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
$Header: /cvs/xtest/xtest/xts5/tset/Xlib4/stwdwclrmp/stwdwclrmp.m,v 1.1 2005-02-12 14:37:34 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1995
All Rights Reserved.

>># Project: VSW5
>># 
>># File: vsw5/tset/Xlib4/stwdwclrmp/stwdwclrmp.m
>># 
>># Description:
>># 	Tests for XSetWindowColormap()
>># 
>># Modifications:
>># $Log: stwdwclrmp.m,v $
>># Revision 1.1  2005-02-12 14:37:34  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:26:40  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:44:57  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:18:54  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:15:25  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 08:48:20  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  00:46:54  andy
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
>>TITLE XSetWindowColormap Xlib4
void
XSetWindowColormap(display, w, colormap)
Display *display = Dsp;
Window w = DRW(display);
Colormap colormap = DefaultColormap(display, DefaultScreen(display));
>>ASSERTION Good A
A call to xname sets the colourmap of the window argument
.A w
to the
.A colormap
argument.
>>STRATEGY
For each supported visual class:
  Create a colormap with XCreateColormap.
  Create a window with XCreateWindow.
  Set the colourmap of the window to the created colormap with XSetWindowColormap.
  Get the colourmap associated with the window with XGetWindowAttributes.
  Verify that the created colourmap and that associated with the window are the same.
>>CODE
XVisualInfo *vi;
XWindowAttributes watts;

	for(resetvinf(VI_WIN); nextvinf(&vi); ) {

		colormap = makecolmap(display, vi->visual, AllocNone);
		w = makewin(display, vi);
		XCALL;
		if( XGetWindowAttributes(display, w, &watts) == False ) {
			delete("XGetWindowAttributes() failed on visual class %s", displayclassname(vi->class));
			return;
		} else
			CHECK;

		if( watts.colormap != colormap ) {
			report("Colormap of window was not set for visual class %s", displayclassname(vi->class));
			FAIL;
		} else
			CHECK;
	}

	CHECKPASS(2*nvinf());

>>ASSERTION Bad C
If more than one type of visual is supported:
When the
.A colormap
argument
does not have the same visual type as the window
specified by the window argument
.A w ,
then a
.S BadMatch 
error occurs.
>>STRATEGY
For each supported visual:
  Create a colormap not of that visual type.
  Create a window of that visual type.
  Verify that a call to XSetWindowColormap generates a BadMatch error.
>>CODE BadMatch
XVisualInfo *vi;
XWindowAttributes watts;
int i, nvisuals;
Visual **visuals;

	resetvinf(VI_WIN);
	if((nvisuals = nvinf()) <= 1) {
		unsupported("Only one visual type is supported");
		return;
	}

	visuals = (Visual **)malloc(nvisuals * sizeof(Visual *));
	if (visuals == 0) {
		delete("Could not allocate visuals");
		return;
	}
	for(resetvinf(VI_WIN), i=0 ; nextvinf(&vi); i++) {
		visuals[i] = vi->visual;
	}

	for(resetvinf(VI_WIN), i = 1; nextvinf(&vi); i++) {
		i = i % nvisuals;
		w = makewin(display, vi);
		colormap = makecolmap(display, visuals[i], AllocNone);
		XCALL;
		if(geterr() == BadMatch)
			CHECK;
	}

	CHECKPASS(nvinf());

>>ASSERTION Bad A
.ER BadColor
>>ASSERTION Bad A
.ER BadWindow
>>#HISTORY	Cal	Completed	Written in new format and style -4/12/90.
>>#HISTORY	Kieron	Completed		<Have a look>
>>#HISTORY	Cal	Action		Writting code.