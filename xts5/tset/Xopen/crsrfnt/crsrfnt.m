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
$Header: /cvs/xtest/xtest/xts5/tset/Xopen/crsrfnt/crsrfnt.m,v 1.1 2005-02-12 14:37:43 anderson Exp $

>># Project: VSW5
>># 
>># File: vsw5/tset/XOPEN/crsrfnt/crsrfnt.m
>># 
>># Description:
>># 	Tests for cursorfont()
>># 
>># Modifications:
>># $Log: crsrfnt.m,v $
>># Revision 1.1  2005-02-12 14:37:43  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:35:28  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:57:57  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:26:43  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:23:16  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:13:18  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:16:33  andy
>># Prepare for GA Release
>>#
/*
      SCCS:  @(#)  crsrfnt.m Rel 1.6	    (11/25/91)

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
>>TITLE cursorfont XOPEN
>>EXTERN
#include	<X11/cursorfont.h>
>>ASSERTION Good A
When the header file <X11/cursorfont.h> is included, 
then the symbol 
.S XC_X_cursor
is defined with the value 0.
>>STRATEGY
Include the file <X11/cursorfont.h>
Verify that the symbol XC_X_cursor is defined.
Verify that the symbol is defined to have value 0.
>>CODE

#ifdef XC_X_cursor

#	if	(XC_X_cursor == 0)
		PASS;
#	else
		report("XC_X_cursor was defined to have value %ld instead of 0.", (long) XC_X_cursor);
		FAIL;
#	endif

#else
	report("XC_X_cursor is not defined.");
	FAIL;
#endif

>>ASSERTION Good A
When the header file <X11/cursorfont.h> is included, 
then the symbol 
.S XC_bottom_left_corner
is defined with the value 12.
>>STRATEGY
Include the file <X11/cursorfont.h>
Verify that the symbol XC_bottom_left_corner is defined.
Verify that the symbol is defined to have value 12.
>>CODE

#ifdef XC_bottom_left_corner

#	if	(XC_bottom_left_corner == 12)
		PASS;
#	else
		report("XC_bottom_left_corner was defined to have value %ld instead of 12.", (long) XC_bottom_left_corner);
		FAIL;
#	endif

#else
	report("XC_bottom_left_corner is not defined.");
	FAIL;
#endif

>>ASSERTION Good A
When the header file <X11/cursorfont.h> is included, 
then the symbol 
.S XC_bottom_right_corner
is defined with the value 14.
>>STRATEGY
Include the file <X11/cursorfont.h>
Verify that the symbol XC_bottom_right_corner is defined.
Verify that the symbol is defined to have value 14.
>>CODE

#ifdef XC_bottom_right_corner

#	if	(XC_bottom_right_corner == 14)
		PASS;
#	else
		report("XC_bottom_right_corner was defined to have value %ld instead of 14.", (long) XC_bottom_right_corner);
		FAIL;
#	endif

#else
	report("XC_bottom_right_corner is not defined.");
	FAIL;
#endif

>>ASSERTION Good A
When the header file <X11/cursorfont.h> is included, 
then the symbol 
.S XC_top_left_corner
is defined with the value 134.
>>STRATEGY
Include the file <X11/cursorfont.h>
Verify that the symbol XC_top_left_corner is defined.
Verify that the symbol is defined to have value 134.
>>CODE

#ifdef XC_top_left_corner

#	if	(XC_top_left_corner == 134)
		PASS;
#	else
		report("XC_top_left_corner was defined to have value %ld instead of 134.", (long) XC_top_left_corner);
		FAIL;
#	endif

#else
	report("XC_top_left_corner is not defined.");
	FAIL;
#endif

>>ASSERTION Good A
When the header file <X11/cursorfont.h> is included, 
then the symbol 
.S XC_top_right_corner
is defined with the value 136.
>>STRATEGY
Include the file <X11/cursorfont.h>
Verify that the symbol XC_top_right_corner is defined.
Verify that the symbol is defined to have value 136.
>>CODE

#ifdef XC_top_right_corner

#	if	(XC_top_right_corner == 136)
		PASS;
#	else
		report("XC_top_right_corner was defined to have value %ld instead of 136.", (long) XC_top_right_corner);
		FAIL;
#	endif

#else
	report("XC_top_right_corner is not defined.");
	FAIL;
#endif

>>ASSERTION Good A
When the header file <X11/cursorfont.h> is included, 
then the symbol 
.S XC_arrow
is defined with the value 2.
>>STRATEGY
Include the file <X11/cursorfont.h>
Verify that the symbol XC_arrow is defined.
Verify that the symbol is defined to have value 2.
>>CODE

#ifdef XC_arrow

#	if	(XC_arrow == 2)
		PASS;
#	else
		report("XC_arrow was defined to have value %ld instead of 2.", (long) XC_arrow);
		FAIL;
#	endif

#else
	report("XC_arrow is not defined.");
	FAIL;
#endif

>>ASSERTION Good A
When the header file <X11/cursorfont.h> is included, 
then the symbol 
.S XC_based_arrow_down
is defined with the value 4.
>>STRATEGY
Include the file <X11/cursorfont.h>
Verify that the symbol XC_based_arrow_down is defined.
Verify that the symbol is defined to have value 4.
>>CODE

#ifdef XC_based_arrow_down

#	if	(XC_based_arrow_down == 4)
		PASS;
#	else
		report("XC_based_arrow_down was defined to have value %ld instead of 4.", (long) XC_based_arrow_down);
		FAIL;
#	endif

#else
	report("XC_based_arrow_down is not defined.");
	FAIL;
#endif

>>ASSERTION Good A
When the header file <X11/cursorfont.h> is included, 
then the symbol 
.S XC_based_arrow_up
is defined with the value 6.
>>STRATEGY
Include the file <X11/cursorfont.h>
Verify that the symbol XC_based_arrow_up is defined.
Verify that the symbol is defined to have value 6.
>>CODE

#ifdef XC_based_arrow_up

#	if	(XC_based_arrow_up == 6)
		PASS;
#	else
		report("XC_based_arrow_up was defined to have value %ld instead of 6.", (long) XC_based_arrow_up);
		FAIL;
#	endif

#else
	report("XC_based_arrow_up is not defined.");
	FAIL;
#endif

>>ASSERTION Good A
When the header file <X11/cursorfont.h> is included, 
then the symbol 
.S XC_double_arrow
is defined with the value 42.
>>STRATEGY
Include the file <X11/cursorfont.h>
Verify that the symbol XC_double_arrow is defined.
Verify that the symbol is defined to have value 42.
>>CODE

#ifdef XC_double_arrow

#	if	(XC_double_arrow == 42)
		PASS;
#	else
		report("XC_double_arrow was defined to have value %ld instead of 42.", (long) XC_double_arrow);
		FAIL;
#	endif

#else
	report("XC_double_arrow is not defined.");
	FAIL;
#endif

>>ASSERTION Good A
When the header file <X11/cursorfont.h> is included, 
then the symbol 
.S XC_question_arrow
is defined with the value 92.
>>STRATEGY
Include the file <X11/cursorfont.h>
Verify that the symbol XC_question_arrow is defined.
Verify that the symbol is defined to have value 92.
>>CODE

#ifdef XC_question_arrow

#	if	(XC_question_arrow == 92)
		PASS;
#	else
		report("XC_question_arrow was defined to have value %ld instead of 92.", (long) XC_question_arrow);
		FAIL;
#	endif

#else
	report("XC_question_arrow is not defined.");
	FAIL;
#endif

>>ASSERTION Good A
When the header file <X11/cursorfont.h> is included, 
then the symbol 
.S XC_sb_h_double_arrow
is defined with the value 108.
>>STRATEGY
Include the file <X11/cursorfont.h>
Verify that the symbol XC_sb_h_double_arrow is defined.
Verify that the symbol is defined to have value 108.
>>CODE

#ifdef XC_sb_h_double_arrow

#	if	(XC_sb_h_double_arrow == 108)
		PASS;
#	else
		report("XC_sb_h_double_arrow was defined to have value %ld instead of 108.", (long) XC_sb_h_double_arrow);
		FAIL;
#	endif

#else
	report("XC_sb_h_double_arrow is not defined.");
	FAIL;
#endif

>>ASSERTION Good A
When the header file <X11/cursorfont.h> is included, 
then the symbol 
.S XC_sb_v_double_arrow
is defined with the value 116.
>>STRATEGY
Include the file <X11/cursorfont.h>
Verify that the symbol XC_sb_v_double_arrow is defined.
Verify that the symbol is defined to have value 116.
>>CODE

#ifdef XC_sb_v_double_arrow

#	if	(XC_sb_v_double_arrow == 116)
		PASS;
#	else
		report("XC_sb_v_double_arrow was defined to have value %ld instead of 116.", (long) XC_sb_v_double_arrow);
		FAIL;
#	endif

#else
	report("XC_sb_v_double_arrow is not defined.");
	FAIL;
#endif

>>ASSERTION Good A
When the header file <X11/cursorfont.h> is included, 
then the symbol 
.S XC_top_left_arrow
is defined with the value 132.
>>STRATEGY
Include the file <X11/cursorfont.h>
Verify that the symbol XC_top_left_arrow is defined.
Verify that the symbol is defined to have value 132.
>>CODE

#ifdef XC_top_left_arrow

#	if	(XC_top_left_arrow == 132)
		PASS;
#	else
		report("XC_top_left_arrow was defined to have value %ld instead of 132.", (long) XC_top_left_arrow);
		FAIL;
#	endif

#else
	report("XC_top_left_arrow is not defined.");
	FAIL;
#endif

>>ASSERTION Good A
When the header file <X11/cursorfont.h> is included, 
then the symbol 
.S XC_bottom_tee
is defined with the value 18.
>>STRATEGY
Include the file <X11/cursorfont.h>
Verify that the symbol XC_bottom_tee is defined.
Verify that the symbol is defined to have value 18.
>>CODE

#ifdef XC_bottom_tee

#	if	(XC_bottom_tee == 18)
		PASS;
#	else
		report("XC_bottom_tee was defined to have value %ld instead of 18.", (long) XC_bottom_tee);
		FAIL;
#	endif

#else
	report("XC_bottom_tee is not defined.");
	FAIL;
#endif

>>ASSERTION Good A
When the header file <X11/cursorfont.h> is included, 
then the symbol 
.S XC_left_tee
is defined with the value 72.
>>STRATEGY
Include the file <X11/cursorfont.h>
Verify that the symbol XC_left_tee is defined.
Verify that the symbol is defined to have value 72.
>>CODE

#ifdef XC_left_tee

#	if	(XC_left_tee == 72)
		PASS;
#	else
		report("XC_left_tee was defined to have value %ld instead of 72.", (long) XC_left_tee);
		FAIL;
#	endif

#else
	report("XC_left_tee is not defined.");
	FAIL;
#endif

>>ASSERTION Good A
When the header file <X11/cursorfont.h> is included, 
then the symbol 
.S XC_right_tee
is defined with the value 98.
>>STRATEGY
Include the file <X11/cursorfont.h>
Verify that the symbol XC_right_tee is defined.
Verify that the symbol is defined to have value 98.
>>CODE

#ifdef XC_right_tee

#	if	(XC_right_tee == 98)
		PASS;
#	else
		report("XC_right_tee was defined to have value %ld instead of 98.", (long) XC_right_tee);
		FAIL;
#	endif

#else
	report("XC_right_tee is not defined.");
	FAIL;
#endif

>>ASSERTION Good A
When the header file <X11/cursorfont.h> is included, 
then the symbol 
.S XC_top_tee
is defined with the value 140.
>>STRATEGY
Include the file <X11/cursorfont.h>
Verify that the symbol XC_top_tee is defined.
Verify that the symbol is defined to have value 140.
>>CODE

#ifdef XC_top_tee

#	if	(XC_top_tee == 140)
		PASS;
#	else
		report("XC_top_tee was defined to have value %ld instead of 140.", (long) XC_top_tee);
		FAIL;
#	endif

#else
	report("XC_top_tee is not defined.");
	FAIL;
#endif

>>ASSERTION Good A
When the header file <X11/cursorfont.h> is included, 
then the symbol 
.S XC_bottom_side
is defined with the value 16.
>>STRATEGY
Include the file <X11/cursorfont.h>
Verify that the symbol XC_bottom_side is defined.
Verify that the symbol is defined to have value 16.
>>CODE

#ifdef XC_bottom_side

#	if	(XC_bottom_side == 16)
		PASS;
#	else
		report("XC_bottom_side was defined to have value %ld instead of 16.", (long) XC_bottom_side);
		FAIL;
#	endif

#else
	report("XC_bottom_side is not defined.");
	FAIL;
#endif

>>ASSERTION Good A
When the header file <X11/cursorfont.h> is included, 
then the symbol 
.S XC_left_side
is defined with the value 70.
>>STRATEGY
Include the file <X11/cursorfont.h>
Verify that the symbol XC_left_side is defined.
Verify that the symbol is defined to have value 70.
>>CODE

#ifdef XC_left_side

#	if	(XC_left_side == 70)
		PASS;
#	else
		report("XC_left_side was defined to have value %ld instead of 70.", (long) XC_left_side);
		FAIL;
#	endif

#else
	report("XC_left_side is not defined.");
	FAIL;
#endif

>>ASSERTION Good A
When the header file <X11/cursorfont.h> is included, 
then the symbol 
.S XC_right_side
is defined with the value 96.
>>STRATEGY
Include the file <X11/cursorfont.h>
Verify that the symbol XC_right_side is defined.
Verify that the symbol is defined to have value 96.
>>CODE

#ifdef XC_right_side

#	if	(XC_right_side == 96)
		PASS;
#	else
		report("XC_right_side was defined to have value %ld instead of 96.", (long) XC_right_side);
		FAIL;
#	endif

#else
	report("XC_right_side is not defined.");
	FAIL;
#endif

>>ASSERTION Good A
When the header file <X11/cursorfont.h> is included, 
then the symbol 
.S XC_top_side
is defined with the value 138.
>>STRATEGY
Include the file <X11/cursorfont.h>
Verify that the symbol XC_top_side is defined.
Verify that the symbol is defined to have value 138.
>>CODE

#ifdef XC_top_side

#	if	(XC_top_side == 138)
		PASS;
#	else
		report("XC_top_side was defined to have value %ld instead of 138.", (long) XC_top_side);
		FAIL;
#	endif

#else
	report("XC_top_side is not defined.");
	FAIL;
#endif

>>ASSERTION Good A
When the header file <X11/cursorfont.h> is included, 
then the symbol 
.S XC_ll_angle
is defined with the value 76.
>>STRATEGY
Include the file <X11/cursorfont.h>
Verify that the symbol XC_ll_angle is defined.
Verify that the symbol is defined to have value 76.
>>CODE

#ifdef XC_ll_angle

#	if	(XC_ll_angle == 76)
		PASS;
#	else
		report("XC_ll_angle was defined to have value %ld instead of 76.", (long) XC_ll_angle);
		FAIL;
#	endif

#else
	report("XC_ll_angle is not defined.");
	FAIL;
#endif

>>ASSERTION Good A
When the header file <X11/cursorfont.h> is included, 
then the symbol 
.S XC_lr_angle
is defined with the value 78.
>>STRATEGY
Include the file <X11/cursorfont.h>
Verify that the symbol XC_lr_angle is defined.
Verify that the symbol is defined to have value 78.
>>CODE

#ifdef XC_lr_angle

#	if	(XC_lr_angle == 78)
		PASS;
#	else
		report("XC_lr_angle was defined to have value %ld instead of 78.", (long) XC_lr_angle);
		FAIL;
#	endif

#else
	report("XC_lr_angle is not defined.");
	FAIL;
#endif

>>ASSERTION Good A
When the header file <X11/cursorfont.h> is included, 
then the symbol 
.S XC_ul_angle
is defined with the value 144.
>>STRATEGY
Include the file <X11/cursorfont.h>
Verify that the symbol XC_ul_angle is defined.
Verify that the symbol is defined to have value 144.
>>CODE

#ifdef XC_ul_angle

#	if	(XC_ul_angle == 144)
		PASS;
#	else
		report("XC_ul_angle was defined to have value %ld instead of 144.", (long) XC_ul_angle);
		FAIL;
#	endif

#else
	report("XC_ul_angle is not defined.");
	FAIL;
#endif

>>ASSERTION Good A
When the header file <X11/cursorfont.h> is included, 
then the symbol 
.S XC_ur_angle
is defined with the value 148.
>>STRATEGY
Include the file <X11/cursorfont.h>
Verify that the symbol XC_ur_angle is defined.
Verify that the symbol is defined to have value 148.
>>CODE

#ifdef XC_ur_angle

#	if	(XC_ur_angle == 148)
		PASS;
#	else
		report("XC_ur_angle was defined to have value %ld instead of 148.", (long) XC_ur_angle);
		FAIL;
#	endif

#else
	report("XC_ur_angle is not defined.");
	FAIL;
#endif

>>ASSERTION Good A
When the header file <X11/cursorfont.h> is included, 
then the symbol 
.S XC_circle
is defined with the value 24.
>>STRATEGY
Include the file <X11/cursorfont.h>
Verify that the symbol XC_circle is defined.
Verify that the symbol is defined to have value 24.
>>CODE

#ifdef XC_circle

#	if	(XC_circle == 24)
		PASS;
#	else
		report("XC_circle was defined to have value %ld instead of 24.", (long) XC_circle);
		FAIL;
#	endif

#else
	report("XC_circle is not defined.");
	FAIL;
#endif

>>ASSERTION Good A
When the header file <X11/cursorfont.h> is included, 
then the symbol 
.S XC_cross
is defined with the value 30.
>>STRATEGY
Include the file <X11/cursorfont.h>
Verify that the symbol XC_cross is defined.
Verify that the symbol is defined to have value 30.
>>CODE

#ifdef XC_cross

#	if	(XC_cross == 30)
		PASS;
#	else
		report("XC_cross was defined to have value %ld instead of 30.", (long) XC_cross);
		FAIL;
#	endif

#else
	report("XC_cross is not defined.");
	FAIL;
#endif

>>ASSERTION Good A
When the header file <X11/cursorfont.h> is included, 
then the symbol 
.S XC_crosshair
is defined with the value 34.
>>STRATEGY
Include the file <X11/cursorfont.h>
Verify that the symbol XC_crosshair is defined.
Verify that the symbol is defined to have value 34.
>>CODE

#ifdef XC_crosshair

#	if	(XC_crosshair == 34)
		PASS;
#	else
		report("XC_crosshair was defined to have value %ld instead of 34.", (long) XC_crosshair);
		FAIL;
#	endif

#else
	report("XC_crosshair is not defined.");
	FAIL;
#endif

>>ASSERTION Good A
When the header file <X11/cursorfont.h> is included, 
then the symbol 
.S XC_center_ptr
is defined with the value 22.
>>STRATEGY
Include the file <X11/cursorfont.h>
Verify that the symbol XC_center_ptr is defined.
Verify that the symbol is defined to have value 22.
>>CODE

#ifdef XC_center_ptr

#	if	(XC_center_ptr == 22)
		PASS;
#	else
		report("XC_center_ptr was defined to have value %ld instead of 22.", (long) XC_center_ptr);
		FAIL;
#	endif

#else
	report("XC_center_ptr is not defined.");
	FAIL;
#endif

>>ASSERTION Good A
When the header file <X11/cursorfont.h> is included, 
then the symbol 
.S XC_left_ptr
is defined with the value 68.
>>STRATEGY
Include the file <X11/cursorfont.h>
Verify that the symbol XC_left_ptr is defined.
Verify that the symbol is defined to have value 68.
>>CODE

#ifdef XC_left_ptr

#	if	(XC_left_ptr == 68)
		PASS;
#	else
		report("XC_left_ptr was defined to have value %ld instead of 68.", (long) XC_left_ptr);
		FAIL;
#	endif

#else
	report("XC_left_ptr is not defined.");
	FAIL;
#endif

>>ASSERTION Good A
When the header file <X11/cursorfont.h> is included, 
then the symbol 
.S XC_right_ptr
is defined with the value 94.
>>STRATEGY
Include the file <X11/cursorfont.h>
Verify that the symbol XC_right_ptr is defined.
Verify that the symbol is defined to have value 94.
>>CODE

#ifdef XC_right_ptr

#	if	(XC_right_ptr == 94)
		PASS;
#	else
		report("XC_right_ptr was defined to have value %ld instead of 94.", (long) XC_right_ptr);
		FAIL;
#	endif

#else
	report("XC_right_ptr is not defined.");
	FAIL;
#endif

>>ASSERTION Good A
When the header file <X11/cursorfont.h> is included, 
then the symbol 
.S XC_num_glyphs
is defined with a value which is even and is not less than 150.
>>STRATEGY
Include the file <X11/cursorfont.h>
Verify that the symbol XC_num_glyphs is defined.
Verify that the sumbol value is even.
Verify that the symbol is defined to have value not less than 150.
>>CODE

#ifdef XC_num_glyphs

	if(XC_num_glyphs < 150) {
		report("XC_num_glyphs (value %ld) is less than 150.", (long) XC_num_glyphs);
		FAIL;
	} else
		CHECK;
	
	if(XC_num_glyphs % 2 != 0) {
		report("XC_num_glyphs (value %ld) is not even.", (long) XC_num_glyphs);
		FAIL;
	} else
		CHECK;

	CHECKPASS(2);
#else
	report("XC_num_glyphs is not defined.");
	FAIL;
#endif

