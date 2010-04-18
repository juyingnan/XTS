/*
 *      SCCS:  @(#)remkill.c	1.9 (96/11/04) 
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

SCCS:   	@(#)remkill.c	1.9 96/11/04 TETware release 3.3
NAME:		remkill.c
PRODUCT:	TETware
AUTHOR:		Andrew Dingwall, UniSoft Ltd.
DATE CREATED:	April 1992

SYNOPSIS:
	#include "tet_api.h"
	int tet_remkill(int remoteid);

DESCRIPTION:
	DTET API function

	terminate process started by tet_remexec()
	return 0 if successful or -1 on error

MODIFICATIONS:
	Andrew Dingwall, UniSoft Ltd., December 1993
	changed dapi.h to dtet2/tet_api.h

	Geoff Clare, UniSoft Ltd., July 1996
	Changes for TETWare.

	Geoff Clare, UniSoft Ltd., Sept 1996
	Changes for TETWare-Lite.

************************************************************************/

#ifndef TET_LITE /* -START-LITE-CUT- */

#include <signal.h>
#include <errno.h>
#include "dtmac.h"
#include "tet_api.h"
#include "dtmsg.h"
#include "ptab.h"
#include "rtab.h"
#include "valmsg.h"
#include "servlib.h"

int tet_remkill(remoteid)
int remoteid;
{
	register struct rtab *rp;

	/* see if the process was started by tet_remexec(),
		and has not aready been waited for */
	if ((rp = tet_rtfind(remoteid)) == (struct rtab *) 0 ||
		rp->rt_pid < 0L) {
			errno = EINVAL;
			tet_errno = TET_ER_INVAL;
			return(-1);
	}

	/* do the remote kill operation and handle the reply code */
	if (tet_tckill(rp->rt_sysid, rp->rt_pid, SIGTERM) < 0) {
		switch (tet_tcerrno) {
		case ER_PID:
			errno = EINVAL;
			break;
		default:
			errno = EIO;
			break;
		}
		tet_errno = -tet_tcerrno;
		return(-1);
	}

	return(0);
}

#else /* -END-LITE-CUT- */

/* avoid "empty" file */
int tet_remkill_not_supported;

#endif /* -LITE-CUT-LINE- */
