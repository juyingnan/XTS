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
>># File: xts5/Xlib12/XSynchronize.m
>># 
>># Description:
>># 	Tests for XSynchronize()
>># 
>># Modifications:
>># $Log: synchrnz.m,v $
>># Revision 1.2  2005-11-03 08:42:37  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:18  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:33:29  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:55:01  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:24:54  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:21:26  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:07:56  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:08:41  andy
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
>>TITLE XSynchronize Xlib12
int ((*)())()
XSynchronize(display, onoff)
Display *display = Dsp;
Bool onoff;
>>EXTERN
static int
afterfunction(display)
Display *display;
{
	return((int) display);
}
>>ASSERTION Good B 1
>>#NOTE Untestable.
A call to xname
with
.A onoff
set to
.S True
turns on synchronous behavior.
>>ASSERTION Good B 1
>>#NOTE Untestable.
A call to xname
with
.A onoff
set to
.S False
turns off synchronous behavior.
>>ASSERTION Good A
A call to xname
with
.A onoff
set to
.S True
sets the after function to a non-NULL value.
>>STRATEGY
Call XSynchronize with onoff set to True.
Call XSetAfterFunction to get value of old after function.
Verify that XSetAfterFunction returned non-NULL.
>>CODE
int	(*proc)();

/* Call XSynchronize with onoff set to True. */
	onoff = True;
	XCALL;
/* Call XSetAfterFunction to get value of old after function. */
	proc = XSetAfterFunction(display, afterfunction);
/* Verify that XSetAfterFunction returned non-NULL. */
	if (proc == (int (*)()) NULL) {
		report("Returned NULL, expected non-NULL.");
		FAIL;
	}
	else
		CHECK;
	CHECKPASS(1);
>>ASSERTION Good A
A call to xname
with
.A onoff
set to
.S False
sets the after function to NULL.
>>STRATEGY
Call XSynchronize with onoff set to False.
Call XSetAfterFunction to get value of old after function.
Verify that XSetAfterFunction returned NULL.
>>CODE
int	(*proc)();

/* Call XSynchronize with onoff set to False. */
	onoff = False;
	XCALL;
/* Call XSetAfterFunction to get value of old after function. */
	proc = XSetAfterFunction(display, afterfunction);
/* Verify that XSetAfterFunction returned NULL. */
	if (proc != (int (*)()) NULL) {
		report("Returned non-NULL, expected NULL.");
		FAIL;
	}
	else
		CHECK;
	CHECKPASS(1);
>>ASSERTION Good A
A call to xname
returns the previous after function.
>>STRATEGY
Call XSetAfterFunction to set after function to afterfunction.
Call XSynchronize with onoff set to False.
Verify that XSynchronize returned afterfunction.
Call XSetAfterFunction to set after function to afterfunction.
Call XSynchronize with onoff set to True.
Verify that XSynchronize returned afterfunction.
>>CODE
int	(*proc)();

/* Call XSetAfterFunction to set after function to afterfunction. */
	XSetAfterFunction(display, afterfunction);
/* Call XSynchronize with onoff set to False. */
	onoff = False;
	proc = XCALL;
/* Verify that XSynchronize returned afterfunction. */
	if (proc != afterfunction) {
		report("Did not return previous after function.");
		FAIL;
	}
	else
		CHECK;
/* Call XSetAfterFunction to set after function to afterfunction. */
	XSetAfterFunction(display, afterfunction);
/* Call XSynchronize with onoff set to True. */
	onoff = True;
	proc = XCALL;
/* Verify that XSynchronize returned afterfunction. */
	if (proc != afterfunction) {
		report("Did not return previous after function.");
		FAIL;
	}
	else
		CHECK;
	CHECKPASS(2);
