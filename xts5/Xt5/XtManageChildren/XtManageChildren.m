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
>># File: xts/Xt5/XtManageChildren/XtManageChildren.m
>># 
>># Description:
>>#	Tests for XtManageChildren()
>># 
>># Modifications:
>># $Log: tmngchdrn.m,v $
>># Revision 1.1  2005-02-12 14:38:14  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:36:33  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:59:24  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:27:43  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:16  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:16:30  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:20:28  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>
#include <X11/Xaw/Label.h>	/* label widget defs */

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
>>TITLE XtManageChildren Xt5
void
XtManageChildren(children, num_children)
>>ASSERTION Good A
A call to 
void XtManageChildren(children, num_children) 
shall call the change_managed procedure of the parent of the specified widgets,
realize the widgets which have not been realized, and map each previously 
unmanaged widget window that has the mapped_when_managed field set to True.
>>CODE
Boolean status1, status2;
Widget labelw1, labelw2;
Widget children[2];

	avs_xt_hier("Tmngchdrn1", "XtManageChildren");
	tet_infoline("PREP: Create unmanaged widget labelw1");
	labelw1 = XtVaCreateWidget(
			"Hello",	 /* widget name */
			labelWidgetClass,	/* widget class */
			boxw1,		/* parent widget */
			(char *)NULL		/* terminate list */
			);
	tet_infoline("PREP: Create unmanaged widget labelw2");
	labelw2 = XtVaCreateWidget(
			"World",	 /* widget name */
			labelWidgetClass,	/* widget class */
			boxw1,		/* parent widget */
			(char *)NULL		/* terminate list */
			);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Add list of children to parent managed widget list");
	children[0] = labelw1;
	children[1] = labelw2;
	XtManageChildren(&children[0], 2);
	tet_infoline("TEST: Child widget labelw1 is managed shall return True");
	status1 = XtIsManaged(labelw1);
	check_dec(True, status1, "XtIsManaged return value");
	tet_infoline("TEST: Child widget labelw2 is managed shall return True");
	status2 = XtIsManaged(labelw2);
	check_dec(True, status2, "XtIsManaged return value");
	tet_infoline("TEST: Child widget labelw1 is realized shall return True");
	status1 = XtIsRealized(labelw1);
	check_dec(True, status1, "XtIsRealized return value");
	tet_infoline("TEST: Child widget labelw2 is realized shall return True");
	status2 = XtIsRealized(labelw2);
	check_dec(True, status2, "XtIsRealized return value");
	tet_result(TET_PASS);
>>ASSERTION Good B 0
A call to void XtManageChildren(children, num_children) 
shall not map the windows of the widgets that have the
mapped_when_managed field set to a value other than True.
>>ASSERTION Good A
A call to void XtManageChildren(children, num_children) when the widgets
specified by children do not all have the same parent shall issue a 
warning message.
>>CODE
Boolean status1, status2;
Widget labelw1, labelw2;
Widget children[2];
int invoked;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tmngchdrn1", "XtManageChildren");
	tet_infoline("PREP: Create unmanaged widget labelw1");
	labelw1 = XtVaCreateWidget(
			"Hello",	 /* widget name */
			labelWidgetClass,	/* widget class */
			boxw1,		/* parent widget */
			(char *)NULL		/* terminate list */
			);
	tet_infoline("PREP: Create unmanaged widget labelw2");
	labelw2 = XtVaCreateWidget(
			"World",	 /* widget name */
			labelWidgetClass,	/* widget class */
			labelw1,		/* parent widget */
			(char *)NULL		/* terminate list */
			);
	XtAppSetWarningMsgHandler(app_ctext, XtWMH_Proc);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Manage a child and its child");
	children[0] = labelw1;
	children[1] = labelw2;
	XtManageChildren(&children[0], 2);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Warning handler was invoked");
	invoked = avs_get_event(1);
	if (!invoked) {
		sprintf(ebuf, "ERROR: Warning handler was not invoked");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
>>ASSERTION Good A
A call to 
void XtManageChildren(children, num_children) 
when the parent of
the widgets specified by children does not belong to a subclass of 
compositeWidgetClass shall issue an error.
>>CODE
Boolean status1, status2;
Widget labelw_good, labelw_good2;
Widget children[2];
int invoked;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tmngchdrn1", "XtManageChildren");
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
	tet_infoline("TEST: Manage a widget with a non-composite parent");
	children[0] = labelw_good2;
	XtManageChildren(&children[0], 1);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Error handler was invoked");
	invoked = avs_get_event(1);
	if (!invoked) {
		sprintf(ebuf, "ERROR: Error handler was not invoked");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
>>ASSERTION Good B 1
A call to void XtManageChildren(children, num_children) when the parent 
of the widgets specified by children is in the process of being destroyed
shall return immediately.
>>ASSERTION Good B 1
On a call to void XtManageChildren(children, num_children) when a widget
in the list of widgets specified by children is in the process of being 
destroyed it shall not be considered for being managed by its parent.
>>ASSERTION Good B 3
On a call to void XtManageChildren(children, num_children) when a widget
in the list of widgets specified by children is already managed it shall 
not be considered for being managed by its parent.
