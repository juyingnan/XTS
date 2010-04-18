/*
 *      SCCS:  @(#)listn.c	1.7 (98/09/01)
 *
 *	UniSoft Ltd., London, England
 *
 * (C) Copyright 1993 X/Open Company Limited
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

SCCS:   	@(#)listn.c	1.7 (98/09/01) TETware release 3.3
NAME:		listn.c
PRODUCT:	TETware
AUTHOR:		Denis McConalogue, UniSoft Ltd.
DATE CREATED:	April 1993 

DESCRIPTION:
	function to initialise the connecion indication array prior to t_listen

MODIFICATIONS:

	Andrew Dingwall, UniSoft Ltd., July 1998
	Added support for shared API libraries.
 
************************************************************************/

#include <errno.h>
#include <sys/types.h>
#include <xti.h>
#include "dtmac.h"
#include "dtmsg.h"
#include "ptab.h"
#include "error.h"
#include "ltoa.h"
#include "xtilib_xt.h"

#ifdef NEEDsrcFile
static char srcFile[] = __FILE__;	/* file name for error reporting */
#endif


/*
**	tet_ts_listen() - clear the connection indication array prior to
**		t_listen
**
*/

/* ARGSUSED */
void tet_ts_listen(fd)
int fd;
{
	int i;

	for (i=0; i < MAX_CONN_IND; i++)
		tet_calls[i] = (struct t_call *)0;

	return;
}

