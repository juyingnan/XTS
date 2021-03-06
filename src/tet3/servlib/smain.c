/*
 *      SCCS:  @(#)smain.c	1.10 (98/09/01) 
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

SCCS:   	@(#)smain.c	1.10 98/09/01 TETware release 3.3
NAME:		smain.c
PRODUCT:	TETware
AUTHOR:		Andrew Dingwall, UniSoft Ltd.
DATE CREATED:	April 1992

DESCRIPTION:
	generic server main() function

MODIFICATIONS:
	Geoff Clare, UniSoft Ltd., August 1996
	Missing <unistd.h> (for getpid) and <stdio.h> (for sprintf).

	Andrew Dingwall, UniSoft Ltd., July 1998
	Added support for shared API libraries.

	Aaron Plattner, April 2010
	Fixed warnings when compiled with GCC's -Wall option.

************************************************************************/

#include <stdio.h>
#include <sys/types.h>
#include "dtmac.h"
#include "globals.h"
#include "error.h"
#include "time.h"
#include "dtmsg.h"
#include "ptab.h"
#include "server.h"
#include "servlib.h"
#include "tslib.h"

/*
**	tet_si_main() - generic server main processing function
**
**	return 0 if successful or 1 (for process exit code) on error
*/

int tet_si_main(argc, argv, needtetroot)
int argc, needtetroot;
char **argv;
{
	register char *p;
	register int rc;
	char buf[30];

#ifndef NOTRACE
	tet_traceinit(argc, argv);
#endif

	while (++argv, --argc > 0) {
		if (*(p = *argv) != '-')
			break;
		switch (*++p) {
		case 'T':
			break;
		default:
			if (tet_ss_argproc(*argv, argc > 1 ? *(argv + 1) : (char *) 0) > 0) {
				--argc;
				++argv;
			}
			break;
		}
	}

	if (needtetroot) {
		if (argc > 0)
			sprintf(tet_root, "%.*s",
				(int) sizeof tet_root - 1, *argv);
		else {
			sprintf(buf, "%.14s [options] tetrootdir",
				tet_progname);
			fatal(0, "usage:", buf);
		}
	}

	/* initialise the transport library */
	tet_ts_startup();

	/* perform server-specific daemon initialisation */
	tet_ss_initdaemon();

	/* start main processing loop */
	while ((rc = tet_ss_serverloop()) > 0)
		;

	return(-rc);
}

