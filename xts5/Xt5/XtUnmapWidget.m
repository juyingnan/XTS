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
>># File: xts/Xt5/XtUnmapWidget.m
>># 
>># Description:
>>#	Tests for XtUnmapWidget()
>># 
>># Modifications:
>># $Log: tunmpwdgt.m,v $
>># Revision 1.1  2005-02-12 14:38:14  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:36:39  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:59:30  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:27:47  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:21  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:16:44  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:20:45  andy
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

static void analyse_events(quit)
Widget quit;
{
	XtAppContext app_context;
	Display *display;
	XEvent loop_event;
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
	 XtDispatchEvent(&loop_event);
	} /* end for */
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtUnmapWidget Xt5
void
XtUnmapWidget(w)
>>ASSERTION Good A
A successful call to 
void XtUnmapWidget(w) 
when the window of the widget w is mapped shall unmap the widget window.
>>CODE
Widget labelw_good;
Display *display;
int status = 0;
pid_t pid2;

	avs_xt_hier("Tunmpwdgt1", "XtUnmapWidget");
	tet_infoline("PREP: Create labelw_good widget Hello");
	labelw_good = (Widget) CreateLabelWidget("Hello", boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Catch UnmapNotify event");
	display = XtDisplay(labelw_good);
	window = XtWindow(labelw_good);
	XSelectInput(display, window, (unsigned long)StructureNotifyMask);
	tet_infoline("PREP: Unmap labelw_good widget");
	XtUnmapWidget(labelw_good);
	FORK(pid2);
	tet_infoline("TEST: UnmapNotify event generated for widget");
	analyse_events(click_quit);
	KROF(pid);
	status = avs_get_event(1);
	check_dec(1, status, "UnmapNotify event count");
	tet_result(TET_PASS);
