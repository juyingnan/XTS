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
>># File: xts/XtC/XtAddWorkProc/XtAddWorkProc.m
>># 
>># Description:
>>#	Tests for XtAddWorkProc()
>># 
>># Modifications:
>># $Log: tadwkproc.m,v $
>># Revision 1.1  2005-02-12 14:38:24  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:38:31  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:35  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:29:33  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:26:07  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:22:42  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:19:21  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;

char client_stuff[] = "Four score and seven years ago";

void XtTMO_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
        exit(0);
}

Boolean XtWKP1_Proc4(client_data)
XtPointer client_data;
{
	avs_set_event(3, avs_get_event(1));
	exit(0);
}
Boolean XtWKP1_Proc3(client_data)
XtPointer client_data;
{
	avs_set_event(1,avs_get_event(1)+1);
	if (avs_get_event(1) == 1) {
		tet_infoline("PREP: Add work procedure from inside original one");
		XtAddWorkProc(XtWKP1_Proc4, client_stuff);

		return(False);
	}
	if (avs_get_event(1) == 5)
		return(True);

	return(False);
}
Boolean XtWKP1_Proc(client_data)
XtPointer client_data;
{
	avs_set_event(1,avs_get_event(1)+1);
	if (strcmp(client_data, client_stuff) != 0) {
		sprintf(ebuf, "ERROR: Expected client_data = \"%s\", received \"%s\"", client_stuff, client_data);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	if (avs_get_event(1) == 5)
		exit(0);
	else
		return(False);
}
Boolean XtWKP1_Proc6(client_data)
XtPointer client_data;
{
	avs_set_event(1,avs_get_event(1)+1);
	tet_infoline("TEST: Client_data passed correctly to handler");
	if (strcmp(client_data, client_stuff) != 0) {
		sprintf(ebuf, "ERROR: Expected client_data = \"%s\", received \"%s\"", client_stuff, client_data);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	exit(0);
}
Boolean XtWKP1_Proc2(client_data)
XtPointer client_data;
{
	avs_set_event(1,avs_get_event(1)+1);
	if (strcmp(client_data, client_stuff) != 0) {
		sprintf(ebuf, "ERROR: Expected client_data = \"%s\", received \"%s\"", client_stuff, client_data);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	if (avs_get_event(1) == 5)
		return(True);
	else
		return(False);
}
Boolean XtWKP2_Head(client_data)
XtPointer client_data;
{
	sprintf(ebuf, "ERROR: Unexpected invocation of XtWKP2_Head");
 	tet_infoline(ebuf);
	tet_result(TET_FAIL); 
	exit(0);
}
Boolean XtWKP2_Tail(client_data)
XtPointer client_data;
{
		avs_set_event(1,1);
		exit(0);
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtAddWorkProc XtC
XtWorkProcId
XtAddWorkProc(proc, client_data)
>>ASSERTION Good A
A successful call to 
XtWorkProcId XtAddWorkProc(proc, client_data)
shall register proc as the work procedure that 
will be called when the default application context for
the calling process waits for an event input, and return
a unique identifier for the work procedure.
>>CODE
pid_t pid2;
int status;
XEvent event;
Display *display;
int i;
pid_t pid3;
int pstatus;

	FORK(pid3);
	avs_xt_hier_def("Tadwkproc1", "XtAddWorkProc");
	FORK(pid2);
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Add work procedure XtWKP1_Proc");
	XtAddWorkProc(XtWKP1_Proc, client_stuff);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Work procedure is invoked");
	for (i = 0; i == 0;) {
		/*flag when NextEvent could block*/
	 	if (XtPending() == 0)
		avs_set_event(2, 1);
	 	XtNextEvent(&event);
	 	XSync(display, False);
	 	XtDispatchEvent(&event);
	} /* end for */
	LKROF(pid2, AVSXTTIMEOUT-4);
	KROF3(pid3, pstatus, AVSXTTIMEOUT-2);
        if (pstatus != 0) {
		tet_infoline("ERROR: Test process exited abnormally");
		tet_infoline("       May mean display cannot be opened");
		tet_result(TET_UNRESOLVED);
        }
	else {
		status = avs_get_event(1);
		check_dec(5, status, "XtWKP1_Proc invocations count");
		tet_infoline("TEST: XtNextEvent would have blocked");
		status = avs_get_event(2);
		check_dec(1, status, "XtNextEvent without events pending");
		tet_result(TET_PASS);
	}
>>ASSERTION Good A
When multiple procedures are registered by calls to
XtWorkProcId XtAddWorkProc(proc, client_data)
the most recently registered procedure shall be called.
>>CODE
pid_t pid2;
int status;
pid_t pid3;
int pstatus;

	FORK(pid3);
	avs_xt_hier_def("Tadwkproc2", "XtAddWorkProc");
	FORK(pid2);
	tet_infoline("PREP: Add work procedure XtWKP2_Head");
	XtAddWorkProc(XtWKP2_Head, (Widget)topLevel);
	tet_infoline("PREP: Add work procedure XtWKP2_Tail");
	XtAddWorkProc(XtWKP2_Tail, (Widget)topLevel);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Procedure XtWKP2_Tail was invoked");
	XtMainLoop();
	LKROF(pid2, AVSXTTIMEOUT-4);
	KROF3(pid3, pstatus, AVSXTTIMEOUT-2);
        if (pstatus != 0) {
		tet_infoline("ERROR: Test process exited abnormally");
		tet_result(TET_UNRESOLVED);
        }
	else {
		status = avs_get_event(1);
		check_dec(1, status, "XtWKP2_Tail invocations count");
		tet_result(TET_PASS);
	}
>>ASSERTION Good A
When a work procedure registered by a call to
XtWorkProcId XtAddWorkProc(proc, client_data)
returns True it shall be unregistered and not called when the 
default application context next waits for event input.
>>CODE
pid_t pid2;
int status;
XEvent event;
Display *display;
int i;
pid_t pid3;
int pstatus;

	FORK(pid3);
	avs_xt_hier_def("Tadwkproc1", "XtAddWorkProc");
	FORK(pid2);
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Add work procedure XtWKP1_Proc");
	XtAddWorkProc(XtWKP1_Proc2, client_stuff);
	XtAddTimeOut(AVSXTLOOPTIMEOUT, XtTMO_Proc, topLevel);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Work procedure is invoked until returns True");
	for (i = 0; i == 0;) {
		/*flag when NextEvent could block*/
	 	if (XtPending() == 0)
			avs_set_event(2, 1);
	 	XtNextEvent(&event);
	 	XSync(display, False);
	 	XtDispatchEvent(&event);
	} /* end for */
	LKROF(pid2, AVSXTTIMEOUT-4);
	KROF3(pid3, pstatus, AVSXTTIMEOUT-2);
        if (pstatus != 0) {
		tet_infoline("ERROR: Test process exited abnormally");
		tet_infoline("       May mean display cannot be opened");
		tet_result(TET_UNRESOLVED);
        }
	else {
		status = avs_get_event(1);
		check_dec(5, status, "XtWKP1_Proc invocations count");
		tet_infoline("TEST: XtNextEvent would have blocked");
		status = avs_get_event(2);
		check_dec(1, status, "XtNextEvent without events pending");
		tet_result(TET_PASS);
	}
>>ASSERTION Good A
When a work procedure registered by a call to
XtWorkProcId XtAddWorkProc(proc, client_data)
registers a work procedure the newly added procedure 
shall have lower priority.
>>CODE
pid_t pid2;
int status;
XEvent event;
Display *display;
int i;
pid_t pid3;
int pstatus;

	FORK(pid3);
	avs_xt_hier_def("Tadwkproc1", "XtAddWorkProc");
	FORK(pid2);
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Add work procedure");
	XtAddWorkProc(XtWKP1_Proc3, client_stuff);
	XtAddTimeOut(AVSXTLOOPTIMEOUT, XtTMO_Proc, topLevel);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	for (i = 0; i == 0;) {
		/*flag when NextEvent could block*/
	 	if (XtPending() == 0)
			avs_set_event(2, 1);
	 	XtNextEvent(&event);
	 	XSync(display, False);
	 	XtDispatchEvent(&event);
	} /* end for */
	LKROF(pid2, AVSXTTIMEOUT-4);
	KROF3(pid3, pstatus, AVSXTTIMEOUT-2);
        if (pstatus != 0) {
		tet_infoline("ERROR: Test process exited abnormally");
		tet_infoline("       May mean display cannot be opened");
		tet_result(TET_UNRESOLVED);
        }
	else {
		tet_infoline("TEST: Added work procedure not invoked until first unregistered");
		status = avs_get_event(1);
		check_dec(5, status, "Original work proc invocations count");
		status = avs_get_event(3);
		check_dec(5, status, "Original work proc invocations prior to invocation of second");
		tet_infoline("TEST: XtNextEvent would have blocked");
		status = avs_get_event(2);
		check_dec(1, status, "XtNextEvent without events pending");
		tet_result(TET_PASS);
	}
>>ASSERTION Good A
A successful call to
XtWorkProcId XtAddWorkProc(proc, client_data)
shall cause
.A client_data
to be passed to
.A proc 
when it is invoked.
>>CODE
pid_t pid2;
int status;
XEvent event;
Display *display;
int i;
pid_t pid3;
int pstatus;

	FORK(pid3);
	avs_xt_hier_def("Tadwkproc1", "XtAddWorkProc");
	FORK(pid2);
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Add work procedure XtWKP1_Proc");
	XtAddWorkProc(XtWKP1_Proc6, client_stuff);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Work procedure is invoked");
	for (i = 0; i == 0;) {
		/*flag when NextEvent could block*/
	 	if (XtPending() == 0)
		avs_set_event(2, 1);
	 	XtNextEvent(&event);
	 	XSync(display, False);
	 	XtDispatchEvent(&event);
	} /* end for */
	LKROF(pid2, AVSXTTIMEOUT-4);
	KROF3(pid3, pstatus, AVSXTTIMEOUT-2);
        if (pstatus != 0) {
		tet_infoline("ERROR: Test process exited abnormally");
		tet_infoline("       May mean display cannot be opened");
		tet_result(TET_UNRESOLVED);
        }
	else {
		status = avs_get_event(1);
		check_dec(1, status, "Work procedure invocations count");
		tet_infoline("TEST: XtNextEvent would have blocked");
		status = avs_get_event(2);
		check_dec(1, status, "XtNextEvent without events pending");
		tet_result(TET_PASS);
	}
