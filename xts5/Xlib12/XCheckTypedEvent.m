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
>># File: xts5/Xlib12/XCheckTypedEvent.m
>># 
>># Description:
>># 	Tests for XCheckTypedEvent()
>># 
>># Modifications:
>># $Log: chcktypdev.m,v $
>># Revision 1.2  2005-11-03 08:42:34  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:18  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:33:16  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:54:36  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:24:42  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:21:14  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:07:19  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:07:35  andy
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
>>TITLE XCheckTypedEvent Xlib12
Bool
XCheckTypedEvent(display, event_type, event_return)
Display *display = Dsp;
int event_type;
XEvent	*event_return = &_event;
>>EXTERN
#include "XFuzz.h"
/*
 * Can not use "xcall" because it empties the event queue.
 */
#define	_xcall_(rvalue)	\
		_startcall(display);\
		rvalue = XCheckTypedEvent(display, event_type, event_return);\
		_endcall(display)
static XEvent _event;
>>ASSERTION Good A
>>#NOTE	Similar assertions to chckmskevn.
A call to xname
returns in
.A event_return
the first event in the event queue that matches
.A event_type .
>>STRATEGY
Discard all events on the event queue.
Call XPutBackEvent to put events on the event queue.
Call XCheckTypedEvent.
Verify that XCheckTypedEvent returned True.
Verify the correct event-type was returned.
Verify the first matching event in event queue was returned.
>>CODE
XEvent	event;
XAnyEvent *ep;
Bool	return_value;

/* Discard all events on the event queue. */
	XSync(display, True);
/* Call XPutBackEvent to put events on the event queue. */
	ep = (XAnyEvent *) &event;
	ep->type = KeyPress;
	ep->send_event = False;
	XPutBackEvent(display, &event);
	ep->type = ButtonPress;
	ep->send_event = False;
	XPutBackEvent(display, &event);
	ep->type = ButtonPress;
	ep->send_event = True;	/* first occurrence has send_event True */
	XPutBackEvent(display, &event);
	ep->type = KeyPress;
	ep->send_event = False;
	XPutBackEvent(display, &event);
/* Call XCheckTypedEvent. */
	event_type = ButtonPress;
	_xcall_(return_value);
/* Verify that XCheckTypedEvent returned True. */
	if (return_value != True) {	
		report("Did not return True: returned %d", return_value);
		FAIL;
	}
	else
		CHECK;
/* Verify the correct event-type was returned. */
	ep = (XAnyEvent *) event_return;
	if (ep->type != ButtonPress) {
		report("Got %s, expected %s", eventname(ep->type), eventname(ButtonPress));
		FAIL;
	}
	else
		CHECK;
/* Verify the first matching event in event queue was returned. */
	if (ep->send_event != True) {
		report("First event in event queue was not returned.");
		FAIL;
	}
	else
		CHECK;
	CHECKPASS(3);
>>ASSERTION def
When a call to xname finds a matching event,
then
xname
returns
.S True .
>>ASSERTION Good A
A call to xname removes the returned event from the event queue.
>>STRATEGY
Discard all events on the event queue.
Call XPutBackEvent to put events on the event queue.
Call XPending to get the current event queue size.
Call XCheckTypedEvent.
Call XPending to get the current event queue size.
Verify that size of event queue has decreased by one.
>>CODE
XEvent	event;
int	oldqsize;
int	newqsize;
Bool	return_value;

/* Discard all events on the event queue. */
	XSync(display, True);
/* Call XPutBackEvent to put events on the event queue. */
	event.type = ButtonPress;
	XPutBackEvent(display, &event);
/* Call XPending to get the current event queue size. */
	oldqsize = XPending(display);
/* Call XCheckTypedEvent. */
	event_type = ButtonPress;
	_xcall_(return_value);
/* Call XPending to get the current event queue size. */
	newqsize = XPending(display);
/* Verify that size of event queue has decreased by one. */
	if (newqsize != (oldqsize-1)) {
		report("Event queue size %d, expected %d", newqsize, oldqsize-1);
		FAIL;
	}
	else
		CHECK;
	CHECKPASS(1);
>>ASSERTION def
When the event queue does not contain a matching event,
then a call to xname
returns in
.A event_return
the first matching event available on the X server connection.
>>ASSERTION Good A
When a matching event is not in the event queue and
is not available on the X server connection,
then a call to xname
returns
.S False .
>>STRATEGY
Discard all events on the event queue.
Call XCheckTypedEvent.
Verify that XCheckTypedEvent returned False.
>>CODE
Bool	return_value;

/* Discard all events on the event queue. */
	XSync(display, True);
/* Call XCheckTypedEvent. */
	event_type = ButtonPress;
	_xcall_(return_value);
/* Verify that XCheckTypedEvent returned False. */
	if (return_value != False) {	
		report("Did not return False: returned %d", return_value);
		FAIL;
	}
	else
		CHECK;
	CHECKPASS(1);
>>ASSERTION Good A
When a matching event is not in the event queue and
is not available on the X server connection,
then a call to xname
flushes the output buffer.
>>STRATEGY
Create client2.
Discard all events on the event queue.
Create pixmap.
Call XCheckTypedEvent.
Verify that XCheckTypedEvent returned False.
Empty the buffer.
Ensure the server has dealt with anything flushed to it: do XSync()
Verify that the output buffer was flushed by effect on server.
>>CODE
Bool	return_value;
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
/* Call XCheckTypedEvent. */
	event_type = ButtonPress;
	_xcall_(return_value);
/* Verify that XCheckTypedEvent returned False. */
	if (return_value != False) {	
		report("Did not return False: returned %d", return_value);
		FAIL;
	}
	else
		CHECK;
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
	CHECKPASS(3);
>>ASSERTION Good A
>>#NOTE	Similar assertions to chckmskevn.
A call to xname
returns in
.A event_return
the first event in the event queue that matches
.A event_type .
>>STRATEGY
Discard all events on the event queue.
Call XPutBackEvent to put events on the event queue.
Call XCheckTypedEvent.
Verify that XCheckTypedEvent returned True.
Verify the correct event-type was returned.
Verify the first matching event in event queue was returned.
>>CODE
XEvent	event;
XAnyEvent *ep;
Bool	return_value;

/* Discard all events on the event queue. */
	XSync(display, True);
/* Call XPutBackEvent to put events on the event queue. */
	ep = (XAnyEvent *) &event;
	int i;
	for(i = 0; i < FUZZ_MAX; i++){
		ep->type = rand() % 32;
		ep->send_event = False;
		XPutBackEvent(display, &event);
	}
	int type = rand() % 32;
	ep->type = type;
	ep->send_event = True;	/* first occurrence has send_event True */
	XPutBackEvent(display, &event);
	ep->type = KeyPress;
	ep->send_event = False;
	XPutBackEvent(display, &event);
/* Call XCheckTypedEvent. */
	event_type = type;
	_xcall_(return_value);
/* Verify that XCheckTypedEvent returned True. */
	if (return_value != True) {	
		report("Did not return True: returned %d", return_value);
		FAIL;
	}
	else
		CHECK;
/* Verify the correct event-type was returned. */
	ep = (XAnyEvent *) event_return;
	if (ep->type != type) {
		report("Got %s, expected %s", eventname(ep->type), eventname(type));
		FAIL;
	}
	else
		CHECK;
/* Verify the first matching event in event queue was returned. */
	if (ep->send_event != True) {
		report("First event in event queue was not returned.");
		FAIL;
	}
	else
		CHECK;
	CHECKPASS(3);
