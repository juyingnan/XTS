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
$Header: /cvs/xtest/xtest/xts5/tset/Xt4/tdestywid/tdestywid.m,v 1.1 2005-02-12 14:38:00 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt4/tdestywid/tdestywid.m
>># 
>># Description:
>>#	Tests for XtDestroyWidget()
>># 
>># Modifications:
>># $Log: tdestywid.m,v $
>># Revision 1.1  2005-02-12 14:38:00  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:36:32  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:59:23  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.1  1998/06/22 23:04:17  andy
>># Altered test 1 so second call to XtDestroyWidget is made from with
>># destroy callback. SR 181.
>>#
>># Revision 6.0  1998/03/02 05:27:42  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:15  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:16:28  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:20:24  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;

/* procedure XtTMO_Proc */
void XtTMO_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
        exit(0);
}

void analyse_events(widget)
Widget widget;
{
	XtAppContext app_context;
	Display *display;
	XEvent loop_event;
	XEvent return_event;
	app_context = XtWidgetToApplicationContext(widget);
	display = XtDisplay(widget);
	for (;;) {
	 XtAppNextEvent(app_context, &loop_event);
	 XSync(display, False);
	 if (loop_event.type == DestroyNotify) {
		avs_set_event(1,1);
		XtAppNextEvent(app_context, &return_event);
		if (return_event.type == DestroyNotify) {
				avs_set_event(2,1);
			exit(0);
		}
	 } /* end if */
	 XtDispatchEvent(&loop_event);
	} /* end for */
}

Boolean flag;

Widget labelw_msg1;

void XtCBP(w, client_data, call_data)
Widget w;
XtPointer client_data, call_data;
{
	tet_infoline("TEST: Destroy labelw_msg1 widget within destroy callback");
	XtDestroyWidget(labelw_msg1);
	avs_set_event(2, avs_get_event(2)+1);
}
void XtCBP_ChildProc(w, client_data, call_data)
Widget w;
XtPointer client_data, call_data;
{
	flag = True;
	avs_set_event(1, 1);
}
void XtCBP_ParentProc(w, client_data, call_data)
Widget w;
XtPointer client_data, call_data;
{
	/*
	** XtCBP_ChildProc to be invoked before XtCBP_ParentProc
	*/
	if (flag)
	avs_set_event(2, 1);
	else {
		sprintf(ebuf, "ERROR: XtCBP_ChildProc to be invoked before XtCBP_ParentProc");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtDestroyWidget Xt4
void
XtDestroyWidget(w)
>>ASSERTION Good A
A call to void XtDestroyWidget(w)
when the being_destroyed field of the widget w is True shall return
immediately.
>>CODE
XEvent loop_event;
char *msg = "Test widget";
Display *display;
Window window;
int status = 0;
pid_t	pid2;
int	i;
Widget rowcolw_good;
Widget labelw_good;
Window rowcolw_good_window;
Window labelw_good_window;

	FORK(pid2);
	avs_xt_hier("Tdestywid1", "XtDestroyWidget");
	tet_infoline("PREP: Create labelw_msg1 widget in boxw1 widget");
	labelw_msg1 = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Catch DestroyNotify event");
	display = XtDisplay(labelw_msg1);
	window = XtWindow(labelw_msg1);
	XSelectInput(display, window, StructureNotifyMask);
	tet_infoline("PREP: Add callback procedure XtCBP_ParentProc() to labelw_msg1");
	XtAddCallback(labelw_msg1,
			XtNdestroyCallback,
			XtCBP,
			(XtPointer)NULL
			);
	tet_infoline("TEST: Destroy labelw_msg1 widget");
	XtDestroyWidget(labelw_msg1);
	tet_infoline("PREP: Register timeout");
        XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTMO_Proc, topLevel);
	tet_infoline("TEST: DestroyNotify event generated just once");
	for (i = 0; i < 10; i++) {
		XtAppNextEvent(app_ctext, &loop_event);
		XSync(display, False);
		if (loop_event.type == DestroyNotify)
			avs_set_event(1,avs_get_event(1)+1);
		XtDispatchEvent(&loop_event);
		i= 0;
	}
	KROF(pid2);
	status = avs_get_event(1);
	check_dec(1, status, "DestroyNotify event count");
	tet_infoline("TEST: Destroy callback called just once");
	status = avs_get_event(2);
	check_dec(1, status, "Destroy callback count");
	tet_result(TET_PASS);
>>ASSERTION Good A
When it is not called from within an application callback routine and the 
widget w is not already being destroyed a call to void XtDestroyWidget(w)
shall perform the following actions in the order specified:

- call the destroy callback procedures registered for the widget w and
  all normal and pop-up descendents in postorder.

- if the widget w is not a pop-up child and the widget's parent is
  a subclass of compositeWidgetClass, and if the parent is not being
  destroyed, unmanage on the widget and call the widget's parent's 
  delete_child procedure.

- if the widget w is not a pop-up child and the widget's parent is
  a subclass of constraintWidgetClass, call the ConstraintClassPart
  destroy procedure for the parent, followed by the destroy procedures
  of the parent's superclass, up to and including the ConstraintClassPart
  destroy procedure for constraintWidgetClass.

- calls the destroy procedures for the widget and all normal and
  pop-up descendents in postorder, calling the CoreClassPart
  destroy procedure in each widget followed by the destroy
  procedures in its superclasses, up to and including the 
  Object class.

- if the widget w is realized destroy the window for the widget
  and the windows for all its normal descendents.

- recursively descend the tree and destroy the windows for all
  realized popup descendents.
>>CODE
XEvent loop_event;
Widget labelw_msg;
char *msg = "Test widget";
Display *display;
Window window;
int status = 0;
pid_t	pid2;
int	i;
Widget rowcolw_good;
Widget labelw_good;
Window rowcolw_good_window;
Window labelw_good_window;

	/*this is catenation of the earlier tests - needs enhancement*/
	avs_set_event(1,0);
	avs_set_event(2,0);
	FORK(pid2);
	avs_xt_hier("Tdestywid1", "XtDestroyWidget");
	tet_infoline("PREP: Create labelw_msg widget in boxw1 widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Catch DestroyNotify event");
	display = XtDisplay(labelw_msg);
	window = XtWindow(labelw_msg);
	XSelectInput(display, window, StructureNotifyMask);
	tet_infoline("TEST: Destroy labelw_msg widget");
	XtDestroyWidget(labelw_msg);
	tet_infoline("TEST: DestroyNotify event generated");
	for (i = 0; i < 10; i++) {
	 XtAppNextEvent(app_ctext, &loop_event);
	 XSync(display, False);
	 if (loop_event.type == DestroyNotify) {
		avs_set_event(1,1);
		exit(0);
	 }
	 XtDispatchEvent(&loop_event);
	 i= 0;
	}
	KROF(pid2);
	status = avs_get_event(1);
	check_dec(1, status, "DestroyNotify event count");
	avs_set_event(1,0);
	avs_set_event(2,0);
	FORK(pid2);
	avs_xt_hier("Tdestywid2", "XtDestroyWidget");
	tet_infoline("PREP: Create rowcolw_good widget in boxw1 widget");
	rowcolw_good = (Widget) CreateRowColWidget(boxw1);
	tet_infoline("PREP: Create labelw_good widget in rowcolw_good widget");
	labelw_good = (Widget) CreateLabelWidget("Hello", rowcolw_good);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Catch DestroyNotify event");
	display = XtDisplay(rowcolw_good);
	rowcolw_good_window = XtWindow(rowcolw_good);
	XSelectInput(display, rowcolw_good_window, StructureNotifyMask);
	labelw_good_window = XtWindow(labelw_good);
	XSelectInput(display, labelw_good_window, StructureNotifyMask);
	tet_infoline("TEST: Destroy rowcolw_good widget");
	XtDestroyWidget(rowcolw_good);
	analyse_events(rowcolw);
	KROF(pid2);
	tet_infoline("TEST: DestroyNotify event was generated for labelw_good");
	status = avs_get_event(1);
	check_dec(1, status, "DestroyNotify event count");
	tet_infoline("TEST: DestroyNotify event was generated for rowcolw_good");
	status = avs_get_event(2);
	check_dec(1, status, "DestroyNotify event count");
	avs_set_event(1,0);
	avs_set_event(2,0);
	FORK(pid2);
	avs_xt_hier("Tdestywid3", "XtDestroyWidget");
	tet_infoline("PREP: Create rowcolw_good widget in boxw1 widget");
	rowcolw_good = (Widget) CreateRowColWidget(boxw1);
	tet_infoline("PREP: Add callback procedure XtCBP_ParentProc() to rowcolw_good");
	XtAddCallback(rowcolw_good,
			XtNdestroyCallback,
			XtCBP_ParentProc,
			(XtPointer)NULL
			);
	tet_infoline("PREP: Create labelw_good widget in rowcolw_good widget");
	labelw_good = (Widget) CreateLabelWidget("Hello", rowcolw_good);
	tet_infoline("PREP: Add callback procedure XtCBP_ChildProc to labelw_good");
	XtAddCallback(labelw_good,
			XtNdestroyCallback,
			XtCBP_ChildProc,
			(XtPointer)NULL
			);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Destroy rowcolw_good widget");
	XtDestroyWidget(rowcolw_good);
	KROF(pid2);
	tet_infoline("TEST: XtCBP_ChildProc procedure was invoked");
	status = avs_get_event(1);
	check_dec(1, status, "callback called count");
	tet_infoline("TEST: XtCBP_ParentProc procedure was invoked");
	status = avs_get_event(2);
	check_dec(1, status, "callback called count");
	tet_result(TET_PASS);
>>ASSERTION Good B 0
When called from within an application callback routine, if the 
widget w is not already being destroyed a call to void XtDestroyWidget(w)
shall set the being_destroyed field of the widget w and its normal and
pop-up children but shall not take other action until XtDispatchEvent
is about to return, at which point it shall perform the following
actions in the order specified:

- call the destroy callback procedures registered for the widget w and
  all normal and pop-up descendents in postorder.

- if the widget w is not a pop-up child and the widget's parent is
  a subclass of compositeWidgetClass, and if the parent is not being
  destroyed, unmanage on the widget and call the widget's parent's 
  delete_child procedure.

- if the widget w is not a pop-up child and the widget's parent is
  a subclass of constraintWidgetClass, call the ConstraintClassPart
  destroy procedure for the parent, followed by the destroy procedures
  of the parent's superclass, up to and including the ConstraintClassPart
  destroy procedure for constraintWidgetClass.

- calls the destroy procedures for the widget and all normal and
  pop-up descendents in postorder, calling the CoreClassPart
  destroy procedure in each widget followed by the destroy
  procedures in its superclasses, up to and including the 
  Object class.

- if the widget w is realized destroy the window for the widget
  and the windows for all its normal descendents.

- recursively descend the tree and destroy the windows for all
  realized popup descendents.
