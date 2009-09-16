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
>># File: xts/Xt7/XtPopupSpringLoaded/XtPopupSpringLoaded.m
>># 
>># Description:
>>#	Tests for XtPopupSpringLoaded()
>># 
>># Modifications:
>># $Log: tpopupsld.m,v $
>># Revision 1.1  2005-02-12 14:38:20  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:36:48  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:59:40  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:27:55  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:29  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:17:23  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:21:33  andy
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

Widget labelw_good;
Widget pushb_good, rowcolw_good;
ShellWidget menuw, menuw2;
Widget pushb_good2, rowcolw_good2;

/*timeout callback*/
void XtTI1_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	tet_infoline("TEST: Shell is popped-up");
	if (menuw->shell.popped_up == False) {
		tet_infoline("ERROR: Shell is not popped up");
		tet_result(TET_FAIL);
	}
	exit(0);
}
/*timeout callback*/
void XtTI7_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	tet_infoline("TEST: Shell is popped-up");
	if (menuw->shell.popped_up == False) {
		tet_infoline("ERROR: Shell is not popped up");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Shell is spring-loaded");
	if (menuw->shell.spring_loaded != True) {
		tet_infoline("ERROR: Shell is not spring-loaded");
		tet_result(TET_FAIL);
	}
	exit(0);
}
void XtCB1_Proc(w, client_data, call_data)
Widget w;
XtPointer client_data;
XtPointer call_data;
{
	tet_infoline("TEST: Call_data points to grab_kind value");
	if (*(int *)call_data != XtGrabExclusive) {
		sprintf(ebuf, "ERROR: expected call_data to point to value of %d, points to %d", XtGrabExclusive, *(int *)call_data);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	avs_set_event(1,1);
}
void XtCB8_Proc(w, client_data, call_data)
Widget w;
XtPointer client_data;
XtPointer call_data;
{
	avs_set_event(2,1);
}

/*timeout callback*/
void XtTI2a_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	exit(0);
}
/*timeout callback*/
void XtTI2b_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	tet_infoline("TEST: Popup1 is popped-up");
	if (menuw->shell.popped_up == False) {
		tet_infoline("ERROR: Shell is not popped up");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Popup1 is nonexclusive");
	if (menuw->shell.grab_kind != XtGrabNonexclusive) {
		sprintf(ebuf, "ERROR: Expected XtGrabNonexclusive(%d), grab type = %d", XtGrabNonexclusive, menuw->shell.grab_kind);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Popup2 is popped-up");
	if (menuw2->shell.popped_up == False) {
		tet_infoline("ERROR: Shell is not popped up");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Popup2 is Exclusive");
	if (menuw2->shell.grab_kind != XtGrabExclusive) {
		sprintf(ebuf, "ERROR: Expected XtGrabExclusive(%d), grab type = %d", XtGrabExclusive, menuw2->shell.grab_kind);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Popup2 is spring-loaded");
	if (menuw2->shell.spring_loaded != True) {
		sprintf(ebuf, "ERROR: Shell is not spring-loaded");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("PREP: Send KeyPress event to popups' parent");
	send_event(labelw_good, KeyPress, KeyPressMask, TRUE);
	tet_infoline("PREP: Send KeyPress event to popup1");
	send_event((Widget)menuw, KeyPress, KeyPressMask, TRUE);
	tet_infoline("PREP: Send KeyPress event to popup2");
	send_event((Widget)menuw2, KeyPress, KeyPressMask, TRUE);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTI2a_Proc, NULL);
}
/*popup's parent's event handler*/
void XtEV2a_Proc(w, client_data, event, contin)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *contin;
{
	if (event->type == KeyPress) {
		avs_set_event(2,1);
	}
}
/*popup1's event handler*/
void XtEV2b_Proc(w, client_data, event, contin)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *contin;
{
	if (event->type == KeyPress) {
		avs_set_event(3,1);
	}
}
/*popup2's event handler*/
void XtEV2c_Proc(w, client_data, event, contin)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *contin;
{
	if (event->type == KeyPress) {
		avs_set_event(4,avs_get_event(4)+1);
	}
}
void XtCB2_Proc(w, client_data, call_data)
Widget w;
XtPointer client_data, call_data;
{
	avs_set_event(1,avs_get_event(1)+1);
}
/*
** Installed Warning handler
*/
void XtEVT3_handler(str1, str2, str3, str4, str5, car)
String str1, str2, str3, str4, *str5;
Cardinal *car;
{
	avs_set_event(1,avs_get_event(1)+1);
	exit(0);
}
void cpc_proc(w)
Widget w;
{
	avs_set_event(2, 1);
	tet_infoline("TEST: create_popup_child_proc argument");
	if (w != (Widget)menuw) {
		sprintf(ebuf, "ERROR: expected argument to point to popup, is %p", w);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtPopupSpringLoaded Xt7
void
XtPopupSpringLoaded(popup_shell)
>>ASSERTION Good A
A call to 
void XtPopupSpringLoaded(popup_shell)
shall map the window of the spring-loaded pop-up widget popup_shell.
>>CODE
int status = 0;
pid_t pid2;

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tpopupsld1", "XtPopupSpringLoaded");
	tet_infoline("PREP: Create labelw_good widget");
	labelw_good = (Widget) CreateLabelWidget("ApTest", boxw1);
	tet_infoline("PREP: Create a popup shell");
	menuw = (ShellWidget)XtVaCreatePopupShell("menuw", overrideShellWidgetClass, labelw_good, NULL);
	tet_infoline("PREP: Add callback to shell for popup");
	XtAddCallback((Widget)menuw, XtNpopupCallback, XtCB1_Proc, NULL);
	tet_infoline("PREP: Create a rowcolw_good widget");
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	tet_infoline("PREP: Create pushb_good button Hello in rowcolw_good widget");
	pushb_good = (Widget) CreatePushButtonGadget( "Hello", rowcolw_good);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTI1_Proc, NULL);
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Map a Pop-up shell spring loaded");
	XtPopupSpringLoaded((Widget)menuw);
	XtAppMainLoop(app_ctext);
	tet_infoline("TEST: Callback is called");
	KROF(pid2);
	status = avs_get_event(1);
	check_dec(1, status, "count of invokations of callback");
	tet_result(TET_PASS);
>>ASSERTION Good A
A call to 
void XtPopupSpringLoaded(popup_shell)
shall make the widget popup_shell modal and add it to the modal cascade if 
one exists or creates a modal cascade starting at popup_shell when no prior 
modal cascade exists.
>>CODE
pid_t pid2;
Display *display;
int status = 0;

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tpopupsld2", "XtPopupSpringLoaded");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Create a popup shell");
	labelw_good = (Widget) CreateLabelWidget("ApTest", boxw1);
	menuw = (ShellWidget)XtVaCreatePopupShell("menuw", overrideShellWidgetClass,
				labelw_good, NULL);
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	pushb_good = (Widget) CreatePushButtonGadget( "Hello", rowcolw_good);
	tet_infoline("PREP: Add callback to shell for popup");
	XtAddCallback((Widget)menuw, XtNpopupCallback, XtCB2_Proc, NULL);
	tet_infoline("PREP: Create another popup shell");
	menuw2 = (ShellWidget)XtVaCreatePopupShell("menuw2", overrideShellWidgetClass,
				labelw_good, NULL);
	rowcolw_good2 = (Widget) CreateRowColWidget((Widget)menuw2);
	pushb_good2 = (Widget) CreatePushButtonGadget( "ApTest", rowcolw_good2);
	tet_infoline("PREP: Add callback to shell for popup");
	XtAddCallback((Widget)menuw2, XtNpopupCallback, XtCB2_Proc, NULL);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTI2b_Proc, NULL);
	tet_infoline("PREP: Create event handler for popups' parent");
	XtAddEventHandler(labelw_good, KeyPressMask, False, &XtEV2a_Proc, NULL);
	tet_infoline("PREP: Create event handler for popup1");
	XtAddEventHandler((Widget)menuw, KeyPressMask, False, &XtEV2b_Proc, NULL);
	tet_infoline("PREP: Create event handler for popup2");
	XtAddEventHandler((Widget)menuw2, KeyPressMask, False, &XtEV2c_Proc, NULL);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Pop-up popup2 spring_loaded");
	XtPopupSpringLoaded((Widget)menuw2);
	tet_infoline("PREP: Pop-up popup1 with XtGrabNonexclusive");
	XtPopup((Widget)menuw, XtGrabNonexclusive);
	tet_infoline("TEST: Callbacks are called");
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	status = avs_get_event(1);
	check_dec(2, status, "callbacks were called");
	tet_infoline("TEST: Popups' parent did not receive KeyPress");
	status = avs_get_event(2);
	check_dec(0, status, "events received by popups' parent count");
	tet_infoline("TEST: Popup1 received its KeyPress");
	status = avs_get_event(3);
	check_dec(1, status, "events received by popup1 count");
	tet_infoline("TEST: Popup2 received all 3 KeyPresses");
	status = avs_get_event(4);
	check_dec(3, status, "events received by popup2");
	tet_result(TET_PASS);
>>ASSERTION Good A
When popup_shell's class is not a subclass of shellWidgetClass and the
calling program has been compiled with the compiler symbol DEBUG defined,
a call to 
void XtPopupSpringLoaded(popup_shell)
shall issue an error.
>>CODE
int status = 0;
pid_t pid2;

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tpopdown3", "XtPopdown");
	tet_infoline("PREP: Set up test XtToolkitError handler");
	XtAppSetErrorMsgHandler(app_ctext, XtEVT3_handler);
	tet_infoline("TEST: Pop-up non-shell");
	XtPopupSpringLoaded(boxw1);
	KROF(pid2);
	tet_infoline("TEST: Error message is generated");
	status = avs_get_event(1);
	check_dec(1, status, "error handler invokations count");
	tet_result(TET_PASS);
>>ASSERTION Good A
When the popped_up field of the widget popup_shell is already True, a call to
void XtPopupSpringLoaded(popup_shell)
shall raise the widget window and return without performing any other action.
>>CODE
int status = 0;
pid_t pid2;

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tpopupsld1", "XtPopupSpringLoaded");
	tet_infoline("PREP: Create labelw_good widget");
	labelw_good = (Widget) CreateLabelWidget("ApTest", boxw1);
	tet_infoline("PREP: Create a popup shell");
	menuw = (ShellWidget)XtVaCreatePopupShell("menuw", overrideShellWidgetClass, labelw_good, NULL);
	tet_infoline("PREP: Add callback to shell for popup");
	XtAddCallback((Widget)menuw, XtNpopupCallback, XtCB1_Proc, NULL);
	tet_infoline("PREP: Create a rowcolw_good widget");
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	tet_infoline("PREP: Create pushb_good button Hello in rowcolw_good widget");
	pushb_good = (Widget) CreatePushButtonGadget( "Hello", rowcolw_good);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTI1_Proc, NULL);
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Map a Pop-up shell spring loaded");
	XtPopupSpringLoaded((Widget)menuw);
	tet_infoline("TEST: Map the Pop-up shell again");
	XtPopupSpringLoaded((Widget)menuw);
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	tet_infoline("TEST: Callback is called");
	status = avs_get_event(1);
	check_dec(1, status, "count of invokations of callback");
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to 
void XtPopupSpringLoaded(popup_shell)
shall call the callback procedures on the popup_callback list of the widget
popup_shell.
>>CODE
int status = 0;
pid_t pid2;

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tpopupsld1", "XtPopupSpringLoaded");
	tet_infoline("PREP: Create labelw_good widget");
	labelw_good = (Widget) CreateLabelWidget("ApTest", boxw1);
	tet_infoline("PREP: Create a popup shell");
	menuw = (ShellWidget)XtVaCreatePopupShell("menuw", overrideShellWidgetClass, labelw_good, NULL);
	tet_infoline("PREP: Add callback to shell for popup");
	XtAddCallback((Widget)menuw, XtNpopupCallback, XtCB1_Proc, NULL);
	XtAddCallback((Widget)menuw, XtNpopupCallback, XtCB8_Proc, NULL);
	tet_infoline("PREP: Create a rowcolw_good widget");
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	tet_infoline("PREP: Create pushb_good button Hello in rowcolw_good widget");
	pushb_good = (Widget) CreatePushButtonGadget( "Hello", rowcolw_good);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTI1_Proc, NULL);
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Map a Pop-up shell spring loaded");
	XtPopupSpringLoaded((Widget)menuw);
	tet_infoline("TEST: Callback is called");
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	status = avs_get_event(1);
	check_dec(1, status, "count of invokations of first callback");
	status = avs_get_event(2);
	check_dec(1, status, "count of invokations of sceond callback");
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to 
void XtPopupSpringLoaded(popup_shell)
shall set the popped_up field in the widget instance structure of 
popup_shell to True.
>>CODE
int status = 0;
pid_t pid2;

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tpopupsld1", "XtPopupSpringLoaded");
	tet_infoline("PREP: Create labelw_good widget");
	labelw_good = (Widget) CreateLabelWidget("ApTest", boxw1);
	tet_infoline("PREP: Create a popup shell");
	menuw = (ShellWidget)XtVaCreatePopupShell("menuw", overrideShellWidgetClass, labelw_good, NULL);
	tet_infoline("PREP: Add callback to shell for popup");
	XtAddCallback((Widget)menuw, XtNpopupCallback, XtCB1_Proc, NULL);
	tet_infoline("PREP: Create a rowcolw_good widget");
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	tet_infoline("PREP: Create pushb_good button Hello in rowcolw_good widget");
	pushb_good = (Widget) CreatePushButtonGadget( "Hello", rowcolw_good);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTI1_Proc, NULL);
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Map a Pop-up shell spring loaded");
	XtPopupSpringLoaded((Widget)menuw);
	tet_infoline("TEST: Callback is called");
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	status = avs_get_event(1);
	check_dec(1, status, "count of invokations of callback");
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to 
void XtPopupSpringLoaded(popup_shell)
shall set the spring_loaded field in the widget instance structure 
of popup_shell to True.
>>CODE
int status = 0;
pid_t pid2;

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tpopupsld1", "XtPopupSpringLoaded");
	tet_infoline("PREP: Create labelw_good widget");
	labelw_good = (Widget) CreateLabelWidget("ApTest", boxw1);
	tet_infoline("PREP: Create a popup shell");
	menuw = (ShellWidget)XtVaCreatePopupShell("menuw", overrideShellWidgetClass, labelw_good, NULL);
	tet_infoline("PREP: Add callback to shell for popup");
	XtAddCallback((Widget)menuw, XtNpopupCallback, XtCB1_Proc, NULL);
	tet_infoline("PREP: Create a rowcolw_good widget");
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	tet_infoline("PREP: Create pushb_good button Hello in rowcolw_good widget");
	pushb_good = (Widget) CreatePushButtonGadget( "Hello", rowcolw_good);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTI7_Proc, NULL);
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Map a Pop-up shell spring loaded");
	XtPopupSpringLoaded((Widget)menuw);
	tet_infoline("TEST: Callback is called");
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	status = avs_get_event(1);
	check_dec(1, status, "count of invokations of callback");
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to 
void XtPopupSpringLoaded(popup_shell)
shall set the grab_kind field in the widget instance structure of 
popup_shell to XtGrabExclusive.
>>CODE
int status = 0;
pid_t pid2;

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tpopupsld1", "XtPopupSpringLoaded");
	tet_infoline("PREP: Create labelw_good widget");
	labelw_good = (Widget) CreateLabelWidget("ApTest", boxw1);
	tet_infoline("PREP: Create a popup shell");
	menuw = (ShellWidget)XtVaCreatePopupShell("menuw", overrideShellWidgetClass, labelw_good, NULL);
	tet_infoline("PREP: Add callback to shell for popup");
	XtAddCallback((Widget)menuw, XtNpopupCallback, XtCB1_Proc, NULL);
	tet_infoline("PREP: Create a rowcolw_good widget");
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	tet_infoline("PREP: Create pushb_good button Hello in rowcolw_good widget");
	pushb_good = (Widget) CreatePushButtonGadget( "Hello", rowcolw_good);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTI1_Proc, NULL);
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Map a Pop-up shell spring loaded");
	XtPopupSpringLoaded((Widget)menuw);
	tet_infoline("TEST: Callback is called");
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	status = avs_get_event(1);
	check_dec(1, status, "count of invokations of callback");
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to 
void XtPopupSpringLoaded(popup_shell)
when the create_popup_child_proc field in the widget instance 
structure of popup_shell is non-NULL shall call the procedure specified by that field, passing popup_shell as the argument.
>>CODE
int status = 0;
pid_t pid2;

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tpopupsld1", "XtPopupSpringLoaded");
	tet_infoline("PREP: Create labelw_good widget");
	labelw_good = (Widget) CreateLabelWidget("ApTest", boxw1);
	tet_infoline("PREP: Create a popup shell");
	menuw = (ShellWidget)XtVaCreatePopupShell("menuw", overrideShellWidgetClass, labelw_good, NULL);
	tet_infoline("PREP: Set create_popup_child_proc value");
	menuw->shell.create_popup_child_proc = cpc_proc;
	tet_infoline("PREP: Add callback to shell for popup");
	XtAddCallback((Widget)menuw, XtNpopupCallback, XtCB1_Proc, NULL);
	tet_infoline("PREP: Create a rowcolw_good widget");
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	tet_infoline("PREP: Create pushb_good button Hello in rowcolw_good widget");
	pushb_good = (Widget) CreatePushButtonGadget( "Hello", rowcolw_good);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTI1_Proc, NULL);
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Map a Pop-up shell spring loaded");
	XtPopupSpringLoaded((Widget)menuw);
	tet_infoline("TEST: Callback is called");
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	status = avs_get_event(1);
	check_dec(1, status, "count of invokations of callback");
	status = avs_get_event(2);
	check_dec(1, status, "count of invokations of create_popup_child_proc procedure");
	tet_result(TET_PASS);
