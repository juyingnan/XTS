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
>># File: xts/Xt3/XtCheckSubclass/XtCheckSubclass.m
>># 
>># Description:
>>#	Tests for XtIsSubclass()
>># 
>># Modifications:
>># $Log: tchcksbcls.m,v $
>># Revision 1.1  2005-02-12 14:37:59  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:36:12  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:59:01  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:27:24  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:23:57  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:15:27  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:19:06  andy
>># Prepare for GA Release
>>#
>>CFILES Test12.c Test3.c
>>EXTERN
/* Toolkit definitions */
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>
#include <AvsComp.h>
#include <X11/Xaw/Label.h>
#include <X11/Xaw/Command.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;

void XtEM_Proc(name, type, class, defaulttp, params, num_params)
String name, type, class, defaulttp, *params;
Cardinal *num_params;
{
String par[10];
int i;
char buffer[1000];
	avs_set_event(1,1);
        XtGetErrorDatabaseText(name, type, class, defaulttp, buffer, 1000);
        i = *num_params;
        memmove((char *)par, (char *)params, i*sizeof(String));
        memset(&par[i], 0, (10-i)*sizeof(String));
        sprintf(ebuf, buffer, par[0], par[1], par[2], par[3], par[4], par[5], par[6], par[7], par[8],par[9]);
	tet_infoline("TEST: Error message contains message passed to XtCheckSubClass");
	if (strstr(ebuf, "ApTest") == NULL) {
		tet_infoline("ERROR: Error message does not contain message passed to XtCheckSubClass");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Error message contains object's actual class");
	if (strstr(ebuf, "Label") == NULL) {
		tet_infoline("ERROR: Error message does not contain object's actual class");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Error message contains expected class");
	if (strstr(ebuf, "Command") == NULL) {
		tet_infoline("ERROR: Error message does not contain expected class");
		tet_result(TET_FAIL);
	}
}

void XtEM_Proc2(name, type, class, defaulttp, params, num_params)
String name, type, class, defaulttp, *params;
Cardinal *num_params;
{
	avs_set_event(1,1);
}

void test1sub();
void test2sub();
void test3sub();
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtCheckSubclass Xt3
Boolean
XtCheckSubclass(w, widget_class, message)
>>ASSERTION Good A
A call to void XtCheckSubclass(w, widget_class, message) when the class 
of the widget w is neither equal to nor is a subclass of the class 
widget_class shall construct an error message from message, widget_class, 
and the actual class of w and call XtErrorMsg().
>>CODE

	test1sub();
>>ASSERTION Good A
A call to void XtCheckSubclass(w, widget_class, message) when the class 
of the widget w is equal to or is a subclass of the class widget_class 
shall not generate an error message.
>>CODE

	test2sub();
>>ASSERTION Good A
When a module is not compiled with the compiler symbol DEBUG defined
a call to void XtCheckSubclass(w, widget_class, message) shall result 
in no code to be executed.
>>CODE

	test3sub();
