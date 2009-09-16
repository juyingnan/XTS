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
>># File: tset/Xt9/XtIsSensitive/XtIsSensitive.m
>># 
>># Description:
>>#	Tests for XtIsSensitive()
>># 
>># Modifications:
>># $Log: tissenstv.m,v $
>># Revision 1.1  2005-02-12 14:38:24  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:37:09  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:00:03  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:28:15  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:50  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:18:38  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:11:59  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;

extern char *event_names[];

void XtEVT_AcceptInput(w, client_data, event, continue_to_dispatch)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_dispatch;
{
	avs_set_event(1, 1);
	exit(0);
}

void XtEVT_Proc(w, client_data, event, continue_to_dispatch)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_dispatch;
{
	sprintf(ebuf, "ERROR: Event %s invoked XtEVT_Proc", event_names[event->type]);
	tet_infoline(ebuf);
	tet_result(TET_FAIL);
}

/* procedure XtTMO_Proc to be invoked */
void XtTMO_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	exit(0);
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtIsSensitive Xt9
Boolean
XtIsSensitive(w)
>>ASSERTION Good A
A call to 
Boolean XtIsSensitive(w)
when the class of the widget 
.A w
is a subclass of
.S RectObject
and the sensitive and ancestor_sensitive fields of the widget are
True shall return True.
>>CODE
XtWidgetGeometry intended, geom;
Boolean sensitive;
Widget labelw_msg;
char *msg = "Test widget";
pid_t pid2;
int invoked;

	FORK(pid2);
	avs_xt_hier("Tissenstv1", "XtIsSensitive");
	tet_infoline("PREP: Create test label widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Register XtEVT_AcceptInput to handle events for");
	tet_infoline("PREP: labelw_msg widget");
	XtAddEventHandler(labelw_msg,
		 ButtonPressMask,
		 False,
		 XtEVT_AcceptInput,
		 (XtPointer)NULL
		 );
	tet_infoline("PREP: Set the sensitivity of test widget and its ancestor to True");
	XtSetSensitive(labelw_msg,True);
	XtSetSensitive(boxw1,True);
	tet_infoline("TEST: Labelw_msg widget is sensitive");
	sensitive = XtIsSensitive(labelw_msg);
	check_dec(True, sensitive, "XtIsSensitive");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Send ButtonPress over wire");
	send_event(labelw_msg, ButtonPress, ButtonPressMask, FALSE);
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: XtEVT_AcceptInput was invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtEVT_AcceptInput invoked count");
	tet_result(TET_PASS);
>>ASSERTION Good A
A call to 
Boolean XtIsSensitive(w)
when the class of the widget 
.A w
is not a subclass of
.S RectObject,
shall return 
.S False.
>>CODE
XtWidgetGeometry intended, geom;
Boolean sensitive;
Widget labelw_msg;
char *msg = "Test widget";
pid_t pid2;
int invoked;

	FORK(pid2);
	avs_xt_hier("Tissenstv2", "XtIsSensitive");
	tet_infoline("PREP: Create test label widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Register procedure XtEVT_Proc to handle events for");
	tet_infoline("PREP: labelw_msg widget");
	XtAddEventHandler(labelw_msg,
		 ButtonPressMask,
		 False,
		 XtEVT_Proc,
		 (Widget)NULL
		 );
	tet_infoline("PREP: Set the sensitivity of test widget to False");
	XtSetSensitive(labelw_msg, False);
	tet_infoline("TEST: labelw_msg widget is not sensitve");
	sensitive = XtIsSensitive(labelw_msg);
	check_dec(False, sensitive, "XtIsSensitive");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Simulate ButtonPress on widget labelw_msg");
	send_event(labelw_msg, ButtonPress, ButtonPressMask, FALSE);
	tet_infoline("PREP: Register timeout procedure");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTMO_Proc, topLevel);
	tet_infoline("TEST: Procedure XtEVT_Proc was not invoked");
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
A call to 
Boolean XtIsSensitive(w)
when the sensitive field of the widget 
.A w
is not
.S True
shall return False.
>>CODE
XtWidgetGeometry intended, geom;
Boolean sensitive;
Widget labelw_msg;
char *msg = "Test widget";
int invoked;

	avs_xt_hier("Tissenstv1", "XtIsSensitive");
	tet_infoline("PREP: Create test label widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Set the sensitivity of test widget to False");
	XtSetSensitive(labelw_msg,False);
	tet_infoline("TEST: labelw_msg widget is not sensitive");
	sensitive = XtIsSensitive(labelw_msg);
	check_dec(False, sensitive, "XtIsSensitive");
	tet_result(TET_PASS);
>>ASSERTION Good A
A call to 
Boolean XtIsSensitive(w)
when the ancestor_sensitive field of the widget 
.A w
is not
.S True
shall return 
.S False.
>>CODE
XtWidgetGeometry intended, geom;
Boolean sensitive;
Widget labelw_msg;
char *msg = "Test widget";
int invoked;

	avs_xt_hier("Tissenstv1", "XtIsSensitive");
	tet_infoline("PREP: Create test label widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Set the ancestor sensitivity of test widget to False");
	XtSetSensitive(boxw1,False);
	XtSetSensitive(labelw_msg,True);
	tet_infoline("TEST: labelw_msg widget is not sensitive");
	sensitive = XtIsSensitive(labelw_msg);
	check_dec(False, sensitive, "XtIsSensitive");
	tet_result(TET_PASS);
