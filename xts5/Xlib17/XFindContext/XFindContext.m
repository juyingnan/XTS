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
>># File: xts5/Xlib17/XFindContext/XFindContext.m
>># 
>># Description:
>># 	Tests for XFindContext()
>># 
>># Modifications:
>># $Log: fndcntxt.m,v $
>># Revision 1.3  2005-11-03 08:43:04  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.2  2005/04/15 14:37:14  anderson
>># Merge baseline changes
>>#
>># Revision 1.1  2005/02/12 14:37:30  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:34:35  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:56:56  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:25:53  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:22:25  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:10:55  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:13:29  andy
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
>>TITLE XFindContext Xlib17
int

Display *display = Dsp;
Window w = defwin(display);
XContext context = XUniqueContext();
caddr_t *data_return = &xfc_data;
>>EXTERN
static caddr_t xfc_data;

static char *xfc_ctxt = "another context";
>>ASSERTION Good A
A call to xname returns the context data
for display 
.A display ,
window
.A w
and context type
.A context 
in
.A data_return ,
and returns zero.
>>STRATEGY
Create a test window.
Save some context information using XSaveContext.
Find the context information using xname.
Verify the context was returned as expected.
>>CODE
int a;
int ret;

/* Create a test window. */
/* Save some context information using XSaveContext. */
	a = XSaveContext(display, w, context, (caddr_t)xfc_ctxt);
	if (a != 0) {
		delete("Could not save test context.");
		report("Returned error: %s", contexterrorname(a));
		return;
	} else
		CHECK;

/* Find the context information using xname. */
	xfc_data = (caddr_t)NULL;
	ret = XCALL;

/* Verify the context was returned as expected. */
#ifdef TEST_RPT
	xfc_data++;
#endif
	if (ret != 0) {
		FAIL;
		report("%s returned an error when expected to succeed.",
			TestName);
		report("Returned error: %s", contexterrorname(ret));
	} else {
		CHECK;
		if (xfc_data != (caddr_t)xfc_ctxt) {
			FAIL;
			report("%s did not return the expected context data.",
				TestName);
			report("Expected context: %0x", (unsigned int)xfc_ctxt);
			report("Returned context: %0x", (unsigned int)xfc_data);
		} else
			CHECK;
	}

	CHECKPASS(3);
>>ASSERTION Bad A
When there is no previously saved context data
for display
.A display ,
window
.A w
and context type
.A context ,
then a call to xname returns
.S XCNOENT .
>>STRATEGY
Create a test window with no context.
Call xname to find the non-existent context.
Verify that XCNOENT was returned.
>>CODE
int ret;

/* Create a test window with no context. */

/* Call xname to find the non-existent context. */
	ret = XCALL;

#ifdef TEST_RPT
	ret = 0;
#endif

/* Verify that XCNOENT was returned. */
	if (ret != XCNOENT) {
		FAIL;
		report("%s did not return XCNOENT when",
			TestName);
		report("finding a non-existent context.");
		report("Return code: %s", contexterrorname(ret));
	} else
		CHECK;

	CHECKPASS(1);

