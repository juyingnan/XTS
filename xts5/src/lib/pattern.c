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
* $Header: /cvs/xtest/xtest/xts5/src/lib/pattern.c,v 1.1 2005-02-12 14:37:15 anderson Exp $
*
* Copyright Applied Testing and Technology Inc. 1995
* All rights reserved
*
* Project: VSW5
*
* File:	vsw5/src/lib/pattern.c
*
* Description:
*	Pattern support routines
*
* Modifications:
* $Log: pattern.c,v $
* Revision 1.1  2005-02-12 14:37:15  anderson
* Initial revision
*
* Revision 8.0  1998/12/23 23:24:48  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:42:59  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:17:11  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:13:44  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.1  1996/01/25 01:57:14  andy
* Portability improvements from DEPLOY tools
*
* Revision 4.0  1995/12/15  08:42:50  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:40:12  andy
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
#include	"X11/Xlib.h"
#include	"X11/Xutil.h"
#include	"xtestlib.h"
#include	"pixval.h"

/*
 * Scribble on the drawable.  A series of vertical lines are drawn starting
 * at (0,0) then at (5,0) (10,0) etc.
 */
void
pattern(disp, d)
Display	*disp;
Drawable	d;
{
unsigned int 	width;
unsigned int 	height;
int 	x;
GC  	gc;

	gc = XCreateGC(disp, d, 0, (XGCValues*)0);
	XSetState(disp, gc, W_FG, W_BG, GXcopy, AllPlanes);

	getsize(disp, d, &width, &height);

	for (x = 0; x < width; x += 5)
		XDrawLine(disp, d, gc, x, 0, x, height);
	
	XFreeGC(disp, gc);
}

/*
 * Check that the pattern that is drawn in pattern() is unchanged.
 * This is done by direct pixel validation with GetImage.
 * If ap is non-NULL then validation is restricted to that area
 * with the origin the origin of the area.
 */
Status
checkpattern(disp, d, ap)
Display	*disp;
Drawable	d;
struct	area	*ap;
{
XImage	*imp;
int 	x, y;
unsigned long	pix;
struct	area	area;
	
	if (ap == (struct area *)0) {
		ap = &area;
		ap->x = ap->y = 0;
		getsize(disp, d, &ap->width, &ap->height);
	}

	imp = XGetImage(disp, d, ap->x, ap->y, ap->width, ap->height, AllPlanes, ZPixmap);
	if (imp == (XImage*)0) {
		report("Get Image failed in checkpattern()");
		return(False);
	}

	for (y = 0; y < ap->height; y++) {
		for (x = 0; x < ap->width; x++) {
			pix = XGetPixel(imp, x, y);
			if (pix != ((x%5 == 0)? W_FG: W_BG)) {
				report("Bad pixel in pattern at (%d, %d)", x, y);
				return(False);
			}
		}
	}
	return(True);
}
