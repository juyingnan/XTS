/*
 *	SCCS: @(#)copysave.c	1.8 (98/09/01)
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

SCCS:   	@(#)copysave.c	1.8 98/09/01 TETware release 3.3
NAME:		copysave.c
PRODUCT:	TETware
AUTHOR:		Andrew Dingwall, UniSoft Ltd.
DATE CREATED:	August 1996

DESCRIPTION:
	functions to deal with copying and saving files

MODIFICATIONS:
	Andrew Dingwall, UniSoft Ltd., June 1997
	don't update TET_TSROOT in the distributed configuration
	after processing a remote TET_RUN (rtrcopy());
	instead always use get_runtime_tsroot() to determine the location
	of the runtime test suite root directory on a particular system

	Andrew Dingwall, UniSoft Ltd., October 1997
	in tcc_rmtmpdir(), don't check for being in the tmpdir subtree
	if we haven't changed directory yet

	Aaron Plattner, April 2010
	Fixed warnings when compiled with GCC's -Wall option.

************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <sys/types.h>
#include <errno.h>
#include "dtmac.h"
#include "dtmsg.h"
#include "error.h"
#include "ltoa.h"
#include "tet3_config.h"
#include "servlib.h"
#include "dtetlib.h"
#include "scentab.h"
#include "proctab.h"
#include "systab.h"
#include "tcc.h"
#include "tcclib.h"

/* static function declarations */
static void inittd2 PROTOLIST((struct systab *));
static void inittd3 PROTOLIST((int, char [], int));
#ifndef TET_LITE	/* -START-LITE-CUT- */
static int init1sfdir PROTOLIST((struct systab *));
static void rtrc2 PROTOLIST((int, char *));
#endif /* !TET_LITE */	/* -END-LITE-CUT- */


/*
**	rtlcopy() - copy the test suite to the runtime directory
**		on the local system if so required
*/

void rtlcopy()
{
	static char fmt[] = "can't copy test suite %.*s to runtime directory %.*s on";
	char msg[sizeof fmt + (MAXPATH * 2)];
	char dest[MAXPATH];

	TRACE3(tet_Ttcc, 1, "copying test suite %s to run-time directory %s on the local system",
		tet_tsroot, tet_run);

	/* determine the name of the destination directory */
	fullpath(tet_run, tet_basename(tet_tsroot), dest, sizeof dest, 0);

	/* do the copy */
	errno = 0;
	if (tet_fcopy(tet_tsroot, dest) < 0) {
		sprintf(msg, fmt, MAXPATH, tet_tsroot, MAXPATH, dest);
		fatal(errno, msg, "the local system");
	}

	/* update tet_tsroot to refer to the new location */
	TRACE2(tet_Tbuf, 6, "free tet_tsroot = %s", tet_i2x(tet_tsroot));
	free(tet_tsroot);
	tet_tsroot = rstrstore(dest);
	TRACE2(tet_Ttcc, 1, "new tet_tsroot = %s", tet_tsroot);
}


#ifndef TET_LITE	/* -START-LITE-CUT- */

/*
**	rtrcopy() - copy the test suite to the runtime directory
**		on each of the remote systems if so required
*/

void rtrcopy()
{
	register int sysid, sysmax;
	char *rtdir;

	for (sysid = 1, sysmax = symax(); sysid <= sysmax; sysid++)
		if (syfind(sysid) != (struct systab *) 0 &&
			(rtdir = getdcfg("TET_RUN", sysid)) != (char *) 0)
				rtrc2(sysid, rtdir);
}

/*
**	rtrc2() - extend the rtrcopy() processing for a particular system
*/

static void rtrc2(sysid, rtdir)
int sysid;
char *rtdir;
{
	static char fmt[] = "can't copy test suite %.*s to runtime directory %.*s on system";
	char msg[sizeof fmt + (MAXPATH * 2)];
	char dest[MAXPATH];
	char *tsroot;

	/* determine the name of the destination directory */
	tsroot = getdcfg("TET_TSROOT", sysid);
	ASSERT(tsroot);
	fullpath(rtdir, tet_basename(tsroot), dest, sizeof dest, 1);

	TRACE4(tet_Ttcc, 1,
		"copying test suite %s to run-time directory %s on system %s",
		tsroot, rtdir, tet_i2a(sysid));

	/* do the copy */
	errno = 0;
	if (tet_tcrcopy(sysid, tsroot, dest) < 0) {
		sprintf(msg, fmt, MAXPATH, tsroot, MAXPATH, dest);
		if (!IS_ER_ERRNO(tet_tcerrno))
			errno = 0;
		fatal(errno ? errno : tet_tcerrno, msg, tet_i2a(sysid));
	} 
}

#endif /* !TET_LITE */	/* -END-LITE-CUT- */


/*
**	inittmpdir() - create a temporary execution directory if necessary
**		on each system for use when TET_EXEC_IN_PLACE is false
*/

void inittmpdir()
{
	register int sysid, sysmax;
	register struct systab *sp;

	for (sysid = 0, sysmax = symax(); sysid <= sysmax; sysid++)
		if ((sp = syfind(sysid)) != (struct systab *) 0)
			inittd2(sp);
}

/*
**	inittd2() - extend the inittmpdir() processing for a particular system
*/

static void inittd2(sp)
struct systab *sp;
{
	static char tmpdirname[] = "TET_TMP_DIR";
	char buf[MAXPATH];
	char *tdir;

	TRACE2(tet_Ttcc, 4, "inittd2(%s)", tet_i2a(sp->sy_sysid));

	ASSERT_LITE(sp->sy_sysid == 0);

	/*
	** if no temporary directory has been specified on this system,
	** create it if necessary and install the name in the distributed
	** configuration for this system
	*/
	if ((tdir = getdcfg(tmpdirname, sp->sy_sysid)) == (char *) 0) {
		inittd3(sp->sy_sysid, buf, sizeof buf);
		tdir = buf;
		putdcfg(tmpdirname, sp->sy_sysid, tdir);
	}

	TRACE3(tet_Ttcc, 1, "TET_TMP_DIR on system %s = %s",
		tet_i2a(sp->sy_sysid), tdir);
}

/*
**	inittd3() - determine the default location for the temporary
**		directory and create it if necessary
**
**	return the name of the default location
*/

static void inittd3(sysid, tdir, tdirlen)
int sysid, tdirlen;
char tdir[];
{
	static char fmt[] = "can't create directory %.*s on system";
	char msg[sizeof fmt + MAXPATH];
	char *tsroot;

	TRACE2(tet_Ttcc, 4, "inittd3(): sysid = %s", tet_i2a(sysid));

	/* determine the name of the default tmpdir */
	tsroot = get_runtime_tsroot(sysid);
	ASSERT(tsroot);
	fullpath(tsroot, "tet_tmp_dir", tdir, tdirlen, sysid > 0 ? 1 : 0);

	/* return now if this directory exists already */
	if (tcc_access(sysid, tdir, 0) == 0)
		return;

	/* here to create the tmpdir */
	errno = 0;
	if (tcc_mkdir(sysid, tdir) < 0) {
		sprintf(msg, fmt, MAXPATH, tdir);
		fatal(errno ? errno : tet_tcerrno, msg, tet_i2a(sysid));
	}

	/* all OK so return */
	TRACE3(tet_Ttcc, 2, "created directory %s on system %s",
		tdir, tet_i2a(sysid));
}

/*
**	tcc_mktmpdir() - create the temporary directory for use when
**		TET_EXEC_IN_PLACE is false
**
**	return 0 if successful or -1 on error
**
**	if successful, the name of the newly-created directory is returned
**	indirectly through *tdp
*/

int tcc_mktmpdir(prp, tmproot, tdp)
struct proctab *prp;
char *tmproot, **tdp;
{

	ASSERT_LITE(*prp->pr_sys == 0);

	/* create the temporary directory */
#ifdef TET_LITE	/* -LITE-CUT-LINE- */
	if ((tet_tcerrno = tcf_mktmpdir(tmproot, tdp)) != ER_OK)
		*tdp = (char *) 0;
#else	/* -START-LITE-CUT- */
	*tdp = tet_tcmktmpdir(*prp->pr_sys, tmproot);
#endif /* TET_LITE */	/* -END-LITE-CUT- */

	/* handle an error return */
	if (*tdp == (char *) 0) {
		if (!IS_ER_ERRNO(tet_tcerrno))
			errno = 0;
		prperror(prp, *prp->pr_sys, errno ? errno : tet_tcerrno,
			"can't create temporary directory below", tmproot);
		return(-1);
	}

	TRACE3(tet_Ttcc, 4,
		"created temporary execution directory %s on system %s",
		*tdp, tet_i2a(*prp->pr_sys));

	return(0);
}

/*
**	tcc_mkalldirs() - make directories recursively
**
**	return 0 if successful or -1 on error
*/

int tcc_mkalldirs(prp, dir)
struct proctab *prp;
char *dir;
{
	int rc;

	ASSERT_LITE(*prp->pr_sys == 0);

#ifdef TET_LITE	/* -LITE-CUT-LINE- */
	rc = tet_mkalldirs(dir);
	tet_tcerrno = rc < 0 ? tet_maperrno(errno) : ER_OK;
#else /* TET_LITE */	/* -START-LITE-CUT- */
	rc = tet_tcmkalldirs(*prp->pr_sys, dir);
#endif /* TET_LITE */	/* -END-LITE-CUT- */

	if (rc < 0) {
		if (!IS_ER_ERRNO(tet_tcerrno))
			errno = 0;
		prperror(prp, *prp->pr_sys, errno ? errno : tet_tcerrno,
			"can't recursively make directory", dir);
		return(-1);
	}

	return(0);
}

/*
**	tcc_rmtmpdir() - remove the temporary directory which is used when
**		TET_EXEC_IN_PLACE is false
**
**	return 0 if successful or -1 on error
*/

int tcc_rmtmpdir(prp, tmpdir)
struct proctab *prp;
char *tmpdir;
{
	struct systab *sp;
	char *tetroot;
	int err, rc;

	/*
	** if we are currently in the tmpdir subtree (or don't yet know where
	** we are), go back to TET_ROOT
	*/
	sp = syfind(*prp->pr_sys);
	ASSERT(sp);
	
	if (sp->sy_cwd) {
		rc = strncmp(tmpdir, sp->sy_cwd, strlen(tmpdir));
	}
	else
		rc = 0;

	if (!rc) {
		tetroot = getdcfg("TET_ROOT", *prp->pr_sys);
		ASSERT(tetroot && *tetroot);
		if (sychdir(sp, tetroot) < 0) {
			prperror(prp, *prp->pr_sys, errno ? errno : tet_tcerrno,
				"can't change directory to", tetroot);
			return(-1);
		}
	}

	/* remove the tmpdir */
#ifdef TET_LITE	/* -LITE-CUT-LINE- */
	rc = tcf_rmrf(tmpdir);
	err = errno;
#else	/* -START-LITE-CUT- */
	rc = tet_tcrmalldirs(*prp->pr_sys, tmpdir);
	err = tet_tcerrno;
#endif /* TET_LITE */	/* -END-LITE-CUT- */
	if (rc < 0) {
		prperror(prp, *prp->pr_sys, err,
			"can't remove temporary directory subtree", tmpdir);
		return(-1);
	}

	TRACE3(tet_Ttcc, 4,
		"removed temporary execution directory %s on system %s",
		tmpdir, tet_i2a(*prp->pr_sys));
	return(0);
}

/*
**	tccopy() - copy the test case directory to the temporary
**		execution directory when TET_EXEC_IN_PLACE is false
**
**	return 0 if successful or -1 on error
*/

int tccopy(prp, from, to)
struct proctab *prp;
char *from, *to;
{
	static char fmt[] = "can't copy test case directory %.*s to temporary directory";
	char msg[sizeof fmt + MAXPATH];
	int err, rc;

#ifdef TET_LITE	/* -LITE-CUT-LINE- */
	if ((rc = tet_fcopy(from, to)) < 0)
		err = errno;
#else	/* -START-LITE-CUT- */
	if ((rc = tet_tcrcopy(*prp->pr_sys, from, to)) < 0)
		err = IS_ER_ERRNO(tet_tcerrno) ? errno : tet_tcerrno;
#endif /* TET_LITE */	/* -END-LITE-CUT- */
	if (rc < 0) {
		sprintf(msg, fmt, MAXPATH, from);
		prperror(prp, *prp->pr_sys, err, msg, to);
		return(-1);
	}

	TRACE3(tet_Ttcc, 4, "copied test case directory %s to %s", from, to);

	return(0);
}


#ifndef TET_LITE	/* -START-LITE-CUT- */

/*
**	initsfdir() - create saved files directories on each remote system
*/

void initsfdir()
{
	register int sysid, sysmax;
	register struct systab *sp;
	int rc = 0;

	for (sysid = 1, sysmax = symax(); sysid <= sysmax; sysid++)
		if ((sp = syfind(sysid)) != (struct systab *) 0 &&
			init1sfdir(sp) < 0)
				rc = -1;

	if (rc < 0)
		tcc_exit(1);
}

/*
**	init1sfdir() - create the saved files directory on a single
**		remote system
**
**	return 0 if successful or -1 on error
*/

static int init1sfdir(sp)
struct systab *sp;
{
	static char fmt[] =
		"can't create saved files directory %s%.*s on system";
	static char below[] = "below ";
	char msg[sizeof fmt + sizeof below + MAXPATH];
	char resroot[MAXPATH];
	char *sfdir, *tsroot;

	TRACE2(tet_Ttcc, 4, "initsfdir(%s)", tet_i2a(sp->sy_sysid));

	/*
	** determine the name of the results directory root on the
	** remote system
	*/
	tsroot = get_runtime_tsroot(sp->sy_sysid);
	ASSERT(tsroot);
	fullpath(tsroot, "results", resroot, sizeof resroot, 1);

	/* create the results directory on the remote system if necessary */
	if (tet_tcmkalldirs(sp->sy_sysid, resroot) < 0) {
		sprintf(msg, fmt, "",
			sizeof msg - sizeof fmt, resroot);
		if (!IS_ER_ERRNO(tet_tcerrno))
			errno = 0;
		error(errno ? errno : tet_tcerrno, msg, tet_i2a(sp->sy_sysid));
		return(-1);
	}

	/* create the saved files directory on the remote system */
	if ((sfdir = tet_tcmksdir(sp->sy_sysid, resroot, resdirsuffix())) == (char *) 0) {
		sprintf(msg, fmt, below,
			sizeof msg - sizeof fmt - sizeof below, resroot);
		error(tet_tcerrno, msg, tet_i2a(sp->sy_sysid));
		return(-1);
	}

	/* all OK so remember the directory name and return */
	sp->sy_sfdir = rstrstore(sfdir);
	return(0);
}

#endif /* !TET_LITE */	/* -END-LITE-CUT- */


/*
**	sfproc() - perform save files processing on a single system
**
**	return 0 if successful or -1 on error
*/

int sfproc(prp, sfiles, nsfiles)
register struct proctab *prp;
char **sfiles;
int nsfiles;
{
	static char fmt[] = "can't copy save files from %.*s on system %03d to";
	char msg[sizeof fmt + MAXPATH + LNUMSZ];
	struct systab *sp;
	int rc;
	int tsfiles = 0;
	char savedir[MAXPATH];
#ifndef TET_LITE	/* -START-LITE-CUT- */
	char path[MAXPATH];
	static char remote[] = "REMOTE%03d";
	char subdir[sizeof remote];
#endif /* !TET_LITE */	/* -END-LITE-CUT- */


	TRACE3(tet_Ttcc, 4, "sfproc(%s): sysid = %s",
		tet_i2x(prp), tet_i2a(*prp->pr_sys));

	ASSERT(prp->pr_nsys == 1);
	ASSERT_LITE(*prp->pr_sys == 0);

	/* change directory to the test case execution directory */
	sp = syfind(*prp->pr_sys);
	ASSERT(sp);
	if (sychdir(sp, prp->pr_tcedir) < 0) {
		prperror(prp, *prp->pr_sys, errno ? errno : tet_tcerrno,
			"can't change directory to", prp->pr_tcedir);
		return(-1);
	}

	/* then do the save */
#ifdef TET_LITE	/* -LITE-CUT-LINE- */

	tsfiles = 0;
	tcexecdir(prp, resdirname(), savedir, sizeof savedir);
	tet_tcerrno = tcf_procdir(".", savedir, sfiles, nsfiles, TCF_TS_LOCAL);
	rc = (tet_tcerrno == ER_OK) ? 0 : -1;

#else /* TET_LITE */	/* -START-LITE-CUT- */

	/*
	** if TET_TRANSFER_SAVE_FILES is true for this system, we must
	** copy the files to REMOTEnnn below the results directory on
	** the local system; if this is the local system, TCCD can do
	** this unaided (tet_tctslfiles()), otherwise TCCD must work with
	** XRESD to do this (tet_tctsmfiles())
	**
	** if TET_TRANSFER_SAVE_FILES is false for this system, we must
	** copy the files to the saved files directory on this system;
	** TCCD can always do this unaded
	*/

	tsfiles = getcflag("TET_TRANSFER_SAVE_FILES", *prp->pr_sys,
		prp->pr_currmode);

	if (tsfiles) {
		sprintf(subdir, remote, *prp->pr_sys % 1000);
		fullpath(resdirname(), subdir, path, sizeof path,
			*prp->pr_sys ? 1 : 0);
		tcexecdir(prp, path, savedir, sizeof savedir);
		if (*prp->pr_sys > 0)
			rc = tet_tctsmfiles(*prp->pr_sys, sfiles, nsfiles,
				savedir + strlen(resdirname()));
		else
			rc = tet_tctslfiles(*prp->pr_sys, sfiles, nsfiles,
				(char *) 0, savedir);
	}
	else
	{
		tcexecdir(prp,
			(*prp->pr_sys > 0) ? sp->sy_sfdir : resdirname(),
			savedir, sizeof savedir);
		rc = tet_tctslfiles(*prp->pr_sys, sfiles, nsfiles,
			(char *) 0, savedir);
	}

#endif /* TET_LITE */	/* -END-LITE-CUT- */

	if (rc < 0) {
		sprintf(msg, fmt, MAXPATH, prp->pr_tcedir, *prp->pr_sys);
		prperror(prp, tsfiles ? 0 : *prp->pr_sys, tet_tcerrno,
			msg, savedir);
	}

	return(rc);
}

