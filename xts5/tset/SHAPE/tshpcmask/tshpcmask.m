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
$Header: /cvs/xtest/xtest/xts5/tset/SHAPE/tshpcmask/tshpcmask.m,v 1.1 2005-02-12 14:37:16 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>>#
>># Project: VSW5
>>#
>># File: tset/SHAPE/tshpcmask/tshpcmask.m
>>#
>># Description:
>>#     Tests for XShapeCombineMask()
>>#
>># Modifications:
>># $Log: tshpcmask.m,v $
>># Revision 1.1  2005-02-12 14:37:16  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:31:26  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:51:08  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:23:06  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:19:38  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:02:09  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.2  1995/12/15  01:47:50  andy
>># Prepare for GA Release
>>#

>>EXTERN
#include <X11/Xlib.h>
#include <X11/Xutil.h>
#include <X11/extensions/shape.h>

extern Display *display;

int avs2;

/*
** Pixmaps
** essentially a rect with dimensions 16x16
*/
#define rect_width 16
#define rect_height 16
static unsigned char rect_bits[] = {
   0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
   0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
   0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
>>TITLE XShapeCombineMask ShapeExt
void
XShapeCombineMask(display, dest, dest_kind, x_off, y_off, src, op)
>>ASSERTION Good A
A call to  XShapeCombineMask(display, dest, dest_kind, x_off, y_off, src, op)
shall perform a CombineMask operation by converting the pixmap src to a
region with bits set to one included in the region and bits set to zero
excluded with an offset from the window origin by amount x_off and y_off,
the resulting region shall be combined as specified by the operator
op with the existing client region as specified by dest_kind of the
destination window dest, and the result shall be stored as the client
region of the destination window.
>>CODE
Window window;
GC gc;
Window root_window;
int x, y;
unsigned int width, height;
unsigned int border_width;
unsigned int depth;
Window dest;
XSetWindowAttributes xswa;
unsigned long  mask;
Pixmap src_pixmap;
XRectangle *rect_return;
int count, order;
int BorderPixel, BackgroundPixel;
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
	tet_infoline("PREP: Create source pixmap");
	src_pixmap = XCreateBitmapFromData(display, window,
		 (char *)rect_bits, rect_width,
		 rect_height);
	tet_infoline("PREP: Create destination window");
	BorderPixel = XWhitePixel(display,XDefaultScreen(display));
	BackgroundPixel = XBlackPixel(display,XDefaultScreen(display));
	dest  = XCreateSimpleWindow(display, window,
		     (x+10), (y+10),
		     (width - 200 ), (height - 200 ), 0,
		     BorderPixel,
		     BackgroundPixel
		     );
	XSync(display, 0);
	/*
	** Combining a pixmap with defaut shapeclip region shall yield
	** region which is a pixmap only, the number of rectangles is
	** one on destination window.
	*/
	tet_infoline("PREP: Combine pixmap with default region");
	XShapeCombineMask(display,
		  dest,
		  ShapeClip,
		  100,
		  100,
		  src_pixmap,
		  ShapeSet);
	XMapWindow(display, dest);
	XSync(display, 0);
	tet_infoline("PREP: Get count and order of rectangles");
	rect_return = (XRectangle *)XShapeGetRectangles(display,
			    dest, ShapeClip,
			    &count, &order);
	tet_infoline("TEST: Count and order values");
	check_dec(1, count, "count");
	check_dec(YXBanded, order, "order");
	LKROF(pid2, AVSXTTIMEOUT);
        tet_result(TET_PASS);
