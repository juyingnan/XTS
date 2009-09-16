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
$Header: /cvs/xtest/xtest/xts5/tset/Xt9/XtRemoveTimeOut/XtRemoveTimeOut.m,v 1.1 2005-02-12 14:38:24 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt9/XtRemoveTimeOut/XtRemoveTimeOut.m
>># 
>># Description:
>>#	Tests for XtRemoveTimeOut()
>># 
>># Modifications:
>># $Log: trmtmout.m,v $
>># Revision 1.1  2005-02-12 14:38:24  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:36:59  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:59:52  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:28:05  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:40  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:18:05  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:11:16  andy
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
void XtTMO_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	sprintf(ebuf, "ERROR: Deleted procedure XtTMO_Proc was invoked");
	tet_infoline(ebuf);
	tet_result(TET_FAIL);
	exit(0);
}
/*
** XtTMO_ExitTest
*/
void XtTMO_ExitTest(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	exit(0);
}
>>TITLE XtRemoveTimeOut Xt9
void
XtRemoveTimeOut(id)
>>ASSERTION Good A
When the time interval specified in the last call to XtAppAddTimeout
has not since elapsed a call to 
void XtRemoveTimeOut(timer)
shall remove the timeout specified by the identifier timer.
>>CODE
XtIntervalId proc_id;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Trmtmout1", "XtRemoveTimeOut");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Add procedure XtTMO_ExitTest to be invoked after");
	tet_infoline("PREP: 4000 milliseconds to exit the test program");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT*2, XtTMO_ExitTest, topLevel);
	tet_infoline("PREP: Register timeout");
	proc_id = XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTMO_Proc, topLevel);
	tet_infoline("PREP: Remove the time out procedure XtTMO_Proc");
	XtRemoveTimeOut(proc_id);
	tet_infoline("TEST: XtTMO_Proc not invoked");
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	tet_result(TET_PASS);
