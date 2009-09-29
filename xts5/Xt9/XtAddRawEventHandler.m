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
>># File: xts/Xt9/XtAddRawEventHandler.m
>># 
>># Description:
>>#	Tests for XtAddRawEventHandler()
>># 
>># Modifications:
>># $Log: tadrwevhr.m,v $
>># Revision 1.1  2005-02-12 14:38:23  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:37:13  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:00:07  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:28:19  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:53  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:18:51  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:12:15  andy
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
char client_stuff[] = "The quality of mercy is not strained";
/*
** XtEVT1_Proc event handler
*/
void XtEVT1_Proc(w, client_data, event, continue_to_process)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_process;
{
	if ( event->type == ButtonPress )
	avs_set_event(1,1);
	else {
	sprintf(ebuf, "ERROR: Expected ButtonPress event Received %s", event_names[event->type]);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Client_data passed correctly to handler");
	if (strcmp(client_data, client_stuff) != 0) {
		sprintf(ebuf, "ERROR: Expected client_data = %s, received %s", client_stuff, client_data);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	exit(0);
}
/*timeout callback*/
void XtTI1_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	exit(0);
}
/*
** XtEVT2_Proc event handler
*/
void XtEVT2_Proc(w, client_data, event, continue_to_process)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_process;
{
	if ( event->type == ButtonPress )
	avs_set_event(1,1);
	else {
	sprintf(ebuf, "ERROR: Expected ButtonPress event Received %s", event_names[event->type]);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Client_data passed correctly to handler");
	if (strcmp(client_data, client_stuff) != 0) {
		sprintf(ebuf, "ERROR: Expected client_data = %s, received %s", client_stuff, client_data);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	exit(0);
}
/*timeout callback*/
void XtTI2_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	exit(0);
}
/*
** Handler XtEVT3_Head
*/
void XtEVT3_Head(w, client_data, event, continue_to_process)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_process;
{
	if ( event->type == ButtonPress )
	avs_set_event(1,1);
	else {
	sprintf(ebuf, "ERROR: Expected ButtonPress event Received %s", event_names[event->type]);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
}
/*
** Handler XtEVT3_Tail
*/
void XtEVT3_Tail(w, client_data, event, continue_to_process)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_process;
{
	if ( event->type == ButtonPress )
	avs_set_event(2,1);
	else {
	sprintf(ebuf, "ERROR: Expected ButtonPress event Received %s", event_names[event->type]);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
}
/*timeout callback*/
void XtTI3_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	exit(0);
}
/*
** Event handler XtEVT4_Proc
*/
void XtEVT4_Proc(w, client_data, event, continue_to_process)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_process;
{
	switch(event->type)
	{
	case ButtonPress:
		avs_set_event(1,avs_get_event(1)+1);
		break;
	case ButtonRelease:
		avs_set_event(2,avs_get_event(2)+1);
		exit(0);
	default:
	 sprintf(ebuf, "ERROR: Expected ButtonPress/ButtonRelease event Received %s", event_names[event->type]);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	} /* end switch */
}
/*timeout callback*/
void XtTI4_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	exit(0);
}
/*
** XtEVT5_Proc event handler
*/
void XtEVT5_Proc(w, client_data, event, continue_to_process)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_process;
{
	if (event->type == ButtonPress )
		avs_set_event(1,avs_get_event(1)+1);
	else {
		sprintf(ebuf, "ERROR: Expected ButtonPress event Received %s", event_names[event->type]);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
}
/*timeout callback*/
void XtTI5_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	exit(0);
}
/*
** Handler XtEVT6_Proc
*/
void XtEVT6_Proc(w, client_data, event, continue_to_process)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_process;
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
		sprintf(ebuf, "ERROR: Expected non-maskable event, received %s", event_names[event->type]);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	} /* end switch */
}
/*timeout callback*/
void XtTI6_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	exit(0);
}
void XtEVT_ProcA(w, client_data, event, continue_to_process)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_process;
{
	if (event->type == ButtonPress) {
		avs_set_event(1,1);
		tet_infoline("TEST: Send KeyPress over wire");
		/*TRUE in last argument causes XSelectInput*/
		send_event(labelw_msg, KeyPress, KeyPressMask, TRUE);
		*continue_to_process=True;
		return;
	}
	if (event->type == KeyPress ) {
		avs_set_event(2,1);
		return;
	}
	sprintf(ebuf, "ERROR: Expected ButtonPress or KeyPress event, received %s", event_names[event->type]);
	tet_infoline(ebuf);
	tet_result(TET_FAIL);
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtAddRawEventHandler Xt9
void
XtAddRawEventHandler(w, event_mask, nonmaskable, proc, client_data)
>>ASSERTION Good A
A successful call to 
void XtAddRawEventHandler(w, event_mask, nonmaskable, proc, client_data)
shall register 
.A proc 
as the procedure that will be called
when an event matching 
.A event_mask 
is dispatched to the widget
.A w.
>>CODE
char *msg = "Event widget";
pid_t pid2;
int status;

	FORK(pid2);
	avs_xt_hier("Tadrwevhr1", "XtAddRawEventHandler");
	tet_infoline("PREP: Create a test labelw_msg widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Register raw event handler");
	XtAddRawEventHandler(labelw_msg, ButtonPressMask, False, XtEVT1_Proc,
		 client_stuff);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTI1_Proc, NULL);
	tet_infoline("TEST: Send ButtonPress over wire to widget labelw_msg");
	/*TRUE in last argument causes XSelectInput*/
	send_event(labelw_msg, ButtonPress, ButtonPressMask, TRUE);
	tet_infoline("TEST: Event handler was invoked");
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	status = avs_get_event(1);
	check_dec(1, status, "handler invocations count");
	tet_result(TET_PASS);
>>ASSERTION Good A
A call to 
void XtAddRawEventHandler(w, event_mask, nonmaskable, proc, client_data)
shall not modify the event_mask attribute of the widget window.
>>CODE
char *msg = "Event widget";
pid_t pid2;
int status;

	FORK(pid2);
	avs_xt_hier("Tadrwevhr2", "XtAddRawEventHandler");
	tet_infoline("PREP: Create a test labelw_msg widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Register raw event handler");
	XtAddRawEventHandler(labelw_msg, ButtonPressMask, False, XtEVT2_Proc,
		 client_stuff);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTI2_Proc, NULL);
	tet_infoline("TEST: Send ButtonPress over wire to widget labelw_msg without selecting");
	/*FALSE in last argument causes no XSelectInput*/
	send_event(labelw_msg, ButtonPress, ButtonPressMask, FALSE);
	tet_infoline("TEST: Event handler was not invoked");
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	status = avs_get_event(1);
	check_dec(0, status, "handler invocations count");
	tet_result(TET_PASS);
>>ASSERTION Good A
When multiple procedures are registered for the widget 
.A w 
on the same event by calls to
void XtAddRawEventHandler(w, event_mask, nonmaskable, proc, client_data)
the procedures shall be called in an indeterminate order when the
specified event is dispatched to the widget.
>>CODE
char *msg = "Event widget";
int head, tail;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tadrwevhr3", "XtAddRawEventHandler");
	tet_infoline("PREP: Create a test labelw_msg widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Register a button press handler");
	XtAddRawEventHandler(labelw_msg, ButtonPressMask, False, XtEVT3_Head,
		 (XtPointer)NULL);
	tet_infoline("PREP: Register another button press handler");
	XtAddRawEventHandler(labelw_msg, ButtonPressMask, False, XtEVT3_Tail,
		 (XtPointer)NULL);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTI3_Proc, NULL);
	tet_infoline("PREP: Send ButtonPress event");
	send_event(labelw_msg, ButtonPress, ButtonPressMask, TRUE);
	tet_infoline("TEST: Both handlers were invoked");
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	head = avs_get_event(1);
	check_dec(1, head, "XtEVT3_Head invoked status");
	tail = avs_get_event(2);
	check_dec(1, tail, "XtEVT3_Tail invoked status");
	tet_result(TET_PASS);
>>ASSERTION Good A
On a call to 
void XtAddRawEventHandler(w, event_mask, nonmaskable, proc, client_data)
when the specified procedure/client data pair has
already been registered for the widget
.A w, 
.A event_mask 
shall augment the event mask already in place for the
procedure
.A proc.
>>CODE
char *msg = "Event widget";
int status1, status2;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tadrwevhr4", "XtAddRawEventHandler");
	tet_infoline("PREP: Create a test labelw_msg widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Register XtEVT4_Proc to handle ButtonPress events");
	XtAddRawEventHandler(labelw_msg,
		 ButtonPressMask,
		 False,
		 XtEVT4_Proc,
		 (XtPointer)NULL
		 );
	tet_infoline("PREP: Register it to handle ButtonRelease events");
	XtAddRawEventHandler(labelw_msg,
		 ButtonReleaseMask,
		 False,
		 XtEVT4_Proc,
		 (XtPointer)NULL
		 );
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTI4_Proc, NULL);
	tet_infoline("PREP: Send ButtonPress event over wire");
	send_event(labelw_msg, ButtonPress, ButtonPressMask, TRUE);
	tet_infoline("PREP: Send ButtonRelease event over wire");
	send_event(labelw_msg,ButtonRelease,ButtonReleaseMask, TRUE);
	tet_infoline("TEST: Handler invoked once per event");
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	status1 = avs_get_event(1);
	check_dec(1, status1, "invoked for ButtonPress count");
	status2 = avs_get_event(2);
	check_dec(1, status2, "invoked for ButtonPress count");
	tet_result(TET_PASS);
>>ASSERTION Good A
When the procedure 
.A proc
is registered for an event by multiple calls to
void XtAddRawEventHandler(w, event_mask, nonmaskable, proc, client_data)
with different values for 
.A client_data
the procedure shall be called multiple times with the corresponding 
values of
.A client_data
as argument when the specified event is dispatched to the widget.
>>CODE
char *msg = "Event widget";
pid_t pid2;
int status;

	FORK(pid2);
	avs_xt_hier("Tadrwevhr5", "XtAddRawEventHandler");
	tet_infoline("PREP: Create a test labelw_msg widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Register raw event handler twice ");
	XtAddRawEventHandler(labelw_msg, ButtonPressMask, False, XtEVT5_Proc,
		 client_stuff);
	XtAddRawEventHandler(labelw_msg, ButtonPressMask, False, XtEVT5_Proc,
		 NULL);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTI5_Proc, NULL);
	tet_infoline("TEST: Send ButtonPress over wire to widget labelw_msg");
	/*TRUE in last argument causes XSelectInput*/
	send_event(labelw_msg, ButtonPress, ButtonPressMask, TRUE);
	tet_infoline("TEST: Event handler was invoked twice");
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	status = avs_get_event(1);
	check_dec(2, status, "handler invocations count");
	tet_result(TET_PASS);
>>ASSERTION Good A
When nonmaskable is set True a call to
void XtAddRawEventHandler(w, event_mask, nonmaskable, proc, client_data)
shall register 
.A proc
as the procedure that will be called when 
non-maskable events are dispatched 
to the specified widget.
>>CODE
char *msg = "Event widget";
pid_t pid2;
int status1, status2;

	FORK(pid2);
	avs_xt_hier("Tadrwevhr6", "XtAddRawEventHandler");
	tet_infoline("PREP: Create a test labelw_msg widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Register handler for KeyPress events");
	tet_infoline("PREP: to labelw_msg widget");
	XtAddRawEventHandler(labelw_msg, KeyPressMask, True, XtEVT6_Proc,
		 (XtPointer)NULL);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTI6_Proc, NULL);
	tet_infoline("PREP: Send nonmaskable events over wire");
	send_event(labelw_msg, GraphicsExpose, GCGraphicsExposures, TRUE);
	send_event(labelw_msg, NoExpose, GCGraphicsExposures, TRUE);
	tet_infoline("TEST: Handler invoked for non-maskable events");
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	status1 = avs_get_event(1);
	check_dec(1, status1, "GraphicsExpose event count");
	status2 = avs_get_event(2);
	check_dec(1, status2, "NoExpose event count");
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to
void XtAddRawEventHandler(w, event_mask, nonmaskable, 
proc, client_data)
when 
.A event_mask
specifies multiple events shall register 
.A proc
as the procedure that will be called for each specified event.
>>CODE
char *msg = "Event widget";
pid_t pid2;
int status;

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tadrwevhr1", "XtAddRawEventHandler");
	tet_infoline("PREP: Create a test labelw_msg widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Register raw event handler");
	XtAddRawEventHandler(labelw_msg, ButtonPressMask|KeyPressMask, False, XtEVT_ProcA, client_stuff);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTI1_Proc, NULL);
	tet_infoline("TEST: Send ButtonPress over wire to widget labelw_msg");
	/*TRUE in last argument causes XSelectInput*/
	send_event(labelw_msg, ButtonPress, ButtonPressMask, TRUE);
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Event handler was invoked for ButtonPress");
	status = avs_get_event(1);
	check_dec(1, status, "handler ButtonPress invocations count");
	tet_infoline("TEST: Event handler was invoked for KeyPress");
	status = avs_get_event(2);
	check_dec(1, status, "handler KeyPress invocations count");
	tet_result(TET_PASS);
>>ASSERTION Good A
When a procedure is registered with multiple calls to
void XtAddRawEventHandler(w, event_mask, nonmaskable, 
proc, client_data)
with the same client data it shall be registered only once
for each event specified in the
.A event_mask
parameter of the calls.
>>CODE
char *msg = "Event widget";
pid_t pid2;
int status;

	FORK(pid2);
	avs_xt_hier("Tadrwevhr1", "XtAddRawEventHandler");
	tet_infoline("PREP: Create a test labelw_msg widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Register raw event handler");
	XtAddRawEventHandler(labelw_msg, ButtonPressMask, False, XtEVT5_Proc,
		 client_stuff);
	tet_infoline("PREP: Register raw event handler again");
	XtAddRawEventHandler(labelw_msg, ButtonPressMask, False, XtEVT5_Proc,
		 client_stuff);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTI1_Proc, NULL);
	tet_infoline("TEST: Send ButtonPress over wire to widget labelw_msg");
	/*TRUE in last argument causes XSelectInput*/
	send_event(labelw_msg, ButtonPress, ButtonPressMask, TRUE);
	tet_infoline("TEST: Event handler was invoked just once");
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	status = avs_get_event(1);
	check_dec(1, status, "handler invocations count");
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to
void XtAddRawEventHandler(w, event_mask, nonmaskable, 
proc, client_data)
shall cause
.A client_data
to be passed to
.A proc
when it is invoked.
>>CODE
char *msg = "Event widget";
pid_t pid2;
int status;

	FORK(pid2);
	avs_xt_hier("Tadrwevhr1", "XtAddRawEventHandler");
	tet_infoline("PREP: Create a test labelw_msg widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Register raw event handler");
	XtAddRawEventHandler(labelw_msg, ButtonPressMask, False, XtEVT1_Proc,
		 client_stuff);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTI1_Proc, NULL);
	tet_infoline("TEST: Send ButtonPress over wire to widget labelw_msg");
	/*TRUE in last argument causes XSelectInput*/
	send_event(labelw_msg, ButtonPress, ButtonPressMask, TRUE);
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Event handler was invoked");
	status = avs_get_event(1);
	check_dec(1, status, "handler invocations count");
	tet_result(TET_PASS);
