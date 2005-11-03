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
$Header: /cvs/xtest/xtest/xts5/tset/Xlib10/lstinstlld/lstinstlld.m,v 1.2 2005-11-03 08:42:18 jmichael Exp $

Copyright (c) Applied Testing and Technology, Inc. 1995
All Rights Reserved.

>># Project: VSW5
>># 
>># File: xts5/tset/Xlib10/lstinstlld/lstinstlld.m
>># 
>># Description:
>># 	Tests for XListInstalledColormaps()
>># 
>># Modifications:
>># $Log: lstinstlld.m,v $
>># Revision 1.2  2005-11-03 08:42:18  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:15  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:31:00  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:50:22  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:22:44  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:19:16  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:00:42  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  00:56:41  andy
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
>>TITLE XListInstalledColormaps Xlib10
Colormap *
xname
Display	*display = Dsp;
Window	w;
int 	*num_return = &Num;
>>EXTERN

/* Variable to hold the return value in */
static	int 	Num;

>>ASSERTION Good A
A call to xname returns a list, that can be
freed with
.F XFree ,
of the currently installed colourmaps for the screen
of the specified window and the number of such colourmaps
in
.A num_return .
>>STRATEGY
Call xname.
Verify that the number of installed colour maps is between the min and
max limits.
Free return value with XFree.
>>CODE
Colormap	*cmp;
Screen	*screen;

	w = DRW(display);
	cmp = XCALL;

	if (cmp == NULL) {
		report("NULL was returned");
		FAIL;
		return;
	} else
		CHECK;

	screen = ScreenOfDisplay(display, DefaultScreen(display));
	if (*num_return < 1 ||
		*num_return > MaxCmapsOfScreen(screen)) {
		report("Number of installed colourmaps was outside range [1, MaxCmapsOfScreen]");
		FAIL;
	} else
		CHECK;

	XFree((char*)cmp);

	CHECKPASS(2);
>>ASSERTION Bad A
.ER BadWindow
