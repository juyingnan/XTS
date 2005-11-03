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
$Header: /cvs/xtest/xtest/xts5/tset/Xlib11/fcsot/fcsot.m,v 1.2 2005-11-03 08:42:28 jmichael Exp $

Copyright (c) Applied Testing and Technology, Inc. 1995
All Rights Reserved.

>># Project: VSW5
>># 
>># File: xts5/tset/Xlib11/fcsot/fcsot.m
>># 
>># Description:
>># 	Tests for FocusOut()
>># 
>># Modifications:
>># $Log: fcsot.m,v $
>># Revision 1.2  2005-11-03 08:42:28  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:16  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:31:14  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:50:47  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:22:55  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:19:28  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:01:26  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  00:58:15  andy
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
>>TITLE FocusOut Xlib11
>>SET startup focusstartup
>>SET cleanup focuscleanup
>>EXTERN
#define	EVENT		FocusOut
#define	OTHEREVENT	FocusIn
#define	MASK		FocusChangeMask

static	Display	*_display_;
static	int	_detail_;
static	long	_event_mask_;
static	XEvent	good;

static	int
selectinput(start, stop, current, previous)
Winh	*start, *stop, *current, *previous;
{
#ifdef	lint
	winh_free(start);
	winh_free(stop);
	winh_free(previous);
#endif
	return(winh_selectinput(_display_, current, _event_mask_));
}

static	int
plant(start, stop, current, previous)
Winh	*start, *stop, *current, *previous;
{
#ifdef	lint
	winh_free(start);
	winh_free(stop);
	winh_free(previous);
#endif
	good.xany.window = current->window;
	return(winh_plant(current, &good, NoEventMask, WINH_NOMASK));
}

static	Bool	increasing;	/* event sequence increases as we climb */

static	int
checksequence(start, stop, current, previous)
Winh	*start, *stop, *current, *previous;
{
	Winhe	*d;
	int	current_sequence;
	int	status;
	static	int	last_sequence;

#ifdef	lint
	winh_free(start);
	winh_free(stop);
#endif
	/* look for desired event type */
	for (d = current->delivered; d != (Winhe *) NULL; d = d->next) {
		if (d->event->type == good.type) {
			current_sequence = d->sequence;
			break;
		}
	}
	if (d == (Winhe *) NULL) {
		report("%s event not delivered", eventname(good.type));
		delete("Missing event");
		return(-1);
	}
	if (previous == (Winh *) NULL)
		status = 0;	/* first call, no previous sequence value */
	else {
		/* assume sequence numbers are not the same */
		status = (current_sequence < last_sequence);
		if (increasing)
			status = (status ? 0 : 1);
		if (status)
			report("Ordering problem between 0x%x (%d) and 0x%x (%d)",
				current->window, current_sequence,
				previous->window, last_sequence);
	}
	last_sequence = current_sequence;
	return(status);
}

static	int
checkdetail(start, stop, current, previous)
Winh	*start, *stop, *current, *previous;
{
	Winhe	*d;

#ifdef	lint
	winh_free(start);
	winh_free(stop);
	winh_free(previous);
#endif
	/* look for desired event type */
	for (d = current->delivered; d != (Winhe *) NULL; d = d->next)
		if (d->event->type == good.type)
			break;
	if (d == (Winhe *) NULL) {
		report("%s event not delivered to window 0x%x",
			eventname(good.type), current->window);
		delete("Missing event");
		return(-1);
	}
	/* check detail */
	if (_detail_ != d->event->xfocus.detail) {
		report("Expected detail of %d, got %d on window 0x%x",
			_detail_, d->event->xfocus.detail, current->window);
		return(1);
	}
	return(0);
}
>>ASSERTION Good A
When a xname event is generated by a window unmap,
then the xname event is generated after the corresponding
.S UnmapNotify
event.
>>STRATEGY
Create client.
Create window hierarchy.
Select for xname and UnmapNotify events on window.
Set focus to window.
Generate events by unmapping window.
Verify that a UnmapNotify event was delivered.
Verify that a xname event was delivered.
Verify that the xname event was delivered after the UnmapNotify event.
>>CODE
Display	*display;
Winh	*winh;
int	status;

/* Create client. */
	if ((display = opendisplay()) == (Display *) NULL) {
		delete("Couldn't create client.");
		return;
	}
	else
		CHECK;
/* Create window hierarchy. */
	winh = winh_adopt(display, (Winh *) NULL, 0L, (XSetWindowAttributes *) NULL, (Winhg *) NULL, WINH_NOMASK);
	if (winh == (Winh *) NULL)
		return;
	else
		CHECK;
	if (winh_create(display, (Winh *) NULL, WINH_MAP))
		return;
	else
		CHECK;
/* Select for xname and UnmapNotify events on window. */
	if (winh_selectinput(display, winh, MASK|StructureNotifyMask))
		return;
	else
		CHECK;
	good.type = EVENT;
	good.xany.display = display;
	good.xany.window = winh->window;
	if (winh_plant(winh, &good, MASK, WINH_NOMASK)) {
		report("Could not plant %s events", eventname(good.type));
		return;
	}
	else
		CHECK;
	good.type = UnmapNotify;
	if (winh_plant(winh, &good, StructureNotifyMask, WINH_NOMASK)) {
		report("Could not plant %s events", eventname(good.type));
		return;
	}
	else
		CHECK;
/* Set focus to window. */
	XSetInputFocus(display, winh->window, RevertToNone, CurrentTime);
/* Generate events by unmapping window. */
	XSync(display, True);
	XUnmapWindow(display, winh->window);
	XSync(display, False);
	if (winh_harvest(display, (Winh *) NULL)) {
		report("Could not harvest events");
		return;
	}
	else
		CHECK;
/* Verify that a UnmapNotify event was delivered. */
/* Verify that a xname event was delivered. */
	status = winh_weed((Winh *) NULL, -1, WINH_WEED_IDENTITY);
	if (status < 0)
		return;
	else if (status > 0) {
		report("Event delivery was not as expected");
		FAIL;
	}
	else {
/* Verify that the xname event was delivered after the UnmapNotify event. */
		status = winh_ordercheck(UnmapNotify, EVENT);
		if (status == -1)
			return;
		else if (status)
			FAIL;
		else
			CHECK;
	}
	CHECKPASS(8);
>>#NOTEd >>ASSERTION
>>#NOTEd When the input focus changes,
>>#NOTEd then ARTICLE xname event is generated.
>>#NOTEm >>ASSERTION
>>#NOTEm When the focus window is unmapped,
>>#NOTEm then ARTICLE xname event is generated.
>>ASSERTION Good A
When a xname event is generated,
then
all clients having set
.S FocusChangeMask
event mask bits on the event window are delivered
a xname event.
>>STRATEGY
Create client.
Create clients client2 and client3.
Create window.
Select for xname events on window.
Select for xname events on window with client2.
Select for no events on window with client3.
Set focus to window.
Generate xname event by changing focus from w to None.
Verify that xname event was delivered.
Verify members in delivered xname event structure.
Verify that xname event was delivered to client2.
Verify members in delivered xname event structure.
Verify that no events were delivered to client3.
>>CODE
int	i;
Display	*display;
Display	*client2, *client3;
Window	w;
XEvent	event;
XFocusChangeEvent	good;

/* Create client. */
	if ((display = opendisplay()) == (Display *) NULL) {
		delete("Couldn't create client.");
		return;
	}
	else
		CHECK;
/* Create clients client2 and client3. */
	if ((client2 = opendisplay()) == (Display *) NULL) {
		delete("Couldn't create client2.");
		return;
	}
	else
		CHECK;
	if ((client3 = opendisplay()) == (Display *) NULL) {
		delete("Couldn't create client3.");
		return;
	}
	else
		CHECK;
/* Create window. */
	w = mkwin(display, (XVisualInfo *) NULL, (struct area *) NULL, True);
/* Select for xname events on window. */
	XSelectInput(display, w, MASK);
/* Select for xname events on window with client2. */
	XSelectInput(client2, w, MASK);
/* Select for no events on window with client3. */
	XSelectInput(client3, w, NoEventMask);
/* Set focus to window. */
	XSetInputFocus(display, w, RevertToNone, CurrentTime);
/* Generate xname event by changing focus from w to None. */
	XSync(display, True);
	XSync(client2, True);
	XSync(client3, True);
	XSetInputFocus(display, None, RevertToNone, CurrentTime);
	XSync(display, False);
	XSync(client2, False);
	XSync(client3, False);
/* Verify that xname event was delivered. */
	if (XPending(display) < 1) {
		report("Expected %s event not delivered.", eventname(EVENT));
		FAIL;
		return;
	}
	else
		CHECK;
/* Verify members in delivered xname event structure. */
	XNextEvent(display, &event);
	good = event.xfocus;
	good.type = EVENT;
	good.send_event = False;
	good.display = display;
	good.window = w;
	good.mode = NotifyNormal;
	good.detail = NotifyNonlinear;
	if (checkevent((XEvent*)&good, &event)) {
		report("Unexpected event structure member value(s)");
		FAIL;
	}
	else
		CHECK;
	if ((i = XPending(display)) > 0) {
		report("Expected 1 event, got %d", i+1);
		FAIL;
	}
	else
		CHECK;
/* Verify that xname event was delivered to client2. */
	if (XPending(client2) < 1) {
		report("Expected %s event not delivered to client2.", eventname(EVENT));
		FAIL;
		return;
	}
	else
		CHECK;
/* Verify members in delivered xname event structure. */
	XNextEvent(client2, &event);
	good = event.xfocus;
	good.type = EVENT;
	good.send_event = False;
	good.display = client2;
	good.window = w;
	good.mode = NotifyNormal;
	good.detail = NotifyNonlinear;
	if (checkevent((XEvent*)&good, &event)) {
		report("Unexpected event structure member value(s) for client2");
		FAIL;
	}
	else
		CHECK;
	if ((i = XPending(client2)) > 0) {
		report("Expected 1 event, got %d for client2", i+1);
		FAIL;
	}
	else
		CHECK;
/* Verify that no events were delivered to client3. */
	if ((i = XPending(client3)) > 0) {
		report("Expected 0 events, got %d for client3", i);
		FAIL;
	}
	else
		CHECK;
	CHECKPASS(10);
>>ASSERTION def
>>#NOTE Tested for in previous assertion.
When a xname event is generated,
then
clients not having set
.S FocusChangeMask
event mask bits on the event window are not delivered
a xname event.
>>#NOTEs >>ASSERTION
>>#NOTEs When ARTICLE xname event is delivered,
>>#NOTEs then
>>#NOTEs .M type
>>#NOTEs is set to
>>#NOTEs xname.
>>#NOTEs >>ASSERTION
>>#NOTEs >>#NOTE The method of expansion is not clear.
>>#NOTEs When ARTICLE xname event is delivered,
>>#NOTEs then
>>#NOTEs .M serial
>>#NOTEs is set
>>#NOTEs from the serial number reported in the protocol
>>#NOTEs but expanded from the 16-bit least-significant bits
>>#NOTEs to a full 32-bit value.
>>#NOTEm >>ASSERTION
>>#NOTEm When ARTICLE xname event is delivered
>>#NOTEm and the event came from a
>>#NOTEm .S SendEvent
>>#NOTEm protocol request,
>>#NOTEm then
>>#NOTEm .M send_event
>>#NOTEm is set to
>>#NOTEm .S True .
>>#NOTEs >>ASSERTION
>>#NOTEs When ARTICLE xname event is delivered
>>#NOTEs and the event was not generated by a
>>#NOTEs .S SendEvent
>>#NOTEs protocol request,
>>#NOTEs then
>>#NOTEs .M send_event
>>#NOTEs is set to
>>#NOTEs .S False .
>>#NOTEs >>ASSERTION
>>#NOTEs When ARTICLE xname event is delivered,
>>#NOTEs then
>>#NOTEs .M display
>>#NOTEs is set to
>>#NOTEs a pointer to the display on which the event was read.
>>#NOTEs >>ASSERTION
>>#NOTEs >>#NOTE Global except for MappingNotify and KeymapNotify.
>>#NOTEs When ARTICLE xname event is delivered,
>>#NOTEs then
>>#NOTEs .M window
>>#NOTEs is set to
>>#NOTEs the
>>#NOTEs ifdef(`WINDOWTYPE', WINDOWTYPE, event)
>>#NOTEs window.
>>#NOTEs >>ASSERTION
>>#NOTEs When ARTICLE xname event is generated while the pointer is not grabbed,
>>#NOTEs then
>>#NOTEs .A mode
>>#NOTEs is set to
>>#NOTEs .S NotifyNormal .
>>#NOTEs >>ASSERTION
>>#NOTEs When ARTICLE xname event is generated while the pointer is grabbed,
>>#NOTEs then
>>#NOTEs .A mode
>>#NOTEs is set to
>>#NOTEs .S NotifyWhileGrabbed .
>>#NOTEm >>ASSERTION
>>#NOTEm When ARTICLE xname event is generated
>>#NOTEm and a keyboard grab activates,
>>#NOTEm then xname events are generated as if the focus were to change from
>>#NOTEm the old focus to the grab window with
>>#NOTEm .A mode
>>#NOTEm is set to
>>#NOTEm .S NotifyGrab .
>>#NOTEm >>ASSERTION
>>#NOTEm When ARTICLE xname event is generated
>>#NOTEm and a keyboard grab deactivates,
>>#NOTEm then xname events are generated as if the focus were to change from
>>#NOTEm the grab window to the new focus with
>>#NOTEm .A mode
>>#NOTEm is set to
>>#NOTEm .S NotifyUngrab .
>>ASSERTION def
All xname events are delivered before
any related
.S FocusIn
are delivered.
>>ASSERTION Good A
>>#NOTE
>>#NOTE Some of these assertions have wording which is not relevant.
>>#NOTE For example, many state ``the pointer is in window P'' but
>>#NOTE make no other reference to window P.
>>#NOTE
When the input focus moves from window A to window B
and window A is an inferior of window B
and the pointer is in window P,
then a xname event is generated on window A,
with
.M detail
set to
.S NotifyAncestor
and then on each window
between window A and window B,
exclusive,
with
.M detail
set to
.S NotifyVirtual .
>>STRATEGY
Create client.
Build window hierarchy.
Move pointer to known location.
Set window B.
Set window A to inferior of window B.
Set input focus to window A.
Select for Focus events on windows.
Generate xname event by changing focus from A to B.
Verify that the expected events were delivered.
Verify that event delivered to window A with detail set to NotifyAncestor.
Verify that event delivered on each window
between window A and window B, exclusive,
with detail set to NotifyVirtual.
Verify that all xname events are delivered before all
FocusIn events.
>>CODE
Display	*display;
int	depth = 4;
Winh	*A, *B;
int	status;

/* Create client. */
	if ((display = opendisplay()) == (Display *) NULL) {
		delete("Couldn't create client.");
		return;
	}
	else
		CHECK;
/* Build window hierarchy. */
	if (winh(display, depth, WINH_MAP)) {
		report("Could not build window hierarchy");
		return;
	}
	else
		CHECK;
/* Move pointer to known location. */
	if (warppointer(display, DRW(display), 0, 0) == (PointerPlace *) NULL)
		return;
	else
		CHECK;
/* Set window B. */
	B = guardian->firstchild;
/* Set window A to inferior of window B. */
	A = B->firstchild->firstchild->firstchild;
/* Set input focus to window A. */
	XSetInputFocus(display, A->window, RevertToNone, CurrentTime);
/* Select for Focus events on windows. */
	_event_mask_ = MASK;
	_display_ = display;
	if (winh_climb(A, B, selectinput)) {
		report("Could not select for events");
		return;
	}
	else
		CHECK;
	good.type = EVENT;
	good.xany.display = display;
	if (winh_climb(A, B->firstchild, plant)) {
		report("Could not plant events");
		return;
	}
	else
		CHECK;
/* Generate xname event by changing focus from A to B. */
	XSync(display, True);
	XSetInputFocus(display, B->window, RevertToNone, CurrentTime);
	XSync(display, False);
	if (winh_harvest(display, (Winh *) NULL)) {
		report("Could not harvest events");
		return;
	}
	else
		CHECK;
/* Verify that the expected events were delivered. */
	if (winh_ignore_event(B, OTHEREVENT, WINH_NOMASK)) {
		delete("Could not ignore %s events", eventname(OTHEREVENT));
		return;
	}
	else
		CHECK;
	status = winh_weed((Winh *) NULL, -1, WINH_WEED_IDENTITY);
	if (status < 0)
		return;
	else if (status > 0) {
		report("Event delivery was not as expected");
		FAIL;
	}
	else {
/* Verify that event delivered to window A with detail set to NotifyAncestor. */
		_detail_ = NotifyAncestor;
		if (winh_climb(A, A, checkdetail))
			FAIL;
		else
			CHECK;
/* Verify that event delivered on each window */
/* between window A and window B, exclusive, */
/* with detail set to NotifyVirtual. */
		_detail_ = NotifyVirtual;
		if (winh_climb(A->parent, B->firstchild, checkdetail))
			FAIL;
		else
			CHECK;
/* Verify that all xname events are delivered before all */
/* FocusIn events. */
		status = winh_ordercheck(EVENT, OTHEREVENT);
		if (status == -1)
			return;
		else if (status)
			FAIL;
		else
			CHECK;
	}
	CHECKPASS(10);
>>ASSERTION Good A
When the input focus moves from window A to window B
and window B is an inferior of window A
and the pointer is in window P
and window P is an inferior of window A
and window P is not an inferior of window B
and window P is not an ancestor of window B,
then a xname event is generated on each window
from window P up to but not including window A,
with
.M detail
set to
.S NotifyPointer .
>>STRATEGY
Create client.
Build window hierarchy.
Move pointer to known location.
Set window A.
Set window B to inferior of window A.
Set window P to inferior of sibling of window B.
Move pointer to window P.
Set input focus to window A.
Select for Focus events on windows.
Generate xname event by changing focus from A to B.
Verify that the expected events were delivered.
Verify that event delivered to each window from window P
up to but not including window A,
with detail set to NotifyPointer.
Verify order of xname event delivery.
Verify that all xname events are delivered before all
FocusIn events.
>>CODE
Display	*display;
int	depth = 4;
Winh	*A, *B, *P, *Pancestor;
int	status;

/* Create client. */
	if ((display = opendisplay()) == (Display *) NULL) {
		delete("Couldn't create client.");
		return;
	}
	else
		CHECK;
/* Build window hierarchy. */
	if (winh(display, depth, WINH_MAP)) {
		report("Could not build window hierarchy");
		return;
	}
	else
		CHECK;
/* Move pointer to known location. */
	if (warppointer(display, DRW(display), 0, 0) == (PointerPlace *) NULL)
		return;
	else
		CHECK;
/* Set window A. */
	A = guardian->firstchild;
/* Set window B to inferior of window A. */
	B = A->firstchild;
/* Set window P to inferior of sibling of window B. */
	Pancestor = A->firstchild->nextsibling;
	P = Pancestor->firstchild->firstchild;
/* Move pointer to window P. */
	XWarpPointer(display, None, P->window, 0, 0, 0, 0, 0, 0);
/* Set input focus to window A. */
	XSetInputFocus(display, A->window, RevertToNone, CurrentTime);
/* Select for Focus events on windows. */
	_event_mask_ = MASK;
	_display_ = display;
	if (winh_climb(P, Pancestor, selectinput)) {
		report("Could not select for events");
		return;
	}
	else
		CHECK;
	if (winh_climb(B, A->firstchild, selectinput)) {
		report("Could not select for events between B and A");
		return;
	}
	else
		CHECK;
	good.type = EVENT;
	good.xany.display = display;
	if (winh_climb(P, Pancestor, plant)) {
		report("Could not plant events");
		return;
	}
	else
		CHECK;
/* Generate xname event by changing focus from A to B. */
	XSync(display, True);
	XSetInputFocus(display, B->window, RevertToNone, CurrentTime);
	XSync(display, False);
	if (winh_harvest(display, (Winh *) NULL)) {
		report("Could not harvest events");
		return;
	}
	else
		CHECK;
/* Verify that the expected events were delivered. */
	if (winh_ignore_event((Winh *) NULL, OTHEREVENT, WINH_NOMASK)) {
		delete("Could not ignore %s events", eventname(OTHEREVENT));
		return;
	}
	else
		CHECK;
	status = winh_weed((Winh *) NULL, -1, WINH_WEED_IDENTITY);
	if (status < 0)
		return;
	else if (status > 0) {
		report("Event delivery was not as expected");
		FAIL;
	}
	else {
/* Verify that event delivered to each window from window P */
/* up to but not including window A, */
/* with detail set to NotifyPointer. */
		_detail_ = NotifyPointer;
		if (winh_climb(P, Pancestor, checkdetail))
			FAIL;
		else
			CHECK;
/* Verify order of xname event delivery. */
		increasing = False;
		if (winh_climb(P, Pancestor, checksequence))
			FAIL;
		else
			CHECK;
/* Verify that all xname events are delivered before all */
/* FocusIn events. */
		status = winh_ordercheck(EVENT, OTHEREVENT);
		if (status == -1)
			return;
		else if (status)
			FAIL;
		else
			CHECK;
	}
	CHECKPASS(11);
>>ASSERTION Good A
When the input focus moves from window A to window B
and window B is an inferior of window A
and the pointer is in window P,
then, after any related xname events are generated
with
.M detail
set to
.S NotifyPointer ,
a xname event is generated on window A,
with
.M detail
set to
.S NotifyInferior .
>>STRATEGY
Create client.
Build window hierarchy.
Move pointer to known location.
Set window A.
Set window B to inferior of window A.
Set window P to inferior of sibling of window B.
Move pointer to window P.
Set input focus to window A.
Select for Focus events on windows.
Generate xname event by changing focus from A to B.
Verify that the expected events were delivered.
Verify that event delivered to each window from window P
up to but not including window A,
with detail set to NotifyPointer.
Verify that event delivered on window A
with detail set to NotifyInferior.
Verify order of xname event delivery.
Verify that all xname events are delivered before all
FocusIn events.
>>CODE
Display	*display;
int	depth = 4;
Winh	*A, *B, *P, *Pancestor;
int	status;

/* Create client. */
	if ((display = opendisplay()) == (Display *) NULL) {
		delete("Couldn't create client.");
		return;
	}
	else
		CHECK;
/* Build window hierarchy. */
	if (winh(display, depth, WINH_MAP)) {
		report("Could not build window hierarchy");
		return;
	}
	else
		CHECK;
/* Move pointer to known location. */
	if (warppointer(display, DRW(display), 0, 0) == (PointerPlace *) NULL)
		return;
	else
		CHECK;
/* Set window A. */
	A = guardian->firstchild;
/* Set window B to inferior of window A. */
	B = A->firstchild;
/* Set window P to inferior of sibling of window B. */
	Pancestor = A->firstchild->nextsibling;
	P = Pancestor->firstchild->firstchild;
/* Move pointer to window P. */
	XWarpPointer(display, None, P->window, 0, 0, 0, 0, 0, 0);
/* Set input focus to window A. */
	XSetInputFocus(display, A->window, RevertToNone, CurrentTime);
/* Select for Focus events on windows. */
	_event_mask_ = MASK;
	_display_ = display;
	if (winh_climb(P, A, selectinput)) {
		report("Could not select for events");
		return;
	}
	else
		CHECK;
	if (winh_climb(B, A->firstchild, selectinput)) {
		report("Could not select for events between B and A");
		return;
	}
	else
		CHECK;
	good.type = EVENT;
	good.xany.display = display;
	if (winh_climb(P, A, plant)) {
		report("Could not plant events");
		return;
	}
	else
		CHECK;
/* Generate xname event by changing focus from A to B. */
	XSync(display, True);
	XSetInputFocus(display, B->window, RevertToNone, CurrentTime);
	XSync(display, False);
	if (winh_harvest(display, (Winh *) NULL)) {
		report("Could not harvest events");
		return;
	}
	else
		CHECK;
/* Verify that the expected events were delivered. */
	if (winh_ignore_event((Winh *) NULL, OTHEREVENT, WINH_NOMASK)) {
		delete("Could not ignore %s events", eventname(OTHEREVENT));
		return;
	}
	else
		CHECK;
	status = winh_weed((Winh *) NULL, -1, WINH_WEED_IDENTITY);
	if (status < 0)
		return;
	else if (status > 0) {
		report("Event delivery was not as expected");
		FAIL;
	}
	else {
/* Verify that event delivered to each window from window P */
/* up to but not including window A, */
/* with detail set to NotifyPointer. */
		_detail_ = NotifyPointer;
		if (winh_climb(P, Pancestor, checkdetail))
			FAIL;
		else
			CHECK;
/* Verify that event delivered on window A */
/* with detail set to NotifyInferior. */
		_detail_ = NotifyInferior;
		if (winh_climb(A, A, checkdetail))
			FAIL;
		else
			CHECK;
/* Verify order of xname event delivery. */
		increasing = False;
		if (winh_climb(P, A, checksequence))
			FAIL;
		else
			CHECK;
/* Verify that all xname events are delivered before all */
/* FocusIn events. */
		status = winh_ordercheck(EVENT, OTHEREVENT);
		if (status == -1)
			return;
		else if (status)
			FAIL;
		else
			CHECK;
	}
	CHECKPASS(12);
>>ASSERTION Good A
When the input focus moves from window A to window B
and window C is their least common ancestor
and the pointer is in window P
and window P is an inferior of window A,
then a xname event is generated on each window
from window P up to but not including window A,
with
.M detail
set to
.S NotifyPointer .
>>STRATEGY
Create client.
Build window hierarchy.
Move pointer to known location.
Set window C.
Set window A to inferior of window C.
Set window P to inferior of window A.
Set window B to inferior of window C.
Move pointer to window P.
Set input focus to window A.
Select for Focus events on windows.
Generate xname event by changing focus from A to B.
Verify that the expected events were delivered.
Verify that event delivered to windows from window P
up to but not including window A,
with detail set to NotifyPointer.
Verify order of xname event delivery.
Verify that all xname events are delivered before all
FocusIn events.
>>CODE
Display	*display;
int	depth = 5;
Winh	*A, *B, *C, *P;
int	status;

/* Create client. */
	if ((display = opendisplay()) == (Display *) NULL) {
		delete("Couldn't create client.");
		return;
	}
	else
		CHECK;
/* Build window hierarchy. */
	if (winh(display, depth, WINH_MAP)) {
		report("Could not build window hierarchy");
		return;
	}
	else
		CHECK;
/* Move pointer to known location. */
	if (warppointer(display, DRW(display), 0, 0) == (PointerPlace *) NULL)
		return;
	else
		CHECK;
/* Set window C. */
	C = guardian->firstchild;
/* Set window A to inferior of window C. */
	A = C->firstchild;
/* Set window P to inferior of window A. */
	P = A->firstchild->firstchild->firstchild;
/* Set window B to inferior of window C. */
	B = C->firstchild->nextsibling->firstchild;
/* Move pointer to window P. */
	XWarpPointer(display, None, P->window, 0, 0, 0, 0, 0, 0);
/* Set input focus to window A. */
	XSetInputFocus(display, A->window, RevertToNone, CurrentTime);
/* Select for Focus events on windows. */
	_event_mask_ = MASK;
	_display_ = display;
	if (winh_climb(P, A->firstchild, selectinput)) {
		report("Could not select for events");
		return;
	}
	else
		CHECK;
	/* This gets us a FocusIn event. */
	if (winh_climb(B, B, selectinput)) {
		report("Could not select for events on B");
		return;
	}
	else
		CHECK;
	if (winh_climb(P, A->firstchild, selectinput)) {
		report("Could not select for events below A to P");
		return;
	}
	else
		CHECK;
	good.type = EVENT;
	good.xany.display = display;
	if (winh_climb(P, A->firstchild, plant)) {
		report("Could not plant events");
		return;
	}
	else
		CHECK;
/* Generate xname event by changing focus from A to B. */
	XSync(display, True);
	XSetInputFocus(display, B->window, RevertToNone, CurrentTime);
	XSync(display, False);
	if (winh_harvest(display, (Winh *) NULL)) {
		report("Could not harvest events");
		return;
	}
	else
		CHECK;
/* Verify that the expected events were delivered. */
	if (winh_ignore_event((Winh *) NULL, OTHEREVENT, WINH_NOMASK)) {
		delete("Could not ignore %s events", eventname(OTHEREVENT));
		return;
	}
	else
		CHECK;
	status = winh_weed((Winh *) NULL, -1, WINH_WEED_IDENTITY);
	if (status < 0)
		return;
	else if (status > 0) {
		report("Event delivery was not as expected");
		FAIL;
	}
	else {
/* Verify that event delivered to windows from window P */
/* up to but not including window A, */
/* with detail set to NotifyPointer. */
		_detail_ = NotifyPointer;
		if (winh_climb(P, A->firstchild, checkdetail))
			FAIL;
		else
			CHECK;
/* Verify order of xname event delivery. */
		increasing = False;
		if (winh_climb(P, A->firstchild, checksequence))
			FAIL;
		else
			CHECK;
/* Verify that all xname events are delivered before all */
/* FocusIn events. */
		status = winh_ordercheck(EVENT, OTHEREVENT);
		if (status == -1)
			return;
		else if (status)
			FAIL;
		else
			CHECK;
	}
	CHECKPASS(12);
>>ASSERTION Good A
When the input focus moves from window A to window B
and window C is their least common ancestor
and the pointer is in window P,
then, after any related xname events are generated
with
.M detail
set to
.S NotifyPointer ,
a xname event is generated on window A,
with
.M detail
set to
.S NotifyNonlinear
and then on
each window between window A and window C, exclusive,
with
.M detail
set to
.S NotifyNonlinearVirtual .
>>STRATEGY
Create client.
Build window hierarchy.
Move pointer to known location.
Set window C.
Set window A to inferior of window C.
Set window P to inferior of window A.
Set window B to inferior of window C.
Move pointer to window P.
Set input focus to window A.
Select for Focus events on windows.
Generate xname event by changing focus from A to B.
Verify that the expected events were delivered.
Verify that event delivered to windows from window P
up to but not including window A,
with detail set to NotifyPointer.
Verify that event delivered to window A
with detail set to NotifyNonlinear.
Verify that event delivered between window A and window C, exclusive,
with detail set to NotifyNonlinearVirtual.
Verify order of xname event delivery.
Verify that all xname events are delivered before all
FocusIn events.
>>CODE
Display	*display;
int	depth = 5;
Winh	*A, *B, *C, *P;
int	status;

/* Create client. */
	if ((display = opendisplay()) == (Display *) NULL) {
		delete("Couldn't create client.");
		return;
	}
	else
		CHECK;
/* Build window hierarchy. */
	if (winh(display, depth, WINH_MAP)) {
		report("Could not build window hierarchy");
		return;
	}
	else
		CHECK;
/* Move pointer to known location. */
	if (warppointer(display, DRW(display), 0, 0) == (PointerPlace *) NULL)
		return;
	else
		CHECK;
/* Set window C. */
	C = guardian->firstchild;
/* Set window A to inferior of window C. */
	A = C->firstchild->firstchild->firstchild;
/* Set window P to inferior of window A. */
	P = A->firstchild;
/* Set window B to inferior of window C. */
	B = C->firstchild->nextsibling->firstchild;
/* Move pointer to window P. */
	XWarpPointer(display, None, P->window, 0, 0, 0, 0, 0, 0);
/* Set input focus to window A. */
	XSetInputFocus(display, A->window, RevertToNone, CurrentTime);
/* Select for Focus events on windows. */
	_event_mask_ = MASK;
	_display_ = display;
	if (winh_climb(P, A, selectinput)) {
		report("Could not select for events");
		return;
	}
	else
		CHECK;
	if (winh_climb(A->parent, C->firstchild, selectinput)) {
		report("Could not select for events between A to C");
		return;
	}
	else
		CHECK;
	/* This gets us a FocusIn event. */
	if (winh_climb(B, B, selectinput)) {
		report("Could not select for events on B");
		return;
	}
	else
		CHECK;
	good.type = EVENT;
	good.xany.display = display;
	if (winh_climb(P, A, plant)) {
		report("Could not plant events");
		return;
	}
	else
		CHECK;
	if (winh_climb(A->parent, C->firstchild, plant)) {
		report("Could not plant events between A and C");
		return;
	}
	else
		CHECK;
/* Generate xname event by changing focus from A to B. */
	XSync(display, True);
	XSetInputFocus(display, B->window, RevertToNone, CurrentTime);
	XSync(display, False);
	if (winh_harvest(display, (Winh *) NULL)) {
		report("Could not harvest events");
		return;
	}
	else
		CHECK;
/* Verify that the expected events were delivered. */
	if (winh_ignore_event((Winh *) NULL, OTHEREVENT, WINH_NOMASK)) {
		delete("Could not ignore %s events", eventname(OTHEREVENT));
		return;
	}
	else
		CHECK;
	status = winh_weed((Winh *) NULL, -1, WINH_WEED_IDENTITY);
	if (status < 0)
		return;
	else if (status > 0) {
		report("Event delivery was not as expected");
		FAIL;
	}
	else {
/* Verify that event delivered to windows from window P */
/* up to but not including window A, */
/* with detail set to NotifyPointer. */
		_detail_ = NotifyPointer;
		if (winh_climb(P, A->firstchild, checkdetail)) {
			report("Incorrect detail from P up to A");
			FAIL;
		}
		else
			CHECK;
/* Verify that event delivered to window A */
/* with detail set to NotifyNonlinear. */
		_detail_ = NotifyNonlinear;
		if (winh_climb(A, A, checkdetail)) {
			report("Incorrect detail for A");
			FAIL;
		}
		else
			CHECK;
/* Verify that event delivered between window A and window C, exclusive, */
/* with detail set to NotifyNonlinearVirtual. */
		_detail_ = NotifyNonlinearVirtual;
		if (winh_climb(A->parent, C->firstchild, checkdetail)) {
			report("Incorrect detail between A and C");
			FAIL;
		}
		else
			CHECK;
/* Verify order of xname event delivery. */
		increasing = False;
		if (winh_climb(P, A, checksequence))
			FAIL;
		else
			CHECK;
		increasing = False;
		if (winh_climb(A, C->firstchild, checksequence))
			FAIL;
		else
			CHECK;
/* Verify that all xname events are delivered before all */
/* FocusIn events. */
		status = winh_ordercheck(EVENT, OTHEREVENT);
		if (status == -1)
			return;
		else if (status)
			FAIL;
		else
			CHECK;
	}
	CHECKPASS(16);
>>ASSERTION Good C
>>#NOTE	This is also tested for in the following assertion.
If the implementation supports multiple screens:
When the input focus moves from window A to window B
and window A and window B are not on the same screens
and the pointer is in window P
and window P is an inferior of window A,
then a xname event is generated on
each window from window P up to but not including window A,
with
.M detail
set to
.S NotifyPointer .
>>STRATEGY
Check to see if multiple screens are supported.
Create client.
Build window hierarchy on all supported screens.
Move pointer to known location.
Set window A.
Set window B to an inferior of the root window on a different screen than A.
Set window P.
Move pointer to window P.
Set input focus to window A.
Select for Focus events on windows.
Generate xname event by changing focus from A to B.
Verify that the expected events were delivered.
Verify that event delivered to each window from window P
up to but not including window A,
with detail set to NotifyPointer.
Verify order of xname event delivery.
Verify that all xname events are delivered before all
FocusIn events.
>>CODE
Display	*display;
int	depth = 4;
Winh	*A, *B, *Broot, *P, *Pancestor;
int	status;

/* Check to see if multiple screens are supported. */
	if (config.alt_screen == -1) {
		unsupported("Multiple screens not supported.");
		return;
	}
	else
		CHECK;
/* Create client. */
	if ((display = opendisplay()) == (Display *) NULL) {
		delete("Couldn't create client.");
		return;
	}
	else
		CHECK;
/* Build window hierarchy on all supported screens. */
	if (winh(display, depth, WINH_MAP|WINH_BOTH_SCREENS)) {
		report("Could not build window hierarchy");
		return;
	}
	else
		CHECK;
/* Move pointer to known location. */
	if (warppointer(display, DRW(display), 0, 0) == (PointerPlace *) NULL)
		return;
	else
		CHECK;
/* Set window A. */
	A = guardian->firstchild;
/* Set window B to an inferior of the root window on a different screen than A. */
	Broot = guardian->nextsibling;
	B = Broot->firstchild->firstchild;
/* Set window P. */
	Pancestor = A->firstchild;
	P = Pancestor->firstchild->firstchild;
/* Move pointer to window P. */
	XWarpPointer(display, None, P->window, 0, 0, 0, 0, 0, 0);
/* Set input focus to window A. */
	XSetInputFocus(display, A->window, RevertToNone, CurrentTime);
/* Select for Focus events on windows. */
	_event_mask_ = MASK;
	_display_ = display;
	if (winh_climb(P, Pancestor, selectinput)) {
		report("Could not select for events");
		return;
	}
	else
		CHECK;
	if (winh_climb(B, Broot, selectinput)) {
		report("Could not select for events on windows B and above");
		return;
	}
	else
		CHECK;
	good.type = EVENT;
	good.xany.display = display;
	if (winh_climb(P, Pancestor, plant)) {
		report("Could not plant events");
		return;
	}
	else
		CHECK;
/* Generate xname event by changing focus from A to B. */
	XSync(display, True);
	XSetInputFocus(display, B->window, RevertToNone, CurrentTime);
	XSync(display, False);
	if (winh_harvest(display, (Winh *) NULL)) {
		report("Could not harvest events");
		return;
	}
	else
		CHECK;
/* Verify that the expected events were delivered. */
	if (winh_ignore_event((Winh *) NULL, OTHEREVENT, WINH_NOMASK)) {
		delete("Could not ignore %s events", eventname(OTHEREVENT));
		return;
	}
	else
		CHECK;
	status = winh_weed((Winh *) NULL, -1, WINH_WEED_IDENTITY);
	if (status < 0)
		return;
	else if (status > 0) {
		report("Event delivery was not as expected");
		FAIL;
	}
	else {
/* Verify that event delivered to each window from window P */
/* up to but not including window A, */
/* with detail set to NotifyPointer. */
		_detail_ = NotifyPointer;
		if (winh_climb(P, Pancestor, checkdetail))
			FAIL;
		else
			CHECK;
/* Verify order of xname event delivery. */
		increasing = False;
		if (winh_climb(P, Pancestor, checksequence))
			FAIL;
		else
			CHECK;
/* Verify that all xname events are delivered before all */
/* FocusIn events. */
		status = winh_ordercheck(EVENT, OTHEREVENT);
		if (status == -1)
			return;
		else if (status)
			FAIL;
		else
			CHECK;
	}
	CHECKPASS(12);
>>ASSERTION Good C
If the implementation supports multiple screens:
When the input focus moves from window A to window B
and window A and window B are not on the same screens
and the pointer is in window P,
then, after any related xname events are generated
with
.M detail
set to
.S NotifyPointer ,
a xname event is generated on
window A,
with
.M detail
set to
.S NotifyNonlinear .
>>STRATEGY
Check to see if multiple screens are supported.
Create client.
Build window hierarchy on all supported screens.
Move pointer to known location.
Set window A to a root window.
Set window B to an inferior of the root window on a different screen than A.
Set window P.
Move pointer to window P.
Set input focus to window A.
Select for Focus events on windows.
Generate xname event by changing focus from A to B.
Verify that the expected events were delivered.
Verify that event delivered to each window from window P
up to but not including window A,
with detail set to NotifyPointer.
Verify that event delivered to window A
with detail set to NotifyNonlinear.
Verify order of xname event delivery.
Verify that all xname events are delivered before all
FocusIn events.
>>CODE
Display	*display;
int	depth = 4;
Winh	*A, *B, *Broot, *P, *Pancestor;
int	status;

/* Check to see if multiple screens are supported. */
	if (config.alt_screen == -1) {
		unsupported("Multiple screens not supported.");
		return;
	}
	else
		CHECK;
/* Create client. */
	if ((display = opendisplay()) == (Display *) NULL) {
		delete("Couldn't create client.");
		return;
	}
	else
		CHECK;
/* Build window hierarchy on all supported screens. */
	if (winh(display, depth, WINH_MAP|WINH_BOTH_SCREENS)) {
		report("Could not build window hierarchy");
		return;
	}
	else
		CHECK;
/* Move pointer to known location. */
	if (warppointer(display, DRW(display), 0, 0) == (PointerPlace *) NULL)
		return;
	else
		CHECK;
/* Set window A to a root window. */
	A = guardian;
/* Set window B to an inferior of the root window on a different screen than A. */
	Broot = guardian->nextsibling;
	B = Broot->firstchild->firstchild;
/* Set window P. */
	Pancestor = A->firstchild;
	P = Pancestor->firstchild->firstchild;
/* Move pointer to window P. */
	XWarpPointer(display, None, P->window, 0, 0, 0, 0, 0, 0);
/* Set input focus to window A. */
	XSetInputFocus(display, A->window, RevertToNone, CurrentTime);
/* Select for Focus events on windows. */
	_event_mask_ = MASK;
	_display_ = display;
	if (winh_climb(P, A, selectinput)) {
		report("Could not select for events");
		return;
	}
	else
		CHECK;
	if (winh_climb(B, Broot, selectinput)) {
		report("Could not select for events on windows B and above");
		return;
	}
	else
		CHECK;
	good.type = EVENT;
	good.xany.display = display;
	if (winh_climb(P, A, plant)) {
		report("Could not plant events");
		return;
	}
	else
		CHECK;
/* Generate xname event by changing focus from A to B. */
	XSync(display, True);
	XSetInputFocus(display, B->window, RevertToNone, CurrentTime);
	XSync(display, False);
	if (winh_harvest(display, (Winh *) NULL)) {
		report("Could not harvest events");
		return;
	}
	else
		CHECK;
/* Verify that the expected events were delivered. */
	if (winh_ignore_event((Winh *) NULL, OTHEREVENT, WINH_NOMASK)) {
		delete("Could not ignore %s events", eventname(OTHEREVENT));
		return;
	}
	else
		CHECK;
	status = winh_weed((Winh *) NULL, -1, WINH_WEED_IDENTITY);
	if (status < 0)
		return;
	else if (status > 0) {
		report("Event delivery was not as expected");
		FAIL;
	}
	else {
/* Verify that event delivered to each window from window P */
/* up to but not including window A, */
/* with detail set to NotifyPointer. */
		_detail_ = NotifyPointer;
		if (winh_climb(P, Pancestor, checkdetail))
			FAIL;
		else
			CHECK;
/* Verify that event delivered to window A */
/* with detail set to NotifyNonlinear. */
		_detail_ = NotifyNonlinear;
		if (winh_climb(A, A, checkdetail))
			FAIL;
		else
			CHECK;
/* Verify order of xname event delivery. */
		increasing = False;
		if (winh_climb(P, A, checksequence))
			FAIL;
		else
			CHECK;
/* Verify that all xname events are delivered before all */
/* FocusIn events. */
		status = winh_ordercheck(EVENT, OTHEREVENT);
		if (status == -1)
			return;
		else if (status)
			FAIL;
		else
			CHECK;
	}
	CHECKPASS(13);
>>ASSERTION Good C
If the implementation supports multiple screens:
When the input focus moves from window A to window B
and window A and window B are not on the same screens
and the pointer is in window P
and window A is not a root window,
then, after the related xname event is generated
with
.M detail
set to
.S NotifyNonlinear ,
a xname event is generated on
each window above window A up to and including its root,
with
.M detail
set to
.S NotifyNonlinearVirtual .
>>STRATEGY
Check to see if multiple screens are supported.
Create client.
Build window hierarchy on all supported screens.
Move pointer to known location.
Set window A to a non-root window.
Set window B to an inferior of the root window on a different screen than A.
Move pointer to window B.
Set input focus to window A.
Select for Focus events on windows.
Generate xname event by changing focus from A to B.
Verify that the expected events were delivered.
Verify that event delivered to window A
with detail set to NotifyNonlinear.
Verify that event delivered on each window above window A
up to and including its root,
with detail set to NotifyNonlinearVirtual.
Verify order of xname event delivery.
Verify that all xname events are delivered before all
FocusIn events.
>>CODE
Display	*display;
int	depth = 4;
Winh	*A, *Aroot, *B, *Broot;
int	status;

/* Check to see if multiple screens are supported. */
	if (config.alt_screen == -1) {
		unsupported("Multiple screens not supported.");
		return;
	}
	else
		CHECK;
/* Create client. */
	if ((display = opendisplay()) == (Display *) NULL) {
		delete("Couldn't create client.");
		return;
	}
	else
		CHECK;
/* Build window hierarchy on all supported screens. */
	if (winh(display, depth, WINH_MAP|WINH_BOTH_SCREENS)) {
		report("Could not build window hierarchy");
		return;
	}
	else
		CHECK;
/* Move pointer to known location. */
	if (warppointer(display, DRW(display), 0, 0) == (PointerPlace *) NULL)
		return;
	else
		CHECK;
/* Set window A to a non-root window. */
	Aroot = guardian;
	A = Aroot->firstchild->firstchild->firstchild;
/* Set window B to an inferior of the root window on a different screen than A. */
	Broot = guardian->nextsibling;
	B = Broot->firstchild->firstchild;
/* Move pointer to window B. */
	XWarpPointer(display, None, B->window, 0, 0, 0, 0, 0, 0);
/* Set input focus to window A. */
	XSetInputFocus(display, A->window, RevertToNone, CurrentTime);
/* Select for Focus events on windows. */
	_event_mask_ = MASK;
	_display_ = display;
	if (winh_climb(A, Aroot, selectinput)) {
		report("Could not select for events");
		return;
	}
	else
		CHECK;
	if (winh_climb(B, Broot, selectinput)) {
		report("Could not select for events on windows B and above");
		return;
	}
	else
		CHECK;
	good.type = EVENT;
	good.xany.display = display;
	if (winh_climb(A, Aroot, plant)) {
		report("Could not plant events");
		return;
	}
	else
		CHECK;
/* Generate xname event by changing focus from A to B. */
	XSync(display, True);
	XSetInputFocus(display, B->window, RevertToNone, CurrentTime);
	XSync(display, False);
	if (winh_harvest(display, (Winh *) NULL)) {
		report("Could not harvest events");
		return;
	}
	else
		CHECK;
/* Verify that the expected events were delivered. */
	if (winh_ignore_event((Winh *) NULL, OTHEREVENT, WINH_NOMASK)) {
		delete("Could not ignore %s events", eventname(OTHEREVENT));
		return;
	}
	else
		CHECK;
	status = winh_weed((Winh *) NULL, -1, WINH_WEED_IDENTITY);
	if (status < 0)
		return;
	else if (status > 0) {
		report("Event delivery was not as expected");
		FAIL;
	}
	else {
/* Verify that event delivered to window A */
/* with detail set to NotifyNonlinear. */
		_detail_ = NotifyNonlinear;
		if (winh_climb(A, A, checkdetail))
			FAIL;
		else
			CHECK;
/* Verify that event delivered on each window above window A */
/* up to and including its root, */
/* with detail set to NotifyNonlinearVirtual. */
		_detail_ = NotifyNonlinearVirtual;
		if (winh_climb(A->parent, Aroot, checkdetail))
			FAIL;
		else
			CHECK;
/* Verify order of xname event delivery. */
		increasing = False;
		if (winh_climb(A, Aroot, checksequence))
			FAIL;
		else
			CHECK;
/* Verify that all xname events are delivered before all */
/* FocusIn events. */
		status = winh_ordercheck(EVENT, OTHEREVENT);
		if (status == -1)
			return;
		else if (status)
			FAIL;
		else
			CHECK;
	}
	CHECKPASS(13);
>>ASSERTION Good A
When the focus moves from window A to
.S PointerRoot
(events sent to the window under the pointer)
or when the focus moves from window A to
.S None
(discard)
and the pointer is in window P
and window P is an inferior of window A,
then a xname event is generated on
each window from window P up to but not including window A,
with
.M detail
set to
.S NotifyPointer .
>>STRATEGY
Create client.
Build window hierarchy.
Set window A to a root window.
Set P to inferior of A.
Move pointer to P.
Set input focus to A.
Select for Focus events on windows.
Generate xname event by changing focus from A to PointerRoot.
Verify that the expected events were delivered.
Verify that event delivered on each window from window P up to
but not including window A
with detail set to NotifyPointer.
Verify that these events occurred in the correct order.
Verify that all xname events are delivered before all
FocusIn events.
Repeat with final focus set to None.
>>CODE
Display	*display;
int	depth = 4;
Winh	*A, *P, *Pancestor;
int	status;
int	i;
static	Window	focuses[] = {
	(Window) PointerRoot,
	(Window) None
};

/* Create client. */
	if ((display = opendisplay()) == (Display *) NULL) {
		delete("Couldn't create client.");
		return;
	}
	else
		CHECK;
/* Build window hierarchy. */
	if (winh(display, depth, WINH_MAP)) {
		report("Could not build window hierarchy");
		return;
	}
	else
		CHECK;
/* Set window A to a root window. */
	A = guardian;
/* Set P to inferior of A. */
	Pancestor = A->firstchild;
	P = Pancestor->firstchild->firstchild;
/* Move pointer to P. */
	if (warppointer(display, P->window, 0, 0) == (PointerPlace *) NULL)
		return;
	else
		CHECK;
	for (i = 0; i < NELEM(focuses); i++) {
/* Set input focus to A. */
		XSetInputFocus(display, A->window, RevertToNone, CurrentTime);
/* Select for Focus events on windows. */
		if (winh_selectinput(display, (Winh *) NULL, MASK)) {
			report("Could not select for events");
			return;
		}
		else
			CHECK;
		good.type = EVENT;
		good.xany.display = display;
		/*
		 * Select on A as well because we are selecting for events
		 * on all windows.
		 */
		if (winh_climb(P, A, plant)) {
			report("Could not plant events");
			return;
		}
		else
			CHECK;
/* Generate xname event by changing focus from A to PointerRoot. */
		XSync(display, True);
		XSetInputFocus(display, focuses[i], RevertToNone, CurrentTime);
		XSync(display, False);
		if (winh_harvest(display, (Winh *) NULL)) {
			report("Could not harvest events");
			return;
		}
		else
			CHECK;
/* Verify that the expected events were delivered. */
		if (winh_ignore_event((Winh *) NULL, OTHEREVENT, WINH_NOMASK)) {
			delete("Could not ignore %s events", eventname(OTHEREVENT));
			return;
		}
		else
			CHECK;
		status = winh_weed((Winh *) NULL, -1, WINH_WEED_IDENTITY);
		if (status < 0)
			return;
		else if (status > 0) {
			report("Event delivery was not as expected");
			FAIL;
		}
		else {
/* Verify that event delivered on each window from window P up to */
/* but not including window A */
/* with detail set to NotifyPointer. */
			_detail_ = NotifyPointer;
			if (winh_climb(P, Pancestor, checkdetail))
				FAIL;
			else
				CHECK;
/* Verify that these events occurred in the correct order. */
			increasing = False;
			if (winh_climb(P, Pancestor, checksequence))
				FAIL;
			else
				CHECK;
/* Verify that all xname events are delivered before all */
/* FocusIn events. */
			status = winh_ordercheck(EVENT, OTHEREVENT);
			if (status == -1)
				return;
			else if (status)
				FAIL;
			else
				CHECK;
		}
/* Repeat with final focus set to None. */
	}
	CHECKPASS(3 + (7*NELEM(focuses)));
>>ASSERTION Good A
When the focus moves from window A to
.S PointerRoot
(events sent to the window under the pointer)
or when the focus moves from window A to
.S None
(discard)
and the pointer is in window P,
then, after any related xname events are generated
with
.M detail
set to
.S NotifyPointer ,
a xname event is generated on
window A,
with
.M detail
set to
.S NotifyNonlinear .
>>STRATEGY
Create client.
Build window hierarchy.
Set window A to a root window.
Set P to inferior of A.
Move pointer to P.
Set input focus to A.
Select for Focus events on windows.
Generate xname event by changing focus from A to PointerRoot.
Verify that the expected events were delivered.
Verify that event delivered on each window from window P up to
but not including window A
with detail set to NotifyPointer.
Verify that event delivered on window A
with detail set to NotifyNonlinear.
Verify that these events occurred in the correct order.
Verify that all xname events are delivered before all
FocusIn events.
Repeat with final focus set to None.
>>CODE
Display	*display;
int	depth = 4;
Winh	*A, *P, *Pancestor;
int	status;
int	i;
static	Window	focuses[] = {
	(Window) PointerRoot,
	(Window) None
};

/* Create client. */
	if ((display = opendisplay()) == (Display *) NULL) {
		delete("Couldn't create client.");
		return;
	}
	else
		CHECK;
/* Build window hierarchy. */
	if (winh(display, depth, WINH_MAP)) {
		report("Could not build window hierarchy");
		return;
	}
	else
		CHECK;
/* Set window A to a root window. */
	A = guardian;
/* Set P to inferior of A. */
	Pancestor = A->firstchild;
	P = Pancestor->firstchild->firstchild;
/* Move pointer to P. */
	if (warppointer(display, P->window, 0, 0) == (PointerPlace *) NULL)
		return;
	else
		CHECK;
	for (i = 0; i < NELEM(focuses); i++) {
/* Set input focus to A. */
		XSetInputFocus(display, A->window, RevertToNone, CurrentTime);
/* Select for Focus events on windows. */
		if (winh_selectinput(display, (Winh *) NULL, MASK)) {
			report("Could not select for events");
			return;
		}
		else
			CHECK;
		good.type = EVENT;
		good.xany.display = display;
		/*
		 * Select on A as well because we are selecting for events
		 * on all windows.
		 */
		if (winh_climb(P, A, plant)) {
			report("Could not plant events");
			return;
		}
		else
			CHECK;
/* Generate xname event by changing focus from A to PointerRoot. */
		XSync(display, True);
		XSetInputFocus(display, focuses[i], RevertToNone, CurrentTime);
		XSync(display, False);
		if (winh_harvest(display, (Winh *) NULL)) {
			report("Could not harvest events");
			return;
		}
		else
			CHECK;
/* Verify that the expected events were delivered. */
		if (winh_ignore_event((Winh *) NULL, OTHEREVENT, WINH_NOMASK)) {
			delete("Could not ignore %s events", eventname(OTHEREVENT));
			return;
		}
		else
			CHECK;
		status = winh_weed((Winh *) NULL, -1, WINH_WEED_IDENTITY);
		if (status < 0)
			return;
		else if (status > 0) {
			report("Event delivery was not as expected");
			FAIL;
		}
		else {
/* Verify that event delivered on each window from window P up to */
/* but not including window A */
/* with detail set to NotifyPointer. */
			_detail_ = NotifyPointer;
			if (winh_climb(P, Pancestor, checkdetail))
				FAIL;
			else
				CHECK;
/* Verify that event delivered on window A */
/* with detail set to NotifyNonlinear. */
			_detail_ = NotifyNonlinear;
			if (winh_climb(A, A, checkdetail))
				FAIL;
			else
				CHECK;
/* Verify that these events occurred in the correct order. */
			increasing = False;
			if (winh_climb(P, A, checksequence))
				FAIL;
			else
				CHECK;
/* Verify that all xname events are delivered before all */
/* FocusIn events. */
			status = winh_ordercheck(EVENT, OTHEREVENT);
			if (status == -1)
				return;
			else if (status)
				FAIL;
			else
				CHECK;
		}
/* Repeat with final focus set to None. */
	}
	CHECKPASS(3 + (8*NELEM(focuses)));
>>ASSERTION Good A
When the focus moves from window A to
.S PointerRoot
(events sent to the window under the pointer)
or when the focus moves from window A to
.S None
(discard)
and the pointer is in window P
and window A is not a root window,
then, after the related xname event is generated
with
.M detail
set to
.S NotifyNonlinear ,
a xname event is generated on
each window above window A up to and including its root,
with
.M detail
set to
.S NotifyNonlinearVirtual .
>>STRATEGY
Create client.
Build window hierarchy.
Set window A to a non-root window.
Set P to root window.
Move pointer to P.
Set input focus to A.
Select for Focus events on windows.
Generate xname event by changing focus from A to PointerRoot.
Verify that the expected events were delivered.
Verify that event delivered on window A
with detail set to NotifyNonlinear.
Verify that event delivered on each window above window A up to
and including its root,
with detail set to NotifyNonlinearVirtual.
Verify that these events occurred in the correct order.
Verify that all xname events are delivered before all
FocusIn events.
Repeat with final focus set to None.
>>CODE
Display	*display;
int	depth = 4;
Winh	*A, *Aroot, *P;
int	status;
int	i;
static	Window	focuses[] = {
	(Window) PointerRoot,
	(Window) None
};

/* Create client. */
	if ((display = opendisplay()) == (Display *) NULL) {
		delete("Couldn't create client.");
		return;
	}
	else
		CHECK;
/* Build window hierarchy. */
	if (winh(display, depth, WINH_MAP)) {
		report("Could not build window hierarchy");
		return;
	}
	else
		CHECK;
/* Set window A to a non-root window. */
	Aroot = guardian;
	A = Aroot->firstchild->firstchild->firstchild;
/* Set P to root window. */
	P = guardian;
/* Move pointer to P. */
	if (warppointer(display, P->window, 0, 0) == (PointerPlace *) NULL)
		return;
	else
		CHECK;
	for (i = 0; i < NELEM(focuses); i++) {
/* Set input focus to A. */
		XSetInputFocus(display, A->window, RevertToNone, CurrentTime);
/* Select for Focus events on windows. */
		if (winh_selectinput(display, (Winh *) NULL, MASK)) {
			report("Could not select for events");
			return;
		}
		else
			CHECK;
		good.type = EVENT;
		good.xany.display = display;
		if (winh_climb(A, Aroot, plant)) {
			report("Could not plant events");
			return;
		}
		else
			CHECK;
/* Generate xname event by changing focus from A to PointerRoot. */
		XSync(display, True);
		XSetInputFocus(display, focuses[i], RevertToNone, CurrentTime);
		XSync(display, False);
		if (winh_harvest(display, (Winh *) NULL)) {
			report("Could not harvest events");
			return;
		}
		else
			CHECK;
/* Verify that the expected events were delivered. */
		if (winh_ignore_event((Winh *) NULL, OTHEREVENT, WINH_NOMASK)) {
			delete("Could not ignore %s events", eventname(OTHEREVENT));
			return;
		}
		else
			CHECK;
		status = winh_weed((Winh *) NULL, -1, WINH_WEED_IDENTITY);
		if (status < 0)
			return;
		else if (status > 0) {
			report("Event delivery was not as expected");
			FAIL;
		}
		else {
/* Verify that event delivered on window A */
/* with detail set to NotifyNonlinear. */
			_detail_ = NotifyNonlinear;
			if (winh_climb(A, A, checkdetail))
				FAIL;
			else
				CHECK;
/* Verify that event delivered on each window above window A up to */
/* and including its root, */
/* with detail set to NotifyNonlinearVirtual. */
			_detail_ = NotifyNonlinearVirtual;
			if (winh_climb(A->parent, Aroot, checkdetail))
				FAIL;
			else
				CHECK;
/* Verify that these events occurred in the correct order. */
			increasing = False;
			if (winh_climb(A, Aroot, checksequence))
				FAIL;
			else
				CHECK;
/* Verify that all xname events are delivered before all */
/* FocusIn events. */
			status = winh_ordercheck(EVENT, OTHEREVENT);
			if (status == -1)
				return;
			else if (status)
				FAIL;
			else
				CHECK;
		}
/* Repeat with final focus set to None. */
	}
	CHECKPASS(3 + (8*NELEM(focuses)));
>>ASSERTION def
>>#NOTE	The approved wording was as follows:
>>#NOTE
>>#NOTE	When the focus moves from
>>#NOTE	.S PointerRoot
>>#NOTE	(events sent to the window under the pointer)
>>#NOTE	or
>>#NOTE	.S None
>>#NOTE	(discard)
>>#NOTE	to window A
>>#NOTE	and the pointer is in window P
>>#NOTE	and the old focus was
>>#NOTE	.S PointerRoot ,
>>#NOTE	then a xname event is generated on
>>#NOTE	each window from window P up to and including window P's root,
>>#NOTE	with
>>#NOTE	.M detail
>>#NOTE	set to
>>#NOTE	.S NotifyPointer .
>>#NOTE	Tested for in next assertion.
When the focus moves from
.S PointerRoot
(events sent to the window under the pointer)
to window A
and the pointer is in window P,
then a xname event is generated on
each window from window P up to and including window P's root,
with
.M detail
set to
.S NotifyPointer .
>>ASSERTION Good A
When the focus moves from
.S PointerRoot
(events sent to the window under the pointer)
to window A
and the pointer is in window P,
then, after any related xname events are generated
with
.M detail
set to
.S NotifyPointer ,
a xname event is generated on
the root window of all screens,
with
.M detail
set to
.S NotifyPointerRoot .
>>STRATEGY
Create client.
Build window hierarchy on all supported screens.
Set window A.
Set window P.
Move pointer to window P.
Set input focus to PointerRoot.
Select for Focus events on windows.
Generate xname event by changing focus from PointerRoot to A.
Verify that the expected events were delivered.
Verify that event delivered to windows above window P
up to and including window P's root,
with detail set to NotifyPointer.
Verify that event delivered to the root window of all screens
with detail set to NotifyPointerRoot.
Verify that these events are delivered after the NotifyPointer events.
Verify order of xname event delivery from P to Proot.
Verify that all xname events are delivered before all
FocusIn events.
>>CODE
Display	*display;
int	depth = 4;
Winh	*A, *P, *Proot, *root;
int	status;

/* Create client. */
	if ((display = opendisplay()) == (Display *) NULL) {
		delete("Couldn't create client.");
		return;
	}
	else
		CHECK;
/* Build window hierarchy on all supported screens. */
	if (winh(display, depth, WINH_MAP|WINH_BOTH_SCREENS)) {
		report("Could not build window hierarchy");
		return;
	}
	else
		CHECK;
/* Set window A. */
	A = guardian->firstchild->firstchild->firstchild;
/* Set window P. */
	Proot = guardian;
	P = Proot->firstchild->nextsibling->firstchild->firstchild;
/* Move pointer to window P. */
	if (warppointer(display, P->window, 0, 0) == (PointerPlace *) NULL)
		return;
	else
		CHECK;
/* Set input focus to PointerRoot. */
	XSetInputFocus(display, PointerRoot, RevertToNone, CurrentTime);
/* Select for Focus events on windows. */
	_event_mask_ = MASK;
	_display_ = display;
	if (winh_selectinput(display, (Winh *) NULL, MASK)) {
		report("Could not select for events");
		return;
	}
	else
		CHECK;
	good.type = EVENT;
	good.xany.display = display;
	if (winh_climb(P, Proot, plant)) {
		report("Could not plant events");
		return;
	}
	else
		CHECK;
	/* root window of all screens */
	for (root = guardian; root != (Winh *) NULL; root = root->nextsibling) {
		if (root == guardian)
			CHECK;
		good.xany.window = root->window;
		if (winh_plant(root, &good, MASK, WINH_NOMASK)) {
			report("Could not plant events");
			return;
		}
	}
/* Generate xname event by changing focus from PointerRoot to A. */
	XSync(display, True);
	XSetInputFocus(display, A->window, RevertToNone, CurrentTime);
	XSync(display, False);
	if (winh_harvest(display, (Winh *) NULL)) {
		report("Could not harvest events");
		return;
	}
	else
		CHECK;
/* Verify that the expected events were delivered. */
	if (winh_ignore_event((Winh *) NULL, OTHEREVENT, WINH_NOMASK)) {
		delete("Could not ignore %s events", eventname(OTHEREVENT));
		return;
	}
	else
		CHECK;
	status = winh_weed((Winh *) NULL, -1, WINH_WEED_IDENTITY);
	if (status < 0)
		return;
	else if (status > 0) {
		report("Event delivery was not as expected");
		FAIL;
	}
	else {
		Winhe	*winhe;

/* Verify that event delivered to windows above window P */
/* up to and including window P's root, */
/* with detail set to NotifyPointer. */
		_detail_ = NotifyPointer;
		if (winh_climb(P, Proot, checkdetail)) {
			report("Incorrect detail from P up to P's root");
			FAIL;
		}
		else
			CHECK;
		/*
		 * Determine sequence number of first FocusOut event
		 * delivered to Proot.
		 */
		for (winhe = Proot->delivered; winhe != (Winhe *) NULL; winhe = winhe->next) {

			if (winhe == Proot->delivered)
				CHECK;
			if (winhe->event->type == EVENT)
				break;
		}
/* Verify that event delivered to the root window of all screens */
/* with detail set to NotifyPointerRoot. */
/* Verify that these events are delivered after the NotifyPointer events. */
		_detail_ = NotifyPointerRoot;
		for (root = guardian; root != (Winh *) NULL; root = root->nextsibling) {
			Winhe	*ptr;

			if (root == guardian)
				CHECK;
			/*
			 * skip to first FocusOut-type event
			 */
			for (ptr = root->delivered; ptr != (Winhe *) NULL; ptr = ptr->next) {
				if (ptr->event->type == EVENT) {
					static	int	first = 1;

					/*
					 * The first FocusOut event on Proot is
					 * already claimed.
					 */
					if (root == Proot && first) {
						first = 0;
						continue;
					}
					else
						break;
				}
			}
			if (ptr == (Winhe *) NULL) {
				delete("Lost %s event in delivered list",
					eventname(EVENT));
				return;
			}
			if (ptr->event->xfocus.detail != _detail_) {
				report("Got detail %d, expected %d on window 0x%x",
					ptr->event->xfocus.detail,
					_detail_, root->window);
				FAIL;
				continue;
			}
			if (ptr->sequence < winhe->sequence) {
				report("Got NotifyPointerRoot-type event on 0x%x prior to all NotifyPointer events", root->window);
				FAIL;
			}
		}
/* Verify order of xname event delivery from P to Proot. */
		increasing = False;
		if (winh_climb(P, Proot, checksequence))
			FAIL;
		else
			CHECK;
/* Verify that all xname events are delivered before all */
/* FocusIn events. */
		status = winh_ordercheck(EVENT, OTHEREVENT);
		if (status == -1)
			return;
		else if (status)
			FAIL;
		else
			CHECK;
	}
	CHECKPASS(13);
>>ASSERTION Good A
>>#NOTE
>>#NOTE The approved form of this assertion is listed below:
>>#NOTE
>>#NOTE	When the focus moves from
>>#NOTE	.S None
>>#NOTE	(discard)
>>#NOTE	to window A
>>#NOTE	and the pointer is in window P,
>>#NOTE	then, after any related xname events are generated
>>#NOTE	with
>>#NOTE	.M detail
>>#NOTE	set to
>>#NOTE	.S NotifyPointer ,
>>#NOTE	a xname event is generated on
>>#NOTE	the root windows of all screens,
>>#NOTE	with
>>#NOTE	.M detail
>>#NOTE	set to
>>#NOTE	.S NotifyDetailNone .
When the focus moves from
.S None
(discard)
to window A
and the pointer is in window P,
then a xname event is generated on
the root window of all screens,
with
.M detail
set to
.S NotifyDetailNone .
>>STRATEGY
Create client.
Build window hierarchy on all supported screens.
Set window P.
Move pointer to window P.
Set input focus to PointerRoot.
Select for Focus events on windows.
Generate xname event by changing focus from PointerRoot to None.
Verify that the expected events were delivered.
Verify that event delivered to windows above window P
up to and including window P's root,
with detail set to NotifyPointer.
Verify that event delivered to the root window of all screens
with detail set to NotifyPointerRoot.
Verify that these events are delivered after the NotifyPointer events.
Verify order of xname event delivery from P to Proot.
Verify that all xname events are delivered before all
FocusIn events.
>>CODE
Display	*display;
int	depth = 4;
Winh	*P, *Proot, *root;
int	status;

/* Create client. */
	if ((display = opendisplay()) == (Display *) NULL) {
		delete("Couldn't create client.");
		return;
	}
	else
		CHECK;
/* Build window hierarchy on all supported screens. */
	if (winh(display, depth, WINH_MAP|WINH_BOTH_SCREENS)) {
		report("Could not build window hierarchy");
		return;
	}
	else
		CHECK;
/* Set window P. */
	Proot = guardian;
	P = Proot->firstchild->nextsibling->firstchild->firstchild;
/* Move pointer to window P. */
	if (warppointer(display, P->window, 0, 0) == (PointerPlace *) NULL)
		return;
	else
		CHECK;
/* Set input focus to PointerRoot. */
	XSetInputFocus(display, PointerRoot, RevertToNone, CurrentTime);
/* Select for Focus events on windows. */
	_event_mask_ = MASK;
	_display_ = display;
	if (winh_selectinput(display, (Winh *) NULL, MASK)) {
		report("Could not select for events");
		return;
	}
	else
		CHECK;
	good.type = EVENT;
	good.xany.display = display;
	if (winh_climb(P, Proot, plant)) {
		report("Could not plant events");
		return;
	}
	else
		CHECK;
	/* root window of all screens */
	for (root = guardian; root != (Winh *) NULL; root = root->nextsibling) {
		if (root == guardian)
			CHECK;
		good.xany.window = root->window;
		if (winh_plant(root, &good, MASK, WINH_NOMASK)) {
			report("Could not plant events");
			return;
		}
	}
/* Generate xname event by changing focus from PointerRoot to None. */
	XSync(display, True);
	XSetInputFocus(display, None, RevertToNone, CurrentTime);
	XSync(display, False);
	if (winh_harvest(display, (Winh *) NULL)) {
		report("Could not harvest events");
		return;
	}
	else
		CHECK;
/* Verify that the expected events were delivered. */
	if (winh_ignore_event((Winh *) NULL, OTHEREVENT, WINH_NOMASK)) {
		delete("Could not ignore %s events", eventname(OTHEREVENT));
		return;
	}
	else
		CHECK;
	status = winh_weed((Winh *) NULL, -1, WINH_WEED_IDENTITY);
	if (status < 0)
		return;
	else if (status > 0) {
		report("Event delivery was not as expected");
		FAIL;
	}
	else {
		Winhe	*winhe;

/* Verify that event delivered to windows above window P */
/* up to and including window P's root, */
/* with detail set to NotifyPointer. */
		_detail_ = NotifyPointer;
		if (winh_climb(P, Proot, checkdetail)) {
			report("Incorrect detail from P up to P's root");
			FAIL;
		}
		else
			CHECK;
		/*
		 * Determine sequence number of first FocusOut event
		 * delivered to Proot.
		 */
		for (winhe = Proot->delivered; winhe != (Winhe *) NULL; winhe = winhe->next) {

			if (winhe == Proot->delivered)
				CHECK;
			if (winhe->event->type == EVENT)
				break;
		}
/* Verify that event delivered to the root window of all screens */
/* with detail set to NotifyPointerRoot. */
/* Verify that these events are delivered after the NotifyPointer events. */
		_detail_ = NotifyPointerRoot;
		for (root = guardian; root != (Winh *) NULL; root = root->nextsibling) {
			Winhe	*ptr;

			if (root == guardian)
				CHECK;
			/*
			 * skip to first FocusOut-type event
			 */
			for (ptr = root->delivered; ptr != (Winhe *) NULL; ptr = ptr->next) {
				if (ptr->event->type == EVENT) {
					static	int	first = 1;

					/*
					 * The first FocusOut event on Proot is
					 * already claimed.
					 */
					if (root == Proot && first) {
						first = 0;
						continue;
					}
					else
						break;
				}
			}
			if (ptr == (Winhe *) NULL) {
				delete("Lost %s event in delivered list",
					eventname(EVENT));
				return;
			}
			if (ptr->event->xfocus.detail != _detail_) {
				report("Got detail %d, expected %d on window 0x%x",
					ptr->event->xfocus.detail,
					_detail_, root->window);
				FAIL;
				continue;
			}
			if (ptr->sequence < winhe->sequence) {
				report("Got NotifyPointerRoot-type event on 0x%x prior to all NotifyPointer events", root->window);
				FAIL;
			}
		}
/* Verify order of xname event delivery from P to Proot. */
		increasing = False;
		if (winh_climb(P, Proot, checksequence))
			FAIL;
		else
			CHECK;
/* Verify that all xname events are delivered before all */
/* FocusIn events. */
		status = winh_ordercheck(EVENT, OTHEREVENT);
		if (status == -1)
			return;
		else if (status)
			FAIL;
		else
			CHECK;
	}
	CHECKPASS(13);
>>ASSERTION Good A
>>#NOTE The approved wording for this assertion is listed below:
>>#NOTE
>>#NOTE	When the focus moves from
>>#NOTE	None to PointerRoot
>>#NOTE	and the pointer is in window P,
>>#NOTE	then, after any related xname events are generated
>>#NOTE	with
>>#NOTE	.M detail
>>#NOTE	set to
>>#NOTE	.S NotifyPointer ,
>>#NOTE	a xname event is generated on
>>#NOTE	the root windows of all screens,
>>#NOTE	with
>>#NOTE	.M detail
>>#NOTE	set to
>>#NOTE	.S NotifyDetailNone .
When the focus moves from
None to PointerRoot
and the pointer is in window P,
then a xname event is generated on
the root window of all screens,
with
.M detail
set to
.S NotifyDetailNone .
>>STRATEGY
Create client.
Build window hierarchy on all supported screens.
Move pointer to known location.
Set input focus to None.
Select for Focus events on windows.
Generate xname event by changing focus from None to PointerRoot.
Verify that the expected events were delivered.
Verify that event delivered to the root window of all screens
with detail set to NotifyDetailNone.
Verify that all xname events are delivered before all
FocusIn events.
>>CODE
Display	*display;
int	depth = 1;
Winh	*root;
int	status;

/* Create client. */
	if ((display = opendisplay()) == (Display *) NULL) {
		delete("Couldn't create client.");
		return;
	}
	else
		CHECK;
/* Build window hierarchy on all supported screens. */
	if (winh(display, depth, WINH_MAP|WINH_BOTH_SCREENS)) {
		report("Could not build window hierarchy");
		return;
	}
	else
		CHECK;
/* Move pointer to known location. */
	if (warppointer(display, DRW(display), 0, 0) == (PointerPlace *) NULL)
		return;
	else
		CHECK;
/* Set input focus to None. */
	XSetInputFocus(display, None, RevertToNone, CurrentTime);
/* Select for Focus events on windows. */
	_event_mask_ = MASK;
	_display_ = display;
	if (winh_selectinput(display, (Winh *) NULL, MASK)) {
		report("Could not select for events");
		return;
	}
	else
		CHECK;
	good.type = EVENT;
	good.xany.display = display;
	/* root window of all screens */
	for (root = guardian; root != (Winh *) NULL; root = root->nextsibling) {
		if (root == guardian)
			CHECK;
		good.xany.window = root->window;
		if (winh_plant(root, &good, MASK, WINH_NOMASK)) {
			report("Could not plant events");
			return;
		}
	}
/* Generate xname event by changing focus from None to PointerRoot. */
	XSync(display, True);
	XSetInputFocus(display, PointerRoot, RevertToNone, CurrentTime);
	XSync(display, False);
	if (winh_harvest(display, (Winh *) NULL)) {
		report("Could not harvest events");
		return;
	}
	else
		CHECK;
/* Verify that the expected events were delivered. */
	if (winh_ignore_event((Winh *) NULL, OTHEREVENT, WINH_NOMASK)) {
		delete("Could not ignore %s events", eventname(OTHEREVENT));
		return;
	}
	else
		CHECK;
	status = winh_weed((Winh *) NULL, -1, WINH_WEED_IDENTITY);
	if (status < 0)
		return;
	else if (status > 0) {
		report("Event delivery was not as expected");
		FAIL;
	}
	else {
/* Verify that event delivered to the root window of all screens */
/* with detail set to NotifyDetailNone. */
		_detail_ = NotifyDetailNone;
		for (root = guardian; root != (Winh *) NULL; root = root->nextsibling) {
			Winhe	*ptr;

			if (root == guardian)
				CHECK;
			/*
			 * skip to first FocusOut-type event
			 */
			for (ptr = root->delivered; ptr != (Winhe *) NULL; ptr = ptr->next) {
				if (ptr->event->type == EVENT)
						break;
			}
			if (ptr == (Winhe *) NULL) {
				delete("Lost %s event in delivered list",
					eventname(EVENT));
				return;
			}
			if (ptr->event->xfocus.detail != _detail_) {
				report("Got detail %d, expected %d on window 0x%x",
					ptr->event->xfocus.detail,
					_detail_, root->window);
				FAIL;
				continue;
			}
		}
/* Verify that all xname events are delivered before all */
/* FocusIn events. */
		status = winh_ordercheck(EVENT, OTHEREVENT);
		if (status == -1)
			return;
		else if (status)
			FAIL;
		else
			CHECK;
	}
	CHECKPASS(9);
