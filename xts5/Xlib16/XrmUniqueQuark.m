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
>># File: xts5/Xlib16/XrmUniqueQuark.m
>># 
>># Description:
>># 	Tests for XrmUniqueQuark()
>># 
>># Modifications:
>># $Log: rmunqqrk.m,v $
>># Revision 1.2  2005-11-03 08:43:01  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:23  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:34:23  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:56:43  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:25:43  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:22:15  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.1  1996/07/15 21:17:22  srini
>># Enhancements and clean-up
>>#
>># Revision 4.0  1995/12/15  09:10:26  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:12:49  andy
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
>>TITLE XrmUniqueQuark Xlib16
XrmQuark

>>SET startup rmstartup
>>EXTERN
#define NITER	100
>>ASSERTION Good A
A call to xname returns a quark that does not represent any string
known to the resource manager.
>>STRATEGY
Call xname to obtain a unique quark.
Verify the quark does not represent a string in the resource manager.
Call xname to obtain another quark.
Verify this is a distinct quark.
>>CODE
XrmQuark ret1, rets[NITER];
char *str;
int	i, j;

	tet_infoline("PREP: Call XrmUniqueQuark to obtain a unique quark");
	/* Call xname to obtain a unique quark. */
	ret1 = XCALL;

	tet_infoline("TEST: Quark does not represent a string in the resource manager");
	/* Verify the quark does not represent a string in the resource manager. */
	str = XrmQuarkToString( ret1 );
	if (str != (char *)NULL) {
		FAIL;
		report("%s did not return a quark not representing a string.",
			TestName);
		report("XrmQuarkToString Expected: NULL pointer");
		report("XrmQuarkToString Returned: '%s'", str);
	} else
		CHECK;

	/* Call xname to obtain another quark. */
	tet_infoline("TEST: Unique quarks are allocated by XrmUniqueQuark");
	for (i = 0; i < NITER; i++)
	{
		rets[i] = XCALL;

		/* Verify this is a distinct quark. */
		for (j = 0; j < (i - 1); j++)
		{
			if (rets[i] == rets[j])
			{
				FAIL;
				report("%s returned indistinct quarks.",
					TestName);
				report("1st quark: %d", (int)rets[i]);
				report("2nd quark: %d", (int)rets[j]);
			}
		}
	}

	CHECKPASS(1);
