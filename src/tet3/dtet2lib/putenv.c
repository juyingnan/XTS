/*
 *      SCCS:  @(#)putenv.c	1.9 (97/07/28) 
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

SCCS:   	@(#)putenv.c	1.9 97/07/28 TETware release 3.3
NAME:		putenv.c
PRODUCT:	TETware
AUTHOR:		Andrew Dingwall, UniSoft Ltd.
DATE CREATED:	April 1992

DESCRIPTION:
	environment manipulation function

MODIFICATIONS:
	Andrew Dingwall, UniSoft Ltd., February 1993
	allow user to modify environment between calls

	Andrew Dingwall, UniSoft Ltd., July 1997
	added support the MT DLL version of the C runtime support library
	on Win32 systems

	Aaron Plattner, April 2010
	Fixed warnings when compiled with GCC's -Wall option.

************************************************************************/

#include <stdio.h>
#include "dtmac.h"
#include "dtetlib.h"

/*
**	tet_putenv() - add an environment string to the environment
**
**	return 0 if successful or -1 on error
**
**	this routine is here because not all systems have putenv(3)
*/

int tet_putenv(s)
char *s;
{

	static char **env;
	static int envlen;
	register char *p1, *p2;
	register char **ep1, **ep2;
	extern char **environ;

	/* see if the 'name' part is already in the environment
		if so, make the ptr refer to the new string */
	for (ep1 = environ; *ep1; ep1++) {
		for (p1 = *ep1, p2 = s; *p1 && *p2; p1++, p2++)
			if (*p1 != *p2 || *p1 == '=')
				break;
		if (*p1 == '=' && *p2 == '=') {
			*ep1 = s;
			return(0);
		}
	}

	/* not there so:
		see if we have been here before -
		make ep2 point to the old environment space (if any);
		allocate a new environment space */
	ep2 = env;
	if (BUFCHK((char **) &env, &envlen, (int) (((ep1 - environ) + 2) * sizeof *env)) < 0)
		return(-1);

	/* now make ep2 point to the end of the new environment,
		copy in the old environment if env did not previously
		refer to it */
	if (ep2 && ep2 == environ)
		ep2 = env + (ep1 - environ);
	else
		for (ep1 = environ, ep2 = env; *ep1; ep1++, ep2++)
			*ep2 = *ep1;

	/* add the new string to the end of the new environment */
	*ep2++ = s;
	*ep2 = (char *) 0;
	environ = env;

	return(0);


}

