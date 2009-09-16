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
>># File: xts/Xt4/XtScreenDatabase/XtScreenDatabase.m
>># 
>># Description:
>>#	Tests for XtScreenDatabase()
>># 
>># Modifications:
>># $Log: tscrndtbs.m,v $
>># Revision 1.1  2005-02-12 14:38:08  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:36:20  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:59:09  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:27:31  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:04  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:15:51  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:19:36  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;
>>TITLE XtScreenDatabase Xt4
XrmDatabase
XtScreenDatabase(screen)
>>ASSERTION Good C
If the implementation is X11R5 or later:
A call to XrmDatabase XtScreenDatabase(screen) shall return the
fully merged resource database for the screen specified by the screen
argument.
>>CODE
#if XT_X_RELEASE > 4
Display	*display;
Widget	labelw_good;
Screen	*screen_good;
char	*str_type;
int	argcount = 0;
XrmValue	value[1];
XrmDatabase database;
static	String fallback_res[] = {
	"*hello.labelString:  Hello World",
	NULL,
};
#endif

#if XT_X_RELEASE > 4
	avs_xt_hier("Tscrndtbs1", "XtScreenDatabase");
	tet_infoline("TEST: Set default set of resource values.");
	XtAppSetFallbackResources(app_ctext, fallback_res);
	tet_infoline("TEST: Initialize display to add resources");
	display = XtDisplay(topLevel);
	XtDisplayInitialize(app_ctext, display,
		    "tscrndtbs1", "Tscrndtbs1",
		    (XrmOptionDescRec *)NULL,
		    (Cardinal)0, &argcount,
		    (String *)NULL );
	tet_infoline("PREP: Create labelw_good widget in boxw1 widget");
	labelw_good = (Widget) CreateLabelWidget("hello", boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get the screen pointer for labelw widget");
	if ((screen_good = XtScreen(labelw)) == NULL ) {
	   	sprintf(ebuf, "ERROR: Expected Screen pointer returned NULL");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Get the resource database");
	database = XtScreenDatabase(screen_good);
	tet_infoline("TEST: Check resource values");
	XrmGetResource(database, "*hello.labelString", NULL, &str_type, &value[0]);
	if (strncmp("Hello World", value[0].addr, strlen("Hello World")) != 0 ) {
	    	sprintf(ebuf, "ERROR: Expected \"Hello World\" for hello.labelString, Received \"%s\"", value[0].addr);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
