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
>># File: tset/Xt5/XtIsManaged/XtIsManaged.m
>># 
>># Description:
>>#	Tests for XtIsManaged()
>># 
>># Modifications:
>># $Log: tismanage.m,v $
>># Revision 1.1  2005-02-12 14:38:14  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:36:37  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:59:29  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:27:46  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:20  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:16:40  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:20:41  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>
#include <X11/Xaw/Label.h>
#include <AvsObj.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;
>>TITLE XtIsManaged Xt5
Boolean
XtIsManaged(w)
>>ASSERTION Good A
A successful call to 
Boolean XtIsManaged(w) when the widget w belongs to the class RectObj or a 
subclass thereof and is managed shall return True.
>>CODE
Boolean status;

	avs_xt_hier("Tismanage1", "XtIsManaged");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: labelw widget is managed shall return True");
	status = XtIsManaged(labelw);
	check_dec(True, status, "XtIsManaged return value");
	tet_result(TET_PASS);
>>ASSERTION Good A
A call to 
Boolean XtIsManaged(w) 
when the widget w is not managed shall return False.
>>CODE
Widget unmngw;
Boolean status;

	avs_xt_hier("Tismanage2", "XtIsManaged");
	tet_infoline("PREP: Create unmngw label widget in box widget");
	unmngw = XtVaCreateWidget(
		"Unmanaged Widget",
		labelWidgetClass,
		boxw1,
		NULL
	);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: XtIsManaged for unmngw label widget returns False");
	status = XtIsManaged(unmngw);
	check_dec(False, status, "XtIsManaged return value");
	tet_result(TET_PASS);
>>ASSERTION Good A
A call to 
Boolean XtIsManaged(w) 
when the widget w does not belong to the class RectObj or a subclass thereof 
shall return False.
>>CODE
Widget ObjectNotWidget;
Boolean status;

	avs_xt_hier("Tismanage2", "XtIsManaged");
	tet_infoline("PREP: Create an AvsObject");
	ObjectNotWidget = XtCreateWidget("ObjectNotWidget", avsObjClass,
			 topLevel, (ArgList) 0, 0);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: XtIsManaged Returns False");
	status = XtIsManaged(ObjectNotWidget) ;
	check_dec(False, status, "Return value");
	tet_result(TET_PASS);
