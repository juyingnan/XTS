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
* $Header: /cvs/xtest/xtest/xts5/src/lib/checkimg.c,v 1.1 2005-02-12 14:37:15 anderson Exp $
*
* Copyright Applied Testing and Technology Inc. 1995
* All rights reserved
*
* Project: VSW5
*
* File:	vsw5/src/lib/checkimg.c
*
* Description:
*	Image support routines
*
* Modifications:
* $Log: checkimg.c,v $
* Revision 1.1  2005-02-12 14:37:15  anderson
* Initial revision
*
* Revision 8.0  1998/12/23 23:24:28  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:42:39  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:16:53  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:13:26  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.1  1996/01/25 01:57:14  andy
* Portability improvements from DEPLOY tools
*
* Revision 4.0  1995/12/15  08:41:59  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:39:07  andy
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
 * Check that each pixel within the specified area is set to
 * inpix and that each pixel outside the area is set to outpix.
 * If flags are CHECK_IN only the inside is checked.
 * If flags are CHECK_OUT only the outside is checked.
 * flags of 0 or CHECK_ALL check both.
 * If ap is NULL then the whole image is checked.
 */
Status
checkimg(im, ap, inpix, outpix, flags)
XImage *im;
struct area *ap;
long inpix;
long outpix;
int flags;
{
register int x, y;
int xorig;
int yorig;
unsigned int fullwidth;
unsigned int fullheight;
register unsigned long pix;
struct area area;
int inloopflag = 0;

	if (flags == 0)
		flags = CHECK_ALL;
	if ((flags & CHECK_ALL) == 0) {
		report("assert error in checkimg()");
		printf("assert error in checkimg()\n");
		exit(1);
	}

	fullwidth = im->width;
	fullheight = im->height;

	/*
	 * If a NULL ap has been given then check the whole image.
	 */
	if (ap == (struct area *)0) {
		ap = &area;
		ap->x = 0;
		ap->y = 0;
		ap->width = fullwidth;
		ap->height = fullheight;
		flags = CHECK_IN;
	}

	if ((flags & CHECK_ALL) == CHECK_IN) {
		xorig = ap->x;
		yorig = ap->y;
		fullwidth = ap->width;
		fullheight = ap->height;
	} else {
		xorig = 0;
		yorig = 0;
	}

	for (y = 0; y < fullheight; y++) {
		for (x = 0; x < fullwidth; x++) {
			inloopflag = 1;
			pix = XGetPixel(im, x, y);
			if (x+xorig >= ap->x && x+xorig < ap->x+ap->width && y+yorig >= ap->y && y+yorig < ap->y+ap->height) {
				if (pix != inpix && (flags & CHECK_IN)) {
					report("Incorrect pixel on inside of area at point (%d, %d): 0x%x != 0x%x",
						x, y, pix, inpix);
					return(False);
				}
			} else {
				if (pix != outpix && (flags & CHECK_OUT)) {
					report("Incorrect pixel on outside of area at point (%d, %d): 0x%x != 0x%x",
					x, y, pix, outpix);
					return(False);
				}
			}
		}
	}

	/* This is to catch bugs */
	if (inloopflag == 0) {
		delete("No pixels checked in checkimg - internal error");
		return(False);
	}
	return(True);
}

/*
 * checkimgstruct() -	verify width, height, and format fields
 *			of an image structure
 */
Status
checkimgstruct(im, depth, width, height, format)
XImage *im;
unsigned int depth;
unsigned int width;
unsigned int height;
int format;
{
	if (im->depth != depth) {
		report("Incorrect depth (%d != %d)", im->depth, depth);
		return(False);
	}
	if (im->width != width) {
		report("Incorrect width (%d != %d)", im->width, width);
		return(False);
	}
	if (im->height != height) {
		report("Incorrect height (%d != %d)", im->height, height);
		return(False);
	}
	if (im->format != format) {
		report("Incorrect format (%d != %d)", im->format, format);
		return(False);
	}
	return(True);
}
