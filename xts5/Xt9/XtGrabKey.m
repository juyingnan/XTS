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
>># File: xts/Xt9/XtGrabKey.m
>># 
>># Description:
>>#	Tests for XtGrabKey()
>># 
>># Modifications:
>># $Log: tgrabkey.m,v $
>># Revision 1.1  2005-02-12 14:38:24  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:37:00  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.1  1998/11/20 23:36:32  mar
>># req.4.W.00130: use a valid keysym instead of zero (min is 8)
>>#
>># Revision 7.0  1998/10/30 22:59:54  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:28:07  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:41  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:18:10  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:11:22  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>
#ifdef XTESTEXTENSION
#include <X11/extensions/XTest.h>
#endif

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;
XKeyboardControl kbvalues;
Widget topLevel;

Widget panedw, boxw1, boxw2;
Widget labelw, click_pass, click_fail;
char label[80];
Widget labelw_msg;

#ifdef XTESTEXTENSION
/*
** procedure XtTMO_Proc
*/
void XtTMO_Proc2(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
XEvent event;
	/*fake user input to get autorepeat back*/
	event.xkey.type = KeyRelease;
	event.xkey.display = XtDisplay(labelw_msg);
	event.xkey.window = XtWindow(labelw_msg);
	event.xkey.x = -1;
	XSelectInput( XtDisplay(topLevel), XtWindow(labelw_msg), KeyReleaseMask);
	XSendEvent(XtDisplay(labelw_msg), XtWindow(labelw_msg), False, KeyReleaseMask, &event);
	tet_infoline("ERROR: Timed out waiting for input");
	tet_result(TET_UNRESOLVED);
}
/*
** procedure XtTMO_Proc
*/
void XtTMO_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
Position rootx, rooty;

	XtAppAddTimeOut(app_ctext, (unsigned long)2000, XtTMO_Proc2, topLevel);
	tet_infoline("PREP: Send KeyRelease outside grab widget");
	XtTranslateCoords(labelw_msg, 0,0,&rootx, &rooty);
	XTestFakeMotionEvent(XtDisplay(labelw_msg), -1, rootx+10, rooty+10, CurrentTime);
	XTestFakeKeyEvent(XtDisplay(labelw_msg), XKeysymToKeycode(XtDisplay(labelw_msg), 32), True, CurrentTime);
	XTestFakeMotionEvent(XtDisplay(labelw_msg), -1, rootx-100, rooty, CurrentTime);
	XTestFakeKeyEvent(XtDisplay(labelw_msg), XKeysymToKeycode(XtDisplay(labelw_msg), 32), False, CurrentTime);
}

static void analyse_events(TestWidget)
Widget TestWidget;
{
	XtPointer client_data, call_data;
	XtAppContext app_context;
	Display *display;
	XEvent event;
	Window window;
	int eflag = 3;
	app_context = XtWidgetToApplicationContext(TestWidget);
	display = XtDisplay(TestWidget);
	window = XtWindow(TestWidget);
	for (;;) {
	XtAppNextEvent(app_context, &event);
	if (eflag < 3)
	eflag--;
	if (event.type == KeyRelease) {
	tet_infoline("TEST: KeyRelease sent to proper place");
	 if (event.xkey.window != window) {
		sprintf(ebuf, "ERROR: Key did not go to correct widget");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
		eflag = 2;
		kbvalues.auto_repeat_mode = AutoRepeatModeOn;
		XChangeKeyboardControl(XtDisplay(topLevel), KBAutoRepeatMode, &kbvalues);
		/*this hack seems to be necessary to get the kbd control to take*/
		send_event(topLevel, FocusIn, FocusChangeMask, TRUE);
		send_event(topLevel, FocusOut, FocusChangeMask, TRUE);
	 }
	 if (event.xkey.x >= 0) {
		sprintf(ebuf, "ERROR: KeyRelease was not left of window");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
		eflag = 2;
		kbvalues.auto_repeat_mode = AutoRepeatModeOn;
		XChangeKeyboardControl(XtDisplay(topLevel), KBAutoRepeatMode, &kbvalues);
		/*this hack seems to be necessary to get the kbd control to take*/
		send_event(topLevel, FocusIn, FocusChangeMask, TRUE);
		send_event(topLevel, FocusOut, FocusChangeMask, TRUE);
	 }
	 else {
		tet_result(TET_PASS);
		kbvalues.auto_repeat_mode = AutoRepeatModeOn;
		XChangeKeyboardControl(XtDisplay(topLevel), KBAutoRepeatMode, &kbvalues);
		/*this hack seems to be necessary to get the kbd control to take*/
		 send_event(topLevel, FocusIn, FocusChangeMask, TRUE);
		 send_event(topLevel, FocusOut, FocusChangeMask, TRUE);
		eflag = 2;
	 }
	} /*end if release*/
	XtDispatchEvent(&event);
	if (eflag == 0)
	exit(0);
	} /* end for*/
}
#endif
>>TITLE XtGrabKey Xt9
void
XtGrabKey(widget, keycode, modifiers, owner_events pointer_mode, keyboard_mode)
>>ASSERTION Good A
When the widget
.A widget
is realized a successful call to
void XtGrabKey(widget, keycode, modifiers, owner_events, 
pointer_mode, keyboard_mode)
shall call XGrabKey to establish a passive key grab 
for the widget
.A widget.
>>CODE
int status;
char *msg = "This is the grab widget\n";
pid_t pid2;

#ifdef XTESTEXTENSION
	FORK(pid2);
	xt_tomultiple = 3;
	tet_infoline("PREP: Initialize toolkit, Open display and Create topLevel root widget");
	topLevel = (Widget) avs_xt_init("Tgrabkey1", NULL, 0);
	tet_infoline("PREP: Disable autorepeat (which would break this test)");
	kbvalues.auto_repeat_mode = AutoRepeatModeOff;
	XChangeKeyboardControl(XtDisplay(topLevel), KBAutoRepeatMode, &kbvalues);
	tet_infoline("PREP: Set up the XtToolkitError handler");
	app_ctext = XtWidgetToApplicationContext(topLevel);
	XtAppSetErrorMsgHandler(app_ctext, xt_handler);
	tet_infoline("PREP: Set up widget tree of depth eight (8) return panedw widget");
	panedw = (Widget) avs_xt_tree(topLevel);
	tet_infoline("PREP: Create boxw1 widget in panedw widget");
	boxw1 = (Widget) CreateBoxWidget(panedw);
	tet_infoline("PREP: Get the label widget name");
	strcpy(label, (char *)title("XtGrabKey") );
	sprintf(ebuf, "PREP: Create label: %s in boxw1 widget", label);
	tet_infoline(ebuf);
	labelw = (Widget) CreateLabelWidget(label, boxw1);
	tet_infoline("PREP: Create boxw2 widget in panedw widget");
	boxw2 = (Widget) CreateBoxWidget(panedw);
	tet_infoline("PREP: Set height and width of boxw2 widget");
	(void) ConfigureDimension(topLevel, boxw2);
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Establish passive grab with XtGrabKey");
	XtGrabKey(labelw_msg, AnyKey, AnyModifier, FALSE, GrabModeAsync, GrabModeAsync);
	XtAppAddTimeOut(app_ctext, (unsigned long)500, XtTMO_Proc, topLevel);
	
	analyse_events(labelw_msg);
	LKROF(pid2, (AVSXTTIMEOUT-2)*xt_tomultiple);
#else
		tet_infoline("INFO: XTEST extension not configured");
		tet_result(TET_UNSUPPORTED);
#endif
>>ASSERTION Good A
When the widget
.A widget
is not realized a successful call to
void XtGrabKey(widget, keycode, modifiers, owner_events pointer_mode, 
keyboard_mode)
shall cause XGrabKey to be called to establish a passive key grab 
for the specified widget when it is realized.
>>CODE
int status;
char *msg = "This is the grab widget\n";
pid_t pid2;

#ifdef XTESTEXTENSION
	FORK(pid2);
	xt_tomultiple = 3;
	tet_infoline("PREP: Initialize toolkit, Open display and Create topLevel root widget");
	topLevel = (Widget) avs_xt_init("Tgrabkey2", NULL, 0);
	tet_infoline("PREP: Disable autorepeat (which would break this test)");
	kbvalues.auto_repeat_mode = AutoRepeatModeOff;
	XChangeKeyboardControl(XtDisplay(topLevel), KBAutoRepeatMode, &kbvalues);
	tet_infoline("PREP: Set up the XtToolkitError handler");
	app_ctext = XtWidgetToApplicationContext(topLevel);
	XtAppSetErrorMsgHandler(app_ctext, xt_handler);
	tet_infoline("PREP: Set up widget tree of depth eight (8) return panedw widget");
	panedw = (Widget) avs_xt_tree(topLevel);
	tet_infoline("PREP: Create boxw1 widget in panedw widget");
	boxw1 = (Widget) CreateBoxWidget(panedw);
	tet_infoline("PREP: Get the label widget name");
	strcpy(label, (char *)title("XtGrabKey") );
	sprintf(ebuf, "PREP: Create label: %s in boxw1 widget", label);
	tet_infoline(ebuf);
	labelw = (Widget) CreateLabelWidget(label, boxw1);
	tet_infoline("PREP: Create boxw2 widget in panedw widget");
	boxw2 = (Widget) CreateBoxWidget(panedw);
	tet_infoline("PREP: Set height and width of boxw2 widget");
	(void) ConfigureDimension(topLevel, boxw2);
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Establish passive grab with XtGrabKey");
	XtGrabKey(labelw_msg, AnyKey, AnyModifier, FALSE, GrabModeAsync, GrabModeAsync);
	XtAppAddTimeOut(app_ctext, (unsigned long)500, XtTMO_Proc, topLevel);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	analyse_events(labelw_msg);
	LKROF(pid2, (AVSXTTIMEOUT-2)*xt_tomultiple);
#else
		tet_infoline("INFO: XTEST extension not configured");
		tet_result(TET_UNSUPPORTED);
#endif
>>ASSERTION Good A
When the widget
.A widget
is realized a successful call to
void XtGrabKey(widget, keycode, modifiers, owner_events pointer_mode, 
keyboard_mode)
shall cause XGrabKey to be called to establish a passive key grab 
for the specified widget when the widget is next realized 
following an unrealize action on the widget.
>>CODE
int status;
char *msg = "This is the grab widget\n";
pid_t pid2;

#ifdef XTESTEXTENSION
	FORK(pid2);
	xt_tomultiple = 3;
	tet_infoline("PREP: Initialize toolkit, Open display and Create topLevel root widget");
	topLevel = (Widget) avs_xt_init("Tgrabkey3", NULL, 0);
	tet_infoline("PREP: Disable autorepeat (which would break this test)");
	kbvalues.auto_repeat_mode = AutoRepeatModeOff;
	XChangeKeyboardControl(XtDisplay(topLevel), KBAutoRepeatMode, &kbvalues);
	tet_infoline("PREP: Set up the XtToolkitError handler");
	app_ctext = XtWidgetToApplicationContext(topLevel);
	XtAppSetErrorMsgHandler(app_ctext, xt_handler);
	tet_infoline("PREP: Set up widget tree of depth eight (8) return panedw widget");
	panedw = (Widget) avs_xt_tree(topLevel);
	tet_infoline("PREP: Create boxw1 widget in panedw widget");
	boxw1 = (Widget) CreateBoxWidget(panedw);
	tet_infoline("PREP: Get the label widget name");
	strcpy(label, (char *)title("XtGrabKey") );
	sprintf(ebuf, "PREP: Create label: %s in boxw1 widget", label);
	tet_infoline(ebuf);
	labelw = (Widget) CreateLabelWidget(label, boxw1);
	tet_infoline("PREP: Create boxw2 widget in panedw widget");
	boxw2 = (Widget) CreateBoxWidget(panedw);
	tet_infoline("PREP: Set height and width of boxw2 widget");
	(void) ConfigureDimension(topLevel, boxw2);
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Establish passive grab with XtGrabKey");
	XtGrabKey(labelw_msg, AnyKey, AnyModifier, FALSE, GrabModeAsync, GrabModeAsync);
	tet_infoline("PREP: Unrealize grab widget");
	XtRealizeWidget(labelw_msg);
	tet_infoline("PREP: Realize grab widget");
	XtRealizeWidget(labelw_msg);
	XtAppAddTimeOut(app_ctext, (unsigned long)500, XtTMO_Proc, topLevel);
	analyse_events(labelw_msg);
	LKROF(pid2, (AVSXTTIMEOUT-2)*xt_tomultiple);
#else
		tet_infoline("INFO: XTEST extension not configured");
		tet_result(TET_UNSUPPORTED);
#endif
>>ASSERTION Good B 0
After a passive key grab is established for the widget
.A widget
by a call to
void XtGrabKey(widget, keycode, modifiers, owner_events pointer_mode, 
keyboard_mode)
when an event matching 
.A keycode
and 
.A modifiers
occurs in the specified widget, a modal cascade exists, 
and the widget is not in the active subset of the modal 
cascade the grab shall not be performed.
>>ASSERTION Good D 0
If the implementation is X11R5 or later:
After a passive key grab is established for the widget
.A widget
by a call to
void XtGrabKey(widget, keycode, modifiers, owner_events pointer_mode, 
keyboard_mode)
when an event matching 
.A keycode
and 
.A modifiers
occurs in the specified widget and an input method exists 
for the widget the grab shall not be performed.
