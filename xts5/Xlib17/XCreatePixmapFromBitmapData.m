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
>># File: xts5/Xlib17/XCreatePixmapFromBitmapData.m
>># 
>># Description:
>># 	Tests for XCreatePixmapFromBitmapData()
>># 
>># Modifications:
>># $Log: crtpxmpfrm.m,v $
>># Revision 1.2  2005-11-03 08:43:03  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:23  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:34:31  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:56:52  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:25:50  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:22:22  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:10:47  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:13:18  andy
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
>>TITLE XCreatePixmapFromBitmapData Xlib17
Pixmap

Display *display = Dsp;
Drawable d;
char *data = (char*)cpfbd_one;
unsigned int width = 16;
unsigned int height = 8;
unsigned long fg = W_BG;
unsigned long bg = W_FG;
unsigned int depth = 1;
>>EXTERN
/* Data for a "checkerboard" pixmap. */
static unsigned char cpfbd_one[] = {
	0xff, 0x00, 0xff, 0x00, 0xff, 0x00, 0xff, 0x00,
	0x00, 0xff, 0x00, 0xff, 0x00, 0xff, 0x00, 0xff};
	
>>ASSERTION Good A
A call to xname returns a pixmap 
containing the bitmap-format
.S XPutImage
of the
.A data 
of depth
.A depth ,
width
.A width ,
and height
.A height ,
and with foreground and background pixel values of
.A fg
and
.A bg .
>>STRATEGY
Create a drawable for the pixmap.
Call xname to create the pixmap from the data.
Call XGetGeometry to check the pixmap.
Verify the pixmap was as expected.
>>CODE
XVisualInfo *vp;
Pixmap ret;
Window wr_r;
int it_r;
unsigned int width_ret, height_ret;
unsigned int uit_r;
unsigned int depth_ret;
struct area ar;

/* Create a drawable for the pixmap. */
	resetvinf(VI_WIN); nextvinf(&vp);
	d = makewin(display, vp);
	depth = vp->depth;

/* Call xname to create the pixmap from the data. */
	ret=XCALL;

/* Call XGetGeometry to check the pixmap. */
	if(!XGetGeometry(display, ret, &wr_r, &it_r, &it_r,
		&width_ret, &height_ret, &uit_r, &depth_ret)) {
		delete("XGetGeometry failed.");
		return;
	} else
		CHECK;

	if(width_ret!=width || height_ret!=height) {
		FAIL;
		report("%s created a pixmap of unexpected geometry",
			TestName);
		report("Expected width, height: %d,%d", width, height);
		report("Returned width, height: %d,%d", width_ret, height_ret);
	} else
		CHECK;

	if(depth_ret != depth) {
		FAIL;
		report("%s created a pixmap of unexpected depth.",
			TestName);
		report("Expected depth: %u", depth);
		report("Returned depth: %u", depth_ret);
	} else
		CHECK;

/* Verify the pixmap was as expected. */
	setarea(&ar,0,0,8,4);
	if (!checkarea(display, ret, &ar, fg, 0, CHECK_IN)) {
		FAIL;
		report("%s did not return the expected pixmap.", TestName);
		trace("Top left quarter was incorrect");
	} else
		CHECK;

	setarea(&ar,8,0,8,4);
	if (!checkarea(display, ret, &ar, bg, 0, CHECK_IN)) {
		FAIL;
		report("%s did not return the expected pixmap.", TestName);
		trace("Top right quarter was incorrect");
	} else
		CHECK;

	setarea(&ar,0,4,8,4);
	if (!checkarea(display, ret, &ar, bg, 0, CHECK_IN)) {
		FAIL;
		report("%s did not return the expected pixmap.", TestName);
		trace("Bottom left quarter was incorrect");
	} else
		CHECK;

	setarea(&ar,8,4,8,4);
	if (!checkarea(display, ret, &ar, fg, 0, CHECK_IN)) {
		FAIL;
		report("%s did not return the expected pixmap.", TestName);
		trace("Bottom right quarter was incorrect");
	} else
		CHECK;

	CHECKPASS(7);

>>ASSERTION Bad A
When the
.A depth
is not supported by the screen of the specified drawable
.A d ,
then on a call to xname a
.S BadValue
error occurs.
>>STRATEGY
Calculate a bad depth.
Call xname with a bad depth
Verify that a bad value error occurred.
>>CODE BadValue
XVisualInfo *vp;
int baddepth;


/* Calculate a bad depth. */
	baddepth=1;
	resetvinf(VI_PIX);
	for(baddepth=1; nextvinf(&vp); )
		if(baddepth < vp->depth)
			baddepth=vp->depth;
	baddepth *= 2;

/* Call xname with a bad depth */
	depth=baddepth;
	d = defwin(display);
	XCALL;

/* Verify that a bad value error occurred. */
	if (geterr() != BadValue) {
		FAIL;
	} else
		CHECK;

	CHECKPASS(1);

>>ASSERTION Bad B 1
When sufficient temporary storage cannot be allocated, then a call to
xname returns
.S NULL .
>>ASSERTION Bad B
.ER BadAlloc 
>>ASSERTION Bad A
When a drawable argument does not name a valid drawable, then one or more
.S BadDrawable
errors, one or more
.S BadGC
errors or both types of error occur.
>>STRATEGY
Create a bad drawable by creating and destroying a window.
Call test function using bad drawable as the drawable argument.
Verify that a BadDrawable and BadGC error occurs.
>>CODE BadDrawable

	seterrdef();

	A_DRAWABLE = (Drawable)badwin(A_DISPLAY);

>>SET no-error-status-check
	XCALL;

	if (geterr() == BadDrawable || geterr() == BadGC)
		PASS;
	else
		FAIL;
