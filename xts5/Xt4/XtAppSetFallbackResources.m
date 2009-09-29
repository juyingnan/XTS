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
>># File: xts/Xt4/XtAppSetFallbackResources.m
>># 
>># Description:
>>#	Tests for XtAppSetFallbackResources()
>># 
>># Modifications:
>># $Log: tappstfllb.m,v $
>># Revision 1.1  2005-02-12 14:38:00  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:36:21  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:59:10  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:27:32  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:05  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:15:54  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:19:39  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;
>>TITLE XtAppSetFallbackResources Xt4
void
XtAppSetFallbackResources(app_ctext, specification_list)
>>ASSERTION Good A
A call to void XtAppSetFallbackResources(app_ctext, specification_list)
shall set the default resource values for the application context app_ctext
from the resource list specification_list to be used in place of an 
application-specific class resource file in initializing a resource database 
if the application-specific class resource file is not found.
>>CODE
Display	*display;
Widget	labelw_good;
XrmDatabase	database;
char	*str_type;
XrmValue	value[1];
int	argcount = 0;
static	String fallback_res[] = {
	"*hello.labelString:  Hello World",
	NULL,
};

	avs_xt_hier("Tappstfllb1", "XtAppSetFallbackResources");
	tet_infoline("TEST: Set default set of resource values.");
	XtAppSetFallbackResources(app_ctext, fallback_res);
	tet_infoline("TEST: Initialize display to add resources");
	display = XtDisplay(topLevel);
	XtDisplayInitialize(app_ctext, display, 
		    "tappstfllb1", "Tappstfllb1", 
		    (XrmOptionDescRec *)NULL,
		    (Cardinal) 0, &argcount,
		    (String *)NULL );
	tet_infoline("TEST: Get the resource database");
	database = XtDatabase(display);
	tet_infoline("TEST: Check the default resource values");
	XrmGetResource(database, "hello.labelString", NULL, &str_type, &value[0]); 
	if (strncmp("Hello World", value[0].addr, strlen("Hello World")) != 0 ) {
	    	sprintf(ebuf, "ERROR: Expected \"Hello World\" for hello.labelString, Received \"%s\"", value[0].addr);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
>>ASSERTION Good A
When the argument specification_list is NULL, a call to void
XtAppSetFallbackResources(app_ctext, specification_list) shall remove
any previous fallback resource specification for the application context.
>>CODE
Display	*display;
Widget	labelw_good;
XrmDatabase database;
char	*str_type[40];
XrmValue result;
XrmValue *value = &result;
int 	argcount = 1;
char	*str_class = NULL;
char	string[40];
static	String fallback_res[] = {
	"*hello.labelString:  Hello World",
	(String)NULL,
};

	avs_xt_hier("Tappstfllb2", "XtAppSetFallbackResources");
	tet_infoline("TEST: Set label resource to Hello World.");
	XtAppSetFallbackResources(app_ctext, &fallback_res[0]);
	display = XtDisplay(topLevel);
	XtDisplayInitialize(app_ctext, display,
		    "tappstfllb2", "Tappstfllb2",
		    (XrmOptionDescRec *)NULL,
		    (Cardinal)0, &argcount,
		    (String *)NULL );
	tet_infoline("TEST: Specify resource list as NULL");
	XtAppSetFallbackResources(app_ctext, (String *)NULL);
	tet_infoline("TEST: Initialize display to add resources");
	XtDisplayInitialize(app_ctext, display, 
		    "tappstfllb2", "Tappstfllb2", 
		    (XrmOptionDescRec *)NULL,
		    (Cardinal) 0, &argcount,
		    (String *)NULL );
	tet_infoline("TEST: Get resource database");
	database = XtDatabase(display);
	tet_infoline("TEST: Check label resource value is deleted from list");
	XrmGetResource(database, "hello.labelString", str_class, str_type, value); 
	if ( value->size != 0 ) {
	    	sprintf(ebuf, "ERROR: Expected NULL, Received %s", value->addr);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
