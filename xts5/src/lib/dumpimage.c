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
* $Header: /cvs/xtest/xtest/xts5/src/lib/dumpimage.c,v 1.2 2005-11-03 08:42:01 jmichael Exp $
*
* Copyright Applied Testing and Technology Inc. 1995
* All rights reserved
*
* Project: VSW5
*
* File:	xts5/src/lib/dumpimage.c
*
* Description:
*	Dump an image
*
* Modifications:
* $Log: dumpimage.c,v $
* Revision 1.2  2005-11-03 08:42:01  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:09  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:24:32  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:42:43  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:16:57  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:13:30  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.1  1996/01/25 01:57:14  andy
* Portability improvements from DEPLOY tools
*
* Revision 4.0  1995/12/15  08:42:11  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:39:23  andy
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

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include	"stdio.h"
#include	"X11/Xlib.h"
#include	"X11/Xutil.h"
#include	"xtestlib.h"
#include	"pixval.h"

/*
 * Dump out an image to the given file name.  A ascii form is used
 * with a simple run length encoding.
 */
/*ARGSUSED2*/
void
dumpimage(imp, name, ap)
XImage	*imp;
char	*name;
struct	area	*ap;	/* NOTUSED yet */
{
FILE	*fp;
int 	x, y;
unsigned long	pix, lastpix = 0L; /* Initialise just to keep lint quiet */
unsigned long 	count;
extern	int 	tet_thistest;
static	int 	lasttest;

	fp = fopen(name, (lasttest==tet_thistest)? "a": "w");
	if (fp == NULL) {
		report("Could not create image file %s", name);
		return;
	}
	lasttest = tet_thistest;

	fprintf(fp, "%d %d %d\n", imp->width, imp->height, imp->depth);

	count = 0;
	for (y = 0; y < imp->height; y++) {
		for (x = 0; x < imp->width; x++) {
			pix = XGetPixel(imp, x, y);
			/* count is 0 on the first time through */
			if (pix != lastpix || count == 0) {
				if (count == 1) {
					fprintf(fp, "%x\n", lastpix);
				} else if (count != 0) {
					fprintf(fp, "%x,%x\n", count, lastpix);
				}
				lastpix = pix;
				count = 1;
			} else {
				count++;
			}
		}
	}
	if (count == 1) {
		fprintf(fp, "%x\n", lastpix);
	} else if (count != 0) {
		fprintf(fp, "%x,%x\n", count, lastpix);
	}
	fclose(fp);
}

