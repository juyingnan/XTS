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
$Header: /cvs/xtest/xtest/xts5/tset/Xt11/XtDisplayStringConversionWarning/XtDisplayStringConversionWarning.m,v 1.1 2005-02-12 14:37:53 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt11/XtDisplayStringConversionWarning/XtDisplayStringConversionWarning.m
>># 
>># Description:
>>#	Tests for XtDisplayStringConversionWarning()
>># 
>># Modifications:
>># $Log: tdisplscw.m,v $
>># Revision 1.1  2005-02-12 14:37:53  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:37:45  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:00:41  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:28:48  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:25:22  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:20:18  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:15:15  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;
#ifndef XavsRChar
#define XavsRChar "Char"
#endif

void XTWHMProc(name, type, class, defaultp, params, num_params)
String name;
String type;
String class;
String defaultp ;
String *params ;
Cardinal *num_params ;
{
String par[10];
int i;
char buffer[1000];

	avs_set_event(1,1);
	tet_infoline("TEST: Warning message contents");
	XtGetErrorDatabaseText(name, type, class, defaultp, buffer, 1000);
	if (params == NULL || num_params == NULL || *num_params == 0) {
		sprintf(ebuf, "%s", buffer);
	}
	else {
		i = *num_params;
		if (i > 10)
			i = 10;
		memcpy((char *)par, (char *)params, i*sizeof(String));
		memset(&par[i], 0, (10-i)*sizeof(String));
		sprintf(ebuf, buffer, par[0], par[1], par[2], par[3], par[4], par[5], par[6], par[7], par[8],par[9]);
	}
	check_str(ebuf, "Cannot convert string \"String\" to type Int", "Warning message");
}
void XTEHMProc(name, type, class, defaultp, params, num_params)
String name;
String type;
String class;
String defaultp ;
String *params ;
Cardinal *num_params ;
{
String par[10];
int i;
char buffer[1000];

	avs_set_event(2,1);
	tet_infoline("TEST: Warning message contents");
	XtGetErrorDatabaseText(name, type, class, defaultp, buffer, 1000);
	if (params == NULL || num_params == NULL || *num_params == 0) {
		sprintf(ebuf, "%s", buffer);
	}
	else {
		i = *num_params;
		if (i > 10)
			i = 10;
		memcpy((char *)par, (char *)params, i*sizeof(String));
		memset(&par[i], 0, (10-i)*sizeof(String));
		sprintf(ebuf, buffer, par[0], par[1], par[2], par[3], par[4], par[5], par[6], par[7], par[8],par[9]);
	}
	check_str(ebuf, "Cannot convert string \"Not a real type\" to type Int", "Warning message");
}


Boolean XtCVT_StringToChar(display, args, num_args, from_val, to_val, convertor_data)
Display *display;
XrmValue *args;
Cardinal *num_args;
XrmValue *from_val;
XrmValue *to_val;
XtPointer *convertor_data;
{
	char *str = (char *) (from_val->addr);
	static unsigned char i;
	to_val->size = sizeof (unsigned char);
	to_val->addr = (XtPointer) &i;
	i = *str;
	/*
	** Force a warning message
	*/
	XtDisplayStringConversionWarning(display, "String", "Int");
}

Boolean XtCVT_StringToChar2(display, args, num_args, from_val, to_val, convertor_data)
Display *display;
XrmValue *args;
Cardinal *num_args;
XrmValue *from_val;
XrmValue *to_val;
XtPointer *convertor_data;
{
	char *str = (char *) (from_val->addr);
	static unsigned char i;
	to_val->size = sizeof (unsigned char);
	to_val->addr = (XtPointer) &i;
	i = *str;
	/*
	** Force an error message
	*/
	XtDisplayStringConversionWarning(display, "Not a real type", "Int");
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtDisplayStringConversionWarning Xt11
void
XtDisplayStringConversionWarning(display, from_value, to_type );
>>ASSERTION Good A
A call to
void XtDisplayStringConversionWarning(display, from_value, to_type)
when an entry exists in the error database for the error name 
.S conversionError,
type
.S string,
and class
.S XtToolkitError
shall display the error message text associated with that entry.
>>CODE
Display *display_good;
XrmValue from;
XrmValue to_in_out;
XtCacheRef cache_ref_return;
int invoked = 0;
char line[80], buf[80];
FILE *stream;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tdisplscw1", "XtDisplayStringConversionWarning");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Catch warning messages");
	XtAppSetWarningMsgHandler(app_ctext, XTWHMProc);
	tet_infoline("PREP: Register resource converter XtCVT_StringToChar");
	XtAppSetTypeConverter(app_ctext,
		 XtRString,
		 XavsRChar,
		 XtCVT_StringToChar,
		 (XtConvertArgList)NULL,
		 (Cardinal)0,
		 XtCacheAll,
		 (XtDestructor)NULL);
	tet_infoline("PREP: Invoke resource converter XtCVT_StringToChar");
	display_good = XtDisplay(topLevel);
	from.addr = (XtPointer) "Hello";
	from.size = sizeof(unsigned char);
	XtCallConverter(display_good,
		XtCVT_StringToChar,
		(XrmValuePtr)NULL,
		(Cardinal)0,
		&from,
		&to_in_out,
		&cache_ref_return
		);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Warning handler was invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "Warning handler invocations count");
	tet_result(TET_PASS);
>>ASSERTION Good A
On a call to
void XtDisplayStringConversionWarning(display, from_value, to_type)
when an entry does not exist in the error database for the error name 
.S conversionError,
type
.S string,
and class
.S XtToolkitError
it shall display the error message: "Cannot convert
.A from_value
to type
.A to_type".
>>CODE
Display *display_good;
XrmValue from;
XrmValue to_in_out;
XtCacheRef cache_ref_return;
int invoked = 0;
char line[80], buf[80];
FILE *stream;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tdisplscw1", "XtDisplayStringConversionWarning");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Catch warning messages");
	XtAppSetWarningMsgHandler(app_ctext, XTEHMProc);
	tet_infoline("PREP: Register resource converter XtCVT_StringToChar2");
	XtAppSetTypeConverter(app_ctext,
		 XtRString,
		 XavsRChar,
		 XtCVT_StringToChar2,
		 (XtConvertArgList)NULL,
		 (Cardinal)0,
		 XtCacheAll,
		 (XtDestructor)NULL);
	tet_infoline("PREP: Invoke resource converter XtCVT_StringToChar2");
	display_good = XtDisplay(topLevel);
	from.addr = (XtPointer) "Hello";
	from.size = sizeof(unsigned char);
	XtCallConverter(display_good,
		XtCVT_StringToChar2,
		(XrmValuePtr)NULL,
		(Cardinal)0,
		&from,
		&to_in_out,
		&cache_ref_return
		);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Warning handler was invoked");
	invoked = avs_get_event(2);
	check_dec(1, invoked, "Warning handler invocations count");
	tet_result(TET_PASS);
