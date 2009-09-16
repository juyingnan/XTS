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
>># File: xts5/tset/Xlib16/XResourceManagerString/XResourceManagerString.m
>># 
>># Description:
>># 	Tests for XResourceManagerString()
>># 
>># Modifications:
>># $Log: rsrcmngrst.m,v $
>># Revision 1.2  2005-11-03 08:43:02  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:23  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:34:24  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:56:44  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:25:43  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:22:16  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.2  1996/08/07 22:49:38  srini
>># Enhancements and clean-up
>>#
>># Revision 4.1  1996/05/09  00:30:52  andy
>># Corrected Xatom include
>>#
>># Revision 4.0  1995/12/15  09:10:27  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:12:51  andy
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
>>TITLE XResourceManagerString Xlib16
char *
XResourceManagerString(display)
Display	*display = Dsp;
>>EXTERN
#include	"X11/Xatom.h"
>>ASSERTION Good A
A call to xname returns the value of the RESOURCE_MANAGER
property on the root window of screen zero at the time
.A display
was opened.
>>STRATEGY
>>CODE
char	*pval1 = "XTest.test.resource:value";
char	*pval2 = "XTest.changed.resource:value";
char	*res;

	tet_infoline("PREP: Set the value of the RESOURCE_MANAGER property to \"XTest.test.resource:value\" using XChangeProperty.");
	XChangeProperty (Dsp, RootWindow(Dsp, 0), XA_RESOURCE_MANAGER, XA_STRING, 8, PropModeReplace, (unsigned char *)pval1, 1+strlen(pval1));
	XSync(Dsp, False);
	tet_infoline("PREP: Open display using XOpenDisplay.");
	display = opendisplay();
	tet_infoline("PREP: Set the value of the RESOURCE_MANAGER property to \"XTest.changed.resource:value\" using XChangeProperty.");
	XChangeProperty (display, RootWindow(display, 0), XA_RESOURCE_MANAGER, XA_STRING, 8, PropModeReplace, (unsigned char *)pval2, 1+strlen(pval2));

	tet_infoline("PREP: Obtain the value of the RESOURCE_MANAGER property at the time display was opened using xname.");
	res = XCALL;

	if( res == (char *) NULL) {
		report("%s() returned NULL.", TestName);
		FAIL;
	} else {
		CHECK;
		tet_infoline("TEST: Verify that the call returned \"XTest.test.resource:value\".");
		if(strcmp(res, pval1) != 0) {
			report("%s() returned \"%s\" instead of \"%s\".", TestName, res, pval1);
			FAIL;
		} else
			CHECK;
	}

	CHECKPASS(2);
>>ASSERTION Good A
A call to xname when the RESOURCE_MANAGER
property on the root window of screen zero does not exist
shall return NULL.
>>STRATEGY
>>CODE
char	*res;

	tet_infoline("PREP: Delete the RESOURCE_MANAGER property for the root window");
	XDeleteProperty (Dsp, RootWindow(Dsp, 0), XA_RESOURCE_MANAGER);
	XSync(Dsp, False);
	tet_infoline("PREP: Open display using XOpenDisplay.");
	display = opendisplay();

	tet_infoline("TEST: Call to XResourceManagerString returns NULL.");
	res = XCALL;

	if( res != (char *) NULL) {
		report("%s() returned \"%s\" instead of NULL.", TestName, res);
		FAIL;
	}

	tet_result(TET_PASS);
