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
>># File: xts/Xt9/XtSetKeyboardFocus/XtSetKeyboardFocus.m
>># 
>># Description:
>>#	Tests for XtSetKeyboardFocus()
>># 
>># Modifications:
>># $Log: tstkbfocs.m,v $
>># Revision 1.1  2005-02-12 14:38:24  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:37:04  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:59:58  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:28:11  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:45  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:18:22  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:11:38  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>
#include <X11/RectObj.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;

void KP1a(w, client_data, event, cont)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *cont;
{
	avs_set_event(2,1);
	exit(0);
}

void KP1b(w, client_data, event, cont)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *cont;
{
	tet_infoline("ERROR: KeyPress was sent to subtree not descendant");
	tet_result(TET_FAIL);
	exit(0);
}

void KP2a(w, client_data, event, cont)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *cont;
{
	avs_set_event(2,1);
	exit(0);
}
void KP2b(w, client_data, event, cont)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *cont;
{
	tet_infoline("ERROR: KeyPress was sent to descendant not subtree");
	tet_result(TET_FAIL);
	exit(0);
}
void KP3a(w, client_data, event, cont)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *cont;
{
	avs_set_event(1,1);
	exit(0);
}
void KP3b(w, client_data, event, cont)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *cont;
{
	tet_infoline("ERROR: KeyPress was sent to subtree not descendant");
	tet_result(TET_FAIL);
	exit(0);
}
static void
analyse_events4(w, w1)
Widget w, w1;
{
	XtAppContext app_context;
	Display *display;
	XEvent loop_event;
	Widget widget;
	int ret_value;
	int gflag = 0;
	Window window;
	widget = XtParent(w);
	app_context = XtWidgetToApplicationContext(w);
	display = XtDisplay(w);
	window = XtWindow(w);
	for (;;) {
	 XtAppNextEvent(app_context, &loop_event);
	 if (loop_event.type == Expose && loop_event.xexpose.window == window){
		if (gflag == 0) {
		tet_infoline("TEST: Actively grab keyboard");
		ret_value = XtGrabKeyboard(w, True, GrabModeAsync, GrabModeAsync, CurrentTime);
		if (ret_value != GrabSuccess) {
			sprintf(ebuf, "ERROR: XtGrabKeyboard Call Failed, return value = %d", ret_value);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
		}
		gflag = 1;
		}
	 }
	 XSync(display, False);
	 XtDispatchEvent(&loop_event);
	} /* end for */
}
void KP4(w, client_data, event, cont)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *cont;
{
	if (event->type == FocusIn) {
		avs_set_event(1,1);
		exit(0);
	}
}
static void
analyse_events5(w, w1)
Widget w, w1;
{
	XtAppContext app_context;
	Display *display;
	XEvent loop_event;
	Widget widget;
	int ret_value;
	int gflag = 0;
	Window window;
	widget = XtParent(w);
	app_context = XtWidgetToApplicationContext(w);
	display = XtDisplay(w);
	window = XtWindow(w);
	for (;;) {
	 XtAppNextEvent(app_context, &loop_event);
	 if (loop_event.type == Expose && loop_event.xexpose.window == window){
		if (gflag == 0) {
		tet_infoline("TEST: Actively grab keyboard");
		ret_value = XtGrabPointer(w, True, FocusChangeMask, GrabModeAsync, GrabModeAsync, window, None, CurrentTime);
		if (ret_value != GrabSuccess) {
			sprintf(ebuf, "ERROR: XtGrabPointer Call Failed, return value = %d", ret_value);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
		}
		gflag = 1;
		}
	 }
	 XSync(display, False);
	 XtDispatchEvent(&loop_event);
	} /* end for */
}
void KP5(w, client_data, event, cont)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *cont;
{
	if (event->type == FocusIn) {
		avs_set_event(1,1);
		exit(0);
	}
}
static void
analyse_events6(w, w1)
Widget w, w1;
{
	XtAppContext app_context;
	Display *display;
	XEvent loop_event;
	Widget widget;
	int ret_value;
	int gflag = 0;
	Window window;
	widget = XtParent(w);
	app_context = XtWidgetToApplicationContext(w);
	display = XtDisplay(w);
	window = XtWindow(w);
	for (;;) {
	 XtAppNextEvent(app_context, &loop_event);
	 if (loop_event.type == Expose && loop_event.xexpose.window == window){
		if (gflag == 0) {
		tet_infoline("TEST: Actively grab the keyboard");
		ret_value = XtGrabKeyboard(w, True, GrabModeAsync, GrabModeAsync, CurrentTime);
		if (ret_value != GrabSuccess) {
			sprintf(ebuf, "ERROR: XtGrabKeyboard Call Failed, return value = %d", ret_value);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
		}
		tet_infoline("TEST: Ungrab the keyboard");
		XtUngrabKeyboard(w, CurrentTime);
		gflag = 1;
		}
	 }
	 XSync(display, False);
	 XtDispatchEvent(&loop_event);
	} /* end for */
}
void KP6(w, client_data, event, cont)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *cont;
{
	if (event->type == FocusOut) {
		avs_set_event(1,1);
		exit(0);
	}
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtSetKeyboardFocus Xt9
int
XtSetKeyboardFocus(subtree, descendant)
>>ASSERTION Good A
When 
.A descendant 
is not 
.A None
a successful call to 
void XtSetKeyboardFocus(subtree, descendant)
shall cause keyboard events that occur in any widget of the widget 
subtree specified by
.A subtree
to be redirected to the widget 
.A descendant.
>>CODE
pid_t pid2;
int status;
int ret_value;
Display *display;

	FORK(pid2);
	avs_xt_hier("Tstkbfocs1", "XtSetKeyboardFocus");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	display = XtDisplay(rowcolw);
	tet_infoline("PREP: Add keypress event handler to rowcolw and panedw");
	XtAddEventHandler(rowcolw,
		KeyPressMask,
		False,
		&KP1a,
		NULL);
	XSelectInput(display, XtWindow(rowcolw), FocusChangeMask|KeyPressMask);
	XtAddEventHandler(panedw,
		KeyPressMask,
		False,
		&KP1b,
		NULL);
	XSelectInput(display, XtWindow(panedw), FocusChangeMask|KeyPressMask);
	tet_infoline("TEST: Set Keyboard focus to panedw subtree with rowcolw as descendant");
	XtSetKeyboardFocus(panedw, rowcolw);
	tet_infoline("TEST: Send a KeyPress to subtree");
	send_event(panedw, KeyPress, KeyPressMask, TRUE);
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: KeyPress event was received by descendant");
	status = avs_get_event(2);
	check_dec(1, status, "KeyPress event count");
	tet_result(TET_PASS);
>>ASSERTION Good A
A call to 
void XtSetKeyboardFocus(subtree, descendant)
when 
.A descendant 
is 
.S None
and no input focus was previously set in 
.A subtree 
shall cause keyboard events that occur in the specified subtree 
to be dispatched normally.
>>CODE
pid_t pid2;
int status;
int ret_value;
Display *display;

	FORK(pid2);
	avs_xt_hier("Tstkbfocs2", "XtSetKeyboardFocus");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	display = XtDisplay(rowcolw);
	tet_infoline("PREP: Add keypress event handler to rowcolw and panedw");
	XtAddEventHandler(rowcolw,
		KeyPressMask,
		False,
		&KP2b,
		NULL);
	XSelectInput(display, XtWindow(rowcolw), FocusChangeMask|KeyPressMask);
	XtAddEventHandler(panedw,
		KeyPressMask,
		False,
		&KP2a,
		NULL);
	XSelectInput(display, XtWindow(panedw), FocusChangeMask|KeyPressMask);
	tet_infoline("PREP: Set Keyboard focus to panedw subtree with NULL as descendant");
	XtSetKeyboardFocus(panedw, NULL);
	tet_infoline("PREP: Send a KeyPress to subtree");
	send_event(panedw, KeyPress, KeyPressMask, TRUE);
	tet_infoline("TEST: Check KeyPress event was received by subtree");
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	status = avs_get_event(2);
	check_dec(1, status, "KeyPress event count");
	tet_result(TET_PASS);
>>ASSERTION Good A
A call to 
void XtSetKeyboardFocus(subtree, descendant)
when the class of
.A descendant 
is not a subclass of Core shall cause keyboard events 
that occur in the specified widget subtree to be redirected 
to the closest windowed ancestor of
.A descendant.
>>CODE
pid_t pid2;
int status;
int ret_value;
Display *display;
Widget test_widget, test_widget2;

	FORK(pid2);
	avs_xt_hier("Tstkbfocs3", "XtSetKeyboardFocus");
	tet_infoline("PREP: Create Core widget as child of rowcolw widget");
	test_widget = XtVaCreateManagedWidget("core", coreWidgetClass, rowcolw, NULL);
	(void) ConfigureDimension(topLevel, test_widget);
	tet_infoline("PREP: Create rectObj widget as child of core widget");
	test_widget2 = XtVaCreateWidget("rect", rectObjClass, test_widget, NULL);
	(void) ConfigureDimension(topLevel, test_widget2);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Add keypress event handler to rowcolw");
	XtAddEventHandler(rowcolw,
		KeyPressMask,
		False,
		KP3b,
		NULL);
	XSelectInput(display, XtWindow(rowcolw), FocusChangeMask|KeyPressMask);
	tet_infoline("PREP: Add keypress event handler to core widget");
	XtAddEventHandler(test_widget,
		KeyPressMask,
		False,
		KP3a,
		NULL);
	XSelectInput(display, XtWindow(test_widget), FocusChangeMask|KeyPressMask);
	tet_infoline("PREP: Set Keyboard focus to rowcolw subtree with rectObj widget as descendant");
	XtSetKeyboardFocus(rowcolw, test_widget2);
	tet_infoline("PREP: Send a KeyPress to subtree");
	send_event(rowcolw, KeyPress, KeyPressMask, TRUE);
	tet_infoline("TEST: KeyPress event was received by core ancestor of rectObj widget");
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	status = avs_get_event(1);
	check_dec(1, status, "count of events to rowcolw");
	tet_result(TET_PASS);
>>ASSERTION Good A
After a successful call to 
void XtSetKeyboardFocus(subtree, descendant)
when the
.S FocusChange
event has been selected by the widget
.A descendant 
and 
.A subtree 
or one of its descendants acquires the X Input focus a 
.S FocusIn 
event shall be generated for descendant.
>>CODE
pid_t pid2;
int status;
int ret_value;
Display *display;

	FORK(pid2);
	avs_xt_hier("Tstkbfocs4", "XtSetKeyboardFocus");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	display = XtDisplay(panedw);
	tet_infoline("PREP: Add focus change event handler to rowcolw");
	XtAddEventHandler(rowcolw,
		FocusChangeMask,
		False,
		&KP4,
		NULL);
	XSelectInput(display, XtWindow(rowcolw), FocusChangeMask);
	tet_infoline("PREP: Set Keyboard focus to panedw subtree with rowcolw as descendant");
	XtSetKeyboardFocus(panedw, rowcolw);
	tet_infoline("TEST: Check FocusIn event was received");
	analyse_events4(panedw, rowcolw);
	LKROF(pid2, AVSXTTIMEOUT-2);
	status = avs_get_event(1);
	check_dec(1, status, "FocusIn event count");
	tet_result(TET_PASS);
>>ASSERTION Good A
After a successful call to 
void XtSetKeyboardFocus(subtree, descendant)
when the
.S FocusChange
event has been selected by the widget
.A descendant 
and the pointer moves into 
the specified subtree a 
.S FocusIn 
event shall be generated for descendant.
>>CODE
pid_t pid2;
int status;
int ret_value;
Display *display;

	FORK(pid2);
	avs_xt_hier("Tstkbfocs5", "XtSetKeyboardFocus");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	display = XtDisplay(panedw);
	tet_infoline("PREP: Add focus change event handler to rowcolw");
	XtAddEventHandler(rowcolw,
		FocusChangeMask,
		False,
		&KP5,
		NULL);
	XSelectInput(display, XtWindow(rowcolw), FocusChangeMask);
	tet_infoline("PREP: Set Keyboard focus to panedw subtree with rowcolw as descendant");
	XtSetKeyboardFocus(panedw, rowcolw);
	tet_infoline("TEST: Check FocusIn event was received");
	analyse_events5(panedw, rowcolw);
	LKROF(pid2, AVSXTTIMEOUT-2);
	status = avs_get_event(1);
	check_dec(1, status, "FocusIn event count");
	tet_result(TET_PASS);
>>ASSERTION Good A
After a successful call to 
void XtSetKeyboardFocus(subtree, descendant)
when 
.S FocusChange 
events have been selected by the widget
.A descendant 
and the subtree or one of its descendants loses the X Input 
focus a
.S FocusOut 
event shall be generated for 
.A descendant.
>>CODE
pid_t pid2;
int status;
int ret_value;
Display *display;

	FORK(pid2);
	avs_xt_hier("Tstkbfocs6", "XtSetKeyboardFocus");
	tet_infoline("PREP: Set height and width of boxw2 widget");
	(void) ConfigureDimension(topLevel, boxw2);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	display = XtDisplay(panedw);
	tet_infoline("PREP: Add focus change event handler to rowcolw");
	XtAddEventHandler(rowcolw,
		FocusChangeMask,
		False,
		&KP6,
		NULL);
	XSelectInput(display, XtWindow(rowcolw), FocusChangeMask);
	tet_infoline("PREP: Set Keyboard focus to panedw subtree with rowcolw as descendant");
	XtSetKeyboardFocus(panedw, rowcolw);
	tet_infoline("TEST: Check FocusIn event was received");
	analyse_events6(panedw, rowcolw);
	LKROF(pid2, AVSXTTIMEOUT-2);
	status = avs_get_event(1);
	check_dec(1, status, "FocusIn event count");
	tet_result(TET_PASS);
>>ASSERTION Good B 0
After a successful call to 
void XtSetKeyboardFocus(subtree, descendant)
when 
.S FocusChange 
events have been selected by the widget
.A descendant 
and an ancestor of subtree loses the keyboard focus a
.S FocusOut 
event shall be generated for 
.A descendant.
>>#
>># Assertion for dispatch logic
>>#
>>ASSERTION Good B 0
After a successful call to 
void XtSetKeyboardFocus(subtree, descendant)
when no modal cascade exists, the widget
.A descendant 
has redirected its keyboard focus to another widget, and 
a keyboard event occurs in a widget in subtree that is either the 
final widget in the focus chain or its descendant the event 
shall be dispatched to the widget in which the event occurred.
>>ASSERTION Good B 0
After a successful call to 
void XtSetKeyboardFocus(subtree, descendant)
when no modal cascade exists, a keyboard event occurs in 
a widget in subtree that is neither an ancestor nor a 
descendant of
.A descendant, 
and the event has activated a keyboard grab for this 
widget the grab shall be canceled.
>>ASSERTION Good B 0
After a successful call to 
void XtSetKeyboardFocus(subtree, descendant)
when no modal cascade exists and 
a keyboard event occurs in a widget in subtree that is an 
ancestor of the final widget in the focus chain and has 
established a passive grab with owner_events set to
.S False
the event shall be dispatched to the widget in which the 
event occurred.
>>ASSERTION Good B 0
After a successful call to 
void XtSetKeyboardFocus(subtree, descendant)
when no modal cascade exists, a keyboard event occurs in 
a widget in subtree that is an ancestor of the final widget 
in the focus chain and has established a passive grab with 
owner_events set to
.S True,
and the coordinates of the event are outside the rectangle
specified by this widget the event shall be dispatched to the 
widget in which the event occurred.
>>ASSERTION Good B 0
After a successful call to 
void XtSetKeyboardFocus(subtree, descendant)
when no modal cascade exists, a keyboard event 
occurs in a widget in subtree that is not the
final widget in the focus chain or its descendant,
nor is the event widget an ancestor of the
final widget in the focus chain that has established 
a passive keyboard grab with owner_events set to 
.S False
or an ancestor that has established a passive keyboard 
grab with owner_events set to 
.S True 
and the coordinates of the event are outside 
the rectangle specified by the widget, and there is a widget
in the subtree that has an active keyboard grab 
the event shall be dispatched to the final widget in
the focus chain.
>>ASSERTION Good B 0
After a successful call to 
void XtSetKeyboardFocus(subtree, descendant)
when no modal cascade exists, a keyboard event 
occurs in a widget in subtree that is not the
final widget in the focus chain or its descendant,
nor is the event widget an ancestor of the
final widget in the focus chain that has established a passive 
keyboard grab with owner_events set to 
.S False
or an ancestor that has established a passive keyboard 
grab with owner_events set to 
.S True 
and the coordinates of the event are outside 
the rectangle specified by the widget, and there is no 
widget between the final widget in the focus chain
and its closest common ancestor with the event widget 
that has grabbed the specified key and modifier combination 
with any value of owner_events the event shall be dispatched to
the final widget in the focus chain.
>>ASSERTION Good B 0
After a successful call to 
void XtSetKeyboardFocus(subtree, descendant)
when no modal cascade exists, a keyboard event 
occurs in a widget in subtree that is not the
final widget in the focus chain or its descendant,
nor is the event widget an ancestor of the
final widget in the focus chain that has established a passive 
keyboard grab with owner_events set to 
.S False
or an ancestor that has established a passive keyboard 
grab with owner_events set to 
.S True 
and the coordinates of the event are outside 
the rectangle specified by the widget, and neither is there a 
widget in the subtree that has an active keyboard grab nor is there a
widget between the final widget in the focus chain
and its closest common ancestor with the event widget 
that has grabbed the key and modifier combination 
with any value of owner_events the event shall be dispatched to
the ancestor of the final widget in the focus chain closest
to its common ancestor with the event widget that has grabbed the
specified key and modifier combination.
>>ASSERTION Good B 0
After a successful call to 
void XtSetKeyboardFocus(subtree, descendant)
when a modal cascade exists, a keyboard event occurs, and the widget 
that would have been the final event dispatch destination had there 
been no modal cascade is in the active subset of the modal cascade 
the event shall be dispatched to that widget.
>>ASSERTION Good B 0
After a successful call to 
void XtSetKeyboardFocus(subtree, descendant)
when a modal cascade exists, a keyboard event occurs, the widget 
that would have been the final event dispatch destination had there 
been no modal cascade is not in the active subset of the modal cascade,
and there is a spring-loaded widget in the active subset of the modal
cascade the event shall be dispatched to the spring-loaded widget.
>>ASSERTION Good B 0
After a successful call to 
void XtSetKeyboardFocus(subtree, descendant)
when a modal cascade exists, a keyboard event occurs, the widget 
that would have been the final event dispatch destination had there 
been no modal cascade is not in the active subset of the modal cascade,
and there is no spring-loaded widget in the active subset of the modal
cascade the event shall be discarded.
