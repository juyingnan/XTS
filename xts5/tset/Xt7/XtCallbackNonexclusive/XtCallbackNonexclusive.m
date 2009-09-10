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
$Header: /cvs/xtest/xtest/xts5/tset/Xt7/XtCallbackNonexclusive/XtCallbackNonexclusive.m,v 1.1 2005-02-12 14:38:14 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt7/XtCallbackNonexclusive/XtCallbackNonexclusive.m
>># 
>># Description:
>>#	Tests for XtCallbackNonexclusive()
>># 
>># Modifications:
>># $Log: tcalbknex.m,v $
>># Revision 1.1  2005-02-12 14:38:14  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:36:49  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:59:42  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:27:56  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:30  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:17:27  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:21:38  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>
#include <X11/ShellP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;
ShellWidget menuw;

void cpcp(w)
Widget w;
{
	avs_set_event(2,1);
}
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
	tet_infoline("TEST: spring_loaded is False");
	if (menuw->shell.spring_loaded != False) {
		tet_infoline("ERROR: spring_loaded is not False");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Grab is nonexclusive");
	if (menuw->shell.grab_kind != XtGrabNonexclusive) {
		sprintf(ebuf, "ERROR: Expected XtGrabNonexclusive(%d), grab type = %d", XtGrabNonexclusive, menuw->shell.grab_kind);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	exit(0);
}
void XtCB1_Proc(w, client_data, call_data)
Widget w;
XtPointer client_data;
XtPointer call_data;
{
	tet_infoline("TEST: Call_data points to XtGrabNonexclusive");
	if (*(int *)call_data != XtGrabNonexclusive) {
		sprintf(ebuf, "ERROR: expected call_data to point to value of %d, points to %d", XtGrabNonexclusive, *(int *)call_data);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	avs_set_event(1,1);
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtCallbackNonexclusive Xt7
void
XtCallbackNonexclusive(w, client_data, call_data)
>>ASSERTION Good A
A successful invocation of
void XtCallbackNonexclusive(w, client_data, call_data) 
shall map the window of the pop-up widget client_data.
>>CODE
Widget labelw_good;
Widget pushb_good, rowcolw_good;
pid_t pid2;
int status;

	FORK(pid2);
	avs_xt_hier("Tcalbknex1", "XtCallbackNonexclusive");
	tet_infoline("PREP: Create labelw_good widget");
	labelw_good = (Widget) CreateLabelWidget("Hello", boxw1);
	tet_infoline("PREP: Create a popup shell");
	menuw = (ShellWidget)XtCreatePopupShell("menuw", overrideShellWidgetClass, labelw_good, NULL, 0);
	tet_infoline("PREP: Create a rowcolw_good widget");
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	tet_infoline("PREP: Create pushb_good button in rowcolw_good widget");
	pushb_good = (Widget) CreatePushButtonGadget( "ApTest", rowcolw_good);
	tet_infoline("PREP: Register callback function XtCallbackNonexclusive");
	XtAddCallback(labelw_good, XtNdestroyCallback, XtCallbackNonexclusive, menuw);
	tet_infoline("PREP: Register timeout");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTI1_Proc, topLevel);
	tet_infoline("PREP: Invoke callback function XtCallbackNonexclusive()");
	XtCallCallbacks(labelw_good, XtNdestroyCallback, (XtPointer)NULL);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful invocation of
void XtCallbackNonexclusive(w, client_data, call_data)
shall make the widget w insensitive.
>>CODE
Widget labelw_good;
Widget pushb_good, rowcolw_good;
XtCallbackStatus status;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tcalbknex2", "XtCallbackNonexclusive");
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
	tet_infoline("PREP: Register XtCallbackNonexclusive");
	XtAddCallback(labelw_good,
			XtNdestroyCallback,
			XtCallbackNonexclusive,
			menuw
			);
	tet_infoline("PREP: Invoke XtCallbackNonexclusive()");
	XtCallCallbacks(labelw_good, XtNdestroyCallback, (XtPointer) NULL );
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Labelw_good widget is insensitive");
	status = XtIsSensitive(labelw_good);
	check_dec(False, status, "XtIsSensitive return value");
	KROF(pid2);
	tet_result(TET_PASS);
>>ASSERTION def
A successful invocation of
void XtCallbackNonexclusive(w, client_data, call_data)
shall make the widget client_data modal and add it to the modal cascade if 
one exists or create a modal cascade starting at client_data when no prior 
modal cascade exists.
>>ASSERTION Good A
A successful invocation of
void XtCallbackNonexclusive(w, client_data, call_data)
shall call the callback procedures on the popup_callback list of the widget
client_data passing to them a pointer to XtGrabNonexclusive as the call_data 
argument.
>>CODE
Widget labelw_good;
Widget pushb_good, rowcolw_good;
pid_t pid2;
int status;

	FORK(pid2);
	avs_xt_hier("Tcalbknex1", "XtCallbackNonexclusive");
	tet_infoline("PREP: Create labelw_good widget");
	labelw_good = (Widget) CreateLabelWidget("Hello", boxw1);
	tet_infoline("PREP: Create a popup shell");
	menuw = (ShellWidget)XtCreatePopupShell("menuw", overrideShellWidgetClass, labelw_good, NULL, 0);
	tet_infoline("PREP: Create a rowcolw_good widget");
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	tet_infoline("PREP: Create pushb_good button in rowcolw_good widget");
	pushb_good = (Widget) CreatePushButtonGadget( "ApTest", rowcolw_good);
	tet_infoline("PREP: Register callback function XtCallbackNonexclusive");
	XtAddCallback(labelw_good, XtNdestroyCallback, XtCallbackNonexclusive, menuw);
	tet_infoline("PREP: Register timeout");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTI1_Proc, topLevel);
	tet_infoline("PREP: Add callback to shell for popup");
	XtAddCallback((Widget)menuw, XtNpopupCallback, XtCB1_Proc, NULL);
	tet_infoline("PREP: Invoke callback function XtCallbackNonexclusive()");
	XtCallCallbacks(labelw_good, XtNdestroyCallback, (XtPointer)NULL);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	tet_infoline("TEST: Callback is called");
	status = avs_get_event(1);
	check_dec(1, status, "count of invokations of callback");
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful invocation of
void XtCallbackNonexclusive(w, client_data, call_data)
shall set the popped_up field in the widget instance structure of client_data
to True.
>>CODE
Widget labelw_good;
Widget pushb_good, rowcolw_good;
pid_t pid2;
int status;

	FORK(pid2);
	avs_xt_hier("Tcalbknex1", "XtCallbackNonexclusive");
	tet_infoline("PREP: Create labelw_good widget");
	labelw_good = (Widget) CreateLabelWidget("Hello", boxw1);
	tet_infoline("PREP: Create a popup shell");
	menuw = (ShellWidget)XtCreatePopupShell("menuw", overrideShellWidgetClass, labelw_good, NULL, 0);
	tet_infoline("PREP: Create a rowcolw_good widget");
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	tet_infoline("PREP: Create pushb_good button in rowcolw_good widget");
	pushb_good = (Widget) CreatePushButtonGadget( "ApTest", rowcolw_good);
	tet_infoline("PREP: Register callback function XtCallbackNonexclusive");
	XtAddCallback(labelw_good, XtNdestroyCallback, XtCallbackNonexclusive, menuw);
	tet_infoline("PREP: Register timeout");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTI1_Proc, topLevel);
	tet_infoline("PREP: Invoke callback function XtCallbackNonexclusive()");
	XtCallCallbacks(labelw_good, XtNdestroyCallback, (XtPointer)NULL);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful invocation of
void XtCallbackNonexclusive(w, client_data, call_data)
shall set the spring_loaded field in the widget instance structure of 
client_data to False.
>>CODE
Widget labelw_good;
Widget pushb_good, rowcolw_good;
pid_t pid2;
int status;

	FORK(pid2);
	avs_xt_hier("Tcalbknex1", "XtCallbackNonexclusive");
	tet_infoline("PREP: Create labelw_good widget");
	labelw_good = (Widget) CreateLabelWidget("Hello", boxw1);
	tet_infoline("PREP: Create a popup shell");
	menuw = (ShellWidget)XtCreatePopupShell("menuw", overrideShellWidgetClass, labelw_good, NULL, 0);
	tet_infoline("PREP: Create a rowcolw_good widget");
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	tet_infoline("PREP: Create pushb_good button in rowcolw_good widget");
	pushb_good = (Widget) CreatePushButtonGadget( "ApTest", rowcolw_good);
	tet_infoline("PREP: Register callback function XtCallbackNonexclusive");
	XtAddCallback(labelw_good, XtNdestroyCallback, XtCallbackNonexclusive, menuw);
	tet_infoline("PREP: Register timeout");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTI1_Proc, topLevel);
	tet_infoline("PREP: Invoke callback function XtCallbackNonexclusive()");
	XtCallCallbacks(labelw_good, XtNdestroyCallback, (XtPointer)NULL);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful invocation of
void XtCallbackNonexclusive(w, client_data, call_data)
shall set the grab_kind field in the widget instance structure of client_data
to XtGrabNonexclusive.
>>CODE
Widget labelw_good;
Widget pushb_good, rowcolw_good;
pid_t pid2;
int status;

	FORK(pid2);
	avs_xt_hier("Tcalbknex1", "XtCallbackNonexclusive");
	tet_infoline("PREP: Create labelw_good widget");
	labelw_good = (Widget) CreateLabelWidget("Hello", boxw1);
	tet_infoline("PREP: Create a popup shell");
	menuw = (ShellWidget)XtCreatePopupShell("menuw", overrideShellWidgetClass, labelw_good, NULL, 0);
	tet_infoline("PREP: Create a rowcolw_good widget");
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	tet_infoline("PREP: Create pushb_good button in rowcolw_good widget");
	pushb_good = (Widget) CreatePushButtonGadget( "ApTest", rowcolw_good);
	tet_infoline("PREP: Register callback function XtCallbackNonexclusive");
	XtAddCallback(labelw_good, XtNdestroyCallback, XtCallbackNonexclusive, menuw);
	tet_infoline("PREP: Register timeout");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTI1_Proc, topLevel);
	tet_infoline("PREP: Invoke callback function XtCallbackNonexclusive()");
	XtCallCallbacks(labelw_good, XtNdestroyCallback, (XtPointer)NULL);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful invocation of
void XtCallbackNonexclusive(w, client_data, call_data)
when the create_popup_child_proc field in the widget instance 
structure of client_data is non-NULL shall call the procedure specified by 
that field.
>>CODE
Widget labelw_good;
Widget pushb_good, rowcolw_good;
pid_t pid2;
int status;

	FORK(pid2);
	avs_xt_hier("Tcalbknex1", "XtCallbackNonexclusive");
	tet_infoline("PREP: Create labelw_good widget");
	labelw_good = (Widget) CreateLabelWidget("Hello", boxw1);
	tet_infoline("PREP: Create a popup shell");
	menuw = (ShellWidget)XtCreatePopupShell("menuw", overrideShellWidgetClass, labelw_good, NULL, 0);
	tet_infoline("PREP: Create a rowcolw_good widget");
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	tet_infoline("PREP: Create pushb_good button in rowcolw_good widget");
	pushb_good = (Widget) CreatePushButtonGadget( "ApTest", rowcolw_good);
	tet_infoline("PREP: Register callback function XtCallbackNonexclusive");
	XtAddCallback((Widget)menuw, XtNdestroyCallback, XtCallbackNonexclusive, menuw);
	tet_infoline("PREP: Register timeout");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTI1_Proc, topLevel);
	tet_infoline("PREP: Set create_popup_child_proc procedure");
	menuw->shell.create_popup_child_proc = cpcp;
	tet_infoline("PREP: Invoke callback function XtCallbackNonexclusive()");
	XtCallCallbacks((Widget)menuw, XtNdestroyCallback, (XtPointer)NULL);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	tet_infoline("TEST: Procedure is called");
	status = avs_get_event(2);
	check_dec(1, status, "count of invokations of procedure");
	tet_result(TET_PASS);
