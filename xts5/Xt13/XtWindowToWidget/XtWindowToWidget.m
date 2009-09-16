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
>># File: xts/Xt13/XtWindowToWidget/XtWindowToWidget.m
>># 
>># Description:
>>#	Tests for XtWindowToWidget()
>># 
>># Modifications:
>># $Log: twindtowd.m,v $
>># Revision 1.1  2005-02-12 14:37:58  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:38:17  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:19  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:29:20  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:25:53  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:22:01  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:18:10  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;
>>TITLE XtWindowToWidget Xt13
Widget
XtWindowToWidget(display, window)
>>ASSERTION Good A
A successful call to 
Widget XtWindowToWidget(display, window)
shall return a pointer to the widget that is realized and 
whose window is
.A window
on the display
.A display.
>>CODE
char string[10];
Window window_good;
Widget widget_good, labelw_good;
Display *display_good;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Twindtowd1", "XtWindowToWidget");
	tet_infoline("PREP: Create test label widget `Hello' in box widget");
	labelw_good = (Widget) CreateLabelWidget("Hello", boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get window id and display pointer of the labelw_good widget");
	window_good = XtWindow(labelw_good);
	display_good = XtDisplay(labelw_good);
	tet_infoline("TEST: XtWindowToWidget translates to widget ID");
	widget_good = XtWindowToWidget(display_good, window_good);
	strcpy(string, XtName(widget_good) );
	check_str("Hello", string, "widget name");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
A call to 
Widget XtWindowToWidget(display, window)
when no realized widget exists whose window is 
.A window
on the specified display shall return NULL.
>>CODE
char ret_str[10];
Widget widget_bad, labelw_good;
Display *display_good; 
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Twindtowd2", "XtWindowToWidget");
	tet_infoline("PREP: Create test label widget `Hello' in box widget");
	labelw_good = (Widget) CreateLabelWidget("Hello", boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get display pointer of the test label widget");
	display_good = XtDisplay(labelw_good);
	tet_infoline("TEST: Invalid window id should not translate to widget ID");
	widget_bad = XtWindowToWidget(display_good, -999);
	if (widget_bad != NULL) {
		sprintf(ebuf, "ERROR: Expected NULL returned widget instance");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
