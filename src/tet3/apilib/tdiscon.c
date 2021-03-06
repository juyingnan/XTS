/*
 *      SCCS:  @(#)tdiscon.c	1.7 (98/08/28) 
 *
 * (C) Copyright 1994 UniSoft Ltd., London, England
 *
 * All rights reserved.  No part of this source code may be reproduced,
 * stored in a retrieval system, or transmitted, in any form or by any
 * means, electronic, mechanical, photocopying, recording or otherwise,
 * except as stated in the end-user licence agreement, without the prior
 * permission of the copyright owners.
 */

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

/************************************************************************

SCCS:   	@(#)tdiscon.c	1.7 98/08/28 TETware release 3.3
NAME:		tdiscon.c
PRODUCT:	TETware
AUTHOR:		Andrew Dingwall, UniSoft Ltd.
DATE CREATED:	December 1993

DESCRIPTION:
	tet_disconnect() must be called in a child process after a fork()
	If this is not done, chaos will break out if the parent and child
	perform overlapping server requests.

MODIFICATIONS:
	Geoff Clare, UniSoft Ltd., Sept 1996
	Changes for TETWare-Lite.

	Andrew Dingwall, UniSoft Ltd., July 1998
	Added support for shared API libraries.

	Aaron Plattner, April 2010
	Fixed warnings when compiled with GCC's -Wall option.

************************************************************************/

#ifndef TET_LITE /* -START-LITE-CUT- */

#include "dtmac.h"
#include "tet_api.h"
#include "dtmsg.h"
#include "ptab.h"
#include "tslib.h"
#include "apilib.h"


/*
**	tet_disconnect() - disconnect from all servers without first
**		logging off
**
**	this function should be called in a child TCM process after a fork()
**
**	the ptab information is retained and the server is unaware that
**	the calling process has called this function (because the server
**	doesn't tell the difference between parent and child)
*/

void tet_disconnect()
{
	register struct ptab *pp;
	extern struct ptab *tet_ptab;

	/* disconnect from TCCDs */
	for (pp = tet_ptab; pp; pp = pp->pt_next)
		tet_ts_disconnect(pp);

	/* disconnect from sync and xresd */
	tet_ts_disconnect(tet_sdptab);
	tet_ts_disconnect(tet_xdptab);
}

#else /* -END-LITE-CUT- */

/* avoid "empty" file */
int tet_tdiscon_not_needed;

#endif /* -LITE-CUT-LINE- */

