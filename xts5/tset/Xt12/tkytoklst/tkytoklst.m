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
$Header: /cvs/xtest/xtest/xts5/tset/Xt12/tkytoklst/tkytoklst.m,v 1.1 2005-02-12 14:37:56 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt12/tkytoklst/tkytoklst.m
>># 
>># Description:
>>#	Tests for XtKeysymToKeycodeList()
>># 
>># Modifications:
>># $Log: tkytoklst.m,v $
>># Revision 1.1  2005-02-12 14:37:56  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:38:03  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:03  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:29:06  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:25:39  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:21:17  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:16:59  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;
>>TITLE XtKeysymToKeycodeList Xt12
void
XtKeysymToKeycodeList(display, keysym, keycodes_return, keycount_return)
>>ASSERTION Good A
A call to
void XtKeysymToKeycodeList(display, keysym, keycodes_return, 
keycount_return)
shall return all the KeyCodes that have the KeySym
.A keysym
in their entry for the keyboard mapping table associated 
with the display
.A display
and return the number KeyCodes on the list in
.A keycount_return.
>>CODE
Display *display;
KeySym keysym, keysym_good;
KeyCode *keycodes_return, code;
Cardinal keycount_return;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tkytoklst1", "XtKeysymToKeycodeList");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get display");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Get keysym for alphabet 'a'");
	keysym = XStringToKeysym("a");
	tet_infoline("PREP: Get keycode list for keysym");
	XtKeysymToKeycodeList(display, keysym, &keycodes_return, &keycount_return);
	tet_infoline("PREP: Convert keycode to keysym");
	code = *keycodes_return;
	keysym_good = XKeycodeToKeysym(display, code, 0);
	tet_infoline("TEST: Keysym values are identical");
	check_dec(keysym, keysym_good, "keysym");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When no KeyCodes map to the KeySym
.A keysym
a call to
void XtKeysymToKeycodeList(display, keysym, keycodes_return, 
keycount_return)
shall return zero in 
.A keycount_return
and set
.A keycodes_return
to NULL.
>>CODE
Display *display;
KeyCode *keycodes_return;
Cardinal keycount_return;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tkytoklst2", "XtKeysymToKeycodeList");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get display");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Get keycode list for keysym");
	XtKeysymToKeycodeList(display, -1,
			&keycodes_return, &keycount_return);
	tet_infoline("TEST: Keycount_return is 0");
	check_dec(0, keycount_return, "keycount_return");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
