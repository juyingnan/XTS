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
$Header: /cvs/xtest/xtest/xts5/tset/SHAPE/tshoffshp/tshoffshp.m,v 1.1 2005-02-12 14:37:16 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>>#
>># Project: VSW5
>>#
>># File: tset/SHAPE/tshoffshp/tshoffshp.m
>>#
>># Description:
>>#     Tests for XShapeOffsetShape()
>>#
>># Modifications:
>># $Log: tshoffshp.m,v $
>># Revision 1.1  2005-02-12 14:37:16  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:31:26  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:51:07  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:23:05  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:19:38  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:02:07  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.2  1995/12/15  01:47:50  andy
>># Prepare for GA Release
>>#

>>EXTERN
#include <X11/Xlib.h>
#include <X11/Xutil.h>
#include <X11/extensions/shape.h>
extern Display *display ;

>>TITLE XShapeOffsetShape ShapeExt
void
XShapeOffsetShape(display, dest, dest_kind, x_off, y_off) 
>>ASSERTION Good A
A call to XShapeOffsetShape(display, dest, dest_kind, x_off, y_off) shall
perform an OffsetShape operation by moving the client region, specified
by dest, relative to its current position by the amounts x_off and y_off.
>>CODE
Window  window;
XRectangle rects[] = { 0,0, 100, 100, 100, 100, 100, 100 };
GC gc;
Window root_window;
int x, y;
unsigned int width, height;
unsigned int border_width;
unsigned int depth;
Window window_good;
XSetWindowAttributes xswa;
unsigned long   mask;
XRectangle *rect_return;
int count, order;
int x_off;
int y_off;
pid_t pid2;

	FORK(pid2);
	tet_infoline("PREP: Open display and create window");
	window = (Window) avs_xext_init();
	tet_infoline("PREP: Get geometry of parent window");
	XGetGeometry(display, window,
		   &root_window,
		   &x, &y,
		   &width, &height,
		   &border_width,
		   &depth
		   );
	tet_infoline("PREP: Create destination window");
	xswa.event_mask = ExposureMask;
	xswa.background_pixel = XBlackPixel(display, XDefaultScreen (display));
	mask = CWEventMask | CWBackPixel;
	window_good = XCreateWindow(display, window,
		     (x+10), (y+10),
		     (width - 50 ), (height - 50 ), 0,
		     CopyFromParent,
		     CopyFromParent,
		     CopyFromParent,
		     mask, &xswa
		     );
	tet_infoline("PREP: Combine two rectangles");
	XShapeCombineRectangles(display,
			window_good,
			ShapeBounding, 0, 0,
			rects,
			sizeof (rects) / sizeof (rects[0]),
			ShapeSet, YXBanded);
	tet_infoline("PREP: Perform offset operation of x_off = 100 and y = 100");
	x_off = 100;
	y_off = 100;
	XShapeOffsetShape(display,
		  window_good,
		  ShapeBounding,
		  x_off,
		  y_off
		  );
	XMapWindow(display, window_good);
	XSync(display, 0);
	tet_infoline("PREP: Get count and order of rectangles");
	rect_return = (XRectangle *)XShapeGetRectangles(display,
			    window_good, ShapeBounding,
			    &count, &order);
	tet_infoline("TEST: Count and order values");
	check_dec(2, count, "count");
	check_dec(YXBanded, order, "order");
	tet_infoline("TEST: First rectangle values after offset");
	check_dec((rects[0].x + x_off), rect_return->x,
			"rect_return->x");
	check_dec((rects[0].y + y_off), rect_return->y,
			"rect_return->y");
	check_dec(rects[0].width, rect_return->width,
			 "rect_return->width");
	check_dec(rects[0].height, rect_return->height,
			"rect_return->height");
	tet_infoline("TEST: Second rectangle values after offset");
	rect_return++;
	check_dec((rects[1].x + x_off), rect_return->x,
			"rect_return->x");
	check_dec((rects[1].y + y_off), rect_return->y,
			"rect_return->y");
	check_dec(rects[1].width, rect_return->width,
			 "rect_return->width");
	check_dec(rects[1].height, rect_return->height,
			"rect_return->height");
	LKROF(pid2, AVSXTTIMEOUT);
	tet_result(TET_PASS);
