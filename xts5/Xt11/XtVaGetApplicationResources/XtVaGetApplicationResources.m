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
$Header: /cvs/xtest/xtest/xts5/tset/Xt11/XtVaGetApplicationResources/XtVaGetApplicationResources.m,v 1.1 2005-02-12 14:37:54 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt11/XtVaGetApplicationResources/XtVaGetApplicationResources.m
>># 
>># Description:
>>#	Tests for XtVaGetApplicationResources()
>># 
>># Modifications:
>># $Log: tvagtares.m,v $
>># Revision 1.1  2005-02-12 14:37:54  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:37:25  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:00:21  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:28:30  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:25:04  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:19:24  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:14:05  andy
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
	XtRString, "XtDefaultForeground"
	},
	{
	XtNlabel,
	XtCLabel,
	XtRString, sizeof(String),
	XtOffsetOf(instance_variable_rec, label),
	XtRString, "XtDefaultLabel"
	},
};
int def = 2002;

static XtResource resources2[] = {
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
	XtRInt, &def
	},
};

char whereitsat[64];

Boolean XtCVT_Proc(display, args, num_args, from_val, to_val, converter_data)
Display *display;
XrmValuePtr args;
Cardinal *num_args;
XrmValue *from_val;
XrmValue *to_val;
XtPointer *converter_data;
{
	sprintf(whereitsat, "%d", *(int *)from_val->addr);
	*(String*)to_val->addr = whereitsat;
	to_val->size = sizeof(XtPointer);
	avs_set_event(2, avs_get_event(2)+1);
	return True;
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtVaGetApplicationResources Xt11
void
XtVaGetApplicationResources(w, base, resources, num_resources, ....)
>>ASSERTION Good A
A successful call to
void XtVaGetApplicationResources(w, base, resources, num_resources, ....)
shall retrieve the resource value for each resource
specified in the resource list
.A resources
from the resource values specified in the varargs style
variable argument list, or if no value for the resource is 
found in the variable argument list, from the resource database 
associated with the widget
.A w,
matching the resource identified by the
the names and classes of all ancestors of
.A w,
the name and class of
.A w,
and the resource name and class,
or if no value is found in the database, from the default_addr
field of the resource list and copy the resource value at an offset
specified by the corresponding resource_offset field from the address
.A base.
>>CODE
instance_variable_rec base;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tvagtares1", "XtVaGetApplicationResources");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Retrieve resource values from resource database");
	XtVaGetApplicationResources(topLevel, 
			&base,
			resources,
			XtNumber(resources),
			(char *)NULL);
	tet_infoline("TEST: Retrieved resource value");
	if ((base.foreground != 0) && (base.foreground != 1)) {
		sprintf(ebuf, "ERROR: expected 0 or 1, received %d", base.foreground);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Retrieve resource values from arg list");
	XtVaGetApplicationResources(topLevel,
			&base,
			resources,
			2,
			XtNlabel, "label value", NULL
			);
	tet_infoline("TEST: Retrieved resource value");
	if (strcmp(base.label, "label value") != 0) {
		sprintf(ebuf, "ERROR: Expected \"label value\", received \"%s\"", base.label);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Retrieve resource values from defaults");
	XtVaGetApplicationResources(topLevel, 
			&base,
			resources,
			XtNumber(resources),
			(char *)NULL);
	tet_infoline("TEST: Retrieved resource value");
	if (strcmp(base.label, "XtDefaultLabel") != 0) {
		sprintf(ebuf, "ERROR: Expected \"XtDefaultLabel\", received \"%s\"", base.label);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
On a call to
void XtVaGetApplicationResources(w, base, resources, num_resources, ....)
when a resource specified in the resource database, variable argument
list or a default resource value is in a different representation from 
the representation type specified in the resource_type field of the 
resource list it shall call the appropriate type converter to 
perform the conversion and store the converted value in the subpart 
data structure.
>>CODE
instance_variable_rec base;
pid_t pid2;
int status;

	FORK(pid2);
	avs_xt_hier("Tvagtares2", "XtVaGetApplicationResources");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	XtAppSetTypeConverter(app_ctext,
		 XtRInt,
		 XtRString,
		 XtCVT_Proc,
		 (XtConvertArgList)NULL,
		 (Cardinal)0,
		 XtCacheNone,
		 NULL);
	tet_infoline("TEST: Retrieve resource value needing conversion");
	XtVaGetApplicationResources(topLevel, 
			&base,
			resources2,
			XtNumber(resources),
			(char *)NULL);
	tet_infoline("TEST: Retrieved resource value");
	if (strcmp(base.label, "2002") != 0) {
		sprintf(ebuf, "ERROR: Expected \"2002\", received \"%s\"", base.label);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: convertor was invoked");
	status = avs_get_event(2);
	check_dec(1, status, "XtCVT_Proc invoked status");
	tet_result(TET_PASS);
>>ASSERTION Good A
On a call to
void XtVaGetApplicationResources(w, base, resources, num_resources, ....)
when the name XtVaTypedArg is specified in place of a resource name
in the variable argument list it shall interpret the four arguments
following this argument as a name/type/value/size tuple.
>>CODE
instance_variable_rec base;
pid_t pid2;
String thelab="label value";

	FORK(pid2);
	avs_xt_hier("Tvagtares1", "XtVaGetApplicationResources");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Retrieve resource values from arg list");
	XtVaGetApplicationResources(topLevel,
		&base,
		resources,
		2,
		XtVaTypedArg, XtNlabel, XtRString, thelab, strlen(thelab)+1, NULL
		);
	tet_infoline("TEST: Retrieved resource value");
	if (strcmp(base.label, "label value") != 0) {
		sprintf(ebuf, "ERROR: Expected \"label value\", received \"%s\"", base.label);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
On a call to
void XtVaGetApplicationResources(w, base, resources, num_resources, ....)
when the name XtVaNestedList is specified in place of a resource name
in the variable argument list it shall interpret the next argument 
as a value specifying another varargs style variable argument list and 
logically insert it in the original list at the point of declaration.
>>CODE
instance_variable_rec base;
pid_t pid2;
XtVarArgsList thelist;

	FORK(pid2);
	avs_xt_hier("Tvagtares1", "XtVaGetApplicationResources");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Retrieve resource values from arg list");
	thelist=XtVaCreateArgsList(NULL, XtNlabel, "label value", NULL);
	XtVaGetApplicationResources(topLevel,
		&base,
		resources,
		2,
		XtVaNestedList, thelist, NULL
		);
	tet_infoline("TEST: Retrieved resource value");
	if (strcmp(base.label, "label value") != 0) {
		sprintf(ebuf, "ERROR: Expected \"label value\", received \"%s\"", base.label);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
