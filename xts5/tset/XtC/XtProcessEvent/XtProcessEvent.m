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
$Header: /cvs/xtest/xtest/xts5/tset/XtC/XtProcessEvent/XtProcessEvent.m,v 1.2 2005-04-21 09:40:42 ajosey Exp $

Copyright (c) 1999 The Open Group
Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/XtC/XtProcessEvent/XtProcessEvent.m
>># 
>># Description:
>>#	Tests for XtProcessEvent()
>># 
>># Modifications:
>># $Log: tprocevnt.m,v $
>># Revision 1.2  2005-04-21 09:40:42  ajosey
>># resync to VSW5.1.5
>>#
>># Revision 8.2  2005/01/21 12:30:25  gwc
>># Updated copyright notice
>>#
>># Revision 8.1  1999/11/26 12:37:46  vsx
>># avoid fixed file locations (for exec-in-place false)
>>#
>># Revision 8.0  1998/12/23 23:38:29  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:32  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:29:31  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:26:05  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:22:35  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:19:11  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;
Widget labelw_msg;

extern char *event_names[];

XtInputId input_ret;
char *msg = "Hello World";
int acount = 0;
FILE *fid;
char *data = "data1";

/*
** Procedure XtIOP_Proc
*/
void XtIOP_Proc2(client_data, source, id)
XtPointer client_data;
int *source;
XtInputId *id;
{
	avs_set_event(3,1);
}
/*
** Procedure XtEVT_Proc
*/
void XtEVT_Proc(w, client_data, event, continue_to_dispatch)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_dispatch;
{
	if (event->type == ButtonPress) {
		avs_set_event(1,1);
		exit(0);
	}
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
	if (event->type == ButtonPress) {
		avs_set_event(1,1);
	}
	else {
		sprintf(ebuf, "ERROR: Expected ButtonPress event Received \"%s\"", event_names[event->type]);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	sprintf(ebuf, "PREP: Open file %s for read", data);
	tet_infoline(ebuf);
	if ((fid = (FILE *)fopen(data, "w+")) == NULL) {
		sprintf(ebuf, "ERROR: Could not open file %s", data);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("PREP: Register file as an input source");
	input_ret = XtAddInput(fileno(fid), (XtPointer)XtInputReadMask, XtIOP_Proc2, (XtPointer)msg);
}
void XtEVT_Proc3(w, client_data, event, continue_to_dispatch)
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

void XtIOP_Proc(client_data, source, id)
XtPointer client_data;
int *source;
XtInputId *id;
{
	avs_set_event(3,avs_get_event(3)+1);
	exit(0);
}

void XtTMO2_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	avs_set_event(2,1);
	exit(0);
}
void XtTMO1_Proc(client_data, id)
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
	send_event(rowcolw, ButtonRelease, ButtonReleaseMask, TRUE);
	tet_infoline("PREP: Register timeout");
	XtAddTimeOut(AVSXTLOOPTIMEOUT, XtTMO1_Proc, topLevel);
}

>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtProcessEvent XtC
void
XtProcessEvent(mask)
>>ASSERTION Good C
If the implementation is X11R5 or later:
A successful call to 
void XtProcessEvent(mask)
when 
.A mask 
has only the
.S XtIMXEvent
mask set, there is at least one pending X event to be 
processed for the calling process, and the widget to
which the event is to be dispatched has no input method registered
for this event shall call the event handler for this widget.
>>CODE
#if XT_X_RELEASE > 4
char *msg = "Event widget";
pid_t pid2;
int invoked = 0;
Display *display;
XEvent loop_event;
int i;
pid_t pid3;
int pstatus;
#endif

#if XT_X_RELEASE > 4
	FORK(pid3);
	avs_xt_hier_def("Tprocevnt1", "XtProcessEvent");
	FORK(pid2);
	tet_infoline("PREP: Create a test labelw_msg widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Register XtEVT_Proc to handle events to labelw_msg");
	XtAddEventHandler(labelw_msg,
		 ButtonPressMask,
		 False,
		 XtEVT_Proc,
		 (XtPointer)NULL
		 );
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send ButtonPress event over wire to labelw_msg widget");
	send_event(labelw_msg, ButtonPress, ButtonPressMask, TRUE);
	display = XtDisplay(rowcolw);
	/*
	** ButtonRelease to call DestroyTree and cleanup
	*/
	send_event(rowcolw, ButtonRelease, ButtonReleaseMask, TRUE);
	for (i= 0; i == 0;) {
		XtProcessEvent(XtIMXEvent);
	} /*end for */
	LKROF(pid2, AVSXTTIMEOUT-4);
	KROF3(pid3, pstatus, AVSXTTIMEOUT-2);
        if (pstatus != 0) {
		tet_infoline("ERROR: Test process exited abnormally");
		tet_infoline("       May mean display cannot be opened");
		tet_result(TET_UNRESOLVED);
        }
	else {
		tet_infoline("TEST: Procedure XtEVT_Proc was invoked");
		invoked = avs_get_event(1);
		check_dec(1, invoked, "XtEVT_Proc invocation count");
		tet_result(TET_PASS);
	}
#else
	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
>>ASSERTION Good C
If the implementation is X11R4:
A successful call to 
void XtProcessEvent(mask)
when 
.A mask 
has only the
.S XtIMXEvent
mask set and there is at least one pending X event to be 
processed for the calling process shall call the 
event handler for the widget to which the event is to be dispatched.
>>CODE
#if XT_X_RELEASE == 4
char *msg = "Event widget";
pid_t pid2;
int invoked = 0;
Display *display;
XEvent loop_event;
int i;
pid_t pid3;
int pstatus;
#endif

#if XT_X_RELEASE == 4
	FORK(pid3);
	avs_xt_hier_def("Tprocevnt1", "XtProcessEvent");
	FORK(pid2);
	tet_infoline("PREP: Create a test labelw_msg widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Register XtEVT_Proc to handle events to labelw_msg");
	XtAddEventHandler(labelw_msg,
		 ButtonPressMask,
		 False,
		 XtEVT_Proc,
		 (XtPointer)NULL
		 );
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send ButtonPress event over wire to labelw_msg widget");
	send_event(labelw_msg, ButtonPress, ButtonPressMask, TRUE);
	display = XtDisplay(rowcolw);
	/*
	** ButtonRelease to call DestroyTree and cleanup
	*/
	send_event(rowcolw, ButtonRelease, ButtonReleaseMask, TRUE);
	for (i= 0; i == 0;) {
		XtProcessEvent(XtIMXEvent);
	} /*end for */
	LKROF(pid2, AVSXTTIMEOUT-4);
	KROF3(pid3, pstatus, AVSXTTIMEOUT-2);
        if (pstatus != 0) {
		tet_infoline("ERROR: Test process exited abnormally");
		tet_infoline("       May mean display cannot be opened");
		tet_result(TET_UNRESOLVED);
        }
	else {
		tet_infoline("TEST: Procedure XtEVT_Proc was invoked");
		invoked = avs_get_event(1);
		check_dec(1, invoked, "XtEVT_Proc invocation count");
		tet_result(TET_PASS);
	}
#else
	tet_infoline("INFO: Implementation is X11R4");
	tet_result(TET_UNSUPPORTED);
#endif
>>ASSERTION Good A
A successful call to 
void XtProcessEvent(mask)
when 
.A mask 
has only the
.S XtIMXEvent
mask set, there is at least one pending X event to be 
processed for the calling process, and the widget to
which the event is to be dispatched has no event handler registered
shall ignore the event.
>>CODE
char *msg = "Event widget";
pid_t pid2;
int invoked = 0;
Display *display;
XEvent loop_event;
int i;
pid_t pid3;
int pstatus;

	FORK(pid3);
	avs_xt_hier_def("Tprocevnt1", "XtProcessEvent");
	FORK(pid2);
	tet_infoline("PREP: Create a test labelw_msg widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Register XtEVT_Proc to handle ButtonPress to labelw_msg");
	XtAddEventHandler(labelw_msg,
		 ButtonPressMask,
		 False,
		 XtEVT_Proc,
		 (XtPointer)NULL
		 );
	tet_infoline("PREP: Send KeyPress event over wire to labelw_msg widget");
	send_event(labelw_msg, KeyPress, KeyPressMask, TRUE);
	tet_infoline("PREP: Send ButtonPress event over wire to labelw_msg widget");
	send_event(labelw_msg, ButtonPress, ButtonPressMask, TRUE);
	send_event(rowcolw, ButtonRelease, ButtonReleaseMask, TRUE);
	XtAddTimeOut(AVSXTLOOPTIMEOUT, XtTMO1_Proc, NULL);
	display = XtDisplay(rowcolw);
	for (i= 0; i == 0;) {
		XtProcessEvent(XtIMXEvent);
	} /*end for */
	LKROF(pid2, AVSXTTIMEOUT-4);
	KROF3(pid3, pstatus, AVSXTTIMEOUT-2);
        if (pstatus != 0) {
		tet_infoline("ERROR: Test process exited abnormally");
		tet_infoline("       May mean display cannot be opened");
		tet_result(TET_UNRESOLVED);
        }
	else {
		tet_infoline("TEST: Procedure XtEVT_Proc was invoked");
		invoked = avs_get_event(1);
		check_dec(1, invoked, "XtEVT_Proc invocation count");
		tet_result(TET_PASS);
	}
>>ASSERTION Good A
A successful call to 
void XtProcessEvent(mask)
when 
.A mask 
has only the
.S XtIMTimer
mask set and there is at least one pending timer to be 
processed for the calling process shall 
call the callback procedure registered for the timer.
>>CODE
char *msg = "Event widget";
pid_t pid2;
int invoked = 0;
Display *display;
XEvent loop_event;
int i;
pid_t pid3;
int pstatus;

	FORK(pid3);
	avs_xt_hier_def("Tprocevnt1", "XtProcessEvent");
	FORK(pid2);
	tet_infoline("PREP: Create a test labelw_msg widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Register timeout procedure");
	XtAddTimeOut(AVSXTLOOPTIMEOUT, XtTMO2_Proc, NULL);
	display = XtDisplay(rowcolw);
	XtProcessEvent(XtIMTimer);
	LKROF(pid2, AVSXTTIMEOUT-4);
	KROF3(pid3, pstatus, AVSXTTIMEOUT-2);
        if (pstatus != 0) {
		tet_infoline("ERROR: Test process exited abnormally");
		tet_infoline("       May mean display cannot be opened");
		tet_result(TET_UNRESOLVED);
        }
	else {
		tet_infoline("TEST: Timer procedure was invoked");
		invoked = avs_get_event(2);
		check_dec(1, invoked, "timeout procedure invocation count");
		tet_result(TET_PASS);
	}
>>ASSERTION Good A
A successful call to 
void XtProcessEvent(mask)
when 
.A mask 
has only the
.S XtIMAlternateInput
mask set and there is at least one pending input source to be 
processed for the calling process shall 
call the callback procedure registered for the input source.
>>CODE
char *msg = "Event widget";
pid_t pid2;
int invoked = 0;
Display *display;
XEvent loop_event;
int i;
pid_t pid3;
int pstatus;

	FORK(pid3);
	avs_xt_hier_def("Tprocevnt1", "XtProcessEvent");
	sprintf(ebuf, "PREP: Open file %s for read", data);
	tet_infoline(ebuf);
	if ((fid = (FILE *)fopen(data, "w+")) == NULL) {
		sprintf(ebuf, "ERROR: Could not open file %s", data);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("PREP: Register file as an input source");
	input_ret = XtAddInput(fileno(fid), (XtPointer)XtInputReadMask, XtIOP_Proc, (XtPointer)msg);
	FORK(pid2);
	tet_infoline("PREP: Create a test labelw_msg widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Register timeout procedure");
	XtAddTimeOut(AVSXTLOOPTIMEOUT, XtTMO1_Proc, NULL);
	display = XtDisplay(rowcolw);
	XtProcessEvent(XtIMAlternateInput);
	LKROF(pid2, AVSXTTIMEOUT-4);
	unlink(data);
	KROF3(pid3, pstatus, AVSXTTIMEOUT-2);
        if (pstatus != 0) {
		tet_infoline("ERROR: Test process exited abnormally");
		tet_infoline("       May mean display cannot be opened");
		tet_result(TET_UNRESOLVED);
        }
	else {
		tet_infoline("TEST: Input callback was invoked");
		invoked = avs_get_event(3);
		check_dec(1, invoked, "callback invocation count");
		tet_result(TET_PASS);
	}
>>ASSERTION Good A
A successful call to 
void XtProcessEvent(mask)
when 
.A mask 
is the bitwise inclusive OR of any combination of
.S XtIMXEvent,
.S XtIMTimer,
and 
.S XtIMAlternateInput 
shall process any one event or input of the specified types.
>>CODE
char *msg = "Event widget";
pid_t pid2;
int invoked = 0;
Display *display;
XEvent loop_event;
int i;
pid_t pid3;
int pstatus;

	FORK(pid3);
	avs_xt_hier_def("Tprocevnt1", "XtProcessEvent");
	tet_infoline("PREP: Create a test labelw_msg widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Register XtEVT_Proc2 to handle events to labelw_msg");
	XtAddEventHandler(labelw_msg,
		 ButtonPressMask,
		 False,
		 XtEVT_Proc2,
		 (XtPointer)NULL
		 );
	tet_infoline("PREP: Send ButtonPress event over wire to labelw_msg widget");
	send_event(labelw_msg, ButtonPress, ButtonPressMask, TRUE);
	tet_infoline("PREP: Register timeout procedure");
	XtAddTimeOut(AVSXTLOOPTIMEOUT, XtTMO2_Proc, NULL);
	FORK(pid2);
	for (i= 0; i == 0;) {
		XtProcessEvent(XtIMAlternateInput|XtIMXEvent|XtIMTimer);
	}
	LKROF(pid2, AVSXTTIMEOUT-4);
	unlink(data);
	KROF3(pid3, pstatus, AVSXTTIMEOUT-2);
        if (pstatus != 0) {
		tet_infoline("ERROR: Test process exited abnormally");
		tet_infoline("       May mean display cannot be opened");
		tet_result(TET_UNRESOLVED);
        }
	else {
		tet_infoline("TEST: Procedure XtEVT_Proc2 was invoked");
		invoked = avs_get_event(1);
		check_dec(1, invoked, "XtEVT_Proc2 invocation count");
		tet_infoline("TEST: Input callback was invoked");
		invoked = avs_get_event(3);
		check_dec(1, invoked, "callback invocation count");
		tet_infoline("TEST: Timer procedure was invoked");
		invoked = avs_get_event(2);
		check_dec(1, invoked, "timeout procedure invocation count");
		tet_result(TET_PASS);
	}
>>ASSERTION Good A
A successful call to 
void XtProcessEvent(mask)
when 
.A mask 
is
.S XtIMAll
shall be equivalent to a call with mask set to a bitwise 
inclusive OR of
.S XtIMXEvent,
.S XtIMTimer,
and
.S XtIMAlternateInput.
>>CODE
char *msg = "Event widget";
pid_t pid2;
int invoked = 0;
Display *display;
XEvent loop_event;
int i;
pid_t pid3;
int pstatus;

	FORK(pid3);
	avs_xt_hier_def("Tprocevnt1", "XtProcessEvent");
	tet_infoline("PREP: Create a test labelw_msg widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Register XtEVT_Proc2 to handle events to labelw_msg");
	XtAddEventHandler(labelw_msg,
		 ButtonPressMask,
		 False,
		 XtEVT_Proc2,
		 (XtPointer)NULL
		 );
	tet_infoline("PREP: Send ButtonPress event over wire to labelw_msg widget");
	send_event(labelw_msg, ButtonPress, ButtonPressMask, TRUE);
	tet_infoline("PREP: Register timeout procedure");
	XtAddTimeOut(AVSXTLOOPTIMEOUT, XtTMO2_Proc, NULL);
	FORK(pid2);
	for (i= 0; i == 0;) {
		XtProcessEvent(XtIMAll);
	}
	LKROF(pid2, AVSXTTIMEOUT-4);
	unlink(data);
	KROF3(pid3, pstatus, AVSXTTIMEOUT-2);
        if (pstatus != 0) {
		tet_infoline("ERROR: Test process exited abnormally");
		tet_infoline("       May mean display cannot be opened");
		tet_result(TET_UNRESOLVED);
        }
	else {
		tet_infoline("TEST: Procedure XtEVT_Proc2 was invoked");
		invoked = avs_get_event(1);
		check_dec(1, invoked, "XtEVT_Proc2 invocation count");
		tet_infoline("TEST: Input callback was invoked");
		invoked = avs_get_event(3);
		check_dec(1, invoked, "callback invocation count");
		tet_infoline("TEST: Timer procedure was invoked");
		invoked = avs_get_event(2);
		check_dec(1, invoked, "timeout procedure invocation count");
		tet_result(TET_PASS);
	}
>>ASSERTION Good A
A successful call to 
void XtProcessEvent(mask)
when there are no events or inputs of the 
specified types to be processed shall block 
until an appropriate event or input is available.
>>CODE
char *msg = "Event widget";
pid_t pid2;
int invoked = 0;
Display *display;
XEvent loop_event;
int i;
pid_t pid3;
int pstatus;

	FORK(pid3);
	avs_xt_hier_def("Tprocevnt1", "XtProcessEvent");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Register timeout procedure");
	XtAddTimeOut(AVSXTLOOPTIMEOUT, XtTMO2_Proc, NULL);
	FORK(pid2);
	for (i= 0; i == 0;) {
		XtProcessEvent(XtIMAll);
	}
	tet_infoline("ERROR: XtProcessEvent returned rqather than blocking");
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
		check_dec(1, invoked, "timeout procedure invocation count");
		tet_result(TET_PASS);
	}
>># 
>>#  XtDispatchEvent assertions
>>#
>>ASSERTION Good D 0
If the implementation is X11R5 or later:
A successful call to 
void XtProcessEvent(mask)
when 
.A mask 
has only the
.S XtIMXEvent
mask set, there is at least one pending X event to be 
processed for the calling process, and the widget 
to which the event is to be dispatched has an 
input method for this event shall not dispatch 
the event to the widget.
>>ASSERTION Good A
When an event for a widget in the calling process
is a KeyPress, KeyRelease, ButtonPress, ButtonRelease, 
MotionNotify, EnterNotify, LeaveNotify, PropertyNotify
or a SelectionClear event a call to
void XtProcessEvent(mask)
shall record the timestamp from the event as the 
last timestamp value that will be returned by the 
next call to XtLastTimestampProcessed.
>>CODE
char *msg = "Event widget";
pid_t pid2;
int invoked = 0;
Display *display;
XEvent loop_event;
int i;
pid_t pid3;
int pstatus;

	FORK(pid3);
	avs_xt_hier_def("Tprocevnt1", "XtProcessEvent");
	FORK(pid2);
	tet_infoline("PREP: Create a test labelw_msg widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Register XtEVT_Proc3 to handle events to labelw_msg");
	XtAddEventHandler(labelw_msg,
		 ButtonPressMask|ButtonReleaseMask|KeyPressMask|KeyReleaseMask,
		 False,
		 XtEVT_Proc3,
		 (XtPointer)NULL
		 );
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Register timeout procedure which will cause event");
	XtAddTimeOut(AVSXTLOOPTIMEOUT, XtTMO_Proc5, topLevel);
	display = XtDisplay(rowcolw);
	for (i= 0; i == 0;) {
		XtProcessEvent(XtIMAll);
	} /*end for */
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
When an event in the calling process
is a remap event, a modal cascade exists that has 
a widget with spring_loaded field set to
.S True,
and no event input filter has been registered for 
the spring-loaded widget window on the specified 
event a call to
void XtProcessEvent(mask)
shall dispatch the event to the spring-loaded 
widget after a dispatch to the widget to which 
the event belonged.
>>ASSERTION Good D 0
If the implementation is X11R5 or later:
When an event in the calling process
is a remap event, a modal cascade exists that has 
a widget with spring_loaded field set to
.S True,
and an event input filter has been registered 
for the spring-loaded widget window on the specified 
event a call to
void XtProcessEvent(mask)
shall not dispatch the event to the spring-loaded widget.
