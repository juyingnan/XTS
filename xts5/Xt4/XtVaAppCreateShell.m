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
>># File: xts/Xt4/XtVaAppCreateShell.m
>># 
>># Description:
>>#	Tests for XtVaAppCreateShell()
>># 
>># Modifications:
>># $Log: tvapcrshl.m,v $
>># Revision 1.1  2005-02-12 14:38:12  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:36:25  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:59:14  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.1  1998/06/23 22:43:34  andy
>># Added sleep(XT_RESET_DELAY) to each test.  SR# 186.
>>#
>># Revision 6.0  1998/03/02 05:27:35  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:09  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:16:07  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:19:57  andy
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
>>TITLE XtVaAppCreateShell Xt4
Widget
XtVaAppCreateShell(name, application_class, widget_class, display, ...)
>>ASSERTION Good A
A successful call to 
Widget XtVaAppCreateShell(name, application_class, widget_class, display, ...) 
shall create a top-level shell widget that is 
the root of a widget tree with name as the shall widget instance name, associate 
it with the display specified by the argument display, and return the shell
widget instance.
>>CODE
Display *display_good;
String name_good, class_good;
XtAppContext app_ctext_good;
Widget topLevel_good;
Boolean status;
int argcount = 0;

	avs_xt_hier("Tvapcrshl1", "XtVaAppCreateShell");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Create application context app_ctext_good");
	app_ctext_good = XtCreateApplicationContext();
	tet_infoline("PREP: Open display and initialize toolkit for app_ctext_good");
	sleep(config.reset_delay);
	display_good = XtOpenDisplay(
		app_ctext_good,	/* application context */
		(String)config.display,	 /* display name */
		"Hello",	 /* application name use argv[0] */
		"World",	 /* application class */
		(XrmOptionDescRec *)NULL,
		(Cardinal) 0,	 /* command line options */
		&argcount,
		(String *)NULL	/* command line args */
	);
	if (display_good == 0) {
		tet_infoline("ERROR: Cannot open display");
		tet_result(TET_FAIL);
		exit(1);
	}
	tet_infoline("TEST: Create additional top level widget");
	topLevel_good = XtVaAppCreateShell("Hello", "World",
		 applicationShellWidgetClass, display_good,
		 (char *)NULL);
 
	tet_infoline("TEST: TopLevel_good widget class is applicationShell");
	status = XtIsApplicationShell(topLevel_good);
	check_dec(True, status, "XtIsApplicationShell return value");
	tet_infoline("PREP: Get the application name and class");
	XtGetApplicationNameAndClass(display_good, &name_good, &class_good );
	tet_infoline("TEST: Application name and class");
	check_str("Hello", name_good, "Application Name");
	check_str("World", class_good, "Application Class");
	tet_result(TET_PASS);
>>ASSERTION Good A
On a successful call to 
Widget XtVaAppCreateShell(name, application_class, widget_class, display, ...) 
when widget_class is ApplicationShell or a subclass thereof 
the shell widget instance created shall have WM_COMMAND property set from 
the values of the XtNargv and XtNargc resources.
>>CODE
Display *display_good;
String name_good, class_good;
XtAppContext app_ctext_good;
Widget widget_good;
Widget rowcolw_good;
XTextProperty *text_prop;
Window window_good;
int argcount = 1;
Atom actual_type;
int actual_format;
unsigned long	num_elements;
long bytes_after;
unsigned char *property_data;
int status;
String argvector[] = { "tvapcrshl2", NULL };
Arg args[2] = {
	{ "XtNwidth", 100 },
	{ "XtNheight", 100 }
};

	tet_infoline("PREP: Initialize the X toolkit");
	XtToolkitInitialize();
	tet_infoline("PREP: Get application context");
	app_ctext_good = XtCreateApplicationContext();;
	tet_infoline("PREP: Set up the XtToolkitError handler");
	XtAppSetErrorMsgHandler(app_ctext_good, xt_handler);
	tet_infoline("PREP: Open display and initialize toolkit for app_ctext_good");
	sleep(config.reset_delay);
	display_good = XtOpenDisplay(
		app_ctext_good,	/* application context */
		(String)config.display,	 /* display name */
		"tvapcrshl2",	 /* application name use argv[0] */
		"test",		/* application class */
		NULL, 0,		/* command line options */
		&argcount, argvector	/* command line args */
	 );
	if (display_good == 0) {
		tet_infoline("ERROR: Cannot open display");
		tet_result(TET_FAIL);
		exit(1);
	}
	tet_infoline("TEST: Create top level widget");
	widget_good = XtVaAppCreateShell("tvapcrshl2", "test",
	 applicationShellWidgetClass, display_good, XtNheight, 100, XtNwidth, 100, XtNargc, argcount, XtNargv, argvector, NULL);
	tet_infoline("PREP: Create rowcol widget");
	rowcolw_good = (Widget) CreateRowColWidget(widget_good);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(widget_good);
	XSync(display_good, False);
	tet_infoline("TEST: WM_CLASS property is set");
	window_good = XtWindow(widget_good);
 
	tet_infoline("TEST: Window property values");
	status = XGetWindowProperty(display_good,
		window_good,
		XA_WM_CLASS,
		(long)0,
		(long)128,
		False,
		AnyPropertyType,
		&actual_type,
		&actual_format,
		&num_elements,
		(unsigned long *)&bytes_after,
		&property_data);
	check_dec(Success, status, "Return value");
	if ( actual_format == (int)0 ) {
		sprintf(ebuf, "ERROR: Expected actual format not zero");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	if ( actual_type == (Atom)None) {
		sprintf(ebuf, "ERROR: Expected actual type None Received %d", actual_type);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	check_str("tvapcrshl2", (char *)property_data, "Class");
	tet_infoline("TEST: WM_COMMAND property is set");

	status = XGetWindowProperty(display_good,
		window_good,
		XA_WM_COMMAND,
		(long)0,
		(long)128,
		False,
		AnyPropertyType,
		&actual_type,
		&actual_format,
		&num_elements,
		(unsigned long *)&bytes_after,
		&property_data);
	check_dec(Success, status, "Return value");
	if ( actual_format == (int)0 ) {
		sprintf(ebuf, "ERROR: Expected actual format not zero");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	if (actual_type == (Atom)None) {
		sprintf(ebuf, "ERROR: Expected actual type not None Received %d", actual_type);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to 
Widget XtVaAppCreateShell(name, application_class, widget_class, display, ...) 
when name is NULL shall name the shell widget instance with the application 
name passed to XtDisplayInitialize.
>>CODE
Display *display_good;
String name_good, class_good;
XtAppContext app_ctext_good;
Widget topLevel_good;
Boolean status;
int argcount = 0;

	avs_xt_hier("Tvapcrshl3", "XtVaAppCreateShell");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Create application context app_ctext_good");
	app_ctext_good = XtCreateApplicationContext();
	tet_infoline("PREP: Open display and initialize toolkit for app_ctext_good");
	sleep(config.reset_delay);
	display_good = XtOpenDisplay(
		app_ctext_good,	/* application context */
		(String)config.display,	 /* display name */
		"Tvapcrshl3",	 /* application name use argv[0] */
		"World",	 /* application class */
		(XrmOptionDescRec *)NULL,
		(Cardinal) 0,	 /* command line options */
		&argcount,
		(String *)NULL	/* command line args */
	 );
	if (display_good == 0) {
		tet_infoline("ERROR: Cannot open display");
		tet_result(TET_FAIL);
		exit(1);
	}
	tet_infoline("TEST: Create additional top level widget");
	topLevel_good = XtVaAppCreateShell(NULL, "World",
		 applicationShellWidgetClass, display_good,
		 (char *)NULL);
	tet_infoline("TEST: TopLevel_good widget class is applicationShell");
	status = XtIsApplicationShell(topLevel_good);
	check_dec(True, status, "XtIsApplicationShell return value");
	tet_infoline("PREP: Get the application name and class");
	XtGetApplicationNameAndClass(display_good, &name_good, &class_good );
	tet_infoline("TEST: Application name");
	check_str("Tvapcrshl3", name_good, "Application Name");
	tet_result(TET_PASS);
>>ASSERTION Good B 0
A successful call to Widget XtVaAppCreateShell(name, application_class, 
widget_class, display, ...) when the resource arguments specify 
XtNscreen shall create the resource database for the shell widget using the
resource arguments specified in varargs style and the resource values from 
the resource database of the screen specified in the XtNscreen argument for 
those resources not specified in the resource arguments.
>>ASSERTION Good B 0
A successful call to Widget XtVaAppCreateShell(name, application_class, 
widget_class, display, ...) when the resource arguments do not specify 
XtNscreen, widget_class is applicationShellWidgetClass or a subclass thereof, 
and the resource database of the default screen for display specifies 
the resource name.screen, class application_class.screen shall create 
the resource database for the shell widget using the resource arguments and
the resource values from the resource database of the screen specified in 
the resource database of the default screen for those resources not 
specified in the resource arguments.
>>ASSERTION Good B 0
A successful call to Widget XtVaAppCreateShell(name, application_class, 
widget_class, display, ...) when the resource arguments do not specify 
XtNscreen, widget_class is not applicationShellWidgetClass or a subclass
thereof, and the resource database of the default screen for display 
specifies the resource name.screen, class Class.screen, where Class is the 
class_name field from CoreClassPart of widget_class, shall create the 
resource database for the shell widget using the resource arguments and 
the resource values from the resource database of the screen specified in 
the resource database of the default screen for those resources not specified 
in the resource arguments.
>>ASSERTION Good B 0
A successful call to Widget XtVaAppCreateShell(name, application_class, 
widget_class, display, ...) when the resource arguments do not specify 
XtNscreen and the resource database of the default screen for 
display does not specify the resource name.screen, class 
application_class.screen shall create the resource database for the 
shell widget using the resource arguments and the resource values from 
the resource database of the default screen for those resources not specified 
in the resource arguments.
