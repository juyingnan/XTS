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
$Header: /cvs/xtest/xtest/xts5/tset/Xt4/tclsdsply/tclsdsply.m,v 1.1 2005-02-12 14:38:00 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt4/tclsdsply/tclsdsply.m
>># 
>># Description:
>>#	Tests for XtCloseDisplay()
>># 
>># Modifications:
>># $Log: tclsdsply.m,v $
>># Revision 1.1  2005-02-12 14:38:00  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:36:19  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:59:09  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:27:30  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:04  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.1  1998/01/14 01:23:39  andy
>># Changed both tests to not poke the widgets for the display after
>># it is closed as this causes core dumps on some implementations (SR 142).
>>#
>># Revision 4.0  1995/12/15 09:15:50  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:19:35  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;
Display	*display_good;

/*
** XtEMH_Proc
*/
void XtEMH_Proc(str, str2, str3, str4, str5, car)
String str, str2, str3, str4, *str5;
Cardinal *car;
{
	avs_set_event(2, 1);
	exit(0);
}

/*timeout callback*/
void XtTI_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
        exit(0);
}

/*
** Registered procedure XtEVT_Proc to be invoked
*/
void XtEVT_Proc(w, client_data, event, continue_to_dispatch)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_dispatch;
{

    if (event->type == ButtonPress){
	display_good= XtDisplay(topLevel);
	tet_infoline("PREP: Close the display during a dispatch");
        XtCloseDisplay(display_good);
	tet_infoline("TEST: Display is still good inside handler");
	if (XtDisplay(labelw) == NULL) {
	   	sprintf(ebuf, "ERROR: Expected valid display pointer");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
        avs_set_event(1,1);
        exit(0);
    }
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtCloseDisplay Xt4
void
XtCloseDisplay(display)
>>ASSERTION Good A
A call to void XtCloseDisplay(display) shall close the display specified
by the argument display and remove it from the application context of the
calling program.
>>CODE
char	string[10];
Widget	labelw_good , widget_good;
Window	window_good;
pid_t	pid2;
int	invoked;

	avs_xt_hier("Tclsdsply1", "XtCloseDisplay");
	display_good = XtDisplay(topLevel);
	tet_infoline("PREP: Create label widget `Hello' in boxw1 widget");
	labelw_good = (Widget) CreateLabelWidget("Hello", boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);	
        tet_infoline("PREP: Register timeout");
        XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTI_Proc, topLevel);
        tet_infoline("PREP: Register error handler");
	XtAppSetErrorMsgHandler(app_ctext, XtEMH_Proc);
	tet_infoline("TEST: Close the display");
	XtCloseDisplay(display_good);
	/*the safest thing to do, as best we can tell, as it
	actually validates the pointer and gives an error message
	if the display isn't valid*/
	tet_infoline("TEST: Display is no longer valid");
	FORK(pid2);
	XtCloseDisplay(display_good);
	KROF(pid2);
	invoked = avs_get_event(2);
	check_dec(1, invoked, "Error handler invoked status");
	/*ensure as best we can that the appcontext is still valid*/
	tet_infoline("TEST: Application context is still valid");
	FORK(pid2);
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	tet_result(TET_PASS);
>>ASSERTION Good A
void XtCloseDisplay(display) when called from within an event dispatch 
shall not close the display until the dispatch is complete.
>>CODE
Widget	labelw_msg;
char	*msg = "Event widget";
int	status;
pid_t	pid2;

	FORK(pid2);
	avs_xt_hier("Tclsdsply2", "XtCloseDisplay");
	tet_infoline("PREP: Create labelw_msg widget in boxw1 widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Register procedure to handle ButtonPress events");
	XtAddEventHandler(labelw_msg,
		  ButtonPressMask,
		  False,
		  XtEVT_Proc,
		  (Display *)display_good
		  );
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send ButtonPress over wire to labelw_msg widget");
	send_event(labelw_msg, ButtonPress, ButtonPressMask, FALSE);
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	status = avs_get_event(1);
	check_dec(1, status, "Callback invocation count");
	tet_result(TET_PASS);
