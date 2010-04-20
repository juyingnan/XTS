/*
 *	SCCS: @(#)fake_xt.c	1.2 (96/11/04)
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

SCCS:   	@(#)fake_xt.c	1.2 96/11/04 TETware release 3.3
NAME:		fake_xt.c
PRODUCT:	TETware
AUTHOR:		Geoff Clare, UniSoft Ltd.
DATE CREATED:	October 1996

DESCRIPTION:
	dummy functions referenced by the XTI transport/specific code

MODIFICATIONS:

	Aaron Plattner, April 2010
	Fixed warnings when compiled with GCC's -Wall option.

************************************************************************/

#include <sys/types.h>
#include "dtmac.h"
#include "error.h"
#include "dtmsg.h"
#include "ptab.h"
#include "server_xt.h"

/* tcc does not listen for or accept incoming connections */
int tet_listen_fd = -1;

void tet_ss_tsaccept()
{
	error(0, "internal error - tet_ss_tsaccept called!", (char *) 0);
}

