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
$Header: /cvs/xtest/xtest/xts5/tset/Xt3/tissbclss/tissbclss.m,v 1.1 2005-02-12 14:38:00 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt3/tissbclss/tissbclss.m
>># 
>># Description:
>>#	Tests for XtIsSubclass()
>># 
>># Modifications:
>># $Log: tissbclss.m,v $
>># Revision 1.1  2005-02-12 14:38:00  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:36:06  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:58:53  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:27:18  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:23:51  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:15:14  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:18:45  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>
#include <X11/Xaw/Label.h>
#include <X11/Xaw/Command.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;
>>TITLE XtIsSubclass Xt3
Boolean
XtIsSubclass(w, widget_class)
>>ASSERTION Good A
A call to Boolean XtIsSubclass(w, widget_class) when the class of the 
widget w is equal to or is a subclass of the class widget_class shall
return True.
>>CODE
Boolean status;
Widget labelw_msg;
char *msg = "Test widget";

	avs_xt_hier("Tissbclass1", "XtIsSubclass");
	tet_infoline("PREP: Create test label widget in box widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1); 
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Check boxw2 widget is subclass of Composite widget");
	status = XtIsSubclass(boxw2, compositeWidgetClass);
	check_dec(True, status, "Return value");
   
	tet_infoline("TEST: Check labelw_msg widget is subclass of Core widget");
	status = XtIsSubclass(labelw_msg, coreWidgetClass);
	check_dec(True, status, "Return value");

	tet_infoline("TEST: Check labelw_msg widget is subclass of Label widget");
	status = XtIsSubclass(labelw_msg, labelWidgetClass);
	check_dec(True, status, "Return value");
   
	tet_result(TET_PASS);
>>ASSERTION Good A
A call to Boolean XtIsSubclass(w, widget_class) when the class of the 
widget w is neither equal to nor is a subclass of the class widget_class 
shall return a value other than True.
>>CODE
Boolean status;
Widget labelw_msg;
char *msg = "Test widget";

	avs_xt_hier("Tissbclass2", "XtIsSubclass");
	tet_infoline("PREP: Create test label widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1); 
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Labelw_msg widget is NOT a subclass of commandWidgetClass");
	status = XtIsSubclass(labelw_msg, commandWidgetClass);
	check_not_dec(True, status, "Return value");
	tet_result(TET_PASS);
