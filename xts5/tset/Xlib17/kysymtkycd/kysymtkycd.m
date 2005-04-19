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
$Header: /cvs/xtest/xtest/xts5/tset/Xlib17/kysymtkycd/kysymtkycd.m,v 1.1 2005-02-12 14:37:30 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1995
All Rights Reserved.

>># Project: VSW5
>># 
>># File: vsw5/tset/Xlib17/kysymtkycd/kysymtkycd.m
>># 
>># Description:
>># 	Tests for XKeysymToKeycode()
>># 
>># Modifications:
>># $Log: kysymtkycd.m,v $
>># Revision 1.1  2005-02-12 14:37:30  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:34:44  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:57:07  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:26:02  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:22:34  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.1  1996/05/09 21:03:56  andy
>># Fixed keysymdef include
>>#
>># Revision 4.0  1995/12/15  09:11:21  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:13:58  andy
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
>>TITLE XKeysymToKeycode Xlib17
KeyCode
XKeysymToKeycode(display, keysym)
Display	*display=Dsp;
KeySym	keysym;
>>EXTERN
#define XK_LATIN1
#include	"X11/keysymdef.h"
#undef XK_LATIN1
>>ASSERTION Good A
A call to xname returns the
.S KeyCode
defined for the
.S KeySym
specified by the
.A keysym
argument.
>>STRATEGY
Verify that XK_a and XK_A map to the same KeyCode using xname.
Verify that the returned KeyCode maps to XK_a using XKeycodeToKeysym with index 0.
Verify that the returned KeyCode maps to XK_A using XKeycodeToKeysym with index 1.
>>CODE
KeyCode	res_lc, res_uc;
KeySym	ks;

	keysym = XK_A;
	res_uc = XCALL;
	keysym = XK_a;
	res_lc = XCALL;

	if( res_lc != res_uc ) {
		report("%s() mapped KeySyms XK_A and XK_a to KeyCodes %lu and %lu instead of to the same KeyCode.", TestName, (long) res_uc, (long) res_lc);
		FAIL;
	} else
		CHECK;

	ks = XKeycodeToKeysym(display, res_lc, 0);

	if(ks != XK_a) {
		report("%s() returned KeyCode %lu which did not map to KeySym XK_a.", TestName, (long) res_lc);
		FAIL;
	} else
		CHECK;

	ks = XKeycodeToKeysym(display, res_uc, 1);

	if(ks != XK_A) {
		report("%s() returned KeyCode %lu which did not map to KeySym XK_A.", TestName, (long) res_uc);
		FAIL;
	} else
		CHECK;

	CHECKPASS(3);


>>ASSERTION Bad B 1
When the
.A keysym
argument is not defined for any
.S KeyCode ,
then a call to xname returns zero.