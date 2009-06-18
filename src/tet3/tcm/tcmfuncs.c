/*
 *      SCCS:  @(#)tcmfuncs.c	1.25 (98/09/01) 
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

#ifndef lint
static char sccsid[] = "@(#)tcmfuncs.c	1.25 (98/09/01) TET3 release 3.3";
static char *copyright[] = {
	"(C) Copyright 1996 X/Open Company Limited",
	"All rights reserved"
};
#endif

/************************************************************************

SCCS:   	@(#)tcmfuncs.c	1.25 98/09/01 TETware release 3.3
NAME:		tcmfuncs.c
PRODUCT:	TETware
AUTHOR:		Andrew Dingwall, UniSoft Ltd.
DATE CREATED:	April 1992

DESCRIPTION:
	generic tcm client-related functions

MODIFICATIONS:
	Andrew Dingwall, UniSoft Ltd., October 1992
	Set tet_progname to basename(argv[0]) so as to avoid long path names
	in error messages.
	Moved tet_tcmptype() call to after TET_TIARGS parsing so that tcmchild
	processes can determine which system they are on.
	Moved tet_root[] from dtcm.c to here so that it is available
	to tcmchild processes as well.

	Denis McConalogue, UniSoft Limited, September 1993
	added ss_disconnect() function

	Andrew Dingwall, UniSoft Ltd., December 1993
	Removed disconnect stuff.
	Changed dapi.h to dtet2/tet_api.h
	Corrected error message when TET_ROOT is not set.

	Andrew Dingwall, UniSoft Ltd., February 1994
	replaced generror() with dtcmerror() as the error handler -
	this sends TETware errors to tet_error() so they will probably
	appear in the journal rather than just being sent to stderr
	straight off

	Andrew Dingwall, UniSoft Ltd., December 1994
	Handle recursive calls to dtcmerror() sensibly.

	Andrew Dingwall, UniSoft Ltd., August 1996
	changes for tetware tcc

	Geoff Clare, UniSoft Ltd., August 1996
	Missing <unistd.h>.

	Geoff Clare, UniSoft Ltd., Sept 1996
	Changes for TETware-Lite.

	Geoff Clare, UniSoft Ltd., Oct 1996
	Enable tracing in TETware-Lite.
	Restructured tcm source to avoid "ld -r".

	Andrew Dingwall, UniSoft Ltd., June 1997
	changes to enable parallel remote and distributed test cases
	to work correctly;
	improved process type determination when processing trace args

	Andrew Dingwall, UniSoft Ltd., July 1998
	Added support for shared API libraries.
 
************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <errno.h>
#include <sys/types.h>
#  include <unistd.h>
#include "dtmac.h"
#include "tet_api.h"
#include "dtmsg.h"
#include "ptab.h"
#include "error.h"
#include "globals.h"
#include "synreq.h"
#include "server.h"
#include "servlib.h"
#include "dtetlib.h"
#include "apilib.h"
#include "tslib.h"
#include "tcmfuncs.h"

#ifndef NOTRACE
#include "ltoa.h"
#endif

#ifdef NEEDsrcFile
static char srcFile[] = __FILE__;	/* file name for error reporting */
#endif

#ifndef TET_LITE /* -START-LITE-CUT- */
extern int tet_psysid;			/* parent's system id */
#endif /* -END-LITE-CUT- */


/*
**	tet_tcminit() - initialisation for both master and slave TCMs
*/

/* ARGSUSED */
void tet_tcminit(argc, argv)
int argc;
char **argv;
{
	register char *envstring, *p;
	char **args;
	int nargs;
#ifndef TET_LITE /* -START-LITE-CUT- */
	char errmsg[128];
	register char **ap;
	register int *ip;
	struct synreq *synreq, *sp;
	int count;
	int nsys;
#endif /* -END-LITE-CUT- */
	static char tiargs_name[] = "TET_TIARGS";
	static char tetroot_name[] = "TET_ROOT";
	static char envmsg[] = "null or not set";
#ifdef NOTRACE
	int twarn = 0;
#else
#  ifndef TET_LITE /* -START-LITE-CUT- */
	int ptsave;
#  endif /* -END-LITE-CUT- */
#endif

	/* get TET_ROOT out of the environment */
	if ((envstring = getenv(tetroot_name)) == (char *) 0 || !*envstring)
		fatal(0, tetroot_name, envmsg);
	(void) sprintf(tet_root, "%.*s", (int) sizeof tet_root - 1, envstring);

	/* get the dtet ti args out of the environment and count them */
	if ((envstring = getenv(tiargs_name)) == (char *) 0 || !*envstring) {
#ifndef TET_LITE /* -START-LITE-CUT- */
		fatal(0, tiargs_name, envmsg);
		/* NOTREACHED */
		return;
#else /* -END-LITE-CUT- */
		args = NULL;
		nargs = 0;
#endif /* -LITE-CUT-LINE- */
	}
	else {
		nargs = 1;
		for (p = envstring; *p; p++)
			if (isspace(*p))
				nargs++;

		/* allocate some space for argument pointers */
		errno = 0;
		if ((args = (char **) malloc(nargs * sizeof *args)) == (char **) 0)
			fatal(errno, "can't get memory for arg list",
				(char *) 0);
		TRACE2(tet_Tbuf, 6, "allocate ti env args = %s", tet_i2x(args));

		/* split the arg string into fields */
		nargs = tet_getargs(envstring, args, nargs);

#ifndef TET_LITE /* -START-LITE-CUT- */

		/* process each argument in turn */
#  ifndef NOTRACE
		/* assume MTCM if we're not sure */
		if ((ptsave = tet_myptype) < 0 || ptsave == PT_NOPROC)
			tet_myptype = PT_MTCM;
		tet_traceinit(nargs + 1, args - 1);
		tet_myptype = ptsave;
#  endif
		for (ap = args; ap < &args[nargs]; ap++) {
			if (*(p = *ap) != '-')
				continue;
			TRACE2(tet_Ttcm, 6, "TI arg = \"%s\"", p);
			switch (*++p) {
			case 'T':
#  ifdef NOTRACE
				if (!twarn) {
					error(0, "tracing not configured",
						(char *) 0);
					twarn = 1;
				}
#  endif
				break;
			case 'l':
				count = isdigit(*++p) ? 1 : 0;
				do {
					if (*p == ',')
						count++;
					else if (!isdigit(*p))
						fatal(0, "bad sysname string",
							*ap);
				} while (*++p);
				errno = 0;
				if ((tet_snames = (int *) malloc(count * sizeof *tet_snames)) == (int *) 0)
					fatal(errno, "can't get memory for sname list",
						(char *) 0);
				TRACE2(tet_Tbuf, 6, "allocate tet_snames = %s",
					tet_i2x(tet_snames));
				p = *ap + 2;
				ip = tet_snames;
				tet_Nsname = count;
				while (--count >= 0) {
					*ip = atoi(p);
					ip++;
					while (*p)
						if (*p++ == ',')
							break;
				}
				break;
			case 'n':
				if ((tet_snid = atol(p + 1)) <= 0)
					fatal(0, "bad sync id", *ap);
				break;
			case 'p':
				if ((tet_psysid = atoi(p + 1)) < 0)
					fatal(0, "bad parent system id", *ap);
				break;
			case 'r':
				if ((tet_xrid = atol(p + 1)) <= 0)
					fatal(0, "bad xres id", *ap);
				break;
			case 's':
				if ((tet_mysysid = atoi(p + 1)) < 0)
					fatal(0, "bad system id", *ap);
				break;
			default:
				fatal(0, "bad ti env argument", *ap);
				/* NOTREACHED */
			}
		}
#endif /* -END-LITE-CUT- */

	} /* end of tiargs processing */

#ifndef TET_LITE /* -START-LITE-CUT- */

	if (tet_mysysid < 0)
		fatal(0, "sysid not assigned", (char *) 0);

	if (tet_snid < 0L)
		fatal(0, "snid not assigned", (char *) 0);

	if (tet_xrid < 0L)
		fatal(0, "xrid not assigned", (char *) 0);

	if (tet_Nsname <= 0)
		fatal(0, "system name list not assigned", (char *) 0);

	/* assign my process type */
	switch (tet_myptype = tet_tcmptype()) {
	case PT_MTCM:
	case PT_STCM:
		break;
	default:
		fatal(0, "ptype assignment error:", tet_ptptype(tet_myptype));
	}

#endif /* -END-LITE-CUT- */

#ifndef NOTRACE
	/* initialise tracing for known process type */
	if (args != NULL) {
		tet_tfclear();
		tet_traceinit(nargs + 1, args - 1);
	}
#endif

	if (args != NULL) {
		TRACE2(tet_Tbuf, 6, "free ti env args = %s", tet_i2x(args));
		free((char *) args);
	}

#ifndef TET_LITE /* -START-LITE-CUT- */

	/* perform transport-specific initialisation */
	tet_ts_startup();
	tet_ts_tcminit();

	/* log on to syncd and xresd */
	if (tet_sdlogon() < 0 ||
		tet_xdlogon() < 0 ||
		tet_xdxrsend(tet_xrid) < 0)
			exit(1);

	/* now we are logged on to xresd, we can use the combined file
		if we received an xrid in TET_TIARGS */
	if (tet_xrid > 0L)
		tet_combined_ok = 1;

#endif /* -END-LITE-CUT- */

#ifndef TET_LITE /* -START-LITE-CUT- */

	/* get some memory for the autosync results */
	if ((synreq = (struct synreq *) malloc(tet_Nsname * sizeof *synreq)) == (struct synreq *) 0) {
		tet_error(errno, "can't get memory for synreq array");
		tet_exit(1);
	}
	TRACE2(tet_Tbuf, 6, "allocate synreq = %s", tet_i2x(synreq));

	/* here, TCMs sync with each other, or a TCMrem process syncs
		with its parent */
	nsys = tet_Nsname;
	if (tet_tcm_async(SV_EXEC_SPNO, SV_YES, SV_EXEC_TIMEOUT, synreq, &nsys) < 0) {
		tet_error(tet_sderrno, "initial sync failed");
		tet_exit(1);
	}

	/* if we didn't get an xrid from TET_TIARGS, we might have received
		one in the last async reply */
	if (!tet_combined_ok && tet_xrid > 0L)
		tet_combined_ok = 1;

	/* report a sync that failed in an "expected" way */
	if (tet_sderrno != ER_OK) {
		for (sp = synreq; sp < synreq + nsys; sp++)
			switch (sp->sy_state) {
			case SS_SYNCYES:
				break;
			default:
				(void) sprintf(errmsg,
				"initial sync error, sysid = %d, state = %s",
					sp->sy_sysid,
					tet_systate(sp->sy_state));
				tet_error(tet_sderrno, errmsg);
			}
		tet_exit(1);
	}

	TRACE2(tet_Tbuf, 6, "free synreq = %s", tet_i2x(synreq));
	free((char *) synreq);

#endif /* -END-LITE-CUT- */
}

/*
**	tet_dtcmerror() - TETware TCM error printing routine
**
**	messages printed by the error() macro come here
**	note that this function might be called recursively
*/

void tet_dtcmerror(errnum, file, line, s1, s2)
int errnum, line;
char *file;
register char *s1, *s2;
{
	char msg[MAXPATH + 128];
	register char *p = msg;
	static int inprogress = 0;
	int combined_save = 0;

	/* start the buffer with filename and line number */
	(void) sprintf(p, "(%s, %d): ", tet_basename(file), line);
	p += strlen(p);

	/* append the first message string */
	while (*s1 && p < &msg[sizeof msg - 1])
		*p++ = *s1++;

	/* append the second message string if there is one */
	if (s2 && *s2 && p < &msg[sizeof msg - 1]) {
		*p++ = ' ';
		while (*s2 && p < &msg[sizeof msg - 1])
			*p++ = *s2++;
	}

	/*
	** terminate the message and punt it to tet_error() for output -
	**	if we are called recursively, there is probably
	**	something wrong with the connection to xresd, so clear
	**	the tet_combined_ok flag to force output to stderr instead
	*/
	*p = '\0';
	if (inprogress++) {
		combined_save = tet_combined_ok;
		tet_combined_ok = 0;
	}
	tet_error(errnum, msg);
	if (--inprogress)
		tet_combined_ok = combined_save;

	errno = 0;
}

