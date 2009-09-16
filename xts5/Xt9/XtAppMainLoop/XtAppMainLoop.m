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

Copyright (c) 1999 The Open Group
Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: xts/Xt9/XtAppMainLoop/XtAppMainLoop.m
>># 
>># Description:
>>#	Tests for XtAppMainLoop()
>># 
>># Modifications:
>># $Log: tapmnloop.m,v $
>># Revision 1.2  2005-04-21 09:40:42  ajosey
>># resync to VSW5.1.5
>>#
>># Revision 8.2  2005/01/21 12:20:53  gwc
>># Updated copyright notice
>>#
>># Revision 8.1  1999/11/26 10:58:34  vsx
>># avoid fixed file locations (for exec-in-place false)
>>#
>># Revision 8.0  1998/12/23 23:37:09  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:00:03  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:28:15  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:49  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:18:36  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:11:56  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;
extern char *event_names[];
Widget labelw_msg;

XtInputId input_ret;
char *msg = "Hello World";
FILE *fid;
/* Procedure XtIOP_Proc */
void XtIOP_Proc(client_data, source, id)
XtPointer client_data;
int *source;
XtInputId *id;
{
	avs_set_event(1,1);
	exit(0);
}

void XtEVT_Proc2(w, client_data, event, continue_to_dispatch)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_dispatch;
{
XKeyEvent *tevent;

	tevent = (XKeyEvent *)event;

	tet_infoline("TEST: Event timestamp returned by XtLastTimestampProcessed");
	if (tevent->time != XtLastTimestampProcessed(XtDisplay(w))) {
		sprintf(ebuf, "ERROR: event->time = %ld, XtLastTimestampProcessed returned %ld", (unsigned long)tevent->time, (unsigned long)XtLastTimestampProcessed(XtDisplay(w)));
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	if (event->type == ButtonPress )
		avs_set_event(1, 1); 
	if (event->type == ButtonRelease )
		avs_set_event(2, 1); 
	if (event->type == KeyPress )
		avs_set_event(3, 1); 
	if (event->type == KeyRelease )
		avs_set_event(4, 1); 
}
/*
** XtEVT_Proc
*/
void XtEVT_Proc(w, client_data, event, continue_to_dispatch)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_dispatch;
{
	if ((Widget)client_data != topLevel) {
		tet_infoline("ERROR: client_data not passed correctly to event handler");
		tet_result(TET_FAIL);
	}
	if (event->type == ButtonPress)
		avs_set_event(1,avs_get_event(1)+1);
	else {
		sprintf(ebuf, "ERROR: Expected ButtonPress event Received %s", event_names[event->type]);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
}
/*
** XtTMO_Proc
*/
void XtTMO_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	exit(0);
}
void XtTMO_Proc5(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	tet_infoline("PREP: Send events");
	send_event_time(labelw_msg, ButtonPress, ButtonPressMask, TRUE, 1);
	send_event_time(labelw_msg, ButtonRelease, ButtonReleaseMask, TRUE, 2);
	send_event_time(labelw_msg, KeyRelease, KeyReleaseMask, TRUE, 3);
	send_event_time(labelw_msg, KeyPress, KeyPressMask, TRUE, 4);
	tet_infoline("PREP: Register timeout");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTMO_Proc, topLevel);
}
void XtTMO_Proc1(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	avs_set_event(1,1);
	exit(0);
}
void XtTMO_Proc2(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	tet_infoline("TEST: Send events after having delayed a bit");
	send_event(labelw_msg, ButtonPress, ButtonPressMask, TRUE);
	send_event(labelw_msg, ButtonPress, ButtonPressMask, TRUE);
	send_event(labelw_msg, ButtonPress, ButtonPressMask, TRUE);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTMO_Proc, topLevel);
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtAppMainLoop Xt9
void
XtAppMainLoop(app_context)
>>ASSERTION Good A
A successful call to 
void XtAppMainLoop(app_context) 
shall perform an infinite loop that reads an incoming X event for 
the application context 
.A app_context
and calls the registered event handler procedure for the widget 
to which the event is dispatched and not return.
>>CODE
char *msg = "Event widget";
pid_t pid2;
int status;

	FORK(pid2);
	avs_xt_hier("Tapmnloop1", "XtAppMainLoop");
	tet_infoline("PREP: Create a test labelw_msg widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Register XtEVT_Proc to handle events to labelw_msg");
	XtAddEventHandler(labelw_msg,
		 ButtonPressMask,
		 False,
		 XtEVT_Proc,
		 (Widget)topLevel
		 );
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Send ButtonPress events over wire to labelw_msg");
	send_event(labelw_msg, ButtonPress, ButtonPressMask, TRUE);
	send_event(labelw_msg, ButtonPress, ButtonPressMask, TRUE);
	send_event(labelw_msg, ButtonPress, ButtonPressMask, TRUE);
	tet_infoline("TEST: Add time out procedure");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTMO_Proc, topLevel);
	tet_infoline("TEST: Loop for events until timeout");
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Event handler was invoked for all events");
	status = avs_get_event(1);
	check_dec(3, status, "Event Handler invocation count");
	tet_result(TET_PASS);
>>ASSERTION Good A
When there are no events in the X input queue of the specified 
application context a call to
void XtAppMainLoop(app_context) 
shall flush the X output buffers of each display in the application 
context and wait until an event from the X server is available.
>>CODE
char *msg = "Event widget";
pid_t pid2;
int status;

	FORK(pid2);
	avs_xt_hier("Tapmnloop1", "XtAppMainLoop");
	tet_infoline("PREP: Create a test labelw_msg widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Register XtEVT_Proc to handle events to labelw_msg");
	XtAddEventHandler(labelw_msg,
		 ButtonPressMask,
		 False,
		 XtEVT_Proc,
		 (Widget)topLevel
		 );
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Add time out procedure");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTMO_Proc2, topLevel);
	tet_infoline("TEST: Loop for events");
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Event handler was invoked for all events");
	status = avs_get_event(1);
	check_dec(3, status, "Event Handler invocation count");
	tet_result(TET_PASS);
>>ASSERTION Good A
When a timeout occurs in the application context
.A app_context
on a call to 
void XtAppMainLoop(app_context) 
while it is blocked to read an event from the queue the 
designated timeout callback procedure shall be called.
>>CODE
char *msg = "Event widget";
pid_t pid2;
int status;

	FORK(pid2);
	avs_xt_hier("Tapmnloop1", "XtAppMainLoop");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Add time out procedure");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTMO_Proc1, topLevel);
	tet_infoline("TEST: Loop for events");
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: time out procedure was invoked");
	status = avs_get_event(1);
	check_dec(1, status, "time out procedure invocation count");
	tet_result(TET_PASS);
>>ASSERTION Good A
When an input from an alternate input source occurs in the application context
.A app_context 
on a call to 
void XtAppMainLoop(app_context) 
while it is blocked to read an event from the queue the 
designated input source callback procedure shall be called.
>>CODE
char *data;
int status;
pid_t pid2;

	data = "tapmnloop.dat";
	sprintf(ebuf, "PREP: Open file %s for read", data);
	tet_infoline(ebuf);
	if ((fid = (FILE *)fopen(data, "w+")) == NULL) {
		sprintf(ebuf, "ERROR: Could not open file %s", data);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	FORK(pid2);
	avs_xt_hier("Tapmnloop", "XtAppMainLoop");
	tet_infoline("PREP: Register the file as input source");
	input_ret = XtAppAddInput(app_ctext, fileno(fid), (XtPointer)XtInputReadMask, XtIOP_Proc, (XtPointer)msg);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTMO_Proc, topLevel);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Input procedure is invoked");
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	unlink(data);
	status = avs_get_event(1);
	check_dec(1, status, "XtIOP_Proc invoked status");
	tet_result(TET_PASS);
>>ASSERTION Good D 0
If the implementation is X11R5 or later:
On a call to
void XtAppMainLoop(app_context) 
when an event obtained from the input queue caused a server keyboard
grab for a widget in the application context
.A app_context
and an input method has been registered on this event for the 
widget it shall cancel the grab and not call the event handler
procedure registered for the widget.
>>ASSERTION Good D 0
If the implementation is X11R5 or later:
On a call to
void XtAppMainLoop(app_context) 
when an event obtained from the input queue caused a server pointer
grab for a widget in the application context
.A app_context
and an input method has been registered on this event for the 
widget it shall cancel the grab and not call the event handler
procedure registered for the widget.
>>ASSERTION Good A
On a call to
void XtAppMainLoop(app_context) 
when an event read from the incoming event queue for the specified
application context is a KeyPress, 
KeyRelease, ButtonPress, ButtonRelease, MotionNotify, EnterNotify, 
LeaveNotify, PropertyNotify or SelectionClear event it shall record 
the timestamp from the event as the last timestamp value that will
be returned by the next call to XtLastTimestampProcessed.
>>CODE
char *msg = "Event widget";
pid_t pid2;
int invoked = 0;
int pstatus;

	FORK(pid2);
	avs_xt_hier("Tapmnloop1", "XtAppMainLoop");
	tet_infoline("PREP: Create a test labelw_msg widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Register XtEVT_Proc2 to handle events to labelw_msg");
	XtAddEventHandler(labelw_msg,
		 ButtonPressMask|ButtonReleaseMask|KeyPressMask|KeyReleaseMask,
		 False,
		 XtEVT_Proc2,
		 (Widget)topLevel
		 );
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Register timeout procedure which will cause event");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTMO_Proc5, topLevel);
	tet_infoline("TEST: Call XtAppMainLoop");
	XtAppMainLoop(app_ctext);
	tet_infoline("ERROR: XtAppMainLoop returned");
	tet_result(TET_FAIL);
	KROF(pid2);
	tet_infoline("TEST: Events were received");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "Handler invocation for ButtonPress count");
	invoked = avs_get_event(2);
	check_dec(1, invoked, "Handler invocation for ButtonRelease count");
	invoked = avs_get_event(3);
	check_dec(1, invoked, "Handler invocation for KeyPress count");
	invoked = avs_get_event(4);
	check_dec(1, invoked, "Handler invocation for KeyRelease count");
	tet_result(TET_PASS);
>>ASSERTION Good D 0
If the implementation is X11R5 or later:
On a call to
void XtAppMainLoop(app_context) 
when an event read from the incoming event queue for the specified
application context is a remap event, 
a modal cascade exists that has a widget with spring_loaded field 
set to
.S True,
and no event input filter has been registered for the spring-loaded 
widget window on the specified event it shall dispatch the event to 
the spring-loaded widget following a dispatch to the widget to 
which the event belonged.
>>ASSERTION Good D 0
If the implementation is X11R5 or later:
On a call to
void XtAppMainLoop(app_context) 
when an event read from the incoming event queue is a remap event, a 
modal cascade exists that has a widget with spring_loaded field set to
.S True,
and an event input filter has been registered for the spring-loaded 
widget window on the specified event it shall not dispatch the event 
to the spring-loaded widget.
>>ASSERTION Good B 0
When a widget in the application context specified by
.A app_context
has the widget class field compress_motion set to 
.S True
a call to
void XtAppMainLoop(app_context) 
shall dispatch only the last motion event when there are 
successive motion events pending for the widget.
>>ASSERTION Good B 0
When a widget in the application context specified by
.A app_context
has the widget class field compress_enterleave set to 
.S True
a call to
void XtAppMainLoop(app_context) 
shall not dispatch pairs of enter and leave events that 
have no intervening events to the widget.
>>ASSERTION Good B 0
When a widget in the application context specified by
.A app_context
has the XtExposeNoCompress flag set in its widget class 
field compress_exposure a call to
void XtAppMainLoop(app_context) 
shall cause every exposure event for the specified widget to be 
dispatched individually to its expose procedure with the 
.S region 
argument set to 
.S NULL.
>># 
>># XtExposeCompressSeries
>>#
>>ASSERTION Good B 0
When a widget in the application context specified by
.A app_context
has the XtExposeCompressSeries flag set in its widget class 
field compress_exposure, a call to
void XtAppMainLoop(app_context) 
shall cause each series of exposure events for the specified widget
to be coalesced into a single event and dispatched to its expose
procedure when an exposure event with count equal to zero occurs.
>># 
>># XtExposeCompressMultiple
>>#
>>ASSERTION Good B 0
When a widget in the application context specified by
.A app_context
has the XtExposeCompressMultiple flag set in its widget class 
field compress_exposure a call to
void XtAppMainLoop(app_context) 
shall cause consecutive series of exposure events for the specified
widget to be coalesced into a single event and dispatched to its
expose procedure when an exposure event whose count equal to zero 
is encountered and either the event queue is empty or the next event 
is not an exposure event for the specified widget.
>># 
>># XtExposeCompressMaximal
>>#
>>ASSERTION Good B 0
When a widget in the application context specified by
.A app_context
has the XtExposeCompressMaximal flag set in its widget class 
field compress_exposure a call to
void XtAppMainLoop(app_context) 
shall cause all series of exposure events in the queue for the 
specified widget to be coalesced into a single event without regard 
to intervening non-exposure events and dispatched to its expose
procedure.
>># 
>># XtExposeGraphicsExpose
>>#
>>ASSERTION Good B 0
When a widget in the application context specified by
.A app_context
has the XtExposeNoCompress and the XtExposeGraphicsExpose flags set 
in its widget class field compress_exposure a call to
void XtAppMainLoop(app_context) 
shall cause all 
.S GraphicsExpose 
events for the specified widget to be dispatched individually to 
its expose procedure.
>>ASSERTION Good B 0
When a widget in the application context specified by
.A app_context
has the XtExposeCompressSeries and the XtExposeGraphicsExpose flags 
set in its widget class field compress_exposure a call to
void XtAppMainLoop(app_context) 
shall cause each series of 
.S GraphicsExpose
events for the specified widget to be coalesced into a single event 
and dispatched to its expose procedure when a
.S GraphicsExpose
event whose count is equal to zero is encountered.
>>ASSERTION Good B 0
When a widget in the application context specified by
.A app_context
has the XtExposeCompressMultiple and the XtExposeGraphicsExpose flags 
set in its widget class field compress_exposure a call to
void XtAppMainLoop(app_context) 
shall cause consecutive series of 
.S GraphicsExpose
events for the specified widget to be coalesced into a single event 
and dispatched to its expose procedure when a
.S GraphicsExpose 
event whose count is equal to zero is encountered and either the event 
queue is empty or the next event is not an 
.S GraphicsExpose
event for the specified widget.
>>ASSERTION Good B 0
When a widget in the application context specified by
.A app_context
has the XtExposeCompressMaximal and the XtExposeGraphicsExpose flags 
set in its widget class field compress_exposure a call to
void XtAppMainLoop(app_context) 
shall cause all series of 
.S GraphicsExpose
events in the queue for the specified widget
to be coalesced into a single event without regard to intervening 
non-GraphicsExpose events and dispatched to its expose procedure.
>># 
>># XtExposeGraphicsExposeMerged
>>#
>>ASSERTION Good B 0
When a widget in the application context specified by
.A app_context
has the XtExposeNoCompress and the XtExposeGraphicsExposeMerged 
flags set in its widget class field compress_exposure a call to
void XtAppMainLoop(app_context) 
shall cause all exposure and 
.S GraphicsExpose 
events for the specified widget to be dispatched individually to 
its expose procedure.
>>ASSERTION Good B 0
When a widget in the application context specified by
.A app_context
has the XtExposeCompressSeries and the XtExposeGraphicsExposeMerged flags 
set in its widget class field compress_exposure a call to
void XtAppMainLoop(app_context) 
shall cause each series of exposure and
.S GraphicsExpose
events for the widget to be coalesced into a single event and 
dispatched to its expose procedure.
>>ASSERTION Good B 0
When a widget in the application context specified by
.A app_context
has the XtExposeCompressMultiple and the XtExposeGraphicsExposeMerged 
flags set in its widget class field compress_exposure a call to
void XtAppMainLoop(app_context) 
shall cause consecutive series of exposure and
.S GraphicsExpose
events for the specified widget to be coalesced into a single event 
and dispatched to its expose procedure when an exposure and a 
.S GraphicsExpose 
event with count equal to zero are encountered and either the event 
queue is empty or the next event is neither an exposure nor a
.S GraphicsExpose
event for the specified widget.
>>ASSERTION Good B 0
When a widget in the application context specified by
.A app_context
has the XtExposeCompressMaximal and the XtExposeGraphicsExposeMerged 
flags set in its widget class field compress_exposure a call to
void XtAppMainLoop(app_context) 
shall cause all series of exposure and
.S GraphicsExpose
events in the queue for the specified widget
to be coalesced into a single event without regard to intervening 
non-exposure and non-GraphicsExpose events and dispatched to its 
expose procedure.
>># 
>># XtExposeNoExpose
>>#
>>ASSERTION Good B 0
When a widget in the application context specified by
.A app_context
has the XtExposeNoExpose flag set with any one of XtExposeNoCompress,
XtExposeCompressSeries, XtExposeCompressMultiple or 
XtExposeCompressMaximal flags set in its widget class field 
compress_exposure a call to
void XtAppMainLoop(app_context) 
shall cause all
.S NoExpose
events for the specified widget to be dispatched individually to its 
expose procedure.
>>ASSERTION Good B 0
When a widget in the application context specified by
.A app_context
has the visible_interest field in its class record set to
.S True
a call to
void XtAppMainLoop(app_context) 
shall dispatch VisibilityUnobscured events to the widget and
set the visible field in the core widget structure to 
.S True.
>>ASSERTION Good B 0
When a widget in the application context specified by
.A app_context
has the visible_interest field in its class record set to
.S True
a call to
void XtAppMainLoop(app_context) 
shall dispatch VisibilityPartiallyObscured events to the widget 
and set the visible field in the core widget structure to 
.S True.
>>ASSERTION Good B 0
When a widget in the application context specified by
.A app_context
has the visible_interest field in its class record set to
.S True
a call to
void XtAppMainLoop(app_context) 
shall dispatch VisibilityFullyObscured events to the widget and
set the visible field in the core widget structure to 
.S False.
>>ASSERTION Good B 0
When a widget in the application context specified by
.A app_context
has the visible_interest field in its class record set to
.S False
a call to
void XtAppMainLoop(app_context) 
shall not dispatch VisibilityUnobscured, VisibilityFullyObscured, 
or VisbilityPartiallyObscured events to the widget.
