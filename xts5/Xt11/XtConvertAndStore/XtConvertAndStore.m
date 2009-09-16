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
$Header: /cvs/xtest/xtest/xts5/tset/Xt11/XtConvertAndStore/XtConvertAndStore.m,v 1.1 2005-02-12 14:37:51 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt11/XtConvertAndStore/XtConvertAndStore.m
>># 
>># Description:
>>#	Tests for XtConvertAndStore()
>># 
>># Modifications:
>># $Log: tcnvrtast.m,v $
>># Revision 1.1  2005-02-12 14:37:51  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:37:49  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:00:46  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:28:52  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:25:26  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:20:32  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:15:33  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;

unsigned char tchar[2] = {0,0};

#ifndef XavsRChar
#define XavsRChar "Char"
#endif
Boolean XtCVT_StringToChar(display, args, num_args, from_val, to_val, converter_data)
Display *display;
XrmValuePtr args;
Cardinal *num_args;
XrmValue *from_val;
XrmValue *to_val;
XtPointer *converter_data;
{
	char *str = (char *) (from_val->addr);
	static unsigned char i;
	to_val->size = sizeof (unsigned char);
	to_val->addr = (XtPointer) &i;
	i = *str;
	avs_set_event(1, avs_get_event(1)+1);
	return True;
}
Boolean XtCVT2_StringToChar(display, args, num_args, from_val, to_val, converter_data)
Display *display;
XrmValuePtr args;
Cardinal *num_args;
XrmValue *from_val;
XrmValue *to_val;
XtPointer *converter_data;
{
	avs_set_event(1, avs_get_event(1)+1);
	return False;
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtConvertAndStore Xt11
Boolean
XtConvertAndStore(object, from_type, from, to_type, to_in_out )
>>ASSERTION Good A
When a converter has been registered for a conversion from
.A from_type
to
.A to_type
for the application context associated with
.A object
with the conversion cache type specified as XtCacheNone 
a successful call to
Boolean XtConvertAndStore(object, from_type, from, to_type, to_in_out)
shall compute the additional arguments needed, call the converter, 
store the converted value returned into the location specified by
to_in_out->addr, and return True.
>>CODE
Display *display_good;
XrmValue from;
XrmValue to_in_out;
XtCacheRef cache_ref_return;
int invoked = 0;
int status;
pid_t pid2;

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tcnvrtast1", "XtConvertAndStore");
	(void) ConfigureDimension(topLevel, boxw2);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Register resource converter XtCVT_StringToChar");
	XtAppSetTypeConverter(app_ctext,
		 XtRString,
		 XavsRChar,
		 XtCVT_StringToChar,
		 (XtConvertArgList)NULL,
		 (Cardinal)0,
		 XtCacheNone,
		 (XtDestructor)NULL);
	tet_infoline("TEST: Call XtConvertAnd Store to invoke resource converter");
	from.addr = (XtPointer) "Hello";
	from.size = sizeof(unsigned char);
	to_in_out.addr = (XtPointer) tchar;
	to_in_out.size = sizeof(unsigned char);
	status = XtConvertAndStore(topLevel,
		 XtRString,
		 &from,
		 XavsRChar,
		 &to_in_out
		 );
	tet_infoline("TEST: Return status");
	check_dec(True, status, "return value");
	tet_infoline("TEST: XtCVT_StringToChar was invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtCVT_StringToChar invoked status");
	tet_infoline("TEST: Result returned");
	check_char('H', *(char *)to_in_out.addr, "conversion result");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When a converter has been registered for a conversion from
.A from_type
to
.A to_type
for the application context associated with
.A object
with the conversion cache type specified as XtCacheNone 
a call to
Boolean XtConvertAndStore(object, from_type, from, to_type, to_in_out)
shall not reuse the results of a previous conversion.
>>CODE
Display *display_good;
XrmValue from;
XrmValue to_in_out;
XtCacheRef cache_ref_return;
int invoked = 0;
int status;
pid_t pid2;

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tcnvrtast1", "XtConvertAndStore");
	(void) ConfigureDimension(topLevel, boxw2);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Register resource converter XtCVT_StringToChar");
	XtAppSetTypeConverter(app_ctext,
		 XtRString,
		 XavsRChar,
		 XtCVT_StringToChar,
		 (XtConvertArgList)NULL,
		 (Cardinal)0,
		 XtCacheNone,
		 (XtDestructor)NULL);
	tet_infoline("TEST: Call XtConvertAnd Store to invoke resource converter");
	from.addr = (XtPointer) "Hello";
	from.size = sizeof(unsigned char);
	to_in_out.addr = (XtPointer) tchar;
	to_in_out.size = sizeof(unsigned char);
	status = XtConvertAndStore(topLevel,
		 XtRString,
		 &from,
		 XavsRChar,
		 &to_in_out
		 );
	tet_infoline("TEST: Return status");
	check_dec(True, status, "return value");
	tet_infoline("TEST: XtCVT_StringToChar was invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtCVT_StringToChar invoked status");
	tet_infoline("TEST: Result returned");
	check_char('H', *(char *)to_in_out.addr, "conversion result");
	tet_infoline("TEST: Call XtConvertAnd Store again");
	from.addr = (XtPointer) "Hello";
	from.size = sizeof(unsigned char);
	to_in_out.addr = (XtPointer) tchar;
	to_in_out.size = sizeof(unsigned char);
	status = XtConvertAndStore(topLevel,
		 XtRString,
		 &from,
		 XavsRChar,
		 &to_in_out
		 );
	tet_infoline("TEST: Return status");
	check_dec(True, status, "return value");
	tet_infoline("TEST: XtCVT_StringToChar was invoked again");
	invoked = avs_get_event(1);
	check_dec(2, invoked, "XtCVT_StringToChar invocation count");
	tet_infoline("TEST: Result returned");
	check_char('H', *(char *)to_in_out.addr, "conversion result");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When a converter has been registered for a conversion from
.A from_type
to
.A to_type
for the application context associated with
.A object
with the conversion cache type specified as XtCacheNone 
a call to
Boolean XtConvertAndStore(object, from_type, from, to_type, to_in_out)
shall return False if the conversion fails.
>>CODE
Display *display_good;
XrmValue from;
XrmValue to_in_out;
XtCacheRef cache_ref_return;
int invoked = 0;
int status;
pid_t pid2;

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tcnvrtast2", "XtConvertAndStore");
	(void) ConfigureDimension(topLevel, boxw2);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Register resource converter XtCVT2_StringToChar");
	XtAppSetTypeConverter(app_ctext,
		 XtRString,
		 XavsRChar,
		 XtCVT2_StringToChar,
		 (XtConvertArgList)NULL,
		 (Cardinal)0,
		 XtCacheNone,
		 (XtDestructor)NULL);
	tet_infoline("TEST: Call XtConvertAnd Store to invoke resource converter");
	from.addr = (XtPointer) "Hello";
	from.size = sizeof(unsigned char);
	status = XtConvertAndStore(topLevel,
		 XtRString,
		 &from,
		 XavsRChar,
		 &to_in_out
		 );
	tet_infoline("TEST: Return status");
	check_dec(False, status, "return value");
	tet_infoline("TEST: XtCVT2_StringToChar was invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtCVT_StringToChar invocation count");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When a converter has been registered for a conversion from
.A from_type
to
.A to_type
for the application context associated with
.A object
with conversion cache type specified as XtCacheAll and the converter has 
not been previously called with the specified arguments a call to
Boolean XtConvertAndStore(object, from_type, from, to_type, to_in_out)
shall compute the additional arguments needed, call the converter, enter 
the result into the conversion cache, store the converted value into
the location specified by to_in_out->addr, and return True.
>>CODE
Display *display_good;
XrmValue from;
XrmValue to_in_out;
XtCacheRef cache_ref_return;
int invoked = 0;
int status;
pid_t pid2;

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tcnvrtast1", "XtConvertAndStore");
	(void) ConfigureDimension(topLevel, boxw2);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Register resource converter XtCVT_StringToChar");
	XtAppSetTypeConverter(app_ctext,
		 XtRString,
		 XavsRChar,
		 XtCVT_StringToChar,
		 (XtConvertArgList)NULL,
		 (Cardinal)0,
		 XtCacheAll,
		 (XtDestructor)NULL);
	tet_infoline("TEST: Call XtConvertAnd Store to invoke resource converter");
	from.addr = (XtPointer) "Hello";
	from.size = sizeof(unsigned char);
	to_in_out.addr = (XtPointer) tchar;
	to_in_out.size = sizeof(unsigned char);
	status = XtConvertAndStore(topLevel,
		 XtRString,
		 &from,
		 XavsRChar,
		 &to_in_out
		 );
	tet_infoline("TEST: Return status");
	check_dec(True, status, "return value");
	tet_infoline("TEST: XtCVT_StringToChar was invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtCVT_StringToChar invoked status");
	tet_infoline("TEST: Result returned");
	check_char('H', *(char *)to_in_out.addr, "conversion result");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When a converter has been registered for a conversion from
.A from_type
to
.A to_type
for the application context associated with
.A object
with conversion cache type specified as XtCacheAll and the converter has 
been previously called with the specified arguments a call to
Boolean XtConvertAndStore(object, from_type, from, to_type, to_in_out)
shall reuse the results of the previous conversion.
>>CODE
Display *display_good;
XrmValue from;
XrmValue to_in_out;
XtCacheRef cache_ref_return;
int invoked = 0;
int status;
pid_t pid2;

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tcnvrtast1", "XtConvertAndStore");
	(void) ConfigureDimension(topLevel, boxw2);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Register resource converter XtCVT_StringToChar");
	XtAppSetTypeConverter(app_ctext,
		 XtRString,
		 XavsRChar,
		 XtCVT_StringToChar,
		 (XtConvertArgList)NULL,
		 (Cardinal)0,
		 XtCacheAll,
		 (XtDestructor)NULL);
	tet_infoline("TEST: Call XtConvertAnd Store to invoke resource converter");
	from.addr = (XtPointer) "Hello";
	from.size = sizeof(unsigned char);
	to_in_out.addr = (XtPointer) tchar;
	to_in_out.size = sizeof(unsigned char);
	status = XtConvertAndStore(topLevel,
		 XtRString,
		 &from,
		 XavsRChar,
		 &to_in_out
		 );
	tet_infoline("TEST: Return status");
	check_dec(True, status, "return value");
	tet_infoline("TEST: XtCVT_StringToChar was invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtCVT_StringToChar invoked status");
	tet_infoline("TEST: Result returned");
	check_char('H', *(char *)to_in_out.addr, "conversion result");
	tet_infoline("TEST: Invoke resource converter again");
	from.addr = (XtPointer) "Hello";
	from.size = sizeof(unsigned char);
	to_in_out.addr = (XtPointer) tchar;
	to_in_out.size = sizeof(unsigned char);
	status = XtConvertAndStore(topLevel,
		 XtRString,
		 &from,
		 XavsRChar,
		 &to_in_out
		 );
	tet_infoline("TEST: Return status");
	check_dec(True, status, "return value");
	tet_infoline("TEST: XtCVT_StringToChar was not invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtCVT_StringToChar invoked status");
	tet_infoline("TEST: Result returned");
	check_char('H', *(char *)to_in_out.addr, "conversion result");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When a converter has been registered for a conversion from
.A from_type
to
.A to_type
for the application context associated with
.A object
with conversion cache type specified as XtCacheAll and the converter has 
not been previously called with the specified arguments a call to
Boolean XtConvertAndStore(object, from_type, from, to_type, to_in_out)
shall return False if the conversion fails.
>>CODE
Display *display_good;
XrmValue from;
XrmValue to_in_out;
XtCacheRef cache_ref_return;
int invoked = 0;
int status;
pid_t pid2;

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tcnvrtast2", "XtConvertAndStore");
	(void) ConfigureDimension(topLevel, boxw2);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Register resource converter XtCVT2_StringToChar");
	XtAppSetTypeConverter(app_ctext,
		 XtRString,
		 XavsRChar,
		 XtCVT2_StringToChar,
		 (XtConvertArgList)NULL,
		 (Cardinal)0,
		 XtCacheAll|XtCacheRefCount,
		 (XtDestructor)NULL);
	tet_infoline("TEST: Call XtConvertAnd Store to invoke resource converter");
	from.addr = (XtPointer) "Hello";
	from.size = sizeof(unsigned char);
	status = XtConvertAndStore(topLevel,
		 XtRString,
		 &from,
		 XavsRChar,
		 &to_in_out
		 );
	tet_infoline("TEST: Return status");
	check_dec(False, status, "return value");
	tet_infoline("TEST: XtCVT2_StringToChar was invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtCVT_StringToChar invocation count");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When a converter has been registered for a conversion from
.A from_type
to
.A to_type
for the application context associated with
.A object
with conversion cache type specified as XtCacheAll, the converter has 
been previously called with the specified arguments, and the conversion
failed a call to
Boolean XtConvertAndStore(object, from_type, from, to_type, to_in_out)
shall not perform the conversion and shall return False.
>>CODE
Display *display_good;
XrmValue from;
XrmValue to_in_out;
XtCacheRef cache_ref_return;
int invoked = 0;
int status;
pid_t pid2;

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tcnvrtast2", "XtConvertAndStore");
	(void) ConfigureDimension(topLevel, boxw2);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Register resource converter XtCVT2_StringToChar");
	XtAppSetTypeConverter(app_ctext,
		 XtRString,
		 XavsRChar,
		 XtCVT2_StringToChar,
		 (XtConvertArgList)NULL,
		 (Cardinal)0,
		 XtCacheAll|XtCacheRefCount,
		 (XtDestructor)NULL);
	tet_infoline("TEST: Call XtConvertAnd Store to invoke resource converter");
	from.addr = (XtPointer) "Hello";
	from.size = sizeof(unsigned char);
	status = XtConvertAndStore(topLevel,
		 XtRString,
		 &from,
		 XavsRChar,
		 &to_in_out
		 );
	tet_infoline("TEST: Return status");
	check_dec(False, status, "return value");
	tet_infoline("TEST: XtCVT2_StringToChar was invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtCVT_StringToChar invocation count");
	tet_infoline("TEST: Invoke resource converter again");
	from.addr = (XtPointer) "Hello";
	from.size = sizeof(unsigned char);
	status = XtConvertAndStore(topLevel,
		 XtRString,
		 &from,
		 XavsRChar,
		 &to_in_out
		 );
	tet_infoline("TEST: Return status");
	check_dec(False, status, "return value");
	tet_infoline("TEST: XtCVT2_StringToChar was not invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtCVT_StringToChar invocation count");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When a converter has been registered for a conversion from
.A from_type
to
.A to_type
for the application context associated with
.A object
with conversion cache type specified as XtCacheAll, the converter has 
been previously called with the specified arguments, the conversion
succeeded, and the size specified by 
.A to_in_out 
is greater
than or equal to the size stored in the conversion cache a call to
Boolean XtConvertAndStore(object, from_type, from, to_type, to_in_out)
shall copy the information stored in the conversion cache into the 
location specified by to_in_out->addr, copy the size specified in the
conversion cache into to_in_out->size, and return True.
>>CODE
Display *display_good;
XrmValue from;
XrmValue to_in_out;
XtCacheRef cache_ref_return;
int invoked = 0;
int status;
pid_t pid2;

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tcnvrtast1", "XtConvertAndStore");
	(void) ConfigureDimension(topLevel, boxw2);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Register resource converter XtCVT_StringToChar");
	XtAppSetTypeConverter(app_ctext,
		 XtRString,
		 XavsRChar,
		 XtCVT_StringToChar,
		 (XtConvertArgList)NULL,
		 (Cardinal)0,
		 XtCacheAll,
		 (XtDestructor)NULL);
	tet_infoline("TEST: Call XtConvertAnd Store to invoke resource converter");
	from.addr = (XtPointer) "Hello";
	from.size = sizeof(unsigned char);
	to_in_out.addr = (XtPointer) tchar;
	to_in_out.size = sizeof(unsigned char);
	status = XtConvertAndStore(topLevel,
		 XtRString,
		 &from,
		 XavsRChar,
		 &to_in_out
		 );
	tet_infoline("TEST: Return status");
	check_dec(True, status, "return value");
	tet_infoline("TEST: XtCVT_StringToChar was invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtCVT_StringToChar invoked status");
	tet_infoline("TEST: Result returned");
	check_char('H', *(char *)to_in_out.addr, "conversion result");
	tet_infoline("TEST: Call XtConvertAnd Store again with larger size");
	from.addr = (XtPointer) "Hello";
	from.size = sizeof(unsigned char);
	to_in_out.addr = (XtPointer) tchar;
	to_in_out.size = sizeof(unsigned char)+1;
	status = XtConvertAndStore(topLevel,
		 XtRString,
		 &from,
		 XavsRChar,
		 &to_in_out
		 );
	tet_infoline("TEST: Return status");
	check_dec(True, status, "return value");
	tet_infoline("TEST: XtCVT_StringToChar was invoked again");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtCVT_StringToChar invocation count");
	tet_infoline("TEST: Result returned");
	check_char('H', *(char *)to_in_out.addr, "conversion result");
	tet_infoline("TEST: Size returned");
	check_dec((long)sizeof(unsigned char), (long)to_in_out.size, "to_in_out.size");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When a converter has been registered for a conversion from
.A from_type
to
.A to_type
for the application context associated with
.A object
with conversion cache type specified as XtCacheAll, the converter has 
been previously called with the specified arguments, the conversion
succeeded, and the size specified by the to_in_out argument is less
than the size stored in the conversion cache a call to
Boolean XtCallConverter(display, converter, args, num_args, from, to_in_out, cache_ref_return)
shall copy the size specified in the conversion cache into 
to_in_out->size and shall return False.
>>CODE
Display *display_good;
XrmValue from;
XrmValue to_in_out;
XtCacheRef cache_ref_return;
int invoked = 0;
int status;
pid_t pid2;

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tcnvrtast1", "XtConvertAndStore");
	(void) ConfigureDimension(topLevel, boxw2);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Register resource converter XtCVT_StringToChar");
	XtAppSetTypeConverter(app_ctext,
		 XtRString,
		 XavsRChar,
		 XtCVT_StringToChar,
		 (XtConvertArgList)NULL,
		 (Cardinal)0,
		 XtCacheAll,
		 (XtDestructor)NULL);
	tet_infoline("TEST: Call XtConvertAnd Store to invoke resource converter");
	from.addr = (XtPointer) "Hello";
	from.size = sizeof(unsigned char);
	to_in_out.addr = (XtPointer) tchar;
	to_in_out.size = sizeof(unsigned char);
	status = XtConvertAndStore(topLevel,
		 XtRString,
		 &from,
		 XavsRChar,
		 &to_in_out
		 );
	tet_infoline("TEST: Return status");
	check_dec(True, status, "return value");
	tet_infoline("TEST: XtCVT_StringToChar was invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtCVT_StringToChar invoked status");
	tet_infoline("TEST: Result returned");
	check_char('H', *(char *)to_in_out.addr, "conversion result");
	tet_infoline("TEST: Call XtConvertAnd Store again with short size");
	from.addr = (XtPointer) "Hello";
	from.size = sizeof(unsigned char);
	to_in_out.addr = (XtPointer) tchar;
	to_in_out.size = sizeof(unsigned char)-1;
	status = XtConvertAndStore(topLevel,
		 XtRString,
		 &from,
		 XavsRChar,
		 &to_in_out
		 );
	tet_infoline("TEST: Return status");
	check_dec(False, status, "return value");
	tet_infoline("TEST: XtCVT_StringToChar was not invoked again");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtCVT_StringToChar invocation count");
	tet_infoline("TEST: Size returned");
	check_dec((long)sizeof(unsigned char), (long)to_in_out.size, "to_in_out.size");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When a converter has been registered for a conversion from
.A from_type
to
.A to_type
for the application context associated with
.A object
with conversion cache type specified as XtCacheByDisplay and the 
converter has not been previously called with the specified arguments 
a call to
Boolean XtConvertAndStore(object, from_type, from, to_type, to_in_out)
shall compute the additional arguments, call the converter, enter 
the result into the conversion cache, store the converted value 
into the location specified by to_in_out->addr, and return True.
>>CODE
Display *display_good;
XrmValue from;
XrmValue to_in_out;
XtCacheRef cache_ref_return;
int invoked = 0;
int status;
pid_t pid2;

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tcnvrtast1", "XtConvertAndStore");
	(void) ConfigureDimension(topLevel, boxw2);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Register resource converter XtCVT_StringToChar");
	XtAppSetTypeConverter(app_ctext,
		 XtRString,
		 XavsRChar,
		 XtCVT_StringToChar,
		 (XtConvertArgList)NULL,
		 (Cardinal)0,
		 XtCacheByDisplay,
		 (XtDestructor)NULL);
	tet_infoline("TEST: Call XtConvertAnd Store to invoke resource converter");
	from.addr = (XtPointer) "Hello";
	from.size = sizeof(unsigned char);
	to_in_out.addr = (XtPointer) tchar;
	to_in_out.size = sizeof(unsigned char);
	status = XtConvertAndStore(topLevel,
		 XtRString,
		 &from,
		 XavsRChar,
		 &to_in_out
		 );
	tet_infoline("TEST: Return status");
	check_dec(True, status, "return value");
	tet_infoline("TEST: XtCVT_StringToChar was invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtCVT_StringToChar invoked status");
	tet_infoline("TEST: Result returned");
	check_char('H', *(char *)to_in_out.addr, "conversion result");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When a converter has been registered for a conversion from
.A from_type
to
.A to_type
for the application context associated with
.A object
with conversion cache type specified as XtCacheByDisplay and the 
converter has been previously called with the specified arguments 
a call to
Boolean XtConvertAndStore(object, from_type, from, to_type, to_in_out)
shall reuse the the previous conversion.
>>CODE
Display *display_good;
XrmValue from;
XrmValue to_in_out;
XtCacheRef cache_ref_return;
int invoked = 0;
int status;
pid_t pid2;

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tcnvrtast1", "XtConvertAndStore");
	(void) ConfigureDimension(topLevel, boxw2);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Register resource converter XtCVT_StringToChar");
	XtAppSetTypeConverter(app_ctext,
		 XtRString,
		 XavsRChar,
		 XtCVT_StringToChar,
		 (XtConvertArgList)NULL,
		 (Cardinal)0,
		 XtCacheByDisplay,
		 (XtDestructor)NULL);
	tet_infoline("TEST: Call XtConvertAnd Store to invoke resource converter");
	from.addr = (XtPointer) "Hello";
	from.size = sizeof(unsigned char);
	to_in_out.addr = (XtPointer) tchar;
	to_in_out.size = sizeof(unsigned char);
	status = XtConvertAndStore(topLevel,
		 XtRString,
		 &from,
		 XavsRChar,
		 &to_in_out
		 );
	tet_infoline("TEST: Return status");
	check_dec(True, status, "return value");
	tet_infoline("TEST: XtCVT_StringToChar was invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtCVT_StringToChar invoked status");
	tet_infoline("TEST: Result returned");
	check_char('H', *(char *)to_in_out.addr, "conversion result");
	tet_infoline("TEST: Invoke resource conversion again");
	from.addr = (XtPointer) "Hello";
	from.size = sizeof(unsigned char);
	to_in_out.addr = (XtPointer) tchar;
	to_in_out.size = sizeof(unsigned char);
	status = XtConvertAndStore(topLevel,
		 XtRString,
		 &from,
		 XavsRChar,
		 &to_in_out
		 );
	tet_infoline("TEST: Return status");
	check_dec(True, status, "return value");
	tet_infoline("TEST: XtCVT_StringToChar was not invoked again");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtCVT_StringToChar invoked status");
	tet_infoline("TEST: Result returned");
	check_char('H', *(char *)to_in_out.addr, "conversion result");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When a converter has been registered for a conversion from
.A from_type
to
.A to_type
for the application context associated with
.A object
with conversion cache type specified as XtCacheByDisplay and the 
converter has not been previously called with the specified arguments 
a call to
Boolean XtConvertAndStore(object, from_type, from, to_type, to_in_out)
shall return False if the conversion fails.
>>CODE
Display *display_good;
XrmValue from;
XrmValue to_in_out;
XtCacheRef cache_ref_return;
int invoked = 0;
int status;
pid_t pid2;

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tcnvrtast2", "XtConvertAndStore");
	(void) ConfigureDimension(topLevel, boxw2);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Register resource converter XtCVT2_StringToChar");
	XtAppSetTypeConverter(app_ctext,
		 XtRString,
		 XavsRChar,
		 XtCVT2_StringToChar,
		 (XtConvertArgList)NULL,
		 (Cardinal)0,
		 XtCacheByDisplay|XtCacheRefCount,
		 (XtDestructor)NULL);
	tet_infoline("TEST: Call XtConvertAnd Store to invoke resource converter");
	from.addr = (XtPointer) "Hello";
	from.size = sizeof(unsigned char);
	status = XtConvertAndStore(topLevel,
		 XtRString,
		 &from,
		 XavsRChar,
		 &to_in_out
		 );
	tet_infoline("TEST: Return status");
	check_dec(False, status, "return value");
	tet_infoline("TEST: XtCVT2_StringToChar was invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtCVT_StringToChar invocation count");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When a converter has been registered for a conversion from
.A from_type
to
.A to_type
for the application context associated with
.A object
with conversion cache type specified as XtCacheByDisplay, the converter 
has been previously called with the specified arguments, and the 
conversion failed a call to
Boolean XtConvertAndStore(object, from_type, from, to_type, to_in_out)
shall not perform the conversion and shall return False.
>>CODE
Display *display_good;
XrmValue from;
XrmValue to_in_out;
XtCacheRef cache_ref_return;
int invoked = 0;
int status;
pid_t pid2;

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tcnvrtast2", "XtConvertAndStore");
	(void) ConfigureDimension(topLevel, boxw2);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Register resource converter XtCVT2_StringToChar");
	XtAppSetTypeConverter(app_ctext,
		 XtRString,
		 XavsRChar,
		 XtCVT2_StringToChar,
		 (XtConvertArgList)NULL,
		 (Cardinal)0,
		 XtCacheByDisplay|XtCacheRefCount,
		 (XtDestructor)NULL);
	tet_infoline("TEST: Call XtConvertAnd Store to invoke resource converter");
	from.addr = (XtPointer) "Hello";
	from.size = sizeof(unsigned char);
	status = XtConvertAndStore(topLevel,
		 XtRString,
		 &from,
		 XavsRChar,
		 &to_in_out
		 );
	tet_infoline("TEST: Return status");
	check_dec(False, status, "return value");
	tet_infoline("TEST: XtCVT2_StringToChar was invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtCVT_StringToChar invocation count");
	tet_infoline("TEST: Call XtConvertAnd Store again");
	from.addr = (XtPointer) "Hello";
	from.size = sizeof(unsigned char);
	status = XtConvertAndStore(topLevel,
		 XtRString,
		 &from,
		 XavsRChar,
		 &to_in_out
		 );
	tet_infoline("TEST: Return status");
	check_dec(False, status, "return value");
	tet_infoline("TEST: XtCVT2_StringToChar was not invoked again");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtCVT_StringToChar invocation count");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When a converter has been registered for a conversion from
.A from_type
to
.A to_type
for the application context associated with
.A object
with conversion cache type specified as XtCacheByDisplay, the converter 
has been previously called with the specified arguments, the conversion
succeeded, and the size specified by the to_in_out argument is greater
than or equal to the size stored in the conversion cache a call to
Boolean XtConvertAndStore(object, from_type, from, to_type, to_in_out)
shall copy the information stored in the conversion cache into the 
location specified by to_in_out->addr, copy the size specified in the
conversion cache into to_in_out->size, and return True.
>>CODE
Display *display_good;
XrmValue from;
XrmValue to_in_out;
XtCacheRef cache_ref_return;
int invoked = 0;
int status;
pid_t pid2;

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tcnvrtast1", "XtConvertAndStore");
	(void) ConfigureDimension(topLevel, boxw2);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Register resource converter XtCVT_StringToChar");
	XtAppSetTypeConverter(app_ctext,
		 XtRString,
		 XavsRChar,
		 XtCVT_StringToChar,
		 (XtConvertArgList)NULL,
		 (Cardinal)0,
		 XtCacheByDisplay,
		 (XtDestructor)NULL);
	tet_infoline("TEST: Call XtConvertAnd Store to invoke resource converter");
	from.addr = (XtPointer) "Hello";
	from.size = sizeof(unsigned char);
	to_in_out.addr = (XtPointer) tchar;
	to_in_out.size = sizeof(unsigned char);
	status = XtConvertAndStore(topLevel,
		 XtRString,
		 &from,
		 XavsRChar,
		 &to_in_out
		 );
	tet_infoline("TEST: Return status");
	check_dec(True, status, "return value");
	tet_infoline("TEST: XtCVT_StringToChar was invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtCVT_StringToChar invoked status");
	tet_infoline("TEST: Result returned");
	check_char('H', *(char *)to_in_out.addr, "conversion result");
	tet_infoline("TEST: Call XtConvertAnd Store again with larger size");
	from.addr = (XtPointer) "Hello";
	from.size = sizeof(unsigned char);
	to_in_out.addr = (XtPointer) tchar;
	to_in_out.size = sizeof(unsigned char)+1;
	status = XtConvertAndStore(topLevel,
		 XtRString,
		 &from,
		 XavsRChar,
		 &to_in_out
		 );
	tet_infoline("TEST: Return status");
	check_dec(True, status, "return value");
	tet_infoline("TEST: XtCVT_StringToChar was not invoked again");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtCVT_StringToChar invocation count");
	tet_infoline("TEST: Result returned");
	check_char('H', *(char *)to_in_out.addr, "conversion result");
	tet_infoline("TEST: Size returned");
	check_dec((long)sizeof(unsigned char), (long)to_in_out.size, "to_in_out.size");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When a converter has been registered for a conversion from
.A from_type
to
.A to_type
for the application context associated with
.A object
with conversion cache type specified as XtCacheByDisplay, the converter 
has been previously called with the specified arguments, the conversion
succeeded, and the size specified by the to_in_out argument is less
than the size stored in the conversion cache a call to
Boolean XtConvertAndStore(object, from_type, from, to_type, to_in_out)
shall copy the size specified in the conversion cache into to_in_out->size
and shall return False.
>>CODE
Display *display_good;
XrmValue from;
XrmValue to_in_out;
XtCacheRef cache_ref_return;
int invoked = 0;
int status;
pid_t pid2;

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tcnvrtast1", "XtConvertAndStore");
	(void) ConfigureDimension(topLevel, boxw2);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Register resource converter XtCVT_StringToChar");
	XtAppSetTypeConverter(app_ctext,
		 XtRString,
		 XavsRChar,
		 XtCVT_StringToChar,
		 (XtConvertArgList)NULL,
		 (Cardinal)0,
		 XtCacheByDisplay,
		 (XtDestructor)NULL);
	tet_infoline("TEST: Call XtConvertAnd Store to invoke resource converter");
	from.addr = (XtPointer) "Hello";
	from.size = sizeof(unsigned char);
	to_in_out.addr = (XtPointer) tchar;
	to_in_out.size = sizeof(unsigned char);
	status = XtConvertAndStore(topLevel,
		 XtRString,
		 &from,
		 XavsRChar,
		 &to_in_out
		 );
	tet_infoline("TEST: Return status");
	check_dec(True, status, "return value");
	tet_infoline("TEST: XtCVT_StringToChar was invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtCVT_StringToChar invoked status");
	tet_infoline("TEST: Result returned");
	check_char('H', *(char *)to_in_out.addr, "conversion result");
	tet_infoline("TEST: Call XtConvertAnd Store again with shorter size");
	from.addr = (XtPointer) "Hello";
	from.size = sizeof(unsigned char);
	to_in_out.addr = (XtPointer) tchar;
	to_in_out.size = sizeof(unsigned char)-1;
	status = XtConvertAndStore(topLevel,
		 XtRString,
		 &from,
		 XavsRChar,
		 &to_in_out
		 );
	tet_infoline("TEST: Return status");
	check_dec(False, status, "return value");
	tet_infoline("TEST: XtCVT_StringToChar was not invoked again");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtCVT_StringToChar invocation count");
	tet_infoline("TEST: Size returned");
	check_dec((long)sizeof(unsigned char), (long)to_in_out.size, "to_in_out.size");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to
Boolean XtConvertAndStore(object, from_type, from, to_type, to_in_out)
when to_in_out.addr is NULL shall replace it with a pointer to a
private storage in which the conversion results are stored and return
the size in to_in_out->size.
>>CODE
Display *display_good;
XrmValue from;
XrmValue to_in_out;
XtCacheRef cache_ref_return;
int invoked = 0;
int status;
pid_t pid2;

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tcnvrtast4", "XtConvertAndStore");
	(void) ConfigureDimension(topLevel, boxw2);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Register resource converter XtCVT_StringToChar");
	XtAppSetTypeConverter(app_ctext,
		 XtRString,
		 XavsRChar,
		 XtCVT_StringToChar,
		 (XtConvertArgList)NULL,
		 (Cardinal)0,
		 XtCacheAll|XtCacheRefCount,
		 (XtDestructor)NULL);
	tet_infoline("TEST: Call XtConvertAnd Store to invoke resource converter");
	from.addr = (XtPointer) "Hello";
	from.size = sizeof(unsigned char);
	tchar[0] = 0;
	to_in_out.addr = NULL;
	to_in_out.size = 0;
	status = XtConvertAndStore(topLevel,
		 XtRString,
		 &from,
		 XavsRChar,
		 &to_in_out
		 );
	tet_infoline("TEST: Return status");
	check_dec(True, status, "return value");
	tet_infoline("TEST: Result returned");
	if (to_in_out.addr == NULL) {
		tet_infoline("ERROR: to_in_out.addr remained NULL");
		tet_result(TET_FAIL);
		exit(1);
	}
	check_char('H', *(char *)to_in_out.addr, "conversion result");
	tet_infoline("TEST: Size returned");
	check_dec(sizeof(unsigned char), to_in_out.size, "size");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good B 1
When a converter has been registered for a conversion from
.A from_type
to
.A to_type
for the application context associated with
.A object
with the cache type set to XtCacheRefCount and XtCacheAll or
XtCacheByDisplay and a XtCacheRef value is returned from the
converter on a call to
Boolean XtConvertAndStore(object, from_type, from, to_type, to_in_out)
the XtCallbackReleaseCacheRef function shall be added to the
destroyCallback list of the specified object.
>>ASSERTION Good B 2
The behavior of a call to 
Boolean XtConvertAndStore(object, from_type, from, to_type, to_in_out)
when 
.A object 
is not of class Object or any subclass thereof.
