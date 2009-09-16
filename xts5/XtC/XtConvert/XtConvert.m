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
$Header: /cvs/xtest/xtest/xts5/tset/XtC/XtConvert/XtConvert.m,v 1.1 2005-02-12 14:38:24 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/XtC/XtConvert/XtConvert.m
>># 
>># Description:
>>#	Tests for XtConvert()
>># 
>># Modifications:
>># $Log: tconvert.m,v $
>># Revision 1.1  2005-02-12 14:38:24  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:38:34  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:37  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:29:36  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:26:09  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:22:51  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:19:32  andy
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

#define XavsRUnknown	"UnknownResource"

void XtWMH_Proc(str1, str2, str3, str4, str5, car)
String str1, str2, str3, str4, *str5;
Cardinal *car;
{
	avs_set_event(1,1);
}
	
void XtCVT1_StringToChar(args, num_args, from_val, to_val)
XrmValuePtr args;
Cardinal *num_args;
XrmValue *from_val;
XrmValue *to_val;
{
	char *str = (char *) (from_val->addr);
	static unsigned char i;
	to_val->size = sizeof (unsigned char);
	to_val->addr = (XtPointer) &i;
	i = *str;
	avs_set_event(1, 1);
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtConvert XtC
void
XtConvert(w, from_type, from, to_type, to_return)
>>ASSERTION Good A
When a converter has been registered for a conversion from
.A from_type
to
.A to_type
for
.A w
a successful call to
void XtConvert(w, from_type, from, to_type, to_return)
shall call the converter and store the converted value returned 
into the location specified by to_return->addr.
>>CODE
Display *display_good;
XrmValue from;
XrmValue to_in_out;
XtCacheRef cache_ref_return;
int invoked = 0;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tconvert1", "XtConvert");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Register resource converter XtCVT1_StringToChar");
	XtAppAddConverter(app_ctext,
		 XtRString,
		 XavsRChar,
		 XtCVT1_StringToChar,
		 (XtConvertArgList)NULL,
		 (Cardinal)0);
	tet_infoline("TEST: Invoke resource converter XtCVT1_StringToChar");
	from.addr = (XtPointer) "Hello";
	from.size = sizeof(unsigned char);
	XtConvert(topLevel,
		XtRString,	
		&from,
		XavsRChar,
		&to_in_out
		);
	tet_infoline("TEST: Check the result returned");
	check_char('H', *(char *)to_in_out.addr, "conversion result");
	tet_infoline("TEST: Check procedure XtCVT1_StringToChar was invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtCVT1_StringToChar invoked status");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>># >>ASSERTION Good A
>># If a call to 
>># void XtConvert(object, from_type, from, to_type to_return )
>># fails to_return.addr shall be NULL.
>># >>CODE
>># Display *display_good;
>># XrmValue from;
>># XrmValue to_in_out;
>># XtCacheRef cache_ref_return;
>># int invoked = 0;
>># int status;
>># pid_t pid2;
>># 
>># 	FORK(pid2);
>># 	avs_xt_hier("Tconvert2", "XtConvert");
>># 	XtAppSetWarningMsgHandler(app_ctext, XtWMH_Proc);
>># 	tet_infoline("PREP: Create windows for widgets and map them");
>># 	XtRealizeWidget(topLevel);
>># 	tet_infoline("TEST: Unknown resource shall return NULL");
>># 	from.addr = (XtPointer) "Hello";
>># 	from.size = sizeof(unsigned char);
>># 	XtConvert(topLevel,
>># 		 XtRString,
>># 		 &from,
>># 		 XavsRUnknown,
>># 		 &to_in_out
>># 		 );
>># 	if (to_in_out.addr != NULL) {
>># 		tet_infoline("ERROR: Returned address was not NULL");
>># 		tet_result(TET_FAIL);
>># 	}
>># 	LKROF(pid2, AVSXTTIMEOUT-2);
>># 	tet_infoline("TEST: Warning handler is called");
>># 	status = avs_get_event(1);
>># 	check_dec(1, status, "calls to warning handler count");
>># 	tet_result(TET_PASS);
