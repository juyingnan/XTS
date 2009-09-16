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
>># File: xts/Xt10/XtRemoveCallbacks/XtRemoveCallbacks.m
>># 
>># Description:
>>#	Tests for XtRemoveCallbacks()
>># 
>># Modifications:
>># $Log: trmcalbks.m,v $
>># Revision 1.1  2005-02-12 14:37:50  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:37:19  mar
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
>># Revision 4.0  1995/12/15 09:19:08  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:13:29  andy
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
** Callback to be invoked
*/
void XtCBP_ProcOne(w, client_data, call_data)
Widget w;
XtPointer client_data, call_data;
{
	avs_set_event(1, 1);
}
/*
** Callback not to be invoked
*/
void XtCBP_ProcTwo(w, client_data, call_data)
Widget w;
XtPointer client_data, call_data;
{
	sprintf(ebuf, "ERROR: Deleted callback XtCBP_ProcTwo invoked");
	tet_infoline(ebuf);
	tet_result(TET_FAIL);
}
/*
** Callback not to be invoked
*/
void XtCBP_ProcThree(w, client_data, call_data)
Widget w;
XtPointer client_data, call_data;
{
	sprintf(ebuf, "ERROR: Deleted Callback XtCBP_ProcThree invoked");
	tet_infoline(ebuf);
	tet_result(TET_FAIL);
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtRemoveCallbacks Xt10
void
XtRemoveCallbacks(object, callback_name, callbacks)
>>ASSERTION Good A
A successful call to
void XtRemoveCallbacks(w, callback_name, callbacks)
shall delete each entry from the widget
.A w's
callback list specified by
.A callback_name
whose callback procedure and client data
matches a callback/client data pair in the list specified by
.A callbacks.
>>CODE
Widget labelw_good;
int first = 0;
XtCallbackRec callbacks[] = {
	{ (XtCallbackProc)XtCBP_ProcOne, (XtPointer) NULL },
	{ (XtCallbackProc)XtCBP_ProcTwo, (XtPointer) NULL },
	{ (XtCallbackProc)XtCBP_ProcThree , (XtPointer) NULL },
	{ (XtCallbackProc) NULL, (XtPointer) NULL }
};
XtCallbackRec remove_list[] = {
	{ (XtCallbackProc)XtCBP_ProcTwo, (XtPointer) NULL },
	{ (XtCallbackProc)XtCBP_ProcThree, (XtPointer) NULL } ,
	{ (XtCallbackProc) NULL, (XtPointer) NULL }
};
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Trmcalbks1", "XtRemoveCallbacks");
	tet_infoline("PREP: Create labelw_good widget Hello in boxw1 widget");
	labelw_good = (Widget) CreateLabelWidget("Hello", boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Add a list of callback procedures to labelw_good widget");
	XtAddCallbacks(labelw_good,
			XtNdestroyCallback,
			&callbacks[0]
			);
	tet_infoline("PREP: Remove some of the callbacks form the list");
	XtRemoveCallbacks(labelw_good,
		 XtNdestroyCallback,
		 &remove_list[0]
		 );
	tet_infoline("PREP: labelw_good destroyed should not invoke the removed functions");
	XtDestroyWidget(labelw_good);
	tet_infoline("TEST: Only the callback not removed is invoked");
	first = avs_get_event(1);
	if (!first) {
		sprintf(ebuf, "ERROR: Function XtCBP_ProcOne was not invoked");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
