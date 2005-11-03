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
$Header: /cvs/xtest/xtest/xts5/tset/Xlib5/chngprprty/chngprprty.m,v 1.2 2005-11-03 08:43:38 jmichael Exp $

Copyright (c) Applied Testing and Technology, Inc. 1995
All Rights Reserved.

>># Project: VSW5
>># 
>># File: xts5/tset/Xlib5/chngprprty/chngprprty.m
>># 
>># Description:
>># 	Tests for XChangeProperty()
>># 
>># Modifications:
>># $Log: chngprprty.m,v $
>># Revision 1.2  2005-11-03 08:43:38  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:26  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:26:42  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:45:00  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:18:56  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:15:28  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.1  1996/05/09 00:34:14  andy
>># Corrected Xatom include
>>#
>># Revision 4.0  1995/12/15  08:48:28  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  00:47:07  andy
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
>>TITLE XChangeProperty Xlib5
void

Display *display = Dsp;
Window w = defwin(display);
Atom property = xcp_list[0];
Atom type = XA_INTEGER;
int format = 32;
int mode = PropModeReplace;
unsigned char *data = (unsigned char *)NULL;
int nelements = 0;
>>EXTERN
#include "X11/Xatom.h"

static Atom xcp_list[] = {
	XA_COPYRIGHT, XA_INTEGER };

static int xcp_num_list = NELEM(xcp_list);

static void
xcp_add_property(prop, data)
Atom prop;
unsigned long data;
{
	XChangeProperty(display, w, prop, XA_INTEGER, 32,
		PropModeReplace, (unsigned char *)&data, 1);
	XSync(display, True);
}

static int
xcp_get_property(prop, length, ret)
Atom prop;
int length;
unsigned char **ret;
{
Atom type;
int format;
unsigned long nitems;
unsigned long after;

	XGetWindowProperty(display, w, prop, 0, (long)length, False,
			XA_INTEGER, &type, &format, &nitems, &after, ret);

	if ( type != XA_INTEGER || format != 32 ) {
		delete("XGetWindowProperty returned unexpected values");
		report("type is %s (expected XA_INTEGER)", atomname(type));
		report("format is %d (expected 32)",format);
		return(0);
	} else {
		if (nitems != length) {
			report("%s did not change the", TestName);
			report("window property as expected");
			report("Expected %d items", length);
			report("Returned %d items", nitems);
			return(0);
		} else {
			if (after != 0) {
				report("%s did not change the", TestName);
				report("window property as expected");
				report("Expected after: 0");
				report("Returned after: %d", after);
				return(0);
			}
		}
	}
	return(1);
}

>>ASSERTION Good A
A call to xname alters the 
.A property
for the specified window
.A w
and
generates a
.S PropertyNotify 
event on that window.
>>STRATEGY
Create a window without properties and with PropertyChangeMask events selected.
Call xname to replace a property value.
Verify that a PropertyNotify event occurred.
Verify that the property was updated as expected.
>>CODE
unsigned long newdata;
unsigned long retdata;
unsigned char *retptr;
int num_ev;
XEvent ev, good;

/* Create a window without properties and with PropertyChangeMask events selected. */
	XSelectInput(display, w, PropertyChangeMask);

/* Call xname to replace a property value. */
	mode = PropModeReplace;
	newdata = xcp_num_list;
	data =  (unsigned char *)&newdata;
	nelements = 1;
	XCALL;

/* Verify that a PropertyNotify event occurred. */
	num_ev = getevent(display, &ev);
	if(num_ev == 0) {
		FAIL;
		report("A call to %s caused no events", TestName);
	} else {
		if(num_ev != 1) {
			FAIL;
			report("A call to %s caused %d events, expecting 1",
				TestName, num_ev);
			do {
				report("Event %s", eventname(ev.type));
			} while(getevent(display, &ev));
		} else {
			good.type = PropertyNotify;
			good.xproperty.type = PropertyNotify;
			good.xproperty.atom = property;
			good.xproperty.display = display;
			good.xproperty.window = w;
			good.xproperty.state = PropertyNewValue;
			if (checkevent(&good, &ev)) {
				FAIL;
			} else
				CHECK;
		}
	}

/* Verify that the property was updated as expected. */
	if(!xcp_get_property(property, 1, &retptr)) {
		FAIL;
	} else {
		retdata = *(unsigned long *)retptr;
		if(retdata != newdata) {
			FAIL;
			report("%s did not assign the property value",TestName);
			report("as expected");
			report("Expected value: %u", newdata);
			report("Returned value: %u", retdata);
		} else
			CHECK;
	}

	CHECKPASS(2);

>>ASSERTION Good A
When
.A mode
is
.S PropModeReplace ,
then a call to xname discards the previous value of
.A property
and stores the new
.A data ,
in the specified
.A format
and 
.A type ,
and a
.S PropertyNotify
event is generated.
>>STRATEGY
Create a window with properties and PropertyChangeMask events selected.
Call xname to replace a property value.
Verify that a PropertyNotify event occurred.
Verify that the property was updated as expected.
>>CODE
int loop;
unsigned long newdata;
unsigned long retdata;
unsigned char *retptr;
int num_ev;
XEvent ev, good;

/* Create a window with properties and PropertyChangeMask events selected. */
	for(loop=0; loop < xcp_num_list; loop++)
		xcp_add_property(xcp_list[loop], (unsigned long)loop);

	XSelectInput(display, w, PropertyChangeMask);

/* Call xname to replace a property value. */
	mode = PropModeReplace;
	newdata = xcp_num_list;
	data =  (unsigned char *)&newdata;
	nelements = 1;
	XCALL;

/* Verify that a PropertyNotify event occurred. */
	num_ev = getevent(display, &ev);
	if(num_ev == 0) {
		FAIL;
		report("A call to %s caused no events", TestName);
	} else {
		if(num_ev != 1) {
			FAIL;
			report("A call to %s caused %d events, expecting 1",
				TestName, num_ev);
			do {
				report("Event %s", eventname(ev.type));
			} while(getevent(display, &ev));
		} else {
			good.type = PropertyNotify;
			good.xproperty.type = PropertyNotify;
			good.xproperty.atom = property;
			good.xproperty.display = display;
			good.xproperty.window = w;
			good.xproperty.state = PropertyNewValue;
			if (checkevent(&good, &ev)) {
				FAIL;
			} else
				CHECK;
		}
	}

/* Verify that the property was updated as expected. */
	if(!xcp_get_property(property, 1, &retptr)) {
		FAIL;
	} else {
		retdata = *(unsigned long *)retptr;
		if(retdata != newdata) {
			FAIL;
			report("%s did not change the property value",TestName);
			report("as expected");
			report("Expected value: %u", newdata);
			report("Returned value: %u", retdata);
		} else
			CHECK;
	}
	
	CHECKPASS(2);

>>ASSERTION Good A
When
.A mode
is
.S PropModePrepend ,
then a call to xname inserts the specified
.A data
before the beginning
of the existing data for
.A property ,
and a 
.S PropertyNotify
event is generated.
>>STRATEGY
Create a window with properties and PropertyChangeMask events selected.
Call xname to replace a property value.
Verify that a PropertyNotify event occurred.
Verify that the property was updated as expected.
>>CODE
int loop;
unsigned long newdata;
unsigned long *retdata;
unsigned char *retptr;
int num_ev;
XEvent ev, good;

/* Create a window with properties and PropertyChangeMask events selected. */
	for(loop=0; loop < xcp_num_list; loop++)
		xcp_add_property(xcp_list[loop], (unsigned long)loop);

	XSelectInput(display, w, PropertyChangeMask);

/* Call xname to replace a property value. */
	mode = PropModePrepend;
	newdata = xcp_num_list;
	data =  (unsigned char *)&newdata;
	nelements = 1;
	XCALL;

/* Verify that a PropertyNotify event occurred. */
	num_ev = getevent(display, &ev);
	if(num_ev == 0) {
		FAIL;
		report("A call to %s caused no events", TestName);
	} else {
		if(num_ev != 1) {
			FAIL;
			report("A call to %s caused %d events, expecting 1",
				TestName, num_ev);
			do {
				report("Event %s", eventname(ev.type));
			} while(getevent(display, &ev));
		} else {
			good.type = PropertyNotify;
			good.xproperty.type = PropertyNotify;
			good.xproperty.atom = property;
			good.xproperty.display = display;
			good.xproperty.window = w;
			good.xproperty.state = PropertyNewValue;
			if (checkevent(&good, &ev)) {
				FAIL;
			} else
				CHECK;
		}
	}

/* Verify that the property was updated as expected. */
	if(!xcp_get_property(property, 2, &retptr)) {
		FAIL;
	} else {
		retdata = (unsigned long *)retptr;
		if(retdata[0] != newdata || retdata[1] != 0) {
			FAIL;
			report("%s did not change the property value",TestName);
			report("as expected");
			report("Expected value: %u,%u", newdata, 0);
			report("Returned value: %u,%u", retdata[0], retdata[1]);
		} else
			CHECK;
	}
	
	CHECKPASS(2);

>>ASSERTION Good A
When
.A mode
is 
.S PropModeAppend , 
then a call to xname inserts the specified
.A data
onto the end of the existing data for
.A property ,
and a 
.S PropertyNotify
event is generated.
>>STRATEGY
Create a window with properties and PropertyChangeMask events selected.
Call xname to replace a property value.
Verify that a PropertyNotify event occurred.
Verify that the property was updated as expected.
>>CODE
int loop;
unsigned long newdata;
unsigned long *retdata;
unsigned char *retptr;
int num_ev;
XEvent ev, good;

/* Create a window with properties and PropertyChangeMask events selected. */
	for(loop=0; loop < xcp_num_list; loop++)
		xcp_add_property(xcp_list[loop], (unsigned long)loop);

	XSelectInput(display, w, PropertyChangeMask);

/* Call xname to replace a property value. */
	mode = PropModeAppend;
	newdata = xcp_num_list;
	data =  (unsigned char *)&newdata;
	nelements = 1;
	XCALL;

/* Verify that a PropertyNotify event occurred. */
	num_ev = getevent(display, &ev);
	if(num_ev == 0) {
		FAIL;
		report("A call to %s caused no events", TestName);
	} else {
		if(num_ev != 1) {
			FAIL;
			report("A call to %s caused %d events, expecting 1",
				TestName, num_ev);
			do {
				report("Event %s", eventname(ev.type));
			} while(getevent(display, &ev));
		} else {
			good.type = PropertyNotify;
			good.xproperty.type = PropertyNotify;
			good.xproperty.atom = property;
			good.xproperty.display = display;
			good.xproperty.window = w;
			good.xproperty.state = PropertyNewValue;
			if (checkevent(&good, &ev)) {
				FAIL;
			} else
				CHECK;
		}
	}

/* Verify that the property was updated as expected. */
	if(!xcp_get_property(property, 2, &retptr)) {
		FAIL;
	} else {
		retdata = (unsigned long *)retptr;
		if(retdata[0] != 0 || retdata[1] != newdata) {
			FAIL;
			report("%s did not change the property value",TestName);
			report("as expected");
			report("Expected values: %u,%u", 0, newdata);
			report("Returned values: %u,%u", retdata[0], retdata[1]);
		} else
			CHECK;
	}
	
	CHECKPASS(2);

>>ASSERTION Good A
When
.A mode
is
.S PropModeAppend
or
.S PropModePrepend
and the
.A property
is undefined for window
.A w ,
then on a call to xname the
.A property
is treated as if it were defined with the correct
.A type
and
.A format
and had zero length data.
>>STRATEGY
Create a window without properties and with PropertyChangeMask events selected.
Call xname to prepend to a non-existant property value.
Verify that a PropertyNotify event occurred.
Verify that the property was updated as expected.
Call xname to append to a non-existant property value.
Verify that a PropertyNotify event occurred.
Verify that the property was updated as expected.
>>CODE
unsigned long newdata;
unsigned long retdata;
unsigned char *retptr;
int num_ev;
XEvent ev, good;

/* Create a window without properties and with PropertyChangeMask events selected. */
	XSelectInput(display, w, PropertyChangeMask);

/* Call xname to prepend to a non-existant property value. */
	mode = PropModePrepend;
	newdata = xcp_num_list;
	data =  (unsigned char *)&newdata;
	nelements = 1;
	XCALL;

/* Verify that a PropertyNotify event occurred. */
	num_ev = getevent(display, &ev);
	if(num_ev == 0) {
		FAIL;
		report("A call to %s caused no events", TestName);
	} else {
		if(num_ev != 1) {
			FAIL;
			report("A call to %s caused %d events, expecting 1",
				TestName, num_ev);
			do {
				report("Event %s", eventname(ev.type));
			} while(getevent(display, &ev));
		} else {
			good.type = PropertyNotify;
			good.xproperty.type = PropertyNotify;
			good.xproperty.atom = property;
			good.xproperty.display = display;
			good.xproperty.window = w;
			good.xproperty.state = PropertyNewValue;
			if (checkevent(&good, &ev)) {
				FAIL;
			} else
				CHECK;
		}
	}

/* Verify that the property was updated as expected. */
	if(!xcp_get_property(property, 1, &retptr)) {
		FAIL;
	} else {
		retdata = *(unsigned long *)retptr;
		if(retdata != newdata) {
			FAIL;
			report("%s did not assign the property value",TestName);
			report("as expected");
			report("Expected value: %u", newdata);
			report("Returned value: %u", retdata);
		} else
			CHECK;
	}

/* Call xname to append to a non-existant property value. */
	property = xcp_list[1];
	mode = PropModeAppend;
	newdata = xcp_num_list;
	data =  (unsigned char *)&newdata;
	nelements = 1;
	XCALL;

/* Verify that a PropertyNotify event occurred. */
	num_ev = getevent(display, &ev);
	if(num_ev == 0) {
		FAIL;
		report("A call to %s caused no events", TestName);
	} else {
		if(num_ev != 1) {
			FAIL;
			report("A call to %s caused %d events, expecting 1",
				TestName, num_ev);
			do {
				report("Event %s", eventname(ev.type));
			} while(getevent(display, &ev));
		} else {
			good.type = PropertyNotify;
			good.xproperty.type = PropertyNotify;
			good.xproperty.atom = property;
			good.xproperty.display = display;
			good.xproperty.window = w;
			good.xproperty.state = PropertyNewValue;
			if (checkevent(&good, &ev)) {
				FAIL;
			} else
				CHECK;
		}
	}

/* Verify that the property was updated as expected. */
	if(!xcp_get_property(property, 1, &retptr)) {
		FAIL;
	} else {
		retdata = *(unsigned long *)retptr;
		if(retdata != newdata) {
			FAIL;
			report("%s did not assign the property value",TestName);
			report("as expected");
			report("Expected value: %u", newdata);
			report("Returned value: %u", retdata);
		} else
			CHECK;
	}
	
	CHECKPASS(4);
	
>>ASSERTION Good A
>># The lifetime of a property is not tied to the storing client.
>>#	Split into two new ones......
When the storing client closes its connection to the server and
the window
.A w
is not destroyed, then the
.A format ,
.A data
and
.A type
of the
.A property
remain associated with the window.
>>STRATEGY
Create a new client.
Call xname to add a property to the window on the new client.
Close client2.
Allow time for the client to close.
Verify that the property is still defined.
>>CODE
Display *client2;
unsigned long newdata;
unsigned long retdata;
unsigned char *retptr;

/* Create a new client. */
	client2 = XOpenDisplay(config.display);
	if(client2 == (Display *)NULL) {
		delete("could not create new client");
		return;
	} else
		CHECK;

/* Call xname to add a property to the window on the new client. */
	display = client2;
	mode = PropModeReplace;
	newdata = xcp_num_list;
	data =  (unsigned char *)&newdata;
	nelements = 1;
	XCALL;

/* Close client2. */
	XCloseDisplay(client2);

/* Allow time for the client to close. */
	reset_delay();

/* Verify that the property is still defined. */
	display = Dsp;
	if(!xcp_get_property(property, 1, &retptr)) {
		FAIL;
	} else {
		retdata = *(unsigned long *)retptr;
		if(retdata != newdata) {
			FAIL;
			report("The property value was not",TestName);
			report("as expected");
			report("Expected value: %u", newdata);
			report("Returned value: %u", retdata);
		} else
			CHECK;
	}

	CHECKPASS(2);

>>ASSERTION Good A
>># This assertion kinda slipped through the net. It would
>># catch if some bizarre implementation actually damaged
>># the property atom.
When the storing client closes its connection to the server and
the server does not reset, then the atom
.A property
remains.
>>STRATEGY
Create a new client.
Call xname to change a property on a window on the new client.
Close new client.
Allow time for the client to close.
Verify that atom property remains defined.
>>CODE
Display *display2;
unsigned long newdata;
Atom atm;

/* Create a new client. */
	if (config.display == (char *)NULL) {
		delete("config.display not set");
		return;
	} else
		CHECK;

	display2 = XOpenDisplay(config.display);
	if (display2 == (Display *)NULL) {
		delete("Could not open display for display2");
		return;
	} else
		CHECK;

/* Call xname to change a property on a window on the new client. */
	display = display2;
	newdata = 255;
	data = (unsigned char *)&newdata;
	XCALL;

/* Close new client. */
	(void) XCloseDisplay(display2);

/* Allow time for the client to close. */
	reset_delay();

/* Verify that atom property remains defined. */
	atm = XInternAtom(Dsp, "INTEGER", True);

	if (atm != XA_INTEGER) {
		FAIL;
		report("%s caused INTEGER atom to become undefined.",
			TestName);
		report("Expected atom %u", (unsigned long)XA_INTEGER);
		report("Returned atom %u", (unsigned long)atm);
	} else
		CHECK;

	CHECKPASS(3);

>>ASSERTION Bad A
When
.A mode
is 
.S PropModePrepend
or
.S PropModeAppend
and the
.A type
or
.A format
do not match the existing
.A property
value, then on a call to xname a
.S BadMatch
error occurs.
>>STRATEGY
Create a window with properties and PropertyChangeMask events selected.
Call xname to append a property value, with incorrect type information.
Verify that no PropertyNotify event occurred.
Verify that the property was unchanged.
Call xname to prepend a property value, with incorrect format information.
Verify that no PropertyNotify event occurred.
Verify that the property was unchanged.
>>CODE BadMatch
int loop;
unsigned long newdata;
unsigned long retdata;
unsigned char *retptr;
int num_ev;
XEvent ev;

/* Create a window with properties and PropertyChangeMask events selected. */
	for(loop=0; loop < xcp_num_list; loop++)
		xcp_add_property(xcp_list[loop], (unsigned long)loop);

	XSelectInput(display, w, PropertyChangeMask);

/* Call xname to append a property value, with incorrect type information. */
	format = 32;
	type = XA_BITMAP;
	mode = PropModeAppend;
	newdata = xcp_num_list;
	data =  (unsigned char *)&newdata;
	nelements = 1;
	XCALL;
	
	if(geterr()!= BadMatch) {
		FAIL;
	} else
		CHECK;

/* Verify that no PropertyNotify event occurred. */
	num_ev = getevent(display, &ev);
	if(num_ev != 0) {
		FAIL;
		report("A call to %s caused %d events, expecting 0",
			TestName, num_ev);
		do {
			report("Event %s", eventname(ev.type));
		} while(getevent(display, &ev));
	} else 
		CHECK;

/* Verify that the property was unchanged. */
	if(!xcp_get_property(property, 1, &retptr)) {
		FAIL;
	} else {
		retdata = *(unsigned long *)retptr;
		if(retdata != 0) {
			FAIL;
			report("%s changed the property value",TestName);
			report("unexpectedly");
			report("Expected value: %u", 0);
			report("Returned value: %u", retdata);
		} else
			CHECK;
	}

/* Call xname to prepend a property value, with incorrect format information. */
	format = 16;
	type = XA_INTEGER;
	mode = PropModePrepend;
	newdata = xcp_num_list;
	data =  (unsigned char *)&newdata;
	nelements = 1;
	XCALL;
	
	if(geterr()!= BadMatch) {
		FAIL;
	} else
		CHECK;

/* Verify that no PropertyNotify event occurred. */
	num_ev = getevent(display, &ev);
	if(num_ev != 0) {
		FAIL;
		report("A call to %s caused %d events, expecting 0",
			TestName, num_ev);
		do {
			report("Event %s", eventname(ev.type));
		} while(getevent(display, &ev));
	} else 
		CHECK;

/* Verify that the property was unchanged. */
	if(!xcp_get_property(property, 1, &retptr)) {
		FAIL;
	} else {
		retdata = *(unsigned long *)retptr;
		if(retdata != 0) {
			FAIL;
			report("%s changed the property value",TestName);
			report("unexpectedly");
			report("Expected value: %u", 0);
			report("Returned value: %u", retdata);
		} else
			CHECK;
	}
	
	CHECKPASS(6);

>>ASSERTION Bad B
.ER BadAlloc
>>ASSERTION Bad A
.ER BadAtom
>>ASSERTION Bad A
.ER BadWindow 
>>ASSERTION Bad A
.ER BadValue format 8 16 32
>>ASSERTION Bad A
.ER BadValue mode PropModeReplace PropModePrepend PropModeAppend
