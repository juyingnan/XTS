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
$Header: /cvs/xtest/xtest/xts5/tset/Xt13/ttranslcd/ttranslcd.m,v 1.1 2005-02-12 14:37:58 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt13/ttranslcd/ttranslcd.m
>># 
>># Description:
>>#	Tests for XtTranslateCoords()
>># 
>># Modifications:
>># $Log: ttranslcd.m,v $
>># Revision 1.1  2005-02-12 14:37:58  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:38:17  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:18  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:29:19  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:25:53  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:22:00  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:18:08  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;

void Popup(w, client_data, call_data)
Widget w;
XtPointer client_data; /* cast to topLevel */
XtPointer call_data;
{
	Widget topLevel = (Widget) client_data;
	Widget menuw = (Widget) call_data;
	Position width, height;
	Position ret_x, ret_y;
	Position get_x, get_y;
	tet_infoline("PREP: Get the coordinates of the middle of topLevel widget");
	XtVaGetValues(topLevel, XtNwidth, &width, XtNheight, &height, NULL);
	tet_infoline("PREP: Translate coordinates");
	XtTranslateCoords(topLevel,	/* Widget */
	 (Position) width/2,	/* x */
	 (Position) height/2,	/* y */
	 &ret_x, &ret_y);	 /* coords on root window */
	tet_infoline("PREP: Move popup shell to this position");
	XtVaSetValues(menuw, XtNx, ret_x, XtNy, ret_y, NULL);
	tet_infoline("PREP: Popup the shell");
	XtPopup(menuw, XtGrabNone);
	tet_infoline("PREP: Get its coordinates");
	XtVaGetValues(menuw, XtNx, &get_x, XtNy, &get_y, NULL);
	tet_infoline("TEST: Coordinates");
	check_dec(ret_x, get_x, "x co-ordinate");
	check_dec(ret_y, get_y, "x co-ordinate");
}
>>TITLE XtTranslateCoords Xt13
void
XtTranslateCoords(w, x, y, root_x_return, root_y_return)
>>ASSERTION Good A
A call 
void XtTranslateCoords(w, x, y, rootx_return, rooty_return)
shall translate the widget-relative coordinate pair specified by
.A x
and 
.A y
to root window absolute coordinates
and return the root-relative x and y coordinates in
.A rootx_return
and 
.A rooty_return
respectively.
>>CODE
Widget labelw_good;
Widget menuw;
Widget pushb_good, rowcolw_good;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Ttranslcd1", "XtTranslateCoords");
	tet_infoline("PREP: Create labelw_good widget Press Me");
	labelw_good = (Widget) CreateLabelWidget("Press Me", boxw1);
	tet_infoline("PREP: Create a shell");
	menuw = XtVaCreatePopupShell("menuw",
				overrideShellWidgetClass,
				labelw_good, NULL);
	tet_infoline("PREP: Create a rowcolw_good widget");
	rowcolw_good = (Widget) CreateRowColWidget(menuw);
	tet_infoline("PREP: Create pushb_good button Hello in rowcolw_good widget");
	pushb_good = (Widget) CreatePushButtonGadget("Hello",
				 rowcolw_good);
	tet_infoline("PREP: Add callback function Popup");
	XtAddCallback(labelw_good, XtNdestroyCallback,
			Popup, topLevel);
	tet_infoline("PREP: Create windows for widget and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Invoke callback function Popup");
	XtCallCallbacks(labelw_good, XtNdestroyCallback, menuw);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
