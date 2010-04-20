/*
 *      SCCS:  @(#)tsinfo.c	1.7 (98/09/01) 
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

SCCS:   	@(#)tsinfo.c	1.7 98/09/01 TETware release 3.3
NAME:		tsinfo.c
PRODUCT:	TETware
AUTHOR:		Andrew Dingwall, UniSoft Ltd.
DATE CREATED:	April 1992

DESCRIPTION:
	functions to convert DTET interprocess INET transport-specific
	information messages between internal and machine-independent format

MODIFICATIONS:
	Andrew Dingwall, UniSoft Ltd., July 1998
	Added support for shared API libraries.

	Aaron Plattner, April 2010
	Fixed warnings when compiled with GCC's -Wall option.

************************************************************************/

#include <stdio.h>
#include "dtmac.h"
#include "ldst.h"
#include "dtmsg.h"
#include "tsinfo_in.h"
#include "dtetlib.h"

static struct stdesc st[] = {
	TSINFO_DESC
};

static short nst = -1;

/* static function declarations */
static void stinit PROTOLIST((void));


static void stinit()
{
	register struct tsinfo *sp = (struct tsinfo *) 0;
	register int n = 0;

	TSINFO_INIT(st, sp, n, nst);
}

TET_IMPORT int tet_tsinfo2bs(from, to)
register struct tsinfo *from;
register char *to;
{
	if (nst < 0)
		stinit();

	return(tet_st2bs((char *) from, to, st, nst));
}

/*
**	tet_bs2tsinfo() - convert a tsinfo message to internal format
*/

int tet_bs2tsinfo(from, fromlen, to, tolen)
register char *from;
register int fromlen;
register struct tsinfo **to;
register int *tolen;
{
	if (nst < 0)
		stinit();

	if (BUFCHK((char **) to, tolen, sizeof **to) < 0)
		return(-1);

	if (tet_bs2st(from, (char *) *to, st, nst, fromlen) < 0)
		return(-1);

	return(sizeof **to);
}

