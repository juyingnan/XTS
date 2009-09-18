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
>># File: xts5/Xlib9/XUnloadFont/XUnloadFont.m
>># 
>># Description:
>># 	Tests for XUnloadFont()
>># 
>># Modifications:
>># $Log: unldfnt.m,v $
>># Revision 1.2  2005-11-03 08:44:00  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:39  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:30:52  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:50:09  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:22:37  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:19:09  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:00:23  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  00:55:56  andy
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
>>TITLE XUnloadFont Xlib9
void

Display	*display = Dsp;
Font	font;
>>SET startup fontstartup
>>SET cleanup fontcleanup
>>ASSERTION Good A
When another resource or resource ID references the
.A font ,
then a call to xname
deletes the association between the
.A font
resource ID 
and the specified font.
>>STRATEGY
Load a font.
Call XUnloadFont.
Verify that the font ID is no longer usable.
>>CODE
GC		gc;

	gc = makegc(display, DRW(display));
	if (isdeleted())
		return;
	font = XLoadFont(display, "xtfont0");

	XCALL;

	/* Try to use the font */
	XSetErrorHandler(error_status);
	reseterr();
	XSetFont(display, gc, font);
	XDrawString(display, DRW(display), gc, 30, 30, "abc", 3);
	XSync(display, 0);
	switch (geterr()) {
	case Success:
		report("font ID was still usable");
		FAIL;
		break;
	case BadFont:
		PASS;
		break;
	default:
		delete("Unexpected error in draw string");
		break;
	}
	XSetErrorHandler(unexp_err);
	
>>ASSERTION Good B 3
When no other resource or resource ID references the
.A font ,
then a call to xname
deletes the association between the
.A font
resource ID 
and the specified font 
and the font itself will be freed.
>>ASSERTION Bad A
.ER BadFont bad-font
>># HISTORY kieron Completed	Reformat and tidy to ca pass