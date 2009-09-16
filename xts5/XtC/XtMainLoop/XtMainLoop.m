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
$Header: /cvs/xtest/xtest/xts5/tset/XtC/XtMainLoop/XtMainLoop.m,v 1.2 2005-04-21 09:40:42 ajosey Exp $

Copyright (c) 1999 The Open Group
Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/XtC/XtMainLoop/XtMainLoop.m
>># 
>># Description:
>>#	Tests for XtMainLoop()
>># 
>># Modifications:
>># $Log: tmainloop.m,v $
>># Revision 1.2  2005-04-21 09:40:42  ajosey
>># resync to VSW5.1.5
>>#
>># Revision 8.2  2005/01/21 12:27:56  gwc
>># Updated copyright notice
>>#
>># Revision 8.1  1999/11/26 12:18:20  vsx
>># avoid fixed file locations (for exec-in-place false)
>>#
>># Revision 8.0  1998/12/23 23:38:28  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:31  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:29:30  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:26:04  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:22:31  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:19:06  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

extern char *event_names[];

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;
Widget labelw_msg;
XtInputId input_ret;
char *msg = "Hello World";
FILE *fid;

/*
** XtEVT_Proc
*/
void XtEVT_Proc(w, client_data, event, continue_to_dispatch)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_dispatch;
{
	if ( event->type == ButtonPress )
		avs_set_event(1, 1); 
	else {
		sprintf(ebuf, "ERROR: Expected ButtonPress event Received \"%s\"", event_names[event->type]);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
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
** XtTMO_Proc
*/
void XtTMO_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	avs_set_event(2, 1); 
	exit(0);
}

void XtTMO_Proc2(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	tet_infoline("PREP: Send ButtonPress event");
	send_event(labelw_msg, ButtonPress, ButtonPressMask, FALSE);
	tet_infoline("PREP: Register timeout");
	XtAddTimeOut(AVSXTLOOPTIMEOUT, XtTMO_Proc, topLevel);
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
	XtAddTimeOut(AVSXTLOOPTIMEOUT, XtTMO_Proc, topLevel);
}
/*
** Procedure XtIOP_Proc
*/
void XtIOP_Proc(client_data, source, id)
XtPointer client_data;
int *source;
XtInputId *id;
{
	avs_set_event(3,avs_get_event(3)+1);
	tet_infoline("TEST: InputID passed to callback matches return from XtAddInput");
	if (*id != input_ret) {
		sprintf(ebuf, "ERROR: InputId passed to callback was %#x, InputId returned by XtAddInput was %#x, should be identical", id, input_ret);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Source passed to callback matches that passed to XtAddInput");
	if (*source != fileno(fid)) {
		sprintf(ebuf, "ERROR: Source passed to callback was %#x, source passed to XtAddInput was %#x, should be identical", *source, fileno(fid));
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Client data passed to callback matches that passed to XtAddInput");
	if (strncmp(client_data, msg, sizeof(msg)) != 0) {
		sprintf(ebuf, "ERROR: Client_data passed to callback was \"%s\", Client_data passed to XtAddInput was \"%s\", should be identical", client_data, msg);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	exit(0);
}
>>SET tpcleanup avs_free_sem
>>SET tpstartup avs_alloc_sem
>>TITLE XtMainLoop XtC
void
XtMainLoop()
>>ASSERTION Good A
A successful call to 
void XtMainLoop()
shall perform an infinite loop that reads an incoming X event 
for the calling process and calls the registered event handler 
procedure for the widget to which the event is dispatched 
and not return.
>>CODE
char *msg = "Event widget";
pid_t pid2;
int invoked = 0;
pid_t pid3;
int pstatus;

	FORK(pid3);
	avs_xt_hier_def("Tmainloop1", "XtMainLoop");
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
	tet_infoline("PREP: Send ButtonPress event");
	send_event(labelw_msg, ButtonPress, ButtonPressMask, FALSE);
	tet_infoline("PREP: Register timeout");
	XtAddTimeOut(AVSXTLOOPTIMEOUT, XtTMO_Proc, topLevel);
	tet_infoline("TEST: Call XtMainLoop");
	FORK(pid2);
	XtMainLoop();
	tet_infoline("ERROR: XtMainLoop returned");
	tet_result(TET_FAIL);
	LKROF(pid2, AVSXTTIMEOUT-4);
	KROF3(pid3, pstatus, AVSXTTIMEOUT-2);
        if (pstatus != 0) {
		tet_infoline("ERROR: Test process exited abnormally");
		tet_infoline("       May mean display cannot be opened");
		tet_result(TET_UNRESOLVED);
        }
	else {
		tet_infoline("TEST: ButtonPress event was received");
		invoked = avs_get_event(1);
		if(!invoked) {
			sprintf(ebuf, "ERROR: XtMainLoop() did not process ButtonPress event");
			tet_infoline(ebuf);
			tet_result(TET_FAIL);
		}
		tet_result(TET_PASS);
	}
>>ASSERTION Good A
When there are no events in the X input queue of the calling
process a call to
void XtMainLoop()
shall flush the X output buffers of each display in the calling 
process and wait until an event from the X server is available.
>>CODE
char *msg = "Event widget";
pid_t pid2;
int invoked = 0;
pid_t pid3;
int pstatus;

	FORK(pid3);
	avs_xt_hier_def("Tmainloop1", "XtMainLoop");
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
	tet_infoline("PREP: Register timeout procedure which will cause event");
	XtAddTimeOut(AVSXTLOOPTIMEOUT, XtTMO_Proc2, topLevel);
	tet_infoline("TEST: XtMainLoop waits for event");
	FORK(pid2);
	XtMainLoop();
	tet_infoline("ERROR: XtMainLoop returned");
	tet_result(TET_FAIL);
	LKROF(pid2, AVSXTTIMEOUT-4);
	KROF3(pid3, pstatus, AVSXTTIMEOUT-2);
        if (pstatus != 0) {
		tet_infoline("ERROR: Test process exited abnormally");
		tet_infoline("       May mean display cannot be opened");
		tet_result(TET_UNRESOLVED);
        }
	else {
		tet_infoline("TEST: ButtonPress event was received");
		invoked = avs_get_event(1);
		if(!invoked) {
			sprintf(ebuf, "ERROR: XtMainLoop() did not process ButtonPress event");
			tet_infoline(ebuf);
			tet_result(TET_FAIL);
		}
		tet_result(TET_PASS);
	}
>>ASSERTION Good A
When a timeout occurs in the calling process
on a call to 
void XtMainLoop()
while it is blocked to read an event from the queue the 
designated timeout callback procedure shall be called.
>>CODE
char *msg = "Event widget";
pid_t pid2;
int invoked = 0;
pid_t pid3;
int pstatus;

	FORK(pid3);
	avs_xt_hier_def("Tmainloop1", "XtMainLoop");
	tet_infoline("PREP: Create a test labelw_msg widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Register timeout");
	XtAddTimeOut(AVSXTLOOPTIMEOUT, XtTMO_Proc, topLevel);
	tet_infoline("TEST: Call XtMainLoop");
	FORK(pid2);
	XtMainLoop();
	tet_infoline("ERROR: XtMainLoop returned");
	tet_result(TET_FAIL);
	LKROF(pid2, AVSXTTIMEOUT-4);
	KROF3(pid3, pstatus, AVSXTTIMEOUT-2);
        if (pstatus != 0) {
		tet_infoline("ERROR: Test process exited abnormally");
		tet_infoline("       May mean display cannot be opened");
		tet_result(TET_UNRESOLVED);
        }
	else {
		tet_infoline("TEST: Timeout procedure was invoked");
		invoked = avs_get_event(2);
		if(!invoked) {
			sprintf(ebuf, "ERROR: XtMainLoop() did not invoke timeout procedure");
			tet_infoline(ebuf);
			tet_result(TET_FAIL);
		}
		tet_result(TET_PASS);
	}
>>ASSERTION Good A
When an input from a source occurs in the calling process
on a call to 
void XtMainLoop()
while it is blocked to read an event from the queue the 
designated input source callback procedure shall be called.
>>CODE
pid_t pid2;
int invoked = 0;
pid_t pid3;
int pstatus;
char *data;

	data = "data1";
	FORK(pid3);
	avs_xt_hier_def("Tmainloop1", "XtMainLoop");
	tet_infoline("PREP: Create a test labelw_msg widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	sprintf(ebuf, "PREP: Open file \"%s\" for read", data);
	tet_infoline(ebuf);
	if (( fid = (FILE *)fopen(data, "w+")) == NULL ) {
		sprintf(ebuf, "ERROR: Could not open file \"%s\"", data);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Register file as an input source");
	input_ret = XtAddInput(fileno(fid), (XtPointer)XtInputReadMask, XtIOP_Proc, (XtPointer)msg);
	tet_infoline("PREP: Register timeout");
	XtAddTimeOut(AVSXTLOOPTIMEOUT, XtTMO_Proc, topLevel);
	FORK(pid2);
	tet_infoline("TEST: Call XtMainLoop");
	XtMainLoop();
	tet_infoline("ERROR: XtMainLoop returned");
	tet_result(TET_FAIL);
	LKROF(pid2, AVSXTTIMEOUT-4);
	unlink(data);
	KROF3(pid3, pstatus, AVSXTTIMEOUT-2);
        if (pstatus != 0) {
		tet_infoline("ERROR: Test process exited abnormally");
		tet_infoline("       May mean display cannot be opened");
		tet_result(TET_UNRESOLVED);
        }
	else {
		tet_infoline("TEST: Input procedure was invoked");
		invoked = avs_get_event(3);
		if(!invoked) {
			sprintf(ebuf, "ERROR: XtMainLoop() did not invoke input procedure");
			tet_infoline(ebuf);
			tet_result(TET_FAIL);
		}
		tet_result(TET_PASS);
	}
>>ASSERTION Good D 0
If the implementation is X11R5 or later:
On a call to
void XtMainLoop()
when an event obtained from the input queue caused a 
server keyboard grab for a widget in the calling process
and an input method has been registered on this event for the 
widget it shall cancel the grab and not call the event handler
procedure registered for the widget.
>>ASSERTION Good D 0
If the implementation is X11R5 or later:
On a call to
void XtMainLoop()
when an event obtained from the input queue caused a 
server pointer grab for a widget in the calling process
and an input method has been registered on this event for the 
widget it shall cancel the grab and not call the event handler
procedure registered for the widget.
>>ASSERTION Good A
On a call to
void XtMainLoop()
when an event read from the incoming event queue for 
the calling process is a KeyPress, KeyRelease, ButtonPress, 
ButtonRelease, MotionNotify, EnterNotify, LeaveNotify, 
PropertyNotify or SelectionClear event it shall record 
the timestamp from the event as the last timestamp value that 
will be returned by the next call to XtLastTimestampProcessed.
>>CODE
char *msg = "Event widget";
pid_t pid2;
int invoked = 0;
pid_t pid3;
int pstatus;

	FORK(pid3);
	avs_xt_hier_def("Tmainloop1", "XtMainLoop");
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
	XtAddTimeOut(AVSXTLOOPTIMEOUT, XtTMO_Proc5, topLevel);
	tet_infoline("TEST: XtMainLoop waits for event");
	FORK(pid2);
	XtMainLoop();
	tet_infoline("ERROR: XtMainLoop returned");
	tet_result(TET_FAIL);
	LKROF(pid2, AVSXTTIMEOUT-4);
	KROF3(pid3, pstatus, AVSXTTIMEOUT-2);
        if (pstatus != 0) {
		tet_infoline("ERROR: Test process exited abnormally");
		tet_infoline("       May mean display cannot be opened");
		tet_result(TET_UNRESOLVED);
        }
	else {
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
	}
>>ASSERTION Good D 0
If the implementation is X11R5 or later:
On a call to
void XtMainLoop()
when an event read from the incoming event queue for the 
calling process is a remap event, a modal cascade exists 
that has a widget with spring_loaded field set to
.S True,
and no event input filter has been registered for the 
spring-loaded widget window on the specified event it shall 
dispatch the event to the spring-loaded widget following a 
dispatch to the widget to which the event belonged.
>>ASSERTION Good D 0
If the implementation is X11R5 or later:
On a call to
void XtMainLoop()
when an event read from the incoming event queue is a remap 
event, a modal cascade exists that has a widget with 
spring_loaded field set to
.S True,
and an event input filter has been registered for the spring-loaded 
widget window on the specified event it shall not dispatch the event 
to the spring-loaded widget.
>>ASSERTION Good B 0
When a widget in the calling process
has the widget class field compress_motion  set to 
.S True
a call to
void XtMainLoop()
shall dispatch only the last motion event when there are 
successive motion events pending for the widget.
>>ASSERTION Good B 0
When a widget in the calling process
has the widget class field compress_enterleave  set to 
.S True
a call to
void XtMainLoop()
shall not dispatch pairs of enter and leave events that 
have no intervening events to the widget.
>>ASSERTION Good B 0
When a widget in the calling process
has the XtExposeNoCompress flag set in its widget class 
field compress_exposure a call to
void XtMainLoop()
shall cause every exposure event for the specified widget to be 
dispatched individually to its expose procedure with the 
.S region 
argument set to 
.S NULL.
>># 
>># XtExposeCompressSeries
>>#
>>ASSERTION Good B 0
When a widget in the calling process
has the XtExposeCompressSeries flag set in its widget class 
field compress_exposure, a call to
void XtMainLoop()
shall cause each series of exposure events for the specified widget
to be coalesced into a single event and dispatched to its expose
procedure when an exposure event with count equal to zero occurs.
>># 
>># XtExposeCompressMultiple
>>#
>>ASSERTION Good B 0
When a widget in the calling process
has the XtExposeCompressMultiple flag set in its 
widget class field compress_exposure a call to
void XtMainLoop()
shall cause consecutive series of exposure events 
for the specified widget to be coalesced into a single 
event and dispatched to its expose procedure when an 
exposure event whose count equal to zero is encountered 
and either the event queue is empty or the next event 
is not an exposure event for the specified widget.
>># 
>># XtExposeCompressMaximal
>>#
>>ASSERTION Good B 0
When a widget in the calling process
has the XtExposeCompressMaximal flag set in its widget class 
field compress_exposure a call to
void XtMainLoop()
shall cause all series of exposure events in the queue for the 
specified widget to be coalesced into a single event without regard 
to intervening non-exposure events and dispatched to its expose
procedure.
>># 
>># XtExposeGraphicsExpose
>>#
>>ASSERTION Good B 0
When a widget in the calling process
has the XtExposeNoCompress and the XtExposeGraphicsExpose 
flags set in its widget class field compress_exposure a call to
void XtMainLoop()
shall cause all 
.S GraphicsExpose 
events for the specified widget to be dispatched individually to 
its expose procedure.
>>ASSERTION Good B 0
When a widget in the calling process
has the XtExposeCompressSeries and the XtExposeGraphicsExpose flags 
set in its widget class field compress_exposure a call to
void XtMainLoop()
shall cause each series of 
.S GraphicsExpose
events for the specified widget to be coalesced into a single event 
and dispatched to its expose procedure when a
.S GraphicsExpose
event whose count is equal to zero is encountered.
>>ASSERTION Good B 0
When a widget in the calling process
has the XtExposeCompressMultiple and the XtExposeGraphicsExpose flags 
set in its widget class field compress_exposure a call to
void XtMainLoop()
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
When a widget in the calling process
has the XtExposeCompressMaximal and the XtExposeGraphicsExpose flags 
set in its widget class field compress_exposure a call to
void XtMainLoop()
shall cause all series of 
.S GraphicsExpose
events in the queue for the specified widget
to be coalesced into a single event without regard to intervening 
non-GraphicsExpose events and dispatched to its expose procedure.
>># 
>># XtExposeGraphicsExposeMerged
>>#
>>ASSERTION Good B 0
When a widget in the calling process
has the XtExposeNoCompress and the XtExposeGraphicsExposeMerged 
flags set in its widget class field compress_exposure a call to
void XtMainLoop()
shall cause all exposure and 
.S GraphicsExpose 
events for the specified widget to be dispatched individually to 
its expose procedure.
>>ASSERTION Good B 0
When a widget in the calling process
has the XtExposeCompressSeries and the 
XtExposeGraphicsExposeMerged flags 
set in its widget class field compress_exposure a call to
void XtMainLoop()
shall cause each series of exposure and
.S GraphicsExpose
events for the widget to be coalesced into 
a single event and dispatched to its expose procedure.
>>ASSERTION Good B 0
When a widget in the calling process
has the XtExposeCompressMultiple and the XtExposeGraphicsExposeMerged 
flags set in its widget class field compress_exposure a call to
void XtMainLoop()
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
When a widget in the calling process
has the XtExposeCompressMaximal and the XtExposeGraphicsExposeMerged 
flags set in its widget class field compress_exposure a call to
void XtMainLoop()
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
When a widget in the calling process
has the XtExposeNoExpose flag set with any one 
of XtExposeNoCompress, XtExposeCompressSeries, 
XtExposeCompressMultiple or XtExposeCompressMaximal 
flags set in its widget class field compress_exposure a call to
void XtMainLoop()
shall cause all
.S NoExpose
events for the specified widget to be dispatched 
individually to its expose procedure.
>>ASSERTION Good B 0
When a widget in the calling process
has the visible_interest field in its class record set to
.S True
a call to
void XtMainLoop()
shall dispatch VisibilityUnobscured events to the widget and
set the visible field in the core widget structure to 
.S True.
>>ASSERTION Good B 0
When a widget in the calling process
has the visible_interest field in its class record set to
.S True
a call to
void XtMainLoop()
shall dispatch VisibilityPartiallyObscured events to the widget 
and set the visible field in the core widget structure to 
.S True.
>>ASSERTION Good B 0
When a widget in the calling process
has the visible_interest field in its class record set to
.S True
a call to
void XtMainLoop()
shall dispatch VisibilityFullyObscured events to 
the widget and set the visible field in the core 
widget structure to 
.S False.
>>ASSERTION Good B 0
When a widget in the calling process
has the visible_interest field in its class record set to
.S False
a call to
void XtMainLoop()
shall not dispatch VisibilityUnobscured, 
VisibilityFullyObscured, or VisbilityPartiallyObscured 
events to the widget.
