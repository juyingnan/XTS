/*
Copyright (c) 2005 X.Org Foundation L.L.C.

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/
/*
* $Header: /cvs/xtest/xtest/xts5/src/libproto/linkstart.c,v 1.2 2005-11-03 08:42:02 jmichael Exp $
*
* Copyright Applied Testing and Technology Inc. 1995
* All rights reserved
*
* Project: VSW5
*
* File:	xts5/src/libproto/linkstart.c
*
* Description:
*	Protocol test support routines
*
* Modifications:
* $Log: linkstart.c,v $
* Revision 1.2  2005-11-03 08:42:02  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:12  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:25:18  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:43:32  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:17:39  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:14:11  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:44:26  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:42:09  andy
* Prepare for GA Release
*
*/

/*
Portions of this software are based on Xlib and X Protocol Test Suite.
We have used this material under the terms of its copyright, which grants
free use, subject to the conditions below.  Note however that those
portions of this software that are based on the original Test Suite have
been significantly revised and that all such revisions are copyright (c)
1995 Applied Testing and Technology, Inc.  Insomuch as the proprietary
revisions cannot be separated from the freely copyable material, the net
result is that use of this software is governed by the ApTest copyright.

Copyright (c) 1990, 1991  X Consortium

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
X CONSORTIUM BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

Except as contained in this notice, the name of the X Consortium shall not be
used in advertising or otherwise to promote the sale, use or other dealings
in this Software without prior written authorization from the X Consortium.

Copyright 1990, 1991 by UniSoft Group Limited.

Permission to use, copy, modify, distribute, and sell this software and
its documentation for any purpose is hereby granted without fee,
provided that the above copyright notice appear in all copies and that
both that copyright notice and this permission notice appear in
supporting documentation, and that the name of UniSoft not be
used in advertising or publicity pertaining to distribution of the
software without specific, written prior permission.  UniSoft
makes no representations about the suitability of this software for any
purpose.  It is provided "as is" without express or implied warranty.
*/

#include	"xtest.h"
#include	"tet_api.h"
#include "stdlib.h"
#include	<stdio.h>
#include	<string.h>

#define MAXTPS	1000
#define TLI	nullfn,1
#define TLI10	TLI, TLI, TLI, TLI, TLI, TLI, TLI, TLI, TLI, TLI
#define TLI50	TLI10, TLI10, TLI10, TLI10, TLI10

static void
nullfn()
{
	return;
}

/*
 * Define the TET interface variables here.  This module will be
 * brought into the executable by the references to these variables.
 */
int 	tet_thistest;

struct	tet_testlist tet_testlist[MAXTPS+1] = {
	TLI50, TLI50, TLI50, TLI50, TLI50,
	TLI50, TLI50, TLI50, TLI50, TLI50,
	TLI50, TLI50, TLI50, TLI50, TLI50,
	TLI50, TLI50, TLI50, TLI50, TLI50,
	NULL, 0 };

void	linkstart();
void	linkclean();

void 	(*tet_startup)() = linkstart;
void 	(*tet_cleanup)() = linkclean;

char	*TestName;
int 	ntests;

extern	char	*tet_pname;

extern	struct	linkinfo	*linktbl[];

/*
 * The startup routine for the linked executables case.  We have
 * to make some assumptions about the TET that are not officialy in
 * the spec.
 *   - It is valid to change the contents of tet_testlist[] in the
 *     startup routine.
 * 
 * Get the name of the routine and set up the interface to
 * point to the tests for that routine.
 */
void
linkstart()
{
struct	linkinfo	*lp;
struct	linkinfo	**lpp;
struct	tet_testlist *tlp;
char	*name;
int 	i;

	lp = (struct linkinfo *)0;

	/*
	 * Get the basename part of tet_pname.
	 */
	name = strrchr(tet_pname, '/');
	if (name)
		name++;
	else
		name = tet_pname;

	for (lpp = linktbl; *lpp; lpp++) {
		if (strcmp((*lpp)->name, name) == 0) {
			lp = *lpp;
			break;
		}
	}

	if (lp == (struct linkinfo *)0) {
		/*
		 * If this happens if probably means that the executable
		 * has been built incorrectly.
		 */
		report("Name (%s) not found in link table, aborting test\n", name);
		fprintf(stderr, "Name (%s) not found in link table, aborting test\n", name);
		exit(EXIT_FAILURE);
	}

	TestName = lp->testname;
	ntests   = *lp->ntests;

	tlp = lp->testlist;
	for (i = 0; tlp[i].testfunc != 0; i++) {
		tet_testlist[i] = tlp[i];
	}
	/* Copy the final null entry */
	tet_testlist[i] = tlp[i];

	if (lp->localstartup)
		(*lp->localstartup)();
	else
		protostartup();

}

/*
 * Cleanup function for linked executables.
 */
void
linkclean()
{
struct	linkinfo	*lp;
struct	linkinfo	**lpp;
char 	*name;

	lp = (struct linkinfo *)0;

	/*
	 * Get the basename part of tet_pname.
	 */
	name = strrchr(tet_pname, '/');
	if (name)
		name++;
	else
		name = tet_pname;

	for (lpp = linktbl; *lpp; lpp++) {
		if (strcmp((*lpp)->name, name) == 0) {
			lp = *lpp;
			break;
		}
	}

	if (lp == (struct linkinfo *)0) {
		/*
		 * If this happens here, something has gone VERY BADLY WRONG
		 * and I'm not certain what we can do about it.
		 */
		report("Name (%s) not found in link table in linkclean!\n", name);
		fprintf(stderr, "Name (%s) not found in link table in linkclean!\n", name);
		exit(EXIT_FAILURE);
	}

	if (lp->localcleanup)
		(*lp->localcleanup)();
	else
		protocleanup();
}
