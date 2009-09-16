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
>># File: tset/SHAPE/XShapeCombineShape/XShapeCombineShape.m
>>#
>># Description:
>>#     Tests for XShapeCombineShape()
>>#
>># Modifications:
>># $Log: tshpcshap.m,v $
>># Revision 1.1  2005-02-12 14:37:16  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:31:28  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:51:12  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:23:07  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:19:39  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:02:12  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.2  1995/12/15  01:47:52  andy
>># Prepare for GA Release
>>#

>>EXTERN
#include <X11/Xlib.h>
#include <X11/Xutil.h>
#include <X11/extensions/shape.h>
extern Display *display;

>>TITLE XShapeCombineShape ShapeExt
void
XShapeCombineShape(display, dest, dest_kind, x_off, y_off, src, src_kind, op)
>>ASSERTION Good A
A call to void XShapeCombineShape(display, dest, dest_kind, x_off, y_off,
src, src_kind, op) shall perform a CombineShape operation by combining 
the client region indicated by src_kind, of the source window src having
an offset from the window origin by x_off and y_off with the client
region, indicated by dest_kind of the destination window dest, and the
result is stored as the client region of the destination window dest.
>>CODE
Window  window;
Window  dest;
Window  src;
/* x_off , y_off, height and width  */
XRectangle rects[] = { 150, 150, 100, 100 }; 
XRectangle *rect_return;
int count, order;
Window root;
int x, y;
unsigned int width, height;
unsigned int border_width;
unsigned int depth;
int BorderPixel, BackgroundPixel;
pid_t pid2;

	FORK(pid2);
	tet_infoline("PREP: Open display and create window");
	window = (Window) avs_xext_init();
	tet_infoline("PREP: Get geometry of window");
	XGetGeometry(display,
		   window,
		   &root,
		   &x, &y,
		   &width, &height,
		   &border_width,
		   &depth
		   );
	tet_infoline("PREP: Create src window");
	BorderPixel = XWhitePixel(display,XDefaultScreen(display));
	BackgroundPixel = XBlackPixel(display,XDefaultScreen(display));
	src = XCreateSimpleWindow(display,
	   (Window)XRootWindow(display, XDefaultScreen(display)),
	    x,
	    y,
	    100,
	    100,
	    0,
	    BorderPixel,
	    BackgroundPixel
	    );
	tet_infoline("PREP: Create destination window");
	dest = XCreateSimpleWindow(display,
	   (Window)XRootWindow(display, XDefaultScreen(display)),
	    (x + 100),
	    (y + 100),
	    200,
	    200,
	    0,
	    BorderPixel,
	    BackgroundPixel
	    );
	tet_infoline("PREP: Combine shape using default regions");
	XShapeCombineShape(display, dest, ShapeBounding,
		   150, 150, src,
		   ShapeBounding, ShapeSet);
	XMapWindow (display, dest);
	XSync (display, 0);
	tet_infoline("PREP: Get count and order of rectangles");
	rect_return = (XRectangle *)XShapeGetRectangles(display,
			    dest, ShapeBounding,
			    &count, &order);
	tet_infoline("TEST: Check number of rectangles in default region is one");
	check_dec(1, count, "count");
	tet_infoline("TEST: Rectangle values");
	check_dec(rects[0].x, rect_return->x, "rect_return->x");
	check_dec(rects[0].y, rect_return->y, "rect_return->y");
	check_dec(rects[0].width, rect_return->width,
		         "rect_return->width");
	check_dec(rects[0].height, rect_return->height, "rect_return->height");

	LKROF(pid2, AVSXTTIMEOUT);
        tet_result(TET_PASS);
