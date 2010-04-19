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

Copyright (c) Applied Testing and Technology, Inc. 1995
All Rights Reserved.

>># Project: VSW5
>># 
>># File: xts5/Xlib9/XDrawRectangles/XDrawRectangles.m
>># 
>># Description:
>># 	Tests for XDrawRectangles()
>># 
>># Modifications:
>># $Log: drwrctngls.m,v $
>># Revision 1.2  2005-11-03 08:43:54  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:35  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:29:23  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:47:57  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:21:23  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:17:54  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 08:55:38  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  00:53:42  andy
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
>>TITLE XDrawRectangles Xlib9
void

Display	*display = Dsp;
Drawable	d;
GC		gc;
XRectangle	*rectangles = defrects;;
int 	nrectangles = NRECTS;
>>EXTERN

static	XRectangle	defrects[] = {
	{10, 10, 60, 7},
	{10, 30, 70, 12},
	{10, 8, 20, 40},
};

#define	NRECTS	2
#define	NRECTSCROSS	3	/* +extra that intersects */

#ifdef MIN 
#undef MIN
#endif
#define MIN(a,b) (((a)<(b)) ? (a) : (b))

#ifdef MAX 
#undef MAX
#endif
#define MAX(a,b) (((a)>(b)) ? (a) : (b))

static void
drawline(ax1, ay1, ax2, ay2)
int 	ax1, ay1, ax2, ay2;
{
XRectangle	rect;
int	fail = 0;
int	x2 = MAX(ax1,ax2), y2 = MAX(ay1,ay2);
	/*
	 * Draw a rectangle that has the two given points as vertices.
	 * Some tests then do not apply or need slight modification.
	 * Sort them as the protocol specifies rects as top-left and w & h
	 * so drawing a rectangle "in reverse" isn't possible.
	 */
	rect.x = MIN(ax1,ax2); rect.y = MIN(ay1,ay2);
	rect.width = x2 - rect.x;
	rect.height = y2 - rect.y;
	rectangles = &rect;
	nrectangles = 1;
	XCALL;
}
#undef MIN
#undef MAX

static void
setfordash()
{
static	XRectangle	rects[] = {
	{20, 10, 48, 70},
	{30, 30, 20, 12},
	};
	rectangles = rects;
	nrectangles = NELEM(rects);
}
>>ASSERTION Good A
A call to xname draws the outlines of 
.A nrectangles
rectangles
specified by
.A rectangles
in the drawable
.A d .
>>STRATEGY
Draw rectangles.
Pixmap verify.
>>CODE
XVisualInfo *vp;

	for (resetvinf(VI_WIN_PIX); nextvinf(&vp); ) {
		d = makewin(display, vp);
		gc = makegc(display, d);
		XCALL;
		PIXCHECK(display, d);
	}
	CHECKPASS(nvinf());
>>ASSERTION def
A call to xname draws each rectangle as if a five-point PolyLine protocol
request were specified for each rectangle in the order
[x, y], [x+width, y], [x+width, y+height], [x, y+height], [x, y].
>>ASSERTION def
All four
corners of each rectangle join.
>>ASSERTION Good B 1
A call to xname draws the rectangles in the order listed in the array.
>>ASSERTION Good A
A call to xname does not draw each pixel of a particular rectangle more than
once.
>>STRATEGY
Set function to GXxor
Draw rectangles
Pixmap verify
>>CODE
XVisualInfo *vp;

	for (resetvinf(VI_WIN_PIX); nextvinf(&vp); ) {
		d = makewin(display, vp);
		gc = makegc(display, d);
		XSetFunction(display, gc, GXxor);
		XCALL;
		PIXCHECK(display, d);
	}
	CHECKPASS(nvinf());

>>ASSERTION Good A
When the rectangles intersect,
then the intersecting pixels are drawn multiple times.
>>STRATEGY
Set function to GXxor
Draw rectangles which intersect
Pixmap verify
>>CODE
XVisualInfo *vp;

	for (resetvinf(VI_WIN_PIX); nextvinf(&vp); ) {
		d = makewin(display, vp);
		gc = makegc(display, d);
		XSetFunction(display, gc, GXxor);
		nrectangles = NRECTSCROSS;
		XCALL;
		PIXCHECK(display, d);
	}
	CHECKPASS(nvinf());

>>ASSERTION gc
On a call to xname the GC components
.M function ,
.M plane-mask ,
.M line-width ,
.M line-style ,
.M join-style
.M fill-style ,
.M subwindow-mode ,
.M clip-x-origin ,
.M clip-y-origin ,
and 
.M clip-mask
are used.
>>ASSERTION gc
On a call to xname the GC mode-dependent components
.M foreground ,
.M background ,
.M tile ,
.M stipple ,
.M tile-stipple-x-origin ,
.M tile-stipple-y-origin ,
.M dash-offset
and
.M dash-list
are used.
>>ASSERTION Bad A
.ER BadDrawable
>>ASSERTION Bad A
.ER BadGC
>>ASSERTION Bad A
.ER BadMatch inputonly
>>ASSERTION Bad A
.ER BadMatch gc-drawable-depth
>>ASSERTION Bad A
.ER BadMatch gc-drawable-screen
>># HISTORY steve Completed	Written in new format and style
>># HISTORY kieron Completed	Global and pixel checking to do - 19/11/90
>># HISTORY dave Completed	Final checking to do - 21/11/90
