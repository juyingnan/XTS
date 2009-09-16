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

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: xts/Xt9/XtAddEventHandler/XtAddEventHandler.m
>># 
>># Description:
>>#	Tests for XtAddEventHandler()
>># 
>># Modifications:
>># $Log: tadevnthr.m,v $
>># Revision 1.1  2005-02-12 14:38:23  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:37:11  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:00:05  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:28:17  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:52  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:18:44  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:12:06  andy
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

/*
** Procedure XtEVT1
*/
void XtEVT1(w, client_data, event, continue_to_dispatch)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_dispatch;
{
	if ( event->type == ButtonPress ) {
		avs_set_event(1,avs_get_event(1)+1);
		exit(0);
	}
	else {
		sprintf(ebuf, "ERROR: Expected ButtonPress event Received %s", event_names[event->type]);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
}
/*
** XtTMO1_Proc procedure
*/
void XtTMO1_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	exit(0);
}

/*
** Handler XtEVT_Head
*/
void XtEVT_Head(w, client_data, event, continue_to_dispatch)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_dispatch;
{
	if ( event->type == ButtonPress )
		avs_set_event(1,avs_get_event(1)+1);
	else {
		sprintf(ebuf, "ERROR: Expected ButtonPress event Received %s", event_names[event->type]);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
}
/*
** Handler XtEVT_Tail
*/
void XtEVT_Tail(w, client_data, event, continue_to_dispatch)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_dispatch;
{
	if ( event->type == ButtonPress )
		avs_set_event(2,avs_get_event(2)+1);
	else {
		sprintf(ebuf, "ERROR: Expected ButtonPress event Received %s", event_names[event->type]);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
}
/*
** XtTMO2_Proc procedure
*/
void XtTMO2_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	exit(0);
}
/*
** Event handler XtEVT_Proc
*/
void XtEVT3_Proc(w, client_data, event, continue_to_dispatch)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_dispatch;
{
	switch(event->type) 
	{
	case ButtonPress: 
		avs_set_event(1,avs_get_event(1)+1);
		break;
	case ButtonRelease: 
		avs_set_event(2,avs_get_event(2)+1);
		break;
	default: 
		sprintf(ebuf, "ERROR: Expected ButtonPress/ButtonRelease event. Received %s", event_names[event->type]);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	} /* end switch */
}
/*
** XtTMO3_Proc procedure
*/
void XtTMO3_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	exit(0);
}

/*
** Handler XtEVT_Proc
*/
void XtEVT4_Proc(w, client_data, event, continue_to_dispatch)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_dispatch;
{
	switch(event->type) 
	{
	case GraphicsExpose: 
		avs_set_event(1,1);
		break;
	case NoExpose: 
		avs_set_event(2,1);
		exit(0);
	default: 
		sprintf(ebuf, "ERROR: Expected GraphicsExpose/NoExpose event Received %s", event_names[event->type]);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	} /* end switch */
}
/*
** XtTMO4_Proc procedure
*/
void XtTMO4_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	exit(0);
}

char client_stuff[] = "The quality of mercy is not strained";
/*
** XtEVT_Proc event handler
*/
void XtEVT5_Proc(w, client_data, event, continue_to_dispatch)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_dispatch;
{
	if ( event->type == ButtonPress )
	avs_set_event(1,avs_get_event(1)+1);
	else {
	sprintf(ebuf, "ERROR: Expected ButtonPress event Received %s", event_names[event->type]);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
}
/*timeout callback*/
void XtTMO5_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	exit(0);
}

/*
** Procedure XtEVT_Proc
*/
void XtEVT6_Proc(w, client_data, event, continue_to_dispatch)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_dispatch;
{
	if ( event->type == ButtonPress ) {
		avs_set_event(1,avs_get_event(1)+1);
		exit(0);
	}
	else {
		sprintf(ebuf, "ERROR: Expected ButtonPress event Received %s", event_names[event->type]);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
}
/*
** XtTMO6_Proc procedure
*/
void XtTMO6_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	exit(0);
}
void XtEVT_Proc7(w, client_data, event, continue_to_dispatch)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_dispatch;
{
	avs_set_event(1,avs_get_event(1)+1);
}
void XtEVT_Proc6(w, client_data, event, continue_to_dispatch)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_dispatch;
{
	avs_set_event(1,avs_get_event(1)+1);
	tet_infoline("TEST: client_data passed to handler");
	if (strcmp(client_data, client_stuff) != 0) {
		sprintf(ebuf, "ERROR: Expected client_data \"%s\", receoved \"%s\"", client_data, client_stuff);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	exit(0);
}

>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtAddEventHandler Xt9
void
XtAddEventHandler(w, event_mask, nonmaskable, proc, client_data)
>>ASSERTION Good A
A successful call to 
void XtAddEventHandler(w, event_mask, nonmaskable, proc, client_data)
shall register proc as the procedure that will be called
when an event matching 
.A event_mask 
is dispatched to the widget
.A w.
>>CODE
Widget labelw_msg;
char *msg = "Event widget";
pid_t pid2;
int status = 0;
pid_t pid3;
int pstatus;

	FORK(pid3);
	avs_xt_hier_def("Tadevnthr1", "XtAddEventHandler");
	tet_infoline("PREP: Create a test labelw_msg widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: XtEVT1 to handle events to labelw_msg");
	XtAddEventHandler(labelw_msg,
		 ButtonPressMask,
		 False,
		 XtEVT1,
		 (XtPointer)NULL
		 );
	XtAddTimeOut(AVSXTLOOPTIMEOUT, XtTMO1_Proc, topLevel);
	tet_infoline("TEST: Send ButtonPress over wire to widget labelw_msg");
	send_event(labelw_msg, ButtonPress, ButtonPressMask, FALSE);
	FORK(pid2);
	XtMainLoop();
	LKROF(pid2, AVSXTTIMEOUT-4);
	KROF3(pid3, pstatus, AVSXTTIMEOUT-2);
        if (pstatus != 0) {
		tet_infoline("ERROR: Test process exited abnormally");
		tet_infoline("       May mean display cannot be opened");
		tet_result(TET_UNRESOLVED);
        }
	else {
		tet_infoline("TEST: Event handler was called");
		status = avs_get_event(1);
		check_dec(1, status, "XtEVT1 invocation count");
		tet_result(TET_PASS);
	}
>>ASSERTION Good A
When multiple procedures are registered for the widget 
.A w 
on the same event by calls to
void XtAddEventHandler(w, event_mask, nonmaskable, proc, client_data)
the procedures shall be called in an indeterminate order when the
specified event is dispatched to the widget.
>>CODE
Widget labelw_msg;
char *msg = "Event widget";
int head = 0;
int tail = 0;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier_def("Tadevnthr2", "XtAddEventHandler");
	tet_infoline("PREP: Create a test labelw_msg widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Register button press handler");
	XtAddEventHandler(labelw_msg,
		 ButtonPressMask,
		 False,
		 XtEVT_Head,
		 (XtPointer)NULL
		 );
	tet_infoline("PREP: Register another button press handler");
	XtAddEventHandler(labelw_msg,
		 ButtonPressMask,
		 False,
		 XtEVT_Tail,
		 (XtPointer)NULL
		 );
	tet_infoline("PREP: Register timeout");
	XtAddTimeOut(AVSXTLOOPTIMEOUT, XtTMO2_Proc, topLevel);
	tet_infoline("TEST: Send ButtonPress event");
	send_event(labelw_msg, ButtonPress, ButtonPressMask, FALSE);
	XtMainLoop();
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Both handlers invoked");
	head = avs_get_event(1);
	check_dec(1, head, "XtEVT_Head invocation count");
	tail = avs_get_event(2);
	check_dec(1, tail, "XtEVT_Tail invocation count");
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to
void XtAddEventHandler(w, event_mask, nonmaskable, proc, client_data)
when 
.A event_mask
specifies multiple events shall register 
.A proc
as the procedure that will be called for each specified event.
>>CODE
Widget labelw_msg;
char *msg = "Event widget";
int status1, status2;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier_def("Tadevnthr3", "XtAddEventHandler");
	tet_infoline("PREP: Create a test labelw_msg widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Register XtEVT_Proc to handle ButtonPress events");
	XtAddEventHandler(labelw_msg,
		 ButtonPressMask,
		 False,
		 XtEVT3_Proc,
		 (XtPointer)NULL
		 );
	tet_infoline("PREP: Register XtEVT_Proc to handle ButtonRelease events");
	XtAddEventHandler(labelw_msg,
		 ButtonReleaseMask,
		 False,
		 XtEVT3_Proc,
		 (XtPointer)NULL
		 );
	tet_infoline("PREP: Register timeout");
	XtAddTimeOut(AVSXTLOOPTIMEOUT, XtTMO3_Proc, topLevel);
	tet_infoline("TEST: Send ButtonPress event");
	send_event(labelw_msg, ButtonPress, ButtonPressMask, FALSE);
	tet_infoline("TEST: Send ButtonRelease event");
	send_event(labelw_msg,ButtonRelease,ButtonReleaseMask, FALSE);
	XtMainLoop();
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Procedure XtEVT3_Proc was invoked for each event.");
	status1 = avs_get_event(1);
	check_dec(1, status1, "times handler was invoked for ButtonPress");
	status2 = avs_get_event(2);
	check_dec(1, status2, "times handler was invoked for ButtonRelease");
	tet_result(TET_PASS);
>>ASSERTION Good A
When nonmaskable is set True a call to
void XtAddEventHandler(w, event_mask, nonmaskable, proc, client_data)
shall register 
.A proc
as the procedure that will be called when non-maskable events
are dispatched to the specified widget.
>>CODE
Widget labelw_msg;
char *msg = "Event widget";
pid_t pid2;
int status1, status2;

	FORK(pid2);
	avs_xt_hier_def("Tadevnthr4", "XtAddEventHandler");
	tet_infoline("PREP: Create a test labelw_msg widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Register XtEVT_Proc to handle KeyPress and non-maskable events");
	tet_infoline("PREP: to labelw_msg widget");
	XtAddEventHandler(labelw_msg,
		 KeyPressMask,
		 True,
		 XtEVT4_Proc,
		 (XtPointer)NULL
		 );
	XtAddTimeOut(AVSXTLOOPTIMEOUT, XtTMO4_Proc, topLevel);
	tet_infoline("TEST: Send nonmaskable events");
	send_event(labelw_msg, GraphicsExpose, GCGraphicsExposures, TRUE);
	send_event(labelw_msg, NoExpose, GCGraphicsExposures, TRUE);
	XtMainLoop();
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Check XtEVT4_Proc was invoked.");
	status1 = avs_get_event(1);
	check_dec(1, status1, "XtEV4T_Proc invocation count");
	status2 = avs_get_event(2);
	check_dec(1, status2, "XtEVT4_Proc invocation count");
	tet_result(TET_PASS);
>>ASSERTION Good A
When the procedure 
.A proc
is registered for an event by multiple calls to
void XtAddEventHandler(w, event_mask, nonmaskable, proc, client_data)
with different values for 
.A client_data
the procedure shall be called multiple times with the corresponding 
values of
.A client_data
as argument when the specified event is dispatched to the widget.
>>CODE
Widget labelw_msg;
char *msg = "Event widget";
pid_t pid2;
int status;

	FORK(pid2);
	avs_xt_hier("Tadevnthr5", "XtAddEventHandler");
	tet_infoline("PREP: Create a test labelw_msg widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Register raw event handler twice ");
	XtAddEventHandler(labelw_msg, ButtonPressMask, False, XtEVT5_Proc,
		 client_stuff);
	XtAddEventHandler(labelw_msg, ButtonPressMask, False, XtEVT5_Proc,
		 NULL);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTMO5_Proc, NULL);
	tet_infoline("TEST: Send ButtonPress over wire to widget labelw_msg");
	send_event(labelw_msg, ButtonPress, ButtonPressMask, FALSE);
	tet_infoline("TEST: Event handler was invoked twice.");
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	status = avs_get_event(1);
	check_dec(2, status, "handler invocation count");
	tet_result(TET_PASS);
>>ASSERTION Good A
When the widget
.A w 
is realized a successful call to 
void XtAddEventHandler(w, event_mask, nonmaskable, proc, client_data)
shall modify the event_mask attribute of the widget window.
>>CODE
Widget labelw_msg;
char *msg = "Event widget";
pid_t pid2;
int status = 0;

	FORK(pid2);
	avs_xt_hier_def("Tadevnthr6", "XtAddEventHandler");
	tet_infoline("PREP: Create a test labelw_msg widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: XtEVT_Proc to handle events to labelw_msg");
	XtAddEventHandler(labelw_msg,
		 ButtonPressMask,
		 False,
		 XtEVT6_Proc,
		 (XtPointer)NULL
		 );
	XtAddTimeOut(AVSXTLOOPTIMEOUT, XtTMO6_Proc, topLevel);
	tet_infoline("TEST: Send ButtonPress over wire to widget labelw_msg");
	/*FALSE in last argument indicates to not select here*/
	send_event(labelw_msg, ButtonPress, ButtonPressMask, FALSE);
	XtMainLoop();
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Check event handler was called");
	status = avs_get_event(1);
	check_dec(1, status, "XtEVT6_Proc invocation count");
	tet_result(TET_PASS);
>>ASSERTION Good A
When a procedure is registered with multiple calls to
void XtAddEventHandler(w, event_mask, nonmaskable, proc, client_data)
with the same client data it shall be registered only once
for each event specified in the
.A event_mask
parameter of the calls.
>>CODE
Widget labelw_msg;
char *msg = "Event widget";
pid_t pid2;
int status = 0;
pid_t pid3;
int pstatus;

	FORK(pid3);
	avs_xt_hier_def("Tadevnthr1", "XtAddEventHandler");
	tet_infoline("PREP: Create a test labelw_msg widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Registed handler");
	XtAddEventHandler(labelw_msg,
		 ButtonPressMask,
		 False,
		 XtEVT_Proc7,
		 client_stuff
		 );
	tet_infoline("PREP: Registed handler again");
	XtAddEventHandler(labelw_msg,
		 ButtonPressMask,
		 False,
		 XtEVT_Proc7,
		 client_stuff
		 );
	XtAddTimeOut(AVSXTLOOPTIMEOUT, XtTMO1_Proc, topLevel);
	tet_infoline("TEST: Send ButtonPress over wire to widget labelw_msg");
	send_event(labelw_msg, ButtonPress, ButtonPressMask, FALSE);
	FORK(pid2);
	XtMainLoop();
	LKROF(pid2, AVSXTTIMEOUT-4);
	KROF3(pid3, pstatus, AVSXTTIMEOUT-2);
        if (pstatus != 0) {
		tet_infoline("ERROR: Test process exited abnormally");
		tet_infoline("       May mean display cannot be opened");
		tet_result(TET_UNRESOLVED);
        }
	else {
		tet_infoline("TEST: Event handler was called just once");
		status = avs_get_event(1);
		check_dec(1, status, "handler invocations count");
		tet_result(TET_PASS);
	}
>>ASSERTION Good A
A successful call to
void XtAddEventHandler(w, event_mask, nonmaskable, proc, client_data)
shall cause
.A client_data
to be passed to
.A proc
when it is invoked.
>>CODE
Widget labelw_msg;
char *msg = "Event widget";
pid_t pid2;
int status = 0;
pid_t pid3;
int pstatus;

	FORK(pid3);
	avs_xt_hier_def("Tadevnthr1", "XtAddEventHandler");
	tet_infoline("PREP: Create a test labelw_msg widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Registed handler");
	XtAddEventHandler(labelw_msg,
		 ButtonPressMask,
		 False,
		 XtEVT_Proc6,
		 client_stuff
		 );
	XtAddTimeOut(AVSXTLOOPTIMEOUT, XtTMO1_Proc, topLevel);
	tet_infoline("TEST: Send ButtonPress over wire to widget labelw_msg");
	send_event(labelw_msg, ButtonPress, ButtonPressMask, FALSE);
	FORK(pid2);
	XtMainLoop();
	LKROF(pid2, AVSXTTIMEOUT-4);
	KROF3(pid3, pstatus, AVSXTTIMEOUT-2);
        if (pstatus != 0) {
		tet_infoline("ERROR: Test process exited abnormally");
		tet_infoline("       May mean display cannot be opened");
		tet_result(TET_UNRESOLVED);
        }
	else {
		tet_infoline("TEST: Event handler was called");
		status = avs_get_event(1);
		check_dec(1, status, "handler invocations count");
		tet_result(TET_PASS);
	}
