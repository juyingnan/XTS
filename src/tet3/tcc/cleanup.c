/*
 *	SCCS: @(#)cleanup.c	1.5 (96/11/04)
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

#ifndef lint
static char sccsid[] = "@(#)cleanup.c	1.5 (96/11/04) TET3 release 3.3";
#endif

/************************************************************************

SCCS:   	@(#)cleanup.c	1.5 96/11/04 TETware release 3.3
NAME:		cleanup.c
PRODUCT:	TETware
AUTHOR:		Andrew Dingwall, UniSoft Ltd.
DATE CREATED:	August 1996

DESCRIPTION:
	tcc exit function

MODIFICATIONS:

************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <sys/types.h>
#include "dtmac.h"
#include "tcc.h"
#include "tet_api.h"

#ifndef NOTRACE
#include "ltoa.h"
#endif


#ifdef NEEDsrcFile
static char srcFile[] = __FILE__;	/* file name for error reporting */
#endif


/*
**	tcc_exit() - clean up and exit
*/

void tcc_exit(status)
int status;
{
	static int been_here;

	TRACE2(tet_Ttcc, 1, "tcc_exit(): status = %s", tet_i2a(status));

	/*
	** guard against recursive calls; e.g., because one of the
	** functions called here itself calls the fatal error handler
	*/
	if (been_here++)
		exit(status);

	/* shut down the execution engine if it is running */
	engine_shutdown();

	/* remove temporary files */
	rescode_cleanup();
	config_cleanup();

	/* emit the end line to the journal */
	if (jnl_usable())
		jnl_tcc_end();

	/* log off servers, close connections and exit */
	tet_exit(status);
}

