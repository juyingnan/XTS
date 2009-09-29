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
>># File: xts/Xt9/XtUngrabKey.m
>># 
>># Description:
>>#	Tests for XtUngrabKey()
>># 
>># Modifications:
>># $Log: tungrabky.m,v $
>># Revision 1.1  2005-02-12 14:38:24  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:37:01  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.1  1998/11/20 23:34:55  mar
>># req.4.W.00130: use a valid keysym instead of zero (min is 8)
>>#
>># Revision 7.0  1998/10/30 22:59:54  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:28:07  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:42  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:18:12  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:11:25  andy
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
Widget click_pass, click_fail;

XKeyboardControl kbvalues;
Widget topLevel;
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
	event.xkey.display = XtDisplay(topLevel);
	event.xkey.window = XtWindow(topLevel);
	event.xkey.x = -1;
	XSelectInput( XtDisplay(topLevel), XtWindow(topLevel), KeyReleaseMask);
	XSendEvent(XtDisplay(topLevel), XtWindow(topLevel), False, KeyReleaseMask, &event);
	tet_infoline("ERROR: Timed out waiting for user input");
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
	XtAppContext app_context;
	Display *display;
	XEvent loop_event;
	int eflag = 3;
	Window window;
	app_context = XtWidgetToApplicationContext(TestWidget);
	display = XtDisplay(TestWidget);
	window = XtWindow(TestWidget);
	for (;;) {
	 XtAppNextEvent(app_context, &loop_event);
	 if (eflag < 3)
		eflag--;
	 if (loop_event.type == KeyRelease) {
	tet_infoline("TEST: Release event not sent to grab widget");
	 if (loop_event.xkey.window == window) {
		sprintf(ebuf, "ERROR: Key Release did not go to correct widget");
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
	XtDispatchEvent(&loop_event);
	if (eflag == 0)
	exit(0);
	} /* end for */
}
#endif
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtUngrabKey Xt9
void
XtUngrabKey(widget, keycode, modifiers)
>>ASSERTION Good A
A successful call to 
void XtUngrabKey(widget, keycode, modifiers)
when the widget
.A widget
has a passive key grab established for 
.A keycode 
and 
.A modifiers 
shall cancel the grab.
>>CODE
char label[80];
int status;
char *msg = "This is the grab widget\n";
pid_t pid2;

#ifdef XTESTEXTENSION
	FORK(pid2);
	xt_tomultiple=3;
	tet_infoline("PREP: Initialize toolkit, Open display and Create topLevel root widget");
	topLevel = (Widget) avs_xt_init("Tungrabky1", NULL, 0);
	tet_infoline("PREP: Set up the XtToolkitError handler");
	app_ctext = XtWidgetToApplicationContext(topLevel);
	XtAppSetErrorMsgHandler(app_ctext, xt_handler);
	tet_infoline("PREP: Set up widget tree of depth eight (8) return panedw widget");
	panedw = (Widget) avs_xt_tree(topLevel);
	tet_infoline("PREP: Create boxw1 widget in panedw widget");
	boxw1 = (Widget) CreateBoxWidget(panedw);
	tet_infoline("PREP: Get the label widget name");
	strcpy(label, (char *)title("XtUngrabKey") );
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
	XSelectInput(XtDisplay(panedw), XtWindow(panedw), KeyPressMask|KeyReleaseMask);
	XSelectInput(XtDisplay(boxw1), XtWindow(boxw1), KeyPressMask|KeyReleaseMask);
	XSelectInput(XtDisplay(boxw2), XtWindow(boxw2), KeyPressMask|KeyReleaseMask);
	XSelectInput(XtDisplay(topLevel), XtWindow(topLevel), KeyPressMask|KeyReleaseMask);
	tet_infoline("PREP: Disable autorepeat (which would break this test)");
	kbvalues.auto_repeat_mode = 0;
	XChangeKeyboardControl(XtDisplay(topLevel), KBAutoRepeatMode, &kbvalues);
	tet_infoline("PREP: Register passive grab on any key, any modifier");
	XtGrabKey(labelw_msg, AnyKey, AnyModifier, False, GrabModeAsync, GrabModeAsync);
	tet_infoline("PREP: Release the grab");
	XtUngrabKey(labelw_msg, AnyKey, AnyModifier);
	XtAppAddTimeOut(app_ctext, (unsigned long)500, XtTMO_Proc, topLevel);
	analyse_events(labelw_msg);
	LKROF(pid2, (AVSXTTIMEOUT-2)*xt_tomultiple);
#else
		tet_infoline("INFO: XTEST extension not configured");
		tet_result(TET_UNSUPPORTED);
#endif
>>ASSERTION Good A
A successful call to 
void XtUngrabKey(widget, keycode, modifiers)
when the widget
.A widget
is not realized and has a deferred passive key grab established for
.A keycode
and 
.A modifiers
shall cancel the key grab.
>>CODE
char label[80];
int status;
char *msg = "This is the grab widget\n";
pid_t pid2;

#ifdef XTESTEXTENSION
	FORK(pid2);
	xt_tomultiple=3;
	tet_infoline("PREP: Initialize toolkit, Open display and Create topLevel root widget");
	topLevel = (Widget) avs_xt_init("Tungrabky2", NULL, 0);
	tet_infoline("PREP: Set up the XtToolkitError handler");
	app_ctext = XtWidgetToApplicationContext(topLevel);
	XtAppSetErrorMsgHandler(app_ctext, xt_handler);
	tet_infoline("PREP: Set up widget tree of depth eight (8) return panedw widget");
	panedw = (Widget) avs_xt_tree(topLevel);
	tet_infoline("PREP: Create boxw1 widget in panedw widget");
	boxw1 = (Widget) CreateBoxWidget(panedw);
	tet_infoline("PREP: Get the label widget name");
	strcpy(label, (char *)title("XtUngrabKey") );
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
	XSelectInput(XtDisplay(panedw), XtWindow(panedw), KeyPressMask|KeyReleaseMask);
	XSelectInput(XtDisplay(boxw1), XtWindow(boxw1), KeyPressMask|KeyReleaseMask);
	XSelectInput(XtDisplay(boxw2), XtWindow(boxw2), KeyPressMask|KeyReleaseMask);
	XSelectInput(XtDisplay(topLevel), XtWindow(topLevel), KeyPressMask|KeyReleaseMask);
	tet_infoline("PREP: Disable autorepeat (which would break this test)");
	kbvalues.auto_repeat_mode = 0;
	XChangeKeyboardControl(XtDisplay(topLevel), KBAutoRepeatMode, &kbvalues);
	tet_infoline("PREP: Unrealize widget");
	XtUnrealizeWidget(labelw_msg);
	tet_infoline("PREP: Register passive grab on any key, any modifier");
	XtGrabKey(labelw_msg, AnyKey, AnyModifier, False, GrabModeAsync, GrabModeAsync);
	tet_infoline("PREP: Release the grab");
	XtUngrabKey(labelw_msg, AnyKey, AnyModifier);
	tet_infoline("PREP: Realize widget");
	XtRealizeWidget(labelw_msg);
	XtAppAddTimeOut(app_ctext, (unsigned long)500, XtTMO_Proc, topLevel);
	analyse_events(labelw_msg);
	LKROF(pid2, (AVSXTTIMEOUT-2)*xt_tomultiple);
#else
		tet_infoline("INFO: XTEST extension not configured");
		tet_result(TET_UNSUPPORTED);
#endif
