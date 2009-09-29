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
>># File: xts/Xt7/XtCallbackPopdown.m
>># 
>># Description:
>>#	Tests for XtCallbackPopdown()
>># 
>># Modifications:
>># $Log: tcalbkpdn.m,v $
>># Revision 1.1  2005-02-12 14:38:15  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:36:51  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:59:44  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:27:58  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:32  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.1  1997/01/21 18:37:09  mar
>># req.4.W.00037: tp3 - set the correct semaphore and set TET_PASS at the end
>># of the test.
>>#
>># Revision 4.0  1995/12/15  09:17:35  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:21:48  andy
>># Prepare for GA Release
>>#
>>EXTERN
#define DEBUG
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>
#include <X11/ShellP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;
ShellWidget menuw;
int test_for;

ShellWidget menuw;
Widget labelw_good;
Widget label2_good;
Widget labelw_good;
Widget pushb_good, rowcolw_good;
Widget pushb_good2, rowcolw_good2;
ShellWidget menuw2, menuw3;
Widget pushb_good3, rowcolw_good3;

int status = 0;

/*timeout callback*/
void XtTI2a(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	exit(0);
}

/*timeout callback*/
void XtTI2b(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	tet_infoline("PREP: Send KeyPress event to popups' parent");
	send_event(labelw_good, KeyPress, KeyPressMask, TRUE);
	tet_infoline("PREP: Send KeyPress event to popup1");
	send_event((Widget)menuw, KeyPress, KeyPressMask, TRUE);
	tet_infoline("PREP: Send KeyPress event to popup2");
	send_event((Widget)menuw2, KeyPress, KeyPressMask, TRUE);
	tet_infoline("PREP: Send KeyPress event to popup3");
	send_event((Widget)menuw3, KeyPress, KeyPressMask, TRUE);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTI2a, NULL);
}


/*timeout callback*/
void XtTI2c(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	tet_infoline("TEST: Popups' parent did not receive KeyPress");
	status = avs_get_event(2);
	check_dec(0, status, "events received by popups' parent count");
	if (test_for != 2) {
		tet_infoline("TEST: Popup1 received KeyPress");
		status = avs_get_event(3);
		check_dec(1, status, "events received by popup1 count");
	} else {
		tet_infoline("TEST: Popup1 did not receive KeyPress");
		status = avs_get_event(3);
		check_dec(0, status, "events received by popup1 count");
	}
	tet_infoline("TEST: Popup2 received KeyPress");
	status = avs_get_event(4);
	check_dec(1, status, "events received by popup2 count");
	tet_infoline("TEST: Popup3 received KeyPress");
	status = avs_get_event(1);
	check_dec(1, status, "events received by popup3 count");
	tet_infoline("TEST: Invoke callback function XtCallbackPopdown()");
	XtCallCallbacks(labelw_good, XtNdestroyCallback, (XtPointer)NULL);
	avs_set_event(1,0);
	avs_set_event(2,0);
	avs_set_event(3,0);
	avs_set_event(4,0);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTI2b, NULL);
}

/*timeout callback*/
void XtTI2d(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	tet_infoline("PREP: Send KeyPress event to popups' parent");
	send_event(labelw_good, KeyPress, KeyPressMask, TRUE);
	tet_infoline("PREP: Send KeyPress event to popup1");
	send_event((Widget)menuw, KeyPress, KeyPressMask, TRUE);
	tet_infoline("PREP: Send KeyPress event to popup2");
	send_event((Widget)menuw2, KeyPress, KeyPressMask, TRUE);
	tet_infoline("PREP: Send KeyPress event to popup3");
	send_event((Widget)menuw3, KeyPress, KeyPressMask, TRUE);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTI2c, NULL);
}

/*popups' parent's event handler*/
void XTEV2a(w, client_data, event, contin)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *contin;
{
	if (event->type == KeyPress) {
		avs_set_event(2, avs_get_event(2)+1);
	}
}
/*popup1's event handler*/
void XtEV2b(w, client_data, event, contin)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *contin;
{
	if (event->type == KeyPress) {
		avs_set_event(3, avs_get_event(3)+1);
	}
}
/*popup2's event handler*/
void XtEV2c(w, client_data, event, contin)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *contin;
{
	if (event->type == KeyPress) {
		avs_set_event(4, avs_get_event(4)+1);
	}
}
/*popup3's event handler*/
void XtEV2d(w, client_data, event, contin)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *contin;
{
	if (event->type == KeyPress) {
		avs_set_event(1, avs_get_event(1)+1);
	}
}


void XtCB5_Proc(w, client_data, call_data)
Widget w;
XtPointer client_data, call_data;
{
	avs_set_event(2,1);
	tet_infoline("TEST: call_data");
	if (call_data == NULL) {
		tet_infoline("ERROR: call_data is NULL");
		tet_result(TET_FAIL);
	} else {
		if (*(XtGrabKind *)call_data != XtGrabExclusive) {
			sprintf(ebuf, "ERROR: expected call_data to point to XtGrabExclusive, points to %d", *(XtGrabKind *)call_data);
			tet_infoline(ebuf);
			tet_result(TET_FAIL);
		}
	}
}
void XtCB4_Proc(w, client_data, call_data)
Widget w;
XtPointer client_data, call_data;
{
	avs_set_event(1,1);
}

/*timeout callback*/
void XtTI1_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	tet_infoline("TEST: Shell is popped-down");
	if (menuw->shell.popped_up == True) {
		tet_infoline("ERROR: Shell is not popped down");
		tet_result(TET_FAIL);
	}
	exit(0);
}

void XtTI2_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	exit(0);
}
void XtEM_Proc(str1, str2, str3, str4, str5, car)
String str1, str2, str3, str4, *str5;
Cardinal *car;
{
	avs_set_event(2,1);
}
void XtWM_Proc(str1, str2, str3, str4, str5, car)
String str1, str2, str3, str4, *str5;
Cardinal *car;
{
}

void check_events(w)
Widget w;
{
XEvent loop_event;
Display *display;
int i;

	display = XtDisplay(w);
	for (i = 0; i < 100; i++) {
		XtAppNextEvent(app_ctext, &loop_event);
/*
		sprintf(ebuf, "event %d %d", i, loop_event.type);
		tet_infoline(ebuf);
*/
		XSync(display, False);
		if (loop_event.type == UnmapNotify)  {
			if (loop_event.xunmap.window == XtWindow(w)) {
				avs_set_event(3,1);
				exit(0);
			}
		}
		XtDispatchEvent(&loop_event);
	}
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtCallbackPopdown Xt7
void XtCallbackPopdown(w, client_data, call_data)
>>ASSERTION Good A
A successful invocation of
void XtCallbackPopdown(w, client_data, call_data) 
shall unmap the window of the widget specified by the shell_widget member of
the structure pointed to by client_data.
>>CODE
Widget labelw_good;
Widget pushb_good, rowcolw_good;
XtPopdownIDRec pop_rec[1];
Boolean initial, final;
int status;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tcalbkpdn1", "XtCallbackPopdown");
	tet_infoline("PREP: Create labelw_good widget");
	labelw_good = (Widget) CreateLabelWidget("ApTest", boxw1);
	tet_infoline("PREP: Create a popup shell");
	menuw = (ShellWidget)XtCreatePopupShell("menuw",
			 overrideShellWidgetClass,
			 labelw_good, NULL, 0);
	tet_infoline("PREP: Create a rowcolw_good widget");
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	tet_infoline("PREP: Create pushb_good button in rowcolw_good widget");
	pushb_good = (Widget) CreatePushButtonGadget(
				"Hello",
				rowcolw_good);
	tet_infoline("PREP: Add callback procedure XtCallbackPopdown");
	pop_rec[0].shell_widget = (Widget)menuw;
	pop_rec[0].enable_widget = labelw_good;
	XtAddCallback(labelw_good, XtNdestroyCallback, XtCallbackPopdown, &pop_rec[0]);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Map a Pop-up shell");
	XtPopup((Widget)menuw, XtGrabNone);
	tet_infoline("PREP: Invoke callback function XtCallbackPopdown()");
	XtCallCallbacks(labelw_good, XtNdestroyCallback, (XtPointer)NULL);
	tet_infoline("PREP: Register timeout");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTI1_Proc, topLevel);
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful invocation of
void XtCallbackPopdown(w, client_data, call_data)
shall set the widget specified by the enable_widget member of the structure 
pointed to by client_data to be sensitive.
>>CODE
Widget labelw_good;
Widget pushb_good, rowcolw_good;
XtPopdownIDRec pop_rec[1];
int status;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tcalbkpdn2", "XtCallbackPopdown");
	tet_infoline("PREP: Create labelw_good widget Press Me");
	labelw_good = (Widget) CreateLabelWidget("Press Me", boxw1);
	tet_infoline("PREP: Create a popup shell");
	menuw = (ShellWidget)XtCreatePopupShell("menuw", overrideShellWidgetClass,
			 labelw_good, NULL, 0);
	tet_infoline("PREP: Create a rowcolw_good widget");
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	tet_infoline("PREP: Create pushb_good button Hello in rowcolw_good widget");
	pushb_good = (Widget) CreatePushButtonGadget( "Hello", rowcolw_good);
	tet_infoline("PREP: Add callback procedure XtCallbackPopdown");
	pop_rec[0].shell_widget = (Widget)menuw;
	pop_rec[0].enable_widget = labelw_good;
	XtAddCallback(labelw_good,
			XtNdestroyCallback,
			XtCallbackPopdown,
			&pop_rec[0]
			);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Map a Pop-up shell");
	XtPopup((Widget)menuw, XtGrabNone);
	tet_infoline("TEST: Invoke callback function XtCallbackPopdown()");
	XtCallCallbacks(labelw_good, XtNdestroyCallback, (XtPointer)NULL);
	tet_infoline("TEST: labelw_good widget is sensitive");
	status = XtIsSensitive(labelw_good);
	check_dec(True, status, "XtIsSensitive return value");
	KROF(pid2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When override_redirect is False, an invocation of
void XtCallbackPopdown(w, client_data, call_data)
shall generate a synthetic UnmapNotify event.
>>CODE
Widget labelw_good;
Widget pushb_good, rowcolw_good;
XtPopdownIDRec pop_rec[1];
Boolean initial, final;
int status;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tcalbkpdn1", "XtCallbackPopdown");
	tet_infoline("PREP: Create labelw_good widget");
	labelw_good = (Widget) CreateLabelWidget("ApTest", boxw1);
	tet_infoline("PREP: Create a popup shell");
	menuw = (ShellWidget)XtCreatePopupShell("menuw",
			 overrideShellWidgetClass,
			 labelw_good, NULL, 0);
	menuw->shell.override_redirect=False;
	tet_infoline("PREP: Create a rowcolw_good widget");
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	tet_infoline("PREP: Create pushb_good button in rowcolw_good widget");
	pushb_good = (Widget) CreatePushButtonGadget(
				"Hello",
				rowcolw_good);
	tet_infoline("PREP: Add callback procedure XtCallbackPopdown");
	pop_rec[0].shell_widget = (Widget)menuw;
	pop_rec[0].enable_widget = labelw_good;
	XtAddCallback(labelw_good, XtNdestroyCallback, XtCallbackPopdown, &pop_rec[0]);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Map a Pop-up shell");
	XtPopup((Widget)menuw, XtGrabNone);
	tet_infoline("PREP: Invoke callback function XtCallbackPopdown()");
	XtCallCallbacks(labelw_good, XtNdestroyCallback, (XtPointer)NULL);
	tet_infoline("PREP: Register timeout");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTI2_Proc, topLevel);
	check_events((Widget)menuw);
	KROF(pid2);
	tet_infoline("TEST: UnmapNotify was generated");
	status = avs_get_event(3);
	check_dec(1, status, "UnmapNotify count");
	tet_result(TET_PASS);
>>ASSERTION Good A
An invocation of
void XtCallbackPopdown(w, client_data, call_data)
when the class of the widget specified by the shell_widget member of 
the structure pointed to by client_data is not a subclass of 
shellWidgetClass and the invoking program has been compiled with the 
compiler symbol DEBUG defined shall issue an invalidClass error.
>>CODE
Widget labelw_good;
Widget pushb_good, rowcolw_good;
XtPopdownIDRec pop_rec[1];
Boolean initial, final;
int status;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tcalbkpdn1", "XtCallbackPopdown");
	tet_infoline("PREP: Install error message handler");
	XtAppSetErrorMsgHandler(app_ctext, &XtEM_Proc);
	XtAppSetWarningMsgHandler(app_ctext, &XtWM_Proc);
	tet_infoline("PREP: Create labelw_good widget");
	labelw_good = (Widget) CreateLabelWidget("ApTest", boxw1);
	tet_infoline("PREP: Create a popup shell");
	menuw = (ShellWidget)XtCreatePopupShell("menuw",
			 overrideShellWidgetClass,
			 labelw_good, NULL, 0);
	tet_infoline("PREP: Create a rowcolw_good widget");
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	tet_infoline("PREP: Create pushb_good button in rowcolw_good widget");
	pushb_good = (Widget) CreatePushButtonGadget(
				"Hello",
				rowcolw_good);
	tet_infoline("PREP: Add callback procedure XtCallbackPopdown");
	pop_rec[0].shell_widget = (Widget)rowcolw;
	pop_rec[0].enable_widget = labelw_good;
	XtAddCallback(labelw_good, XtNdestroyCallback, XtCallbackPopdown, &pop_rec[0]);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Map a Pop-up shell");
	XtPopup((Widget)menuw, XtGrabNone);
	tet_infoline("PREP: Invoke callback function XtCallbackPopdown()");
	XtCallCallbacks(labelw_good, XtNdestroyCallback, (XtPointer)NULL);
	tet_infoline("PREP: Register timeout");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTI2_Proc, topLevel);
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	tet_infoline("TEST: Error message was generated");
	status = avs_get_event(2);
	if (status != 1) {
		tet_infoline("ERROR: Error message handler was not called");
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
>>ASSERTION Good A
An invocation of
void XtCallbackPopdown(w, client_data, call_data)
when the popped_up field of the widget specified by the shell_widget 
member of the structure pointed to by client_data is not True shall 
return immediately.
>>CODE
Widget labelw_good;
Widget pushb_good, rowcolw_good;
XtPopdownIDRec pop_rec[1];
int status;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tcalbkpdn2", "XtCallbackPopdown");
	tet_infoline("PREP: Create labelw_good widget Press Me");
	labelw_good = (Widget) CreateLabelWidget("Press Me", boxw1);
	tet_infoline("PREP: Create a popup shell");
	menuw = (ShellWidget)XtCreatePopupShell("menuw", overrideShellWidgetClass,
			 labelw_good, NULL, 0);
	tet_infoline("PREP: Create a rowcolw_good widget");
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	tet_infoline("PREP: Create pushb_good button Hello in rowcolw_good widget");
	pushb_good = (Widget) CreatePushButtonGadget( "Hello", rowcolw_good);
	tet_infoline("PREP: Add callback procedure XtCallbackPopdown");
	pop_rec[0].shell_widget = (Widget)menuw;
	pop_rec[0].enable_widget = labelw_good;
	XtAddCallback(labelw_good,
			XtNdestroyCallback,
			XtCallbackPopdown,
			&pop_rec[0]
			);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Invoke callback function XtCallbackPopdown()");
	XtCallCallbacks(labelw_good, XtNdestroyCallback, (XtPointer)NULL);
	KROF(pid2);
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful invocation of
void XtCallbackPopdown(w, client_data, call_data)
shall call the callback procedures on the popdown_callback list of 
the widget specified by the shell_widget member of the structure 
pointed to by client_data, passing to them a pointer to the value 
of the widget's grab_kind field as the call_data argument.
>>CODE
Widget labelw_good;
Widget pushb_good, rowcolw_good;
XtPopdownIDRec pop_rec[1];
Boolean initial, final;
int status;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tcalbkpdn1", "XtCallbackPopdown");
	tet_infoline("PREP: Create labelw_good widget");
	labelw_good = (Widget) CreateLabelWidget("ApTest", boxw1);
	tet_infoline("PREP: Create a popup shell");
	menuw = (ShellWidget)XtCreatePopupShell("menuw",
			 overrideShellWidgetClass,
			 labelw_good, NULL, 0);
	tet_infoline("PREP: Create a rowcolw_good widget");
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	tet_infoline("PREP: Create pushb_good button in rowcolw_good widget");
	pushb_good = (Widget) CreatePushButtonGadget(
				"Hello",
				rowcolw_good);
	tet_infoline("PREP: Add callback procedure XtCallbackPopdown");
	pop_rec[0].shell_widget = (Widget)menuw;
	pop_rec[0].enable_widget = labelw_good;
	XtAddCallback(labelw_good, XtNdestroyCallback, XtCallbackPopdown, &pop_rec[0]);
	tet_infoline("PREP: Add callbacks to shell for popdown");
	XtAddCallback((Widget)menuw, XtNpopdownCallback, XtCB4_Proc, NULL);
	XtAddCallback((Widget)menuw, XtNpopdownCallback, XtCB5_Proc, NULL);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Map a Pop-up shell");
	XtPopup((Widget)menuw, XtGrabExclusive);
	tet_infoline("PREP: Invoke callback function XtCallbackPopdown()");
	XtCallCallbacks(labelw_good, XtNdestroyCallback, (XtPointer)NULL);
	tet_infoline("PREP: Register timeout");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTI2_Proc, topLevel);
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	tet_infoline("TEST: Callbacks were called");
	status = avs_get_event(1);
	check_dec(1, status, "callback 1 invocation count");
	status = avs_get_event(2);
	check_dec(1, status, "callback 2 invocation count");
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful invocation of
void XtCallbackPopdown(w, client_data, call_data)
shall set the popped_up field in the widget instance structure of the widget 
specified by the shell_widget member of the structure pointed to by 
client_data to False.
>>CODE
Widget labelw_good;
Widget pushb_good, rowcolw_good;
XtPopdownIDRec pop_rec[1];
Boolean initial, final;
int status;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tcalbkpdn1", "XtCallbackPopdown");
	tet_infoline("PREP: Create labelw_good widget");
	labelw_good = (Widget) CreateLabelWidget("ApTest", boxw1);
	tet_infoline("PREP: Create a popup shell");
	menuw = (ShellWidget)XtCreatePopupShell("menuw",
			 overrideShellWidgetClass,
			 labelw_good, NULL, 0);
	tet_infoline("PREP: Create a rowcolw_good widget");
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	tet_infoline("PREP: Create pushb_good button in rowcolw_good widget");
	pushb_good = (Widget) CreatePushButtonGadget(
				"Hello",
				rowcolw_good);
	tet_infoline("PREP: Add callback procedure XtCallbackPopdown");
	pop_rec[0].shell_widget = (Widget)menuw;
	pop_rec[0].enable_widget = labelw_good;
	XtAddCallback(labelw_good, XtNdestroyCallback, XtCallbackPopdown, &pop_rec[0]);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Map a Pop-up shell");
	XtPopup((Widget)menuw, XtGrabNone);
	tet_infoline("PREP: Invoke callback function XtCallbackPopdown()");
	XtCallCallbacks(labelw_good, XtNdestroyCallback, (XtPointer)NULL);
	tet_infoline("PREP: Register timeout");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTI1_Proc, topLevel);
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful invocation of
void XtCallbackPopdown(w, client_data, call_data)
when the grab_kind field in the widget instance structure of the widget 
specified by the shell_widget member of the structure pointed to by 
client_data is XtGrabNonexclusive shall remove widgets from the modal 
cascade starting at the most recent widget up to and including the 
widget specified by shell_widget.
>>CODE
pid_t pid2;
Display *display;
XtPopdownIDRec pop_rec[1];

	FORK(pid2);
	test_for = 1;
	avs_xt_hier("Tcalbkpdn1", "XtCallbackPopdown");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Create a popup shell");
	labelw_good = (Widget) CreateLabelWidget("ApTest", boxw1);
	menuw = (ShellWidget)XtVaCreatePopupShell("menuw", overrideShellWidgetClass, labelw_good, NULL);
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	pushb_good = (Widget) CreatePushButtonGadget( "Hello", rowcolw_good);
	tet_infoline("PREP: Create another popup shell");
	menuw2 = (ShellWidget)XtVaCreatePopupShell("menuw2", overrideShellWidgetClass, labelw_good, NULL);
	rowcolw_good2 = (Widget) CreateRowColWidget((Widget)menuw2);
	pushb_good2 = (Widget) CreatePushButtonGadget( "Hi there", rowcolw_good2); tet_infoline("PREP: Create yet another popup shell");
	menuw3 = (ShellWidget)XtVaCreatePopupShell("menuw3", overrideShellWidgetClass, labelw_good, NULL);
	rowcolw_good3 = (Widget) CreateRowColWidget((Widget)menuw3);
	pushb_good3 = (Widget) CreatePushButtonGadget( "Hi there", rowcolw_good3);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTI2d, NULL);
	tet_infoline("PREP: Create event handler for popups' parent");
	XtAddEventHandler(labelw_good, KeyPressMask, False, XTEV2a, NULL);
	tet_infoline("PREP: Create event handler for popup1");
	XtAddEventHandler((Widget)menuw, KeyPressMask, False, XtEV2b, NULL);
	tet_infoline("PREP: Create event handler for popup2");
	XtAddEventHandler((Widget)menuw2, KeyPressMask, False, XtEV2c, NULL);
	tet_infoline("PREP: Create event handler for popup3");
	XtAddEventHandler((Widget)menuw3, KeyPressMask, False, XtEV2d, NULL);
	tet_infoline("PREP: Add callback procedure XtCallbackPopdown");
	pop_rec[0].shell_widget = (Widget)menuw2;
	pop_rec[0].enable_widget = labelw_good;
	XtAddCallback(labelw_good, XtNdestroyCallback, XtCallbackPopdown, &pop_rec[0]);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Make popup1 exclusive");
	XtPopup((Widget)menuw, XtGrabExclusive);
	tet_infoline("PREP: Make popup2 nonexclusive");
	XtPopup((Widget)menuw2, XtGrabNonexclusive);
	tet_infoline("PREP: Make popup3 nonexclusive");
	XtPopup((Widget)menuw3, XtGrabNonexclusive);
	XtAppMainLoop(app_ctext);
	LKROF(pid2, 25);
	tet_infoline("TEST: Popups' parent did not receive KeyPress");
	status = avs_get_event(2);
	check_dec(0, status, "events received by popups' parent count");
	tet_infoline("TEST: Popup1 received KeyPress");
	status = avs_get_event(3);
	check_dec(1, status, "events received by popup1 count");
	tet_infoline("TEST: Popup2 did not receive KeyPress");
	status = avs_get_event(4);
	check_dec(0, status, "events received by popup2 count");
	tet_infoline("TEST: Popup3 did not receive KeyPress");
	status = avs_get_event(1);
	check_dec(0, status, "events received by popup3 count");
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful invocation of
void XtCallbackPopdown(w, client_data, call_data)
when the grab_kind field in the widget instance structure of the 
widget specified by the shell_widget member of the structure pointed 
to by client_data is XtGrabExclusive shall remove widgets from the 
modal cascade starting at the most recent widget up to and including 
the widget specified by shell_widget.
>>CODE
pid_t pid2;
Display *display;
XtPopdownIDRec pop_rec[1];

	FORK(pid2);
	test_for = 2;
	avs_xt_hier("Tcalbkpdn1", "XtCallbackPopdown");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Create a popup shell");
	labelw_good = (Widget) CreateLabelWidget("ApTest", boxw1);
	menuw = (ShellWidget)XtVaCreatePopupShell("menuw", overrideShellWidgetClass, labelw_good, NULL);
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	pushb_good = (Widget) CreatePushButtonGadget( "Hello", rowcolw_good);
	tet_infoline("PREP: Create another popup shell");
	menuw2 = (ShellWidget)XtVaCreatePopupShell("menuw2", overrideShellWidgetClass, labelw_good, NULL);
	rowcolw_good2 = (Widget) CreateRowColWidget((Widget)menuw2);
	pushb_good2 = (Widget) CreatePushButtonGadget( "Hi there", rowcolw_good2); tet_infoline("PREP: Create yet another popup shell");
	menuw3 = (ShellWidget)XtVaCreatePopupShell("menuw3", overrideShellWidgetClass, labelw_good, NULL);
	rowcolw_good3 = (Widget) CreateRowColWidget((Widget)menuw3);
	pushb_good3 = (Widget) CreatePushButtonGadget( "Hi there", rowcolw_good3);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTI2d, NULL);
	tet_infoline("PREP: Create event handler for popups' parent");
	XtAddEventHandler(labelw_good, KeyPressMask, False, XTEV2a, NULL);
	tet_infoline("PREP: Create event handler for popup1");
	XtAddEventHandler((Widget)menuw, KeyPressMask, False, XtEV2b, NULL);
	tet_infoline("PREP: Create event handler for popup2");
	XtAddEventHandler((Widget)menuw2, KeyPressMask, False, XtEV2c, NULL);
	tet_infoline("PREP: Create event handler for popup3");
	XtAddEventHandler((Widget)menuw3, KeyPressMask, False, XtEV2d, NULL);
	tet_infoline("PREP: Add callback procedure XtCallbackPopdown");
	pop_rec[0].shell_widget = (Widget)menuw2;
	pop_rec[0].enable_widget = labelw_good;
	XtAddCallback(labelw_good, XtNdestroyCallback, XtCallbackPopdown, &pop_rec[0]);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Make popup1 exclusive");
	XtPopup((Widget)menuw, XtGrabExclusive);
	tet_infoline("PREP: Make popup2 exclusive");
	XtPopup((Widget)menuw2, XtGrabExclusive);
	tet_infoline("PREP: Make popup3 nonexclusive");
	XtPopup((Widget)menuw3, XtGrabNonexclusive);
	XtAppMainLoop(app_ctext);
	LKROF(pid2, 25);
	tet_infoline("TEST: Popups' parent did not receive KeyPress");
	status = avs_get_event(2);
	check_dec(0, status, "events received by popups' parent count");
	tet_infoline("TEST: Popup1 received KeyPress");
	status = avs_get_event(3);
	check_dec(1, status, "events received by popup1 count");
	tet_infoline("TEST: Popup2 did not receive KeyPress");
	status = avs_get_event(4);
	check_dec(0, status, "events received by popup2 count");
	tet_infoline("TEST: Popup3 did not receive KeyPress");
	status = avs_get_event(1);
	check_dec(0, status, "events received by popup3 count");
	tet_result(TET_PASS);
