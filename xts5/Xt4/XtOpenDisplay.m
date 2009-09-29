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
>># File: xts/Xt4/XtOpenDisplay.m
>># 
>># Description:
>>#	Tests for XtOpenDisplay()
>># 
>># Modifications:
>># $Log: topndsply.m,v $
>># Revision 1.1  2005-02-12 14:38:03  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:36:19  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:59:08  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.1  1998/06/23 22:52:09  andy
>># Added sleep(XT_RESET_DELAY) to each test.  SR# 186.
>>#
>># Revision 6.0  1998/03/02 05:27:30  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.1  1998/02/04 23:16:27  andy
>># Editorial
>>#
>># Revision 5.0  1998/01/26 03:24:03  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.1  1998/01/13 03:19:37  andy
>># In test 20,  changed closure_ret from XtPointer * to XtPointer (SR 146).
>>#
>># Revision 4.0  1995/12/15 09:15:48  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:19:32  andy
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
>>TITLE XtOpenDisplay Xt4
Display *
XtOpenDisplay(app_context, display_string, application_name, application_class, options, num_options, argc, argv)
>>ASSERTION Good A
A successful call to 
Display *XtOpenDisplay(app_context, display_string, 
application_name, application_class, options, num_options, argc, argv) 
shall open the display specified by the argument display_string, create 
a resource database for the display, and return a pointer to the opened 
display.
>>CODE
Display	*display_good;
String	name_good, class_good;
int	argcount = 0;

	XtToolkitInitialize();
	app_ctext= XtCreateApplicationContext();
	tet_infoline("TEST: Open display");
	sleep(config.reset_delay);
	display_good = XtOpenDisplay(
		app_ctext,	/* application context */
		(String)config.display,	/* display name */
		"topndsply1",	/* application name use argv[0] */
		"Topndsply1",	/* application class */
		(XrmOptionDescRec *)NULL,
		(Cardinal)0,	 /* command line options */
		&argcount,
		(String *)NULL	/* command line args */
	 );
	if (display_good == 0) {
		tet_infoline("ERROR: Cannot open display");
		tet_result(TET_FAIL);
		exit(1);
	}
	tet_infoline("PREP: Get the application name and class");
	XtGetApplicationNameAndClass(display_good, &name_good, &class_good );
	tet_infoline("TEST: Application name and class.");
	check_str("topndsply1", name_good, "Name of Application:");
	check_str("Topndsply1", class_good,"Class of Application:");
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to 
Display *XtOpenDisplay(app_context, display_string, 
application_name, application_class, options, num_options, argc, argv) 
when display_string is NULL shall use the -display option specified in 
argv as the display to be opened and initialized.
>>CODE
char	name_good[40];
Display	*display_good;
char	*display_name;
int	argc_count;
char	**argv_string;
int	count = 3;
char	*argvals[4];

	XtToolkitInitialize();
	app_ctext= XtCreateApplicationContext();
	tet_infoline("PREP: Construct -display option");
	argvals[0] = "topndsply2";
	argvals[1] = "-display";
	argvals[2] = (char *)config.display;
	argvals[3] = (char *)NULL;
	argc_count = count;
	argv_string = &argvals[0];
	tet_infoline("TEST: Open display");
	sleep(config.reset_delay);
	display_good = XtOpenDisplay(
		app_ctext,	/* application context */
		(String)NULL,	/* display name */
		"topndsply2",	/* application name use argv[0] */
		"Topndsply2",	/* application class */
		(XrmOptionDescRec *)NULL,
		(Cardinal)0,	/* command line options */
		&argc_count,
		argv_string	/* command line args */
	 );
	if (display_good == 0) {
		tet_infoline("ERROR: Cannot open display");
		tet_result(TET_FAIL);
		exit(1);
	}
	tet_infoline("TEST: Display name is correct.");
	display_name = XDisplayString(display_good);
	check_str(config.display, display_name, "Display name");
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to 
Display *XtOpenDisplay(app_context, display_string, application_name, 
application_class, options, num_options, argc, argv) 
when display_string is NULL and the -display option is not specified 
in argv shall use the value set in the DISPLAY environment variable as 
the display to be opened and initialized.
>>CODE
Display	*display_good;
String	name_good, class_good;
char	return_name[40];
char	*display_name;
int	argcount = 0;

	XtToolkitInitialize();
	app_ctext= XtCreateApplicationContext();
	sprintf(ebuf, "DISPLAY=%s", config.display);
	putenv(ebuf);
	tet_infoline("TEST: Open display");
	sleep(config.reset_delay);
	display_good = XtOpenDisplay(
		app_ctext,	/* application context */
		(String)NULL,	/* display name */
		"topndsply3",	/* application name use argv[0] */
		"Topndsply3",	/* application class */
		(XrmOptionDescRec *)NULL,
		(Cardinal)0,	/* command line options */
		&argcount,
		(String *)NULL	/* command line args */
	 );
	if (display_good == 0) {
		tet_infoline("ERROR: Cannot open display");
		tet_result(TET_FAIL);
		exit(1);
	}
	tet_infoline("TEST: Check the env DISPLAY name is used.");
	display_name = XDisplayString(display_good);
	check_str(config.display, display_name, "Display name");
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to 
Display *XtOpenDisplay(app_context, display_string, 
application_name, application_class, options, num_options, argc, argv) 
when the -name option is specified in argv shall use this value as the 
application name to query the server and screen resource databases for
the name.xnlLanguage resource to create the resource database for the display.
>>CODE
Display	*display_good;
String	name_good, class_good;
int	argc_count;
char	**argv_string;
int	count = 3;
char	*argvals[4];

	XtToolkitInitialize();
	app_ctext= XtCreateApplicationContext();
	tet_infoline("PREP: Construct -name option");
	argvals[0] = "topndsply4";
	argvals[1] = "-name";
	argvals[2] = "topndsply4";
	argvals[3] = (char *)NULL;
	argc_count = count;
	argv_string = &argvals[0];
	tet_infoline("TEST: Open display");
	sleep(config.reset_delay);
	display_good = XtOpenDisplay(
		app_ctext,		/* application context */
		(String)config.display,	/* display name */
		(String)NULL,	 	/* application name use argv[0] */
		"Topndsply4",	 	/* application class */
		(XrmOptionDescRec *)NULL,
		(Cardinal)0,		/* command line options */
		&argc_count,
		argv_string		/* command line args */
	 );
	if (display_good == 0) {
		tet_infoline("ERROR: Cannot open display");
		tet_result(TET_FAIL);
		exit(1);
	}
	tet_infoline("PREP: Get the application name");
	XtGetApplicationNameAndClass(display_good, &name_good,
		&class_good );
	tet_infoline("TEST: Application name");
	check_str("topndsply4", name_good, "Name of Application:");
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to 
Display *XtOpenDisplay(app_context, display_string, 
application_name, application_class, options, num_options, argc, argv) 
when the -name option is not specified in argv and application_name is
non-NULL shall use this value as the application name to query the 
server and the screen resource databases for the name.xnlLanguage 
resource to create the resource database for the display.
>>CODE
Display	*display_good;
String	name_good, class_good;
int	argcount = 0;

	XtToolkitInitialize();
	app_ctext= XtCreateApplicationContext();
	tet_infoline("TEST: Open display");
	sleep(config.reset_delay);
	display_good = XtOpenDisplay(
		app_ctext,		/* application context */
		(String)config.display,	/* display name */
		"topndsply5",	 	/* application name use argv[0] */
		"Topndsply5",	 	/* application class */
		(XrmOptionDescRec *)NULL,
		(Cardinal)0,	 	/* command line options */
		&argcount,
		(String *)NULL		/* command line args */
	 );
	if (display_good == 0) {
		tet_infoline("ERROR: Cannot open display");
		tet_result(TET_FAIL);
		exit(1);
	}
	tet_infoline("PREP: Get the application name");
	XtGetApplicationNameAndClass(display_good, &name_good,
		&class_good );
	tet_infoline("TEST: Application name");
	check_str("topndsply5", name_good, "Name of Application");
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to 
Display *XtOpenDisplay(app_context, display_string, 
application_name, application_class, options, num_options, argc, argv) 
when the -name option is not specified in argv, application_name is
NULL, and the environment variable RESOURCE_NAME is set shall use this 
value as the application name to query the server and screen resource 
databases for the name.xnlLanguage resource to create the resource database
for the display.
>>CODE
Display	*display_good;
String	name_good, class_good;
int	argcount = 0;

	XtToolkitInitialize();
	app_ctext= XtCreateApplicationContext();
	tet_infoline("PREP: Set up env variable RESOURCE_NAME=topndsply5");
	putenv("RESOURCE_NAME=topndsply6");
	tet_infoline("TEST: Open display");
	sleep(config.reset_delay);
	display_good = XtOpenDisplay(
		app_ctext,		/* application context */
		(String)config.display,	/* display name */
		(String)NULL,		/* application name use argv[0] */
		"Topndsply6",	 	/* application class */
		(XrmOptionDescRec *)NULL,
		(Cardinal)0,		/* command line options */
		&argcount,
		(String *)NULL		/* command line args */
	 );
	if (display_good == 0) {
		tet_infoline("ERROR: Cannot open display");
		tet_result(TET_FAIL);
		exit(1);
	}
	tet_infoline("PREP: Get the application name");
	XtGetApplicationNameAndClass(display_good, &name_good, &class_good );
	tet_infoline("TEST: Application name");
	check_str("topndsply6", name_good, "Name of Application:");
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to Display *XtOpenDisplay(app_context, display_string, 
application_name, application_class, options, num_options, argc, argv) 
when the -name option is not specified in argv, application_name is NULL, 
the environment variable RESOURCE_NAME is not set, and argv[0] is not an
empty string shall use this value as the application name to query the 
server and screen resource databases for the name.xnlLanguage resource to 
create the resource database for the display.
>>CODE
Display	*display_good;
String	name_good, class_good;
int	argc_count;
char	**argv_string;
char	argv1[] = "topndsply7";
char	*argvals[2] = { "topndsply7", 0 };
int	count = 1;

	argc_count = count;
	argv_string = &argvals[0];
	XtToolkitInitialize();
	app_ctext= XtCreateApplicationContext();
	tet_infoline("TEST: Open display");
	sleep(config.reset_delay);
	display_good = XtOpenDisplay(
		app_ctext,		/* application context */
		(String)config.display,	/* display name */
		(String)NULL,		/* application name use argv[0] */
		"Topndsply7",	 	/* application class */
		(XrmOptionDescRec *)NULL,
		(Cardinal)0,		/* command line options */
		&argc_count,
		(String *)argv_string	/* command line args */
	 );
	if (display_good == 0) {
		tet_infoline("ERROR: Cannot open display");
		tet_result(TET_FAIL);
		exit(1);
	}
	tet_infoline("PREP: Get the application name");
	XtGetApplicationNameAndClass(display_good, &name_good, &class_good );
	tet_infoline("TEST: Application name");
	check_str("topndsply7", name_good, "Name of Application:");
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to Display *XtOpenDisplay(app_context, display_string, 
application_name, application_class, options, num_options, argc, argv) 
when the -name option is not specified in argv, application_name is NULL, 
the environment variable RESOURCE_NAME is not set, and argv[0] is an empty 
string shall use the string "main" as the application name to query the 
server and screen resource databases for the name.xnlLanguage resource to 
create the resource database for the display.
>>CODE
Display	*display_good;
String	name_good, class_good;
int	argcount = 0;

	XtToolkitInitialize();
	app_ctext= XtCreateApplicationContext();
	tet_infoline("TEST: Open display");
	sleep(config.reset_delay);
	display_good = XtOpenDisplay(
		app_ctext,		/* application context */
		(String)config.display,	/* display name */
		(String)NULL,	 	/* application name use argv[0] */
		"Topndsply1",	 	/* application class */
		(XrmOptionDescRec *)NULL,
		(Cardinal)0,		/* command line options */
		&argcount,
		(String *)NULL		/* command line args */
	 );
	if (display_good == 0) {
		tet_infoline("ERROR: Cannot open display");
		tet_result(TET_FAIL);
		exit(1);
	}
	tet_infoline("PREP: Get the application name");
	XtGetApplicationNameAndClass(display_good, &name_good,
		&class_good );
	tet_infoline("TEST: Application name is main");
	check_str("main", name_good, "Name of Application:");
	tet_result(TET_PASS);
>>ASSERTION Good A
A call to 
Display *XtOpenDisplay(app_context, display_string, application_name,
application_class, options, num_options, argc, argv) 
shall return NULL on failure.
>>CODE
Display	*display_good;
String	name_good, class_good;
int	argcount = 0;

	XtToolkitInitialize();
	app_ctext= XtCreateApplicationContext();
	tet_infoline("TEST: Open display");
	sleep(config.reset_delay);
	display_good = XtOpenDisplay(
		app_ctext,	/* application context */
		"gibberish",	/* display name */
		"topndsply1",	/* application name use argv[0] */
		"Topndsply1",	/* application class */
		(XrmOptionDescRec *)NULL,
		(Cardinal)0,	/* command line options */
		&argcount,
		(String *)NULL	/* command line args */
	 );
	tet_infoline("TEST: returns NULL with non-existant display");
	if (display_good != NULL) {
		tet_infoline("ERROR: expected NULL, got a display");
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
>>#
>># Start of XtDisplayInitialize assertions
>>#
>>ASSERTION Good A
When the synchronize resource is set to True in the resource database
created by a successful call to 
Display *XtOpenDisplay(app_context, display_string, application_name,
application_class, options, num_options, argc, argv) 
it shall 
put Xlib into synchronous mode for this display connection 
and any others currently open in the application context app_context.
>>CODE
Window window;
int scr;
static char *property_data = "Hello World";
XtAppContext app_ctext;
Display *display;
int queued_events, events;
int argc = 2;
    /*
    ** -synchronous on
    ** +synchronous off
    */
char *argv[] = { "tdsplyintl2", "-synchronous", (char *)NULL };

	tet_infoline("PREP: Initialize the Xt toolkit");
	XtToolkitInitialize();
	tet_infoline("PREP: Create an application context");
	app_ctext = XtCreateApplicationContext();
	tet_infoline("TEST: Open a display connection");
	sleep(config.reset_delay);
	display = XtOpenDisplay(app_ctext,
		config.display,
	    "tdsplyintl2",
	    "Tdsplyintl2",
	    (XrmOptionDescRec *)NULL,
	    (Cardinal)0,
	&argc, &argv[0] );
	if (display == 0) {
		tet_infoline("ERROR: Cannot open display");
		tet_result(TET_FAIL);
		exit(1);
	}
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
		XChangeProperty(display, window, XA_RESOURCE_MANAGER,
			XA_STRING, 8,0, (unsigned char *)property_data, 16);
	check_dec(3+queued_events, XQLength(display), "queue length");
	tet_result(TET_PASS);
>>ASSERTION Good D 0
If the implementation is X11R5 or later:
When a language procedure has been registered for the application context
.A app_context
a successful call to 
Display *XtOpenDisplay(app_context, display_string, application_name,
application_class, options, num_options, argc, argv) 
shall call the language procedure with a language string determined
by searching the following sources in the specified order:

- the -xnlLanguage resource or a -xrm option containing the
  xnlLanguage/XnlLanguage resource defined in the command line,

- the resource application_name.xnlLanguage, class
  application_class.XnlLanguage in the server's RESOURCE_MANAGER 
  property for the root window of screen zero if it exists, and in 
  the user preference resource file otherwise.
>>ASSERTION Good D 0
If the implementation is X11R5 or later:
When a language procedure has been registered for the application context
.A app_context
a successful call to 
Display *XtOpenDisplay(app_context, display_string, application_name,
application_class, options, num_options, argc, argv) 
shall call the procedure with the empty string if the server's
RESOURCE_MANAGER property for the root window of screen zero exists
and a language string is not found on the command line or in this 
property.
>>ASSERTION Good D 0
If the implementation is X11R5 or later:
When a language procedure has been registered for the application context
.A app_context
a successful call to 
Display *XtOpenDisplay(app_context, display_string, application_name,
application_class, options, num_options, argc, argv) 
shall call the procedure with the empty string if the server's
RESOURCE_MANAGER property for the root window of screen zero does not exist
and a language string is not found on the command line or in the user
preference resource file.
>>ASSERTION Good D 0
If the implementation is X11R5 or later:
When a language procedure has not been registered for the application context
.A app_context
a successful call to 
Display *XtOpenDisplay(app_context, display_string, application_name,
application_class, options, num_options, argc, argv) 
shall determine a language string for the display
by searching the following sources in the specified order:

- the resource database created from the command line.

- the resource application_name.xnlLanguage, class
  application_class.XnlLanguage in the server's RESOURCE_MANAGER 
  property for the root window of screen zero if it exists, or in 
  the user preference resource file otherwise.

- the environment.
>>ASSERTION Good D 0
If the implementation is X11R5 or later and is POSIX-based:
When a language procedure has not been registered for the application context
.A app_context
a successful call to 
Display *XtOpenDisplay(app_context, display_string, application_name,
application_class, options, num_options, argc, argv) 
shall use the LANG environment variable as the environment value to 
search when determining the language string for the display.
>>ASSERTION Good D 0
If the implementation is X11R5 or later:
When a language procedure has not been registered for the application context
.A app_context
a successful call to 
Display *XtOpenDisplay(app_context, display_string, application_name,
application_class, options, num_options, argc, argv) 
shall set the language string for the display to the empty string if the
server's RESOURCE_MANAGER property for the root window of screen zero exists,
and a language string is not found on the command line, in this 
property, or in the environment.
>>ASSERTION Good D 0
If the implementation is X11R5 or later:
When a language procedure has not been registered for the application context
.A app_context
a successful call to 
Display *XtOpenDisplay(app_context, display_string, application_name,
application_class, options, num_options, argc, argv) 
shall set the language string for the display to the empty string if the
server's RESOURCE_MANAGER property for the root window of screen zero does
not exist and a language string is not found on the command line, in the user
preference resource file, or in the environment.
>>ASSERTION Good D 0
A successful call to 
Display *XtOpenDisplay(app_context, display_string, application_name,
application_class, options, num_options, argc, argv) 
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
Display *XtOpenDisplay(app_context, display_string, application_name,
application_class, options, num_options, argc, argv) 
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

        FORK(pid2);
	XtToolkitInitialize();
	app_ctext= XtCreateApplicationContext();
	tet_infoline("TEST: Open display");
	sleep(config.reset_delay);
	display_good = XtOpenDisplay(
		app_ctext,	/* application context */
		(String)config.display,	/* display name */
		"topndsply1",	/* application name use argv[0] */
		"Topndsply1",	/* application class */
		(XrmOptionDescRec *)NULL,
		(Cardinal)0,	 /* command line options */
		&argcount,
		args11	 /* command line args */
	);
	if (display_good == 0) {
		tet_infoline("ERROR: Cannot open display");
		tet_result(TET_FAIL);
		exit(1);
	}
	tet_infoline("TEST: Create top level widget");
	topLevel = XtAppCreateShell("Hello", "World",
		 applicationShellWidgetClass, display_good,
		 (ArgList)NULL, (Cardinal)0);
        tet_infoline("TEST: Retrieve resource values from resource database");
        XtGetApplicationResources(topLevel,
                        &base,
                        resources,
                        1,
                        (ArgList)NULL,
                        (Cardinal)0);
        tet_infoline("TEST: Retrieved resource value");
        if ((base.foreground != 0) && (base.foreground != 1)) {
                sprintf(ebuf, "ERROR: expected foreground value of 0 or 1, received %d", base.foreground);
                tet_infoline(ebuf);
                tet_result(TET_FAIL);
        }
        LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to 
Display *XtOpenDisplay(app_context, display_string, application_name,
application_class, options, num_options, argc, argv) 
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

        FORK(pid2);
	tet_infoline("PREP: Initialize the Xt toolkit");
	XtToolkitInitialize();
	tet_infoline("PREP: Create an application context");
	app_ctext = XtCreateApplicationContext();
	tet_infoline("TEST: Open a display connection with +rv in args");
	sleep(config.reset_delay);
	display = XtOpenDisplay(app_ctext,
		config.display,
		"tdsplyintl2",
		"Tdsplyintl2",
		(XrmOptionDescRec *)NULL,
		(Cardinal)0,
		&argc, &argv[0] );
	if (display == 0) {
		tet_infoline("ERROR: Cannot open display");
		tet_result(TET_FAIL);
		exit(1);
	}
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
>>ASSERTION Good B 5
A successful call to 
Display *XtOpenDisplay(app_context, display_string, application_name,
application_class, options, num_options, argc, argv) 
when the application context app_context has more than one display and
the selectionTimeout resource is specified on the command line shall set
this value in the selectionTimeout resource in the resource databases
of all the displays in the application context.
>>ASSERTION Good D 0
If the implementation is POSIX-based:
A successful call to 
Display *XtOpenDisplay(app_context, display_string, application_name,
application_class, options, num_options, argc, argv) 
when the environment variable XENVIRONMENT exists shall use the value
of this variable as the name of the user environment resource file.
>>ASSERTION Good D 0
If the implementation is POSIX-based:
A successful call to 
Display *XtOpenDisplay(app_context, display_string, application_name,
application_class, options, num_options, argc, argv) 
when the environment variable XENVIRONMENT does not exist shall use
the file .Xdefaults-host, where host is the name of the system running
the application, in the user's home directory as the user environment
resource file.
>>ASSERTION Good B 0
A successful call to 
Display *XtOpenDisplay(app_context, display_string, application_name,
application_class, options, num_options, argc, argv) 
shall set the values from the higher precedence sources of the resource
database being created for the display as the current resource database
before determining the file name for the application-specific user resource file.
>>ASSERTION Good D 0
If the implementation is POSIX-based:
A successful call to 
Display *XtOpenDisplay(app_context, display_string, application_name,
application_class, options, num_options, argc, argv) 
when the environment variable XUSERFILESEARCHPATH is defined 
shall use the result of calling XtResolvePathname(display, path,
NULL, NULL, NULL, NULL, 0, NULL) with the value of this variable as path
as the name of the application-specific user resource file.
>>ASSERTION Good D 0
If the implementation is POSIX-based:
A successful call to 
Display *XtOpenDisplay(app_context, display_string, application_name,
application_class, options, num_options, argc, argv) 
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
Display *XtOpenDisplay(app_context, display_string, application_name,
application_class, options, num_options, argc, argv) 
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
Display *XtOpenDisplay(app_context, display_string, application_name,
application_class, options, num_options, argc, argv) 
shall use the result of calling XtResolvePathname(display, "app-defaults",
NULL, NULL, NULL, NULL, 0, NULL) as the name of the application-specific
class resource file, with the values from the higher precedence sources of
the resource database being created for the display set as the current
resource database before the call is made.
