Copyright (c) 2005 X.Org Foundation L.L.C.

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
$Header: /cvs/xtest/xtest/xts5/tset/Xt4/XtSetLanguageProc/XtSetLanguageProc.m,v 1.2 2005-04-21 09:40:42 ajosey Exp $

Copyright (c) 2004 The Open Group
Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt4/XtSetLanguageProc/XtSetLanguageProc.m
>># 
>># Description:
>>#	Tests for XtSetLanguageProc()
>># 
>># Modifications:
>># $Log: tstlnggprc.m,v $
>># Revision 1.2  2005-04-21 09:40:42  ajosey
>># resync to VSW5.1.5
>>#
>># Revision 8.2  2005/01/14 12:15:44  gwc
>># Updated copyright notice
>>#
>># Revision 8.1  2004/02/12 15:54:44  gwc
>># Set LC_ALL in environment instead of LANG in test 7
>>#
>># Revision 8.0  1998/12/23 23:36:18  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:59:08  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.1  1998/06/23 22:49:32  andy
>># Added sleep(XT_RESET_DELAY) to each test.  SR# 186.
>>#
>># Revision 6.0  1998/03/02 05:27:29  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:03  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:15:46  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:19:29  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <locale.h>
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext, app_ctext2;
Display *display_good;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;

char client_stuff[] = "These are the times that try men's souls";

/*
** Procedure XtLP_Proc
*/
String XtLP_Proc(display, language, client_data)
Display *display;
String language;
XtPointer client_data;
{
	avs_set_event(1,avs_get_event(1)+1);
	tet_infoline("TEST: Client data correctly passed to language procedure");
	if (strcmp(client_data, client_stuff) != 0) {
		sprintf(ebuf, "ERROR: Expected client_data \"%s\", received \"%s\"", client_stuff, (char *)client_data);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	return (String)setlocale(LC_ALL, NULL);
#endif
}

void WarnH(msg)
String msg;
{
	avs_set_event(2,1);
}

>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtSetLanguageProc Xt4
XtLanguageProc
XtSetLanguageProc(app_context, proc, client_data)
>>ASSERTION Good C
If the implementation is X11R5 or later:
A call to XtLanguageProc XtSetLanguageProc(app_context, proc, client_data)
shall register proc as the language procedure that will be called
from XtDisplayInitialize() for all subsequent displays initialized in
app_context and return the previously registered language procedure.
>>CODE
#if XT_X_RELEASE > 4
Widget	TopLevel2;
XtLanguageProc	oldproc;
int	argcount = 0;
int 	status;
#endif

#if XT_X_RELEASE > 4
	tet_infoline("PREP: Initialize the Xt toolkit");
	XtToolkitInitialize();
	tet_infoline("PREP: Create an application context");
	app_ctext = XtCreateApplicationContext();
	tet_infoline("PREP: Register XT error handler");
	XtAppSetErrorMsgHandler(app_ctext, xt_handler);
	tet_infoline("PREP: Open a display connection");
	sleep(config.reset_delay);
	display_good = XOpenDisplay(config.display);
	if (display_good == 0) {
		tet_infoline("ERROR: Cannot open display");
		tet_result(TET_FAIL);
		exit(1);
	}
	tet_infoline("TEST: Call XtSetLanguageProc");
	oldproc = XtSetLanguageProc(app_ctext, &XtLP_Proc, client_stuff);
	tet_infoline("TEST: Initialize display");
	XtDisplayInitialize(app_ctext, display_good, "tstlnggprc1",
	    "Tstlnggprc1",
	    (XrmOptionDescRec *)NULL,
	    (Cardinal)0, &argcount,
	    (String *)NULL );
	tet_infoline("TEST: Language procedure was invoked");
	status = avs_get_event(1);
	check_dec(1, status, "language procedure invocation count");
	tet_infoline("PREP: Open another display connection");
	display_good = XOpenDisplay(config.display);
	if (display_good == 0) {
		tet_infoline("ERROR: Cannot open display");
		tet_result(TET_FAIL);
		exit(1);
	}
	tet_infoline("TEST: Initialize it");
	XtDisplayInitialize(app_ctext, display_good, "tstlnggprc1",
	    "Tstlnggprc1",
	    (XrmOptionDescRec *)NULL,
	    (Cardinal)0, &argcount,
	    (String *)NULL );
	tet_infoline("TEST: Language procedure was invoked again");
	status = avs_get_event(1);
	check_dec(2, status, "language procedure invocation count");
	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation is X11R4");
	tet_result(TET_UNSUPPORTED);
#endif
>>ASSERTION Good C
If the implementation is X11R5 or later:
A call to XtLanguageProc XtSetLanguageProc(app_context, proc, client_data)
when app_context is NULL shall register proc in all application contexts 
created by the application, including those created in the future.
>>CODE
#if XT_X_RELEASE > 4
XtLanguageProc	oldproc;
int	argcount = 0;
int	status;
#endif

#if XT_X_RELEASE > 4
	tet_infoline("PREP: Initialize the Xt toolkit");
	XtToolkitInitialize();
	tet_infoline("PREP: Create an application context");
	app_ctext = XtCreateApplicationContext();
	tet_infoline("PREP: Register XT error handler");
	XtAppSetErrorMsgHandler(app_ctext, xt_handler);
	tet_infoline("PREP: Open a display connection");
	sleep(config.reset_delay);
	display_good = XOpenDisplay(config.display);
	if (display_good == 0) {
		tet_infoline("ERROR: Cannot open display");
		tet_result(TET_FAIL);
		exit(1);
	}
	tet_infoline("TEST: Call XtSetLanguageProc with NULL application context");
	oldproc = XtSetLanguageProc(NULL, &XtLP_Proc, client_stuff);
	tet_infoline("TEST: Initialize display");
	XtDisplayInitialize(app_ctext, display_good, "tstlnggprc1",
	    "Tstlnggprc1",
	    (XrmOptionDescRec *)NULL,
	    (Cardinal)0, &argcount,
	    (String *)NULL );
	tet_infoline("TEST: Language procedure was invoked");
	status = avs_get_event(1);
	check_dec(1, status, "language procedure invocation count");
	tet_infoline("PREP: Establish another application context");
	app_ctext2 = XtCreateApplicationContext();
	tet_infoline("PREP: Register XT error handler");
	XtAppSetErrorMsgHandler(app_ctext2, xt_handler);
	tet_infoline("PREP: Open another display connection");
	display_good = XOpenDisplay(config.display);
	if (display_good == 0) {
		tet_infoline("ERROR: Cannot open display");
		tet_result(TET_FAIL);
		exit(1);
	}
	tet_infoline("TEST: Initialize it");
	XtDisplayInitialize(app_ctext, display_good, "tstlnggprc1",
	    "Tstlnggprc1",
	    (XrmOptionDescRec *)NULL,
	    (Cardinal)0, &argcount,
	    (String *)NULL );
	tet_infoline("TEST: Language procedure was invoked again");
	status = avs_get_event(1);
	check_dec(2, status, "language procedure invocation count");
	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation is X11R4");
	tet_result(TET_UNSUPPORTED);
#endif
>>ASSERTION Good C
If the implementation is X11R5 or later:
A call to XtLanguageProc XtSetLanguageProc(app_context, proc, client_data)
when proc is NULL shall register a default language procedure.
>>CODE
#if XT_X_RELEASE > 4
XtLanguageProc	oldproc, oldproc2;
int	argcount = 0 ;
int	status;
#endif

#if XT_X_RELEASE > 4
	tet_infoline("PREP: Initialize the Xt toolkit");
	XtToolkitInitialize();
	tet_infoline("PREP: Create an application context");
	app_ctext = XtCreateApplicationContext();
	tet_infoline("PREP: Register XT error handler");
	XtAppSetErrorMsgHandler(app_ctext, xt_handler);
	tet_infoline("TEST: Call XtSetLanguageProc with NULL proc");
	/*when nothing has been registered, returns what gets the default*/
	oldproc = XtSetLanguageProc(app_ctext, NULL, client_stuff);
	tet_infoline("TEST: Call XtSetLanguageProc again to get last proc set");
	oldproc2 = XtSetLanguageProc(app_ctext, &XtLP_Proc, client_stuff);
	tet_infoline("TEST: Compare returns from two calls");
	if (oldproc != oldproc2) {
		sprintf(ebuf, "ERROR: Default language procedure wasn't registered");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Call XtSetLanguageProc again with NULL proc");
	oldproc = XtSetLanguageProc(app_ctext, NULL, client_stuff);
	tet_infoline("TEST: Open a display connection");
	sleep(config.reset_delay);
	display_good = XOpenDisplay(config.display);
	if (display_good == 0) {
		tet_infoline("ERROR: Cannot open display");
		tet_result(TET_FAIL);
		exit(1);
	}
	tet_infoline("TEST: Initialize display");
	XtDisplayInitialize(app_ctext, display_good, "tstlnggprc1",
	    "Tstlnggprc1",
	    (XrmOptionDescRec *)NULL,
	    (Cardinal)0, &argcount,
	    (String *)NULL );
	tet_infoline("TEST: Test procedure was not invoked");
	status = avs_get_event(1);
	check_dec(0, status, "language procedure invocation count");
	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation is X11R4");
	tet_result(TET_UNSUPPORTED);
#endif
>>ASSERTION Good C
If the implementation is X11R5 or later:
When a language procedure has not yet been registered, a call to
XtLanguageProc XtSetLanguageProc(app_context, proc, client_data) shall
return a value which will cause the default language procedure
to be registered when used in a subsequent call to XtSetLanguageProc().
>>CODE
#if XT_X_RELEASE > 4
int	argcount = 0;
int	status;
XtLanguageProc	oldproc, oldproc2;
#endif

#if XT_X_RELEASE > 4
	tet_infoline("PREP: Initialize the Xt toolkit");
	XtToolkitInitialize();
	tet_infoline("PREP: Create an application context");
	app_ctext = XtCreateApplicationContext();
	tet_infoline("PREP: Register XT error handler");
	XtAppSetErrorMsgHandler(app_ctext, xt_handler);
	tet_infoline("TEST: Call XtSetLanguageProc setting test procedure");
	oldproc = XtSetLanguageProc(app_ctext, &XtLP_Proc, client_stuff);
	tet_infoline("TEST: Call XtSetLanguageProc with return from first call");
	oldproc2 = XtSetLanguageProc(app_ctext, oldproc, client_stuff);
	tet_infoline("TEST: Open a display connection");
	sleep(config.reset_delay);
	display_good = XOpenDisplay(config.display);
	if (display_good == 0) {
		tet_infoline("ERROR: Cannot open display");
		tet_result(TET_FAIL);
		exit(1);
	}
	tet_infoline("TEST: Initialize display");
	XtDisplayInitialize(app_ctext, display_good, "tstlnggprc1",
	    "Tstlnggprc4",
	    (XrmOptionDescRec *)NULL,
	    (Cardinal)0, &argcount,
	    (String *)NULL );
	tet_infoline("TEST: Test procedure was not invoked");
	status = avs_get_event(1);
	check_dec(0, status, "language procedure invocation count");
	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation is X11R4");
	tet_result(TET_UNSUPPORTED);
#endif
>>ASSERTION Good B 3
If the implementation is X11R5 or later:
The default language procedure set by a call to
XtLanguageProc XtSetLanguageProc(app_context, proc, client_data) 
shall set the locale according to the environment.
>>ASSERTION Good B 1
If the implementation is X11R5 or later:
The default language procedure set by a call to
XtLanguageProc XtSetLanguageProc(app_context, proc, client_data) 
shall issue a warning if an error is encountered in setting the locale.
>>ASSERTION Good C
If the implementation is X11R5 or later:
The default language procedure set by a call to
XtLanguageProc XtSetLanguageProc(app_context, proc, client_data) 
shall issue a warning and the set the locale to "C" if the locale
specified by the environment is not supported.
>>CODE
#if XT_X_RELEASE > 4
Widget	TopLevel2;
XtLanguageProc	oldproc;
int	argcount = 0;
int 	status;
#endif

#if XT_X_RELEASE > 4
	putenv("LC_ALL=unreal");
	tet_infoline("PREP: Initialize the Xt toolkit");
	XtToolkitInitialize();
	tet_infoline("PREP: Create an application context");
	app_ctext = XtCreateApplicationContext();
	XtAppSetWarningHandler(app_ctext, WarnH);
	tet_infoline("TEST: Call XtSetLanguageProc again with NULL proc");
	oldproc = XtSetLanguageProc(app_ctext, NULL, client_stuff);
	tet_infoline("PREP: Open a display connection");
	sleep(config.reset_delay);
	display_good = XOpenDisplay(config.display);
	if (display_good == 0) {
		tet_infoline("ERROR: Cannot open display");
		tet_result(TET_FAIL);
		exit(1);
	}
	tet_infoline("TEST: Initialize display");
	XtDisplayInitialize(app_ctext, display_good, "tstlnggprc1",
	    "Tstlnggprc1",
	    (XrmOptionDescRec *)NULL,
	    (Cardinal)0, &argcount,
	    NULL);
	tet_infoline("TEST: Warning was issued");
	status = avs_get_event(2);
	check_dec(1, status, "warning handler invocation count");
	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation is X11R4");
	tet_result(TET_UNSUPPORTED);
#endif
>>ASSERTION Good C
If the implementation is X11R5 or later:
After setting the locale, the default language procedure set by a call to
XtLanguageProc XtSetLanguageProc(app_context, proc, client_data) 
shall set the X locale modifiers to the empty string.
>>CODE
#if XT_X_RELEASE > 4
Widget	TopLevel2;
XtLanguageProc	oldproc;
int	argcount = 0;
int 	status;
char *mod_ret;
#endif

#if XT_X_RELEASE > 4
	tet_infoline("PREP: Initialize the Xt toolkit");
	XtToolkitInitialize();
	tet_infoline("PREP: Create an application context");
	app_ctext = XtCreateApplicationContext();
	XtAppSetWarningHandler(app_ctext, WarnH);
	tet_infoline("TEST: Call XtSetLanguageProc again with NULL proc");
	oldproc = XtSetLanguageProc(app_ctext, NULL, client_stuff);
	tet_infoline("PREP: Open a display connection");
	sleep(config.reset_delay);
	display_good = XOpenDisplay(config.display);
	if (display_good == 0) {
		tet_infoline("ERROR: Cannot open display");
		tet_result(TET_FAIL);
		exit(1);
	}
	tet_infoline("TEST: Initialize display");
	XtDisplayInitialize(app_ctext, display_good, "tstlnggprc1",
	    "Tstlnggprc1",
	    (XrmOptionDescRec *)NULL,
	    (Cardinal)0, &argcount,
	    NULL);
	tet_infoline("PREP: Get locale modifiers");
	mod_ret = XSetLocaleModifiers("");
	if (mod_ret == NULL) {
		tet_infoline("ERROR: XSetLocaleModifiers return value is NULL");
		tet_result(TET_FAIL);
	} else {
	if (strcmp(mod_ret, "") != 0) {
		sprintf(ebuf, "ERROR: Expected empty string, received \"%s\"", mod_ret);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	}
	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation is X11R4");
	tet_result(TET_UNSUPPORTED);
#endif
