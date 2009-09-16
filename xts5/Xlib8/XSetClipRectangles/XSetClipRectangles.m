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
>># File: xts5/tset/Xlib8/XSetClipRectangles/XSetClipRectangles.m
>># 
>># Description:
>># 	Tests for XSetClipRectangles()
>># 
>># Modifications:
>># $Log: stclprctng.m,v $
>># Revision 1.2  2005-11-03 08:43:50  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:32  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:27:31  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:45:50  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:19:42  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:16:12  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 08:51:06  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  00:51:46  andy
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
>>TITLE XSetClipRectangles Xlib8
void
XSetClipRectangles(display, gc, clip_x_origin, clip_y_origin, rectangles, n, ordering)
Display *display = Dsp;
GC gc;
int clip_x_origin = 1;
int clip_y_origin = 1;
XRectangle *rectangles = &crect;
int n = 1;
int ordering = Unsorted;
>>EXTERN
XRectangle	crect;

int
bad_orderA(order_arg)
int	order_arg;
{
XVisualInfo *vp;
Window	win;
XGCValues	values;
XRectangle 	drects[2];
int		i, j;
int		pass = 0, fail = 0;

	resetvinf(VI_WIN);
	nextvinf(&vp);

	win = makewin(display, vp);
	values.foreground = W_FG;
	values.background = W_BG;


	drects[0].x = 0;
	drects[0].y = 10;
	drects[0].width = drects[0].height = 5;

	drects[1].x = 10;
	drects[1].y = 5;
	drects[1].width = drects[1].height = 5;

	gc = XCreateGC(display, win, GCForeground | GCBackground, &values);


	rectangles = drects;
	n = 2;
	ordering = order_arg;

	/* 
	 * XCALL can't be used at the moment - 
	 * it expects geterr() to have one correct return type.  
	 */

	startcall(Dsp);

	if (isdeleted()) {
		return;
	}
	XSetClipRectangles(display, gc, clip_x_origin, clip_y_origin, rectangles, n, ordering);

	endcall(Dsp);

	if (geterr() == BadMatch) {
		trace("XSetClipRectangles returned BadMatch error.");
		CHECK;
	} else if (geterr() == Success) {
		trace("XSetClipRectangles did not return an error.");
		CHECK;
	} else {
		report("Got %s, Expecting BadMatch or Success.", errorname(geterr()));
		FAIL;
	}
	return(pass);
}

int
bad_orderB(order_arg)
int	order_arg;
{
XVisualInfo *vp;
Window	win;
XGCValues	values;
XRectangle 	drects[3];
int		i, j;
int		pass = 0, fail = 0;

	resetvinf(VI_WIN);
	nextvinf(&vp);
	win = makewin(display, vp);
	values.foreground = W_FG;
	values.background = W_BG;


	drects[0].x = 20;
	drects[0].y = 5;
	drects[0].width = drects[0].height = 5;

	drects[1].x = 10;
	drects[1].y = 5;
	drects[1].width = drects[1].height = 5;

	gc = XCreateGC(display, win, GCForeground | GCBackground, &values);

	rectangles = drects;
	n = 2;
	ordering = order_arg;

	/* 
	 * XCALL can't be used at the moment - 
	 * it expects geterr() to have one correct return type.
	 */

	startcall(Dsp);

	if (isdeleted()) {
		return;
	}
	XSetClipRectangles(display, gc, clip_x_origin, clip_y_origin, rectangles, n, ordering);

	endcall(Dsp);

	if (geterr() == BadMatch) {
		trace("XSetClipRectangles returned BadMatch error.");
		CHECK;
	} else if (geterr() == Success) {
		trace("XSetClipRectangles did not return an error.");
		CHECK;
	} else {
		report("Got %s, Expecting BadMatch or Success.", errorname(geterr()));
		FAIL;
	}
	return(pass);
}

int
bad_orderC(order_arg)
int	order_arg;
{
XVisualInfo *vp;
Window	win;
XGCValues	values;
XRectangle 	drects[3];
int		i, j;
int		pass = 0, fail = 0;

	resetvinf(VI_WIN);
	nextvinf(&vp);
	win = makewin(display, vp);
	values.foreground = W_FG;
	values.background = W_BG;


	drects[0].x = 20;
	drects[0].y = 5;
	drects[0].width = drects[0].height = 5;

	drects[1].x = 30;
	drects[1].y = 5;
	drects[1].width = drects[1].height = 4;

	gc = XCreateGC(display, win, GCForeground | GCBackground, &values);

	rectangles = drects;
	n = 2;
	ordering = order_arg;

	/* 
	 * XCALL can't be used at the moment - 
	 * it expects geterr() to have one correct return type.
	 */

	startcall(Dsp);

	if (isdeleted()) {
		return;
	}
	XSetClipRectangles(display, gc, clip_x_origin, clip_y_origin, rectangles, n, ordering);

	endcall(Dsp);

	if (geterr() == BadMatch) {
		trace("XSetClipRectangles returned BadMatch error.");
		CHECK;
	} else if (geterr() == Success) {
		trace("XSetClipRectangles did not return an error.");
		CHECK;
	} else {
		report("Got %s, Expecting BadMatch or Success.", errorname(geterr()));
		FAIL;
	}
	return(pass);
}

>>ASSERTION Good A
A call to xname sets the
.M clip_mask
component of the specified GC to the specified list of rectangles
and sets the
.M clip_x_origin
and
.M clip_y_origin
components of the specified GC to the arguments
.A clip_x_origin
and
.A clip_y_origin .
>>STRATEGY
Create window.
Create GC bg = BlackPixel, fg = WhitePixel, fn = GXxor.
Set pixel at (0, 0) to fg with XDrawPoint.
Verify Pixel at (0, 0) is fg with XGetimage and GetPixel.
Set clip mask to rectangle (1, 1) (2, 2) with XSetClipRectangles.
Set Pixel at (2, 2) with XDrawPoint.
Verify Pixel at (2, 2) is fg with XGetimage and GetPixel.
Set pixel at (0, 0) to bg with XDrawPoint.
Verify Pixel at (0, 0) is fg with XGetimage and GetPixel.
>>CODE
XVisualInfo *vp;
Window	win;
XGCValues	values;

	resetvinf(VI_WIN);
	nextvinf(&vp);
	win = makewin(display, vp);
	values.foreground = W_FG;
	values.background = W_BG;
	values.function = GXxor;

	gc = XCreateGC(display, win, GCForeground | GCBackground | GCFunction, &values);

	XDrawPoint(display, win, gc, 0, 0);

	if( ! checkpixel(display, win, 0, 0, W_FG)) {
		delete("Pixel at (0, 0) was not set to foreground.");
		return;
	} else 
		CHECK;

	crect.x = crect.y = 1;
	crect.width = crect.height = 1;

	XCALL;

	XDrawPoint(display, win, gc, 2, 2);

	if( ! checkpixel(display, win, 2, 2, W_FG)) {
		delete("Pixel at (2, 2) was not set to foreground.");
		return;
	} else 
		CHECK;

	XDrawPoint(display, win, gc, 0, 0);

	if( ! checkpixel(display, win, 0, 0, W_FG)) {
		report("Pixel at (0, 0) was not left as foreground.");
		FAIL;
	} else 
		CHECK;

	CHECKPASS(3);
>>ASSERTION Good B 1
When two or more of the
.A rectangles
intersect, then no error occurs.
>>ASSERTION Good A
When the number of rectangles specified by the argument
.A n
is zero, then the
.M clip_mask
component of the specified
.A gc
is set to disable output on any subsequent graphics operation.
>>STRATEGY
For all supported visuals:
	Create a window
	Verify that every window pixel is not set.
	Call XSetClipRectangles with a meaningful rectangle and n=0;
	Verify that every window pixel cannot be set.
>>CODE
XVisualInfo	*vp;
Window		win;
XGCValues	values;
GC		pgc;
int	i, j;

	values.foreground = W_FG;
	values.background = W_BG;

	crect.x = 0;
	crect.y = 0;
	crect.width = 10;
	crect.height = 20;

	for(resetvinf(VI_WIN);	nextvinf(&vp); ) {
		win = makewin(display, vp);
		gc = XCreateGC(display, win, GCForeground | GCBackground, &values);

		if( checkarea(display, win, (struct area *) 0, W_BG, 0L, 0) == False) {
			delete("Window contents were not initialised.");
			return;
		} else
			CHECK;

		n = 0;
		XCALL;

		for(j=0; j<W_STDHEIGHT; j++)
			for(i=0; i< W_STDWIDTH; i++)
				XDrawPoint(display, win, gc, i, j);

		if( checkarea(display, win, (struct area *) 0, W_BG, 0L, 0) == False) {
			report("Drawing was not disabled.");
			FAIL;
		} else
			CHECK;
	}

	CHECKPASS(2 * nvinf());

>>ASSERTION Good A
When the
.A ordering
argument is
.S YSorted ,
and the specified list of rectangles is not non-decreasing in the Y origin, 
then either a
.S BadMatch
error occurs or no error occurs.
>>STRATEGY
Create list of rectangles decreasing in Y origin.
Call XSetClipRectangles.
Verify that if an error occurs it is a BadMatch error.
>>CODE 

	if(bad_orderA(YSorted) == 1)
		PASS;

>>ASSERTION Good A
When the
.A ordering
argument is
.S YXSorted
and the specified list of rectangles is either not non-decreasing in
the Y origin 
or rectangles with the same Y origin are not
non-decreasing in the X origin, 
then either a
.S BadMatch
error occurs or no error occurs.  
>>STRATEGY 
Create list of rectangles decreasing in Y origin.  
Call XSetClipRectangles.  
Verify that if an error occurs it is a BadMatch error.  
Create list of rectangles with
same Y origin and height and decreasing in X origin.  
Call XSetClipRectangles.  
Verify that if an error occurs it is a BadMatch error.  
>>CODE

	if(bad_orderA(YXSorted) == 1 &&
	   bad_orderB(YXSorted) == 1)
		PASS;

>>ASSERTION Good A
When the
.A ordering
argument is
.S YXBanded
and the specified list of rectangles is either not non-decreasing in
the Y origin 
or rectangles with the same Y origin are not
non-decreasing in the X origin 
or there is a Y scanline included by
rectangles with different Y origins or extents, 
then either a
.S BadMatch
error occurs or no error occurs.  
>>STRATEGY 
Create list of rectangles decreasing in Y origin.  
Call XSetClipRectangles.  
Verify that if an error occurs it is a BadMatch error.  
Create list of rectangles with
same Y origin and height and decreasing in X origin.  
Call XSetClipRectangles.  
Verify that if an error occurs it is a BadMatch error.  
Create list of rectangles with same Y origin and increasing X
origin and differing extents.  
Call XSetClipRectangles.  
Verify that if an error occurs it is a BadMatch error.  
>>CODE

	if(bad_orderA(YXBanded) == 1 &&
	   bad_orderB(YXBanded) == 1 &&
	   bad_orderC(YXBanded) == 1)
		PASS;

>>ASSERTION Bad B 1
.ER Alloc
>>ASSERTION Bad A
.ER GC
>>ASSERTION Bad A
.ER Value ordering Unsorted YSorted YXSorted YXBanded 
>># HISTORY cal Completed	Written in new format and style
>># HISTORY kieron Completed	Global and pixel checking to do - 19/11/90
>># HISTORY dave Completed	Final checking to do - 21/11/90
>># HISTORY cal	Action		Writing code.
