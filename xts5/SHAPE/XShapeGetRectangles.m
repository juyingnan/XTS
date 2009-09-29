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

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>>#
>># Project: VSW5
>>#
>># File: xts/SHAPE/XShapeGetRectangles.m
>>#
>># Description:
>>#     Tests for XShapeGetRectangles()
>>#
>># Modifications:
>># $Log: tshpgtrec.m,v $
>># Revision 1.1  2005-02-12 14:37:16  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:31:28  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:51:13  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:23:07  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:19:40  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:02:14  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.2  1995/12/15  01:47:53  andy
>># Prepare for GA Release
>>#

>>EXTERN
#include <X11/Xlib.h>
#include <X11/Xutil.h>
#include <X11/extensions/shape.h>
extern Display *display;

>>TITLE XShapeGetRectangles ShapeExt
XRectangle *
XShapeGetRectangles(display, window, kind, count, ordering)
>>ASSERTION Good A
A call to XRectangle *XShapeGetRectangles(display, window, kind, count,
ordering) shall return the list of rectangles as specified by count
and ordering order
describing the region specified by kind.");
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
	xswa.background_pixel = XBlackPixel(display,
			  XDefaultScreen (display));
	mask = CWEventMask | CWBackPixel;
	window_good = XCreateWindow(display, window,
		     (x+10), (y+10),
		     (width - 50 ), (height - 50 ), 0,
		     CopyFromParent,
		     CopyFromParent,
		     CopyFromParent,
		     mask, &xswa
		     );
	tet_infoline("PREP: Combine two rectangles and map window");
	XShapeCombineRectangles(display,
		        window_good,
		        ShapeBounding, 0, 0,
		        rects,
		        sizeof (rects) / sizeof (rects[0]),
		        ShapeSet, YXBanded);
	XMapWindow(display, window_good);
	XSync(display, 0);
	tet_infoline("PREP: Get count and order of rectangles");
	rect_return = (XRectangle *)XShapeGetRectangles(display,
			    window_good, ShapeBounding,
			    &count, &order);
	tet_infoline("TEST: Count and order values");
	check_dec(2, count, "count");
	check_dec(YXBanded, order, "order");
	tet_infoline("TEST: Check first rectangle values");
	check_dec(rects[0].x, rect_return->x, "rect_return->x");
	check_dec(rects[0].y, rect_return->y, "rect_return->y");
	check_dec(rects[0].width, rect_return->width,
		         "rect_return->width");
	check_dec(rects[0].height, rect_return->height,
			"rect_return->height");
	tet_infoline("TEST: Second rectangle values");
	rect_return++;
	check_dec(rects[1].x, rect_return->x, "rect_return->x");
	check_dec(rects[1].y, rect_return->y, "rect_return->y");
	check_dec(rects[1].width, rect_return->width,
		         "rect_return->width");
	check_dec(rects[1].height, rect_return->height,
			"rect_return->height");

	LKROF(pid2, AVSXTTIMEOUT);
        tet_result(TET_PASS);
