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
>># File: xts/Xt13/XtGetSelectionValue/XtGetSelectionValue.m
>># 
>># Description:
>>#	Tests for XtGetSelectionValue()
>># 
>># Modifications:
>># $Log: tgtsvalue.m,v $
>># Revision 1.1  2005-02-12 14:37:58  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:38:12  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:12  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:29:14  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:25:48  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:21:42  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:17:45  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>
#include <X11/Xatom.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;

#define	SELECTION	XA_PRIMARY
#define	TYPE	XA_STRING
#define	MSG	 "Hello"
#define	FORMAT	8

/*
** local functions
*/
static Boolean convert_proc();
static void lose_proc();
static void done_proc();
static void requestor_callback();

/* procedure XtTMO_Proc to be invoked */
void XtTMO_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	exit(0);
}

static void XtEVT_handler1(sender_widget, client_data, event, continue_to_dispatch)
Widget sender_widget;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_dispatch;
{
Boolean status;
XButtonEvent *bevent;

	bevent = (XButtonEvent*)event;
	avs_set_event(1, 1); 
	status = XtOwnSelection(
		 sender_widget,
		 SELECTION,
		 bevent->time,
		 convert_proc,
		 NULL,
		 done_proc
		 );
	check_dec(True, status, "status");
}

static void XtEVT_handler2(receiver_widget, client_data, event, continue_to_dispatch)
Widget receiver_widget;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_dispatch;
{
XButtonEvent *bevent;

	bevent = (XButtonEvent*)event;
	avs_set_event(2, 1); 
	XtGetSelectionValue(
		receiver_widget,
		SELECTION,
		TYPE,
		requestor_callback, 
		client_data,
		bevent->time
		);
}

static Boolean convert_proc(w, selection, target, type_return, value_return,
		length_return, format_return)
Widget w;
Atom *selection;
Atom *target;
Atom *type_return;
XtPointer *value_return;
unsigned long *length_return;
int *format_return;
{
	
	char *data;
	avs_set_event(4,1);
	if ( *target == TYPE ) {
	*length_return = strlen(MSG) * sizeof(char) + 1;
	data = XtMalloc(*length_return);
	strcpy(data, MSG);
	*value_return = data;
	*type_return = TYPE;
	*format_return = FORMAT;
	return(True);
	} else
	return(False);
}

static void lose_proc(w, selection)
Widget w;
Atom *selection;
{
	sprintf(ebuf, "ERROR: labelw_good widget lost selection ownership");
	tet_infoline(ebuf);
	tet_result(TET_FAIL);
}

static void done_proc(w, selection, target)
Widget w;
Atom *selection;
Atom *target;
{
	XtDisownSelection(w, *selection, CurrentTime);
}

static void requestor_callback(w, client_data, selection, type, value,
		length, format)
Widget w;
XtPointer client_data;
Atom *selection;
Atom *type;
XtPointer value;
unsigned long *length;
int *format;
{
	avs_set_event(3,1);
	tet_infoline("TEST: Values sent to callback");
	check_dec(SELECTION, *selection, "*selection");
	check_dec(TYPE , *type, "*type");
	check_str(MSG, value, "*value");
	check_dec(strlen(MSG)+1, *length, "*length");
	check_dec(FORMAT, *format, "*format");
}

static void requestor_callback2(w, client_data, selection, type, value,
		length, format)
Widget w;
XtPointer client_data;
Atom *selection;
Atom *type;
XtPointer value;
unsigned long *length;
int *format;
{
	avs_set_event(3,1);
	tet_infoline("TEST: callback: value is NULL");
	if (value != NULL) {
		tet_infoline("ERROR: value is not NULL");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: callback: length is 0");
	check_dec(0, *length, "*length");
}

static void XtEVT2_handler2(receiver_widget, client_data, event, continue_to_dispatch)
Widget receiver_widget;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_dispatch;
{
XButtonEvent *bevent;

	bevent = (XButtonEvent*)event;
	avs_set_event(2, 1); 
	XtGetSelectionValue(
		receiver_widget,
		SELECTION,
		TYPE,
		requestor_callback2, 
		client_data,
		bevent->time
		);
}

static Boolean convert_proc3(w, selection, target, type_return, value_return,
		length_return, format_return)
Widget w;
Atom *selection;
Atom *target;
Atom *type_return;
XtPointer *value_return;
unsigned long *length_return;
int *format_return;
{
	
	return(False);
}
static void XtEVT3_handler1(sender_widget, client_data, event, continue_to_dispatch)
Widget sender_widget;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_dispatch;
{
Boolean status;
XButtonEvent *bevent;

	bevent = (XButtonEvent*)event;
	avs_set_event(1, 1); 
	status = XtOwnSelection(
		 sender_widget,
		 SELECTION,
		 bevent->time,
		 convert_proc3,
		 NULL,
		 done_proc
		 );
	check_dec(True, status, "status");
}

static void XtEVT3_handler2(receiver_widget, client_data, event, continue_to_dispatch)
Widget receiver_widget;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_dispatch;
{
XButtonEvent *bevent;

	bevent = (XButtonEvent*)event;
	avs_set_event(2, 1); 
	XtGetSelectionValue(
		receiver_widget,
		SELECTION,
		TYPE,
		requestor_callback2, 
		client_data,
		bevent->time
		);
}

>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtGetSelectionValue Xt13
void
XtGetSelectionValue(w, selection, target, callback, client_data, time)
>>ASSERTION Good A
A call to 
void XtGetSelectionValue(w, selection, target, callback, 
client_data, time)
shall cause the callback procedure 
.A callback
to be called with the value of the selection
.A selection
converted to the type
.A target,
the widget
.A w,
and 
.A client_data
passed as arguments.
>>CODE
Widget labelw_good;
pid_t pid2;
int invoked1, invoked2;
int invoked3;

	FORK(pid2);
	avs_xt_hier("Tgtsvalue1", "XtGetSelectionValue");
	tet_infoline("PREP: Create labelw_good widget Hello");
	labelw_good = (Widget) CreateLabelWidget("Hello", boxw1);
	tet_infoline("PREP: Register event handler XtEVT_handler1 to handle");
	tet_infoline("      ButtonPress events to labelw_good widget");
	XtAddEventHandler(labelw_good,
		 ButtonPressMask,
		 False,
		 XtEVT_handler1,
		 (Widget)NULL
		 );
	tet_infoline("PREP: Register event handler XtEVT_handler2 to handle");
	tet_infoline("      ButtonRelease events to boxw2 widget");
	XtAddEventHandler(boxw2,
		 ButtonReleaseMask,
		 False,
		 XtEVT_handler2,
		 (Widget)NULL
		 );
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send ButtonPress event");
	send_event(labelw_good, ButtonPress, ButtonPressMask, FALSE);
	tet_infoline("PREP: Send ButtonRelease event");
	send_event(boxw2, ButtonRelease, ButtonReleaseMask, FALSE);
	tet_infoline("PREP: Register timeout procedure");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTMO_Proc, topLevel);
	tet_infoline("TEST: XtEVT_handler1 and XtEVT_handler2 invoked");
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	invoked1 = avs_get_event(1);
	check_dec(1, invoked1, "XtEVT_handler1 invocations count");
	invoked2 = avs_get_event(2);
	check_dec(1, invoked2, "XtEVT_handler2 invocations count");
	tet_infoline("TEST: Requestor callback invoked");
	invoked3 = avs_get_event(3);
	check_dec(1, invoked3, "requestor callback invocations count");
	tet_result(TET_PASS);
>>ASSERTION Good A
A call to 
void XtGetSelectionValue(w, selection, target, callback, 
client_data, time)
when the value of the specified selection 
is not of type
.A target
shall cause the XtConvertSelectionProc procedure of the 
selection owner to be called to convert the selection value 
to the specified type.
>>CODE
Widget labelw_good;
pid_t pid2;
int invoked1, invoked2;
int invoked3;

	FORK(pid2);
	avs_xt_hier("Tgtsvalue1", "XtGetSelectionValue");
	tet_infoline("PREP: Create labelw_good widget Hello");
	labelw_good = (Widget) CreateLabelWidget("Hello", boxw1);
	tet_infoline("PREP: Register event handler XtEVT_handler1 to handle");
	tet_infoline("      ButtonPress events to labelw_good widget");
	XtAddEventHandler(labelw_good,
		 ButtonPressMask,
		 False,
		 XtEVT_handler1,
		 (Widget)NULL
		 );
	tet_infoline("PREP: Register event handler XtEVT_handler2 to handle");
	tet_infoline("      ButtonRelease events to boxw2 widget");
	XtAddEventHandler(boxw2,
		 ButtonReleaseMask,
		 False,
		 XtEVT_handler2,
		 (Widget)NULL
		 );
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send ButtonPress event");
	send_event(labelw_good, ButtonPress, ButtonPressMask, FALSE);
	tet_infoline("PREP: Send ButtonRelease event");
	send_event(boxw2, ButtonRelease, ButtonReleaseMask, FALSE);
	tet_infoline("PREP: Register timeout procedure");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTMO_Proc, topLevel);
	tet_infoline("TEST: XtEVT_handler1 and XtEVT_handler2 invoked");
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	invoked1 = avs_get_event(1);
	check_dec(1, invoked1, "XtEVT_handler1 invocations count");
	invoked2 = avs_get_event(2);
	check_dec(1, invoked2, "XtEVT_handler2 invocations count");
	tet_infoline("TEST: Requestor callback invoked");
	invoked3 = avs_get_event(3);
	check_dec(1, invoked3, "requestor callback invocations count");
	tet_infoline("TEST: conversion procedure invoked");
	invoked3 = avs_get_event(4);
	check_dec(1, invoked3, "conversion procedure invocations count");
	tet_result(TET_PASS);
>>ASSERTION Good A
When the selection
.A selection
has no owner a call to 
void XtGetSelectionValue(w, selection, target, callback, 
client_data, time)
shall cause the callback procedure to be called with
the value parameter set to NULL and length set to zero.
>>CODE
Widget labelw_good;
pid_t pid2;
int invoked1, invoked2;
int invoked3;

	FORK(pid2);
	avs_xt_hier("Tgtsvalue1", "XtGetSelectionValue");
	tet_infoline("PREP: Create labelw_good widget Hello");
	labelw_good = (Widget) CreateLabelWidget("Hello", boxw1);
	tet_infoline("PREP: Register event handler XtEVT2_handler2 to handle");
	tet_infoline("      ButtonRelease events to boxw2 widget");
	XtAddEventHandler(boxw2,
		 ButtonReleaseMask,
		 False,
		 XtEVT2_handler2,
		 (Widget)NULL
		 );
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send ButtonRelease event");
	send_event(boxw2, ButtonRelease, ButtonReleaseMask, FALSE);
	tet_infoline("PREP: Register timeout procedure");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTMO_Proc, topLevel);
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: XtEVT2_handler2 invoked");
	invoked2 = avs_get_event(2);
	check_dec(1, invoked2, "XtEVT2_handler2 invocations count");
	tet_infoline("TEST: Requestor callback invoked");
	invoked3 = avs_get_event(3);
	check_dec(1, invoked3, "requestor callback invocations count");
	tet_result(TET_PASS);
>>ASSERTION Good A
When the owner of the selection
.A selection
cannot convert the selection value to the type
.A target
a call to 
void XtGetSelectionValue(w, selection, target, callback, 
client_data, time)
shall cause the callback procedure to be called with
the value parameter set to NULL and length set to zero.
>>CODE
Widget labelw_good;
pid_t pid2;
int invoked1, invoked2;
int invoked3;

	FORK(pid2);
	avs_xt_hier("Tgtsvalue1", "XtGetSelectionValue");
	tet_infoline("PREP: Create labelw_good widget Hello");
	labelw_good = (Widget) CreateLabelWidget("Hello", boxw1);
	tet_infoline("PREP: Register event handler XtEVT3_handler1 to handle");
	tet_infoline("      ButtonPress events to labelw_good widget");
	XtAddEventHandler(labelw_good,
		 ButtonPressMask,
		 False,
		 XtEVT3_handler1,
		 (Widget)NULL
		 );
	tet_infoline("PREP: Register event handler XtEVT3_handler2 to handle");
	tet_infoline("      ButtonRelease events to boxw2 widget");
	XtAddEventHandler(boxw2,
		 ButtonReleaseMask,
		 False,
		 XtEVT3_handler2,
		 (Widget)NULL
		 );
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send ButtonPress event");
	send_event(labelw_good, ButtonPress, ButtonPressMask, FALSE);
	tet_infoline("PREP: Send ButtonRelease event");
	send_event(boxw2, ButtonRelease, ButtonReleaseMask, FALSE);
	tet_infoline("PREP: Register timeout procedure");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTMO_Proc, topLevel);
	tet_infoline("TEST: XtEVT_handler1 and XtEVT_handler2 invoked");
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	invoked1 = avs_get_event(1);
	check_dec(1, invoked1, "XtEVT_handler1 invocations count");
	invoked2 = avs_get_event(2);
	check_dec(1, invoked2, "XtEVT_handler2 invocations count");
	tet_infoline("TEST: Requestor callback invoked");
	invoked3 = avs_get_event(3);
	check_dec(1, invoked3, "requestor callback invocations count");
	tet_result(TET_PASS);
