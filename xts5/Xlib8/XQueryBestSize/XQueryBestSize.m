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
>># File: xts5/tset/Xlib8/XQueryBestSize/XQueryBestSize.m
>># 
>># Description:
>># 	Tests for XQueryBestSize()
>># 
>># Modifications:
>># $Log: qrybstsz.m,v $
>># Revision 1.2  2005-11-03 08:43:49  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:32  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:27:28  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:45:46  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:19:39  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:16:09  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 08:50:57  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  00:51:32  andy
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
>>TITLE XQueryBestSize Xlib8
Status
XQueryBestSize(display, class, which_screen, width, height, rwidth, rheight)
Display *display = Dsp;
int class;
Drawable which_screen;
unsigned int width;
unsigned int height;
unsigned int *rwidth = &cwidth;
unsigned int *rheight = &cheight;
>>EXTERN
unsigned int cheight, cwidth;
>>ASSERTION Good A
When the 
.A class
argument is
.S CursorShape , 
then a call to xname returns the largest cursor height and width 
that can be fully displayed on the specified screen.
>>STRATEGY
Set class to CursorShape.
Call XQueryBestSize with width 10000 and height 10000.
Verify that XQueryBestSize returns non zero.
Call XQueryBestSize with returned values of width and height.
Verify that XQueryBestSize returns non zero.
Verify that XQueryBestSize returns the previously returned values
for width and height.
Repeat with initial width and height both set to zero.
>>CODE
Status qstat;

	which_screen = DRW(display);
	class = CursorShape;

	width = 10000;
	height = 10000;

	qstat = XCALL;

	if(qstat == 0) {
		report("XQueryBestSize returned wrong value %ld", (long) qstat);
		FAIL;
	} else
		CHECK;

	trace("Status returned was %d", qstat);
	trace("Best height (for %d ) = %d", height, cheight);
	trace("Best width (for %d)  = %d", width, cwidth);

	width = cwidth;
	height = cheight;

	cwidth = cheight = 0;

	qstat = XCALL;

	if(qstat == 0) {
		report("XQueryBestSize returned wrong value %ld", (long) qstat);
		FAIL;
	} else
		CHECK;

	trace("Status returned was %d", qstat);
	trace("Best height (for %d ) = %d", height, cheight);
	trace("Best width (for %d)  = %d", width, cwidth);

	if(width != cwidth) {
		report("XQueryBestSize returned best width %d", cwidth);
		report("after previously returning best width %d", width);
		FAIL;
	} else
		CHECK;

	if(height != cheight) {
		report("XQueryBestSize returned best height %d", cheight);
		report("after previously returning best height %d", height);
		FAIL;
	} else
		CHECK;

	width = 0;
	height = 0;

	qstat = XCALL;

	if(qstat == 0) {
		report("XQueryBestSize returned wrong value %ld", (long) qstat);
		FAIL;
	} else
		CHECK;

	trace("Status returned was %d", qstat);
	trace("Best height (for %d ) = %d", height, cheight);
	trace("Best width (for %d)  = %d", width, cwidth);

	width = cwidth;
	height = cheight;

	cwidth = cheight = 0;

	qstat = XCALL;

	if(qstat == 0) {
		report("XQueryBestSize returned wrong value %ld", (long) qstat);
		FAIL;
	} else
		CHECK;

	trace("Status returned was %d", qstat);
	trace("Best height (for %d ) = %d", height, cheight);
	trace("Best width (for %d)  = %d", width, cwidth);

	if(width != cwidth) {
		report("XQueryBestSize returned best width %d", cwidth);
		report("after previously returning best width %d", width);
		FAIL;
	} else
		CHECK;

	if(height != cheight) {
		report("XQueryBestSize returned best height %d", cheight);
		report("after previously returning best height %d", height);
		FAIL;
	} else
		CHECK;

	CHECKPASS(8);

>>ASSERTION Good A
When the 
.A class
argument is
.S TileShape , 
then a call to xname returns the height and width of tile that are closest to the arguments
.A height
and
.A width
that can be tiled fastest on the specified screen.
>>STRATEGY
Set class to TileShape.
Call XQueryBestSize with width 10000 and height 10000.
Verify that XQueryBestSize returns non zero.
Call XQueryBestSize with returned values of width and height.
Verify that XQueryBestSize returns non zero.
Verify that XQueryBestSize returns the previously returned values
for width and height.
Repeat with initial width and height both set to zero.
>>CODE
Status qstat;

	which_screen = DRW(display);
	class = TileShape;

	width = 10000;
	height = 10000;

	qstat = XCALL;

	if(qstat == 0) {
		report("XQueryBestSize returned wrong value %ld", (long) qstat);
		FAIL;
	} else
		CHECK;

	trace("Status returned was %d", qstat);
	trace("Best height (for %d ) = %d", height, cheight);
	trace("Best width (for %d)  = %d", width, cwidth);

	width = cwidth;
	height = cheight;

	cwidth = cheight = 0;

	qstat = XCALL;

	if(qstat == 0) {
		report("XQueryBestSize returned wrong value %ld", (long) qstat);
		FAIL;
	} else
		CHECK;

	trace("Status returned was %d", qstat);
	trace("Best height (for %d ) = %d", height, cheight);
	trace("Best width (for %d)  = %d", width, cwidth);

	if(width != cwidth) {
		report("XQueryBestSize returned best width %d", cwidth);
		report("after previously returning best width %d", width);
		FAIL;
	} else
		CHECK;

	if(height != cheight) {
		report("XQueryBestSize returned best height %d", cheight);
		report("after previously returning best height %d", height);
		FAIL;
	} else
		CHECK;

	width = 0;
	height = 0;

	qstat = XCALL;

	if(qstat == 0) {
		report("XQueryBestSize returned wrong value %ld", (long) qstat);
		FAIL;
	} else
		CHECK;

	trace("Status returned was %d", qstat);
	trace("Best height (for %d ) = %d", height, cheight);
	trace("Best width (for %d)  = %d", width, cwidth);

	width = cwidth;
	height = cheight;

	cwidth = cheight = 0;

	qstat = XCALL;

	if(qstat == 0) {
		report("XQueryBestSize returned wrong value %ld", (long) qstat);
		FAIL;
	} else
		CHECK;

	trace("Status returned was %d", qstat);
	trace("Best height (for %d ) = %d", height, cheight);
	trace("Best width (for %d)  = %d", width, cwidth);

	if(width != cwidth) {
		report("XQueryBestSize returned best width %d", cwidth);
		report("after previously returning best width %d", width);
		FAIL;
	} else
		CHECK;

	if(height != cheight) {
		report("XQueryBestSize returned best height %d", cheight);
		report("after previously returning best height %d", height);
		FAIL;
	} else
		CHECK;

	CHECKPASS(8);

>>ASSERTION Good A
When the
.A class
argument is
.S StippleShape , 
then a call to xname returns the height and width of stipple that are closest to the arguments
.A height
and
.A width
that can be stippled fastest on the specified screen.
>>STRATEGY
Set class to StippleShape.
Call XQueryBestSize with width 10000 and height 10000.
Verify that XQueryBestSize returns non zero.
Call XQueryBestSize with returned values of width and height.
Verify that XQueryBestSize returns non zero.
Verify that XQueryBestSize returns the previously returned values
for width and height.
Repeat with initial width and height both set to zero.
>>CODE
Status qstat;

	which_screen = DRW(display);
	class = StippleShape;

	width = 10000;
	height = 10000;

	qstat = XCALL;

	if(qstat == 0) {
		report("XQueryBestSize returned wrong value %ld", (long) qstat);
		FAIL;
	} else
		CHECK;

	trace("Status returned was %d", qstat);
	trace("Best height (for %d ) = %d", height, cheight);
	trace("Best width (for %d)  = %d", width, cwidth);

	width = cwidth;
	height = cheight;

	cwidth = cheight = 0;

	qstat = XCALL;

	if(qstat == 0) {
		report("XQueryBestSize returned wrong value %ld", (long) qstat);
		FAIL;
	} else
		CHECK;

	trace("Status returned was %d", qstat);
	trace("Best height (for %d ) = %d", height, cheight);
	trace("Best width (for %d)  = %d", width, cwidth);

	if(width != cwidth) {
		report("XQueryBestSize returned best width %d", cwidth);
		report("after previously returning best width %d", width);
		FAIL;
	} else
		CHECK;

	if(height != cheight) {
		report("XQueryBestSize returned best height %d", cheight);
		report("after previously returning best height %d", height);
		FAIL;
	} else
		CHECK;

	width = 0;
	height = 0;

	qstat = XCALL;

	if(qstat == 0) {
		report("XQueryBestSize returned wrong value %ld", (long) qstat);
		FAIL;
	} else
		CHECK;

	trace("Status returned was %d", qstat);
	trace("Best height (for %d ) = %d", height, cheight);
	trace("Best width (for %d)  = %d", width, cwidth);

	width = cwidth;
	height = cheight;

	cwidth = cheight = 0;

	qstat = XCALL;

	if(qstat == 0) {
		report("XQueryBestSize returned wrong value %ld", (long) qstat);
		FAIL;
	} else
		CHECK;

	trace("Status returned was %d", qstat);
	trace("Best height (for %d ) = %d", height, cheight);
	trace("Best width (for %d)  = %d", width, cwidth);

	if(width != cwidth) {
		report("XQueryBestSize returned best width %d", cwidth);
		report("after previously returning best width %d", width);
		FAIL;
	} else
		CHECK;

	if(height != cheight) {
		report("XQueryBestSize returned best height %d", cheight);
		report("after previously returning best height %d", height);
		FAIL;
	} else
		CHECK;

	CHECKPASS(8);

>>ASSERTION Bad A
When the 
.A class
argument is
.S TileShape , 
and the
.A which_screen
argument specifies an
.S InputOnly
window, then a
.S BadMatch
error occurs.
>>STRATEGY
Set class to TileShape.
Set which_screen to an InputOnly window.
Call XQueryBestSize.
Verify that XQueryBestSize returns zero.
Verify that a BadMatch error occurs.
>>CODE BadMatch
int qstat;

	which_screen = iponlywin(display);
	class = TileShape;
	qstat = XCALL;
	trace("Status returned is %d", qstat);

	if(qstat == 0)
		CHECK;
	else
		FAIL;

	if(geterr() == BadMatch)
		CHECK;
	else
		FAIL;

	CHECKPASS(2);

>>ASSERTION Bad A
When the 
.A class
argument is
.S StippleShape , 
and the
.A which_screen
argument specifies an
.S InputOnly
window, then a
.S BadMatch
error occurs.
>>STRATEGY
Set class to StippleShape.
Set which_screen to an InputOnly window.
Call XQueryBestSize.
Verify that XQueryBestSize returns zero.
Verify that a BadMatch error occurs.
>>CODE BadMatch
int qstat;

	which_screen = iponlywin(display);
	class = StippleShape;
	qstat = XCALL;
	trace("Status returned is %d", qstat);

	if(qstat == 0)
		CHECK;
	else
		FAIL;

	if(geterr() == BadMatch)
		CHECK;
	else
		FAIL;

	CHECKPASS(2);

>>ASSERTION Bad A
.ER Drawable
>>ASSERTION Bad A
.ER Value class TileShape CursorShape StippleShape
>># HISTORY cal Completed	Written in new format and style
>># HISTORY kieron Completed	Global and pixel checking to do - 19/11/90
>># HISTORY dave Completed	Final checking to do - 21/11/9
>># HISTORY cal Action		Writing code.
