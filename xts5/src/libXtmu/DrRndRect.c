/*
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
*/
/*
*
* Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
* All Rights Reserved.
*
* Project: VSW5
*
* File: xts5/src/lib/libXtaw/DrRndRect.c
*
* Description:
*	Subset of libXmu need for VSW5.  Use if implementation does not
*	support Athena.
*
* Modifications:
* $Log: DrRndRect.c,v $
* Revision 1.2  2005-11-03 08:42:02  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:11  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:26:00  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:44:15  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:18:18  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:14:50  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:46:24  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:44:32  andy
* Prepare for GA Release
*
*/
/*
 *
 * XmuDrawRoundedRectangle, XmuFillRoundedRectangle
 *
 * Draw/Fill a rounded rectangle, where x, y, w, h are the dimensions of
 * the overall rectangle, and ew and eh are the sizes of a bounding box
 * that the corners are drawn inside of.
 */

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <X11/Xlib.h>

void
XmuDrawRoundedRectangle (dpy, draw, gc, x, y, w, h, ew, eh)
    Display		*dpy;
    Drawable		draw;
    GC			gc;
    int			x, y, w, h, ew, eh;
{
	XArc	arcs[8];

	if (ew*2 > w)
	    ew = 0;
	if (eh*2 > h)
	    eh = 0;

	arcs[0].x = x;
	arcs[0].y = y;
	arcs[0].width = ew*2;
	arcs[0].height = eh*2;
	arcs[0].angle1 = 180*64;
	arcs[0].angle2 = -90*64;

	arcs[1].x = x + ew;
	arcs[1].y = y;
	arcs[1].width = w - ew*2;
	arcs[1].height = 0;
	arcs[1].angle1 = 180*64;
	arcs[1].angle2 = -180*64;

	arcs[2].x = x + w - ew*2;
	arcs[2].y = y;
	arcs[2].width = ew*2;
	arcs[2].height = eh*2;
	arcs[2].angle1 = 90*64;
	arcs[2].angle2 = -90*64;

	arcs[3].x = x + w;
	arcs[3].y = y + eh;
	arcs[3].width = 0;
	arcs[3].height = h - eh*2;
	arcs[3].angle1 = 90 * 64;
	arcs[3].angle2 = -180*64;

	arcs[4].x = x + w - ew*2;
	arcs[4].y = y + h - eh*2;
	arcs[4].width = ew * 2;
	arcs[4].height = eh * 2;
	arcs[4].angle1 = 0;
	arcs[4].angle2 = -90*64;

	arcs[5].x = x + ew;
	arcs[5].y = y + h;
	arcs[5].width = w - ew*2;
	arcs[5].height = 0;
	arcs[5].angle1 = 0;
	arcs[5].angle2 = -180*64;

	arcs[6].x = x;
	arcs[6].y = y + h - eh*2;
	arcs[6].width = ew*2;
	arcs[6].height = eh*2;
	arcs[6].angle1 = 270*64;
	arcs[6].angle2 = -90*64;

	arcs[7].x = x;
	arcs[7].y = y + eh;
	arcs[7].width = 0;
	arcs[7].height = h - eh*2;
	arcs[7].angle1 = 270*64;
	arcs[7].angle2 = -180*64;
	XDrawArcs (dpy, draw, gc, arcs, 8);
}

void
XmuFillRoundedRectangle (dpy, draw, gc, x, y, w, h, ew, eh)
    Display		*dpy;
    Drawable		draw;
    GC			gc;
    int			x, y, w, h, ew, eh;
{
	XArc	arcs[4];
	XRectangle rects[3];
	XGCValues vals;

	XGetGCValues(dpy, gc, GCArcMode, &vals);
	if (vals.arc_mode != ArcPieSlice)
	    XSetArcMode(dpy, gc, ArcPieSlice);

	if (ew*2 > w)
	    ew = 0;
	if (eh*2 > h)
	    eh = 0;

	arcs[0].x = x;
	arcs[0].y = y;
	arcs[0].width = ew*2;
	arcs[0].height = eh*2;
	arcs[0].angle1 = 180*64;
	arcs[0].angle2 = -90*64;

	arcs[1].x = x + w - ew*2;
	arcs[1].y = y;
	arcs[1].width = ew*2;
	arcs[1].height = eh*2;
	arcs[1].angle1 = 90*64;
	arcs[1].angle2 = -90*64;

	arcs[2].x = x + w - ew*2;
	arcs[2].y = y + h - eh*2;
	arcs[2].width = ew*2;
	arcs[2].height = eh*2;
	arcs[2].angle1 = 0;
	arcs[2].angle2 = -90*64;

	arcs[3].x = x;
	arcs[3].y = y + h - eh*2;
	arcs[3].width = ew*2;
	arcs[3].height = eh*2;
	arcs[3].angle1 = 270*64;
	arcs[3].angle2 = -90*64;

	XFillArcs (dpy, draw, gc, arcs, 4);

	rects[0].x = x + ew;
	rects[0].y = y;
	rects[0].width = w - ew*2;
	rects[0].height = h;

	rects[1].x = x;
	rects[1].y = y + eh;
	rects[1].width = ew;
	rects[1].height = h - eh*2;

	rects[2].x = x + w - ew;
	rects[2].y = y + eh;
	rects[2].width = ew;
	rects[2].height = h - eh*2;

	XFillRectangles (dpy, draw, gc, rects, 3);

	if (vals.arc_mode != ArcPieSlice)
	    XSetArcMode(dpy, gc, vals.arc_mode);
}
