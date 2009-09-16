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
$Header: /cvs/xtest/xtest/xts5/tset/XtC/XtCreateApplicationShell/XtCreateApplicationShell.m,v 1.1 2005-02-12 14:38:24 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/XtC/XtCreateApplicationShell/XtCreateApplicationShell.m
>># 
>># Description:
>>#	Tests for XtCreateApplicationShell()
>># 
>># Modifications:
>># $Log: tcrappshl.m,v $
>># Revision 1.1  2005-02-12 14:38:24  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:38:32  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:35  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:29:34  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:26:07  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:22:44  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:19:23  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;
>>TITLE XtCreateApplicationShell XtC
Widget
XtCreateApplicationShell(name, widget_class, args, num_args)
>>ASSERTION Good A
A successful call to 
Widget XtCreateApplicationShell(name, widget_class, 
args, num_args)
shall create a top-level shell widget that is 
the root of a widget tree with name as the widget 
instance name and return the shell widget instance.
>>CODE
Display *display_good;
Widget widget_good, labelw_good;
Boolean status;
Arg setargs[2];
pid_t pid2;
pid_t pid3;
int pstatus;

	FORK(pid3);
	avs_xt_hier_def("Tcrappshl1", "XtCreateApplicationShell");
	FORK(pid2);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Create additional top-level widget");
	setargs[0].name = (String)XtNwidth;
	setargs[0].value = (XtArgVal)100;
	setargs[1].name = (String)XtNheight;
	setargs[1].value = (XtArgVal)100;
	widget_good = XtCreateApplicationShell(
		"Tcrappshl1",	/* application name */
		applicationShellWidgetClass, /* widget class */
		&setargs[0],
		(Cardinal)2
		);
	tet_infoline("TEST: Widget_good class is applicationShellWidgetClass");
	status = XtIsApplicationShell(widget_good);
	check_dec(True, status, "XtIsApplicationShell return value");
	LKROF(pid2, AVSXTTIMEOUT-4);
	KROF3(pid3, pstatus, AVSXTTIMEOUT-2);
        if (pstatus != 0) {
		tet_infoline("ERROR: Test process exited abnormally");
		tet_infoline("       May mean display cannot be opened");
		tet_result(TET_UNRESOLVED);
        }
	else
		tet_result(TET_PASS);
>>ASSERTION Good B 0
On a successful call to 
Widget XtCreateApplicationShell(name, widget_class, args, num_args)
when widget_class is ApplicationShell or a subclass 
thereof the shell widget instance created shall 
have the WM_COMMAND property set from the values of the 
XtNargv and XtNargc resources.
>>ASSERTION Good A
A successful call to 
Widget XtCreateApplicationShell(name, widget_class, args, num_args)
when name is NULL shall name the
shell widget instance with the application name 
passed to XtDisplayInitialize.
>>CODE
Display *display_good;
Widget widget_good, labelw_good;
Boolean status;
Arg setargs[2];
pid_t pid2;
pid_t pid3;
int pstatus;
String	name_good, class_good;

	FORK(pid3);
	avs_xt_hier_def("Tcrappshl2", "XtCreateApplicationShell");
	FORK(pid2);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Create additional top-level widget");
	setargs[0].name = (String)XtNwidth;
	setargs[0].value = (XtArgVal)100;
	setargs[1].name = (String)XtNheight;
	setargs[1].value = (XtArgVal)100;
	widget_good = XtCreateApplicationShell(
		NULL,	/* application name */
		applicationShellWidgetClass, /* widget class */
		&setargs[0],
		(Cardinal)2
		);
	tet_infoline("TEST: Application name");
	display_good = XtDisplay(widget_good);
        XtGetApplicationNameAndClass(display_good, &name_good, &class_good );
        check_str("main", name_good, "Application Name");
	LKROF(pid2, AVSXTTIMEOUT-4);
	KROF3(pid3, pstatus, AVSXTTIMEOUT-2);
        if (pstatus != 0) {
		tet_infoline("ERROR: Test process exited abnormally");
		tet_infoline("       May mean display cannot be opened");
		tet_result(TET_UNRESOLVED);
        }
	else
		tet_result(TET_PASS);
>>ASSERTION Good B 0
A successful call to 
Widget XtCreateApplicationShell(name, widget_class, args, num_args)
when 
.A args 
specifies the XtNscreen argument shall create the 
resource database for the shell widget using the
resource values specified in 
.A args 
and resource values from the resource database of 
the screen specified by the XtNscreen argument for 
those resources not specified in 
.A args.
>>ASSERTION Good B 0
A successful call to 
Widget XtCreateApplicationShell(name, widget_class, args, num_args)
when args does not specify the 
XtNscreen argument, widget_class is applicationShellWidgetClass 
or a subclass thereof, and the resource database of the 
default screen for display specifies the resource name.screen, 
class class.screen, where class is the application class passed
to XtInitialize, shall create the resource database 
for the shell widget using the resource values specified 
in args and resource values from the resource database 
of the screen specified in the resource database of the 
default screen for those resources not specified in args.
>>ASSERTION Good B 0
A successful call to 
Widget XtCreateApplicationShell(name, widget_class, args, num_args)
when args does not specify the XtNscreen argument, 
widget_class is not applicationShellWidgetClass or a 
subclass thereof, and the resource database of the 
default screen for display specifies the resource name.screen, 
class Class.screen, where Class is the class_name field 
from CoreClassPart of widget_class, shall create the 
resource database for the shell widget using the resource 
values specified in args and resource values from the 
resource database of the screen specified in the resource 
database of the default screen for those resources not 
specified in args.
>>ASSERTION Good B 0
A successful call to 
Widget XtCreateApplicationShell(name, widget_class, args, num_args)
when args does not specify the XtNscreen argument and 
the resource database of the default screen for display 
does not specify the resource name.screen, class 
class.screen, where class is the application class passed to
XtInitialize, shall create the resource 
database for the shell widget using the resource values 
specified in args and resource values from the resource 
database of the default screen for those resources not
specified in args.
