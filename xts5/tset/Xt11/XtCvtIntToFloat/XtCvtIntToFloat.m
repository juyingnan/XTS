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
$Header: /cvs/xtest/xtest/xts5/tset/Xt11/XtCvtIntToFloat/XtCvtIntToFloat.m,v 1.1 2005-02-12 14:37:51 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt11/XtCvtIntToFloat/XtCvtIntToFloat.m
>># 
>># Description:
>>#	Tests for XtCvtIntToFloat()
>># 
>># Modifications:
>># $Log: tcinflt.m,v $
>># Revision 1.1  2005-02-12 14:37:51  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:37:40  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:00:36  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:28:43  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:25:18  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:20:07  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:15:00  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;
>>TITLE XtCvtIntToFloat Xt11
Boolean
XtCvtIntToFloat(display, args, num_args, from, to, converter_data)
>>ASSERTION Good C
If the implementation is X11R5 or later:
A successful call to
Boolean XtCvtIntToFloat(display, args, num_args, from, to, converter_data)
when 
.A to->addr 
is not NULL and 
.A to->size 
is large enough to store
an XtRFloat type shall convert the XtRInt value specified in 
.A from
to an XtRFloat type, store it at the location specified by
.A to->addr,
set
.A to->size 
to the actual size of the converted data, and return True.
>>CODE
#if XT_X_RELEASE > 4
/* Conversion arguments and results */
Boolean status;
Display *display;
XrmValue args[2];
Cardinal num_args;
XrmValue fromVal;
XrmValue toVal;
XtPointer *closure_ret = (XtPointer *) 0;
/* Int to float specific */
int num = 7;
float res;
pid_t pid2;
#endif

#if XT_X_RELEASE > 4
	FORK(pid2);
	avs_xt_hier("Tcinboln1", "XtCvtIntToFloat");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get display");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Set up required conversion args");
	num_args = 0;
	tet_infoline("TEST: Conversion succeeds");
	fromVal.addr = (XtPointer) &num;
	fromVal.size = sizeof(int);
	toVal.addr = (XtPointer) &res;
	toVal.size = sizeof(float);
	status = XtCvtIntToFloat(display,
			&args[0],
			&num_args,
			&fromVal,
			&toVal,
			closure_ret);
	check_dec(True, status, "XtCvtIntToFloat return value");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
>>ASSERTION Good C
If the implementation is X11R5 or later:
A call to 
Boolean XtCvtIntToFloat(display, args, num_args, from, to, converter_data)
when 
.A to->addr 
is not NULL and 
.A to->size 
is too small for an
XtRFloat type shall not perform a
conversion, set the 
.A to->size 
field to the number of bytes required to store the converted data,
and return False.
>>CODE
#if XT_X_RELEASE > 4
/* Conversion arguments and results */
Boolean status;
Display *display;
XrmValue args[2];
Cardinal num_args;
XrmValue fromVal;
XrmValue toVal;
XtPointer *closure_ret = (XtPointer *) 0;
/* Int to float specific */
int num = 1;
float res;
pid_t pid2;
#endif

#if XT_X_RELEASE > 4
	FORK(pid2);
	avs_xt_hier("Tcinboln3", "XtCvtIntToFloat");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get display");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Set up required conversion args");
	num_args = 0;
	tet_infoline("TEST: Conversion fails");
	fromVal.addr = (XtPointer) &num;
	fromVal.size = sizeof(int);
	toVal.addr = (XtPointer) &res;
	toVal.size = 0;
	status = XtCvtIntToFloat(display,
			&args[0],
			&num_args,
			&fromVal,
			&toVal,
			closure_ret);
	check_dec(False, status, "XtCvtIntToFloat return value");
	tet_infoline("TEST: to_size");
	if (toVal.size != sizeof(float)) {
		sprintf(ebuf, "ERROR: to_size not set correctly, expected %d, received %d", sizeof(float), toVal.size);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
>>ASSERTION Good C
If the implementation is X11R5 or later:
A successful call to 
Boolean XtCvtIntToFloat(display, args, num_args, from, to, converter_data)
when 
.A to->addr 
is NULL shall convert the XtRInt value specified in
.A from
to an XtRFloat type, allocate space for the converted data,
set
.A to->addr 
to specify the location of the data,
set
.A to->size
to the size of the coverted data, and return True.
>>CODE
#if XT_X_RELEASE > 4
/* Conversion arguments and results */
Boolean status;
Display *display;
XrmValue args[2];
Cardinal num_args;
XrmValue fromVal;
XrmValue toVal;
XtPointer *closure_ret = (XtPointer *) 0;
/* Int to float specific */
int num = 1;
pid_t pid2;
#endif

#if XT_X_RELEASE > 4
	FORK(pid2);
	avs_xt_hier("Tcinboln2", "XtCvtIntToFloat");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get display");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Set up required conversion args");
	num_args = 0;
	tet_infoline("TEST: Conversion succeeds");
	fromVal.addr = (XtPointer) &num;
	fromVal.size = sizeof(int);
	toVal.addr = (XtPointer)0;
	toVal.size = 0;
	status = XtCvtIntToFloat(display,
			&args[0],
			&num_args,
			&fromVal,
			&toVal,
			closure_ret);
	check_dec(True, status, "XtCvtIntToFloat return value");
	tet_infoline("TEST: to->addr and to->size are set");
	if (!toVal.addr) {
		sprintf(ebuf, "ERROR: to->addr was not set");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	if (toVal.size != sizeof(float)) {
		sprintf(ebuf, "ERROR: to_size not set correctly, expected %d, received %d", sizeof(float), toVal.size);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
