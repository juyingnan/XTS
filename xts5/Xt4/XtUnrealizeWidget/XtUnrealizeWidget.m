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
$Header: /cvs/xtest/xtest/xts5/tset/Xt4/XtUnrealizeWidget/XtUnrealizeWidget.m,v 1.1 2005-02-12 14:38:11 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt4/XtUnrealizeWidget/XtUnrealizeWidget.m
>># 
>># Description:
>>#	Tests for XtUnrealizeWidget()
>># 
>># Modifications:
>># $Log: tunrlzwgt.m,v $
>># Revision 1.1  2005-02-12 14:38:11  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:36:32  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:59:23  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:27:41  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:15  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:16:27  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:20:22  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;
>>TITLE XtUnrealizeWidget Xt4
void
XtUnrealizeWidget(w)
>>ASSERTION Good A
When w is realized a call to 
void XtUnrealizeWidget(w) 
shall destroy the windows associated with the widget w and its descendants.
>>CODE
Window window_bad;
Widget widget_good, labelw_good;
Widget rowcolw_good;
Display *display_good;
Boolean status;

	avs_xt_hier("Tunrlzwgt1", "XtUnrealizeWidget");
	tet_infoline("PREP: Create rowcolw_good widget in boxw1 widget");
	rowcolw_good = (Widget) CreateRowColWidget(boxw1);
	tet_infoline("PREP: Create test label widget `Hello' in rowcolw_good widget");
	labelw_good = (Widget) CreateLabelWidget("Hello", rowcolw_good);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Unrealize rowcolw_good widget");
	XtUnrealizeWidget(rowcolw_good);
	tet_infoline("TEST: Root widget rowcolw_good is unrealized");
	status = XtIsRealized(rowcolw_good);
	check_dec(False, status, "XtIsRealized return value");
	tet_infoline("TEST: Leaf widget labelw_good is unrealized");
	status = XtIsRealized(labelw_good);
	check_dec(False, status, "XtIsRealized return value");
	tet_infoline("TEST: Window of rowcolw_good widget is destroyed");
	if ((window_bad = XtWindow(rowcolw_good)) > 0) {
		sprintf(ebuf, "ERROR: Expected Invalid window id received %d", window_bad);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
>>ASSERTION Good A
When w is unrealized a call to 
void XtUnrealizeWidget(w) 
shall have no effect.
>>CODE
Window window_bad;
Widget widget_good, labelw_good;
Widget rowcolw_good;
Display *display_good;
Boolean status;

	avs_xt_hier("Tunrlzwgt1", "XtUnrealizeWidget");
	tet_infoline("PREP: Create rowcolw_good widget in boxw1 widget");
	rowcolw_good = (Widget) CreateRowColWidget(boxw1);
	tet_infoline("PREP: Create test label widget `Hello' in rowcolw_good widget");
	labelw_good = (Widget) CreateLabelWidget("Hello", rowcolw_good);
	tet_infoline("PREP: Unrealize rowcolw_good widget");
	XtUnrealizeWidget(rowcolw_good);
	tet_result(TET_PASS);
>>ASSERTION Good B 3
When w is realized and managed a call to 
void XtUnrealizeWidget(w) 
shall remove it from the managed list of its parent.
>>ASSERTION Good B 0
When w is realized a call to 
void XtUnrealizeWidget(w) 
shall make a child-to-parent traversal of the widget tree with the widget w as
the root and call the procedures on the XtNunrealizeCallback list of each
widget that has a callback list resource named "unrealizeCallback" defined.
