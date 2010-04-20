/*
 *      SCCS:  @(#)tcmchild.c	1.13 (98/09/01) 
 *
 *	UniSoft Ltd., London, England
 *
 * (C) Copyright 1992 X/Open Company Limited
 *
 * All rights reserved.  No part of this source code may be reproduced,
 * stored in a retrieval system, or transmitted, in any form or by any
 * means, electronic, mechanical, photocopying, recording or otherwise,
 * except as stated in the end-user licence agreement, without the prior
 * permission of the copyright owners.
 *
 * X/Open and the 'X' symbol are trademarks of X/Open Company Limited in
 * the UK and other countries.
 */

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

/************************************************************************

SCCS:   	@(#)tcmchild.c	1.13 98/09/01 TETware release 3.3
NAME:		tcmchild.c
PRODUCT:	TETware
AUTHOR:		Andrew Dingwall, UniSoft Ltd.
DATE CREATED:	October 1992

DESCRIPTION:
	tcm main() and client-related functions for processes
	started by tet_exec() and tet_spawn()

MODIFICATIONS:
	Denis McConalogue, UniSoft Limited, September 1993
	changed tet_tcmptype() to set process type PT_MTCM for
	non-distributed test cases executing on remote or
	local systems.

	Andrew Dingwall, UniSoft Ltd., August 1996
	changes for TETware

	Geoff Clare, UniSoft Ltd., Sept 1996
	changes for TETware-Lite

	Geoff Clare, UniSoft Ltd., Oct 1996
	restructured tcm source to avoid "ld -r"
	(this file was ctcmfuncs.c - moved main() and other things here)

	Andrew Dingwall, UniSoft Ltd., April 1997
	initialise tet_pname in case it gets used (in tet_dtcmerror())
	before it can be set up in tet_tcm*_main()

	Andrew Dingwall, UniSoft Ltd., July 1998
	Added support for shared API libraries.
	Note that this includes a change to the calling convention for
	child processes.

	Aaron Plattner, April 2010
	Fixed warnings when compiled with GCC's -Wall option.

************************************************************************/

#ifdef __cplusplus
extern "C" {
#endif

#include <stdio.h>
#  include <signal.h>
#include "dtmac.h"
#include "dtmsg.h"
#include "dtthr.h"
#include "globals.h"
#include "tcmfuncs.h"
#include "error.h"
#ifndef TET_LITE /* -START-LITE-CUT- */
#  include "ptab.h"
#  include "synreq.h"
#  include "server.h"
#  include "tslib.h"
#  include "servlib.h"
#endif		/* -END-LITE-CUT- */
#include "dtetlib.h"
#include "sigsafe.h"

extern int	tet_tcmc_main PROTOLIST((int, char **));
extern void	tet_dtcmerror PROTOLIST((int, const char *, int, const char *,
                                         const char *));

TET_EXPORT char *tet_pname = "<unknown>";
TET_EXPORT int tet_thistest = -1;

#ifndef TET_LITE /* -START-LITE-CUT- */
int tet_psysid = -1;			/* parent's system id */
TET_EXPORT long tet_snid = -1L;		/* sync id */
TET_EXPORT long tet_xrid = -1L;		/* xres id */
TET_EXPORT int *tet_snames;		/* system name list */
TET_EXPORT int tet_Nsname;		/* number of system names */
TET_EXPORT struct ptab *tet_sdptab, *tet_xdptab;
					/* ptab elements for syncd and xresd */
#endif		/* -END-LITE-CUT- */

TET_EXPORT sigset_t tet_blockable_sigs;

#ifdef TET_THREADS
TET_EXPORT tet_thread_t tet_start_tid;
#endif /* TET_THREADS */

#ifdef __cplusplus
}
#endif

/*
**	main() is the main program for processes started by tet_exec().
**	It is simply a wrapper for tet_tcmc_main().
*/

#ifdef PROTOTYPES
int main(int argc, char **argv)
#else
int main(argc, argv)
int	argc;
char	**argv;
#endif
{

#ifdef TET_LITE					/* -LITE-CUT-LINE- */
#  define MYPTYPE	PT_MTCM
#  define MYSYSID	0
#else						/* -START-LITE-CUT- */
#  define MYPTYPE	-1
#  define MYSYSID	-1
#endif						/* -END-LITE-CUT- */

	/* must be first */
	tet_init_globals(argc > 0 ? tet_basename(*argv) : (char *)  "child process controller",
		MYPTYPE, MYSYSID, tet_dtcmerror, tet_genfatal);

	/*
	** make sure that we are linked with the right version of
	** the API library
	*/
	tet_check_apilib_version();


	return tet_tcmc_main(argc, argv);
}


#ifdef __cplusplus
extern "C" {
#endif

#ifndef TET_LITE /* -START-LITE-CUT- */

/*
**	tet_tcm_async() - dummy auto-sync function for child TCMs
**
**	child TCMs do not do auto-syncs, so this function should only be
**	called with spno == SV_EXEC_SPNO from tet_tcminit()
*/

/* ARGSUSED */
#ifdef PROTOTYPES
TET_EXPORT int tet_tcm_async(long spno, int vote, int timeout,
	    struct synreq *synreq, int *nsys)
#else
TET_EXPORT int tet_tcm_async(spno, vote, timeout, synreq, nsys)
long spno;
int vote, timeout, *nsys;
struct synreq *synreq;
#endif
{
	ASSERT(spno == SV_EXEC_SPNO);

	tet_sderrno = ER_OK;
	return(0);
}

/*
**	tet_tcmptype() - return process type for a TCM
**
**	In TETware there is almost no difference between "master" and
**	"slave" TCMs and this function is only used to decide which
**	TCMs in a distributed test case should inform XRESD of IC and
**	TP start and end.
**	Someone has to do it so it might as well be the first (or only)
**	system in the system list.
*/

int tet_tcmptype PROTOLIST((void))
{
	int sys1;

	sys1 = tet_snames ? *tet_snames : -1;

	return (tet_mysysid == sys1 ? PT_MTCM : PT_STCM);
}

/*
**	tet_ss_dead() - server-specific dead process handler
**
**	should only be called from tet_si_service() when a server dies
**	unexpectedly
**
**	server logoff routines do not come here
*/

#ifdef PROTOTYPES
TET_EXPORT void tet_ss_dead(struct ptab *pp)
#else
TET_EXPORT void tet_ss_dead(pp)
struct ptab *pp;
#endif
{
	/* emit a diagnostic if this is unexpected */
	if ((pp->pt_flags & PF_LOGGEDOFF) == 0)
		error(0, "server connection closed", tet_r2a(&pp->pt_rid));

	pp->pt_flags = (pp->pt_flags & ~PF_LOGGEDON) | PF_LOGGEDOFF;
}

/*
**	tet_ss_connect() - connect to remote process
*/

#ifdef PROTOTYPES
TET_EXPORT void tet_ss_connect(struct ptab *pp)
#else
TET_EXPORT void tet_ss_connect(pp)
struct ptab *pp;
#endif
{
	tet_ts_connect(pp);
}

/*
**	tet_ss_ptalloc(), tet_ss_ptfree()  - allocate and free server-specific
**		ptab data area
**
**	tcm does not make use of server-specific data
*/

#ifdef PROTOTYPES
TET_EXPORT int tet_ss_ptalloc(struct ptab *pp)
#else
TET_EXPORT int tet_ss_ptalloc(pp)
struct ptab *pp;
#endif
{
	pp->pt_sdata = (char *) 0;
	return(0);
}

/* ARGSUSED */
#ifdef PROTOTYPES
TET_EXPORT void tet_ss_ptfree(struct ptab *pp)
#else
void tet_ss_ptfree(pp)
struct ptab *pp;
#endif
{
	/* nothing */
}

/*
**	tet_ss_serverloop() - server-specific server loop
**
**	this may be called from tet_si_servwait() if non-blocking message i/o
**	would block
**
**	tcm does not do non-blocking i/o, so this should never occur
*/

TET_EXPORT int tet_ss_serverloop PROTOLIST((void))
{
	error(0, "internal error - serverloop called!", (char *) 0);
	return(-1);
}

/*
**	tet_ss_process() - server-specific request process routine
**
**	would be called from tet_si_service() when state is PS_PROCESS
**
**	tcm only uses tet_si_clientloop() which itself returns as soon as a
**	process reaches this state, so tet_ss_process() should never be called
**/

#ifdef PROTOTYPES
TET_EXPORT void tet_ss_process(struct ptab *pp)
#else
TET_EXPORT void tet_ss_process(pp)
struct ptab *pp;
#endif
{
	error(0, "internal error - tet_ss_process called!",
		tet_r2a(&pp->pt_rid));
}

/*
 * The following functions are simply wrappers for the real functions
 * in tcm_bs.c, tcm_in.c and tcm_xt.c.  This is done so that tccd, xresd
 * and syncd cannot resolve these symbols in libapi.a.
 */

extern int tet_tcm_bs2md PROTOLIST((char *, struct ptab *));

#ifdef PROTOTYPES
TET_EXPORT int tet_ss_bs2md(char *from, struct ptab *pp)
#else
TET_EXPORT int tet_ss_bs2md(from, pp)
char *from;
struct ptab *pp;
#endif
{
	return tet_tcm_bs2md(from, pp);
}

extern int tet_tcm_md2bs PROTOLIST((struct ptab *pp, char **bp, int *lp,
	int offs));

#ifdef PROTOTYPES
TET_EXPORT int tet_ss_md2bs(struct ptab *pp, char **bp, int *lp, int offs)
#else
TET_EXPORT int tet_ss_md2bs(pp, bp, lp, offs)
struct ptab *pp;
char **bp;
int *lp, offs;
#endif
{
	return tet_tcm_md2bs(pp, bp, lp, offs);
}

extern int tet_tcm_tsconnect PROTOLIST((struct ptab *));

#ifdef PROTOTYPES
TET_EXPORT int tet_ss_tsconnect(struct ptab *pp)
#else
TET_EXPORT int tet_ss_tsconnect(pp)
struct ptab *pp;
#endif
{
	return tet_tcm_tsconnect(pp);
}

extern int tet_tcm_tsinfo PROTOLIST((struct ptab *, int));

#ifdef PROTOTYPES
TET_EXPORT int tet_ss_tsinfo(struct ptab *pp, int ptype)
#else
TET_EXPORT int tet_ss_tsinfo(pp, ptype)
struct ptab *pp;
int ptype;
#endif
{
	return tet_tcm_tsinfo(pp, ptype);
}

#endif	/* -END-LITE-CUT- */


/*
**	tet_callfuncname() - return name of tcmchild's calling function
**		for use in error messages
*/

char *tet_callfuncname PROTOLIST((void))
{
	return("tet_exec() or tet_spawn()");
}

#ifdef __cplusplus
}
#endif

