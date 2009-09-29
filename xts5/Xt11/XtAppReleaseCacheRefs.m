Copyright (c) 2005 X.Org Foundation L.L.C.

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
>># File: xts/Xt11/XtAppReleaseCacheRefs.m
>># 
>># Description:
>>#	Tests for XtAppReleaseCacheRefs()
>># 
>># Modifications:
>># $Log: taprelcre.m,v $
>># Revision 1.2  2005-04-21 09:40:42  ajosey
>># resync to VSW5.1.5
>>#
>># Revision 8.1  1999/04/05 22:28:03  mar
>># req.4.W.00138: tp2 - destructor should not free to_val.  The Intrinsics handle
>># it internally (it happens to be a stack variable).
>>#
>># Revision 8.0  1998/12/23 23:37:36  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:00:33  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:28:40  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:25:15  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:19:59  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:14:49  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;

XrmValue from;
XrmValue to_in_out;

unsigned char tochar;

char buf[32];

void init_args()
{
	from.addr = (XtPointer) "Hello";
	from.size = strlen(from.addr)+1;
	to_in_out.addr = (XtPointer)&tochar;
	to_in_out.size = sizeof(unsigned char);
}

#ifndef XavsRChar
#define XavsRChar "Char"
#endif
Boolean XtCVT_Proc(display, args, num_args, from_val, to_val, converter_data)
Display *display;
XrmValuePtr args;
Cardinal *num_args;
XrmValue *from_val;
XrmValue *to_val;
XtPointer *converter_data;
{
	/*
	** Conveter to convert String to Char
	*/
	char *str = (char *) (from_val->addr);
	static unsigned char i;
	avs_set_event(1,avs_get_event(1)+1);
	to_val->size = sizeof (unsigned char);
	to_val->addr = (XtPointer) &i;
	i = *str;
	return True;
}
void XtDES_Proc(app_ctext, to_val, converter_data, args, num_args )
XtAppContext	app_ctext;
XrmValue *to_val;
XtPointer converter_data;
XrmValue *args;
Cardinal *num_args;
{
	avs_set_event(2,avs_get_event(2)+1);
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtAppReleaseCacheRefs Xt11
void
XtAppReleaseCacheRefs(app_context, refs)
>>ASSERTION Good A
A successful call to 
void XtAppReleaseCacheRefs(app_context, refs)
shall decrement the
reference count for each conversion entry in the list specified by
.A refs.
>>CODE
XtCacheRef cache_ref_return1[2], cache_ref_return2[2];
int status1, status2;
Boolean flag;
Display *display_good;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Taprelcre1", "XtSetTypeConverter");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Register resource converter and destructor");
	XtAppSetTypeConverter(app_ctext,
		 XtRString,
		 XavsRChar,
		 XtCVT_Proc,
		 (XtConvertArgList)NULL,
		 (Cardinal)0,
		 XtCacheAll|XtCacheRefCount,
		 XtDES_Proc);
	tet_infoline("TEST: Invoke resource converter twice");
	display_good = XtDisplay(topLevel);
	init_args();
	flag = XtCallConverter(display_good,
		XtCVT_Proc,
		(XrmValuePtr)NULL,
		(Cardinal)0,
		&from,
		&to_in_out,
		&(cache_ref_return1[0])
		);
	check_dec(True, flag, "return value");
	flag = XtCallConverter(display_good,
		XtCVT_Proc,
		(XrmValuePtr)NULL,
		(Cardinal)0,
		&from,
		&to_in_out,
		&(cache_ref_return2[0])
		);
	cache_ref_return1[1] = 0;
	cache_ref_return2[1] = 0;
	check_dec(True, flag, "return value");
	tet_infoline("TEST: Resource converter was invoked");
	status1 = avs_get_event(1);
	check_dec(1, status1, "Resource converter invoked count");
	tet_infoline("TEST: Release the cached resource value");
	XtAppReleaseCacheRefs(app_ctext, cache_ref_return1);
	tet_infoline("TEST: Resource destructor was not invoked");
	status2 = avs_get_event(2);
	check_dec(0, status2, "Resource destructor invoked count");
	tet_infoline("TEST: Release the cached resource value again");
	XtAppReleaseCacheRefs(app_ctext, cache_ref_return2);
	tet_infoline("TEST: Resource destructor was invoked");
	status2 = avs_get_event(2);
	check_dec(1, status2, "Resource destructor invoked count");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to 
void XtAppReleaseCacheRefs(app_context, refs)
shall call the destructor procedure and remove the resource 
from the conversion cache for any conversion entry in
.A refs
that reaches a conversion count of zero.
>>CODE
XtCacheRef cache_ref_return1[2], cache_ref_return2[2];
int status1, status2;
Boolean flag;
Display *display_good;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Taprelcre1", "XtSetTypeConverter");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Register resource converter and destructor");
	XtAppSetTypeConverter(app_ctext,
		 XtRString,
		 XavsRChar,
		 XtCVT_Proc,
		 (XtConvertArgList)NULL,
		 (Cardinal)0,
		 XtCacheAll|XtCacheRefCount,
		 XtDES_Proc);
	tet_infoline("TEST: Invoke resource converter twice");
	display_good = XtDisplay(topLevel);
	init_args();
	flag = XtCallConverter(display_good,
		XtCVT_Proc,
		(XrmValuePtr)NULL,
		(Cardinal)0,
		&from,
		&to_in_out,
		&(cache_ref_return1[0])
		);
	check_dec(True, flag, "return value");
	flag = XtCallConverter(display_good,
		XtCVT_Proc,
		(XrmValuePtr)NULL,
		(Cardinal)0,
		&from,
		&to_in_out,
		&(cache_ref_return2[0])
		);
	cache_ref_return1[1] = 0;
	cache_ref_return2[1] = 0;
	check_dec(True, flag, "return value");
	tet_infoline("TEST: Resource converter was invoked");
	status1 = avs_get_event(1);
	check_dec(1, status1, "Resource converter invoked count");
	tet_infoline("TEST: Release the cached resource value");
	XtAppReleaseCacheRefs(app_ctext, cache_ref_return1);
	tet_infoline("TEST: Release the cached resource value again");
	XtAppReleaseCacheRefs(app_ctext, cache_ref_return2);
	tet_infoline("TEST: Resource destructor was invoked");
	status2 = avs_get_event(2);
	check_dec(1, status2, "Resource destructor invoked count");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
