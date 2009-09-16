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
>># File: xts/Xt11/XtCvtStringToFontSet/XtCvtStringToFontSet.m
>># 
>># Description:
>>#	Tests for XtCvtStringToFontSet()
>># 
>># Modifications:
>># $Log: tcstfset.m,v $
>># Revision 1.1  2005-02-12 14:37:53  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:37:31  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:00:28  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:28:35  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.1  1998/02/03 22:17:55  andy
>># Added warning handler install to test 2 (SR 160).
>>#
>># Revision 5.0  1998/01/26 03:25:10  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:19:42  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:14:28  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>
#include <locale.h>

void XtWMH_Proc(str1, str2, str3, str4, str5, car)
String str1, str2, str3, str4, *str5;
Cardinal *car;
{
	avs_set_event(1,1);
}

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;

>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtCvtStringToFontSet Xt11
Boolean
XtCvtStringToFontSet(display, args, num_args, from, to, converter_data)
>>ASSERTION Good C
If the implementation is X11R5 or later:
A successful call to
Boolean XtCvtStringToFontSet(display, args, num_args, from, to, converter_data)
when 
.A to->addr 
is not NULL and 
.A to->size 
is large enough to store
an XtRFontSet type shall convert the string specified in 
.A from
to an XtRFontSet type, store it at the location specified by
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
/* String to FontSet specific */
char *locale;
char *fontName = "fixed";
XFontSet fontset;
pid_t pid2;
#endif

#if XT_X_RELEASE > 4
	FORK(pid2);
	avs_xt_hier("Tcstfset1", "XtCvtStringToFontSet");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get display");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Set up required conversion args");
	args[0].addr = (XtPointer )&display;
	args[0].size = sizeof(Display*);
	locale = (char *)setlocale(LC_ALL, "C");
	args[1].addr = (XtPointer )&locale;
	args[1].size = sizeof(char*);
	num_args = 2;
	tet_infoline("TEST: Check conversion succeeds");
	fromVal.addr = ximconfig.fontsets;
	fromVal.size = strlen(ximconfig.fontsets)+1;
	toVal.addr = (XtPointer) &fontset;
	toVal.size = sizeof(XFontSet);
	status = XtCvtStringToFontSet(display,
			&args[0],
			&num_args,
			&fromVal,
			&toVal,
			closure_ret);
	check_dec(True, status, "XtCvtStringToFontSet return value");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
>>ASSERTION Good C
If the implementation is X11R5 or later:
A call to 
Boolean XtCvtStringToFontSet(display, args, num_args, from, to, converter_data)
when 
.A to->addr 
is not NULL and 
.A to->size 
is too small for an
XtRFontSet type shall not perform a
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
/* String to FontSet specific */
char *locale;
char *fontName = "fixed";
XFontSet fontset;
pid_t pid2;
#endif

#if XT_X_RELEASE > 4
	FORK(pid2);
	avs_xt_hier("Tcstfset2", "XtCvtStringToFontSet");
	XtAppSetWarningMsgHandler(app_ctext, XtWMH_Proc);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get display");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Set up required conversion args");
	args[0].addr = (XtPointer )&display;
	args[0].size = sizeof(Display*);
	locale = (char *)setlocale(LC_ALL, "C");
	args[1].addr = (XtPointer )&locale;
	args[1].size = sizeof(char*);
	num_args = 2;
	tet_infoline("TEST: Check conversion fails");
	fromVal.addr = ximconfig.fontsets;
	fromVal.size = strlen(ximconfig.fontsets)+1;
	toVal.addr = (XtPointer) &fontset;
	toVal.size = 0;
	status = XtCvtStringToFontSet(display,
			&args[0],
			&num_args,
			&fromVal,
			&toVal,
			closure_ret);
	check_dec(False, status, "XtCvtStringToFontSet return value");
	tet_infoline("TEST: to_size");
	if (toVal.size != sizeof(XFontSet)) {
		sprintf(ebuf, "ERROR: to_size not set correctly, expected %d, received %d", sizeof(XFontSet), toVal.size);
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
Boolean XtCvtStringToFontSet(display, args, num_args, from, to, converter_data)
when 
.A to->addr 
is NULL shall convert the string specified in
.A from
to an XtRFontSet type, allocate space for the converted data,
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
/* String to FontSet specific */
char *locale;
char *fontName = "fixed";
pid_t pid2;
#endif

#if XT_X_RELEASE > 4
	FORK(pid2);
	avs_xt_hier("Tcstfset3", "XtCvtStringToFontSet");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get display");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Set up required conversion args");
	args[0].addr = (XtPointer )&display;
	args[0].size = sizeof(Display*);
	locale = (char *)setlocale(LC_ALL, "C");
	args[1].addr = (XtPointer )&locale;
	args[1].size = sizeof(char*);
	num_args = 2;
	tet_infoline("TEST: Check conversion succeeds");
	fromVal.addr = ximconfig.fontsets;
	fromVal.size = strlen(ximconfig.fontsets)+1;
	toVal.addr = (XtPointer)0;
	toVal.size = 0;
	status = XtCvtStringToFontSet(display,
			&args[0],
			&num_args,
			&fromVal,
			&toVal,
			closure_ret);
	check_dec(True, status, "XtCvtStringToFontSet return value");
	tet_infoline("TEST: to->addr and to->size are set");
	if (!toVal.addr) {
		sprintf(ebuf, "ERROR: to->addr was not set");
	tet_infoline(ebuf);
	tet_result(TET_FAIL);
	}
	if (toVal.size != sizeof(XFontSet)) {
		sprintf(ebuf, "ERROR: to_size not set correctly, expected %d, received %d", sizeof(XFontSet), toVal.size);
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
A call to
Boolean XtCvtStringToFontSet(display, args, num_args, from, to, converter_data)
when 
.A args 
specifies an improper value shall not perform a conversion,
issue a warning message, and return False.
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
/* String to FontSet specific */
char *locale;
char *fontName = "fixed";
pid_t pid2;
#endif

#if XT_X_RELEASE > 4
	FORK(pid2);
	avs_xt_hier("Tcstfset4", "XtCvtStringToFontSet");
	avs_set_event(1,0);
	XtAppSetWarningMsgHandler(app_ctext, XtWMH_Proc);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get display");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Set up required conversion args incorrectly");
	num_args = 0;
	tet_infoline("TEST: Check conversion fails");
	fromVal.addr = ximconfig.fontsets;
	fromVal.size = strlen(ximconfig.fontsets)+1;
	toVal.addr = (XtPointer)0;
	toVal.size = 0;
	status = XtCvtStringToFontSet(display,
			&args[0],
			&num_args,
			&fromVal,
			&toVal,
			closure_ret);
	check_dec(False, status, "conversion status");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Warning handler is called");
	status = avs_get_event(1);
	check_dec(1, status, "calls to warning handler count");
	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
>>ASSERTION Good B 0
If the implementation is X11R5 or later:
On a successful call to
Boolean XtCvtStringToFontSet(display, args, num_args, from, to, converter_data)
when 
.A from
specifies the constant XtDefaultFontSet and the application resource
database contains the resource name "xtDefaultFontSet", class 
"XtDefaultFontSet" the converted value shall specify this 
resource value.
>>ASSERTION Good D 2
If the implementation is X11R5 or later:
On a successful call to
Boolean XtCvtStringToFontSet(display, args, num_args, from, to, converter_data)
when 
.A from
specifies the constant XtDefaultFontSet and the application resource
database does not contain the resource name "xtDefaultFontSet", class 
"XtDefaultFontSet" the converted data shall specify an 
implementation-defined font set.
>>ASSERTION Good D 2
If the implementation is X11R5 or later:
On a successful call to
Boolean XtCvtStringToFontSet(display, args, num_args, from, to, converter_data)
when 
.A from
specifies the constant XtDefaultFontSet, the application resource
database contains the resource name "xtDefaultFontSet", class 
"XtDefaultFontSet", and a font set could not be created from the base
font name list specified by this resource the converted data shall 
specify an implementation-defined font set.
>>ASSERTION Good D 2
If the implementation is X11R5 or later:
On a call to
Boolean XtCvtStringToFontSet(display, args, num_args, from, to, converter_data)
when 
.A from
specifies the constant XtDefaultFontSet, the application resource
database contains the resource name "xtDefaultFontSet", class 
"XtDefaultFontSet", a font set cannot be created from the base font
name list specified by this resource, and an implementation-defined 
font set could not be created it shall issue a warning message and 
return False.
>>ASSERTION Good D 2
If the implementation is X11R5 or later:
A call to
Boolean XtCvtStringToFontSet(display, args, num_args, from, to, converter_data)
when 
.A from
specifies the constant XtDefaultFontSet and a font set could 
be created that has missing character sets shall return the 
partial font set in and issue a warning message.
>>ASSERTION Good B 0
If the implementation is X11R5 or later:
On a call to
Boolean XtCvtStringToFontSet(display, args, num_args, from, to, converter_data)
the resource type conversion performed shall be locale specific.
>>ASSERTION Good C
If the implementation is X11R5 or later:
A call to
Boolean XtCvtStringToFontSet(display, args, num_args, from, to, converter_data)
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
/* String to FontSet specific */
char *locale;
char *fontName = "-1";
XFontSet fontset;
pid_t pid2;
#endif

#if XT_X_RELEASE > 4
	FORK(pid2);
	avs_set_event(1, 0);
	avs_xt_hier("Tcstfset5", "XtCvtStringToFontSet");
	XtAppSetWarningMsgHandler(app_ctext, XtWMH_Proc);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get display");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Set up required conversion args");
	args[0].addr = (XtPointer )&display;
	args[0].size = sizeof(Display*);
	locale = (char *)setlocale(LC_ALL, "C");
	args[1].addr = (XtPointer )&locale;
	args[1].size = sizeof(char*);
	num_args = 2;
	tet_infoline("TEST: Check conversion fails");
	fromVal.addr = fontName;
	fromVal.size = strlen(fontName)+1;
	toVal.addr = (XtPointer) &fontset;
	toVal.size = sizeof(XFontSet);
	status = XtCvtStringToFontSet(display,
			&args[0],
			&num_args,
			&fromVal,
			&toVal,
			closure_ret);
	check_dec(False, status, "XtCvtStringToFontSet return value");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Warning handler is called");
	status = avs_get_event(1);
	check_dec(1, status, "calls to warning handler count");
	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
