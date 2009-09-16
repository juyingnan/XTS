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
>># File: xts/Xt9/XtAddGrab/XtAddGrab.m
>># 
>># Description:
>>#	Tests for XtAddGrab()
>># 
>># Modifications:
>># $Log: taddgrab.m,v $
>># Revision 1.1  2005-02-12 14:38:23  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:36:59  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:59:52  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:28:06  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.1  1998/02/03 21:27:30  andy
>># Editorial
>>#
>># Revision 5.0  1998/01/26 03:24:40  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:18:06  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:11:17  andy
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
** XtTMNO1_Proc procedure
** XtAddGrab() locks user input invoke, timeout procedure to exit
** from test after 2 seconds.
*/
void XtTMNO1_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	exit(0);
}

/*rowcolw's event handler*/
void XtEV1a_Proc(w, client_data, event, contin)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *contin;
{
	avs_set_event(1,avs_get_event(1)+1);
}

/*labelw_good's event handler*/
void XtEV1b_Proc(w, client_data, event, contin)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *contin;
{
	avs_set_event(2,avs_get_event(2)+1);
}

/*labelw_good2's event handler*/
void XtEV1c_Proc(w, client_data, event, contin)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *contin;
{
	avs_set_event(3,avs_get_event(3)+1);
}

/*boxw1's event handler*/
void XtEV1d_Proc(w, client_data, event, contin)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *contin;
{
	avs_set_event(4,avs_get_event(4)+1);
}
/*
** XtTMO2_Proc procedure
** XtAddGrab() locks user input invoke, timeout procedure to exit
** from test after 2 seconds.
*/
void XtTMO2_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	exit(0);
}

/*rowcolw's event handler*/
void XtEV2a_Proc(w, client_data, event, contin)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *contin;
{
	avs_set_event(1,avs_get_event(1)+1);
}

/*labelw_good's event handler*/
void XtEV2b_Proc(w, client_data, event, contin)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *contin;
{
	avs_set_event(2,avs_get_event(2)+1);
}

/*labelw_good2's event handler*/
void XtEV2c_Proc(w, client_data, event, contin)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *contin;
{
	avs_set_event(3,avs_get_event(3)+1);
}

/*boxw1's event handler*/
void XtEV2d_Proc(w, client_data, event, contin)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *contin;
{
	avs_set_event(4,avs_get_event(4)+1);
}
/*
** XtTMO3_Proc procedure
** XtAddGrab() locks user input invoke, timeout procedure to exit
** from test after 2 seconds.
*/
void XtTMO3_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	exit(0);
}

/*rowcolw's event handler*/
void XtEV3a_Proc(w, client_data, event, contin)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *contin;
{
	avs_set_event(1,avs_get_event(1)+1);
}

/*labelw_good's event handler*/
void XtEV3b_Proc(w, client_data, event, contin)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *contin;
{
	avs_set_event(2,avs_get_event(2)+1);
}

/*labelw_good2's event handler*/
void XtEV3c_Proc(w, client_data, event, contin)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *contin;
{
	avs_set_event(3,avs_get_event(3)+1);
}

/*boxw1's event handler*/
void XtEV3d_Proc(w, client_data, event, contin)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *contin;
{
	avs_set_event(4,avs_get_event(4)+1);
}
/*
** Installed Warning handler
*/
void XtEVT_handler(str1, str2, str3, str4, str5, car)
String str1, str2, str3, str4, *str5;
Cardinal *car;
{
	avs_set_event(1,avs_get_event(1)+1);
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtAddGrab Xt9
void
XtAddGrab(w, exclusive, spring_loaded)
>>ASSERTION Good A
A successful call to 
void XtAddGrab(w, exclusive, spring_loaded)
when 
.A exclusive 
is True and 
.A spring_loaded 
is False shall cause XtDispatchEvent to deliver user input events that 
occur in the active subset of the cascade to the widget 
.A w 
and other members of the active subset but not to its ancestors in 
the modal cascade.
>>CODE
char label[80];
Widget labelw_good, labelw_good2;
int status = 0;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Taddgrab1", "XtAddGrab");
	tet_infoline("PREP: Create labelw_good widget");
	labelw_good = (Widget) CreateLabelWidget("Modal", boxw1);
	tet_infoline("PREP: Create labelw_good2 widget");
	labelw_good2 = (Widget) CreateLabelWidget("ApTest", boxw1);
	tet_infoline("PREP: Create event handler for rowcolw");
	XtAddEventHandler(rowcolw, KeyPressMask|ButtonPressMask, False, XtEV1a_Proc, NULL);
	tet_infoline("PREP: Create event handler for labelw_good");
	XtAddEventHandler(labelw_good, KeyPressMask|ButtonPressMask, False, XtEV1b_Proc, NULL);
	tet_infoline("PREP: Create event handler for labelw_good2");
	XtAddEventHandler(labelw_good2, KeyPressMask|ButtonPressMask, False, XtEV1c_Proc, NULL);
	tet_infoline("PREP: Create event handler for boxw1");
	XtAddEventHandler(boxw1, KeyPressMask|ButtonPressMask, False, XtEV1d_Proc, NULL);
	tet_infoline("PREP: Set grab for labelw_good2, non-exclusive");
	XtAddGrab(labelw_good2, False, False);
	tet_infoline("PREP: Set grab for labelw_good, exclusive");
	XtAddGrab(labelw_good, True, False);
	tet_infoline("PREP: Set grab for rowcolw, non-exclusive");
	XtAddGrab(rowcolw, False, False);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send KeyPress and ButtonPress to boxw1");
	send_event(boxw1, ButtonPress, ButtonPressMask, TRUE);
	send_event(boxw1, KeyPress, KeyPressMask, TRUE);
	tet_infoline("PREP: Send KeyPress and ButtonPress to rowcolw");
	send_event(rowcolw, ButtonPress, ButtonPressMask, TRUE);
	send_event(rowcolw, KeyPress, KeyPressMask, TRUE);
	tet_infoline("PREP: Send KeyPress and ButtonPress to labelw_good2");
	send_event(labelw_good2, ButtonPress, ButtonPressMask, TRUE);
	send_event(labelw_good2, KeyPress, KeyPressMask, TRUE);
	tet_infoline("PREP: Send KeyPress and ButtonPress to labelw_good");
	send_event(labelw_good, ButtonPress, ButtonPressMask, TRUE);
	send_event(labelw_good, KeyPress, KeyPressMask, TRUE);
	tet_infoline("PREP: Register timeout");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTMNO1_Proc, topLevel);
	tet_infoline("TEST: Events should only be dispatched to labelw_good and rowcolw");
	XtAppMainLoop(app_ctext);
	LKROF(pid2, 25);
	tet_infoline("TEST: Events were received by labelw_good");
	status = avs_get_event(1);
	check_dec(2, status, "labelw_good event count");
	tet_infoline("TEST: Events were received by rowcolw (active subset)");
	status = avs_get_event(2);
	check_dec(2, status, "rowcolw event count");
	tet_infoline("TEST: Events were not received by labelw_good2 (above in cascade)");
	status = avs_get_event(3);
	check_dec(0, status, "labelw_good2 event count");
	tet_infoline("TEST: Events were not received by boxw1 (outside cascade)");
	status = avs_get_event(4);
	check_dec(0, status, "boxw1 event count");
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to 
void XtAddGrab(w, exclusive, spring_loaded)
when 
.A exclusive 
is False and 
.A spring_loaded 
is False shall cause 
XtDispatchEvent to deliver user input events that occur in the active
subset of the modal cascade to the widget 
.A w 
and other members of the active subset up to and including the most 
recent cascade entry added with the exclusive parameter as
.S True.
>>CODE
char label[80];
Widget labelw_good, labelw_good2;
int status = 0;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Taddgrab2", "XtAddGrab");
	tet_infoline("PREP: Create labelw_good widget");
	labelw_good = (Widget) CreateLabelWidget("Modal", boxw1);
	tet_infoline("PREP: Create labelw_good2 widget");
	labelw_good2 = (Widget) CreateLabelWidget("ApTest", boxw2);
	tet_infoline("PREP: Create event handler for rowcolw");
	XtAddEventHandler(rowcolw, KeyPressMask|ButtonPressMask, False, XtEV2a_Proc, NULL);
	tet_infoline("PREP: Create event handler for labelw_good");
	XtAddEventHandler(labelw_good, KeyPressMask|ButtonPressMask, False, XtEV2b_Proc, NULL);
	tet_infoline("PREP: Create event handler for labelw_good2");
	XtAddEventHandler(labelw_good2, KeyPressMask|ButtonPressMask, False, XtEV2c_Proc, NULL);
	tet_infoline("PREP: Create event handler for boxw1");
	XtAddEventHandler(boxw1, KeyPressMask|ButtonPressMask, False, XtEV2d_Proc, NULL);
	tet_infoline("PREP: Set grab for rowcolw, non-exclusive");
	XtAddGrab(rowcolw, False, False);
	tet_infoline("PREP: Set grab for labelw_good, exclusive");
	XtAddGrab(labelw_good, True, False);
	tet_infoline("PREP: Set grab for labelw_good2, nonexclusive");
	XtAddGrab(labelw_good2, False, False);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send KeyPress and ButtonPress to boxw1");
	send_event(boxw1, ButtonPress, ButtonPressMask, TRUE);
	send_event(boxw1, KeyPress, KeyPressMask, TRUE);
	tet_infoline("PREP: Send KeyPress and ButtonPress to rowcolw");
	send_event(rowcolw, ButtonPress, ButtonPressMask, TRUE);
	send_event(rowcolw, KeyPress, KeyPressMask, TRUE);
	tet_infoline("PREP: Send KeyPress and ButtonPress to labelw_good2");
	send_event(labelw_good2, ButtonPress, ButtonPressMask, TRUE);
	send_event(labelw_good2, KeyPress, KeyPressMask, TRUE);
	tet_infoline("PREP: Send KeyPress and ButtonPress to labelw_good");
	send_event(labelw_good, ButtonPress, ButtonPressMask, TRUE);
	send_event(labelw_good, KeyPress, KeyPressMask, TRUE);
	tet_infoline("PREP: Register timeout");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTMO2_Proc, topLevel);
	tet_infoline("TEST: Events should only be dispatched to labelw_good and labelw_good2");
	XtAppMainLoop(app_ctext);
	LKROF(pid2, 25);
	tet_infoline("TEST: Events were received by labelw_good2");
	status = avs_get_event(3);
	check_dec(2, status, "labelw_good2 event count");
	tet_infoline("TEST: Events were received by labelw_good (first above in cascade with exclusive)");
	status = avs_get_event(2);
	check_dec(2, status, "labelw_good event count");
	tet_infoline("TEST: Events were not received by rowcolw (above labelw_goodw2 in cascade)");
	status = avs_get_event(1);
	check_dec(0, status, "rowcolw event count");
	tet_infoline("TEST: Events were not received by boxw1 (outside cascade)");
	status = avs_get_event(4);
	check_dec(0, status, "boxw1 event count");
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to 
void XtAddGrab(w, exclusive, spring_loaded)
when 
.A exclusive 
is True and 
.A spring_loaded 
is True shall cause XtDispatchEvent to deliver all 
KeyPress, KeyRelease, ButtonPress and ButtonRelease events that occur 
outside the active subset of the modal cascade but in the calling 
process to the widget 
.A w.
>>CODE
Widget labelw_good, labelw_good2;
int status = 0;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Taddgrab3", "XtAddGrab");
	tet_infoline("PREP: Create labelw_good widget");
	labelw_good = (Widget) CreateLabelWidget("Modal", boxw1);
	tet_infoline("PREP: Create labelw_good2 widget");
	labelw_good2 = (Widget) CreateLabelWidget("ApTest", boxw2);
	tet_infoline("PREP: Create event handler for rowcolw");
	XtAddEventHandler(rowcolw, KeyPressMask|ButtonPressMask, False, XtEV3a_Proc, NULL);
	tet_infoline("PREP: Create event handler for labelw_good");
	XtAddEventHandler(labelw_good, KeyPressMask|ButtonPressMask, False, XtEV3b_Proc, NULL);
	tet_infoline("PREP: Create event handler for labelw_good2");
	XtAddEventHandler(labelw_good2, KeyPressMask|ButtonPressMask, False, XtEV3c_Proc, NULL);
	tet_infoline("PREP: Create event handler for boxw1");
	XtAddEventHandler(boxw1, KeyPressMask|ButtonPressMask, False, XtEV3d_Proc, NULL);
	tet_infoline("PREP: Set grab for rowcolw, non-exclusive");
	XtAddGrab(rowcolw, False, False);
	tet_infoline("PREP: Set grab for labelw_good, exclusive, springloaded");
	XtAddGrab(labelw_good, True, True);
	tet_infoline("PREP: Set grab for labelw_good2, nonexclusive");
	XtAddGrab(labelw_good2, False, False);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send KeyPress and ButtonPress to boxw1");
	send_event(boxw1, ButtonPress, ButtonPressMask, TRUE);
	send_event(boxw1, KeyPress, KeyPressMask, TRUE);
	tet_infoline("PREP: Send KeyPress and ButtonPress to rowcolw");
	send_event(rowcolw, ButtonPress, ButtonPressMask, TRUE);
	send_event(rowcolw, KeyPress, KeyPressMask, TRUE);
	tet_infoline("PREP: Send KeyPress and ButtonPress to labelw_good2");
	send_event(labelw_good2, ButtonPress, ButtonPressMask, TRUE);
	send_event(labelw_good2, KeyPress, KeyPressMask, TRUE);
	tet_infoline("PREP: Send KeyPress and ButtonPress to labelw_good");
	send_event(labelw_good, ButtonPress, ButtonPressMask, TRUE);
	send_event(labelw_good, KeyPress, KeyPressMask, TRUE);
	tet_infoline("PREP: Register timeout");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTMO3_Proc, topLevel);
	tet_infoline("TEST: Events should only be dispatched to labelw_good and labelw_good2");
	XtAppMainLoop(app_ctext);
	LKROF(pid2, 25);
	tet_infoline("TEST: All events were received by labelw_good (springloaded)");
	status = avs_get_event(2);
	check_dec(8, status, "labelw_good event count");
	tet_infoline("TEST: Events were received by labelw_good2 (below labelw_good in cascade)");
	status = avs_get_event(3);
	check_dec(2, status, "labelw_good2 event count");
	tet_infoline("TEST: Events were not received by rowcolw (above labelw_goodw in cascade)");
	status = avs_get_event(1);
	check_dec(0, status, "rowcolw event count");
	tet_infoline("TEST: Events were not received by boxw1 (outside cascade)");
	status = avs_get_event(4);
	check_dec(0, status, "boxw1 event count");
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to 
void XtAddGrab(w, exclusive, spring_loaded)
when 
.A exclusive 
is True and 
.A spring_loaded 
is True shall cause XtDispatchEvent to deliver all user input events that 
occur in the active subset of the modal cascade to the appropriate widget
in the active subset and also to the widget
.A w.
>>CODE
Widget labelw_good, labelw_good2;
int status = 0;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Taddgrab3", "XtAddGrab");
	tet_infoline("PREP: Create labelw_good widget");
	labelw_good = (Widget) CreateLabelWidget("Modal", boxw1);
	tet_infoline("PREP: Create labelw_good2 widget");
	labelw_good2 = (Widget) CreateLabelWidget("ApTest", boxw2);
	tet_infoline("PREP: Create event handler for rowcolw");
	XtAddEventHandler(rowcolw, KeyPressMask|ButtonPressMask, False, XtEV3a_Proc, NULL);
	tet_infoline("PREP: Create event handler for labelw_good");
	XtAddEventHandler(labelw_good, KeyPressMask|ButtonPressMask, False, XtEV3b_Proc, NULL);
	tet_infoline("PREP: Create event handler for labelw_good2");
	XtAddEventHandler(labelw_good2, KeyPressMask|ButtonPressMask, False, XtEV3c_Proc, NULL);
	tet_infoline("PREP: Create event handler for boxw1");
	XtAddEventHandler(boxw1, KeyPressMask|ButtonPressMask, False, XtEV3d_Proc, NULL);
	tet_infoline("PREP: Set grab for rowcolw, non-exclusive");
	XtAddGrab(rowcolw, False, False);
	tet_infoline("PREP: Set grab for labelw_good, exclusive, springloaded");
	XtAddGrab(labelw_good, True, True);
	tet_infoline("PREP: Set grab for labelw_good2, nonexclusive");
	XtAddGrab(labelw_good2, False, False);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send KeyPress and ButtonPress to boxw1");
	send_event(boxw1, ButtonPress, ButtonPressMask, TRUE);
	send_event(boxw1, KeyPress, KeyPressMask, TRUE);
	tet_infoline("PREP: Send KeyPress and ButtonPress to rowcolw");
	send_event(rowcolw, ButtonPress, ButtonPressMask, TRUE);
	send_event(rowcolw, KeyPress, KeyPressMask, TRUE);
	tet_infoline("PREP: Send KeyPress and ButtonPress to labelw_good2");
	send_event(labelw_good2, ButtonPress, ButtonPressMask, TRUE);
	send_event(labelw_good2, KeyPress, KeyPressMask, TRUE);
	tet_infoline("PREP: Send KeyPress and ButtonPress to labelw_good");
	send_event(labelw_good, ButtonPress, ButtonPressMask, TRUE);
	send_event(labelw_good, KeyPress, KeyPressMask, TRUE);
	tet_infoline("PREP: Register timeout");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTMO3_Proc, topLevel);
	tet_infoline("TEST: Events should be dispatched to labelw_good and labelw_good2");
	XtAppMainLoop(app_ctext);
	LKROF(pid2, 25);
	tet_infoline("TEST: All events were received by labelw_good (springloaded)");
	status = avs_get_event(2);
	check_dec(8, status, "labelw_good event count");
	tet_infoline("TEST: Events were received by labelw_good2 (below labelw_good in cascade)");
	status = avs_get_event(3);
	check_dec(2, status, "labelw_good2 event count");
	tet_result(TET_PASS);
>>ASSERTION Good A
A call to 
void XtAddGrab(w, exclusive, spring_loaded)
when 
.A exclusive 
is False and 
.A spring_loaded 
is True shall issue a warning message.
>>CODE
char label[80];
Widget labelw_good;
Widget pushb_good, rowcolw_good;
int status = 0;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Taddgrab1", "XtAddGrab");
	tet_infoline("PREP: Create labelw_good widget");
	labelw_good = (Widget) CreateLabelWidget("Modal", boxw1);
	tet_infoline("PREP: Set up test XtToolkitWarning handler");
	XtAppSetWarningMsgHandler(app_ctext, XtEVT_handler);
	tet_infoline("TEST: Issue XtAddGrab for labelw_good");
	XtAddGrab(labelw_good, False, True);
	tet_infoline("TEST: Warning message was issued");
	status = avs_get_event(1);
	check_dec(1, status, "warning message invoked count");
	LKROF(pid2, 25);
	tet_result(TET_PASS);
