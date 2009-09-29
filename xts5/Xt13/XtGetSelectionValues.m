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
>># File: xts/Xt13/XtGetSelectionValues.m
>># 
>># Description:
>>#	Tests for XtGetSelectionValues()
>># 
>># Modifications:
>># $Log: tgtslvals.m,v $
>># Revision 1.1  2005-02-12 14:37:57  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:38:12  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:13  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:29:15  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:25:48  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:21:44  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:17:47  andy
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

static void XtEVT_handler1(sender_widget, client_data, event, continue_to_dispatch)
Widget sender_widget;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_dispatch;
{
Boolean status;
XButtonEvent *bevent;

	bevent = (XButtonEvent *)event;
	status = XtOwnSelection(
		 sender_widget,
		 SELECTION,
		 bevent->time,
		 convert_proc,
		 NULL,
		 NULL
		 );
	check_dec(True, status, "XtOwnSelection return value");
}

static void XtEVT_handler2(receiver_widget, client_data, event, continue_to_dispatch)
Widget receiver_widget;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_dispatch;
{
XButtonEvent *bevent;

	XtPointer cd[] = {
		(XtPointer) 0,
		(XtPointer) 0,
	};
	Atom targets[2] = {
	XA_STRING,
	XA_INTEGER,
	};
		
	bevent = (XButtonEvent *)event;

	XtGetSelectionValues(
		receiver_widget,
		SELECTION,
		targets,
		2,
		requestor_callback, 
		cd,
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
	static int int_value = 0;
	avs_set_event(5, avs_get_event(5)+1);
	if ( *target == XA_STRING ) {
	*length_return = strlen(MSG) * sizeof(char) + 1;
	data = XtMalloc(*length_return);
	strcpy(data, MSG);
	*value_return = data;
	*type_return = XA_STRING;
	*format_return = FORMAT;
	return(True);
	}
	if ( *target == XA_INTEGER) {
	*length_return = sizeof(int);
	*value_return = (char *)&int_value;
	*type_return = XA_INTEGER;
	*format_return = FORMAT;
	return(True);
	}
}
static void
requestor_callback(w, client_data, selection, type, value,
		length, format)
Widget w;
XtPointer client_data;
Atom *selection;
Atom *type;
XtPointer value;
unsigned long *length;
int *format;
{
	int integer;
	avs_set_event(3,1);
	if ( *type == XA_STRING ) {
	avs_set_event(1, XA_STRING);
	check_dec(SELECTION, *selection, "*selection");
	check_dec(XA_STRING , *type, "*type");
	check_str(MSG, value, "*value");
	check_dec(strlen(MSG)+1, *length, "*length");
	check_dec(FORMAT, *format, "*format");
	}
	if ( *type == XA_INTEGER ) {
	avs_set_event(2, XA_INTEGER);
	integer = *(int *)value;
	check_dec(SELECTION, *selection, "*selection");
	check_dec(XA_INTEGER , *type, "*type");
	check_dec(0, integer, "value");
	check_dec(FORMAT, *format, "*format");
	exit(0);
	}
}
static Boolean convert_proc2(w, selection, target, type_return, value_return,
		length_return, format_return)
Widget w;
Atom *selection;
Atom *target;
Atom *type_return;
XtPointer *value_return;
unsigned long *length_return;
int *format_return;
{
	return False;
}
static void
requestor_callback2(w, client_data, selection, type, value,
		length, format)
Widget w;
XtPointer client_data;
Atom *selection;
Atom *type;
XtPointer value;
unsigned long *length;
int *format;
{
	avs_set_event(1, 1); 
	tet_infoline("TEST: callback: length is 0");
	check_dec(0, *length, "*length");
	tet_infoline("TEST: callback: value is NULL");
	if (value != NULL) {
		tet_infoline("ERROR: value is not NULL");
		tet_result(TET_FAIL);
	}
	exit(0);
}
static void XtEVT_handler1_2(sender_widget, client_data, event, continue_to_dispatch)
Widget sender_widget;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_dispatch;
{
Boolean status;
XButtonEvent *bevent;

	bevent = (XButtonEvent *)event;
	status = XtOwnSelection(
		 sender_widget,
		 SELECTION,
		 bevent->time,
		 convert_proc2,
		 NULL,
		 NULL
		 );
	check_dec(True, status, "XtOwnSelection return value");
}
static void XtEVT_handler2_2(receiver_widget, client_data, event, continue_to_dispatch)
Widget receiver_widget;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_dispatch;
{
XButtonEvent *bevent;

	XtPointer cd[] = {
		(XtPointer) 0,
		(XtPointer) 0,
	};
	Atom targets[2] = {
	XA_STRING,
	XA_INTEGER,
	};
		
	bevent = (XButtonEvent *)event;

	XtGetSelectionValues(
		receiver_widget,
		SELECTION,
		targets,
		2,
		requestor_callback2, 
		cd,
		bevent->time
		);
}

>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtGetSelectionValues Xt13
void
XtGetSelectionValues(w, selection, targets, callback, client_data, time)
>>ASSERTION Good A
A call to 
void XtGetSelectionValues(w, selection, targets, count, callback, 
client_data, time)
shall cause the callback procedure 
.A callback
to be called for each conversion of the value of the selection 
.A selection
to each of the 
.A count
types specified in
.A targets,
with the converted value, the widget
.A w,
and the corresponding value from the list of data pointed to by
.A client_data
passed as arguments.
>>CODE
Widget labelw_good;
pid_t pid2;
int invoked1, invoked2;

	FORK(pid2);
	avs_xt_hier("Tgtslvals1", "XtGetSelectionValues");
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
	tet_infoline("TEST: Send ButtonPress event");
	send_event(labelw_good, ButtonPress, ButtonPressMask, FALSE);
	tet_infoline("TEST: Send ButtonRelease event");
	send_event(boxw2, ButtonRelease, ButtonReleaseMask, FALSE);
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Requestor_callback was invoked for each target value");
	invoked1 = avs_get_event(1);
	check_dec(XA_STRING, invoked1, "invocations for XA_STRING count");
	invoked2 = avs_get_event(2);
	check_dec(XA_INTEGER, invoked2, "invocations for XA_INTEGER count");
	tet_result(TET_PASS);
>>ASSERTION Good A
A call to 
void XtGetSelectionValues(w, selection, targets, count, callback, 
client_data, time)
when the value of the specified selection needs conversion to a 
type specified in
.A targets
shall cause the XtConvertSelectionProc procedure of the 
selection owner to be called to convert the selection value 
to the specified type.
>>CODE
Widget labelw_good;
pid_t pid2;
int invoked1, invoked2;

	FORK(pid2);
	avs_xt_hier("Tgtslvals1", "XtGetSelectionValues");
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
	tet_infoline("TEST: Send ButtonPress event");
	send_event(labelw_good, ButtonPress, ButtonPressMask, FALSE);
	tet_infoline("TEST: Send ButtonRelease event");
	send_event(boxw2, ButtonRelease, ButtonReleaseMask, FALSE);
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Requestor_callback was invoked for each target value");
	invoked1 = avs_get_event(1);
	check_dec(XA_STRING, invoked1, "invocations for XA_STRING count");
	invoked2 = avs_get_event(2);
	check_dec(XA_INTEGER, invoked2, "invocations for XA_INTEGER count");
	tet_infoline("TEST: conversion procedure was invoked for each target value");
	invoked1 = avs_get_event(5);
	check_dec(2, invoked1, "conversion procedure invocations");
	tet_result(TET_PASS);
>>ASSERTION Good A
When the selection
.A selection
has no owner a call to 
void XtGetSelectionValues(w, selection, targets, count, callback, 
client_data, time)
shall cause the callback procedure to be called with
the value parameter set to NULL and length set to zero.
>>CODE
Widget labelw_good;
pid_t pid2;
int invoked1, invoked2;

	FORK(pid2);
	avs_xt_hier("Tgtslvals1", "XtGetSelectionValues");
	tet_infoline("PREP: Create labelw_good widget Hello");
	labelw_good = (Widget) CreateLabelWidget("Hello", boxw1);
	tet_infoline("PREP: Register event handler XtEVT_handler2_2 to handle");
	tet_infoline("      ButtonRelease events to boxw2 widget");
	XtAddEventHandler(boxw2,
		 ButtonReleaseMask,
		 False,
		 XtEVT_handler2_2,
		 (Widget)NULL
		 );
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Send ButtonRelease event");
	send_event(boxw2, ButtonRelease, ButtonReleaseMask, FALSE);
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Requestor_callback was invoked");
	invoked1 = avs_get_event(1);
	check_dec(1, invoked1, "invocations for XA_STRING count");
	tet_result(TET_PASS);
>>ASSERTION Good A
When the owner of the selection
.A selection
cannot convert the selection value to a type specified in
.A targets
a call to 
void XtGetSelectionValues(w, selection, targets, count, callback, 
client_data, time)
shall cause the callback procedure to be called with
the value parameter set to NULL and length set to zero.
>>CODE
Widget labelw_good;
pid_t pid2;
int invoked1, invoked2;

	FORK(pid2);
	avs_xt_hier("Tgtslvals1", "XtGetSelectionValues");
	tet_infoline("PREP: Create labelw_good widget Hello");
	labelw_good = (Widget) CreateLabelWidget("Hello", boxw1);
	tet_infoline("PREP: Register event handler XtEVT_handler1_2 to handle");
	tet_infoline("      ButtonPress events to labelw_good widget");
	XtAddEventHandler(labelw_good,
		 ButtonPressMask,
		 False,
		 XtEVT_handler1_2,
		 (Widget)NULL
		 );
	tet_infoline("PREP: Register event handler XtEVT_handler2 to handle");
	tet_infoline("      ButtonRelease events to boxw2 widget");
	XtAddEventHandler(boxw2,
		 ButtonReleaseMask,
		 False,
		 XtEVT_handler2_2,
		 (Widget)NULL
		 );
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Send ButtonPress event");
	send_event(labelw_good, ButtonPress, ButtonPressMask, FALSE);
	tet_infoline("TEST: Send ButtonRelease event");
	send_event(boxw2, ButtonRelease, ButtonReleaseMask, FALSE);
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Requestor_callback was invoked");
	invoked1 = avs_get_event(1);
	check_dec(1, invoked1, "invocations for XA_STRING count");
	tet_result(TET_PASS);
>>ASSERTION Good B 3
The owner of the selection
.A selection
shall not be changed during a call to
void XtGetSelectionValuesIncremental(w, selection, targets, count,
selection_callback, client_data, time).
