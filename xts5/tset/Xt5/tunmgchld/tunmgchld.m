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
$Header: /cvs/xtest/xtest/xts5/tset/Xt5/tunmgchld/tunmgchld.m,v 1.1 2005-02-12 14:38:14 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt5/tunmgchld/tunmgchld.m
>># 
>># Description:
>>#	Tests for XtUnmanageChild()
>># 
>># Modifications:
>># $Log: tunmgchld.m,v $
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
>># Revision 4.0  1995/12/15 09:16:39  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:20:39  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>
#include <X11/Xaw/Label.h>
#include <AvsComp2.h>

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
>>TITLE XtUnmanageChild Xt5
void
XtUnmanageChild(w)
>>ASSERTION Good A
A successful call to 
void XtUnmanageChild(w) 
when the widget w is managed by its parent shall make the widget to be 
unmanaged. 
>>CODE
Boolean status;
Widget labelw_good;

	avs_xt_hier("Tunmgchld1", "XtUnmanageChild");
	tet_infoline("PREP: Create a managed widget labelw_good");
	labelw_good = (Widget) CreateLabelWidget("Hello", boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Unmanage child");
	XtUnmanageChild(labelw_good);
	tet_infoline("TEST: labelw_good widget is managed shall return False");
	status = XtIsManaged(labelw_good);
	tet_result(TET_PASS);
>>ASSERTION Good B 0
On a successful call to 
void XtUnmanageChild(w) 
when the widget w is realized and has become unmanaged the window of the 
widget shall be unmapped.
>>ASSERTION Good A
When the parent is realized and the widget w has become unmanaged
a successful call to 
void XtUnmanageChild(w) 
shall invoke the change_managed routine of the parent.
>>CODE
int status;
Widget test2_widget, test_widget;

	avs_xt_hier("Tunmgchdn2", "XtUnmanageChild");
	tet_infoline("PREP: Create a test parent");
	test_widget = XtVaCreateManagedWidget("avsw2", avsComp2WidgetClass, boxw1, NULL);
	tet_infoline("PREP: Create a managed child widget");
	test2_widget = (Widget) CreateLabelWidget("Hello", test_widget);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Unmanage child");
	XtUnmanageChild(test2_widget);
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
When the parent of the widget w is not a subclass of compositeWidgetClass 
a successful call to 
void XtUnmanageChild(w) 
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

	avs_xt_hier("Tunmgchdn4", "XtUnmanageChild");
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
	XtUnmanageChild(labelw_good);
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
>>ASSERTION Good B 3
A successful call to 
void XtUnmanageChild(w) 
when the parent of the widget w is being destroyed shall return immediately.
>>ASSERTION Good B 3
A call to 
void XtUnmanageChild(w) 
when the widget w is in the process of being destroyed shall return without
unmanaging the widget.
>>ASSERTION Good A
A call to 
void XtUnmanageChild(w) 
when the widget w is already unmanaged shall have no effect.
>>CODE
int status;
Widget test2_widget, test_widget;

	avs_xt_hier("Tunmgchdn2", "XtUnmanageChild");
	tet_infoline("PREP: Create a test parent");
	test_widget = XtVaCreateManagedWidget("avsw2", avsComp2WidgetClass, boxw1, NULL);
	tet_infoline("PREP: Create a managed child widget");
	test2_widget = (Widget) CreateLabelWidget("Hello", test_widget);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Unmanage child");
	XtUnmanageChild(test2_widget);
	tet_infoline("TEST: Change managed procedure invoked");
	/*this is a test widget class with a special change managed routine*/
	/*that sets this when its called - see AvsComp2.h in the avsxt library*/
	status = avs_get_event(5);
	if (status != 1) {
		sprintf(ebuf, "ERROR: Change_managed routine not invoked");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Unmanage child again");
	XtUnmanageChild(test2_widget);
	tet_infoline("TEST: Change managed procedure not invoked");
	avs_set_event(5, 0);
	status = avs_get_event(5);
	if (status != 0) {
		sprintf(ebuf, "ERROR: Change_managed routine was invoked again");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
