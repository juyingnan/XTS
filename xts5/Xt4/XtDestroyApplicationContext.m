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
>># File: xts/Xt4/XtDestroyApplicationContext.m
>># 
>># Description:
>>#	Tests for XtDestroyApplicationContext()
>># 
>># Modifications:
>># $Log: tdstryappl.m,v $
>># Revision 1.1  2005-02-12 14:38:02  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:36:16  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:59:06  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:27:28  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:01  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:15:41  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:19:23  andy
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
** Procedure XtEVT_Proc
*/
void XtEVT_Proc(w, client_data, event, flag)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *flag;
{
    if (event->type == ButtonPress) {
	XtDestroyApplicationContext((XtAppContext)client_data);
        avs_set_event(1,1);
        exit(0);
    }
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtDestroyApplicationContext Xt4
void
XtDestroyApplicationContext(app_context)
>>ASSERTION Good A
A call to void XtDestroyApplicationContext(app_context) shall destroy
the application context app_context and close all the display connections 
associated with it.
>>CODE

	avs_xt_hier("Tdstryappl1", "XtDestroyApplicationContext");
	tet_infoline("TEST: Destroy an application context");
	XtDestroyApplicationContext(app_ctext);
	tet_result(TET_PASS);
>>ASSERTION Good A
A call to void XtDestroyApplicationContext(app_context) when called from 
within an event dispatch shall not destroy the application context until 
the dispatch is complete.
>>CODE
Widget labelw_msg;
char *msg = "Test widget";
pid_t pid2;
int invoked = 0;

	FORK(pid2);
	avs_xt_hier("Tdstryappl2", "XtDestroyApplicationContext");
	tet_infoline("PREP: Create labelw_msg widget in boxw1");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Register procedure to handle ButtonPress events to");
	tet_infoline("PREP: labelw_msg widget");
	XtAddEventHandler(labelw_msg,
		  ButtonPressMask,
		  False,
		  XtEVT_Proc,
		  (XtPointer)app_ctext
		  );
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Simulate ButtonPress on widget labelw_msg");
	send_event(labelw_msg, ButtonPress, ButtonPressMask, FALSE);
	tet_infoline("TEST: Loop for events");
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	tet_infoline("TEST: Context terminated on event handler completion");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "Event handler invoked count");
	tet_result(TET_PASS);
