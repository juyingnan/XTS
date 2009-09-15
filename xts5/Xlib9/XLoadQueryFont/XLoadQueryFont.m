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
>># File: xts5/Xlib9/XLoadQueryFont/XLoadQueryFont.m
>># 
>># Description:
>># 	Tests for XLoadQueryFont()
>># 
>># Modifications:
>># $Log: ldqryfnt.m,v $
>># Revision 1.2  2005-11-03 08:43:57  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:39  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:30:43  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:49:52  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:22:30  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:19:02  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 08:59:58  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  00:55:15  andy
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
>>TITLE XLoadQueryFont Xlib9
XFontStruct *

Display	*display = Dsp;
char	*name = "xtfont0";
>>SET startup fontstartup
>>SET cleanup fontcleanup
>>ASSERTION Good A
When the 
.A name
argument names an existing font, 
then a call to xname loads the font named
.A name ,
and returns a pointer to an
.S XFontStruct 
structure which contains information on the font.
>>STRATEGY
For each VSW5 font:
  Load and query font.
  Compare returned XFontStruct with known good structures.
>>EXTERN
extern	int 	checkfsp();
extern	struct	fontinfo fontinfo[];
extern	int 	nfontinfo;
>>CODE
XFontStruct	*fsp;
int 	i;


	for (i = 0; i < nfontinfo; i++) {
		name = fontinfo[i].name;
		trace("Loading %s", name);
		fsp = XCALL;
		if (checkfsp(fsp, fontinfo[i].fontstruct, *fontinfo[i].string))
			CHECK;
		else
			FAIL;
	}

	CHECKPASS(nfontinfo);

>>ASSERTION Good A
The font ID returned by a call to xname is usable 
on any GC created for any screen of the display.
>>STRATEGY
For each visual supported for the default screen:
  Load and query font \"xtfont1\".
  Create window.
  Create GC for window.
  Set font component in GC to loaded font.
  Draw string with single character.
  Pixmap verify.
Note: this tests the GC's for the default screen. 
To test for other screens, re-run the test suite with DISPLAY set 
to number of required screen.
>>CODE
XVisualInfo	*vp;
Font	font;
XFontStruct	*fsp;
Drawable d;
GC	gc;

	for (resetvinf(VI_WIN_PIX); nextvinf(&vp); ) {
		name = fontinfo[1].name;

		fsp = XCALL;
		font = fsp->fid;

		if (geterr() != Success) {
			/* Already done after calling XLoadFont */
			report("font %s could not be loaded", name);
			report("Check that VSW5 fonts have been installed");
			FAIL;
		} else {
			d = makewin(display, vp);
			gc = makegc(display, d);
			XSetFont(display, gc, font);
			XDrawString(display, d, gc, 20, 20, "z", 1);
			PIXCHECK(display, d);
			dclear(display, d);
			XFreeFont(display, fsp);
		}
	}
	CHECKPASS(nvinf());


>>ASSERTION Good A
When the 
.A name
argument does not name an existing font, 
then xname returns NULL.
>>STRATEGY
Set name to a non-existant name.
Verify that NULL is returned.
>>CODE
XFontStruct	*fsp;

	name = config.bad_font_name;
	fsp = XCALL;

	if (fsp == NULL)
		PASS;
	else {
		report("NULL was not returned when the name was '%s'", name);
		FAIL;
	}
>>ASSERTION Good A
Upper and lower case characters in the
.A name
argument refer to the same font.
>>STRATEGY
Load font by name xtfont0.
Load font by name XtFoNt0.
Verify that this name also succeeds and that
the returned XFontStruct's are the same.
>>CODE
XFontStruct	*fsp1;
XFontStruct	*fsp2;

	name = "xtfont0";
	fsp1 = XCALL;
	if (fsp1 == NULL) {
		delete("Could not load font %s", name);
		return;
	}

	name = "XtFoNt0";
	fsp2 = XCALL;
	if (fsp2 == NULL) {
		report("Font could not be loaded with name %s", name);
		FAIL;
		return;
	}

	/*
	 * The checking of the copyright property is inhibited, so that
	 * this test can pass even if the first one doesn't.
	 */
	if (checkfsp(fsp2, fsp1, (char*)0))
		PASS;
	else {
		report("Different XFontStruct descriptions were returned");
		FAIL;
	}
>>ASSERTION Bad A
.ER BadAlloc 
>># HISTORY kieron Completed	Reformat and tidy to ca pass
