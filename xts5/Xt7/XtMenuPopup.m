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
>># File: xts/Xt7/XtMenuPopup.m
>># 
>># Description:
>>#	Tests for XtMenuPopup()
>># 
>># Modifications:
>># $Log: tmpopup.m,v $
>># Revision 1.1  2005-02-12 14:38:17  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:36:50  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:59:43  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:27:57  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:31  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:17:31  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:21:44  andy
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
void XtTI1_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	tet_infoline("TEST: Shell is popped-up");
	if (menuw->shell.popped_up == False) {
		tet_infoline("ERROR: Shell is not popped up");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Grab is exclusive");
	if (menuw->shell.grab_kind != XtGrabExclusive) {
		sprintf(ebuf, "ERROR: Expected XtGrabExclusive(%d), grab type = %d", XtGrabExclusive, menuw->shell.grab_kind);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	exit(0);
}
/*timeout callback*/
void XtTI1a_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	tet_infoline("TEST: Shell is popped-up");
	if (menuw->shell.popped_up == False) {
		tet_infoline("ERROR: Shell is not popped up");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Grab is non-exclusive");
	if (menuw->shell.grab_kind != XtGrabNonexclusive) {
		sprintf(ebuf, "ERROR: Expected XtGrabNonexclusive(%d), grab type = %d", XtGrabNonexclusive, menuw->shell.grab_kind);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	exit(0);
}
/*timeout callback*/
void XtTI2_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
        tet_infoline("TESTING: Shell is popped-up");
        if (menuw->shell.popped_up == False) {
                tet_infoline("ERROR: Shell is not popped up");
                tet_result(TET_FAIL);
        }
        tet_infoline("TESTING: Grab is exclusive");
        if (menuw->shell.grab_kind != XtGrabExclusive) {
                sprintf(ebuf, "ERROR: Expected XtGrabExclusive(%d), grab type = %d", XtGrabExclusive, menuw->shell.grab_kind);
		tet_infoline(ebuf);
                tet_result(TET_FAIL);
        }
	exit(0);
}
/*timeout callback*/
void XtTI8_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	tet_infoline("TEST: Shell is popped-up");
	if (menuw->shell.popped_up == False) {
		tet_infoline("ERROR: Shell is not popped up");
		tet_result(TET_FAIL);
	}
	exit(0);
}
/*timeout callback*/
void XtTI9a_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	tet_infoline("TEST: Shell is not spring loaded");
	if (menuw->shell.spring_loaded != False) {
		tet_infoline("ERROR: Shell is spring loaded");
		tet_result(TET_FAIL);
	}
	exit(0);
}
/*timeout callback*/
void XtTI9b_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	tet_infoline("TEST: Shell is spring loaded");
	if (menuw->shell.spring_loaded = False) {
		tet_infoline("ERROR: Shell is not spring loaded");
		tet_result(TET_FAIL);
	}
	exit(0);
}
void XtCB2_Proc(w, client_data, call_data)
Widget w;
XtPointer client_data, call_data;
{
	avs_set_event(1,1);
	exit(0);
}
/*timeout callback*/
void XtTI3_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	exit(0);
}
void XtWMH3_Proc(str1, str2, str3, str4, str5, car)
String str1, str2, str3, str4, *str5;
Cardinal *car;
{
	avs_set_event(2,1);
}
void XtCB3_Proc(w, client_data, call_data)
Widget w;
XtPointer client_data, call_data;
{
	avs_set_event(1,1);
	exit(0);
}
void XtCB7_Proc(w, client_data, call_data)
Widget w;
XtPointer client_data, call_data;
{
	tet_infoline("TEST: call_data passed to callback");
	if (*(XtGrabKind *)call_data != XtGrabNonexclusive) {
		sprintf(ebuf, "ERROR: Expected call_data to be XtGrabNonexclusive (%d), is %d", XtGrabNonexclusive, *(XtGrabKind *)call_data);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	avs_set_event(1,1);
}
void XtCB8_Proc(w, client_data, call_data)
Widget w;
XtPointer client_data, call_data;
{
	avs_set_event(2,1);
	tet_infoline("TEST: call_data passed to callback");
	if (*(XtGrabKind *)call_data != XtGrabNonexclusive) {
		sprintf(ebuf, "ERROR: Expected call_data to be XtGrabNonexclusive (%d), is %d", XtGrabNonexclusive, *(XtGrabKind *)call_data);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
}
void XtCB7e_Proc(w, client_data, call_data)
Widget w;
XtPointer client_data, call_data;
{
	tet_infoline("TEST: call_data passed to callback");
	if (*(XtGrabKind *)call_data != XtGrabExclusive) {
		sprintf(ebuf, "ERROR: Expected call_data to be XtGrabExclusive (%d), is %d", XtGrabExclusive, *(XtGrabKind *)call_data);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	avs_set_event(1,1);
}
void XtCB8e_Proc(w, client_data, call_data)
Widget w;
XtPointer client_data, call_data;
{
	avs_set_event(2,1);
	tet_infoline("TEST: call_data passed to callback");
	if (*(XtGrabKind *)call_data != XtGrabExclusive) {
		sprintf(ebuf, "ERROR: Expected call_data to be XtGrabExclusive (%d), is %d", XtGrabExclusive, *(XtGrabKind *)call_data);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
}
/*timeout callback*/
void XtTIe_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	exit(0);
}
/*timeout callback*/
void XtTI4_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
        tet_infoline("TESTING: Shell is popped-up");
        if (menuw->shell.popped_up == False) {
                tet_infoline("ERROR: Shell is not popped up");
                tet_result(TET_FAIL);
        }
        tet_infoline("TESTING: Grab is exclusive");
        if (menuw->shell.grab_kind != XtGrabExclusive) {
                sprintf(ebuf, "ERROR: Expected XtGrabExclusive(%d), grab type = %d", XtGrabExclusive, menuw->shell.grab_kind);
		tet_infoline(ebuf);
                tet_result(TET_FAIL);
        }
	exit(0);
}
/*popup's parent's event handler*/
void XtEV4a_Proc(w, client_data, event, contin)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *contin;
{
	if (event->type == KeyPress) {
        	tet_infoline("ERROR: Events were dispatched to non-modal widget");
        	tet_result(TET_FAIL);
	}
}
/*popup's event handler*/
void XtEV4b_proc(w, client_data, event, contin)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *contin;
{
        avs_set_event(2, avs_get_event(2)+1);
}

void XtCB4_Proc(w, client_data, call_data)
Widget w;
XtPointer client_data, call_data;
{
	avs_set_event(1,1);
        tet_infoline("PREP: Create event handler for popup");
        XtAddEventHandler((Widget)menuw, KeyPressMask, False, &XtEV4b_proc, NULL);
	tet_infoline("PREP: Send KeyPress event to the popup's parent - should go to popup");
	send_event(labelw_good, KeyPress, KeyPressMask, TRUE);
}
/*timeout callback*/
void XtTI5_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	tet_infoline("TEST: Shell is popped-up");
	if (menuw->shell.popped_up == False) {
		tet_infoline("ERROR: Shell is not popped up");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Grab is non-exclusive");
	if (menuw->shell.grab_kind != XtGrabNonexclusive) {
		sprintf(ebuf, "ERROR: Expected XtGrabNonexclusive(%d), grab type = %d", XtGrabNonexclusive, menuw->shell.grab_kind);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	exit(0);
}
/*timeout callback*/
void XtTI6_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	tet_infoline("TEST: Shell is popped-up");
	if (menuw->shell.popped_up == False) {
		tet_infoline("ERROR: Shell is not popped up");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Grab is nonexclusive");
	if (menuw->shell.grab_kind != XtGrabNonexclusive) {
		sprintf(ebuf, "ERROR: Expected XtGrabNonexclusive(%d), grab type = %d", XtGrabNonexclusive, menuw->shell.grab_kind);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	exit(0);
}
/*boxw2's event handler*/
void XtEV6a_Proc(w, client_data, event, contin)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *contin;
{
	tet_infoline("ERROR: Events were dispatched to non-modal widget");
	tet_result(TET_FAIL);
}
/*popup's parent's event handler*/
void XtEV6b_Proc(w, client_data, event, contin)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *contin;
{
	if (event->type == ButtonPress)
		avs_set_event(2,1);
}
/*popup's event handler*/
void XtEV6c_Proc(w, client_data, event, contin)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *contin;
{
	if (event->type == ButtonPress)
		avs_set_event(3,1);
}
/*timeout callback*/
void XtTI7_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	tet_infoline("TEST: Shell is not popped-up");
	if (menuw->shell.popped_up == True) {
		tet_infoline("ERROR: Shell is popped up");
		tet_result(TET_FAIL);
	}
	exit(0);
}

void XtWMH7_Proc(str1, str2, str3, str4, str5, car)
String str1, str2, str3, str4, *str5;
Cardinal *car;
{
	avs_set_event(2,1);
}
void cpc_proc(w)
Widget w;
{
	avs_set_event(2, 1);
	tet_infoline("TEST: create_popup_child_proc argument");
	if (w != (Widget)menuw) {
		sprintf(ebuf, "ERROR: expected argument to point to popup, is %p", w);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	exit(0);
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtMenuPopup Xt7
void
XtMenuPopup(shell_name)
>>ASSERTION Good A
A successful invocation of 
void XtMenuPopup(shell_name)
when the widget specified by shell_name is among the pop-up children of the 
widget in which the call is invoked shall map the window of the pop-up widget.
>>CODE
pid_t pid2;
Display *display;
int status = 0;
XtTranslations translations;
static char trans_good[] = "#replace	\n\
	 <BtnDown>:	XtMenuPopup(menuw)";

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tmpopup1", "XtMenuPopup");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Create a popup shell");
	labelw_good = (Widget) CreateLabelWidget("ApTest", boxw1);
	menuw = (ShellWidget)XtVaCreatePopupShell("menuw", overrideShellWidgetClass,
				labelw_good, NULL);
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	pushb_good = (Widget) CreatePushButtonGadget( "Hello", rowcolw_good);
	tet_infoline("PREP: Add translation into popup's parent");
	translations = XtParseTranslationTable(trans_good);
	XtOverrideTranslations(labelw_good, translations);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTI1_Proc, NULL);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send ButtonPress event to popup's parent");
	send_event(labelw_good, ButtonPress, ButtonPressMask, TRUE);
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful invocation of 
void XtMenuPopup(shell_name) 
when the widget specified by shell_name is not among the pop-up children of 
the widget in which the call is invoked but is a pop-child of an ancestor 
widget shall traverse the parent chain till it finds the pop-up child with 
the specified name and map the window of the pop-up child widget.
>>CODE
Widget test_w, test2_w;
pid_t pid2;
Display *display;
int status = 0;
XtTranslations translations;
static char trans_good[] = "#replace	\n\
	 <BtnDown>:	XtMenuPopup(menuw)";

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tmpopup2", "XtMenuPopup");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Create a popup shell");
	test_w = (Widget) XtCreateWidget("test", compositeWidgetClass, boxw1, (ArgList)NULL, 0);
	(void) ConfigureDimension(topLevel, test_w);
	test2_w = CreateRowColWidget(test_w);
	(void) ConfigureDimension(topLevel, test2_w);
	menuw = (ShellWidget)XtVaCreatePopupShell("menuw",
				overrideShellWidgetClass,
				test_w, NULL);
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	pushb_good = (Widget) CreatePushButtonGadget(
				"Hello",
				rowcolw_good);
	tet_infoline("PREP: Compile new translation table entry");
	translations = XtParseTranslationTable(trans_good);
	tet_infoline("PREP: Add translation into popup's parent's child");
	XtOverrideTranslations(test2_w, translations);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTI2_Proc, NULL);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send ButtonPress event to popup's parent's child");
	send_event(test2_w, ButtonPress, ButtonPressMask, TRUE);
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	tet_result(TET_PASS);
>>ASSERTION Good A
An invocation of 
void XtMenuPopup(shell_name) 
when the widget specified by shell_name is neither among the pop-up children of 
the widget in which the call is invoked nor is it among the pop-up children 
of any of the widget ancestors up to and including the top-level 
shell widget shall issue a warning and return immediately.
>>CODE
pid_t pid2;
Display *display;
int status = 0;
XtTranslations translations;
static char trans_good[] = "#replace	\n\
	 <BtnDown>:	XtMenuPopup(menuw)";

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tmpopup3", "XtMenuPopup");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Create a popup shell");
	labelw_good = (Widget) CreateLabelWidget("Test", boxw1);
	menuw = (ShellWidget)XtVaCreatePopupShell("menuw",
				overrideShellWidgetClass,
				labelw_good, NULL);
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	pushb_good = (Widget) CreatePushButtonGadget(
				"Hello",
				rowcolw_good);
	tet_infoline("PREP: Compile new translation table entry");
	translations = XtParseTranslationTable(trans_good);
	tet_infoline("PREP: Add translation into shell's parent's parent");
	XtOverrideTranslations(boxw1, translations);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTI3_Proc, NULL);
	tet_infoline("PREP: Set Warning Message Handler");
	XtAppSetWarningMsgHandler(app_ctext, XtWMH3_Proc);
	tet_infoline("PREP: Add callback to shell for popup");
	XtAddCallback((Widget)menuw, XtNpopupCallback, XtCB3_Proc, NULL);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send ButtonPress event to shell's parent's parent");
	send_event(boxw1, ButtonPress, ButtonPressMask, TRUE);
	tet_infoline("TEST: Shell was not popped up");
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	status = avs_get_event(1);
	check_dec(0, status, "shell popped up");
	tet_infoline("TEST: Warning message was generated");
	status = avs_get_event(2);
	check_dec(1, status, "warning handler invocations count");
	tet_result(TET_PASS);
>>ASSERTION Good A
When
void XtMenuPopup(shell_name) 
is invoked on a ButtonPress event it shall make the widget specified by 
shell_name modal and add it to the modal cascade if one exists or create a 
modal cascade starting at this widget when no prior modal cascade exists.
>>CODE
pid_t pid2;
Display *display;
int status = 0;
XtTranslations translations;
static char trans_good[] = "#replace	\n\
	 <BtnDown>:	XtMenuPopup(menuw)";

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tmpopup4", "XtMenuPopup");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Create a popup shell");
	labelw_good = (Widget) CreateLabelWidget("Test", boxw1);
	menuw = (ShellWidget)XtVaCreatePopupShell("menuw",
				overrideShellWidgetClass,
				labelw_good, NULL);
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	pushb_good = (Widget) CreatePushButtonGadget(
				"Hello",
				rowcolw_good);
	tet_infoline("PREP: Compile new translation table entry");
	translations = XtParseTranslationTable(trans_good);
	tet_infoline("PREP: Add translation into popup's parent");
	XtOverrideTranslations(labelw_good, translations);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTI4_Proc, NULL);
	tet_infoline("PREP: Create event handler for popup's parent");
	XtAddEventHandler(labelw_good, ButtonPressMask, False, &XtEV4a_Proc, NULL);
	tet_infoline("PREP: Add callback to shell for popup");
	XtAddCallback((Widget)menuw, XtNpopupCallback, XtCB4_Proc, NULL);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send ButtonPress event to popup's parent to cause popup");
	send_event(labelw_good, ButtonPress, ButtonPressMask, TRUE);
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	tet_infoline("TEST: Popup received KeyPress");
	status = avs_get_event(2);
	check_dec(1, status, "events received by popup count");
	tet_result(TET_PASS);
>>ASSERTION Good A
When
void XtMenuPopup(shell_name) 
is invoked on a KeyPress event it shall make the widget specified by 
shell_name modal and add it to the modal cascade if one exists or create a 
modal cascade starting at this widget when no prior modal cascade exists.
>>CODE
String myargvector[] = {"menuw", NULL};
pid_t pid2;
Display *display;
int status = 0;
int i;
XEvent event_good;
XtTranslations translations;
XEvent testevent;

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tmpopup5", "XtMenuPopup");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Create a popup shell");
	labelw_good = (Widget) CreateLabelWidget("Test", boxw1);
	menuw = (ShellWidget)XtVaCreatePopupShell("menuw", overrideShellWidgetClass,
				labelw_good, NULL);
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	pushb_good = (Widget) CreatePushButtonGadget( "Hello", rowcolw_good);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTI5_Proc, NULL);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Call action procedure");
	testevent.xkey.window = XtWindow(labelw_good);
	testevent.type = KeyPress;
	XtCallActionProc(labelw_good, "XtMenuPopup", &testevent, myargvector, 1);
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When
void XtMenuPopup(shell_name) 
is invoked on a EnterWindow event it shall make the widget specified by 
shell_name modal and add it to the modal cascade if one exists or create a 
modal cascade starting at this widget when no prior modal cascade exists.
>>CODE
XEvent event;
int i;
pid_t pid2;
Display *display;
int status = 0;
XtTranslations translations;
static char trans_good[] = "#replace	\n\
	 <EnterNotify>:	XtMenuPopup(menuw)";

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tmpopup6", "XtMenuPopup");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Create a popup shell");
	labelw_good = (Widget) CreateLabelWidget("Test", boxw1);
	menuw = (ShellWidget)XtVaCreatePopupShell("menuw",
				overrideShellWidgetClass,
				labelw_good, NULL);
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	pushb_good = (Widget) CreatePushButtonGadget(
				"Hello",
				rowcolw_good);
	tet_infoline("PREP: Compile new translation table entry");
	translations = XtParseTranslationTable(trans_good);
	tet_infoline("PREP: Add translation into popup's parent");
	XtOverrideTranslations(labelw_good, translations);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTI6_Proc, NULL);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send EnterNotify event to popup's parent to cause popup");
	send_event(labelw_good, EnterNotify, EnterWindowMask, TRUE);
	for (i = 0; i< 10;) {
	 XtAppNextEvent(app_ctext, &event);
	 XSync(display, False);
		if (event.type == MapNotify) {
		if (event.xmap.window == XtWindow((Widget)menuw)) {
				avs_set_event(1,1);
			tet_infoline("PREP: Make popup's parent modal, exclusive");
			XtAddGrab(labelw_good, True, False);
			tet_infoline("PREP: Create event handler for boxw2");
			XtAddEventHandler(boxw2, ButtonPressMask, False, &XtEV6a_Proc, NULL);
			tet_infoline("PREP: Create event handler for popup's parent");
			XtAddEventHandler(labelw_good, ButtonPressMask, False, &XtEV6b_Proc, NULL);
			tet_infoline("PREP: Create event handler for popup");
			XtAddEventHandler((Widget)menuw, ButtonPressMask, False, &XtEV6c_Proc, NULL);
			tet_infoline("PREP: Send ButtonPress event to the popup's parent - should be dispatched");
			send_event(labelw_good, ButtonPress, ButtonPressMask, TRUE);
			tet_infoline("PREP: Send ButtonPress event to the popup - should be dispatched");
			send_event((Widget)menuw, ButtonPress, ButtonPressMask, TRUE);
			tet_infoline("PREP: Send ButtonPress event to boxw2 - should not be dispatched");
			send_event(boxw2, ButtonPress, ButtonPressMask, TRUE);
		}
	 }
	 XtDispatchEvent(&event);
	} /* end for */
	KROF(pid2);
	status = avs_get_event(1);
	check_dec(1, status, "MapNotify for shell count");
	tet_infoline("TEST: Popup's parent received ButtonPress");
	status = avs_get_event(2);
	check_dec(1, status, "events received by popup's parent count");
	tet_infoline("TEST: Popup received ButtonPress");
	status = avs_get_event(3);
	check_dec(1, status, "events received by popup parent count");
	tet_result(TET_PASS);
>>ASSERTION Good A
When 
void XtMenuPopup(shell_name) 
is invoked on an event other than KeyPress, ButtonPress, or EnterWindow, the 
translation manger shall generate a warning message and ignore the action.
>>CODE
pid_t pid2;
Display *display;
int status = 0;
XtTranslations translations;
static char trans_good[] = "#replace	\n\
	 <FocusIn>:	XtMenuPopup(menuw)";

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tmpopup7", "XtMenuPopup");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Create a popup shell");
	labelw_good = (Widget) CreateLabelWidget("Test", boxw1);
	menuw = (ShellWidget)XtVaCreatePopupShell("menuw",
				overrideShellWidgetClass,
				labelw_good, NULL);
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	pushb_good = (Widget) CreatePushButtonGadget(
				"Hello",
				rowcolw_good);
	tet_infoline("PREP: Compile new translation table entry");
	translations = XtParseTranslationTable(trans_good);
	tet_infoline("PREP: Add translation into popup's parent");
	XtOverrideTranslations(labelw_good, translations);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTI7_Proc, NULL);
	tet_infoline("PREP: Set Warning Message Handler");
	XtAppSetWarningMsgHandler(app_ctext, XtWMH7_Proc);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send FocusIn event to popup's parent");
	send_event(labelw_good, FocusIn, FocusChangeMask, TRUE);
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	tet_infoline("TEST: Warning message was sent");
	status = avs_get_event(2);
	check_dec(1, status, "warning message handler invoked count");
	tet_result(TET_PASS);
>>ASSERTION Good A
When
void XtMenuPopup(shell_name) 
is invoked on a EnterWindow event it shall call the callback procedures on 
the popup_callback list of the widget specified by shell_name, passing to 
them a pointer to XtGrabNonexclusive as the call_data argument.
>>CODE
Widget test_w, test2_w;
pid_t pid2;
Display *display;
int status = 0;
XtTranslations translations;
static char trans_good[] = "#replace	\n\
	 <EnterNotify>:	XtMenuPopup(menuw)";

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tmpopup2", "XtMenuPopup");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Create a popup shell");
	test_w = (Widget) XtCreateWidget("test", compositeWidgetClass, boxw1, (ArgList)NULL, 0);
	(void) ConfigureDimension(topLevel, test_w);
	test2_w = CreateRowColWidget(test_w);
	(void) ConfigureDimension(topLevel, test2_w);
	menuw = (ShellWidget)XtVaCreatePopupShell("menuw",
				overrideShellWidgetClass,
				test_w, NULL);
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	pushb_good = (Widget) CreatePushButtonGadget(
				"Hello",
				rowcolw_good);
	tet_infoline("PREP: Compile new translation table entry");
	translations = XtParseTranslationTable(trans_good);
	tet_infoline("PREP: Add translation into popup's parent's child");
	XtOverrideTranslations(test2_w, translations);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTIe_Proc, NULL);
	tet_infoline("PREP: Add callbacks to shell for popup");
	XtAddCallback((Widget)menuw, XtNpopupCallback, XtCB7_Proc, NULL);
	XtAddCallback((Widget)menuw, XtNpopupCallback, XtCB8_Proc, NULL);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send EnterNotify event to popup's parent to cause popup");
	send_event(test2_w, EnterNotify, EnterWindowMask, TRUE);
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	tet_infoline("TEST: Callbacks called");
	status = avs_get_event(1);
	check_dec(1, status, "callback 1 invocation count");
	status = avs_get_event(2);
	check_dec(1, status, "callback 2 invocation count");
	tet_result(TET_PASS);
>>ASSERTION Good A
When
void XtMenuPopup(shell_name) 
is invoked on a EnterWindow event it shall set the popped_up field in the 
widget instance structure of shell_name to True.
>>CODE
Widget test_w, test2_w;
pid_t pid2;
Display *display;
int status = 0;
XtTranslations translations;
static char trans_good[] = "#replace	\n\
	 <EnterNotify>:	XtMenuPopup(menuw)";

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tmpopup2", "XtMenuPopup");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Create a popup shell");
	test_w = (Widget) XtCreateWidget("test", compositeWidgetClass, boxw1, (ArgList)NULL, 0);
	(void) ConfigureDimension(topLevel, test_w);
	test2_w = CreateRowColWidget(test_w);
	(void) ConfigureDimension(topLevel, test2_w);
	menuw = (ShellWidget)XtVaCreatePopupShell("menuw",
				overrideShellWidgetClass,
				test_w, NULL);
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	pushb_good = (Widget) CreatePushButtonGadget(
				"Hello",
				rowcolw_good);
	tet_infoline("PREP: Compile new translation table entry");
	translations = XtParseTranslationTable(trans_good);
	tet_infoline("PREP: Add translation into popup's parent's child");
	XtOverrideTranslations(test2_w, translations);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTI8_Proc, NULL);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send EnterNotify event to popup's parent to cause popup");
	send_event(test2_w, EnterNotify, EnterWindowMask, TRUE);
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When
void XtMenuPopup(shell_name) 
is invoked on a EnterWindow event it shall set the spring_loaded field in the 
widget instance structure of shell_name to False.
>>CODE
Widget test_w, test2_w;
pid_t pid2;
Display *display;
int status = 0;
XtTranslations translations;
static char trans_good[] = "#replace	\n\
	 <EnterNotify>:	XtMenuPopup(menuw)";

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tmpopup2", "XtMenuPopup");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Create a popup shell");
	test_w = (Widget) XtCreateWidget("test", compositeWidgetClass, boxw1, (ArgList)NULL, 0);
	(void) ConfigureDimension(topLevel, test_w);
	test2_w = CreateRowColWidget(test_w);
	(void) ConfigureDimension(topLevel, test2_w);
	menuw = (ShellWidget)XtVaCreatePopupShell("menuw",
				overrideShellWidgetClass,
				test_w, NULL);
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	pushb_good = (Widget) CreatePushButtonGadget(
				"Hello",
				rowcolw_good);
	tet_infoline("PREP: Compile new translation table entry");
	translations = XtParseTranslationTable(trans_good);
	tet_infoline("PREP: Add translation into popup's parent's child");
	XtOverrideTranslations(test2_w, translations);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTI9a_Proc, NULL);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send EnterNotify event to popup's parent to cause popup");
	send_event(test2_w, EnterNotify, EnterWindowMask, TRUE);
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When
void XtMenuPopup(shell_name) 
is invoked on a EnterWindow event it shall set the grab_kind field in the 
widget instance structure of shell_name to XtGrabNonExclusive.
>>CODE
Widget test_w, test2_w;
pid_t pid2;
Display *display;
int status = 0;
XtTranslations translations;
static char trans_good[] = "#replace	\n\
	 <EnterNotify>:	XtMenuPopup(menuw)";

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tmpopup2", "XtMenuPopup");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Create a popup shell");
	test_w = (Widget) XtCreateWidget("test", compositeWidgetClass, boxw1, (ArgList)NULL, 0);
	(void) ConfigureDimension(topLevel, test_w);
	test2_w = CreateRowColWidget(test_w);
	(void) ConfigureDimension(topLevel, test2_w);
	menuw = (ShellWidget)XtVaCreatePopupShell("menuw",
				overrideShellWidgetClass,
				test_w, NULL);
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	pushb_good = (Widget) CreatePushButtonGadget(
				"Hello",
				rowcolw_good);
	tet_infoline("PREP: Compile new translation table entry");
	translations = XtParseTranslationTable(trans_good);
	tet_infoline("PREP: Add translation into popup's parent's child");
	XtOverrideTranslations(test2_w, translations);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTI1a_Proc, NULL);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send EnterNotify event to popup's parent to cause popup");
	send_event(test2_w, EnterNotify, EnterWindowMask, TRUE);
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When
void XtMenuPopup(shell_name) 
is invoked on a EnterWindow event and the create_popup_child_proc field in 
the widget instance structure of shell_name is non-NULL it 
shall call the procedure specified by that field with the popped up shell as
the parameter.
>>CODE
Widget test_w, test2_w;
pid_t pid2;
Display *display;
int status = 0;
XtTranslations translations;
static char trans_good[] = "#replace	\n\
	 <EnterNotify>:	XtMenuPopup(menuw)";

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tmpopup2", "XtMenuPopup");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Create a popup shell");
	test_w = (Widget) XtCreateWidget("test", compositeWidgetClass, boxw1, (ArgList)NULL, 0);
	(void) ConfigureDimension(topLevel, test_w);
	test2_w = CreateRowColWidget(test_w);
	(void) ConfigureDimension(topLevel, test2_w);
	menuw = (ShellWidget)XtVaCreatePopupShell("menuw",
				overrideShellWidgetClass,
				test_w, NULL);
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	pushb_good = (Widget) CreatePushButtonGadget(
				"Hello",
				rowcolw_good);
	tet_infoline("PREP: Compile new translation table entry");
	translations = XtParseTranslationTable(trans_good);
	tet_infoline("PREP: Add translation into popup's parent's child");
	XtOverrideTranslations(test2_w, translations);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTIe_Proc, NULL);
	tet_infoline("PREP: Set create_popup_child_proc value");
	menuw->shell.create_popup_child_proc = cpc_proc;
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send EnterNotify event to popup's parent to cause popup");
	send_event(test2_w, EnterNotify, EnterWindowMask, TRUE);
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	tet_infoline("TEST: create_popup_child_proc was called");
	status = avs_get_event(2);
	check_dec(1, status, "count of invokations of create_popup_child_proc procedure");
	tet_result(TET_PASS);
>>ASSERTION Good A
When
void XtMenuPopup(shell_name) 
is invoked on a KeyPress event it shall call the callback procedures on 
the popup_callback list of the widget specified by shell_name, passing to 
them a pointer to XtGrabNonexclusive as the call_data argument.
>>CODE
Widget test_w, test2_w;
pid_t pid2;
Display *display;
int status = 0;
XtTranslations translations;
static char trans_good[] = "#replace	\n\
	 <KeyPress>:	XtMenuPopup(menuw)";

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tmpopup2", "XtMenuPopup");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Create a popup shell");
	test_w = (Widget) XtCreateWidget("test", compositeWidgetClass, boxw1, (ArgList)NULL, 0);
	(void) ConfigureDimension(topLevel, test_w);
	test2_w = CreateRowColWidget(test_w);
	(void) ConfigureDimension(topLevel, test2_w);
	menuw = (ShellWidget)XtVaCreatePopupShell("menuw",
				overrideShellWidgetClass,
				test_w, NULL);
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	pushb_good = (Widget) CreatePushButtonGadget(
				"Hello",
				rowcolw_good);
	tet_infoline("PREP: Compile new translation table entry");
	translations = XtParseTranslationTable(trans_good);
	tet_infoline("PREP: Add translation into popup's parent's child");
	XtOverrideTranslations(test2_w, translations);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTIe_Proc, NULL);
	tet_infoline("PREP: Add callbacks to shell for popup");
	XtAddCallback((Widget)menuw, XtNpopupCallback, XtCB7_Proc, NULL);
	XtAddCallback((Widget)menuw, XtNpopupCallback, XtCB8_Proc, NULL);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send KeyPress event to popup's parent to cause popup");
	send_event(test2_w, KeyPress, KeyPressMask, TRUE);
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	tet_infoline("TEST: Callbacks called");
	status = avs_get_event(1);
	check_dec(1, status, "callback 1 invocation count");
	status = avs_get_event(2);
	check_dec(1, status, "callback 2 invocation count");
	tet_result(TET_PASS);
>>ASSERTION Good A
When
void XtMenuPopup(shell_name) 
is invoked on a KeyPress event it shall set the popped_up field in the 
widget instance structure of shell_name to True.
>>CODE
Widget test_w, test2_w;
pid_t pid2;
Display *display;
int status = 0;
XtTranslations translations;
static char trans_good[] = "#replace	\n\
	 <KeyPress>:	XtMenuPopup(menuw)";

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tmpopup2", "XtMenuPopup");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Create a popup shell");
	test_w = (Widget) XtCreateWidget("test", compositeWidgetClass, boxw1, (ArgList)NULL, 0);
	(void) ConfigureDimension(topLevel, test_w);
	test2_w = CreateRowColWidget(test_w);
	(void) ConfigureDimension(topLevel, test2_w);
	menuw = (ShellWidget)XtVaCreatePopupShell("menuw",
				overrideShellWidgetClass,
				test_w, NULL);
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	pushb_good = (Widget) CreatePushButtonGadget(
				"Hello",
				rowcolw_good);
	tet_infoline("PREP: Compile new translation table entry");
	translations = XtParseTranslationTable(trans_good);
	tet_infoline("PREP: Add translation into popup's parent's child");
	XtOverrideTranslations(test2_w, translations);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTI8_Proc, NULL);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send KeyPress event to popup's parent to cause popup");
	send_event(test2_w, KeyPress, KeyPressMask, TRUE);
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When
void XtMenuPopup(shell_name) 
is invoked on a KeyPress event it shall set the spring_loaded field in the 
widget instance structure of shell_name to False.
>>CODE
Widget test_w, test2_w;
pid_t pid2;
Display *display;
int status = 0;
XtTranslations translations;
static char trans_good[] = "#replace	\n\
	 <KeyPress>:	XtMenuPopup(menuw)";

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tmpopup2", "XtMenuPopup");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Create a popup shell");
	test_w = (Widget) XtCreateWidget("test", compositeWidgetClass, boxw1, (ArgList)NULL, 0);
	(void) ConfigureDimension(topLevel, test_w);
	test2_w = CreateRowColWidget(test_w);
	(void) ConfigureDimension(topLevel, test2_w);
	menuw = (ShellWidget)XtVaCreatePopupShell("menuw",
				overrideShellWidgetClass,
				test_w, NULL);
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	pushb_good = (Widget) CreatePushButtonGadget(
				"Hello",
				rowcolw_good);
	tet_infoline("PREP: Compile new translation table entry");
	translations = XtParseTranslationTable(trans_good);
	tet_infoline("PREP: Add translation into popup's parent's child");
	XtOverrideTranslations(test2_w, translations);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTI9a_Proc, NULL);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send KeyPress event to popup's parent to cause popup");
	send_event(test2_w, KeyPress, KeyPressMask, TRUE);
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When
void XtMenuPopup(shell_name) 
is invoked on a KeyPress event it shall set the grab_kind field in the 
widget instance structure of shell_name to XtGrabNonExclusive.
>>CODE
Widget test_w, test2_w;
pid_t pid2;
Display *display;
int status = 0;
XtTranslations translations;
static char trans_good[] = "#replace	\n\
	 <KeyPress>:	XtMenuPopup(menuw)";

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tmpopup2", "XtMenuPopup");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Create a popup shell");
	test_w = (Widget) XtCreateWidget("test", compositeWidgetClass, boxw1, (ArgList)NULL, 0);
	(void) ConfigureDimension(topLevel, test_w);
	test2_w = CreateRowColWidget(test_w);
	(void) ConfigureDimension(topLevel, test2_w);
	menuw = (ShellWidget)XtVaCreatePopupShell("menuw",
				overrideShellWidgetClass,
				test_w, NULL);
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	pushb_good = (Widget) CreatePushButtonGadget(
				"Hello",
				rowcolw_good);
	tet_infoline("PREP: Compile new translation table entry");
	translations = XtParseTranslationTable(trans_good);
	tet_infoline("PREP: Add translation into popup's parent's child");
	XtOverrideTranslations(test2_w, translations);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTI1a_Proc, NULL);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send KeyPress event to popup's parent to cause popup");
	send_event(test2_w, KeyPress, KeyPressMask, TRUE);
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When
void XtMenuPopup(shell_name) 
is invoked on a KeyPress event and the create_popup_child_proc field in 
the widget instance structure of shell_name is non-NULL it 
shall call the procedure specified by that field with the popped-up
shell as the parameter.
>>CODE
Widget test_w, test2_w;
pid_t pid2;
Display *display;
int status = 0;
XtTranslations translations;
static char trans_good[] = "#replace	\n\
	 <KeyPress>:	XtMenuPopup(menuw)";

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tmpopup2", "XtMenuPopup");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Create a popup shell");
	test_w = (Widget) XtCreateWidget("test", compositeWidgetClass, boxw1, (ArgList)NULL, 0);
	(void) ConfigureDimension(topLevel, test_w);
	test2_w = CreateRowColWidget(test_w);
	(void) ConfigureDimension(topLevel, test2_w);
	menuw = (ShellWidget)XtVaCreatePopupShell("menuw",
				overrideShellWidgetClass,
				test_w, NULL);
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	pushb_good = (Widget) CreatePushButtonGadget(
				"Hello",
				rowcolw_good);
	tet_infoline("PREP: Compile new translation table entry");
	translations = XtParseTranslationTable(trans_good);
	tet_infoline("PREP: Add translation into popup's parent's child");
	XtOverrideTranslations(test2_w, translations);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTIe_Proc, NULL);
	tet_infoline("PREP: Set create_popup_child_proc value");
	menuw->shell.create_popup_child_proc = cpc_proc;
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send KeyPress event to popup's parent to cause popup");
	send_event(test2_w, KeyPress, KeyPressMask, TRUE);
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	tet_infoline("TEST: create_popup_child_proc was called");
	status = avs_get_event(2);
	check_dec(1, status, "count of invokations of create_popup_child_proc procedure");
	tet_result(TET_PASS);
>>ASSERTION Good A
When
void XtMenuPopup(shell_name) 
is invoked on a ButtonPress event it shall call the callback procedures on 
the popup_callback list of the widget specified by shell_name, passing to 
them a pointer to XtGrabExclusive as the call_data argument.
>>CODE
Widget test_w, test2_w;
pid_t pid2;
Display *display;
int status = 0;
XtTranslations translations;
static char trans_good[] = "#replace	\n\
	 <ButtonPress>:	XtMenuPopup(menuw)";

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tmpopup2", "XtMenuPopup");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Create a popup shell");
	test_w = (Widget) XtCreateWidget("test", compositeWidgetClass, boxw1, (ArgList)NULL, 0);
	(void) ConfigureDimension(topLevel, test_w);
	test2_w = CreateRowColWidget(test_w);
	(void) ConfigureDimension(topLevel, test2_w);
	menuw = (ShellWidget)XtVaCreatePopupShell("menuw",
				overrideShellWidgetClass,
				test_w, NULL);
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	pushb_good = (Widget) CreatePushButtonGadget(
				"Hello",
				rowcolw_good);
	tet_infoline("PREP: Compile new translation table entry");
	translations = XtParseTranslationTable(trans_good);
	tet_infoline("PREP: Add translation into popup's parent's child");
	XtOverrideTranslations(test2_w, translations);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTIe_Proc, NULL);
	tet_infoline("PREP: Add callbacks to shell for popup");
	XtAddCallback((Widget)menuw, XtNpopupCallback, XtCB7e_Proc, NULL);
	XtAddCallback((Widget)menuw, XtNpopupCallback, XtCB8e_Proc, NULL);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send ButtonPress event to popup's parent to cause popup");
	send_event(test2_w, ButtonPress, ButtonPressMask, TRUE);
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	tet_infoline("TEST: Callbacks called");
	status = avs_get_event(1);
	check_dec(1, status, "callback 1 invocation count");
	status = avs_get_event(2);
	check_dec(1, status, "callback 2 invocation count");
	tet_result(TET_PASS);
>>ASSERTION Good A
When
void XtMenuPopup(shell_name) 
is invoked on a ButtonPress event it shall set the popped_up field in the 
widget instance structure of shell_name to True.
>>CODE
Widget test_w, test2_w;
pid_t pid2;
Display *display;
int status = 0;
XtTranslations translations;
static char trans_good[] = "#replace	\n\
	 <ButtonPress>:	XtMenuPopup(menuw)";

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tmpopup2", "XtMenuPopup");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Create a popup shell");
	test_w = (Widget) XtCreateWidget("test", compositeWidgetClass, boxw1, (ArgList)NULL, 0);
	(void) ConfigureDimension(topLevel, test_w);
	test2_w = CreateRowColWidget(test_w);
	(void) ConfigureDimension(topLevel, test2_w);
	menuw = (ShellWidget)XtVaCreatePopupShell("menuw",
				overrideShellWidgetClass,
				test_w, NULL);
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	pushb_good = (Widget) CreatePushButtonGadget(
				"Hello",
				rowcolw_good);
	tet_infoline("PREP: Compile new translation table entry");
	translations = XtParseTranslationTable(trans_good);
	tet_infoline("PREP: Add translation into popup's parent's child");
	XtOverrideTranslations(test2_w, translations);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTI8_Proc, NULL);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send ButtonPress event to popup's parent to cause popup");
	send_event(test2_w, ButtonPress, ButtonPressMask, TRUE);
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When
void XtMenuPopup(shell_name) 
is invoked on a ButtonPress event it shall set the spring_loaded field in the 
widget instance structure of shell_name to True.
>>CODE
Widget test_w, test2_w;
pid_t pid2;
Display *display;
int status = 0;
XtTranslations translations;
static char trans_good[] = "#replace	\n\
	 <ButtonPress>:	XtMenuPopup(menuw)";

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tmpopup2", "XtMenuPopup");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Create a popup shell");
	test_w = (Widget) XtCreateWidget("test", compositeWidgetClass, boxw1, (ArgList)NULL, 0);
	(void) ConfigureDimension(topLevel, test_w);
	test2_w = CreateRowColWidget(test_w);
	(void) ConfigureDimension(topLevel, test2_w);
	menuw = (ShellWidget)XtVaCreatePopupShell("menuw",
				overrideShellWidgetClass,
				test_w, NULL);
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	pushb_good = (Widget) CreatePushButtonGadget(
				"Hello",
				rowcolw_good);
	tet_infoline("PREP: Compile new translation table entry");
	translations = XtParseTranslationTable(trans_good);
	tet_infoline("PREP: Add translation into popup's parent's child");
	XtOverrideTranslations(test2_w, translations);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTI9b_Proc, NULL);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send ButtonPress event to popup's parent to cause popup");
	send_event(test2_w, ButtonPress, ButtonPressMask, TRUE);
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When
void XtMenuPopup(shell_name) 
is invoked on a ButtonPress event it shall set the grab_kind field in the 
widget instance structure of shell_name to XtGrabExclusive.
>>CODE
Widget test_w, test2_w;
pid_t pid2;
Display *display;
int status = 0;
XtTranslations translations;
static char trans_good[] = "#replace	\n\
	 <ButtonPress>:	XtMenuPopup(menuw)";

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tmpopup2", "XtMenuPopup");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Create a popup shell");
	test_w = (Widget) XtCreateWidget("test", compositeWidgetClass, boxw1, (ArgList)NULL, 0);
	(void) ConfigureDimension(topLevel, test_w);
	test2_w = CreateRowColWidget(test_w);
	(void) ConfigureDimension(topLevel, test2_w);
	menuw = (ShellWidget)XtVaCreatePopupShell("menuw",
				overrideShellWidgetClass,
				test_w, NULL);
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	pushb_good = (Widget) CreatePushButtonGadget(
				"Hello",
				rowcolw_good);
	tet_infoline("PREP: Compile new translation table entry");
	translations = XtParseTranslationTable(trans_good);
	tet_infoline("PREP: Add translation into popup's parent's child");
	XtOverrideTranslations(test2_w, translations);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTI1_Proc, NULL);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send ButtonPress event to popup's parent to cause popup");
	send_event(test2_w, ButtonPress, ButtonPressMask, TRUE);
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When
void XtMenuPopup(shell_name) 
is invoked on a ButtonPress event and the create_popup_child_proc field in 
the widget instance structure of shell_name is non-NULL it 
shall call the procedure specified by that field with the popped-up
shell as the parameter.
>>CODE
Widget test_w, test2_w;
pid_t pid2;
Display *display;
int status = 0;
XtTranslations translations;
static char trans_good[] = "#replace	\n\
	 <ButtonPress>:	XtMenuPopup(menuw)";

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tmpopup2", "XtMenuPopup");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Create a popup shell");
	test_w = (Widget) XtCreateWidget("test", compositeWidgetClass, boxw1, (ArgList)NULL, 0);
	(void) ConfigureDimension(topLevel, test_w);
	test2_w = CreateRowColWidget(test_w);
	(void) ConfigureDimension(topLevel, test2_w);
	menuw = (ShellWidget)XtVaCreatePopupShell("menuw",
				overrideShellWidgetClass,
				test_w, NULL);
	rowcolw_good = (Widget) CreateRowColWidget((Widget)menuw);
	pushb_good = (Widget) CreatePushButtonGadget(
				"Hello",
				rowcolw_good);
	tet_infoline("PREP: Compile new translation table entry");
	translations = XtParseTranslationTable(trans_good);
	tet_infoline("PREP: Add translation into popup's parent's child");
	XtOverrideTranslations(test2_w, translations);
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, &XtTIe_Proc, NULL);
	tet_infoline("PREP: Set create_popup_child_proc value");
	menuw->shell.create_popup_child_proc = cpc_proc;
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Send ButtonPress event to popup's parent to cause popup");
	send_event(test2_w, ButtonPress, ButtonPressMask, TRUE);
	XtAppMainLoop(app_ctext);
	KROF(pid2);
	tet_infoline("TEST: create_popup_child_proc was called");
	status = avs_get_event(2);
	check_dec(1, status, "count of invokations of create_popup_child_proc procedure");
	tet_result(TET_PASS);
