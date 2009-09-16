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
>># File: xts/Xt4/XtParent/XtParent.m
>># 
>># Description:
>>#	Tests for XtParent()
>># 
>># Modifications:
>># $Log: tparent.m,v $
>># Revision 1.1  2005-02-12 14:38:03  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:36:28  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:59:18  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:27:38  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:12  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:16:20  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:20:12  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;
>>TITLE XtParent Xt4
Widget
XtParent(w)
>>ASSERTION Good A
A call to Widget XtParent(w) shall return the parent object for the widget w.
>>CODE
Widget ret_parent, test_lw, test_rw;
Widget widget_good , labelw_good; 
Widget rowcolw_good;

	avs_xt_hier("Tparent1", "XtParent");
	tet_infoline("PREP: Create rowcolw_good widget in box1w widget");
	rowcolw_good = (Widget) CreateRowColWidget(boxw1);
	tet_infoline("PREP: Create test label widget name `Hello' in first box widget");
	labelw_good = (Widget) CreateLabelWidget("Hello", rowcolw_good);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: A call to XtParent shall return parent row column widget");
	tet_infoline("      of the label Hello widget");
	widget_good = (Widget)XtParent(labelw_good);
	if (widget_good == NULL) {
	 	tet_infoline("ERROR: Expected parent widget instance returned NULL");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Returned widget is indeed parent row column widget");
	check_str("rowcolw", XtName(widget_good), "widget name");
	tet_result(TET_PASS);
