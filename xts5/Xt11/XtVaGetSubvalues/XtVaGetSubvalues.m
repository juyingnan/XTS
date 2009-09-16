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
>># File: xts/Xt11/XtVaGetSubvalues/XtVaGetSubvalues.m
>># 
>># Description:
>>#	Tests for XtVaGetSubvalues()
>># 
>># Modifications:
>># $Log: tvagtsval.m,v $
>># Revision 1.1  2005-02-12 14:37:54  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:37:51  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:00:49  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.1  1998/08/05 22:17:39  andy
>># Changed the type used for getting XtNforeground from int to Pixel.
>>#
>># Revision 6.0  1998/03/02 05:28:54  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:25:28  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.1  1997/01/07 19:50:32  mar
>># req.4.W.00032: tp3 - XtVaGetSubvalues() call missing the XtVaNestedList keyword
>># before the nested args list, thelist.
>>#
>># Revision 4.0  1995/12/15  09:20:41  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:15:45  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;

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
	XtRString, "XtDefaultforeground"
	},
	{
	XtNlabel,
	XtCLabel,
	XtRString, sizeof(String),
	XtOffsetOf(instance_variable_rec, label),
	XtRString, "XtDefaultLabel"
	},
};

void XtWMHl_Proc(str1)
String str1;
{
	avs_set_event(1,1);
}
void XtWMH_Proc(str1, str2, str3, str4, str5, car)
String str1, str2, str3, str4, *str5;
Cardinal *car;
{
	avs_set_event(1,1);
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtVaGetSubvalues Xt11
void
XtVaGetSubvalues(base, resources, num_resources, ...)
>>ASSERTION Good A
A call to
void XtVaGetSubvalues(base, resources, num_resources, ...)
shall copy the resource value from the structure pointed to by
.A base 
for each resource name specified in the varargs style variable 
argument list of name/value pairs that is present in the resource 
list specified by
.A resources
to the location specified by the corresponding value field.
>>CODE
instance_variable_rec base;
Cardinal num_resources;
Pixel pixel;
char *string;
Cardinal num_args;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tvagtsval1", "XtVaGetSubvalues");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Initialize the base address");
	XtGetApplicationResources(topLevel, &base, resources, 2,
			(ArgList) NULL, (Cardinal)0);
	tet_infoline("PREP: Set subvalues");
	XtVaSetSubvalues(&base, resources, 2, XtNforeground, 1,
		 XtNlabel, "Hello World", (char *)NULL);
	tet_infoline("PREP: Get subvalues");
	XtVaGetSubvalues(&base, resources, 2, XtNforeground, &pixel,
		 XtNlabel, &string, (char *)NULL);
	tet_infoline("TEST: Retrieved subvalues");
	check_dec(1, pixel , XtNforeground);
	check_str("Hello World", string , XtNlabel);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When a member in the variable argument list is of type XtVaTypedArg
a call to
void XtVaGetSubvalues(base, resources, num_resources, ...)
shall issue a warning message and ignore the entry.
>>CODE
instance_variable_rec base;
Cardinal num_resources;
Pixel pixel;
char *string;
Cardinal num_args;
pid_t pid2;
int status;

	FORK(pid2);
	avs_set_event(1, 0);
	avs_xt_hier("Tvagtsval1", "XtVaGetSubvalues");
	XtAppSetWarningMsgHandler(app_ctext, XtWMH_Proc);
	XtAppSetWarningHandler(app_ctext, XtWMHl_Proc);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Initialize the base address");
	XtGetApplicationResources(topLevel, &base, resources, 2,
			(ArgList) NULL, (Cardinal)0);
	tet_infoline("PREP: Set subvalues");
	XtVaSetSubvalues(&base, resources, 2, XtNforeground, 1,
		 XtNlabel, "Hello World", (char *)NULL);
	tet_infoline("PREP: Get subvalues");
	
	XtVaGetSubvalues(&base, resources, 2, XtNforeground, &pixel,
		 XtVaTypedArg, XtNlabel, XtRString, string, 0, (char *)NULL);
	tet_infoline("TEST: Retrieved subvalues");
	check_dec(1, pixel , XtNforeground);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Warning handler is called");
	status = avs_get_event(1);
	check_dec(1, status, "calls to warning handler count");
	tet_result(TET_PASS);
>>ASSERTION Good A
On a call to
void XtVaGetSubvalues(base, resources, num_resources, ...)
when the name XtVaNestedList is specified in place of a resource name
in the variable argument list it shall interpret the next argument 
as a value specifying another varargs style variable argument list and 
logically insert it in the original list at the point of declaration.
>>CODE
instance_variable_rec base;
Cardinal num_resources;
Pixel pixel;
char *string;
Cardinal num_args;
pid_t pid2;
XtVarArgsList thelist;

	FORK(pid2);
	avs_xt_hier("Tvagtsval1", "XtVaGetSubvalues");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Initialize the base address");
	XtGetApplicationResources(topLevel, &base, resources, 2,
			(ArgList) NULL, (Cardinal)0);
	tet_infoline("PREP: Set subvalues");
	XtVaSetSubvalues(&base, resources, 2, XtNforeground, 1,
		 XtNlabel, "Hello World", (char *)NULL);
	tet_infoline("PREP: Get subvalues");
	thelist=XtVaCreateArgsList(NULL, XtNforeground, &pixel, NULL);
	XtVaGetSubvalues(&base, resources, 2, XtVaNestedList, thelist,
		 XtNlabel, &string, (char *)NULL);
	tet_infoline("TEST: Retrieved subvalues");
	check_dec(1, pixel , XtNforeground);
	check_str("Hello World", string , XtNlabel);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
