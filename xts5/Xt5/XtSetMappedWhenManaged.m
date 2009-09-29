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
>># File: xts/Xt5/XtSetMappedWhenManaged.m
>># 
>># Description:
>>#	Tests for XtSetMappedWhenManaged()
>># 
>># Modifications:
>># $Log: tstmpwmng.m,v $
>># Revision 1.1  2005-02-12 14:38:14  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:36:38  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:59:29  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:27:46  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:20  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:16:41  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:20:42  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;
Window window;

static void analyse_events2(quit)
Widget quit;
{
	XtAppContext app_context;
	Display *display;
	XEvent loop_event;
	XEvent return_event;
	Widget widget;
	widget = XtParent(quit);
	app_context = XtWidgetToApplicationContext(widget);
	display = XtDisplay(widget);
	for (;;) {
	 XtAppNextEvent(app_context, &loop_event);
	 XSync(display, False);
	 if (loop_event.type == UnmapNotify) {
		if (loop_event.xany.window == window) {
			avs_set_event(1,1);
			exit(0);
		}
	 }
	} /* end for */
}

static void analyse_events(quit)
Widget quit;
{
	XtAppContext app_context;
	Display *display;
	XEvent loop_event;
	XEvent return_event;
	Widget widget;
	widget = XtParent(quit);
	app_context = XtWidgetToApplicationContext(widget);
	display = XtDisplay(widget);
	for (;;) {
	 XtAppNextEvent(app_context, &loop_event);
	 XSync(display, False);
	if (loop_event.type == MapNotify) {
		if (loop_event.xany.window == window) {
			avs_set_event(1,1);
			exit(0);
		}
	}
	 XtDispatchEvent(&loop_event);
	} /* end for */
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtSetMappedWhenManaged Xt5
void
XtSetMappedWhenManaged(w, map_when_managed)
>>ASSERTION Good A
When the widget w is realized, managed, and map_when_managed is set 
to True a successful call to 
void XtSetMappedWhenManaged(w, map_when_managed) 
shall map the widget window.
>>CODE
Widget labelw_msg;
char *msg = "Test widget";
Boolean value;
Arg args[1];
Display *display;
int status = 0;
pid_t pid2;

	avs_xt_hier("Tstmpwmng1", "XtSetMappedWhenManaged");
	tet_infoline("PREP: Create labelw_msg in box1w");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("TEST: Set mapped_when_managed to True");
	XtSetMappedWhenManaged(labelw_msg, False);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Catch MapNotify event");
	display = XtDisplay(labelw_msg);
	window = XtWindow(labelw_msg);
	XSelectInput(display, window, (unsigned long)StructureNotifyMask);
	tet_infoline("PREP: Unmap labelw_msg widget");
	XtUnmapWidget(labelw_msg);
	tet_infoline("TEST: Set mapped_when_managed to True");
	XtSetMappedWhenManaged(labelw_msg, True);
	FORK(pid2);
	tet_infoline("TEST: MapNotify event was generated for widget");
	analyse_events(click_quit);
	KROF(pid2);
	kill(pid2, SIGKILL);
	status = avs_get_event(1);
	check_dec(1, status, "MapNotify event count");
	tet_infoline("TEST: Resource value XtNmappedWhenManaged is True.");
	args[0].name = XtNmappedWhenManaged;
	XtVaGetValues(labelw_msg, XtNmappedWhenManaged, &value, (char *)NULL);
	check_dec(True, value, "XtNmappedWhenManaged");
	tet_result(TET_PASS);
>>ASSERTION Good A
When the widget w is realized, managed, and map_when_managed is set 
to False a successful call to 
void XtSetMappedWhenManaged(w, map_when_managed) 
shall unmap the widget window.
>>CODE
Widget labelw_msg;
char *msg = "Test widget";
Boolean value;
Display *display;
int status = 0;
pid_t pid2;

	avs_xt_hier("Tstmpwmng2", "XtSetMappedWhenManaged");
	tet_infoline("PREP: Create labelw_msg in box1w");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Catch MapNotify event");
	display = XtDisplay(labelw_msg);
	window = XtWindow(labelw_msg);
	XSelectInput(display, window, (unsigned long)StructureNotifyMask);
	tet_infoline("TEST Set mapped_when_managed to False");
	XtSetMappedWhenManaged(labelw_msg, False);
	FORK(pid2);
	tet_infoline("TEST: UnmapNotify event was generated for widget");
	analyse_events2(click_quit);
	KROF(pid2);
	kill(pid2, SIGKILL);
	status = avs_get_event(1);
	check_dec(1, status, "UnmapNotify event count");
	tet_infoline("TEST: Resource value XtNmappedWhenManaged is False.");
	XtVaGetValues(labelw_msg, XtNmappedWhenManaged, &value, (char *)NULL);
	check_dec(False, value, "XtNmappedWhenManaged");
	tet_result(TET_PASS);
