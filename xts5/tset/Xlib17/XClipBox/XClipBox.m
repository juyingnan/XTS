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
$Header: /cvs/xtest/xtest/xts5/tset/Xlib17/XClipBox/XClipBox.m,v 1.2 2005-11-03 08:43:03 jmichael Exp $

Copyright (c) Applied Testing and Technology, Inc. 1995
All Rights Reserved.

>># Project: VSW5
>># 
>># File: xts5/tset/Xlib17/XClipBox/XClipBox.m
>># 
>># Description:
>># 	Tests for XClipBox()
>># 
>># Modifications:
>># $Log: clpbx.m,v $
>># Revision 1.2  2005-11-03 08:43:03  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:23  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:34:30  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:56:50  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:25:48  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:22:21  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:10:42  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:13:11  andy
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
>>TITLE XClipBox Xlib17

XClipBox(r, rect_return)
Region		r;
XRectangle	*rect_return;
>>ASSERTION Good A
A call to xname returns in the
.A rect_return
argument the smallest rectangle enclosing the region
.A r .
>>EXTERN
Status
checknotclear(disp, d, fg)
Display		*disp;
Drawable	d;
unsigned long	fg;
{
XImage			*im;
unsigned long		pix;
unsigned int		width;
unsigned int		height;
int			x;
int			y;

	getsize(Dsp, d, &width, &height);
	
        if ((im = XGetImage(disp, d, 0, 0, width, height, AllPlanes, ZPixmap)) == (XImage*) NULL) {
                delete("XGetImage failed");
                return(False);
        }

	for(y=0; y<height; y++)		
		for(x=0; x<width; x++)
			if(XGetPixel(im, x, y) == fg)
				return(True);
	return(False);
}
>>STRATEGY
Create a region using XPolygonRegion.
Create a gc using XCreateGC.
Create a window using XCreateWindow.
Set the clip mask of the gc to the region.
Fill the entire drawable with W_FG using XFillRectangle.
Verify that the drawable is not completely W_BG.
Set the foreground of the gc to W_BG.
Obtain the smallest rectangle enclosing the polygon using xname.
Draw the returned rectangle in W_BG using XFillRectangle.
Verify that the drawable is completely W_BG

Create a window using XCreateWindow.
Fill the entire drawable with W_FG using XFillRectangle and the first gc.
Verify that the drawable is not completely W_BG.
Draw the smallest enclosing rectangle offset by +1+0 in W_BG using XFillRectangle and the second gc.
Verify that the drawable is not completely W_BG.

Create a window using XCreateWindow.
Fill the entire drawable with W_FG using XFillRectangle and the first gc.
Verify that the drawable is not completely W_BG.
Draw the smallest enclosing rectangle offset by -1+0 in W_BG using XFillRectangle and the second gc.
Verify that the drawable is not completely W_BG.

Create a window using XCreateWindow.
Fill the entire drawable with W_FG using XFillRectangle and the first gc.
Verify that the drawable is not completely W_BG.
Draw the smallest enclosing rectangle offset by +0+1 in W_BG using XFillRectangle and the second gc.
Verify that the drawable is not completely W_BG.

Create a window using XCreateWindow.
Fill the entire drawable with W_FG using XFillRectangle and the first gc.
Verify that the drawable is not completely W_BG.
Draw the smallest enclosing rectangle offset by +0-1 in W_BG using XFillRectangle and the second gc.
Verify that the drawable is not completely W_BG.
>>CODE
static XPoint   points[] = { {10, 10},  {74, 10},  {75, 30},  {65, 60},  {65, 30}, {75, 60},
                         {30, 50},  {30, 74},  {60, 74},   {60, 5},   {70, 5},  {70, 75}, {10, 85} };
Region		reg;
XRectangle	rect;
XVisualInfo	*vi;
Window		win;
GC		gc;
GC		gc2;
unsigned int		width;
unsigned int		height;

	reg = XPolygonRegion( points, NELEM(points), WindingRule);
	resetvinf(VI_WIN);
	nextvinf(&vi);
	win = makewin(Dsp, vi);
	gc = makegc(Dsp, win);
	gc2 = makegc(Dsp, win);
	XSetRegion(Dsp, gc, reg);
	XSetForeground(Dsp, gc, W_FG);
	XSetForeground(Dsp, gc2, W_BG);
	getsize(Dsp, win, &width, &height);
	XFillRectangle(Dsp, win, gc, 0,0, width, height);	

	if(checknotclear(Dsp, win, W_FG) == 0) {
		delete("XFillRectangle did not set any pixel to foreground.");
		return;
	} else
		CHECK;

	r = reg;
	rect_return = &rect;
	XCALL;

	XDestroyRegion(reg);

	XFillRectangle(Dsp, win, gc2, rect.x, rect.y, rect.width, rect.height);	

	if(checknotclear(Dsp, win, W_FG) != 0 ) {
		report("With a region used as the clip-mask in a GC,");
		report("%s() did not return a sufficiently large rectangle.", TestName);
		FAIL;
		return;
	} else
		CHECK;

	win = makewin(Dsp, vi);
	XFillRectangle(Dsp, win, gc, 0,0, width, height);	

	if(checknotclear(Dsp, win, W_FG) == 0) {
		delete("XFillRectangle did not set any pixel to foreground.");
		return;
	} else
		CHECK;
	XFillRectangle(Dsp, win, gc2, rect.x+1, rect.y, rect.width, rect.height);	

	if(checknotclear(Dsp, win, W_FG) == 0 ) {
		report("With a region used as the clip-mask in a GC,");
		report("%s() did not return a sufficiently small rectangle.in the x-direction.", TestName);
		FAIL;
	} else
		CHECK;

	win = makewin(Dsp, vi);
	XFillRectangle(Dsp, win, gc, 0,0, width, height);	

	if(checknotclear(Dsp, win, W_FG) == 0) {
		delete("XFillRectangle did not set any pixel to foreground.");
		return;
	} else
		CHECK;
	XFillRectangle(Dsp, win, gc2, rect.x-1, rect.y, rect.width, rect.height);	

	if(checknotclear(Dsp, win, W_FG) == 0 ) {
		report("With a region used as the clip-mask in a GC,");
		report("%s() did not return a sufficiently small rectangle in the x-direction.", TestName);
		FAIL;
	} else
		CHECK;

	win = makewin(Dsp, vi);
	XFillRectangle(Dsp, win, gc, 0,0, width, height);	

	if(checknotclear(Dsp, win, W_FG) == 0) {
		delete("XFillRectangle did not set any pixel to foreground.");
		return;
	} else
		CHECK;

	XFillRectangle(Dsp, win, gc2, rect.x, rect.y+1, rect.width, rect.height);	

	if(checknotclear(Dsp, win, W_FG) == 0 ) {
		report("With a region used as the clip-mask in a GC,");
		report("%s() did not return a sufficiently small rectangle in the y-direction.", TestName);
		FAIL;
	} else
		CHECK;

	win = makewin(Dsp, vi);
	XFillRectangle(Dsp, win, gc, 0,0, width, height);	

	if(checknotclear(Dsp, win, W_FG) == 0) {
		delete("XFillRectangle did not set any pixel to foreground.");
		return;
	} else
		CHECK;

	XFillRectangle(Dsp, win, gc2, rect.x, rect.y-1, rect.width, rect.height);	

	if(checknotclear(Dsp, win, W_FG) == 0 ) {
		report("With a region used as the clip-mask in a GC,");
		report("%s() did not return a sufficiently small rectangle in the y-direction.", TestName);
		FAIL;
	} else
		CHECK;

	CHECKPASS(10);
