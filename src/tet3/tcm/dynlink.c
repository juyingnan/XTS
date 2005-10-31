/*
 *	SCCS: @(#)dynlink.c	1.1 (98/09/01)
 *
 *	UniSoft Ltd., London, England
 *
 * Copyright (c) 1998 The Open Group
 * All rights reserved.
 *
 * No part of this source code may be reproduced, stored in a retrieval
 * system, or transmitted, in any form or by any means, electronic,
 * mechanical, photocopying, recording or otherwise, except as stated
 * in the end-user licence agreement, without the prior permission of
 * the copyright owners.
 * A copy of the end-user licence agreement is contained in the file
 * Licence which accompanies this distribution.
 * 
 * Motif, OSF/1, UNIX and the "X" device are registered trademarks and
 * IT DialTone and The Open Group are trademarks of The Open Group in
 * the US and other countries.
 *
 * X/Open is a trademark of X/Open Company Limited in the UK and other
 * countries.
 *
 */

#ifndef lint
static char sccsid[] = "@(#)dynlink.c	1.1 (98/09/01) TET3 release 3.3";
#endif

/************************************************************************

SCCS:   	@(#)dynlink.c	1.1 98/09/01 TETware release 3.3
NAME:		dynlink.c
PRODUCT:	TETware
AUTHOR:		Andrew Dingwall, UniSoft Ltd.
DATE CREATED:	July 1998

DESCRIPTION:
	this is a simple dynamic linker for use when building a test case
	to use a shared API library on a Win32 system

	the dynamic linker is in two parts:

		tet_w32dynlink() resides in the main program
		tet_w32dlcheck() resides in the shared API library

	tet_w32dynlink() performs the dynamic linking
	tet_w32dlcheck() ensures that none of the pointers have been missed

	see the comment in dtmac.h for an overview of how this works


	no calls to TETware library functions are allowed from this file

MODIFICATIONS:

************************************************************************/

/* TET_SHLIB_SOURCE implies TET_SHLIB */
#if defined(TET_SHLIB_SOURCE) && !defined(TET_SHLIB)
#  define TET_SHLIB
#endif


int tet_dynlink_c_not_used;


