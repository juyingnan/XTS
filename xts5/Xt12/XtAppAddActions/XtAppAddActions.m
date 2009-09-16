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
$Header: /cvs/xtest/xtest/xts5/tset/Xt12/XtAppAddActions/XtAppAddActions.m,v 1.1 2005-02-12 14:37:55 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt12/XtAppAddActions/XtAppAddActions.m
>># 
>># Description:
>>#	Tests for XtAppAddActions()
>># 
>># Modifications:
>># $Log: tapadactn.m,v $
>># Revision 1.1  2005-02-12 14:37:55  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:37:54  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:00:52  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:28:57  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:25:31  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:20:51  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:16:26  andy
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
void AvsWidAction(widget, event, params, num_params)
Widget widget;
XEvent *event;
String *params;
Cardinal *num_params;
{
	avs_set_event(1,1);
	tet_infoline("TEST: Widget passed correctly to action procedure");
	if (widget != boxw1) {
		sprintf(ebuf, "ERROR: Expected widget = %#x, received %#x", boxw1, widget);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Event is passed correctly to action proc");
	if (event->type != ButtonPress) {
		sprintf(ebuf, "ERROR: Expected ButtonPress event, received %s", event_names[event->type]);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	exit(0);
}
#define AVS_WID_ACTION "AvsWidAction"
XtActionsRec actions[] = {
	{AVS_WID_ACTION, AvsWidAction},
};
/*action procedure*/
void AvsWidAction2(widget, event, params, num_params)
Widget widget;
XEvent *event;
String *params;
Cardinal *num_params;
{
	tet_infoline("ERROR: Least recent action procedure was called");
	tet_result(TET_FAIL);
	exit(0);
}
#define AVS_WID_ACTION "AvsWidAction"
XtActionsRec actions2[] = {
	{AVS_WID_ACTION, AvsWidAction2}
};
XtActionsRec actions22[] = {
	{AVS_WID_ACTION, AvsWidAction}
};
XtActionsRec actions3[] = {
	{AVS_WID_ACTION, AvsWidAction},
	{AVS_WID_ACTION, AvsWidAction2},
};
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtAppAddActions Xt12
void
XtAppAddActions(app_context, actions, num_actions)
>>ASSERTION Good A
A successful call to
void XtAppAddActions(app_context, actions, num_actions)
shall register 
.A actions 
as the action table that will map procedure name strings to the
corresponding procedures for the application context 
.A app_context.
>>CODE
XEvent event;
int status;
pid_t pid2;
XtTranslations translations;
static char trans_good[] = "#replace	\n\
	 <BtnDown>:	AvsWidAction()";

	FORK(pid2);
	avs_xt_hier("Tapadactn1", "XtAppAddActions");
	tet_infoline("PREP: Register action table with resource manager");
	XtAppAddActions(app_ctext, actions, XtNumber(actions) );
	tet_infoline("PREP: Add translation into widget");
	translations = XtParseTranslationTable(trans_good);
	XtOverrideTranslations(boxw1, translations);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send ButtonPress event to invoke action");
	send_event(boxw1, ButtonPress, ButtonPressMask, TRUE);
	tet_infoline("TEST: Action procedure is invoked");
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	status = avs_get_event(1);
	check_dec(1, status, "action procedure invoked count");
	tet_result(TET_PASS);
>>ASSERTION Good A
Actions registered with 
void XtAppAddActions(app_context, actions, num_actions) can be
invoked with XtCallActionProc.
>>CODE
XEvent event;
int status;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tapadactn2", "XtAppAddActions");
	tet_infoline("PREP: Register action table with resource manager");
	XtAppAddActions(app_ctext, actions, XtNumber(actions) );
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Invoke action procedure");
	event.type = ButtonPress;
	XtCallActionProc(boxw1, AVS_WID_ACTION, &event,
			(String *)NULL, (Cardinal)0);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Action procedure is invoked");
	status = avs_get_event(1);
	check_dec(1, status, "action procedure invoked status");
	tet_result(TET_PASS);
>>ASSERTION Good A
When an action is registered with the same name by 
multiple calls to
void XtAppAddActions(app_context, actions, num_actions)
the most recently registered action shall override the rest.
>>CODE
XEvent event;
int status;
pid_t pid2;
XtTranslations translations;
static char trans_good[] = "#replace	\n\
	 <BtnDown>:	AvsWidAction()";

	FORK(pid2);
	avs_xt_hier("Tapadactn3", "XtAppAddActions");
	tet_infoline("PREP: Register action tables with resource manager");
	XtAppAddActions(app_ctext, actions2, XtNumber(actions2) );
	XtAppAddActions(app_ctext, actions22, XtNumber(actions22) );
	tet_infoline("PREP: Add translation into widget");
	translations = XtParseTranslationTable(trans_good);
	XtOverrideTranslations(boxw1, translations);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send ButtonPress event to invoke action");
	send_event(boxw1, ButtonPress, ButtonPressMask, TRUE);
	tet_infoline("TEST: Correct action procedure is invoked");
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	status = avs_get_event(1);
	check_dec(1, status, "action procedure invoked count");
	tet_result(TET_PASS);
>>ASSERTION Good A
When duplicate actions exist in an action table registered 
by a call to
void XtAppAddActions(app_context, actions, num_actions)
the first occurrence of the action in the table shall override
the rest.
>>CODE
XEvent event;
int status;
pid_t pid2;
XtTranslations translations;
static char trans_good[] = "#replace	\n\
	 <BtnDown>:	AvsWidAction()";

	FORK(pid2);
	avs_xt_hier("Tapadactn4", "XtAppAddActions");
	tet_infoline("PREP: Register action table with resource manager");
	XtAppAddActions(app_ctext, actions3, XtNumber(actions3) );
	tet_infoline("PREP: Add translation into widget");
	translations = XtParseTranslationTable(trans_good);
	XtOverrideTranslations(boxw1, translations);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send ButtonPress event to invoke action");
	send_event(boxw1, ButtonPress, ButtonPressMask, TRUE);
	tet_infoline("TEST: Correct action procedure is invoked");
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	status = avs_get_event(1);
	check_dec(1, status, "action procedure invoked count");
	tet_result(TET_PASS);
