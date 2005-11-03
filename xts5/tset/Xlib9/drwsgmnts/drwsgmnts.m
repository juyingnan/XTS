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
$Header: /cvs/xtest/xtest/xts5/tset/Xlib9/drwsgmnts/drwsgmnts.m,v 1.2 2005-11-03 08:43:55 jmichael Exp $

Copyright (c) Applied Testing and Technology, Inc. 1995
All Rights Reserved.

>># Project: VSW5
>># 
>># File: xts5/tset/Xlib9/drwsgmnts/drwsgmnts.m
>># 
>># Description:
>># 	Tests for XDrawSegments()
>># 
>># Modifications:
>># $Log: drwsgmnts.m,v $
>># Revision 1.2  2005-11-03 08:43:55  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:35  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:29:39  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:48:12  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:21:35  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:18:06  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 08:56:16  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  00:53:49  andy
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
>>TITLE XDrawSegments Xlib9
void

Display	*display = Dsp;
Drawable	d;
GC		gc;
XSegment *segments = defsegs;
int 	nsegments = NSEGS;
>>EXTERN

XSegment	defsegs[] = {
	{10, 10, 50, 40},
	{25, 7, 60, 15},
	{10, 10, 25, 7},
	{10, 40, 40, 10},
};

#define	NSEGS	2	/* Number of segments that don't touch */
#define NSEGSJOIN 3	/*   + extra segment to test joins */
#define NSEGSCROSS 4/*   + extra segment to test intersecting lines */

static void
drawline(ax1, ay1, ax2, ay2)
int 	ax1, ay1, ax2, ay2;
{
XSegment segs[1];
int 	pass = 0, fail = 0;

	segs[0].x1 = ax1; segs[0].y1 = ay1;
	segs[0].x2 = ax2; segs[0].y2 = ay2;
	segments = segs;
	nsegments = 1;
	XCALL;
}

static void
setfordash()
{
static	XSegment segs[2];
	segs[0].x1 = 20; segs[0].y1 = 20;
	segs[0].x2 = 70; segs[0].y2 = 20;

	segs[1].x1 = 80; segs[1].y1 = 20;
	segs[1].x2 = 80; segs[1].y2 = 80;
	segments = segs;
	nsegments = 2;
}

>>ASSERTION Good A
A call to xname
draws
.A nsegments
lines between the points
.A "" ( x1 , y1 )
and
.A "" ( x2 , y2 )
in 
.A segments
in the drawable
.A d .
>>STRATEGY
Draw segments.
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
>>ASSERTION Good B 1
A call to xname draws the lines in the order listed in the array of
.S XSegment 
structures.
>>ASSERTION Good A
A call to xname does not perform joining at coincident endpoints.
>>STRATEGY
Set line-width component of GC to 4.
Set line-style component of GC to LineSolid.
Set cap-style component of GC to CapButt.
Set join-style component of GC to JoinRound.
Draw segments which include joins.
Pixmap verify.
>>CODE
XVisualInfo	*vp;

	for (resetvinf(VI_WIN_PIX); nextvinf(&vp); ) {
		d = makewin(display, vp);
		gc = makegc(display, d);
		nsegments = NSEGSJOIN;
		XSetLineAttributes(display, gc, 4, LineSolid, CapButt, JoinRound);
		XCALL;
		PIXCHECK(display, d);
	}
	CHECKPASS(nvinf());
>>ASSERTION Good A
A call to xname does not draw each pixel for a particular line more than once.
>>STRATEGY
Set function component of GC to GXxor.
Draw segments.
Pixmap verify.
>>CODE
XVisualInfo	*vp;

	for (resetvinf(VI_WIN_PIX); nextvinf(&vp); ) {
		d = makewin(display, vp);
		gc = makegc(display, d);
		XSetFunction(display, gc, GXxor);
		XCALL;
		PIXCHECK(display, d);
	}
	CHECKPASS(nvinf());
>>ASSERTION Good A
When lines intersect, then the intersecting pixels are drawn multiple times.
>>STRATEGY
Set function component of GC to GXxor.
Set line-width component of GC to 3.
Set line-style component of GC to LineSolid.
Set cap-style component of GC to CapButt.
Set join-style component of GC to JoinRound.
Draw segments which include joins and intersections.
Pixmap verify.
>>CODE
XVisualInfo	*vp;

	for (resetvinf(VI_WIN_PIX); nextvinf(&vp); ) {
		d = makewin(display, vp);
		gc = makegc(display, d);
		XSetFunction(display, gc, GXxor);
		XSetLineAttributes(display, gc, 3, LineSolid, CapButt, JoinRound);
		nsegments = NSEGSCROSS;
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
.M cap-style ,
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
.ER Match gc-drawable-depth
>>ASSERTION Bad A
.ER BadMatch gc-drawable-screen
>># HISTORY steve Completed	Written in new format and style
>># HISTORY kieron Completed	Global and pixel checking to do - 19/11/90
>># HISTORY dave Completed	Final checking to do - 21/11/90
