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
>># File: tset/Xt4/XtRealizeWidget/XtRealizeWidget.m
>># 
>># Description:
>>#	Tests for XtRealizeWidget()
>># 
>># Modifications:
>># $Log: trealwdgt.m,v $
>># Revision 1.1  2005-02-12 14:38:04  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:36:27  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:59:17  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:27:37  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:10  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:16:15  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:20:06  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;
>>TITLE XtRealizeWidget Xt4
void
XtRealizeWidget(w)
>>ASSERTION Good B 0
A call to void XtRealizeWidget(w) shall bind all action names in the
translation table of the widget w to procedures.
>>ASSERTION Good A
A call to void XtRealizeWidget(w) when the widget w is already realized 
shall return immediately.
>>CODE
Window window_good;
Widget widget_good, labelw_good;
Display *display_good;

	avs_xt_hier("Trealwdgt2", "XtRealizeWidget");
	tet_infoline("PREP: Create test label widget `Hello' in box widget");
	labelw_good = (Widget) CreateLabelWidget("Hello", boxw1);
	tet_infoline("TEST: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Call XtRealize again");
	XtRealizeWidget(topLevel);
	tet_result(TET_PASS);
>>ASSERTION Good B 0
A call to void XtRealizeWidget(w) shall make a post order traversal of the 
widget tree starting at the widget w and call each non-NULL change_managed
procedure of all composite widgets that have one or more managed
children in the reverse order of their appearance in the CompositePart 
children list.
>>ASSERTION Good B 0
A call to void XtRealizeWidget(w) when the widget w is not a subclass of
compositeWidgetClass shall return without realizing or mapping its children.
>>ASSERTION Good B 0
A successful call to void XtRealizeWidget(w) shall recursively descend the 
widget tree starting at the widget w and call the realize procedures of all 
the managed children in the reverse order of their appearance in the 
CompositePart children list, passing to them the widget, a XtValueMask, and
a XSetWindowAttributes structure as parameters.
>>ASSERTION Good B 0
A successful call to void XtRealizeWidget(w) shall set the 
background_pixmap, border_pixmap, and the colormap fields of the 
XSetWindowAttributes structure to their corresponding fields in the 
widget core structure before passing it to the realize procedures of 
the managed children.
>>ASSERTION Good B 0
A successful call to void XtRealizeWidget(w) shall set the 
event_mask field of the XSetWindowAttributes structure to indicate the
event handlers registered, the event translations specified, the expose
field is non-NULL, and the visible_interest field is True before passing
it to the realize procedures of the managed children.
>>ASSERTION Good B 0
A successful call to void XtRealizeWidget(w) shall set the 
bit_gravity field of the XSetWindowAttributes structure, before passing
it to the realize procedures of the managed children, to NorthWestGravity 
when the expose field of the widget core structure is NULL.
>>ASSERTION Good B 0
A successful call to void XtRealizeWidget(w) shall map the windows of all the
managed children that have the mapped_when_managed field set to True.
>>ASSERTION Good A
A successful call to void XtRealizeWidget(w) when the widget w is a top-level shell
widget and has the mapped_when_managed field set to True shall map the 
widget window.
>>CODE
Window window_good;
Widget widget_good;
Display *display_good;

	avs_xt_hier("Trealwdgt2", "XtRealizeWidget");
	tet_infoline("TEST: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Check XtWindow() returns valid window id");
	if ((window_good = XtWindow(topLevel) ) <= 0 ) {
		sprintf(ebuf, "ERROR: Expected Valid window id returned %d", window_good);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
		exit(0);
	}
	tet_infoline("TEST: Window id is correct");
	display_good = XtDisplay(topLevel);
	widget_good = XtWindowToWidget(display_good, window_good);
	check_str("VSW5 X Toolkit Tests", XtName(topLevel), "widget name");
	tet_result(TET_PASS);
>>ASSERTION Good B 0
A call to void XtRealizeWidget(w) when the widget w is a top-level shell
widget and has the mapped_when_managed field set to a value other than 
True shall not map the widget window.
