/*
 *      SCCS:  @(#)tptab.c	1.7 (97/07/21) 
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

SCCS:   	@(#)tptab.c	1.7 97/07/21 TETware release 3.3
NAME:		tptab.c
PRODUCT:	TETware
AUTHOR:		Andrew Dingwall, UniSoft Ltd.
DATE CREATED:	April 1992

DESCRIPTION:
	functions to administer INET transport-specific process table data

MODIFICATIONS:

	Aaron Plattner, April 2010
	Fixed warnings when compiled with GCC's -Wall option.

************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/types.h>
#  include <netinet/in.h>
#include "dtmac.h"
#include "dtmsg.h"
#include "ptab.h"
#include "tptab_in.h"
#include "error.h"
#include "bstring.h"
#include "dtetlib.h"
#include "tslib.h"

#ifndef NOTRACE
#include "ltoa.h"
#endif


/*
**	tet_ts_ptalloc() - allocate transport-specific data element in a ptab
**		structure
**
**	return 0 if successful or -1 on error
*/

int tet_ts_ptalloc(pp)
struct ptab *pp;
{
	register struct tptab *tp;

	errno = 0;
	if ((tp = (struct tptab *) malloc(sizeof *tp)) == (struct tptab *) 0) {
		error(errno, "can't get memory for ts data", (char *) 0);
		pp->pt_tdata = (char *) 0;
		return(-1);
	}
	TRACE2(tet_Tbuf, 6, "allocate tptab = %s", tet_i2x(tp));
	bzero((char *) tp, sizeof *tp);

	tp->tp_sd = INVALID_SOCKET;
	if (BUFCHK(&tp->tp_buf, &tp->tp_len, DM_HDRSZ) < 0) {
		tet_ts_ptfree(pp);
		return(-1);
	}
	tp->tp_ptr = tp->tp_buf;

	pp->pt_tdata = (char *) tp;
	return(0);
}

/*
**	tet_ts_ptfree() - free transport-specific data element in a
**		ptab structure
*/

void tet_ts_ptfree(pp)
struct ptab *pp;
{
	register struct tptab *tp = (struct tptab *) pp->pt_tdata;

	TRACE2(tet_Tbuf, 6, "free tptab = %s", tet_i2x(tp));

	if (tp) {
		if (tp->tp_buf) {
			TRACE2(tet_Tbuf, 6, "free tpbuf = %s",
				tet_i2x(tp->tp_buf));
			free(tp->tp_buf);
		}
		free((char *) tp);
		pp->pt_tdata = (char *) 0;
	}
}

