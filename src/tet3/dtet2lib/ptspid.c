/*
 *      SCCS:  @(#)ptspid.c	1.6 (96/11/04) 
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

SCCS:   	@(#)ptspid.c	1.6 96/11/04 TETware release 3.3
NAME:		ptspid.c
PRODUCT:	TETware
AUTHOR:		Andrew Dingwall, UniSoft Ltd.
DATE CREATED:	April 1992

DESCRIPTION:
	process table search function

MODIFICATIONS:

	Aaron Plattner, April 2010
	Fixed warnings when compiled with GCC's -Wall option.

************************************************************************/

#ifndef TET_LITE	/* -START-LITE-CUT- */

#include <sys/types.h>
#include "dtmac.h"
#include "dtmsg.h"
#include "ptab.h"
#include "error.h"

/*
**	tet_getptbysyspid() - find a ptab element by sysid/pid
**		and return a pointer thereto
**
**	return (struct ptab *) 0 if not found
*/

struct ptab *tet_getptbysyspid(sysid, pid)
register int sysid;
register long pid;
{
	register struct ptab *pp;
	extern struct ptab *tet_ptab;

	for (pp = tet_ptab; pp; pp = pp->pt_next) {
		ASSERT(pp->pt_magic == PT_MAGIC);
		if (pp->ptr_sysid == sysid && pp->ptr_pid == pid)
			break;
	}

	return(pp);
}

#else /* -END-LITE-CUT- */

int tet_ptspid_c_not_empty;

#endif /* -LITE-CUT-LINE- */

