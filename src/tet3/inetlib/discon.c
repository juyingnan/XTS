/*
 *      SCCS:  @(#)discon.c	1.5 (97/07/21) 
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
static char sccsid[] = "@(#)discon.c	1.5 (97/07/21) TET3 release 3.3";
#endif

/************************************************************************

SCCS:   	@(#)discon.c	1.5 97/07/21 TETware release 3.3
NAME:		discon.c
PRODUCT:	TETware
AUTHOR:		Denis McConalogue, Unisoft Ltd.
DATE CREATED:	May 1993

DESCRIPTION:
	required transport-specific library interface

	function to support tet_disconnect() for the INET transport interface

MODIFICATIONS:
	Andrew Dingwall, UniSoft Ltd., December 1993
	moved function from connect.c to here


************************************************************************/

#include <sys/types.h>
#  include <netinet/in.h>
#include "dtmac.h"
#include "dtmsg.h"
#include "ptab.h"
#include "tptab_in.h"
#include "tslib.h"

#ifndef NOTRACE
#include "ltoa.h"
#endif


/*
**      tet_ts_disconnect() - transport-specific disconnect routine -
**		called from tet_disconnect()
**
**	note that this function can be called even when the calling process
**	is not connected to the specified server
*/

void tet_ts_disconnect(pp)
struct ptab *pp;
{
        register struct tptab *tp = (struct tptab *) pp->pt_tdata;

	TRACE2(tet_Tio, 4, "tet_ts_disconnect: close sd %s",
		tet_i2a(tp->tp_sd));

	if (tp->tp_sd != INVALID_SOCKET) {
		(void) SOCKET_CLOSE(tp->tp_sd);
		tp->tp_sd = INVALID_SOCKET;
	}

	pp->pt_flags = (pp->pt_flags & ~(PF_LOGGEDON | PF_CONNECTED)) | PF_LOGGEDOFF;
	pp->pt_state = PS_IDLE;
}

