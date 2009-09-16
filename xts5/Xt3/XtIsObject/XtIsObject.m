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
>># File: xts/Xt3/XtIsObject/XtIsObject.m
>># 
>># Description:
>>#	Tests for XtIsObject
>># 
>># Modifications:
>># $Log: tisobjct.m,v $
>># Revision 1.1  2005-02-12 14:37:59  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:36:06  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:58:53  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:27:19  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:23:52  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:15:15  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:18:47  andy
>># Prepare for GA Release
>>#
>>EXTERN

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;
>>TITLE XtIsObject Xt3
Boolean
XtIsObject(w)
>>ASSERTION Good A
A call to Boolean XtIsObject(w) when the class of the widget w is equal 
to or is a subclass of the Object widget class shall return True.
>>CODE
Boolean status;

	avs_xt_hier("Tisobjct1", "XtIsObject");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Returns True for subclass of Object");
	status = XtIsObject(labelw);
	check_dec(True, status, "Return value");
	tet_result(TET_PASS);
>>ASSERTION Good A
A call to Boolean XtIsObject(w) when the class of the widget w is neither 
equal to nor is a subclass of the Object widget class shall return a value
other than True.
>>CODE
Boolean status;

	avs_xt_hier("Tisobjct2", "XtIsObject");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Returns non-True for widget not Object or subclass of Object");
	status = XtIsObject((Widget)app_ctext);
	check_not_dec(True, status, "Return value");
	tet_result(TET_PASS);
