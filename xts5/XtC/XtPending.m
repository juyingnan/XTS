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
>># File: xts/XtC/XtPending.m
>># 
>># Description:
>>#	Tests for XtPending()
>># 
>># Modifications:
>># $Log: tpending.m,v $
>># Revision 1.1  2005-02-12 14:38:25  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:38:30  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:33  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:29:32  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.1  1998/01/28 21:40:56  andy
>># Changed reutrn type from XtInputMask to Boolean.  Changed test 1 to
>># only check for non-zero value (SR 159).
>>#
>># Revision 5.0  1998/01/26 03:26:05  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:22:38  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:19:15  andy
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
** XtTMO1_Proc
*/
void XtTMO1_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	tet_infoline("PREP: Generate some events");
	send_event(topLevel, KeyPress, KeyPressMask, TRUE );
	send_event(topLevel, KeyPress, KeyPressMask, TRUE );
}
/*
** XtTMO2_Proc
*/
void XtTMO2_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	/*
	** Queue should be empty at this point
	** KeyPress will wake up XtNextEvent, XtPending should then
	** find an empty queue.
	*/
	send_event(topLevel, KeyPress, KeyPressMask, TRUE);
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtPending XtC
XtInputMask
XtPending()
>>ASSERTION Good A
When the calling process
has at least one pending event from the X server 
or an alternate source a successful call to
Boolean XtPending() 
shall return a nonzero value.
>>CODE
pid_t pid2;
int pending, status = 0;
int type_event = 0;
XEvent loop_event;
Display *display;
Boolean processing;
int i;
pid_t pid3;
int pstatus;

	FORK(pid3);
	avs_xt_hier_def("Tpending1", "XtPending");
	FORK(pid2);
	tet_infoline("PREP: Register timeout");
	XtAddTimeOut(AVSXTLOOPTIMEOUT, XtTMO1_Proc, topLevel);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	display = XtDisplay(rowcolw);
	for (i = 0; i == 0;) {
		XtNextEvent( &loop_event);
		/*upon timeout we'll be sent two keypresses*/
		/*when the first appears see the second is pending*/
		if (loop_event.type == KeyPress) {
			processing = XtPending();
			avs_set_event(1, processing);
			exit(0);
		}
		XSync(display, False);
		XtDispatchEvent(&loop_event);
	} /*end for */
	LKROF(pid2, AVSXTTIMEOUT-4);
	KROF3(pid3, pstatus, AVSXTTIMEOUT-2);
        if (pstatus != 0) {
		tet_infoline("ERROR: Test process exited abnormally");
		tet_infoline("       May mean display cannot be opened");
		tet_result(TET_UNRESOLVED);
        }
	else {
		tet_infoline("TEST: XtPending returns non-zero value");
		status = avs_get_event(1);
		if (status == 0) {
			tet_infoline("Expected non-zero return from XtPending with events in the queue, received 0");
			tet_result(TET_FAIL);
		}
		tet_result(TET_PASS);
	}
>>ASSERTION Good A
When no events are pending for the calling 
process a call to
Boolean XtPending() 
shall flush the output buffers of every 
display in the calling process and return zero.
>>CODE
pid_t pid2;
int status;
XEvent loop_event;
Display *display;
Boolean processing;
int i;
pid_t pid3;
int pstatus;

	FORK(pid3);
	avs_xt_hier_def("Tpending2", "XtPending");
	FORK(pid2);
	tet_infoline("PREP: Register timeout");
	XtAddTimeOut(AVSXTLOOPTIMEOUT, XtTMO2_Proc, topLevel);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: With no events pending zero is returned");
	display = XtDisplay(rowcolw);
	for (i = 0; i == 0;) { /* Begin for */
		XtNextEvent(&loop_event);
		XSync(display, False);
		/*
		** no events in wait state: processing = 0
		*/
		if (loop_event.type == KeyPress) {
			processing = XtPending();
			avs_set_event(1, processing);
			exit(0);
		}
		XtDispatchEvent(&loop_event);
	} /*end for */
	LKROF(pid2, AVSXTTIMEOUT-4);
	KROF3(pid3, pstatus, AVSXTTIMEOUT-2);
        if (pstatus != 0) {
		tet_infoline("ERROR: Test process exited abnormally");
		tet_result(TET_UNRESOLVED);
        }
	else {
		status = avs_get_event(1);
		check_dec(0, status, "XtPending return when queue is empty");
		tet_result(TET_PASS);
	}
