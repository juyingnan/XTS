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
$Header: /cvs/xtest/xtest/xts5/tset/Xt10/thscbacks/thscbacks.m,v 1.1 2005-02-12 14:37:49 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt10/thscbacks/thscbacks.m
>># 
>># Description:
>>#	Tests for XtHasCallbacks()
>># 
>># Modifications:
>># $Log: thscbacks.m,v $
>># Revision 1.1  2005-02-12 14:37:49  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:37:21  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:00:17  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:28:26  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:25:00  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:19:13  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:13:35  andy
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
** XtCBP1_Proc
*/
void XtCBP1_Proc(w, client_data, call_data)
Widget w;
XtPointer client_data, call_data;
{
}
>>TITLE XtHasCallbacks Xt10
XtCallbackStatus
XtHasCallbacks(widget, callback_name)
>>ASSERTION Good A
A call to 
XtCallbackStatus XtHasCallbacks(w, callback_name)
when the callback list specified by
.A callback_name
does not exist for the widget
.A w
shall return XtCallbackNoList.
>>CODE
Widget labelw_good;
XtCallbackStatus status;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Thscbacks1", "XtHasCallbacks");
	tet_infoline("PREP: Create labelw_good widget Hello in boxw1 widget");
	labelw_good = (Widget) CreateLabelWidget("Hello", boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Add callback XtCBP1_Proc to labelw_good widget");
	XtAddCallback(labelw_good,
			XtNdestroyCallback,
			XtCBP1_Proc,
			(XtPointer)NULL
			);
	tet_infoline("TEST: One call back in the list shall return XtCallbackHasSome");
	status = XtHasCallbacks(labelw_good, XtNdestroyCallback);
	check_dec(XtCallbackHasSome, status, "XtHasCallbacks");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
A call to 
XtCallbackStatus XtHasCallbacks(w, callback_name)
when the callback list specified by
.A callback_name
exists for the widget
.A w
and has no callbacks registered for it shall 
return XtCallbackHasNone.
>>CODE
Widget labelw_good;
XtCallbackStatus status;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Thscbacks2", "XtHasCallbacks");
	tet_infoline("PREP: Create labelw_good widget Hello in boxw1 widget");
	labelw_good = (Widget) CreateLabelWidget("Hello", boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: No call back in the list shall return XtCallbackHasNone");
	status = XtHasCallbacks(labelw_good, XtNdestroyCallback);
	check_dec(XtCallbackHasNone, status, "XtHasCallbacks");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
A call to 
XtCallbackStatus XtHasCallbacks(w, callback_name)
when the callback list specified by
.A callback_name
exists in the widget
.A w
and has at least one callback registered for it shall 
return XtCallbackHasSome.
>>CODE
#define XavsNotResource "bogus resource"
Widget labelw_good;
XtCallbackStatus status;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Thscbacks3", "XtHasCallbacks");
	tet_infoline("PREP: Create labelw_good widget Hello in boxw1 widget");
	labelw_good = (Widget) CreateLabelWidget("Hello", boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: The bogus resource XavsNotResource returns XtCallbackNoList");
	status = XtHasCallbacks(labelw_good, XavsNotResource);
	check_dec(XtCallbackNoList, status, "XtHasCallbacks");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
