/*
 *      SCCS:  @(#)ptstate.c	1.7 (98/08/28) 
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

SCCS:   	@(#)ptstate.c	1.7 98/08/28 TETware release 3.3
NAME:		ptstate.c
PRODUCT:	TETware
AUTHOR:		Andrew Dingwall, UniSoft Ltd.
DATE CREATED:	April 1992

DESCRIPTION:
	function to return printable representation of process state

MODIFICATIONS:

	Andrew Dingwall, UniSoft Ltd., July 1998
	Only compile code in this file when building Distributed TETware.

	Aaron Plattner, April 2010
	Fixed warnings when compiled with GCC's -Wall option.

************************************************************************/

#ifndef TET_LITE	/* -START-LITE-CUT- */

#include <stdio.h>
#include <sys/types.h>
#include "dtmac.h"
#include "dtmsg.h"
#include "ptab.h"
#include "ltoa.h"
#include "dtetlib.h"

/*
**	tet_ptstate() - return a printable representation of a ptab pt_state
**		value
*/

char *tet_ptstate(state)
int state;
{
	static char text[] = "process-state ";
	static char msg[sizeof text + LNUMSZ];

	switch (state) {
	case PS_DEAD:
		return("DEAD");
	case PS_IDLE:
		return("IDLE");
	case PS_RCVMSG:
		return("RCVMSG");
	case PS_SNDMSG:
		return("SNDMSG");
	case PS_PROCESS:
		return("PROCESS");
	case PS_WAITSYNC:
		return("WAITSYNC");
	case PS_CONNECT:
		return("CONNECT");
	default:
		sprintf(msg, "%s%d", text, state);
		return(msg);
	}
}

#else		/* -END-LITE-CUT- */

int tet_ptstate_c_not_used;

#endif		/* -LITE-CUT-LINE- */

