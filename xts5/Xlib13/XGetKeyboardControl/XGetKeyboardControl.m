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
$Header: /cvs/xtest/xtest/xts5/tset/Xlib13/XGetKeyboardControl/XGetKeyboardControl.m,v 1.2 2005-11-03 08:42:39 jmichael Exp $

Copyright (c) Applied Testing and Technology, Inc. 1995
All Rights Reserved.

>># Project: VSW5
>># 
>># File: xts5/tset/Xlib13/XGetKeyboardControl/XGetKeyboardControl.m
>># 
>># Description:
>># 	Tests for XGetKeyboardControl()
>># 
>># Modifications:
>># $Log: gtkybrdcnt.m,v $
>># Revision 1.2  2005-11-03 08:42:39  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:19  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:33:39  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:55:18  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:25:02  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:21:34  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:08:27  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:09:42  andy
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
>>TITLE XGetKeyboardControl Xlib13
void

Display	*display = Dsp;
XKeyboardState	*values_return = &Ksvals;
>>EXTERN

static XKeyboardState	Ksvals;

>>ASSERTION Good A
A call to xname returns the current control values for the keyboard to
.A values_return .
>>STRATEGY
Set some keyboard values with XChangeKeyboardControl.
Call xname to get values.
Verify values are as set.
>>CODE
XKeyboardControl	kset;
XKeyboardState	oldkb;

	/*
	 * Actually first we save the original values.
	 */
	values_return = &oldkb;
	XCALL;

	kset.key_click_percent = 21;
	kset.bell_percent = 12;
	kset.bell_pitch = 402;
	kset.bell_duration = 222;

	XChangeKeyboardControl(display, KBKeyClickPercent|KBBellPercent|KBBellPitch|KBBellDuration, &kset);

	if (isdeleted())
		return;

	values_return = &Ksvals;
	XCALL;

	if (values_return->key_click_percent == kset.key_click_percent)
		CHECK;
	else {
		report("Value of key_click_percent was %d, expecting %d",
			values_return->key_click_percent, kset.key_click_percent);
		FAIL;
	}
	if (values_return->bell_percent == kset.bell_percent)
		CHECK;
	else {
		report("Value of bell_percent was %d, expecting %d",
			values_return->bell_percent, kset.bell_percent);
		FAIL;
	}
	if (values_return->bell_pitch == kset.bell_pitch)
		CHECK;
	else {
		report("Value of bell_pitch was %d, expecting %d",
			values_return->bell_pitch, kset.bell_pitch);
		FAIL;
	}
	if (values_return->bell_duration == kset.bell_duration)
		CHECK;
	else {
		report("Value of bell_duration was %d, expecting %d",
			values_return->bell_duration, kset.bell_duration);
		FAIL;
	}

	CHECKPASS(4);

	/*
	 * Attempt to restore the original values.
	 */
	kset.key_click_percent = oldkb.key_click_percent;
	kset.bell_percent = oldkb.bell_percent;
	kset.bell_pitch = oldkb.bell_pitch;
	kset.bell_duration = oldkb.bell_duration;

	XChangeKeyboardControl(display, KBKeyClickPercent|KBBellPercent|KBBellPitch|KBBellDuration, &kset);

	XSync(display, False);
