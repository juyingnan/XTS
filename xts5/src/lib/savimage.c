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
* $Header: /cvs/xtest/xtest/xts5/src/lib/savimage.c,v 1.1 2005-02-12 14:37:15 anderson Exp $
*
* Copyright Applied Testing and Technology Inc. 1995
* All rights reserved
*
* Project: VSW5
*
* File:	vsw5/src/lib/savimage.c
*
* Description:
*	Image support routines
*
* Modifications:
* $Log: savimage.c,v $
* Revision 1.1  2005-02-12 14:37:15  anderson
* Initial revision
*
* Revision 8.0  1998/12/23 23:24:50  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:43:02  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:17:13  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:13:46  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.1  1996/01/25 01:57:14  andy
* Portability improvements from DEPLOY tools
*
* Revision 4.0  1995/12/15  08:42:58  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:40:22  andy
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


#include	"stdio.h"
#include	"xtest.h"
#include	"X11/Xlib.h"
#include	"X11/Xutil.h"
#include	"xtestlib.h"
#include	"pixval.h"

extern	int 	Errnum;	/* Number of error record */

/*
 * Save an image of the drawable.  Basically this is just a XGetImage
 * on the whole area of the drawable.
 */
XImage *
savimage(disp, d)
Display	*disp;
Drawable	d;
{
unsigned int 	width;
unsigned int 	height;
XImage	*imp;

	getsize(disp, d, &width, &height);
	imp = XGetImage(disp, d, 0, 0, width, height, AllPlanes, ZPixmap);

	regid(disp, (union regtypes *)&imp, REG_IMAGE);

	return(imp);
}


/*
 * Compare an image to what is currently on the drawable.
 * This is common code for the routines compsavimage() and diffsavimage().
 */
static Status
compsavcommon(disp, d, im, diff)
Display	*disp;
Drawable d;
XImage	*im;
int 	diff;	/* True if difference expected */
{
XImage	*newim;
int 	x, y;
unsigned int 	width, height;
unsigned long	pix1, pix2;

	getsize(disp, d, &width, &height);
	newim =  XGetImage(disp, d, 0, 0, width, height, AllPlanes, ZPixmap);
	if (newim == (XImage*)0) {
		delete("XGetImage failed");
		return(False);
	}

	for (y = 0; y < height; y++) {
		for (x = 0; x < width; x++) {
			pix1 = XGetPixel(im, x, y);
			pix2 = XGetPixel(newim, x, y);

			if (pix1 != pix2) {
				if (!diff) {
					char	name[32];

					/*
					 * A difference was not expected so dump out expected
					 * and obtained images.
					 */
					report("Pixel mismatch at (%d, %d) (%d - %d)"
						, x, y, pix1, pix2);
					sprintf(name, "Err%04d.err", Errnum++);
					report("See file %s for details", name);
					(void) unlink(name);
					dumpimage(newim, name, (struct area *)0);
					dumpimage(im, name, (struct area *)0);
					XDestroyImage(newim);
				}
				return(False);
			}
		}
	}
	XDestroyImage(newim);
	return(True);
}

Status
compsavimage(disp, d, im)
Display	*disp;
Drawable d;
XImage	*im;
{
	return compsavcommon(disp, d, im, 0);
}

Status
diffsavimage(disp, d, im)
Display	*disp;
Drawable d;
XImage	*im;
{
	return compsavcommon(disp, d, im, 1);
}

