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
>># File: xts5/Xlib17/XKeycodeToKeysym.m
>># 
>># Description:
>># 	Tests for XKeycodeToKeysym()
>># 
>># Modifications:
>># $Log: kycdtkysym.m,v $
>># Revision 1.2  2005-11-03 08:43:06  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:23  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:34:44  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:57:06  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:26:01  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:22:34  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.1  1996/05/09 21:03:05  andy
>># Fixed keysymdef include
>>#
>># Revision 4.0  1995/12/15  09:11:20  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:13:57  andy
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
>>TITLE XKeycodeToKeysym Xlib17
KeySym
XKeyCodeToKeysym(display, keycode, idx)
Display	*display = Dsp;
KeyCode	keycode;
int	idx;
>>EXTERN
#define XK_LATIN1
#include	"X11/keysymdef.h"
#undef XK_LATIN1
>>ASSERTION Good A
A call to xname returns the
.S KeySym
specified by element
.A index
of the
.S KeyCode
vector specified by the
.A keycode
argument.
>>STRATEGY
Obtain the KeyCode corresponding to KeySym XK_a using XKeysymToKeycode.
Obtain the KeySym corresponding to the KeyCode using xname with index = 0.
Verify that the KeySym returned is XK_a.
Obtain the KeySym corresponding to the KeyCode using xname with index = 1.
Verify that the KeySym returned is XK_A.
>>CODE
KeyCode	kc;
KeySym	ks;

	kc = XKeysymToKeycode(display, XK_a);

	if(kc == 0) {
		delete("XKeysymToKeycode() returned 0 for KeySym XK_a");
		return;
	} else
		CHECK;

	keycode = kc;
	idx = 0;
	ks = XCALL;

	if(ks != XK_a) {
		report("%s() returned KeySym %lu instead of %lu for KeyCode %lu and index %d.",
			TestName, (long) ks, (long) XK_a, (long) kc, idx);
		FAIL;
	} else
		CHECK;


	idx = 1;
	ks = XCALL;

	if(ks != XK_A) {
		report("%s() returned KeySym %lu instead of %lu for KeyCode %lu and index %d.",
			TestName, (long) ks, (long) XK_A, (long) kc, idx);
		FAIL;
	} else
		CHECK;

	CHECKPASS(3);

>>ASSERTION Good A
When the symbol specified by element
.A index
of the
.S KeyCode
vector specified by the
.A keycode
argument is not defined, then a call to
xname returns
.S NoSymbol . 
>>STRATEGY
Obtain the maximum keycode using XDisplayKeycodes.
Obtain the KeySym corresponding to the maximum KeyCode+1 using xname with index 0.
Verify that the call returned NoSymbol.
Obtain the KeySym corresponding to the minimum KeyCode using xname with index 9.
Verify that the call returned NoSymbol.
>>CODE
int	maxi,mini;
KeyCode	maxkc, minkc;
KeySym	ks;

	XDisplayKeycodes(display, &mini, &maxi);
	minkc = (KeyCode)mini;
	maxkc = (KeyCode)maxi;

	idx = 0;
	keycode = maxkc + 1;
	ks = XCALL;

	if(ks != NoSymbol) {
		report("%s() returned KeySym value %ul instead of NoSymbol (%lu) for KeyCode %lu and index %d.",
			TestName, (long) ks, (long) NoSymbol, (long) keycode, idx);
		FAIL;
	} else
		CHECK;

	keycode = minkc;
	idx = 9; /* only 0-8 are valid. */
	ks = XCALL;

	if(ks != NoSymbol) {
		report("%s() returned KeySym value %ul instead of NoSymbol (%lu) for KeyCode %lu and index %d.",
			TestName, (long) ks, (long) NoSymbol, (long) keycode, idx);
		FAIL;
	} else
		CHECK;

	CHECKPASS(2);
