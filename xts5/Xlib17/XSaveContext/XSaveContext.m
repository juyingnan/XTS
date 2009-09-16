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
>># File: xts5/tset/Xlib17/XSaveContext/XSaveContext.m
>># 
>># Description:
>># 	Tests for XSaveContext()
>># 
>># Modifications:
>># $Log: svcntxt.m,v $
>># Revision 1.3  2005-11-03 08:43:13  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.2  2005/04/15 14:37:14  anderson
>># Merge baseline changes
>>#
>># Revision 1.1  2005/02/12 14:37:31  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:34:56  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:57:20  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:26:12  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:22:45  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:11:51  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:14:39  andy
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
>>TITLE XSaveContext Xlib17
int

Display *display = Dsp;
Window w = defwin(display);
XContext context = XUniqueContext();
caddr_t data;
>>EXTERN

static char *xsc_ctxt ="set context";
static char *xsc_ctxt2 ="set context two";

>>ASSERTION Good A
A call to xname sets the table entry for context data
for display 
.A display ,
window
.A w
and context type
.A context 
to the specified value
.A data ,
and returns zero.
>>STRATEGY
Call xname to enter the context data.
Verify that zero was returned.
Call XFindContext to verify that the context data was added correctly.
>>CODE
int a;
int ret;
caddr_t b;

/* Call xname to enter the context data. */
	data = (caddr_t) xsc_ctxt;
	ret = XCALL;

/* Verify that zero was returned. */
	if (ret != 0) {
		FAIL;
		report("%s returned non-zero when expected zero.",
			TestName);
		report("Returned value: %s", contexterrorname(ret));
	} else
		CHECK;

/* Call XFindContext to verify that the context data was added correctly. */
	a = XFindContext(display, w, context, &b);
	if (a != 0) {
		FAIL;
		report("XFindContext failed to find the context saved by %s", TestName);
		report("XFindContext returned %s", contexterrorname(a));
	} else {
		CHECK;

		if (b != (caddr_t)xsc_ctxt) {
			FAIL;
			report("XFindContext returned an unexpected context.");
			report("Expected context: %0x", (unsigned int)xsc_ctxt);
			report("Returned context: %0x", (unsigned int)b);
		} else
			CHECK;
	}

	CHECKPASS(3);

>>ASSERTION Good A
When there is previously saved context data
for display
.A display ,
window
.A w
and context type
.A context ,
then a call to xname replaces the previously saved context data
with the specified value
.A data ,
and returns zero.
>>STRATEGY
Call xname to set the context data.
Verify that zero was returned.
Call xname to reset the context data.
Verify that zero was returned.
Call XFindContext to verify that the context data was added correctly.
>>CODE
int a;
int ret;
caddr_t b;

/* Call xname to set the context data. */
	data = (caddr_t) xsc_ctxt;
	ret = XCALL;

/* Verify that zero was returned. */
	if (ret != 0) {
		FAIL;
		report("%s returned non-zero when expected zero when setting",
			TestName);
		report("context information.");
		report("Returned value: %s", contexterrorname(ret));
	} else
		CHECK;

/* Call xname to reset the context data. */
	data = (caddr_t) xsc_ctxt2;
	ret = XCALL;

/* Verify that zero was returned. */
	if (ret != 0) {
		FAIL;
		report("%s returned non-zero when expected zero when resetting",
			TestName);
		report("context information.");
		report("Returned value: %s", contexterrorname(ret));
	} else
		CHECK;

/* Call XFindContext to verify that the context data was added correctly. */
	a = XFindContext(display, w, context, &b);
	if (a != 0) {
		FAIL;
		report("XFindContext failed to find the context saved by %s", TestName);
		report("XFindContext returned %s", contexterrorname(a));
	} else {
		CHECK;

		if (b != (caddr_t)xsc_ctxt2) {
			FAIL;
			report("XFindContext returned an unexpected context.");
			report("Original context: %0x", (unsigned int)xsc_ctxt);
			report("Expected context: %0x", (unsigned int)xsc_ctxt2);
			report("Returned context: %0x", (unsigned int)b);
		} else
			CHECK;
	}

	CHECKPASS(4);
>>ASSERTION Bad B 1
When there is insufficient memory, then a call to xname returns
.S XCNOMEM .
