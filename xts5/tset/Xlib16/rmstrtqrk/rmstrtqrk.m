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
$Header: /cvs/xtest/xtest/xts5/tset/Xlib16/rmstrtqrk/rmstrtqrk.m,v 1.2 2005-11-03 08:43:00 jmichael Exp $

Copyright (c) Applied Testing and Technology, Inc. 1995
All Rights Reserved.

>># Project: VSW5
>># 
>># File: xts5/tset/Xlib16/rmstrtqrk/rmstrtqrk.m
>># 
>># Description:
>># 	Tests for XrmStringToQuark()
>># 
>># Modifications:
>># $Log: rmstrtqrk.m,v $
>># Revision 1.2  2005-11-03 08:43:00  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:23  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:34:22  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:56:42  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:25:42  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:22:14  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.1  1996/07/16 23:50:00  srini
>># Enhancements and clean-up
>>#
>># Revision 4.0  1995/12/15  09:10:23  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:12:46  andy
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
>>TITLE XrmStringToQuark Xlib16
XrmQuark

char *string;
>>SET startup rmstartup
>>ASSERTION Good A
A call to xname returns a quark allocated to represent
.A string .
>>STRATEGY
Call xname to allocate a quark for a string.
Call XrmQuarkToString to obtain representation for the quark.
Verify the quark represents the string.
>>CODE
char *s = "stq_one";
XrmQuark ret;
char *rep;

/* Call xname to allocate a quark for a string. */
	tet_infoline("PREP: Allocate a quark for a string");
	string = s;
	ret = XCALL;

/* Call XrmQuarkToString to obtain representation for the quark. */
	rep = XrmQuarkToString(ret);

#ifdef TESTING
	rep = "barfed";
#endif

/* Verify the quark represents the string. */
	tet_infoline("TEST: Quark represents the string");
	if((rep==(char *)NULL) || strcmp(s,rep)) {
		FAIL;
		report("%s did not allocate a quark representing the string",
			TestName);
		report("Returned quark was: %d", (int)ret);
		report("Expected representation: %s", s);
		report("Returned representation: %s",
			(rep==(char *)NULL?"NULL pointer":rep));
	} else
		CHECK;

	CHECKPASS(1);

>>ASSERTION Good A
When a quark already exists for
.A string ,
then a call to xname returns that quark.
>>STRATEGY
Call xname to allocate a quark for a string.
Call xname to allocate a quark for the string again.
Verify that the quarks were the same.
>>CODE
char *s = "stq_two";
XrmQuark ret1, ret2;

/* Call xname to allocate a quark for a string. */
	string = s;

	tet_infoline("PREP: Allocate a quark for a string");
	ret1 = XCALL;

/* Call xname to allocate a quark for the string again. */
	tet_infoline("PREP: Allocate another quark for the same string");
	ret2 = XCALL;

/* Verify that the quarks were the same. */
	tet_infoline("TEST: Verify that the quarks were the same.");
	if (ret1 != ret2) {
		FAIL;
		report("%s did not return the same quark to represent",
			TestName);
		report("the same string.");
		report("1st quark return: %d", (int) ret1);
		report("2nd quark return: %d", (int) ret2);
	} else
		CHECK;

	CHECKPASS(1);
>>ASSERTION Good B 2
The result of a call to xname when 
.A string
is in an encoding other than the Host Portable Character set.
