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
>># File: xts/Xt9/XtRemoveGrab.m
>># 
>># Description:
>>#	Tests for XtRemoveGrab()
>># 
>># Modifications:
>># $Log: trmgrab.m,v $
>># Revision 1.1  2005-02-12 14:38:24  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:37:00  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:59:53  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:28:06  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:41  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:18:08  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:11:20  andy
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

int status = 0;
Widget label2_good;
Widget labelw_good;
Widget pushb_good, rowcolw_good;
Widget pushb_good2, rowcolw_good2;
ShellWidget menuw, menuw2, menuw3;
Widget pushb_good3, rowcolw_good3;

/*timeout callback*/
void XtTI1d(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	exit(0);
}

/*timeout callback*/
void XtTI1c(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	tet_infoline("PREP: Send KeyPress event to popup1");
	send_event((Widget)menuw, KeyPress, KeyPressMask, TRUE);
	tet_infoline("PREP: Send KeyPress event to popups' parent");
	send_event(labelw_good, KeyPress, KeyPressMask, TRUE);
	tet_infoline("PREP: Send KeyPress event to popup2");
	send_event((Widget)menuw2, KeyPress, KeyPressMask, TRUE);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTI1d, NULL);
}


/*timeout callback*/
void XtTI1b(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	tet_infoline("TEST: Popups' parent did not receive KeyPress");
	status = avs_get_event(2);
	check_dec(0, status, "events received by popups' parent count");
	tet_infoline("TEST: Popup1 received KeyPress");
	status = avs_get_event(3);
	check_dec(1, status, "events received by popup1 count");
	tet_infoline("TEST: Popup2 received KeyPress");
	status = avs_get_event(4);
	check_dec(1, status, "events received by popup2 count");
	tet_infoline("PREP: Remove grab from popup2");
	XtRemoveGrab((Widget)menuw2);
	avs_set_event(2,0);
	avs_set_event(3,0);
	avs_set_event(4,0);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTI1c, NULL);
}

/*timeout callback*/
void XtTI1a(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	tet_infoline("PREP: Send KeyPress event to popup1");
	send_event((Widget)menuw, KeyPress, KeyPressMask, TRUE);
	tet_infoline("PREP: Send KeyPress event to popups' parent");
	send_event(labelw_good, KeyPress, KeyPressMask, TRUE);
	tet_infoline("PREP: Send KeyPress event to popup2");
	send_event((Widget)menuw2, KeyPress, KeyPressMask, TRUE);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTI1b, NULL);
}
/*popups' parent's event handler*/
void XtEV1a(w, client_data, event, contin)
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
void XtEV1b(w, client_data, event, contin)
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
void XtEV1c(w, client_data, event, contin)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *contin;
{
	if (event->type == KeyPress) {
		avs_set_event(4, avs_get_event(4)+1);
	}
}

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
	tet_infoline("TEST: Popup1 received KeyPress");
	status = avs_get_event(3);
	check_dec(1, status, "events received by popup1 count");
	tet_infoline("TEST: Popup2 received KeyPress");
	status = avs_get_event(4);
	check_dec(1, status, "events received by popup2 count");
	tet_infoline("TEST: Popup3 received KeyPress");
	status = avs_get_event(1);
	check_dec(1, status, "events received by popup3 count");
	tet_infoline("PREP: Remove grab from popup2");
	XtRemoveGrab((Widget)menuw2);
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
/*
** XtEMH_Proc
*/
void XtEMH_Proc(str1, str2, str3, str4, str5, car)
String str1, str2, str3, str4, *str5;
Cardinal *car;
{
	avs_set_event(1,1);
}

>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtRemoveGrab Xt9
void
XtRemoveGrab(w)
>>ASSERTION Good A
A call to 
void XtRemoveGrab(w) shall remove widgets from the modal cascade starting
at the most recent widget up to and including the specified widget.
members from the modal cascade.
>>CODE
pid_t pid2;
Display *display;

	FORK(pid2);
	avs_xt_hier("Trmgrab1", "XtRemoveGrab");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Create a popup shell");
	labelw_good = (Widget) CreateLabelWidget("ApTest", boxw1);
	menuw = (ShellWidget)XtVaCreatePopupShell("menuw", overrideShellWidgetClass,
				labelw_good, NULL);
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	pushb_good = (Widget) CreatePushButtonGadget( "Hello", rowcolw_good);
	tet_infoline("PREP: Create another popup shell");
	menuw2 = (ShellWidget)XtVaCreatePopupShell("menuw2", overrideShellWidgetClass,
				labelw_good, NULL);
	rowcolw_good2 = (Widget) CreateRowColWidget((Widget)menuw2);
	pushb_good2 = (Widget) CreatePushButtonGadget( "Hi there", rowcolw_good2);
	tet_infoline("PREP: Create yet another popup shell");
	menuw3 = (ShellWidget)XtVaCreatePopupShell("menuw3", overrideShellWidgetClass,
				labelw_good, NULL);
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
A call to 
void XtRemoveGrab(w) 
when the widget
.A w 
is not on the modal cascade shall issue a warning message.
>>CODE
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Trmgrab3", "XtRemoveGrab");
	tet_infoline("PREP: Create labelw_good widget Press Me");
	labelw_good = (Widget) CreateLabelWidget("Press Me", boxw1);
	tet_infoline("PREP: Create a popup shell");
	menuw = (ShellWidget)XtVaCreatePopupShell("menuw",
				overrideShellWidgetClass,
				labelw_good, NULL);
	tet_infoline("PREP: Create a rowcolw_good widget");
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	tet_infoline("PREP: Create pushb_good button Hello in rowcolw_good widget");
	pushb_good = (Widget) CreatePushButtonGadget(
				"Hello",
				rowcolw_good);
	tet_infoline("PREP: Register warning handler");
	XtAppSetWarningMsgHandler(app_ctext, XtEMH_Proc);
	tet_infoline("PREP: Map a Pop-up shell.");
	XtPopup((Widget)menuw, XtGrabNone);
	tet_infoline("PREP: Redirect user input to a modal widget.");
	XtAddGrab((Widget)menuw, True, True);
	tet_infoline("PREP: Remove the grab twice");
	XtRemoveGrab((Widget)menuw);
	XtRemoveGrab((Widget)menuw);
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Warning handler was invoked.");
	status = avs_get_event(1);
	check_dec(1, status, "warning handler invocation count");
	LKROF(pid2,25);
	tet_result(TET_PASS);
