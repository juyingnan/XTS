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
>># File: xts/Xt13/XtAddExposureToRegion.m
>># 
>># Description:
>>#	Tests for XtAddExposureToRegion()
>># 
>># Modifications:
>># $Log: tadexptor.m,v $
>># Revision 1.1  2005-02-12 14:37:57  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:38:16  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:17  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:29:19  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:25:52  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:21:59  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:18:06  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;

extern char *event_names[];

/*
** Procedure XtEVT1_Proc
*/
void XtEVT1_Proc(w, client_data, event, continue_to_dispatch)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_dispatch;
{
Region test_region;

	if ( event->type == Expose ) {
		tet_infoline("PREP: Create a region");
		test_region = XCreateRegion();
		tet_infoline("TEST: Add exposure to region");
		XtAddExposureToRegion((XEvent *)&event, test_region);
		/*unclear how verify this worked with opaque type*/
		avs_set_event(1,avs_get_event(1)+1);
		exit(0);
	}
	else {
		sprintf(ebuf, "ERROR: Expected Expose event Received %s", event_names[event->type]);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
}
void XtEVT_Proc1(w, client_data, event, continue_to_dispatch)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_dispatch;
{
Region test_region;

	if (event->type == GraphicsExpose ) {
		tet_infoline("PREP: Create a region");
		test_region = XCreateRegion();
		tet_infoline("TEST: Add exposure to region");
		XtAddExposureToRegion((XEvent *)&event, test_region);
		/*unclear how verify this worked with opaque type*/
		avs_set_event(2,avs_get_event(2)+1);
		exit(0);
	}
	else {
		sprintf(ebuf, "ERROR: Expected GraphicsExpose event Received %s", event_names[event->type]);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
}
/*
** Procedure XtEVT2_Proc
*/
void XtEVT2_Proc(w, client_data, event, continue_to_dispatch)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_dispatch;
{
Region test_region;

	if ( event->type == KeyPress ) {
		tet_infoline("PREP: Create a region");
		test_region = XCreateRegion();
		tet_infoline("PREP: Add exposure to region using KeyPress event");
		XtAddExposureToRegion((XEvent *)&event, test_region);
		avs_set_event(1,avs_get_event(1)+1);
		exit(0);
	}
	else {
		sprintf(ebuf, "ERROR: Expected KeyPress event Received %s", event_names[event->type]);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
}
/*
** Installed Warning handler
*/
void XtEMH2_Proc(str, str2, str3, str4, str5, car)
String str, str2, str3, str4, *str5;
Cardinal *car;
{
	avs_set_event(3,1);
	exit(0);
}
/*
** Installed Error handler
*/
void XtEMH_Proc(str, str2, str3, str4, str5, car)
String str, str2, str3, str4, *str5;
Cardinal *car;
{
	avs_set_event(2,1);
	exit(0);
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtAddExposureToRegion Xt13
void
XtAddExposureToRegion(event, region)
>>ASSERTION Good A
A call to 
void XtAddExposureToRegion(event, region)
when 
.A event 
specifies an Expose event
shall compute the union of the rectangle defined by the
specified event and the region
.A region
and store the result in 
.A region.
>>CODE
pid_t pid2;
int status;

	FORK(pid2);
	avs_xt_hier("Tadexptor1", "XtAddExposureToRegion");
	tet_infoline("PREP: XtEVT1_Proc to handle events to labelw");
	XtAddEventHandler(labelw,
		 ExposureMask,
		 False,
		 XtEVT1_Proc,
		 (XtPointer)NULL
		 );
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	send_event(labelw, Expose, ExposureMask, TRUE);
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Event handler was called");
	status = avs_get_event(1);
	check_dec(1, status, "XtEVT1_Proc invocations count");
	tet_result(TET_PASS);
>>ASSERTION Good A
A call to 
void XtAddExposureToRegion(event, region)
when 
.A event 
specifies a GraphicsExpose event
shall compute the union of the rectangle defined by the
specified event and the region
.A region
and store the result in 
.A region.
>>CODE
pid_t pid2;
int status;

	FORK(pid2);
	avs_xt_hier("Tadexptor1", "XtAddExposureToRegion");
	tet_infoline("PREP: XtEVT1_Proc to handle events to labelw");
	XtAddEventHandler(labelw,
		 0,
		 True,
		 XtEVT_Proc1,
		 (XtPointer)NULL
		 );
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	send_event(labelw, GraphicsExpose, ExposureMask, TRUE);
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Event handler was called");
	status = avs_get_event(2);
	check_dec(1, status, "handler invocations count");
	tet_result(TET_PASS);
>>ASSERTION Good A
When the event specified by
.A event 
is neither an Expose nor a
GraphicsExpose event a call to 
void XtAddExposureToRegion(event, region)
shall not issue an error and not modify 
.A region.
>>CODE
pid_t pid2;
int status;

	FORK(pid2);
	avs_xt_hier("Tadexptor2", "XtAddExposureToRegion");
	tet_infoline("PREP: Register error and warning handler");
	XtAppSetWarningMsgHandler(app_ctext, XtEMH2_Proc);
	XtAppSetErrorMsgHandler(app_ctext, XtEMH_Proc);
	tet_infoline("PREP: XtEVT2_Proc to handle key press events to labelw");
	XtAddEventHandler(labelw,
		 KeyPressMask,
		 False,
		 XtEVT2_Proc,
		 (XtPointer)NULL
		 );
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send KeyPress event");
	send_event(labelw, KeyPress, KeyPressMask, TRUE);
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: No error or warning was generated");
	status = avs_get_event(2);
	check_dec(0, status, "Error message count");
	status = avs_get_event(3);
	check_dec(0, status, "Warning message count");
	tet_result(TET_PASS);
