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
$Header: /cvs/xtest/xtest/xts5/tset/Xlib9/ldfnt/ldfnt.m,v 1.1 2005-02-12 14:37:43 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1995
All Rights Reserved.

>># Project: VSW5
>># 
>># File: vsw5/tset/Xlib9/ldfnt/ldfnt.m
>># 
>># Description:
>># 	Tests for XLoadFont()
>># 
>># Modifications:
>># $Log: ldfnt.m,v $
>># Revision 1.1  2005-02-12 14:37:43  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:30:42  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:49:50  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:22:29  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:19:01  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 08:59:56  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  00:55:11  andy
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
>>TITLE XLoadFont Xlib9
Font

Display	*display = Dsp;
char	*name = "xtfont1";
>>SET startup fontstartup
>>SET cleanup fontcleanup
>>ASSERTION Good A
When 
.A name
is a NULL terminated string in ISO Latin-1 encoding,
then
a call to xname
loads the specified font and returns its font ID.
>>STRATEGY
For each VSW5 font:
  Load font.
  Make some simple checks to see if a font ID is returned.
>>CODE
Font	font;
int 	i;
char	fname[64];

	for (i = 0; i < XT_NFONTS; i++) {
		sprintf(fname, "xtfont%d", i);
		trace("Loading font %s", fname);
		name = fname;

		font = XCALL;

		if (geterr() != Success) {
			report("font %s could not be loaded", fname);
			report("Check that VSW5 fonts have been installed");
			FAIL;
		} else if (font == 0 || (font & 0xc0000000)) {
			report("An invalid font ID was returned");
			FAIL;
		} else
			CHECK;
	}
	CHECKPASS(XT_NFONTS);

>>ASSERTION Good A
The font ID returned by a call to xname is usable 
on any GC created for any screen of the display.
>>STRATEGY
For each visual supported for the default screen:
  Load font \"xtfont1\".
  Create window.
  Create GC for window.
  Set font component in GC to loaded font.
  Draw string with single character.
  Pixmap verify.
Note: this tests the GC's for the default screen. 
To test for other screens, re-run the test suite with XT_DISPLAY set 
to number of required screen.
>>CODE
XVisualInfo	*vp;
Font	font;
char	*fname = "xtfont1";
Drawable d;
GC	gc;

	for (resetvinf(VI_WIN_PIX); nextvinf(&vp); ) {
		name = fname;

		font = XCALL;

		if (geterr() != Success) {
			/* Already done after calling XLoadFont */
			report("font %s could not be loaded", fname);
			report("Check that VSW5 fonts have been installed");
			FAIL;
		} else {
			d = makewin(display, vp);
			gc = makegc(display, d);
			XSetFont(display, gc, font);
			XDrawString(display, d, gc, 20, 20, "z", 1);
			PIXCHECK(display, d);
			dclear(display, d);
			XUnloadFont(display, font);
		}
	}
	CHECKPASS(nvinf());

>>ASSERTION Good A
Upper and lower case characters in the
.A name
argument refer to the same font.
>># The name arg is case insensitive.
>>STRATEGY
Try series of name differing only in case.
Font ID is different each time so have to..
Draw string and save result in original font.
Verify that font returned using each name draws same string.
>>EXTERN
#define TEXTSTRING "AbyZ%~"
>>CODE
Font	font;
static char	*names[] = {
	"xtfont1",
	"Xtfont1",
	"XTFONT1",
	"xTfOnT1",
	"XtFoNt1",
};
int 	i;
Drawable	draw;
XImage	*sav;
GC		gc;

	name = "xtfont1";
	font = XCALL;
	if (geterr() != Success) {
		/* Test has already failed */
		delete("Font could not be loaded");
		return;
	}

	draw = defdraw(display, VI_WIN_PIX);
	gc = makegc(display, draw);
	XSetFont(display, gc, font);

	XDrawString(display, draw, gc, 30, 30, TEXTSTRING, strlen(TEXTSTRING));
	sav = savimage(display, draw);

	if (isdeleted())
		return;

	for (i = 0; i < NELEM(names); i++) {

		dclear(display, draw);
		name = names[i];
		font = XCALL;

		if (geterr() == Success) {
			XSetFont(display, gc, font);
			XDrawString(display, draw, gc, 30, 30, TEXTSTRING, strlen(TEXTSTRING));
			if (compsavimage(display, draw, sav))
				CHECK;
			else {
				report("Font %s was different to xtfont1", name);
				FAIL;
			}
		} else {
			report("Font load failed with name %s", name);
			FAIL;	/* Has been done already */
		}
	}
	CHECKPASS(NELEM(names));
>>ASSERTION Bad A
.ER BadName font
>>ASSERTION Bad B 3
.ER BadAlloc 
>># HISTORY kieron Completed	Reformat and tidy to ca pass
