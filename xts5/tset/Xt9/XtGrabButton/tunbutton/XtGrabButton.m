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
$Header: /cvs/xtest/xtest/xts5/tset/Xt9/XtGrabButton/XtGrabButton.m,v 1.1 2005-02-12 14:38:24 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt9/XtGrabButton/XtGrabButton.m
>># 
>># Description:
>>#	Tests for XtUngrabButton()
>># 
>># Modifications:
>># $Log: tunbutton.m,v $
>># Revision 1.1  2005-02-12 14:38:24  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:37:03  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:59:56  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:28:09  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:44  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:18:18  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:11:33  andy
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
Widget labelw_msg;

#ifdef XTESTEXTENSION
static void
analyse_events(TestWidget)
Widget TestWidget;
{
	XtAppContext app_context;
	Display *display;
	XEvent loop_event;
	Window window;
	Widget widget;
	app_context = XtWidgetToApplicationContext(TestWidget);
	display = XtDisplay(TestWidget);
	/*
	** Poll events
	*/
	for (;;) {
	 XtAppNextEvent(app_context, &loop_event);
	 XSync(display, False);
	 XtDispatchEvent(&loop_event);
	 if (loop_event.type == ButtonPress) {
		tet_infoline("INFO: ButtonPress event received");
	}
	 if (loop_event.type == ButtonRelease) {
		tet_infoline("TEST: Button release not sent to grab widget");
	 	if (XtWindow(TestWidget) == loop_event.xbutton.window) {
			tet_infoline("ERROR: Event sent to grab window");
			tet_result(TET_FAIL);
			exit(0);
		}
		else {
			tet_result(TET_PASS);
			exit(0);
		}
	}
	} /* end for */
}
Widget labelw, click_pass, click_fail;
char label[80];

/*
** procedure XtTMO_Proc
*/
void XtTMO_Proc2(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
XEvent event;
	tet_infoline("ERROR: Timed out waiting for input");
	tet_result(TET_UNRESOLVED);
	exit(0);
}

/*
** procedure XtTMO_Proc
*/
void XtTMO_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	Position rootx, rooty;

	XtAppAddTimeOut(app_ctext, (unsigned long)4000, XtTMO_Proc2, topLevel);
	tet_infoline("PREP: Move inside of grab widget");
	XtTranslateCoords(labelw_msg, 0,0,&rootx, &rooty);
	XTestFakeMotionEvent(XtDisplay(labelw_msg), -1, rootx+100, rooty, CurrentTime);
	tet_infoline("PREP: Depress button");
	XTestFakeButtonEvent(XtDisplay(labelw_msg), 1, True, CurrentTime);
	tet_infoline("PREP: Move outside of grab widget");
	XTestFakeMotionEvent(XtDisplay(labelw_msg), -1, rootx-100, rooty+100, CurrentTime);
	tet_infoline("PREP: Release button");
	XTestFakeButtonEvent(XtDisplay(labelw_msg), 1, False, CurrentTime);
}
#endif
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtGrabButton Xt9
void
XtGrabButton(widget, button, modifiers, owner_events, event_mask, pointer_mode, keyboard_mode, confine_to, cursor)
>>ASSERTION Good A
A successful call to 
void XtUngrabButton(widget, button, modifiers)
when the widget specified by
.A widget 
has a passive button grab established for 
.A button 
and
.A modifiers
shall cancel the grab.
>>CODE
Display *display;
int status;
Window window;
int ret_value;
char *msg = "This is the grab widget\n";
pid_t pid2;

#ifdef XTESTEXTENSION
	FORK(pid2);
	xt_tomultiple=3;
	tet_infoline("PREP: Initialize toolkit, Open display and Create topLevel root widget");
	topLevel = (Widget) avs_xt_init("Tgrabbutn1", NULL, 0);
	tet_infoline("PREP: Set up the XtToolkitError handler");
	app_ctext = XtWidgetToApplicationContext(topLevel);
	XtAppSetErrorMsgHandler(app_ctext, xt_handler);
	tet_infoline("PREP: Set up widget tree of depth eight (8) return panedw widget");
	panedw = (Widget) avs_xt_tree(topLevel);
	tet_infoline("PREP: Create boxw1 widget in panedw widget");
	boxw1 = (Widget) CreateBoxWidget(panedw);
	tet_infoline("PREP: Get the label widget name");
	strcpy(label, (char *)title("XtGrabButton") );
	labelw = (Widget) CreateLabelWidget(label, boxw1);
	tet_infoline("PREP: Create boxw2 widget in panedw widget");
	boxw2 = (Widget) CreateBoxWidget(panedw);
	tet_infoline("PREP: Set height and width of boxw2 widget");
	(void) ConfigureDimension(topLevel, boxw2);
	sprintf(ebuf, "PREP: Create label requesting user input");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	XtAppAddTimeOut(app_ctext, (unsigned long)500, XtTMO_Proc, topLevel);
	tet_infoline("PREP: Issue XtGrabButton");
	XtGrabButton(labelw_msg, AnyButton, AnyModifier, True,
		 ButtonPressMask|ButtonReleaseMask, GrabModeAsync,
		 GrabModeAsync, XtWindow(labelw_msg), None);
	tet_infoline("PREP: Issue XtUngrabButton");
	XtUngrabButton(labelw_msg, AnyButton, AnyModifier);
        XSelectInput(XtDisplay(topLevel), XtWindow(topLevel), ButtonPressMask|ButtonReleaseMask|KeyPressMask|KeyReleaseMask|ExposureMask|OwnerGrabButtonMask);
	analyse_events(labelw_msg);
	LKROF(pid2, (AVSXTTIMEOUT-2)*xt_tomultiple);
#else
	tet_infoline("INFO: XTEST extension is not configured");
	tet_result(TET_UNSUPPORTED);
#endif
>>ASSERTION Good A
A successful call to
void XtUngrabButton(widget, button, modifiers)
when the widget
.A widget
is not realized and has a deferred passive pointer grab 
established for
.A button
and
.A modifiers
shall 
cancel the grab.
>>CODE
Display *display;
int status;
Window window;
int ret_value;
char *msg = "This is the grab widget\n";
pid_t pid2;

#ifdef XTESTEXTENSION
	FORK(pid2);
	xt_tomultiple=3;
	tet_infoline("PREP: Initialize toolkit, Open display and Create topLevel root widget");
	topLevel = (Widget) avs_xt_init("Tgrabbutn2", NULL, 0);
	tet_infoline("PREP: Set up the XtToolkitError handler");
	app_ctext = XtWidgetToApplicationContext(topLevel);
	XtAppSetErrorMsgHandler(app_ctext, xt_handler);
	tet_infoline("PREP: Set up widget tree of depth eight (8) return panedw widget");
	panedw = (Widget) avs_xt_tree(topLevel);
	tet_infoline("PREP: Create boxw1 widget in panedw widget");
	boxw1 = (Widget) CreateBoxWidget(panedw);
	tet_infoline("PREP: Get the label widget name");
	strcpy(label, (char *)title("XtGrabButton") );
	labelw = (Widget) CreateLabelWidget(label, boxw1);
	tet_infoline("PREP: Create boxw2 widget in panedw widget");
	boxw2 = (Widget) CreateBoxWidget(panedw);
	tet_infoline("PREP: Set height and width of boxw2 widget");
	(void) ConfigureDimension(topLevel, boxw2);
	sprintf(ebuf, "PREP: Create label requesting user input");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	XtAppAddTimeOut(app_ctext, (unsigned long)500, XtTMO_Proc, topLevel);
	tet_infoline("PREP: Issue XtGrabButton");
	XtGrabButton(labelw_msg, AnyButton, AnyModifier, True,
		 ButtonPressMask|ButtonReleaseMask, GrabModeAsync,
		 GrabModeAsync, XtWindow(labelw_msg), None);
	tet_infoline("PREP: Unrealize grab widget");
	XtUnrealizeWidget(labelw_msg);
	tet_infoline("PREP: Issue XtUngrabButton");
	XtUngrabButton(labelw_msg, AnyButton, AnyModifier);
	tet_infoline("PREP: Realize grab widget");
	XtRealizeWidget(labelw_msg);
        XSelectInput(XtDisplay(topLevel), XtWindow(topLevel), ButtonPressMask|ButtonReleaseMask|KeyPressMask|KeyReleaseMask|ExposureMask|OwnerGrabButtonMask);
	analyse_events(labelw_msg);
	LKROF(pid2, (AVSXTTIMEOUT-2)*xt_tomultiple);
#else
	tet_infoline("INFO: XTEST extension is not configured");
	tet_result(TET_UNSUPPORTED);
#endif
