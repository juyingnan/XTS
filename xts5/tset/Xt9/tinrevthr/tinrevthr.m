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
$Header: /cvs/xtest/xtest/xts5/tset/Xt9/tinrevthr/tinrevthr.m,v 1.1 2005-02-12 14:38:24 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt9/tinrevthr/tinrevthr.m
>># 
>># Description:
>>#	Tests for XtInsertRawEventHandler()
>># 
>># Modifications:
>># $Log: tinrevthr.m,v $
>># Revision 1.1  2005-02-12 14:38:24  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:37:14  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:00:09  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:28:20  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:54  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:18:55  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:12:21  andy
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

char client_stuff[] = "The quality of mercy is not strained";

/*
** XtEVT1_InsertRawHead
*/
void XtEVT1_InsertRawHead(w, client_data, event, continue_to_process)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_process;
{
	if ( event->type == ButtonPress ) {
	avs_set_event(1,1);
	}
	else {
	sprintf(ebuf, "ERROR: Expected ButtonPress event Received %s", event_names[event->type]);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
		exit(0);
	}
	tet_infoline("TEST: Client_data is passed correctly");
	if (strcmp(client_data, client_stuff) != 0) {
		sprintf(ebuf, "ERROR: Expected client_data = %s, received %s", client_stuff, client_data);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
		exit(0);
	}
}
/*
** XtEVT1_Proc
*/
void XtEVT1_Proc(w, client_data, event, continue_to_process)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_process;
{
	if ( event->type == ButtonPress ) {
	if (avs_get_event(1) != 0) {
	 	avs_set_event(2,1);
		exit(0);
	}
	else {
	 	sprintf(ebuf, "ERROR: XtEVT1_InsertRawHead should be invoked before XtEVT_Proc");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
		exit(0);
	}
	} else {
		sprintf(ebuf, "ERROR: Expected ButtonPress event Received %s", event_names[event->type]);
	tet_infoline(ebuf);
	tet_result(TET_FAIL);
	exit(0);
	}
}
/*
** Procedure XtEVT2_Proc
*/
void XtEVT2_Proc(w, client_data, event, continue_to_process)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_process;
{
	if ( event->type == ButtonPress ) {
	avs_set_event(1,1);
	} else {
	sprintf(ebuf, "ERROR: Expected ButtonPress event Received %s", event_names[event->type]);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
		exit(0);
	}
}
/*
** Procedure XtEVT2_InsertTail
*/
void XtEVT2_InsertRawTail(w, client_data, event, continue_to_process)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_process;
{
	if (event->type == ButtonPress ) {
	if (avs_get_event(1) != 0) {
	 	avs_set_event(2,1);
	}
	else {
	 sprintf(ebuf, "ERROR: XtEVT2_Proc should be invoked before XtEVT_InsertRawTail");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	}
	else {
	sprintf(ebuf, "ERROR: Expected ButtonPress event Received %s", event_names[event->type]);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Client_data is passed correctly");
	if (strcmp(client_data, client_stuff) != 0) {
		sprintf(ebuf, "ERROR: Expected client_data = %s, received %s", client_stuff, client_data);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	exit(0);
}
/*
** Event handler XtEVT3_Proc2
*/
void XtEVT3_Proc2(w, client_data, event, continue_to_process)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_process;
{
	switch(event->type) 
	{
	case ButtonPress: 
		avs_set_event(2,avs_get_event(1)+1);
		break;
	case ButtonRelease: 
		avs_set_event(4,avs_get_event(3)+1);
		break;
	default: 
		sprintf(ebuf, "ERROR: Expected ButtonPress/ButtonRelease event. Received %s", event_names[event->type]);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	} /* end switch */
}

/*
** Event handler XtEVT3_Proc
*/
void XtEVT3_Proc(w, client_data, event, continue_to_process)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_process;
{
	switch(event->type) 
	{
	case ButtonPress: 
		avs_set_event(1,avs_get_event(2)+1);
		break;
	case ButtonRelease: 
		avs_set_event(3,avs_get_event(4)+1);
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
** Handler XtEVT4_Proc
*/
void XtEVT4_Proc(w, client_data, event, continue_to_process)
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

/*
** XtEVT5_Proc event handler
*/
void XtEVT5_Proc(w, client_data, event, continue_to_process)
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
void XtTMO5_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	avs_set_event(1,0);
	exit(0);
}

/*
** Handler XtEVT6_Head
*/
void XtEVT6_Head(w, client_data, event, continue_to_process)
Widget w;
XtPointer client_data ;
XEvent *event ;
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
** Handler XtEVT6_Tail
*/
void XtEVT6_Tail(w, client_data, event, continue_to_process)
Widget w;
XtPointer client_data ;
XEvent *event ;
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
void XtTMO6_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	exit(0);
}

/*
** XtEVT7_Proc event handler
*/
void XtEVT7_Proc(w, client_data, event, continue_to_process)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_process;
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
void XtTMO7_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	exit(0);
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtInsertRawEventHandler Xt9
void
XtInsertRawEventHandler(w, event_mask, nonmaskable, proc, client_data, position)
>>ASSERTION Good A
When 
.A position 
is
XtListHead
a successful call to
void XtInsertRawEventHandler(w, event_mask, nonmaskable, proc, 
client_data, position)
shall register proc as the procedure that will be called, before
any other previously registered procedure when an event matching 
event_mask is dispatched to the widget
.A w.
>>CODE
Widget labelw_msg;
char *msg = "Event widget";
pid_t pid2;
int status1, status2;

	FORK(pid2);
	avs_xt_hier("Tinrevthr1", "XtInsertRawEventHandler");
	tet_infoline("PREP: Create a test labelw_msg widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Insert XtEVT1_InsertRawHead before the previously");
	tet_infoline("PREP: Register XtEVT1_Proc to handle events to labelw_msg");
	XtAddEventHandler(labelw_msg,
		 ButtonPressMask,
		 False,
		 XtEVT1_Proc,
		 (XtPointer)NULL
		 );
	tet_infoline("PREP: registered event handler XtEVT1_Proc");
	XtInsertRawEventHandler(labelw_msg,
		 ButtonPressMask,
		 False,
		 XtEVT1_InsertRawHead,
		 client_stuff,
		 XtListHead
		 );
	tet_infoline("PREP: Send ButtonPress event");
	send_event(labelw_msg, ButtonPress, ButtonPressMask, TRUE);
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: XtEVT1_InsertRawHead was invoked");
	status1 = avs_get_event(1);
	check_dec(1, status1, "XtEVT1_InsertRawHead invoked count");
	tet_infoline("TEST: Procedure XtEVT1_Proc was invoked");
	status2 = avs_get_event(2);
	check_dec(1, status2, "XtEVT1_Proc invoked count");
	tet_result(TET_PASS);
>>ASSERTION Good A
When 
.A position 
is XtListTail
a successful call to
void XtInsertRawEventHandler(w, event_mask, nonmaskable, proc, 
client_data, position)
shall register proc as the procedure that will be called, after
all other previously registered procedures when an event matching 
event_mask is dispatched to the widget
.A w.
>>CODE
Widget labelw_msg;
char *msg = "Event widget";
int status1, status2;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tinrevthr2", "XtInsertRawEventHandler");
	tet_infoline("PREP: Create a test labelw_msg widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Register XtEVT2_Proc to handle events to labelw_msg");
	XtAddEventHandler(labelw_msg,
		 ButtonPressMask,
		 False,
		 XtEVT2_Proc,
		 (XtPointer)NULL
		 );
	tet_infoline("PREP: Insert procedure XtEVT2_InsertRawTail after the previously");
	tet_infoline("PREP: registered event handler XtEVT2_Proc");
	XtInsertRawEventHandler(labelw_msg,
		 ButtonPressMask,
		 False,
		 XtEVT2_InsertRawTail,
		 client_stuff,
		 XtListTail
		 );
	tet_infoline("TEST: Send ButtonPress event");
	send_event(labelw_msg, ButtonPress, ButtonPressMask, TRUE);
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: XtEVT2_Proc was invoked");
	status1 = avs_get_event(1);
	check_dec(1, status1, " XtEVT2_Proc invoked count");
	tet_infoline("TEST: XtEVT2_InsertRawTail was invoked");
	status2 = avs_get_event(2);
	check_dec(1, status2, " XtEVT2_InsertRawTail invoked count");
	tet_result(TET_PASS);
>>ASSERTION Good A
When the procedure registered by a call to
void XtInsertRawEventHandler(w, event_mask, nonmaskable, proc, 
client_data, position)
is already registered with the same client_data for the widget
.A w,
.A event_mask 
shall augment the existing event mask.
>>CODE
Widget labelw_msg;
char *msg = "Event widget";
int status1, status2;
pid_t pid2;
pid_t pid3;
int pstatus;

	FORK(pid3);
	avs_xt_hier_def("Tinrevthr3", "XtInsertRawEventHandler");
	tet_infoline("PREP: Create a test labelw_msg widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Register XtEVT3_Proc to handle ButtonPress events");
	tet_infoline("      to labelw_msg widget");
	XtAddEventHandler(labelw_msg,
		 ButtonPressMask|ButtonReleaseMask,
		 False,
		 XtEVT3_Proc,
		 (XtPointer)NULL
		 );
	tet_infoline("PREP: Register XtEVT3_Proc2 to handle ButtonPress events");
	tet_infoline("      to labelw_msg widget with position at head");
	XtInsertRawEventHandler(labelw_msg,
		 ButtonPressMask,
		 False,
		 XtEVT3_Proc2,
		 (XtPointer)NULL,
			XtListHead
		 );
	tet_infoline("PREP: Register XtEVT3_Proc2 to handle ButtonRelease events");
	tet_infoline("PREP: to labelw_msg widget with position at tail");
	XtInsertRawEventHandler(labelw_msg,
		 ButtonReleaseMask,
		 False,
		 XtEVT3_Proc2,
		 (XtPointer)NULL,
			XtListTail
		 );
	tet_infoline("PREP: Register timeout");
	XtAddTimeOut(AVSXTLOOPTIMEOUT, XtTMO3_Proc, topLevel);
	tet_infoline("TEST: Send ButtonPress event");
	send_event(labelw_msg, ButtonPress, ButtonPressMask, TRUE);
	tet_infoline("TEST: Send ButtonRelease event");
	send_event(labelw_msg,ButtonRelease,ButtonReleaseMask, TRUE);
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
		tet_infoline("TEST: Procedure XtEVT3_Proc was invoked for each event at tail");
		status1 = avs_get_event(2);
		check_dec(2, status1, "handler position in list for ButtonPress");
		status2 = avs_get_event(4);
		check_dec(2, status2, "handler position in list for ButtonRelease");
		tet_result(TET_PASS);
	}
>>ASSERTION Good A
When 
.A nonmaskable 
is True a call to
void XtInsertRawEventHandler(w, event_mask, nonmaskable, proc, 
client_data, position)
shall register 
.A proc
as a procedure that will be called when non-maskable events
are dispatched to the specified widget.
>>CODE
Widget labelw_msg;
char *msg = "Event widget";
pid_t pid2;
int status1, status2;
pid_t pid3;
int pstatus;

	FORK(pid3);
	avs_xt_hier_def("Tinrevthr4", "XtInsertRawEventHandler");
	tet_infoline("PREP: Create a test labelw_msg widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Register XtEVT4_Proc to handle KeyPress and non-maskable events");
	XtInsertEventHandler(labelw_msg,
		 KeyPressMask,
		 True,
		 XtEVT4_Proc,
		 (XtPointer)NULL,
		XtListHead
		 );
	XtAddTimeOut(AVSXTLOOPTIMEOUT, XtTMO4_Proc, topLevel);
	tet_infoline("TEST: Send nonmaskable events");
	send_event(labelw_msg, GraphicsExpose, GCGraphicsExposures, TRUE);
	send_event(labelw_msg, NoExpose, GCGraphicsExposures, TRUE);
	FORK(pid2);
	XtMainLoop();
	LKROF(pid2, AVSXTTIMEOUT-4);
	KROF3(pid3, pstatus, AVSXTTIMEOUT-2);
        if (pstatus != 0) {
		tet_infoline("ERROR: Test process exited abnormally");
		tet_result(TET_UNRESOLVED);
        }
	else {
		tet_infoline("TEST: XtEVT4_Proc was invoked");
		status1 = avs_get_event(1);
		check_dec(1, status1, "count of GraphicsExpose events");
		status2 = avs_get_event(2);
		check_dec(1, status2, "count of NoExpose events");
		tet_result(TET_PASS);
	}
>>ASSERTION Good A
A call to
void XtInsertRawEventHandler(w, event_mask, nonmaskable, proc, 
client_data, position)
shall not modify the event_mask attribute of the widget window.
>>CODE
Widget labelw_msg;
char *msg = "Event widget";
pid_t pid2;
int status;

	FORK(pid2);
	avs_xt_hier("Tinrwevhr5", "XtInsertRawEventHandler");
	tet_infoline("PREP: Create a test labelw_msg widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Register raw event handler");
	XtInsertRawEventHandler(labelw_msg, ButtonPressMask, False, XtEVT5_Proc,
		 client_stuff, XtListHead);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTMO5_Proc, NULL);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Send ButtonPress event without selecting");
	/*FALSE in last argument causes no XSelectInput*/
	send_event(labelw_msg, ButtonPress, ButtonPressMask, FALSE);
	tet_infoline("TEST: Event handler was not invoked");
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	status = avs_get_event(1);
	check_dec(0, status, "handler invoked count");
	tet_result(TET_PASS);
>>ASSERTION Good A
When multiple procedures are registered for the widget 
.w 
on the same event by calls to
void XtInsertRawEventHandler(w, event_mask, nonmaskable, proc, 
client_data, position)
the procedures shall be called in an indeterminate order when the
specified event is dispatched to the widget.
>>CODE
Widget labelw_msg;
char *msg = "Event widget";
int head, tail;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tinrwevhr6", "XtInsertRawEventHandler");
	tet_infoline("PREP: Create a test labelw_msg widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Register a button press handler");
	XtInsertRawEventHandler(labelw_msg, ButtonPressMask, False, XtEVT6_Head,
		 (XtPointer)NULL, XtListHead);
	tet_infoline("PREP: Register another button press handler");
	XtInsertRawEventHandler(labelw_msg, ButtonPressMask, False, XtEVT6_Tail,
		 (XtPointer)NULL, XtListHead);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTMO6_Proc, NULL);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send ButtonPress event");
	send_event(labelw_msg, ButtonPress, ButtonPressMask, TRUE);
	tet_infoline("TEST: Both handlers were invoked");
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	head = avs_get_event(1);
	check_dec(1, head, "XtEVT6_Head invoked count");
	tail = avs_get_event(2);
	check_dec(1, tail, "XtEVT6_Tail invoked count");
	tet_result(TET_PASS);
>>ASSERTION Good A
When the procedure 
.A proc
is registered for an event by multiple calls to
void XtInsertRawEventHandler(w, event_mask, nonmaskable, proc, 
client_data, position)
with different values for 
.A client_data
the procedure shall be called multiple times with the corresponding 
values of
.A client_data
when the specified event is dispatched to the widget.
>>CODE
Widget labelw_msg;
char *msg = "Event widget";
pid_t pid2;
int status;

	FORK(pid2);
	avs_xt_hier("Tadrwevhr7", "XtInsertRawEventHandler");
	tet_infoline("PREP: Create a test labelw_msg widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Register raw event handler twice ");
	XtInsertRawEventHandler(labelw_msg, ButtonPressMask, False, XtEVT7_Proc,
		 client_stuff, XtListHead);
	XtInsertRawEventHandler(labelw_msg, ButtonPressMask, False, XtEVT7_Proc,
		 NULL, XtListHead);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTMO7_Proc, NULL);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Send ButtonPress over wire to widget labelw_msg");
	/*TRUE in last argument causes XSelectInput*/
	send_event(labelw_msg, ButtonPress, ButtonPressMask, TRUE);
	tet_infoline("TEST: Event handler was invoked twice");
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	status = avs_get_event(1);
	check_dec(2, status, "handler invoked count");
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to
void XtInsertRawEventHandler(w, event_mask, nonmaskable, proc, 
client_data, position)
when 
.A event_mask
specifies multiple events shall register 
.A proc
as the procedure that will be called for each specified event that 
is dispatched to the widget.
>>CODE
Widget labelw_msg;
char *msg = "Event widget";
int status1, status2;
pid_t pid2;
pid_t pid3;
int pstatus;

	FORK(pid3);
	avs_xt_hier_def("Tinrevthr3", "XtInsertRawEventHandler");
	tet_infoline("PREP: Create a test labelw_msg widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Register XtEVT3_Proc2 to handle ButtonRelease and ButtonPress events");
	XtInsertRawEventHandler(labelw_msg,
		ButtonReleaseMask|ButtonPressMask,
		False,
		XtEVT3_Proc2,
		client_stuff,
		XtListTail
		 );
	tet_infoline("PREP: Register timeout");
	XtAddTimeOut(AVSXTLOOPTIMEOUT, XtTMO3_Proc, topLevel);
	tet_infoline("TEST: Send ButtonPress event");
	send_event(labelw_msg, ButtonPress, ButtonPressMask, TRUE);
	tet_infoline("TEST: Send ButtonRelease event");
	send_event(labelw_msg,ButtonRelease,ButtonReleaseMask, TRUE);
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
		tet_infoline("TEST: Procedure XtEVT3_Proc2 was invoked once for each event");
		status1 = avs_get_event(2);
		check_dec(1, status1, "ButtonPress event count");
		status2 = avs_get_event(4);
		check_dec(1, status2, "ButtonRelease event count");
		tet_result(TET_PASS);
	}
>>ASSERTION Good A
When a procedure is registered with multiple calls to
void XtInsertRawEventHandler(w, event_mask, nonmaskable, proc, 
client_data, position)
with the same client data it shall be registered only once
for each event specified in the
.A event_mask
parameter of the calls.
>>CODE
Widget labelw_msg;
char *msg = "Event widget";
int status1, status2;
pid_t pid2;
pid_t pid3;
int pstatus;

	FORK(pid3);
	avs_xt_hier_def("Tinrevthr3", "XtInsertRawEventHandler");
	tet_infoline("PREP: Create a test labelw_msg widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Register XtEVT3_Proc2 to handle ButtonPress events");
	XtInsertRawEventHandler(labelw_msg,
		 ButtonPressMask,
		 False,
		 XtEVT3_Proc2,
		 (XtPointer)NULL,
			XtListHead
		 );
	tet_infoline("PREP: Register XtEVT3_Proc2 to handle ButtonRelease events");
	XtInsertRawEventHandler(labelw_msg,
		ButtonReleaseMask,
		False,
		XtEVT3_Proc2,
		client_stuff,
		XtListTail
		 );
	tet_infoline("PREP: Register XtEVT3_Proc2 to handle ButtonRelease events");
	XtInsertRawEventHandler(labelw_msg,
		ButtonReleaseMask,
		False,
		XtEVT3_Proc2,
		client_stuff,
		XtListTail
		 );
	tet_infoline("PREP: Register timeout");
	XtAddTimeOut(AVSXTLOOPTIMEOUT, XtTMO3_Proc, topLevel);
	tet_infoline("TEST: Send ButtonPress event");
	send_event(labelw_msg, ButtonPress, ButtonPressMask, TRUE);
	tet_infoline("TEST: Send ButtonRelease event");
	send_event(labelw_msg,ButtonRelease,ButtonReleaseMask, TRUE);
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
		tet_infoline("TEST: Procedure XtEVT3_Proc2 was invoked once for each event");
		status1 = avs_get_event(2);
		check_dec(1, status1, "ButtonPress event count");
		status2 = avs_get_event(4);
		check_dec(1, status2, "ButtonRelease event count");
		tet_result(TET_PASS);
	}
>>ASSERTION Good A
A successful call to
void XtInsertRawEventHandler(w, event_mask, nonmaskable, proc, 
client_data, position)
shall cause
.A client_data
to be passed to
.A proc
when it is invoked.
>>CODE
Widget labelw_msg;
char *msg = "Event widget";
pid_t pid2;
int status1, status2;

	FORK(pid2);
	avs_xt_hier("Tinrevthr1", "XtInsertRawEventHandler");
	tet_infoline("PREP: Create a test labelw_msg widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Insert XtEVT1_InsertRawHead before the previously");
	tet_infoline("PREP: Register XtEVT1_Proc to handle events to labelw_msg");
	XtAddEventHandler(labelw_msg,
		 ButtonPressMask,
		 False,
		 XtEVT1_Proc,
		 (XtPointer)NULL
		 );
	tet_infoline("PREP: registered event handler XtEVT1_Proc");
	XtInsertRawEventHandler(labelw_msg,
		 ButtonPressMask,
		 False,
		 XtEVT1_InsertRawHead,
		 client_stuff,
		 XtListHead
		 );
	tet_infoline("PREP: Send ButtonPress event");
	send_event(labelw_msg, ButtonPress, ButtonPressMask, TRUE);
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: XtEVT1_InsertRawHead was invoked");
	status1 = avs_get_event(1);
	check_dec(1, status1, "XtEVT1_InsertRawHead invoked count");
	tet_infoline("TEST: Procedure XtEVT1_Proc was invoked");
	status2 = avs_get_event(2);
	check_dec(1, status2, "XtEVT1_Proc invoked count");
	tet_result(TET_PASS);
