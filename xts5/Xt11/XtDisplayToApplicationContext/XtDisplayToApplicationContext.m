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
>># File: xts/Xt11/XtDisplayToApplicationContext/XtDisplayToApplicationContext.m
>># 
>># Description:
>>#	Tests for XtDisplayToApplicationContext()
>># 
>># Modifications:
>># $Log: tdispltac.m,v $
>># Revision 1.1  2005-02-12 14:37:53  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:37:45  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:00:42  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:28:48  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:25:22  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:20:20  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:15:17  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;

/*
** XtEMH_Proc
*/
void XtEMH_Proc(str, str2, str3, str4, str5, car)
String str, str2, str3, str4, *str5;
Cardinal *car;
{
	avs_set_event(1, 1);
	exit(0);
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtDisplayToApplicationContext Xt11
XtAppContext
XtDisplayToApplicationContext(display)
>>ASSERTION Good A
A successful call to
XtAppContext XtDisplayToApplicationContext(display)
shall return the application context in which the display
.A display
was initialized.
>>CODE
XtAppContext app_ctext_good;
Display *display_good;
Widget labelw_good;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tdispltac1", "XtDisplayToApplicationContext");
	tet_infoline("PREP: Create label widget `Hello' in boxw1 widget");
	labelw_good = (Widget) CreateLabelWidget("Hello", boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get the display pointer for label widget `Hello' ");
	if ( ( display_good = XtDisplay(labelw_good) ) == NULL ) {
		sprintf(ebuf, "ERROR: Expected valid display pointer returned NULL");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Check the application context is valid");
	 app_ctext_good = XtDisplayToApplicationContext(display_good);
	 if (app_ctext_good == NULL) {
		sprintf(ebuf, "ERROR: Expected valid application context Received NULL");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
A call to
XtAppContext XtDisplayToApplicationContext(display)
when 
.A display 
is not an Intrinsics initialized display shall issue 
an error message.
>>CODE
Display *display;
pid_t pid2;
int invoked = 0;

	FORK(pid2);
	avs_xt_hier("Tdispltac1", "XtDisplayToApplicationContext");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Register XtEMH_Proc to be called on error");
	tet_infoline("PREP: conditions");
	XtAppSetErrorMsgHandler(app_ctext, XtEMH_Proc);
	tet_infoline("TEST: Display unknown returns error");
	XtDisplayToApplicationContext(display);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Error handler was invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtEMH_Proc invoked status");
	tet_result(TET_PASS);
