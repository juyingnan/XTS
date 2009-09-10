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
$Header: /cvs/xtest/xtest/xts5/tset/Xlib17/XGetPixel/XGetPixel.m,v 1.3 2005-11-03 08:43:04 jmichael Exp $

Copyright (c) 2004 The Open Group
Copyright (c) Applied Testing and Technology, Inc. 1995
All Rights Reserved.

>># Project: VSW5
>># 
>># File: xts5/tset/Xlib17/XGetPixel/XGetPixel.m
>># 
>># Description:
>># 	Tests for XGetPixel()
>># 
>># Modifications:
>># $Log: gtpxl.m,v $
>># Revision 1.3  2005-11-03 08:43:04  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.2  2005/04/21 09:40:42  ajosey
>># resync to VSW5.1.5
>>#
>># Revision 8.2  2005/01/14 12:03:49  gwc
>># Updated copyright notice
>>#
>># Revision 8.1  2004/02/12 12:40:33  gwc
>># Fixed uses of 1<<depth to handle depth 32
>>#
>># Revision 8.0  1998/12/23 23:34:39  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:57:01  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:25:57  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:22:30  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:11:08  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:13:41  andy
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
>>TITLE XGetPixel Xlib17
unsigned long
XGetPixel(ximage, x, y)
XImage	*ximage;
int	x;
int	y;
>>ASSERTION Good A
When the image
.A ximage
contains coordinates
.A x, y ,
then a call to xname returns the normalised value of the pixel located at
.A x, y
in the image.
>>STRATEGY
For all supported drawables:
   Create a drawable.
   For a range of pixel values over the drawable's depth:
      Set a pixel in the drawable using XDrawPoint.
      For XYPixmap and ZPixmap:
         Obtain an XImage using XGetImage.
         Obtain the pixel value using xname.
         Verify that the values are the same.
>>CODE
XVisualInfo	*vi;
GC		gc;
int		npix;
Pixmap		pm;
Window		win;
int		i;
int		j;
unsigned long	pixel;
unsigned long	rpixel;
unsigned long	mask;
static int	fmats[2] = { XYPixmap, ZPixmap };

	x = 2;
	y = 1;

	for(resetvinf(VI_PIX); nextvinf(&vi);) {

		pm = makepixm(Dsp, vi);
		gc = makegc(Dsp, pm);
		if (vi->depth < 32)
			mask = (1UL<<vi->depth) - 1;
		else
			mask = 0xffffffffUL;
		for(i = 0; i <= (15 & mask); i++) {
			pixel =  mask & (i | i<<4 | i<<12 | i<<20);
			XSetForeground(Dsp, gc, pixel);
			XDrawPoint(Dsp, pm, gc, x+1, y+2);

			for(j=0; j<2; j++) {
				ximage = XGetImage(Dsp, pm, 1,2, 2*x,2*y, AllPlanes, fmats[j]);
				if( ximage == (XImage *) NULL ) {
					delete("XGetImage() returned NULL.");
					return;
				} else {

					rpixel = XCALL;

					if(rpixel != pixel) {
						report("%s() returned 0x%lx instead of 0x%lx.", TestName, rpixel, pixel);
						FAIL;
					} else
						if(i == 0 && j == 0)
							CHECK;

					XDestroyImage(ximage);
				}

			}
		}

	}

	npix = nvinf();

	for(resetvinf(VI_WIN); nextvinf(&vi);) {

		win = makewin(Dsp, vi);
		gc = makegc(Dsp, win);
		if (vi->depth < 32)
			mask = (1UL<<vi->depth) - 1;
		else
			mask = 0xffffffffUL;
		for(i = 0; i <= (15 & mask); i++) {
			pixel =  mask & (i | i<<4 | i<<12 | i<<20);
			XSetForeground(Dsp, gc, pixel);
			XDrawPoint(Dsp, win, gc, x+1, y+2);

			for(j=0; j<2; j++) {
				ximage = XGetImage(Dsp, win, 1,2, 2*x,2*y, AllPlanes, fmats[j]);
				if( ximage == (XImage *) NULL ) {
					delete("XGetImage() returned NULL.");
					return;
				} else {

					rpixel = XCALL;

					if(rpixel != pixel) {
						report("%s() returned 0x%lx instead of 0x%lx.", TestName, rpixel, pixel);
						FAIL;
					} else
						if(i == 0 && j == 0)
							CHECK;

					XDestroyImage(ximage);
				}

			}
		}

	}

	CHECKPASS(npix + nvinf());

