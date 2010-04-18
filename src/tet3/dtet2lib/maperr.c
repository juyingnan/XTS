/*
 *      SCCS:  @(#)maperr.c	1.8 (96/11/04)
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

SCCS:   	@(#)maperr.c	1.8 96/11/04 TETware release 3.3
NAME:		maperr.c
PRODUCT:	TETware
AUTHOR:		Andrew Dingwall, UniSoft Ltd.
DATE CREATED:	May 1992

DESCRIPTION:
	function to convert local errno value to DTET message reply code

MODIFICATIONS:
	Andrew Dingwall, UniSoft Ltd., November 1992
	AIX-specific modifications.

	Andrew Dingwall, UniSoft Ltd., January 1993
	Rewritten to use the errmap structure -
	this avoids compiler "duplicate case in switch" messages.

************************************************************************/

#include <stdio.h>
#include "dtmac.h"
#include "error.h"
#include "dtmsg.h"
#include "dtetlib.h"
#include "errmap.h"


/*
**	tet_maperrno() - map errno value to DTET message reply code
*/

int tet_maperrno(errnum)
register int errnum;
{
	register struct errmap *ep, *ee;

	for (ep = tet_errmap, ee = &tet_errmap[tet_Nerrmap]; ep < ee; ep++) {
		if (errnum == ep->em_errno) {
			if (ep->em_repcode)
				return(ep->em_repcode);
			else
				break;
		}
	}

	error(errnum, ep < ee ? ep->em_errname : tet_errname(errnum),
		"has no equivalent DTET message reply code");
	return(ER_ERR);
}
