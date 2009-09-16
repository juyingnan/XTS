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
>># File: tset/XtC/XtStringConversionWarning/XtStringConversionWarning.m
>># 
>># Description:
>>#	Tests for XtStringConversionWarning()
>># 
>># Modifications:
>># $Log: tstconwg.m,v $
>># Revision 1.1  2005-02-12 14:38:25  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:38:32  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:36  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:29:34  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:26:08  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:22:45  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:19:25  andy
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

/*
** Installed Warning handler
*/
void XtWMH_Proc(name, type, class, defaultp, params, num_params)
String name, type, class, defaultp, *params;
Cardinal *num_params;
{
	tet_infoline("TEST: Warning handler parameters");
	check_str("conversionError", name, "name");
	check_str("string", type, "type");
	check_str("XtToolkitError", class, "class");
	sprintf(ebuf, defaultp, *params, *(params+1));
	check_str("Cannot convert string \"String\" to type Int", ebuf, "default message");
	avs_set_event(1,1);
}

void XtCVT_StringToChar(args, num_args, from_val, to_val)
XrmValue *args;
Cardinal *num_args;
XrmValue *from_val;
XrmValue *to_val;
{
	char *str = (char *) (from_val->addr);
	static unsigned char i;
	to_val->size = sizeof (unsigned char);
	to_val->addr = (XtPointer) &i;
	i = *str;
	/*
	** Force warning message
	*/
	XtStringConversionWarning("String", "Int");
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtStringConversionWarning XtC
void
XtStringConversionWarning(src, dst_type)
>>ASSERTION Good A
A call to
void XtStringConversionWarning(src, dst_type)
shall issue a warning message with the name
.S conversionError,
type
.S string,
class
.S XtToolkitError
and the default messages string
.S Cannot convert "src" to type "dst_type".
>>CODE
Display *display_good;
XrmValue from;
XrmValue to_in_out;
XtCacheRef cache_ref_return;
int invoked = 0;
char line[80], buf[80];
char file_name[1024];
FILE *stream;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tstconwgw1", "XtStringConversionWarning");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Catch warning messages");
	XtSetWarningMsgHandler(XtWMH_Proc);
	tet_infoline("PREP: Register resource converter XtCVT_StringToChar");
	XtAddConverter(XtRString,
		 XavsRChar,
		 XtCVT_StringToChar,
		 (XtConvertArgList)NULL,
		 (Cardinal) 0);
	tet_infoline("PREP: Invoke resource converter XtCVT_StringToChar");
	display_good = XtDisplay(topLevel);
	from.addr = (XtPointer) "Hello";
	from.size = sizeof(unsigned char);
	XtDirectConvert(XtCVT_StringToChar,
		(XrmValuePtr)NULL,
		(Cardinal)0,
		&from,
		&to_in_out
		);
	tet_infoline("TEST: Procedure XtWMH_Proc was invoked");
	invoked = avs_get_event(1);
	if (!invoked) {
		sprintf(ebuf, "ERROR: Procedure XtWMH_Proc was not invoked");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
