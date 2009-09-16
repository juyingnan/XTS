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

Copyright (c) 1999 The Open Group
Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/XtC/XtPeekEvent/XtPeekEvent.m
>># 
>># Description:
>>#	Tests for XtPeekEvent()
>># 
>># Modifications:
>># $Log: tpeekevnt.m,v $
>># Revision 1.2  2005-04-21 09:40:42  ajosey
>># resync to VSW5.1.5
>>#
>># Revision 8.3  2005/01/21 12:29:40  gwc
>># Updated copyright notice
>>#
>># Revision 8.2  1999/11/26 12:30:34  vsx
>># avoid fixed file locations (for exec-in-place false)
>>#
>># Revision 8.1  1999/11/24 11:34:29  vsx
>># TSD4.W.00162: avoid semctl ERANGE error on fast systems
>>#
>># Revision 8.0  1998/12/23 23:38:29  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:33  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:29:31  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.1  1998/02/24 02:49:16  andy
>># Made test2 contingent on coverage
>>#
>># Revision 5.0  1998/01/26 03:26:05  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.1  1998/01/15 22:01:43  andy
>># Changed type of processing variable to Boolean to match XtPending
>># signature (SR 156).
>>#
>># Revision 4.0  1995/12/15 09:22:37  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:19:13  andy
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

Widget topLevel;
Widget panedw, boxw1, boxw2;

XtInputId input_ret;
char *msg = "Hello World";
int acount = 0;
FILE *fid;

void XtIOP_Proc(client_data, source, id)
XtPointer client_data;
int *source;
XtInputId *id;
{
	avs_set_event(2, 1);
}

/*
** XtTMO1_Proc
*/
void XtTMO1_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	exit(0);
}
/*
** XtTMO2_Proc
*/
void XtTMO2_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	avs_set_event(1, 1);
}
/*
** XtTMO3_Proc
*/
void XtTMO3_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	/*
	** Send event KeyPress and wake up XtPeekEvent.
	*/
	send_event(topLevel, KeyPress, KeyPressMask, TRUE );
}
void XtTMO4_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
char *data;

	avs_set_event(1, 1);
	data = "data1";
	sprintf(ebuf, "PREP: Open file %s for read", data);
	tet_infoline(ebuf);
	if ((fid = (FILE *)fopen(data, "w+")) == NULL) {
		sprintf(ebuf, "ERROR: Could not open file %s", data);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Register file as an input source");
	input_ret = XtAddInput(fileno(fid), (XtPointer)XtInputReadMask, XtIOP_Proc, (XtPointer)msg);
	XtAddTimeOut(AVSXTLOOPTIMEOUT, XtTMO3_Proc, NULL);
}

>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtPeekEvent XtC
Boolean
XtPeekEvent(event_return)
>>ASSERTION Good A
When the calling process has at least one X 
event in the input queue a successful call to 
Boolean XtPeekEvent(event_return)
shall copy the event at the head of the input 
queue in event_return and return a non-zero value.
>>CODE
Widget labelw_msg;
char *msg = "Event widget";
XEvent loop_event, return_event;
Display *display;
Boolean status;
pid_t pid2;
int i;
pid_t pid3;
int pstatus;

	FORK(pid3);
	avs_xt_hier_def("Tpeekevnt1", "XtPeekEvent");
	FORK(pid2);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send KeyPress event over wire");
	send_event(boxw1, KeyPress, KeyPressMask, TRUE);
	tet_infoline("PREP: Register timeout");
	XtAddTimeOut(AVSXTLOOPTIMEOUT, XtTMO1_Proc, NULL);
	tet_infoline("TEST: XtPeekEvent will non-destructively report event");
	display = XtDisplay(boxw1);
	/*loop for events*/
	for (i = 0; i == 0;) {
		/*peek looking for the KeyPress we sent*/
		status = XtPeekEvent(&return_event);
		if (status == True) {
	 		if ( return_event.type == KeyPress ) {
				/*check peek was non-destructive*/
				XtNextEvent(&loop_event);
				XSync(display, False);
	 			XtDispatchEvent(&loop_event);
				if ( loop_event.type != KeyPress ) {
	 				sprintf(ebuf, "ERROR: Peek removed event");
					tet_infoline(ebuf);
					tet_result(TET_FAIL);
				}
				exit(0);
			}
			else {
				XtNextEvent(&loop_event);
				XSync(display, False);
	 			XtDispatchEvent(&loop_event);
			}
		}
		else {
		XtNextEvent(&loop_event);
		XSync(display, False);
	 	XtDispatchEvent(&loop_event);
		}
	} /* end for */
	LKROF(pid2, AVSXTTIMEOUT-4);
	KROF3(pid3, pstatus, AVSXTTIMEOUT-2);
        if (pstatus != 0) {
		tet_infoline("ERROR: Test process exited abnormally");
		tet_infoline("       May mean display cannot be opened");
		tet_result(TET_UNRESOLVED);
        }
	else 
		tet_result(TET_PASS);
>>ASSERTION Good A
When the calling process has no X event in the input queue a call to 
Boolean XtPeekEvent(event_return)
shall flush the output buffers of every display 
in the calling process, block until an event is 
available on the queue, copy the event in
.A event_return,
and return a non-zero value if the event is an X event.
>>CODE
Boolean status;
pid_t pid2;
int waited = 0;
XEvent loop_event, return_event;
Display *display;
Boolean processing;
int i;
pid_t pid3;
int pstatus;

/*this test is in the process of review vis consistency of the spec,
test suite, and sample code*/
if (config.coverage == 0) {
	FORK(pid3);
	avs_xt_hier_def("Tpeekevnt2", "XtPeekEvent");
	FORK(pid2);
	XtAddTimeOut(AVSXTLOOPTIMEOUT, XtTMO3_Proc, NULL);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Loop for events and check XtPeekEvent waited for it");
	/*this is a pretty weak test, but its not clear what a better*/
	/*test method would be*/
	display = XtDisplay(topLevel);
	for (i = 0; i == 0;) {
		processing = XtPending();
		/*this bit gives things time to settle down after the*/
		/*burst of events after the XtRealize. Ideally, this will*/
		/*cause the peek call to wait for the timeout event.*/
		/*If the user is moving the cursor or whatever, this*/
		/*may do the waking up instead, but it really*/
		/*doesn't matter*/
		if (processing == 0) {
			sleep(1);
			processing = XtPending();
		}
		/*no events*/
		if (processing == 0) {
			status = XtPeekEvent(&loop_event);
			/*if it comes back and there are events, it must*/
			/*have waited*/
			processing = XtPending();
			if (processing != 0) 
				break;
			else {
				sprintf(ebuf, "ERROR: XtPeekEvent returned, no events are pending");
				tet_infoline(ebuf);
				tet_result(TET_FAIL);
				exit(0);
			}
		}
		/*dispatch events until emptiness happiness*/
		XtNextEvent(&loop_event);
		XSync(display, False);
		XtDispatchEvent(&loop_event);
	}
	/*if it timed out, it never returned or the queue never emptied*/
	LKROF(pid2, AVSXTTIMEOUT-4);
	KROF3(pid3, pstatus, AVSXTTIMEOUT-2);
        if (pstatus != 0) {
		tet_infoline("ERROR: Test process exited abnormally");
		tet_result(TET_UNRESOLVED);
        }
	else
		tet_result(TET_PASS);
} else
		tet_result(TET_UNTESTED);
>>ASSERTION Good A
When a call to
Boolean XtPeekEvent(event_return)
blocks and input occurs for an alternate input source it
shall return zero.
>>CODE
Boolean status;
pid_t pid2;
int waited = 0;
XEvent loop_event, return_event;
Display *display;
int i;
pid_t pid3;
int pstatus;

	FORK(pid3);
	avs_xt_hier_def("Tpeekevnt3", "XtPeekEvent");
	FORK(pid2);
	XtAddTimeOut(AVSXTLOOPTIMEOUT, XtTMO4_Proc, NULL);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	display = XtDisplay(topLevel);
	/*dispatch events until the timeout starts the input source*/
	while (avs_get_event(1) == 0) {
		XtNextEvent(&loop_event);
		XSync(display, False);
		XtDispatchEvent(&loop_event);
	}
	tet_infoline("TEST: XtPeekEvent returns 0 for alternate input");
	status = XtPeekEvent(&loop_event);
	if (status != 0) {
		sprintf(ebuf, "ERROR: XtPeekEvent returned %s, expected 0", status);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	LKROF(pid2, AVSXTTIMEOUT-4);
	KROF3(pid3, pstatus, AVSXTTIMEOUT-2);
        if (pstatus != 0) {
		tet_infoline("ERROR: Test process exited abnormally");
		tet_result(TET_UNRESOLVED);
        }
	else {
		tet_result(TET_PASS);
	}
	unlink("data1");
