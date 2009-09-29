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
>># File: xts5/Xlib17/XRotateBuffers.m
>># 
>># Description:
>># 	Tests for XRotateBuffers()
>># 
>># Modifications:
>># $Log: rttbffrs.m,v $
>># Revision 1.2  2005-11-03 08:43:11  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:23  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:34:52  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:57:16  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:26:09  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:22:41  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.1  1996/05/09 00:30:34  andy
>># Corrected Xatom include
>>#
>># Revision 4.0  1995/12/15  09:11:42  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:14:26  andy
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
>>TITLE XRotateBuffers Xlib17

XRotateBuffers(display, rotate);
Display	*display = Dsp;
int	rotate;
>>EXTERN
#include	"X11/Xatom.h"
>>ASSERTION Good A
A call to xname rotates the cut buffers by
.A rotate
modulo 8.
>>STRATEGY
For cut buffers 0..7:
   Set the buffer to contain distinct data.
Rotate the buffers by -51 using xname.
For i in 0..7:
   Verify the data previously in buffer i is now in buffer (i+rotate) modulo 8.
>>CODE
char	*bp;
char	*rbp;
int	nr;
int	len;
int 	i;
int 	j;
struct	bstrct {
	char	*data;
	int	len;
}	bfrs[8], *bptr;

	for(i=0, bptr=bfrs; i<8; i++, bptr++) {

		len = 1+i*123;
		bptr->len = len;

		if((bptr->data = (char *)malloc(len)) == (char *) NULL) {
			delete("malloc() returned NULL.");
			return;
		} else
			CHECK;

		for(j=len, bp=bptr->data; j>0; *bp++ = (j) %  (256 - i), j--);

		XStoreBuffer(display, bptr->data, len, i);
	}


	rotate = -51;
	XCALL;

	for(i=0, bptr=bfrs; i<8; i++, bptr++) {
		
		rbp = XFetchBuffer(display, &nr, (8 + i + (rotate % 8)) % 8);

		if(rbp == (char *) NULL) {
			delete("Buffer %d was not set.", i);
			return;
		} else {
			CHECK;

			if(bptr->len != nr) {
				report("%s() did set buffer %d to contain %d bytes instead of %d.", TestName, i, nr, bptr->len);
				FAIL;
			} else {
				CHECK;

				if(memcmp(rbp, bptr->data, nr) != 0) {
					report("%s() set buffer %d to contain the wrong data.", TestName, i);
					FAIL;
				} else
					CHECK;
			}

			free(bptr->data);
			XFree(rbp);
		}
	}

	CHECKPASS(8 + 8 * 3);

>>ASSERTION Bad A
When any of the 8 cut buffers have not been created, then a
.S BadMatch
error occurs.
>>STRATEGY
For cut buffers 0..7:
   Set the buffer to contain some data.
Delete the property CUT_BUFFER4 from screen 0 of the display using XDeletePropery.
Rotate the buffers by 1 using xname.
Verify that a BadMatch error occurred.
>>CODE BadMatch
char	*tstr = "XTest Multi buffer string";
int	len = 1 + strlen(tstr);
int 	i;

	for(i=0; i < 8; i++)
		XStoreBuffer(display, tstr, len, i);

	XDeleteProperty(display, RootWindow(display, 0), XA_CUT_BUFFER4);
	rotate = 1;
	XCALL;
	if(geterr() == BadMatch)
		PASS;
