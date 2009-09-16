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
$Header: /cvs/xtest/xtest/xts5/tset/Xlib8/XSetTSOrigin/XSetTSOrigin.m,v 1.2 2005-11-03 08:43:52 jmichael Exp $

Copyright (c) Applied Testing and Technology, Inc. 1995
All Rights Reserved.

>># Project: VSW5
>># 
>># File: xts5/tset/Xlib8/XSetTSOrigin/XSetTSOrigin.m
>># 
>># Description:
>># 	Tests for XSetTSOrigin()
>># 
>># Modifications:
>># $Log: sttsorgn.m,v $
>># Revision 1.2  2005-11-03 08:43:52  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:33  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:27:38  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:46:03  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:19:48  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:16:18  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 08:51:24  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  00:52:20  andy
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
>>TITLE XSetTSOrigin Xlib8
void
XSetTSOrigin(display, gc, ts_x_origin, ts_y_origin)
Display *display = Dsp;
GC gc;
int ts_x_origin = -1;
int ts_y_origin = -1;
>>SET need-gc-flush
>>ASSERTION Good A
A call to xname sets the
.M ts_x_origin
and
.M ts_y_origin
components of the specified GC to the arguments
.A ts_x_origin
and
.A ts_y_origin .
>>STRATEGY
Create Window.  
Create GC with fg = WhitePixel, bg = BlackPixel, fill_style = FillOpaqueTiled,
 tile = | 0 1 |
        | 1 1 |  
Draw a filled rectangle (0, 0) (2, 2) with XFillRectangle.
Verify Pixel at (0, 0) is bg with XGetImage and XGetPixel.
Set Tile/Stipple origin to (1, 1) with XSetTSOrigin.
Draw a filled rectangle (0, 0) (2, 2) with XFillRectangle.
Verify Pixel at (0, 0) is bg with XGetImage and XGetPixel.
>>CODE
XVisualInfo	*vp;
Window		win;
XGCValues	values;
Pixmap		stip;
GC	sgc;

	resetvinf(VI_WIN);
	nextvinf(&vp);
	win = makewin(display, vp);
	stip = XCreatePixmap( display, win, 2, 2, 1); 	

	values.foreground = 1;
	sgc = XCreateGC(display, stip, GCForeground, &values);
	XFillRectangle(display, stip, sgc, 0, 0, 2, 2);
	XSetForeground(display, sgc, 0);
	XDrawPoint(display, stip, sgc, 0, 0);

	values.foreground = W_FG;
	values.background = W_BG;
	values.fill_style = FillOpaqueStippled;
	values.stipple = stip;

	gc = XCreateGC(display, win, GCForeground | GCBackground | GCFillStyle | GCStipple, &values);
	XFillRectangle(display, win, gc, 0, 0, 2, 2);

	if( ! checkpixel(display, win, 0, 0, W_BG)) {
		delete("Pixel at (0, 0) was not set to background.");
		return;
	} else 
		CHECK;

	ts_x_origin = 1;
	ts_y_origin = 1;
	XCALL;

	XFillRectangle(display, win, gc, 0, 0, 2, 2);
	if( ! checkpixel(display, win, 0, 0, W_FG)) {
		report("Pixel at (0, 0) was not set to foreground.");
		FAIL;
	} else 
		CHECK;

	CHECKPASS(2);

>>ASSERTION Bad B 1
.ER Alloc
>>ASSERTION Bad A
.ER GC
>># HISTORY cal Completed	Written in new format and style /tree/Xtest/x/root/xtest/lib/libxtest.a
>># HISTORY kieron Completed	Global and pixel checking to do - 19/11/90
>># HISTORY dave Completed	Final checking to do - 21/11/90
>># HISTORY cal Action 		Writing code.
