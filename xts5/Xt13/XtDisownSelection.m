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
>># File: xts/Xt13/XtDisownSelection.m
>># 
>># Description:
>>#	Tests for XtDisownSelection()
>># 
>># Modifications:
>># $Log: tdisownsl.m,v $
>># Revision 1.1  2005-02-12 14:37:57  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:38:13  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:14  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:29:16  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:25:50  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:21:48  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:17:53  andy
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
static void requestor_callback();
static void requestor_callback2();

static void XtEVT_handler1(sender_widget, client_data, event, continue_to_dispatch)
Widget sender_widget;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_dispatch;
{
	Boolean status;
	XButtonEvent *bevent;

	bevent = (XButtonEvent *)event;

	avs_set_event(1, 1); 
	tet_infoline("PREP: Own selection");
	status = XtOwnSelection(
		 sender_widget,
		 SELECTION,
		 bevent->time,
		 convert_proc,
		 NULL,
		 NULL
		 );
	check_dec(True, status, "XtOwnSelection return value");
	tet_infoline("TEST: Disown selection");
	XtDisownSelection(sender_widget, SELECTION, CurrentTime); 
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

	avs_set_event(1, 1); 
	tet_infoline("PREP: Own selection");
	status = XtOwnSelection(
		 sender_widget,
		 SELECTION,
		 bevent->time,
		 convert_proc,
		 NULL,
		 NULL
		 );
	check_dec(True, status, "XtOwnSelection return value");
	tet_infoline("TEST: Disown selection");
	XtDisownSelection(sender_widget, SELECTION, CurrentTime); 
	tet_infoline("TEST: Disown selection again");
	XtDisownSelection(sender_widget, SELECTION, CurrentTime); 
}

static void XtEVT_handler1_3(sender_widget, client_data, event, continue_to_dispatch)
Widget sender_widget;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_dispatch;
{
	Boolean status;
	XButtonEvent *bevent;

	bevent = (XButtonEvent *)event;

	avs_set_event(1, 1); 
	tet_infoline("PREP: Own selection");
	status = XtOwnSelection(
		 sender_widget,
		 SELECTION,
		 bevent->time,
		 convert_proc,
		 NULL,
		 NULL
		 );
	check_dec(True, status, "XtOwnSelection return value");
	tet_infoline("TEST: Disown selection from non-owner widget");
	XtDisownSelection(topLevel, SELECTION, CurrentTime); 
}

static void XtEVT_handler2_3(receiver_widget, client_data, event, continue_to_dispatch)
Widget receiver_widget;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_dispatch;
{
	XButtonEvent *bevent;

	bevent = (XButtonEvent *)event;
	avs_set_event(2, 1); 
	tet_infoline("PREP: Get selection");
	XtGetSelectionValue(
		receiver_widget,
		SELECTION,
		TYPE,
		requestor_callback2, 
		client_data,
		bevent->time
		);
}

static void XtEVT_handler2(receiver_widget, client_data, event, continue_to_dispatch)
Widget receiver_widget;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_dispatch;
{
	XButtonEvent *bevent;

	bevent = (XButtonEvent *)event;
	avs_set_event(2, 1); 
	tet_infoline("PREP: Get selection");
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
convert_proc(w, selection, target, type_return, value_return,
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
	avs_set_event(3, 1);
	if ( *target == TYPE ) {
	*length_return = strlen(MSG) * sizeof(char);
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
	tet_infoline("TEST: Requestor callback not passed valid data");
	check_dec(SELECTION, *selection, "*selection");
	if (value != NULL) {
		tet_infoline("ERROR: Expected callback to get value of NULL");
		tet_result(TET_FAIL);
	}
	check_dec(0, *length, "*length");
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
	tet_infoline("TEST: Requestor callback passed valid data");
	check_dec(SELECTION, *selection, "*selection");
	check_dec(TYPE , *type, "*type");
	check_str(MSG, value, "*value");
	check_dec(strlen(MSG), *length, "*length");
	check_dec(FORMAT, *format, "*format");
}
void XtTMO_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	exit(0);
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtDisownSelection Xt13
void
XtDisownSelection(w, selection, time)
>>ASSERTION Good A
A successful call to 
void XtDisownSelection(w, selection, time) 
shall cause the widget
.A w
to lose ownership of the selection
.A selection.
>>CODE
Widget labelw_good;
pid_t pid2;
int invoked1, invoked2;
int invoked3;

	FORK(pid2);
	avs_xt_hier("Tdisownsl1", "XtDisownSelection");
	tet_infoline("PREP: Create labelw_good widget Hello");
	labelw_good = (Widget) CreateLabelWidget("Hello", boxw1);
	tet_infoline("PREP: Register button press event handler");
	XtAddEventHandler(labelw_good,
		 ButtonPressMask,
		 False,
		 XtEVT_handler1,
		 (Widget)NULL
		 );
	tet_infoline("PREP: Register button release event handler");
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
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTMO_Proc, NULL);
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Handlers were invoked");
	invoked1 = avs_get_event(1);
	check_dec(1, invoked1, "Handler 1 invocations count");
	invoked2 = avs_get_event(2);
	check_dec(1, invoked2, "Handler 1 invocations count");
	tet_infoline("TEST: Convert_proc was not invoked");
	invoked3 = avs_get_event(3);
	check_dec(0, invoked3, "Convert_proc invocations count");
	tet_result(TET_PASS);
>>ASSERTION Good A
A call to 
void XtDisownSelection(w, selection, time) 
when the widget
.A w
has already lost the ownership of the specified selection
shall not perform any action.
>>CODE
Widget labelw_good;
pid_t pid2;
int invoked1, invoked2;
int invoked3;

	FORK(pid2);
	avs_xt_hier("Tdisownsl1", "XtDisownSelection");
	tet_infoline("PREP: Create labelw_good widget Hello");
	labelw_good = (Widget) CreateLabelWidget("Hello", boxw1);
	tet_infoline("PREP: Register button press event handler");
	XtAddEventHandler(labelw_good,
		 ButtonPressMask,
		 False,
		 XtEVT_handler1_2,
		 (Widget)NULL
		 );
	tet_infoline("PREP: Register button release event handler");
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
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTMO_Proc, NULL);
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Handlers were invoked");
	invoked1 = avs_get_event(1);
	check_dec(1, invoked1, "Handler 1 invocations count");
	invoked2 = avs_get_event(2);
	check_dec(1, invoked2, "Handler 1 invocations count");
	tet_infoline("TEST: Convert_proc was not invoked");
	invoked3 = avs_get_event(3);
	check_dec(0, invoked3, "Convert_proc invocations count");
	tet_result(TET_PASS);
>>ASSERTION Good A
A call to 
void XtDisownSelection(w, selection, time) 
when the widget
.A w
is not the owner of the specified selection
shall not perform any action.
>>CODE
Widget labelw_good;
pid_t pid2;
int invoked1, invoked2;
int invoked3;

	FORK(pid2);
	avs_xt_hier("Tdisownsl1", "XtDisownSelection");
	tet_infoline("PREP: Create labelw_good widget Hello");
	labelw_good = (Widget) CreateLabelWidget("Hello", boxw1);
	tet_infoline("PREP: Register button press event handler");
	XtAddEventHandler(labelw_good,
		 ButtonPressMask,
		 False,
		 XtEVT_handler1_3,
		 (Widget)NULL
		 );
	tet_infoline("PREP: Register button release event handler");
	XtAddEventHandler(boxw2,
		 ButtonReleaseMask,
		 False,
		 XtEVT_handler2_3,
		 (Widget)NULL
		 );
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send ButtonPress event");
	send_event(labelw_good, ButtonPress, ButtonPressMask, FALSE);
	tet_infoline("PREP: Send ButtonRelease event");
	send_event(boxw2, ButtonRelease, ButtonReleaseMask, FALSE);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTMO_Proc, NULL);
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Handlers were invoked");
	invoked1 = avs_get_event(1);
	check_dec(1, invoked1, "Handler 1 invocations count");
	invoked2 = avs_get_event(2);
	check_dec(1, invoked2, "Handler 1 invocations count");
	tet_infoline("TEST: Convert_proc was invoked");
	invoked3 = avs_get_event(3);
	check_dec(1, invoked3, "Convert_proc invocations count");
	tet_result(TET_PASS);
>>ASSERTION Good B 3
After a call to 
void XtDisownSelection(w, selection, time) 
when a request for the value of the specified selection
arrives with a timestamp during the period that the widget
.A w
owned the selection the convert procedure shall not be called.
>>ASSERTION Good B 3
After a call to 
void XtDisownSelection(w, selection, time) 
when a selection request that started before the call to 
XtDisownSelection completes the XtSelectionDoneProc procedure for
the specified widget shall be called.
