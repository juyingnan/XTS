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
>># File: xts5/Xlib5/XListProperties.m
>># 
>># Description:
>># 	Tests for XListProperties()
>># 
>># Modifications:
>># $Log: lstprprts.m,v $
>># Revision 1.2  2005-11-03 08:43:39  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:28  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:26:47  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:45:05  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:19:01  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:15:32  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.1  1996/05/09 00:34:22  andy
>># Corrected Xatom include
>>#
>># Revision 4.0  1995/12/15  08:48:43  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  00:47:32  andy
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
>>TITLE XListProperties Xlib5
Atom *

Display *display = Dsp;
Window w = defwin(display);
int *num_prop_return = &num_prop;
>>EXTERN
#include "X11/Xatom.h"

static int num_prop;

static Atom xlp_list[] = {
          XA_PRIMARY,
         XA_CUT_BUFFER0,
         XA_RECTANGLE,
         XA_COPYRIGHT,
};
static int xlp_nlist = NELEM(xlp_list);

>>ASSERTION Good A
When the specified window
.A w
has properties defined, then a call to xname
returns a pointer to an array of atom properties that are defined for 
the specified window
.A w 
and can be freed with XFree,
and returns the number of properties in the
array in
.A num_prop_return .
>>STRATEGY
Create a window with properties.
Call xname to obtain the property list for the window.
Verify that the number of properties returned was as expected.
Verify that the correct properties were returned.
Verify the list may be XFree'd.
>>CODE
int loop,loop2;
int found;
char *data = "a tested property";
Atom *ret;

/* Create a window with properties. */
	for(loop=0; loop<xlp_nlist; loop++)
		XChangeProperty(display, w, xlp_list[loop], XA_STRING, 8,
			PropModeReplace,(unsigned char *)data, strlen(data));

/* Call xname to obtain the property list for the window. */
	num_prop = -1;
	ret = XCALL;

/* Verify that the number of properties returned was as expected. */
	if (num_prop != xlp_nlist) {
		FAIL;
		report("%s returned an unexpected num_prop_return",
			TestName);
		trace("Expected value: %d", xlp_nlist);
		trace("Returned value: %d", num_prop);
	} else
		CHECK;

	if (ret == (Atom *)NULL) {
		FAIL;
		report("%s returned a NULL pointer.", TestName);
		report("Expecting a pointer to a list of atoms.");
		return;
	} else
		CHECK;
		
	
	found = 0;

/* Verify that the correct properties were returned. */
	for (loop=0; loop<num_prop; loop++) {
		for(loop2=0; loop2<xlp_nlist; loop2++) {
			if( ret[loop] == xlp_list[loop2] ) {
				found++;
				break;
			}
		}
	}

#ifdef TESTING
	found = 0;
#endif

	if (found != num_prop) {
		FAIL;
		report("%s returned unexpected properties", TestName);
		trace("Expected properties");
		for (loop=0; loop<xlp_nlist; loop++)
			trace(" %s", atomname(xlp_list[loop]));
		trace("Returned properties");
		for (loop=0; loop<num_prop; loop++)
			trace(" %s", atomname(ret[loop]));
	} else
		CHECK;

/* Verify the list may be XFree'd. */
	if (num_prop != 0)
	{
		XFree((char*)ret);
		CHECK;
	}

	CHECKPASS(4);
>>ASSERTION Good A
When the specified window
.A w
has no properties defined, then a call to xname returns
.S NULL ,
and zero in
.A num_prop_return .
>>STRATEGY
Create a window with no properties.
Call xname to obtain the property list for the window.
Verify that a NULL pointer was returned.
Verify that num_prop_return was zero.
>>CODE
Atom *ret;

/* Create a window with no properties. */
/* Call xname to obtain the property list for the window. */
	num_prop = -1;
	ret = XCALL;

/* Verify that a NULL pointer was returned. */
	if (ret != (Atom *)NULL) {
		FAIL;
		report("%s returned an unexpected value", TestName);
		trace("Expected value: NULL pointer");
		trace("Returned value: non-NULL pointer");
	} else
		CHECK;

/* Verify that num_prop_return was zero. */
	if (num_prop != 0) {
		FAIL;
		report("%s returned an unexpected num_prop_return",
			TestName);
		trace("Expected value: 0");
		trace("Returned value: %d", num_prop);
	} else
		CHECK;

	CHECKPASS(2);
>>ASSERTION Bad A
.ER BadWindow
