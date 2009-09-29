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
>># File: xts/Xt4/XtSetArg.m
>># 
>># Description:
>>#	Tests for XtSetArg()
>># 
>># Modifications:
>># $Log: tstarg.m,v $
>># Revision 1.1  2005-02-12 14:38:09  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:36:21  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:59:11  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:27:32  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:06  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:15:55  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:19:41  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

extern char * event_names[];

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;
>>TITLE XtSetArg Xt4
void
XtSetArg(arg, resource_name, value)
>>ASSERTION Good A
A call to void XtSetArg(arg, resource_name, value) when the size of value
is less than or equal to the size of XtArgVal shall set the arg.name
member of the structure arg to resource_name and the arg.value member to 
value.
>>CODE
Display *display;
Arg testarg;

	tet_infoline("TEST: XtSetArg sets arg members correctly");
	XtSetArg(testarg, "ApTest", 1);
	if (strcmp(testarg.name, "ApTest") != 0) {
		sprintf(ebuf, "ERROR: expected arg name = \"ApTest\", was \"%s\"", testarg.name);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	if (testarg.value  != 1) {
		sprintf(ebuf, "ERROR: expected value = 1, was %d", testarg.value);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
>>ASSERTION Good A
A call to void XtSetArg(arg, resource_name, value) when the size of value 
is greater than the size of XtArgVal shall store a pointer to value in
the arg.value member of the structure arg.
>>CODE
Display *display;
Arg testarg;

	tet_infoline("TEST: XtSetArg sets arg members correctly");
	XtSetArg(testarg, "ApTest2", "A string");
	if (strcmp(testarg.name, "ApTest2") != 0) {
		sprintf(ebuf, "ERROR: expected arg name = \"ApTest2\", was \"%s\"", testarg.name);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	if (strncmp((char *)testarg.value, "A string", strlen("A string"))  != 0) {
		tet_infoline("ERROR: expected value to point to string");
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
