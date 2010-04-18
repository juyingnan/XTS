/*
 *	SCCS: @(#)tet_fork.c	1.25 (98/08/28)
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

/*
 * Copyright 1990 Open Software Foundation (OSF)
 * Copyright 1990 Unix International (UI)
 * Copyright 1990 X/Open Company Limited (X/Open)
 *
 * Permission to use, copy, modify, and distribute this software and its
 * documentation for any purpose and without fee is hereby granted, provided
 * that the above copyright notice appear in all copies and that both that
 * copyright notice and this permission notice appear in supporting
 * documentation, and that the name of OSF, UI or X/Open not be used in 
 * advertising or publicity pertaining to distribution of the software 
 * without specific, written prior permission.  OSF, UI and X/Open make 
 * no representations about the suitability of this software for any purpose.  
 * It is provided "as is" without express or implied warranty.
 *
 * OSF, UI and X/Open DISCLAIM ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, 
 * INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO 
 * EVENT SHALL OSF, UI or X/Open BE LIABLE FOR ANY SPECIAL, INDIRECT OR 
 * CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF 
 * USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR 
 * OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR 
 * PERFORMANCE OF THIS SOFTWARE.
 */

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

/************************************************************************

SCCS:   	@(#)tet_fork.c	1.25 98/08/28 TETware release 3.3
NAME:		'C' API fork process function
PRODUCT:	TETware
AUTHOR:		Geoff Clare, UniSoft Ltd.
DATE CREATED:	26 July 1990
SYNOPSIS:

	int	tet_fork(void (*childproc)(), void (*parentproc)(),
		     int waittime, int exitvals);

	int	tet_fork1(void (*childproc)(), void (*parentproc)(),
		     int waittime, int exitvals);

	pid_t	tet_child;  [ per-thread ]

	pid_t *	tet_thr_child(void);
	int	tet_killw(pid_t child, unsigned timeout);
	char *	tet_errname(int errno_val);
	char *	tet_signame(int signum);

DESCRIPTION:

	Tet_fork() forks a child process and calls (*childproc)() in the
	child and (*parentproc)() (if != TET_NULLFP) in the parent.  The
	child calls tet_setcontext() to distinguish it's results file
	output from the parent's.  Calls to tet_setblock() are made in
	the parent to separate output made before, during and after
	execution of the child process.

	Waittime controls whether, and for how long, tet_fork() waits for
	the child after (*parentproc)() has returned.  If waittime < 0 no
	wait is done and the child is killed if it is still alive.  If
	waittime is zero tet_fork() waits indefinitely, otherwise the
	wait is timed out after waittime seconds.  If the child is going
	to be waited for, signals which are being caught in the parent
	are set to SIG_DFL in the child so unexpected signals will come
	through to the wait status.

	Exitvals is a bit mask of valid child exit codes.  Tet_fork()
	returns the child exit code (if valid), otherwise -1.  If
	(*childproc)() returns rather than exiting, or no wait was done
	then tet_fork() returns 0.  If tet_fork() returns -1 it first
	writes an information line and an UNRESOLVED result code to the
	execution results file.

	In the parent process tet_child is set to the PID of the child
	process.

	Tet_fork1() is only provided in the threads version of the API.
	It is equivalent to tet_fork() except that it calls fork1()
	instead of fork().

	Tet_thr_child() is not part of the API: it is used (in the
	threads version) in the #define of tet_child.

	Tet_killw() is not part of the API.  It is used by other functions
	in the API to kill a child process (with SIGTERM) and wait for it.
	If the wait times out it will kill the child with SIGKILL.  If the
	wait fails for any other reason -1 is returned.  If the child
	exits or was not there (ECHILD) then 0 is returned.  If the kill()
	fails and errno is ESRCH the wait is done anyway (to reap a
	possible zombie).  On return the value of errno is restored to
	the value set by the failed system call.

	Note that, because of the second wait after SIGKILL, the time spent
	in this routine may be twice the timeout given.

	tet_signame() is not part of the API.
	It is used by API functions to obtain names for the standard 
	signal names.

	These functions are not implemented on WIN32 platforms.


MODIFICATIONS:

	June 1992
	This file is derived from TET release 1.10

	Andrew Dingwall, UniSoft Ltd., October 1992
	Update tet_mypid after a fork().

	Denis McConalogue, UniSoft Limited, August 1993
                changed dtet to tet2 in #include

	Denis McConalogue, UniSoft Limited, September 1993
	make sure all connections inherited by child processes are closed.
	logon again to SYNCD and XRESD in child process.
	make sure that if the child process returns, any new connections
	are logged off

	Geoff Clare, UniSoft Ltd., July-August 1996
	Changes for TETWare.

	Geoff Clare, UniSoft Ltd., Sept 1996
	Added alarm.h.

	Andrew Dingwall, UniSoft Ltd., September 1996
	Removed tet_errname() from here in favour of the more comprehensive
	version in dtet2lib.

	Geoff Clare, UniSoft Ltd., Sept 1996
	Changes for TETWare-Lite.

	Geoff Clare, UniSoft Ltd., Oct 1996
	Added dtetlib.h (for tet_errname decl).

	Andrew Dingwall, UniSoft Ltd., June 1997
	added call to tet_xdxrsend() after tet_xdlogon() -
	needed to make parallel remote and distributed test cases work
	correctly

	Andrew Dingwall, UniSoft Ltd., February 1998
	Use TETware-specific macros to access threads functions and
	data items.

	Andrew Dingwall, UniSoft Ltd., July 1998
	Changed the way that tet_fork() operates when TET_POSIX_THREADS
	is defined.
	This is because in UI threads:
		fork() = forkall() and there is also a fork1() system call.
	whereas in POSIX threads:
		fork() = fork1() and there is no forkall() system call.
	Added support for shared API libraries.
 
************************************************************************/


#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <errno.h>
#include <signal.h>
#include <sys/wait.h>
#include "dtmac.h"
#include "dtthr.h"
#include "globals.h"
#include "alarm.h"
#include "error.h"
#include "servlib.h"
#include "dtetlib.h"
#include "sigsafe.h"
#include "tet_api.h"
#include "apilib.h"

#define	KILLWAIT	10

#  ifdef NEEDsrcFile
static char srcFile[] = __FILE__;
#  endif

#  ifndef TET_THREADS
static	int	alrm_flag; /* threads version is #defined in alarm.h */
#  endif


#  ifndef TET_THREADS
pid_t	tet_child;
#  else /* TET_THREADS */
#    ifndef FORK1
TET_IMPORT tet_thread_key_t tet_child_key;

TET_IMPORT pid_t *tet_thr_child()
{
	/* find tet_child address for this thread */

	void *rtval;

	rtval = 0;
	TET_THR_GETSPECIFIC(tet_child_key, &rtval);
	if (rtval == 0)
	{
		/* No tet_child has been set up for this thread - probably
		   because it was not created with tet_thr_create().
		   Try and allocate a new tet_child. */

		rtval = malloc(sizeof(pid_t));
		TET_THR_SETSPECIFIC(tet_child_key, rtval);
		rtval = 0;
		TET_THR_GETSPECIFIC(tet_child_key, &rtval);
		if (rtval == 0)
			fatal(0, "could not set up tet_child for new thread in tet_thr_child", (char *)0);
		*((pid_t *)rtval) = 0;
	}

	return (pid_t *)rtval;
}
#    endif /* !FORK1 */
#  endif /* TET_THREADS */

/* ARGSUSED */
static void
alrm(sig)
int sig;
{
	alrm_flag++;
}

/* ARGSUSED */
static void
sig_term(sig)
int sig;
{
	/* clean up on receipt of SIGTERM, but arrange for wait
	   status still to show termination by SIGTERM */

	struct sigaction sa;

	if (tet_child > 0)
		(void) tet_killw(tet_child, KILLWAIT);

	sa.sa_handler = SIG_DFL;
	sa.sa_flags = 0; 
	(void) sigemptyset(&sa.sa_mask); 
	(void) sigaction(SIGTERM, &sa, (struct sigaction *)NULL);
	(void) kill(getpid(), SIGTERM);
}

#  ifdef FORK1
TET_IMPORT int tet_fork1(childproc, parentproc, waittime, exitvals)
#  else
TET_IMPORT int tet_fork(childproc, parentproc, waittime, exitvals)
#  endif
void (*childproc) ();
void (*parentproc) ();
int	waittime;
int	exitvals;
{
	int	rtval, err, status, i;
	pid_t	savchild;
	char	buf[256];
	struct sigaction new_sa; 
	struct alrmaction new_aa, old_aa; 
#  ifdef TET_THREADS
	sigset_t oldset;
#    if defined(FORK1) || defined(TET_POSIX_THREADS)
	extern void tet_mtx_lock();
	extern void tet_mtx_unlock();
	extern void tet_thrtab_reset();
#    else
	extern tet_mutex_t tet_top_mtx;
#    endif
#  endif /* TET_THREADS */

	(void) fflush(stdout);
	(void) fflush(stderr);

	/* Save old value of tet_child in case of recursive calls
	   to tet_fork().  RESTORE tet_child BEFORE ALL RETURNS. */
	savchild = tet_child;

#  ifdef TET_THREADS
	/*
	** tet_fork1() and POSIX tet_fork() must obtain all mutexes and
	** locks before forking, to ensure they are not held by threads
	** which will not exist in the child.
	**
	** UI tet_fork() must obtain tet_top_mtx, to ensure other threads
	** in the child do not try to access the servers before this thread
	** disconnects the inherited parent connections and logs on again.
	**
	** Note that by obtaining tet_top_mtx without going through API_LOCK
	** we are assuming that these functions are never called from other
	** API functions
	*/

	err = TET_THR_SIGSETMASK(SIG_BLOCK, &tet_blockable_sigs, &oldset);
	if (err != 0)
	{
		/* not fatal, as we haven't forked yet */
		error(err, "TET_THR_SIGSETMASK() failed in tet_fork1()", (char *)0);
		/* tet_child = savchild; not needed */
		tet_errno = TET_ER_ERR;
		return -1;
	}
#    if defined(FORK1) || defined(TET_POSIX_THREADS)
	tet_mtx_lock();
#    else
	TET_MUTEX_LOCK(&tet_top_mtx);
#    endif

#  endif /* TET_THREADS */

#  if defined(FORK1) && !defined(TET_POSIX_THREADS)
	switch (tet_child = fork1())
#  else
	switch (tet_child = fork())
#  endif
	{
	
	case -1:
		err = errno;
#  ifdef TET_THREADS
#    if defined(FORK1) || defined(TET_POSIX_THREADS)
		tet_mtx_unlock();
#    else
		TET_MUTEX_UNLOCK(&tet_top_mtx);
#    endif
		(void) TET_THR_SIGSETMASK(SIG_SETMASK, &oldset, (sigset_t *)0);
#  endif /* TET_THREADS */

		(void) sprintf(buf,
#  ifdef FORK1
#    ifdef TET_POSIX_THREADS
			"fork() failed in tet_fork1() - errno %d (%s)",
#    else
			"fork1() failed in tet_fork1() - errno %d (%s)",
#    endif
#  else
			"fork() failed in tet_fork() - errno %d (%s)",
#  endif
			err, tet_errname(err));
		tet_infoline(buf);
		tet_result(TET_UNRESOLVED);
		tet_child = savchild;
		tet_errno = TET_ER_FORK;
		return -1;

	case 0:
		/* child process */

		tet_mypid = getpid();
#  if defined(FORK1) || defined(TET_POSIX_THREADS)
		tet_start_tid = TET_THR_SELF();
		tet_thrtab_reset(); /* empty the thread table */
#  endif

		if (waittime >= 0)
		{
			/* set signals which were caught in parent to default */

			/* NSIG is not provided by POSIX.1:  it must be
			   defined via an extra feature-test macro, or
			   on the compiler command line */
			for (i = 1; i < NSIG; i++)
			{
				if (sigaction(i, (struct sigaction *)NULL,
					&new_sa) != -1 &&
					new_sa.sa_handler != SIG_DFL &&
					new_sa.sa_handler != SIG_IGN)
				{
					new_sa.sa_handler = SIG_DFL;
					(void) sigaction(i, &new_sa,
						(struct sigaction *)NULL);
				}
			}
		}

#  ifndef TET_LITE /* -START-LITE-CUT- */
		/* disconnect from all connected servers */
		tet_disconnect();

		/* logon again to XRESD and SYNCD */
		if (tet_xdlogon() == 0)
			(void) tet_xdxrsend(tet_xrid);
		(void) tet_sdlogon();
#  endif /* -END-LITE-CUT- */

#  ifdef TET_THREADS
#    if defined(FORK1) || defined(TET_POSIX_THREADS)
		tet_mtx_unlock();
#    else
		TET_MUTEX_UNLOCK(&tet_top_mtx);
#    endif
		(void) TET_THR_SIGSETMASK(SIG_SETMASK, &oldset, (sigset_t *)0);
#  endif /* TET_THREADS */

		/* change context to distinguish output from parent's */
		tet_setcontext();
#  if defined(FORK1) || defined(TET_POSIX_THREADS)
		/* threads version of tet_setcontext() does not reset the
		   block number(s), but for tet_fork1() and POSIX
		   tet_fork() we know there is only one thread in the
		   child, so it's OK to reset it. */
		tet_next_block = 0;
		tet_setblock();
#  endif
		
		/* call child function, and if it returns exit with code 0 */
		(*childproc) ();
#  ifdef TET_THREADS
		tet_cln_threads(0);
#  endif
		tet_exit(0);
	}

	/* parent process */

	/* if SIGTERM is set to default (e.g. if this tet_fork() was
	   called from a child), catch it so we can propagate tet_killw() */
	if (sigaction(SIGTERM, (struct sigaction *)NULL, &new_sa) != -1 &&
		new_sa.sa_handler == SIG_DFL)
	{
		new_sa.sa_handler = sig_term;
		(void) sigaction(SIGTERM, &new_sa, (struct sigaction *)NULL);
	}

#  ifdef TET_THREADS
#    if defined(FORK1) || defined(TET_POSIX_THREADS)
	tet_mtx_unlock();
#    else
	TET_MUTEX_UNLOCK(&tet_top_mtx);
#    endif
	(void) TET_THR_SIGSETMASK(SIG_SETMASK, &oldset, (sigset_t *)0);
#  endif /* TET_THREADS */

	if (parentproc != NULL)
	{
		tet_setblock();
		(*parentproc) ();
	}

	tet_setblock();

	/* no API_LOCK here */

	/* negative waittime means no wait required (i.e. parentproc does
	   the wait, or the child is to be killed if still around) */

	if (waittime < 0)
	{
		(void) tet_killw(tet_child, KILLWAIT);
		tet_child = savchild;
		return 0;
	}

	/* wait for child, with timeout if required */

	if (waittime > 0)
	{
		new_aa.waittime = waittime; 
		new_aa.sa.sa_handler = alrm; 
		new_aa.sa.sa_flags = 0; 
		(void) sigemptyset(&new_aa.sa.sa_mask); 
		alrm_flag = 0; 
		if (tet_set_alarm(&new_aa, &old_aa) == -1)
			fatal(errno, "failed to set alarm", (char *)0);
	}

	rtval = waitpid(tet_child, &status, WUNTRACED);
	err = errno; 

	if (waittime > 0)
		(void) tet_clr_alarm(&old_aa);

	/* check child wait status shows valid exit code, if not
	   report wait status and give UNRESOLVED result */

	if (rtval == -1)
	{
		if (alrm_flag > 0)
			(void) sprintf(buf, "child process timed out");
		else
			(void) sprintf(buf, "waitpid() failed - errno %d (%s)",
				err, tet_errname(err));
		tet_infoline(buf);
		tet_result(TET_UNRESOLVED);
		(void) tet_killw(tet_child, KILLWAIT);

		switch (err)
		{
		case ECHILD: tet_errno = TET_ER_PID; break;
		case EINVAL: tet_errno = TET_ER_INVAL; break;
		case EINTR:  tet_errno = TET_ER_WAIT; break;
		default:
#  ifdef FORK1
			error(err, "tet_fork1() got unexpected errno value from waitpid()",
			    (char *)0);
#  else
			error(err, "tet_fork() got unexpected errno value from waitpid()",
			    (char *)0);
#  endif
			tet_errno = TET_ER_ERR;
		}
		tet_child = savchild;
		return -1;
	}
	else if (WIFEXITED(status))
	{
		status = WEXITSTATUS(status);

		if ((status & ~exitvals) == 0)
		{
			/* Valid exit code */

			tet_child = savchild;
			return status;
		}
		else
		{
			(void) sprintf(buf,
				"child process gave unexpected exit code %d",
				status);
			tet_infoline(buf);
		}
	}
	else if (WIFSIGNALED(status))
	{
		status = WTERMSIG(status);
		(void) sprintf(buf,
			"child process was terminated by signal %d (%s)",
			status, tet_signame(status));
		tet_infoline(buf);
	}
	else if (WIFSTOPPED(status))
	{
		status = WSTOPSIG(status);
		(void) sprintf(buf,
			"child process was stopped by signal %d (%s)",
			status, tet_signame(status));
		tet_infoline(buf);
		(void) tet_killw(tet_child, KILLWAIT);
	}
	else
	{
		(void) sprintf(buf,
			"child process returned bad wait status (%#x)", status);
		tet_infoline(buf);
	}

	tet_result(TET_UNRESOLVED);

	tet_child = savchild;
	tet_errno = TET_ER_ERR;
	return -1;
}

#  ifndef FORK1

int
tet_killw(child, timeout)
pid_t child;
unsigned int timeout;
{
	/* kill child and wait for it (with timeout) */

	pid_t	pid;
	int	sig = SIGTERM;
	int	ret = -1;
	int	err, count, status;
	struct alrmaction new_aa, old_aa; 

	new_aa.waittime = timeout; 
	new_aa.sa.sa_handler = alrm; 
	new_aa.sa.sa_flags = 0; 
	(void) sigemptyset(&new_aa.sa.sa_mask); 

	for (count = 0; count < 2; count++)
	{
		if (kill(child, sig) == -1 && errno != ESRCH)
		{
			err = errno;
			break;
		}

		alrm_flag = 0; 
		if (tet_set_alarm(&new_aa, &old_aa) == -1)
			fatal(errno, "failed to set alarm", (char *)0);
		pid = waitpid(child, &status, 0);
		err = errno;
		(void) tet_clr_alarm(&old_aa);

		if (pid == child)
		{
			ret = 0;
			break;
		}
		if (pid == -1 && alrm_flag == 0 && errno != ECHILD)
			break;
		
		sig = SIGKILL; /* use a stronger signal the second time */
	}

	errno = err;
	return ret;
}

char *
tet_signame(sig)
int sig;
{
	/* look up name for given signal number */

	/* the table must contain standard signals only - a return
	   value not starting with "SIG" is taken to indicate a
	   non-standard signal */

	int	i;
	static	struct {
		int num;
		char *name;
	} sig_table[] = {
		{ SIGABRT,	"SIGABRT" },
		{ SIGALRM,	"SIGALRM" },
		{ SIGCHLD,	"SIGCHLD" },
		{ SIGCONT,	"SIGCONT" },
		{ SIGFPE,	"SIGFPE" },
		{ SIGHUP,	"SIGHUP" },
		{ SIGILL,	"SIGILL" },
		{ SIGINT,	"SIGINT" },
		{ SIGKILL,	"SIGKILL" },
		{ SIGPIPE,	"SIGPIPE" },
		{ SIGQUIT,	"SIGQUIT" },
		{ SIGSEGV,	"SIGSEGV" },
		{ SIGSTOP,	"SIGSTOP" },
		{ SIGTERM,	"SIGTERM" },
		{ SIGTSTP,	"SIGTSTP" },
		{ SIGTTIN,	"SIGTTIN" },
		{ SIGTTOU,	"SIGTTOU" },
		{ SIGUSR1,	"SIGUSR1" },
		{ SIGUSR2,	"SIGUSR2" },
		{ 0,		NULL }
	};


	for (i = 0; sig_table[i].name != NULL; i++)
	{
		if (sig_table[i].num == sig)
			return sig_table[i].name;
	}

	return "unknown signal";
}

#  endif /* FORK1 */


