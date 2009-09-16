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
>># File: tset/Xt9/XtGrabPointer/XtGrabPointer.m
>># 
>># Description:
>>#	Tests for XtGrabPointer()
>># 
>># Modifications:
>># $Log: tgrbpoint.m,v $
>># Revision 1.1  2005-02-12 14:38:24  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:37:03  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:59:57  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:28:10  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:44  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:18:19  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:11:35  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;

static void
analyse_events(w, w1)
Widget w, w1;
{
	XtAppContext app_context;
	Display *display;
	XEvent loop_event;
	Widget widget;
	int ret_value;
	Window window;
	widget = XtParent(w);
	app_context = XtWidgetToApplicationContext(w);
	display = XtDisplay(w);
	window = XtWindow(w);
	for (;;) {
	 XtAppNextEvent(app_context, &loop_event);
	 if (loop_event.type == Expose && loop_event.xexpose.window == window){
		tet_infoline("TEST: Grab the pointer.");
		ret_value = XtGrabPointer(w, True, FocusChangeMask, GrabModeAsync, GrabModeAsync, window, None, CurrentTime);
		if (ret_value != GrabSuccess) {
			sprintf(ebuf, "ERROR: XtGrabPointer Call Failed, return value = %d", ret_value);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
		}
		exit(0);
	 }
	 XSync(display, False);
	 XtDispatchEvent(&loop_event);
	} /* end for */
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtGrabPointer Xt9
int
XtGrabPointer(widget, owner_events, event_mask, pointer_mode, keyboard_mode, confine_to, cursor, time)
>>ASSERTION Good A
When the widget
.A widget 
is realized a successful call to
int XtGrabPointer(widget, owner_events, event_mask, pointer_mode, 
keyboard_mode, confine_to, cursor, time) 
shall call XGrabPointer to make an active grab of the pointer for the 
specified widget.
>>CODE
Widget test_widget;
int status;
int ret_value;
Display *display;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tgrbpoint1", "XtGrabPointer");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	analyse_events(panedw, rowcolw);
	LKROF(pid2, AVSXTTIMEOUT-10);
	tet_result(TET_PASS);
>>ASSERTION Good A
A call to
int XtGrabPointer(widget, owner_events, event_mask, pointer_mode, 
keyboard_mode, confine_to, cursor, time) 
when the widget
.A widget
is not realized shall not activate the pointer grab and shall
return
.S GrabNotViewable.
>>CODE
Window window;
int ret_value;
Widget labelw_good;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tgrbpoint2", "XtGrabPointer");
	tet_infoline("PREP: Create labelw_good widget in boxw1 widget");
	labelw_good = (Widget) CreateLabelWidget("Hello", boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Try grabbing pointer widget not realized");
	XtUnrealizeWidget(labelw_good);
	ret_value = XtGrabPointer(labelw_good,True,KeyPress,
		 GrabModeAsync, GrabModeAsync, None,
		 None, CurrentTime);
	tet_infoline("TEST: Return value is GrabNotViewable.");
	check_dec((long)GrabNotViewable, ret_value, "GrabNotViewable");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
