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
$Header: /cvs/xtest/xtest/xts5/tset/Xt11/tcalcnvtr/tcalcnvtr.m,v 1.1 2005-02-12 14:37:51 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt11/tcalcnvtr/tcalcnvtr.m
>># 
>># Description:
>>#	Tests for XtCallConverter()
>># 
>># Modifications:
>># $Log: tcalcnvtr.m,v $
>># Revision 1.1  2005-02-12 14:37:51  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:37:47  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:00:44  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:28:50  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:25:24  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:20:27  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:15:26  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

/*conversion results go here*/
unsigned char tochar;

XtAppContext app_ctext, app_ctext2;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;

pid_t pid2;
Display *display_good;
XrmValue from;
XrmValue to_in_out;
XtCacheRef cache_ref_return;
int invoked = 0;
Boolean status;
char fromdata[128];
void init_args()
{
pid_t	thepid;

	display_good = XtDisplay(topLevel);
	strcpy(fromdata, "Hello");
	thepid = getpid();
	sprintf(&fromdata[strlen(fromdata)], "%d", thepid);
	from.addr = (XPointer) fromdata;
	from.size = strlen(from.addr) + 1;
	to_in_out.size = sizeof(unsigned char);
	to_in_out.addr = (XtPointer)&tochar;
	tochar = 0;
	invoked = 0;
}

#ifndef XavsRChar
#define XavsRChar "Char"
#endif
Boolean XtCVT1_StringToChar(display, args, num_args, from_val, to_val, converter_data)
Display *display;
XrmValue *args;
Cardinal *num_args;
XrmValue *from_val;
XrmValue *to_val;
XtPointer *converter_data;
{
	char *str = (char *) (from_val->addr);
	static unsigned char i;
	to_val->size = sizeof (unsigned char);
	to_val->addr = (XPointer) &i;
	i = *str;
	avs_set_event(1, avs_get_event(1)+1);
	return True;
}
#define XavsRUnknown "UnknownRes"
Boolean XtCVT2_StringToChar(display, args, num_args, from_val, to_val, converter_data)
Display *display;
XrmValuePtr args;
Cardinal *num_args;
XrmValue *from_val;
XrmValue *to_val;
XtPointer *converter_data;
{
	avs_set_event(1, avs_get_event(1)+1);
	/* Force false value as if conversion failed */
	return (False);
}
Boolean XtCVT3_StringToChar(display, args, num_args, from_val, to_val, converter_data)
Display *display;
XrmValue *args;
Cardinal *num_args;
XrmValue *from_val;
XrmValue *to_val;
XtPointer *converter_data;
{

	return (XtCVT1_StringToChar(display, args, num_args, from_val, to_val, converter_data));
}
Boolean XtCVT4_StringToChar(display, args, num_args, from_val, to_val, converter_data)
Display *display;
XrmValue *args;
Cardinal *num_args;
XrmValue *from_val;
XrmValue *to_val;
XtPointer *converter_data;
{
	return (XtCVT1_StringToChar(display, args, num_args, from_val, to_val, converter_data));
}
Boolean XtCVT1a_StringToChar(display, args, num_args, from_val, to_val, converter_data)
Display *display;
XrmValue *args;
Cardinal *num_args;
XrmValue *from_val;
XrmValue *to_val;
XtPointer *converter_data;
{
	return (XtCVT1_StringToChar(display, args, num_args, from_val, to_val, converter_data));
}
Boolean XtCVT2a_StringToChar(display, args, num_args, from_val, to_val, converter_data)
Display *display;
XrmValuePtr args;
Cardinal *num_args;
XrmValue *from_val;
XrmValue *to_val;
XtPointer *converter_data;
{
	return (XtCVT2_StringToChar(display, args, num_args, from_val, to_val, converter_data));
}
Boolean XtCVT3a_StringToChar(display, args, num_args, from_val, to_val, converter_data)
Display *display;
XrmValue *args;
Cardinal *num_args;
XrmValue *from_val;
XrmValue *to_val;
XtPointer *converter_data;
{

	return (XtCVT1_StringToChar(display, args, num_args, from_val, to_val, converter_data));
}
Boolean XtCVT4a_StringToChar(display, args, num_args, from_val, to_val, converter_data)
Display *display;
XrmValue *args;
Cardinal *num_args;
XrmValue *from_val;
XrmValue *to_val;
XtPointer *converter_data;
{
	return (XtCVT1_StringToChar(display, args, num_args, from_val, to_val, converter_data));
}
Boolean XtCVT1b_StringToChar(display, args, num_args, from_val, to_val, converter_data)
Display *display;
XrmValue *args;
Cardinal *num_args;
XrmValue *from_val;
XrmValue *to_val;
XtPointer *converter_data;
{
	return (XtCVT1_StringToChar(display, args, num_args, from_val, to_val, converter_data));
}
Boolean XtCVT2b_StringToChar(display, args, num_args, from_val, to_val, converter_data)
Display *display;
XrmValuePtr args;
Cardinal *num_args;
XrmValue *from_val;
XrmValue *to_val;
XtPointer *converter_data;
{
	return (XtCVT2_StringToChar(display, args, num_args, from_val, to_val, converter_data));
}
Boolean XtCVT3b_StringToChar(display, args, num_args, from_val, to_val, converter_data)
Display *display;
XrmValue *args;
Cardinal *num_args;
XrmValue *from_val;
XrmValue *to_val;
XtPointer *converter_data;
{

	return (XtCVT1_StringToChar(display, args, num_args, from_val, to_val, converter_data));
}
Boolean XtCVT4b_StringToChar(display, args, num_args, from_val, to_val, converter_data)
Display *display;
XrmValue *args;
Cardinal *num_args;
XrmValue *from_val;
XrmValue *to_val;
XtPointer *converter_data;
{
	return (XtCVT1_StringToChar(display, args, num_args, from_val, to_val, converter_data));
}
Boolean XtCVT1c_StringToChar(display, args, num_args, from_val, to_val, converter_data)
Display *display;
XrmValue *args;
Cardinal *num_args;
XrmValue *from_val;
XrmValue *to_val;
XtPointer *converter_data;
{
	return (XtCVT1_StringToChar(display, args, num_args, from_val, to_val, converter_data));
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtCallConverter Xt11
Boolean
XtCallConverter(display, converter, args, num_args, from, to_in_out, cache_ref_return)
>>ASSERTION Good A
When the converter 
.A converter
has been registered with the conversion cache type specified 
as XtCacheNone 
a call to
Boolean XtCallConverter(display, converter, conversion_args, 
num_args, from, to_in_out, cache_ref_return)
shall call the converter, store the converted value returned into
the location specified by to_in_out->addr, and return what the 
converter returns.
>>CODE

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tcalcnvtr13", "XtCallConverter");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Register resource converter XtCVT1c_StringToChar");
	XtAppSetTypeConverter(app_ctext,
		 XtRString,
		 XavsRChar,
		 XtCVT1c_StringToChar,
		 (XtConvertArgList)NULL,
		 (Cardinal)0,
		 XtCacheNone|XtCacheRefCount,
		 (XtDestructor)NULL);
	tet_infoline("TEST: Invoke resource converter XtCVT1c_StringToChar");
	init_args();
	status = XtCallConverter(display_good,
		XtCVT1c_StringToChar,
		(XrmValuePtr)NULL,
		(Cardinal)0,
		&from,
		&to_in_out,
		&cache_ref_return
		);
	tet_infoline("TEST: Return value");
	check_dec(True, status, "XtCallConverter return value");
	tet_infoline("TEST: Procedure XtCVT1c_StringToChar was invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtCVT1c_StringToChar invoked count");
	tet_infoline("TEST: Result returned");
	check_dec((long) 'H', (long) *(unsigned char*)to_in_out.addr, "Character");
	tet_infoline("TEST: Re-Invoke resource converter with same values");
	display_good = XtDisplay(topLevel);
	init_args();
	status = XtCallConverter(display_good,
		XtCVT1c_StringToChar,
		(XrmValuePtr)NULL,
		(Cardinal)0,
		&from,
		&to_in_out,
		&cache_ref_return
		);
	tet_infoline("TEST: Return value");
	check_dec(True, status, "XtCallConverter return value");
	tet_infoline("TEST: Procedure XtCVT1c_StringToChar was invoked");
	invoked = avs_get_event(1);
	check_dec(2, invoked, "XtCVT1c_StringToChar invoked count");
	tet_infoline("TEST: Result returned");
	check_dec((long) 'H', (long) *(unsigned char*)to_in_out.addr, "Character");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When the type converter 
.A converter
has been registered for the application context associated with 
.A display
with the conversion cache type specified as XtCacheAll and the 
converter has not been previously called with the specified 
arguments a call to
Boolean XtCallConverter(display, converter, args, num_args, 
from, to_in_out, cache_ref_return)
shall call the converter, enter the result into the conversion cache, 
store the converted value into the location specified by
to_in_out->addr, and return what the converter returns.
>>CODE

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tcalcnvtr1", "XtCallConverter");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Register resource converter XtCVT1_StringToChar");
	XtAppSetTypeConverter(app_ctext,
		 XtRString,
		 XavsRChar,
		 XtCVT1_StringToChar,
		 (XtConvertArgList)NULL,
		 (Cardinal)0,
		 XtCacheAll|XtCacheRefCount,
		 (XtDestructor)NULL);
	tet_infoline("TEST: Invoke resource converter XtCVT1_StringToChar");
	init_args();
	status = XtCallConverter(display_good,
		XtCVT1_StringToChar,
		(XrmValuePtr)NULL,
		(Cardinal)0,
		&from,
		&to_in_out,
		&cache_ref_return
		);
	tet_infoline("TEST: Return value");
	check_dec(True, status, "XtCallConverter return value");
	tet_infoline("TEST: Procedure XtCVT1_StringToChar was invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtCVT1_StringToChar invoked count");
	tet_infoline("TEST: Result returned");
	check_dec((long) 'H', (long) *(unsigned char*)to_in_out.addr, "Character");
	tet_infoline("TEST: Re-Invoke resource converter with same values");
	init_args();
	status = XtCallConverter(display_good,
		XtCVT1_StringToChar,
		(XrmValuePtr)NULL,
		(Cardinal)0,
		&from,
		&to_in_out,
		&cache_ref_return
		);
	tet_infoline("TEST: Return value");
	check_dec(True, status, "XtCallConverter return value");
	tet_infoline("TEST: Procedure XtCVT1_StringToChar was not invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtCVT1_StringToChar invoked count");
	tet_infoline("TEST: Result returned");
	check_dec((long) 'H', (long) *(unsigned char*)to_in_out.addr, "Character");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When the type converter 
.A converter
has been  registered for the application context associated with 
.A display
with the conversion cache type specified as XtCacheAll, the converter has 
been previously called with the specified arguments, and the conversion
failed a call to
Boolean XtCallConverter(display, converter, args, num_args, 
from, to_in_out, cache_ref_return)
shall return False immediately.
>>CODE

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tcalcnvtr2", "XtCallConverter");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Register resource converter XtCVT2_StringToChar");
	XtAppSetTypeConverter(app_ctext,
		 XtRString,
		 XavsRUnknown,
		 XtCVT2_StringToChar,
		 (XtConvertArgList)NULL,
		 (Cardinal)0,
		 XtCacheByDisplay|XtCacheRefCount,
		 (XtDestructor)NULL);
	tet_infoline("TEST: Invoke resource converter XtCVT2_StringToChar");
	init_args();
	status = XtCallConverter(display_good,
		XtCVT2_StringToChar,
		(XrmValuePtr)NULL,
		(Cardinal)0,
		&from,
		&to_in_out,
		&cache_ref_return
		);
	tet_infoline("TEST: Return value was false");
	check_dec(False, status, "XtCallConverter return value");
	tet_infoline("TEST: Convertor was invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtCVT2_StringToChar invoked count");
	tet_infoline("TEST: Re-Invoke resource converter with same values");
	init_args();
	status = XtCallConverter(display_good,
		XtCVT2_StringToChar,
		(XrmValuePtr)NULL,
		(Cardinal)0,
		&from,
		&to_in_out,
		&cache_ref_return
		);
	tet_infoline("TEST: Return value was false");
	check_dec(False, status, "XtCallConverter return value");
	tet_infoline("TEST: Convertor was not invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtCVT2_StringToChar invoked count");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When the type converter 
.A converter
has been registered for the application context associated with 
.A display
with the conversion cache type specified as XtCacheAll, the converter has 
been previously called with the specified arguments, the conversion
succeeded, and the size specified by the to_in_out argument is greater
than or equal to the size stored in the conversion cache a call to
Boolean XtCallConverter(display, converter, args, num_args, 
from, to_in_out, cache_ref_return)
shall copy the information stored in the conversion cache into the 
location specified by to_in_out->addr, copy the size specified in the
conversion cache into to_in_out->size, and return True.
>>CODE

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tcalcnvtr3", "XtCallConverter");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Register resource converter XtCVT3_StringToChar");
	XtAppSetTypeConverter(app_ctext,
		 XtRString,
		 XavsRChar,
		 XtCVT3_StringToChar,
		 (XtConvertArgList)NULL,
		 (Cardinal)0,
		 XtCacheAll|XtCacheRefCount,
		 (XtDestructor)NULL);
	tet_infoline("TEST: Invoke resource converter XtCVT3_StringToChar");
	init_args();
	status = XtCallConverter(display_good,
		XtCVT3_StringToChar,
		(XrmValuePtr)NULL,
		(Cardinal)0,
		&from,
		&to_in_out,
		&cache_ref_return
		);
	tet_infoline("TEST: Procedure XtCVT3_StringToChar was invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtCVT3_StringToChar invoked count");
	tet_infoline("TEST: Result returned first time");
	check_dec((long) 'H', (long) *(unsigned char*)to_in_out.addr,
		"Character");
	tet_infoline("TEST: Re-invoke with same arguments");
	init_args();
	to_in_out.size = sizeof(unsigned char)+1;
	status = XtCallConverter(display_good,
		XtCVT3_StringToChar,
		(XrmValuePtr)NULL,
		(Cardinal)0,
		&from,
		&to_in_out,
		&cache_ref_return
		);
	tet_infoline("TEST: Return value");
	check_dec(True, status, "XtCallConverter return value");
	tet_infoline("TEST: Convertor was not invoked");
	invoked = avs_get_event(1);
	tet_infoline("TEST: Result returned second time");
	check_dec((long) 'H', (long) *(unsigned char*)to_in_out.addr, "Character");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When the type converter 
.A converter
has been registered for the application context associated with 
.A display
with the conversion cache type specified as XtCacheAll, the converter has 
been previously called with the specified arguments, the conversion
succeeded, and the size specified by the to_in_out argument is less
than the size stored in the conversion cache a call to
Boolean XtCallConverter(display, converter, args, num_args, 
from, to_in_out, cache_ref_return)
shall copy the size specified in the conversion cache into 
to_in_out->size and return False.
>>CODE

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tcalcnvtr4", "XtCallConverter");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Register resource converter XtCVT4_StringToChar");
	XtAppSetTypeConverter(app_ctext,
		 XtRString,
		 XavsRChar,
		 XtCVT4_StringToChar,
		 (XtConvertArgList)NULL,
		 (Cardinal)0,
		 XtCacheAll|XtCacheRefCount,
		 (XtDestructor)NULL);
	tet_infoline("TEST: Invoke resource converter XtCVT4_StringToChar");
	init_args();
	status = XtCallConverter(display_good,
		XtCVT4_StringToChar,
		(XrmValuePtr)NULL,
		(Cardinal)0,
		&from,
		&to_in_out,
		&cache_ref_return
		);
	tet_infoline("TEST: Procedure XtCVT4_StringToChar was invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtCVT4_StringToChar invoked count");
	tet_infoline("TEST: Result returned first time");
	check_dec((long) 'H', (long) *(unsigned char*)to_in_out.addr,
		"Character");
	tet_infoline("TEST: Re-invoke with short size");
	init_args();
	to_in_out.size = 0;
	status = XtCallConverter(display_good,
		XtCVT4_StringToChar,
		(XrmValuePtr)NULL,
		(Cardinal)0,
		&from,
		&to_in_out,
		&cache_ref_return
		);
	tet_infoline("TEST: Return value");
	check_dec(False, status, "XtCallConverter return value");
	tet_infoline("TEST: Convertor was not invoked");
	invoked = avs_get_event(1);
	tet_infoline("TEST: Size returned");
	check_dec((long)sizeof(unsigned char), (long)to_in_out.size, "to_in_out.size");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When the type converter 
.A converter
has been registered for the application context associated with 
.A display
with the conversion cache type specified as XtCacheByDisplay and the 
converter has not been previously called with the specified arguments 
a call to
Boolean XtCallConverter(display, converter, args, num_args, 
from, to_in_out, cache_ref_return)
shall call the converter, enter the result into the conversion cache, 
store the converted value into the location specified by
to_in_out->addr, and return what the converter returns.
>>CODE

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tcalcnvtr9", "XtCallConverter");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Register resource converter XtCVT1b_StringToChar");
	XtAppSetTypeConverter(app_ctext,
		 XtRString,
		 XavsRChar,
		 XtCVT1b_StringToChar,
		 (XtConvertArgList)NULL,
		 (Cardinal)0,
		 XtCacheByDisplay|XtCacheRefCount,
		 (XtDestructor)NULL);
	tet_infoline("TEST: Invoke resource converter XtCVT1b_StringToChar");
	init_args();
	status = XtCallConverter(display_good,
		XtCVT1b_StringToChar,
		(XrmValuePtr)NULL,
		(Cardinal)0,
		&from,
		&to_in_out,
		&cache_ref_return
		);
	tet_infoline("TEST: Return value");
	check_dec(True, status, "XtCallConverter return value");
	tet_infoline("TEST: Procedure XtCVT1b_StringToChar was invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtCVT1b_StringToChar invoked count");
	tet_infoline("TEST: Result returned");
	check_dec((long) 'H', (long) *(unsigned char*)to_in_out.addr, "Character");
	tet_infoline("TEST: Re-Invoke resource converter with same values");
	init_args();
	status = XtCallConverter(display_good,
		XtCVT1b_StringToChar,
		(XrmValuePtr)NULL,
		(Cardinal)0,
		&from,
		&to_in_out,
		&cache_ref_return
		);
	tet_infoline("TEST: Return value");
	check_dec(True, status, "XtCallConverter return value");
	tet_infoline("TEST: Procedure XtCVT1b_StringToChar was not invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtCVT1b_StringToChar invoked count");
	tet_infoline("TEST: Result returned");
	check_dec((long) 'H', (long) *(unsigned char*)to_in_out.addr, "Character");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);

>>ASSERTION Good A
When the type converter 
.A converter
has been registered for the application context associated with 
.A display
with the conversion cache type specified as XtCacheByDisplay, the converter 
has been previously called with the specified arguments, and the 
conversion failed a call to
Boolean XtCallConverter(display, converter, args, num_args, 
from, to_in_out, cache_ref_return)
shall return False immediately.
>>CODE

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tcalcnvtr10", "XtCallConverter");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Register resource converter XtCVT2b_StringToChar");
	XtAppSetTypeConverter(app_ctext,
		 XtRString,
		 XavsRUnknown,
		 XtCVT2b_StringToChar,
		 (XtConvertArgList)NULL,
		 (Cardinal)0,
		 XtCacheByDisplay|XtCacheRefCount,
		 (XtDestructor)NULL);
	tet_infoline("TEST: Invoke resource converter XtCVT2b_StringToChar");
	init_args();
	status = XtCallConverter(display_good,
		XtCVT2b_StringToChar,
		(XrmValuePtr)NULL,
		(Cardinal)0,
		&from,
		&to_in_out,
		&cache_ref_return
		);
	tet_infoline("TEST: Return value was false");
	check_dec(False, status, "XtCallConverter return value");
	tet_infoline("TEST: Convertor was invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtCVT2b_StringToChar invoked count");
	tet_infoline("TEST: Re-Invoke resource converter with same values");
	init_args();
	status = XtCallConverter(display_good,
		XtCVT2b_StringToChar,
		(XrmValuePtr)NULL,
		(Cardinal)0,
		&from,
		&to_in_out,
		&cache_ref_return
		);
	tet_infoline("TEST: Return value was false");
	check_dec(False, status, "XtCallConverter return value");
	tet_infoline("TEST: Convertor was not invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtCVT2b_StringToChar invoked count");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When the type converter 
.A converter
has been registered for the application context associated with 
.A display
with the conversion cache type specified as XtCacheByDisplay, the converter 
has been previously called with the specified arguments, the conversion
succeeded, and the size specified by the to_in_out argument is greater
than or equal to the size stored in the conversion cache a call to
Boolean XtCallConverter(display, converter, args, num_args, 
from, to_in_out, cache_ref_return)
shall copy the information stored in the conversion cache into the 
location specified by to_in_out->addr, copy the size specified in the
conversion cache into to_in_out->size, and return True.
>>CODE

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tcalcnvtr11", "XtCallConverter");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Register resource converter XtCVT3b_StringToChar");
	XtAppSetTypeConverter(app_ctext,
		 XtRString,
		 XavsRChar,
		 XtCVT3b_StringToChar,
		 (XtConvertArgList)NULL,
		 (Cardinal)0,
		 XtCacheByDisplay|XtCacheRefCount,
		 (XtDestructor)NULL);
	tet_infoline("TEST: Invoke resource converter XtCVT3b_StringToChar");
	init_args();
	status = XtCallConverter(display_good,
		XtCVT3b_StringToChar,
		(XrmValuePtr)NULL,
		(Cardinal)0,
		&from,
		&to_in_out,
		&cache_ref_return
		);
	tet_infoline("TEST: Procedure XtCVT3b_StringToChar was invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtCVT3b_StringToChar invoked count");
	tet_infoline("TEST: Result returned first time");
	check_dec((long) 'H', (long) *(unsigned char*)to_in_out.addr,
		"Character");
	tet_infoline("TEST: Re-invoke with same arguments");
	init_args();
	to_in_out.size = sizeof(unsigned char) +1;
	status = XtCallConverter(display_good,
		XtCVT3b_StringToChar,
		(XrmValuePtr)NULL,
		(Cardinal)0,
		&from,
		&to_in_out,
		&cache_ref_return
		);
	tet_infoline("TEST: Return value");
	check_dec(True, status, "XtCallConverter return value");
	tet_infoline("TEST: Convertor was not invoked");
	invoked = avs_get_event(1);
	tet_infoline("TEST: Result returned second time");
	check_dec((long) 'H', (long) *(unsigned char*)to_in_out.addr, "Character");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When the type converter 
.A converter
has been registered for the application context associated with 
.A display
with the conversion cache type specified as XtCacheByDisplay, the 
converter has been previously called with the specified arguments, 
the conversion succeeded, and the size specified by the to_in_out 
argument is less than the size stored in the conversion cache a call to
Boolean XtCallConverter(display, converter, args, num_args, 
from, to_in_out, cache_ref_return)
shall copy the size specified in the conversion cache into 
to_in_out->size and return False.
>>CODE

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tcalcnvtr12", "XtCallConverter");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Register resource converter XtCVT4b_StringToChar");
	XtAppSetTypeConverter(app_ctext,
		 XtRString,
		 XavsRChar,
		 XtCVT4b_StringToChar,
		 (XtConvertArgList)NULL,
		 (Cardinal)0,
		 XtCacheByDisplay|XtCacheRefCount,
		 (XtDestructor)NULL);
	tet_infoline("TEST: Invoke resource converter XtCVT4b_StringToChar");
	init_args();
	status = XtCallConverter(display_good,
		XtCVT4b_StringToChar,
		(XrmValuePtr)NULL,
		(Cardinal)0,
		&from,
		&to_in_out,
		&cache_ref_return
		);
	tet_infoline("TEST: Procedure XtCVT4b_StringToChar was invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtCVT4b_StringToChar invoked count");
	tet_infoline("TEST: Result returned first time");
	check_dec((long) 'H', (long) *(unsigned char*)to_in_out.addr,
		"Character");
	tet_infoline("TEST: Re-invoke with short size");
	init_args();
	to_in_out.size = 0;
	status = XtCallConverter(display_good,
		XtCVT4b_StringToChar,
		(XrmValuePtr)NULL,
		(Cardinal)0,
		&from,
		&to_in_out,
		&cache_ref_return
		);
	tet_infoline("TEST: Return value");
	check_dec(False, status, "XtCallConverter return value");
	tet_infoline("TEST: Convertor was not invoked");
	invoked = avs_get_event(1);
	tet_infoline("TEST: Size returned");
	check_dec((long)sizeof(unsigned char), (long)to_in_out.size, "to_in_out.size");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When the type converter 
.A converter
has not been registered for the application context associated with 
.A display
and the converter has not been previously called with the specified 
arguments a call to
Boolean XtCallConverter(display, converter, args, num_args, 
from, to_in_out, cache_ref_return)
shall call the converter, enter the result into the conversion cache, 
store the converted value into the location specified by
to_in_out->addr, and return what the converter returns.
>>CODE

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tcalcnvtr5", "XtCallConverter");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Invoke resource converter XtCVT1a_StringToChar");
	init_args();
	status = XtCallConverter(display_good,
		XtCVT1a_StringToChar,
		(XrmValuePtr)NULL,
		(Cardinal)0,
		&from,
		&to_in_out,
		&cache_ref_return
		);
	tet_infoline("TEST: Return value");
	check_dec(True, status, "XtCallConverter return value");
	tet_infoline("TEST: Procedure XtCVT1a_StringToChar was invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtCVT1a_StringToChar invoked count");
	tet_infoline("TEST: Result returned");
	check_dec((long) 'H', (long) *(unsigned char*)to_in_out.addr, "Character");
	tet_infoline("TEST: Re-Invoke resource converter with same values");
	init_args();
	status = XtCallConverter(display_good,
		XtCVT1a_StringToChar,
		(XrmValuePtr)NULL,
		(Cardinal)0,
		&from,
		&to_in_out,
		&cache_ref_return
		);
	tet_infoline("TEST: Return value");
	check_dec(True, status, "XtCallConverter return value");
	tet_infoline("TEST: Procedure XtCVT1a_StringToChar was not invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtCVT1a_StringToChar invoked count");
	tet_infoline("TEST: Result returned");
	check_dec((long) 'H', (long) *(unsigned char*)to_in_out.addr, "Character");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When the type converter 
.A converter
has not been registered for the application context associated with 
.A display, 
the converter has been previously called with the specified arguments, 
and the conversion failed a call to
Boolean XtCallConverter(display, converter, args, num_args, 
from, to_in_out, cache_ref_return)
shall return False immediately.
>>CODE

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tcalcnvtr6", "XtCallConverter");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Invoke resource converter XtCVT2a_StringToChar");
	init_args();
	status = XtCallConverter(display_good,
		XtCVT2a_StringToChar,
		(XrmValuePtr)NULL,
		(Cardinal)0,
		&from,
		&to_in_out,
		&cache_ref_return
		);
	tet_infoline("TEST: Return value was false");
	check_dec(False, status, "XtCallConverter return value");
	tet_infoline("TEST: Convertor was invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtCVT2a_StringToChar invoked count");
	tet_infoline("TEST: Re-Invoke resource converter with same values");
	init_args();
	status = XtCallConverter(display_good,
		XtCVT2a_StringToChar,
		(XrmValuePtr)NULL,
		(Cardinal)0,
		&from,
		&to_in_out,
		&cache_ref_return
		);
	tet_infoline("TEST: Return value was false");
	check_dec(False, status, "XtCallConverter return value");
	tet_infoline("TEST: Convertor was not invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtCVT2a_StringToChar invoked count");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When the type converter 
.A converter
has not been registered for the application context associated with 
.A display, 
the converter has been previously called with the specified arguments, 
the conversion succeeded, and the size specified by the to_in_out 
argument is greater than or equal to the size stored in the conversion 
cache a call to
Boolean XtCallConverter(display, converter, args, num_args, 
from, to_in_out, cache_ref_return)
shall copy the information stored in the conversion cache into the 
location specified by to_in_out->addr, copy the size specified in the
conversion cache into to_in_out->size, and return True.
>>CODE

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tcalcnvtr7", "XtCallConverter");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Invoke resource converter XtCVT3a_StringToChar");
	display_good = XtDisplay(topLevel);
	init_args();
	status = XtCallConverter(display_good,
		XtCVT3a_StringToChar,
		(XrmValuePtr)NULL,
		(Cardinal)0,
		&from,
		&to_in_out,
		&cache_ref_return
		);
	tet_infoline("TEST: Return value");
	check_dec(True, status, "XtCallConverter return value");
	tet_infoline("TEST: Procedure XtCVT3a_StringToChar was invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtCVT3a_StringToChar invoked count");
	tet_infoline("TEST: Result returned");
	check_dec((long) 'H', (long) *(unsigned char*)to_in_out.addr, "Character");
	tet_infoline("TEST: Re-Invoke resource converter with same values");
	init_args();
	to_in_out.size = sizeof(unsigned char) +1;
	status = XtCallConverter(display_good,
		XtCVT3a_StringToChar,
		(XrmValuePtr)NULL,
		(Cardinal)0,
		&from,
		&to_in_out,
		&cache_ref_return
		);
	tet_infoline("TEST: Return value");
	check_dec(True, status, "XtCallConverter return value");
	tet_infoline("TEST: Procedure XtCVT3a_StringToChar was not invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtCVT3a_StringToChar invoked count");
	tet_infoline("TEST: Result returned");
	check_dec((long) 'H', (long) *(unsigned char*)to_in_out.addr, "Character");
	tet_infoline("TEST: Size returned");
	check_dec((long)sizeof(unsigned char), (long)to_in_out.size, "to_in_out.size");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When the type converter 
.A converter
has not been registered for the application context associated with 
.A display, 
the converter has been previously called with the specified arguments, 
the conversion succeeded, and the size specified by the to_in_out 
argument is less than the size stored in the conversion cache 
a call to
Boolean XtCallConverter(display, converter, args, num_args, 
from, to_in_out, cache_ref_return)
shall copy the size specified in the conversion cache into 
to_in_out->size and return False.
>>CODE

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tcalcnvtr8", "XtCallConverter");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Invoke resource converter XtCVT4a_StringToChar");
	init_args();
	status = XtCallConverter(display_good,
		XtCVT4a_StringToChar,
		(XrmValuePtr)NULL,
		(Cardinal)0,
		&from,
		&to_in_out,
		&cache_ref_return
		);
	tet_infoline("TEST: Return value");
	check_dec(True, status, "XtCallConverter return value");
	tet_infoline("TEST: Procedure XtCVT4a_StringToChar was invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtCVT4a_StringToChar invoked count");
	tet_infoline("TEST: Result returned");
	check_dec((long) 'H', (long) *(unsigned char*)to_in_out.addr, "Character");
	tet_infoline("TEST: Re-Invoke resource converter with short size");
	init_args();
	to_in_out.size = 0;
	status = XtCallConverter(display_good,
		XtCVT4a_StringToChar,
		(XrmValuePtr)NULL,
		(Cardinal)0,
		&from,
		&to_in_out,
		&cache_ref_return
		);
	tet_infoline("TEST: Return value");
	check_dec(False, status, "XtCallConverter return value");
	tet_infoline("TEST: Procedure XtCVT4a_StringToChar was not invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtCVT4a_StringToChar invoked count");
	tet_infoline("TEST: Size returned");
	check_dec((long)sizeof(unsigned char), (long)to_in_out.size, "to_in_out.size");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good B 1
When the type converter 
.A converter
has been registered for the application context associated with 
.A display
with the cache type set to XtCacheAll and XtCacheRefCount and 
.A cache_ref_return
is not NULL a call to
Boolean XtCallConverter(display, converter, args, num_args, 
from, to_in_out, cache_ref_return)
shall store a conversion cache id into the location specified by
.A cache_ref_return.
>>ASSERTION Good B 1
When the type converter 
.A converter
has been registered for the application context associated with 
.A display
with the cache type set to XtCacheByDisplay and XtCacheRefCount and 
.A cache_ref_return
is not NULL a call to
Boolean XtCallConverter(display, converter, args, num_args, 
from, to_in_out, cache_ref_return)
shall store a conversion cache id into the location specified by
.A cache_ref_return.
