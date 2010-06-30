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
>># File: xts/XtC/XtAddActions.m
>># 
>># Description:
>>#	Tests for XtAddActions()
>># 
>># Modifications:
>># $Log: tadaction.m,v $
>># Revision 1.1  2005-02-12 14:38:24  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:38:36  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:39  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.1  1998/06/23 23:00:00  andy
>># Added sleep(XT_RESET_DELAY) to each test.  SR# 186.
>>#
>># Revision 6.0  1998/03/02 05:29:37  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:26:11  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:22:55  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:19:37  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;

void AvsWidAction(w, event, params, num_params)
Widget w;
XEvent *event;
String *params;
Cardinal *num_params;
{
	avs_set_event(1,1);
}
void AvsWidAction2(w, event, params, num_params)
Widget w;
XEvent *event;
String *params;
Cardinal *num_params;
{
	avs_set_event(2,1);
}
#define AVS_WID_ACTION "AvsWidAction"
static XtActionsRec actions[] = {
	{AVS_WID_ACTION, AvsWidAction},
};
static XtActionsRec actions2[] = {
	{AVS_WID_ACTION, AvsWidAction},
	{AVS_WID_ACTION, AvsWidAction2}
};
static XtActionsRec actions3[] = {
	{AVS_WID_ACTION, AvsWidAction2},
};
void setPosSize(w)
Widget w;
{
	Display *display;
	int x_origin, y_origin;	 /* x, y origin of widget */
	int width, height;		/* height and width of widget */
	int DisplayWidthInPix;	 /* Number of display width pixels */
	int DisplayHeightInPix;	/* Number of display height pixels */
	int DisplayWidthInMM;	 /* display width in mm */
	int PixelPerCM;	 /* number of pixels in cms */
	display = XtDisplay(w);
	/*
	** Get height and width of display in pixels and create a toplevel
	** shell with consistent height and width for any display.
	*/
	DisplayWidthInPix = XDisplayWidth(display, XDefaultScreen(display));
	DisplayHeightInPix = XDisplayHeight(display, XDefaultScreen(display));
	DisplayWidthInMM = XDisplayWidthMM(display, XDefaultScreen(display));
	PixelPerCM = ( DisplayWidthInPix * 10 )/DisplayWidthInMM;
	x_origin = 2 * PixelPerCM;
	y_origin = 2 * PixelPerCM;
	width = DisplayWidthInPix - ( 4 * PixelPerCM );
	height = DisplayHeightInPix - ( 4 * PixelPerCM );
	XtVaSetValues(w,
			XtNx, x_origin,
			XtNy, y_origin,
			XtNwidth, width,
			XtNheight, height,
			NULL);
}
/*
*/
int argc = 0;
String argv[] = { "Tadaction1", NULL};
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtAddActions XtC
void
XtAddActions(actions, num_actions)
>>ASSERTION Good A
A successful call to
void XtAddActions(actions, num_actions)
shall register 
.A actions 
as the action table that will map procedure name 
strings to the corresponding procedures for the
default application context of the calling process.
>>CODE
char label[80];
Widget test_widget;
char *test_text = "Test Widget";
XEvent event;
pid_t pid2;
int status = 0;
int	pstatus;
pid_t	pid3;

	FORK(pid3);
	tet_infoline("PREP: Initialize toolkit");
	sprintf(ebuf, "DISPLAY=%s", config.display);
	putenv(ebuf);
	sleep(config.reset_delay);
	topLevel = (Widget) XtInitialize("Tadaction1", "Tadaction1",
		(XrmOptionDescRec*) NULL,
		(Cardinal) 0,
		(int *) &argc, (String*) argv);
	setPosSize(topLevel);
	FORK(pid2);
	tet_infoline("PREP: Set up the XtToolkitError handler");
	app_ctext = XtWidgetToApplicationContext(topLevel);
	XtAppSetErrorMsgHandler(app_ctext, xt_handler);
	tet_infoline("PREP: Set up widget tree of depth eight (8) return panedw widget");
	panedw = (Widget) avs_xt_tree(topLevel);
	tet_infoline("PREP: Create boxw1 widget in panedw widget");
	boxw1 = (Widget) CreateBoxWidget(panedw);
	tet_infoline("PREP: Create rowcolw widget in boxw1 widget");
	rowcolw = (Widget) CreateRowColWidget(boxw1);
	tet_infoline("PREP: Create push button gadget `Quit' in rowcolw widget");
	click_quit = (Widget) CreatePushButtonGadget("Quit", rowcolw);
	tet_infoline("PREP: Add callback procedure DestroyTree to push button gadget `Quit' ");
	XtAddCallback(click_quit,
			XtNcallback,
			DestroyTree,
			(XtPointer)topLevel
			);
	tet_infoline("PREP: Get the label widget name");
	strcpy(label, (char *)title("XtAddActions") );
	sprintf(ebuf, "PREP: Create label: %s in boxw1 widget", label);
	tet_infoline(ebuf);
	labelw = (Widget) CreateLabelWidget(label, boxw1);
	tet_infoline("PREP: Register procedure DestroyTree to handle events to rowcolw widget");
	XtAddEventHandler(rowcolw,
		 ButtonReleaseMask,
		 False,
		 (XtEventHandler)DestroyTree,
		 (XtPointer)topLevel
		 );
	tet_infoline("PREP: Create boxw2 widget in panedw widget");
	boxw2 = (Widget) CreateBoxWidget(panedw);
	tet_infoline("PREP: Set height and width of boxw2 widget");
	ConfigureDimension(topLevel, boxw2);
	tet_infoline("PREP: Create AVS Widget");
	test_widget = (Widget) CreateLabelWidget(test_text, boxw1);
	tet_infoline("TEST: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Register action table with resource manager");
	XtAddActions(actions, XtNumber(actions));
	tet_infoline("TEST: Invoke the action procedure");
	XtCallActionProc(test_widget, AVS_WID_ACTION, &event,
		(String *)NULL, (Cardinal)0 );
	LKROF(pid2, AVSXTTIMEOUT-4);
	KROF3(pid3, pstatus, AVSXTTIMEOUT-2);
        if (pstatus != 0) {
		tet_infoline("ERROR: Test process exited abnormally");
		tet_infoline("       May mean display cannot be opened");
		tet_result(TET_UNRESOLVED);
	}
	else {
		tet_infoline("TEST: Action procedure was invoked");
		status = avs_get_event(1);
		check_dec(1, status, "Action procedure invocations count");
		tet_result(TET_PASS);
	}
>>ASSERTION Good A
When an action is registered with the same name by 
multiple calls to
void XtAddActions(actions, num_actions)
the most recently registered action shall 
override the rest.
>>CODE
char label[80];
Widget test_widget;
char *test_text = "Test Widget";
XEvent event;
pid_t pid2;
int status = 0;
int	pstatus;
pid_t	pid3;

	FORK(pid3);
	tet_infoline("PREP: Initialize toolkit");
	sprintf(ebuf, "DISPLAY=%s", config.display);
	putenv(ebuf);
	sleep(config.reset_delay);
	topLevel = (Widget) XtInitialize("Tadaction1", "Tadaction1",
		(XrmOptionDescRec*) NULL,
		(Cardinal) 0,
		(int *) &argc, (String*) argv);
	setPosSize(topLevel);
	FORK(pid2);
	tet_infoline("PREP: Set up the XtToolkitError handler");
	app_ctext = XtWidgetToApplicationContext(topLevel);
	XtAppSetErrorMsgHandler(app_ctext, xt_handler);
	tet_infoline("PREP: Set up widget tree of depth eight (8) return panedw widget");
	panedw = (Widget) avs_xt_tree(topLevel);
	tet_infoline("PREP: Create boxw1 widget in panedw widget");
	boxw1 = (Widget) CreateBoxWidget(panedw);
	tet_infoline("PREP: Create rowcolw widget in boxw1 widget");
	rowcolw = (Widget) CreateRowColWidget(boxw1);
	tet_infoline("PREP: Create push button gadget `Quit' in rowcolw widget");
	click_quit = (Widget) CreatePushButtonGadget("Quit", rowcolw);
	tet_infoline("PREP: Add callback procedure DestroyTree to push button gadget `Quit' ");
	XtAddCallback(click_quit,
			XtNcallback,
			DestroyTree,
			(XtPointer)topLevel
			);
	tet_infoline("PREP: Get the label widget name");
	strcpy(label, (char *)title("XtAddActions") );
	sprintf(ebuf, "PREP: Create label: %s in boxw1 widget", label);
	tet_infoline(ebuf);
	labelw = (Widget) CreateLabelWidget(label, boxw1);
	tet_infoline("PREP: Register procedure DestroyTree to handle events to rowcolw widget");
	XtAddEventHandler(rowcolw,
		 ButtonReleaseMask,
		 False,
		 (XtEventHandler)DestroyTree,
		 (XtPointer)topLevel
		 );
	tet_infoline("PREP: Create boxw2 widget in panedw widget");
	boxw2 = (Widget) CreateBoxWidget(panedw);
	tet_infoline("PREP: Set height and width of boxw2 widget");
	ConfigureDimension(topLevel, boxw2);
	tet_infoline("PREP: Create AVS Widget");
	test_widget = (Widget) CreateLabelWidget(test_text, boxw1);
	tet_infoline("TEST: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Register action table with resource manager");
	XtAddActions(actions, XtNumber(actions));
	tet_infoline("TEST: Register another action table with resource manager");
	XtAddActions(actions3, XtNumber(actions3));
	tet_infoline("TEST: Invoke the action procedure");
	XtCallActionProc(test_widget, AVS_WID_ACTION, &event,
		(String *)NULL, (Cardinal)0 );
	LKROF(pid2, AVSXTTIMEOUT-4);
	KROF3(pid3, pstatus, AVSXTTIMEOUT-2);
        if (pstatus != 0) {
		tet_infoline("ERROR: Test process exited abnormally");
		tet_infoline("       May mean display cannot be opened");
		tet_result(TET_UNRESOLVED);
	}
	else {
		tet_infoline("TEST: Second action procedure was invoked");
		status = avs_get_event(2);
		check_dec(1, status, "Second action procedure invocations count");
		tet_infoline("TEST: First action procedure was not invoked");
		status = avs_get_event(1);
		check_dec(0, status, "First action procedure invocations count");
		tet_result(TET_PASS);
	}
>>ASSERTION Good A
When duplicate actions exist in an action table registered 
by a call to
void XtAddActions(actions, num_actions)
the first occurrence of the action in the table 
shall override the rest.
>>CODE
char label[80];
Widget test_widget;
char *test_text = "Test Widget";
XEvent event;
pid_t pid2;
int status = 0;
int	pstatus;
pid_t	pid3;

	FORK(pid3);
	tet_infoline("PREP: Initialize toolkit");
	sprintf(ebuf, "DISPLAY=%s", config.display);
	putenv(ebuf);
	sleep(config.reset_delay);
	topLevel = (Widget) XtInitialize("Tadaction1", "Tadaction1",
		(XrmOptionDescRec*) NULL,
		(Cardinal) 0,
		(int *) &argc, (String*) argv);
	setPosSize(topLevel);
	FORK(pid2);
	tet_infoline("PREP: Set up the XtToolkitError handler");
	app_ctext = XtWidgetToApplicationContext(topLevel);
	XtAppSetErrorMsgHandler(app_ctext, xt_handler);
	tet_infoline("PREP: Set up widget tree of depth eight (8) return panedw widget");
	panedw = (Widget) avs_xt_tree(topLevel);
	tet_infoline("PREP: Create boxw1 widget in panedw widget");
	boxw1 = (Widget) CreateBoxWidget(panedw);
	tet_infoline("PREP: Create rowcolw widget in boxw1 widget");
	rowcolw = (Widget) CreateRowColWidget(boxw1);
	tet_infoline("PREP: Create push button gadget `Quit' in rowcolw widget");
	click_quit = (Widget) CreatePushButtonGadget("Quit", rowcolw);
	tet_infoline("PREP: Add callback procedure DestroyTree to push button gadget `Quit' ");
	XtAddCallback(click_quit,
			XtNcallback,
			DestroyTree,
			(XtPointer)topLevel
			);
	tet_infoline("PREP: Get the label widget name");
	strcpy(label, (char *)title("XtAddActions") );
	sprintf(ebuf, "PREP: Create label: %s in boxw1 widget", label);
	tet_infoline(ebuf);
	labelw = (Widget) CreateLabelWidget(label, boxw1);
	tet_infoline("PREP: Register procedure DestroyTree to handle events to rowcolw widget");
	XtAddEventHandler(rowcolw,
		 ButtonReleaseMask,
		 False,
		 (XtEventHandler)DestroyTree,
		 (XtPointer)topLevel
		 );
	tet_infoline("PREP: Create boxw2 widget in panedw widget");
	boxw2 = (Widget) CreateBoxWidget(panedw);
	tet_infoline("PREP: Set height and width of boxw2 widget");
	ConfigureDimension(topLevel, boxw2);
	tet_infoline("PREP: Create AVS Widget");
	test_widget = (Widget) CreateLabelWidget(test_text, boxw1);
	tet_infoline("TEST: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Register action table with resource manager");
	XtAddActions(actions2, XtNumber(actions2));
	tet_infoline("TEST: Invoke the action procedure");
	XtCallActionProc(test_widget, AVS_WID_ACTION, &event,
		(String *)NULL, (Cardinal)0 );
	LKROF(pid2, AVSXTTIMEOUT-4);
	KROF3(pid3, pstatus, AVSXTTIMEOUT-2);
        if (pstatus != 0) {
		tet_infoline("ERROR: Test process exited abnormally");
		tet_infoline("       May mean display cannot be opened");
		tet_result(TET_UNRESOLVED);
	}
	else {
		tet_infoline("TEST: First action procedure was invoked");
		status = avs_get_event(1);
		check_dec(1, status, "First action procedure invocations count");
		tet_infoline("TEST: Second action procedure was not invoked");
		status = avs_get_event(2);
		check_dec(0, status, "Second action procedure invocations count");
		tet_result(TET_PASS);
	}
