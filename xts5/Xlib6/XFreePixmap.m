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
>># File: xts5/Xlib6/XFreePixmap.m
>># 
>># Description:
>># 	Tests for XFreePixmap()
>># 
>># Modifications:
>># $Log: frpxmp.m,v $
>># Revision 1.2  2005-11-03 08:43:41  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:29  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:26:53  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:45:11  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:19:06  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:15:37  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 08:49:01  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  00:48:03  andy
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
>>TITLE XFreePixmap Xlib6
void
XFreePixmap(display, pixmap)
Display *display = Dsp;
Pixmap  pixmap;
>>ASSERTION Good A
A call to xname removes the association between the pixmap ID
.A pixmap
and the specified pixmap.
>>STRATEGY
For all supported depths of pixmap:
   Create a pixmap.
   Create a gc using the pixmap as the drawable.
   Free the pixmap with XFreePixmap.
   Plot (0,0) in the pixmap.
   Verify that a BadDrawable error occurred.
>>CODE
XVisualInfo	*vp;
GC		gc;

	for(resetvinf(VI_PIX); nextvinf(&vp); ) {
		pixmap = XCreatePixmap(display, DRW(display), 1, 1, vp->depth);
		gc = makegc(display, pixmap);
		XCALL;
		
		startcall(Dsp);
		XDrawPoint(display, pixmap, gc, 0, 0);
		endcall(Dsp);
		if(geterr() != BadDrawable) {
			report("Got %s instead of BadDrawable when drawing on a freed pixmap. ", errorname(geterr()));
			FAIL;
		} else
			CHECK;
	}

	CHECKPASS(nvinf());

>>ASSERTION Good A
The storage allocated to the pixmap is not recovered until all references to it
have been removed.
>>STRATEGY
Create a window.
Create a pixmap of the same dimensions as the window.
Pattern the pixmap.
Create a gc with the pixmap as the tile and the fill_mode set to FillTiled.
Free the pixmap with XFreePixmap.
Tile the entire window with XFillRectangle.
Verify that the tiled pattern matches the pixmap.
>>CODE
Window		win;
XVisualInfo	*vp;
XGCValues	gcv;
GC		gc;

	for(resetvinf(VI_WIN); nextvinf(&vp);) {
		win = makewin(display, vp);	
		pixmap = XCreatePixmap(display, DRW(display), W_STDWIDTH, W_STDHEIGHT, vp->depth);
		dset(display, pixmap, W_BG);
		pattern(display, pixmap);
	
		gcv.fill_style = FillTiled;
		gcv.tile = pixmap;
		gcv.foreground = W_FG;
		gcv.background = W_BG;

                /*
                 * Create the GC with the window of the same depth because
                 * the root window could be of a different depth.
                 */
		gc = XCreateGC(display, win, GCFillStyle|GCTile|GCForeground|GCBackground, &gcv);
		XCALL;
	
		XFillRectangle(display, win, gc, 0, 0, W_STDWIDTH+1, W_STDHEIGHT+1);		
		
		if( checkpattern(display, win, (struct area *) 0 ) != True) {
			report("Tiled pattern on window was not correct after");
			report("tile component in GC was freed by XFreePixmap");
			FAIL;
		} else
			CHECK;
	
	}
	CHECKPASS(nvinf());

>>ASSERTION Bad A	
.ER BadPixmap
>>#HISTORY	Cal	Completed	Written in new format and style.
>>#HISTORY	Kieron	Completed		<Have a look>
>>#HISTORY	Cal	Action		Writing code.
