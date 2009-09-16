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
$Header: /cvs/xtest/xtest/xts5/tset/Xt9/XtSetSensitive/XtSetSensitive.m,v 1.1 2005-02-12 14:38:24 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt9/XtSetSensitive/XtSetSensitive.m
>># 
>># Description:
>>#	Tests for XtSetSensitive()
>># 
>># Modifications:
>># $Log: tstsenstv.m,v $
>># Revision 1.1  2005-02-12 14:38:24  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:37:10  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:00:04  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:28:16  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:50  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:18:40  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:12:01  andy
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

/*
** Registered procedure Proc
*/
void XtEVT_Proc(w, client_data, event, continue_to_dispatch)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_dispatch;
{
	sprintf(ebuf, "ERROR: Event %s invoked XtEVT_Proc", event_names[event->type]);
	tet_infoline(ebuf);
	tet_result(TET_FAIL);
	exit(0);
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
>>TITLE XtSetSensitive Xt9
void
XtSetSensitive(w, sensitive)
>>ASSERTION Good A
When sensitive is True a successful call to 
void XtSetSensitive(w, sensitive) 
shall set the sensitive field of the widget
.A w
to True.
>>CODE
Boolean status;
Widget rowcolw_good;
Widget labelw_good;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tstsenstv1", "XtSetSensitive");
	tet_infoline("PREP: Create rowcolw_good widget in boxw1 widget");
	rowcolw_good = (Widget) CreateRowColWidget(boxw1);
	tet_infoline("PREP: Create labelw_good widget in rowcolw_good widget");
	labelw_good = (Widget)CreateLabelWidget("Hello", rowcolw_good);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Set Sensitivity of labelw_good widget to True.");
	XtSetSensitive(labelw_good, True);
	tet_infoline("TEST: Labelw_good sensitivity is set to True");
	status = XtIsSensitive(labelw_good);
	check_dec(True, status, "XtIsSensitive");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When sensitive is True a successful call to 
void XtSetSensitive(w, sensitive) 
shall set the sensitive field of the widget
.A w
to False.
>>CODE
Boolean status;
Widget rowcolw_good;
Widget labelw_good;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tstsenstv2", "XtSetSensitive");
	tet_infoline("PREP: Create rowcolw_good widget in boxw1 widget");
	rowcolw_good = (Widget) CreateRowColWidget(boxw1);
	tet_infoline("PREP: Create labelw_good widget in rowcolw_good widget");
	labelw_good = (Widget)CreateLabelWidget("Hello", rowcolw_good);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Set Sensitivity of labelw_good widget to False.");
	XtSetSensitive(labelw_good, False);
	tet_infoline("TEST: Labelw_good sensitivity is set to False");
	status = XtIsSensitive(labelw_good);
	check_dec(False, status, "XtIsSensitive");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good B 0
A successful call to
void XtSetSensitive(w, sensitive) 
shall call the set_values procedures of the specified 
widget's class and its superclasses in superclass-to-subclass order.
>>ASSERTION Good B 0
A successful call to
void XtSetSensitive(w, sensitive) 
when the widget w has any non-NULL set_values_hook 
fields shall call the procedures specified by those 
fields immediately following the call to corresponding 
set_values procedure.
>>ASSERTION Good A
When sensitive is True, the class of the widget 
is a subclass of Composite, and the widget's 
ancestor_sensitive field is True a call to 
void XtSetSensitive(w, sensitive) 
shall set the ancestor_sensitive of each 
child widget to True and set the ancestor_sensitive 
field of each normal descendant that is now
sensitive to True.
>>CODE
Boolean status;
Widget rowcolw_good;
Widget labelw_good;
Boolean ancestor_sensitive;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tstsenstv3", "XtSetSensitive");
	tet_infoline("PREP: Create rowcolw_good widget in boxw1 widget");
	rowcolw_good = (Widget) CreateRowColWidget(boxw1);
	tet_infoline("PREP: Create labelw_good widget in rowcolw_good widget");
	labelw_good = (Widget)CreateLabelWidget("Hello", rowcolw_good);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Set ancestor_sensitive of labelw_good to False.");
	XtVaSetValues(rowcolw_good, XtNancestorSensitive, True, NULL);
				XtVaSetValues(rowcolw_good, XtNsensitive, False, NULL);
	XtVaSetValues(labelw_good, XtNancestorSensitive, False, NULL);
	tet_infoline("PREP: Set Sensitivity of parent rowcolw_good widget to True.");
	XtSetSensitive(rowcolw_good, True);
	tet_infoline("TEST: Rowcolw_good sensitivity is set to True");
	status = XtIsSensitive(rowcolw_good);
	check_dec(True, status, "XtIsSensitive");
	tet_infoline("TEST: Child widget labelw_good ancestor_sensitive is set to True");
	XtVaGetValues(labelw_good, XtNancestorSensitive, &ancestor_sensitive, NULL);
	if (ancestor_sensitive != True) {
		sprintf(ebuf, "ERROR: %s %s %d", "Expected child's ancestor_sensitivity to True(%d), Received", True, ancestor_sensitive);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When sensitive is False and the class of the widget 
is a subclass of Composite a call to 
void XtSetSensitive(w, sensitive) 
shall recursively traverse down the children tree 
and set 
.S ancestor_sensitive 
field of each widget to False.
>>CODE
Boolean status;
Widget rowcolw_good;
Widget labelw_good;
Boolean ancestor_sensitive;
int event_mask;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tstsenstv4", "XtSetSensitive");
	tet_infoline("PREP: Create rowcolw_good widget in boxw1 widget");
	rowcolw_good = (Widget) CreateRowColWidget(boxw1);
	tet_infoline("PREP: Create labelw_good widget in rowcolw_good widget");
	labelw_good = (Widget)CreateLabelWidget("Hello", rowcolw_good);
	tet_infoline("PREP: Register XtEVT_Proc to handle events to rowcolw_good");
	event_mask = ( KeyPressMask | KeyRelease | ButtonPressMask |
			ButtonReleaseMask);
	XtAddEventHandler(rowcolw_good,
		 event_mask,
		 False,
		 XtEVT_Proc,
		 (XtPointer)NULL
		 );
	tet_infoline("TEST: Ancestor_sensitive of labelw_good is True.");
	ancestor_sensitive = 0;
	XtVaGetValues(labelw_good, XtNancestorSensitive, &ancestor_sensitive, NULL);
	if (ancestor_sensitive != True) {
		sprintf(ebuf, "ERROR: Expected %s of %d, got %d", XtNancestorSensitive, True, ancestor_sensitive);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("PREP: Set Sensitivity of parent rowcolw_good widget to False.");
	XtSetSensitive(rowcolw_good, False);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Rowcolw_good sensitivity is set to False");
	status = XtIsSensitive(rowcolw_good);
	check_dec(False, status, "rowcolw_good sensitivity");
	tet_infoline("TEST: Labelw_good sensitivity is set to False");
	status = XtIsSensitive(labelw_good);
	check_dec(False, status, "labelw_good sensitivity");
	tet_infoline("TEST: Child widget labelw_good ancestor_sensitive is set to FDalse");
	XtVaGetValues(labelw_good, XtNancestorSensitive,
			&ancestor_sensitive, NULL);
	if (ancestor_sensitive != False) {
			sprintf(ebuf, "ERROR: Incorrect %s, wanted %d got %d", XtNancestorSensitive, False, ancestor_sensitive);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("PREP: Register timeout procedure");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTMO_Proc, topLevel);
	tet_infoline("TEST: Rowcolw_good widget does not respond to events");
	send_event(rowcolw_good, ButtonPress, ButtonPressMask, TRUE);
	send_event(rowcolw_good, ButtonRelease, ButtonReleaseMask,TRUE);
	send_event(rowcolw_good, KeyPress, KeyPressMask, TRUE);
	send_event(rowcolw_good, KeyRelease, KeyReleaseMask, TRUE);
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
