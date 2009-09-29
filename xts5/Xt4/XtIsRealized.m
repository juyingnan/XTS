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
>># File: xts/Xt4/XtIsRealized.m
>># 
>># Description:
>>#	Tests for XtIsRealized()
>># 
>># Modifications:
>># $Log: tisrealiz.m,v $
>># Revision 1.1  2005-02-12 14:38:02  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:36:33  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:59:24  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:27:42  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:16  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:16:29  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:20:26  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>
#include <AvsRectObj.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;
>>TITLE XtIsRealized Xt4
Boolean XtIsRealized(object)
>>ASSERTION Good A
A call to Boolean XtIsRealized(w) shall return True when the window for 
the widget w has a non-zero ID.
>>CODE
Boolean status;

	avs_xt_hier("Tisrealiz1", "XtIsRealized");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Widget labelw is realized shall return True");
	status = XtIsRealized(labelw);
	check_dec(True, status, "Return value");
	tet_result(TET_PASS);
>>ASSERTION Good A
A call to Boolean XtIsRealized(w) shall when the widget w has not been 
realized shall return a value other than True.
>>CODE
Boolean status;

	avs_xt_hier("Tisrealiz2", "XtIsRealized");
	tet_infoline("TEST: labelw widget NOT realized - shall return False");
	status = XtIsRealized(labelw);
	check_dec(False, status, "Return value");
	tet_result(TET_PASS);
>>ASSERTION Good C
If the implementation is X11R5 or later:
A call to Boolean XtIsRealized(w) when w is not a widget shall 
return the state of the nearest widget ancestor.
>>CODE
Widget test_widget;
Boolean status;

	avs_xt_hier("Tisrealiz1", "XtIsRealized");
        tet_infoline("PREP: Create AVS RectObj widget");
        test_widget = XtVaCreateManagedWidget("avsro", avsrectObjClass, topLevel, NULL);

	tet_infoline("TEST: XtIsRealized returns False");
	status = XtIsRealized(test_widget);
	check_dec(False, status, "Return value");
	tet_infoline("PREP: Realize nearest widget ancenstor");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: XtIsRealized returns True");
	status = XtIsRealized(test_widget);
	check_dec(True, status, "Return value");
	tet_result(TET_PASS);
