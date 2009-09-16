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
>># File: xts/Xt9/XtRemoveWorkProc/XtRemoveWorkProc.m
>># 
>># Description:
>>#	Tests for XtRemoveWorkProc()
>># 
>># Modifications:
>># $Log: trmwkproc.m,v $
>># Revision 1.1  2005-02-12 14:38:24  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:37:11  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:00:05  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:28:17  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:51  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:18:43  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:12:04  andy
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
** XtTMO_ExitTest
*/
void XtTMO_ExitTest(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	exit(0);
}
Boolean XtWKP_Proc(client_data)
XtPointer client_data;
{
	sprintf(ebuf, "ERROR: Deleted procedure XtWKP_Proc should not be invoked.");
	tet_infoline(ebuf);
	tet_result(TET_FAIL);
}
>>TITLE XtRemoveWorkProc Xt9
void
XtRemoveWorkProc(id)
>>ASSERTION Good A
A successful call to 
void XtRemoveWorkProc(id) 
shall remove the work procedure 
registered by a prior call to XtAddWorkProc.
>>CODE
XtWorkProcId id;
pid_t pid2;
pid_t pid3;
int status;

	FORK(pid3);
	avs_xt_hier_def("Trmwkproc1", "XtRemoveWorkProc");
	tet_infoline("TEST: Add work procedure XtWKP_Proc");
	id = XtAddWorkProc(&XtWKP_Proc, (Widget)topLevel);
	tet_infoline("TEST: Remove the work procedure XtWKP_Proc");
	XtRemoveWorkProc(id);
	tet_infoline("TEST: Register timeout");
	XtAddTimeOut(AVSXTLOOPTIMEOUT, XtTMO_ExitTest, topLevel);
	tet_infoline("TEST: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	FORK(pid2);
	tet_infoline("TEST: XtMainLoop will not call the work proc");
	XtMainLoop();
	LKROF(pid2, AVSXTTIMEOUT-4);
        KROF3(pid3, status, AVSXTTIMEOUT-2)
        if (status != 0) {
		tet_infoline("ERROR: Test process exited abnormally");
		tet_infoline("       May mean display cannot be opened");
		tet_result(TET_UNRESOLVED);
        } else
		tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to 
void XtRemoveWorkProc(id) 
shall remove the work procedure registered by a prior 
call to XtAppAddWorkProc.
>>CODE
XtWorkProcId id;
pid_t pid2;

	avs_xt_hier("Trmwkproc2", "XtRemoveWorkProc");
	tet_infoline("TEST: Add work procedure XtWKP_Proc");
	id = XtAppAddWorkProc(app_ctext, &XtWKP_Proc, (Widget)topLevel);
	tet_infoline("TEST: Remove the work procedure XtWKP_Proc");
	XtRemoveWorkProc(id);
	tet_infoline("TEST: Register tiemout");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTMO_ExitTest, topLevel);
	tet_infoline("TEST: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	FORK(pid2);
	tet_infoline("TEST: XtAppMainLoop will not call the work proc");
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
