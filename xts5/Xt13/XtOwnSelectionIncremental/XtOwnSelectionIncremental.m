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
$Header: /cvs/xtest/xtest/xts5/tset/Xt13/XtOwnSelectionIncremental/XtOwnSelectionIncremental.m,v 1.1 2005-02-12 14:37:58 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt13/XtOwnSelectionIncremental/XtOwnSelectionIncremental.m
>># 
>># Description:
>>#	Tests for XtOwnSelectionIncremental()
>># 
>># Modifications:
>># $Log: townselin.m,v $
>># Revision 1.1  2005-02-12 14:37:58  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:38:15  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:16  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:29:17  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:25:51  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:21:55  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:18:01  andy
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
#define	HELLO	 "ApTest"
#define	WORLD	 "World"
#define	FORMAT	8

/*
** local functions
*/
static Boolean convert_proc1();
static void lose_proc1();
static void done_proc1();
static void cancel_proc1();
static void requestor_callback1();

int increment = 1; 

/* procedure XtTMO1_Proc to be invoked */
void XtTMO1_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	exit(0);
}

static void XtEVT1_handler1(sender_widget, client_data, event, continue_to_dispatch)
Widget sender_widget;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_dispatch;
{
	Boolean status;
XButtonEvent *bevent;

	bevent = (XButtonEvent *)event;
	avs_set_event(1, 1); 
	status = XtOwnSelectionIncremental(
		 sender_widget,
		 SELECTION,
		 bevent->time,
		 convert_proc1,
		 NULL,
		 done_proc1,
		 NULL,
		 client_data
		 );
	check_dec(True, status, "XtOwnSelectionIncremental return value");
}

static void XtEVT1_handler2(receiver_widget, client_data, event, continue_to_dispatch)
Widget receiver_widget;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_dispatch;
{
XButtonEvent *bevent;

	bevent = (XButtonEvent *)event;
	avs_set_event(2, 1); 
	XtGetSelectionValueIncremental(
		receiver_widget,
		SELECTION,
		TYPE,
		requestor_callback1, 
		client_data,
		bevent->time
		);
}
static Boolean 
convert_proc1(w, selection, target, type_return, value_return,
		length_return, format_return, max_length, client_data, request_id)
Widget w;
Atom *selection;
Atom *target;
Atom *type_return;
XtPointer *value_return;
unsigned long *length_return;
int *format_return;
unsigned long *max_length;
XtPointer client_data;
XtRequestId *request_id;
{
	
	char *data;
	if ( *target == TYPE ) {
	switch (increment) {
	case 1:
	 *length_return = strlen(HELLO) * sizeof(char) + 1;
	 data = XtMalloc(*length_return);
	 strcpy(data, HELLO);
	 *value_return = data;
	 *type_return = TYPE;
	 *format_return = FORMAT;
	 return(True);
	case 2: 
	 *length_return = strlen(WORLD) * sizeof(char) + 1;
	 data = XtMalloc(*length_return);
	 strcpy(data, WORLD);
	 *value_return = data;
	 *type_return = TYPE;
	 *format_return = FORMAT;
	 return(True);
	case 3:
	 *length_return = 0;
		break;
	default:
	 *length_return = 0;
		break;
	} /* end switch */
	} else
	return(False);
}
static void
lose_proc1(w, selection, client_data)
Widget w;
Atom *selection;
XtPointer client_data;
{
	sprintf(ebuf, "ERROR: labelw_good widget lost selection ownership");
	tet_infoline(ebuf);
	tet_result(TET_FAIL);
	exit(0);
}
static void
done_proc1(w, selection, target, request_id, client_data)
Widget w;
Atom *selection;
Atom *target;
XtRequestId *request_id;
XtPointer client_data;
{
	XtDisownSelection(w, *selection, CurrentTime);
}
static void
requestor_callback1(w, client_data, selection, type, value,
		length, format)
Widget w;
XtPointer client_data;
Atom *selection;
Atom *type;
XtPointer value;
unsigned long *length;
int *format;
{
	switch (increment) {
	case 1:
	check_dec(SELECTION, *selection, "*selection");
	check_dec(TYPE , *type, "*type");
	check_str(HELLO, value, "*value");
	check_dec(strlen(HELLO)+1, *length, "*length");
	check_dec(FORMAT, *format, "*format");
	break;
	case 2:
	check_dec(SELECTION, *selection, "*selection");
	check_dec(TYPE , *type, "*type");
	check_str(WORLD, value, "*value");
	check_dec(strlen(WORLD)+1, *length, "*length");
	check_dec(FORMAT, *format, "*format");
	break;
	case 3:
	break;
	}
	increment += 1;
}
/* local functions */
static Boolean convert_proc2();
static void lose_proc2();
static void done_proc2();
static void cancel_proc2();
static void requestor_callback2();

/* procedure XtTMO2_Proc to be invoked */
void XtTMO2_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	exit(0);
}

static void XtEVT2_handler1(sender_widget, client_data, event, continue_to_dispatch)
Widget sender_widget;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_dispatch;
{
	Boolean status;
XButtonEvent *bevent;

	bevent = (XButtonEvent *)event;
	avs_set_event(1, 1); 
	XtUnrealizeWidget(sender_widget);
	status = XtOwnSelectionIncremental(
		 sender_widget,
		 SELECTION,
		 bevent->time,
		 convert_proc2,
		 NULL,
		 done_proc2,
		 NULL,
		 client_data
		 );
	check_dec(False, status, "XtOwnSelectionIncremental return value");
}
static
void XtEVT2_handler2(receiver_widget, client_data, event, continue_to_dispatch)
Widget receiver_widget;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_dispatch;
{
XButtonEvent *bevent;

	bevent = (XButtonEvent *)event;
	avs_set_event(2, 1); 
	XtGetSelectionValueIncremental(
		receiver_widget,
		SELECTION,
		TYPE,
		requestor_callback2, 
		client_data,
		bevent->time
		);
}
static Boolean 
convert_proc2(w, selection, target, type_return, value_return,
		length_return, format_return, max_length, client_data, request_id)
Widget w;
Atom *selection;
Atom *target;
Atom *type_return;
XtPointer *value_return;
unsigned long *length_return;
int *format_return;
unsigned long *max_length;
XtPointer client_data;
XtRequestId *request_id;
{
	
	char *data;
	if ( *target == TYPE ) {
	switch (increment) {
	case 1:
	 *length_return = strlen(HELLO) * sizeof(char) + 1;
	 data = XtMalloc(*length_return);
	 strcpy(data, HELLO);
	 *value_return = data;
	 *type_return = TYPE;
	 *format_return = FORMAT;
	 return(True);
	case 2: 
	 *length_return = strlen(WORLD) * sizeof(char) + 1;
	 data = XtMalloc(*length_return);
	 strcpy(data, WORLD);
	 *value_return = data;
	 *type_return = TYPE;
	 *format_return = FORMAT;
	 return(True);
	case 3:
	 *length_return = 0;
		break;
	default:
	 *length_return = 0;
		break;
	} /* end switch */
	} else
	return(False);
}
static void
lose_proc2(w, selection, client_data)
Widget w;
Atom *selection;
XtPointer client_data;
{
	sprintf(ebuf, "ERROR: labelw_good widget lost selection ownership");
	tet_infoline(ebuf);
	tet_result(TET_FAIL);
}
static void
done_proc2(w, selection, target, request_id, client_data)
Widget w;
Atom *selection;
Atom *target;
XtRequestId *request_id;
XtPointer client_data;
{
	XtDisownSelection(w, *selection, CurrentTime);
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
	switch (increment) {
	case 1:
	check_dec(SELECTION, *selection, "*selection");
	check_dec(0, (long)value, "value");
	check_dec(0, *length, "*length");
	check_dec(FORMAT, *format, "*format");
	break;
	case 2:
	check_dec(SELECTION, *selection, "*selection");
	check_dec(TYPE , *type, "*type");
	check_str(WORLD, value, "*value");
	check_dec(strlen(WORLD)+1, *length, "*length");
	check_dec(FORMAT, *format, "*format");
	break;
	case 3:
	break;
	}
	increment += 1;
}
/* local functions */
static Boolean convert_proc3();
static void lose_proc3();
static void done_proc3();
static void cancel_proc3();
static void requestor_callback3();

/* procedure XtTMO3_Proc to be invoked */
void XtTMO3_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	exit(0);
}

static void XtEVT3_handler1(sender_widget, client_data, event, continue_to_dispatch)
Widget sender_widget;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_dispatch;
{
	Boolean status;
XButtonEvent *bevent;

	bevent = (XButtonEvent *)event;
	status = XtOwnSelectionIncremental(
		 sender_widget,
		 SELECTION,
		 bevent->time,
		 convert_proc3,
		 NULL,
		 done_proc3,
		 NULL,
		 client_data
		 );
	check_dec(True, status, "XtOwnSelectionIncremental return value");
}
static
void XtEVT3_handler2(receiver_widget, client_data, event, continue_to_dispatch)
Widget receiver_widget;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_dispatch;
{
XButtonEvent *bevent;

	bevent = (XButtonEvent *)event;
	XtGetSelectionValueIncremental(
		receiver_widget,
		SELECTION,
		TYPE,
		requestor_callback3, 
		client_data,
		bevent->time
		);
}
static Boolean 
convert_proc3(w, selection, target, type_return, value_return,
		length_return, format_return, max_length, client_data, request_id)
Widget w;
Atom *selection;
Atom *target;
Atom *type_return;
XtPointer *value_return;
unsigned long *length_return;
int *format_return;
unsigned long *max_length;
XtPointer client_data;
XtRequestId *request_id;
{
	
	char *data;
	if ( *target == TYPE ) {
	switch (increment) {
	case 1:
	 avs_set_event(1, 1);
	 *length_return = strlen(HELLO) * sizeof(char) + 1;
	 data = XtMalloc(*length_return);
	 strcpy(data, HELLO);
	 *value_return = data;
	 *type_return = TYPE;
	 *format_return = FORMAT;
	 return(True);
	case 2: 
	 avs_set_event(2, 1);
	 *length_return = strlen(WORLD) * sizeof(char) + 1;
	 data = XtMalloc(*length_return);
	 strcpy(data, WORLD);
	 *value_return = data;
	 *type_return = TYPE;
	 *format_return = FORMAT;
	 return(True);
	case 3:
	 *length_return = 0;
		break;
	default:
	 *length_return = 0;
		break;
	} /* end switch */
	} else
	return(False);
}
static void
lose_proc3(w, selection, client_data)
Widget w;
Atom *selection;
XtPointer client_data;
{
	sprintf(ebuf, "ERROR: labelw_good widget lost selection ownership");
	tet_infoline(ebuf);
	tet_result(TET_FAIL);
}
static void
done_proc3(w, selection, target, request_id, client_data)
Widget w;
Atom *selection;
Atom *target;
XtRequestId *request_id;
XtPointer client_data;
{
	XtDisownSelection(w, *selection, CurrentTime);
}
static void
requestor_callback3(w, client_data, selection, type, value,
		length, format)
Widget w;
XtPointer client_data;
Atom *selection;
Atom *type;
XtPointer value;
unsigned long *length;
int *format;
{
	switch (increment) {
	case 1:
	check_dec(SELECTION, *selection, "*selection");
	check_dec(TYPE , *type, "*type");
	check_str(HELLO, value, "*value");
	check_dec(strlen(HELLO)+1, *length, "*length");
	check_dec(FORMAT, *format, "*format");
	break;
	case 2:
	check_dec(SELECTION, *selection, "*selection");
	check_dec(TYPE , *type, "*type");
	check_str(WORLD, value, "*value");
	check_dec(strlen(WORLD)+1, *length, "*length");
	check_dec(FORMAT, *format, "*format");
	break;
	case 3:
	break;
	}
	increment += 1;
}
/* local functions */
static Boolean convert4_proc();
static void lose4_proc();
static void done4_proc();
static void cancel4_proc();
static void requestor_callback();

/* procedure XtTMO4_Proc to be invoked */
void XtTMO4_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	exit(0);
}

static void XtEVT4_handler1(sender_widget, client_data, event, continue_to_dispatch)
Widget sender_widget;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_dispatch;
{
	Boolean status;
XButtonEvent *bevent;

	bevent = (XButtonEvent *)event;
	status = XtOwnSelectionIncremental(
		 sender_widget,
		 SELECTION,
		 bevent->time,
		 convert4_proc,
		 NULL,
		 done4_proc,
		 NULL,
		 client_data
		 );
	check_dec(True, status, "XtOwnSelectionIncremental return value");
}
static
void XtEVT4_handler2(receiver_widget, client_data, event, continue_to_dispatch)
Widget receiver_widget;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_dispatch;
{
XButtonEvent *bevent;

	bevent = (XButtonEvent *)event;
	XtGetSelectionValueIncremental(
		receiver_widget,
		SELECTION,
		TYPE,
		requestor_callback, 
		client_data,
		bevent->time
		);
}
static Boolean 
convert4_proc(w, selection, target, type_return, value_return,
		length_return, format_return, max_length, client_data, request_id)
Widget w;
Atom *selection;
Atom *target;
Atom *type_return;
XtPointer *value_return;
unsigned long *length_return;
int *format_return;
unsigned long *max_length;
XtPointer client_data;
XtRequestId *request_id;
{
	
	char *data;
	if ( *target == TYPE ) {
	switch (increment) {
	case 1:
	 *length_return = strlen(HELLO) * sizeof(char) + 1;
	 data = XtMalloc(*length_return);
	 strcpy(data, HELLO);
	 *value_return = data;
	 *type_return = TYPE;
	 *format_return = FORMAT;
	 return(True);
	case 2: 
	 *length_return = strlen(WORLD) * sizeof(char) + 1;
	 data = XtMalloc(*length_return);
	 strcpy(data, WORLD);
	 *value_return = data;
	 *type_return = TYPE;
	 *format_return = FORMAT;
	 return(True);
	case 3:
	 *length_return = 0;
		break;
	default:
	 *length_return = 0;
		break;
	} /* end switch */
	} else
	return(False);
}
static void
lose4_proc(w, selection, client_data)
Widget w;
Atom *selection;
XtPointer client_data;
{
	sprintf(ebuf, "ERROR: labelw_good widget lost selection ownership");
	tet_infoline(ebuf);
	tet_result(TET_FAIL);
}
static void
done4_proc(w, selection, target, request_id, client_data)
Widget w;
Atom *selection;
Atom *target;
XtRequestId *request_id;
XtPointer client_data;
{
	avs_set_event(1, 1);
	XtDisownSelection(w, *selection, CurrentTime);
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
	switch (increment) {
	case 1:
	check_dec(SELECTION, *selection, "*selection");
	check_dec(TYPE , *type, "*type");
	check_str(HELLO, value, "*value");
	check_dec(strlen(HELLO)+1, *length, "*length");
	check_dec(FORMAT, *format, "*format");
	break;
	case 2:
	check_dec(SELECTION, *selection, "*selection");
	check_dec(TYPE , *type, "*type");
	check_str(WORLD, value, "*value");
	check_dec(strlen(WORLD)+1, *length, "*length");
	check_dec(FORMAT, *format, "*format");
	break;
	case 3:
	break;
	}
	increment += 1;
}
/* local functions */
static Boolean convert_proc5();
static void lose_proc5();
static void done_proc5();
static void cancel_proc5();
static void requestor_callback5();

/* procedure XtTMO5_Proc to be invoked */
void XtTMO5_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	exit(0);
}

static void XtEVT5_handler1(sender_widget, client_data, event, continue_to_dispatch)
Widget sender_widget;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_dispatch;
{
	Boolean status;
XButtonEvent *bevent;

	bevent = (XButtonEvent *)event;
	status = XtOwnSelectionIncremental(
		 sender_widget,
		 SELECTION,
		 bevent->time,
		 convert_proc5,
		 lose_proc5,
		 done_proc5,
		 NULL,
		 client_data
		 );
	check_dec(True, status, "XtOwnSelectionIncremental return value");
}
static
void XtEVT5_handler2(receiver_widget, client_data, event, continue_to_dispatch)
Widget receiver_widget;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_dispatch;
{
XButtonEvent *bevent;

	bevent = (XButtonEvent *)event;
	XtGetSelectionValueIncremental(
		receiver_widget,
		SELECTION,
		TYPE,
		requestor_callback5, 
		client_data,
		bevent->time
		);
}
static Boolean 
convert_proc5(w, selection, target, type_return, value_return,
		length_return, format_return, max_length, client_data, request_id)
Widget w;
Atom *selection;
Atom *target;
Atom *type_return;
XtPointer *value_return;
unsigned long *length_return;
int *format_return;
unsigned long *max_length;
XtPointer client_data;
XtRequestId *request_id;
{
	
	char *data;
	if ( *target == TYPE ) {
	switch (increment) {
	case 1:
	 *length_return = strlen(HELLO) * sizeof(char) + 1;
	 data = XtMalloc(*length_return);
	 strcpy(data, HELLO);
	 *value_return = data;
	 *type_return = TYPE;
	 *format_return = FORMAT;
	 return(True);
	case 2: 
	 *length_return = strlen(WORLD) * sizeof(char) + 1;
	 data = XtMalloc(*length_return);
	 strcpy(data, WORLD);
	 *value_return = data;
	 *type_return = TYPE;
	 *format_return = FORMAT;
	 return(True);
	case 3:
	 *length_return = 0;
		break;
	default:
	 *length_return = 0;
		break;
	} /* end switch */
	} else
	return(False);
}
static void
lose_proc5(w, selection, client_data)
Widget w;
Atom *selection;
XtPointer client_data;
{
	avs_set_event(1, 1);
}
static void
done_proc5(w, selection, target, request_id, client_data)
Widget w;
Atom *selection;
Atom *target;
XtRequestId *request_id;
XtPointer client_data;
{
	XtDisownSelection(w, *selection, CurrentTime);
}
static void
requestor_callback5(w, client_data, selection, type, value,
		length, format)
Widget w;
XtPointer client_data;
Atom *selection;
Atom *type;
XtPointer value;
unsigned long *length;
int *format;
{
	switch (increment) {
	case 1:
	check_dec(SELECTION, *selection, "*selection");
	check_dec(TYPE , *type, "*type");
	check_str(HELLO, value, "*value");
	check_dec(strlen(HELLO)+1, *length, "*length");
	check_dec(FORMAT, *format, "*format");
	break;
	case 2:
	check_dec(SELECTION, *selection, "*selection");
	check_dec(TYPE , *type, "*type");
	check_str(WORLD, value, "*value");
	check_dec(strlen(WORLD)+1, *length, "*length");
	check_dec(FORMAT, *format, "*format");
	break;
	case 3:
	break;
	}
	increment += 1;
}

static void XtEVT6_handler1(sender_widget, client_data, event, continue_to_dispatch)
Widget sender_widget;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_dispatch;
{
	Boolean status;
XButtonEvent *bevent;

	bevent = (XButtonEvent *)event;
	avs_set_event(1, 1); 
	status = XtOwnSelectionIncremental(
		 sender_widget,
		 SELECTION,
		 bevent->time,
		 convert_proc1,
		 NULL,
		 NULL,
		 NULL,
		 client_data
		 );
	check_dec(True, status, "XtOwnSelectionIncremental return value");
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtOwnSelectionIncremental Xt13
Boolean
XtOwnSelectionIncremental(w, selection, time, convert_proc, lose_proc, done_proc cancel_callback, client_data)
>>ASSERTION Good A
A successful call to 
Boolean XtOwnSelectionIncremental(w, selection, time, convert_callback, 
lose_callback, done_callback cancel_callback, client_data)
shall set the widget 
.A w
as the owner of the selection
.A selection
for incremental transfers of the selection value and return True.
>>CODE
Widget labelw_good;
pid_t pid2;
int invoked1, invoked2;

	FORK(pid2);
	increment = 1;
	avs_xt_hier("Townselin1", "XtOwnSelectionIncremental");
	tet_infoline("PREP: Create labelw_good widget ApTest");
	labelw_good = (Widget) CreateLabelWidget("ApTest", boxw1);
	tet_infoline("PREP: Register event handler XtEVT1_handler1 to handle");
	tet_infoline("      ButtonPress events to labelw_good widget");
	XtAddEventHandler(labelw_good,
		 ButtonPressMask,
		 False,
		 XtEVT1_handler1,
		 (Widget)NULL
		 );
	tet_infoline("PREP: Register event handler XtEVT1_handler2 to handle");
	tet_infoline("      ButtonRelease events to boxw2 widget");
	XtAddEventHandler(boxw2,
		 ButtonReleaseMask,
		 False,
		 XtEVT1_handler2,
		 (Widget)NULL
		 );
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send ButtonPress event");
	send_event(labelw_good, ButtonPress, ButtonPressMask, FALSE);
	tet_infoline("PREP: Send ButtonRelease event");
	send_event(boxw2, ButtonRelease, ButtonReleaseMask, FALSE);
	tet_infoline("PREP: Register timeout procedure");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTMO1_Proc, topLevel);
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Handlers were invoked");
	invoked1 = avs_get_event(1);
	check_dec(1, invoked1, "handler 1 invocations count");
	invoked2 = avs_get_event(2);
	check_dec(1, invoked2, "handler 2 invocations count");
	tet_result(TET_PASS);
>>ASSERTION Good A
A call to 
Boolean XtOwnSelectionIncremental(w, selection, time, convert_callback, 
lose_callback, done_callback cancel_callback, client_data)
when the widget 
.A w
is unable to assert ownership on the selection
.A selection
shall return False.
>>CODE
Widget labelw_good;
pid_t pid2;
int invoked1, invoked2;

	FORK(pid2);
	increment = 1;
	avs_xt_hier("Townselin2", "XtOwnSelectionIncremental");
	tet_infoline("PREP: Create labelw_good widget ApTest");
	labelw_good = (Widget) CreateLabelWidget("ApTest", boxw1);
	tet_infoline("PREP: Register event handler XtEVT2_handler1 to handle");
	tet_infoline("       ButtonPress events to labelw_good widget");
	XtAddEventHandler(labelw_good,
		 ButtonPressMask,
		 False,
		 XtEVT2_handler1,
		 (Widget)NULL
		 );
	tet_infoline("PREP: Register event handler XtEVT2_handler2 to handle");
	tet_infoline("       ButtonRelease events to boxw2 widget");
	XtAddEventHandler(boxw2,
		 ButtonReleaseMask,
		 False,
		 XtEVT2_handler2,
		 (Widget)NULL
		 );
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send ButtonPress event");
	send_event(labelw_good, ButtonPress, ButtonPressMask, FALSE);
	tet_infoline("PREP: Send ButtonRelease event");
	send_event(boxw2, ButtonRelease, ButtonReleaseMask, FALSE);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTMO2_Proc, topLevel);
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Check XtEVT2_handler1 and XtEVT2_handler2 were invoked");
	invoked1 = avs_get_event(1);
	check_dec(1, invoked1, "handler 1 invocations count");
	invoked2 = avs_get_event(2);
	check_dec(1, invoked2, "handler 2 invocations count");
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to 
Boolean XtOwnSelectionIncremental(w, selection, time, convert_callback, 
lose_callback, done_callback cancel_callback, client_data)
shall register 
.A convert_callback 
as the procedure that will be called when a widget requests for the 
current value of the specified selection.
>>CODE
Widget labelw_good;
pid_t pid2;
int invoked1, invoked2;

	FORK(pid2);
	increment = 1;
	avs_xt_hier("Townselin3", "XtOwnSelectionIncremental");
	tet_infoline("PREP: Create labelw_good widget ApTest");
	labelw_good = (Widget) CreateLabelWidget("ApTest", boxw1);
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
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTMO3_Proc, topLevel);
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Convert_proc was invoked twice");
	invoked1 = avs_get_event(1);
	check_dec(1, invoked1, "handler 1 invocations count");
	invoked2 = avs_get_event(2);
	check_dec(1, invoked2, "handler 2 invocations count");
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to 
Boolean XtOwnSelectionIncremental(w, selection, time, convert_callback, 
lose_callback, done_callback cancel_callback, client_data)
shall register 
.A done_callback 
as the procedure that will be called after a widget that requests
for the current value of the specified selection obtains the entire
selection value.
>>CODE
Widget labelw_good;
pid_t pid2;
int invoked;

	FORK(pid2);
	increment = 1;
	avs_xt_hier("Townselin4", "XtOwnSelectionIncremental");
	tet_infoline("PREP: Create labelw_good widget ApTest");
	labelw_good = (Widget) CreateLabelWidget("ApTest", boxw1);
	tet_infoline("PREP: Register event handler XtEVT4_handler1 to handle");
	tet_infoline("      ButtonPress events to labelw_good widget");
	XtAddEventHandler(labelw_good,
		 ButtonPressMask,
		 False,
		 XtEVT4_handler1,
		 (Widget)NULL
		 );
	tet_infoline("PREP: Register event handler XtEVT4_handler2 to handle");
	tet_infoline("      ButtonRelease events to boxw2 widget");
	XtAddEventHandler(boxw2,
		 ButtonReleaseMask,
		 False,
		 XtEVT4_handler2,
		 (Widget)NULL
		 );
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send ButtonPress event");
	send_event(labelw_good, ButtonPress, ButtonPressMask, FALSE);
	tet_infoline("PREP: Send ButtonRelease event");
	send_event(boxw2, ButtonRelease, ButtonReleaseMask, FALSE);
	tet_infoline("PREP: Register timeout procedure");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTMO4_Proc, topLevel);
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: done_proc procedure was invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "invocations count");
	tet_result(TET_PASS);
>>ASSERTION Good A
When
.A done_callback
is NULL a successful call to
Boolean XtOwnSelectionIncremental(w, selection, time, convert_callback, 
lose_callback, done_callback cancel_callback, client_data)
shall not register any callback procedure to be called when 
a requester receives the current value of the specified selection.
>>CODE
Widget labelw_good;
pid_t pid2;
int invoked1, invoked2;

	FORK(pid2);
	increment = 1;
	avs_xt_hier("Townselin1", "XtOwnSelectionIncremental");
	tet_infoline("PREP: Create labelw_good widget ApTest");
	labelw_good = (Widget) CreateLabelWidget("ApTest", boxw1);
	/*has NULL done_proc - can't really shown nothing is registered
	but this shows nothing catastrophic happens*/
	tet_infoline("PREP: Register event handler XtEVT6_handler1 to handle");
	tet_infoline("      ButtonPress events to labelw_good widget");
	XtAddEventHandler(labelw_good,
		 ButtonPressMask,
		 False,
		 XtEVT1_handler1,
		 (Widget)NULL
		 );
	tet_infoline("PREP: Register event handler XtEVT1_handler2 to handle");
	tet_infoline("      ButtonRelease events to boxw2 widget");
	XtAddEventHandler(boxw2,
		 ButtonReleaseMask,
		 False,
		 XtEVT1_handler2,
		 (Widget)NULL
		 );
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send ButtonPress event");
	send_event(labelw_good, ButtonPress, ButtonPressMask, FALSE);
	tet_infoline("PREP: Send ButtonRelease event");
	send_event(boxw2, ButtonRelease, ButtonReleaseMask, FALSE);
	tet_infoline("PREP: Register timeout procedure");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTMO1_Proc, topLevel);
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Handlers were invoked");
	invoked1 = avs_get_event(1);
	check_dec(1, invoked1, "handler 1 invocations count");
	invoked2 = avs_get_event(2);
	check_dec(1, invoked2, "handler 2 invocations count");
	tet_result(TET_PASS);
>>ASSERTION Good B 3
After a successful call to
Boolean XtOwnSelectionIncremental(w, selection, time, convert_callback, 
lose_callback, done_callback cancel_callback, client_data)
with 
.A done_callback
set to NULL the storage allocated for the selection value
by the
.A convert_proc
procedure when a widget requests for the selection value shall 
be freed when the selection value transfer is complete.
>>ASSERTION Good A
A successful call to 
Boolean XtOwnSelectionIncremental(w, selection, time, convert_callback, 
lose_callback, done_callback cancel_callback, client_data)
shall register 
.A lose_callback 
as the procedure that will called when the widget 
.A w
loses the ownership of the specified selection.
>>CODE
Widget labelw_good;
pid_t pid2;
int invoked;

	FORK(pid2);
	increment = 1;
	avs_xt_hier("Townselin5", "XtOwnSelectionIncremental");
	tet_infoline("PREP: Create labelw_good widget ApTest");
	labelw_good = (Widget) CreateLabelWidget("ApTest", boxw1);
	tet_infoline("PREP: Register event handler XtEVT5_handler1 to handle");
	tet_infoline("      ButtonPress events to labelw_good widget");
	XtAddEventHandler(labelw_good,
		 ButtonPressMask,
		 False,
		 XtEVT5_handler1,
		 (Widget)NULL
		 );
	tet_infoline("PREP: Register event handler XtEVT5_handler2 to handle");
	tet_infoline("      ButtonRelease events to boxw2 widget");
	XtAddEventHandler(boxw2,
		 ButtonReleaseMask,
		 False,
		 XtEVT5_handler2,
		 (Widget)NULL
		 );
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send ButtonPress event");
	send_event(labelw_good, ButtonPress, ButtonPressMask, FALSE);
	tet_infoline("PREP: Send ButtonRelease event");
	send_event(boxw2, ButtonRelease, ButtonReleaseMask, FALSE);
	tet_infoline("PREP: Register timeout procedure");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTMO5_Proc, topLevel);
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Check lose_proc procedure was invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "invocations count");
	tet_result(TET_PASS);
>>ASSERTION Good A
When
.A lose_callback
is NULL a successful call to
Boolean XtOwnSelectionIncremental(w, selection, time, convert_callback, 
lose_callback, done_callback cancel_callback, client_data)
shall not register any callback procedure to be called when 
the widget
.A w
loses the ownership of the specified selection.
>>CODE
Widget labelw_good;
pid_t pid2;
int invoked1, invoked2;

	FORK(pid2);
	increment = 1;
	avs_xt_hier("Townselin1", "XtOwnSelectionIncremental");
	tet_infoline("PREP: Create labelw_good widget ApTest");
	labelw_good = (Widget) CreateLabelWidget("ApTest", boxw1);
	/*has NULL lose_proc - can't really shown nothing is registered
	but this shows nothing catastrophic happens*/
	tet_infoline("PREP: Register event handler XtEVT1_handler1 to handle");
	tet_infoline("      ButtonPress events to labelw_good widget");
	XtAddEventHandler(labelw_good,
		 ButtonPressMask,
		 False,
		 XtEVT1_handler1,
		 (Widget)NULL
		 );
	tet_infoline("PREP: Register event handler XtEVT1_handler2 to handle");
	tet_infoline("      ButtonRelease events to boxw2 widget");
	XtAddEventHandler(boxw2,
		 ButtonReleaseMask,
		 False,
		 XtEVT1_handler2,
		 (Widget)NULL
		 );
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send ButtonPress event");
	send_event(labelw_good, ButtonPress, ButtonPressMask, FALSE);
	tet_infoline("PREP: Send ButtonRelease event");
	send_event(boxw2, ButtonRelease, ButtonReleaseMask, FALSE);
	tet_infoline("PREP: Register timeout procedure");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTMO1_Proc, topLevel);
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Handlers were invoked");
	invoked1 = avs_get_event(1);
	check_dec(1, invoked1, "handler 1 invocations count");
	invoked2 = avs_get_event(2);
	check_dec(1, invoked2, "handler 2 invocations count");
	tet_result(TET_PASS);
>>ASSERTION Good B 3
A successful call to 
Boolean XtOwnSelectionIncremental(w, selection, time, convert_callback, 
lose_callback, done_callback cancel_callback, client_data)
shall register 
.A cancel_callback 
as the procedure that will called when a request for the value
of the selection 
.A selection
aborts due to a selection timeout.
>>ASSERTION Good B 3
When
.A cancel_callback
is NULL a successful call to
Boolean XtOwnSelectionIncremental(w, selection, time, convert_callback, 
lose_callback, done_callback cancel_callback, client_data)
shall not register any callback procedure to be called when a 
request for value of the specified selection aborts due to a 
selection timeout.
>>CODE
Widget labelw_good;
pid_t pid2;
int invoked1, invoked2;

	FORK(pid2);
	increment = 1;
	avs_xt_hier("Townselin1", "XtOwnSelectionIncremental");
	tet_infoline("PREP: Create labelw_good widget ApTest");
	labelw_good = (Widget) CreateLabelWidget("ApTest", boxw1);
	/*has NULL cancel_proc - can't really shown nothing is registered
	but this shows nothing catastrophic happens*/
	tet_infoline("PREP: Register event handler XtEVT1_handler1 to handle");
	tet_infoline("      ButtonPress events to labelw_good widget");
	XtAddEventHandler(labelw_good,
		 ButtonPressMask,
		 False,
		 XtEVT1_handler1,
		 (Widget)NULL
		 );
	tet_infoline("PREP: Register event handler XtEVT1_handler2 to handle");
	tet_infoline("      ButtonRelease events to boxw2 widget");
	XtAddEventHandler(boxw2,
		 ButtonReleaseMask,
		 False,
		 XtEVT1_handler2,
		 (Widget)NULL
		 );
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send ButtonPress event");
	send_event(labelw_good, ButtonPress, ButtonPressMask, FALSE);
	tet_infoline("PREP: Send ButtonRelease event");
	send_event(boxw2, ButtonRelease, ButtonReleaseMask, FALSE);
	tet_infoline("PREP: Register timeout procedure");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTMO1_Proc, topLevel);
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Handlers were invoked");
	invoked1 = avs_get_event(1);
	check_dec(1, invoked1, "handler 1 invocations count");
	invoked2 = avs_get_event(2);
	check_dec(1, invoked2, "handler 2 invocations count");
	tet_result(TET_PASS);
