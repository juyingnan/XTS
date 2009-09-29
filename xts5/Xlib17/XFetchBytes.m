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
>># File: xts5/Xlib17/XFetchBytes.m
>># 
>># Description:
>># 	Tests for XFetchBytes()
>># 
>># Modifications:
>># $Log: ftchbyts.m,v $
>># Revision 1.2  2005-11-03 08:43:04  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:23  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:34:36  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:56:57  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:25:54  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:22:26  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.1  1996/05/09 00:30:25  andy
>># Corrected Xatom include
>>#
>># Revision 4.0  1995/12/15  09:10:58  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:13:33  andy
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
>>TITLE XFetchBytes Xlib17
char *
XFetchBytes(display, nbytes_return)
Display	*display = Dsp;
int	*nbytes_return;
>>EXTERN
#include	"X11/Xatom.h"
char		buff[17];
>>ASSERTION Good A
When cut buffer zero contains data, then a call to xname returns in the
.A nbytes_return
argument the number of bytes stored in the buffer and returns a pointer
to storage allocated for the data, which can be freed with
.S XFree .
>>STRATEGY
Store some data in cut buffer zero using XStoreBuffer.
Obtain the data in cut buffer zero using xname.
Verify that the data is correct.
Free the returned data using XFree.
>>CODE
char	*bp;
char	*bpr = (char *) NULL;
int	i;
int	br;

	for(i=NELEM(buff), bp = buff; i>0; *bp++ = (char) (i & 255), i--);

	XStoreBuffer(display, buff, NELEM(buff), 0);

	nbytes_return = &br;
	bp = XCALL;

	if(bp == (char *) NULL) {
		report("%s() did return the contents of cut buffer 0.", TestName);
		FAIL;
	} else {
		CHECK;

		if(br != NELEM(buff)) {
			report("%s() returned %d bytes from cut buffer 0 instead of %d.", TestName, br, NELEM(buff));
			FAIL;
		} else {
			CHECK;

			if(memcmp(bp, buff, NELEM(buff)) != 0) {
				report("%s() did not return the contents of cut buffer 0 correctly.", TestName);
				FAIL;
			} else
				CHECK;
		}

		XFree(bp);
	}

	CHECKPASS(3);

>>ASSERTION Good A
When cut buffer zero does not contain any data, then a call to xname
sets the
.A nbytes_return
argument to zero, and returns NULL.
>>STRATEGY
Set cut buffer to contain data using XStoreBytes.
Delete the property CUT_BUFFER0 from screen 0 of the display using XDeletePropery.
Obtain the contents of cut buffer 0 using xname.
Verify that the call returned NULL.
Verify that the nbytes_return argument was set to zero.
>>CODE
char	*tstr = "XTest cut buffer 0 string";
char	*bp;
int	br;

	XStoreBytes(display, tstr, 1 + strlen(tstr));
	XDeleteProperty(display, RootWindow(display, 0), XA_CUT_BUFFER0);
	nbytes_return = &br;
	bp = XCALL;

	if(bp != (char *) NULL) {
		report("%s() did not return NULL.", TestName);
		FAIL;
	} else 
		CHECK;

	if(br != 0) {
		report("%s() returned %d bytes from cut buffer 0 instead of 0.", TestName, br);
		FAIL;
	} else
		CHECK;

	CHECKPASS(2);
