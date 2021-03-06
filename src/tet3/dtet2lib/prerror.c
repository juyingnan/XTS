/*
 *      SCCS:  @(#)prerror.c	1.9 (98/08/28) 
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

SCCS:   	@(#)prerror.c	1.9 98/08/28 TETware release 3.3
NAME:		prerror.c
PRODUCT:	TETware
AUTHOR:		Andrew Dingwall, UniSoft Ltd.
DATE CREATED:	April 1992

DESCRIPTION:
	error message formatting and printing function

MODIFICATIONS:
	Andrew Dingwall, UniSoft Ltd., July 1997
	added support the MT DLL version of the C runtime support library
	on Win32 systems

	Andrew Dingwall, UniSoft Ltd., March 1998
	replaced references to sys_errlist[] and sys_nerr with
	a call to strerror()

	Andrew Dingwall, UniSoft Ltd., July 1998
	Added support for shared API libraries.

	Aaron Plattner, April 2010
	Fixed warnings when compiled with GCC's -Wall option.

************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>
#ifndef TET_LITE	/* -START-LITE-CUT- */
#endif /* !TET_LITE */	/* -END-LITE-CUT- */
#include "dtmac.h"
#include "dtetlib.h"

/*
**	tet_prerror() - format and print an error message
*/

void tet_prerror(FILE *fp, int errnum, const char *hdr, const char *file,
                 int line, const char *s1, const char *s2)
{
	const char *s3, *s4;

	fprintf(fp, "%s (%s, %d): %s",
		hdr, tet_basename(file), line, s1);
	if (s2 && *s2)
		fprintf(fp, " %s", s2);
	if (errnum > 0) {
		s3 = ":";
			if ((s4 = strerror(errnum)) == (char *) 0) {
				s3 = ", errno =";
				s4 = tet_errname(errnum);
			}
		fprintf(fp, "%s %s", s3, s4);
	}
	putc('\n', fp);
	fflush(fp);

	errno = 0;
}
