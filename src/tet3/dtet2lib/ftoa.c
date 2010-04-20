/*
 *      SCCS:  @(#)ftoa.c	1.9 (98/08/28) 
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

SCCS:   	@(#)ftoa.c	1.9 98/08/28 TETware release 3.3
NAME:		ftoa.c
PRODUCT:	TETware
AUTHOR:		Andrew Dingwall, UniSoft Ltd.
DATE CREATED:	June 1992

DESCRIPTION:
	function to return a printable representation of a set of flags

MODIFICATIONS:
	Andrew Dingwall, UniSoft Ltd., August 1996
	add a pool of re-usable buffers so that more than one tet_f2a()
	value may be passed to a reporting function

	Aaron Plattner, April 2010
	Fixed warnings when compiled with GCC's -Wall option.

************************************************************************/

#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include "dtmac.h"
#include "dtmsg.h"
#include "ptab.h"
#include "ltoa.h"
#include "ftoa.h"
#include "dtetlib.h"

/*
**	tet_f2a() - return printable representation of ptab pt_flags value
**
**	the return value points to a static area whose contents are
**	overwritten after NFBUF calls
*/

char *tet_f2a(fval, flags, nflags)
int fval, nflags;
struct flags flags[];
{
	static struct {
		char *bp;
		int buflen;
	} bufstruct[NFBUF];
	static int count;
	char **bpp;
	int *blp;
	register struct flags *fp;
	register char *p1, *p2;
	register unsigned ftmp;
	register int n, needlen;

	if (++count >= NFBUF)
		count = 0;
	bpp = &bufstruct[count].bp;
	blp = &bufstruct[count].buflen;

	/* work out the required output buffer size */
	for (needlen = 0, ftmp = fval, n = 0; ftmp; ftmp >>= 1, n++) {
		if (!(ftmp & 1))
			continue;
		for (fp = &flags[nflags - 1]; fp >= flags; fp--)
			if (fp->fl_value == (1 << n)) {
				needlen += strlen(fp->fl_name) + 1;
				break;
			}
		if (fp < flags)
			needlen += strlen(tet_i2o(1 << n)) + 1;
	}

	/* get the buffer to put the flag names in */
	if (BUFCHK(bpp, blp, TET_MAX(needlen, 2)) < 0)
		return("");

	/* copy the flag names in to the buffer */
	for (p1 = *bpp, ftmp = fval, n = 0; ftmp; ftmp >>= 1, n++) {
		if (!(ftmp & 1))
			continue;
		for (fp = &flags[nflags - 1]; fp >= flags; fp--)
			if (fp->fl_value == (1 << n)) {
				for (p2 = fp->fl_name; *p2; p2++)
					*p1++ = *p2;
				break;
			}
		if (fp < flags)
			for (p2 = tet_i2o(1 << n); *p2; p2++)
				*p1++ = *p2;
		if (ftmp & ~1)
			*p1++ = '|';
	}

	if (p1 == *bpp)
		*p1++ = '0';

	*p1 = '\0';

	return(*bpp);
}

