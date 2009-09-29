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
>># File: xts/Xt4/XtAppInitialize.m
>># 
>># Description:
>>#	Tests for XtAppInitialize()
>># 
>># Modifications:
>># $Log: tapintlze.m,v $
>># Revision 1.1  2005-02-12 14:38:00  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:36:25  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:59:15  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.1  1998/06/23 22:35:02  andy
>># Added sleep(XT_RESET_DELAY) to each test.  SR# 186.
>>#
>># Revision 6.0  1998/03/02 05:27:36  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:09  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.1  1998/01/13 04:50:30  andy
>># In test 17 changed type of closure_ret from XtPointer * to XtPointer (SR 140).
>>#
>># Revision 4.0  1995/12/15 09:16:09  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:19:59  andy
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
char *msg="/tmp/outfile";
char *args11[] = {
	"-background", "green",
	"-bd", "green",
	"-bg", "green",
	"-borderwidth", "3",
	"-bordercolor", "red",
	"-bw", "3",
	"-fg", "green",
	"-font", XtDefaultFont,
	"-fn", XtDefaultFont,
	"-foreground", "blue",
	"-geometry", "100x100",
	"-iconic", 
	"-reverse",
	"-rv",
	"+rv",
	"-selectionTimeout", "50",
	"-synchronous",
	"+synchronous",
	"-title", "ApTest",
	"-xnlLanguage", "C",
	NULL};


typedef struct _instance_variables {
        long foreground;
        String label;
} instance_variable_rec;

static XtResource resources[] = {
        {
        XtNforeground,
        XtCForeground,
        XtRPixel, sizeof(Pixel),
        XtOffsetOf(instance_variable_rec, foreground),
        XtRString, "XtDefaultForeground"
        },
        {
        XtNlabel,
        XtCLabel,
        XtRString, sizeof(String),
        XtOffsetOf(instance_variable_rec, label),
        XtRString, "very bad idea"
        },
};
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtAppInitialize Xt4
Widget
XtAppInitialize(app_context_return, application_class, options, num_options, argc_in_out, argv_in_out, fallback_resources, args, num_args)
>>ASSERTION Good A
A call to 
Widget XtAppInitialize(app_context_return, application_class, 
options, num_options, argc_in_out, argv_in_out, fallback_resources, args,
num_args)
shall initialize the Intrinsics internals, create an application context for
the calling application, return the context in app_context_return, open 
a display, create a top-level shell widget that is the root of a widget 
tree, and return the shell widget instance.
>>CODE
XtAppContext app_ctext_return;
Widget widget_good;
Display *display_good;
String name_good, class_good;
char name[20], class[20];
Boolean status;
int argcount = 0;
pid_t	pid2;

	FORK(pid2);
	tet_infoline("TEST: Initialize toolkit");
	sleep(config.reset_delay);
	sprintf(ebuf, "DISPLAY=%s", config.display);
	putenv(ebuf);
	widget_good = XtAppInitialize(&app_ctext_return,
		"TAppInitialize",
		(XrmOptionDescList)NULL,
		(Cardinal)0,
		&argcount,
		(String *)NULL,
		(String *)NULL,
		(ArgList)NULL,
		(Cardinal)0
	);
	avs_set_event(1,1);
	tet_infoline("TEST: Class is applicationShell");
	status = XtIsApplicationShell(widget_good);
	check_dec(True, status, "Return value");
	tet_infoline("TEST: Application name and class.");
	display_good = XtDisplay(widget_good);
	XtGetApplicationNameAndClass(display_good, &name_good, &class_good );
	check_str("main", name_good, "Name");
	check_str("TAppInitialize", class_good, "Class");
	KROF(pid2);
	if (avs_get_event(1) != 1) {
		tet_infoline("ERROR: Process terminated by XtAppInitialize ");
		tet_result(TET_FAIL);
		exit(1);
	}
	tet_result(TET_PASS);
>>ASSERTION Good A
When the display cannot be opened, a call to 
Widget XtAppInitialize(app_context_return, application_class, options,
num_options, argc_in_out, argv_in_out, fallback_resources, args, num_args) 
shall issue an error message and terminate the calling process.
>>CODE
XtAppContext app_ctext_return;
Widget widget_good;
Display *display_good;
String name_good, class_good;
char name[20], class[20];
Boolean status;
int argcount = 0;
pid_t	pid2;
FILE *stream;
char line[80], *retval;

	tet_infoline("TEST: Initialize toolkit");
	FORK(pid2);
	sleep(config.reset_delay);
	sprintf(ebuf, "PREP: Direct error message to %s", msg);
	tet_infoline(ebuf);
	push_stderr("outfile", "w");
	sprintf(ebuf, "DISPLAY=%s", "notarealdisplay");
	putenv(ebuf);
	widget_good = XtAppInitialize(&app_ctext_return,
		"TAppInitialize",
		(XrmOptionDescList)NULL,
		(Cardinal)0,
		&argcount,
		(String *)NULL,
		(String *)NULL,
		(ArgList)NULL,
		(Cardinal)0
	);
	avs_set_event(1,1);
	pop_stderr();
	KROF(pid2);
	tet_infoline("TEST: Open the file and read the message");
	stream = (FILE *)fopen(msg, "r");
	retval = fgets(line, 80, stream) ;
	if (retval == NULL) {
		tet_infoline("ERROR: No error message issued");
		tet_result(TET_FAIL);
		unlink(msg);
		exit(0);
	}
	unlink(msg);
	if (avs_get_event(1) ==  1) {
		tet_infoline("ERROR: Process not terminated by XtAppInitialize ");
		tet_result(TET_FAIL);
		exit(1);
	}

	tet_result(TET_PASS);
>>#
>># Start of XtCreateApplicationContext
>>#
>># -----
>>#
>># Start of XtOpenDisplay
>>#
>>ASSERTION Good B 0
A successful call to 
Widget XtAppInitialize(app_context_return, application_class, options,
num_options, argc_in_out, argv_in_out, fallback_resources, args, num_args) 
shall create a resource database for the display opened.
>>ASSERTION Good A
A successful call to 
Widget XtAppInitialize(app_context_return, application_class, options,
num_options, argc_in_out, argv_in_out, fallback_resources, args, num_args) 
when the -display option is specified in argv_in_out shall use this value as 
the display to be opened and initialized.
>>CODE
XtAppContext app_ctext_return;
Widget widget_good;
Display *display_good;
Boolean status;
pid_t	pid2;
int     argc_count;
char    **argv_string;
int     count = 3;
char    *argvals[4];
char    *display_name;


	FORK(pid2);
	sleep(config.reset_delay);
	tet_infoline("TEST: Initialize toolkit");
	tet_infoline("PREP: Set arguments to include -display");
	argvals[0] = "tinitlize";
	argvals[1] = "-display";
	argvals[2] = (char *)config.display;
	argvals[3] = (char *)NULL;
	argc_count = count;
	argv_string = &argvals[0];
	widget_good = XtAppInitialize(&app_ctext_return,
		"TAppInitialize",
		(XrmOptionDescList)NULL,
		(Cardinal)0,
		&argc_count,
		argv_string,
		(String *)NULL,
		(ArgList)NULL,
		(Cardinal)0
	);
	avs_set_event(1,1);
	display_good = XtDisplay(widget_good);
	tet_infoline("TEST: Display name is correct");
	display_name = XDisplayString(display_good);
	check_str(config.display, display_name, "Display name");
	KROF(pid2);
	if (avs_get_event(1) != 1) {
		tet_infoline("ERROR: Process terminated by XtAppInitialize ");
		tet_result(TET_FAIL);
		exit(1);
	}
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to 
Widget XtAppInitialize(app_context_return, application_class, options,
num_options, argc_in_out, argv_in_out, fallback_resources, args, num_args) 
when the -display option is not specified in argv_in_out and the DISPLAY environment 
variable is set shall use this value as the display to be opened and 
initialized.
>>CODE
XtAppContext app_ctext_return;
Widget widget_good;
Display *display_good;
Boolean status;
int argcount = 0;
char    *display_name;
pid_t	pid2;

	FORK(pid2);
	sleep(config.reset_delay);
	tet_infoline("PREP: Set DISPLAY");
	sprintf(ebuf, "DISPLAY=%s", config.display);
	putenv(ebuf);
	tet_infoline("TEST: Initialize toolkit");
	widget_good = XtAppInitialize(&app_ctext_return,
		"TAppInitialize",
		(XrmOptionDescList)NULL,
		(Cardinal)0,
		&argcount,
		(String *)NULL,
		(String *)NULL,
		(ArgList)NULL,
		(Cardinal)0
	);
	avs_set_event(1,1);
	display_good = XtDisplay(widget_good);
	tet_infoline("TEST: Display name is correct");
	display_name = XDisplayString(display_good);
	check_str(config.display, display_name, "Display name");
	KROF(pid2);
	if (avs_get_event(1) != 1) {
		tet_infoline("ERROR: Process terminated by XtAppInitialize ");
		tet_result(TET_FAIL);
		exit(1);
	}
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to 
Widget XtAppInitialize(app_context_return, application_class, options,
num_options, argc_in_out, argv_in_out, fallback_resources, args, num_args) 
when the -name option is specified in argv_in_out shall use this value as the 
application name to query the server and screen resource databases for
the name.xnlLanguage resource to create the resource database for the display.
>>CODE
XtAppContext app_ctext_return;
Widget widget_good;
Display *display_good;
String name_good, class_good;
char name[20], class[20];
int argcount = 0;
Boolean status;
pid_t pid2;
int	pstatus;
int     argc_count;
char    **argv_string;
int     count = 3;
char    *argvals[4];

	FORK(pid2);
	sleep(config.reset_delay);
	sprintf(ebuf, "DISPLAY=%s", config.display);
	putenv(ebuf);
	tet_infoline("TEST: Initialize toolkit and open display");
	argvals[0] = "tinitlize";
        argvals[1] = "-name";
        argvals[2] = "testname";
        argvals[3] = (char *)NULL;
        argc_count = count;
        argv_string = &argvals[0];
	widget_good = XtAppInitialize(&app_ctext_return,
		"TAppInitialize",
		(XrmOptionDescList)NULL,
		(Cardinal)0,
		&argc_count,
		argv_string,
		(String *)NULL,
		(ArgList)NULL,
		(Cardinal)0
	);
	tet_infoline("TEST: widget_good class is applicationShell");
	status = XtIsApplicationShell(widget_good);
	check_dec(True, status, "XtIsApplicationShell return value");
	tet_infoline("TEST: Application name and class");
	display_good = XtDisplay(widget_good);
	XtGetApplicationNameAndClass(display_good, &name_good, &class_good );
	check_str("testname", name_good, "Application Name");
	KROF3(pid2, pstatus, AVSXTTIMEOUT-2);
	if (pstatus != 0) {
		tet_infoline("ERROR: Test process exited abnormally");
		tet_infoline("       May mean display cannot be opened");
		tet_result(TET_UNRESOLVED);
	} else
                tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to 
Widget XtAppInitialize(app_context_return, application_class, options,
num_options, argc_in_out, argv_in_out, fallback_resources, args, num_args) 
when the -name option is not specified in argv_in_out and the environment variable 
RESOURCE_NAME is set shall use this value as the application name to query 
the server and screen resource databases for the name.xnlLanguage resource 
to create the resource database for the display.
>>CODE
XtAppContext app_ctext_return;
Widget widget_good;
Display *display_good;
String name_good, class_good;
char name[20], class[20];
int argcount = 0;
Boolean status;
pid_t pid2;
int pstatus;

	FORK(pid2);
	sleep(config.reset_delay);
        tet_infoline("PREP: Set up env variable RESOURCE_NAME");
        putenv("RESOURCE_NAME=testname2");
	sprintf(ebuf, "DISPLAY=%s", config.display);
	putenv(ebuf);
	tet_infoline("TEST: Initialize toolkit and open display");
	widget_good = XtAppInitialize(&app_ctext_return,
		"TAppInitialize",
		(XrmOptionDescList)NULL,
		(Cardinal)0,
		&argcount,
		(String *)NULL,
		(String *)NULL,
		(ArgList)NULL,
		(Cardinal)0
	);
	tet_infoline("TEST: widget_good class is applicationShell");
	status = XtIsApplicationShell(widget_good);
	check_dec(True, status, "XtIsApplicationShell return value");
	tet_infoline("TEST: Application name and class");
	display_good = XtDisplay(widget_good);
	XtGetApplicationNameAndClass(display_good, &name_good, &class_good );
	check_str("testname2", name_good, "Application Name");
	KROF3(pid2, pstatus, AVSXTTIMEOUT-2);
	if (pstatus != 0) {
		tet_infoline("ERROR: Test process exited abnormally");
		tet_infoline("       May mean display cannot be opened");
		tet_result(TET_UNRESOLVED);
	} else
                tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to 
Widget XtAppInitialize(app_context_return, application_class, options,
num_options, argc_in_out, argv_in_out, fallback_resources, args, num_args) 
when the -name option is not specified in argv_in_out, the environment variable 
RESOURCE_NAME is not set, and argv_in_out[0] is not an empty string shall use 
this value as the application name to query the server and screen resource 
databases for the name.xnlLanguage resource to create the resource database 
for the display.
>>CODE
XtAppContext app_ctext_return;
Widget widget_good;
Display *display_good;
String name_good, class_good;
char name[20], class[20];
int argcount = 0;
Boolean status;
pid_t pid2;
int	pstatus;
int     argc_count;
char    **argv_string;
int     count = 1;
char    *argvals[4];

	FORK(pid2);
	sleep(config.reset_delay);
	sprintf(ebuf, "DISPLAY=%s", config.display);
	putenv(ebuf);
	tet_infoline("TEST: Initialize toolkit and open display");
	argvals[0] = "testname3";
        argvals[1] = (char *)NULL;
        argc_count = count;
        argv_string = &argvals[0];
	widget_good = XtAppInitialize(&app_ctext_return,
		"TAppInitialize",
		(XrmOptionDescList)NULL,
		(Cardinal)0,
		&argc_count,
		argv_string,
		(String *)NULL,
		(ArgList)NULL,
		(Cardinal)0
	);
	tet_infoline("TEST: widget_good class is applicationShell");
	status = XtIsApplicationShell(widget_good);
	check_dec(True, status, "XtIsApplicationShell return value");
	tet_infoline("TEST: Application name and class");
	display_good = XtDisplay(widget_good);
	XtGetApplicationNameAndClass(display_good, &name_good, &class_good );
	check_str("testname3", name_good, "Application Name");
	KROF3(pid2, pstatus, AVSXTTIMEOUT-2);
	if (pstatus != 0) {
		tet_infoline("ERROR: Test process exited abnormally");
		tet_infoline("       May mean display cannot be opened");
		tet_result(TET_UNRESOLVED);
	} else
                tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to 
Widget XtAppInitialize(app_context_return, application_class, options,
num_options, argc_in_out, argv_in_out, fallback_resources, args, num_args) 
when the -name option is not specified in argv_in_out, the environment variable 
RESOURCE_NAME is not set, and argv_in_out[0] is an empty string shall use the 
string "main" as the application name to query the server and screen resource 
databases for the name.xnlLanguage resource to create the resource database 
for the display.
>>CODE
XtAppContext app_ctext_return;
Widget widget_good;
Display *display_good;
String name_good, class_good;
char name[20], class[20];
Boolean status;
int argcount = 0;
pid_t	pid2;

	FORK(pid2);
	sleep(config.reset_delay);
	tet_infoline("TEST: Initialize toolkit");
	sprintf(ebuf, "DISPLAY=%s", config.display);
	putenv(ebuf);
	widget_good = XtAppInitialize(&app_ctext_return,
		"TAppInitialize",
		(XrmOptionDescList)NULL,
		(Cardinal)0,
		&argcount,
		(String *)NULL,
		(String *)NULL,
		(ArgList)NULL,
		(Cardinal)0
	);
	avs_set_event(1,1);
	tet_infoline("TEST: Class is applicationShell");
	status = XtIsApplicationShell(widget_good);
	check_dec(True, status, "Return value");
	tet_infoline("TEST: Application name and class.");
	display_good = XtDisplay(widget_good);
	XtGetApplicationNameAndClass(display_good, &name_good, &class_good );
	check_str("main", name_good, "Name");
	check_str("TAppInitialize", class_good, "Class");
	KROF(pid2);
	if (avs_get_event(1) != 1) {
		tet_infoline("ERROR: Process terminated by XtAppInitialize ");
		tet_result(TET_FAIL);
		exit(1);
	}
	tet_result(TET_PASS);
>># >>#
>># >># Start of XtDisplayInitialize assertions
>># >>#
>>ASSERTION Good A
When the synchronize resource is set to True in the resource database
created by a successful call to 
Widget XtAppInitialize(app_context_return, application_class, options,
num_options, argc_in_out, argv_in_out, fallback_resources, args, num_args) 
it shall put Xlib into synchronous mode for this display connection.
>>CODE
Window window;
int scr;
static char *property_data = "Hello World";
XtAppContext app_ctext_return;
Display *display;
int queued_events, events;
int argc = 2;
pid_t pid2;
int     pstatus;
    /*
    ** -synchronous on
    ** +synchronous off
    */
char *argv[] = { "tinitlize", "-synchronous", (char *)NULL };
Widget widget_good;

	FORK(pid2);
	sleep(config.reset_delay);
	sprintf(ebuf, "DISPLAY=%s", config.display);
	putenv(ebuf);
	tet_infoline("TEST: Initialize toolkit and open display");
	widget_good = XtAppInitialize(&app_ctext_return,
		"TAppInitialize",
		(XrmOptionDescList)NULL,
		(Cardinal)0,
		&argc,
		argv,
		(String *)NULL,
		(ArgList)NULL,
		(Cardinal)0
	);
	avs_set_event(1,1);
	display = XtDisplay(widget_good);
	tet_infoline("PREP: Create a window for events");
	scr = DefaultScreen(display);
	window = XCreateWindow(display, RootWindow(display, scr),
	       0, 0, 5, 5, 0, /* x,y,wid,ht,brd width */
	       DefaultDepth(display, scr),
	       InputOutput,
	       DefaultVisual(display, scr),
	       (XtValueMask) 0,
	       (XSetWindowAttributes *) 0);
	tet_infoline("TEST: Check Xlib is in synchronous mode");
	queued_events = XQLength(display);
	XSelectInput(display, window,
	     (unsigned long)PropertyChangeMask);
	for (events = 0; events < 3; events++)
		XChangeProperty(display, window, XA_RESOURCE_MANAGER, XA_STRING, 8,0, (unsigned char *)property_data, 16);
	check_dec(3+queued_events, XQLength(display), "queue length");
	KROF3(pid2, pstatus, AVSXTTIMEOUT-2);
	if (avs_get_event(1) != 1) {
		tet_infoline("ERROR: Process terminated by XtAppInitialize ");
		tet_result(TET_FAIL);
		exit(1);
	}
	tet_result(TET_PASS);
>>ASSERTION Good B 0
If the implementation is X11R5 or later:
A successful call to 
Widget XtAppInitialize(app_context_return, application_class, options,
num_options, argc_in_out, argv_in_out, fallback_resources, args, num_args) 
shall determine a language string for the display
by searching the following sources in the specified order:

- the resource database created from the command line.

- the resource application_name.xnlLanguage, class
  application_class.XnlLanguage in the server's RESOURCE_MANAGER 
  property for the root window of screen zero if it exists, or in 
  the user preference resource file otherwise.

- the environment.
>>ASSERTION Good B 0
If the implementation is X11R5 or later and is POSIX-based:
A successful call to 
Widget XtAppInitialize(app_context_return, application_class, options,
num_options, argc_in_out, argv_in_out, fallback_resources, args, num_args) 
shall use the LANG environment variable as the environment value to 
search when determining the language string for the display.
>>ASSERTION Good D 0
If the implementation is X11R5 or later:
A successful call to 
Widget XtAppInitialize(app_context_return, application_class, options,
num_options, argc_in_out, argv_in_out, fallback_resources, args, num_args) 
shall set the language string for the display to the empty string if the
server's RESOURCE_MANAGER property for the root window of screen zero 
exists, and a language string is not found on the command line, in this 
property, or in the environment.
>>ASSERTION Good D 0
If the implementation is X11R5 or later:
A successful call to 
Widget XtAppInitialize(app_context_return, application_class, options,
num_options, argc_in_out, argv_in_out, fallback_resources, args, num_args) 
shall set the language string for the display to the empty string if the
server's RESOURCE_MANAGER property for the root window of screen 
zero does not exist and a language string is not found on the 
command line, in the user preference resource file, or in the 
environment.
>>ASSERTION Good D 0
A successful call to 
Widget XtAppInitialize(app_context_return, application_class, options,
num_options, argc_in_out, argv_in_out, fallback_resources, args, num_args) 
shall associate with the default screen of the display a resource 
database created by combining entries from the following sources, 
in order, with the first named source having the highest precedence:

- the application command line

- the user's environment resource file

- per-screen resource specifications from the server, as returned by
  XScreenResourceString()

- per display resource specifications from the server (the 
  server's RESOURCE_MANAGER property for the root window of 
  screen zero) if they exist, otherwise the user preference file

- the application-specific user resource file.

- the application-specific class resource file .
>>ASSERTION Good A
A successful call to 
Widget XtAppInitialize(app_context_return, application_class, options,
num_options, argc_in_out, argv_in_out, fallback_resources, args, num_args) 
shall recognize options specified on the command line that are in the
standard table of options in section 4.4 of the specification or in
the table specific to the application specified by
.A options
and
.A num_options.
>>CODE
Display	*display_good;
String	name_good, class_good;
int	argcount = 20;
instance_variable_rec base;
pid_t pid2;
Widget widget_good;
XtAppContext app_ctext_return;

        FORK(pid2);
	sleep(config.reset_delay);
	tet_infoline("PREP: Set DISPLAY");
	sprintf(ebuf, "DISPLAY=%s", config.display);
	putenv(ebuf);
	tet_infoline("TEST: Initialize toolkit");
	widget_good = XtAppInitialize(&app_ctext_return,
		"TAppInitialize",
		(XrmOptionDescList)NULL,
		(Cardinal)0,
		&argcount,
		args11,
		(String *)NULL,
		(ArgList)NULL,
		(Cardinal)0
	);
        tet_infoline("TEST: Retrieve resource values from resource database");
        XtGetApplicationResources(widget_good,
                        &base,
                        resources,
                        1,
                        (ArgList)NULL,
                        (Cardinal)0);
        LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to 
Widget XtAppInitialize(app_context_return, application_class, options,
num_options, argc_in_out, argv_in_out, fallback_resources, args, num_args) 
when the reverseVideo resource is define as True on the command line shall use
the value of XtDefaultForeground instead of XtDefaultBackground and
vice versa in the resource database created for the display.
>>CODE
Window window;
int scr;
static char *property_data = "Hello World";
XtAppContext app_ctext;
Display *display;
int queued_events, events;
XrmValue args[2];
Cardinal num_args;
XrmValue fromVal;
XrmValue toVal;
Boolean closure;
XtPointer closure_ret = (XtPointer *) &closure;
int argc = 2;
char *argv[] = { "tdsplyintl2", "+rv", (char *)NULL };
Screen *screen;
Colormap colormap;
pid_t pid2;
Pixel res;
Boolean status;
XtAppContext app_ctext_return;
Widget widget_good;

        FORK(pid2);
	sleep(config.reset_delay);
	sprintf(ebuf, "DISPLAY=%s", config.display);
	putenv(ebuf);
	tet_infoline("TEST: Initialize and application with +rv in args");
	widget_good = XtAppInitialize(&app_ctext_return,
		"TAppInitialize",
		(XrmOptionDescList)NULL,
		(Cardinal)0,
		&argc,
		argv,
		(String *)NULL,
		(ArgList)NULL,
		(Cardinal)0
	);
	display = XtDisplay(widget_good);
	tet_infoline("PREP: Set up required conversion args");
        screen = DefaultScreenOfDisplay(display);
        args[0].addr = (XtPointer )&screen;
        args[0].size = sizeof(Screen*);
        colormap = DefaultColormapOfScreen(screen);
        args[1].addr = (XtPointer) &colormap;
        args[1].size = sizeof(Colormap);
        num_args = 2;
        tet_infoline("TEST: Convert XtDefaultForeground");
        fromVal.addr = XtDefaultForeground;
        fromVal.size = strlen(XtDefaultForeground)+1;
        toVal.addr = (XtPointer) &res;
        toVal.size = sizeof(Pixel);
        status = XtCvtStringToPixel(display,
                        &args[0],
                        &num_args,
                        &fromVal,
                        &toVal,
                        &closure_ret);
        check_dec(True, status, "XtCvtStringToPixel return value");
        tet_infoline("TEST: Conversion result");
        check_dec(XBlackPixelOfScreen(DefaultScreenOfDisplay(display)), res, "returned pixel");
        tet_infoline("TEST: Convert XtDefaultBackground");
        fromVal.addr = XtDefaultBackground;
        fromVal.size = strlen(XtDefaultBackground)+1;
        toVal.addr = (XtPointer) &res;
        toVal.size = sizeof(Pixel);
        status = XtCvtStringToPixel(display,
                        &args[0],
                        &num_args,
                        &fromVal,
                        &toVal,
                        &closure_ret);
        check_dec(True, status, "XtCvtStringToPixel return value");
        tet_infoline("TEST: Conversion result");
        check_dec(XWhitePixelOfScreen(DefaultScreenOfDisplay(display)), res, "returned pixel");
        LKROF(pid2, AVSXTTIMEOUT-2);
        tet_result(TET_PASS);
>>ASSERTION Good D 0
If the implementation is POSIX-based:
A successful call to 
Widget XtAppInitialize(app_context_return, application_class, options,
num_options, argc_in_out, argv_in_out, fallback_resources, args, num_args) 
when the environment variable XENVIRONMENT exists shall use the value
of this variable as the name of the user environment resource file.
>>ASSERTION Good D 0
If the implementation is POSIX-based:
A successful call to 
Widget XtAppInitialize(app_context_return, application_class, options,
num_options, argc_in_out, argv_in_out, fallback_resources, args, num_args) 
when the environment variable XENVIRONMENT does not exist shall use
the file .Xdefaults-host, where host is the name of the system running
the application, in the user's home directory as the user environment
resource file.
>>ASSERTION Good B 0
A successful call to 
Widget XtAppInitialize(app_context_return, application_class, options,
num_options, argc_in_out, argv_in_out, fallback_resources, args, num_args) 
shall set the values from the higher precedence sources of the resource
database being created for the display as the current resource database
before determining the file name for the application-specific user resource file.
>>ASSERTION Good D 0
If the implementation is POSIX-based:
A successful call to 
Widget XtAppInitialize(app_context_return, application_class, options,
num_options, argc_in_out, argv_in_out, fallback_resources, args, num_args) 
when the environment variable XUSERFILESEARCHPATH is defined 
shall use the result of calling XtResolvePathname(display, path,
NULL, NULL, NULL, NULL, 0, NULL) with the value of this variable as path
as the name of the application-specific user resource file.
>>ASSERTION Good D 0
If the implementation is POSIX-based:
A successful call to 
Widget XtAppInitialize(app_context_return, application_class, options,
num_options, argc_in_out, argv_in_out, fallback_resources, args, num_args) 
when the environment variable XUSERFILESEARCHPATH is not defined and
the environment variable XAPPLRESDIR is not defined shall 
use the result of calling XtResolvePathname(display, path,
NULL, NULL, NULL, NULL, 0, NULL) as the name of the application-specific
user resource file where path contains at least entries containing $HOME as
the directory prefix plus the following substitutions, in the order specified:

- %C, %N, %L or %C, %N, %l, %t, %c

- %C, %N, %l

- %C, %N

- %N, %L or %N, %l, %t, %c

- %N, %l

- %N
>>ASSERTION Good D 0
If the implementation is POSIX-based:
A successful call to 
Widget XtAppInitialize(app_context_return, application_class, options,
num_options, argc_in_out, argv_in_out, fallback_resources, args, num_args) 
when the environment variable XUSERFILESEARCHPATH is not defined and
the environment variable XAPPLRESDIR is defined shall use the result
of calling XtResolvePathname(display, path, NULL, NULL, NULL, NULL, 0, NULL)
as the name of the application-specific user resource file where path
contains at least entries containing the following directory prefixes and
substitutions, in the order specified:

- $XPPLRESDIR with %C, %N, %L or %C, %N, %l, %t, %c

- $XPPLRESDIR with %C, %N, %l

- $XPPLRESDIR with %C, %N

- $XPPLRESDIR with %N, %L or %N, %l, %t, %c

- $XPPLRESDIR with %N, %l

- $XPPLRESDIR with %N

- $HOME with %N
>>ASSERTION Good B 0
A successful call to 
Widget XtAppInitialize(app_context_return, application_class, options,
num_options, argc_in_out, argv_in_out, fallback_resources, args, num_args) 
shall use the result of calling XtResolvePathname(display, "app-defaults",
NULL, NULL, NULL, NULL, 0, NULL) as the name of the application-specific
class resource file, with the values from the higher precedence sources of
the resource database being created for the display set as the current
resource database before the call is made.
>>#
>># Start of XtAppCreateShell
>>#
>>ASSERTION Good B 0
On a successful call to 
Widget XtAppInitialize(app_context_return, application_class, options,
num_options, argc_in_out, argv_in_out, fallback_resources, args, num_args) 
the shell widget instance created shall have WM_COMMAND property set from 
the values of the XtNargv and XtNargc resources.
>>ASSERTION Good B 0
A successful call to 
Widget XtAppInitialize(app_context_return, application_class, options,
num_options, argc_in_out, argv_in_out, fallback_resources, args, num_args) 
shall name the shell widget instance with the application name passed to 
XtDisplayInitialize.
>>ASSERTION Good B 0
A successful call to 
Widget XtAppInitialize(app_context_return, application_class, options,
num_options, argc_in_out, argv_in_out, fallback_resources, args, num_args) 
when args specifies the XtNscreen argument shall create the resource database 
for the shell widget using the resource values specified in args and 
resource values from the resource database of the screen specified by the 
XtNscreen argument for those resources not specified in args.
>>ASSERTION Good B 0
A successful call to 
Widget XtAppInitialize(app_context_return, application_class, options,
num_options, argc_in_out, argv_in_out, fallback_resources, args, num_args) 
when args does not specify the XtNscreen argument and the resource database 
of the default screen for display 
specifies the resource name.screen, class application_class.screen shall 
create the resource database for the shell widget using the resource values 
specified in args and resource values from the resource database of the screen 
specified in the resource database of the default screen for those resources 
not specified in args.
>>ASSERTION Good B 0
A successful call to 
Widget XtAppInitialize(app_context_return, application_class, options,
num_options, argc_in_out, argv_in_out, fallback_resources, args, num_args) 
when args does not specify the XtNscreen argument and the resource database 
of the default screen for display does not specify the resource name.screen, 
class application_class.screen shall create the resource database for the 
shell widget using the resource values specified in args and resource values 
from the resource database of the default screen for those resources not
specified in args.
