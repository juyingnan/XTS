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
>># File: xts/Xt4/XtScreenOfObject/XtScreenOfObject.m
>># 
>># Description:
>>#	Tests for XtScreenOfObject()
>># 
>># Modifications:
>># $Log: tscnofobt.m,v $
>># Revision 1.1  2005-02-12 14:38:05  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:36:30  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:59:20  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:27:40  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:14  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:16:23  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:20:18  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;
>>TITLE XtScreenOfObject Xt4
Screen *
XtScreenOfObject(object)
>>ASSERTION Good A
A call to Screen *XtScreenOfObject(object) when object is a widget
shall return the screen pointer for the widget.
>>CODE
Screen *screen_good, *ret_screen;
Display *display_good;
int ret_screen_id , screen_id_good;

	avs_xt_hier("Tscnofobt1", "XtScreenOfObject");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Get the screen pointer for widget label");
	if ((screen_good = XtScreenOfObject(labelw)) == NULL) {
			sprintf(ebuf, "ERROR: Expected Screen pointer returned NULL");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Returned screen pointer is valid");
	display_good = XtDisplay(labelw);
	ret_screen = XDefaultScreenOfDisplay(display_good);
	ret_screen_id = XScreenNumberOfScreen(ret_screen);
	screen_id_good = XScreenNumberOfScreen(screen_good);
	check_dec(screen_id_good, ret_screen_id, "screen number");
	tet_result(TET_PASS);
>>ASSERTION Good A
A call to 
Screen *XtScreenOfObject(object) 
when object is not a widget shall return the screen pointer for the nearest 
ancestor of object that is of class Object or a subclass thereof.
>>CODE
Screen *screen_good, *ret_screen;
Display *display_good;
int ret_screen_id , screen_id_good;

	avs_xt_hier("Tscnofobt2", "XtScreenOfObject");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Get the screen pointer for push button gadget");
	if ((screen_good = XtScreenOfObject(click_quit)) == NULL) {
		sprintf(ebuf, "ERROR: Expected Screen pointer returned NULL");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Returned screen pointer is that of the gadget's parent");
	display_good = XtDisplay(rowcolw);
	ret_screen = XDefaultScreenOfDisplay(display_good);
	ret_screen_id = XScreenNumberOfScreen(ret_screen);
	screen_id_good = XScreenNumberOfScreen(screen_good);
	check_dec(screen_id_good, ret_screen_id, "screen number");
	tet_result(TET_PASS);
