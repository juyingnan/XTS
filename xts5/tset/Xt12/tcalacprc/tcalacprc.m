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
$Header: /cvs/xtest/xtest/xts5/tset/Xt12/tcalacprc/tcalacprc.m,v 1.1 2005-02-12 14:37:55 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt12/tcalacprc/tcalacprc.m
>># 
>># Description:
>>#	Tests for XtCallActionProc()
>># 
>># Modifications:
>># $Log: tcalacprc.m,v $
>># Revision 1.1  2005-02-12 14:37:55  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:38:04  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:04  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:29:07  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:25:40  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:21:20  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:17:03  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;

extern char *event_names[];

void AvsWidAction(w, event, params, num_params)
Widget w;
XEvent *event;
String *params;
Cardinal *num_params;
{
	avs_set_event(1,1);
}
#define AVS_WID_ACTION "AvsWidAction"
XtActionsRec actions[] = {
	{AVS_WID_ACTION, AvsWidAction},
};
void XtWMH_Proc(str1, str2, str3, str4, str5, car)
String str1, str2, str3, str4, *str5;
Cardinal *car;
{
	avs_set_event(1,1);
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtCallActionProc Xt12
void
XtCallActionProc(widget, action, event, params, num_params)
>>ASSERTION Good A
A call to 
void XtCallActionProc(widget, action, event, params, num_params)
shall search, in order, the action tables of the class of widget
.A widget
and all superclasses, in a subclass-to-superclass order, the widget 
parent's class and superclass, in a subclass-to-superclass order,
and all action tables registered with XtAppAddActions and 
XtAddActions from the most recently added table to the oldest table
for the first occurrence of the action procedure named
.A action
and invoke the procedure with the specified widget, the event 
pointer
.A event,
and the parameters specified by
.A params 
passed as arguments.
>>CODE
Cardinal num_actions = 3;
XEvent event;
int status;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tapadactn1", "XtCallActionProc");
	tet_infoline("PREP: Register action table with resource manager");
	XtAppAddActions(app_ctext, actions, XtNumber(actions));
	tet_infoline("PREP: Invoke action procedure");
	XtCallActionProc(topLevel, AVS_WID_ACTION, &event, NULL, 0);
	tet_infoline("TEST: Procedure was invoked");
	status = avs_get_event(1);
	check_dec(1, status, "invoked status");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
A call to 
void XtCallActionProc(widget, action, event, params, num_params)
when an action routine named
.A action
cannot be found in any action table shall generate a warning message.
>>CODE
XEvent event;
int status;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tapadactn2", "XtCallActionProc");
	tet_infoline("PREP: Register procedure handler to be called on non fatalconditions");
	XtAppSetWarningMsgHandler(app_ctext, XtWMH_Proc);
	tet_infoline("TEST: Warning handler is called");
	XtCallActionProc(labelw, "XtACT_NoProc", &event, (String *)NULL, (Cardinal)0);
	status = avs_get_event(1);
	check_dec(1, status, "XtWMH_Proc invoked status");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
