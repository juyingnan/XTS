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
$Header: /cvs/xtest/xtest/xts5/tset/XtC/XtDirectConvert/XtDirectConvert.m,v 1.1 2005-02-12 14:38:24 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/XtC/XtDirectConvert/XtDirectConvert.m
>># 
>># Description:
>>#	Tests for XtDirectConvert()
>># 
>># Modifications:
>># $Log: tdircnvrt.m,v $
>># Revision 1.1  2005-02-12 14:38:24  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:38:34  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:38  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:29:36  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:26:10  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:22:52  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:19:34  andy
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
void XtCVT_StringToChar(args, num_args, from_val, to_val)
XrmValuePtr args;
Cardinal *num_args;
XrmValue *from_val;
XrmValue *to_val;
{
	char *str = (char *) (from_val->addr);
	static unsigned char i;
	avs_set_event(1, 1);
	to_val->size = sizeof (unsigned char);
	to_val->addr = (XtPointer) &i;
	i = *str;
}
void XtCVT_StringToChar2(args, num_args, from_val, to_val)
XrmValuePtr args;
Cardinal *num_args;
XrmValue *from_val;
XrmValue *to_val;
{
	avs_set_event(1, 1);
	to_val->size = 0;
	to_val->addr = NULL;
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtDirectConvert XtC
void
XtDirectConvert(converter, args, num_args, from, to_return)
>>ASSERTION Good A
A successful call to 
void XtDirectConvert(converter, args, num_args, from, to_return)
when the converter
.A converter
has not been previously called with the specified arguments 
shall call the converter, store the results in the cache, and 
return the converted value in the location pointed to by
.A to_return->addr.
>>CODE
Display *display_good;
XrmValue from;
XrmValue to_in_out;
XtCacheRef cache_ref_return;
int invoked = 0;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tdircnvrt1", "XtDirectConvert");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Register resource converter XtCVT_StringToChar");
	XtAppAddConverter(app_ctext,
		 XtRString,
		 XavsRChar,
		 XtCVT_StringToChar,
		 (XtConvertArgList)NULL,
		 (Cardinal)0);
	tet_infoline("PREP: Invoke resource converter XtCVT_StringToChar");
	from.addr = (XtPointer) "Hello";
	from.size = sizeof(unsigned char);
	XtDirectConvert(XtCVT_StringToChar,
		(XrmValuePtr)NULL,
		(Cardinal)0,
		&from,
		&to_in_out
		);
	tet_infoline("TEST: Result returned");
	check_char('H', *(char *)to_in_out.addr, "conversion result");
	tet_infoline("TEST: Procedure XtCVT_StringToChar was invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtCVT_StringToChar invocations count");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good B 2
A successful call to 
void XtDirectConvert(converter, args, num_args, from, to_return)
when the converter
.A converter
has been previously called with the specified arguments 
shall return a descriptor for information stored in cache in
.A to_return.
>>ASSERTION Good A
When it fails to carry out the conversion a call to
void XtDirectConvert(converter, args, num_args, from, to_return)
shall set
.A to_return->size
to zero and
.A to_return->addr
to NULL.
>>CODE
Display *display_good;
XrmValue from;
XrmValue to_in_out;
XtCacheRef cache_ref_return;
int invoked = 0;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tdircnvrt1", "XtDirectConvert");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Register resource converter XtCVT_StringToChar2");
	XtAppAddConverter(app_ctext,
		 XtRString,
		 XavsRChar,
		 XtCVT_StringToChar2,
		 (XtConvertArgList)NULL,
		 (Cardinal)0);
	tet_infoline("PREP: Invoke resource converter XtCVT_StringToChar2");
	from.addr = (XtPointer) "Hello";
	from.size = sizeof(unsigned char);
	XtDirectConvert(XtCVT_StringToChar2,
		(XrmValuePtr)NULL,
		(Cardinal)0,
		&from,
		&to_in_out
		);
	tet_infoline("TEST: Procedure XtCVT_StringToChar was invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtCVT_StringToChar invocations count");
	tet_infoline("TEST: to_in_out.addr = NULL");
	if (to_in_out.addr != NULL) {
		tet_infoline("ERROR: to_in_out.addr != NULL");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: to_in_out.size = 0");
	check_dec(0, to_in_out.size, "to_in_out.size");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
