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
>># File: xts/Xt12/XtRegisterGrabAction.m
>># 
>># Description:
>>#	Tests for XtRegisterGrabAction()
>># 
>># Modifications:
>># $Log: tregraba.m,v $
>># Revision 1.1  2005-02-12 14:37:56  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:38:04  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.1  1998/11/20 23:33:22  mar
>># req.4.W.00130: tp1-3 - use a valid keysym instead of zero (min is 8)
>>#
>># Revision 7.0  1998/10/30 23:01:04  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:29:06  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:25:40  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:21:19  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:17:01  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>
#ifdef XTESTEXTENSION
#include <X11/extensions/XTest.h>
#endif

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;

extern char *event_names[];

Widget click_pass, click_fail;
char label[80];
int status;
Widget labelw_msg;

#ifdef XTESTEXTENSION
static void XtACP_Proc(widget, event, params, num_params)
Widget widget;
XEvent *event;
String *params;
Cardinal *num_params;
{
	avs_set_event(2,1);
}

/*
** procedure XtTMO_Proc
*/
void XtTMO_Proc2(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
XEvent event;

	tet_infoline("ERROR: Timed out waiting for user input");
	tet_result(TET_UNRESOLVED);
	exit(0);
}

/*
** procedure XtTMO_Proc
*/
void XtTMO_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	Position rootx, rooty;
	XtAppAddTimeOut(app_ctext, (unsigned long)2000, XtTMO_Proc2, topLevel);
	tet_infoline("PREP: Send KeyPress outside grab widget");
	XtTranslateCoords(labelw_msg, 0,0,&rootx, &rooty);
	XTestFakeMotionEvent(XtDisplay(labelw_msg), -1, rootx+10, rooty+10, CurrentTime);
	XTestFakeKeyEvent(XtDisplay(labelw_msg), XKeysymToKeycode(XtDisplay(labelw_msg), 32), True, CurrentTime);
	XTestFakeMotionEvent(XtDisplay(labelw_msg), -1, rootx-100, rooty, CurrentTime);
	XTestFakeKeyEvent(XtDisplay(labelw_msg), XKeysymToKeycode(XtDisplay(labelw_msg), 32), False, CurrentTime);
}

static void analyse_events(TestWidget)
Widget TestWidget;
{
	XtAppContext app_context;
	Display *display;
	XEvent loop_event;
	Window window;
	Widget widget;
	app_context = XtWidgetToApplicationContext(TestWidget);
	display = XtDisplay(TestWidget);
	/*
	** Poll events
	*/
	for (;;) {
	 XtAppNextEvent(app_context, &loop_event);
	 if (loop_event.type == KeyRelease) {
		if (XtWindow(TestWidget) == loop_event.xkey.window) {
			tet_infoline("TEST: KeyRelease event in correct widget");
			if (loop_event.xkey.x >= 0 && loop_event.xkey.y >= 0) {
				sprintf(ebuf, "ERROR: Key not released above or left of widget");
				tet_infoline(ebuf);
				tet_result(TET_FAIL);
			}
			tet_infoline("TEST: KeyPress event was received and processed");
			status = avs_get_event(1);
			check_dec(1, status, "KeyPress receipt count");
			tet_infoline("TEST: Action procedure was invoked");
			status = avs_get_event(2);
			check_dec(1, status, "action proc invocation count");
			exit(0);
		}
	 } /* end if */
	 if ( loop_event.type == KeyPress ) {
	 	if (XtWindow(TestWidget) == loop_event.xkey.window)
			avs_set_event(1,1);
	 } /* end if */
	 XtDispatchEvent(&loop_event);
	 XSync(display, False);
	} /* end for */
}
#endif
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtRegisterGrabAction Xt12
void
XtRegisterGrabAction(action_proc, owner_events, event_mask, pointer_mode, keyboard_mode)
>>ASSERTION Good A
After a successful call to
void XtRegisterGrabAction(action_proc, owner_events, event_mask, pointer_mode, keyboard_mode)
when a widget for the calling process is realized and the procedure 
.A action_proc 
is present in the translation table or the accelerator table of this
widget associated with a KeyPress event shall cause a 
passive key grab to be registered for the widget window on every 
KeyCode that maps to the event detail field in the translation or 
the accelerator table.
>>CODE
#ifdef XTESTEXTENSION
Display *display;
pid_t pid2;
Window window;
int ret_value;
char *msg = "This is the grab widget\n";
XtTranslations translations;
static char trans_good[] = "#replace	\n\
	 <Key>:	XtACP_Proc()";
static XtActionsRec actions[] = {
	 {"XtACP_Proc",	XtACP_Proc},
};
#endif

#ifdef XTESTEXTENSION
	FORK(pid2);
	xt_tomultiple = 3;
	tet_infoline("PREP: Initialize toolkit, Open display and Create topLevel root widget");
	topLevel = (Widget) avs_xt_init("Tgrabbutn1", NULL, 0);
	tet_infoline("PREP: Set up the XtToolkitError handler");
	app_ctext = XtWidgetToApplicationContext(topLevel);
	XtAppSetErrorMsgHandler(app_ctext, xt_handler);
	tet_infoline("PREP: Set up widget tree of depth eight (8) return panedw widget");
	panedw = (Widget) avs_xt_tree(topLevel);
	tet_infoline("PREP: Create boxw1 widget in panedw widget");
	boxw1 = (Widget) CreateBoxWidget(panedw);
	tet_infoline("PREP: Get the label widget name");
	strcpy(label, (char *)title("XtRegisterGrabAction"));
	tet_infoline("PREP: Create label in boxw1 widget");
	labelw = (Widget) CreateLabelWidget(label, boxw1);
	tet_infoline("PREP: Create boxw2 widget in panedw widget");
	boxw2 = (Widget) CreateBoxWidget(panedw);
	tet_infoline("PREP: Set height and width of boxw2 widget");
	ConfigureDimension(topLevel, boxw2);
	sprintf(ebuf, "PREP: Create label in boxw1 widget");
	tet_infoline(ebuf);
	labelw_msg = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Add action table");
	XtAppAddActions(app_ctext, actions, 1);
	tet_infoline("PREP: Parse translation table");
	translations = XtParseTranslationTable(trans_good);
	tet_infoline("PREP: Add new translations into boxw1 widget");
	XtOverrideTranslations(labelw_msg, translations);
	tet_infoline("TEST: Register ActionProc with XtRegisterGrabAction");
	XtRegisterGrabAction(XtACP_Proc, False, ButtonPressMask|ButtonReleaseMask|KeyPressMask|KeyReleaseMask, GrabModeAsync, GrabModeAsync);
	tet_infoline("TEST: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	XSelectInput(XtDisplay(topLevel), XtWindow(topLevel), ButtonPressMask|ButtonReleaseMask|KeyPressMask|KeyReleaseMask|ExposureMask|OwnerGrabButtonMask);
	XtAppAddTimeOut(app_ctext, (unsigned long)500, XtTMO_Proc, topLevel);
	tet_infoline("TEST: Analyse user input");
	analyse_events(labelw_msg);
	LKROF(pid2, AVSXTTIMEOUT);
	tet_result(TET_PASS);
#else
	tet_infoline("INFO: XTEST extension not configured");
	tet_result(TET_UNSUPPORTED);
#endif
>>ASSERTION Good B 0
After a successful call to
void XtRegisterGrabAction(action_proc, owner_events, event_mask, pointer_mode, keyboard_mode)
when a widget in the calling process that is already realized has 
its translations or the accelerators installed being modified 
and the procedure 
.A action_proc 
is present in the translation table or the accelerator table of this
widget associated with a KeyPress event a passive key 
grab shall be registered for the widget window on every KeyCode 
that maps to the event detail field in the translation or the 
accelerator table.
>>ASSERTION Good B 0
After a successful call to
void XtRegisterGrabAction(action_proc, owner_events, event_mask, pointer_mode, keyboard_mode)
when a widget in the calling process is realized and the procedure 
.A action_proc 
is present in the translation table or the accelerator table of this
widget associated with a ButtonPress event shall cause a 
passive pointer grab to be registered for the widget window on every 
button that maps to the event detail field in the translation or 
the accelerator table.
>>ASSERTION Good B 0
After a successful call to
void XtRegisterGrabAction(action_proc, owner_events, event_mask, pointer_mode, keyboard_mode)
when a widget in the calling process that is already realized has 
its translations or the accelerators installed being modified 
and the procedure 
.A action_proc 
is present in the translation table or the accelerator table of this
widget associated with a ButtonPress event a passive 
pointer grab shall be registered for the widget window on every 
button that maps to the event detail field in the translation 
or the accelerator table.
>>ASSERTION Good B 0
After a successful call to
void XtRegisterGrabAction(action_proc, owner_events, event_mask, pointer_mode, keyboard_mode)
when a pointer grab is registered for a widget the modifiers 
specified for the grab shall be the modifiers from the translation
specification.
>>ASSERTION Good B 0
After a successful call to
void XtRegisterGrabAction(action_proc, owner_events, event_mask, pointer_mode, keyboard_mode)
when a pointer grab is registered for a widget the grab 
shall not specify the window to confine the pointer to or the
cursor that is to be displayed during the grab.
>>ASSERTION Good B 0
After a successful call to
void XtRegisterGrabAction(action_proc, owner_events, event_mask, pointer_mode, keyboard_mode)
when a keyboard grab is registered for a widget and the translation
table entry specifies colon in the modifier list the modifiers 
specified for the grab shall be the modifiers determined from
the modifier mask returned by the key translator procedure 
registered for the display and ORing these with any modifiers 
specified in the translation specification.
>>ASSERTION Good B 0
After a successful call to
void XtRegisterGrabAction(action_proc, owner_events, event_mask, pointer_mode, keyboard_mode)
when a keyboard grab is registered for a widget and the translation
table entry does not specify colon in the modifier list the modifiers 
specified for the grab shall be the modifiers specified in the 
translation specification.
>>ASSERTION Good B 0
After a successful call to
void XtRegisterGrabAction(action_proc, owner_events, event_mask, pointer_mode, keyboard_mode)
when a keyboard or a pointer grab is registered for a widget the
modifiers specified for the grab shall include don't-care modifiers
only if the translation entry specifies "Any" in the modifiers field.
>>ASSERTION Good B 0
A call to
void XtRegisterGrabAction(action_proc, owner_events, event_mask, pointer_mode, keyboard_mode)
when the procedure
.A action_proc
is already registered for the calling process 
shall cause the new values specified for the grab to
replace the previously specified values for
any widgets that become realized following the call.
>>ASSERTION Good B 0
A call to
void XtRegisterGrabAction(action_proc, owner_events, event_mask, pointer_mode, keyboard_mode)
when the procedure
.A action_proc
is already registered for the calling process 
shall not alter the existing values for the grab
on widgets that are currently realized.
