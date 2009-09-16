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
$Header: /cvs/xtest/xtest/xts5/tset/Xt10/XtRemoveAllCallbacks/XtRemoveAllCallbacks.m,v 1.1 2005-02-12 14:37:50 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt10/XtRemoveAllCallbacks/XtRemoveAllCallbacks.m
>># 
>># Description:
>>#	Tests for XtRemoveAllCallbacks()
>># 
>># Modifications:
>># $Log: trmalcbks.m,v $
>># Revision 1.1  2005-02-12 14:37:50  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:37:19  mar
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
>># Revision 4.0  1995/12/15 09:19:09  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:13:30  andy
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
** XtCBP_ProcOne()
*/
XtCallbackProc XtCBP_ProcOne(w, client_data, call_data)
Widget w;
XtPointer client_data, call_data;
{
	sprintf(ebuf, "ERROR: Deleted Callback XtCBP_ProcOne invoked");
	tet_infoline(ebuf);
	tet_result(TET_FAIL);
}
/*
** XtCBP_ProcTwo()
*/
XtCallbackProc XtCBP_ProcTwo(w, client_data, call_data)
Widget w;
XtPointer client_data, call_data;
{
	sprintf(ebuf, "ERROR: Deleted Callback XtCBP_ProcTwo invoked");
	tet_infoline(ebuf);
	tet_result(TET_FAIL);
}
>>TITLE XtRemoveAllCallbacks Xt10
void
XtRemoveAllCallbacks(object, callback_name)
>>ASSERTION Good A
A successful call to 
void XtRemoveAllCallbacks(w, callback_name)
shall delete all callback procedures from the widget
.A w's
callback list specified by
.A callback_name.
>>CODE
Widget labelw_good;
XtCallbackRec callbacks[] = {
	{ (XtCallbackProc)XtCBP_ProcOne, (XtPointer) NULL },
	{ (XtCallbackProc)XtCBP_ProcTwo, (XtPointer) NULL },
	{ (XtCallbackProc) NULL, (XtPointer) NULL }
};
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Trmalcbks1", "XtRemoveAllCallbacks");
	tet_infoline("PREP: Create labelw_good widget Hello in boxw1 widget");
	labelw_good = (Widget) CreateLabelWidget("Hello", boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Add a list of destroy callback procedures to labelw_good widget");
	XtAddCallbacks(labelw_good,
			XtNdestroyCallback,
			&callbacks[0]
			);
	tet_infoline("PREP: Remove the callbacks from the list");
	XtRemoveAllCallbacks(labelw_good, XtNdestroyCallback);
	tet_infoline("TEST: Destroying the widget does not invoke functions");
	XtDestroyWidget(labelw_good);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good B 3
A successful call to 
void XtRemoveAllCallbacks(w, callback_name)
shall free all storage associated with the callback list
specified by
.A callback_name.
