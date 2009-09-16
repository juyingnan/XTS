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
>># File: tset/Xt13/XtSetWMColormapWindows/XtSetWMColormapWindows.m
>># 
>># Description:
>>#	Tests for XtSetWMColormapWindows()
>># 
>># Modifications:
>># $Log: tstwmcmw.m,v $
>># Revision 1.1  2005-02-12 14:37:58  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:38:23  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:26  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:29:25  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:25:59  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:22:16  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:18:30  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;
>>TITLE XtSetWMColormapWindows Xt13
void
XtSetWMColormapWindows(widget, list, count)
>>ASSERTION Good A
A successful call to 
void XtSetWMColormapWindows(widget, list, count)
when the widget
.A widget
is realized and
.A count
is not zero 
shall set the WM_COLORMAP_WINDOWS property on the window of the 
specified widget to a list of windows that are the windows of those
widgets on the list 
.A  list 
which are realized and have unique colormap resources.
>>CODE
Widget rowcolw_good;
Widget labelw_good;
Widget list[2];
Display *display;
Window window, *colormap_windows[2];
int count_return;
int status;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tstwmcmw1", "XtSetWMColormapWindows");
	tet_infoline("PREP: Create rowcolw_good widget in boxw1 widget");
	rowcolw_good = (Widget) CreateRowColWidget(boxw1);
	tet_infoline("PREP: Create labelw_good in rowcolw_good widget");
	labelw_good = (Widget) CreateLabelWidget("Hello",rowcolw_good);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Set WM_COLORMAP_WINDOWS property for rowcolw_good widget");
	list[0] = rowcolw_good;
	list[1] = labelw_good;
	XtSetWMColormapWindows(rowcolw_good, &list[0], 2);
	tet_infoline("TEST: WM_COLORMAP_WINDOWS property for rowcolw_good widget");
	display = XtDisplay(rowcolw_good);
	window = XtWindow(rowcolw_good);
	status = XGetWMColormapWindows(display, window, colormap_windows, &count_return);
	check_dec(True, status, "XGetWMColormapWindows return value");
	check_dec(window, *colormap_windows[0], "window id");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
A call to 
void XtSetWMColormapWindows(widget, list, count)
when the widget
.A widget
is not realized shall return immediately.
>>CODE
Widget rowcolw_good;
Widget labelw_good;
Widget list[2];
Display *display;
Window window, *colormap_windows[2];
int count_return;
int status;
pid_t pid2;

	FORK(pid2);
	/*verify nothing catastrophic happens*/
	avs_xt_hier("Tstwmcmw1", "XtSetWMColormapWindows");
	tet_infoline("PREP: Create rowcolw_good widget in boxw1 widget");
	rowcolw_good = (Widget) CreateRowColWidget(boxw1);
	tet_infoline("PREP: Create labelw_good in rowcolw_good widget");
	labelw_good = (Widget) CreateLabelWidget("Hello",rowcolw_good);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	list[0] = labelw_good;
	tet_infoline("PREP: Unrealize widget");
	XtUnrealizeWidget(rowcolw_good);
	tet_infoline("TEST: Set WM_COLORMAP_WINDOWS property for rowcolw_good widget");
	XtSetWMColormapWindows(rowcolw_good, &list[0], 1);
	tet_infoline("PREP: Realize widget");
	XtRealizeWidget(rowcolw_good);
	tet_infoline("TEST: WM_COLORMAP_WINDOWS property for rowcolw_good widget");
	display = XtDisplay(rowcolw_good);
	window = XtWindow(rowcolw_good);
	status = XGetWMColormapWindows(display, window, colormap_windows, &count_return);
	check_dec(False, status, "XGetWMColormapWindows return value");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
A call to 
void XtSetWMColormapWindows(widget, list, count)
when 
.A count
is zero shall return immediately.
>>CODE
Widget rowcolw_good;
Widget labelw_good;
Widget list[2];
Display *display;
Window window, *colormap_windows[2];
int count_return;
int status;
pid_t pid2;

	FORK(pid2);
	/*verify nothing catastrophic happens*/
	avs_xt_hier("Tstwmcmw1", "XtSetWMColormapWindows");
	tet_infoline("PREP: Create rowcolw_good widget in boxw1 widget");
	rowcolw_good = (Widget) CreateRowColWidget(boxw1);
	tet_infoline("PREP: Create labelw_good in rowcolw_good widget");
	labelw_good = (Widget) CreateLabelWidget("Hello",rowcolw_good);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Set WM_COLORMAP_WINDOWS property for rowcolw_good widget");
	list[0] = rowcolw_good;
	list[1] = labelw_good;
	XtSetWMColormapWindows(rowcolw_good, &list[0], 0);
	tet_infoline("TEST: WM_COLORMAP_WINDOWS property for rowcolw_good widget");
	display = XtDisplay(rowcolw_good);
	window = XtWindow(rowcolw_good);
	status = XGetWMColormapWindows(display, window, colormap_windows, &count_return);
	check_dec(False, status, "XGetWMColormapWindows return value");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
