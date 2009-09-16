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
>># File: tset/Xt7/XtVaCreatePopupShell/XtVaCreatePopupShell.m
>># 
>># Description:
>>#	Tests for XtVaCreatePopupShell()
>># 
>># Modifications:
>># $Log: tvacrpshl.m,v $
>># Revision 1.1  2005-02-12 14:38:21  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:36:46  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:59:38  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:27:53  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:27  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:17:15  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:21:23  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>
#include <X11/ShellP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;
ShellWidget menuw;
Widget labelw_good;
Widget pushb_good, rowcolw_good;

/*timeout callback*/
void XtTI_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	if (menuw->shell.popped_up == False) {
		tet_infoline("ERROR: Shell is not popped up");
		tet_result(TET_FAIL);
	}
	exit(0);
}

void XtCBP_Proc(w, client_data, call_data)
Widget w;
XtPointer client_data;
XtPointer call_data;
{
	avs_set_event(1,1);
	exit(0);
}

>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtVaCreatePopupShell Xt7
Widget
XtVaCreatePopupShell(name, widget_class, parent, ...)
>>ASSERTION Good A
A successful call to 
Widget XtVaCreatePopupShell(name, widget_class, parent, ...)
shall create a pop-up shell widget belonging to the class widget_class, 
name the widget instance as name, make it a pop-up child of parent, 
and return a pointer to the pop-up shell widget instance structure.
>>CODE
int status = 0;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tvacrpsh1", "XtVaCreatePopupShell");
	tet_infoline("PREP: Create labelw_good widget");
	labelw_good = (Widget) CreateLabelWidget("ApTest", boxw1);
	tet_infoline("TEST: Create a popup shell");
	menuw = (ShellWidget)XtVaCreatePopupShell("menuw", overrideShellWidgetClass, labelw_good, NULL);
	tet_infoline("PREP: Create a rowcolw_good widget");
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	tet_infoline("PREP: Create pushb_good button Hello in rowcolw_good widget");
	pushb_good = (Widget) CreatePushButtonGadget( "Hello", rowcolw_good);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTI_Proc, NULL);
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Map a Pop-up shell.");
	XtPopup((Widget)menuw, XtGrabExclusive);
	tet_infoline("TEST: Shell is popped-up");
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When the resource XtNpopupCallback is specified, a call
to Widget XtVaCreatePopupShell(name, widget_class, parent, ...)
shall register callback procedures on the shell's pop-up callback
list that shall be invoked when the widget is popped up.
>>CODE
char label[80];
int status = 0;
pid_t pid2;
XtCallbackRec callbacks[2] = {
	{ (XtCallbackProc) XtCBP_Proc, (XtPointer) NULL },
	{ (XtCallbackProc) NULL, (XtPointer) NULL }
};

	FORK(pid2);
	avs_xt_hier("Tvacrpshl2", "XtVaCreatePopupShell");
	tet_infoline("PREP: Create labelw_good widget Press Me");
	labelw_good = (Widget) CreateLabelWidget("Press Me", boxw1);
	tet_infoline("TEST: Create a vacrpshl shell");
	menuw = (ShellWidget)XtVaCreatePopupShell("menuw",
				overrideShellWidgetClass,
				labelw_good, 
				XtNpopupCallback,
				&callbacks[0],
				(char *)NULL);
	tet_infoline("PREP: Create a rowcolw_good widget");
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	tet_infoline("PREP: Create pushb_good button Hello in rowcolw_good widget");
	pushb_good = (Widget) CreatePushButtonGadget(
				"Hello",
				rowcolw_good);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Map a Pop-up shell.");
	XtPopup((Widget)menuw, XtGrabNone);
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	tet_infoline("PREP: Procedure XtCBP_Proc was invoked.");
	status = avs_get_event(1);
	check_dec(1, status, "callback invocation count");
	tet_result(TET_PASS);
>>ASSERTION Good A
When the resource XtNpopdownCallback is specified, a
call to Widget XtVaCreatePopupShell(name, widget_class, parent, ...)
shall register callback procedures on the shell's pop-down callback list
that shall be invoked when the widget is popped down.
>>CODE
int status = 0;
pid_t pid2;
XtCallbackRec callbacks[2] = {
	{ (XtCallbackProc)XtCBP_Proc, (XtPointer) NULL },
	{ (XtCallbackProc) NULL, (XtPointer) NULL }
};

	FORK(pid2);
	avs_xt_hier("Tvacrpshl3", "XtVaCreatePopupShell");
	tet_infoline("PREP: Create labelw_good widget Press Me");
	labelw_good = (Widget) CreateLabelWidget("Press Me", boxw1);
	tet_infoline("TEST: Create a vacrpshl shell");
	menuw = (ShellWidget)XtVaCreatePopupShell("menuw",
				overrideShellWidgetClass,
				labelw_good, 
				XtNpopdownCallback,
				&callbacks[0], (char *)NULL);
	tet_infoline("PREP: Create a rowcolw_good widget");
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	tet_infoline("PREP: Create pushb_good button Hello in rowcolw_good widget");
	pushb_good = (Widget) CreatePushButtonGadget(
				"Hello",
				rowcolw_good);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Map a Pop-up shell.");
	XtPopup((Widget)menuw, XtGrabNone);
	tet_infoline("PREP: UnMap a Pop-up shell.");
	XtPopdown((Widget)menuw);
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	tet_infoline("TEST: Procedure XtCBP_Proc was invoked.");
	status = avs_get_event(1);
	check_dec(1, status, "callback invocation count");
	tet_result(TET_PASS);
>>ASSERTION Good B 0
A successful call to 
Widget XtVaCreatePopupShell(name, widget_class, parent, ...)
when the varargs style variable argument list specifies the XtNscreen
argument shall create the resource database for the pop-up shell widget using 
the resource values specified in the varargs style arguments and resource 
values from the resource database of the screen specified by the XtNscreen 
argument for those resources not specified in the variable argument list.
>>ASSERTION Good B 0
A successful call to 
Widget XtVaCreatePopupShell(name, widget_class, parent, ...)
when the variable argument list does not specify the 
XtNscreen argument, and the resource database associated with the parent's
screen specifies the resource name.screen, class class.screen 
where class is the class_name field in the CoreClassPart of widget_class shall 
create the resource database for the pop-up shell widget using the resource 
values specified in the varargs style arguments and resource values from the 
resource database of the screen specified in the resource database of the 
parent's screen for those resources not specified in the variable argument list.
>>ASSERTION Good B 0
A successful call to 
Widget XtVaCreatePopupShell(name, widget_class, parent, ...)
when the variable argument list does not specify the XtNscreen argument, and 
the resource database associated with the parent's screen does not specify 
the resource name.screen, class class.screen where class is the class_name 
field in the CoreClassPart of widget_class shall create the resource database 
for the pop-up shell widget using the resource values specified in the variable 
argument list and resource values from the resource database of parent's 
screen for those resources not specified in the variable argument list.
