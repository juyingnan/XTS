/*
Copyright (c) 2005 X.Org Foundation LLC

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
* $Header: /cvs/xtest/xtest/xts5/src/bin/mc/gccomps.c,v 1.1 2005-02-12 14:37:14 anderson Exp $
*
* Copyright (c) Applied Testing and Technology, Inc. 1995
* All Rights Reserved.
*
* Project: VSW5
*
* File: src/bin/mc/gccomps.c
*
* Description:
*       misc routines for mc utilities
*
* Modifications:
* $Log: gccomps.c,v $
* Revision 1.1  2005-02-12 14:37:14  anderson
* Initial revision
*
* Revision 8.0  1998/12/23 23:24:13  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:42:23  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:16:39  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:13:12  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:41:16  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:37:59  andy
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


#include	<stdio.h>
#include	<string.h>

#include	"mc.h"

static	struct	gclookup {
	char	*gccompname;
	char	*include;
} gclookup[] = {
	/*
	 * Note:  If there are gccompname's that are initial strings of others
	 * then they must be afterwards.
	 */
	{"function", "function"},
	{"plane-mask", "plane-mask"},
	{"foreground", "foreground"},
	{"background", "background"},
	{"line-width", "line-width"},
	{"line-style", "line-style"},
	{"cap-style", "cap-style"},
	{"join-style", "join-style"},
	{"fill-style", "fill-style"},
	{"fill-rule", "fill-rule"},
	{"arc-mode", "arc-mode"},
	{"tile-stipple-x-origin", "ts-x-origin"},
	{"tile-stipple-y-origin", "ts-y-origin"},
	{"ts-x-origin", "ts-x-origin"},
	{"ts-y-origin", "ts-y-origin"},
	{"tile", "tile"},
	{"stipple", "stipple"},
	{"font", "font"},
	{"subwindow-mode", "subwindow-mode"},
	{"graphics-exposures", "graphics-exposures"},
	{"clip-x-origin", "clip-x-origin"},
	{"clip-y-origin", "clip-y-origin"},
	{"clip-mask", "clip-mask"},
	{"dash-offset", "dash-offset"},
	{"dash-list", "dash-list"},
	{"dashes", "dash-list"},
};

#define	NGCCOMP	(sizeof(gclookup)/sizeof(struct gclookup))

gccomps(fp, buf)
FILE	*fp;
char	*buf;
{
struct	gclookup	*lp;
char	*cp;

	while (newline(fp, buf) != NULL && !SECSTART(buf)) {
		if (strncmp(buf, ".M", 2) != 0)
			continue;

		cp = buf+3;
		while (*cp && *cp == ' ' || *cp == '\t')
			cp++;

		for (lp = gclookup; lp < gclookup+NGCCOMP; lp++) {
			if (strncmp(cp, lp->gccompname, strlen(lp->gccompname)) == 0)
				break;
		}

		if (lp == gclookup+NGCCOMP) {
			err("");
			(void) fprintf(stderr, "Unrecognised gc component name %s\n", cp);
			errexit();
		}

		(void) sprintf(buf, "gc/%.9s.mc\n", lp->include);
		includefile(buf, buf);
	}
}
