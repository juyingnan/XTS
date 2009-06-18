/*
 *      SCCS:  @(#)ltoa.c	1.7 (98/08/28) 
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
static char sccsid[] = "@(#)ltoa.c	1.7 (98/08/28) TET3 release 3.3";
#endif

/************************************************************************

SCCS:   	@(#)ltoa.c	1.7 98/08/28 TETware release 3.3
NAME:		ltoa.c
PRODUCT:	TETware
AUTHOR:		Andrew Dingwall, UniSoft Ltd.
DATE CREATED:	April 1992

DESCRIPTION:
	function to convert long int to ascii
	avoids having to use sprintf to format error messages

MODIFICATIONS:
	Andrew Dingwall, UniSoft Ltd., June 1997
	corrected the problem with the largest -ve number

	Andrew Dingwall, UniSoft Ltd., July 1998
	Added support for shared API libraries.
 
************************************************************************/

#include "dtmac.h"
#include "ltoa.h"

/*
**	tet_l2a() - convert long int to ascii
*/

TET_IMPORT char *tet_l2a(n)
register long n;
{
	static char buf[NLBUF][LNUMSZ];
	static int count;
	register char *p;
	register int sign;

	sign = (n < 0L) ? -1 : 1;

	if (++count >= NLBUF)
		count = 0;
	p = &buf[count][LNUMSZ - 1];
	*p = '\0';

	do {
		*--p = ((n % 10L) * sign) + '0';
	} while ((n /= 10L) != 0L);

	if (sign < 0)
		*--p = '-';

	return(p);
}

