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
>># File: tset/Xt9/XtUngrabPointer/XtUngrabPointer.m
>># 
>># Description:
>>#	Tests for XtUngrabPointer()
>># 
>># Modifications:
>># $Log: tunpointr.m,v $
>># Revision 1.1  2005-02-12 14:38:24  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:37:04  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:59:58  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:28:10  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:45  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:18:20  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:11:36  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

static void analyse_events(w, w2)
Widget w,w2;
{
	XtAppContext app_context;
	Display *display;
	XEvent loop_event;
	int ret_value;
	Window window;
	Widget widget;
	widget = XtParent(w);
	app_context = XtWidgetToApplicationContext(widget);
	display = XtDisplay(widget);
	for (;;) {
	 XtAppNextEvent(app_context, &loop_event);
	 XSync(display, False);
	 if ( loop_event.type == MotionNotify ) {
	 	avs_set_event(1,1);
		exit(0);
	 }
	if (loop_event.type == Expose) {
		if (loop_event.xexpose.window == XtWindow(w)) {
		tet_infoline("PREP: Grab the pointer");
		ret_value = XtGrabPointer(w,True, FocusChangeMask,
		 GrabModeAsync, GrabModeAsync, XtWindow(w), None, CurrentTime);
		check_dec((long)GrabSuccess, ret_value, "XtGrabPointer return value");
		tet_infoline("PREP: Ungrab the pointer");
		XtUngrabPointer(w, CurrentTime);
		tet_infoline("PREP: Move the pointer");
		XWarpPointer(XtDisplay(w), XtWindow(w), XtWindow(w2), 1, 1 , 0, 0, 100,1);
		}
	}
	 XtDispatchEvent(&loop_event);
	} /* end for */
}
void XtTMO_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	exit(0);
}

XtAppContext app_ctext ;
Widget topLevel, panedw, boxw1, boxw2 ;
Widget labelw, rowcolw, click_quit ;

>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtUngrabPointer Xt9
void
XtUngrabPointer(widget, time)
>>ASSERTION Good A
A successful call to 
void XtUngrabPointer(widget, time)
shall cancel the active pointer grab for the widget
.A widget.
>>CODE
Display *display;
int status;
Window window;
int ret_value;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tunpointr1", "XtUngrabPointer");
	tet_infoline("PREP: Register timeout");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTMO_Proc, topLevel);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	analyse_events(panedw, boxw1);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: MotionNotify events were not received.");
	status = avs_get_event(1);
	check_dec(0, status, "motion notify event count");
	tet_result(TET_PASS);
