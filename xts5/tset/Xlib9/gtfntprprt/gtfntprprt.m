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
$Header: /cvs/xtest/xtest/xts5/tset/Xlib9/gtfntprprt/gtfntprprt.m,v 1.1 2005-02-12 14:37:43 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1995
All Rights Reserved.

>># Project: VSW5
>># 
>># File: vsw5/tset/Xlib9/gtfntprprt/gtfntprprt.m
>># 
>># Description:
>># 	Tests for XGetFontProperty()
>># 
>># Modifications:
>># $Log: gtfntprprt.m,v $
>># Revision 1.1  2005-02-12 14:37:43  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:30:39  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:49:45  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:22:27  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:18:59  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.1  1996/05/09 00:32:33  andy
>># Corrected Xatom include
>>#
>># Revision 4.0  1995/12/15  08:59:48  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  00:54:53  andy
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
>>TITLE XGetFontProperty Xlib9
Bool

XFontStruct	*font_struct;
Atom	atom;
unsigned long	*value_return;
>>SET startup fontstartup
>>SET cleanup fontcleanup
>>EXTERN
#include	"X11/Xatom.h"
>>ASSERTION Good A
When the property specified by the
.A atom
argument
is defined,
then a call to xname returns
the value of the property
.A atom
in the
.S XFontStruct
named by the argument
.A font_struct
and returns
.S True .
>>STRATEGY
Retrieve properties that are known to be defined for the test fonts.
Verify that True is returned.
Verify that the value of the properties are correct.
>>CODE
unsigned long	val;
Bool	ret;
int 	i;
XFontProp	*fprop;
extern	XFontStruct	xtfont0;	/* Known good version */
extern	char	*xtfont0cpright;	/* Known good version */

	font_struct = XLoadQueryFont(Dsp, "xtfont0");
	if (font_struct == NULL || isdeleted()) {
		delete("Could not load font, check that VSW5 fonts are installed");
		return;
	}

	value_return = &val;

	for (i = 0; i < xtfont0.n_properties; i++) {
		fprop = &xtfont0.properties[i];
		atom = fprop->name;

		ret = XCALL;
		if (ret != True) {
			report("call did not return True for atom %s", atomname(atom));
			FAIL;
			continue;
		} else
			CHECK;

		if (atom == XA_COPYRIGHT) {
		char	*crstr;

			XSetErrorHandler(error_status);
			reseterr();
			crstr = XGetAtomName(Dsp, val);
			XSetErrorHandler(unexp_err);
			switch (geterr()) {
			case Success:
				break;
			case BadAtom:
				report("copyright string atom did not exist");
				FAIL;
				break;
			default:
				delete("Call to XGetAtomName failed");
				return;
			}

			if (strcmp(crstr, xtfont0cpright) == 0)
				CHECK;
			else {
				report("XA_COPYRIGHT was '%s',", crstr);
				report(" expecting '%s'", xtfont0cpright);
				FAIL;
			}

		} else {
			/* Compare value */
			if (fprop->card32 == val)
				CHECK;
			else {
				report("value of %s was %d, expecting %d",
					atomname(atom), val, fprop->card32);
				FAIL;
			}
		}
	}
	CHECKPASS(2*xtfont0.n_properties);

>>ASSERTION Good A
>># NOTE	kieron	Have to have defined fonts (bdf format)
>>#			loaded as the pre-defined properties (in X11/Xatom.h)
>>#			are likely, but not guaranteed, to be present on any
>>#			server.
When the property specified by the
.A atom
argument
is not defined,
then a call to xname returns
.S False .
>>STRATEGY
Use the XA_RGB_DEFAULT_MAP atom which is not defined in the VSW5 fonts,
(and is unlikely to be defined in a font..)
Verify that False is returned.
>>CODE
unsigned long	val;
Bool	ret;
int 	i;
extern	XFontStruct	xtfont0;	/* Known good version */

	font_struct = XLoadQueryFont(Dsp, "xtfont0");
	if (font_struct == NULL || isdeleted()) {
		delete("Could not load font, check that VSW5 fonts are installed");
		return;
	}

	value_return = &val;

	atom = XA_RGB_DEFAULT_MAP;

	ret = XCALL;

	if (ret != False)
		FAIL;
	else
		PASS;

>># HISTORY	kieron	Completed	Reformat and tidy to ca pass
