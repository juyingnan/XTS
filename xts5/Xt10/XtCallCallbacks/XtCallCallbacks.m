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
$Header: /cvs/xtest/xtest/xts5/tset/Xt10/XtCallCallbacks/XtCallCallbacks.m,v 1.1 2005-02-12 14:37:49 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt10/XtCallCallbacks/XtCallCallbacks.m
>># 
>># Description:
>>#	Tests for XtCallCallbacks()
>># 
>># Modifications:
>># $Log: tcalcbcks.m,v $
>># Revision 1.1  2005-02-12 14:37:49  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:37:20  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:00:15  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:28:25  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:59  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:19:11  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:13:32  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;

extern WidgetClass avsObjClass;
char client_stuff1[] = "Four score and seven years ago";
char client_stuff2[] = "The lazy brown dog";
char call_stuff[] = "My love she speaks like silence";

Widget labelw_good;

/*
** Procedure XtCBP_ProcOne
*/
void XtCBP_ProcOne(w, client_data, call_data)
Widget w;
XtPointer client_data;
XtPointer call_data;
{
	
	tet_infoline("TEST: Widget passed correctly");
	if (w != labelw_good) {
		tet_infoline("ERROR: Object not passed correctly");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Client_data passed correctly");
	if (client_data == NULL) {
		sprintf(ebuf, "ERROR: Expected client data = \"%s\", was NULL", client_stuff1);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	} else {
		if (strcmp(client_data, client_stuff1) != 0) {
			sprintf(ebuf, "ERROR: Expected client data = \"%s\", was \"%s\"", client_stuff1, client_data);
			tet_infoline(ebuf);
			tet_result(TET_FAIL);
		}
	}
	tet_infoline("TEST: Call_data passed correctly");
	if (call_data == NULL) {
		sprintf(ebuf, "ERROR: Expected call data = \"%s\", was NULL", call_stuff);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	} else {
		if (strcmp(call_data, call_stuff) != 0) {
			sprintf(ebuf, "ERROR: Expected call data = \"%s\", was \"%s\"", call_stuff, call_data);
			tet_infoline(ebuf);
			tet_result(TET_FAIL);
		}
	}
	avs_set_event(1, 1);
}
/*
** Procedure XtCBP_ProcTwo
*/
void XtCBP_ProcTwo(w, client_data, call_data)
Widget w;
XtPointer client_data;
XtPointer call_data;
{
	tet_infoline("TEST: Widget passed correctly");
	if (w != labelw_good) {
		tet_infoline("ERROR: Object not passed correctly");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Client_data passed correctly");
	if (client_data == NULL) {
		sprintf(ebuf, "ERROR: Expected client data = \"%s\", was NULL", client_stuff2);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	} else {
		if (strcmp(client_data, client_stuff2) != 0) {
			sprintf(ebuf, "ERROR: Expected client data = \"%s\", was \"%s\"", client_stuff2, client_data);
			tet_infoline(ebuf);
			tet_result(TET_FAIL);
		}
	}
	tet_infoline("TEST: Call_data passed correctly");
	if (call_data == NULL) {
		sprintf(ebuf, "ERROR: Expected call data = \"%s\", was NULL", call_stuff);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	} else {
		if (strcmp(call_data, call_stuff) != 0) {
			sprintf(ebuf, "ERROR: Expected call data = \"%s\", was \"%s\"", call_stuff, call_data);
			tet_infoline(ebuf);
			tet_result(TET_FAIL);
		}
	}
	avs_set_event(2, 1);
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtCallCallbacks Xt10
void
XtCallCallbacks(w, callback_name, call_data)
>>ASSERTION Good A
A successful call to 
void XtCallCallbacks(w, callback_name, call_data)
shall call each callback procedure in the widget
.A w's
callback list specified by
.A callback_name,
passing the client data registered with the procedure and
.A call_data
as arguments.
>>CODE
int first, second, third;
int call_data = 0;
XtCallbackRec callbacks[3] = {
	{ (XtCallbackProc)XtCBP_ProcOne, client_stuff1 },
	{ (XtCallbackProc)XtCBP_ProcTwo, client_stuff2},
	{ (XtCallbackProc) NULL,	 (XtPointer)NULL }
};
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tcalcbcks1", "XtCallCallbacks");
	tet_infoline("PREP: Create labelw_good widget in boxw1 widget");
	labelw_good = (Widget) CreateLabelWidget("Hello", boxw1);
	tet_infoline("PREP: Add callback procedure XtCBP_Proc to labelw_good");
	XtAddCallbacks(labelw_good,
			XtNdestroyCallback,
			&callbacks[0]
			);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Invoke callbacks");
	XtCallCallbacks(labelw_good, XtNdestroyCallback, call_stuff);
	tet_infoline("TEST: All procedures were invoked");
	first = avs_get_event(1);
	check_dec(1, first, "XtCBP_ProcOne invoked count");
	second = avs_get_event(2);
	check_dec(1, second, "XtCBP_ProcTwo invoked count");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
