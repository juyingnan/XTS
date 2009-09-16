Copyright (c) 2005 X.Org Foundation L.L.C.

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

Copyright (c) 2004 The Open Group
Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: xts/Xt7/XtPopup/XtPopup.m
>># 
>># Description:
>>#	Tests for XtPopup()
>># 
>># Modifications:
>># $Log: tpopup.m,v $
>># Revision 1.2  2005-04-21 09:40:42  ajosey
>># resync to VSW5.1.5
>>#
>># Revision 8.2  2005/01/21 12:19:13  gwc
>># Updated copyright notice
>>#
>># Revision 8.1  2004/01/16 09:35:32  gwc
>># Changed (int *) cast to (XtGrabKind *) in XtCB1_Proc
>>#
>># Revision 8.0  1998/12/23 23:36:47  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:59:39  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:27:54  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:28  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:17:19  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:21:27  andy
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
Widget label2_good;
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
void XtTI7_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	tet_infoline("TEST: Shell is popped-up");
	if (menuw->shell.popped_up == False) {
		tet_infoline("ERROR: Shell is not popped up");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Shell is not spring loaded-up");
	if (menuw->shell.spring_loaded != False) {
		tet_infoline("ERROR: Shell is spring loaded");
		tet_result(TET_FAIL);
	}
	exit(0);
}
void XtTI8_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	tet_infoline("TEST: Shell is popped-up");
	if (menuw->shell.popped_up == False) {
		tet_infoline("ERROR: Shell is not popped up");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Grab kind set correctly");
	if (menuw->shell.grab_kind != XtGrabExclusive) {
		sprintf(ebuf, "ERROR: expected grab_lind to be XtGrabExclusive, is %d", menuw->shell.grab_kind);
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
	tet_infoline("TEST: Call_data points to grab_kind value");
	if (*(XtGrabKind *)call_data != XtGrabExclusive) {
		sprintf(ebuf, "ERROR: expected call_data to point to value of %d, points to %d", XtGrabExclusive, *(XtGrabKind *)call_data);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	avs_set_event(1,1);
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
	tet_infoline("TEST: Shell is popped-up");
	if (menuw->shell.popped_up == False) {
		tet_infoline("ERROR: Shell is not popped up");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: No Grab");
	if (menuw->shell.grab_kind != XtGrabNone) {
		sprintf(ebuf, "ERROR: Expected XtGrabNone(%d), grab type = %d", XtGrabNone, menuw->shell.grab_kind);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("PREP: Send KeyPress event to popup's parent");
	send_event(labelw_good, KeyPress, KeyPressMask, TRUE);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTI2a_Proc, NULL);
}
/*popup's parent's event handler*/
void XtEV2_Proc(w, client_data, event, contin)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *contin;
{
	if (event->type == KeyPress) {
		avs_set_event(2,1);
		exit(0);
	}
}
void XtCB2_Proc(w, client_data, call_data)
Widget w;
XtPointer client_data, call_data;
{
	avs_set_event(1,1);
}

/*timeout callback*/
void XtTI3a_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	exit(0);
}
/*timeout callback*/
void XtTI_3bProc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	tet_infoline("TEST: Shell is popped-up");
	if (menuw->shell.popped_up == False) {
		tet_infoline("ERROR: Shell is not popped up");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Grab is exclusive");
	if (menuw->shell.grab_kind != XtGrabExclusive) {
		sprintf(ebuf, "ERROR: Expected XtGrabExclusive(%d), grab type = %d", XtGrabExclusive, menuw->shell.grab_kind);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Shell is popped-up");
	if (menuw2->shell.popped_up == False) {
		tet_infoline("ERROR: Shell is not popped up");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Grab is non-exclusive");
	if (menuw2->shell.grab_kind != XtGrabNonexclusive) {
		sprintf(ebuf, "ERROR: Expected XtGrabNonexclusive(%d), grab type = %d", XtGrabNonexclusive, menuw2->shell.grab_kind);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("PREP: Send KeyPress event to popup");
	send_event((Widget)menuw, KeyPress, KeyPressMask, TRUE);
	tet_infoline("PREP: Send KeyPress event to popup's parent");
	send_event(labelw_good, KeyPress, KeyPressMask, TRUE);
	tet_infoline("PREP: Send KeyPress event to popup's child");
	send_event((Widget)menuw2, KeyPress, KeyPressMask, TRUE);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTI3a_Proc, NULL);
}
/*popup's parent's event handler*/
void XtEV3aProc(w, client_data, event, contin)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *contin;
{
	if (event->type == KeyPress) {
		avs_set_event(2,1);
	}
}
/*popup's event handler*/
void XTEV3bProc(w, client_data, event, contin)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *contin;
{
	if (event->type == KeyPress) {
		avs_set_event(3,1);
	}
}
/*popup's child's event handler*/
void XtEV3c_Proc(w, client_data, event, contin)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *contin;
{
	if (event->type == KeyPress) {
		avs_set_event(4,1);
		exit(0);
	}
}
void XtCB3_Proc(w, client_data, call_data)
Widget w;
XtPointer client_data, call_data;
{
	avs_set_event(1,avs_get_event(1)+1);
}
/*timeout callback*/
void XtTI4a_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	exit(0);
}
/*timeout callback*/
void XtTI4b_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	tet_infoline("TEST: Shell is popped-up");
	if (menuw->shell.popped_up == False) {
		tet_infoline("ERROR: Shell is not popped up");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Grab is nonexclusive");
	if (menuw->shell.grab_kind != XtGrabNonexclusive) {
		sprintf(ebuf, "ERROR: Expected XtGrabNonexclusive(%d), grab type = %d", XtGrabNonexclusive, menuw->shell.grab_kind);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Shell is popped-up");
	if (menuw2->shell.popped_up == False) {
		tet_infoline("ERROR: Shell is not popped up");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Grab is Exclusive");
	if (menuw2->shell.grab_kind != XtGrabExclusive) {
		sprintf(ebuf, "ERROR: Expected XtGrabExclusive(%d), grab type = %d", XtGrabExclusive, menuw2->shell.grab_kind);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("PREP: Send KeyPress event to popup");
	send_event((Widget)menuw, KeyPress, KeyPressMask, TRUE);
	tet_infoline("PREP: Send KeyPress event to popup's parent");
	send_event(labelw_good, KeyPress, KeyPressMask, TRUE);
	tet_infoline("PREP: Send KeyPress event to popup's child");
	send_event((Widget)menuw2, KeyPress, KeyPressMask, TRUE);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTI4a_Proc, NULL);
}
/*popup's parent's event handler*/
void XtEV4a_Proc(w, client_data, event, contin)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *contin;
{
	if (event->type == KeyPress) {
		avs_set_event(2,1);
	}
}
/*popup's event handler*/
void XtEV4b_Proc(w, client_data, event, contin)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *contin;
{
	if (event->type == KeyPress) {
		avs_set_event(3,1);
	}
}
/*popup's child's event handler*/
void XtEV4c_Proc(w, client_data, event, contin)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *contin;
{
	if (event->type == KeyPress) {
		avs_set_event(4,1);
		exit(0);
	}
}
void XtCB4_Proc(w, client_data, call_data)
Widget w;
XtPointer client_data, call_data;
{
	avs_set_event(1,avs_get_event(1)+1);
}

/*
** Installed Warning handler
*/
void XtEVT5_handler(str1, str2, str3, str4, str5, car)
String str1, str2, str3, str4, *str5;
Cardinal *car;
{
	avs_set_event(1,avs_get_event(1)+1);
	exit(0);
}
/*
** Installed Warning handler
*/
void XtEVT6_handler(str1, str2, str3, str4, str5, car)
String str1, str2, str3, str4, *str5;
Cardinal *car;
{
	avs_set_event(2,avs_get_event(2)+1);
	exit(0);
}
/*timeout callback*/
void XtTI6_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	exit(0);
}
void XtCB6_Proc(w, client_data, call_data)
Widget w;
XtPointer client_data;
XtPointer call_data;
{
	avs_set_event(1,avs_get_event(1)+1);
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
>>TITLE XtPopup Xt7
void
XtPopup(popup_shell, grab_kind)
>>ASSERTION Good A
A call to 
void XtPopup(popup_shell, grab_kind)
shall map the window of the pop-up shell widget popup_shell.
>>CODE
int status = 0;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tpopup1", "XtPopup");
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
	tet_infoline("TEST: Map a Pop-up shell");
	XtPopup((Widget)menuw, XtGrabExclusive);
	tet_infoline("TEST: Callback is called");
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	status = avs_get_event(1);
	check_dec(1, status, "count of invokations of callback");
	tet_result(TET_PASS);
>>ASSERTION Good A
A call to 
void XtPopup(popup_shell, grab_kind)
when grab_kind is XtGrabNone shall make the widget popup_shell a
modeless pop-up.
>>CODE
pid_t pid2;
Display *display;
int status = 0;

	FORK(pid2);
	avs_xt_hier("Tpopup2", "XtPopup");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Create a popup shell");
	labelw_good = (Widget) CreateLabelWidget("ApTest", boxw1);
	menuw = (ShellWidget)XtVaCreatePopupShell("menuw", overrideShellWidgetClass,
				labelw_good, NULL);
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	pushb_good = (Widget) CreatePushButtonGadget( "Hello", rowcolw_good);
	tet_infoline("PREP: Add callback to shell for popup");
	XtAddCallback((Widget)menuw, XtNpopupCallback, XtCB2_Proc, NULL);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTI2b_Proc, NULL);
	tet_infoline("PREP: Create event handler for popup's parent");
	XtAddEventHandler(labelw_good, KeyPressMask, False, &XtEV2_Proc, NULL);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Pop-up the shell");
	XtPopup((Widget)menuw, XtGrabNone);
	tet_infoline("TEST: Callback is called");
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	status = avs_get_event(1);
	check_dec(1, status, "callback was called");
	tet_infoline("TEST: Popup's parent received KeyPress");
	status = avs_get_event(2);
	check_dec(1, status, "events received by popup's parent count");
	tet_result(TET_PASS);
>>ASSERTION Good A
A call to 
void XtPopup(popup_shell, grab_kind)
when grab_kind is XtGrabNonexclusive shall cause all future user events that
occur outside the modal cascade, while the widget popup_shell is popped-up and 
is the most recent entry of the modal cascade, to be not delivered to any other 
widget of the calling process other than to its ancestors in the modal cascade, 
up to the last widget popped-up with XtGrabExclusive set to True.
>>CODE
pid_t pid2;
Display *display;
int status = 0;

	FORK(pid2);
	avs_xt_hier("Tpopup3", "XtPopup");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Create a popup shell");
	labelw_good = (Widget) CreateLabelWidget("ApTest", boxw1);
	menuw = (ShellWidget)XtVaCreatePopupShell("menuw", overrideShellWidgetClass,
				labelw_good, NULL);
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	pushb_good = (Widget) CreatePushButtonGadget( "Hello", rowcolw_good);
	tet_infoline("PREP: Add callback to shell for popup");
	XtAddCallback((Widget)menuw, XtNpopupCallback, XtCB3_Proc, NULL);
	tet_infoline("PREP: Create another popup shell, child of the first");
	menuw2 = (ShellWidget)XtVaCreatePopupShell("menuw2", overrideShellWidgetClass,
				(Widget)menuw, NULL);
	rowcolw_good2 = (Widget) CreateRowColWidget((Widget)menuw2);
	pushb_good2 = (Widget) CreatePushButtonGadget( "Hi there", rowcolw_good2);
	tet_infoline("PREP: Add callback to shell for popup");
	XtAddCallback((Widget)menuw2, XtNpopupCallback, XtCB3_Proc, NULL);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTI_3bProc, NULL);
	tet_infoline("PREP: Create event handler for popup");
	XtAddEventHandler(labelw_good, KeyPressMask, False, &XtEV3aProc, NULL);
	tet_infoline("PREP: Create event handler for popup's parent");
	XtAddEventHandler((Widget)menuw, KeyPressMask, False, &XTEV3bProc, NULL);
	tet_infoline("PREP: Create event handler for popup's child");
	XtAddEventHandler((Widget)menuw2, KeyPressMask, False, &XtEV3c_Proc, NULL);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Make the popup exclusive");
	XtPopup((Widget)menuw, XtGrabExclusive);
	tet_infoline("PREP: Make the popup's child non-exclusive");
	XtPopup((Widget)menuw2, XtGrabNonexclusive);
	tet_infoline("TEST: Callbacks are called");
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	status = avs_get_event(1);
	check_dec(2, status, "callbacks were called");
	tet_infoline("TEST: Popup's parent did not receive KeyPress");
	status = avs_get_event(2);
	check_dec(0, status, "events received by popup's parent count");
	tet_infoline("TEST: Popup received KeyPress");
	status = avs_get_event(3);
	check_dec(1, status, "events received by popup count");
	tet_infoline("TEST: Popup's child received KeyPress");
	status = avs_get_event(4);
	check_dec(1, status, "events received by popup's child count");
	tet_result(TET_PASS);
>>ASSERTION Good A
A call to 
void XtPopup(popup_shell, grab_kind)
when grab_kind is XtGrabExclusive shall cause all future user events that
occur outside the modal cascade, while the widget popup_shell is popped-up 
and is the most recent entry in the modal cascade, to be not delivered to 
any other widget of the calling process.
>>CODE
pid_t pid2;
Display *display;
int status = 0;

	FORK(pid2);
	avs_xt_hier("Tpopup4", "XtPopup");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Create a popup shell");
	labelw_good = (Widget) CreateLabelWidget("ApTest", boxw1);
	menuw = (ShellWidget)XtVaCreatePopupShell("menuw", overrideShellWidgetClass,
				labelw_good, NULL);
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	pushb_good = (Widget) CreatePushButtonGadget( "Hello", rowcolw_good);
	tet_infoline("PREP: Add callback to shell for popup");
	XtAddCallback((Widget)menuw, XtNpopupCallback, XtCB4_Proc, NULL);
	tet_infoline("PREP: Create another popup shell, child of the first");
	menuw2 = (ShellWidget)XtVaCreatePopupShell("menuw2", overrideShellWidgetClass,
				(Widget)menuw, NULL);
	rowcolw_good2 = (Widget) CreateRowColWidget((Widget)menuw2);
	pushb_good2 = (Widget) CreatePushButtonGadget( "Hi there", rowcolw_good2);
	tet_infoline("PREP: Add callback to shell for popup");
	XtAddCallback((Widget)menuw2, XtNpopupCallback, XtCB4_Proc, NULL);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTI4b_Proc, NULL);
	tet_infoline("PREP: Create event handler for popup's parent");
	XtAddEventHandler(labelw_good, KeyPressMask, False, &XtEV4a_Proc, NULL);
	tet_infoline("PREP: Create event handler for popup");
	XtAddEventHandler((Widget)menuw, KeyPressMask, False, &XtEV4b_Proc, NULL);
	tet_infoline("PREP: Create event handler for popup's child");
	XtAddEventHandler((Widget)menuw2, KeyPressMask, False, &XtEV4c_Proc, NULL);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Pop-up the popup with XtGrabNonexclusive");
	XtPopup((Widget)menuw, XtGrabNonexclusive);
	tet_infoline("PREP: Pop-up the child with XtGrabExclusive");
	XtPopup((Widget)menuw2, XtGrabExclusive);
	tet_infoline("TEST: Callbacks are called");
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	status = avs_get_event(1);
	check_dec(2, status, "callbacks were called");
	tet_infoline("TEST: Popup's parent did not receive KeyPress");
	status = avs_get_event(2);
	check_dec(0, status, "events received by popup's parent count");
	tet_infoline("TEST: Popup did not receive KeyPress");
	status = avs_get_event(3);
	check_dec(0, status, "events received by popup count");
	tet_infoline("TEST: Popup's child received KeyPress");
	status = avs_get_event(4);
	check_dec(1, status, "events received by popup's child count");
	tet_result(TET_PASS);
>>ASSERTION Good A
When popup_shell's class is not a subclass of shellWidgetClass and the
calling program has been compiled with the compiler symbol DEBUG defined,
a call to 
void XtPopup(popup_shell, grab_kind)
shall issue an error.
>>CODE
int status = 0;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tpopup5", "XtPopup");
	tet_infoline("PREP: Set up test XtToolkitError handler");
	XtAppSetErrorMsgHandler(app_ctext, XtEVT5_handler);
	tet_infoline("TEST: Map a pop-up that is not a shell");
	XtPopup(boxw1, XtGrabNone);
	KROF(pid2);
	tet_infoline("TEST: Error message is generated");
	status = avs_get_event(1);
	check_dec(1, status, "error handler called count");
	tet_result(TET_PASS);
>>ASSERTION Good A
When the popped_up field of the widget popup_shell is already True, a call to
void XtPopup(popup_shell, grab_kind) 
shall raise the widget window and return without performing any other action.
>>CODE
int status = 0;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tpopup6", "XtPopup");
	tet_infoline("PREP: Set up test XtToolkitError handler");
	XtAppSetErrorMsgHandler(app_ctext, XtEVT6_handler);
	labelw_good = (Widget) CreateLabelWidget("ApTest", boxw1);
	tet_infoline("PREP: Create a popup shell");
	menuw = (ShellWidget)XtVaCreatePopupShell("menuw", overrideShellWidgetClass, labelw_good, NULL);
	tet_infoline("PREP: Add callback to shell for popup");
	XtAddCallback((Widget)menuw, XtNpopupCallback, XtCB6_Proc, NULL);
	tet_infoline("PREP: Create a rowcolw_good widget");
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	tet_infoline("PREP: Create pushb_good button Hello in rowcolw_good widget");
	pushb_good = (Widget) CreatePushButtonGadget( "Hello", rowcolw_good);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTI6_Proc, NULL);
	tet_infoline("PREP: Pop-up shell twice");
	XtPopup((Widget)menuw, XtGrabNone);
	XtPopup((Widget)menuw, XtGrabNone);
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Callback is called only once");
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	status = avs_get_event(1);
	check_dec(1, status, "count of invokations of callback");
	tet_infoline("TEST: Error message is not generated");
	status = avs_get_event(2);
	check_dec(0, status, "error handler called count");
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to 
void XtPopup(popup_shell, grab_kind)
shall call the callback procedures on the popup_callback list of the widget
popup_shell passing to them a pointer to grab_kind as the call_data argument.
>>CODE
int status = 0;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tpopup1", "XtPopup");
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
	tet_infoline("TEST: Map a Pop-up shell");
	XtPopup((Widget)menuw, XtGrabExclusive);
	tet_infoline("TEST: Callback is called");
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	status = avs_get_event(1);
	check_dec(1, status, "count of invokations of callback");
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to 
void XtPopup(popup_shell, grab_kind)
shall set the popped_up field in the widget instance structure of 
popup_shell to True.
>>CODE
int status = 0;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tpopup1", "XtPopup");
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
	tet_infoline("TEST: Map a Pop-up shell");
	XtPopup((Widget)menuw, XtGrabExclusive);
	tet_infoline("TEST: Callback is called");
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	status = avs_get_event(1);
	check_dec(1, status, "count of invokations of callback");
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to 
void XtPopup(popup_shell, grab_kind)
shall set the spring_loaded field in the widget instance structure 
of popup_shell to False.
>>CODE
int status = 0;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tpopup1", "XtPopup");
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
	tet_infoline("TEST: Map a Pop-up shell");
	XtPopup((Widget)menuw, XtGrabExclusive);
	tet_infoline("TEST: Callback is called");
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	status = avs_get_event(1);
	check_dec(1, status, "count of invokations of callback");
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to 
void XtPopup(popup_shell, grab_kind)
shall set the grab_kind field in the widget instance structure 
of popup_shell to grab_kind.
>>CODE
int status = 0;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tpopup1", "XtPopup");
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
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTI8_Proc, NULL);
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Map a Pop-up shell");
	XtPopup((Widget)menuw, XtGrabExclusive);
	tet_infoline("TEST: Callback is called");
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	status = avs_get_event(1);
	check_dec(1, status, "count of invokations of callback");
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to 
void XtPopup(popup_shell, grab_kind)
when the create_popup_child_proc field in the widget instance 
structure of popup_shell is non-NULL shall call the procedure specified by that field, passing popup_shell as the argument.
>>CODE
int status = 0;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tpopup1", "XtPopup");
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
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTI8_Proc, NULL);
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Set create_popup_child_proc value");
	menuw->shell.create_popup_child_proc = cpc_proc;
	tet_infoline("TEST: Map a Pop-up shell");
	XtPopup((Widget)menuw, XtGrabExclusive);
	tet_infoline("TEST: Callback is called");
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	tet_infoline("TEST: create_popup_child_proc was called");
	status = avs_get_event(1);
	check_dec(1, status, "count of invokations of callback");
	status = avs_get_event(2);
	check_dec(1, status, "count of invokations of create_popup_child_proc procedure");
	tet_result(TET_PASS);
