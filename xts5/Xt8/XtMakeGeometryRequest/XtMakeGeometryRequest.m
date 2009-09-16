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
>># File: xts/Xt8/XtMakeGeometryRequest/XtMakeGeometryRequest.m
>># 
>># Description:
>>#	Tests for XtMakeGeometryRequest()
>># 
>># Modifications:
>># $Log: tmkgmreqt.m,v $
>># Revision 1.1  2005-02-12 14:38:23  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:36:52  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:59:45  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.1  1998/06/26 21:03:35  andy
>># Changed test 5 so that modification to geometry of destroyed widget
>># is done within destory callback. SR 188.
>>#
>># Revision 6.0  1998/03/02 05:27:59  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:33  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:17:40  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:21:55  andy
>># Prepare for GA Release
>>#
>>EXTERN
/*
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>
*/
#include <AvsForm.h>
#include <AvsForm2.h>
#include <AvsForm3.h>

void XtWMH_Proc(str1, str2, str3, str4, str5, car)
String str1, str2, str3, str4, *str5;
Cardinal *car;
{
        avs_set_event(1,1);
}

Widget labelw_msg1;

XtWidgetGeometry intended5;
XtWidgetGeometry geom5;

/*destroy callback for test 5*/
void XtCBP(w, client_data, call_data)
Widget w;
XtPointer client_data, call_data;
{
	XtGeometryResult result;
	XtWidgetGeometry request;
	XtWidgetGeometry reply_return;

	tet_infoline("INFO: Inside destroy callback");
        avs_set_event(2,1);
	tet_infoline("PREP: Change geometry of labelw_msg1 widget");
	request.request_mode = intended5.request_mode;
	request.x = geom5.x + 10;
	request.y = geom5.y + 10;
	request.width = geom5.width + 10;
	request.height = geom5.height + 10;
	request.border_width = geom5.border_width + 1;
	result = XtMakeGeometryRequest(labelw_msg1, &request, &reply_return);
	tet_infoline("TEST: Return value is XtGeometryNo");
	check_dec(XtGeometryNo, result, "XtGeometryNo");
}

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;

#include <X11/Xaw/Label.h>
#include <X11/Xaw/Logo.h>
extern WidgetClass avsCompWidgetClass, avsWidgetClass;
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtMakeGeometryRequest Xt8
XtGeometryResult
XtMakeGeometryRequest(w, request, reply_return)
>>ASSERTION Good A
When the widget 
.A w 
is unmanaged a call to
XtGeometryResult XtMakeGeometryRequest(w, request, reply_return)
shall change those geometry fields in the widget that are 
specified in the request_mode member of the structure pointed 
to by
.A request
to the corresponding values specified in other members of
the structure and return XtGeometryYes.
>>CODE
XtWidgetGeometry request;
XtWidgetGeometry reply_return;
XtWidgetGeometry intended, geom;
XtGeometryResult result;
Widget rowcolw_good;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tmkgmreqt1", "XtMakeGeometryRequest");
	tet_infoline("PREP: Create rowcolw widget in boxw1 widget");
	rowcolw_good = (Widget) CreateRowColWidget(boxw1);
	tet_infoline("TEST: Change geometry of unmanaged widget");
	intended.request_mode = CWX|CWY|CWWidth|CWHeight|CWBorderWidth;
	XtQueryGeometry(rowcolw_good, &intended, &geom);
	request.request_mode = intended.request_mode;
	request.x = geom.x + 10;
	request.y = geom.y + 10;
	request.width = geom.width + 10;
	request.height = geom.height + 10;
	request.border_width = geom.border_width + 1;
	result = XtMakeGeometryRequest(rowcolw_good, &request, &reply_return);
	tet_infoline("TEST: return value is XtGeometryYes");
	check_dec(XtGeometryYes, result, "XtMakeGeometryRequest result");
        LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When the parent of the widget 
.A w 
is not realized a call to
XtGeometryResult XtMakeGeometryRequest(w, request, reply_return)
shall change those geometry fields in the widget that are 
specified in the request_mode member of the structure pointed 
to by
.A request
to the corresponding values specified in other members of
the structure and return XtGeometryYes.
>>CODE
Widget rowcolw_good;
XtWidgetGeometry request;
XtWidgetGeometry reply_return;
XtWidgetGeometry intended, geom;
XtGeometryResult result;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tmkgmreqt1", "XtMakeGeometryRequest");
	tet_infoline("TEST: Change geometry of unrealized widget");
	rowcolw_good = (Widget) CreateRowColWidget(boxw1);
	tet_infoline("PREP: Change geometry of rowcolw_good widget, parent widget");
	tet_infoline("PREP: unrealized.");
	intended.request_mode = CWX|CWY|CWWidth|CWHeight|CWBorderWidth;
	XtQueryGeometry(rowcolw_good, &intended, &geom);
	request.request_mode = intended.request_mode;
	request.x = geom.x + 10;
	request.y = geom.y + 10;
	request.width = geom.width + 10;
	request.height = geom.height + 10;
	request.border_width = geom.border_width + 1;
	result = XtMakeGeometryRequest(rowcolw_good, &request, &reply_return);
	tet_infoline("TEST: return value is XtGeometryYes");
	check_dec(XtGeometryYes, result, "XtMakeGeometryRequest result");
        LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When the class of the parent of the widget 
.A w 
is not a subclass of compositeWidgetClass a call to
XtGeometryResult XtMakeGeometryRequest(w, request, reply_return)
shall issue an invalidParent error.
>>CODE
Widget labelw_good, labelw_good2;
XtWidgetGeometry request;
XtWidgetGeometry reply_return;
XtWidgetGeometry intended, geom;
XtGeometryResult result;
pid_t pid2;
int invoked;

	FORK(pid2);
	avs_xt_hier("Tmkgmreqt6", "XtMakeGeometryRequest");
        XtAppSetErrorMsgHandler(app_ctext, XtWMH_Proc);
        tet_infoline("PREP: Create core class test widgets");
        labelw_good = XtVaCreateWidget(
                        "labelw_good",
                        coreWidgetClass,
                        boxw1,
                        NULL
                        );
        labelw_good2 = XtVaCreateWidget(
                        "labelw_good2",
                        coreWidgetClass,
                        labelw_good,
                        NULL
                        );
        (void) ConfigureDimension(topLevel, labelw_good);
        (void) ConfigureDimension(topLevel, labelw_good2);
	tet_infoline("TEST: Call XtMakeGeometryRequest");
	result = XtMakeGeometryRequest(labelw_good2, &request, &reply_return);
        LKROF(pid2, AVSXTTIMEOUT-2);
        tet_infoline("TEST: Error handler was invoked");
        invoked = avs_get_event(1);
        if (!invoked) {
                sprintf(ebuf, "ERROR: Error handler was not invoked");
                tet_infoline(ebuf);
                tet_result(TET_FAIL);
        }
	tet_result(TET_PASS);
>>ASSERTION Good A
When the geometry_manager field of the parent of the widget 
.A w 
is NULL a call to
XtGeometryResult XtMakeGeometryRequest(w, request, reply_return)
shall issue an invalidGeometryManager error.
>>CODE
XtWidgetGeometry request;
XtWidgetGeometry reply_return;
XtWidgetGeometry intended, geom;
XtGeometryResult result;
Widget formw_good, formw_good2, labelw_good;
pid_t pid2;
int invoked;

	FORK(pid2);
	avs_xt_hier("Tmkgmreqt1", "XtMakeGeometryRequest");
        XtAppSetErrorMsgHandler(app_ctext, XtWMH_Proc);
	tet_infoline("PREP: Create avsform3 widget in avsform widget");
	formw_good2 = XtCreateManagedWidget("avsform3",
			avsform3WidgetClass,
			boxw1,
			NULL,
			0);
	labelw_good = (Widget) CreateLabelWidget("Hello", formw_good2);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Change geometry of labelw_good widget");
	request.request_mode = 0;
	request.x = 0;
	request.y = 0;
	request.width = 0;
	request.height = 0;
	request.border_width = 0;
	result = XtMakeGeometryRequest(labelw_good, &request, &reply_return);
        LKROF(pid2, AVSXTTIMEOUT-2);
        tet_infoline("TEST: Error handler was invoked");
        invoked = avs_get_event(1);
        if (!invoked) {
                sprintf(ebuf, "ERROR: Error handler was not invoked");
                tet_infoline(ebuf);
                tet_result(TET_FAIL);
        }
	tet_result(TET_PASS);
>>ASSERTION Good A
When the being_destroyed field of the widget
.A w
is True a call to 
XtGeometryResult XtMakeGeometryRequest(w, request, reply_return)
shall return XtGeometryNo.
>>CODE
Widget labelw_msg;
char *msg = "Test widget";
pid_t pid2;
int	invoked;

        avs_set_event(2,0);
	FORK(pid2);
	avs_xt_hier("Tmkgmreqt1", "XtMakeGeometryRequest");
	tet_infoline("PREP: Create label widget in boxw1 widget");
	labelw_msg1 = (Widget) CreateLabelWidget(msg, boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Add destroy callback procedure to labelw_msg1");
	XtAddCallback(labelw_msg1,
			XtNdestroyCallback,
			XtCBP,
			(XtPointer)NULL
			);
	tet_infoline("PREP: Get current geometry and destroy widget");
	intended5.request_mode = CWX|CWY|CWWidth|CWHeight|CWBorderWidth;
	XtQueryGeometry(labelw_msg1, &intended5, &geom5);
	XtDestroyWidget(labelw_msg1);
        LKROF(pid2, AVSXTTIMEOUT-2);
        invoked = avs_get_event(2);
        if (!invoked) {
                sprintf(ebuf, "ERROR: Destroy callback was not invoked");
                tet_infoline(ebuf);
                tet_result(TET_FAIL);
        } else
		tet_result(TET_PASS);
>>ASSERTION Good A
When the fields x, y, width, height, and the border_width of the
widget
.A w
are all equal to their corresponding values in 
.A request
a call to
XtGeometryResult XtMakeGeometryRequest(w, request, reply_return)
shall return XtGeometryYes.
>>CODE
XtWidgetGeometry request;
XtWidgetGeometry reply_return;
XtWidgetGeometry intended, geom;
XtGeometryResult result;
Widget rowcolw_good;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tmkgmreqt1", "XtMakeGeometryRequest");
	tet_infoline("PREP: Create rowcolw widget in boxw1 widget");
	rowcolw_good = (Widget) CreateRowColWidget(boxw1);
	tet_infoline("TEST: Do not change geometry of unmanaged widget");
	intended.request_mode = CWX|CWY|CWWidth|CWHeight|CWBorderWidth;
	XtQueryGeometry(rowcolw_good, &intended, &geom);
	request.request_mode = intended.request_mode;
	request.x = geom.x;
	request.y = geom.y;
	request.width = geom.width;
	request.height = geom.height;
	request.border_width = geom.border_width;
	result = XtMakeGeometryRequest(rowcolw_good, &request, &reply_return);
	tet_infoline("TEST: return value is XtGeometryYes");
	check_dec(XtGeometryYes, result, "XtMakeGeometryRequest result");
        LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When at least one of x, y, width, height or the border_width 
field of the widget
.A w
is not equal to its corresponding value in 
.A request
a call to
XtGeometryResult XtMakeGeometryRequest(w, request, reply_return)
shall call the geometry_manager procedure of the specified widget's
parent passing 
.A request
and
.A reply_return
as arguments to it.
>>CODE
XtWidgetGeometry request;
XtWidgetGeometry reply_return;
XtWidgetGeometry intended, geom;
XtGeometryResult result;
Widget formw_good, formw_good2, labelw_good;
pid_t pid2;
int invoked;

	FORK(pid2);
	avs_xt_hier("Tmkgmreqt1", "XtMakeGeometryRequest");
	tet_infoline("PREP: Create avsform widget in boxw1 widget");
	formw_good = XtCreateManagedWidget("avsform",
			avsformWidgetClass,
			boxw1,
			NULL,
			0);
	tet_infoline("PREP: Create avsform2 widget in avsform widget");
	formw_good2 = XtCreateManagedWidget("avsform2",
			avsform2WidgetClass,
			formw_good,
			NULL,
			0);
	labelw_good = (Widget) CreateLabelWidget("Hello", formw_good2);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Change geometry of avsform2 widget");
	intended.request_mode = CWX|CWY|CWWidth|CWHeight|CWBorderWidth;
	XtQueryGeometry(formw_good2, &intended, &geom);
	request.request_mode = intended.request_mode;
	request.x = geom.x + 10;
	request.y = geom.y + 10;
	request.width = geom.width + 10;
	request.height = geom.height + 10;
	request.border_width = geom.border_width + 1;
	result = XtMakeGeometryRequest(formw_good2, &request, &reply_return);
        LKROF(pid2, AVSXTTIMEOUT-2);
        tet_infoline("TEST: Parent's Geometry manager was invoked");
        invoked = avs_get_event(5);
        if (!invoked) {
                sprintf(ebuf, "ERROR: Geometry manager was not invoked");
                tet_infoline(ebuf);
                tet_result(TET_FAIL);
        }
	tet_result(TET_PASS);
>>ASSERTION Good B 1
On a call to
XtGeometryResult XtMakeGeometryRequest(w, request, reply_return)
when the widget
.A w
is realized, at least one of x, y, width, height or the 
border_width field of the widget is not equal to its 
corresponding value in 
.A request, 
and the call to the geometry_manager procedure of 
the widget's parent returns XtGeometryYes with 
request->request_mode set to a value other than XtCWQueryOnly 
it shall call the XConfigureWindow Xlib function.
>>ASSERTION Good A
A call to
XtGeometryResult XtMakeGeometryRequest(w, request, reply_return)
when the widget
.A w
is realized, at least one of x, y, width, height or the 
border_width field of the widget is not equal to its 
corresponding value in 
.A request, 
and the call to the geometry_manager procedure of the widget's 
parent returns XtGeometryDone shall return XtGeometryYes.
>>CODE
XtWidgetGeometry request;
XtWidgetGeometry reply_return;
XtWidgetGeometry intended, geom;
XtGeometryResult result;
Widget formw_good, formw_good2, labelw_good;
pid_t pid2;
int invoked;

	FORK(pid2);
	avs_xt_hier("Tmkgmreqt1", "XtMakeGeometryRequest");
	tet_infoline("PREP: Create avsform widget in boxw1 widget");
	formw_good = XtCreateManagedWidget("avsform",
			avsformWidgetClass,
			boxw1,
			NULL,
			0);
	tet_infoline("PREP: Create avsform2 widget in avsform widget");
	formw_good2 = XtCreateManagedWidget("avsform2",
			avsform2WidgetClass,
			formw_good,
			NULL,
			0);
	labelw_good = (Widget) CreateLabelWidget("Hello", formw_good2);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Change geometry of avsform2 widget");
	intended.request_mode = CWX|CWY|CWWidth|CWHeight|CWBorderWidth;
	XtQueryGeometry(formw_good2, &intended, &geom);
	request.request_mode = intended.request_mode;
	request.x = geom.x + 10;
	request.y = geom.y + 10;
	request.width = geom.width + 10;
	request.height = geom.height + 10;
	request.border_width = geom.border_width + 1;
	/*this forces the avsForm (parent) widget's geometry manager to
	return XtMakeGeometryDone*/
	avs_set_event(5, 77);
	result = XtMakeGeometryRequest(formw_good2, &request, &reply_return);
	tet_infoline("TEST: return value is XtGeometryYes");
	check_dec(XtGeometryYes, result, "XtMakeGeometryRequest result");
        LKROF(pid2, AVSXTTIMEOUT-2);
        tet_infoline("TEST: Parent's Geometry manager was invoked");
        invoked = avs_get_event(5);
        if (!invoked) {
                sprintf(ebuf, "ERROR: Geometry manager was not invoked");
                tet_infoline(ebuf);
                tet_result(TET_FAIL);
        }
	tet_result(TET_PASS);
>>ASSERTION Good A
A call to
XtGeometryResult XtMakeGeometryRequest(w, request, reply_return)
when the widget
.A w
is realized, at least one of x, y, width, height or the 
border_width field of the widget is not equal to its 
corresponding value in 
.A request, 
and the call to the geometry_manager procedure of the 
the widget's parent neither returns XtGeometryYes with 
request->request_mode set to a value other than XtCWQueryOnly 
nor returns XtGeometryDone shall return what the 
geometry_manager procedure returns.
>>CODE
XtWidgetGeometry request;
XtWidgetGeometry reply_return;
XtWidgetGeometry intended, geom;
XtGeometryResult result;
Widget rowcolw_good;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tmkgmreqt1", "XtMakeGeometryRequest");
	tet_infoline("PREP: Create rowcolw widget in boxw1 widget");
	rowcolw_good = (Widget) CreateRowColWidget(boxw1);
	tet_infoline("TEST: Change geometry of unmanaged widget");
	intended.request_mode = CWX|CWY|CWWidth|CWHeight|CWBorderWidth;
	XtQueryGeometry(rowcolw_good, &intended, &geom);
	request.request_mode = intended.request_mode;
	request.x = geom.x + 10;
	request.y = geom.y + 10;
	request.width = geom.width + 10;
	request.height = geom.height + 10;
	request.border_width = geom.border_width + 1;
	result = XtMakeGeometryRequest(rowcolw_good, &request, &reply_return);
	tet_infoline("TEST: return value is XtGeometryYes");
	check_dec(XtGeometryYes, result, "XtMakeGeometryRequest result");
        LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good B 3
When 
.A reply_return 
is NULL a call to
XtGeometryResult XtMakeGeometryRequest(w, request, reply_return)
shall not return XtGeometryAlmost.
