/*
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
*/
/*
* $Header: /cvs/xtest/xtest/xts5/include/vmath.h,v 1.1 2005-02-12 14:37:13 anderson Exp $
*
* Copyright Applied Testing and Technology Inc. 1995
* All rights reserved
*
* Project: VSW5
*
* File:	vsw5/src/libXR5/vmath.h
*
* Description:
*	Drawable support routines
*
* Modifications:
* $Log: vmath.h,v $
* Revision 1.1  2005-02-12 14:37:13  anderson
* Initial revision
*
* Revision 8.0  1998/12/23 23:23:35  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:41:40  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:16:05  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:12:36  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:38:51  tbr
* Branch point for Release 5.0.0
*
* Revision 3.2  1995/12/15  02:08:48  andy
* Prepare for GA Release
*
*/

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

Copyright 1990, 1991 by UniSoft Group Limited.

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

#ifndef VMATH
#define VMATH

/**** define GLOBAL and PARAMS *****/

#ifdef gen_code
#define GLOBAL
#define INIT(x) = x
#else
#define GLOBAL extern
#define INIT(x) 
#endif

#ifdef ANSI_C
#define PARAMS(x) x
#else
#define PARAMS(x) ()                                                                                                     
#endif


/**** define extent record for use by drawutil.h and the generation routines ****/

typedef struct extent_record1 {
    int lowx,lowy,highx,highy;
} extent_record;

/*** define useful macros *****/

GLOBAL int _itmp1,_itmp2;
GLOBAL double _ftmp1,_ftmp2;

#define ABS(x) ((x) < 0 ? (-(x)) : (x))
#define ABSi(x) ((_itmp1=(x)) < 0 ? (-(_itmp1)) : (_itmp1))
#define ABSf(x) ((_ftmp1=(x)) < 0 ? (-(_ftmp1)) : (_ftmp1))

#define MIN(x,y) ((x) < (y) ? (x) : (y))
#define MAX(x,y) ((x) > (y) ? (x) : (y))

#define MINi(x,y) (_itmp1=(x),_itmp2=(y),(_itmp1 < _itmp2 ? _itmp1 : _itmp2))
#define MAXi(x,y) (_itmp1=(x),_itmp2=(y),(_itmp1 > _itmp2 ? _itmp1 : _itmp2))

#define MINf(x,y) (_ftmp1=(x),_ftmp2=(y),(_ftmp1 < _ftmp2 ? _ftmp1 : _ftmp2))
#define MAXf(x,y) (_ftmp1=(x),_ftmp2=(y),(_ftmp1 > _ftmp2 ? _ftmp1 : _ftmp2))

#define SWAPi(x1,x2) (_itmp1 = x1, x1 = x2, x2 = _itmp1)
#define SWAPf(x1,x2) (_ftmp1 = x1, x1 = x2, x2 = _ftmp1)

#ifdef gen_code
int permute_sign1[4] = { -1,  1, 1,-1 };
int permute_sign2[4] = {  1, -1, 1,-1 };
#else
extern int permute_sign1[4];
extern int permute_sign2[4];
#endif

#define SIGN(s,x) ((s) < 0 ? (-(x)) : (x))


/*** define ROUND() which is used with all float calculations to round them to a specified number of digits ****/

extern double floor PARAMS((double number));
#define MAX_ERROR 1e-8
#define INV_MAX_ERROR 1e8
#define ROUND(x) (( floor( (double)(x)*INV_MAX_ERROR + 0.5 )*MAX_ERROR))

#define PI ((double)3.141592653589793238462643)


/****************************************************************************
*           FUNCTIONS IN VMATH_C.C
*****************************************************************************/

extern double portable_random PARAMS((long seed));

extern void init_random PARAMS((int seed));

extern int arbitrary PARAMS((int lo, int hi));

extern double portable_sine PARAMS((double radians));

extern double portable_cosine PARAMS((double radians));

extern double portable_sqrt PARAMS((double x));

extern void calc_abcf PARAMS((double x1, double y1, double x2, double y2, double *a, double *b, double *c));

extern void calc_abci PARAMS((int x1, int y1, int x2, int y2, int *a, int *b, int *c));

extern int lines_cross PARAMS((double a1, double b1, double c1, double a2, double b2, double c2, 
                               double *x_cross, double *y_cross));

extern void calc_point_extents PARAMS((int x, int y, extent_record *extent));

extern void calc_points_extents PARAMS((XPoint *points, int num_points, int mode, extent_record *extent));
                       
extern void calc_rectangle_extents PARAMS((int x, int y, unsigned int width, unsigned int height, int thickness,
                                           extent_record *extent));

extern void calc_rectangles_extents PARAMS((XRectangle *rectangles, int num_rectangles, int thickness, 
                                            extent_record *extent));

extern void calc_fill_rectangle_extents PARAMS((int x, int y, unsigned int width, unsigned int height,
                                                extent_record *extent));

extern void calc_fill_rectangles_extents PARAMS((XRectangle *rectangles, int num_rectangles, extent_record *extent));

extern void calc_segment_extents PARAMS((int x1, int y1, int x2, int y2, int thickness, int cap1, int cap2, 
                                         extent_record *extent));

extern void calc_segments_extents PARAMS((XSegment *segments, int num_segments, int thickness, int cap, 
                                          extent_record *extent));

extern void calc_lines_extents PARAMS((XPoint *points, int num_points, int thickness, int cap, int join, int mode,
                                       extent_record *extent));

extern void calc_join_extents PARAMS((int x1, int y1, int x2, int y2, int x3, int y3, int thickness, int join, 
                                      extent_record *extent));

extern void calc_arc_extents PARAMS((int x, int y, unsigned int width, unsigned int height, short angle1, short angle2,
                                     int thickness, int cap1, int cap2, extent_record *extent));

extern void calc_arcs_extents PARAMS((XArc *arcs, int num_arcs, int thickness, int cap, int join, extent_record *extent));

extern void calc_fill_arc_extents PARAMS((int x, int y, unsigned int width, unsigned int height, short angle1, short angle2,
                                          int arc_mode, extent_record *extent));

extern void calc_fill_arcs_extents PARAMS((XArc *arcs, int num_arcs, int arc_mode, extent_record *extent));

extern void copy_extents PARAMS((extent_record *extent1, extent_record *extent2));

extern void update_extents PARAMS((extent_record *extent1, extent_record *extent2));

#endif                                                                                                  
