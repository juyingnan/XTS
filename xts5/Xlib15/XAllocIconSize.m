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
>># File: xts5/Xlib15/XAllocIconSize.m
>># 
>># Description:
>># 	Tests for XAllocIconSize()
>># 
>># Modifications:
>># $Log: allcicnsz.m,v $
>># Revision 1.2  2005-11-03 08:42:47  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:20  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:33:47  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:55:36  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:25:10  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:21:42  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:08:51  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:10:25  andy
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
>>TITLE XAllocIconSize Xlib15
XIconSize	*XAllocIconSize()
>>ASSERTION Good A
A call to xname allocates and returns a pointer to a
.S XIconSize 
structure in which each component is set to zero.
>>STRATEGY
Allocate a XIconSize structure using XAllocIconSize.
Verify that the function did not return NULL.
Verify that each component of the structure is 0.
Release the allocated memory using XFree.
>>CODE
XIconSize	*isize;

	isize = XCALL;

	if(isize == (XIconSize *) NULL) {
		delete("%s() returned NULL.", TestName);
		return;
	} else
		CHECK;

	if(isize->min_width != 0) {
		report("The min_width component of the XIconSize structure was %d instead of zero", isize->min_width);
		FAIL;
	} else
		CHECK;

	if(isize->min_height != 0) {
		report("The min_height component of the XIconSize structure was %d instead of zero", isize->min_height);
		FAIL;
	} else
		CHECK;

	if(isize-> max_width != 0) {
		report("The max_width component of the XIconSize structure was %d instead of zero", isize-> max_width);
		FAIL;
	} else
		CHECK;

	if(isize->max_height != 0) {
		report("The max_height component of the XIconSize structure was %d instead of zero", isize->max_height);
		FAIL;
	} else
		CHECK;

	if(isize->width_inc != 0) {
		report("The width_inc component of the XIconSize structure was %d instead of zero", isize->width_inc);
		FAIL;
	} else
		CHECK;

	if(isize-> height_inc != 0) {
		report("The height_inc component of the XIconSize structure was %d instead of zero", isize->height_inc);
		FAIL;
	} else
		CHECK;

	CHECKPASS(7);

>>ASSERTION Bad B 1
When insufficient memory is available, then
a call to xname returns NULL.
>># Kieron	Action	Review
