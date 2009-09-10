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
$Header: /cvs/xtest/xtest/xts5/tset/Xt11/XtCallbackReleaseCacheRefList/XtCallbackReleaseCacheRefList.m,v 1.1 2005-02-12 14:37:51 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt11/XtCallbackReleaseCacheRefList/XtCallbackReleaseCacheRefList.m
>># 
>># Description:
>>#	Tests for XtCallbackReleaseCacheRefList()
>># 
>># Modifications:
>># $Log: tcalbrcrl.m,v $
>># Revision 1.1  2005-02-12 14:37:51  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:37:48  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:00:45  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:28:51  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:25:25  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:20:30  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:15:31  andy
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
	if (!to_val->addr) {
		to_val->size = sizeof (unsigned char);
		to_val->addr = (XtPointer) &i;
	}
	if (to_val->size < sizeof(unsigned char))
		return False;
	*((unsigned char *)to_val->addr) = (unsigned char) *str;
	return True;
}

void XtDES_Proc(app_ctext, to_val, converter_data, args, num_args )
XtAppContext	app_ctext;
XrmValue *to_val;
XtPointer converter_data;
XrmValuePtr args;
Cardinal *num_args;
{
	avs_set_event(1,avs_get_event(1)+1);
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtCallbackReleaseCacheRefList Xt11
void
XtCallbackReleaseCacheRefList(object, client_data, call_data)
>>ASSERTION Good A
When added to a callback list with
.A client_data
specified as a pointer to a NULL-terminated list of XtCacheRef values
and later invoked,
void XtCallbackReleaseCacheRefList(object, client_data, call_data)
shall decrement the reference counts for the conversion entries
specified by
.A client_data.
>>CODE
Display *display_good;
XrmValue from, from_val;
XrmValue to_in_out;
XrmValue to_return;
XtCacheRef cache_ref_return[3], cache_ref;
Boolean status;
XtPointer client_data;
pid_t pid2;
unsigned char tchar;

	FORK(pid2);
	avs_xt_hier("Tcalbrcrl1", "XtCallbackReleaseCacheRefList");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Register resource converter");
	XtAppSetTypeConverter(app_ctext,
		 XtRString,
		 XavsRChar,
		 XtCVT_StringToChar,
		 (XtConvertArgList)NULL,
		 (Cardinal)0,
		 XtCacheRefCount,
		 XtDES_Proc);
	tet_infoline("PREP: Invoke converter twice to cache resources");
	display_good = XtDisplay(topLevel);
	from.addr = (XtPointer)"Hello";
	from.size = strlen(from.addr) + 1;
	to_in_out.size = sizeof(unsigned char);
	to_in_out.addr = (XtPointer)&tchar;
	status = XtCallConverter(display_good,
		XtCVT_StringToChar,
		(XrmValuePtr)NULL,
		(Cardinal)0,
		&from,
		&to_in_out,
		&cache_ref_return[0]
		);
	status = XtCallConverter(display_good,
		XtCVT_StringToChar,
		(XrmValuePtr)NULL,
		(Cardinal)0,
		&from,
		&to_in_out,
		&cache_ref_return[1]
		);
	cache_ref_return[2] = (XtCacheRef) NULL;
	tet_infoline("TEST: Invoke XtCallbackReleaseCacheRefList callback");
	XtAddCallback(topLevel, XtNdestroyCallback, XtCallbackReleaseCacheRefList, (XtPointer)cache_ref_return);
	XtCallCallbacks(topLevel, XtNdestroyCallback, (XtPointer)NULL);
	tet_infoline("TEST: Destructor is invoked once");
	check_dec(1, status, "destructor invocation count");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
