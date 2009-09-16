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
$Header: /cvs/xtest/xtest/xts5/tset/Xt9/XtAppAddWorkProc/XtAppAddWorkProc.m,v 1.1 2005-02-12 14:38:24 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt9/XtAppAddWorkProc/XtAppAddWorkProc.m
>># 
>># Description:
>>#	Tests for XtAppAddWorkProc()
>># 
>># Modifications:
>># $Log: tapawkprc.m,v $
>># Revision 1.1  2005-02-12 14:38:24  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:37:10  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:00:04  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:28:16  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:51  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:18:41  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:12:02  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;

char client_stuff[] = "These are the times that try men's souls";

Boolean XtWKP_Proc(client_data)
XtPointer client_data;
{
int count;

	if (strcmp(client_data, client_stuff) != 0) {
		sprintf(ebuf, "ERROR: Expected client_data = %s, received %s", client_stuff, client_data);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}

	/*let it get called a few times*/
	count = avs_get_event(1);
	if (count == 10)
		exit(0);
	else {
		avs_set_event(1,++count);
		return False;
	}
}
Boolean XtWKP_Proc5(client_data)
XtPointer client_data;
{
int count;

	tet_infoline("TEST: client_data passed to work procedure");
	if (strcmp(client_data, client_stuff) != 0) {
		sprintf(ebuf, "ERROR: Expected client_data = %s, received %s", client_stuff, client_data);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}

	/*let it get called a few times*/
	count = avs_get_event(1);
	if (count == 10)
		exit(0);
	else {
		avs_set_event(1,++count);
		return False;
	}
}

Boolean XtWKP_Proc3(client_data)
XtPointer client_data;
{
int count;

	/*let it get called a few times*/
	count = avs_get_event(1);
	if (count < 5) {
		avs_set_event(1,++count);
		return False;
	}
	/*then no more*/
	else
		return True;
}

Boolean XtWKP_Head(client_data)
XtPointer client_data;
{
	Widget topLevel = (Widget) client_data;
	sprintf(ebuf, "ERROR: Unexpected invocation of XtWKP_Head");
	tet_infoline(ebuf);
	tet_result(TET_FAIL);
	exit(0);
}

Boolean XtWKP_Tail(client_data)
XtPointer client_data;
{
	Widget topLevel = (Widget) client_data;
	avs_set_event(1,1);
	exit(0);
}

/* procedure XtTMO_Proc to be invoked */
void XtTMO_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	exit(0);
}

Boolean XtWKP_Proc7(client_data)
XtPointer client_data;
{
	avs_set_event(2, avs_get_event(1));
	exit(0);
}
Boolean XtWKP_Proc6(client_data)
XtPointer client_data;
{
	avs_set_event(1, avs_get_event(1)+1);
	if (avs_get_event(1) == 1) {
		XtAppAddWorkProc(app_ctext, XtWKP_Proc7, client_stuff);
		return(False);
	}
	if (avs_get_event(1) == 5) {
		return(True);
	}
	return(False);
}
extern char *event_names[];

/*
** Registered procedure Proc
*/
void XtEVT_Proc(w, client_data, event, continue_to_dispatch)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_dispatch;
{
	return;
}

/* procedure XtTMO_Proc to be invoked */
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtAppAddWorkProc Xt9
XtWorkProcId
XtAppAddWorkProc(app_context, proc, client_data)
>>ASSERTION Good A
A successful call to 
XtWorkProcId XtAppAddWorkProc(app_context, proc, client_data)
shall register proc as the work procedure that will be called when 
the application_context specified by
.A app_context
waits for an event input and returns a unique identifier for the work 
procedure.
>>CODE
pid_t pid2;
int status;

	FORK(pid2);
	avs_xt_hier("Tapawkprc1", "XtAppAddWorkProc");
	tet_infoline("PREP: Add work procedure XtWKP_Proc");
	XtAppAddWorkProc(app_ctext, XtWKP_Proc, client_stuff);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Work procedure is invoked");
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	status = avs_get_event(1);
	check_dec(10, status, "XtWKP_Proc invoked count");
	tet_result(TET_PASS);
>>ASSERTION Good A
When multiple procedures are registered by calls to
XtWorkProcId XtAppAddWorkProc(app_context, proc, client_data)
the most recently registered procedure shall be called when
the specified application context waits for an event input.
>>CODE
pid_t pid2;
int status;

	FORK(pid2);
	avs_xt_hier("Tapawkprc2", "XtAppAddWorkProc");
	tet_infoline("PREP: Add work procedure XtWKP_Head");
	XtAppAddWorkProc(app_ctext, XtWKP_Head, (Widget)topLevel);
	tet_infoline("PREP: Add work procedure XtWKP_Tail");
	XtAppAddWorkProc(app_ctext, XtWKP_Tail, (Widget)topLevel);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Procedure XtWKP_Head not invoked");
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	status = avs_get_event(1);
	tet_infoline("TEST: Procedure XtWKP_Tail is invoked");
	check_dec(1, status, "XtWKP_Tail invoked count");
	tet_result(TET_PASS);
>>ASSERTION Good A
When a work procedure registered by a call to
XtWorkProcId XtAppAddWorkProc(app_context, proc, client_data)
returns True it shall be unregistered and not called when the 
specified application context next waits for event input.
>>CODE
pid_t pid2;
int status;

	FORK(pid2);
	avs_xt_hier("Tapawkprc1", "XtAppAddWorkProc");
	tet_infoline("PREP: Add work procedure XtWKP_Proc");
	XtAppAddWorkProc(app_ctext, XtWKP_Proc3, client_stuff);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Register timeout procedure");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTMO_Proc, topLevel);
	tet_infoline("TEST: Work procedure unregistered after returns True");
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	status = avs_get_event(1);
	check_dec(5, status, "XtWKP_Proc invoked count");
	tet_result(TET_PASS);
>>ASSERTION Good A
When a work procedure registered by a call to
XtWorkProcId XtAppAddWorkProc(app_context, proc, client_data)
registers a work procedure the newly added procedure shall have
lower priority.
>>CODE
pid_t pid2;
int status;

	FORK(pid2);
	avs_xt_hier("Tapawkprc1", "XtAppAddWorkProc");
	tet_infoline("PREP: Add work procedure");
	XtAppAddWorkProc(app_ctext, XtWKP_Proc6, client_stuff);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTMO_Proc, topLevel);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Second work procedure is not invoked until first in unregistered");
	status = avs_get_event(1);
	check_dec(5, status, "first procedure invocations count");
	status = avs_get_event(2);
	check_dec(5, status, "time first procedure was invoked before second");
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to
XtWorkProcId XtAppAddWorkProc(app_context, proc, client_data)
shall cause 
.A client_data
to be passed to
.A proc
when it is invoked.
>>CODE
pid_t pid2;
int status;

	FORK(pid2);
	avs_xt_hier("Tapawkprc1", "XtAppAddWorkProc");
	tet_infoline("PREP: Add work procedure");
	XtAppAddWorkProc(app_ctext, XtWKP_Proc5, client_stuff);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Work procedure is invoked");
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	status = avs_get_event(1);
	check_dec(10, status, "work procedure invocation count");
	tet_result(TET_PASS);
