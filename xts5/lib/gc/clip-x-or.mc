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
$Header: /cvs/xtest/xtest/xts5/lib/gc/clip-x-or.mc,v 1.1 2005-02-12 14:37:14 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1995
All Rights Reserved.

>>#
>># Project: VSW5
>>#
>># File: tset/lib/gc/clip-x-or.mc
>>#
>># Description:
>>#     Predefined Xlib test
>>#
>># Modifications:
>># $Log: clip-x-or.mc,v $
>># Revision 1.1  2005-02-12 14:37:14  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:23:50  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:41:57  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:16:19  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:12:51  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 08:40:19  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  00:36:53  andy
>># Prepare for GA Release
>>#
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
>># This file does both the x and y clip-mask origin components.
>>#
>>ASSERTION Good A
The clip origin coordinates
.M clip-x-origin
and
.M clip-y-origin
are interpreted relative to the
origin of the destination drawable specified in the graphics
operation.
>>STRATEGY
Create Pixmap and set clip-mask with it.
Vary clip origin
Verify nothing is drawn outside the clip_mask based on the origin.
Pixmap verify results inside the cliparea.
>>CODE
XVisualInfo	*vp;
Pixmap	cmopixmap;
struct	area	area;
unsigned int 	cmowidth;
unsigned int 	cmoheight;
int 	divsize;
int 	i, j;

	divsize = 3;

	for (resetvinf(VI_WIN_PIX); nextvinf(&vp); ) {
#ifdef A_DRAWABLE2
		winpair(A_DISPLAY, vp, &A_DRAWABLE, &A_DRAWABLE2);
#if T_XCopyPlane
		dset(A_DISPLAY, A_DRAWABLE, ~0L);
#else
		dset(A_DISPLAY, A_DRAWABLE, W_FG);
#endif
#else
		A_DRAW = makewin(A_DISPLAY, vp);
#endif
		A_GC = makegc(A_DISPLAY, A_DRAW);
#ifdef A_IMAGE
		A_IMAGE = makeimg(A_DISPLAY, vp, ZPixmap);
		dsetimg(A_IMAGE, W_FG);
#endif

		/*
		 * Get size of the pixmap.  It is divsize smaller on all sides
		 * than the window.
		 */
		getsize(A_DISPLAY, A_DRAW, &cmowidth, &cmoheight);
		cmowidth /= divsize;
		cmoheight /= divsize;
		debug(2, "clip-mask height=%d, width=%d", cmowidth, cmoheight);

		/*
		 * Create a pixmap that is about divsize^2 of the area of
		 * the window.
		 */
		cmopixmap = XCreatePixmap(A_DISPLAY, A_DRAW, cmowidth, cmoheight, 1);
		dset(A_DISPLAY, cmopixmap, 1L);

		XSetClipMask(A_DISPLAY, A_GC, cmopixmap);
		XFreePixmap(A_DISPLAY, cmopixmap);

		for (i = 0; i < divsize; i++) {
			for (j = 0; j < divsize; j++) {
				setarea(&area, i*cmowidth, j*cmoheight, cmowidth, cmoheight);
				debug(2, "Origin at (%d,%d)", area.x, area.y);
				XSetClipOrigin(A_DISPLAY, A_GC, area.x, area.y);
				XCALL;
				if (checkarea(A_DISPLAY,A_DRAW,&area,W_BG,W_BG,CHECK_OUT))
					CHECK;
				else {
					report("Drawing occurred outside clip_mask");
					FAIL;
				}
				PIXCHECK(A_DISPLAY, A_DRAW);
				dclear(A_DISPLAY, A_DRAW);
			}
		}
	}

	CHECKPASS(2*divsize*divsize*nvinf());

