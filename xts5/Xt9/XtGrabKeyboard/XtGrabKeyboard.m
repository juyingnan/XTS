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
>># File: xts/Xt9/XtGrabKeyboard/XtGrabKeyboard.m
>># 
>># Description:
>>#	Tests for XtGrabKeyboard()
>># 
>># Modifications:
>># $Log: tgrabkybd.m,v $
>># Revision 1.1  2005-02-12 14:38:24  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:37:01  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.1  1998/11/20 23:36:07  mar
>># req.4.W.00130: use a valid keysym instead of zero (min is 8)
>>#
>># Revision 7.0  1998/10/30 22:59:55  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:28:08  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:42  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:18:14  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:11:27  andy
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

Widget panedw, boxw1, boxw2;
Widget click_pass, click_fail;
char label[80];
XKeyboardControl kbvalues;
Widget topLevel;
Widget labelw;
int eflag = 3;

#ifdef XTESTEXTENSION
void hack()
{
		eflag = 2;
		kbvalues.auto_repeat_mode = AutoRepeatModeOn;
		XChangeKeyboardControl(XtDisplay(topLevel), KBAutoRepeatMode, &kbvalues);
		/*this hack seems to be necessary to get the kbd control to take*/
		send_event(topLevel, FocusIn, FocusChangeMask, TRUE);
		send_event(topLevel, FocusOut, FocusChangeMask, TRUE);
}

/*
** procedure XtTMO_Proc
*/
void XtTMO_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
XEvent event;
	/*fake user input to get autorepeat back*/
	event.xkey.type = KeyRelease;
	event.xkey.display = XtDisplay(labelw);
	event.xkey.window = XtWindow(labelw);
	event.xkey.x = -1;
	XSelectInput( XtDisplay(topLevel), XtWindow(labelw), KeyReleaseMask);
	XSendEvent(XtDisplay(labelw), XtWindow(labelw), False, KeyReleaseMask, &event);
	tet_infoline("ERROR: Timed out waiting for user input");
	tet_result(TET_UNRESOLVED);
}

static void analyse_events(TestWidget)
Widget TestWidget;
{
	XtAppContext app_context;
	Display *display;
	XEvent event;
	int didthis = 0;
	Window window;
	int ret_value;
	Position rootx, rooty;

	app_context = XtWidgetToApplicationContext(TestWidget);
	display = XtDisplay(TestWidget);
	window = XtWindow(TestWidget);
	for (;;) {
	 XtAppNextEvent(app_context, &event);
	if (eflag < 3)
		eflag--;
	 XSync(display, False);
	 if (event.type == KeyPress) {
		if (event.xkey.window != window) {
			sprintf(ebuf, "ERROR: KeyPress event in wrong window. Wanted 0x%08lx, got 0x%08lx", window, event.xkey.window);
			tet_infoline(ebuf);
			tet_result(TET_FAIL);
			hack();
		}
	}
	if (event.type == KeyRelease) {
		if (event.xkey.window != window) {
		 sprintf(ebuf, "ERROR: KeyRelease event in wrong window. Wanted 0x%08lx, got 0x%08lx", window, event.xkey.window);
		 tet_infoline(ebuf);
		 tet_result(TET_FAIL);
			hack();
		}
		else {
			tet_result(TET_PASS);
			hack();
		}
	}
	 if (event.type == Expose && event.xexpose.window == window) {
		if (didthis == 0) {
			didthis = 1;
			tet_infoline("PREP: Grab Keyboard");
				ret_value = XtGrabKeyboard(TestWidget, FALSE, GrabModeAsync, GrabModeAsync, CurrentTime);
				if (ret_value != Success) {
				sprintf(ebuf, "ERROR: XtGrabKeyboard Call Failed with result %d.", ret_value);
				tet_infoline(ebuf);
				tet_result(TET_FAIL);
				hack();
				}
			tet_infoline("PREP: Simulate user input");
			XtTranslateCoords(TestWidget, 0,0,&rootx, &rooty);
			XTestFakeMotionEvent(XtDisplay(TestWidget), -1, rootx-100, rooty, CurrentTime);
			XTestFakeKeyEvent(XtDisplay(TestWidget), XKeysymToKeycode(XtDisplay(TestWidget), 32), True, CurrentTime);
			XTestFakeKeyEvent(XtDisplay(TestWidget), XKeysymToKeycode(XtDisplay(TestWidget), 32), False, CurrentTime);
			tet_infoline("TEST: Analyze events");
		}
	} 
 XtDispatchEvent(&event);
	 if (eflag == 0) {
		exit(0);
	}
	} /* end for */
}
#endif
>>TITLE XtGrabKeyboard Xt9
int
XtGrabKeyboard(widget, owner_events, pointer_mode, keyboard_mode, time);
>>ASSERTION Good A
When the widget
.A widget
is realized
a successful call to
int XtGrabKeyboard(widget, owner_events, pointer_mode, keyboard_mode, 
time)
shall call XGrabKeyboard to make an active grab of the keyboard for the 
specified widget.
>>CODE
int status;
char *msg = "This is the widget which will grab the keyboard";
pid_t pid2;

#ifdef XTESTEXTENSION
	FORK(pid2);
	xt_tomultiple=3;
	tet_infoline("PREP: Initialize toolkit, Open display and Create topLevel root widget");
	topLevel = (Widget) avs_xt_init("Tgrabkybd1", NULL, 0);
	tet_infoline("PREP: Set up the XtToolkitError handler");
	app_ctext = XtWidgetToApplicationContext(topLevel);
	XtAppSetErrorMsgHandler(app_ctext, xt_handler);
	tet_infoline("PREP: Disable autorepeat (which would break this test)");
	kbvalues.auto_repeat_mode = AutoRepeatModeOff;
	XChangeKeyboardControl(XtDisplay(topLevel), KBAutoRepeatMode, &kbvalues);
	tet_infoline("PREP: Set up widget tree of depth eight (8) return panedw widget");
	panedw = (Widget) avs_xt_tree(topLevel);
	tet_infoline("PREP: Create boxw1 widget in panedw widget");
	boxw1 = (Widget) CreateBoxWidget(panedw);
	tet_infoline("PREP: Get the label widget name");
	strcpy(label, (char *)title("XtGrabKeyboard") );
	sprintf(ebuf, "PREP: Create label: %s in boxw1 widget", label);
	tet_infoline(ebuf);
	labelw = (Widget) CreateLabelWidget(label, boxw1);
	tet_infoline("PREP: Create boxw2 widget in panedw widget");
	boxw2 = (Widget) CreateBoxWidget(panedw);
	tet_infoline("PREP: Set height and width of boxw2 widget");
	(void) ConfigureDimension(topLevel, boxw2);
	labelw = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtAppAddTimeOut(app_ctext, (unsigned long)5000, XtTMO_Proc, topLevel);
	XtRealizeWidget(topLevel);
	analyse_events(labelw);
	LKROF(pid2, (AVSXTTIMEOUT-2)*xt_tomultiple);
#else
		tet_infoline("INFO: XTEST extension is not configured");
		tet_result(TET_UNSUPPORTED);
#endif
>>ASSERTION Good A
A call to
int XtGrabKeyboard(widget, owner_events, pointer_mode, keyboard_mode, 
time)
when the widget
.A widget
is not realized shall not activate the keyboard grab and shall return
.S GrabNotViewable.
>>CODE
int ret_value;
char *msg = "This is the widget which will grab the keyboard";
pid_t pid2;

	FORK(pid2);
	xt_tomultiple=3;
	tet_infoline("PREP: Initialize toolkit, Open display and Create topLevel root widget");
	topLevel = (Widget) avs_xt_init("Tgrabkybd1", NULL, 0);
	tet_infoline("PREP: Set up the XtToolkitError handler");
	app_ctext = XtWidgetToApplicationContext(topLevel);
	XtAppSetErrorMsgHandler(app_ctext, xt_handler);
	tet_infoline("PREP: Disable autorepeat (which would break this test)");
	kbvalues.auto_repeat_mode = AutoRepeatModeOff;
	XChangeKeyboardControl(XtDisplay(topLevel), KBAutoRepeatMode, &kbvalues);
	tet_infoline("PREP: Set up widget tree of depth eight (8) return panedw widget");
	panedw = (Widget) avs_xt_tree(topLevel);
	tet_infoline("PREP: Create boxw1 widget in panedw widget");
	boxw1 = (Widget) CreateBoxWidget(panedw);
	tet_infoline("PREP: Get the label widget name");
	strcpy(label, (char *)title("XtGrabKeyboard") );
	sprintf(ebuf, "PREP: Create label: %s in boxw1 widget", label);
	tet_infoline(ebuf);
	labelw = (Widget) CreateLabelWidget(label, boxw1);
	tet_infoline("PREP: Create boxw2 widget in panedw widget");
	boxw2 = (Widget) CreateBoxWidget(panedw);
	tet_infoline("PREP: Set height and width of boxw2 widget");
	(void) ConfigureDimension(topLevel, boxw2);
	labelw = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("TEST: Grab the keyboard without realizing the widgets");
	ret_value = XtGrabKeyboard(labelw, FALSE, GrabModeAsync, GrabModeAsync, CurrentTime);
	tet_infoline("TEST: Return value");
	if (ret_value != GrabNotViewable) {
		sprintf(ebuf, "ERROR: XtGrabKeyboard returned %d, expected GrabNotViewable (%d)", ret_value, GrabNotViewable);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	LKROF(pid2, (AVSXTTIMEOUT-2)*xt_tomultiple);
	tet_result(TET_PASS);
