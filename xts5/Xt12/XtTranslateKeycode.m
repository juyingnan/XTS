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
>># File: xts/Xt12/XtTranslateKeycode.m
>># 
>># Description:
>>#	Tests for XtTranslateKeycode()
>># 
>># Modifications:
>># $Log: ttranskcd.m,v $
>># Revision 1.1  2005-02-12 14:37:57  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:38:01  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:00  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:29:04  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:25:37  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.1  1996/02/26 23:11:42  andy
>># Added cast per SR 92
>>#
>># Revision 4.0  1995/12/15  09:21:12  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:16:52  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>
#define XK_MISCELLANY
#include <X11/keysymdef.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;

void Proc(dpy, keycode, modifiers, modifiers_return, keysym_return)
Display *dpy;
KeyCode keycode;
Modifiers modifiers;
Modifiers *modifiers_return;
KeySym *keysym_return;
{
	KeySym keysym;
	avs_set_event(1,1);
	keysym = XKeycodeToKeysym(dpy, keycode, 0);
	*keysym_return = keysym;
	*modifiers_return = modifiers;
 
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtTranslateKeycode Xt12
void
XtTranslateKeycode(display, keycode, modifiers, modifiers_return, keysym_return)
>>ASSERTION Good A
A successful call to
void XtTranslateKeycode(display, keycode, modifiers, 
modifiers_return, keysym_return)
shall invoke the currently registered KeyCode-to-KeySym 
translator for the KeyCode
.A keycode
with the specified arguments and return the associated KeySym in
.A keysym_return.
>>CODE
Display *display;
KeyCode keycode;
KeyCode *keycodes_return;
Modifiers modifiers;
Modifiers modifiers_return;
KeySym keysym_return;
KeySym keysym;
Cardinal keycount_return;
int invoked = 0;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Ttranskcd1", "XtTranslateKeycode");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get display");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Register Key Translator Proc");
	XtSetKeyTranslator(display, (XtKeyProc)Proc);
	tet_infoline("PREP: Get keysym for alphabet 'a'");
	keysym = XStringToKeysym("a");
	tet_infoline("PREP: Get keycode list for keysym");
	XtKeysymToKeycodeList(display, keysym,
			&keycodes_return, &keycount_return);
	tet_infoline("TEST: Invoke keycode-to-keysym translator");
	keycode = *keycodes_return;
	modifiers = 0;
	XtTranslateKeycode(display, keycode, modifiers,
			&modifiers_return, &keysym_return);
	tet_infoline("TEST: Keysym values are identical");
	check_dec(keysym, keysym_return, "keysym");
	tet_infoline("TEST: Key Translator Proc was invoked");
	/* get the shared memory address 1 value */
	invoked = avs_get_event(1);
	if (!invoked) {
		sprintf(ebuf, "ERROR: Procedure Proc was not invoked");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to
void XtTranslateKeycode(display, keycode, modifiers, 
modifiers_return, keysym_return)
shall return a mask that indicates the modifiers actually used to
generate the KeySym in
.A modifiers_return.
>>CODE
Display *display;
KeyCode keycode;
KeyCode *keycodes_return;
Modifiers modifiers;
Modifiers modifiers_return;
KeySym keysym_return;
KeySym keysym;
Cardinal keycount_return;
int invoked = 0;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Ttranskcd2", "XtTranslateKeycode");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get display");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Register Key Translator Proc");
	XtSetKeyTranslator(display, Proc);
	tet_infoline("PREP: Get keysym for alphabet 'a'");
	keysym = XStringToKeysym("a");
	tet_infoline("PREP: Get keycode list for keysym");
	XtKeysymToKeycodeList(display, keysym,
			&keycodes_return, &keycount_return);
	keycode = *keycodes_return;
	modifiers = ShiftMask;
	modifiers_return = 0xff;
	tet_infoline("TEST: Invoke keycode-to-keysym translator");
	XtTranslateKeycode(display, keycode, modifiers,
			&modifiers_return, &keysym_return);
	tet_infoline("TEST: modifiers_return");
	check_dec(ShiftMask, modifiers_return, "modifiers_return");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
