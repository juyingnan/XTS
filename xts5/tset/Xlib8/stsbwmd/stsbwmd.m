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
$Header: /cvs/xtest/xtest/xts5/tset/Xlib8/stsbwmd/stsbwmd.m,v 1.2 2005-11-03 08:43:51 jmichael Exp $

Copyright (c) Applied Testing and Technology, Inc. 1995
All Rights Reserved.

>># Project: VSW5
>># 
>># File: xts5/tset/Xlib8/stsbwmd/stsbwmd.m
>># 
>># Description:
>># 	Tests for XSetSubwindowMode()
>># 
>># Modifications:
>># $Log: stsbwmd.m,v $
>># Revision 1.2  2005-11-03 08:43:51  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:33  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:27:36  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:45:59  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:19:46  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:16:17  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 08:51:19  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  00:52:11  andy
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
>>TITLE XSetSubwindowMode Xlib8
void
XSetSubwindowMode(display, gc, subwindow_mode);
Display	*display = Dsp;
GC	gc;
int	subwindow_mode = IncludeInferiors;
>>SET need-gc-flush
>>ASSERTION Good A
A call to xname sets the
.M subwindow_mode
component of the specified GC to the value of the
.A subwindow_mode
argument.
>>STRATEGY
Create window.
Create child window fully obscuring the parent.
Create GC with subwindow_mode = IncludeInferiors, fg = WhitePixel, bg = BlackPixel.
Draw point (0, 0) on ParentWindow.
Verify pixel at (0, 0) is fg using XGetImage and XGetPixel.
Verify pixel at (0, 1) is bg using XGetImage and XGetPixel.
Set subwindow_mode of GC to ClipByChildren with XSetSubwindowMode.
Set pixel at (0, 1) on parent window.
Verify pixel at (0, 1) is bg using XGetImage and XGetPixel.
>>CODE
XVisualInfo *vp;
Window	pwin, cwin;
XGCValues	values;

	resetvinf(VI_WIN);
	nextvinf(&vp);
	pwin = makewin(display, vp);
	cwin = crechild(display, pwin, (struct area *) 0);
	values.foreground = W_FG;
	values.background = W_BG;
	values.subwindow_mode = IncludeInferiors;
	gc = XCreateGC(display, pwin, GCForeground | GCBackground | GCSubwindowMode, &values);

	XDrawPoint(display, pwin, gc, 0, 0);

	if( ! checkpixel(display, cwin, 0, 0, W_FG)) {
		delete("Pixel at (0, 0) was not set to foreground.");
		return;
	} else 
		CHECK;


	if( ! checkpixel(display, cwin, 0, 1, W_BG)) {
		delete("Pixel at (0, 1) was not set to background.");
		return;
	} else 
		CHECK;

	subwindow_mode = ClipByChildren;
	XCALL;

	XDrawPoint(display, pwin, gc, 0, 1);

	if( ! checkpixel(display, cwin, 0, 1, W_BG)) {
		report("Pixel at (0, 1) was not set to background.");
		FAIL;
	} else 
		CHECK;
	
	CHECKPASS(3);

>>ASSERTION Bad B 1
.ER Alloc
>>ASSERTION Bad A
.ER BadGC
>>ASSERTION Bad A
.ER Value subwindow_mode ClipByChildren IncludeInferiors
>># HISTORY cal Completed	Written in new format and style
>># HISTORY kieron Completed	Global and pixel checking to do - 19/11/90
>># HISTORY dave Completed	Final checking to do - 21/11/90
>># HISTORY cal	Action		Writing code.
