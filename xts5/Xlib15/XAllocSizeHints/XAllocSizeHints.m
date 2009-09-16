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
>># File: xts5/tset/Xlib15/XAllocSizeHints/XAllocSizeHints.m
>># 
>># Description:
>># 	Tests for XAllocSizeHints()
>># 
>># Modifications:
>># $Log: allcszhnts.m,v $
>># Revision 1.2  2005-11-03 08:42:47  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:20  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:33:48  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:55:38  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:25:11  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:21:43  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:08:54  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:10:29  andy
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
>>TITLE XAllocSizeHints Xlib15
XSizeHints *
XAllocSizeHints()
>>ASSERTION Good A
A call to xname allocates and returns a pointer to a
.S XSizeHints 
structure, which can be freed with
.S XFree ,
in which each component is set to zero.
>>STRATEGY
Allocate an XSizeHints structure with XAllocSizeHints.
Verify NULL is not returned.
Verify that each component of the structure is set to zero.
Release the allocated memory using XFree.
>>CODE
XSizeHints	*shints;

	shints = XAllocSizeHints();

	if (shints == (XSizeHints *)NULL) {
		delete("XAllocSizeHints returned NULL.");
		return;
	} else
		CHECK;

	if(shints->flags != 0L) {
		report("The flags component of the XSizeHints structure was not zero.");
		FAIL;
	} else
		CHECK;

	if(shints->x != 0) {
		report("The x component of the XSizeHints structure was not zero.");
		FAIL;
	} else
		CHECK;

	if(shints->y != 0) {
		report("The y component of the XSizeHints structure was not zero.");
		FAIL;
	} else
		CHECK;

	if(shints->width != 0) {
		report("The width component of the XSizeHints structure was not zero.");
		FAIL;
	} else
		CHECK;

	if(shints->height != 0) {
		report("The height component of the XSizeHints structure was not zero.");
		FAIL;
	} else
		CHECK;

	if(shints->min_width != 0) {
		report("The min_width component of the XSizeHints structure was not zero.");
		FAIL;
	} else
		CHECK;

	if(shints->min_height != 0) {
		report("The min_height component of the XSizeHints structure was not zero.");
		FAIL;
	} else
		CHECK;

	if(shints->max_width != 0) {
		report("The max_width component of the XSizeHints structure was not zero.");
		FAIL;
	} else
		CHECK;

	if(shints->max_height != 0) {
		report("The max_height component of the XSizeHints structure was not zero.");
		FAIL;
	} else
		CHECK;

	if(shints->width_inc != 0) {
		report("The width_inc component of the XSizeHints structure was not zero.");
		FAIL;
	} else
		CHECK;

	if(shints->height_inc != 0) {
		report("The height_inc component of the XSizeHints structure was not zero.");
		FAIL;
	} else
		CHECK;

	if((shints->min_aspect.x != 0) || (shints->min_aspect.y != 0)){
		report("The min_aspect components of the XSizeHints structure were not zero.");
		FAIL;
	} else
		CHECK;

	if((shints->max_aspect.x != 0) || (shints->max_aspect.y != 0)){
		report("The max_aspect components of the XSizeHints structure were not zero.");
		FAIL;
	} else
		CHECK;

	if(shints->base_width != 0) {
		report("The base_width component of the XSizeHints structure was not zero.");
		FAIL;
	} else
		CHECK;

	if(shints->base_height != 0) {
		report("The base_height component of the XSizeHints structure was not zero.");
		FAIL;
	} else
		CHECK;

	if(shints->win_gravity != 0) {
		report("The win_gravity component of the XSizeHints structure was not zero.");
		FAIL;
	} else
		CHECK;


	XFree((char *) shints);
	CHECKPASS(17);

>>ASSERTION Good B 1
When insufficient memory is available, then
a call to xname returns NULL.
>># Kieron	Completed	Review
