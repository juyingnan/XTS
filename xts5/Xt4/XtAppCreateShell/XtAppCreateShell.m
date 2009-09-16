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
>># File: tset/Xt4/XtAppCreateShell/XtAppCreateShell.m
>># 
>># Description:
>>#	Tests for XtAppCreateShell()
>># 
>># Modifications:
>># $Log: tapcrshel.m,v $
>># Revision 1.1  2005-02-12 14:38:00  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:36:24  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:59:14  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.1  1998/06/23 22:41:43  andy
>># Added sleep(XT_RESET_DELAY) to each test.  SR# 186.
>>#
>># Revision 6.0  1998/03/02 05:27:35  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:08  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:16:06  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:19:55  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>
#include <X11/Xatom.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;
>>TITLE XtAppCreateShell Xt4
Widget
XtAppCreateShell(name, application_class, widget_class, display, args, num_args)
>>ASSERTION Good A
A successful call to 
Widget XtAppCreateShell(name, application_class, widget_class, display, args, num_args) 
shall create a top-level shell widget that is 
the root of a widget tree with name as the widget instance name, 
associate it with the display specified by the argument display, and 
return the shell widget instance.
>>CODE
Display *display_good;
String name_good;
XtAppContext app_ctext_good;
Widget topLevel_good;
Boolean status;
int argcount = 0;
pid_t pid2;

	FORK(pid2);
	XtToolkitInitialize();
	tet_infoline("PREP: Create application context");
	app_ctext_good = XtCreateApplicationContext();
	tet_infoline("PREP: Open display");
	sleep(config.reset_delay);
	display_good = XtOpenDisplay(
		app_ctext_good,	/* application context */
		(String)config.display,	 /* display name */
		"Hi there",	 /* application name use argv[0] */
		"World",	 /* application class */
		(XrmOptionDescRec *)NULL,
		(Cardinal) 0,	 /* command line options */
		&argcount,
		(String *)NULL	/* command line args */
	);
	if (display_good == NULL) {
		tet_infoline("ERROR: Cannot open display");
		tet_result(TET_FAIL);
		exit(1);
	}
	tet_infoline("TEST: Create top level widget");
	topLevel_good = XtAppCreateShell("Hello", "World",
		 applicationShellWidgetClass, display_good,
		 (ArgList)NULL, (Cardinal)0);
	tet_infoline("TEST: Class is applicationShell");
	status = XtIsApplicationShell(topLevel_good);
	check_dec(True, status, "Return value");
	tet_infoline("TEST: Name");
	name_good = XtName(topLevel_good);
	check_str("Hello", name_good, "Name");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
On a successful call to 
Widget XtAppCreateShell(name, application_class, widget_class, display, args, 
num_args) 
when widget_class is ApplicationShell or a subclass thereof the shell widget 
instance created shall have WM_COMMAND property set from the values of the 
XtNargv and XtNargc resources.
>>CODE
Display *display_good;
String name_good, class_good;
char name[20], class[20];
XtAppContext app_ctext_good;
Widget widget_good;
Widget labelw_msg;
char *msg = "Property widget";
XTextProperty *text_prop;
Window window_good;
int argcount = 0;
int ret_value = 0;
Atom actual_type;
int actual_format;
unsigned long num_elements;
long bytes_after;
unsigned char *property_data_buff;
Arg args[2] = {
{ "XtNwidth", 100 },
{ "XtNheight", 100 }
};
pid_t	pid2;

	FORK(pid2);

	XtToolkitInitialize();
	tet_infoline("PREP: Create application context");
	app_ctext_good = XtCreateApplicationContext();
	tet_infoline("PREP: Open display");
	sleep(config.reset_delay);
	display_good = XtOpenDisplay(
		app_ctext_good,	/* application context */
		(String)config.display,	 /* display name */
		"Hello",	 /* application name use argv[0] */
		"World",	 /* application class */
		(XrmOptionDescRec *)NULL,
		(Cardinal)0,		/* command line options */
		&argcount,
		(String *)NULL	 /* command line args */
	);
	if (display_good == NULL) {
		tet_infoline("ERROR: Cannot open display");
		tet_result(TET_FAIL);
		exit(1);
	}
	tet_infoline("PREP: Create top level widget");
	widget_good = XtAppCreateShell("Hello", "World",
		 applicationShellWidgetClass, display_good,
		 &args[0], 2);
	tet_infoline("PREP: Create label widget");
	labelw_msg = (Widget) CreateLabelWidget(msg, widget_good);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(widget_good);
	tet_infoline("TEST: WM_COMMAND property is set");
	window_good = XtWindow(labelw_msg);
	ret_value = XGetWindowProperty(display_good, window_good,
		 XA_WM_COMMAND, (long)0,
		 128, False, AnyPropertyType,
		 &actual_type,
		 &actual_format,
		 &num_elements,
		 (unsigned long *)&bytes_after,
		 &property_data_buff);
	check_dec(Success, ret_value, "Return value");
	tet_infoline("TEST: WM_CLASS property is set");
	window_good = XtWindow(labelw_msg);
	ret_value = XGetWindowProperty(display_good, window_good,
		 XA_WM_CLASS, (long)0,
		 128, False, AnyPropertyType,
		 &actual_type,
		 &actual_format,
		 &num_elements,
		 (unsigned long *)&bytes_after,
		 &property_data_buff);
	check_dec(Success, ret_value, "Return value");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to Widget XtAppCreateShell(name, application_class, 
widget_class, display, args, num_args) when name is NULL shall name the
shell widget instance with the application name passed to XtDisplayInitialize.
>>CODE
Display *display_good;
String name_good;
XtAppContext app_ctext_good;
Widget topLevel_good;
Boolean status;
int argcount = 0;
pid_t	pid2;

	FORK(pid2);
	XtToolkitInitialize();
	tet_infoline("PREP: Create application context");
	app_ctext_good = XtCreateApplicationContext();
	tet_infoline("PREP: Open display");
	sleep(config.reset_delay);
	display_good = XtOpenDisplay(
		app_ctext_good,	/* application context */
		(String)config.display,	 /* display name */
		"Hi there",	 /* application name use argv[0] */
		"World",	 /* application class */
		(XrmOptionDescRec *)NULL,
		(Cardinal) 0,	 /* command line options */
		&argcount,
		(String *)NULL	/* command line args */
	 );
	if (display_good == NULL) {
		tet_infoline("ERROR: Cannot open display");
		tet_result(TET_FAIL);
		exit(1);
	}
	tet_infoline("TEST: Create top level widget");
	topLevel_good = XtAppCreateShell(NULL, "World",
		 applicationShellWidgetClass, display_good,
		 (ArgList)NULL, (Cardinal)0);
	tet_infoline("TEST: Class is applicationShell");
	status = XtIsApplicationShell(topLevel_good);
	check_dec(True, status, "Return value");
	tet_infoline("TEST: Name");
	name_good = XtName(topLevel_good);
	check_str("Hi there", name_good, "Name");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good B 0
A successful call to 
Widget XtAppCreateShell(name, application_class, widget_class, display, args, 
num_args) 
when args specifies the XtNscreen
argument shall create the resource database for the shell widget using the
resource values specified in args and resource values from the resource 
database of the screen specified by the XtNscreen argument for those 
resources not specified in args.
>>ASSERTION Good B 0
A successful call to 
Widget XtAppCreateShell(name, application_class, widget_class, display, args, 
num_args) 
when args does not specify the 
XtNscreen argument, widget_class is applicationShellWidgetClass or a subclass
thereof, and the resource database of the default screen for display 
specifies the resource name.screen, class application_class.screen shall 
create the resource database for the shell widget using the resource values 
specified in args and resource values from the resource database of the screen 
specified in the resource database of the default screen for those resources 
not specified in args.
>>ASSERTION Good B 0
A successful call to 
Widget XtAppCreateShell(name, application_class, widget_class, display, 
args, num_args) 
when args does not specify the XtNscreen argument, widget_class is not 
applicationShellWidgetClass or a subclass thereof, and the resource database 
of the default screen for display specifies the resource name.screen, 
class Class.screen, where Class is the class_name field from CoreClassPart 
of widget_class, shall create the resource database for the shell widget 
using the resource values specified in args and resource values from the 
resource database of the screen specified in the resource database of the 
default screen for those resources not specified in args.
>>ASSERTION Good B 0
A successful call to 
Widget XtAppCreateShell(name, application_class, widget_class, display, 
args, num_args) 
when args does not specify the XtNscreen argument and the resource database 
of the default screen for display does not specify the resource name.screen, 
class application_class.screen shall create the resource database for the 
shell widget using the resource values specified in args and resource values 
from the resource database of the default screen for those resources not
specified in args.
