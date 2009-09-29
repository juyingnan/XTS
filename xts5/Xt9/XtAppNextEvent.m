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
>># File: xts/Xt9/XtAppNextEvent.m
>># 
>># Description:
>>#	Tests for XtAppNextEvent()
>># 
>># Modifications:
>># $Log: tapnxevnt.m,v $
>># Revision 1.2  2005-04-21 09:40:42  ajosey
>># resync to VSW5.1.5
>>#
>># Revision 8.3  2005/01/21 12:21:49  gwc
>># Updated copyright notice
>>#
>># Revision 8.2  1999/12/03 12:20:52  vsx
>># missing display = XtDisplay(topLevel) in tp4
>>#
>># Revision 8.1  1999/11/26 11:06:17  vsx
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
>># Revision 5.0  1998/01/26 03:24:48  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:18:31  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:11:49  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;

extern char *event_names[] ;

/* procedure XtTMO1_Proc to be invoked */
void XtTMO1_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	exit(0);
}
/*
** XtTMO2_Procedure
*/
void XtTMO2_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	avs_set_event(2,1);	
	exit(0);
}
/*
** XtTMO3_Proc
*/
void XtTMO3_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	avs_set_event(1, 1);
	exit(0);
	
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
	avs_set_event(1,1);
	tet_infoline("TEST: InputID passed to procedure matches return from XtAddInput");
	if (*id != input_ret) {
		sprintf(ebuf, "ERROR: InputId passed to procedure was %#x, InputId returned by XtAddInput was %#x, should be identical", id, input_ret);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Source passed to procedure matches that passed to XtAddInput");
	if (*source != fileno(fid)) {
		sprintf(ebuf, "ERROR: Source passed to procedure was %#x, source passed to XtAddInput was %#x, should be identical", *source, fileno(fid));
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Client data passed to procedure matches that passed to XtAddInput");
	if (strncmp(client_data, msg, sizeof(msg)) != 0) {
		sprintf(ebuf, "ERROR: Client_data passed to procedure was %s, client_data passed to XtAddInput was %s, should be identical", client_data, msg);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	exit(0);
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtAppNextEvent Xt9
void
XtAppNextEvent(app_context, event_return)
>>ASSERTION Good A
When the application context specified by
.A app_context
has an X event in the input queue
a successful call to 
void XtAppNextEvent(app_context, event_return)
shall remove the X event from the head of the queue and return it in 
.A event_return .
>>CODE
char label[80];
Widget labelw_msg;
char *msg = "Event widget";
pid_t pid2;
int status;
Display *display;
XEvent loop_event;
Widget widget;
int i;

	FORK(pid2);
	avs_xt_hier("Tapnxevnt1", "XtAppNextEvent");
	tet_infoline("PREP: Create a test labelw_msg widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTMO1_Proc, topLevel);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Simulate KeyPress and KeyRelease event");
	send_event(labelw_msg, KeyPress, KeyPressMask, TRUE);
	send_event(labelw_msg,KeyRelease,KeyReleaseMask, TRUE);
	tet_infoline("TEST: Check XtAppNextEvent returns KeyRelease event after");
	tet_infoline("TEST: KeyPress event");
	display = XtDisplay(topLevel);
	for (i = 1; i == 1;) {
		XtAppNextEvent(app_ctext, &loop_event);
		XtDispatchEvent(&loop_event);
		if ( loop_event.type == KeyPress ) {
			/*
			** KeyRelease to follow KeyPress event.
			*/
			XtAppNextEvent(app_ctext, &loop_event);
			if (loop_event.type != KeyRelease ) {
	 			sprintf(ebuf, "ERROR: Expected KeyRelease, received %s", event_names[loop_event.type]);
				tet_infoline(ebuf);
				tet_result(TET_FAIL);
				exit(0);
			}
				avs_set_event(1, 1);
			exit(0);
	 	} /* end if KeyPress */
	 	XSync(display, False);
	} /* end for */
	LKROF(pid2, AVSXTTIMEOUT-2);
	status = avs_get_event(1);
	check_dec(1, status, "count of key releases received");
	tet_result(TET_PASS);
>>ASSERTION Good A
When there are no events in the X input queue for the specified 
application context a call to
void XtAppNextEvent(app_context, event_return)
shall flush the X output buffers of each display in the application 
context and wait until an event from the X server is available.
>>CODE
pid_t pid2;
int status = 0;
XEvent loop_event;
Display *display;
int i;

	FORK(pid2);
	avs_xt_hier("Tapnxevnt2", "XtAppNextEvent");
	tet_infoline("PREP: Register timeout");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTMO2_Proc, topLevel);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: XtAppNextEvent will wait and then wake up");
	display = XtDisplay(topLevel);
	for (i = 1; i == 1;) {
		if (!XtAppPending(app_ctext))
			avs_set_event(1,1);
		XtAppNextEvent(app_ctext, &loop_event);
		XSync(display, False);
		XtDispatchEvent(&loop_event);
	}
	LKROF(pid2, AVSXTTIMEOUT-2);
	status = avs_get_event(1);
	check_dec(1,status, "queue emptied");
	status = avs_get_event(2);
	check_dec(1,status, "events after queue emptied");
	tet_result(TET_PASS);
>>ASSERTION Good A
When a timeout occurs in the specified application context while  
a call to 
void XtAppNextEvent(app_context, event_return)
is blocked the designated callback procedure for the timeout 
shall be called.
>>CODE
pid_t pid2;
int status, waited;
XEvent loop_event;
Display *display;
XtInputMask processing;
int i;

	FORK(pid2);
	avs_xt_hier("Tapnxevnt3", "XtAppNextEvent");
	tet_infoline("PREP: Register timeout");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTMO3_Proc, topLevel);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Timeout is invoked");
	display = XtDisplay(topLevel);
	for (i = 1;i == 1;) {
		XtAppNextEvent(app_ctext, &loop_event);
		XSync(display, False);
		XtDispatchEvent(&loop_event);
	} /*end for*/
	LKROF(pid2, AVSXTTIMEOUT-2);
	status = avs_get_event(1);
	check_dec(1, status, "XtTMO3_Proc() invocation count");
	tet_result(TET_PASS);
>>ASSERTION Good A
When input from other source occurs in the specified application 
context while a call to 
void XtAppNextEvent(app_context, event_return)
is blocked the designated callback procedure for the input source 
shall be called.
>>CODE
char *data;
pid_t pid2;
int i;
int status, waited;
XEvent loop_event;
Display *display;
XtInputMask processing;

	data = "tapnxevnt.dat";
	FORK(pid2);
	avs_xt_hier("Tapnxevnt4", "XtAppNextEvent");
	sprintf(ebuf, "PREP: Open file %s for read", data);
	tet_infoline(ebuf);
	if ((fid = (FILE *)fopen(data, "w+")) == NULL) {
		sprintf(ebuf, "ERROR: Could not open file %s", data);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("PREP: Register the file as input source");
	input_ret = XtAppAddInput(app_ctext, fileno(fid), (XtPointer)XtInputReadMask, XtIOP_Proc, (XtPointer)msg);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTMO1_Proc, topLevel);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	display = XtDisplay(topLevel);
	for (i = 1;i == 1;) {
		XtAppNextEvent(app_ctext, &loop_event);
		XSync(display, False);
		XtDispatchEvent(&loop_event);
	} /*end for*/
	KROF(pid2);
	unlink(data);
	tet_infoline("TEST: Input procedure is invoked");
	status = avs_get_event(1);
	check_dec(1, status, "XtIOP_Proc invoked status");
	tet_result(TET_PASS);

