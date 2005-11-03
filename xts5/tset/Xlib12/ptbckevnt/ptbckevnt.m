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
$Header: /cvs/xtest/xtest/xts5/tset/Xlib12/ptbckevnt/ptbckevnt.m,v 1.2 2005-11-03 08:42:36 jmichael Exp $

Copyright (c) Applied Testing and Technology, Inc. 1995
All Rights Reserved.

>># Project: VSW5
>># 
>># File: xts5/tset/Xlib12/ptbckevnt/ptbckevnt.m
>># 
>># Description:
>># 	Tests for XPutBackEvent()
>># 
>># Modifications:
>># $Log: ptbckevnt.m,v $
>># Revision 1.2  2005-11-03 08:42:36  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:18  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:33:25  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:54:53  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:24:50  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:21:22  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:07:42  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:08:15  andy
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
>>TITLE XPutBackEvent Xlib12
void
XPutBackEvent(display, event)
Display *display = Dsp;
XEvent	*event = &_event;
>>EXTERN
/*
 * Can not use "xcall" because it empties the event queue.
 */
#define	_xcall_()	\
		_startcall(display);\
		XPutBackEvent(display, event);\
		_endcall(display)
static XEvent _event;
>>ASSERTION Good A
A call to xname pushes a copy of
.A event
onto the head of the display's event queue.
>>STRATEGY
Call XSync to empty event queue.
Call XPutBackEvent to push event onto the head of the event queue.
Call XPeekEvent to verify that first event is the event that was pushed.
Call XPutBackEvent to push another event onto the head of the event queue.
Call XPeekEvent to verify that first event is the event that was pushed.
>>CODE
XEvent	event_return;

/* Call XSync to empty event queue. */
	XSync(display, True);
/* Call XPutBackEvent to push event onto the head of the event queue. */
	event->type = ButtonPress;
	_xcall_();
/* Call XPeekEvent to verify that first event is the event that was pushed. */
	XPeekEvent(display, &event_return);
	if (event_return.type != event->type) {
		report("Returned %s, expected %s", eventname(event_return.type), eventname(event->type));
		FAIL;
	}
	else
		CHECK;
/* Call XPutBackEvent to push another event onto the head of the event queue. */
	event->type = KeyPress;
	_xcall_();
/* Call XPeekEvent to verify that first event is the event that was pushed. */
	XPeekEvent(display, &event_return);
	if (event_return.type != event->type) {
		report("Returned %s, expected %s", eventname(event_return.type), eventname(event->type));
		FAIL;
	}
	else
		CHECK;
	XSync(display, True);
	
	CHECKPASS(2);
>>ASSERTION Good B 5
A call to xname
can be made an unlimited number of times in succession.
>>STRATEGY
Call XPutBackEvent 1000 times.
>>CODE
int	i;

/* Call XPutBackEvent 1000 times. */
	event->type = ButtonPress;
	for (i=0; i<1000; i++) {
		_xcall_();
	}
	UNTESTED;
