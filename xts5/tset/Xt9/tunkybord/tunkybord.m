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
$Header: /cvs/xtest/xtest/xts5/tset/Xt9/tunkybord/tunkybord.m,v 1.1 2005-02-12 14:38:24 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt9/tunkybord/tunkybord.m
>># 
>># Description:
>>#	Tests for XtUngrabKeyboard()
>># 
>># Modifications:
>># $Log: tunkybord.m,v $
>># Revision 1.1  2005-02-12 14:38:24  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:37:02  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.1  1998/11/20 23:34:13  mar
>># req.4.W.00130: tp1-3 - use a valid keysym instead of zero (min is 8)
>>#
>># Revision 7.0  1998/10/30 22:59:55  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:28:08  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:43  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:18:15  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:11:29  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>
#ifdef XTESTEXTENSION
#include <X11/extensions/XTest.h>
#endif

XtAppContext app_ctext, app_context;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;
Widget click_pass, click_fail;

#ifdef XTESTEXTENSION
/*
** procedure XtTMO_Proc
*/
void XtTMO_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
XEvent event;
	tet_infoline("ERROR: Timed out waiting for input");
	tet_result(TET_UNRESOLVED);
	exit(0);
}

static void analyse_events(TestWidget)
Widget TestWidget;
{
	Display *display;
	XEvent loop_event;
	Window window;
	Position rootx, rooty;
	 long event_mask;
	/* Event mask that will be set for all windows as they are exposed */
	/* Need key/button press/release plus whatever it takes to make the */
	/* widget work */
	event_mask = KeyPressMask | KeyReleaseMask |
			ButtonPressMask | ButtonReleaseMask |
			EnterWindowMask | LeaveWindowMask |
			ExposureMask | VisibilityChangeMask |
			VisibilityChangeMask;
				
	app_context = XtWidgetToApplicationContext(TestWidget);
	display = XtDisplay(TestWidget);
	window = XtWindow(TestWidget);
	/*
	** Poll events
	*/
	for (;;) {
	 XtAppNextEvent(app_context, &loop_event);
	 XtDispatchEvent(&loop_event);
	 if (loop_event.type == KeyPress) { 
		avs_set_event(1,1);
		if (loop_event.xkey.window == window) {
			avs_set_event(2,1);
		}
	 }
	 if (loop_event.type == KeyRelease) {
		avs_set_event(3,1);
		if (loop_event.xkey.window == window) {
			avs_set_event(4,1);
	 }
	tet_result(TET_PASS);
	exit(0);
	}
	if (loop_event.type == Expose) {
		if (loop_event.xexpose.window == window) {
			tet_infoline("TEST: Grab and ungrab keyboard");
			XtGrabKeyboard(TestWidget, FALSE, GrabModeAsync, GrabModeAsync, CurrentTime);
			XtUngrabKeyboard(TestWidget, CurrentTime);
			tet_infoline("PREP: Simulate user input");
			XtTranslateCoords(TestWidget, 0,0,&rootx, &rooty);
			XTestFakeMotionEvent(XtDisplay(TestWidget), -1, rootx-100, rooty, CurrentTime);
			XTestFakeKeyEvent(XtDisplay(TestWidget), XKeysymToKeycode(XtDisplay(TestWidget), 32), True, CurrentTime);
			XTestFakeKeyEvent(XtDisplay(TestWidget), XKeysymToKeycode(XtDisplay(TestWidget), 32), False, CurrentTime);
		}
		/* Make sure all windows get interesting events */
		XSelectInput(display, loop_event.xexpose.window, event_mask);
		}
	} /* end for */
}
#endif
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtUngrabKeyboard Xt9
void
XtUngrabKeyboard(widget, time)
>>ASSERTION Good A
A successful call to 
void XtUngrabKeyboard(widget, time)
shall cancel the active keyboard grab for the widget
.A widget.
>>CODE
char label[80];
int status;
Widget labelw_msg;
char *msg = "This is the grab window\n";
pid_t pid2;

#ifdef XTESTEXTENSION
	FORK(pid2);
	xt_tomultiple=3;
	tet_infoline("PREP: Initialize toolkit, Open display and Create topLevel root widget");
	topLevel = (Widget) avs_xt_init("Tunkybord1", NULL, 0);
	tet_infoline("PREP: Set up the XtToolkitError handler");
	app_ctext = XtWidgetToApplicationContext(topLevel);
	XtAppSetErrorMsgHandler(app_ctext, xt_handler);
	tet_infoline("PREP: Set up widget tree of depth eight (8) return panedw widget");
	panedw = (Widget) avs_xt_tree(topLevel);
	tet_infoline("PREP: Create boxw1 widget in panedw widget");
	boxw1 = (Widget) CreateBoxWidget(panedw);
	tet_infoline("PREP: Get the label widget name");
	strcpy(label, (char *)title("XtUngrabKeyboard") );
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
	XSelectInput(XtDisplay(topLevel), XtWindow(topLevel), KeyPressMask|KeyReleaseMask);
	XtAppAddTimeOut(app_ctext, (unsigned long)5000, XtTMO_Proc, topLevel);
	analyse_events(labelw_msg);
	LKROF(pid2, (AVSXTTIMEOUT-2)*xt_tomultiple);
	tet_infoline("TEST: Events were not grabbed");
	status = avs_get_event(1);
	check_dec(1, status, "key press outside window count");
	status = avs_get_event(2);
	check_dec(0, status, "key press inside window count");
	status = avs_get_event(3);
	check_dec(1, status, "key release outside window count");
	status = avs_get_event(4);
	check_dec(0, status, "key release inside window count");
#else
	tet_infoline("INFO: XTEST extension not configured");
	tet_result(TET_UNSUPPORTED);
#endif
