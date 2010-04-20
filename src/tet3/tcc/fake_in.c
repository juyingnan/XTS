/*
 *	SCCS: @(#)fake_in.c	1.4 (97/07/21)
 *
 *	UniSoft Ltd., London, England
 *
 * (C) Copyright 1996 X/Open Company Limited
 *
 * All rights reserved.  No part of this source code may be reproduced,
 * stored in a retrieval system, or transmitted, in any form or by any
 * means, electronic, mechanical, photocopying, recording or otherwise,
 * except as stated in the end-user licence agreement, without the prior
 * permission of the copyright owners.
 * A copy of the end-user licence agreement is contained in the file
 * Licence which accompanies this distribution.
 * 
 * X/Open and the 'X' symbol are trademarks of X/Open Company Limited in
 * the UK and other countries.
 */

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

/************************************************************************

SCCS:   	@(#)fake_in.c	1.4 97/07/21 TETware release 3.3
NAME:		fake_in.c
PRODUCT:	TETware
AUTHOR:		Andrew Dingwall, UniSoft Ltd.
DATE CREATED:	August 1996

DESCRIPTION:
	dummy functions referenced by the INET transport/specific code

MODIFICATIONS:

	Aaron Plattner, April 2010
	Fixed warnings when compiled with GCC's -Wall option.

************************************************************************/

#include <sys/types.h>
#include "dtmac.h"
#include "error.h"
#include "dtmsg.h"
#include "ptab.h"
#include "server_in.h"

/* tcc does not listen for or accept incoming connections */
SOCKET tet_listen_sd = INVALID_SOCKET;

void tet_ss_tsaccept()
{
	error(0, "internal error - tet_ss_tsaccept called!", (char *) 0);
}

