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
$Header: /cvs/xtest/xtest/xts5/tset/Xt10/trmclback/trmclback.m,v 1.1 2005-02-12 14:37:50 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt10/trmclback/trmclback.m
>># 
>># Description:
>>#	Tests for XtRemoveCallback()
>># 
>># Modifications:
>># $Log: trmclback.m,v $
>># Revision 1.1  2005-02-12 14:37:50  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:37:18  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:00:14  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:28:24  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:58  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:19:07  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:13:27  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;

/*
** procedure XtCBP_Proc
*/
void XtCBP_Proc(w, client_data, call_data)
Widget w;
XtPointer client_data, call_data;
{
	sprintf(ebuf, "ERROR: Deleted Callback XtCBP_Proc was invoked");
	tet_infoline(ebuf);
	tet_result(TET_FAIL);
}
/*
** procedure XtCBP2_Proc
*/
void XtCBP2_Proc(w, client_data, call_data)
Widget w;
XtPointer client_data, call_data;
{
	avs_set_event(1, avs_get_event(1)+1);
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtRemoveCallback Xt10
void
XtRemoveCallback(object, callback_name, callback, client_data)
>>ASSERTION Good A
A successful call to
void XtRemoveCallback(w, callback_name, callback, client_data)
shall delete the procedure
.A callback
from the widget 
.A w's 
callback list specified by
.A callback_name
that was added to the list to be invoked with 
.A client_data
as the client data argument.
>>CODE
Widget labelw_good;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Trmclback1", "XtRemoveCallback");
	tet_infoline("PREP: Create labelw_good widget Hello in boxw1 widget");
	labelw_good = (Widget) CreateLabelWidget("Hello", boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Add a callback procedure to labelw_good widget");
	XtAddCallback(labelw_good,
			XtNdestroyCallback,
			XtCBP_Proc,
			(XtPointer)labelw_good
			);
	tet_infoline("PREP: Remove the procedure XtCBP_Proc from the list");
	XtRemoveCallback(labelw_good, XtNdestroyCallback,
		 XtCBP_Proc, (XtPointer)labelw_good );
	tet_infoline("TEST: labelw_good destroyed should not invoke callback");
	XtDestroyWidget(labelw_good);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
If the procedure callback and client_data do not match
function/data pair on the list, a call to
void XtRemoveCallback(w, callback_name, callback, client_data)
shall not delete the procedure from the
callback list identified by resource callback_name for w.
>>CODE
Widget labelw_good;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Trmclback1", "XtRemoveCallback");
	tet_infoline("PREP: Create labelw_good widget Hello in boxw1 widget");
	labelw_good = (Widget) CreateLabelWidget("Hello", boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Add a callback procedure to labelw_good widget");
	XtAddCallback(labelw_good,
			XtNdestroyCallback,
			XtCBP2_Proc,
			(XtPointer)labelw_good
			);
	tet_infoline("PREP: Remove the procedure XtCBP2_Proc from the list with other client data");
	XtRemoveCallback(labelw_good, XtNdestroyCallback,
		 XtCBP2_Proc, (XtPointer)topLevel );
	tet_infoline("TEST: labelw_good destroyed should invoke function");
	XtDestroyWidget(labelw_good);
	LKROF(pid2, AVSXTTIMEOUT-2);
	if (avs_get_event(1) == 0) {
		tet_infoline("ERROR: Callback was not invoked");
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
