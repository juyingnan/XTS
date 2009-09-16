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
>># File: tset/Xt13/XtGetSelectionRequest/XtGetSelectionRequest.m
>># 
>># Description:
>>#	Tests for XtGetSelectionRequest()
>># 
>># Modifications:
>># $Log: tgtsreque.m,v $
>># Revision 1.1  2005-02-12 14:37:57  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:38:11  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:12  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:29:14  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:25:47  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:21:40  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:17:42  andy
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

/* local functions */
static Boolean convert_proc1();
static void lose_proc1();
static void done_proc1();
static void requestor_callback1();

static void XtEVT1_handler1(sender_widget, client_data, event, continue_to_dispatch)
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
		 convert_proc1,
		 NULL,
		 done_proc1
		 );

	check_dec(True, status, "status");
}

static void XtEVT1_handler2(receiver_widget, client_data, event, continue_to_dispatch)
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
		requestor_callback1, 
		client_data,
		bevent->time
		);
}

static Boolean convert_proc1(w, selection, target, type_return, value_return,
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
	XSelectionRequestEvent *request;
	avs_set_event(1, 1);
	tet_infoline("TEST: Data returned from XtGetSelectionRequest");
	request = XtGetSelectionRequest(w, *selection, (XtRequestId)NULL);
	check_dec(SelectionRequest, request->type, "request->type");
	check_dec(SELECTION, request->selection, "request->selection");
	check_dec(TYPE, request->target, "request->target");
	check_dec(XtWindow(w), request->owner, "request->owner");
	exit(0);
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

/* local functions */
static Boolean convert_proc2();
static void lose_proc2();
static void done_proc2();
static void requestor_callback2();

void XtWMH_Proc(str1, str2, str3, str4, str5, car)
String str1, str2, str3, str4, *str5;
Cardinal *car;
{
	avs_set_event(2,1);
}

static void XtEVT2_handler1(sender_widget, client_data, event, continue_to_dispatch)
Widget sender_widget;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_dispatch;
{
XButtonEvent *bevent;
	Boolean status;

	bevent = (XButtonEvent *)event;
	status = XtOwnSelection(
		 sender_widget,
		 SELECTION,
		 bevent->time,
		 convert_proc2,
		 NULL,
		 done_proc2
		 );
	check_dec(True, status, "XtOwnSelection return value");
}

static void XtEVT2_handler2(receiver_widget, client_data, event, continue_to_dispatch)
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
		requestor_callback2, 
		client_data,
		bevent->time
		);
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
	
	char *data;
	XSelectionRequestEvent *request;
	avs_set_event(1, 1);
	tet_infoline("TEST: XtGetSelectionRequest returns NULL");
	request = XtGetSelectionRequest(topLevel, NULL, (XtRequestId)NULL);
	if (request != NULL) {
		tet_infoline("ERROR: XtGetSelectionRequest did not return NULL");
		tet_result(TET_FAIL);
	}
	exit(0);
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

static void requestor_callback2(w, client_data, selection, type, value, length, format)
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
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtGetSelectionRequest Xt13
XSelectionRequestEvent *
XtGetSelectionRequest(w, selection, request_id)
>>ASSERTION Good A
When called from an XtConvertSelectionProc procedure,
XSelectionRequestEvent *XtGetSelectionRequest(w, selection, request_id)
shall return a pointer to the SelectionRequest event 
for the widget
.A w,
identified by the selection
.A selection
and the requester id
.A request_id
that triggered the invocation of the 
XtConvertSelectionProc procedure.
>>CODE
Widget labelw_good;
pid_t pid2;
int invoked;

	FORK(pid2);
	avs_xt_hier("Tgtsreque1", "XtGetSelectionRequest");
	tet_infoline("PREP: Create labelw_good widget Hello");
	labelw_good = (Widget) CreateLabelWidget("Hello", boxw1);
	tet_infoline("PREP: Register event handler XtEVT1_handler1 to handle");
	tet_infoline("PREP: ButtonPress events to labelw_good widget");
	XtAddEventHandler(labelw_good,
		 ButtonPressMask,
		 False,
		 XtEVT1_handler1,
		 (Widget)NULL
		 );
	tet_infoline("PREP: Register event handler XtEVT1_handler2 to handle");
	tet_infoline("PREP: ButtonRelease events to boxw2 widget");
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
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Convert_proc procedure was invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "count of convert procedure invocations");
	tet_result(TET_PASS);
>>ASSERTION Good A
When 
.A selection
is an atomic selection owned by the specified widget and 
.A request_id
is NULL a call to
XSelectionRequestEvent *XtGetSelectionRequest(w, selection, request_id)
from an XtConvertSelectionProc procedure shall return the 
SelectionRequest event that caused the invocation of the 
XtConvertSelectionProc procedure.
>>CODE
Widget labelw_good;
pid_t pid2;
int invoked;

	FORK(pid2);
	avs_xt_hier("Tgtsreque1", "XtGetSelectionRequest");
	tet_infoline("PREP: Create labelw_good widget Hello");
	labelw_good = (Widget) CreateLabelWidget("Hello", boxw1);
	tet_infoline("PREP: Register event handler XtEVT1_handler1 to handle");
	tet_infoline("PREP: ButtonPress events to labelw_good widget");
	XtAddEventHandler(labelw_good,
		 ButtonPressMask,
		 False,
		 XtEVT1_handler1,
		 (Widget)NULL
		 );
	tet_infoline("PREP: Register event handler XtEVT1_handler2 to handle");
	tet_infoline("PREP: ButtonRelease events to boxw2 widget");
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
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Convert_proc procedure was invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "count of convert procedure invocations");
	tet_result(TET_PASS);
>>ASSERTION Good A
When no SelectionRequest event is being processed for the widget
.A w, 
selection
.A selection, 
and requester id
.A request_id 
a call to 
XSelectionRequestEvent *XtGetSelectionRequest(w, selection, request_id)
shall return NULL.
>>CODE
Widget labelw_good;
pid_t pid2;
int invoked;

	FORK(pid2);
	avs_xt_hier("Tgtsreque2", "XtGetSelectionRequest");
	XtAppSetWarningMsgHandler(app_ctext, XtWMH_Proc);
	tet_infoline("PREP: Create labelw_good widget Hello");
	labelw_good = (Widget) CreateLabelWidget("Hello", boxw1);
	tet_infoline("PREP: Register event handler XtEVT2_handler1 to handle");
	tet_infoline("PREP: ButtonPress events to labelw_good widget");
	XtAddEventHandler(labelw_good,
		 ButtonPressMask,
		 False,
		 XtEVT2_handler1,
		 (Widget)NULL
		 );
	tet_infoline("PREP: Register event handler XtEVT2_handler2 to handle");
	tet_infoline("PREP: ButtonRelease events to boxw2 widget");
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
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Convert_proc2 procedure was invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "invoked");
	tet_infoline("TEST: Warning handler is called");
	invoked = avs_get_event(2);
	check_dec(1, invoked, "calls to warning handler count");
	tet_result(TET_PASS);
