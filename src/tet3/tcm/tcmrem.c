/*
 *      SCCS:  @(#)tcmrem.c	1.13 (98/09/01) 
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

SCCS:   	@(#)tcmrem.c	1.13 98/09/01 TETware release 3.3
NAME:		tcmrem.c
PRODUCT:	TETware
AUTHOR:		Andrew Dingwall, UniSoft Ltd.
DATE CREATED:	May 1992

DESCRIPTION:
	tcm main() and client-related functions for processes
	started by tet_remexec()

MODIFICATIONS:
	Andrew Dingwall, UniSoft Ltd., October 1992
	Most of the code that was in this file is now in child.c and is
	built into tcmchild.o as well as tcmrem.o.
	This file now only contains code specific to tcmrem.o.

	Andrew Dingwall, UniSoft Ltd., August 1996
	changes for tetware-style syncs

	Geoff Clare, UniSoft Ltd., Oct 1996
	restructured tcm source to avoid "ld -r"
	(this file was rtcmfuncs.c - moved main() and other things here)

	Andrew Dingwall, UniSoft Ltd., April 1997
	initialise tet_pname in case it gets used (in tet_dtcmerror())
	before it can be set up in tet_tcm*_main()

	Andrew Dingwall, UniSoft Ltd., July 1998
	Added support for shared API libraries.
	Note that this includes a change to the calling convention for
	child processes.
 
************************************************************************/

#include <stdio.h>
#  include <signal.h>
#include "dtmac.h"
#include "dtmsg.h"
#include "ptab.h"
#include "error.h"
#include "globals.h"
#include "synreq.h"
#include "tcmfuncs.h"
#include "server.h"
#include "tslib.h"
#include "dtetlib.h"
#include "sigsafe.h"

extern int	tet_tcmc_main PROTOLIST((int, char **));
extern void	tet_dtcmerror PROTOLIST((int, char *, int, char *, char *));

TET_EXPORT char *tet_pname = "<unknown>";
TET_EXPORT int tet_thistest = -1;

int tet_psysid = -1;			/* parent's system id */
TET_EXPORT long tet_snid = -1L;		/* sync id */
TET_EXPORT long tet_xrid = -1L;		/* xres id */
TET_EXPORT int *tet_snames;		/* system name list */
TET_EXPORT int tet_Nsname;		/* number of system names */
TET_EXPORT struct ptab *tet_sdptab, *tet_xdptab;
					/* ptab elements for syncd and xresd */

TET_EXPORT sigset_t tet_blockable_sigs;

#ifdef NEEDsrcFile
static char srcFile[] = __FILE__;	/* file name for error reporting */
#endif

/*
**	main() is the main program for processes started by tet_remexec().
**	It is simply a wrapper for tet_tcmc_main().
*/

int main(argc, argv)
int	argc;
char	**argv;
{
	/* must be first */
	tet_init_globals(argc > 0 ? tet_basename(*argv) : "remote process controller",
		-1, -1, tet_dtcmerror, tet_genfatal);

	/*
	** make sure that we are linked with the right version of
	** the API library
	*/
	tet_check_apilib_version();


	return tet_tcmc_main(argc, argv);
}

/*
**	tet_callfuncname() - return name of tcmrem's calling function
**		for use in error messages
*/

char *tet_callfuncname()
{
	return("tet_remexec()");
}

/*
**	tet_tcmptype() - return process type for slave TCM
*/

int tet_tcmptype()
{
	return(PT_STCM);
}

/*
**	tet_tcm_async() - do an automatic sync from a tcmrem STCM
*/

TET_EXPORT int tet_tcm_async(spno, vote, timeout, synreq, nsys)
long spno;
int vote, timeout, *nsys;
struct synreq *synreq;
{
	return(tet_sdasync(tet_snid, tet_xrid, spno, vote, timeout, synreq, nsys));
}

/*
**	tet_ss_dead() - server-specific dead process handler
**
**	should only be called from tet_si_service() when a server dies
**	unexpectedly
**
**	server logoff routines do not come here
*/

TET_EXPORT void tet_ss_dead(pp)
struct ptab *pp;
{
	/* emit a diagnostic if this is unexpected */
	if ((pp->pt_flags & PF_LOGGEDOFF) == 0)
		error(0, "server connection closed", tet_r2a(&pp->pt_rid));

	pp->pt_flags = (pp->pt_flags & ~PF_LOGGEDON) | PF_LOGGEDOFF;
}

/*
**	tet_ss_connect() - connect to remote process
*/

TET_EXPORT void tet_ss_connect(pp)
struct ptab *pp;
{
	tet_ts_connect(pp);
}

/*
**	tet_ss_ptalloc(), tet_ss_ptfree()  - allocate and free server-specific
**		ptab data area
**
**	tcm does not make use of server-specific data
*/

TET_EXPORT int tet_ss_ptalloc(pp)
struct ptab *pp;
{
	pp->pt_sdata = (char *) 0;
	return(0);
}

/* ARGSUSED */
TET_EXPORT void tet_ss_ptfree(pp)
struct ptab *pp;
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

TET_EXPORT int tet_ss_serverloop()
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

TET_EXPORT void tet_ss_process(pp)
struct ptab *pp;
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

TET_EXPORT int tet_ss_bs2md(from, pp)
char *from;
struct ptab *pp;
{
	return tet_tcm_bs2md(from, pp);
}

extern int tet_tcm_md2bs PROTOLIST((struct ptab *pp, char **bp, int *lp,
	int offs));

TET_EXPORT int tet_ss_md2bs(pp, bp, lp, offs)
struct ptab *pp;
char **bp;
int *lp, offs;
{
	return tet_tcm_md2bs(pp, bp, lp, offs);
}

extern int tet_tcm_tsconnect PROTOLIST((struct ptab *));

TET_EXPORT int tet_ss_tsconnect(pp)
struct ptab *pp;
{
	return tet_tcm_tsconnect(pp);
}

extern int tet_tcm_tsinfo PROTOLIST((struct ptab *, int));

TET_EXPORT int tet_ss_tsinfo(pp, ptype)
struct ptab *pp;
int ptype;
{
	return tet_tcm_tsinfo(pp, ptype);
}

