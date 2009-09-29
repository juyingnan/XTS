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
>># File: xts/Xt12/XtGetActionKeysym.m
>># 
>># Description:
>>#	Tests for XtGetActionKeysym()
>># 
>># Modifications:
>># $Log: tgtacksym.m,v $
>># Revision 1.1  2005-02-12 14:37:56  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:38:03  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:03  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:29:05  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:25:39  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:21:15  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:16:57  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>
#include <AvsWid.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;

/* keysym sent */
KeySym keysym;

void AvsWidAction1(w, event, params, num_params)
Widget w;
XEvent *event;
String *params;
Cardinal *num_params;
{
	KeySym k;
	/* Indicate that action procedure was called */
	avs_set_event(1,1);
	/* Check XtGetActionKeysym returns keysym for event 
	 * KeyPress or KeyRelease
	*/
	tet_infoline("TEST: XtGetActionKeysym returns correct keysym");
	k = XtGetActionKeysym(event, (Modifiers*)NULL);
	if (k != keysym) {
		sprintf(ebuf, "ERROR: XtGetActionKeysym did not return correct keysym (got %ld, wanted %ld", k, keysym);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
}
#define AVS_WID_ACTION1 "AvsWidAction1"
XtActionsRec actions1[] = {
	{AVS_WID_ACTION1, AvsWidAction1},
};
void AvsWidAction2(w, event, params, num_params)
Widget w;
XEvent *event;
String *params;
Cardinal *num_params;
{
	KeySym k;
	/* Indicate that action procedure was called */
	avs_set_event(1,1);
	tet_infoline("TEST: XtGetActionKeysym returns correct keysym");
	k = XtGetActionKeysym(event, (Modifiers*)0);
	if (k != keysym) {
		sprintf(ebuf, "ERROR: XtGetActionKeysym did not return correct keysym (got %ld, wanted %ld", k, keysym);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
}
#define AVS_WID_ACTION2 "AvsWidAction2"
XtActionsRec actions2[] = {
	{AVS_WID_ACTION2, AvsWidAction2},
};
void AvsWidAction3(w, event, params, num_params)
Widget w;
XEvent *event;
String *params;
Cardinal *num_params;
{
	Modifiers modret;
	KeySym k;
	/* Indicate that action procedure was called */
	avs_set_event(1,1);
	/* Check XtGetActionKeysym returns keysym for event 
	 * KeyPress or KeyRelease
	*/
	tet_infoline("TEST: XtGetActionKeysym returns correct keysym");
	k = XtGetActionKeysym(event, &modret);
	if (k != keysym) {
		sprintf(ebuf, "ERROR: XtGetActionKeysym did not return correct keysym (got %ld, wanted %ld", k, keysym);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: XtGetActionKeysym returns correct modifiers");
	if (modret != ShiftMask) {
		sprintf(ebuf, "ERROR: XtGetActionKeysym did not return correct modifiers (got %ld, wanted %ld", modret, ShiftMask);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
}
#define AVS_WID_ACTION3 "AvsWidAction3"
XtActionsRec actions3[] = {
	{AVS_WID_ACTION3, AvsWidAction3},
};

/* keysym received */
KeySym k;

/* keysym sent */
KeySym keysymA;
KeySym keysymB;

XEvent eventA, eventB;

void AvsWidAction5(w, event, params, num_params)
Widget w;
XEvent *event;
String *params;
Cardinal *num_params;
{
	KeySym k;
	/* Indicate that action procedure was called */
	avs_set_event(1,1);
	tet_infoline("PREP: Call XtGetActionKeysym with event for 'B'");
	k = XtGetActionKeysym(&eventB, (Modifiers*)0);
	tet_infoline("TEST: XtGetActionKeysym returns correct keysym");
	if (k != keysymB) {
		sprintf(ebuf, "ERROR: XtGetActionKeysym did not return correct keysym (got %ld, wanted %ld", k, keysymB);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
}
#define AVS_WID_ACTION5 "AvsWidAction5"
XtActionsRec actions5[] = {
	{AVS_WID_ACTION5, AvsWidAction5},
};

void AvsWidAction6(w, event, params, num_params)
Widget w;
XEvent *event;
String *params;
Cardinal *num_params;
{
	KeySym k;
	/* Indicate that action procedure was called */
	avs_set_event(1,1);
	tet_infoline("PREP: Call XtGetActionKeysym with event for 'B'");
	k = XtGetActionKeysym(&eventB, (Modifiers*)0);
	tet_infoline("TEST: XtGetActionKeysym returns correct keysym");
	if (k != keysymB) {
		sprintf(ebuf, "ERROR: XtGetActionKeysym did not return correct keysym (got %ld, wanted %ld", k, keysymB);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
}
#define AVS_WID_ACTION6 "AvsWidAction6"
XtActionsRec actions6[] = {
	{AVS_WID_ACTION6, AvsWidAction6},
};
void AvsWidAction7(w, event, params, num_params)
Widget w;
XEvent *event;
String *params;
Cardinal *num_params;
{
	KeySym k;
	/* Indicate that action procedure was called */
	avs_set_event(1,1);
	/* Check XtGetActionKeysym returns keysym for event 
	 * KeyPress or KeyRelease
	*/
	tet_infoline("TEST: NoSymbol is returned");
	k = XtGetActionKeysym(event, (Modifiers*)0);
	if (k != NoSymbol) {
		sprintf(ebuf, "ERROR: XtGetActionKeysym did not return NoSymbol (got %ld, wanted %ld", k, NoSymbol);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
}
#define AVS_WID_ACTION7 "AvsWidAction7"
XtActionsRec actions7[] = {
	{AVS_WID_ACTION7, AvsWidAction7},
};
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtGetActionKeysym Xt12
KeySym
XtGetActionKeysym(event, modifiers_return)
>>ASSERTION Good A
When 
KeySym XtGetActionKeysym(event, modifiers_return)
is called from an action procedure, the event pointer
.A event
has the same value as the event pointer passed to the 
action procedure, and the event is a KeyPress it shall return 
the KeySym that matches the final event specification in the 
traslation table.
>>CODE
Widget test_widget;
XEvent event;
KeyCode *keycodes_return;
Cardinal keycount_return;
Display *display;
int invoked = 0;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tgtacksym1", "XtGetActionKeysym");
	tet_infoline("PREP: Create AVS widget");
	test_widget = XtVaCreateManagedWidget("avsw", avsWidgetClass, boxw1, NULL);
	tet_infoline("PREP: Register action table with resource manager");
	XtAppAddActions(app_ctext, actions1, XtNumber(actions1) );
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get keysym for alphabet 'A'");
	keysym = XStringToKeysym("A");
	tet_infoline("PREP: Get keycode list for keysym");
	display = XtDisplay(topLevel);
	XtKeysymToKeycodeList(display, keysym, &keycodes_return, &keycount_return);
	tet_infoline("PREP: Invoke action procedure");
	event.type = KeyPress;
	event.xkey.type = KeyPress;
	event.xkey.keycode = *keycodes_return;
	event.xkey.state = ShiftMask;
	event.xkey.display = display;
	XtCallActionProc(test_widget, AVS_WID_ACTION1, &event,
			(String *)NULL, (Cardinal)0);
	tet_infoline("TEST: Procedure was invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "action procedure invoked status");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When 
KeySym XtGetActionKeysym(event, modifiers_return)
is called from an action procedure, the event pointer
.A event
has the same value as the event pointer passed to the 
action procedure, and the event is a KeyRelease it shall return 
the KeySym that matches the final event specification in the 
traslation table.
>>CODE
Widget test_widget;
XEvent event;
KeyCode *keycodes_return;
Cardinal keycount_return;
Display *display;
int invoked = 0;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tgtacksym2", "XtGetActionKeysym");
	tet_infoline("PREP: Create AVS widget");
	test_widget = XtVaCreateManagedWidget("avsw",
			 avsWidgetClass, boxw1, NULL);
	tet_infoline("PREP: Register action table with resource manager");
	XtAppAddActions(app_ctext, actions2, XtNumber(actions2));
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get keysym for alphabet 'A'");
	keysym = XStringToKeysym("A");
	tet_infoline("PREP: Get keycode list for keysym");
	display = XtDisplay(topLevel);
	XtKeysymToKeycodeList(display, keysym,
			&keycodes_return, &keycount_return);
	tet_infoline("PREP: Invoke action procedure");
	event.type = KeyRelease;
	event.xkey.type = KeyRelease;
	event.xkey.keycode = *keycodes_return;
	event.xkey.state = ShiftMask;
	event.xkey.display = display;
	XtCallActionProc(test_widget, AVS_WID_ACTION2, &event,
			 (String *)NULL, (Cardinal)0);
	tet_infoline("TEST: Action Procedure was invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "action procedure invoked count");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When 
KeySym XtGetActionKeysym(event, modifiers_return)
is called from an action procedure, the event pointer
.A event
has the same value as the event pointer passed to the 
action procedure, the event is a KeyRelease or a KeyPress
event, and 
.A modifiers_return 
is non-NULL it shall return the modifiers used to generate 
the KeySym in
.A modifiers_return.
>>CODE
Widget test_widget;
XEvent event;
KeyCode *keycodes_return;
Cardinal keycount_return;
Display *display;
int invoked = 0;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tgtacksym3", "XtGetActionKeysym");
	tet_infoline("PREP: Create AVS widget");
	test_widget = XtVaCreateManagedWidget("avsw",
			 avsWidgetClass, boxw1, NULL);
	tet_infoline("PREP: Register action table with resource manager");
	XtAppAddActions(app_ctext, actions3, XtNumber(actions3));
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get keysym for alphabet 'A'");
	keysym = XStringToKeysym("A");
	tet_infoline("PREP: Get keycode list for keysym");
	display = XtDisplay(topLevel);
	XtKeysymToKeycodeList(display, keysym,
			&keycodes_return, &keycount_return);
	tet_infoline("PREP: Invoke action procedure");
	event.type = KeyRelease;
	event.xkey.type = KeyRelease;
	event.xkey.keycode = *keycodes_return;
	event.xkey.state = ShiftMask;
	event.xkey.display = display;
	XtCallActionProc(test_widget, AVS_WID_ACTION3, &event,
			 (String *)NULL, (Cardinal)0);
	tet_infoline("TEST: Action Procedure was invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "action procedure invoked count");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When 
KeySym XtGetActionKeysym(event, modifiers_return)
is not called from an action procedure and the event is a 
KeyPress it shall invoke the currently registered 
KeyCode-to-KeySym translator for the KeyCode specified by
the event pointer
.A event
and return the associated KeySym and a constant that indicates the
subset of all modifiers examined by the translator in
.A modifiers_return.
>>CODE
Widget test_widget;
XEvent event;
KeyCode *keycodes_return;
Cardinal keycount_return;
Display *display;
int invoked = 0;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tgtacksym4", "XtGetActionKeysym");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get keysym for alphabet 'A'");
	keysym = XStringToKeysym("A");
	tet_infoline("PREP: Get keycode list for keysym");
	display = XtDisplay(topLevel);
	XtKeysymToKeycodeList(display, keysym,
			&keycodes_return, &keycount_return);
	tet_infoline("PREP: Call XtGetActionKeysym");
	event.type = KeyPress;
	event.xkey.type = KeyPress;
	event.xkey.keycode = *keycodes_return;
	event.xkey.state = ShiftMask;
	event.xkey.display = display;
	tet_infoline("TEST: XtGetActionKeysym returns correct keysym");
	k = XtGetActionKeysym(&event, (Modifiers*)NULL);
	if (k != keysym) {
		sprintf(ebuf, "ERROR: XtGetActionKeysym did not return correct keysym (got %ld, wanted %ld", k, keysym);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When 
KeySym XtGetActionKeysym(event, modifiers_return)
is not called from an action procedure and the event is a 
KeyRelease it shall invoke the currently registered 
KeyCode-to-KeySym translator for the KeyCode specified by
the event pointer
.A event
and return the associated KeySym and a constant that indicates the
subset of all modifiers examined by the translator in
.A modifiers_return.
>>CODE
Widget test_widget;
XEvent event;
KeyCode *keycodes_return;
Cardinal keycount_return;
Display *display;
int invoked = 0;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tgtacksym4", "XtGetActionKeysym");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get keysym for alphabet 'A'");
	keysym = XStringToKeysym("A");
	tet_infoline("PREP: Get keycode list for keysym");
	display = XtDisplay(topLevel);
	XtKeysymToKeycodeList(display, keysym,
			&keycodes_return, &keycount_return);
	tet_infoline("PREP: Call XtGetActionKeysym");
	event.type = KeyRelease;
	event.xkey.type = KeyRelease;
	event.xkey.keycode = *keycodes_return;
	event.xkey.state = ShiftMask;
	event.xkey.display = display;
	tet_infoline("TEST: XtGetActionKeysym returns correct keysym");
	k = XtGetActionKeysym(&event, (Modifiers*)NULL);
	if (k != keysym) {
		sprintf(ebuf, "ERROR: XtGetActionKeysym did not return correct keysym (got %ld, wanted %ld", k, keysym);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When 
KeySym XtGetActionKeysym(event, modifiers_return)
is called from an action procedure, the event pointed to by
.A event
does not have the same value as the event passed to the action 
procedure, and the event is a KeyPress it shall invoke the 
currently registered KeyCode-to-KeySym translator for the KeyCode 
specified by the event pointer
.A event
and return the associated KeySym and a constant that indicates the
subset of all modifiers examined by the translator in
.A modifiers_return.
>>CODE
Widget test_widget;
KeyCode *keycodes_returnA;
KeyCode *keycodes_returnB;
Cardinal keycount_returnA;
Cardinal keycount_returnB;
Display *display;
int invoked = 0;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tgtacksym5", "XtGetActionKeysym");
	tet_infoline("PREP: Create AVS widget");
	test_widget = XtVaCreateManagedWidget("avsw",
			 avsWidgetClass, boxw1, NULL);
	tet_infoline("PREP: Register action table with resource manager");
	XtAppAddActions(app_ctext, actions5, XtNumber(actions5) );
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get keysyms for alphabet 'A' and 'B'");
	keysymA = XStringToKeysym("A");
	keysymB = XStringToKeysym("B");
	tet_infoline("PREP: Get keycode lists for keysyms");
	display = XtDisplay(topLevel);
	XtKeysymToKeycodeList(display, keysymA, &keycodes_returnA, &keycount_returnA);
	XtKeysymToKeycodeList(display, keysymB, &keycodes_returnB, &keycount_returnB);
	tet_infoline("PREP: Invoke action procedure with event for 'A'");
	eventA.type = KeyPress;
	eventB.type = KeyPress;
	eventA.xkey.type = KeyPress;
	eventB.xkey.type = KeyPress;
	eventA.xkey.keycode = *keycodes_returnA;
	eventB.xkey.keycode = *keycodes_returnB;
	eventA.xkey.state = ShiftMask;
	eventB.xkey.state = ShiftMask;
	eventA.xkey.display = display;
	eventB.xkey.display = display;
	XtCallActionProc(test_widget, AVS_WID_ACTION5, &eventA,
			 (String *)NULL, (Cardinal)0);
	tet_infoline("TEST: Action Procedure was invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "action procedure invoked count");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When 
KeySym XtGetActionKeysym(event, modifiers_return)
is called from an action procedure, the event pointed to by
.A event
does not have the same value as the event passed to the action 
procedure, and the event is a KeyRelease it shall invoke the 
currently registered KeyCode-to-KeySym translator for the KeyCode 
specified by the event pointer
.A event
and return the associated KeySym and a constant that indicates the
subset of all modifiers examined by the translator in
.A modifiers_return.
>>CODE
Widget test_widget;
KeyCode *keycodes_returnA;
KeyCode *keycodes_returnB;
Cardinal keycount_returnA;
Cardinal keycount_returnB;
Display *display;
int invoked = 0;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tgtacksym6", "XtGetActionKeysym");
	tet_infoline("PREP: Create AVS widget");
	test_widget = XtVaCreateManagedWidget("avsw",
			 avsWidgetClass, boxw1, NULL);
	tet_infoline("PREP: Register action table with resource manager");
	XtAppAddActions(app_ctext, actions6, XtNumber(actions6) );
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get keysyms for alphabet 'A' and 'B'");
	keysymA = XStringToKeysym("A");
	keysymB = XStringToKeysym("B");
	tet_infoline("PREP: Get keycode lists for keysyms");
	display = XtDisplay(topLevel);
	XtKeysymToKeycodeList(display, keysymA, &keycodes_returnA, &keycount_returnA);
	XtKeysymToKeycodeList(display, keysymB, &keycodes_returnB, &keycount_returnB);
	tet_infoline("PREP: Invoke action procedure with event for 'A'");
	eventA.type = KeyRelease;
	eventB.type = KeyRelease;
	eventA.xkey.type = KeyRelease;
	eventB.xkey.type = KeyRelease;
	eventA.xkey.keycode = *keycodes_returnA;
	eventB.xkey.keycode = *keycodes_returnB;
	eventA.xkey.state = ShiftMask;
	eventB.xkey.state = ShiftMask;
	eventA.xkey.display = display;
	eventB.xkey.display = display;
	XtCallActionProc(test_widget, AVS_WID_ACTION6, &eventA,
			 (String *)NULL, (Cardinal)0);
	tet_infoline("TEST: Action Procedure was invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "action procedure invoked count");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When the event pointed to by
.A event
is neither a KeyPress nor a KeyRelease event a call to 
KeySym XtGetActionKeysym(event, modifiers_return)
shall return 
.S NoSymbol
and ignore
.A modifiers_return.
>>CODE
XEvent event;
Widget test_widget;
KeySym keysym, keysym_good;
KeyCode *keycodes_return, code;
Cardinal keycount_return;
Display *display;
int invoked = 0;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tgtacksym7", "XtGetActionKeysym");
	tet_infoline("PREP: Create AVS widget");
	test_widget = XtVaCreateManagedWidget("avsw",
			 avsWidgetClass, boxw1, NULL);
	tet_infoline("PREP: Register action table with resource manager");
	XtAppAddActions(app_ctext, actions7, XtNumber(actions7) );
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get keysym for alphabet 'a'");
	keysym = XStringToKeysym("a");
	tet_infoline("PREP: Get keycode list for keysym");
	display = XtDisplay(topLevel);
	XtKeysymToKeycodeList(display, keysym,
			&keycodes_return, &keycount_return);
	tet_infoline("PREP: Invoke action procedure");
	event.type = ButtonPress;
	event.xbutton.state = ShiftMask;
	event.xbutton.display = display;
	XtCallActionProc(test_widget, AVS_WID_ACTION7, &event,
			(String *)NULL, (Cardinal)0);
	tet_infoline("TEST: Action Procedure was invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "action procedure invoked count");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
