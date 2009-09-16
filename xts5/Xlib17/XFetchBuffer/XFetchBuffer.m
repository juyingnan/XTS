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
>># File: xts5/Xlib17/XFetchBuffer/XFetchBuffer.m
>># 
>># Description:
>># 	Tests for XFetchBuffer()
>># 
>># Modifications:
>># $Log: ftchbffr.m,v $
>># Revision 1.2  2005-11-03 08:43:04  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:23  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:34:35  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:56:56  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:25:53  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:22:26  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.1  1996/05/09 00:30:24  andy
>># Corrected Xatom include
>>#
>># Revision 4.0  1995/12/15  09:10:57  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:13:31  andy
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
>>#
>># COMMENT : 	Spec mentions the possibility of a BadValue error.
>># 		I can't see how this could be generated without
>>#		changing Xlib. The spec also fails to mention that
>>#		the call returns NULL if there is no data in the 
>>#		specified cut buffer. I have added this to the
>>#		assertion.
>>#
>># Cal 12/07/91
>>#
>>TITLE XFetchBuffer Xlib17
char *
XFetchBuffer(display, nbytes_return, buffer)
Display	*display = Dsp;
int	*nbytes_return;
int	buffer;
>>EXTERN
#include	"X11/Xatom.h"
>>ASSERTION Good A
When the cut buffer specified by the
.A buffer
argument contains data, then a call to xname returns in the
.A nbytes_return
argument the number of bytes stored in the buffer and returns a pointer
to storage allocated for the data, which can be freed with
.S XFree .
>>STRATEGY
For each cut buffer 0..7:
   Set the buffer to contain data using XStoreBuffer.
For each cut buffer 0..7:
   Obtain the contents of the buffer using xname.
   Verify that the data is correct.
   Free the returned data using XFree.
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

		if((bptr->data = (char*)malloc(len)) == (char *) NULL) {
			delete("malloc() returned NULL.");
			return;
		} else
			CHECK;

		for(j=len, bp=bptr->data; j>0; *bp++ = (j) %  (256 - i), j--)
			;

		XStoreBuffer(display, bptr->data, len, i);
	}

	for(i=0, bptr=bfrs; i<8; i++, bptr++) {
		
		buffer = i;
		nbytes_return = &nr;
		rbp = XCALL;

		if(rbp == (char *) NULL) {
			report("%s() did not set buffer %d to contain any data.", TestName, i);
			FAIL;
		} else {
			CHECK;

			if(bptr->len != nr) {
				report("%s() set buffer %d to contain %d bytes instead of %d.", TestName, i, nr, bptr->len);
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


	CHECKPASS(8 + 8 * (3));

>>ASSERTION Good A
When the cut buffer specified by the
.A buffer
argument does not contain any data, then a call to xname sets the
.A nbytes_return
argument to zero, and returns NULL.
>>STRATEGY
For each cut buffer 0..7:
   Set the buffer to contain data using XStoreBuffer.
For i in 0..7:
  Delete the property CUT_BUFFERi from screen 0 of the display using XDeletePropery.
For each cut buffer 0..7:
   Obtain the contents of the buffer using xname.
   Verify that the call returned NULL.
   Verify that the nbytes_return argument was set to zero.
>>CODE
char	*rbp;
char	*tstr = "XTest Multi buffer string";
int	len = 1 + strlen(tstr);
int	nr;
int 	i;

	for(i=0; i < 8; i++)
		XStoreBuffer(display, tstr, len, i);

	XDeleteProperty(display, RootWindow(display, 0), XA_CUT_BUFFER0);
	XDeleteProperty(display, RootWindow(display, 0), XA_CUT_BUFFER1);
	XDeleteProperty(display, RootWindow(display, 0), XA_CUT_BUFFER2);
	XDeleteProperty(display, RootWindow(display, 0), XA_CUT_BUFFER3);
	XDeleteProperty(display, RootWindow(display, 0), XA_CUT_BUFFER4);
	XDeleteProperty(display, RootWindow(display, 0), XA_CUT_BUFFER5);
	XDeleteProperty(display, RootWindow(display, 0), XA_CUT_BUFFER6);
	XDeleteProperty(display, RootWindow(display, 0), XA_CUT_BUFFER7);

	for(i=0; i < 8; i++) {
		
		buffer = i;
		nbytes_return = &nr;
		rbp = XCALL;

		if(rbp != (char *) NULL) {
			report("%s() did not return NULL for buffer %d.", TestName, i);
			FAIL;
		} else
			CHECK;

		if(nr != 0) {
			report("%s() set nbytes_return to %d instead of 0 for buffer %d.", TestName, nr, i);
			FAIL;
		} else
			CHECK;

	}

	CHECKPASS(8 * 2);
