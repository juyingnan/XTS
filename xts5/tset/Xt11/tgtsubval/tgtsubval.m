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
$Header: /cvs/xtest/xtest/xts5/tset/Xt11/tgtsubval/tgtsubval.m,v 1.1 2005-02-12 14:37:54 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt11/tgtsubval/tgtsubval.m
>># 
>># Description:
>>#	Tests for XtGetSubvalues()
>># 
>># Modifications:
>># $Log: tgtsubval.m,v $
>># Revision 1.1  2005-02-12 14:37:54  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:37:50  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:00:48  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:28:54  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:25:28  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:20:40  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:15:44  andy
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
>>TITLE XtGetSubvalues Xt11
void
XtGetSubvalues(base, resources, num_resources, args, num_args)
>>ASSERTION Good A
A call to
void XtGetSubvalues(base, resources, num_resources, args, num_args)
shall copy the resource value from the structure pointed to by
.A base 
for the resource specified in the name field of each member of 
the argument list 
.A args
that is present in the resource list specified by
.A resources
to the location specified by the corresponding value field.
>>CODE
instance_variable_rec base;
Cardinal num_resources;
Arg setargs[2], getargs[2];
Cardinal num_args;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tgtsubval1", "XtGetSubvalues");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Initialize the base address");
	XtGetApplicationResources(topLevel, &base, resources,2,
			(ArgList)NULL,(Cardinal)0);
	tet_infoline("PREP: Set subvalues");
	setargs[0].name = XtNforeground;
	setargs[0].value = (XtArgVal)1;
	setargs[1].name = XtNlabel;
	setargs[1].value = (XtArgVal)"Hello World";
	XtSetSubvalues(&base, resources, 2, &setargs[0], 2 );
	tet_infoline("PREP: Get subvalues");
	getargs[0].name = XtNforeground;
	getargs[0].value = (XtArgVal)malloc(sizeof(Pixel));
	getargs[1].name = XtNlabel;
	getargs[1].value = (XtArgVal)malloc(strlen("Hello World")+1);
	XtGetSubvalues(&base, resources, 2, getargs, 2);
	tet_infoline("TEST: Retrieved subvalues");
	check_dec(1, *((Pixel *)getargs[0].value) , XtNforeground);
	check_str("Hello World", *(char**)getargs[1].value, XtNlabel);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
A call to
void XtGetSubvalues(base, resources, num_resources, args, num_args)
when a resource specified in the argument list 
.A args
is not present in the resource list specified by
.A resources
shall not modify the value at the location specified by the 
corresponding value field.
>>CODE
instance_variable_rec base;
Cardinal num_resources;
Arg setargs[2], getargs[2];
Cardinal num_args;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tgtsubval1", "XtGetSubvalues");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Initialize the base address");
	XtGetApplicationResources(topLevel, &base, resources,2,
			(ArgList)NULL,(Cardinal)0);
	tet_infoline("PREP: Set subvalues");
	setargs[0].name = XtNforeground;
	setargs[0].value = (XtArgVal)1;
	setargs[1].name = XtNlabel;
	setargs[1].value = (XtArgVal)"Hello World";
	XtSetSubvalues(&base, resources, 2, &setargs[0], 2 );
	tet_infoline("PREP: Get subvalues");
	getargs[0].name = "missing 1";
	getargs[0].value = (XtArgVal)malloc(sizeof(Pixel));
	getargs[1].name = XtNlabel;
	getargs[1].value = (XtArgVal)malloc(strlen("Hello World")+1);
	*(Pixel *) getargs[0].value = 0xAA;
	XtGetSubvalues(&base, resources, 2, getargs, 2);
	tet_infoline("TEST: Value was not changed");
	check_dec(0xAA, *((Pixel *)getargs[0].value), "value");
	check_str("Hello World", *(char**)getargs[1].value, XtNlabel);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
