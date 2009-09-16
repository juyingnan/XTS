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
$Header: /cvs/xtest/xtest/xts5/tset/Xt12/XtRemoveActionHook/XtRemoveActionHook.m,v 1.1 2005-02-12 14:37:56 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt12/XtRemoveActionHook/XtRemoveActionHook.m
>># 
>># Description:
>>#	Tests for XtRemoveActionHook()
>># 
>># Modifications:
>># $Log: trmvachok.m,v $
>># Revision 1.1  2005-02-12 14:37:56  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:37:55  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:00:53  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:28:58  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:25:32  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:20:55  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:16:31  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;

void AvsWidAction(w, event, params, num_params)
Widget w;
XEvent *event;
String *params;
Cardinal *num_params;
{
	avs_set_event(2,1);
}
#define AVS_WID_ACTION "AvsWidAction"
XtActionsRec actions[] = {
	{AVS_WID_ACTION, AvsWidAction},
};
void XtAHP_Proc(widget, client_data,
	action_name, event, params, num_params)
Widget widget;
XtPointer client_data;
String action_name;
XEvent *event;
String *params;
Cardinal *num_params;
{
	avs_set_event(1, 1); 
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtRemoveActionHook Xt12
void
XtRemoveActionHook(id)
>>ASSERTION Good A
A successful call to 
void XtRemoveActionHook(id) 
shall remove the action hook procedure specified by 
.A id
from the list of action hook procedures for the application 
context in which it was registered by a prior call to
XtAppAddActionHook.
>>CODE
XEvent event;
XtActionHookId id;
int invoked = 0;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Trmvachok1", "XtRemoveActionHook");
	tet_infoline("PREP: Register action table with resource manager");
	XtAppAddActions(app_ctext, actions, XtNumber(actions) );
	tet_infoline("PREP: Add an action hook procedure XtAHP_Proc");
	id = (XtActionHookId) XtAppAddActionHook(app_ctext,
			 XtAHP_Proc, (XtPointer)NULL);
	tet_infoline("PREP: Remove procedure XtAHP_Proc");
	XtRemoveActionHook(id);
	tet_infoline("PREP: Invoke action procedure");
	XtCallActionProc(topLevel, AVS_WID_ACTION, &event, NULL, 0);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Procedure XtAHP_Proc was not invoked");
	invoked = avs_get_event(1);
	if (invoked) {
		sprintf(ebuf, "ERROR: Deleted procedure XtAHP_Proc was invoked");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Action Procedure was invoked");
	invoked = avs_get_event(2);
	if ( !invoked ) {
		sprintf(ebuf, "ERROR: Action procedure not invoked");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
