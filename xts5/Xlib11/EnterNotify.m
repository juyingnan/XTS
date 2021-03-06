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
>># File: xts5/Xlib11/EnterNotify.m
>># 
>># Description:
>># 	Tests for EnterNotify()
>># 
>># Modifications:
>># $Log: entrntfy.m,v $
>># Revision 1.2  2005-11-03 08:42:27  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:16  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:31:12  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:50:43  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:22:53  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:19:26  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:01:15  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  00:57:55  andy
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
>>TITLE EnterNotify Xlib11
>>EXTERN
#define	EVENT		EnterNotify
#define	OTHEREVENT	LeaveNotify
#define	MASK		EnterWindowMask
#define	OTHERMASK	LeaveWindowMask
#define	BOTHMASKS	(MASK|OTHERMASK)
#define EVENTMASK	MASK
#define	OTHEREVENTMASK	LeaveWindowMask

static	int	_detail_;
static	XEvent	good;

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
	if (_detail_ != d->event->xcrossing.detail) {
		report("Expected detail of %d, got %d on window 0x%x",
			_detail_, d->event->xcrossing.detail, current->window);
		return(1);
	}
	return(0);
}
>>ASSERTION Good A
>>#NOTE
>>#NOTE Hierarchy events are:
>>#NOTE 	UnmapNotify,
>>#NOTE 	MapNotify,
>>#NOTE 	ConfigureNotify,
>>#NOTE 	GravityNotify, and
>>#NOTE 	CirculateNotify.
>>#NOTE
When an xname event is generated by a hierarchy change,
then the xname event is delivered after any hierarchy event.
>>STRATEGY
Create client2.
Create window1.
Create window2 on top of window1.
Select for xname events on window1.
Select for xname events on window1 with client2.
Select for UnmapNotify events on window2.
Move pointer to window2.
Call XUnmapWindow on window2.
Verify that UnmapNotify event was received on window2.
Verify that xname event was received on window1.
Verify that xname event was received on window1 by client2.
Verify that pointer has remained where it was moved.
>>CODE
int	i;
Display	*display = Dsp;
Display	*client2;
Window	w1, w2;
XEvent	event;
struct area	area;
PointerPlace	*warp;

/* Create client2. */
	if ((client2 = opendisplay()) == (Display *) NULL) {
		delete("Couldn't create client2.");
		return;
	}
	else
		CHECK;
/* Create window1. */
	area.x = 0;
	area.y = 0;
	area.width = W_STDWIDTH;
	area.height = W_STDHEIGHT;
	w1 = mkwin(display, (XVisualInfo *) NULL, &area, True);
/* Create window2 on top of window1. */
	w2 = mkwin(display, (XVisualInfo *) NULL, &area, True);
/* Select for xname events on window1. */
	XSelectInput(display, w1, MASK);
/* Select for xname events on window1 with client2. */
	XSelectInput(client2, w1, MASK);
/* Select for UnmapNotify events on window2. */
	XSelectInput(display, w2, StructureNotifyMask);
/* Move pointer to window2. */
	warp = warppointer(display, w2, 0, 0);
	if (warp == (PointerPlace *) NULL)
		return;
	else
		CHECK;
	XSync(display, True);
	XSync(client2, True);
/* Call XUnmapWindow on window2. */
	XUnmapWindow(display, w2);
	XSync(display, False);
	XSync(client2, False);
/* Verify that UnmapNotify event was received on window2. */
	if (XPending(display) < 1) {
		report("Expected UnmapNotify event not delivered.");
		FAIL;
		return;
	}
	else
		CHECK;
	XNextEvent(display, &event);
	if (event.type != UnmapNotify) {
		report("Expected %s, got %s", eventname(UnmapNotify), eventname(event.type));
		FAIL;
	}
	else
		CHECK;
/* Verify that xname event was received on window1. */
	if (XPending(display) < 1) {
		report("Expected %s event not delivered.", TestName);
		FAIL;
		return;
	}
	else
		CHECK;
	XNextEvent(display, &event);
	if (event.type != EVENT) {
		report("Expected %s, got %s", eventname(EVENT), eventname(event.type));
		FAIL;
	}
	else
		CHECK;
	if ((i = XPending(display)) > 0) {
		report("Expected 2 events, got %d", i+2);
		FAIL;
	}
	else
		CHECK;
/* Verify that xname event was received on window1 by client2. */
	if (XPending(client2) < 1) {
		report("Expected %s event not delivered to client2.", TestName);
		FAIL;
		return;
	}
	else
		CHECK;
	XNextEvent(client2, &event);
	if (event.type != EVENT) {
		report("Expected %s, got %s with client2", eventname(EVENT), eventname(event.type));
		FAIL;
	}
	else
		CHECK;
	if ((i = XPending(client2)) > 0) {
		report("For client2: Expected 1 event, got %d", i+1);
		FAIL;
	}
	else
		CHECK;

	/* Additional possible testing: */
	/* Select for no events on window1. */
	/* Select for MapNotify events on window2. */
	/* Select for xname events on window2. */
	/* Select for xname events on window2 with client2. */
	/* Call XMapWindow on window2. */
	/* Verify that MapNotify event was received on window2. */
	/* Verify that xname event was received on window2. */
	/* Verify that xname event was received on window2 by client2. */
	/* Verify that pointer has remained where it was moved. */
	/* Select for xname events on window1. */
	/* Select for xname events on window1 with client2. */
	/* Select for ConfigureNotify events on window2. */
	/* Call XLowerWindow on window2. */
	/* Verify that ConfigureNotify event was received on window2. */
	/* Verify that xname event was received on window1. */
	/* Verify that xname event was received on window1 by client2. */
	/* Verify that pointer has remained where it was moved. */

	/* Others: GravityNotify, CirculateNotify. */

/* Verify that pointer has remained where it was moved. */
	if (pointermoved(display, warp)) {
		delete("Pointer moved unexpectedly");
		return;
	}
	else
		CHECK;
	CHECKPASS(11);
>>#NOTEd >>ASSERTION
>>#NOTEd When the window which contains the pointer changes,
>>#NOTEd then ARTICLE xname event is generated.
>>#NOTEm >>ASSERTION
>>#NOTEm When a client calls
>>#NOTEm .F XGrabPointer
>>#NOTEm or
>>#NOTEm .F XUngrabPointer ,
>>#NOTEm then ARTICLE xname event is generated.
>>ASSERTION def
>>#NOTE	Checked in previous test.
When an xname event is generated,
then
all clients having set
.S EnterWindowMask
event mask bits on the event window are delivered
an xname event.
>>ASSERTION Good A
>>#NOTE True for most events (except MappingNotify and selection stuff).
When an xname event is generated,
then
clients not having set
.S EnterWindowMask
event mask bits on the event window are not delivered
an xname event.
>>STRATEGY
Create client2.
Create window.
Move pointer outside of window.
Select for xname events on window.
Select for no events on window with client2.
Warp pointer to window.
Verify that a single xname event was received.
Verify that no events were received by client2.
>>CODE
int	i;
Display	*display = Dsp;
Display	*client2;
Window	w;
XEvent	event;
XEvent	good;
struct	area	area;
PointerPlace	*warp1, *warp2;

/* Create client2. */
	if ((client2 = opendisplay()) == (Display *) NULL) {
		delete("Couldn't create client2.");
		return;
	}
	else
		CHECK;
/* Create window. */
	area.x = 10;
	area.y = 10;
	area.width = W_STDWIDTH;
	area.height = W_STDHEIGHT;
	w = mkwin(display, (XVisualInfo *) NULL, &area, True);
/* Move pointer outside of window. */
	warp1 = warppointer(display, DRW(display), 0, 0);
	if (warp1 == (PointerPlace *) NULL)
		return;
	else
		CHECK;
/* Select for xname events on window. */
	XSelectInput(display, w, MASK);
/* Select for no events on window with client2. */
	XSelectInput(client2, w, NoEventMask);
/* Warp pointer to window. */
	XSync(display, True);
	XSync(client2, True);
	warp2 = warppointer(display, w, 2, 3);
	if (warp2 == (PointerPlace *) NULL)
		return;
	else
		CHECK;
	XSync(display, False);
	XSync(client2, False);
/* Verify that a single xname event was received. */
	if (XPending(display) < 1) {
		report("Expected %s event not delivered.", TestName);
		FAIL;
		return;
	}
	else
		CHECK;
	XNextEvent(display, &event);
	good.xcrossing.type = EVENT;
	good.xcrossing.serial = event.xcrossing.serial;
	good.xcrossing.send_event = False;
	good.xcrossing.display = display;
	good.xcrossing.window = w;
	good.xcrossing.root = DRW(display);
	good.xcrossing.subwindow = None;
	good.xcrossing.time = event.xcrossing.time;
	good.xcrossing.x = 2;
	good.xcrossing.y = 3;
	ROOTCOORDSET(display, &(good.xcrossing));	/* x_root and y_root */
	good.xcrossing.mode = NotifyNormal;
	/* under virtual root windows detail gets set to NotifyNonlinear */
	good.xcrossing.detail = NotifyAncestor;
	good.xcrossing.same_screen = True;
	good.xcrossing.focus = True;	/* assumes focus follows pointer */
	good.xcrossing.state = 0;
	if (checkevent(&good, &event)) {
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
/* Verify that no events were received by client2. */
	if ((i = XPending(client2)) > 0) {
		report("For client2: Expected 0 events, got %d", i);
		FAIL;
	}
	else
		CHECK;
	CHECKPASS(7);
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
>>#NOTEs When ARTICLE xname event is delivered,
>>#NOTEs then
>>#NOTEs .M root
>>#NOTEs is set to the source window's root window.
>>ASSERTION Good A
When an xname event is delivered
and the child of the event window contains the final pointer position,
then
.M subwindow
is set to
that child.
>>STRATEGY
Build window hierarchy.
Create the hierarchy.
Move pointer to outside of window.
Select no events on the sourcew.
Set EnterWindowMask event mask bits on the eventw.
Move pointer to child of event window.
Verify that a xname event was received.
Verify that subwindow is set to the source window.
>>CODE
int	status;
Display	*display = Dsp;
Winh	*eventw;
Winh	*sourcew;
XEvent	good;
Winhg	winhg;
PointerPlace	*warp1, *warp2;

/* Build window hierarchy. */
	winhg.area.x = 1;
	winhg.area.y = 1;
	winhg.area.width = W_STDWIDTH;
	winhg.area.height = W_STDHEIGHT;
	winhg.border_width = 1;
	eventw = winh_adopt(display, (Winh *) NULL, 0L, (XSetWindowAttributes *) NULL, &winhg, WINH_NOMASK);
	if (eventw == (Winh *) NULL) {
		report("Could not create eventw");
		return;
	}
	else
		CHECK;
	winhg.area.width /= 2;
	winhg.area.height /= 2;
	sourcew = winh_adopt(display, eventw, 0L, (XSetWindowAttributes *) NULL, &winhg, WINH_NOMASK);
	if (sourcew == (Winh *) NULL) {
		report("Could not create sourcew");
		return;
	}
	else
		CHECK;
/* Create the hierarchy. */
	if (winh_create(display, (Winh *) NULL, WINH_MAP))
		return;
	else
		CHECK;
/* Move pointer to outside of window. */
	warp1 = warppointer(display, DRW(display), 0, 0);
	if (warp1 == (PointerPlace *) NULL)
		return;
	else
		CHECK;
/* Select no events on the sourcew. */
	if (winh_selectinput(display, sourcew, NoEventMask))
		return;
	else
		CHECK;
/* Set EnterWindowMask event mask bits on the eventw. */
	if (winh_selectinput(display, eventw, MASK))
		return;
	else
		CHECK;
	XSync(display, True);
	good.type = EVENT;
	good.xcrossing.display = display;
	good.xcrossing.window = eventw->window;
	good.xcrossing.subwindow = sourcew->window;
/* Move pointer to child of event window. */
	warp2 = warppointer(display, sourcew->window, 2, 2);
	if (warp2 == (PointerPlace *) NULL)
		return;
	else
		CHECK;
/* Verify that a xname event was received. */
	XSync(display, False);
	if (winh_plant(eventw, &good, NoEventMask, WINH_NOMASK))
		return;
	else
		CHECK;
	if (winh_harvest(display, (Winh *) NULL))
		return;
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
/* Verify that subwindow is set to the source window. */
		/* since only one event was expected, it must be first in list */
		if (eventw->delivered->event->xcrossing.subwindow != sourcew->window) {
			report("Subwindow set to 0x%x, expected 0x%x",
				eventw->delivered->event->xcrossing.subwindow, sourcew->window);
			FAIL;
		}
		else
			CHECK;
	}

	CHECKPASS(10);

>>ASSERTION def
>>#NOTE	Already tested for in a test with only a single window involved.
When an xname event is delivered
and the child of the event window does not contain the final pointer position,
then
.M subwindow
is set to
.S None .
>>#NOTEs >>ASSERTION
>>#NOTEs When ARTICLE xname event is delivered,
>>#NOTEs then
>>#NOTEs .M time
>>#NOTEs is set to
>>#NOTEs the time in milliseconds at which the event was generated.
>>#NOTEs >>ASSERTION
>>#NOTEs When ARTICLE xname event is delivered
>>#NOTEs and the event window is on the same screen as the root window,
>>#NOTEs then
>>#NOTEs .M x
>>#NOTEs and
>>#NOTEs .M y
>>#NOTEs are set to
>>#NOTEs the coordinates of
>>#NOTEs the final pointer position relative to the event window's origin.
>>#REMOVED >>ASSERTION Good C
>>#COMMENT:
>># This assertion was removed April 1992 because
>># an enter notify event is not generated when the root
>># is on the alternate screen (bug report 0234).
>># -stuart.
>>#REMOVED >>#COMMENT:
>>#REMOVED >># Assertion category changed March 1992 since it was found not to require
>>#REMOVED >># device events.
>>#REMOVED >># - Cal.
>>#REMOVED If multiple screens are supported:
>>#REMOVED When an xname event is delivered
>>#REMOVED and the event and root windows are not on the same screen,
>>#REMOVED then
>>#REMOVED .M x
>>#REMOVED and
>>#REMOVED .M y
>>#REMOVED are set to
>>#REMOVED zero.
>>#REMOVED >>STRATEGY
>>#REMOVED If multiple screens are supported:
>>#REMOVED   Create a window on the default screen.
>>#REMOVED   Create a window on the alternate screen.
>>#REMOVED   Warp the pointer into the first window.
>>#REMOVED   Grab the pointer for the first window.
>>#REMOVED   Warp the pointer into the alternate screen window.
>>#REMOVED   Verify that an xname event was generated relative to the grab window.
>>#REMOVED   Verify that the x and y components were set to zero.
>>#REMOVED >>CODE
>>#REMOVED Window		wg;
>>#REMOVED Window		w2;
>>#REMOVED XEvent		ev;
>>#REMOVED int		gr;
>>#REMOVED 
>>#REMOVED 	/* If multiple screens are supported: */
>>#REMOVED 	if (config.alt_screen == -1) {
>>#REMOVED 		unsupported("Multiple screens not supported.");
>>#REMOVED 		return;
>>#REMOVED 	} else
>>#REMOVED 		CHECK;
>>#REMOVED 
>>#REMOVED 			/* Create a window on the default screen. */
>>#REMOVED         wg = defwin(Dsp);
>>#REMOVED 			/* Create a window on the alternate screen. */
>>#REMOVED         w2 = defdraw(Dsp, VI_ALT_WIN);
>>#REMOVED 
>>#REMOVED 			/* Warp the pointer into the first window. */
>>#REMOVED 	warppointer(Dsp, wg, 13, 17);
>>#REMOVED 	XSync(Dsp, True);
>>#REMOVED 
>>#REMOVED 			/* Grab the pointer for the first window. */
>>#REMOVED 	if((gr = XGrabPointer(Dsp, wg, False, EVENTMASK|PointerMotionMask, GrabModeAsync, GrabModeAsync, None, None, CurrentTime)) != GrabSuccess) {
>>#REMOVED 		delete("XGrabPointer() returned %s instead of GrabSuccess.", grabreplyname(gr));
>>#REMOVED 		return;
>>#REMOVED 	} else
>>#REMOVED 		CHECK;
>>#REMOVED 
>>#REMOVED 			/* Warp the pointer into the alternate screen window. */
>>#REMOVED 	XSync(Dsp, True);
>>#REMOVED 	warppointer(Dsp, w2, 7,11);
>>#REMOVED 	XSync(Dsp, False);
>>#REMOVED 
>>#REMOVED 			/* Verify that an xname event was generated relative to the grab window. */
>>#REMOVED 	if (XCheckWindowEvent(Dsp, wg, EVENTMASK, &ev) == False) {
>>#REMOVED 		report("Expected %s event was not received.", eventname(EVENT));
>>#REMOVED 		FAIL;
>>#REMOVED 	} else { 
>>#REMOVED 		CHECK;
>>#REMOVED 
>>#REMOVED 			/* Verify that the x and y components were set to zero. */
>>#REMOVED 		if(ev.xcrossing.x != 0 || ev.xcrossing.y != 0) {
>>#REMOVED 			report("The x (value %d) and y (value %d) components of the %s event were not set to zero.",
>>#REMOVED 				ev.xcrossing.x, ev.xcrossing.y, eventname(EVENT));
>>#REMOVED 			FAIL;
>>#REMOVED 		} else 
>>#REMOVED 			CHECK;
>>#REMOVED 	}
>>#REMOVED 
>>#REMOVED 	XUngrabPointer(Dsp, CurrentTime);
>>#REMOVED 	CHECKPASS(4);
>>#REMOVED 
>>#NOTEs >>ASSERTION
>>#NOTEs When ARTICLE xname event is delivered,
>>#NOTEs then
>>#NOTEs .M x_root
>>#NOTEs and
>>#NOTEs .M y_root
>>#NOTEs are set to coordinates of the pointer
>>#NOTEs when the event was generated
>>#NOTEs relative to the root window's origin.
>>#NOTEm >>ASSERTION
>>#NOTEm >>#NOTE
>>#NOTEm >>#NOTE The spec does not actually state this.  What the spec states is that
>>#NOTEm >>#NOTE things behave as if the pointer moved from the confine-to window to
>>#NOTEm >>#NOTE the grab window, the opposite of what one might expect.
>>#NOTEm >>#NOTE
>>#NOTEm When ARTICLE xname event is generated as the result of a grab activation,
>>#NOTEm then xname event generation occurs as if the pointer moved from
>>#NOTEm the grab window to the confine-to window with
>>#NOTEm .M mode
>>#NOTEm set to
>>#NOTEm .S NotifyGrab .
>>#NOTEm >>ASSERTION
>>#NOTEm >>#NOTE
>>#NOTEm >>#NOTE The spec does not actually state this.  What the spec states is that
>>#NOTEm >>#NOTE things behave as if the pointer moved from the grab window to
>>#NOTEm >>#NOTE the confine-to window, the opposite of what one might expect.
>>#NOTEm >>#NOTE
>>#NOTEm When ARTICLE xname event is generated as the result of a grab deactivation,
>>#NOTEm then xname event generation occurs as if the pointer moved from
>>#NOTEm the confine-to window to the grab window with
>>#NOTEm .M mode
>>#NOTEm set to
>>#NOTEm .S NotifyUngrab .
>>ASSERTION def
All xname events are delivered after
any related
.S LeaveNotify
are delivered.
>>#NOTE
>>#NOTE It would not surprise me in the least if these assertions could
>>#NOTE be simplified and/or reduced in number.
>>#NOTE
>>ASSERTION Good A
When the pointer moves from window A to window B
and A is an inferior of B,
then an xname event is generated on window B with
.M detail
set to
.S NotifyInferior .
>>STRATEGY
Build window hierarchy.
Move pointer to known location.
Set window B.
Set window A to child of window B.
Select for xname and LeaveNotify events on windows A and B.
Move pointer from window A to window B.
Verify xname event received on window B.
Verify that detail is set to NotifyInferior.
Verify that all xname events are delivered after all
LeaveNotify events.
>>CODE
Display	*display = Dsp;
int	depth = 3;
Winh	*A, *B;
int	status;
XEvent	*event;

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
/* Set window A to child of window B. */
	A = B->firstchild;
/* Select for xname and LeaveNotify events on windows A and B. */
	if (winh_selectinput(display, A, BOTHMASKS)) {
		report("Error selecting for events.");
		return;
	}
	else
		CHECK;
	if (winh_selectinput(display, B, BOTHMASKS)) {
		report("Error selecting for events.");
		return;
	}
	else
		CHECK;

/* Move pointer from window A to window B. */
	XWarpPointer(display, None, A->window, 0, 0, 0, 0, 0, 0);
	XSync(display, True);
	XWarpPointer(display, None, B->window, 0, 0, 0, 0, 0, 0);
	XSync(display, False);
	if (winh_harvest(display, (Winh *) NULL)) {
		report("Could not harvest events");
		return;
	}
	else
		CHECK;
/* Verify xname event received on window B. */
	if (B->delivered == (Winhe *) NULL || (event = B->delivered->event)->type != EVENT) {
		report("Expected event not generated");
		FAIL;
	}
	else
	{
/* Verify that detail is set to NotifyInferior. */
		if (event->xcrossing.detail != NotifyInferior) {
			report("Got detail %d, expected %d", event->xcrossing.detail, NotifyInferior);
			FAIL;
		}
		else
			CHECK;
/* Verify that all xname events are delivered after all */
/* LeaveNotify events. */
		status = winh_ordercheck(OTHEREVENT, EVENT);
		if (status == -1)
			return;
		else if (status)
			FAIL;
		else
			CHECK;
	}
	CHECKPASS(7);
>>ASSERTION Good A
When the pointer moves from window A to window B
and B is an inferior of A,
then an xname event is generated once on each window
between window A and window B, exclusive,
in window hierarchy order,
with
.M detail
set to
.S NotifyVirtual
and then on window B with
.M detail
set to
.S NotifyAncestor .
>>STRATEGY
Create client.
Build window hierarchy.
Move pointer to known location.
Set window A.
Set window B to inferior of window A.
Select for xname and LeaveNotify events on all windows.
Move pointer from window A to window B.
Verify events delivered, between window A and window B, exclusive,
in proper order.
Verify that detail is set to NotifyVirtual.
Verify that event delivered to window B with detail set to NotifyAncestor.
Verify that all xname events are delivered after all
LeaveNotify events.
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
/* Set window A. */
	A = guardian->firstchild;
/* Set window B to inferior of window A. */
	B = A->firstchild->firstchild->firstchild;
/* Select for xname and LeaveNotify events on all windows. */
	if (winh_selectinput(display, (Winh *) NULL, BOTHMASKS)) {
		report("Could not select for events");
		return;
	}
	else
		CHECK;
	good.type = EVENT;
	good.xany.display = display;
	if (winh_climb(B, A->firstchild, plant)) {
		report("Could not plant events");
		return;
	}
	else
		CHECK;
/* Move pointer from window A to window B. */
	XWarpPointer(display, None, A->window, 0, 0, 0, 0, 0, 0);
	XSync(display, True);
	XWarpPointer(display, None, B->window, 0, 0, 0, 0, 0, 0);
	XSync(display, False);
	if (winh_harvest(display, (Winh *) NULL)) {
		report("Could not harvest events");
		return;
	}
	else
		CHECK;
	if (winh_ignore_event((Winh *) NULL, OTHEREVENT, WINH_NOMASK))
		return;
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
/* Verify events delivered, between window A and window B, exclusive, */
/* in proper order. */
		increasing = True;
		if (winh_climb(B, A->firstchild, checksequence))
			FAIL;
		else
			CHECK;
/* Verify that detail is set to NotifyVirtual. */
		_detail_ = NotifyVirtual;
		if (winh_climb(B->parent, A->firstchild, checkdetail))
			FAIL;
		else
			CHECK;
/* Verify that event delivered to window B with detail set to NotifyAncestor. */
		_detail_ = NotifyAncestor;
		if (winh_climb(B, B, checkdetail))
			FAIL;
		else
			CHECK;
/* Verify that all xname events are delivered after all */
/* LeaveNotify events. */
		status = winh_ordercheck(OTHEREVENT, EVENT);
		if (status == -1)
			return;
		else if (status)
			FAIL;
		else
			CHECK;
	}
	CHECKPASS(11);
>>ASSERTION Good A
When the pointer moves from window A to window B
and there exists a window C that is their least common ancestor,
then an xname event is generated once on each window
between window C and window B, exclusive, with
.M detail
set to
.S NotifyNonlinearVirtual
and then on window B with
.M detail
set to
.S NotifyNonlinear .
>>STRATEGY
Create client.
Build window hierarchy.
Move pointer to known location.
Set windows A, B, and C.
Select for xname and LeaveNotify events on all windows.
Move pointer from window A to window B.
Verify events delivered, between window C and window B, exclusive,
in proper order.
Verify that detail is set to NotifyNonlinearVirtual.
Verify that event delivered to window B with detail set to NotifyNonlinear.
Verify that all xname events are delivered after all
LeaveNotify events.
>>CODE
Display	*display;
int	depth = 5;
Winh	*A, *B, *C;
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
/* Set windows A, B, and C. */
	C = guardian->firstchild;
	A = C->firstchild->nextsibling->firstchild->firstchild;
	B = C->firstchild->             firstchild->firstchild;
/* Select for xname and LeaveNotify events on all windows. */
	if (winh_selectinput(display, (Winh *) NULL, BOTHMASKS)) {
		report("Could not select for events");
		return;
	}
	else
		CHECK;
	good.type = EVENT;
	good.xany.display = display;
	if (winh_climb(B, C->firstchild, plant)) {
		report("Could not plant events");
		return;
	}
	else
		CHECK;
/* Move pointer from window A to window B. */
	XWarpPointer(display, None, A->window, 0, 0, 0, 0, 0, 0);
	XSync(display, True);
	XWarpPointer(display, None, B->window, 0, 0, 0, 0, 0, 0);
	XSync(display, False);
	if (winh_harvest(display, (Winh *) NULL)) {
		report("Could not harvest events");
		return;
	}
	else
		CHECK;
	if (winh_ignore_event((Winh *) NULL, OTHEREVENT, WINH_NOMASK))
		return;
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
/* Verify events delivered, between window C and window B, exclusive, */
/* in proper order. */
		increasing = True;
		if (winh_climb(B, C->firstchild, checksequence))
			FAIL;
		else
			CHECK;
/* Verify that detail is set to NotifyNonlinearVirtual. */
		_detail_ = NotifyNonlinearVirtual;
		if (winh_climb(B->parent, C->firstchild, checkdetail))
			FAIL;
		else
			CHECK;
/* Verify that event delivered to window B with detail set to NotifyNonlinear. */
		_detail_ = NotifyNonlinear;
		if (winh_climb(B, B, checkdetail))
			FAIL;
		else
			CHECK;
/* Verify that all xname events are delivered after all */
/* LeaveNotify events. */
		status = winh_ordercheck(OTHEREVENT, EVENT);
		if (status == -1)
			return;
		else if (status) {
			report("Incorrect event ordering.");
			FAIL;
		}
		else
			CHECK;
	}
	CHECKPASS(11);
>>ASSERTION Good A
If the implementation supports multiple screens:
When the pointer moves from window A to window B
and window A and window B are on different screens
and window B is not a root window,
then an xname event is generated on
each window from window B's root down to but not including window B with
.M detail
set to
.S NotifyNonlinearVirtual
and then on window B with
.M detail
set to
.S NotifyNonlinear .
>>STRATEGY
Check to see if multiple screens are supported.
Build window hierarchy.
Move pointer to known location.
Select for xname and LeaveNotify events between windows B and
B's root window.
Move pointer from window A to window B.
Verify events delivered on each window from window B's root
down to but not including window B in proper order.
Verify that detail is set to NotifyNonlinearVirtual.
Verify that event delivered to window B with detail set to NotifyNonlinear.
Verify that all xname events are delivered after all
LeaveNotify events.
>>CODE
Display	*display;
int	depth = 5;
Winh	*A, *B, *Broot;
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
/* Build window hierarchy. */
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
/* Set windows A and B. */ 
	A = guardian->firstchild;
	Broot = guardian->nextsibling;
	B = Broot->firstchild->firstchild->firstchild;
/* Select for xname and LeaveNotify events on all windows. */
	if (winh_selectinput(display, (Winh *) NULL, BOTHMASKS)) {
		report("Could not select for events");
		return;
	}
	else
		CHECK;
	good.type = EVENT;
	good.xany.display = display;
	if (winh_climb(B, Broot, plant)) {
		report("Could not plant events");
		return;
	}
	else
		CHECK;
/* Move pointer from window A to window B. */
	XWarpPointer(display, None, A->window, 0, 0, 0, 0, 0, 0);
	XSync(display, True);
	XWarpPointer(display, None, B->window, 0, 0, 0, 0, 0, 0);
	XSync(display, False);
	if (winh_harvest(display, (Winh *) NULL)) {
		report("Could not harvest events");
		return;
	}
	else
		CHECK;
	if (winh_ignore_event((Winh *) NULL, OTHEREVENT, WINH_NOMASK))
		return;
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
/* Verify events delivered on each window from window B's root */
/* down to but not including window B in proper order. */
		increasing = True;
		if (winh_climb(B, Broot, checksequence))
			FAIL;
		else
			CHECK;
/* Verify that detail is set to NotifyNonlinearVirtual. */
		_detail_ = NotifyNonlinearVirtual;
		if (winh_climb(B->parent, Broot, checkdetail))
			FAIL;
		else
			CHECK;
/* Verify that event delivered to window B with detail set to NotifyNonlinear. */
		_detail_ = NotifyNonlinear;
		if (winh_climb(B, B, checkdetail))
			FAIL;
		else
			CHECK;
/* Verify that all xname events are delivered after all */
/* LeaveNotify events. */
		status = winh_ordercheck(OTHEREVENT, EVENT);
		if (status == -1)
			return;
		else if (status) {
			report("Incorrect event ordering.");
			FAIL;
		}
		else
			CHECK;
	}
	CHECKPASS(12);
>>ASSERTION def
>>#NOTE	Tested above.
If the implementation supports multiple screens:
When the pointer moves from window A to window B
and window A and window B are on different screens,
then an xname event is generated on window B with
.M detail
set to
.S NotifyNonlinear .
>>#NOTEs >>ASSERTION
>>#NOTEs When ARTICLE xname event is delivered
>>#NOTEs and the event and root windows are on the same screen,
>>#NOTEs then
>>#NOTEs .M same_screen
>>#NOTEs is set to
>>#NOTEs .S True .
>>#REMOVED >>ASSERTION Good C
>>#COMMENT:
>># This assertion was removed April 1992 because
>># an enter notify event is not generated when the root
>># is on the alternate screen (bug report 0234).
>># -stuart.
>>#REMOVED >>#COMMENT:
>>#REMOVED >># Assertion category changed March 1992 since it was found not to require
>>#REMOVED >># device events.
>>#REMOVED >># - Cal.
>>#REMOVED If multiple screens are supported:
>>#REMOVED When an xname event is delivered
>>#REMOVED and the event and root windows are not on the same screen,
>>#REMOVED then
>>#REMOVED .M same_screen
>>#REMOVED is set to
>>#REMOVED .S False .
>>#REMOVED >>STRATEGY
>>#REMOVED If multiple screens are supported:
>>#REMOVED   Create a window on the default screen.
>>#REMOVED   Create a window on the alternate screen.
>>#REMOVED   Warp the pointer into the first window.
>>#REMOVED   Grab the pointer for the first window.
>>#REMOVED   Warp the pointer into the alternate screen window.
>>#REMOVED   Verify that an xname event was generated relative to the grab window.
>>#REMOVED   Verify that the same_screen component was False.
>>#REMOVED >>CODE
>>#REMOVED Window		wg;
>>#REMOVED Window		w2;
>>#REMOVED XEvent		ev;
>>#REMOVED int		gr;
>>#REMOVED 
>>#REMOVED 
>>#REMOVED 	/* If multiple screens are supported: */
>>#REMOVED 	if (config.alt_screen == -1) {
>>#REMOVED 		unsupported("Multiple screens not supported.");
>>#REMOVED 		return;
>>#REMOVED 	} else
>>#REMOVED 		CHECK;
>>#REMOVED 
>>#REMOVED 			/* Create a window on the default screen. */
>>#REMOVED         wg = defwin(Dsp);
>>#REMOVED 			/* Create a window on the alternate screen. */
>>#REMOVED         w2 = defdraw(Dsp, VI_ALT_WIN);
>>#REMOVED 
>>#REMOVED 			/* Warp the pointer into the first window. */
>>#REMOVED 	warppointer(Dsp, wg, 13, 17);
>>#REMOVED 	XSync(Dsp, True);
>>#REMOVED 
>>#REMOVED 			/* Grab the pointer for the first window. */
>>#REMOVED 	if((gr = XGrabPointer(Dsp, wg, False, EVENTMASK|PointerMotionMask, GrabModeAsync, GrabModeAsync, None, None, CurrentTime)) != GrabSuccess) {
>>#REMOVED 		delete("XGrabPointer() returned %s instead of GrabSuccess.", grabreplyname(gr));
>>#REMOVED 		return;
>>#REMOVED 	} else
>>#REMOVED 		CHECK;
>>#REMOVED 
>>#REMOVED 			/* Warp the pointer into the alternate screen window. */
>>#REMOVED 	XSync(Dsp, True);
>>#REMOVED 	warppointer(Dsp, w2, 7,11);
>>#REMOVED 	XSync(Dsp, False);
>>#REMOVED 
>>#REMOVED 			/* Verify that an xname event was generated relative to the grab window. */
>>#REMOVED 	if (XCheckWindowEvent(Dsp, wg, EVENTMASK, &ev) == False) {
>>#REMOVED 		report("Expected %s event was not received.", eventname(EVENT));
>>#REMOVED 		FAIL;
>>#REMOVED 	} else { 
>>#REMOVED 
>>#REMOVED 		CHECK;
>>#REMOVED 			/* Verify that the same_screen component was False. */
>>#REMOVED 		if(ev.xcrossing.same_screen != False) {
>>#REMOVED 			report("The same_screen component of the %s event was not set to False.", eventname(EVENT));
>>#REMOVED 			FAIL;
>>#REMOVED 		} else 
>>#REMOVED 			CHECK;
>>#REMOVED 	}
>>#REMOVED 
>>#REMOVED 	XUngrabPointer(Dsp, CurrentTime);
>>#REMOVED 	CHECKPASS(4);
>>#REMOVED 
>>ASSERTION Good A
When an xname event is delivered
and the event window is the focus window,
then
.M focus
is set to
.S True .
>>STRATEGY
Build window hierarchy.
Set input focus to eventw.
Move pointer to known location.
Select xname events on the eventw.
Call XWarpPointer to move the pointer to eventw.
Verify event was delivered with focus set to True.
Move pointer back to known location.
Clear event expectations.
Set input focus to known window.
Call XWarpPointer to move the pointer to eventw.
Verify event was delivered with focus set to False.
>>CODE
Display	*display = Dsp;
Winh	*eventw;
int	status;

/* Build window hierarchy. */
	if (winh(display, 1, WINH_MAP)) {
		report("Could not build window hierarchy");
		return;
	}
	else
		CHECK;
	eventw = guardian->firstchild;
/* Set input focus to eventw. */
	XSetInputFocus(display, eventw->window, RevertToPointerRoot, CurrentTime);
/* Move pointer to known location. */
	if (warppointer(display, DRW(display), 0, 0) == (PointerPlace *) NULL)
		return;
	else
		CHECK;
/* Select xname events on the eventw. */
	if (winh_selectinput(display, eventw, MASK))
		return;
	else
		CHECK;
/* Call XWarpPointer to move the pointer to eventw. */
	XSync(display, True);
	XWarpPointer(display, None, eventw->window, 0, 0, 0, 0, 0, 0);
	XSync(display, False);
/* Verify event was delivered with focus set to True. */
	good.type = EVENT;
	good.xany.display = display;
	good.xany.window = eventw->window;
	if (winh_plant(eventw, &good, NoEventMask, WINH_NOMASK)) {
		report("Could not initialize for event delivery");
		return;
	}
	else
		CHECK;
	if (winh_harvest(display, (Winh *) NULL)) {
		report("Could not harvest events");
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
		if (eventw->delivered->event->xcrossing.focus != True) {
			report("Focus set to %d, expected %d",
				eventw->delivered->event->xcrossing.focus,True);
			FAIL;
		}
		else
			CHECK;
	}
/* Move pointer back to known location. */
	XWarpPointer(display, None, DRW(display), 0, 0, 0, 0, 0, 0);
/* Set input focus to known window. */
	XSetInputFocus(display, eventw->nextsibling->window, RevertToPointerRoot, CurrentTime);
/* Call XWarpPointer to move the pointer to eventw. */
	XSync(display, True);
	XWarpPointer(display, None, eventw->window, 0, 0, 0, 0, 0, 0);
	XSync(display, False);
/* Verify event was delivered with focus set to False. */
	if (winh_plant(eventw, &good, NoEventMask, WINH_NOMASK)) {
		report("Could not initialize for event delivery");
		return;
	}
	else
		CHECK;
	if (winh_harvest(display, (Winh *) NULL)) {
		report("Could not harvest events");
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
		if (eventw->delivered->event->xcrossing.focus != False) {
			report("Focus set to %d, expected %d",
				eventw->delivered->event->xcrossing.focus, False);
			FAIL;
		}
		else
			CHECK;
	}
	CHECKPASS(9);
>>ASSERTION Good A
When an xname event is delivered
and the event window is an inferior of the focus window,
then
.M focus
is set to
.S True .
>>STRATEGY
Build window hierarchy.
Set input focus to ancestor of window eventw.
Move pointer to known location.
Select xname events on the eventw.
Call XWarpPointer to move the pointer to eventw.
Verify event was delivered with focus set to True.
>>CODE
Display	*display = Dsp;
Winh	*eventw, *focusw;
int	status;

/* Build window hierarchy. */
	if (winh(display, 2, WINH_MAP)) {
		report("Could not build window hierarchy");
		return;
	}
	else
		CHECK;
	focusw = guardian->firstchild;
	eventw = guardian->firstchild->firstchild;
/* Set input focus to ancestor of window eventw. */
	XSetInputFocus(display, focusw->window, RevertToPointerRoot, CurrentTime);
/* Move pointer to known location. */
	if (warppointer(display, DRW(display), 0, 0) == (PointerPlace *) NULL)
		return;
	else
		CHECK;
/* Select xname events on the eventw. */
	if (winh_selectinput(display, eventw, MASK))
		return;
	else
		CHECK;
/* Call XWarpPointer to move the pointer to eventw. */
	XSync(display, True);
	XWarpPointer(display, None, eventw->window, 0, 0, 0, 0, 2, 2);
	XSync(display, False);
/* Verify event was delivered with focus set to True. */
	good.type = EVENT;
	good.xany.display = display;
	good.xany.window = eventw->window;
	if (winh_plant(eventw, &good, NoEventMask, WINH_NOMASK)) {
		report("Could not initialize for event delivery");
		return;
	}
	else
		CHECK;
	if (winh_harvest(display, (Winh *) NULL)) {
		report("Could not harvest events");
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
		if (eventw->delivered->event->xcrossing.focus != True) {
			report("Focus set to %d, expected %d",
				eventw->delivered->event->xcrossing.focus, True);
			FAIL;
		}
		else
			CHECK;
	}
	CHECKPASS(6);
>>#NOTEs >>ASSERTION
>>#NOTEs When ARTICLE xname event is delivered
>>#NOTEs and the event window is not the focus window or
>>#NOTEs an inferior of the focus window,
>>#NOTEs then
>>#NOTEs .M focus
>>#NOTEs is set to
>>#NOTEs .S False .
>>#NOTEs >>ASSERTION
>>#NOTEs When ARTICLE xname event is delivered,
>>#NOTEs then
>>#NOTEs .M state
>>#NOTEs is set to
>>#NOTEs indicate the logical state
>>#NOTEs of the pointer buttons,
>>#NOTEs which is the bitwise OR of one or more of
>>#NOTEs the button or modifier key masks
>>#NOTEs .S Button1Mask ,
>>#NOTEs .S Button2Mask ,
>>#NOTEs .S Button3Mask ,
>>#NOTEs .S Button4Mask ,
>>#NOTEs .S Button5Mask ,
>>#NOTEs .S ShiftMask ,
>>#NOTEs .S LockMask ,
>>#NOTEs .S ControlMask ,
>>#NOTEs .S Mod1Mask ,
>>#NOTEs .S Mod2Mask ,
>>#NOTEs .S Mod3Mask ,
>>#NOTEs .S Mod4Mask ,
>>#NOTEs and
>>#NOTEs .S Mod5Mask .
