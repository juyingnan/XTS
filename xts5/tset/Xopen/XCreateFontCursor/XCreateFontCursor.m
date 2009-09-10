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
$Header: /cvs/xtest/xtest/xts5/tset/Xopen/XCreateFontCursor/XCreateFontCursor.m,v 1.2 2005-11-03 08:44:00 jmichael Exp $

>># Project: VSW5
>># 
>># File: xts5/tset/XOPEN/XCreateFontCursor/XCreateFontCursor.m
>># 
>># Description:
>># 	Tests for XCreateFontCursor()
>># 
>># Modifications:
>># $Log: crtfntcrsr.m,v $
>># Revision 1.2  2005-11-03 08:44:00  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:40  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:35:30  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:57:58  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:26:44  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:23:17  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:13:22  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:16:38  andy
>># Prepare for GA Release
>>#
/*
     SCCS:  @(#)  crtfntcrsr.m Rel 1.5	    (11/25/91)

	UniSoft Ltd., London, England

(C) Copyright 1991 X/Open Company Limited

All rights reserved.  No part of this source code may be reproduced,
stored in a retrieval system, or transmitted, in any form or by any
means, electronic, mechanical, photocopying, recording or otherwise,
except as stated in the end-user licence agreement, without the prior
permission of the copyright owners.

X/Open and the 'X' symbol are trademarks of X/Open Company Limited in
the UK and other countries.
*/
>>TITLE XCreateFontCursor XOPEN
Cursor
XCreateFontCursor(display, shape)
Display *display = Dsp;
unsigned int shape;
>>SET startup fontstartup
>>SET cleanup fontcleanup
>>EXTERN
#include <X11/cursorfont.h>

/*
 * mkcolor() -	return a pointer to a color structure.
 *		flag indicates whether or not color is foreground
 * 		(Copied from rclrcrs.m.)
 */
static XColor *
mkcolor(flag)
{
	static	XColor	fore;
	static	XColor	back;
	static	int	first = 1;

	if (first)
	{
		first = 0;

		fore.pixel = BlackPixel(display, DefaultScreen(display));
		XQueryColor(display, DefaultColormap(display, DefaultScreen(display)), &fore);
		back.pixel = WhitePixel(display, DefaultScreen(display));
		XQueryColor(display, DefaultColormap(display, DefaultScreen(display)), &back);
	}
	return(flag ? &fore : &back);
}

static
void
test_font(symbol)
int	symbol;
{
Cursor	qstat;
Window w;
XVisualInfo *vp;
int     pass = 0, fail = 0;

/* Create windows. */
	for (resetvinf(VI_WIN); nextvinf(&vp); ) {
		w = makewin(display, vp);

		shape = symbol;

		trace("Shape used is %x", shape);
/* Call XCreateFontCursor with specified shape. */
	
		qstat = XCALL;

/* Verify that XCreateFontCursor returns non-zero. */
		if (qstat == 0) {
			report("On a call to XCreateFontCursor,");
			report("wrong value %ld was returned", (long) qstat);
			FAIL;
		} else
			CHECK;

/* Call XDefineCursor and verify that no error occurs. */
		startcall(display);
		if (isdeleted())
			return;
		XDefineCursor(display, w, qstat);
		endcall(display);
		if (geterr() != Success) {
			report("On a call to XDefineCursor,");
			report("Got %s, Expecting Success", errorname(geterr()));
			FAIL;
		}
		else
			CHECK;

/* Call XRecolorCursor and verify that no error occurs. */
		startcall(display);
		if (isdeleted())
			return;
		XRecolorCursor(display, qstat, mkcolor(1), mkcolor(0));
		endcall(display);
		if (geterr() != Success) {
			report("On a call to XRecolorCursor,");
			report("Got %s, Expecting Success", errorname(geterr()));
			FAIL;
		}
		else
			CHECK;

/* Call XFreeCursor and verify that no error occurs. */
		startcall(display);
		if (isdeleted())
			return;
		XFreeCursor(display, qstat);
		endcall(display);
		if (geterr() != Success) {
			report("On a call to XFreeCursor,");
			report("Got %s, Expecting Success", errorname(geterr()));
			FAIL;
		}
		else
			CHECK;
	}

	CHECKPASS(4*nvinf());
}

>>ASSERTION Good A
When the
.A shape 
argument is
.S XC_X_cursor ,
then a call to xname creates a
.S Cursor
and returns the cursor ID.
>>STRATEGY
Create windows.
Call XCreateFontCursor with shape XC_X_cursor.
Verify that XCreateFontCursor returns non-zero.
Call XDefineCursor and verify that no error occurs.
Call XRecolorCursor and verify that no error occurs.
Call XFreeCursor and verify that no error occurs.
>>CODE

	test_font(XC_X_cursor);

>>ASSERTION Good A
When the
.A shape 
argument is
.S XC_bottom_left_corner ,
then a call to xname creates a
.S Cursor
and returns the cursor ID.
>>STRATEGY
Create windows.
Call XCreateFontCursor with shape XC_bottom_left_corner.
Verify that XCreateFontCursor returns non-zero.
Call XDefineCursor and verify that no error occurs.
Call XRecolorCursor and verify that no error occurs.
Call XFreeCursor and verify that no error occurs.
>>CODE

	test_font(XC_bottom_left_corner);

>>ASSERTION Good A
When the
.A shape 
argument is
.S XC_bottom_right_corner ,
then a call to xname creates a
.S Cursor
and returns the cursor ID.
>>STRATEGY
Create windows.
Call XCreateFontCursor with shape XC_bottom_right_corner.
Verify that XCreateFontCursor returns non-zero.
Call XDefineCursor and verify that no error occurs.
Call XRecolorCursor and verify that no error occurs.
Call XFreeCursor and verify that no error occurs.
>>CODE

	test_font(XC_bottom_right_corner);

>>ASSERTION Good A
When the
.A shape 
argument is
.S XC_top_left_corner ,
then a call to xname creates a
.S Cursor
and returns the cursor ID.
>>STRATEGY
Create windows.
Call XCreateFontCursor with shape XC_top_left_corner.
Verify that XCreateFontCursor returns non-zero.
Call XDefineCursor and verify that no error occurs.
Call XRecolorCursor and verify that no error occurs.
Call XFreeCursor and verify that no error occurs.
>>CODE

	test_font(XC_top_left_corner);

>>ASSERTION Good A
When the
.A shape 
argument is
.S XC_top_right_corner ,
then a call to xname creates a
.S Cursor
and returns the cursor ID.
>>STRATEGY
Create windows.
Call XCreateFontCursor with shape XC_top_right_corner.
Verify that XCreateFontCursor returns non-zero.
Call XDefineCursor and verify that no error occurs.
Call XRecolorCursor and verify that no error occurs.
Call XFreeCursor and verify that no error occurs.
>>CODE

	test_font(XC_top_right_corner);

>>ASSERTION Good A
When the
.A shape 
argument is
.S XC_arrow ,
then a call to xname creates a
.S Cursor
and returns the cursor ID.
>>STRATEGY
Create windows.
Call XCreateFontCursor with shape XC_arrow.
Verify that XCreateFontCursor returns non-zero.
Call XDefineCursor and verify that no error occurs.
Call XRecolorCursor and verify that no error occurs.
Call XFreeCursor and verify that no error occurs.
>>CODE

	test_font(XC_arrow);

>>ASSERTION Good A
When the
.A shape 
argument is
.S XC_based_arrow_down ,
then a call to xname creates a
.S Cursor
and returns the cursor ID.
>>STRATEGY
Create windows.
Call XCreateFontCursor with shape XC_based_arrow_down.
Verify that XCreateFontCursor returns non-zero.
Call XDefineCursor and verify that no error occurs.
Call XRecolorCursor and verify that no error occurs.
Call XFreeCursor and verify that no error occurs.
>>CODE

	test_font(XC_based_arrow_down);

>>ASSERTION Good A
When the
.A shape 
argument is
.S XC_based_arrow_up ,
then a call to xname creates a
.S Cursor
and returns the cursor ID.
>>STRATEGY
Create windows.
Call XCreateFontCursor with shape XC_based_arrow_up.
Verify that XCreateFontCursor returns non-zero.
Call XDefineCursor and verify that no error occurs.
Call XRecolorCursor and verify that no error occurs.
Call XFreeCursor and verify that no error occurs.
>>CODE

	test_font(XC_based_arrow_up);

>>ASSERTION Good A
When the
.A shape 
argument is
.S XC_double_arrow ,
then a call to xname creates a
.S Cursor
and returns the cursor ID.
>>STRATEGY
Create windows.
Call XCreateFontCursor with shape XC_double_arrow.
Verify that XCreateFontCursor returns non-zero.
Call XDefineCursor and verify that no error occurs.
Call XRecolorCursor and verify that no error occurs.
Call XFreeCursor and verify that no error occurs.
>>CODE

	test_font(XC_double_arrow);

>>ASSERTION Good A
When the
.A shape 
argument is
.S XC_question_arrow ,
then a call to xname creates a
.S Cursor
and returns the cursor ID.
>>STRATEGY
Create windows.
Call XCreateFontCursor with shape XC_question_arrow.
Verify that XCreateFontCursor returns non-zero.
Call XDefineCursor and verify that no error occurs.
Call XRecolorCursor and verify that no error occurs.
Call XFreeCursor and verify that no error occurs.
>>CODE

	test_font(XC_question_arrow);

>>ASSERTION Good A
When the
.A shape 
argument is
.S XC_sb_h_double_arrow ,
then a call to xname creates a
.S Cursor
and returns the cursor ID.
>>STRATEGY
Create windows.
Call XCreateFontCursor with shape XC_sb_h_double_arrow.
Verify that XCreateFontCursor returns non-zero.
Call XDefineCursor and verify that no error occurs.
Call XRecolorCursor and verify that no error occurs.
Call XFreeCursor and verify that no error occurs.
>>CODE

	test_font(XC_sb_h_double_arrow);

>>ASSERTION Good A
When the
.A shape 
argument is
.S XC_sb_v_double_arrow ,
then a call to xname creates a
.S Cursor
and returns the cursor ID.
>>STRATEGY
Create windows.
Call XCreateFontCursor with shape XC_sb_v_double_arrow.
Verify that XCreateFontCursor returns non-zero.
Call XDefineCursor and verify that no error occurs.
Call XRecolorCursor and verify that no error occurs.
Call XFreeCursor and verify that no error occurs.
>>CODE

	test_font(XC_sb_v_double_arrow);

>>ASSERTION Good A
When the
.A shape 
argument is
.S XC_top_left_arrow ,
then a call to xname creates a
.S Cursor
and returns the cursor ID.
>>STRATEGY
Create windows.
Call XCreateFontCursor with shape XC_top_left_arrow.
Verify that XCreateFontCursor returns non-zero.
Call XDefineCursor and verify that no error occurs.
Call XRecolorCursor and verify that no error occurs.
Call XFreeCursor and verify that no error occurs.
>>CODE

	test_font(XC_top_left_arrow);

>>ASSERTION Good A
When the
.A shape 
argument is
.S XC_bottom_tee ,
then a call to xname creates a
.S Cursor
and returns the cursor ID.
>>STRATEGY
Create windows.
Call XCreateFontCursor with shape XC_bottom_tee.
Verify that XCreateFontCursor returns non-zero.
Call XDefineCursor and verify that no error occurs.
Call XRecolorCursor and verify that no error occurs.
Call XFreeCursor and verify that no error occurs.
>>CODE

	test_font(XC_bottom_tee);

>>ASSERTION Good A
When the
.A shape 
argument is
.S XC_left_tee ,
then a call to xname creates a
.S Cursor
and returns the cursor ID.
>>STRATEGY
Create windows.
Call XCreateFontCursor with shape XC_left_tee.
Verify that XCreateFontCursor returns non-zero.
Call XDefineCursor and verify that no error occurs.
Call XRecolorCursor and verify that no error occurs.
Call XFreeCursor and verify that no error occurs.
>>CODE

	test_font(XC_left_tee);

>>ASSERTION Good A
When the
.A shape 
argument is
.S XC_right_tee ,
then a call to xname creates a
.S Cursor
and returns the cursor ID.
>>STRATEGY
Create windows.
Call XCreateFontCursor with shape XC_right_tee.
Verify that XCreateFontCursor returns non-zero.
Call XDefineCursor and verify that no error occurs.
Call XRecolorCursor and verify that no error occurs.
Call XFreeCursor and verify that no error occurs.
>>CODE

	test_font(XC_right_tee);

>>ASSERTION Good A
When the
.A shape 
argument is
.S XC_top_tee ,
then a call to xname creates a
.S Cursor
and returns the cursor ID.
>>STRATEGY
Create windows.
Call XCreateFontCursor with shape XC_top_tee.
Verify that XCreateFontCursor returns non-zero.
Call XDefineCursor and verify that no error occurs.
Call XRecolorCursor and verify that no error occurs.
Call XFreeCursor and verify that no error occurs.
>>CODE

	test_font(XC_top_tee);

>>ASSERTION Good A
When the
.A shape 
argument is
.S XC_bottom_side ,
then a call to xname creates a
.S Cursor
and returns the cursor ID.
>>STRATEGY
Create windows.
Call XCreateFontCursor with shape XC_bottom_side.
Verify that XCreateFontCursor returns non-zero.
Call XDefineCursor and verify that no error occurs.
Call XRecolorCursor and verify that no error occurs.
Call XFreeCursor and verify that no error occurs.
>>CODE

	test_font(XC_bottom_side);

>>ASSERTION Good A
When the
.A shape 
argument is
.S XC_left_side ,
then a call to xname creates a
.S Cursor
and returns the cursor ID.
>>STRATEGY
Create windows.
Call XCreateFontCursor with shape XC_left_side.
Verify that XCreateFontCursor returns non-zero.
Call XDefineCursor and verify that no error occurs.
Call XRecolorCursor and verify that no error occurs.
Call XFreeCursor and verify that no error occurs.
>>CODE

	test_font(XC_left_side);

>>ASSERTION Good A
When the
.A shape 
argument is
.S XC_right_side ,
then a call to xname creates a
.S Cursor
and returns the cursor ID.
>>STRATEGY
Create windows.
Call XCreateFontCursor with shape XC_right_side.
Verify that XCreateFontCursor returns non-zero.
Call XDefineCursor and verify that no error occurs.
Call XRecolorCursor and verify that no error occurs.
Call XFreeCursor and verify that no error occurs.
>>CODE

	test_font(XC_right_side);

>>ASSERTION Good A
When the
.A shape 
argument is
.S XC_top_side ,
then a call to xname creates a
.S Cursor
and returns the cursor ID.
>>STRATEGY
Create windows.
Call XCreateFontCursor with shape XC_top_side.
Verify that XCreateFontCursor returns non-zero.
Call XDefineCursor and verify that no error occurs.
Call XRecolorCursor and verify that no error occurs.
Call XFreeCursor and verify that no error occurs.
>>CODE

	test_font(XC_top_side);

>>ASSERTION Good A
When the
.A shape 
argument is
.S XC_ll_angle ,
then a call to xname creates a
.S Cursor
and returns the cursor ID.
>>STRATEGY
Create windows.
Call XCreateFontCursor with shape XC_ll_angle.
Verify that XCreateFontCursor returns non-zero.
Call XDefineCursor and verify that no error occurs.
Call XRecolorCursor and verify that no error occurs.
Call XFreeCursor and verify that no error occurs.
>>CODE

	test_font(XC_ll_angle);

>>ASSERTION Good A
When the
.A shape 
argument is
.S XC_lr_angle ,
then a call to xname creates a
.S Cursor
and returns the cursor ID.
>>STRATEGY
Create windows.
Call XCreateFontCursor with shape XC_lr_angle.
Verify that XCreateFontCursor returns non-zero.
Call XDefineCursor and verify that no error occurs.
Call XRecolorCursor and verify that no error occurs.
Call XFreeCursor and verify that no error occurs.
>>CODE

	test_font(XC_lr_angle);

>>ASSERTION Good A
When the
.A shape 
argument is
.S XC_ul_angle ,
then a call to xname creates a
.S Cursor
and returns the cursor ID.
>>STRATEGY
Create windows.
Call XCreateFontCursor with shape XC_ul_angle.
Verify that XCreateFontCursor returns non-zero.
Call XDefineCursor and verify that no error occurs.
Call XRecolorCursor and verify that no error occurs.
Call XFreeCursor and verify that no error occurs.
>>CODE

	test_font(XC_ul_angle);

>>ASSERTION Good A
When the
.A shape 
argument is
.S XC_ur_angle ,
then a call to xname creates a
.S Cursor
and returns the cursor ID.
>>STRATEGY
Create windows.
Call XCreateFontCursor with shape XC_ur_angle.
Verify that XCreateFontCursor returns non-zero.
Call XDefineCursor and verify that no error occurs.
Call XRecolorCursor and verify that no error occurs.
Call XFreeCursor and verify that no error occurs.
>>CODE

	test_font(XC_ur_angle);

>>ASSERTION Good A
When the
.A shape 
argument is
.S XC_circle ,
then a call to xname creates a
.S Cursor
and returns the cursor ID.
>>STRATEGY
Create windows.
Call XCreateFontCursor with shape XC_circle.
Verify that XCreateFontCursor returns non-zero.
Call XDefineCursor and verify that no error occurs.
Call XRecolorCursor and verify that no error occurs.
Call XFreeCursor and verify that no error occurs.
>>CODE

	test_font(XC_circle);

>>ASSERTION Good A
When the
.A shape 
argument is
.S XC_cross ,
then a call to xname creates a
.S Cursor
and returns the cursor ID.
>>STRATEGY
Create windows.
Call XCreateFontCursor with shape XC_cross.
Verify that XCreateFontCursor returns non-zero.
Call XDefineCursor and verify that no error occurs.
Call XRecolorCursor and verify that no error occurs.
Call XFreeCursor and verify that no error occurs.
>>CODE

	test_font(XC_cross);

>>ASSERTION Good A
When the
.A shape 
argument is
.S XC_crosshair ,
then a call to xname creates a
.S Cursor
and returns the cursor ID.
>>STRATEGY
Create windows.
Call XCreateFontCursor with shape XC_crosshair.
Verify that XCreateFontCursor returns non-zero.
Call XDefineCursor and verify that no error occurs.
Call XRecolorCursor and verify that no error occurs.
Call XFreeCursor and verify that no error occurs.
>>CODE

	test_font(XC_crosshair);

>>ASSERTION Good A
When the
.A shape 
argument is
.S XC_center_ptr ,
then a call to xname creates a
.S Cursor
and returns the cursor ID.
>>STRATEGY
Create windows.
Call XCreateFontCursor with shape XC_center_ptr.
Verify that XCreateFontCursor returns non-zero.
Call XDefineCursor and verify that no error occurs.
Call XRecolorCursor and verify that no error occurs.
Call XFreeCursor and verify that no error occurs.
>>CODE

	test_font(XC_center_ptr);

>>ASSERTION Good A
When the
.A shape 
argument is
.S XC_left_ptr ,
then a call to xname creates a
.S Cursor
and returns the cursor ID.
>>STRATEGY
Create windows.
Call XCreateFontCursor with shape XC_left_ptr.
Verify that XCreateFontCursor returns non-zero.
Call XDefineCursor and verify that no error occurs.
Call XRecolorCursor and verify that no error occurs.
Call XFreeCursor and verify that no error occurs.
>>CODE

	test_font(XC_left_ptr);

>>ASSERTION Good A
When the
.A shape 
argument is
.S XC_right_ptr ,
then a call to xname creates a
.S Cursor
and returns the cursor ID.
>>STRATEGY
Create windows.
Call XCreateFontCursor with shape XC_right_ptr.
Verify that XCreateFontCursor returns non-zero.
Call XDefineCursor and verify that no error occurs.
Call XRecolorCursor and verify that no error occurs.
Call XFreeCursor and verify that no error occurs.
>>CODE

	test_font(XC_right_ptr);

