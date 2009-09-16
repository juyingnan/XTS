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
>># File: xts5/Xlib8/XSetFont/XSetFont.m
>># 
>># Description:
>># 	Tests for XSetFont()
>># 
>># Modifications:
>># $Log: stfnt.m,v $
>># Revision 1.2  2005-11-03 08:43:50  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:33  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:27:33  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:45:55  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:19:44  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:16:14  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 08:51:13  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  00:51:59  andy
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
>>TITLE XSetFont Xlib8
char **
XSetFont(display, gc, font)
Display *display = Dsp;
GC gc;
Font font;
>>SET startup fontstartup
>>SET cleanup fontcleanup
>>EXTERN
#define FONT1 "xtfont0"
#define FONT2 "xtfont1"
>>ASSERTION Good A
A call to xname sets the
.M font
component of the specified GC to the value of the
.A font
argument.
>>STRATEGY
Create window.
Load font 1.
Load font 2.
Create GC with font = font1, fn = GXxor.
Draw string with glyph differing between font 1 and 2.
Set font component of GC to font2 with XSetFont.
Draw string with glyph differing between font 1 and 2.
Verify that not all pixels in the window are set to bg.
>>CODE
XVisualInfo	*vp;
XFontStruct	*fs1, *fs2, *rfs;
XCharStruct	*cs1,*cs2,*maxchar;
XGCValues	values;
GContext	gcctxt;
int		xmin, ymax;

	resetvinf(VI_WIN);
	nextvinf(&vp);
	Win = makewin(display, vp);

	if((fs1 = XLoadQueryFont(display, FONT1)) == (XFontStruct *) 0) {
		delete("Failed to load font %s", FONT1);
		return;
	} else
		CHECK;

	if((fs2 = XLoadQueryFont(display, FONT2)) == (XFontStruct *) 0) {
		delete("Failed to load font %s", FONT2);
		return;
	} else
		CHECK;

	cs1 = &(fs1->max_bounds);
	cs2 = &(fs2->max_bounds);

	values.font = fs1->fid;
	values.foreground = W_FG;
	values.background = W_BG;
	values.function = GXxor;

        /*
         * Create the GC with the window with which it is to be used.
         * This is required because there is a possibility that the target
         * window may not match the default visual depth (causing a BadMatch
         * error if the GC is used with it if created with the root).
         */
	gc = XCreateGC(display, Win, GCFont|GCBackground|GCForeground|GCFunction, &values);

	xmin = (int) ((cs1->lbearing < cs2->lbearing) ? cs1->lbearing : cs2->lbearing);
	ymax = (int) ((cs1->ascent > cs2->ascent) ? cs1->ascent : cs2->ascent);
	XDrawString(display, Win, gc, -xmin, ymax ,"a", 1);

	font = fs2->fid;
	XCALL;

	XDrawString(display, Win, gc, -xmin, ymax ,"a", 1);

	if( checkarea(display, Win, (struct area *) 0, W_BG, W_BG, CHECK_ALL|CHECK_DIFFER) == True) {
		report("Font was not changed by XSetFont.");
		FAIL;
	} else
		CHECK;

	CHECKPASS(3);

>>ASSERTION Bad B 1
.ER Alloc
>>ASSERTION Bad A
.ER Font bad-font
>>ASSERTION Bad A
.ER GC
>># HISTORY cal Completed	Written in new format and style
>># HISTORY kieron Completed	Global and pixel checking to do - 19/11/90
>># HISTORY dave Completed	Final checking to do- 21/11/90
>># HISTORY cal Action 		Writing code.
