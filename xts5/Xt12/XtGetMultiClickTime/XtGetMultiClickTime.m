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
$Header: /cvs/xtest/xtest/xts5/tset/Xt12/XtGetMultiClickTime/XtGetMultiClickTime.m,v 1.1 2005-02-12 14:37:56 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt12/XtGetMultiClickTime/XtGetMultiClickTime.m
>># 
>># Description:
>>#	Tests for XtGetMultiClickTime()
>># 
>># Modifications:
>># $Log: tgtmctime.m,v $
>># Revision 1.1  2005-02-12 14:37:56  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:37:56  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:00:54  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:28:59  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:25:32  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:20:57  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:16:34  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;
>>TITLE XtGetMultiClickTime Xt12
int
XtGetMultiClickTime(display)
>>ASSERTION Good A
A successful call to 
int XtGetMultiClickTime(display) 
shall return the time in milliseconds that is the maximum permissible
time between two consecutive sets of one or more identical events
to be interpreted as repeated events for the purpose of matching 
a translation entry for the display
.A display.
>>CODE
int click_time;
Display *display_good;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tgtmctime1", "XtGetMultiClickTime");
	tet_infoline("PREP: Set up the XtToolkitError handler");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Set the multiclick time to 400 milliseconds.");
	display_good = XtDisplay(topLevel);
	XtSetMultiClickTime(display_good, 400);
	tet_infoline("TEST: Multiclick time is 400 milliseconds.");
	click_time = XtGetMultiClickTime(display_good);
	if (click_time != 400) {
		sprintf(ebuf, "ERROR: Expected click time 400 Received %d", click_time);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When the multiclick time has neither been set for the specified 
display using the application resource with name 
"multiclicktime", class "MultiClickTime" nor has it been modified 
by a prior call to XtSetMultiClickTime a call to 
int XtGetMultiClickTime(display)
shall return a time interval value of 200 milliseconds.
>>CODE
int click_time;
Display *display_good;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tgtmctime2", "XtGetMultiClickTime");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Default multiclick time is 200 milliseconds.");
	display_good = XtDisplay(topLevel);
	click_time = XtGetMultiClickTime(display_good);
	if (click_time != 200 ) {
		sprintf(ebuf, "ERROR: Expected click time 200 Received %d", click_time);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
