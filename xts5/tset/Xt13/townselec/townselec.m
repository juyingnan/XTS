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
$Header: /cvs/xtest/xtest/xts5/tset/Xt13/townselec/townselec.m,v 1.1 2005-02-12 14:37:58 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt13/townselec/townselec.m
>># 
>># Description:
>>#	Tests for XtOwnSelection()
>># 
>># Modifications:
>># $Log: townselec.m,v $
>># Revision 1.1  2005-02-12 14:37:58  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:38:13  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:14  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:29:15  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:25:49  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:21:46  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:17:50  andy
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
#define	MSG	 "ApTest"
#define	FORMAT	8

/*
** local functions
*/
static Boolean convert_proc1();
static void lose_proc1();
static void done_proc1();
static void requestor_callback1();

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
	status = XtOwnSelection(
		 sender_widget,
		 SELECTION,
		 bevent->time,
		 convert_proc1,
		 NULL,
		 done_proc1
		 );
	check_dec(True, status, "XtOwnSelection return value");
}
static
void XtEVT1_handler2(receiver_widget, client_data, event, continue_to_dispatch)
Widget receiver_widget;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_dispatch;
{
XButtonEvent *bevent;

	bevent = (XButtonEvent *)event;
	avs_set_event(2, 1); 
	XtGetSelectionValue(
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
static void
lose_proc1(w, selection)
Widget w;
Atom *selection;
{
		sprintf(ebuf, "ERROR: labelw_good widget lost selection ownership");
	tet_infoline(ebuf);
	tet_result(TET_FAIL);
	exit(0);
}
static void
done_proc1(w, selection, target)
Widget w;
Atom *selection;
Atom *target;
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
	check_dec(SELECTION, *selection, "*selection");
	check_dec(TYPE , *type, "*type");
	check_str(MSG, value, "*value");
	check_dec(strlen(MSG)+1, *length, "*length");
	check_dec(FORMAT, *format, "*format");
}
static Boolean convert_proc2();
static void lose_proc2();
static void done_proc2();
static void requestor_callback2();

/* procedure XtTMO2_Proc to be invoked */
void XtTMO2_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	exit(0);
}

static void XtEVT2_handler(sender_widget, client_data, event, continue_to_dispatch)
Widget sender_widget;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_dispatch;
{
	Boolean status;
	XButtonEvent *bevent;
	Widget topLevel = (Widget)client_data;

	bevent = (XButtonEvent *)event;
	avs_set_event(1, 1); 
	XtUnrealizeWidget(sender_widget);
	status = XtOwnSelection(
		 sender_widget,
		 SELECTION,
		 bevent->time,
		 convert_proc2,
		 lose_proc2,
		 done_proc2
		 );
	check_dec(False, status, "XtOwnSelection return value");
}
static Boolean 
convert_proc2(w, selection, target, type_return, value_return,
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
static void
lose_proc2(w, selection)
Widget w;
Atom *selection;
{
	sprintf(ebuf, "ERROR: labelw_good widget lost selection ownership");
	tet_infoline(ebuf);
	tet_result(TET_FAIL);
}
static void
done_proc2(w, selection, target)
Widget w;
Atom *selection;
Atom *target;
{
	XtDisownSelection(w, *selection, CurrentTime);
}
/* local functions */
static Boolean convert_proc3();
static void lose_proc3();
static void done_proc3();
static void requestor_callback3();

/* procedure XtTMO3_Proc to be invoked */
void XtTMO3_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	exit(0);
}

void XtEVT3_handler1(sender_widget, client_data, event, continue_to_dispatch)
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
		 convert_proc3,
		 NULL,
		 done_proc3
		 );
	check_dec(True, status, "XtOwnSelection return value");
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
	XtGetSelectionValue(
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
	avs_set_event(1, 1);
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
static void
lose_proc3(w, selection)
Widget w;
Atom *selection;
{
	sprintf(ebuf, "ERROR: labelw_good widget lost selection ownership");
	tet_infoline(ebuf);
	tet_result(TET_FAIL);
}
static void
done_proc3(w, selection, target)
Widget w;
Atom *selection;
Atom *target;
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
	check_dec(SELECTION, *selection, "*selection");
	check_dec(TYPE , *type, "*type");
	check_str(MSG, value, "*value");
	check_dec(strlen(MSG)+1, *length, "*length");
	check_dec(FORMAT, *format, "*format");
}
/*
** local functions
*/
static Boolean convert_proc4();
static void lose_proc4();
static void done_proc4();
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
	status = XtOwnSelection(
		 sender_widget,
		 SELECTION,
		 bevent->time,
		 convert_proc4,
		 NULL,
		 done_proc4
		 );
	check_dec(True, status, "XtOwnSelection return value");
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
	XtGetSelectionValue(
		receiver_widget,
		SELECTION,
		TYPE,
		requestor_callback, 
		client_data,
		bevent->time
		);
}
static Boolean 
convert_proc4(w, selection, target, type_return, value_return,
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
static void
lose_proc4(w, selection)
Widget w;
Atom *selection;
{
	sprintf(ebuf, "ERROR: labelw_good widget lost selection ownership");
	tet_infoline(ebuf);
	tet_result(TET_FAIL);
}
static void
done_proc4(w, selection, target)
Widget w;
Atom *selection;
Atom *target;
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
	check_dec(SELECTION, *selection, "*selection");
	check_dec(TYPE , *type, "*type");
	check_str(MSG, value, "*value");
	check_dec(strlen(MSG)+1, *length, "*length");
	check_dec(FORMAT, *format, "*format");
}
/* local functions */
static Boolean convert_proc5();
static void lose_proc5();
static void done_proc5();
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
	status = XtOwnSelection(
		 sender_widget,
		 SELECTION,
		 bevent->time,
		 convert_proc5,
		 lose_proc5,
		 done_proc5
		 );
	check_dec(True, status, "XtOwnSelection return value");
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
	XtGetSelectionValue(
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
static void
lose_proc5(w, selection)
Widget w;
Atom *selection;
{
	avs_set_event(1, 1);
}
static void
done_proc5(w, selection, target)
Widget w;
Atom *selection;
Atom *target;
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
	check_dec(SELECTION, *selection, "*selection");
	check_dec(TYPE , *type, "*type");
	check_str(MSG, value, "*value");
	check_dec(strlen(MSG)+1, *length, "*length");
	check_dec(FORMAT, *format, "*format");
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
	status = XtOwnSelection(
		 sender_widget,
		 SELECTION,
		 bevent->time,
		 convert_proc1,
		 NULL,
		 NULL
		 );
	check_dec(True, status, "XtOwnSelection return value");
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtOwnSelection Xt13
Boolean
XtOwnSelection( w, selection, time, convert_proc, lose_selection, done_proc)
>>ASSERTION Good A
A successful call to 
Boolean XtOwnSelection(w, selection, time, convert_proc, 
lose_selection, done_proc)
shall set the widget 
.A w
as the owner of the selection
.A selection
and return True.
>>CODE
Widget labelw_good;
pid_t pid2;
int invoked1, invoked2;

	FORK(pid2);
	avs_xt_hier("Townselec1", "XtOwnSelection");
	tet_infoline("PREP: Create labelw_good widget ApTest");
	labelw_good = (Widget) CreateLabelWidget("ApTest", boxw1);
	tet_infoline("PREP: Register event handler XtEVT1_handler1 to handle");
	tet_infoline("	    ButtonPress events to labelw_good widget");
	XtAddEventHandler(labelw_good,
		 ButtonPressMask,
		 False,
		 XtEVT1_handler1,
		 (Widget)NULL
		 );
	tet_infoline("PREP: Register event handler XtEVT1_handler2 to handle");
	tet_infoline("	    ButtonRelease events to boxw2 widget");
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
	tet_infoline("TEST: XtEVT1_handler1 and XtEVT1_handler2 invoked");
	invoked1 = avs_get_event(1);
	check_dec(1, invoked1, "XtEVT1_handler1 invocations count");
	invoked2 = avs_get_event(2);
	check_dec(1, invoked2, "XtEVT1_handler2 invocations count");
	tet_result(TET_PASS);
>>ASSERTION Good A
A call to 
Boolean XtOwnSelection(w, selection, time, convert_proc, 
lose_selection, done_proc)
when some other widget has asserted ownership on the specified
selection at a time which is later than the time specified by
.A time
shall return False.
>>CODE
Widget labelw_good;
pid_t pid2;
int invoked;

	FORK(pid2);
	avs_xt_hier("Townselec2", "XtOwnSelection");
	tet_infoline("PREP: Create labelw_good widget ApTest");
	labelw_good = (Widget) CreateLabelWidget("ApTest", boxw1);
	tet_infoline("PREP: Register event handler XtEVT2_handler to handle");
	tet_infoline("      ButtonPress events to labelw_good widget");
	XtAddEventHandler(labelw_good,
		 ButtonPressMask,
		 False,
		 XtEVT2_handler,
		 (XtPointer)NULL
		 );
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send ButtonPress event");
	send_event(labelw_good, ButtonPress, ButtonPressMask, FALSE);
	tet_infoline("PREP: Register timeout procedure");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTMO2_Proc, topLevel);
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: XtEVT2_handler was invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtEVT2_handler invocations count");
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to 
Boolean XtOwnSelection(w, selection, time, convert_proc, 
lose_selection, done_proc)
shall register 
.A convert_proc 
as the procedure that will be called when a widget requests for the 
current value of the specified selection.
>>CODE
Widget labelw_good;
pid_t pid2;
int invoked;

	FORK(pid2);
	avs_xt_hier("Townselec3", "XtOwnSelection");
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
	tet_infoline("TEST: Convert_proc procedure was invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "Convert_proc invocations count");
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to 
Boolean XtOwnSelection(w, selection, time, convert_proc, 
lose_selection, done_proc)
shall register 
.A done_proc 
as the procedure that will be called after a widget that requests
for the current value of the specified selection obtains it.
>>CODE
Widget labelw_good;
pid_t pid2;
int invoked;

	FORK(pid2);
	avs_xt_hier("Townselec4", "XtOwnSelection");
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
	check_dec(1, invoked, "done_proc invocations count");
	tet_result(TET_PASS);
>>ASSERTION Good A
When
.A done_proc
is NULL a successful call to
Boolean XtOwnSelection(w, selection, time, convert_proc, 
lose_selection, done_proc)
shall not register any callback procedure to be called when 
a requester receives the current value of the specified selection.
>>CODE
Widget labelw_good;
pid_t pid2;
int invoked1, invoked2;

	FORK(pid2);
	/*the handlers used here use a NULL done_proc*/
	/*we can't really provide no procedure is set but this shows*/
	/*nothing catastrophic happens with a NULL done_proc*/
	avs_xt_hier("Townselec1", "XtOwnSelection");
	tet_infoline("PREP: Create labelw_good widget ApTest");
	labelw_good = (Widget) CreateLabelWidget("ApTest", boxw1);
	tet_infoline("PREP: Register event handler XtEVT6_handler1 to handle");
	tet_infoline("	    ButtonPress events to labelw_good widget");
	XtAddEventHandler(labelw_good,
		 ButtonPressMask,
		 False,
		 XtEVT6_handler1,
		 (Widget)NULL
		 );
	tet_infoline("PREP: Register event handler XtEVT1_handler2 to handle");
	tet_infoline("	    ButtonRelease events to boxw2 widget");
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
	tet_infoline("TEST: XtEVT6_handler1 and XtEVT1_handler2 invoked");
	invoked1 = avs_get_event(1);
	check_dec(1, invoked1, "XtEVT1_handler1 invocations count");
	invoked2 = avs_get_event(2);
	check_dec(1, invoked2, "XtEVT1_handler2 invocations count");
	tet_result(TET_PASS);
>>ASSERTION Good B 3
After a successful call to
Boolean XtOwnSelection(w, selection, time, convert_proc, 
lose_selection, done_proc)
with 
.A done_proc
set to NULL the storage allocated for the selection value
by the
.A convert_proc
procedure when a widget requests the selection value shall 
be freed when the selection value transfer is complete.
>>ASSERTION Good A
A successful call to 
Boolean XtOwnSelection(w, selection, time, convert_proc, 
lose_selection, done_proc)
shall register 
.A lose_selection 
as the procedure that will be called when the widget 
.A w
loses the ownership of the specified selection.
>>CODE
Widget labelw_good;
pid_t pid2;
int invoked;

	FORK(pid2);
	avs_xt_hier("Townselec5", "XtOwnSelection");
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
	tet_infoline("TEST: lose_selection procedure was invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "lose_selection invocations count");
	tet_result(TET_PASS);
>>ASSERTION Good A
When
.A lose_selection
is NULL a successful call to
Boolean XtOwnSelection(w, selection, time, convert_proc, 
lose_selection, done_proc)
shall not register any callback procedure to be called when 
the widget
.A w
loses the ownership of the specified selection.
>>CODE
Widget labelw_good;
pid_t pid2;
int invoked1, invoked2;

	FORK(pid2);
	/*the handlers used here use a NULL lose_selection*/
	/*we can't really provide no procedure is set but this shows*/
	/*nothing catastrophic happens with a NULL lose_selection*/
	avs_xt_hier("Townselec1", "XtOwnSelection");
	tet_infoline("PREP: Create labelw_good widget ApTest");
	labelw_good = (Widget) CreateLabelWidget("ApTest", boxw1);
	tet_infoline("PREP: Register event handler XtEVT1_handler1 to handle");
	tet_infoline("	    ButtonPress events to labelw_good widget");
	XtAddEventHandler(labelw_good,
		 ButtonPressMask,
		 False,
		 XtEVT1_handler1,
		 (Widget)NULL
		 );
	tet_infoline("PREP: Register event handler XtEVT1_handler2 to handle");
	tet_infoline("	    ButtonRelease events to boxw2 widget");
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
	tet_infoline("TEST: XtEVT1_handler1 and XtEVT1_handler2 invoked");
	invoked1 = avs_get_event(1);
	check_dec(1, invoked1, "XtEVT1_handler1 invocations count");
	invoked2 = avs_get_event(2);
	check_dec(1, invoked2, "XtEVT1_handler2 invocations count");
	tet_result(TET_PASS);
