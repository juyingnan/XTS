Copyright (c) 2005 X.Org Foundation LLC

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
$Header: /cvs/xtest/xtest/xts5/tset/Xlib5/cnvrtslctn/cnvrtslctn.m,v 1.1 2005-02-12 14:37:34 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1995
All Rights Reserved.

>># Project: VSW5
>># 
>># File: vsw5/tset/Xlib5/cnvrtslctn/cnvrtslctn.m
>># 
>># Description:
>># 	Tests for XConvertSelection()
>># 
>># Modifications:
>># $Log: cnvrtslctn.m,v $
>># Revision 1.1  2005-02-12 14:37:34  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:26:43  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:45:00  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:18:57  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:15:28  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.1  1996/05/09 00:34:16  andy
>># Corrected Xatom include
>>#
>># Revision 4.0  1995/12/15  08:48:30  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  00:47:11  andy
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
>>TITLE XConvertSelection Xlib5
void

Display *display = Dsp;
Atom selection = XA_COPYRIGHT;
Atom target = XA_NOTICE;
Atom property = XA_INTEGER;
Window requestor = defwin(display);
Time  thetime = CurrentTime;
>>EXTERN
#include "X11/Xatom.h"
>>ASSERTION Good A
When the specified
.A selection
has an owner, then a call to xname generates a
.S SelectionRequest 
event to the selection owner, with
.A selection ,
.A target ,
.A property ,
.A requestor ,
and
.A time
arguments passed unchanged as event structure members.
>>STRATEGY
Create a new client.
Create a window with a selection which it owns on client2.
Call xname to convert the selection.
Verify that the correct SelectionNotify event was delivered to client2
Verify no events were delivered to client1.
>>CODE
Display *client1, *client2;
Window owner;
int num_ev;
XEvent ev;

/* Create a new client. */
	client1 = display;
	client2 = opendisplay();
	if (client2 == (Display *)NULL) {
		delete("Could not create client2");
		return;
	} else
		CHECK;

/* Create a window with a selection which it owns on client2. */
	owner = defwin(client2);
	XSetSelectionOwner(client2, selection, owner, CurrentTime);
	XSync(client2, True);

/* Call xname to convert the selection. */
	XCALL;
	XSync(client1, False);
	XSync(client2, False);

/* Verify that the correct SelectionNotify event was delivered to client2 */
	num_ev = getevent(client2, &ev);
	if (num_ev != 1) {
		FAIL;
		report("%s did not cause a single SelectionNotify event",
			TestName);
		trace("Received %d events", num_ev);
		while (num_ev > 0) {
			trace("Event %s", eventname(ev.type));
			num_ev = getevent(client2, &ev);
		}
	} else {
		XEvent good;

		good.type = SelectionRequest;
		good.xselectionrequest.type = SelectionRequest;
		good.xselectionrequest.display = client2;
		good.xselectionrequest.owner = owner;
		good.xselectionrequest.requestor = requestor;
		good.xselectionrequest.selection = selection;
		good.xselectionrequest.target = target;
		good.xselectionrequest.property = property; 
		good.xselectionrequest.time	= -1;

		if (checkevent(&good, &ev)) {
			FAIL;
			report("SelectionNotify event was incorrect");
		} else
			CHECK;
	}

/* Verify no events were delivered to client1. */
	num_ev = getevent(client1, &ev);
	if (num_ev != 0) {
		FAIL;
		report("%s generated unexpected events on client1",
			TestName);
		trace("Expected 0 events");
		trace("Received %d events", num_ev);
		do {
			trace("Event: %s", eventname(ev.type));
		} while(getevent(client1, &ev));
	} else
		CHECK;

	CHECKPASS(3);

>>ASSERTION Good A
When the specified
.A selection
has no owner, then a call to xname generates a
.S SelectionNotify 
event to the
.A requestor 
window with
.A selection ,
.A target 
and
.A time
arguments passed unchanged as event structure members, and with
.A property
set to
.S None . 
>>STRATEGY
Call xname to convert the selection.
Verify that the correct SelectionNotify event was delivered to display.
>>CODE
int num_ev;
XEvent ev;

/* Call xname to convert the selection. */
	XCALL;
	XSync(display, False);

/* Verify that the correct SelectionNotify event was delivered to display. */
	num_ev = getevent(display, &ev);
	if (num_ev != 1) {
		FAIL;
		report("%s did not cause a single SelectionNotify event",
			TestName);
		trace("Received %d events", num_ev);
		while (num_ev > 0) {
			trace("Event %s", eventname(ev.type));
			num_ev = getevent(display, &ev);
		}
	} else {
		XEvent good;

		good.type = SelectionNotify;
		good.xselection.type = SelectionNotify;
		good.xselection.display = display;
		good.xselection.requestor = requestor;
		good.xselection.selection = selection;
		good.xselection.target = target;
		good.xselection.property = None; /* is passed with no owner */
		good.xselection.time	= -1;

		if (checkevent(&good, &ev)) {
			FAIL;
			report("SelectionNotify event was incorrect");
		} else
			CHECK;
	}

	CHECKPASS(1);

>>ASSERTION Good A
The atoms
.S PRIMARY
and
.S SECONDARY
are predefined selection atoms.
>>STRATEGY
Obtain the server representation for the PRIMARY and SECONDARY atoms.
Verify that the atoms were defined.
>>CODE
Atom primary, secondary;

/* Obtain the server representation for the PRIMARY and SECONDARY atoms. */
	primary = XInternAtom(display, "PRIMARY", True);
	secondary = XInternAtom(display, "SECONDARY", True);

/* Verify that the atoms were defined. */
	if (primary == None) {
		FAIL;
		report("PRIMARY was not defined");
	} else
		CHECK;

	if (secondary == None) {
		FAIL;
		report("SECONDARY was not defined");
	} else
		CHECK;

	CHECKPASS(2);

>>ASSERTION Bad A
.ER BadWindow
>>ASSERTION Bad A
.ER BadAtom
