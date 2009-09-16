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
>># File: xts/Xt10/XtAddCallbacks/XtAddCallbacks.m
>># 
>># Description:
>>#	Tests for XtAddCallbacks()
>># 
>># Modifications:
>># $Log: tadclbcks.m,v $
>># Revision 1.1  2005-02-12 14:37:49  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:37:17  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:00:13  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:28:23  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:57  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:19:06  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:13:26  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;

char client_stuff1[] = "This is client data";
char client_stuff2[] = "This is more client data";
/*
** Callback procedure
*/
void XtCBP1_Head(w, client_data, call_data)
Widget w;
XtPointer client_data, call_data;
{
	avs_set_event(1, 1);
	tet_infoline("TEST: client data sent correctly");
	if (client_data == NULL) {
		sprintf(ebuf, "ERROR: expected client_data of \"%s\", received NULL", client_stuff1);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	else {
		if (strcmp(client_data, client_stuff1) != 0) {
			sprintf(ebuf, "ERROR: expected client_data of \"%s\", received \"%s\"", client_stuff1, client_data);
			tet_infoline(ebuf);
			tet_result(TET_FAIL);
		}
	}
}

char client_stuff[] = "This is some client data";
/*
** Callback procedure
*/
void XtCBP2_Proc(w, client_data, call_data)
Widget w;
XtPointer client_data, call_data;
{
	avs_set_event(1,avs_get_event(1)+1);
	if (client_data != NULL) {
		avs_set_event(2,avs_get_event(2)+1);
		if (strcmp(client_stuff, client_data) != 0) {
			sprintf(ebuf, "ERROR: expected client_data of \"%s\", received \"%s\"", client_stuff, client_data);
			tet_infoline(ebuf);
			tet_result(TET_FAIL);
		}
	}
}
/*
** Callback procedure
*/
void XtCBP1_Tail(w, client_data, call_data)
Widget w;
XtPointer client_data, call_data;
{
	avs_set_event(2, 1);
	tet_infoline("TEST: client data sent correctly");
	if (client_data == NULL) {
		sprintf(ebuf, "ERROR: expected client_data of \"%s\", received NULL", client_stuff2);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	else {
		if (strcmp(client_data, client_stuff2) != 0) {
			sprintf(ebuf, "ERROR: expected client_data of \"%s\", received \"%s\"", client_stuff2, client_data);
			tet_infoline(ebuf);
			tet_result(TET_FAIL);
		}
	}
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtAddCallbacks Xt10
void
XtAddCallbacks(object, callback_name, callbacks)
>>ASSERTION Good A
A successful call to
void XtAddCallbacks(w, callback_name, callbacks)
shall add the list of callback procedures specified by
.A callbacks
to the widget
.A w's
callback list specified by
.A callback_name.
>>CODE
Widget labelw_good;
int head, tail;
XtCallbackRec callbacks[] = {
	{ (XtCallbackProc) XtCBP1_Head, client_stuff1},
	{ (XtCallbackProc) XtCBP1_Tail, client_stuff2},
	{ (XtCallbackProc) NULL, (XtPointer) NULL }
};
pid_t pid2;

	FORK(pid2)
	avs_xt_hier("Tadclbcks1", "XtAddCallbacks");
	tet_infoline("PREP: Create labelw_good widget in boxw1 widget");
	labelw_good = (Widget) CreateLabelWidget("Hello", boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Add a list of callback procedures to labelw_good widget");
	XtAddCallbacks(labelw_good,
			XtNdestroyCallback,
			&callbacks[0]
			);
	tet_infoline("PREP: Destroy labelw_good");
	XtDestroyWidget(labelw_good);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Callbacks were invoked");
	head = avs_get_event(1);
	tail = avs_get_event(2);
	check_dec(1, head, "XtCBP1_Head invoked status");
	check_dec(1, tail, "XtCBP1_Tail invoked status");
	tet_result(TET_PASS);
>>ASSERTION Good A
When a callback procedure occurs multiple times 
in the list of procedures added to the the widget
.A w's
callback list by a call to
void XtAddCallbacks(w, callback_name, callbacks)
it shall be invoked as many times as it occurs in 
the specified list.
>>CODE
Widget labelw_good;
int status = 0;
XtCallbackRec callbacks[] = {
	{ (XtCallbackProc) XtCBP2_Proc, (XtPointer)NULL},
	{ (XtCallbackProc) XtCBP2_Proc, client_stuff},
	{ (XtCallbackProc) XtCBP2_Proc, client_stuff},
	{ (XtCallbackProc) XtCBP2_Proc, (XtPointer)NULL},
	{ (XtCallbackProc) NULL, (XtPointer) NULL }
};
pid_t pid2;

	FORK(pid2)
	avs_xt_hier("Tadclbcks2", "XtAddCallbacks");
	tet_infoline("PREP: Create labelw_good widget Hello in boxw1 widget");
	labelw_good = (Widget) CreateLabelWidget("Hello", boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Add a list callback procedures to labelw_good widget");
	XtAddCallbacks(labelw_good,
			XtNdestroyCallback,
			&callbacks[0]
			);
	tet_infoline("PREP: Destroy labelw_good");
	XtDestroyWidget(labelw_good);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Callbacks were invoked and passed client_data");
	status = avs_get_event(1);
	check_dec(4, status, "times XtCBP2_Proc invoked");
	status = avs_get_event(2);
	check_dec(2, status, "times XtCBP2_Proc invoked with data");
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to
void XtAddCallbacks(w, callback_name, callbacks)
shall cause 
.A client_data
to be passed to the callback procedures specified by
.A callbacks
when they are invoked.
>>CODE
Widget labelw_good;
int head, tail;
XtCallbackRec callbacks[] = {
	{ (XtCallbackProc) XtCBP1_Head, client_stuff1},
	{ (XtCallbackProc) XtCBP1_Tail, client_stuff2},
	{ (XtCallbackProc) NULL, (XtPointer) NULL }
};
pid_t pid2;

	FORK(pid2)
	avs_xt_hier("Tadclbcks3", "XtAddCallbacks");
	tet_infoline("PREP: Create labelw_good widget in boxw1 widget");
	labelw_good = (Widget) CreateLabelWidget("Hello", boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Add a list of callback procedures to labelw_good widget");
	XtAddCallbacks(labelw_good,
			XtNdestroyCallback,
			&callbacks[0]
			);
	tet_infoline("PREP: Destroy labelw_good");
	XtDestroyWidget(labelw_good);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Callbacks were invoked");
	head = avs_get_event(1);
	tail = avs_get_event(2);
	check_dec(1, head, "XtCBP1_Head invoked status");
	check_dec(1, tail, "XtCBP1_Tail invoked status");
	tet_result(TET_PASS);
