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
$Header: /cvs/xtest/xtest/xts5/tset/Xt5/tmngchild/tmngchild.m,v 1.1 2005-02-12 14:38:14 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt5/tmngchild/tmngchild.m
>># 
>># Description:
>>#	Tests for XtManageChild()
>># 
>># Modifications:
>># $Log: tmngchild.m,v $
>># Revision 1.1  2005-02-12 14:38:14  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:36:34  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:59:26  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:27:43  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:17  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:16:32  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:20:30  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>
#include <X11/Xaw/Label.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;

void XtWMH_Proc(str1, str2, str3, str4, str5, car)
String str1, str2, str3, str4, *str5;
Cardinal *car;
{
	avs_set_event(1,1);
	exit(1);
}

>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtManageChild Xt5
void
XtManageChild(w)
>>ASSERTION Good A
A call to void XtManageChild(w) when widget w is not realized and has the
map_when_managed field set to True and the parent of the widget is 
realized shall call the change_managed procedure of the parent, realize 
the widget, and map the widget window.
>>CODE
Boolean status;
Widget labelw_good;

	avs_xt_hier("Tmngchild1", "XtManageChild");
	tet_infoline("PREP: Create a labelw_good widget");
	labelw_good = XtVaCreateWidget(
			"labelw_good",
			labelWidgetClass,
			boxw1,
			NULL
			);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Add widget labelw_good to parent's managed widget boxw1 list");
	XtManageChild(labelw_good);
	tet_infoline("TEST: labelw_good widget is managed shall return True");
	status = XtIsManaged(labelw_good);
	check_dec(True, status, "XtIsManaged return value");
	tet_result(TET_PASS);
>>ASSERTION Good B 0
On a successful call to void XtManageChild(w) when the widget w has the 
map_when_managed field set to a value other than True its
window shall not be mapped.
>>ASSERTION Good A
A call to void XtManageChild(w) when the parent of the widget w 
does not belong to a subclass of compositeWidgetClass shall issue an 
error.
>>CODE
Boolean status;
Widget labelw_good, labelw_good2;
pid_t pid2;
int invoked;

	FORK(pid2);
	avs_xt_hier("Tmngchild3", "XtManageChild");
	XtAppSetErrorMsgHandler(app_ctext, XtWMH_Proc);
	tet_infoline("PREP: Create test widgets");
	labelw_good = XtVaCreateWidget(
			"labelw_good",
			coreWidgetClass,
			boxw1,
			NULL
			);
	labelw_good2 = XtVaCreateWidget(
			"labelw_good2",
			coreWidgetClass,
			labelw_good,
			NULL
			);
	(void) ConfigureDimension(topLevel, labelw_good);
	(void) ConfigureDimension(topLevel, labelw_good2);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Manage a widget with non-composite parent");
	XtManageChild(labelw_good2);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Error handler was invoked");
	invoked = avs_get_event(1);
	if (!invoked) {
		sprintf(ebuf, "ERROR: Error handler was not invoked");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
>>ASSERTION Good B 3
A call to void XtManageChild(w) when the parent of the widget w is in the 
process of being destroyed shall return immediately.
>>ASSERTION Good B 3
A call to void XtManageChild(w) when the widget w is in the process of 
being destroyed shall return immediately.
>>ASSERTION Good A
A call to void XtManageChild(w) when the widget w is already managed 
shall return immediately.
>>CODE
Boolean status;
Widget labelw_good;

	avs_xt_hier("Tmngchild1", "XtManageChild");
	tet_infoline("PREP: Create a labelw_good widget");
	labelw_good = XtVaCreateWidget(
			"labelw_good",
			labelWidgetClass,
			boxw1,
			NULL
			);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Add widget labelw_good to parent's managed widget boxw1 list");
	XtManageChild(labelw_good);
	tet_infoline("PREP: Call XtManageChild again for widget");
	XtManageChild(labelw_good);
	tet_result(TET_PASS);
