/*
 *      SCCS:  @(#)nbio.c	1.7 (97/07/21) 
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

SCCS:   	@(#)nbio.c	1.7 97/07/21 TETware release 3.3
NAME:		nbio.c
PRODUCT:	TETware
AUTHOR:		Andrew Dingwall, UniSoft Ltd.
DATE CREATED:	April 1992

DESCRIPTION:
	function to establish non-blocking i/o on an INET socket

MODIFICATIONS:
	Andrew Dingwall, UniSoft Ltd., February 1994
	moved the ioctl() call from dtet2lib/fionbio.c to here
	(this is to make dtet2lib POSIX-clean)

************************************************************************/

#include <sys/types.h>
#  include <netinet/in.h>
#  ifdef SVR4
#    include <sys/filio.h>
#  else
#    include <sys/ioctl.h>
#  endif /* SVR4 */
#include <errno.h>
#include "dtmac.h"
#include "dtmsg.h"
#include "ptab.h"
#include "tptab_in.h"
#include "inetlib_in.h"
#include "ltoa.h"
#include "error.h"

/*
**	tet_ts_nbio() - establish non-blocking i/o on a socket
**
**	return 0 if successful or -1 on error
*/

int tet_ts_nbio(pp)
register struct ptab *pp;
{
	register SOCKET sd = ((struct tptab *) pp->pt_tdata)->tp_sd;
	int arg;

	arg = 1;
	if (SOCKET_IOCTL(sd, FIONBIO, &arg) == SOCKET_ERROR) {
		error(SOCKET_ERRNO, "ioctl(FIONBIO) failed on sd",
			tet_i2a(sd));
		return(-1);
	}

	pp->pt_flags |= PF_NBIO;
	return(0);
}

