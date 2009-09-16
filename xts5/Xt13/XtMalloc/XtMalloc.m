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
>># File: xts/Xt13/XtMalloc/XtMalloc.m
>># 
>># Description:
>>#	Tests for XtMalloc()
>># 
>># Modifications:
>># $Log: tmalloc.m,v $
>># Revision 1.1  2005-02-12 14:37:58  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:38:06  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:06  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.1  1998/07/01 00:58:54  andy
>># tet_infolines were being called when all memory had been malloc-ed
>># causing tcm errors when TET tried to malloc a buffer for the message.
>># Moved the infolines to avoid this.
>>#
>># Revision 6.0  1998/03/02 05:29:09  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:25:42  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:21:25  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:17:22  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;

extern void alloc_handler();
extern int alloc_handler_called;
>>TITLE XtMalloc Xt13
char *
XtMalloc(size)
>>ASSERTION Good A
A successful call to 
char *XtMalloc(size)
shall return a pointer to a block of storage of at least 
.A size 
bytes.
>>CODE
char *ptr, *ptr1;
size_t max_limit;
int i;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tmalloc1", "XtMalloc");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Determine largest malloc");
	max_limit = mem_limit();
	tet_infoline("TEST: Allocate memory");
	ptr = (char *) XtMalloc(max_limit);
	if (ptr == (char *)0) {
		sprintf(ebuf, "ERROR: Malloc could not allocate %d bytes", max_limit);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	XtFree(ptr);
	tet_infoline("CLEANUP: Free memory");
 
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When there is insufficient memory to allocate the requested
block a call to 
char *XtMalloc(size) 
shall issue an allocError error and return NULL.
>>CODE
char *ptr, *ptr1;
size_t max_limit;
int i;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tmalloc2", "XtMalloc");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Set up toolkit handler for XtMalloc failure");
	XtAppSetErrorMsgHandler(app_ctext, alloc_handler);
	tet_infoline("PREP: Determine largest malloc");
	max_limit = mem_limit();
	tet_infoline("PREP: Allocate that much and the check over the limit XtMalloc calls XtErrorMsg");
	ptr = (char *) XtMalloc(max_limit);
	if (ptr == (char *)0) {
		sprintf(ebuf, "ERROR: XtMalloc could not allocate %d bytes", max_limit);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	ptr1 = (char *)XtMalloc(max_limit);
	if (ptr1 != (char *)0) {
		sprintf(ebuf, "ERROR: XtMalloc could still allocate %d bytes", max_limit);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	XtFree(ptr);
	tet_infoline("CLEANUP: Free memory");
	if (alloc_handler_called != 1) {
		sprintf(ebuf, "ERROR: XtMalloc did not generate toolkit error message");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good B 2
The order and contiguity of the storage allocated by 
successive calls to
char *XtMalloc(size).
>>ASSERTION Good B 1
A successful call to
char *XtMalloc(size) 
shall return a pointer to an object that is disjoint from
any other object.
>>ASSERTION Good B 1
The pointer returned by a successful call to
char *XtMalloc(size) 
shall point to the lowest byte address of the 
allocated space.
>>ASSERTION Good B 2
The pointer returned by a call to 
char *XtMalloc(size)
when 
.A size
is zero.
