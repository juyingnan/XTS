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
$Header: /cvs/xtest/xtest/xts5/tset/Xt12/XtAppAddActionHook/XtAppAddActionHook.m,v 1.1 2005-02-12 14:37:55 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt12/XtAppAddActionHook/XtAppAddActionHook.m
>># 
>># Description:
>>#	Tests for XtAppAddActionHook()
>># 
>># Modifications:
>># $Log: tapadachk.m,v $
>># Revision 1.1  2005-02-12 14:37:55  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:37:54  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:00:53  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:28:58  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:25:31  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:20:53  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:16:28  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;

#include <xt/SquareCelP.h>
extern char *event_names[];
char client_stuff[] = "These are the times that try men's souls";
int flag;
/*an action procedure*/
void AvsWidAction1(w, event, params, num_params)
Widget w;
XEvent *event;
String *params;
Cardinal *num_params;
{
	if (avs_get_event(1) == 0) {
		sprintf(ebuf, "ERROR: Action hook procedure was not called before action procedure");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	avs_set_event(2,1);
	exit(0);
}
#define AVS_WID_ACTION1 "AvsWidAction1"
XtActionsRec actions1[] = {
	{AVS_WID_ACTION1, AvsWidAction1},
};
/*an action hook procedure*/
void XtAHP1_Proc(widget, client_data, action_name, event, params, num_params)
Widget widget;
XtPointer client_data;
String action_name;
XEvent *event;
String *params;
Cardinal *num_params;
{
		avs_set_event(1, 1); 
		flag = 1;
	tet_infoline("TEST: Widget passed correctly to hook procedure");
	if (widget != boxw1) {
		sprintf(ebuf, "ERROR: Expected widget = %#x, received %#x", boxw1, widget);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Client_data passed correctly to hook procedure");
	if (client_data == NULL) {
		sprintf(ebuf, "ERROR: Expected client_data = \"%s\", received NULL", client_stuff);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	} else {
		if (strcmp(client_data, client_stuff) != 0) {
			sprintf(ebuf, "ERROR: Expected client_data = \"%s\", received \"%s\"", client_stuff, client_data);
			tet_infoline(ebuf);
			tet_result(TET_FAIL);
		}
	}
	tet_infoline("TEST: Action name is passed correctly to hook proc");
	if (strcmp(action_name, "AvsWidAction1") != 0) {
		sprintf(ebuf, "ERROR: Expected action_name = AvsWidAction1, received \"%s\"", action_name);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Event is passed correctly to hook proc");
	if (event->type != ButtonPress) {
		sprintf(ebuf, "ERROR: Expected ButtonPress event, received \"%s\"", event_names[event->type]);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
}

/*an action procedure*/
void AvsWidAction2(w, event, params, num_params)
Widget w;
XEvent *event;
String *params;
Cardinal *num_params;
{
	if (avs_get_event(1) == 0) {
		sprintf(ebuf, "ERROR: Action hook procedure was not called before action procedure");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	avs_set_event(2,1);
	exit(0);
}
#define AVS_WID_ACTION2 "AvsWidAction2"
XtActionsRec actions2[] = {
	{AVS_WID_ACTION2, AvsWidAction2},
};
/*an action hook procedure*/
void XtAHP2_Proc(widget, client_data, action_name, event, params, num_params)
Widget widget;
XtPointer client_data;
String action_name;
XEvent *event;
String *params;
Cardinal *num_params;
{
	avs_set_event(1, 1); 
	flag = 1;
	tet_infoline("TEST: Widget passed correctly to hook procedure");
	if (widget != boxw1) {
		sprintf(ebuf, "ERROR: Expected widget = %#x, received %#x", boxw1, widget);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Client_data passed correctly to hook procedure");
	if (client_data == NULL) {
		sprintf(ebuf, "ERROR: Expected client_data = \"%s\", received NULL", client_stuff);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	} else {
		if (strcmp(client_data, client_stuff) != 0) {
			sprintf(ebuf, "ERROR: Expected client_data = \"%s\", received \"%s\"", client_stuff, client_data);
			tet_infoline(ebuf);
			tet_result(TET_FAIL);
		}
	}
	tet_infoline("TEST: Action name is passed correctly to hook proc");
	if (strcmp(action_name, "AvsWidAction2") != 0) {
		sprintf(ebuf, "ERROR: Expected action_name = AvsWidAction2, received \"%s\"", action_name);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Event is passed correctly to hook proc");
	if (event->type != ButtonPress) {
		sprintf(ebuf, "ERROR: Expected ButtonPress event, received \"%s\"", event_names[event->type]);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
}
/*an action procedure*/
void AvsWidAction3(w, event, params, num_params)
Widget w;
XEvent *event;
String *params;
Cardinal *num_params;
{
	if (flag != 2) {
		sprintf(ebuf, "ERROR: Action hook procedures not called before action procedure");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	avs_set_event(1,1);
	exit(0);
}
#define AVS_WID_ACTION3 "AvsWidAction3"
XtActionsRec actions3[] = {
	{AVS_WID_ACTION3, AvsWidAction3},
};
/*another action hook procedure*/
void XtAHP3a_Proc(widget, client_data, action_name, event, params, num_params)
Widget widget;
XtPointer client_data;
String action_name;
XEvent *event;
String *params;
Cardinal *num_params;
{
		flag++;
		avs_set_event(3, flag); 
	tet_infoline("TEST: Widget passed correctly to hook procedure");
	if (widget != boxw1) {
		sprintf(ebuf, "ERROR: Expected widget = %#x, received %#x", boxw1, widget);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Action name is passed correctly to hook proc");
	if (strcmp(action_name, "AvsWidAction3") != 0) {
		sprintf(ebuf, "ERROR: Expected action_name = AvsWidAction3, received \"%s\"", action_name);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Event is passed correctly to hook proc");
	if (event->type != ButtonPress) {
		sprintf(ebuf, "ERROR: Expected ButtonPress event, received \"%s\"", event_names[event->type]);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
}
/*an action hook procedure*/
void XtAHP3_Proc(widget, client_data, action_name, event, params, num_params)
Widget widget;
XtPointer client_data;
String action_name;
XEvent *event;
String *params;
Cardinal *num_params;
{
	flag++;
	avs_set_event(2, flag); 
	tet_infoline("TEST: Widget passed correctly to hook procedure");
	if (widget != boxw1) {
		sprintf(ebuf, "ERROR: Expected widget = %#x, received %#x", boxw1, widget);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Action name is passed correctly to hook proc");
	if (strcmp(action_name, "AvsWidAction3") != 0) {
		sprintf(ebuf, "ERROR: Expected action_name = AvsWidAction3, received \"%s\"", action_name);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Event is passed correctly to hook proc");
	if (event->type != ButtonPress) {
		sprintf(ebuf, "ERROR: Expected ButtonPress event, received \"%s\"", event_names[event->type]);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
}
/*an action procedure*/
void AvsWidAction4(w, event, params, num_params)
Widget w;
XEvent *event;
String *params;
Cardinal *num_params;
{
	if (flag != 2) {
		sprintf(ebuf, "ERROR: Action hook procedures not called before action procedure");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	avs_set_event(1,1);
	exit(0);
}
#define AVS_WID_ACTION4 "AvsWidAction4"
XtActionsRec actions4[] = {
	{AVS_WID_ACTION4, AvsWidAction4},
};
/*an action hook procedure*/
void XtAHP4_Proc(widget, client_data, action_name, event, params, num_params)
Widget widget;
XtPointer client_data;
String action_name;
XEvent *event;
String *params;
Cardinal *num_params;
{
		flag++;
		avs_set_event(flag+1, 1); 
	tet_infoline("TEST: Widget passed correctly to hook procedure");
	if (widget != boxw1) {
		sprintf(ebuf, "ERROR: Expected widget = %#x, received %#x", boxw1, widget);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	if (client_data != NULL) {
		tet_infoline("TEST: Client_data passed correctly to hook procedure");
		if (strcmp(client_data, client_stuff) != 0) {
			sprintf(ebuf, "ERROR: Expected client_data = \"%s\", received \"%s\"", client_stuff, client_data);
			tet_infoline(ebuf);
			tet_result(TET_FAIL);
		}
	}
	tet_infoline("TEST: Action name is passed correctly to hook proc");
	if (strcmp(action_name, "AvsWidAction4") != 0) {
		sprintf(ebuf, "ERROR: Expected action_name = AvsWidAction4, received \"%s\"", action_name);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Event is passed correctly to hook proc");
	if (event->type != ButtonPress) {
		sprintf(ebuf, "ERROR: Expected ButtonPress event, received \"%s\"", event_names[event->type]);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
}
/*an action procedure*/
void AvsWidAction5(w, event, params, num_params)
Widget w;
XEvent *event;
String *params;
Cardinal *num_params;
{
	if (flag != 2) {
		sprintf(ebuf, "ERROR: Action hook procedures not called before action procedure");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	avs_set_event(1,1);
	exit(0);
}
#define AVS_WID_ACTION5 "AvsWidAction5"
XtActionsRec actions5[] = {
	{AVS_WID_ACTION5, AvsWidAction5},
};
/*an action hook procedure*/
void XtAHP5_Proc(widget, client_data, action_name, event, params, num_params)
Widget widget;
XtPointer client_data;
String action_name;
XEvent *event;
String *params;
Cardinal *num_params;
{
	flag++;
	avs_set_event(flag+1, 1); 
	tet_infoline("TEST: Widget passed correctly to hook procedure");
	if (widget != boxw1) {
		sprintf(ebuf, "ERROR: Expected widget = %#x, received %#x", boxw1, widget);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	if (client_data != NULL) {
		tet_infoline("TEST: Client_data passed correctly to hook procedure");
		if (strcmp(client_data, client_stuff) != 0) {
			sprintf(ebuf, "ERROR: Expected client_data = \"%s\", received \"%s\"", client_stuff, client_data);
			tet_infoline(ebuf);
			tet_result(TET_FAIL);
		}
	}
	tet_infoline("TEST: Action name is passed correctly to hook proc");
	if (strcmp(action_name, "AvsWidAction5") != 0) {
		sprintf(ebuf, "ERROR: Expected action_name = AvsWidAction5, received \"%s\"", action_name);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Event is passed correctly to hook proc");
	if (event->type != ButtonPress) {
		sprintf(ebuf, "ERROR: Expected ButtonPress event, received \"%s\"", event_names[event->type]);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtAppAddActionHook Xt12
XtActionHookId
XtAppAddActionHook(app, proc, client_data)
>>ASSERTION Good A
A successful call to
XtActionHookId XtAppAddActionHook(app, proc, client_data)
shall register 
.A proc
as the procedure that will be called just before any action 
procedure is dispatched in the application context 
.A app
and return an identifier for it.
>>CODE
Widget squarew;
XEvent event;
int status1, status2;
pid_t pid2;
XtTranslations translations;
static char trans_good[] = "#replace	\n\
 <BtnDown>:	AvsWidAction1()";

	FORK(pid2);
	avs_xt_hier("Tapadachk1", "XtAppAddActionHook");
	tet_infoline("PREP: Register action procedure with resource manager");
	XtAppAddActions(app_ctext, actions1, XtNumber(actions1));
	tet_infoline("PREP: Add translation into widget");
	translations = XtParseTranslationTable(trans_good);
	XtOverrideTranslations(boxw1, translations);
	tet_infoline("PREP: Add an action hook procedure");
	XtAppAddActionHook(app_ctext, XtAHP1_Proc, client_stuff);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send ButtonPress event to invoke action");
	send_event(boxw1, ButtonPress, ButtonPressMask, TRUE);
	tet_infoline("TEST: Action hook and action procedures are invoked");
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	status1 = avs_get_event(1);
	check_dec(1, status1, "XtAHP1_Proc invoked status");
	status2 = avs_get_event(2);
	check_dec(1, status2, "Action procedure invoked status");
	tet_result(TET_PASS);
>>ASSERTION Good A
A call to
XtActionHookId XtAppAddActionHook(app, proc, client_data)
shall register
.A proc 
as the procedure that will be called before an action procedure 
is invoked by a call to XtCallActionProc.
>>CODE
Widget squarew;
XEvent event;
int status1, status2;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tapadachk2", "XtAppAddActionHook");
	tet_infoline("PREP: Register action procedure with resource manager");
	XtAppAddActions(app_ctext, actions2, XtNumber(actions2));
	tet_infoline("PREP: Add an action hook procedure");
	XtAppAddActionHook(app_ctext, XtAHP2_Proc, client_stuff);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Invoke action procedure");
	event.type = ButtonPress;
	XtCallActionProc(boxw1, AVS_WID_ACTION2, &event,
			(String *)NULL, (Cardinal)0);
	tet_infoline("TEST: Action hook and action procedures are invoked");
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	status1 = avs_get_event(1);
	check_dec(1, status1, "XtAHP2_Proc invoked status");
	status2 = avs_get_event(2);
	check_dec(1, status2, "Action procedure invoked status");
	tet_result(TET_PASS);
>>ASSERTION Good A
When multiple action hook procedures have been registered 
for an application context by calls to
XtActionHookId XtAppAddActionHook(app, proc, client_data)
they shall be called in the reverse order of their registration.
>>CODE
Widget squarew;
XEvent event;
int status1, status2;
pid_t pid2;
XtTranslations translations;
static char trans_good[] = "#replace	\n\
	 <BtnDown>:	AvsWidAction3()";

	FORK(pid2);
	avs_xt_hier("Tapadachk3", "XtAppAddActionHook");
	tet_infoline("PREP: Register action procedure with resource manager");
	XtAppAddActions(app_ctext, actions3, XtNumber(actions3));
	tet_infoline("PREP: Add translation into widget");
	translations = XtParseTranslationTable(trans_good);
	XtOverrideTranslations(boxw1, translations);
	tet_infoline("PREP: Add an action hook procedure");
	XtAppAddActionHook(app_ctext, XtAHP3_Proc, client_stuff);
	tet_infoline("PREP: Add another action hook procedure");
	XtAppAddActionHook(app_ctext, XtAHP3a_Proc, client_stuff);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send ButtonPress event to invoke action");
	send_event(boxw1, ButtonPress, ButtonPressMask, TRUE);
	tet_infoline("TEST: Action hook and action procedures are invoked, order is correct");
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	status1 = avs_get_event(2);
	check_dec(2, status1, "invokation of first action hook proc");
	status1 = avs_get_event(3);
	check_dec(1, status1, "invokation of second action hook proc");
	status2 = avs_get_event(1);
	check_dec(1, status2, "Action procedure invoked status");
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to
XtActionHookId XtAppAddActionHook(app, proc, client_data)
shall cause 
.A client_data
to be passed to
.A proc
when it is invoked.
>>CODE
Widget squarew;
XEvent event;
int status1, status2;
pid_t pid2;
XtTranslations translations;
static char trans_good[] = "#replace	\n\
 <BtnDown>:	AvsWidAction1()";

	FORK(pid2);
	avs_xt_hier("Tapadachk1", "XtAppAddActionHook");
	tet_infoline("PREP: Register action procedure with resource manager");
	XtAppAddActions(app_ctext, actions1, XtNumber(actions1));
	tet_infoline("PREP: Add translation into widget");
	translations = XtParseTranslationTable(trans_good);
	XtOverrideTranslations(boxw1, translations);
	tet_infoline("PREP: Add an action hook procedure");
	XtAppAddActionHook(app_ctext, XtAHP1_Proc, client_stuff);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send ButtonPress event to invoke action");
	send_event(boxw1, ButtonPress, ButtonPressMask, TRUE);
	tet_infoline("TEST: Action hook and action procedures are invoked");
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	status1 = avs_get_event(1);
	check_dec(1, status1, "XtAHP1_Proc invoked status");
	status2 = avs_get_event(2);
	check_dec(1, status2, "Action procedure invoked status");
	tet_result(TET_PASS);
>>ASSERTION Good A
An action hook procedure registered multiple times
with a call to
XtActionHookId XtAppAddActionHook(app, proc, client_data)
with different client_data shall be called multiple times when an action is
dispatched.
>>CODE
Widget squarew;
XEvent event;
int status1, status2;
pid_t pid2;
XtTranslations translations;
static char trans_good[] = "#replace	\n\
	 <BtnDown>:	AvsWidAction4()";

	FORK(pid2);
	avs_xt_hier("Tapadachk4", "XtAppAddActionHook");
	tet_infoline("PREP: Register action procedure with resource manager");
	XtAppAddActions(app_ctext, actions4, XtNumber(actions4));
	tet_infoline("PREP: Add translation into widget");
	translations = XtParseTranslationTable(trans_good);
	XtOverrideTranslations(boxw1, translations);
	tet_infoline("PREP: Add an action hook procedure");
	XtAppAddActionHook(app_ctext, XtAHP4_Proc, client_stuff);
	tet_infoline("PREP: Add it again with other client_data");
	XtAppAddActionHook(app_ctext, XtAHP4_Proc, NULL);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send ButtonPress event to invoke action");
	send_event(boxw1, ButtonPress, ButtonPressMask, TRUE);
	tet_infoline("TEST: Action hook and action procedures are invoked, order is correct");
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	status1 = avs_get_event(2);
	check_dec(1, status1, "first invocation action hook proc");
	status1 = avs_get_event(3);
	check_dec(1, status1, "second invocation of action hook proc");
	status2 = avs_get_event(1);
	check_dec(1, status2, "invocation of action procedure");
	tet_result(TET_PASS);
>>ASSERTION Good A
An action hook procedure registered multiple times
with a call to
XtActionHookId XtAppAddActionHook(app, proc, client_data)
with the same client_data shall be called multiple times when an action is
dispatched.
>>CODE
Widget squarew;
XEvent event;
int status1, status2;
pid_t pid2;
XtTranslations translations;
static char trans_good[] = "#replace	\n\
	 <BtnDown>:	AvsWidAction5()";

	FORK(pid2);
	avs_xt_hier("Tapadachk5", "XtAppAddActionHook");
	tet_infoline("PREP: Register action procedure with resource manager");
	XtAppAddActions(app_ctext, actions5, XtNumber(actions5));
	tet_infoline("PREP: Add translation into widget");
	translations = XtParseTranslationTable(trans_good);
	XtOverrideTranslations(boxw1, translations);
	tet_infoline("PREP: Add an action hook procedure");
	XtAppAddActionHook(app_ctext, XtAHP5_Proc, client_stuff);
	tet_infoline("PREP: Add it again with the same client_data");
	XtAppAddActionHook(app_ctext, XtAHP5_Proc, client_stuff);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send ButtonPress event to invoke action");
	send_event(boxw1, ButtonPress, ButtonPressMask, TRUE);
	tet_infoline("TEST: Action hook and action procedures are invoked, order is correct");
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	status1 = avs_get_event(2);
	check_dec(1, status1, "first invocation action hook proc");
	status1 = avs_get_event(3);
	check_dec(1, status1, "second invocation of action hook proc");
	status2 = avs_get_event(1);
	check_dec(1, status2, "invocation of action procedure");
	tet_result(TET_PASS);
