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
>># File: xts/XtC/XtNextEvent/XtNextEvent.m
>># 
>># Description:
>>#	Tests for XtNextEvent()
>># 
>># Modifications:
>># $Log: tnxtevnt.m,v $
>># Revision 1.2  2005-04-21 09:40:42  ajosey
>># resync to VSW5.1.5
>>#
>># Revision 8.3  2005/01/21 12:28:54  gwc
>># Updated copyright notice
>>#
>># Revision 8.2  1999/11/26 12:23:41  vsx
>># avoid fixed file locations (for exec-in-place false)
>>#
>># Revision 8.1  1999/11/24 11:23:11  vsx
>># TSD4.W.00161: avoid semctl ERANGE error on fast systems
>>#
>># Revision 8.0  1998/12/23 23:38:28  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:32  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:29:30  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:26:04  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:22:33  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:19:09  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;
XtInputId input_ret;
char *msg = "Hello World";
int acount = 0;
FILE *fid;

/*
** XtTMO2_Proc
*/
void XtTMO2_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	send_event(topLevel, KeyPress, KeyPressMask, TRUE );
}

/*
** XtTMO3_Proc()
*/
void XtTMO3_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	avs_set_event(1, 1);
	exit(0);
	
}

static void analyse_events(quit)
Widget quit;
{
int i;
	Display *display;
	XEvent loop_event;
	XEvent event_return;
	Widget widget;
	widget = XtParent(quit);
	display = XtDisplay(widget);
	for (i = 0;i == 0;) {
	 	XNextEvent(display, &loop_event);
	 	XSync(display, False);
	 	if (loop_event.type == KeyPress) {
			/*
			** KeyRelease to follow KeyPress event.
			*/
			XtNextEvent(&loop_event);
			if ( loop_event.type == KeyRelease ) {
	 			XtDispatchEvent(&loop_event);
				exit(0);
			}
			else {
	 			sprintf(ebuf, "ERROR: Expected KeyRelease to Follow KeyPress");
				tet_infoline(ebuf);
				tet_result(TET_FAIL);
			}
	 }
	 XtDispatchEvent(&loop_event);
	} /* end for */
}
/*
** Procedure XtIOP_Proc
*/
void XtIOP_Proc(client_data, source, id)
XtPointer client_data;
int *source;
XtInputId *id;
{
	avs_set_event(2, 1);
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtNextEvent XtC
void
XtNextEvent(event_return)
>>ASSERTION Good A
When the calling process
has an X event in the input queue
a successful call to 
void XtNextEvent(event_return)
shall remove the X event from the head 
of the queue and return it in 
.A event_return .
>>CODE
Widget labelw_msg;
char *msg = "Event widget";
pid_t pid2;
pid_t pid3;
int pstatus;

	FORK(pid3);
	avs_xt_hier_def("Tnxtevnt1", "XtNextEvent");
	FORK(pid2);
	tet_infoline("PREP: Create a test labelw_msg widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send KeyPress and KeyRelease event over wire");
	send_event(labelw_msg, KeyPress, KeyPressMask, TRUE);
	send_event(labelw_msg, KeyRelease,KeyReleaseMask, TRUE);
	tet_infoline("TEST: XtNextEvent returns KeyRelease event after KeyPress event");
	analyse_events(click_quit);
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
When there are no events in the X input queue 
for the calling process a call to
void XtNextEvent(event_return)
shall flush the X output buffers of each 
display in the calling process and wait 
until an event from the X server is available.
>>CODE
pid_t pid2;
int waited = 0;
XEvent loop_event;
Display *display;
XtInputMask processing;
int i;
pid_t pid3;
int pstatus;

	FORK(pid3);
	avs_xt_hier_def("Tnxtevnt2", "XtNextEvent");
	FORK(pid2);
	tet_infoline("PREP: Register timeout");
	XtAddTimeOut(AVSXTLOOPTIMEOUT, XtTMO2_Proc, topLevel);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: XtNextEvent waits for next event");
	display = XtDisplay(rowcolw);
	for (i = 0; i == 0;) {
		XtNextEvent(&loop_event);
		XSync(display, False);
		XtDispatchEvent(&loop_event);
		/*
		** receiving events:	 proccessing = non zero
		** no events in wait state: processing = 0
		*/
		processing = XtPending();
		if (loop_event.type == KeyPress) {
			exit(0);
		}
		/*
		** No events XtNextEvent() waits for events.
		*/
		if (!processing)
			avs_set_event(1, 1);
	} /*end for */
	LKROF(pid2, AVSXTTIMEOUT-4);
	KROF3(pid3, pstatus, AVSXTTIMEOUT-2);
        if (pstatus != 0) {
		tet_infoline("ERROR: Test process exited abnormally");
		tet_result(TET_UNRESOLVED);
        }
	else {
		waited = avs_get_event(1);
		if (!waited) {
			sprintf(ebuf, "ERROR: XtNextEvent did not wait for the event");
			tet_infoline(ebuf);
			tet_result(TET_FAIL);
		}
		tet_result(TET_PASS);
	}
>>ASSERTION Good A
When a timeout occurs in the calling process
while  a call to 
void XtNextEvent(event_return)
is blocked the designated callback procedure for 
the timeout shall be called.
>>CODE
pid_t pid2;
int status = 0;
int waited = 0;
XEvent loop_event;
Display *display;
XtInputMask processing;
int i;
pid_t pid3;
int pstatus;

	FORK(pid3);
	avs_xt_hier_def("Tnxtevnt3", "XtNextEvent");
	FORK(pid2);
	tet_infoline("PREP: Register timeout");
	XtAddTimeOut(AVSXTLOOPTIMEOUT, XtTMO3_Proc, topLevel);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Procedure XtTMO3_Proc was invoked and XtNextEvent");
	tet_infoline("      indeed waited for next event");
	display = XtDisplay(topLevel);
	for (i = 0; i == 0;) {
		XtNextEvent(&loop_event);
		XSync(display, False);
		XtDispatchEvent(&loop_event);
	} /*end for*/
	LKROF(pid2, AVSXTTIMEOUT-4);
	KROF3(pid3, pstatus, AVSXTTIMEOUT-2);
        if (pstatus != 0) {
		tet_infoline("ERROR: Test process exited abnormally");
		tet_result(TET_UNRESOLVED);
        }
	else {
		status = avs_get_event(1);
		if (!status) {
			sprintf(ebuf, "ERROR: XtTMO3_Proc was not invoked");
			tet_infoline(ebuf);
			tet_result(TET_FAIL);
		}
		tet_result(TET_PASS);
	}
>>ASSERTION Good A
When input for an alternate input source occurs in the 
calling process while a call to 
void XtNextEvent(event_return)
is blocked the designated callback procedure 
for the input source shall be called.
>>CODE
pid_t pid2;
int status = 0;
int waited = 0;
XEvent loop_event;
Display *display;
XtInputMask processing;
int i;
pid_t pid3;
int pstatus;
char *data;

	FORK(pid3);
	avs_xt_hier_def("Tnxtevnt3", "XtNextEvent");
	data = "data1";
	sprintf(ebuf, "PREP: Open file %s for read", data);
	tet_infoline(ebuf);
	if ((fid = (FILE *)fopen(data, "w+")) == NULL) {
		sprintf(ebuf, "ERROR: Could not open file %s", data);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	FORK(pid2);
	tet_infoline("TEST: Register file as an input source");
	input_ret = XtAddInput(fileno(fid), (XtPointer)XtInputReadMask, XtIOP_Proc, (XtPointer)msg);
	tet_infoline("PREP: Register timeout");
	XtAddTimeOut(AVSXTLOOPTIMEOUT, XtTMO3_Proc, topLevel);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Callback for input is called");
	display = XtDisplay(topLevel);
	for (i = 0; i == 0;) {
		XtNextEvent(&loop_event);
		XSync(display, False);
		XtDispatchEvent(&loop_event);
	} /*end for*/
	LKROF(pid2, AVSXTTIMEOUT-4);
	unlink(data);
	KROF3(pid3, pstatus, AVSXTTIMEOUT-2);
        if (pstatus != 0) {
		tet_infoline("ERROR: Test process exited abnormally");
		tet_result(TET_UNRESOLVED);
        }
	else {
		status = avs_get_event(2);
		if (!status) {
			sprintf(ebuf, "ERROR: callback was not invoked");
			tet_infoline(ebuf);
			tet_result(TET_FAIL);
		}
		tet_result(TET_PASS);
	}
