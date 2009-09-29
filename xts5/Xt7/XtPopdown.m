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
>># File: xts/Xt7/XtPopdown.m
>># 
>># Description:
>>#	Tests for XtPopdown()
>># 
>># Modifications:
>># $Log: tpopdown.m,v $
>># Revision 1.1  2005-02-12 14:38:18  anderson
>># Initial revision
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
>># Revision 5.0  1998/01/26 03:24:29  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:17:21  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:21:30  andy
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

extern char *event_names[];

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
	tet_infoline("PREP: XtPopdown popup2");
	XtPopdown((Widget)menuw2);
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

/*timeout callback*/
void XtTI1_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	tet_infoline("TEST: Shell popped-up field is False");
	if (menuw->shell.popped_up == True) {
		tet_infoline("ERROR: Shell is popped up");
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
void XtEVT4_handler(str1, str2, str3, str4, str5, car)
String str1, str2, str3, str4, *str5;
Cardinal *car;
{
	avs_set_event(2,avs_get_event(2)+1);
	exit(0);
}
/*timeout callback*/
void XtTI4_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	exit(0);
}
void XtCB4_Proc(w, client_data, call_data)
Widget w;
XtPointer client_data;
XtPointer call_data;
{
	avs_set_event(1,avs_get_event(1)+1);
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtPopdown Xt7
void
XtPopdown(popup_shell)
>>ASSERTION Good A
A call to 
XtPopdown(popup_shell)
shall unmap the window of the pop-up shell widget popup_shell.
>>CODE
int status = 0;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tpopdown1", "XtPopdown");
	tet_infoline("PREP: Create labelw_good widget");
	labelw_good = (Widget) CreateLabelWidget("ApTest", boxw1);
	tet_infoline("PREP: Create a popup shell");
	menuw = (ShellWidget)XtVaCreatePopupShell("menuw", overrideShellWidgetClass, labelw_good, NULL);
	tet_infoline("PREP: Add callback to shell for popup and popdown");
	XtAddCallback((Widget)menuw, XtNpopupCallback, XtCB1_Proc, NULL);
	XtAddCallback((Widget)menuw, XtNpopdownCallback, XtCB1_Proc, NULL);
	tet_infoline("PREP: Create a rowcolw_good widget");
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	tet_infoline("PREP: Create pushb_good button Hello in rowcolw_good widget");
	pushb_good = (Widget) CreatePushButtonGadget( "Hello", rowcolw_good);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTI1_Proc, NULL);
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Map a Pop-up shell and pop it down");
	XtPopup((Widget)menuw, XtGrabExclusive);
	XtPopdown((Widget)menuw);
	tet_infoline("TEST: Popup and popdown callbacks");
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	status = avs_get_event(1);
	check_dec(2, status, "count of invokations of callback");
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to
void XtPopdown(popup_shell)
when override_redirect is False shall generate a synthetic UnmapNotify event.
>>CODE
int avs2;
int status = 0;
pid_t pid2;
Display *display;
XEvent loop_event;
XEvent return_event;
int i;

	FORK(pid2);
	avs_xt_hier("Tpopdown2", "XtPopdown");
	tet_infoline("PREP: Create labelw_good widget Press Me");
	labelw_good = (Widget) CreateLabelWidget("ApTest", boxw1);
	tet_infoline("PREP: Create a popdown shell");
	menuw = (ShellWidget)XtVaCreatePopupShell("menuw", overrideShellWidgetClass, labelw_good, NULL);
	menuw->shell.override_redirect=False;
	tet_infoline("PREP: Create a rowcolw_good widget");
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	tet_infoline("PREP: Create pushb_good button in rowcolw_good widget");
	pushb_good = (Widget) CreatePushButtonGadget( "Hello", rowcolw_good);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Popup the pop-up shell");
	XtPopup((Widget)menuw, XtGrabNone);
	send_event(rowcolw, KeyPress, KeyPressMask, TRUE);
	tet_infoline("TEST: Popdown the pop-up shell");
	XtPopdown((Widget)menuw);
	tet_infoline("TEST: UnmapNotify event generated");
	display = XtDisplay(topLevel);
	for (i = 1; i< 10; i++) {
	 	XtAppNextEvent(app_ctext, &loop_event);
	 	XSync(display, False);
		if (loop_event.type == UnmapNotify)  {
			if (loop_event.xunmap.window == XtWindow((Widget)menuw)) {
				avs_set_event(1,1);
				exit(0);
			}
		}
		i--; /*avoid statement not reached warnings*/
	 	XtDispatchEvent(&loop_event);
	} /* end for */
	KROF(pid2);
	status = avs_get_event(1);
	check_dec(1, status, "UnmapNotify count");
	tet_result(TET_PASS);
>>ASSERTION Good A
When popup_shell's class is not a subclass of shellWidgetClass and the
calling program has been compiled with the compiler symbol DEBUG defined,
a call to 
void XtPopdown(popup_shell)
shall issue an invalidClass error.
>>CODE
int status = 0;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tpopdown3", "XtPopdown");
	tet_infoline("PREP: Set up test XtToolkitError handler");
	XtAppSetErrorMsgHandler(app_ctext, XtEVT3_handler);
	tet_infoline("TEST: Pop-down non-shell");
	XtPopdown(boxw1);
	KROF(pid2);
	tet_infoline("TEST: Error message is generated");
	status = avs_get_event(1);
	check_dec(1, status, "error handler called count");
	tet_result(TET_PASS);
>>ASSERTION Good A
When the popped_up field of the widget popup_shell is not True, a call to
void XtPopdown(popup_shell)
shall return immediately.
>>CODE
int status = 0;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tpopup4", "XtPopup");
	tet_infoline("PREP: Set up test XtToolkitError handler");
	XtAppSetErrorMsgHandler(app_ctext, XtEVT4_handler);
	labelw_good = (Widget) CreateLabelWidget("ApTest", boxw1);
	tet_infoline("PREP: Create a popup shell");
	menuw = (ShellWidget)XtVaCreatePopupShell("menuw", overrideShellWidgetClass, labelw_good, NULL);
	tet_infoline("PREP: Add callback to shell for popdown");
	XtAddCallback((Widget)menuw, XtNpopdownCallback, XtCB4_Proc, NULL);
	tet_infoline("PREP: Create a rowcolw_good widget");
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	tet_infoline("PREP: Create push button in rowcolw_good widget");
	pushb_good = (Widget) CreatePushButtonGadget( "Hello", rowcolw_good);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTI4_Proc, NULL);
	tet_infoline("PREP: Pop-down shell");
	XtPopdown((Widget)menuw);
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Callback is not called");
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	status = avs_get_event(1);
	check_dec(0, status, "count of invokations of callback");
	tet_infoline("TEST: Error message is not generated");
	status = avs_get_event(2);
	check_dec(0, status, "error handler called count");
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to 
void XtPopdown(popup_shell)
shall call the callback procedures on the popdown_callback list of the widget
popup_shell passing to them a pointer to the value of the widget's grab_kind 
field as the call_data argument.
>>CODE
int status = 0;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tpopdown1", "XtPopdown");
	tet_infoline("PREP: Create labelw_good widget");
	labelw_good = (Widget) CreateLabelWidget("ApTest", boxw1);
	tet_infoline("PREP: Create a popup shell");
	menuw = (ShellWidget)XtVaCreatePopupShell("menuw", overrideShellWidgetClass, labelw_good, NULL);
	tet_infoline("PREP: Add callback to shell for popup and popdown");
	XtAddCallback((Widget)menuw, XtNpopupCallback, XtCB1_Proc, NULL);
	XtAddCallback((Widget)menuw, XtNpopdownCallback, XtCB1_Proc, NULL);
	tet_infoline("PREP: Create a rowcolw_good widget");
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	tet_infoline("PREP: Create pushb_good button Hello in rowcolw_good widget");
	pushb_good = (Widget) CreatePushButtonGadget( "Hello", rowcolw_good);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTI1_Proc, NULL);
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Map a Pop-up shell and pop it down");
	XtPopup((Widget)menuw, XtGrabExclusive);
	XtPopdown((Widget)menuw);
	tet_infoline("TEST: Popup and popdown callbacks");
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	status = avs_get_event(1);
	check_dec(2, status, "count of invokations of callback");
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to 
void XtPopdown(popup_shell)
shall set the popped_up field in the widget instance structure of popup_shell
to False.
>>CODE
int status = 0;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tpopdown1", "XtPopdown");
	tet_infoline("PREP: Create labelw_good widget");
	labelw_good = (Widget) CreateLabelWidget("ApTest", boxw1);
	tet_infoline("PREP: Create a popup shell");
	menuw = (ShellWidget)XtVaCreatePopupShell("menuw", overrideShellWidgetClass, labelw_good, NULL);
	tet_infoline("PREP: Add callback to shell for popup and popdown");
	XtAddCallback((Widget)menuw, XtNpopupCallback, XtCB1_Proc, NULL);
	XtAddCallback((Widget)menuw, XtNpopdownCallback, XtCB1_Proc, NULL);
	tet_infoline("PREP: Create a rowcolw_good widget");
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	tet_infoline("PREP: Create pushb_good button Hello in rowcolw_good widget");
	pushb_good = (Widget) CreatePushButtonGadget( "Hello", rowcolw_good);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTI1_Proc, NULL);
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Map a Pop-up shell and pop it down");
	XtPopup((Widget)menuw, XtGrabExclusive);
	XtPopdown((Widget)menuw);
	tet_infoline("TEST: Popup and popdown callbacks");
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	status = avs_get_event(1);
	check_dec(2, status, "count of invokations of callback");
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to 
void XtPopdown(popup_shell)
when the grab_kind field of the widget popup_shell is XtGrabNonexclusive shall 
remove widgets from the modal cascade starting at the most recent widget up to
and including the widget popup_shell.
>>CODE
pid_t pid2;
Display *display;

	FORK(pid2);
	test_for = 1;
	avs_xt_hier("Tpopdown1", "XtPopdown");
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
A successful call to 
void XtPopdown(popup_shell)
when the grab_kind field of the widget popup_shell is XtGrabExclusive shall 
remove widgets from the modal cascade starting at the most recent widget up to
and including the widget popup_shell.
>>CODE
pid_t pid2;
Display *display;

	FORK(pid2);
	test_for = 2;
	avs_xt_hier("Tpopdown1", "XtPopdown");
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
