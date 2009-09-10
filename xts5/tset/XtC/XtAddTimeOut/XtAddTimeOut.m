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
$Header: /cvs/xtest/xtest/xts5/tset/XtC/XtAddTimeOut/XtAddTimeOut.m,v 1.1 2005-02-12 14:38:24 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/XtC/XtAddTimeOut/XtAddTimeOut.m
>># 
>># Description:
>>#	Tests for XtAddTimeOut()
>># 
>># Modifications:
>># $Log: taddtmout.m,v $
>># Revision 1.1  2005-02-12 14:38:24  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:38:31  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:34  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:29:33  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:26:06  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:22:41  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:19:19  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;

void XtTMO_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	avs_set_event(1, 1);
	exit(0);
}
void XtTMO_Proc3(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	avs_set_event(2, avs_get_event(2)+1);
	exit(0);
}
void XtTMO_Proc2(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	avs_set_event(1, avs_get_event(1)+1);
	XtAddTimeOut(AVSXTLOOPTIMEOUT+2, XtTMO_Proc3, topLevel);
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtAddTimeOut XtC
XtIntervalId
XtAddTimeOut(interval, proc, client_data)
>>ASSERTION Good A
A successful call to
XtIntervalId XtAddTimeOut(interval, proc, client_data)
shall register proc as the procedure that will be 
called for the default application context of the
calling process after 
.A interval 
milliseconds have elapsed and return a unique 
identifier for it.
>>CODE
pid_t pid2;
int status = 0;
pid_t pid3;
int pstatus;

	FORK(pid3);
	avs_xt_hier_def("Taddtmout1", "XtAddTimeout");
	FORK(pid2);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Register timeout");
	XtAddTimeOut(AVSXTLOOPTIMEOUT, XtTMO_Proc, topLevel);
	tet_infoline("TEST: Loop for events and wait for timeout to be invoked");
	XtMainLoop();
	LKROF(pid2, AVSXTTIMEOUT-4);
	KROF3(pid3, pstatus, AVSXTTIMEOUT-2);
        if (pstatus != 0) {
		tet_infoline("ERROR: Test process exited abnormally");
		tet_infoline("       May mean display cannot be opened");
		tet_result(TET_UNRESOLVED);
        }
	else {
		tet_infoline("TEST: Timeout procedure was invoked");
		status = avs_get_event(1);
		check_dec(1, status, "XtTMO_Proc invocations count");
		tet_result(TET_PASS);
	}
>>ASSERTION Good A
The timeout registered by a call to
XtIntervalId XtAddTimeOut(interval, proc, client_data)
shall be removed after the first invocation of the 
timeout procedure.
>>CODE
pid_t pid2;
int status = 0;
pid_t pid3;
int pstatus;

	FORK(pid3);
	avs_xt_hier_def("Taddtmout1", "XtAddTimeout");
	FORK(pid2);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Register timeout");
	XtAddTimeOut(AVSXTLOOPTIMEOUT, XtTMO_Proc2, topLevel);
	tet_infoline("TEST: Loop for events and wait for timeout to be invoked");
	XtMainLoop();
	LKROF(pid2, AVSXTTIMEOUT-4);
	KROF3(pid3, pstatus, AVSXTTIMEOUT-2);
        if (pstatus != 0) {
		tet_infoline("ERROR: Test process exited abnormally");
		tet_infoline("       May mean display cannot be opened");
		tet_result(TET_UNRESOLVED);
        }
	else {
		tet_infoline("TEST: Timeout procedure was invoked just once");
		status = avs_get_event(1);
		check_dec(1, status, "XtTMO_Proc2 invocations count");
		status = avs_get_event(2);
		check_dec(1, status, "XtTMO_Proc3 invocations count");
		tet_result(TET_PASS);
	}
