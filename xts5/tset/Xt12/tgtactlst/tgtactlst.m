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
$Header: /cvs/xtest/xtest/xts5/tset/Xt12/tgtactlst/tgtactlst.m,v 1.1 2005-02-12 14:37:56 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt12/tgtactlst/tgtactlst.m
>># 
>># Description:
>>#	Tests for XtGetActionList()
>># 
>># Modifications:
>># $Log: tgtactlst.m,v $
>># Revision 1.1  2005-02-12 14:37:56  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:38:05  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:04  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:29:07  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:25:41  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:21:21  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:17:04  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>
#include <X11/Composite.h>
#include <AvsComp.h>
#include <AvsComp2.h>
#include <AvsRectObj.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtGetActionList Xt12
void
XtGetActionList(widget_class, actions_return, num_actions_return)
>>ASSERTION Good C
If the implementation is X11R5 or greater:
A call to
void XtGetActionList(widget_class, actions_return, num_actions_return)
shall return the action table defined by the widget class
.A widget_class
in 
.A actions_return
and the number of action procedures on the list in
.A num_actions_return.
>>CODE
#if XT_X_RELEASE > 4
Widget test_widget;
Widget test_widget2;
XEvent event;
Display *display;
WidgetClass	my_class;
XtActionList	my_list;
Cardinal	num_actions_return;
pid_t pid2;
#endif

#if XT_X_RELEASE > 4
	FORK(pid2);
	avs_xt_hier("Tgtactlst1", "XtGetActionList");
	tet_infoline("PREP: Create composite AVS widget");
	test_widget = XtVaCreateManagedWidget("avsw", avsCompWidgetClass, boxw1, NULL);
	test_widget2 = XtVaCreateManagedWidget("avsw2", avsComp2WidgetClass, test_widget, NULL);
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Call XtGetActionList on composite AVS widget");
	my_class = avsComp2WidgetClass;
	XtGetActionList(my_class, (XtActionList *)&my_list, &num_actions_return);
	tet_infoline("TEST: Verify XtGetActionList returns proper actions");
	if (my_list == NULL) {
		sprintf(ebuf, "ERROR: actions_return should not be NULL");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	if (num_actions_return != 2) {
		sprintf(ebuf, "ERROR: num_actions_return should be 2, is %d", num_actions_return);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	if (strcmp(my_list->string, "action11") != 0) {
		sprintf(ebuf, "ERROR: first action should be action11, is %s", my_list->string);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	my_list++;
	if (strcmp(my_list->string, "action12") != 0) {
		sprintf(ebuf, "ERROR: second action should be action12, is %s", my_list->string);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
>>ASSERTION Good C
If the implementation is X11R5 or greater:
A call to
void XtGetActionList(widget_class, actions_return, num_actions_return)
shall not return the action tables defined by the superclasses of
the widget class
.A widget_class.
>>CODE
#if XT_X_RELEASE > 4
Widget test_widget;
Widget test_widget2;
XEvent event;
Display *display;
WidgetClass	my_class;
XtActionList	my_list;
Cardinal	num_actions_return;
pid_t pid2;
#endif

#if XT_X_RELEASE > 4
	FORK(pid2);
	avs_xt_hier("Tgtactlst1", "XtGetActionList");
	tet_infoline("PREP: Create composite AVS widget");
	test_widget = XtVaCreateManagedWidget("avsw", avsCompWidgetClass, boxw1, NULL);
	test_widget2 = XtVaCreateManagedWidget("avsw2", avsComp2WidgetClass, test_widget, NULL);
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Call XtGetActionList on composite AVS widget");
	my_class = avsComp2WidgetClass;
	XtGetActionList(my_class, (XtActionList *)&my_list, &num_actions_return);
	tet_infoline("TEST: Verify XtGetActionList returns proper actions");
	if (my_list == NULL) {
		sprintf(ebuf, "ERROR: actions_return should not be NULL");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	if (strcmp(my_list->string, "action1") == 0) {
		sprintf(ebuf, "ERROR: superclass' actions being reported");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	my_list++;
	if (strcmp(my_list->string, "action2") == 0) {
		sprintf(ebuf, "ERROR: superclass' actions being reported");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
>>ASSERTION Good C
If the implementation is X11R5 or greater:
A call to
void XtGetActionList(widget_class, actions_return, num_actions_return)
when the widget class
.A widget_class
is not initialized
shall return NULL in 
.A actions_return 
and zero in 
.A num_actions_return.
>>CODE
#if XT_X_RELEASE > 4
Widget test_widget;
XEvent event;
Display *display;
WidgetClass	my_class, my_superclass;
XtActionList	*my_list, *my_Superclass_list;
Cardinal	num_actions_return = 10;
pid_t pid2;
#endif

#if XT_X_RELEASE > 4
	FORK(pid2);
	avs_xt_hier("Tgtactlst4","XtGetActionList");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Verify XtGetActionList indicates no actions");
	my_class = avsCompWidgetClass;
	XtGetActionList(my_class, (XtActionList *)&my_list, &num_actions_return);
	if (my_list != NULL) {
		sprintf(ebuf, "ERROR: actions_return should be NULL");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	if (num_actions_return != 0) {
		sprintf(ebuf, "ERROR: num_actions_return should be 0, is %d", num_actions_return);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
>>ASSERTION Good C
If the implementation is X11R5 or greater:
A call to
void XtGetActionList(widget_class, actions_return, num_actions_return)
when the widget class
.A widget_class
is not 
.S coreWidgetClass
or a subclass thereof shall return NULL in 
.A actions_return 
and zero in 
.A num_actions_return.
>>CODE
#if XT_X_RELEASE > 4
Widget test_widget;
Widget test_widget2;
XEvent event;
Display *display;
WidgetClass	my_class;
XtActionList	my_list;
Cardinal	num_actions_return;
pid_t pid2;
#endif

#if XT_X_RELEASE > 4
	FORK(pid2);
	avs_xt_hier("Tgtactlst1", "XtGetActionList");
	tet_infoline("PREP: Create AVS RectObj widget");
	test_widget = XtVaCreateManagedWidget("avsro", avsrectObjClass, topLevel, NULL);
	XtRealizeWidget(topLevel);
	/*this widget has two actions but is not a subclass of core*/
	tet_infoline("TEST: Verify XtGetActionList returns no actions");
	my_class = avsrectObjClass;
	XtGetActionList(my_class, &my_list, &num_actions_return);
	if (my_list != NULL) {
		sprintf(ebuf, "ERROR: actions_return should be NULL");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	if (num_actions_return != 0) {
		sprintf(ebuf, "ERROR: num_actions_return should be 0, is %d", num_actions_return);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
>>ASSERTION Good C
If the implementation is X11R5 or greater:
A call to
void XtGetActionList(widget_class, actions_return, num_actions_return)
when the widget class
.A widget_class
does not define any actions shall return NULL in 
.A actions_return 
and zero in 
.A num_actions_return.
>>CODE
#if XT_X_RELEASE > 4
Widget test_widget;
XEvent event;
Display *display;
WidgetClass	my_class, my_superclass;
XtActionList	*my_list, *my_Superclass_list;
Cardinal	num_actions_return = 10;
pid_t pid2;
#endif

#if XT_X_RELEASE > 4
	FORK(pid2);
	avs_xt_hier("Tgtactlst4", "XtGetActionList");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Verify XtGetActionList indicates no actions");
	my_class =compositeWidgetClass;
	XtGetActionList(my_class, (XtActionList *)&my_list, &num_actions_return);
	if (my_list != NULL) {
		sprintf(ebuf, "ERROR: actions_return should be NULL");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	if (num_actions_return != 0) {
		sprintf(ebuf, "ERROR: num_actions_return should be 0, is %d", num_actions_return);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
