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
$Header: /cvs/xtest/xtest/xts5/tset/Xt13/tcalloc/tcalloc.m,v 1.2 2005-04-21 09:40:42 ajosey Exp $

Copyright (c) 2004 The Open Group
Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt13/tcalloc/tcalloc.m
>># 
>># Description:
>>#	Tests for XtCalloc()
>># 
>># Modifications:
>># $Log: tcalloc.m,v $
>># Revision 1.2  2005-04-21 09:40:42  ajosey
>># resync to VSW5.1.5
>>#
>># Revision 8.2  2005/01/14 12:11:28  gwc
>># Updated copyright notice
>>#
>># Revision 8.1  2004/02/12 16:57:43  gwc
>># Changed num to size_t in test 2
>>#
>># Revision 8.0  1998/12/23 23:38:06  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:06  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:29:09  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:25:43  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:21:26  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:17:24  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;

extern int alloc_handler_called;
extern void alloc_handler();
>>TITLE XtCalloc Xt13
char *
XtCalloc(num,size)
>>ASSERTION Good A
A successful call to 
char *XtCalloc(num, size)
shall allocate space for 
.A num 
number of array elements each of size
.A size 
and initialize the space to zero.
>>CODE
char *ptr , *array;
int i;
unsigned int num = 2;
unsigned int size = 12;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tcalloc1", "XtCalloc");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	sprintf(ebuf, "TEST: Allocate elements %d of size %d to zero", num, size);
	tet_infoline(ebuf);
	array = (char *) XtCalloc(num, size);
	ptr = (char *) array;
	for (i = 1; i <= size * num; i++ , ptr++)
	if (*ptr != (char) 0) {
		sprintf(ebuf, "ERROR: Allocated memory location not initialized to zero");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When there is insufficient memory to allocate the requested
block a call to 
char *XtCalloc(num, size)
shall issue an allocError error and return NULL.
>>CODE
char *array;
size_t num;
unsigned int size = 14;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tcalloc2", "XtCalloc");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
 
	tet_infoline("PREP: Set up toolkit handler for XtCalloc failure");
	XtAppSetErrorMsgHandler(app_ctext, alloc_handler);
	tet_infoline("PREP: Determine largest malloc");
	num = mem_limit();
	tet_infoline("PREP: Over the limit XtCalloc should call XtErrorMessage");
	array = (char *) XtCalloc( ( num + 10 ), size);
	if (alloc_handler_called != 1) {
		sprintf(ebuf, "ERROR: XtCalloc did not generate toolkit error message");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("CLEANUP: Free memory");
	XtFree(array);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good B 2
The order and contiguity of the storage allocated by 
successive calls to
char *XtCalloc(num, size).
>>ASSERTION Good B 1
A successful call to
char *XtCalloc(num, size)
shall return a pointer to an object that is disjoint from
any other object.
>>ASSERTION Good B 1
The pointer returned by a successful call to
char *XtCalloc(num, size)
shall point to the lowest byte address of the 
allocated space.
>>ASSERTION Good B 2
The pointer returned by a call to 
char *XtCalloc(num, size)
when 
.A size
is zero.
