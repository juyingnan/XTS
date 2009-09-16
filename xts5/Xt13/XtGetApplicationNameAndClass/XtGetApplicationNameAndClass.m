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
>># File: tset/Xt13/XtGetApplicationNameAndClass/XtGetApplicationNameAndClass.m
>># 
>># Description:
>>#	Tests for XtGetApplicationNameAndClass()
>># 
>># Modifications:
>># $Log: tgtapnacl.m,v $
>># Revision 1.1  2005-02-12 14:37:57  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:38:19  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:21  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:29:21  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:25:55  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:22:05  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:18:15  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;
>>TITLE XtGetApplicationNameAndClass Xt13
void
XtGetApplicationNameAndClass(display, name_return, class_return)
>>ASSERTION Good A
A call to 
void XtGetApplicationNameAndClass(display, name_return, class_return)
shall return the application name and the application class
passed to XtDisplayInitialize for the display
.A display
in
.A name_return 
and
.A class_return 
respectively.
>>CODE
Display *display_good;
String name_good, class_good;
int argcount = 0;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tgtapnacl1", "XtGetApplicationNameAndClass");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get the application name and class");
	display_good = XtDisplay(topLevel);
	XtGetApplicationNameAndClass(display_good, &name_good, &class_good );
	tet_infoline("TEST: Name and class are valid.");
	check_str("VSW5 X Toolkit Tests", name_good, "Name of Application");
	check_str("Tgtapnacl1", class_good, "Class of Application");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good B 2
The contents of
.A name_return
and
.A class_return
on a call to 
void XtGetApplicationNameAndClass(display, name_return, class_return)
when the display
.A display 
was never initialized.
>>ASSERTION Good B 2
The contents of
.A name_return
and
.A class_return
on a call to 
void XtGetApplicationNameAndClass(display, name_return, class_return)
when the display
.A display 
has been closed.
