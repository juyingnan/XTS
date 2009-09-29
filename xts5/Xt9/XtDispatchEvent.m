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
>># File: xts/Xt9/XtDispatchEvent.m
>># 
>># Description:
>>#	Tests for XtDispatchEvent()
>># 
>># Modifications:
>># $Log: tdispatet.m,v $
>># Revision 1.1  2005-02-12 14:38:24  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:37:08  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:00:02  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:28:14  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:49  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:18:35  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:11:54  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

extern char *event_names[] ;

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;
Widget labelw_msg;

/*
** XtEVT_Proc
*/
void XtEVT_Proc(w, client_data, event, continue_to_dispatch)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_dispatch;
{
	if ( event->type == KeyPress ) {
		avs_set_event(1,1);
		exit(0);
	}
	else {
		sprintf(ebuf, "ERROR: Expected KeyPress event Received %s", event_names[event->type]);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
		exit(0);
	}
}
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
static void analyse_events1(quit)
Widget quit;
{

int i;
XtAppContext app_context;
Display *display;
XEvent loop_event;
XEvent event_return;
int status;
Widget widget;

	widget = XtParent(quit);
	app_context = XtWidgetToApplicationContext(widget);
	display = XtDisplay(widget);
	for (i = 1; i == 1;) {
		XtAppNextEvent(app_context, &loop_event);
	 	XSync(display, False);
		/*
		** If KeyPress event should invoke XtEVT_Proc
		*/
		if (loop_event.type == KeyPress) {
			tet_infoline("TEST: XtDispatchEvent finds handler");
	 		status = XtDispatchEvent(&loop_event);
	 		check_dec(True, status, "XtDispatchEvent return");
		}
		else
			XtDispatchEvent(&loop_event);
	} /* end for */
}

static void analyse_events2(quit)
Widget quit;
{
int i;
XtAppContext app_context;
Display *display;
XEvent loop_event;
XEvent event_return;
int status;
Widget widget;

	widget = XtParent(quit);
	app_context = XtWidgetToApplicationContext(widget);
	display = XtDisplay(widget);
	for (i = 1; i == 1;) {
	 	XtAppNextEvent(app_context, &loop_event);
	 	XSync(display, False);
		if (loop_event.type == KeyRelease) {
			tet_infoline("TEST: XtDispatchEvent returns False");
	 		status = XtDispatchEvent(&loop_event);
	 		check_dec(False, status, "XtDispatchEvent return");	
			exit(0);
		}
		else
			XtDispatchEvent(&loop_event);
	} /* end for */
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtDispatchEvent Xt9
Boolean
XtDispatchEvent(event)
>>ASSERTION Good C
If the implementation is X11R5 or later:
A successful call to 
Boolean XtDispatchEvent(event) 
when no input method has been registered on the event
.A event
for the widget to which the event is to be dispatched
shall dispatch the event to handler procedures previously registered 
and return True.
>>CODE
#if XT_X_RELEASE > 4
extern char *event_names[];
Boolean dispatched;
char *msg = "Test widget";
pid_t pid2;
int invoked = 0;
#endif

#if XT_X_RELEASE > 4
	FORK(pid2);
	avs_xt_hier("Tdispatet1", "XtDispatchEvent");
	tet_infoline("PREP: Create a test labelw_msg widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Register XtEVT_Proc to handle events to labelw_msg");
	XtAddEventHandler(labelw_msg,
		 KeyPressMask,
		 False,
		 XtEVT_Proc,
		 (Widget)NULL
		 );
	tet_infoline("PREP: Send ButtonPress over wire to widget labelw_msg");
	send_event(labelw_msg, KeyPress, KeyPressMask, TRUE);
	tet_infoline("TEST: Handler was invoked");
	analyse_events1(click_quit);
	LKROF(pid2, AVSXTTIMEOUT-2);
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtEVT_Proc invocation count");
	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation is not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
>>ASSERTION Good C
If the implementation is X11R4:
A successful call to 
Boolean XtDispatchEvent(event) 
shall dispatch the event to the handler procedure previously 
registered for the widget to which the event is to be dispatched
and return True.
>>CODE
#if XT_X_RELEASE == 4
extern char *event_names[];
Boolean dispatched;
char *msg = "Test widget";
pid_t pid2;
int invoked = 0;
#endif

#if XT_X_RELEASE == 4
	FORK(pid2);
	avs_xt_hier("Tdispatet1", "XtDispatchEvent");
	tet_infoline("PREP: Create a test labelw_msg widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Register XtEVT_Proc to handle events to labelw_msg");
	XtAddEventHandler(labelw_msg,
		 KeyPressMask,
		 False,
		 XtEVT_Proc,
		 (Widget)NULL
		 );
	tet_infoline("PREP: Send ButtonPress over wire to widget labelw_msg");
	send_event(labelw_msg, KeyPress, KeyPressMask, TRUE);
	tet_infoline("TEST: Handler was invoked");
	analyse_events1(click_quit);
	LKROF(pid2, AVSXTTIMEOUT-2);
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtEVT_Proc invocation count");
	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation is not X11R4");
	tet_result(TET_UNSUPPORTED);
#endif
>>ASSERTION Good D 0
If the implementation is X11R5 or later:
A call to 
Boolean XtDispatchEvent(event) 
when an input method has been registered on the event
.A event
for the widget to which the event is to be 
dispatched and the specified event has not caused a server 
keyboard or a pointer grab shall return True immediately.
>>ASSERTION Good D 0
If the implementation is X11R5 or later:
A successful call to 
Boolean XtDispatchEvent(event) 
when an input method has been registered on the event
.A event
for the widget to which the event is to be 
dispatched and the event caused the activation of a server 
keyboard grab shall cancel the keyboard grab, not perform any 
other action, and return True.
>>ASSERTION Good D 0
If the implementation is X11R5 or later:
A successful call to 
Boolean XtDispatchEvent(event) 
when an input method has been registered on the event
.A event
for the widget to which the event is to be 
dispatched and the event caused the activation of a server 
pointer grab shall cancel the pointer grab, not perform any 
other action, and return True.
>>ASSERTION Good A
When 
.A event 
is a KeyPress, KeyRelease, ButtonPress, ButtonRelease, 
MotionNotify, EnterNotify, LeaveNotify, PropertyNotify
or a SelectionClear event a call to
Boolean XtDispatchEvent(event) 
shall record the timestamp from the event as the last timestamp 
value that will be returned by the next call to 
XtLastTimestampProcessed.
>>CODE
extern char *event_names[];
Boolean dispatched;
pid_t pid2;
int invoked = 0;
int i;
Display *display;
XEvent loop_event;
char *msg = "Test Widget";

	FORK(pid2);
	avs_xt_hier("Tdispatet1", "XtDispatchEvent");
	tet_infoline("PREP: Create a test labelw_msg widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Register XtEVT_Proc to handle events to labelw_msg");
	XtAddEventHandler(labelw_msg,
		 ButtonPressMask|ButtonReleaseMask|KeyPressMask|KeyReleaseMask,
		 False,
		 XtEVT_Proc2,
		 (Widget)NULL
		 );
	tet_infoline("PREP: Register timeout procedure which will cause events");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTMO_Proc5, topLevel);
	display = XtDisplay(topLevel);
	for (i = 1; i == 1;) {
		XtAppNextEvent(app_ctext, &loop_event);
	 	XSync(display, False);
		XtDispatchEvent(&loop_event);
	} /* end for */
	LKROF(pid2, AVSXTTIMEOUT-2);
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
When 
.A event 
is a remap event, a modal cascade exists that has 
a widget with spring_loaded field set to
.S True,
and no event input filter has been registered for the spring-loaded
widget on the specified event a call to
Boolean XtDispatchEvent(event) 
shall dispatch the event to the spring-loaded widget after a
dispatch to the widget to which the event belonged.
>>ASSERTION Good D 0
If the implementation is X11R4:
When 
.A event 
is a remap event and a modal cascade exists that has 
a widget with spring_loaded field set to
.S True
a call to
Boolean XtDispatchEvent(event) 
shall dispatch the event to the spring-loaded widget after a
dispatch to the widget to which the event belonged.
>>ASSERTION Good D 0
If the implementation is X11R5 or later:
When 
.A event 
is a remap event, a modal cascade exists that has 
a widget with spring_loaded field set to
.S True,
and an event input filter has been registered for the spring-loaded
widget on the specified event a call to
Boolean XtDispatchEvent(event) 
shall not dispatch the event to the spring-loaded widget.
>>ASSERTION Good C
If the implementation is X11R5 or later:
A successful call to 
Boolean XtDispatchEvent(event) 
when an input method has not been registered on the event
.A event
for the widget in which the event occurs and the
event is not being dispatched to any widget shall return 
.S False.
>>CODE
#if XT_X_RELEASE > 4
Boolean dispatched;
int invoked = 0;
pid_t pid2;
#endif

#if XT_X_RELEASE > 4
	FORK(pid2);
	avs_xt_hier("Tdispatet2", "XtDispatchEvent");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send KeyRelease over wire to rowcolw");
	send_event(rowcolw, KeyRelease, KeyReleaseMask, TRUE);
	analyse_events2(click_quit);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation is not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
>>ASSERTION Good C
If the implementation is X11R4:
When no handler for the specified event is registered a call to
Boolean XtDispatchEvent(event) 
shall return 
.S False.
>>CODE
#if XT_X_RELEASE == 4
Boolean dispatched;
int invoked = 0;
pid_t pid2;
#endif

#if XT_X_RELEASE == 4
	FORK(pid2);
	avs_xt_hier("Tdispatet2", "XtDispatchEvent");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send KeyRelease over wire to rowcolw");
	send_event(rowcolw, KeyRelease, KeyReleaseMask, TRUE);
	analyse_events2(click_quit);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation is not X11R4");
	tet_result(TET_UNSUPPORTED);
#endif
