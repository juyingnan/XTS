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
>># File: xts/Xt4/XtDisplayOfObject/XtDisplayOfObject.m
>># 
>># Description:
>>#	Tests for XtDisplayOfObject()
>># 
>># Modifications:
>># $Log: tdisplofo.m,v $
>># Revision 1.1  2005-02-12 14:38:00  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:36:30  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:59:20  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:27:39  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:13  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:16:22  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:20:17  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;
>>TITLE XtDisplayOfObject Xt4
Display *
XtDisplayOfObject(object)
>>ASSERTION Good A
A call to Display *XtDisplayOfObject(object) when object is a widget 
shall return the display pointer for the widget.
>>CODE
Widget labelw_good , widget_good;
Display *display_good;
Window window_good;

	avs_xt_hier("Tdisplofo1", "XtDisplayOfObject");
	tet_infoline("PREP: Create label widget `Hello' in boxw1 widget");
	labelw_good = (Widget) CreateLabelWidget("Hello", boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Get the display pointer for label widget `Hello' ");
	if ((display_good = XtDisplayOfObject(labelw_good) ) == NULL ) {
		sprintf(ebuf, "ERROR: Expected display pointer returned NULL");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Display pointer is valid for widget");
	window_good = XtWindow(labelw_good);
	widget_good = XtWindowToWidget(display_good, window_good);
	check_str("Hello", XtName(widget_good), "widget name");
	tet_result(TET_PASS);
>>ASSERTION Good A
A call to Display *XtDisplayOfObject(object) when object is not a widget
shall return the display pointer of the nearest ancestor of object
that belongs to class Widget or a subclass thereof.
>>CODE
Widget widget_good;
Display *display_good;
Window window_good;

	avs_xt_hier("Tdisplofo2", "XtDisplayOfObject");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Get the display pointer for nearest widget");
	tet_infoline("      to push button gadget");
	if ( ( display_good = XtDisplayOfObject(click_quit) ) == NULL ) {
		sprintf(ebuf, "ERROR: Expected valid display pointer returned NULL");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Display pointer is valid");
	window_good = XtWindow(rowcolw);
	widget_good = XtWindowToWidget(display_good, window_good);
	check_str("rowcolw", XtName(widget_good), "widget name");
	tet_result(TET_PASS);
