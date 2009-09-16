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
$Header: /cvs/xtest/xtest/xts5/tset/Xt13/XtAppSetErrorMsgHandler/XtAppSetErrorMsgHandler.m,v 1.1 2005-02-12 14:37:57 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt13/XtAppSetErrorMsgHandler/XtAppSetErrorMsgHandler.m
>># 
>># Description:
>>#	Tests for XtAppSetErrorMsgHandler()
>># 
>># Modifications:
>># $Log: tapstermh.m,v $
>># Revision 1.1  2005-02-12 14:37:57  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:38:19  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:21  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:29:21  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:25:55  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:22:06  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:18:16  andy
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
** XtEMH_Proc
*/
void XtEMH_Proc(str, str2, str3, str4, str5, car)
String str, str2, str3, str4, *str5;
Cardinal *car;
{
	avs_set_event(1,1);
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtAppSetErrorMsgHandler Xt13
XtErrorMsgHandler
XtAppSetErrorMsgHandler(app_context, msg_handler)
>>ASSERTION Good A
A call to 
XtErrorMsgHandler XtAppSetErrorMsgHandler(app_context, msg_handler)
shall register 
.A msg_handler 
as the high-level fatal error handler for the application context
.A app_context.
>>CODE
XtErrorMsgHandler previous_handler;
pid_t pid2;
int status;

	FORK(pid2);
	avs_xt_hier("Tapstermh1", "XtAppSetErrorMsgHandler");
	tet_infoline("PREP: Register error message handler");
	previous_handler = XtAppSetErrorMsgHandler(app_ctext, XtEMH_Proc);
	tet_infoline("PREP: Call XtAppErrorMsg");
	XtAppErrorMsg(app_ctext, "name", "type", "class", "default", NULL, 0);
	tet_infoline("TEST: Error handler was invoked");
	status = avs_get_event(1);
	check_dec(1, status , "handler invocations count");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
A call to 
XtErrorMsgHandler XtAppSetErrorMsgHandler(app_context, msg_handler)
shall return a pointer to the previously installed high-level 
error handler for the application context
.A app_context.
>>CODE
XtErrorMsgHandler previous_handler;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tapstermh2", "XtAppSetErrorMsgHandler");
	tet_infoline("PREP: Register error messagehandler");
	previous_handler = XtAppSetErrorMsgHandler(app_ctext, XtEMH_Proc);
	if (previous_handler == NULL) {
		sprintf(ebuf, "ERROR: Expected pointer to previous handler, got NULL");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("PREP: Re-Register error handler");
	previous_handler = XtAppSetErrorMsgHandler(app_ctext, previous_handler);
	tet_infoline("TEST: Pointer to previous handler returned");
	if (previous_handler != XtEMH_Proc) {
		sprintf(ebuf, "ERROR: Pointer to previous handler not returned correctly");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
