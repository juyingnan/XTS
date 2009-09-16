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
>># File: xts5/Xlib5/XDeleteProperty/XDeleteProperty.m
>># 
>># Description:
>># 	Tests for XDeleteProperty()
>># 
>># Modifications:
>># $Log: dltprprty.m,v $
>># Revision 1.2  2005-11-03 08:43:38  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:27  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:26:43  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:45:01  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:18:57  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:15:29  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.1  1996/05/09 00:34:16  andy
>># Corrected Xatom include
>>#
>># Revision 4.0  1995/12/15  08:48:31  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  00:47:13  andy
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
>>TITLE XDeleteProperty Xlib5
void

Display *display = Dsp;
Window w = defwin(display);
Atom property = XA_COPYRIGHT;
>>EXTERN
#include "X11/Xatom.h"
>>ASSERTION Good A
When the specified
.A property
exists on the specified window
.A w ,
then
a call to xname deletes the
.A property
and a
.S PropertyNotify
event is generated on the window
.A w .
>>STRATEGY
Create a window with a property and  PropertyChangeMask events selected. 
Call xname to delete the property.
Verify that a good PropertyNotify event occurred.
Verify that the window property was deleted.
>>CODE
char *data="a tested property";
int num = 0;
XEvent ev;

/* Create a window with a property and  PropertyChangeMask events selected.  */
	XChangeProperty(display, w, property, XA_STRING, 8,
		PropModeReplace,(unsigned char *)data, strlen(data));
	XSync(display, True);
        XSelectInput(display, w, PropertyChangeMask);

/* Call xname to delete the property. */
	XCALL;

/* Verify that a good PropertyNotify event occurred. */

	num = getevent(display, &ev);
	if (num != 1) {
		FAIL;
		report("%s caused %d events", num);
		trace("Expecting a single PropertyNotify event");
	} else {
		XEvent good;
		
		good.type = PropertyNotify;
		good.xproperty.type = PropertyNotify;
		good.xproperty.display= display;
		good.xproperty.serial = 0;
		good.xproperty.send_event = False;
		good.xproperty.window = w;
		good.xproperty.atom = property;
		good.xproperty.time = 0;
		good.xproperty.state = PropertyDelete;

#ifdef TESTING
	good.xproperty.atom--;
#endif

		if (checkevent(&good, &ev)) {
			FAIL;
		} else
			CHECK;
	}

/* Verify that the window property was deleted. */
	(void)XListProperties(display, w, &num);
	if (num != 0) {
		FAIL;
		report("%s did not delete a window property", TestName);
		trace("Expected: 0 properties");
		trace("Returned: %d propert%s", num, (num==1?"y":"ies"));
	} else
		CHECK;

	CHECKPASS(2);
>>ASSERTION Good A
When the specified
.A property
does not exist on the specified window
.A w ,
then a call to xname deletes no property of the window
.A w
and no
.S PropertyNotify
event is generated.
>>STRATEGY
Create a window with a property and PropertyChangeMask events selected. 
Call xname to delete a non-existant property.
Verify that no PropertyNotify events occurred.
Verify that the window property was not deleted.
>>CODE
char *data="a tested property";
int num = 0;
XEvent ev;

/* Create a window with a property and PropertyChangeMask events selected.  */
	XChangeProperty(display, w, XA_NOTICE, XA_STRING, 8,
		PropModeReplace,(unsigned char *)data, strlen(data));
	XSync(display, True);
        XSelectInput(display, w, PropertyChangeMask);

/* Call xname to delete a non-existant property. */
#ifdef TESTING
	property = XA_NOTICE;
#endif
	XCALL;

/* Verify that no PropertyNotify events occurred. */
	if (getevent(display, &ev) != 0) {
		FAIL;
		report("%s caused unexpected event(s)", TestName);
		do {
			trace("Event: %s", eventname(ev.type));
		} while(getevent(display, &ev));
	} else
		CHECK;

/* Verify that the window property was not deleted. */
	(void)XListProperties(display, w, &num);
	if (num != 1) {
		FAIL;
		report("%s unexpectedly changed the window properties",
			TestName);
		trace("Expected: 1 property");
		trace("Returned: %d properties", num);
	} else
		CHECK;

	CHECKPASS(2);

>>ASSERTION Bad A
.ER BadAtom
>>ASSERTION Bad A
.ER BadWindow
