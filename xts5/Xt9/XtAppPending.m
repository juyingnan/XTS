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
>># File: xts/Xt9/XtAppPending.m
>># 
>># Description:
>>#	Tests for XtAppPending()
>># 
>># Modifications:
>># $Log: tappendng.m,v $
>># Revision 1.2  2005-04-21 09:40:42  ajosey
>># resync to VSW5.1.5
>>#
>># Revision 8.2  2005/01/21 12:22:35  gwc
>># Updated copyright notice
>>#
>># Revision 8.1  1999/11/26 11:17:42  vsx
>># avoid fixed file locations (for exec-in-place false)
>>#
>># Revision 8.0  1998/12/23 23:37:06  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:00:00  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:28:12  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:47  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:18:28  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:11:45  andy
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
FILE *fid;
/* Procedure XtIOP_Proc */
void XtIOP_Proc(client_data, source, id)
XtPointer client_data;
int *source;
XtInputId *id;
{
}
/*
** XtTMO_Proc
*/
void XtTMO1_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	send_event(topLevel, KeyPress, KeyPressMask, TRUE );
	send_event(topLevel, KeyPress, KeyPressMask, TRUE );
}
/*
** XtTMO_Proc
*/
void XtTMO2_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	/*
	** Queue should be empty at this point
	** KeyPress will wake up XtAppNextEvent, XtAppPending should then
	** find an empty queue.
	*/
	send_event(topLevel, KeyPress, KeyPressMask, TRUE);
}
void XtTMO3_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	exit(0);
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtAppPending Xt9
XtInputMask
XtAppPending(app_context)
>>ASSERTION Good A
When the application context specified by
.A app_context 
has at least one pending event from the X server a successful call to
XtInputMask XtAppPending(app_context) 
shall return a value that has the XtIMXEvent bit set.
>>CODE
pid_t pid2;
int pending, status = 0;
int type_event = 0;
XEvent loop_event;
Display *display;
XtInputMask processing;
int i;

	FORK(pid2);
	avs_xt_hier("Tappendng1", "XtAppPending");
	tet_infoline("PREP: Register timeout");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTMO1_Proc, topLevel);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: XtAppPending will return correct mask");
	display = XtDisplay(rowcolw);
	for (i = 1;i == 1;) {
		processing = XtAppPending(app_ctext);
		if (processing != 0) {
			if ((processing & XtIMXEvent) != 0) {
				if (XtAppPeekEvent(app_ctext, &loop_event) != True) {
					tet_infoline("ERROR: XtAppPending says event is pending but XtAppPeekEvent says not");
					tet_result(TET_FAIL);
					exit(0);
				}
					if (loop_event.type == KeyPress) {
						avs_set_event(2, 1);
					exit(0);
				}
			}
			if ((processing & XtIMTimer) != 0)
					avs_set_event(1, 1);
			XtAppNextEvent(app_ctext, &loop_event);
			XSync(display, False);
			XtDispatchEvent(&loop_event);
		}
	} /*end for */
	LKROF(pid2, AVSXTTIMEOUT-2);
	status = avs_get_event(1);
	check_dec(1, status, "reports of timeout");
	status = avs_get_event(2);
	check_dec(1, status, "reports of keypresses");
	tet_result(TET_PASS);
>>ASSERTION Good A
When the application context specified by
.A app_context 
has at least one pending timer a successful call to
XtInputMask XtAppPending(app_context) 
shall return a value that has the 
.S XtIMTimer 
bit set.
>>CODE
pid_t pid2;
int pending, status = 0;
int type_event = 0;
XEvent loop_event;
Display *display;
XtInputMask processing;
int i;

	FORK(pid2);
	avs_xt_hier("Tappendng1", "XtAppPending");
	tet_infoline("PREP: Register timeout");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTMO3_Proc, topLevel);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: XtAppPending will return correct mask");
	display = XtDisplay(rowcolw);
	for (i = 1;i == 1;) {
		processing = XtAppPending(app_ctext);
		if (processing != 0) {
			if ((processing & XtIMTimer) != 0) {
				avs_set_event(2, 1);
				exit(0);
			}
			XtAppNextEvent(app_ctext, &loop_event);
			XSync(display, False);
			XtDispatchEvent(&loop_event);
		}
	} /*end for */
	LKROF(pid2, AVSXTTIMEOUT-2);
	status = avs_get_event(2);
	check_dec(1, status, "reports of timeout");
	tet_result(TET_PASS);
>>ASSERTION Good A
When the application context specified by
.A app_context 
has at least one pending event from input sources other than 
the X server and timer a successful call to
XtInputMask XtAppPending(app_context) 
shall return a value that has the 
.S XtIMAlternateInput 
bit set.
>>CODE
pid_t pid2;
int pending, status = 0;
int type_event = 0;
XEvent loop_event;
Display *display;
XtInputMask processing;
int i;
const char *data;

	data = outfile("tappendng.dat");
	FORK(pid2);
	avs_xt_hier("Tappendng1", "XtAppPending");
	tet_infoline("PREP: Register timeout");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTMO3_Proc, topLevel);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	sprintf(ebuf, "PREP: Open file %s for read", data);
	tet_infoline(ebuf);
	if ((fid = (FILE *)fopen(data, "w+")) == NULL) {
		sprintf(ebuf, "ERROR: Could not open file %s", data);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("PREP: Register the file as input source");
	input_ret = XtAppAddInput(app_ctext, fileno(fid), (XtPointer)XtInputReadMask, XtIOP_Proc, (XtPointer)msg);
	tet_infoline("TEST: XtAppPending will return correct mask");
	display = XtDisplay(rowcolw);
	for (i = 1;i == 1;) {
		processing = XtAppPending(app_ctext);
		if (processing != 0) {
			if ((processing & XtIMAlternateInput) != 0) {
				avs_set_event(3, 1);
				exit(0);
			}
			XtAppNextEvent(app_ctext, &loop_event);
			XSync(display, False);
			XtDispatchEvent(&loop_event);
		}
	} /*end for */
	LKROF(pid2, AVSXTTIMEOUT-2);
	unlink(data);
	status = avs_get_event(3);
	check_dec(1, status, "reports of alternate input events");
	tet_result(TET_PASS);
>>ASSERTION Good A
When the application context specified by
.A app_context 
has pending events from more than one source
a call to
XtInputMask XtAppPending(app_context) 
shall return a value that is the logical OR of 
.S XtIMXEvent, 
.S XtIMTimer,
and 
.S XtIMAlternateInput 
bits corresponding to the pending event sources.
>>CODE
pid_t pid2;
int pending, status = 0;
int type_event = 0;
XEvent loop_event;
Display *display;
XtInputMask processing;
int i;
const char *data;

	data = outfile("tappendng.dat");
	FORK(pid2);
	avs_xt_hier("Tappendng1", "XtAppPending");
	tet_infoline("PREP: Register timeout");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTMO3_Proc, topLevel);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	sprintf(ebuf, "PREP: Open file %s for read", data);
	tet_infoline(ebuf);
	if ((fid = (FILE *)fopen(data, "w+")) == NULL) {
		sprintf(ebuf, "ERROR: Could not open file %s", data);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("PREP: Register the file as input source");
	input_ret = XtAppAddInput(app_ctext, fileno(fid), (XtPointer)XtInputReadMask, XtIOP_Proc, (XtPointer)msg);
	tet_infoline("PREP: Send keypress events");
	send_event(topLevel, KeyPress, KeyPressMask, TRUE );
	send_event(topLevel, KeyPress, KeyPressMask, TRUE );
	tet_infoline("TEST: XtAppPending will return correct mask");
	display = XtDisplay(rowcolw);
	for (i = 1;i == 1;) {
		processing = XtAppPending(app_ctext);
		if (processing != 0) {
			if ((processing & (XtIMXEvent|XtIMAlternateInput)) == (XtIMXEvent|XtIMAlternateInput)) {
				avs_set_event(2, 1);
				exit(0);
			}
			XtAppNextEvent(app_ctext, &loop_event);
			XSync(display, False);
			XtDispatchEvent(&loop_event);
		}
	} /*end for */
	LKROF(pid2, AVSXTTIMEOUT-2);
	unlink(data);
	status = avs_get_event(2);
	check_dec(1, status, "reports of both X and alternate input events");
	tet_result(TET_PASS);
>>ASSERTION Good A
When no events are pending for the application context specified by
.A app_context
a call to
XtInputMask XtAppPending(app_context)
shall flush the output buffers of every display in the application 
context and return zero.
>>CODE
pid_t pid2;
int status;
XEvent loop_event;
Display *display;
XtInputMask processing;
int i;

	FORK(pid2);
	avs_xt_hier("Tappendng2", "XtAppPending");
	tet_infoline("PREP: Register timeout");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTMO2_Proc, topLevel);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: With no events pending zero is returned");
	display = XtDisplay(rowcolw);
	for ( i = 0; i == 0;) { /* Begin for */
		XtAppNextEvent(app_ctext, &loop_event);
		XSync(display, False);
		/*
		** no events in wait state: processing = 0
		*/
		if (loop_event.type == KeyPress) {
		processing = XtAppPending(app_ctext);
		avs_set_event(1, processing);
		exit(0);
		}
		XtDispatchEvent(&loop_event);
	} /*end for */
	LKROF(pid2, AVSXTTIMEOUT-2);
	status = avs_get_event(1);
	check_dec(0, status, "return when queue is empty");
	tet_result(TET_PASS);
