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
$Header: /cvs/xtest/xtest/xts5/tset/Xlib17/rctinrgn/rctinrgn.m,v 1.2 2005-11-03 08:43:11 jmichael Exp $

Copyright (c) Applied Testing and Technology, Inc. 1995
All Rights Reserved.

>># Project: VSW5
>># 
>># File: xts5/tset/Xlib17/rctinrgn/rctinrgn.m
>># 
>># Description:
>># 	Tests for XRectInRegion()
>># 
>># Modifications:
>># $Log: rctinrgn.m,v $
>># Revision 1.2  2005-11-03 08:43:11  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:23  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:34:50  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:57:14  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:26:07  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:22:40  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:11:37  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:14:20  andy
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
>>TITLE XRectInRegion Xlib17
int
XRectInRegion(r, x, y, width, height)
Region		r;
int		x;
int		y;
unsigned int	width;
unsigned int	height;
>>EXTERN
static XRectangle	medrect = { 10,10, 15,5 };
>>ASSERTION Good A
When the rectangle specified by the
.A x ,
.A y ,
.A width ,
and
.A height
arguments is entirely in the region
.A r ,
then a call to xname returns
.S RectangleIn .
>>STRATEGY
Create a region using XCreateRegion.
Set the region to a rectangle using XUnionRectWithRegion.
Verify that with a contained rectangle xname returns RectangleIn.
>>CODE
Region			R;
int			res;

	R = makeregion();
	if(isdeleted()) return;

	XUnionRectWithRegion(&medrect, R, R);
	r = R;
	x=10;	
	y=10;
	width=15;
	height=5;

	res = XCALL;

	if(res != RectangleIn) {
		report("%s() returned %d instead of RectangleIn (%d).", TestName, res, RectangleIn);
		FAIL;
	} else
		PASS;

>>ASSERTION Good A
When the rectangle specified by the
.A x ,
.A y ,
.A width ,
and
.A height
arguments is entirely out of the region
.A r ,
then a call to xname returns
.S RectangleOut .
>>STRATEGY
Create a region using XCreateRegion.
Set the region to a rectangle using XUnionRectWithRegion.
Verify that with a non-intersecting rectangle xname returns RectangleOut.
>>CODE
Region			R;
int			res;

	R = makeregion();
	if(isdeleted()) return;

	XUnionRectWithRegion(&medrect, R, R);
	r = R;
	x=35;	
	y=15;
	width=5;
	height=2;

	res = XCALL;

	if(res != RectangleOut) {
		report("%s() returned %d instead of RectangleOut (%d).", TestName, res, RectangleOut);
		FAIL;
	} else
		PASS;

>>ASSERTION Good A
When the rectangle specified by the
.A x ,
.A y ,
.A width ,
and
.A height
arguments is partly in the region
.A r ,
then a call to xname returns
.S RectanglePart .
>>STRATEGY
Create a region using XCreateRegion.
Set the region to a rectangle using XUnionRectWithRegion.
Verify that with an intersecting rectangle xname returns RectanglePart.
>>CODE
Region			R;
int			res;

	R = makeregion();
	if(isdeleted()) return;

	XUnionRectWithRegion(&medrect, R, R);
	r = R;
	x=20;	
	y=5;
	width=4;
	height=10;

	res = XCALL;

	if(res != RectanglePart) {
		report("%s() returned %d instead of RectanglePart (%d).", TestName, res, RectanglePart);
		FAIL;
	} else
		PASS;

