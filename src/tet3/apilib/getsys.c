/*
 *      SCCS:  @(#)getsys.c	1.12 (98/08/28) 
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

SCCS:   	@(#)getsys.c	1.12 98/08/28 TETware release 3.3
NAME:		getsys.c
PRODUCT:	TETware
AUTHOR:		Andrew Dingwall, UniSoft Ltd.
DATE CREATED:	April 1992

SYNOPSIS:
	#include "tet_api.h"
	int tet_remgetsys(void);

DESCRIPTION:
	DTET API function

	Tet_remgetsys() returns the (numeric) system name of the local
	system.  The TETware-Lite version always returns zero.

MODIFICATIONS:
	Andrew Dingwall, UniSoft Ltd., December 1993
	changed dapi.h to dtet2/tet_api.h

	Geoff Clare, UniSoft Ltd., July 1996
	Changes for TETWare.

	Geoff Clare, UniSoft Ltd., Sept 1996
	Changes for TETWare-Lite.

	Andrew Dingwall, UniSoft Ltd., July 1998
	Added support for shared API libraries.
	Moved tet_getsysbyid() to a separate file.

	Aaron Plattner, April 2010
	Fixed warnings when compiled with GCC's -Wall option.

************************************************************************/

#include "dtmac.h"
#include "globals.h"
#include "tet_api.h"

TET_IMPORT int tet_remgetsys()
{
#ifndef TET_LITE /* -START-LITE-CUT- */
	return(tet_mysysid);
#else /* -END-LITE-CUT- */
	return(0);
#endif /* -LITE-CUT-LINE- */
}

