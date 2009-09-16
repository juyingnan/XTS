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
>># File: xts5/tset/Xlib17/XEmptyRegion/XEmptyRegion.m
>># 
>># Description:
>># 	Tests for XEmptyRegion()
>># 
>># Modifications:
>># $Log: emptyrgn.m,v $
>># Revision 1.2  2005-11-03 08:43:04  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:23  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:34:33  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:56:55  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:25:52  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:22:24  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:10:53  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:13:26  andy
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
>>TITLE XEmptyRegion Xlib17
Bool
XEmptyRegion(r)
Region	r;
>>ASSERTION Good A
When the region
.A r
is empty, then a call to xname returns
.S True .
>>STRATEGY
Create a region using XCreateRegion.
Verify that the region is empty using xname.
Compute the intersection of two disjoint regions.
Verify that the region is empty using xname.
>>CODE
Region			reg;
Bool			res;
Region			R1;
Region			R2;
static XRectangle	rect1 = {0,0, 7,13 };
static XRectangle	rect2 = {8, 14, 12,12};

	reg = makeregion();
	R1 = makeregion();
	R2 = makeregion();

	if(isdeleted()) return;

	r = reg;
	res = XCALL;

	if(res != True) {
		report("%s() did not return True", TestName);
		report("for a region obtain by a call to XCreateRegion().");
		FAIL;
	} else
		CHECK;

	XUnionRectWithRegion(&rect1, R1, R1);
	XUnionRectWithRegion(&rect2, R2, R2);
	XIntersectRegion(R1, R2, R1);

	r = R1;
	res = XCALL;

	if(res != True) {
		report("%s() did not return True", TestName);
		report("for a region obtained from the union of two disjoint regions.");
		FAIL;
	} else
		CHECK;

	CHECKPASS(2);

>>ASSERTION Good A
When the region
.A r
is not empty, then a call to xname returns
.S False .
>>STRATEGY
Create a region using XCreateRegion.
Set the region using XUnionRectWithRegion.
Verify that the region is non-empty using xname.
>>CODE
Bool			res;
Region			R1;
static	XRectangle	rect1 = {0,0, 1,1 };

	R1 = makeregion();	
	if(isdeleted()) return;

	XUnionRectWithRegion(&rect1, R1, R1);
	r = R1;
	res = XCALL;

	if(res != False) {
		report("%s() did not return False", TestName);
		report("for a region obtain by a call to XUnionRectWithRegion().");
		FAIL;
	} else
		PASS;
