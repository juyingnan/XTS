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
$Header: /cvs/xtest/xtest/xts5/tset/Xt13/tnewstrg/tnewstrg.m,v 1.1 2005-02-12 14:37:58 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt13/tnewstrg/tnewstrg.m
>># 
>># Description:
>>#	Tests for XtNewString()
>># 
>># Modifications:
>># $Log: tnewstrg.m,v $
>># Revision 1.1  2005-02-12 14:37:58  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:38:08  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:08  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:29:11  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:25:45  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:21:31  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:17:31  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;

char *array;

void XtEM_Proc(str, str2, str3, str4, str5, car)
String str, str2, str3, str4, *str5;
Cardinal *car;
{
	XtFree(array);
	avs_set_event(1,1);
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtNewString Xt13
String
XtNewString(string)
>>ASSERTION Good A
A successful call to 
String XtNewString(string) 
shall allocate storage for a new string instance, copy 
the string pointed to by
.A string
into the newly allocated storage, and return a pointer to 
the allocated storage.
>>CODE
char label[80];
String ptr;
static char string[] = "Hello World";
pid_t pid2;

	FORK(pid2);
	tet_infoline("PREP: Initialize toolkit, Open display and Create topLevel root widget");
	topLevel = (Widget) avs_xt_init("Tnewstrg1", NULL, 0);
	tet_infoline("PREP: Set up the XtToolkitError handler");
	app_ctext = XtWidgetToApplicationContext(topLevel);
	XtAppSetErrorMsgHandler(app_ctext, xt_handler);
	tet_infoline("TEST: XtNewString shall copy an instance of a string");
	ptr = XtNewString(string);
	check_str("Hello World", ptr, "Instance String");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When there is insufficient memory to allocate storage for
a new string instance a call to 
String XtNewString(string) 
shall issue an allocError error and return NULL.
>>CODE
Widget topLevel;
unsigned int num;
int status;
unsigned int size = 14;
String ptr;
static char string[] = "Hello World";
pid_t pid2;

	FORK(pid2);
	tet_infoline("PREP: Initialize toolkit, Open display and Create topLevel root widget");
	topLevel = (Widget) avs_xt_init("Tnewstrg2", NULL, 0);
	tet_infoline("PREP: Set up the XtToolkitError handler");
	app_ctext = XtWidgetToApplicationContext(topLevel);
	XtAppSetErrorMsgHandler(app_ctext, &XtEM_Proc);
	tet_infoline("PREP: Malloc available memory.");
	num = mem_limit();
	array = (char *) XtCalloc(num, 4);
	tet_infoline("TEST: XtString shall call XtErrorMsg");
	ptr = XtNewString(string);
	status = avs_get_event(1);
	if (status != 1) {
		tet_infoline("ERROR: Error message handler was not called");
		tet_result(TET_FAIL);
		avs_set_event(1,0);
	}
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good B 2
The order and contiguity of the storage allocated by 
successive calls to
String XtNewString(string).
>>ASSERTION Good B 1
A successful call to
String XtNewString(string) 
shall return a pointer to an object that is disjoint from
any other object.
>>ASSERTION Good B 1
The pointer returned by a successful call to
String XtNewString(string) 
shall point to the lowest byte address of the 
allocated space.
