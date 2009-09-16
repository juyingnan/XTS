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
$Header: /cvs/xtest/xtest/xts5/tset/Xlib17/XAddPixel/XAddPixel.m,v 1.3 2005-11-03 08:43:03 jmichael Exp $

Copyright (c) 2004 The Open Group
Copyright (c) Applied Testing and Technology, Inc. 1995
All Rights Reserved.

>># Project: VSW5
>># 
>># File: xts5/tset/Xlib17/XAddPixel/XAddPixel.m
>># 
>># Description:
>># 	Tests for XAddPixel()
>># 
>># Modifications:
>># $Log: addpxl.m,v $
>># Revision 1.3  2005-11-03 08:43:03  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.2  2005/04/21 09:40:42  ajosey
>># resync to VSW5.1.5
>>#
>># Revision 8.2  2005/01/14 12:02:32  gwc
>># Updated copyright notice
>>#
>># Revision 8.1  2004/02/12 12:17:02  gwc
>># Fixed uses of 1<<dep[th] to handle depth 32
>>#
>># Revision 8.0  1998/12/23 23:34:29  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:56:50  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:25:48  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:22:20  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:10:41  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:13:10  andy
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
>>TITLE XAddPixel Xlib17

XAddPixel(ximage, value)
XImage	*ximage;
long	value;
>>EXTERN
void
mpattern(display, d, w, h, dep)
Display		*display;
Drawable	d;
unsigned int	w;
unsigned int	h;
int		dep;
{
int		i;
int		j;
unsigned long	mod;
GC		gc;
unsigned long	val;

	gc = makegc(display, d);
	if (dep < 32)
		mod = 1UL<<dep;
	val = 0;
	for(j=0; j<h; j++)
		for(i=0; i<w; i++) {
			XSetForeground(display, gc, val);
			XDrawPoint(display, d, gc, i, j);
			if (dep < 32)
				val = (val + 1) % mod;
			else
				val = (val + 1);
		}
}

int
mcheck(xi, w, h, dep)
XImage		*xi;
unsigned int	w;
unsigned int	h;
int		dep;
{
int		i;
int		j;
unsigned long	mod;
unsigned long	val;

	if (dep < 32)
		mod = 1UL<<dep;
	val = value;
	for(j=0; j<h; j++)
		for(i=0; i<w; i++) {
			if(XGetPixel(ximage, i, j) != val){
				return 0;
			}
			if (dep < 32)
				val = (val + 1) % mod;
			else
				val = (val + 1);
		}
	return 1;
}
>>ASSERTION Good A
A call to xname adds the
.A value
argument to every pixel in the
.A ximage
argument.
>>STRATEGY
For all supported drawables:
   Create a drawable.
   Initialise the drawable's pixels.
   For ZPixmap and XYPixmap:
	   Obtain an ximage from the drawable using XGetImage.
	   Add the drawables depth - 1 to every image pixel using xname.
	   Verify that the ximage pixels all set correctly using XGetPixel.
>>CODE
XVisualInfo	*vi;
int		npix;
unsigned int	width;
unsigned int	height;
Pixmap		pm;
Window		win;
int		i;
static int	fmats[2] = { XYPixmap, ZPixmap };
	

	for(resetvinf(VI_PIX); nextvinf(&vi);) {

		pm = makepixm(Dsp, vi);
		getsize(Dsp, pm, &width, &height);
		width = width > 17 ? 17 : width;
		height = height > 19  ? 19 : height;
		mpattern(Dsp, pm, width, height, vi->depth);

		for(i=0; i<2; i++) {
			ximage = XGetImage(Dsp, pm, 0,0, width, height, AllPlanes, fmats[i]);
			if( ximage == (XImage *) NULL ) {
				delete("XGetImage() returned NULL.");
				return;
			} else {

				if (vi->depth <= 30)
					value = (1L << vi->depth) - 1;
				else
					value = (1L << 30) - 1;
				XCALL;
				if(mcheck(ximage, width, height, vi->depth) == 0) {
					report("XImage structure was not correct.");
					FAIL;
				} else
					CHECK;

				XDestroyImage(ximage);
			}

		}
	}
	npix = nvinf();

	for(resetvinf(VI_WIN); nextvinf(&vi);) {

		win = makewin(Dsp, vi);
		getsize(Dsp, win, &width, &height);
		width = width > 17 ? 17 : width;
		height = height > 19  ? 19 : height;
		mpattern(Dsp, win, width, height, vi->depth);

		for(i=0; i<2; i++) {
			ximage = XGetImage(Dsp, win, 0,0, width, height, AllPlanes, fmats[i]);
			if(ximage == (XImage *) NULL) {
				delete("XGetImage() returned NULL.");
				return;
			} else {
				if (vi->depth <= 30)
					value = (1L << vi->depth) - 1;
				else
					value = (1L << 30) - 1;
				XCALL;
				if(mcheck(ximage, width, height, vi->depth) == 0) {
					report("XImage structure was not correct.");
					FAIL;
				} else
					CHECK;

				XDestroyImage(ximage);
			}
		}

	}

	CHECKPASS(2 * (npix + nvinf()));
