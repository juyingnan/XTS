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
$Header: /cvs/xtest/xtest/xts5/tset/Xt13/tltmsproc/tltmsproc.m,v 1.1 2005-02-12 14:37:58 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt13/tltmsproc/tltmsproc.m
>># 
>># Description:
>>#	Tests for XtLastTimestampProcessed()
>># 
>># Modifications:
>># $Log: tltmsproc.m,v $
>># Revision 1.1  2005-02-12 14:37:58  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:38:16  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:17  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:29:18  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:25:52  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:21:57  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:18:05  andy
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
	sprintf(ebuf, "ERROR: Event %s invoked procedure XtEVT_Proc", event_names[event->type]);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
}

#define DESIRED_TIME (Time) 779

void analyse_events(quit)
Widget quit;
{
	XtAppContext app_context;
	Display *display;
	XEvent loop_event;
	XEvent event_return;
	Time time_stamp;
	Widget widget;
	widget = XtParent(quit);
	app_context = XtWidgetToApplicationContext(widget);
	display = XtDisplay(widget);
	for (;;) {
	 XtAppNextEvent(app_context, &loop_event);
	 XSync(display, False);
		if ( loop_event.type == ButtonPress ) {
	 	XtDispatchEvent(&loop_event);
		tet_infoline("PREP: Get timestamp of ButtonPress");
		tet_infoline("TEST: Timestamp value");
	 	time_stamp = XtLastTimestampProcessed(display);
	 	if (!time_stamp) {
			sprintf(ebuf, "ERROR: Expected non-zero timestamp, got %d, event stamp %d", time_stamp, loop_event.xbutton.time);
			tet_infoline(ebuf);
			tet_result(TET_FAIL);
	 	}
		exit(0);
	}
	 XtDispatchEvent(&loop_event);
	} /* end for */
}

void analyse_events2(quit)
Widget quit;
{
	XtAppContext app_context;
	Display *display;
	XEvent loop_event;
	XEvent event_return;
	Time time_stamp;
	Widget widget;
	widget = XtParent(quit);
	app_context = XtWidgetToApplicationContext(widget);
	display = XtDisplay(widget);
	for (;;) {
		XtAppNextEvent(app_context, &loop_event);
		XSync(display, False);
		tet_infoline("PREP: Get timestamp before events processed");
		time_stamp = XtLastTimestampProcessed(display);
		tet_infoline("TEST: Timestamp value");
		avs_set_event(1, 1);
		if (time_stamp != 0) {
			sprintf(ebuf, "ERROR: Expected zero timestamp, got %d", time_stamp);
			tet_infoline(ebuf);
			tet_result(TET_FAIL);
		}
		exit(0);
	}
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtLastTimestampProcessed Xt13
Time
XtLastTimestampProcessed(display)
>>ASSERTION Good A
A successful call to 
Time XtLastTimestampProcessed(display)
shall return the timestamp from the most recent event 
passed to XtDispatchEvent for the display
.A display
that contained a timestamp.
>>CODE
Boolean dispatched;
Widget labelw_msg;
char *msg = "Test widget";
pid_t pid2;
int invoked = 0;

	FORK(pid2);
	avs_xt_hier("Tltmsproc1", "XtLastTimestampProcessed");
	tet_infoline("PREP: Create a test labelw_msg widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Register procedure XtEVT_Proc to handle events to");
	tet_infoline("PREP: labelw_msg widget");
	XtAddEventHandler(labelw_msg,
		 ButtonPress,
		 False,
		 XtEVT_Proc,
		 (XtPointer)NULL
		 );
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send ButtonPress event");
	send_event_time(labelw_msg, ButtonPress, ButtonPressMask, TRUE, DESIRED_TIME);
	analyse_events(click_quit);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: XtEVT_Proc was invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtEVT_Proc invocations count");
	tet_result(TET_PASS);
>>ASSERTION Good A
When no KeyPress, KeyRelease, ButtonPress, ButtonRelease, 
MotionNotify, EnterNotify, LeaveNotify, PropertyNotify or 
SelectionClear event has yet been passed to XtDispatchEvent
for the display
.A display
a call to
Time XtLastTimestampProcessed(display)
shall return zero.
>>CODE
Boolean dispatched;
Widget labelw_msg;
char *msg = "Test widget";
pid_t pid2;
int invoked = 0;

	FORK(pid2);
	avs_xt_hier("Tltmsproc2", "XtLastTimestampProcessed");
	tet_infoline("PREP: Create a test labelw_msg widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Register procedure XtEVT_Proc to handle events to");
	tet_infoline("PREP: labelw_msg widget");
	XtAddEventHandler(labelw_msg,
		 ButtonPress,
		 False,
		 XtEVT_Proc,
		 (XtPointer)NULL
		 );
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send ButtonPress event");
	send_event_time(labelw_msg, ButtonPress, ButtonPressMask, TRUE, DESIRED_TIME);
	analyse_events2(click_quit);
	LKROF(pid2, AVSXTTIMEOUT-2);
	if (avs_get_event(1) == 0) {
		tet_infoline("ERROR: Event loop terminated abnormally");
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
