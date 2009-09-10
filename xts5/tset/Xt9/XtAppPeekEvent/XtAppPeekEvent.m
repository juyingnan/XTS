Copyright (c) 2005 X.Org Foundation L.L.C.

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
$Header: /cvs/xtest/xtest/xts5/tset/Xt9/XtAppPeekEvent/XtAppPeekEvent.m,v 1.2 2005-04-21 09:40:42 ajosey Exp $

Copyright (c) 1999 The Open Group
Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt9/XtAppPeekEvent/XtAppPeekEvent.m
>># 
>># Description:
>>#	Tests for XtAppPeekEvent()
>># 
>># Modifications:
>># $Log: tappkevnt.m,v $
>># Revision 1.2  2005-04-21 09:40:42  ajosey
>># resync to VSW5.1.5
>>#
>># Revision 8.2  2005/01/21 12:23:22  gwc
>># Updated copyright notice
>>#
>># Revision 8.1  1999/11/26 11:21:35  vsx
>># avoid fixed file locations (for exec-in-place false)
>>#
>># Revision 8.0  1998/12/23 23:37:07  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:00:01  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:28:13  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.1  1998/02/24 02:49:48  andy
>># Made test 3 contingent on coverage
>>#
>># Revision 5.0  1998/01/26 03:24:47  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.1  1998/01/20 20:02:33  andy
>># Editorial
>>#
>># Revision 4.0  1995/12/15 09:18:29  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:11:47  andy
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
** XtTMO_Proc
*/
int timeout_called = 0;
void XtTMO_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	timeout_called++;
}

/*
** XtTMO_Proc
*/
void XtTMO3_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	/*
	** Send event KeyPress and wake up XtAppPeekEvent.
	*/
	send_event(topLevel, KeyPress, KeyPressMask, TRUE );
	send_event(topLevel, KeyPress, KeyPressMask, TRUE );
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTMO_Proc, topLevel);
}

XtInputId input_ret;
char *msg = "Hello World";
FILE *fid;
/* Procedure XtIOP_Proc */
void XtIOP_Proc(client_data, source, id)
XtPointer client_data;
int *source;
XtInputId *id;
{
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtAppPeekEvent Xt9
Boolean 
XtAppPeekEvent(app_context, event_return)
>>ASSERTION Good A
When the application context specified by
.A app_context
has at least one X event in the input queue
a successful call to 
Boolean XtAppPeekEvent(app_context, event_return)
shall copy the event at the head of the input queue in event_return 
and return 
.S True.
>>CODE
Widget labelw_msg;
char *msg = "Event widget";
XEvent loop_event, return_event;
Display *display;
int status;
pid_t pid2;
int i;

	avs_xt_hier("Tappkevnt1", "XtAppPeekEvent");
	tet_infoline("PREP: Create a test labelw_msg widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send KeyPress event over wire");
	send_event(labelw_msg, KeyPress, KeyPressMask, TRUE);
	tet_infoline("TEST: XtAppPeekEvenet will non-destructively report it");
	FORK(pid2);
	display = XtDisplay(rowcolw);
	/*loop for events*/
	for (i = 1;i == 1;) {
		/*peek looking for the KeyPress we sent*/
		status = XtAppPeekEvent(app_ctext, &return_event);
		if (status == True) {
	 		if ( return_event.type == KeyPress ) {
				/*check peek was non-destructive*/
				XtAppNextEvent(app_ctext, &loop_event);
				XSync(display, False);
				if ( loop_event.type == KeyPress )
					break;
				else {
	 				sprintf(ebuf, "ERROR: Peek removed event");
					tet_infoline(ebuf);
					tet_result(TET_FAIL);
					exit(0);
				}
			}
		}
		/*dispatch all the others*/
		XtAppNextEvent(app_ctext, &loop_event);
		XSync(display, False);
	 	XtDispatchEvent(&loop_event);
	} /* end for */
	LKROF(pid2, AVSXTTIMEOUT-2);
	XtDestroyWidget(topLevel);
	tet_result(TET_PASS);
>>ASSERTION Good A
When a call to
Boolean XtAppPeekEvent(app_context, event_return)
blocks for an event input and the event subsequently obtained is
an input from a source registered with XtAppAddInput it shall return 
.A False.
>>CODE
XtInputMask pstatus;
pid_t pid2;
XEvent loop_event, return_event;
Display *display;
XtInputMask processing;
Boolean status;
int i;
char *data;

	data = "tappkevnt.dat";
	avs_xt_hier("Tappkevnt2", "XtAppPeekEvent");
	tet_infoline("PREP: Register timeout");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTMO_Proc, topLevel);
	sprintf(ebuf, "PREP: Open file %s for read", data);
	tet_infoline(ebuf);
	if ((fid = (FILE *)fopen(data, "w+")) == NULL) {
		sprintf(ebuf, "ERROR: Could not open file %s", data);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("PREP: Register the file as input source");
	input_ret = XtAppAddInput(app_ctext, fileno(fid), (XtPointer)XtInputReadMask, XtIOP_Proc, (XtPointer)msg);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: XtAppPeekEvent returns false when encountering an input event");
	FORK(pid2);
	display = XtDisplay(topLevel);
	for (i = 1;i== 1;) {
		/*peek looking for the alternate input event*/
		status = XtAppPeekEvent(app_ctext, &return_event);
		if (status == FALSE) {
	 		if (return_event.type == 0) {
				/*check peek was non-destructive*/
				pstatus = XtAppPending(app_ctext);
				if ((pstatus & XtIMAlternateInput) != 0)
					exit(0);
				else {
	 				sprintf(ebuf, "ERROR: Peek removed event");
					tet_infoline(ebuf);
					tet_result(TET_FAIL);
					exit(0);
				}
			}
		}
		/*dispatch all the others*/
		XtAppNextEvent(app_ctext, &loop_event);
		XSync(display, False);
	 	XtDispatchEvent(&loop_event);
	}
	LKROF(pid2, AVSXTTIMEOUT-2);
	unlink(data);
	XtDestroyWidget(topLevel);
	tet_result(TET_PASS);
>>ASSERTION Good A
When the application context specified by
.A app_context
has no X event in the input queue
a call to 
Boolean XtAppPeekEvent(app_context, event_return)
shall flush the output buffers of every display in the application
context, block until an event is available on the queue, copy the
event in
.A event_return,
and return 
.S True 
if the event is an X event.
>>CODE
Boolean status;
pid_t pid2;
int waited = 0;
XEvent loop_event, return_event;
Display *display;
XtInputMask processing;
int i;

/*this test is in the process of review vis consistency of the spec,
test suite, and sample code*/
if (config.coverage == 0) {
	FORK(pid2);
	avs_xt_hier("Tappkevnt3", "XtAppPeekEvent");
	/*this will wake up the peek after 5 secs*/
	tet_infoline("PREP: Register timeout");
	XtAppAddTimeOut(app_ctext, 5000, XtTMO3_Proc, topLevel);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Loop for events and check XtAppPeekEvent waits for them");
	display = XtDisplay(topLevel);
	/*delay a little so events from the realize get generated*/
	sleep(2);

	for (i = 1; i == 1;) {
		/*wait until no events are pending*/
		processing = XtAppPending(app_ctext);
		if (processing == 0) {
			/*peek*/
			status = XtAppPeekEvent(app_ctext, &loop_event);
			
			/*it should only come back after waiting until
			an event arrives, make sure the event is
			still pending*/
			processing = XtAppPending(app_ctext);
			if (processing != 0) 
				exit(0);
			else {
				sprintf(ebuf, "ERROR: XtAppPeekEvent returned but no events are pending");
				tet_infoline(ebuf);
				tet_result(TET_FAIL);
				exit(0);
			}
		}
		/*keep dispatching events*/
		XtAppNextEvent(app_ctext, &loop_event);
		XSync(display, False);
		XtDispatchEvent(&loop_event);
	}
	/*if it timed out, it never returned or the queue never emptied*/
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
} else
	tet_result(TET_UNTESTED);
