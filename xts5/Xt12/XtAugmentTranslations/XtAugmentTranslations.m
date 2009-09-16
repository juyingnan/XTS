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
>># File: tset/Xt12/XtAugmentTranslations/XtAugmentTranslations.m
>># 
>># Description:
>>#	Tests for XtAugmentTranslations()
>># 
>># Modifications:
>># $Log: taugtrtns.m,v $
>># Revision 1.1  2005-02-12 14:37:55  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:37:57  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:00:55  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:29:00  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:25:33  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:21:00  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:16:37  andy
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
XtActionProc XtACT1_Proc(w, event, params, num_params)
Widget w;
XEvent *event;
String *params;
Cardinal *num_params;
{
	if ( event->type == ButtonPress ) {
	avs_set_event(1,1);
	exit(0);
	}
	else {
	sprintf(ebuf, "ERROR: Expected ButtonPress event Received %s", event_names[event->type]);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
}
/*timeout callback*/
void XtTI1_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	exit(0);
}
/*
** Procedure XtACT2_Proc
*/
XtActionProc XtACT2_Proc(w, event, params, num_params)
Widget w;
XEvent *event;
String *params;
Cardinal *num_params;
{
	if ( event->type == ButtonPress ) {
	avs_set_event(1,1);
	exit(0);
	}
	else {
	sprintf(ebuf, "ERROR: Expected ButtonPress event Received %s", event_names[event->type]);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
}
/*timeout callback*/
void XtTI2_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	exit(0);
}
/*
** Procedure XtACT3_Proc
*/
XtActionProc XtACT3_Proc(w, event, params, num_params)
Widget w;
XEvent *event;
String *params;
Cardinal *num_params;
{
	if ( event->type == ButtonPress ) {
	avs_set_event(1,1);
	exit(0);
	}
	else {
	sprintf(ebuf, "ERROR: Expected ButtonPress event Received %s", event_names[event->type]);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
}
/*timeout callback*/
void XtTI3_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	exit(0);
}
/*
** Procedure XtACT4_Proc
*/
XtActionProc XtACT4_Proc(w, event, params, num_params)
Widget w;
XEvent *event;
String *params;
Cardinal *num_params;
{
	avs_set_event(1,1);
}
/*
** Procedure XtACT4a_Proc
*/
XtActionProc XtACT4a_Proc(w, event, params, num_params)
Widget w;
XEvent *event;
String *params;
Cardinal *num_params;
{
	avs_set_event(2,1);
}
/*timeout callback*/
void XtTI4_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	exit(0);
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtAugmentTranslations Xt12
void
XtAugmentTranslations(w, translations)
>>ASSERTION Good A
A call to 
void XtAugmentTranslations(w, translations)
shall nondestructively merge new translations into the widget w's existing
translations ignoring any #replace directive that may
have been specified in the translation string.
>>CODE
pid_t pid2;
int status;
XtTranslations translations;
static char trans_good1[] = "#replace	\n\
	 <BtnDown>:	XtACT1_Proc()";
static XtActionsRec actions1[] = {
	 {"XtACT1_Proc", (XtActionProc)XtACT1_Proc},
};

	FORK(pid2);
	avs_xt_hier("Taugtrtns1", "XtAugmentTranslations");
	tet_infoline("PREP: Add action table");
	XtAppAddActions(app_ctext, actions1, 1);
	tet_infoline("PREP: Parse translation table");
	translations = XtParseTranslationTable(trans_good1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Add new translations into boxw1 widget");
	XtAugmentTranslations(boxw1, translations);
	tet_infoline("PREP: Send ButtonPress event over wire to boxw1");
	send_event(boxw1, ButtonPress, ButtonPressMask, TRUE);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTI1_Proc, NULL);
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Translation occurs");
	status = avs_get_event(1);
	check_dec(1, status, "XtACT1_Proc invocation count");
	tet_result(TET_PASS);
>>ASSERTION Good A
A call to 
void XtAugmentTranslations(w, translations)
shall nondestructively merge new translations into the widget w's existing
translations ignoring any #augment directive that may
have been specified in the translation string.
>>CODE
pid_t pid2;
int status;
XtTranslations translations;
static char trans_good2[] = "#augment	\n\
	 <BtnDown>:	XtACT2_Proc()";
static XtActionsRec actions2[] = {
	 {"XtACT2_Proc",	(XtActionProc)XtACT2_Proc},
};

	FORK(pid2);
	avs_xt_hier("Taugtrtns2", "XtAugmentTranslations");
	tet_infoline("PREP: Add action table");
	XtAppAddActions(app_ctext, actions2, 1);
	tet_infoline("PREP: Parse translation table");
	translations = XtParseTranslationTable(trans_good2);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Add new translations into boxw1 widget");
	XtAugmentTranslations(boxw1, translations);
	tet_infoline("TEST: Send ButtonPress event over wire to boxw1");
	send_event(boxw1, ButtonPress, ButtonPressMask, TRUE);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTI2_Proc, NULL);
	tet_infoline("TEST: Translation occurs");
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	status = avs_get_event(1);
	check_dec(1, status, "XtACT2_Proc invocations count");
	tet_result(TET_PASS);
>>ASSERTION Good A
A call to void XtAugmentTranslations(w, translations)
shall nondestructively merge new translations into the widget w's existing
translations ignoring any #override directive that may
have been specified in the translation string.
>>CODE
pid_t pid2;
int status;
XtTranslations translations;
static char trans_good3[] = "#override	\n\
	 <BtnDown>:	XtACT3_Proc()";
static XtActionsRec actions3[] = {
	 {"XtACT3_Proc", (XtActionProc)XtACT3_Proc},
};

	FORK(pid2);
	avs_xt_hier("Taugtrtns3", "XtAugmentTranslations");
	tet_infoline("PREP: Add action table");
	XtAppAddActions(app_ctext, actions3, 1);
	tet_infoline("PREP: Parse translation table");
	translations = XtParseTranslationTable(trans_good3);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Add new translations into boxw1 widget");
	XtAugmentTranslations(boxw1, translations);
	tet_infoline("PREP: Send ButtonPress event over wire to boxw1");
	send_event(boxw1, ButtonPress, ButtonPressMask, TRUE);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTI3_Proc, NULL);
	tet_infoline("TEST: Translation occurs");
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	status = avs_get_event(1);
	check_dec(1, status, "XtACT3_Proc invoked status");
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to 
void XtAugmentTranslations(w, translations)
when 
.A translations
specifies an event or an event sequence that already exists in the
specified widget's translations shall ignore the new translation.
>>CODE
XtTranslations translations;
static char trans_good4[] = "<BtnDown>:	XtACT4_Proc()";
static XtActionsRec actions4[] = {
	 {"XtACT4_Proc", (XtActionProc)XtACT4_Proc},
	 {"XtACT4a_Proc", (XtActionProc)XtACT4a_Proc},
};
static char trans_good4a[] = "<BtnDown>:	XtACT4a_Proc()";
pid_t pid2;
int status;

	FORK(pid2);
	avs_xt_hier("Taugtrtns4", "XtAugmentTranslations");
	tet_infoline("PREP: Add action table");
	XtAppAddActions(app_ctext, actions4, 2);
	tet_infoline("PREP: Parse translation table");
	translations = XtParseTranslationTable(trans_good4);
	tet_infoline("PREP: Add new translations to widget");
	XtAugmentTranslations(boxw1, translations);
	tet_infoline("PREP: Parse translation table with refinition");
	translations = XtParseTranslationTable(trans_good4a);
	tet_infoline("PREP: Add new translations to widget");
	XtAugmentTranslations(boxw1, translations);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send ButtonPress event over wire to test_widget");
	send_event(boxw1, ButtonPress, ButtonPressMask, TRUE);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTI4_Proc, NULL);
	tet_infoline("TEST: Only original translation occurs");
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	status = avs_get_event(1);
	check_dec(1, status, "original translation count");
	status = avs_get_event(2);
	check_dec(0, status, "redefinition of translation count");
	tet_result(TET_PASS);
