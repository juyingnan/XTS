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

Copyright (c) 1999,2002 The Open Group
Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: xts/XtC/XtAppAddConverter/XtAppAddConverter.m
>># 
>># Description:
>>#	Tests for XtAppAddConverter()
>># 
>># Modifications:
>># $Log: tapadconv.m,v $
>># Revision 1.2  2005-04-21 09:40:42  ajosey
>># resync to VSW5.1.5
>>#
>># Revision 8.3  2005/01/21 12:27:09  gwc
>># Updated copyright notice
>>#
>># Revision 8.2  2002/11/27 15:50:34  gwc
>># TSD4W.00173: separate case 3 in XtCVT_ProcA()
>>#
>># Revision 8.1  1999/11/24 16:11:32  vsx
>># req.4.W.00142: 64-bit problem passing int values using XtImmediate
>>#
>># Revision 8.0  1998/12/23 23:38:33  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:37  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.1  1998/03/25 18:21:35  andy
>># Added initializeation of to_in_out parameter to XtConvertAndStore calls. SR 174.
>>#
>># Revision 6.0  1998/03/02 05:29:35  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:26:09  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:22:49  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:19:30  andy
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
void XtCVT_Proc2(args, num_args, from_val, to_val)
XrmValuePtr args;
Cardinal *num_args;
XrmValue *from_val;
XrmValue *to_val;
{
	char *str = (char *) (from_val->addr);
	static unsigned char i;
 
	/*
	** Convert string to char 
	*/
	avs_set_event(2, 1);
	to_val->size = sizeof (unsigned char);
	to_val->addr = (XtPointer) &i;
	i = *str;
}

void XtCVT_Proc(args, num_args, from_val, to_val)
XrmValuePtr args;
Cardinal *num_args;
XrmValue *from_val;
XrmValue *to_val;
{
	char *str = (char *) (from_val->addr);
	static unsigned char j;
 
	/*
	** Convert string to char 
	*/
	avs_set_event(1, 1);
	to_val->size = sizeof (unsigned char);
	to_val->addr = (XtPointer) &j;
	j = *str;
}

void XtCVT_Proc3(args, num_args, from_val, to_val)
XrmValuePtr args;
Cardinal *num_args;
XrmValue *from_val;
XrmValue *to_val;
{
	avs_set_event(1, avs_get_event(1)+1);
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

void init_args(pchecknum)
int *pchecknum;
{
	cargs[0].address_mode = XtAddress;
	cargs[0].address_id = (XtPointer)pchecknum;
	cargs[0].size = sizeof(XtPointer);

/*XtAddress*/
	cargs[1].address_mode = XtAddress;
	cargs[1].address_id = (XtPointer)&argdata[1];
	cargs[1].size = sizeof(XtPointer);

/*XtBaseOffset*/
	cargs[2].address_mode = XtBaseOffset;
	cargs[2].address_id = (XtPointer)XtOffset(Widget, core.screen);
	cargs[2].size = sizeof(Screen *);

/*XtImmediate*/
	cargs[3].address_mode = XtImmediate;
	cargs[3].address_id = (XtPointer)argdata[3];
	cargs[3].size = sizeof(argdata[3]);

/*XtResourceString*/
	cargs[4].address_mode = XtImmediate;
	cargs[4].address_id = (XtPointer)argdata[4];
	cargs[4].size = sizeof(argdata[4]);

/*XtResourceQuark*/
	cargs[5].address_mode = XtImmediate;
	cargs[5].address_id = (XtPointer)argdata[5];
	cargs[5].size = sizeof(argdata[5]);

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

	checknum = (int)(*(int *)args[0].addr);

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
>>TITLE XtAppAddConverter XtC
void
XtAppAddConverter(app_context, from_type, to_type, converter, convert_args, num_args)
>>ASSERTION Good A
A successful call to 
void XtAppAddConverter(app_context, from_type, to_type, 
converter, convert_args, num_args)
shall register 
.A converter 
as the procedure that will be called by the Intrinsics 
to convert a resource value from the representation type
.A from_type
to the type
.A to_type
in the application context
.A app_context
of the calling process.
>>CODE
Display *display_good;
XrmValue from;
XrmValue to_in_out;
XtCacheRef cache_ref_return;
int status;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tapadconv1", "XtAppAddConverter");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Register resource converter XtCVT_Proc");
	XtAppAddConverter(app_ctext,
		 XtRString,
		 XavsRChar,
		 XtCVT_Proc,
		 (XtConvertArgList)NULL,
		 (Cardinal)0);
	tet_infoline("TEST: Invoke resource converter XtCVT_Proc");
	from.addr = (XtPointer) "Hello";
	from.size = sizeof(unsigned char);
	XtDirectConvert(XtCVT_Proc, (XrmValuePtr)NULL, (Cardinal)0, &from, &to_in_out);
	tet_infoline("TEST: Procedure XtCVT_Proc was invoked");
	status = avs_get_event(1);
	check_dec(1, status, "XtCVT_Proc invocation count");
	tet_infoline("TEST: Converted results");
	check_char('H', *(char *)to_in_out.addr, "conversion result");
	XtCloseDisplay(XtDisplay(topLevel));
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When more than one converter is registered for the same
.A from_type
and
.A to_type
by multiple calls to
void XtAppAddConverter(app_context, from_type, to_type, 
converter, convert_args, num_args)
the most recently registered converter shall 
override the previous ones.
>>CODE
Display *display_good;
XrmValue from;
XrmValue to_in_out;
char	charret;
XtCacheRef cache_ref_return;
int status;
pid_t pid2;

	FORK(pid2);
	avs_set_event(1, 0);
	avs_set_event(2, 0);
	avs_xt_hier("Tapadconv1", "XtAppAddConverter");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Register resource converter XtCVT_Proc2");
	XtAppAddConverter(app_ctext,
		 XtRString,
		 XavsRChar,
		 XtCVT_Proc2,
		 (XtConvertArgList)NULL,
		 (Cardinal)0);
	tet_infoline("TEST: Register XtCVT_Proc for same conversion");
	XtAppAddConverter(app_ctext,
		 XtRString,
		 XavsRChar,
		 XtCVT_Proc,
		 (XtConvertArgList)NULL,
		 (Cardinal)0);
	tet_infoline("TEST: Invoke conversion");
	from.addr = (XtPointer) "Hello";
	from.size = sizeof(unsigned char);
	to_in_out.addr = &charret;
	to_in_out.size = 1;
	XtConvertAndStore(
		topLevel,
		XtRString,
		&from,
		XavsRChar,
		&to_in_out);
	tet_infoline("TEST: Converted results");
	check_char('H', *(char *)to_in_out.addr, "conversion result");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Procedure XtCVT_Proc2 was not invoked");
	status = avs_get_event(2);
	check_dec(0, status, "XtCVT_Proc2 invocation count");
	tet_infoline("TEST: Procedure XtCVT_Proc was invoked");
	status = avs_get_event(1);
	check_dec(1, status, "XtCVT_Proc invocation count");
	tet_result(TET_PASS);
>>ASSERTION Good A
On a call to
void XtAppAddConverter(app_context, from_type, to_type, 
converter, convert_args, num_args)
the converter procedure shall be registered such that
the results of a a previous conversion will be reused for subsequent
resource requests with the same source value and conversion arguments.
>>CODE
Display *display_good;
XrmValue from;
XrmValue to_in_out;
XtCacheRef cache_ref_return;
int status;
pid_t pid2;
char thechar[2]={0,0};
char *thestring = "Hello";

	FORK(pid2);
	avs_xt_hier("Tapadconv1", "XtAppAddConverter");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Register resource converter XtCVT_Proc3");
	XtAppAddConverter(app_ctext,
		 XtRString,
		 XavsRChar,
		 XtCVT_Proc3,
		 (XtConvertArgList)NULL,
		 (Cardinal)0);
	tet_infoline("TEST: Invoke conversion");
	from.addr = thestring;
	from.size = strlen(thestring)+1;
	to_in_out.addr = thechar;
	to_in_out.size = sizeof(char);
	XtDirectConvert(XtCVT_Proc3, (XrmValuePtr)NULL, (Cardinal)0, &from, &to_in_out);
	tet_infoline("TEST: Invoke conversion again with same arguments");
	from.addr = thestring;
	from.size = strlen(thestring)+1;
	to_in_out.addr = thechar;
	to_in_out.size = sizeof(char);
	XtDirectConvert(XtCVT_Proc3, (XrmValuePtr)NULL, (Cardinal)0, &from, &to_in_out);
	tet_infoline("TEST: Procedure XtCVT_Proc3 was invoked only once");
	status = avs_get_event(1);
	check_dec(1, status, "XtCVT_Proc3 invocation count");
	XtCloseDisplay(XtDisplay(topLevel));
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When a converter is registered by a call to
void XtAppAddConverter(app_context, from_type, to_type, 
converter, convert_args, num_args)
with the address_mode
member of an XtConvertArgRec structure in the list pointed to by
.A convert_args
set to XtAddress it shall be called by the Intrinsics with the 
data pointed to by the address_id field  passed as a conversion 
argument.
>>CODE
Display *display_good;
XrmValue from;
XrmValue to_in_out;
XtCacheRef cache_ref_return;
int status;
int checknum;
pid_t pid2;
char	charret;

	FORK(pid2);
	avs_xt_hier("Tapadconv1", "XtAppAddConverter");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Register resource converter");
	checknum = 1;
	init_args(&checknum);
	XtAppAddConverter(app_ctext,
		 XtRString,
		 XavsRChar,
		XtCVT_ProcA,
		(XtConvertArgList)cargs,
		(Cardinal)NUMARGS);
	tet_infoline("TEST: Invoke conversion");
	from.addr = (XtPointer) "Hello";
	from.size = sizeof(unsigned char);
	to_in_out.addr = &charret;
	to_in_out.size = 1;
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
	check_dec(1, status, "converter invocation count");
	tet_result(TET_PASS);
>>ASSERTION Good A
When a converter is registered by a call to
void XtAppAddConverter(app_context, from_type, to_type, 
converter, convert_args, num_args)
with the address_mode
member of an XtConvertArgRec structure in the list pointed to by
.A convert_args
set to XtBaseOffset it shall be called by the Intrinsics with the 
data at an offset of address_id from the base of the widget, in whose 
context the converter is invoked, passed as a conversion argument.
>>CODE
Display *display_good;
XrmValue from;
XrmValue to_in_out;
XtCacheRef cache_ref_return;
int status;
int checknum;
pid_t pid2;
char	charret;

	FORK(pid2);
	avs_xt_hier("Tapadconv1", "XtAppAddConverter");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Register resource converter");
	checknum = 2;
	init_args(&checknum);
	XtAppAddConverter(app_ctext,
		 XtRString,
		 XavsRChar,
		XtCVT_ProcA,
		(XtConvertArgList)cargs,
		(Cardinal)NUMARGS);
	tet_infoline("TEST: Invoke conversion");
	from.addr = (XtPointer) "Hello";
	from.size = sizeof(unsigned char);
	to_in_out.addr = &charret;
	to_in_out.size = 1;
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
	check_dec(1, status, "converter invocation count");
	tet_result(TET_PASS);
>>ASSERTION Good A
When a converter is registered by a call to
void XtAppAddConverter(app_context, from_type, to_type, 
converter, convert_args, num_args)
with the address_mode
member of an XtConvertArgRec structure in the list pointed to by
.A convert_args
set to XtImmediate it shall be called by the Intrinsics with 
the data in the address_id field passed as a conversion
argument.
>>CODE
Display *display_good;
XrmValue from;
XrmValue to_in_out;
char	charret;
XtCacheRef cache_ref_return;
int status;
int checknum;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tapadconv1", "XtAppAddConverter");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Register resource converter");
	checknum = 3;
	init_args(&checknum);
	XtAppAddConverter(app_ctext,
		 XtRString,
		 XavsRChar,
		XtCVT_ProcA,
		(XtConvertArgList)cargs,
		(Cardinal)NUMARGS);
	tet_infoline("TEST: Invoke conversion");
	from.addr = (XtPointer) "Hello";
	from.size = sizeof(unsigned char);
	to_in_out.addr = &charret;
	to_in_out.size = 1;
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
	check_dec(1, status, "converter invocation count");
	tet_result(TET_PASS);
>>ASSERTION Good B 0
When a converter is registered by a call to
void XtAppAddConverter(app_context, from_type, to_type, 
converter, convert_args, num_args)
with the address_mode
member of an XtConvertArgRec structure in the list pointed to by
.A convert_args
set to XtResourceString it shall be called by the Intrinsics 
with the value of the resource for the widget named by the string
pointed to by address_id passed as a conversion argument.
>>ASSERTION Good B 0
When a converter is registered by a call to
void XtAppAddConverter(app_context, from_type, to_type, 
converter, convert_args, num_args)
with the address_mode
member of an XtConvertArgRec structure in the list pointed to by
.A convert_args
set to XtResourceQuark it shall be called by the Intrinsics with the
value of the resource for the widget, in whose context 
the converter is invoked, for the resource string specified by the 
quark value in the address_id field passed as a conversion argument.
>>ASSERTION Good A
When a converter is registered by a call to
void XtAppAddConverter(app_context, from_type, to_type, 
converter, convert_args, num_args)
with the address_mode
member of an XtConvertArgRec structure in the list pointed to by
.A convert_args
set to XtWidgetBaseOffset it shall be called by the Intrinsics with 
the data at an offset of address_id in the closest windowed
ancestor of the widget in whose context the converter is called, 
when the widget is not of a subclass of Core, passed as a conversion 
argument.
>>CODE
Display *display_good;
XrmValue from;
XrmValue to_in_out;
char	charret;
XtCacheRef cache_ref_return;
int status;
int checknum;
pid_t pid2;
Widget test_widget;

	FORK(pid2);
	avs_xt_hier("Tapadconv1", "XtAppAddConverter");
        tet_infoline("PREP: Create AVS RectObj widget");
        test_widget = XtVaCreateManagedWidget("avsro", avsrectObjClass, topLevel, NULL);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Register resource converter");
	checknum = 7;
	init_args(&checknum);
	XtAppAddConverter(app_ctext,
		 XtRString,
		 XavsRChar,
		XtCVT_ProcA,
		(XtConvertArgList)cargs,
		(Cardinal)NUMARGS);
	tet_infoline("TEST: Invoke conversion");
	from.addr = (XtPointer) "Hello";
	from.size = sizeof(unsigned char);
	to_in_out.addr = &charret;
	to_in_out.size = 1;
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
	check_dec(1, status, "converter invocation count");
	tet_infoline("TEST: function was invoked");
	status = avs_get_event(2);
	check_dec(1, status, "function invocation count");
	tet_result(TET_PASS);
>>ASSERTION Good A
When a converter is registered by a call to
void XtAppAddConverter(app_context, from_type, to_type, 
converter, convert_args, num_args)
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
char	charret;
XtCacheRef cache_ref_return;
int status;
int checknum;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tapadconv1", "XtAppAddConverter");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Register resource converter");
	checknum = 7;
	init_args(&checknum);
	XtAppAddConverter(app_ctext,
		 XtRString,
		 XavsRChar,
		XtCVT_ProcA,
		(XtConvertArgList)cargs,
		(Cardinal)NUMARGS);
	tet_infoline("TEST: Invoke conversion");
	from.addr = (XtPointer) "Hello";
	from.size = sizeof(unsigned char);
	to_in_out.addr = &charret;
	to_in_out.size = 1;
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
	check_dec(1, status, "converter invocation count");
	tet_infoline("TEST: function was invoked");
	status = avs_get_event(2);
	check_dec(1, status, "function invocation count");
	tet_result(TET_PASS);
