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
$Header: /cvs/xtest/xtest/xts5/tset/Xt13/tapgtstot/tapgtstot.m,v 1.1 2005-02-12 14:37:57 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt13/tapgtstot/tapgtstot.m
>># 
>># Description:
>>#	Tests for XtAppGetSelectionTimeout()
>># 
>># Modifications:
>># $Log: tapgtstot.m,v $
>># Revision 1.1  2005-02-12 14:37:57  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:38:11  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:11  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:29:13  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:25:47  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:21:39  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:17:40  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;
>>TITLE XtAppGetSelectionTimeout Xt13
unsigned
long XtAppGetSelectionTimeout(app_context)
>>ASSERTION Good A
A call to 
unsigned long XtAppGetSelectionTimeout(app_context)
shall return the current selection timeout value for the 
application context 
.A app_context,
in milliseconds.
>>CODE
unsigned long selection_time;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tapgtstot1", "XtAppGetSelectionTimeout");
	tet_infoline("PREP: Set the selection time out value of 10000 milliseconds");
	XtAppSetSelectionTimeout(app_ctext, (unsigned long )10000);
	tet_infoline("TEST: Check the selectionTimeout is 10000 milliseconds");
	selection_time = XtAppGetSelectionTimeout(app_ctext);
	check_dec((unsigned long )10000, selection_time, "time-out");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When the selection timeout for the calling process 
has not been set with the application resource selectionTimeout 
or by a prior call to XtAppSetSelectionTimeout 
a call to 
unsigned long XtAppGetSelectionTimeout(app_context)
shall return a value of 5000 milliseconds.
>>CODE
unsigned long selection_time;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tapgtstot2", "XtAppGetSelectionTimeout");
	tet_infoline("TEST: Check the selectionTimeout is 5000 milliseconds");
	selection_time = XtAppGetSelectionTimeout(app_ctext);
	check_dec((unsigned long )5000, selection_time, "time-out");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
