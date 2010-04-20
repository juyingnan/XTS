/*
 *      SCCS:  @(#)listn.c	1.9 (97/07/21) 
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

SCCS:   	@(#)listn.c	1.9 97/07/21 TETware release 3.3
NAME:		listn.c
PRODUCT:	TETware
AUTHOR:		Andrew Dingwall, UniSoft Ltd.
DATE CREATED:	April 1992

DESCRIPTION:
	function to listen on an INET socket

MODIFICATIONS:

	Aaron Plattner, April 2010
	Fixed warnings when compiled with GCC's -Wall option.

************************************************************************/

#include <errno.h>
#include <sys/types.h>
#  include <netinet/in.h>
#include "dtmac.h"
#include "error.h"
#include "ltoa.h"
#include "time.h"
#include "dtmsg.h"
#include "ptab.h"
#include "inetlib_in.h"


/*
**	tet_ts_listen() - arrange to listen on the incoming message socket
*/

void tet_ts_listen(sd)
SOCKET sd;
{
	TRACE2(tet_Tio, 4, "listen on sd %s", tet_i2a(sd));

	if (listen(sd, 10) == SOCKET_ERROR)
		fatal(SOCKET_ERRNO, "listen() failed on sd", tet_i2a(sd));
}

