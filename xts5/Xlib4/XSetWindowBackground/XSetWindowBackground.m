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
>># File: xts5/Xlib4/XSetWindowBackground/XSetWindowBackground.m
>># 
>># Description:
>># 	Tests for XSetWindowBackground()
>># 
>># Modifications:
>># $Log: stwdwbg.m,v $
>># Revision 1.2  2005-11-03 08:43:36  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:26  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:26:35  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:44:52  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.1  1998/07/23 21:04:56  andy
>># In test 2 add another check for being deleted.  SR 200.
>>#
>># Revision 6.0  1998/03/02 05:18:50  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:15:21  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 08:48:09  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  00:46:41  andy
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
>>TITLE XSetWindowBackground Xlib4
void

Display *display = Dsp;
Window	w;
unsigned long	background_pixel = W_FG;
>>EXTERN
static Window	parent;
static struct	area	ap;

static void
inittp()
{
	tpstartup();

	ap.x = 50;
	ap.y = 60;
	ap.width = 20;
	ap.height= 20;
}
>>SET tpstartup inittp
>>ASSERTION Good A
A call to xname sets the background of the window to the pixel value
specified by
.A background_pixel .
>>STRATEGY
Create a window.
Set the background_pixel by calling xname.
Verify the background pixel was set to background_pixel using XGetPixel.
>>CODE
XEvent	event;

	parent = defdraw(display, VI_WIN);

	w = creunmapchild(display, parent, &ap);

	XCALL;

	XSelectInput(display, w, ExposureMask);	
	XMapWindow(display, w);
	XWindowEvent(display,w,ExposureMask, &event); /* Await exposure */

	if(getpixel(display, w, 1, 1) != W_FG) {
		report("%s did not set the background pixel to W_FG.", TestName);
		FAIL;
	} else
		CHECK;
	
	CHECKPASS(1);
>>ASSERTION Good A
When the background is changed, then the
window contents are not changed.
>>STRATEGY
Create a window.
Set the background-pixmap
Map window over a plain background.
Change background pixel. 
Verify that background has not changed.
>>CODE
Pixmap	pm;
XEvent event;
XVisualInfo	*vp;
XSetWindowAttributes	attributes;

	for(resetvinf(VI_WIN); nextvinf(&vp); ) {
		parent = makewin(display, vp);

		if ( isdeleted() )
			continue;

		w = creunmapchild(display, parent, &ap);

		pm = maketile(display, w);
		XSetWindowBackgroundPixmap(display, w, pm);

		XSelectInput(display, w, ExposureMask);
		XMapWindow(display, w);
					/* Wait for window to be exposed */
		XWindowEvent(display,w,ExposureMask, &event);

		background_pixel = W_BG;
		XCALL;

		if ( isdeleted() )
			continue;

		if (checktile(display, w, NULL, 0, 0, pm))
			CHECK;
		else
			FAIL;

	}

	CHECKPASS(nvinf());

>>ASSERTION Bad A
.ER BadMatch wininputonly
>>ASSERTION Bad A
.ER BadWindow 
