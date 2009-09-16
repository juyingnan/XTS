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

Copyright (c) 2002 The Open Group
Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt13/XtRealloc/XtRealloc.m
>># 
>># Description:
>>#	Tests for XtRealloc()
>># 
>># Modifications:
>># $Log: trealloc.m,v $
>># Revision 1.3  2006-11-14 14:52:55  anderson
>># Fix bug #4528 - avoid potential double free()
>>#
>># Revision 1.2  2005/04/21 09:40:42  ajosey
>># resync to VSW5.1.5
>>#
>># Revision 8.2  2005/01/21 12:15:59  gwc
>># Updated copyright notice
>>#
>># Revision 8.1  2002/06/11 09:22:48  gwc
>># moved another tet_infoline in test 6 to avoid malloc failure in TET
>>#
>># Revision 8.0  1998/12/23 23:38:07  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:07  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.1  1998/07/01 01:03:20  andy
>># tet_infolines were being called when all memory had been allocated,
>># causing tcm errors when TET tried to malloc a buffer for the message.
>># Moved the infolines to avoid this.
>>#
>># Revision 6.0  1998/03/02 05:29:09  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:25:43  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:21:28  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:17:26  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;

#define PAT_SKIP	10240

extern void alloc_handler();
extern int alloc_handler_called;
>>TITLE XtRealloc Xt13
char *
XtRealloc(ptr, num)
>>ASSERTION Good A
A successful call to 
char *XtRealloc(ptr, num)
when
.A ptr
matches a pointer returned by a prior call to
XtMalloc, XtCalloc or XtRealloc shall change the size of 
the block of storage pointed to by
.A ptr
to 
.A num, 
copy the old contents pointed by 
.A ptr
into the new block, free the old block,
and return a pointer to the newly allocated block.
>>CODE
char *ptr, *ptr1, *ptr2;
size_t max_limit, half_limit;
int i;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Trealloc1", "XtRealloc");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Determine largest realloc");
	tet_infoline("TEST: Allocate memory");
	half_limit = 1024;
	ptr = (char *) XtMalloc(half_limit);
	if (ptr == (char *)NULL) {
			sprintf(ebuf, "ERROR: XtMalloc could not allocate %d bytes", half_limit);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("PREP: Write data to the allocated memory");
	ptr1 = ptr;
	for (i = 1; i <= half_limit; i++, ptr++)
		*ptr = 0x55;
	tet_infoline("TEST: Realloc and cut the request to 1/10 of current value");
	half_limit /= 10;
	ptr = XtRealloc(ptr1, half_limit);
	if (ptr == (char *)NULL) {
			sprintf(ebuf, "ERROR: XtRealloc could not allocate %d bytes", half_limit);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	ptr2 = ptr;
	tet_infoline("TEST: Read the pattern back from the allocated memory");
	for (i = 1; i <= half_limit; i++, ptr++)
		if (*ptr != 0x55) {
		sprintf(ebuf, "ERROR: %s\nExpected %d\nActual %d", "Memory area returned by XtRealloc invalid", 0x55, *ptr);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
		break;
		}
	tet_infoline("CLEANUP: Free memory");
	if( ptr2 != ptr1 )
		XtFree(ptr2);
	XtFree(ptr1);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good B 1
A successful call to
char *XtRealloc(ptr, num)
when 
.A num 
is less than the size of the storage allocated for 
.A ptr
shall copy only as much data as will fit into the newly allocated
storage from
.A ptr.
>>ASSERTION Good A
When there is insufficient memory to allocate the requested
block a call to 
char *XtRealloc(ptr, num)
shall issue an allocError error and return NULL.
>>CODE
char *ptr, *ptr1;
size_t max_limit;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Trealloc2", "XtRealloc");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Set up toolkit handler for XtRealloc failure");
	XtAppSetErrorMsgHandler(app_ctext, alloc_handler);
	tet_infoline("PREP: Determine largest realloc");
	max_limit = mem_limit();
	tet_infoline("TEST: Allocate memory then verify over the limit XtRealloc calls error handler");
	ptr = (char *) XtMalloc(max_limit);
	if (ptr == (char *)NULL) {
	 	sprintf(ebuf, "ERROR: XtMalloc could not allocate %d bytes", max_limit);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	ptr1 = (char *)XtRealloc(NULL, max_limit);
	XtFree(ptr);
	tet_infoline("CLEANUP: Free memory");
	if (alloc_handler_called == 0) {
		sprintf(ebuf, "ERROR: XtRealloc did not call error handler");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When
.A ptr 
is NULL a call to 
char *XtRealloc(ptr, num) 
shall allocate new storage and not copy any data into it.
>>CODE
char *ptr, *ptr1;
size_t max_limit;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Trealloc3", "XtRealloc");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Determine largest realloc");
	max_limit = mem_limit();
	tet_infoline("TEST: Allocate memory");
	ptr = (char *) XtRealloc(NULL, max_limit);
	if (ptr == (char *)NULL) {
	 	sprintf(ebuf, "ERROR: XtRealloc could not allocate %d bytes", max_limit);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	XtFree(ptr);
	tet_infoline("CLEANUP: Free memory");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good B 2
The contents of the newly allocated portion of the object
on a call to
char *XtRealloc(ptr, num) 
when 
.A num
is larger than the size of the storage pointed to by
.A ptr.
>>ASSERTION Good A
When 
.A num
is zero and 
.A ptr 
is not NULL a call to
char *XtRealloc(ptr, num) 
shall free the object pointed to by
.A ptr.
>>CODE
char *ptr, *ptr1;
size_t max_limit;
int i;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Trealloc", "XtRealloc");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Determine largest malloc");
	max_limit = mem_limit();
	tet_infoline("PREP: Allocate memory then call XtRealloc for memory, setting num = 0");
	tet_infoline("TEST: Then, again attempt the XtMalloc");
	ptr = (char *) XtMalloc(max_limit);
	if (ptr == (char *)0) {
		sprintf(ebuf, "ERROR: XtMalloc could not allocate %d bytes", max_limit);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	XtRealloc(ptr, 0);
	ptr = (char *)XtMalloc(max_limit);
	if (ptr == (char *)0) {
		sprintf(ebuf, "ERROR: XtMalloc could not re-allocate space after XtRealloc");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	else {
		XtFree(ptr);
		tet_infoline("CLEANUP: Memory freed");
	}
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good B 2
The behavior of a call to char *XtRealloc(ptr, num) when 
.A ptr 
does not match a pointer returned by a prior call to
XtMalloc, XtCalloc or XtRealloc.
>>ASSERTION Good B 2
The behavior of a call to 
char *XtRealloc(ptr, num) 
when the space pointed to by
.A ptr 
has been previously deallocated.
>>ASSERTION Good B 2
The order and contiguity of the storage allocated by 
successive calls to
char *XtRealloc(ptr, num).
>>ASSERTION Good B 1
A successful call to
char *XtRealloc(ptr, num) 
shall return a pointer to an object that is disjoint from
any other object.
>>ASSERTION Good B 1
The pointer returned by a successful call to
char *XtRealloc(ptr, num) 
shall point to the lowest byte address of the 
allocated space.
>>ASSERTION Good B 2
The pointer returned by a call to 
char *XtRealloc(ptr, num) 
when 
.A num
is zero.
