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
>># File: xts5/Xlib9/XFillArcs/XFillArcs.m
>># 
>># Description:
>># 	Tests for XFillArcs()
>># 
>># Modifications:
>># $Log: fllarcs.m,v $
>># Revision 1.2  2005-11-03 08:43:55  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:38  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:30:19  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:49:06  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:22:09  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:18:42  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 08:58:36  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  00:54:23  andy
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
>>TITLE XFillArcs Xlib9
void

Display	*display = Dsp;
Drawable d;
GC		gc;
XArc	*arcs = defarcs;
int 	narcs = NARCS(defarcs);
>>EXTERN

#define	NARCS(a) (sizeof(a)/sizeof(XArc))

#define	DEG(n)	(64*(n))

/* avoid any non-rational chords/pie-faces */
static	XArc	defarcs[] = {
	{10, 10, 60, 40, DEG(90), DEG(90)},
	{50, 10, 50, 70, DEG(0), DEG(-90)},
};

>>ASSERTION Good A
A call to xname draws
.A narcs
filled circular or elliptical arcs in the drawable
.A d
as specified by the corresponding member of the
.A arcs
list.
>>STRATEGY
Draw arcs.
Pixmap verify.
>>CODE
XVisualInfo	*vp;

	for (resetvinf(VI_WIN_PIX); nextvinf(&vp); ) {
		d = makewin(display, vp);
		gc = makegc(display, d);

		XCALL;

		PIXCHECK(display, d);
	}

	CHECKPASS(nvinf());

>># The next 3 assertions used to be included from arc.inc.
>># The wording was only correct for fllarcs - so I have hand included them.
>># DPJ Cater	17/3/91
>>ASSERTION Good A
When the GC component
.M arc-mode
is
.S ArcChord ,
then a call to xname fills the region closed by the infinitely thin path
described by each specified arc and the single line segment joining the two
endpoints of that arc.
>>STRATEGY
Set arc-mode to ArcChord
Draw arcs
Pixmap check.
>>CODE
XVisualInfo	*vp;

	for (resetvinf(VI_WIN_PIX); nextvinf(&vp); ) {
		d = makewin(display, vp);
		gc = makegc(display, d);

		XSetArcMode(display, gc, ArcChord);

		XCALL;

		PIXCHECK(display, d);
	}

	CHECKPASS(nvinf());

>>ASSERTION Good A
When the GC component
.M arc-mode
is
.S ArcPieSlice , 
then a call to xname fills the region closed by the infinitely thin path
described by each specified arc and
the two line segments joining the endpoints of that arc with the centre
point of that arc.
>>STRATEGY
Set arc-mode to ArcPieSlice
Draw arcs.
Pixmap verify.
>>CODE
XVisualInfo	*vp;

	for (resetvinf(VI_WIN_PIX); nextvinf(&vp); ) {
		d = makewin(display, vp);
		gc = makegc(display, d);

		XSetArcMode(display, gc, ArcPieSlice);

		XCALL;

		PIXCHECK(display, d);
	}

	CHECKPASS(nvinf());

>>ASSERTION Good A
A call to xname does not draw a pixel for any particular arc more than once.
>>STRATEGY
Draw with gc function set to GXcopy
Draw with gc function set to GXxor
Verify that window is blank
>>CODE
XVisualInfo	*vp;

	for (resetvinf(VI_WIN_PIX); nextvinf(&vp); ) {
		d = makewin(display, vp);
		gc = makegc(display, d);

		XCALL;

		XSetFunction(display, gc, GXxor);

		XCALL;

		if (checkarea(display, d, (struct area *)0, W_BG, W_BG, CHECK_IN))
			CHECK;
		else {
			report("Pixels drawn more than once");
			FAIL;
		}
	}

	CHECKPASS(nvinf());

>>ASSERTION Good B 1
A call to xname fills the arcs in the order listed in the array.
>>ASSERTION Good A
When arcs intersect, then the intersecting pixels are drawn multiple times.
>>STRATEGY
Set gc funcion to GXxor
Draw intersecting filled arcs.
>>CODE
XVisualInfo	*vp;
static	XArc	intarcs[] = {
	{10, 10, 60, 60, DEG(0), DEG(180)},
	{30, 30, 60, 60, DEG(0), DEG(180)},
};

	for (resetvinf(VI_WIN_PIX); nextvinf(&vp); ) {
		d = makewin(display, vp);
		gc = makegc(display, d);

		XSetFunction(display, gc, GXxor);

		arcs = intarcs;
		narcs = NARCS(intarcs);
		XCALL;

		PIXCHECK(display, d);
	}

	CHECKPASS(nvinf());

>>ASSERTION gc
On a call to xname the GC components
.M function ,
.M plane-mask ,
.M fill-style ,
.M arc-mode ,
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
.M tile-stipple-x-origin
and
.M tile-stipple-y-origin
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
