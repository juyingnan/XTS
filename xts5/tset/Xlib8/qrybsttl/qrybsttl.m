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
$Header: /cvs/xtest/xtest/xts5/tset/Xlib8/qrybsttl/qrybsttl.m,v 1.1 2005-02-12 14:37:37 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1995
All Rights Reserved.

>># Project: VSW5
>># 
>># File: vsw5/tset/Xlib8/qrybsttl/qrybsttl.m
>># 
>># Description:
>># 	Tests for XQueryBestTile()
>># 
>># Modifications:
>># $Log: qrybsttl.m,v $
>># Revision 1.1  2005-02-12 14:37:37  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:27:28  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:45:47  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:19:39  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:16:10  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 08:50:59  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  00:51:35  andy
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
>>TITLE XQueryBestTile Xlib8
Status
XQueryBestTile(display, drawable, width, height, rwidth, rheight)
Display *display = Dsp;
Drawable drawable;
unsigned int width;
unsigned int height;
unsigned int *rwidth = &bwidth;
unsigned int *rheight = &bheight;
>>EXTERN
unsigned int bwidth, bheight;
>>ASSERTION Good A
A call to xname returns the height and width of tile that are closest to the arguments
.A height
and
.A width
that can be tiled fastest on the specified screen.
>>STRATEGY
Call XQueryBestTile with width 17 and height 13.
Verify that XQueryBestTile returns non zero.
Call XQueryBestTile with returned values of width and height.
Verify that XQueryBestTile returns non zero.
Verify that XQueryBestTile returns the previously returned values
for width and height.
Repeat with initial width and height both set to zero.
>>CODE
Status qstat;

	drawable = DRW(display);

	width = 17;
	height = 13;

	qstat = XCALL;

	if(qstat == 0) {
		report("XQueryBestTile returned wrong value %d", qstat);
		FAIL;
	} else
		CHECK;

	trace("Status returned was %d", qstat);
	trace("Best width (for 17)  = %d", bwidth);
	trace("Best height (for 13) = %d", bheight);

	width = bwidth;
	height = bheight;

	bwidth = bheight = 0;

	qstat = XCALL;

	if(qstat == 0) {
		report("XQueryBestTile returned wrong value %d", qstat);
		FAIL;
	} else
		CHECK;

	trace("Status returned was %d", qstat);
	trace("Best width (for %d)  = %d", width, bwidth);
	trace("Best height (for %d) = %d", height, bheight);

	if(width != bwidth) {
		report("XQueryBestTile returned best width %d", bwidth);
		report("after previously returning best width %d", width);
		FAIL;
	} else
		CHECK;

	if(height != bheight) {
		report("XQueryBestTile returned best height %d", bheight);
		report("after previously returning best height %d", height);
		FAIL;
	} else
		CHECK;

	width = 0;
	height = 0;

	qstat = XCALL;

	if(qstat == 0) {
		report("XQueryBestTile returned wrong value %d", qstat);
		FAIL;
	} else
		CHECK;

	trace("Status returned was %d", qstat);
	trace("Best width (for 0)  = %d", bwidth);
	trace("Best height (for 0) = %d", bheight);

	width = bwidth;
	height = bheight;

	bwidth = bheight = 0;

	qstat = XCALL;

	if(qstat == 0) {
		report("XQueryBestTile returned wrong value %d", qstat);
		FAIL;
	} else
		CHECK;

	trace("Status returned was %d", qstat);
	trace("Best width (for %d)  = %d", width, bwidth);
	trace("Best height (for %d) = %d", height, bheight);

	if(width != bwidth) {
		report("XQueryBestTile returned best width %d", bwidth);
		report("after previously returning best width %d", width);
		FAIL;
	} else
		CHECK;

	if(height != bheight) {
		report("XQueryBestTile returned best height %d", bheight);
		report("after previously returning best height %d", height);
		FAIL;
	} else
		CHECK;

	CHECKPASS(8);

>>ASSERTION Bad A
.ER Drawable
>>ASSERTION Bad A
.ER Match inputonly
>># HISTORY cal Completed	Written in new format and style
>># HISTORY kieron Completed	Global and pixel checking to do - 19/11/90
>># HISTORY dave Completed	Final checking to do - 21/11/90
>># HISTORY cal Action 		Writing code.
