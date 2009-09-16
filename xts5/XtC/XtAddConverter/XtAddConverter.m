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
>># File: tset/XtC/XtAddConverter/XtAddConverter.m
>># 
>># Description:
>>#	Tests for XtAddConverter()
>># 
>># Modifications:
>># $Log: tadconvtr.m,v $
>># Revision 1.1  2005-02-12 14:38:24  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:38:33  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:36  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.1  1998/08/07 19:32:20  andy
>># Adjusted casts for argument data retrieval to handle 64-bit implementations.
>>#
>># Revision 6.0  1998/03/02 05:29:35  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:26:08  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:22:47  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:19:27  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>
#include <AvsRectObj.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;

#ifndef XavsRChar
#define XavsRChar "Char"
#endif
void XtCVT_Proc(args, num_args, from_val, to_val)
XrmValue* args;
Cardinal *num_args;
XrmValue *from_val;
XrmValue *to_val;
{
	/*
	** Convert string to character 
	*/
	char *str = (char *) (from_val->addr);
	static unsigned char i;
	avs_set_event(1, avs_get_event(1)+1);
	to_val->size = sizeof (unsigned char);
	to_val->addr = (XtPointer) &i;
	i = *str;
}
void XtCVT_Proc10(args, num_args, from_val, to_val)
XrmValue* args;
Cardinal *num_args;
XrmValue *from_val;
XrmValue *to_val;
{
	/*
	** Convert string to character 
	*/
	char *str = (char *) (from_val->addr);
	static unsigned char i;
	avs_set_event(2, 1);
	to_val->size = sizeof (unsigned char);
	to_val->addr = (XtPointer) &i;
	i = *str;
}

#define NUMARGS 8
XtConvertArgRec cargs[NUMARGS];
int argdata[NUMARGS] = {
	0,	/*don't care*/
	2002,
	0,	
	4004,
	0,	
	0,	
	0,	
	8008	
};

void xcap(w, size, value)
Widget w;
Cardinal *size;
XrmValue *value;
{
	avs_set_event(2, avs_get_event(2)+1);
	value->addr = (XtPointer)&argdata[7];
	value->size = sizeof(argdata[7]);
}

void init_args(checknum)
int checknum;
{
	cargs[0].address_mode = XtImmediate;
	cargs[0].address_id = (XtPointer)checknum;
	cargs[0].size = sizeof(XtPointer);

/*XtAddress*/
	cargs[1].address_mode = XtAddress;
	cargs[1].address_id = (XtPointer)&argdata[1];
	cargs[1].size = sizeof(XtPointer);

/*XtBaseOffset*/
	cargs[2].address_mode = XtBaseOffset;
	cargs[2].address_id = (XtPointer)XtOffset(Widget, core.screen);
	cargs[2].size = sizeof(Screen*);

/*XtImmediate*/
	cargs[3].address_mode = XtImmediate;
	cargs[3].address_id = (XtPointer)argdata[3];
	cargs[3].size = sizeof(XtPointer);

/*XtResourceString*/
	cargs[4].address_mode = XtImmediate;
	cargs[4].address_id = (XtPointer)argdata[4];
	cargs[4].size = sizeof(XtPointer);

/*XtResourceQuark*/
	cargs[5].address_mode = XtImmediate;
	cargs[5].address_id = (XtPointer)argdata[5];
	cargs[5].size = sizeof(XtPointer);

/*XtWidgetBaseOffset*/
	cargs[6].address_mode = XtWidgetBaseOffset;
	cargs[6].address_id = (XtPointer)XtOffset(Widget, core.self);
	cargs[6].size = sizeof(Widget);

/*XtProcedureArg*/
	cargs[7].address_mode = XtProcedureArg;
	cargs[7].address_id = (XtPointer)xcap;
	cargs[7].size = sizeof(XtPointer);
}

void XtCVT_ProcA(args, num_args, from_val, to_val)
XrmValuePtr args;
Cardinal *num_args;
XrmValue *from_val;
XrmValue *to_val;
{
int	checknum;

	avs_set_event(1, avs_get_event(1)+1);
	tet_infoline("TEST: Additional arguments passed to converter");
	if (*num_args != NUMARGS) {
		sprintf(ebuf, "ERROR: expected %d arguments, received %d", NUMARGS, *num_args);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
		return;
	}

	checknum = (int)(*(XPointer *)args[0].addr);

	if (checknum == 0) {
		tet_infoline("ERROR: args[0].addr = 0");
		tet_result(TET_FAIL);
		return;
	}
	if (checknum > NUMARGS) {
		sprintf(ebuf, "ERROR: args[0].addr = %d, should be < %d", checknum, NUMARGS);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
		return;
	}
	if (args[checknum].addr == NULL) {
		sprintf(ebuf, "ERROR: args[%d].addr = NULL", checknum);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
		return;
	}

	switch (checknum) {
	case 1:
	case 7:
		if (((int)*(int *)args[checknum].addr) != argdata[checknum]) {
			sprintf(ebuf, "ERROR: expected args[%d].addr to point to %d points to %d", checknum, argdata[checknum], ((int)*(int *)args[checknum].addr));
			tet_infoline(ebuf);
			tet_result(TET_FAIL);
			return;
		}
		break;
	case 2:
		if (((Screen*)*(Screen**)args[checknum].addr) != topLevel->core.screen) {
			sprintf(ebuf, "ERROR: expected args[%d].addr to point to %p points to %p", checknum, topLevel->core.screen, ((Screen*)*(Screen**)args[checknum].addr));
			tet_infoline(ebuf);
			tet_result(TET_FAIL);
			return;
		}
		break;
	case 3:
		if (((int)*(XPointer *)args[checknum].addr) != argdata[checknum]) {
			sprintf(ebuf, "ERROR: expected args[%d].addr to point to %d points to %d", checknum, argdata[checknum], ((int)*(XPointer *)args[checknum].addr));
			tet_infoline(ebuf);
			tet_result(TET_FAIL);
			return;
		}
		break;
	case 6:
		if (((Widget)*(Widget*)args[checknum].addr) != topLevel->core.self) {
			sprintf(ebuf, "ERROR: expected args[%d].addr to point to %p points to %p", checknum, topLevel->core.self, ((Widget)*(Widget*)args[checknum].addr));
			tet_infoline(ebuf);
			tet_result(TET_FAIL);
			return;
		}
		break;
	default:
		sprintf(ebuf, "ERROR: Unknown argument type %d", checknum);
		tet_infoline(ebuf);
		tet_result(TET_UNRESOLVED);
		return;
	}
	return;
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtAddConverter XtC
void
XtAddConverter(from_type, to_type, converter, convert_args, num_args)
>>ASSERTION Good A
A successful call to 
void XtAddConverter(from_type, to_type, converter, 
convert_args, num_args)
shall register 
.A converter 
as the procedure that will be called by the Intrinsics 
to convert a resource value from the representation type
.A from_type
to the type
.A to_type
in all application contexts created by the calling process,
including any future application contexts that may be created.
>>CODE
Display *display_good;
XrmValue from;
XrmValue to_in_out;
XtCacheRef cache_ref_return;
int status = 0;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tadconvtr1", "XtAddConverter");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Register resource converter XtCVT_Proc");
	XtAddConverter(XtRString,
			XavsRChar,
			XtCVT_Proc,
			(XtConvertArgList)NULL,
			(Cardinal)0);
	tet_infoline("TEST: Invoke resource converter XtCVT_Proc");
	from.addr = (XtPointer) "Hello";
	from.size = sizeof(unsigned char);
	XtDirectConvert(XtCVT_Proc,
		(XrmValuePtr) NULL,
		(Cardinal)0,
		&from,
		&to_in_out);
	tet_infoline("TEST: Converted results");
	check_char('H', *(char *)to_in_out.addr, "conversion result");
	XtCloseDisplay(XtDisplay(topLevel));
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Check procedure XtCVT_Proc was invoked");
	status = avs_get_event(1);
	check_dec(1, status, "XtCVT_Proc invocations count");
	tet_result(TET_PASS);
>>ASSERTION Good A
When more than one converter is registered for the same 
.A from_type 
and 
.A to_type 
by multiple calls to 
void XtAddConverter(from_type, to_type, converter, 
convert_args, num_args)
the most recently registered converter shall 
override the previous ones.
>>CODE
Display *display_good;
XrmValue from;
XrmValue to_in_out;
XtCacheRef cache_ref_return;
int status = 0;
pid_t pid2;
char	thechar;

	FORK(pid2);
	avs_xt_hier("Tadconvtr1", "XtAddConverter");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Register resource converter XtCVT_Proc");
	XtAddConverter(XtRString,
			XavsRChar,
			XtCVT_Proc,
			(XtConvertArgList)NULL,
			(Cardinal)0);
	tet_infoline("TEST: Register XtCVT_Proc10 for same conversion");
	XtAddConverter(XtRString,
			XavsRChar,
			XtCVT_Proc10,
			(XtConvertArgList)NULL,
			(Cardinal)0);
	tet_infoline("TEST: Invoke resource converter XtCVT_Proc");
	from.addr = (XtPointer) "Hello";
	from.size = sizeof(unsigned char);
	to_in_out.addr = &thechar;
	to_in_out.size = sizeof(char);
	XtConvertAndStore(topLevel,
		XtRString,
		&from,
		XavsRChar,
		&to_in_out);
	tet_infoline("TEST: Converted results");
	check_char('H', *(char *)to_in_out.addr, "conversion result");
	XtCloseDisplay(XtDisplay(topLevel));
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Check procedure XtCVT_Proc was not invoked");
	status = avs_get_event(1);
	check_dec(0, status, "XtCVT_Proc invocations count");
	tet_infoline("TEST: Check procedure XtCVT_Proc10 not invoked");
	status = avs_get_event(2);
	check_dec(1, status, "XtCVT_Proc10 invocations count");
	tet_result(TET_PASS);
>>ASSERTION Good A
On a call to
void XtAddConverter(from_type, to_type, converter, 
convert_args, num_args)
the converter procedure shall be registered such that
the results of a previous conversion will be reused 
for subsequent resource requests with the same source 
value and conversion arguments.
>>CODE
Display *display_good;
XrmValue from;
XrmValue to_in_out;
XtCacheRef cache_ref_return;
int status = 0;
pid_t pid2;
char	thechar;
char *thestring = "Hello";

	FORK(pid2);
	avs_xt_hier("Tadconvtr1", "XtAddConverter");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Register resource converter XtCVT_Proc");
	XtAddConverter(XtRString,
			XavsRChar,
			XtCVT_Proc,
			(XtConvertArgList)NULL,
			(Cardinal)0);
	tet_infoline("TEST: Invoke resource converter XtCVT_Proc");
	from.addr = thestring;
	from.size = sizeof(String);
	to_in_out.addr = &thechar;
	to_in_out.size = sizeof(char);
	XtConvertAndStore(topLevel,
		XtRString,
		&from,
		XavsRChar,
		&to_in_out);
	tet_infoline("TEST: Reinvoke resource converter with same arguments");
	from.addr = thestring;
	from.size = sizeof(String);
	to_in_out.addr = &thechar;
	to_in_out.size = sizeof(char);
	XtConvertAndStore(topLevel,
		XtRString,
		&from,
		XavsRChar,
		&to_in_out);
	tet_infoline("TEST: Converted results");
	check_char('H', *(char *)to_in_out.addr, "conversion result");
	XtCloseDisplay(XtDisplay(topLevel));
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Convertor was invoked just once");
	status = avs_get_event(1);
	check_dec(1, status, "XtCVT_Proc invocations count");
	tet_result(TET_PASS);
>>ASSERTION Good A
When a converter is registered by a call to
void XtAddConverter(from_type, to_type, converter, 
convert_args, num_args)
with the address_mode member of an XtConvertArgRec 
structure in the list pointed to by
.A convert_args
set to XtAddress it shall be called by the Intrinsics 
with the data pointed to by the address_id field  
passed as a conversion argument.
>>CODE
Display *display_good;
XrmValue from;
XrmValue to_in_out;
XtCacheRef cache_ref_return;
int status = 0;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tadconvtr1", "XtAddConverter");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Register resource converter");
	init_args(1);
	XtAddConverter(XtRString,
		XavsRChar,
		XtCVT_ProcA,
		(XtConvertArgList)cargs,
		(Cardinal)NUMARGS);
	tet_infoline("TEST: Invoke conversion");
	from.addr = (XtPointer) "Hello";
	from.size = sizeof(unsigned char);
	XtConvertAndStore(
		topLevel,
		XtRString,
		&from,
		XavsRChar,
		&to_in_out
		);
	XtCloseDisplay(XtDisplay(topLevel));
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Converter was invoked");
	status = avs_get_event(1);
	check_dec(1, status, "converter invocations count");
	tet_result(TET_PASS);
>>ASSERTION Good A
When a converter is registered by a call to
void XtAddConverter(from_type, to_type, converter, 
convert_args, num_args)
with the address_mode member of an XtConvertArgRec 
structure in the list pointed to by
.A convert_args
set to XtBaseOffset it shall be called by the Intrinsics with the 
data at an offset of address_id from the base of the widget, in whose 
context the converter is invoked, passed as a conversion argument.
>>CODE
Display *display_good;
XrmValue from;
XrmValue to_in_out;
XtCacheRef cache_ref_return;
int status = 0;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tadconvtr1", "XtAddConverter");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Register resource converter");
	init_args(2);
	XtAddConverter(XtRString,
		XavsRChar,
		XtCVT_ProcA,
		(XtConvertArgList)cargs,
		(Cardinal)NUMARGS);
	tet_infoline("TEST: Invoke conversion");
	from.addr = (XtPointer) "Hello";
	from.size = sizeof(unsigned char);
	XtConvertAndStore(
		topLevel,
		XtRString,
		&from,
		XavsRChar,
		&to_in_out
		);
	XtCloseDisplay(XtDisplay(topLevel));
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Converter was invoked");
	status = avs_get_event(1);
	check_dec(1, status, "converter invocations count");
	tet_result(TET_PASS);
>>ASSERTION Good A
When a converter is registered by a call to
void XtAddConverter(from_type, to_type, converter, 
convert_args, num_args)
with the address_mode
member of an XtConvertArgRec structure in the list 
pointed to by
.A convert_args
set to XtImmediate it shall be called by the Intrinsics with 
the data in the address_id field passed as a conversion
argument.
>>CODE
Display *display_good;
XrmValue from;
XrmValue to_in_out;
XtCacheRef cache_ref_return;
int status = 0;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tadconvtr1", "XtAddConverter");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Register resource converter");
	init_args(3);
	XtAddConverter(XtRString,
		XavsRChar,
		XtCVT_ProcA,
		(XtConvertArgList)cargs,
		(Cardinal)NUMARGS);
	tet_infoline("TEST: Invoke conversion");
	from.addr = (XtPointer) "Hello";
	from.size = sizeof(unsigned char);
	XtConvertAndStore(
		topLevel,
		XtRString,
		&from,
		XavsRChar,
		&to_in_out
		);
	XtCloseDisplay(XtDisplay(topLevel));
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Converter was invoked");
	status = avs_get_event(1);
	check_dec(1, status, "converter invocations count");
	tet_result(TET_PASS);
>>ASSERTION Good B 0
When a converter is registered by a call to
void XtAddConverter(from_type, to_type, converter, 
convert_args, num_args)
with the address_mode member of an XtConvertArgRec 
structure in the list pointed to by
.A convert_args
set to XtResourceString it shall be called 
by the Intrinsics with the value of the resource for the widget
that is named by the address_id passed as a conversion argument.
>>ASSERTION Good B 0
When a converter is registered by a call to
void XtAddConverter(from_type, to_type, converter, 
convert_args, num_args)
with the address_mode
member of an XtConvertArgRec structure in 
the list pointed to by
.A convert_args
set to XtResourceQuark it shall be called 
by the Intrinsics with the offset of the resource 
from the base of the widget, in whose context the 
converter is invoked, for the resource string 
specified by the quark value in the address_id field 
passed as a conversion argument.
>>ASSERTION Good A
When a converter is registered by a call to
void XtAddConverter(from_type, to_type, converter, 
convert_args, num_args)
with the address_mode
member of an XtConvertArgRec structure in the 
list pointed to by
.A convert_args
set to XtWidgetBaseOffset it shall be called 
by the Intrinsics with the data at an offset 
of address_id in the closest windowed ancestor 
of the widget in whose context the converter is called, 
when the widget is not of a subclass of Core, 
passed as a conversion argument.
>>CODE
Display *display_good;
XrmValue from;
XrmValue to_in_out;
XtCacheRef cache_ref_return;
int status = 0;
pid_t pid2;
Widget test_widget;

	FORK(pid2);
	avs_xt_hier("Tadconvtr1", "XtAddConverter");
        tet_infoline("PREP: Create AVS RectObj widget");
        test_widget = XtVaCreateManagedWidget("avsro", avsrectObjClass, topLevel, NULL);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Register resource converter");
	init_args(6);
	XtAddConverter(XtRString,
		XavsRChar,
		XtCVT_ProcA,
		(XtConvertArgList)cargs,
		(Cardinal)NUMARGS);
	tet_infoline("TEST: Invoke conversion");
	from.addr = (XtPointer) "Hello";
	from.size = sizeof(unsigned char);
	XtConvertAndStore(
		test_widget,
		XtRString,
		&from,
		XavsRChar,
		&to_in_out
		);
	XtCloseDisplay(XtDisplay(topLevel));
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Converter was invoked");
	status = avs_get_event(1);
	check_dec(1, status, "converter invocations count");
	tet_result(TET_PASS);
>>ASSERTION Good A
When a converter is registered by a call to
void XtAddConverter(from_type, to_type, converter, 
convert_args, num_args)
with the address_mode
member of an XtConvertArgRec structure in the list pointed to by
.A convert_args
set to XtProcedureArg it shall be called by the Intrinsics with the 
value returned by the function pointed to by the address_id field 
passed as a conversion argument.
>>CODE
Display *display_good;
XrmValue from;
XrmValue to_in_out;
XtCacheRef cache_ref_return;
int status = 0;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tadconvtr1", "XtAddConverter");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Register resource converter");
	init_args(7);
	XtAddConverter(XtRString,
		XavsRChar,
		XtCVT_ProcA,
		(XtConvertArgList)cargs,
		(Cardinal)NUMARGS);
	tet_infoline("TEST: Invoke conversion");
	from.addr = (XtPointer) "Hello";
	from.size = sizeof(unsigned char);
	XtConvertAndStore(
		topLevel,
		XtRString,
		&from,
		XavsRChar,
		&to_in_out
		);
	XtCloseDisplay(XtDisplay(topLevel));
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Converter was invoked");
	status = avs_get_event(1);
	check_dec(1, status, "converter invocations count");
	tet_infoline("TEST: function was invoked");
	status = avs_get_event(2);
	check_dec(1, status, "function invocation count");
	tet_result(TET_PASS);
