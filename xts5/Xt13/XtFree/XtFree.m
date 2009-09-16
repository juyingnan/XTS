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
>># File: tset/Xt13/XtFree/XtFree.m
>># 
>># Description:
>>#	Tests for XtFree()
>># 
>># Modifications:
>># $Log: tfree.m,v $
>># Revision 1.1  2005-02-12 14:37:57  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:38:07  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:07  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.1  1998/07/01 01:05:10  andy
>># tet_infolines were being called when all memory had been malloc-ed
>># causing tcm errors when TET tried to malloc a buffer for the message.
>># Moved the infolines to avoid this.
>>#
>># Revision 6.0  1998/03/02 05:29:10  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:25:44  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:21:29  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:17:27  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;

>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtFree Xt13
void
XtFree(ptr)
>>ASSERTION Good A
When 
.A ptr
points to a block of storage allocated by a prior call 
to XtMalloc, XtCalloc or XtRealloc a successful call to 
void XtFree(ptr)
shall free the specified block.
>>CODE
char *ptr, *ptr1;
size_t max_limit;
int i;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tfree1", "XtFree");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Determine largest malloc");
	max_limit = mem_limit();
	tet_infoline("PREP: Allocate memory and free the memory, then try and re malloc it");
	ptr = (char *) XtMalloc(max_limit);
	if (ptr == (char *)0) {
		sprintf(ebuf, "ERROR: XtMalloc could not allocate %d bytes", max_limit);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	XtFree(ptr);
	ptr = (char *)XtMalloc(max_limit);
	if (ptr == (char *)0) {
		sprintf(ebuf, "ERROR: XtMalloc could not re-allocate space after Xtfree");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	XtFree(ptr);
	tet_infoline("CLEANUP: Free it again");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When
.A ptr
is NULL a call to
void XtFree(ptr)
shall return immediately.
>>CODE
char *ptr, *ptr1;
size_t max_limit;
int i;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tfree1", "XtFree");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Call XtFree(NULL)");
	XtFree(NULL);
	avs_set_event(1,1);
	LKROF(pid2, AVSXTTIMEOUT-2);
	if (avs_get_event(1) != 1) {
		tet_infoline("ERROR: XtFree(NULL) causes process to exit");
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
>>ASSERTION Good B 2
The behavior of a call to 
void XtFree(ptr)
when 
.A ptr 
does not specify a pointer returned by a prior call to
XtMalloc, XtCalloc or XtRealloc.
>>ASSERTION Good B 2
The behavior of a call to 
void XtFree(ptr)
when the storage pointed to by
.A ptr 
has been previously deallocated.
