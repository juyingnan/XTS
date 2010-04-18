/*
 *	SCCS: @(#)alarm.c	1.10 (98/08/28)
 *
 *	UniSoft Ltd., London, England
 *
 * (C) Copyright 1996 X/Open Company Limited
 *
 * All rights reserved.  No part of this source code may be reproduced,
 * stored in a retrieval system, or transmitted, in any form or by any
 * means, electronic, mechanical, photocopying, recording or otherwise,
 * except as stated in the end-user licence agreement, without the prior
 * permission of the copyright owners.
 * A copy of the end-user licence agreement is contained in the file
 * Licence which accompanies this distribution.
 * 
 * X/Open and the 'X' symbol are trademarks of X/Open Company Limited in
 * the UK and other countries.
 */

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

/************************************************************************

SCCS:   	@(#)alarm.c	1.10 98/08/28 TETware release 3.3
NAME:		functions to provide timeouts (including thread-safe version)
PRODUCT:	TETware
AUTHOR:		Geoff Clare, UniSoft Ltd.
DATE CREATED:	July 1996
SYNOPSIS:

	#include <signal.h>
	#include "dtetlib.h"

	int	tet_set_alarm(struct alrmaction *new_aa,
			      struct alrmaction *old_aa);

	int	tet_clr_alarm(struct alrmaction *old_aa);

	int *	tet_thr_alrm_flag(void);

DESCRIPTION:

	Tet_set_alarm() and tet_clr_alarm() provide a timeout facility
	for use in code that is compiled both thread-safe and not.
	They return 0 on success, -1 (with errno set) on failure.

	The waittime field of new_aa specifies the timeout period.  The
	sa field will be used in a struct sigaction to set the signal
	disposition for SIGALRM.  (In the threads version this does not
	happen until the timeout period has expired.)  The previous
	disposition, which is placed in old_aa->sa in the non-threads
	version only, will have been restored by the time tet_clr_alarm()
	returns.

	The handler specified in new_aa->sa.sa_handler should just
	increment alrm_flag.  It must not longjmp.  For thread-safety,
	new_aa and old_aa must not point to global or static data.

	Tet_thr_alrm_flag() is used (in the threads version) in the
	#define of alrm_flag.

	note that none of these functions are implemented on WIN32

MODIFICATIONS:

	Geoff Clare, UniSoft Ltd., Sept 1996
	Moved from apilib to dtet2lib (so can be used in fifolib).
	Unblock SIGALRM in non-thread version.

	Andrew Dingwall, UniSoft Ltd., February 1998
	Use TETware-specific macros to access threads functions and
	data items.

	Andrew Dingwall, UniSoft Ltd., July 1998
	Added support for shared API libraries.
 
************************************************************************/


#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <errno.h>
#include <signal.h>
#include <time.h>
#include "dtmac.h"
#include "dtthr.h"
#include "sigsafe.h"
#include "alarm.h"
#include "error.h"
#include "tet_api.h"

#ifndef NOTRACE
#include "ltoa.h"
#endif

#ifdef NEEDsrcFile
static char srcFile[] = __FILE__;
#endif

#ifdef TET_THREADS

#define ALRMWAIT	5	/* seconds to wait for tet_clr_alarm() to
				   be called after SIGALRM sent */

extern tet_mutex_t tet_sigalrm_mtx;
extern tet_mutex_t tet_alarm_mtx;

struct alrmarg {
	unsigned int	waittime;
	struct sigaction *sap;
	tet_thread_t	kill_tid;
	tet_cond_t	*cvp;
	unsigned int	*condp;
};

static void *alrm_thr PROTOLIST((void *));

#endif /* TET_THREADS */

int
tet_set_alarm(new_aa, old_aa)
struct alrmaction *new_aa, *old_aa;
{
#ifndef TET_THREADS

	sigset_t alrmset;

	ASSERT(new_aa->waittime != 0);
	if (sigaction(SIGALRM, &new_aa->sa, &old_aa->sa) == -1)
		return -1;

	/* SIGALRM is blocked between tet_sigsafe_start/end calls,
	   so unblock it.  (This means the handler mustn't longjmp.) */
	(void) sigemptyset(&alrmset);
	(void) sigaddset(&alrmset, SIGALRM);
	(void) sigprocmask(SIG_UNBLOCK, &alrmset, &old_aa->mask);

	(void) alarm(new_aa->waittime);

#else /* TET_THREADS */

	int err;
	struct alrmarg *alrmarg;
	sigset_t alrmset;

	ASSERT(new_aa->waittime != 0);

	old_aa->cvp = NULL; /* indicates not yet valid to tet_clr_alarm() */
	old_aa->waittime = new_aa->waittime; /* use as condition flag */

	alrmarg = (struct alrmarg *) malloc(sizeof(*alrmarg));
	if (alrmarg == NULL)
		return -1;
	TRACE2(tet_Tbuf, 6, "allocate alrmarg = %s", tet_i2x(alrmarg));

	alrmarg->cvp = (tet_cond_t *) malloc(sizeof(tet_cond_t));
	if (alrmarg->cvp == NULL)
	{
		TRACE2(tet_Tbuf, 6, "free alrmarg = %s", tet_i2x(alrmarg));
		free((void *)alrmarg);
		return -1;
	}
	TRACE2(tet_Tbuf, 6, "allocate condition variable = %s",
		tet_i2x(alrmarg->cvp));

	(void) TET_COND_INIT(alrmarg->cvp);

	/* call alrm_thr() in a new thread */
	alrmarg->waittime = new_aa->waittime;
	alrmarg->sap = &new_aa->sa;
	alrmarg->condp = &old_aa->waittime;
	alrmarg->kill_tid = TET_THR_SELF();
	err = TET_THR_CREATE(alrm_thr, (void *) alrmarg, &old_aa->join_tid);
	if (err != 0)
	{
		(void) TET_COND_DESTROY(alrmarg->cvp);
		TRACE2(tet_Tbuf, 6, "free condition variable = %s",
			tet_i2x(alrmarg->cvp));
		free((void *)alrmarg->cvp);
		TRACE2(tet_Tbuf, 6, "free alrmarg = %s", tet_i2x(alrmarg));
		free((void *)alrmarg);
		errno = err;
		return -1;
	}

	/*
	 * If tet_clr_alarm() is called within waittime, alrm_thr
	 * will see this via TET_COND_TIMEDWAIT() and will return.
	 * If not, it will install the specified new signal
	 * action and send a SIGALRM to this thread.
	 */

	(void) sigemptyset(&alrmset);
	(void) sigaddset(&alrmset, SIGALRM);
	(void) TET_THR_SIGSETMASK(SIG_UNBLOCK, &alrmset, &old_aa->mask);
	old_aa->cvp = alrmarg->cvp;

	/* note alrmarg is freed in alrm_thr() */

#endif /* TET_THREADS */

	return 0;
}

#ifdef TET_THREADS

static void *
alrm_thr(varg)
void *varg;
{
	/*
	 * Cause the target thread to execute the specified SIGALRM
	 * handler, after timeout of waittime seconds.
	 * (This function is executed in a new thread.)
	 */

	struct alrmarg *argp = (struct alrmarg *)varg;
	unsigned int	waittime;
	struct sigaction *new_sap;
	tet_thread_t	kill_tid;
	tet_cond_t	*cvp;
	unsigned int	*condp;
	struct sigaction oldsigact;
	tet_timestruc_t abstime;
	int err;

	/* copy passed arguments to local storage */

	waittime = argp->waittime;
	new_sap = argp->sap;
	kill_tid = argp->kill_tid;
	cvp = argp->cvp;
	condp = argp->condp;
	TRACE2(tet_Tbuf, 6, "free alrmarg = %s", tet_i2x(argp));
	free((void *)argp);

	/* wait for tet_clr_alarm() to clear condition flag */

	MTX_LOCK(&tet_alarm_mtx);
	abstime.tv_sec = time((time_t *)0) + waittime;
	abstime.tv_nsec = 0;
	while (*condp != 0) /* this points at old_aa->waittime */
	{
		err = TET_COND_TIMEDWAIT(cvp, &tet_alarm_mtx, &abstime);
		if (err != EINTR)
			break;
	}
	if (*condp == 0)
		err = 0;
	MTX_UNLOCK(&tet_alarm_mtx);
	if (err == 0)
	{
		(void) TET_COND_DESTROY(cvp);
		TRACE2(tet_Tbuf, 6, "free condition variable = %s",
			tet_i2x(cvp));
		free((void *)cvp);
		return (void *)0;
	}
	else if (err != ETIME)
		fatal(err, "first TET_COND_TIMEDWAIT() failed in alrm_thr()",
			(char *)0);

	MTX_LOCK(&tet_sigalrm_mtx);

	if (sigaction(SIGALRM, new_sap, &oldsigact) == -1)
		fatal(errno, "sigaction() failed in alrm_thr()", (char *)0);
	err = TET_THR_KILL(kill_tid, SIGALRM);
	if (err != 0)
		fatal(err, "TET_THR_KILL() failed in alrm_thr()", (char *)0);

	/* must wait until target thread calls tet_clr_alarm() before
	   it is safe to restore old SIGALRM handler */
	TET_MUTEX_LOCK(&tet_alarm_mtx);	/* don't nest MTX_LOCK */
	abstime.tv_sec = time((time_t *)0) + ALRMWAIT;
	abstime.tv_nsec = 0;
	while (*condp != 0)
	{
		err = TET_COND_TIMEDWAIT(cvp, &tet_alarm_mtx, &abstime);
		if (err != EINTR)
			break;
	}
	if (*condp == 0)
		err = 0;
	TET_MUTEX_UNLOCK(&tet_alarm_mtx);
	if (err != 0 && err != ETIME)
		fatal(err, "second TET_COND_TIMEDWAIT() failed in alrm_thr()",
			(char *)0);
	else if (err == ETIME)
		fatal(err,
			"second TET_COND_TIMEDWAIT() timed out in alrm_thr()",
			(char *)0);

	(void) sigaction(SIGALRM, &oldsigact, (struct sigaction *)0);

	MTX_UNLOCK(&tet_sigalrm_mtx);

	(void) TET_COND_DESTROY(cvp);
	TRACE2(tet_Tbuf, 6, "free condition variable = %s", tet_i2x(cvp));
	free((void *)cvp);

	return (void *)0;
}

#endif /* TET_THREADS */

int
tet_clr_alarm(old_aa)
struct alrmaction *old_aa;
{
#ifndef TET_THREADS

	(void) alarm(0);
	(void) sigprocmask(SIG_SETMASK, &old_aa->mask, (sigset_t *)0);
	if (sigaction(SIGALRM, &old_aa->sa, (struct sigaction *)0) == -1)
		return -1;

#else
	int err;

	if (old_aa->cvp == NULL)
	{
		errno = EINVAL;
		return -1;
	}

	(void) TET_THR_SIGSETMASK(SIG_SETMASK, &old_aa->mask, (sigset_t *) 0);
	MTX_LOCK(&tet_alarm_mtx);
	old_aa->waittime = 0;	/* used as condition var */
	(void) TET_COND_SIGNAL(old_aa->cvp);
	MTX_UNLOCK(&tet_alarm_mtx);
	old_aa->cvp = NULL;	/* so a second call will give EINVAL */

	err = TET_THR_JOIN(old_aa->join_tid, (void **) NULL);
	if (err != 0)
	{
		errno = err;
		return -1;
	}

#endif
	return 0;
}

#ifdef TET_THREADS

TET_IMPORT tet_thread_key_t tet_alrm_flag_key;

int *
tet_thr_alrm_flag()
{
	/* find tet_alrm_flag address for this thread */

	void *rtval;

	rtval = 0;
	TET_THR_GETSPECIFIC(tet_alrm_flag_key, &rtval);
	if (rtval == 0)
	{
		/* No tet_alrm_flag has been set up for this thread - probably
		   because it was not created with tet_thr_create().
		   Try and allocate a new tet_alrm_flag. */

		rtval = malloc(sizeof(int));
		TET_THR_SETSPECIFIC(tet_alrm_flag_key, rtval);
		rtval = 0;
		TET_THR_GETSPECIFIC(tet_alrm_flag_key, &rtval);
		if (rtval == 0)
			fatal(0, "could not set up tet_alrm_flag for new thread in tet_thr_alrm_flag", (char *)0);
		*((int *)rtval) = 0;
	}

	return (int *)rtval;
}
#endif /* TET_THREADS */


