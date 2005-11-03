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
$Header: /cvs/xtest/xtest/xts5/tset/Xlib16/rmqrktstr/rmqrktstr.m,v 1.2 2005-11-03 08:42:59 jmichael Exp $

Copyright (c) Applied Testing and Technology, Inc. 1995
All Rights Reserved.

>># Project: VSW5
>># 
>># File: xts5/tset/Xlib16/rmqrktstr/rmqrktstr.m
>># 
>># Description:
>># 	Tests for XrmQuarkToString()
>># 
>># Modifications:
>># $Log: rmqrktstr.m,v $
>># Revision 1.2  2005-11-03 08:42:59  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:23  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:34:21  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:56:40  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:25:41  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:22:14  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.1  1996/07/19 18:11:03  srini
>># Enhancements and clean-up
>>#
>># Revision 4.0  1995/12/15  09:10:20  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:12:41  andy
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
>>TITLE XrmQuarkToString Xlib16
char *

XrmQuark quark;
>>EXTERN
#define NITER	100
>>SET startup rmstartup
>>ASSERTION Good A
A call to xname returns a pointer to the string that corresponds to
the
.A quark .
>>STRATEGY
Call XrmStringToQuark to allocate a quark for a string.
Call xname to obtain the representation for the quark.
>>CODE
char *s="qts_one";
char *ret;

/* Call XrmStringToQuark to allocate a quark for a string. */
	quark = XrmStringToQuark( s );

/* Call xname to obtain the representation for the quark. */
	ret = XCALL;

	if (ret==(char *)NULL || strcmp(s,ret)) {
		FAIL;
		report("%s did not return the representation for the quark.",
			TestName);
		report("Expected representation: %s", s);
		report("Returned representation: %s",
			(ret==(char *)NULL?"NULL pointer":ret));
	} else
		CHECK;

	CHECKPASS(1);

>>ASSERTION Good A
When no string exists for a
.A quark ,
then a call to xname returns
.S NULL .
>>STRATEGY
Create a unique quark which has no string representation.
Call xname to obtain the representation for the quark.
Verify that a NULL pointer was returned.
>>CODE
char *ret;

/* Create a unique quark which has no string representation. */
	quark = XrmUniqueQuark();

/* Call xname to obtain the representation for the quark. */
	ret = XCALL;

/* Verify that a NULL pointer was returned. */
	if (ret != (char *)NULL) {
		FAIL;
		report("%s returned unexpected value with a quark with",
			TestName);
		report("no string representation.");
		report("Expected value: NULL pointer");
		report("Returned value: '%s'", ret);
	} else
		CHECK;

	CHECKPASS(1);
>>ASSERTION Good A
When a call to xname returns a non-NULL value for string future calls to the
function with the same value for 
.A quark
shall return pointer to the same string.
>>STRATEGY
>>CODE
int	i;
char	*ret, *save_addr;

	
	/* Create a unique quark which has no string representation. */
	tet_infoline("PREP: Create a unique quark.");
	quark = XrmUniqueQuark();

	/* Call xname to obtain the representation for the quark. */
	tet_infoline("PREP: Save address of the value returned on first call.");
	save_addr = XCALL;

	/* Call xname to obtain another quark. */
	tet_infoline("TEST: Identical pointers are returned by XrmQuarkToString");
	for (i = 0; i < NITER; i++)
	{
		ret = XCALL;

		if (ret != save_addr)
		{
			FAIL;
			report("%s returned non-identical addresses.",
				TestName);
			report("Expected: 0x%x", (int)save_addr);
			report("Got     : 0x%x", (int)ret);
		}
	}
	tet_result(TET_PASS);
