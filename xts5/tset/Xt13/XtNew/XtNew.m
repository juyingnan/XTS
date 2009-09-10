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
$Header: /cvs/xtest/xtest/xts5/tset/Xt13/XtNew/XtNew.m,v 1.2 2005-04-21 09:40:42 ajosey Exp $

Copyright (c) 2004 The Open Group
Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt13/XtNew/XtNew.m
>># 
>># Description:
>>#	Tests for XtNew()
>># 
>># Modifications:
>># $Log: tnew.m,v $
>># Revision 1.2  2005-04-21 09:40:42  ajosey
>># resync to VSW5.1.5
>>#
>># Revision 8.2  2005/01/14 12:12:39  gwc
>># Updated copyright notice
>>#
>># Revision 8.1  2004/02/12 17:01:08  gwc
>># Changed num to size_t in test 2
>>#
>># Revision 8.0  1998/12/23 23:38:08  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:08  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:29:10  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:25:44  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:21:30  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:17:29  andy
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
>>TITLE XtNew Xt13
String
XtNew(type)
>>ASSERTION Good A
A call to 
type *XtNew(type) 
shall allocate storage for a new instance of type 
.A type
and return a pointer to the allocated storage.
>>CODE
Widget topLevel;
char *ptr;
pid_t pid2;

	FORK(pid2);
	tet_infoline("PREP: Initialize toolkit, Open display and Create topLevel root widget");
	topLevel = (Widget) avs_xt_init("Tnew1", NULL, 0);
	tet_infoline("PREP: Set up the XtToolkitError handler");
	app_ctext = XtWidgetToApplicationContext(topLevel);
	XtAppSetErrorMsgHandler(app_ctext, xt_handler);
	tet_infoline("TEST: XtNew shall allocate storage for type");
	ptr = XtNew(char);
	/*actually will likely get a SIGSEGV if there's a problem*/
	*ptr = 2;
	if (*ptr != 2) {
		tet_infoline("ERROR: Storage not allocated correctly");
		tet_result(TET_FAIL);
	}
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When there is insufficient memory to allocate storage for the
new instance of type
.A type
a call to
type *XtNew(type) 
shall issue an allocError error and return NULL.
>>CODE
Widget topLevel;
size_t num;
int status;
char *ptr;
pid_t pid2;

	FORK(pid2);
	tet_infoline("PREP: Initialize toolkit, Open display and Create topLevel root widget");
	topLevel = (Widget) avs_xt_init("Tnew2", NULL, 0);
	tet_infoline("PREP: Set up the XtToolkitError handler");
	app_ctext = XtWidgetToApplicationContext(topLevel);
	XtAppSetErrorMsgHandler(app_ctext, &XtEM_Proc);
	tet_infoline("PREP: Malloc available memory");
	num = mem_limit();
	array = (char *) XtCalloc(num, 4);
	tet_infoline("TEST: XtNew shall call XtErrorMsg");
	ptr = XtNew(char);
	status = avs_get_event(1);
	if (status != 1) {
		tet_infoline("ERROR: Error message handler was not called");
		tet_result(TET_FAIL);
	}
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good B 2
The order and contiguity of the storage allocated by 
successive calls to
type *XtNew(type).
>>ASSERTION Good B 1
A successful call to
type *XtNew(type) 
shall return a pointer to an object that is disjoint from
any other object.
>>ASSERTION Good B 1
The pointer returned by a successful call to
type *XtNew(type) 
shall point to the lowest byte address of the 
allocated space.
