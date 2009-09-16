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
$Header: /cvs/xtest/xtest/xts5/tset/Xt9/XtAppAddTimeOut/XtAppAddTimeOut.m,v 1.1 2005-02-12 14:38:23 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt9/XtAppAddTimeOut/XtAppAddTimeOut.m
>># 
>># Description:
>>#	Tests for XtAppAddTimeOut()
>># 
>># Modifications:
>># $Log: tapatmout.m,v $
>># Revision 1.1  2005-02-12 14:38:23  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:36:58  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:59:51  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:28:05  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:39  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:18:04  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:11:14  andy
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

char *client_stuff = "once upon a time";

void XtTMO_Proc2(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	avs_set_event(1, 1);
	tet_infoline("TEST: client_data passed to procedure");
	if (client_data == NULL) {
		tet_infoline("ERROR: client_data is NULL");
		tet_result(TET_FAIL);
		exit(0);
	}
	if (strcmp((char *)client_data, client_stuff) != 0) {
		sprintf(ebuf, "ERROR: expected client_data of \"%s\", is\"%s\"", client_stuff, client_data);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	exit(0);
}
void XtTMO_Proc3(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	avs_set_event(2, 1);
	exit(0);
}
void XtTMO_Proc4(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT+2, XtTMO_Proc3, topLevel);
	avs_set_event(1, avs_get_event(1)+1);
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtAppAddTimeOut Xt9
XtIntervalId
XtAppAddTimeOut(app_context, interval, proc, client_data)
>>ASSERTION Good A
A successful call to
XtIntervalId XtAppAddTimeOut(app_context, interval, proc, client_data)
shall register proc as the procedure that will be called for the
application context
.A app_context
when the next 
call to XtAppNextEvent is made after 
.A interval 
milliseconds have elapsed.
>>CODE
pid_t pid2;
int status = 0;

	FORK(pid2);
	avs_xt_hier("Tapatmout1", "XtAppAddTimeOut");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Register timeout procedure");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTMO_Proc, topLevel);
	tet_infoline("TEST: Timeout procedure is invoked");
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	status = avs_get_event(1);
	check_dec(1, status, "XtTMO_Proc invoked status");
	tet_result(TET_PASS);
>>ASSERTION Good A
The timeout registered by a call to
XtIntervalId XtAppAddTimeOut(app_context, interval, proc, client_data)
shall be removed after the first invocation of the timeout procedure.
>>CODE
pid_t pid2;
int status = 0;

	FORK(pid2);
	avs_xt_hier("Tapatmout1", "XtAppAddTimeOut");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Register timeout procedure");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTMO_Proc4, topLevel);
	tet_infoline("TEST: Timeout procedure is invoked only once");
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	status = avs_get_event(1);
	check_dec(1, status, "timeout procedure invocation count");
	status = avs_get_event(2);
	check_dec(1, status, "second timeout procedure invocation count");
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to
XtIntervalId XtAppAddTimeOut(app_context, interval, proc, client_data)
shall cause 
.A client_data
to be passed to
.A proc
when it is invoked.
>>CODE
pid_t pid2;
int status = 0;

	FORK(pid2);
	avs_xt_hier("Tapatmout1", "XtAppAddTimeOut");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Register timeout procedure");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTMO_Proc2, client_stuff);
	tet_infoline("TEST: Timeout procedure is invoked");
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	status = avs_get_event(1);
	check_dec(1, status, "XtTMO_Proc2 invocation count");
	tet_result(TET_PASS);
