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
$Header: /cvs/xtest/xtest/xts5/tset/Xt4/XtDatabase/XtDatabase.m,v 1.1 2005-02-12 14:38:02 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt4/XtDatabase/XtDatabase.m
>># 
>># Description:
>>#	Tests for XtDatabase()
>># 
>># Modifications:
>># $Log: tdtbs.m,v $
>># Revision 1.1  2005-02-12 14:38:02  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:36:20  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:59:10  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.1  1998/06/23 22:47:15  andy
>># Added sleep(XT_RESET_DELAY) to each test.  SR# 186.
>>#
>># Revision 6.0  1998/03/02 05:27:31  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:05  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:15:53  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:19:38  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;
>>TITLE XtDatabase Xt4
XrmDatabase
XtDatabase(display)
>>ASSERTION Good A
A call to XrmDatabase XtDatabase(display) shall return the default
resource database associated with display.
>>CODE
Display	*display;
Widget	labelw_good;
XrmDatabase database;
char	*str_type;
int	argcount = 0;
XrmValue	value[1];
static String fallback_res[] = {
	"*hello.labelString:  Hello World",
	NULL,
};

	XtToolkitInitialize();
	app_ctext = XtCreateApplicationContext();
	tet_infoline("PREP: Set default set of resource values.");
	XtAppSetFallbackResources(app_ctext, fallback_res);
	tet_infoline("PREP: Initialize display");
	sleep(config.reset_delay);
	display = XOpenDisplay(config.display);
	if (display == 0) {
		tet_infoline("ERROR: Cannot open display");
		tet_result(TET_FAIL);
		exit(1);
	}
	XtDisplayInitialize(app_ctext, display,
		    "tdtbs1", "Tdtbs1",
		    (XrmOptionDescRec *)NULL,
		    (Cardinal)0, &argcount,
		    (String *)NULL );
	tet_infoline("TEST: Get the resource database");
	database = XtDatabase(display);
	tet_infoline("TEST: Check resource values");
	XrmGetResource(database, "hello.labelString", NULL,
		   &str_type, &value[0]);
	if (strncmp("Hello World", value[0].addr, strlen("Hello World")) != 0 ) {
	    	sprintf(ebuf, "ERROR: Expected \"Hello World\"for hello.labelString,  Received %s", value[0].addr);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
>>ASSERTION Good C
If the implementation is X11R5 or later: 
A call to XrmDatabase XtDatabase(display) when display has not been 
initialized shall return NULL.
>>CODE
Display	*display;
XrmDatabase	database;

#if XT_X_RELEASE > 4
	XtToolkitInitialize();
	app_ctext = XtCreateApplicationContext();
        if (app_ctext == NULL) {
        	tet_infoline("ERROR: Expected valid application context returned NULL");
                tet_result(TET_FAIL);
                return;
        }
	tet_infoline("PREP: Open display");
	sleep(config.reset_delay);
        display = XOpenDisplay(config.display);
	if (display == 0) {
		tet_infoline("ERROR: Cannot open display");
		tet_result(TET_FAIL);
		exit(1);
	}
	tet_infoline("TEST: Database is NULL");
	database = XtDatabase(display);
	if (database != NULL) {
	    	tet_infoline("ERROR: Expected return of NULL");
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation is X11R4");
	tet_result(TET_UNSUPPORTED);
#endif
