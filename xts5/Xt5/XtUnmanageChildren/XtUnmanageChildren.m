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
>># File: xts/Xt5/XtUnmanageChildren/XtUnmanageChildren.m
>># 
>># Description:
>>#	Tests for XtUnmanageChildren()
>># 
>># Modifications:
>># $Log: tunmgchdn.m,v $
>># Revision 1.1  2005-02-12 14:38:14  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:36:36  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:59:28  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:27:45  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:19  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.1  1996/11/05 22:39:12  andy
>># For TP4, change to require a warning message rather than an error.
>># Per req.4.W.00027
>>#
>># Revision 4.0  1995/12/15  09:16:38  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:20:37  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>
#include <AvsComp2.h>
#include <X11/Xaw/Label.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;

void XtEMH2_Proc(str1, str2, str3, str4, str5, car)
String str1, str2, str3, str4, *str5;
Cardinal *car;
{
	avs_set_event(2,1);
}
/*
** Installed Error handler
*/
void XtEMH_Proc(str1, str2, str3, str4, str5, car)
String str1, str2, str3, str4, *str5;
Cardinal *car;
{
	avs_set_event(1,1);
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtUnmanageChildren Xt5
void
XtUnmanageChildren(children, num_children)
>>ASSERTION Good A
A successful call to 
void XtUnmanageChildren(children, num_children) 
shall cause each specified child widget which is managed by the parent 
to be unmanaged.
>>CODE
Boolean value_good;
Widget labelw1, labelw2;
Widget children[2];


	avs_xt_hier("Tunmgchdn1", "XtUnmanageChildren");
	tet_infoline("PREP: Create a managed widget labelw1");
	labelw1 = (Widget) CreateLabelWidget("Hello", boxw1);
	tet_infoline("PREP: Create a managed widget labelw2");
	labelw2 = (Widget) CreateLabelWidget("World", boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Remove list of children from the parent managed widget list");
	children[0] = labelw1;
	children[1] = labelw2;
	XtUnmanageChildren(children, 2);
	tet_infoline("TEST: Children are not managed");
	value_good = XtIsManaged(labelw1);
	check_dec(False, value_good, "XtIsManaged return value");
	value_good = XtIsManaged(labelw2);
	check_dec(False, value_good, "XtIsManaged return value");
	tet_result(TET_PASS);
>>ASSERTION Good B 0
A successful call to 
void XtUnmanageChildren(children, num_children) 
shall unmap the widget window of each realized child widget that has 
become unmanaged.
>>ASSERTION Good A
When the parent is realized and at least one child widget has become unmanaged
a successful call to 
void XtUnmanageChildren(children, num_children) 
shall invoke the change_managed routine of the parent.
>>CODE
int status;
Widget children[2];
Widget test_widget, test2_widget;

	avs_xt_hier("Tunmgchdn2", "XtUnmanageChildren");
	tet_infoline("PREP: Create a test parent");
	test_widget = XtVaCreateManagedWidget("avsw2", avsComp2WidgetClass, boxw1, NULL);
	tet_infoline("PREP: Create a managed child widget");
	test2_widget = (Widget) CreateLabelWidget("Hello", test_widget);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	children[0] = test2_widget;
	XtUnmanageChildren(children, 1);
	tet_infoline("TEST: Change managed procedure invoked");
	/*this is a test widget class with a special change managed routine*/
	/*that sets this when its called - see AvsComp2.h in the avsxt library*/
	status = avs_get_event(5);
	if (status != 1 ) {
		sprintf(ebuf, "ERROR: Change_managed routine not invoked");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
>>ASSERTION Good A
When the widgets specified by children do not all have the same parent
a call to 
void XtUnmanageChildren(children, num_children) 
shall issue a warning message and continue.
>>CODE
Boolean value_good;
Widget labelw1, labelw2;
Widget children[2];
Widget rowcolw_good;
int invoked;

	avs_xt_hier("Tunmgchdn2", "XtUnmanageChildren");
	tet_infoline("PREP: Create managed child widget labelw1 in boxw1");
	labelw1 = (Widget) CreateLabelWidget("Hello", boxw1);
	tet_infoline("PREP: Create rowcolw_good widget in boxw1 widget");
	rowcolw_good = (Widget) CreateRowColWidget(boxw1);
	tet_infoline("PREP: Create managed child widget labelw2 in rowcolw_good");
	labelw2 = (Widget) CreateLabelWidget("World", rowcolw_good);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Register error handler");
	XtAppSetWarningMsgHandler(app_ctext, XtEMH2_Proc);
	XtAppSetErrorMsgHandler(app_ctext, XtEMH_Proc);
	tet_infoline("PREP: Unmange children, with different parents");
	children[0] = labelw1;
	children[1] = labelw2;
	XtUnmanageChildren(children, 2);
	tet_infoline("TEST: Error message was generated");
	invoked = avs_get_event(2);
	if (!invoked) {
		sprintf(ebuf, "ERROR: Warning handler was not invoked");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	invoked = avs_get_event(1);
	if (invoked) {
		sprintf(ebuf, "ERROR: Error message was issued instead of warning message");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
>>ASSERTION Good A
When the parent of the widgets specified by children is not a subclass of 
compositeWidgetClass a call to 
void XtUnmanageChildren(children, num_children) 
shall issue an invalidParent error.
>>CODE
Widget menuw;
Widget labelw_good;
Widget pushb_good;
Boolean value_good;
Widget labelw1, labelw2;
Widget children[2];
Widget rowcolw_good;
int invoked;

	avs_xt_hier("Tunmgchdn4", "XtUnmanageChildren");
	tet_infoline("PREP: Create child of non-Composite widget");
	labelw_good = XtVaCreateWidget(
			"ApTest",		 /* arbitrary widget name */
			labelWidgetClass,	/* widget class */
			labelw,			/* parent widget */
			(char *)NULL		/* terminate list */
			);
	tet_infoline("PREP: Register error handler");
	XtAppSetErrorMsgHandler(app_ctext, XtEMH_Proc);
	XtAppSetWarningMsgHandler(app_ctext, XtEMH2_Proc);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Unmanage child of non-composite widget");
	children[0] = labelw_good;
	XtUnmanageChildren(children, 1);
	tet_infoline("TEST: Error handler was invoked");
	invoked = avs_get_event(1);
	if (!invoked) {
		sprintf(ebuf, "ERROR: Error handler was not invoked");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	invoked = avs_get_event(2);
	if (invoked) {
		sprintf(ebuf, "ERROR: Warning message was generated instead of error message");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
>>ASSERTION Good B 1
When the parent of the widgets specified by children is being destroyed
a call to 
void XtUnmanageChildren(children, num_children) 
shall return immediately.
>>ASSERTION Good B 1
A call to 
void XtUnmanageChildren(children, num_children) 
shall ignore those child widgets which are in the process of being destroyed.
>>ASSERTION Good A
A call to 
void XtUnmanageChildren(children, num_children) 
shall ignore those child widgets which are already unmanaged.
>>CODE
int status;
Widget children[2];
Widget test_widget, test2_widget;

	avs_xt_hier("Tunmgchdn2", "XtUnmanageChildren");
	tet_infoline("PREP: Create a test parent");
	test_widget = XtVaCreateManagedWidget("avsw2", avsComp2WidgetClass, boxw1, NULL);
	tet_infoline("PREP: Create a managed child widget");
	test2_widget = (Widget) CreateLabelWidget("Hello", test_widget);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	children[0] = test2_widget;
	tet_infoline("TEST: Call XtUnmanageChildren");
	XtUnmanageChildren(children, 1);
	tet_infoline("TEST: Change managed procedure invoked");
	/*this is a test widget class with a special change managed routine*/
	/*that sets this when its called - see AvsComp2.h in the avsxt library*/
	status = avs_get_event(5);
	if (status != 1 ) {
		sprintf(ebuf, "ERROR: Change_managed routine not invoked");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	avs_set_event(5, 0);
	tet_infoline("TEST: Call XtUnmanageChildren again");
	XtUnmanageChildren(children, 1);
	tet_infoline("TEST: Change managed procedure was not invoked");
	status = avs_get_event(5);
	if (status != 0 ) {
		sprintf(ebuf, "ERROR: Change_managed routine was invoked again");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
