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

Copyright (c) Applied Testing and Technology, Inc. 1995
All Rights Reserved.

>># Project: VSW5
>># 
>># File: xts5/Xlib13/XGetPointerControl.m
>># 
>># Description:
>># 	Tests for XGetPointerControl()
>># 
>># Modifications:
>># $Log: gtpntrcntr.m,v $
>># Revision 1.2  2005-11-03 08:42:40  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:19  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:33:40  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:55:21  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:25:04  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:21:36  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:08:31  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:09:48  andy
>># Prepare for GA Release
>>#
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
>>TITLE XGetPointerControl Xlib13
void

Display	*display = Dsp;
int 	*accel_numerator_return = &num;
int 	*accel_denominator_return = &denom;
int 	*threshold_return = &thresh;
>>EXTERN

#include "XFuzz.h"
static int 	num;
static int 	denom;
static int 	thresh;

>>ASSERTION Good A
A call to xname returns the current acceleration multiplier
and acceleration threshold to
.A accel_numerator_return ,
.A accel_denominator_return
and
.A threshold_return .
>>STRATEGY
Set some values.
Call xname.
Verify values are as set.
>>CODE
int 	onum, odenom, othresh;
int 	val = 34;

	/* First get original values */
	accel_numerator_return = &onum;
	accel_denominator_return = &odenom;
	threshold_return = &othresh;
	XCALL;

	XChangePointerControl(display, True, True, val, val, val);
	if (isdeleted())
		return;

	accel_numerator_return = &num;
	accel_denominator_return = &denom;
	threshold_return = &thresh;
	XCALL;

	if (num == val)
		CHECK;
	else {
		report("accel_numerator_return was %d, expecting %d", num, val);
		FAIL;
	}
	if (denom == val)
		CHECK;
	else {
		report("accel_denominator_return was %d, expecting %d", denom, val);
		FAIL;
	}
	if (thresh == val)
		CHECK;
	else {
		report("threshold_return was %d, expecting %d", thresh, val);
		FAIL;
	}

	CHECKPASS(3);

	XChangePointerControl(display, True, True, onum, odenom, othresh);
	XSync(display, False);
>>ASSERTION Good A
A call to xname returns the current acceleration multiplier
and acceleration threshold to
.A accel_numerator_return ,
.A accel_denominator_return
and
.A threshold_return .
>>STRATEGY
Set some values.
Call xname.
Verify values are as set.
>>CODE
int 	onum, odenom, othresh;
int 	val = 34;
int 		count;

for(count = 0; count < FUZZ_MAX; count ++){
	val = rand () % 1000;
	/* First get original values */
	accel_numerator_return = &onum;
	accel_denominator_return = &odenom;
	threshold_return = &othresh;
	XCALL;

	XChangePointerControl(display, True, True, val, val, val);
	if (isdeleted())
		return;

	accel_numerator_return = &num;
	accel_denominator_return = &denom;
	threshold_return = &thresh;
	XCALL;

	if (num == val)
		CHECK;
	else {
		report("accel_numerator_return was %d, expecting %d", num, val);
		FAIL;
	}
	if (denom == val)
		CHECK;
	else {
		report("accel_denominator_return was %d, expecting %d", denom, val);
		FAIL;
	}
	if (thresh == val)
		CHECK;
	else {
		report("threshold_return was %d, expecting %d", thresh, val);
		FAIL;
	}
}

	CHECKPASS(3 * FUZZ_MAX);

	XChangePointerControl(display, True, True, onum, odenom, othresh);
	XSync(display, False);
