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
$Header: /cvs/xtest/xtest/xts5/tset/Xlib17/offstrgn/offstrgn.m,v 1.1 2005-02-12 14:37:31 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1995
All Rights Reserved.

>># Project: VSW5
>># 
>># File: vsw5/tset/Xlib17/offstrgn/offstrgn.m
>># 
>># Description:
>># 	Tests for XOffsetRegion()
>># 
>># Modifications:
>># $Log: offstrgn.m,v $
>># Revision 1.1  2005-02-12 14:37:31  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:34:47  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:57:10  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:26:04  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:22:37  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:11:28  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:14:07  andy
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
>>TITLE XOffsetRegion Xlib17

XOffsetRegion(r, dx, dy)
Region	r;
int	dx;
int	dy;
>>ASSERTION Good A
A call to xname moves the region
.A r
by
.A dx
in the x direction and
.A dy
in the y direction.
>>STRATEGY
Create a window using XCreateWindow.
Create a gc using XCreateGC.
Set the gc function to GXxor using XSetFunction.
Set the foreground pixel of the gc to W_FG ^ W_BG using XSetForeground.
Draw a rectangle using XFillRectangle.
Create a region using XCreateRegion.
Verify that the call did not return NULL.
Set the region to a rectangle of the same dimension but a different position as the drawn one using XUnionRectWithRegion.
Offset the region to lie over the same position as the drawn rectangle using xname.
Set the clipmask of the gc to the region using XSetRegion.
Fill the entire drawable using XFillRectangle.
Verify that the entire window is W_BG.
>>CODE
XVisualInfo		*vi;
Window			win;
GC			gc;
unsigned int    	width;
unsigned int    	height;
static XRectangle	cliprect = { 23, 13, 53, 63 };
static XRectangle	rect = { -1, -2, 53, 63 };

	resetvinf(VI_WIN);
	nextvinf(&vi);
	win = makewin(Dsp, vi); /* Makes a window with bg W_BG. */

	gc = makegc(Dsp, win);
	XSetFunction(Dsp, gc, GXxor);
	XSetForeground(Dsp, gc, W_BG^W_FG);
	XFillRectangle(Dsp, win, gc, cliprect.x, cliprect.y, cliprect.width, cliprect.height);
	if( checkarea(Dsp, win, (struct area *) NULL, W_BG, W_BG, CHECK_ALL|CHECK_DIFFER) != 0) {
		delete("All pixels were set to W_BG before calling %s", TestName);
		return;
	} else
		PASS;

	if( (r = XCreateRegion()) == (Region) NULL) {
		delete("XCreateRegion() returned NULL.");
		return;
	} else
		CHECK;

	XUnionRectWithRegion(&rect, r, r);
	dx = cliprect.x - rect.x;
	dy = cliprect.y - rect.y;
	XCALL;
	XSetRegion(Dsp, gc, r);
	getsize(Dsp, win, &width, &height);
	XFillRectangle(Dsp, win, gc, 0,0, width, height);

	if( checkarea(Dsp, win, (struct area *) NULL, W_BG, W_BG, CHECK_ALL) == 0) {
		report("Some pixels were not set to W_BG after calling %s", TestName);
		FAIL;
	} else
		PASS;
	
	XFlush(Dsp);
	sleep(5);
	XDestroyRegion(r);
