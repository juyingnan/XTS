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
>># File: xts/Xt11/XtCvtStringToInitialState.m
>># 
>># Description:
>>#	Tests for XtCvtStringToInitialState()
>># 
>># Modifications:
>># $Log: tcstinit.m,v $
>># Revision 1.1  2005-02-12 14:37:53  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:37:32  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:00:29  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:28:36  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.1  1998/02/03 22:18:00  andy
>># Added warning handler install to test 2 (SR 160).
>>#
>># Revision 5.0  1998/01/26 03:25:11  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:19:46  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:14:32  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;

void XtWMH_Proc(str1, str2, str3, str4, str5, car)
String str1, str2, str3, str4, *str5;
Cardinal *car;
{
	avs_set_event(1,1);
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtCvtStringToInitialState Xt11
Boolean
XtCvtStringToInitialState(display, args, num_args, from, to, converter_data)
>>ASSERTION Good C
If the implementation is X11R5 or later:
A successful call to
Boolean XtCvtStringToInitialState(display, args, num_args, from, to, converter_data)
when 
.A to->addr 
is not NULL and 
.A to->size 
is large enough to store
an XtRInitialState type shall convert the string specified in 
.A from
to an XtRInitialState type, store it at the location specified by
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
/* String to InitialState specific */
char *statestr = "IconicState";
int initstate;
pid_t pid2;
#endif

#if XT_X_RELEASE > 4
	FORK(pid2);
	avs_xt_hier("Tcstinit1", "XtCvtStringToInitialState");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get display");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Set up required conversion args");
	num_args = 0;
	tet_infoline("TEST: Check conversion succeeds");
	fromVal.addr = statestr;
	fromVal.size = strlen(statestr)+1;
	toVal.addr = (XtPointer) &initstate;
	toVal.size = sizeof(int);
	status = XtCvtStringToInitialState(display,
			&args[0],
			&num_args,
			&fromVal,
			&toVal,
			closure_ret);
	check_dec(True, status, "XtCvtStringToInitialState return value");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
>>ASSERTION Good C
If the implementation is X11R5 or later:
A call to 
Boolean XtCvtStringToInitialState(display, args, num_args, from, to, converter_data)
when 
.A to->addr 
is not NULL and 
.A to->size 
is too small for an
XtRInitialState type shall not perform a
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
/* String to InitialState specific */
char *statestr = "NormalState";
int initstate;
pid_t pid2;
#endif

#if XT_X_RELEASE > 4
	FORK(pid2);
	avs_xt_hier("Tcstinit2", "XtCvtStringToInitialState");
	XtAppSetWarningMsgHandler(app_ctext, XtWMH_Proc);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get display");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Set up required conversion args");
	num_args = 0;
	tet_infoline("TEST: Check conversion fails");
	fromVal.addr = statestr;
	fromVal.size = strlen(statestr)+1;
	toVal.addr = (XtPointer) &initstate;
	toVal.size = 0;
	status = XtCvtStringToInitialState(display,
			&args[0],
			&num_args,
			&fromVal,
			&toVal,
			closure_ret);
	check_dec(False, status, "XtCvtStringToInitialState return value");
	tet_infoline("TEST: to_size");
	if (toVal.size == 0) {
		tet_infoline("ERROR: toVal.size not set");
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
Boolean XtCvtStringToInitialState(display, args, num_args, from, to, converter_data)
when 
.A to->addr 
is NULL shall convert the string specified in
.A from
to an XtRInitialState type, allocate space for the converted data,
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
/* String to InitialState specific */
char *statestr = "NormalState";
pid_t pid2;
#endif

#if XT_X_RELEASE > 4
	FORK(pid2);
	avs_xt_hier("Tcstinit3", "XtCvtStringToInitialState");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get display");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Set up required conversion args");
	num_args = 0;
	tet_infoline("TEST: Check conversion succeeds");
	fromVal.addr = statestr;
	fromVal.size = strlen(statestr)+1;
	toVal.addr = (XtPointer)0;
	toVal.size = 0;
	status = XtCvtStringToInitialState(display,
			&args[0],
			&num_args,
			&fromVal,
			&toVal,
			closure_ret);
	tet_infoline("TEST: Check return status is True");
	check_dec(True, status, "XtCvtStringToInitialState return value");
	tet_infoline("TEST: to->addr and to->size are set");
	if (!toVal.addr) {
		sprintf(ebuf, "ERROR: to->addr was not set");
	tet_infoline(ebuf);
	tet_result(TET_FAIL);
	}
	if (!toVal.size) {
		sprintf(ebuf, "ERROR: to->size was not set");
	tet_infoline(ebuf);
	tet_result(TET_FAIL);
	}
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
>>ASSERTION Good A
If the implementation is X11R5 or later:
A call to
Boolean XtCvtStringToInitialState(display, args, num_args, from, to, converter_data)
when the conversion is not performed due to an improper value 
specified in
.A from
shall issue a warning message and return False.
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
/* String to InitialState specific */
char *statestr = "This should not be valid as a state";
int initstate;
pid_t pid2;
#endif

#if XT_X_RELEASE > 4
	FORK(pid2);
	avs_set_event(1, 0);
	avs_xt_hier("Tcstinit4", "XtCvtStringToInitialState");
	XtAppSetWarningMsgHandler(app_ctext, XtWMH_Proc);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get display");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Set up required conversion args");
	num_args = 0;
	tet_infoline("TEST: Check conversion fails");
	fromVal.addr = statestr;
	fromVal.size = strlen(statestr)+1;
	toVal.addr = (XtPointer) &initstate;
	toVal.size = sizeof(int);
	status = XtCvtStringToInitialState(display,
			&args[0],
			&num_args,
			&fromVal,
			&toVal,
			closure_ret);
	check_dec(False, status, "XtCvtStringToInitialState return value");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Warning handler is called");
	status = avs_get_event(1);
	check_dec(1, status, "calls to warning handler count");
	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
>>ASSERTION Good A
If the implementation is X11R5 or later:
A call to
Boolean XtCvtStringToInitialState(display, args, num_args, from, to, converter_data)
when
.A from
specifies the string NormalState shall convert it to an XtRInitialState
value as specified by the X Window System File Formats and Application
Conventions specification.
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
/* String to InitialState specific */
char *statestr = "NormalState";
int initstate;
pid_t pid2;
#endif

#if XT_X_RELEASE > 4
	FORK(pid2);
	avs_xt_hier("Tcstinit5", "XtCvtStringToInitialState");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get display");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Set up required conversion args");
	num_args = 0;
	tet_infoline("TEST: Check conversion succeeds");
	fromVal.addr = statestr;
	fromVal.size = strlen(statestr)+1;
	toVal.addr = (XtPointer) &initstate;
	toVal.size = sizeof(int);
	status = XtCvtStringToInitialState(display,
			&args[0],
			&num_args,
			&fromVal,
			&toVal,
			closure_ret);
	check_dec(True, status, "XtCvtStringToInitialState return value");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
>>ASSERTION Good A
If the implementation is X11R5 or later:
A call to
Boolean XtCvtStringToInitialState(display, args, num_args, from, to, converter_data)
when
.A from
specifies the string IconicState shall convert it to an XtRInitialState
value as specified by the X Window System File Formats and Application
Conventions specification.
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
/* String to InitialState specific */
char *statestr = "IconicState";
int initstate;
pid_t pid2;
#endif

#if XT_X_RELEASE > 4
	FORK(pid2);
	avs_xt_hier("Tcstinit1", "XtCvtStringToInitialState");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get display");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Set up required conversion args");
	num_args = 0;
	tet_infoline("TEST: Check conversion succeeds");
	fromVal.addr = statestr;
	fromVal.size = strlen(statestr)+1;
	toVal.addr = (XtPointer) &initstate;
	toVal.size = sizeof(int);
	status = XtCvtStringToInitialState(display,
			&args[0],
			&num_args,
			&fromVal,
			&toVal,
			closure_ret);
	check_dec(True, status, "XtCvtStringToInitialState return value");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
