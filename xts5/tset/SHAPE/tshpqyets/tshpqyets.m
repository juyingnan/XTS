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
$Header: /cvs/xtest/xtest/xts5/tset/SHAPE/tshpqyets/tshpqyets.m,v 1.1 2005-02-12 14:37:16 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>>#
>># Project: VSW5
>>#
>># File: tset/SHAPE/tshpqyets/tshpqyets.m
>>#
>># Description:
>>#     Tests for XShapeQueryExtents()
>>#
>># Modifications:
>># $Log: tshpqyets.m,v $
>># Revision 1.1  2005-02-12 14:37:16  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:31:30  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:51:16  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:23:09  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:19:41  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:02:17  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.2  1995/12/15  01:47:55  andy
>># Prepare for GA Release
>>#

>>EXTERN
#include <X11/Xlib.h>
#include <X11/Xutil.h>
#include <X11/extensions/shape.h>
extern Display *display ;

>>TITLE XShapeQueryExtents ShapeExt
Status
XShapeQueryExtents(display, window, bounding_shaped, x_bounding, y_bounding, w_bounding, h_bounding, clip_shaped, x_clip, y_clip, w_clip, h_clip )
>>ASSERTION Good A
A call to Status XShapeQueryExtents(display, window, bounding_shaped,
x_bounding, y_bounding, w_bounding, h_bounding, clip_shaped, x_clip, y_clip,
w_clip, h_clip) shall return a non-zero value, and set x_bounding,
 y_bounding, w_bounding, h_bounding to the extents of the bounding 
shape, and x_clip, y_clip, w_clip, h_clip to extents of the clip shape.
>>CODE
Window window;
int value_good;
int bounding_shaped, clip_shaped;
int x_bounding, y_bounding;
unsigned int w_bounding, h_bounding;
int x_clip, y_clip;
unsigned int w_clip, h_clip;
Window root;
int x, y;
unsigned int width, height;
unsigned int border_width;
unsigned int depth;
pid_t pid2;


>># Definition for default bounding and clip regions for the rectangles
>># 
>># bounding.x = -bwidth
>># bounding.y = -bwidth
>># bounding.width = width + 2 * bwidth
>># bounding.height = height + 2 * bwidth
>># 
>># clip.x = 0
>># clip.y = 0 
>># clip.width = width
>># clip.heigth = height

	FORK(pid2);
	tet_infoline("PREP: Open display and create window");
	window = (Window) avs_xext_init();
	tet_infoline("PREP: XShapeQueryExtents");
	value_good = XShapeQueryExtents(display, window,
			&bounding_shaped,
			&x_bounding, &y_bounding,
			&w_bounding, &h_bounding,
			&clip_shaped,
			&x_clip, &y_clip, 
			&w_clip, &h_clip);
	tet_infoline("TEST: Non zero value is returned");
	if (value_good <= 0) {
		sprintf(ebuf, "ERROR: Expected non zero value, returned %d", value_good);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("PREP: Get geometry of window");
	XGetGeometry(display,
		   window,
		   &root,
		   &x, &y,
		   &width, &height,
		   &border_width,
		   &depth 
		   );
	tet_infoline("TEST: Bounding shape and clip shape value");
	check_dec(-1, x_bounding, "x_bounding");
	check_dec(-1, y_bounding, "y_bounding");
	check_dec((width +(2 * border_width)), w_bounding, "w_bounding");
	check_dec((height+(2 * border_width)), h_bounding, "h_bounding");
	check_dec(0, x_clip, "x_clip");
	check_dec(0, y_clip, "y_clip");
	check_dec(width, w_clip, "w_clip");
	check_dec(height, h_clip, "h_clip");

	LKROF(pid2, AVSXTTIMEOUT);
        tet_result(TET_PASS);
