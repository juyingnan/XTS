/*
 *	SCCS: @(#)errno.c	1.7 (98/08/28)
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

SCCS:   	@(#)errno.c	1.7 98/08/28 TETware release 3.3
NAME:		'C' API error reporting mechanism
PRODUCT:	TETware
AUTHOR:		Geoff Clare, UniSoft Ltd.
DATE CREATED:	July 1996
SYNOPSIS:

	int	tet_errno;
	char *	tet_errlist[];
	int	tet_nerr;

	int *	tet_thr_errno(void);

DESCRIPTION:

	Tet_errno is set to a non-zero value by API functions when
	an error is indicated by the function's return value.
	In the threads version of the API, tet_errno is really
	a #define, enabling each thread to have a separate tet_errno.

	Tet_errlist contains a short string describing each tet_errno
	value, and can be indexed by tet_errno after checking the
	condition: (tet_errno >= 0 && tet_errno < tet_nerr).

	Tet_thr_errno() is not part of the API: it is used (in the
	threads version) in the #define of tet_errno.

	Where API functions call others, and wish to use tet_errno in
	reporting errors, tet_errno must be passed NEGATED to the
	internal error reporting functions such as tet_error(), error()
	and fatal().

MODIFICATIONS:

	Andrew Dingwall, UniSoft Ltd., February 1998
	Use TETware-specific macros to access threads functions and
	data items.

	Andrew Dingwall, UniSoft Ltd., July 1998
	Added support for shared API libraries.
 
************************************************************************/

#include <stdlib.h>
#include "dtmac.h"
#include "tet_api.h"
#include "error.h"
#include "dtthr.h"

#ifdef NEEDsrcFile
static char srcFile[] = __FILE__;
#endif

#ifndef TET_THREADS
TET_IMPORT int tet_errno;
#else /* !TET_THREADS */

TET_IMPORT tet_thread_key_t tet_errno_key;

TET_IMPORT int *tet_thr_errno()
{
	/* find tet_errno address for this thread */

	void *rtval;

	rtval = 0;
	TET_THR_GETSPECIFIC(tet_errno_key, &rtval);
	if (rtval == 0)
	{
		/* No tet_errno has been set up for this thread - probably
		   because it was not created with tet_thr_create().
		   Try and allocate a new tet_errno. */

		rtval = malloc(sizeof(int));
		TET_THR_SETSPECIFIC(tet_errno_key, rtval);
		rtval = 0;
		TET_THR_GETSPECIFIC(tet_errno_key, &rtval);
		if (rtval == 0)
			fatal(0, "could not set up tet_errno for new thread in tet_thr_errno", (char *)0);
		*((int *)rtval) = 0;
	}

	return (int *)rtval;
}
#endif /* !TET_THREADS */

/* This list must be kept in sync with tet_api.h and dtmsg.h */
TET_IMPORT char *tet_errlist[] = {
/* TET_ER_OK		 0 */ "no error",
/* TET_ER_ERR		 1 */ "general error",
/* TET_ER_MAGIC		 2 */ "bad magic number",
/* TET_ER_LOGON		 3 */ "not logged on",
/* TET_ER_RCVERR	 4 */ "receive message error",
/* TET_ER_REQ		 5 */ "unknown request code",
/* TET_ER_TIMEDOUT	 6 */ "request/call timed out",
/* TET_ER_DUPS		 7 */ "request contained duplicate IDs",
/* TET_ER_SYNCERR	 8 */ "sync completed unsuccessfully",
/* TET_ER_INVAL		 9 */ "invalid parameter",
/* TET_ER_TRACE		10 */ "tracing not configured",
/* TET_ER_WAIT		11 */ "process not terminated",
/* TET_ER_XRID		12 */ "bad xrid in xresd request",
/* TET_ER_SNID		13 */ "bad snid in syncd request",
/* TET_ER_SYSID		14 */ "bad sysid or sysid not in system name list",
/* TET_ER_INPROGRESS	15 */ "event in progress",
/* TET_ER_DONE		16 */ "event finished or already happened",
/* TET_ER_CONTEXT	17 */ "request out of context",
/* TET_ER_PERM		18 */ "privilege request/kill error",
/* TET_ER_FORK		19 */ "can't fork",
/* TET_ER_NOENT		20 */ "no such file or directory",
/* TET_ER_PID		21 */ "no such process",
/* TET_ER_SIGNUM	22 */ "bad signal number",
/* TET_ER_FID		23 */ "bad file id",
/* TET_ER_INTERN	24 */ "server internal error",
/* TET_ER_ABORT		25 */ "abort TCM on TP end",
/* TET_ER_2BIG		26 */ "argument list too long",
};
 
TET_IMPORT int tet_nerr = sizeof(tet_errlist)/sizeof(*tet_errlist);

