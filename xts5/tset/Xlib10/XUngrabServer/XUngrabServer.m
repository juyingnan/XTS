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
$Header: /cvs/xtest/xtest/xts5/tset/Xlib10/XUngrabServer/XUngrabServer.m,v 1.3 2006-02-20 18:28:14 jamey Exp $

Copyright (c) Applied Testing and Technology, Inc. 1995
All Rights Reserved.

>># Project: VSW5
>># 
>># File: xts5/tset/Xlib10/XUngrabServer/XUngrabServer.m
>># 
>># Description:
>># 	Tests for XUngrabServer()
>># 
>># Modifications:
>># $Log: ungrbsrvr.m,v $
>># Revision 1.3  2006-02-20 18:28:14  jamey
>># Displays must not be shared across a fork(2), but opendisplay causes XCloseDisplay to be called in the parent at test end.
>># Just use XOpenDisplay for the connection used in the child.
>>#
>># Revision 1.2  2005/11/03 08:42:19  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:16  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:31:05  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:50:31  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:22:47  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:19:20  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.1  1996/05/09 00:32:09  andy
>># Corrected Xatom include
>>#
>># Revision 4.0  1995/12/15  09:00:53  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  00:57:05  andy
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
>>TITLE XUngrabServer Xlib10
void

Display	*display = Dsp;
>>ASSERTION Good A
A call to xname
resumes processing of requests and close downs on other connections.
>>EXTERN

#include	"X11/Xatom.h"

>>STRATEGY
Create second connection client2.
Call XGrabServer on default display.
Create another process.
  In created process:
  Perform a XChangeProperty request for client2.
Wait sufficient time to allow client2 request to be processed.
Check that no PropertyChange event has been produced.
Call xname to Ungrab server.
Wait sufficient time to allow client2 request to be processed.
Verify that event has now been received.
>>EXTERN

static Display	*client2;

static Window	win;

static int 	waittime;

>>CODE
int 	ret;

	client2 = XOpenDisplay(config.display);

	win = defwin(Dsp);
	XSelectInput(display, win, PropertyChangeMask);
	XSelectInput(client2, win, PropertyChangeMask);

	waittime = 2*config.speedfactor + 5;

	if (isdeleted())
		return;

	XGrabServer(display);
	XSync(display, False);
	XFlush(client2);

	ret = tet_fork(cproc, pproc, waittime, 1);
	/* Test now continues in pproc */

	if (ret == TIMEOUT_EXIT) {
		delete("Child process timed out");
	}
>>EXTERN
static void
pproc()
{
XEvent	ev;
int 	pass = 0, fail = 0;

	/* Allow time for change prop to occur */
	sleep(waittime);

	if (XCheckWindowEvent(display, win, PropertyChangeMask, &ev)) {
		delete("A request was processed for other than the grabbing client");
		FAIL;
	} else
		CHECK;

	/*
	 * Release the grab and wait a bit to allow the requests on the other
	 * connection to go ahead.
	 */
	XCALL;

	/* Allow time for change prop to occur */
	sleep(waittime);
	if (XCheckWindowEvent(display, win, PropertyChangeMask, &ev))
		CHECK;
	else {
		report("Requests were not processed after server grab was released.");
		FAIL;
	}

	CHECKPASS(2);
}
>>EXTERN
/*
 * Perform operation on client2 while display has the server grabbed.
 */
static void
cproc()
{
long 	val;
Atom	name;

	val = 5;

	settimeout(waittime*3);

	name = XInternAtom(client2, "name", False);
	XChangeProperty(client2, win, name, XA_INTEGER, 32, PropModeReplace,
		(unsigned char *)&val, 1);
	XFlush(client2);

	cleartimeout();

	exit(0);
}
