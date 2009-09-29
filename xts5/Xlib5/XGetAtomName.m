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
>># File: xts5/Xlib5/XGetAtomName.m
>># 
>># Description:
>># 	Tests for XGetAtomName()
>># 
>># Modifications:
>># $Log: gtatmnm.m,v $
>># Revision 1.2  2005-11-03 08:43:38  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:27  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:26:44  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:45:01  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:18:58  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:15:29  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.1  1996/05/09 00:34:17  andy
>># Corrected Xatom include
>>#
>># Revision 4.0  1995/12/15  08:48:32  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  00:47:16  andy
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
>>TITLE XGetAtomName Xlib5
char *

Display *display = Dsp;
Atom atom;
>>EXTERN
#include "X11/Xatom.h"

static struct xga_struct {
	char *name;
	Atom atom;
} xga_list[] = {
	 "PRIMARY", XA_PRIMARY, 
	 "CUT_BUFFER0", XA_CUT_BUFFER0, 
	 "RECTANGLE", XA_RECTANGLE,
	 "COPYRIGHT", XA_COPYRIGHT,
};
static int xga_nlist = NELEM(xga_list);

>>ASSERTION Good A
A call to xname returns the name, which can be freeed with XFree,
associated with the specified
.A atom .
>>STRATEGY
For some predefined atoms:
	Call xname to obtain the name associated with the atom.
	Verify the strings returned were as expected.
>>CODE
char *ret_str;
int l;

/* For some predefined atoms: */
	for(l=0; l<xga_nlist; l++) {

/* 	Call xname to obtain the name associated with the atom. */
		atom = xga_list[l].atom;
		trace("checking atom %d (%s)", atom, atomname(atom));
		ret_str = XCALL;

		if (ret_str == NULL) {
			FAIL;
			report("%s returned a null string with atom name %s",
				TestName, xga_list[l].name);
			continue;
		} else
			CHECK;

/* 	Verify the strings returned were as expected. */
		if (strcmp(xga_list[l].name, ret_str) != 0 ) {
			FAIL;
			report("%s returned an unexpected string");
			report("Expected: '%s'", xga_list[l].name);
			report("Returned: '%s'", ret_str);
		} else
			CHECK;
		XFree(ret_str);
	}

	CHECKPASS(2*xga_nlist);
>>ASSERTION Bad A
.ER BadAtom
