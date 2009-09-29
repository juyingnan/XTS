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
>># File: xts/Xt13/XtAppSetSelectionTimeout.m
>># 
>># Description:
>>#	Tests for XtAppSetSelectionTimeout()
>># 
>># Modifications:
>># $Log: tapststmo.m,v $
>># Revision 1.1  2005-02-12 14:37:57  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:38:10  mar
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
>># Revision 4.0  1995/12/15 09:21:38  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:17:39  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;
>>TITLE XtAppSetSelectionTimeout Xt13
void
XtAppSetSelectionTimeout(app_context,timeout)
>>ASSERTION Good A
A call to 
void XtAppSetSelectionTimeout(app_context, timeout)
shall set the selection timeout value for the application 
context 
.A app_context
to 
.A timeout
milliseconds.
>>CODE
unsigned long time_out;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tapststmo1", "XtAppSetSelectionTimeout");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Set the selection time out value of 10000 milliseconds");
	XtAppSetSelectionTimeout(app_ctext, (unsigned long )10000);
	tet_infoline("TEST: Check the selectionTimeout is 10000 milliseconds");
	if((time_out = XtAppGetSelectionTimeout(app_ctext)) != (unsigned long )10000 ) {
		sprintf(ebuf, "ERROR: Expected 10000 returned %d", time_out);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
