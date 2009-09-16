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
>># File: xts5/Xlib15/XSetClassHint/XSetClassHint.m
>># 
>># Description:
>># 	Tests for XSetClassHint()
>># 
>># Modifications:
>># $Log: stclsshnt.m,v $
>># Revision 1.2  2005-11-03 08:42:50  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:21  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:33:59  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:55:59  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:25:21  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:21:53  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.1  1996/05/09 00:28:59  andy
>># Corrected Xatom include
>>#
>># Revision 4.0  1995/12/15  09:09:23  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:11:21  andy
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
>>TITLE XSetClassHint Xlib15
 
XSetClassHint(display, w, class_hints)
Display		*display = Dsp;
Window		w = DRW(Dsp);
XClassHint	*class_hints = &chint;
>>EXTERN
#include	"X11/Xatom.h"
XClassHint	chint = { "DefName", "DefClass"};
>>ASSERTION Good A
A call to xname sets the WM_CLASS property for
the window
.A w
to be of
.M type
.S STRING ,
.M format
8 and to have
.M value
set to the strings in the
.M res_name
and
.M res_class
members of the
.S XClassHint
structure named by the
.A class_hints
argument, in that order and null-separated.
>>STRATEGY
Create a window with XCreateWindow.
Set the WM_CLASS property for the window using XSetClassHint.
Obtain the value type and format  of the WM_CLASS property using XGetWindowProperty.
Verify that the format is 8.
Verify that the type is STRING.
Verify that the value is correct.
>>CODE
Window		win;
XVisualInfo	*vp;
XClassHint	classhint, retchint;
int		reslen;
char		*propp = NULL, *s;
unsigned long	leftover, nitems, len;
int		actual_format;
Atom		actual_type;

	resetvinf(VI_WIN);
	nextvinf(&vp);
	win = makewin(display, vp);

	classhint.res_name = "XTestResName";
	classhint.res_class = "XTestClassName";

	reslen = strlen(classhint.res_name);
	len = reslen + 1 + strlen(classhint.res_class) + 1;

	w = win;
	class_hints = &classhint;
	XCALL;

	if (XGetWindowProperty(display, win, XA_WM_CLASS, 0L, len, False,
	     AnyPropertyType, &actual_type, &actual_format, &nitems, &leftover,
		 (unsigned char **)&propp) != Success) {
		delete("XGetWindowProperty() did not return Success.");
		return;
	} else
		CHECK;

	if(leftover != 0) {
		report("The leftover elements numbered %lu instead of 0", leftover);
		FAIL;
	} else
		CHECK;

	if(actual_format != 8) {
		report("The format of the WM_HINTS property was %lu instead of 8", actual_format);
		FAIL;
	} else
		CHECK;

	if(actual_type != XA_STRING) {
		report("The type of the WM_CLASS property was %lu instead of STRING (%lu).", actual_type, (unsigned long) XA_STRING);
		FAIL;
	} else
		CHECK;

	if(propp == NULL) {

		report("No value was set for the WM_CLASS property.");
		FAIL;		

	} else {

		if(strcmp(propp, classhint.res_name) != 0) {
			report("The res_name component of the XClassHint structure was \"%s\" instead of \"%s\"", propp, classhint.res_name);
			FAIL;
		} else
			CHECK;

		if(strcmp(s = propp+1+reslen, classhint.res_class) != 0) {
			report("The res_class component of the XClassHint structure was \"%s\" instead of \"%s\".", s, classhint.res_class);
			FAIL;
		} else
			CHECK;
		XFree((char*)propp);
	}

	CHECKPASS(6);

>>ASSERTION Bad B 1
.ER BadAlloc 
>>ASSERTION Bad A
.ER BadWindow 
>># Kieron	Completed	Review
