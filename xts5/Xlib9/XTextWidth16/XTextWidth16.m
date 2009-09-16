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
>># File: xts5/tset/Xlib9/XTextWidth16/XTextWidth16.m
>># 
>># Description:
>># 	Tests for XTextWidth16()
>># 
>># Modifications:
>># $Log: txtwdth16.m,v $
>># Revision 1.2  2005-11-03 08:43:59  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:39  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:30:51  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:50:08  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:22:37  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:19:09  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:00:21  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  00:55:53  andy
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
>>TITLE XTextWidth16 Xlib9
int

XFontStruct	*font_struct;
XChar2b	*string = ch1;
int 	count = NELEM(ch1);
>>EXTERN

static	XChar2b	ch1[] = {
	{0, 34}, {0, 54}, {0, 89}, {0, 100}, {0, 130}, {0, 201}, {0, 234}, {0, 255},
	{1, 34}, {1, 54}, {1, 89}, {1, 100}, {1, 130}, {1, 201}, {1, 234}, {1, 255},
	{2, 34}, {2, 54}, {2, 89}, {2, 100}, {2, 130}, {2, 201}, {2, 234}, {2, 255},
	{33, 34}, {33, 54}, {33, 89}, {33, 100}, {33, 130}, {33, 201}, {33, 234}, {33, 255},
	{36, 34}, {36, 54}, {36, 89}, {36, 100}, {36, 130}, {36, 201}, {36, 234}, {36, 255},
	{38, 34}, {38, 54}, {38, 89}, {38, 100}, {38, 130}, {38, 201}, {38, 234}, {38, 255},
	{48, 34}, {48, 54}, {48, 89}, {48, 100}, {48, 130}, {48, 201}, {48, 234}, {48, 255},
	{120, 34}, {120, 54}, {120, 89}, {120, 100}, {120, 130}, {120, 201}, {120, 234}, {120, 255},
};

extern	struct	fontinfo	fontinfo[];
extern	int 	nfontinfo;
>>ASSERTION Good A
A call to xname returns the sum of the character-width
metrics of all characters in the 16-bit or 2-byte character string,
.A string ,
as rendered in the font referenced by
.A font_struct .
>>STRATEGY
For each 16-bit font
  Call XTextWidth16 with string.
  Verify returned value by direct calculation from metric info.
>>CODE
int 	i;
int 	width;
int 	calcwidth;
int 	n16;

	n16 = 0;

	for (i = 0; i < nfontinfo; i++) {
		font_struct = fontinfo[i].fontstruct;
		if (font_struct->max_byte1 == 0)
			continue;

		n16++;

		width = XCALL;

		calcwidth = txtwidth16(font_struct, ch1, count);

		if (calcwidth != width) {
			report("Font %s - width was %d, expecting %d", fontinfo[i].name,
					width, calcwidth);
			FAIL;
		} else
			CHECK;
	}
	CHECKPASS(n16);
>>ASSERTION Good B 2
>># How can we know if the font is defined with linear indexing?
When the
font is defined with linear indexing rather than 2-byte matrix indexing,
then each
.S XChar2b
structure is interpreted as a 16-bit number with byte1 as the
most-significant byte.
>># HISTORY kieron Completed    Reformat and tidy to ca pass
