/*
 *      SCCS:  @(#)madir.c	1.9 (96/11/04) 
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

SCCS:   	@(#)madir.c	1.9 96/11/04 TETware release 3.3
NAME:		madir.c
PRODUCT:	TETware
AUTHOR:		Andrew Dingwall, UniSoft Ltd.
DATE CREATED:	June 1992

DESCRIPTION:
	recursive directory creation function

MODIFICATIONS:

	Aaron Plattner, April 2010
	Fixed warnings when compiled with GCC's -Wall option.

************************************************************************/

#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/stat.h>
#include "dtmac.h"
#include "error.h"
#include "dtetlib.h"

/* mode for created directories */
#define MODEANY		((mode_t) (S_IRWXU | S_IRWXG | S_IRWXO))

/* static function declarations */
static int mkad2 PROTOLIST((char *));


/*
**	tet_mkalldirs() - make directories as necessary in a directory path
**
**	return 0 if successful, -1 otherwise
*/

int tet_mkalldirs(path)
char *path;
{
	register int rc;
	struct STAT_ST stbuf;
	char buf[MAXPATH + 1];

	if (STAT(path, &stbuf) < 0) {
		if (errno == ENOENT) {
			sprintf(buf, "%.*s", (int)sizeof buf - 1, path);
			rc = mkad2(buf);
		}
		else {
			error(errno, "can't stat", path);
			rc = -1;
		}
	}
	else
		rc = 0;

	return(rc);
}

/*
**	mkad2() - make directories as necessary when the last component in the
**	path is known not to exist
**
**	return 0 if successful, -1 otherwise
*/

static int mkad2(path)
char *path;
{
	register char *p;
	register int rc;
	struct STAT_ST stbuf;
	int errsave;

	ASSERT(*path);

	/* find the last / character (if any) */
	for (p = path + strlen(path) - 1; p >= path; p--)
		if (isdirsep(*p))
			break;

	/* if found:
		replace it with a \0 
		if the parent directory does not exist, create that as well
		restore the / */
	if (p > path) {
		*p = '\0';
		if (STAT(path, &stbuf) < 0)
			rc = mkad2(path);
		else if (!S_ISDIR(stbuf.st_mode)) {
			error(ENOTDIR, path, (char *) 0);
			rc = -1;
		}
		else
			rc = 0;
		*p = '/';
		if (rc < 0)
			return(rc);
	}

	/* finally, create the directory on this level */
	if ((rc = tet_mkdir(path, MODEANY)) < 0) {
		errsave = errno;
		error(errno, "can't make directory", path);
		errno = errsave;
	}

	return(rc);
}

