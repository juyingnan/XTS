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
>># File: xts5/Xlib12/XPending.m
>># 
>># Description:
>># 	Tests for XPending()
>># 
>># Modifications:
>># $Log: pndng.m,v $
>># Revision 1.2  2005-11-03 08:42:36  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:18  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:33:25  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:54:52  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:24:50  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:21:22  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:07:41  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:08:13  andy
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
>>TITLE XPending Xlib12
int
XPending(display)
Display *display = Dsp;
>>EXTERN

/*
 * Can not use "xcall" because it empties the event queue.
 */
#define	_xcall_(return_value)	\
		_startcall(display);\
		return_value = XPending(display);\
		_endcall(display)
>>ASSERTION Good A
>>#NOTE	These assertions are similar to those in
>>#NOTE XEventsQueued for the QueuedAfterFlush tests.
When the number of events already in the event queue is non-zero,
then a call to xname
returns the number of events in the event queue.
>>STRATEGY
Discard all events on the event queue.
Call XPutBackEvent to put events on the event queue.
Call XPending.
Verify that XPending returned the correct number of events.
>>CODE
int	eventsput;
int	event_count;
XEvent	event;

/* Discard all events on the event queue. */
	XSync(display, True);
/* Call XPutBackEvent to put events on the event queue. */
	event.type = MapNotify;
	eventsput = 0;
	XPutBackEvent(display, &event), eventsput++;
	XPutBackEvent(display, &event), eventsput++;
	XPutBackEvent(display, &event), eventsput++;
/* Call XPending. */
	_xcall_(event_count);
/* Verify that XPending returned the correct number of events. */
	if (event_count != eventsput) {
		report("Returned %d, expected %d", event_count, eventsput);
		FAIL;
	}
	else
		CHECK;
	/* empty event queue */
	XSync(display, True);

	CHECKPASS(1);
>>ASSERTION Good A
When there are no events in the event queue,
then a call to xname
flushes the output buffer.
>>STRATEGY
Create client2.
Discard all events on the event queue.
Create pixmap.
Call XPending.
Empty the buffer.
Ensure the server has dealt with anything flushed to it: do XSync()
Verify that the output buffer was flushed by effect on server.
Verify that XPending returned the correct number of events.
>>CODE
int	event_count;
Pixmap	pm;
Display *client2;

/* Create client2. */
	client2 = opendisplay();
	if (client2 == (Display *) NULL) {
		delete("Can not open display");
		return;
	}
	else
		CHECK;
/* Discard all events on the event queue. */
	XSync(display, True);
/* Create pixmap. */
	/* avoid using makepixm() */
	pm = XCreatePixmap(display, DRW(display), 10, 10, 1);
/* Call XPending. */
	_xcall_(event_count);
/* Empty the buffer. */
	(void)XTestDiscard(display);
/* Ensure the server has dealt with anything flushed to it: do XSync() */
	XSync(display, False);
/* Verify that the output buffer was flushed by effect on server. */
	_startcall(client2);
	XFreePixmap(client2, pm);
	XSync(client2, True);
	_endcall(client2);
	if (geterr() != Success) {
		report("The output buffer was not flushed.");
		XFreePixmap(display, pm);
		FAIL;
	}
	else
		CHECK;
/* Verify that XPending returned the correct number of events. */
	if (event_count != 0) {
		report("Returned %d, expected none", event_count);
		FAIL;
	}
	else
		CHECK;

	CHECKPASS(3);
>>ASSERTION Good A
When there are no events in the event queue,
then a call to xname
attempts to read more events out of the client's connection
without blocking
and returns the number read.
>>STRATEGY
Discard all events on the event queue.
Call XPending and verify that blocking did not occur.
Discard all events on the event queue.
>>CODE
Block_Info info;
int	block_status;

/* Discard all events on the event queue. */
	XSync(display, True);
/* Call XPending and verify that blocking did not occur. */
	XPending_Type(info);
	block_status = block(display, (XEvent *) NULL, &info);
	if (block_status == -1)
		return;
	else
		CHECK;
	if (block_status == 1) {
		report("Blocking occurred with QueuedAfterFlush when it should not have.");
		FAIL;
	}
	else
		CHECK;
	if (info.int_return != 0) {
		delete("Unexpected number of events in event queue: %d", info.int_return);
		return;
	}
	else
		CHECK;
/* Discard all events on the event queue. */
	XSync(display, True);
	CHECKPASS(3);
