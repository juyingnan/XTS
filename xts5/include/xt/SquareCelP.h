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
* Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
* All Rights Reserved.
*
* Project: VSW5
*
* File: xts5/include/xt/SquareCellP.h
*
* Description:
*	Test widget
*
* Modifications:
* $Log: SquareCelP.h,v $
* Revision 1.2  2005-11-03 08:42:01  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:07  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:22:59  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:40:59  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:15:32  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:12:04  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:38:03  tbr
* Branch point for Release 5.0.0
*
* Revision 3.2  1995/12/15  00:38:42  andy
* Prepare for GA Release
*
*/

/* 
 * SquareCellP.h - Private definitions for SquareCell widget
 */

#ifndef SQUARECELP_H
#define SQUARECELP_H

#include "X11/IntrinsicP.h"
#include "X11/CoreP.h"
#include "X11/Xaw/SimpleP.h"

/*
 * Include public header file for this widget.
 */
#include "SquareCell.h"

/* New fields for the SquareCell widget class record */

typedef struct {
	int make_compiler_happy;	/* keep compiler happy */
} SquareCellClassPart;

/* Full class record declaration */
typedef struct _SquareCellClassRec {
    CoreClassPart	core_class;
	SimpleClassPart		simple_class;
    SquareCellClassPart	squareCell_class;
} SquareCellClassRec;

extern SquareCellClassRec squareCellClassRec;

/* New fields for the SquareCell widget record */
typedef struct {
    /* resources */
    Pixel	foreground;
    XtCallbackList callback;	/* application installed callback function(s) */
    Dimension	pixmap_width_in_cells;
    Dimension 	pixmap_height_in_cells;
    int cell_size_in_pixels;
    int cur_x, cur_y;  /* position of visible corner in big pixmap */
    char *cell;	/* array for keeping track of array of bits */
	Boolean show_all;  /* whether bitmap should display entire bitmap */

    /* private state */
    Dimension	pixmap_width_in_pixels;
    Dimension	pixmap_height_in_pixels;
    Pixmap big_picture;
    GC		draw_gc;	/* one plane, for drawing into pixmap */
    GC		undraw_gc;	/* one plane, for drawing into pixmap */
    GC		copy_gc;	/* defaultdepthofscreen, for copying pixmap into window */
	Boolean user_allocated;  /* whether user allocated cell array */
} SquareCellPart;

/*
 * Full instance record declaration
 */
typedef struct _SquareCellRec {
    CorePart		    core;
	SimplePart			primitive;
    SquareCellPart	    squareCell;
} SquareCellRec;

#endif /* SQUARECELP_H */
