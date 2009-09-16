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
$Header: /cvs/xtest/xtest/xts5/tset/Xt4/XtScreen/XtScreen.m,v 1.1 2005-02-12 14:38:07 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt4/XtScreen/XtScreen.m
>># 
>># Description:
>>#	Tests for XtScreen()
>># 
>># Modifications:
>># $Log: tscreen.m,v $
>># Revision 1.1  2005-02-12 14:38:07  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:36:29  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:59:19  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:27:39  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:12  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:16:21  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:20:14  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>
XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;
>>TITLE XtScreen Xt4
Screen *
XtScreen(w)
>>ASSERTION Good A
A call to Screen *XtScreen(w) shall return the screen pointer for the widget w.
>>CODE
Screen *screen_good, *ret_screen;
Display *display_good;
int screen_id_good , ret_screen_id;

	avs_xt_hier("Tscreen1", "XtScreen");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: XtScreen shall return the screen pointer for labelw widget");
	if ((screen_good = XtScreen(labelw)) == NULL) {
		tet_infoline("ERROR: Expected Screen pointer returned NULL");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Returned screen pointer is valid");
	display_good = XtDisplay(labelw);
	ret_screen = XDefaultScreenOfDisplay(display_good);
	ret_screen_id = XScreenNumberOfScreen(ret_screen);
	screen_id_good = XScreenNumberOfScreen(screen_good);
	check_dec(screen_id_good, ret_screen_id, "screen number");
	tet_result(TET_PASS);
