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
>># File: xts/Xt8/XtMakeResizeRequest.m
>># 
>># Description:
>>#	Tests for XtMakeResizeRequest()
>># 
>># Modifications:
>># $Log: tmkrsizrt.m,v $
>># Revision 1.1  2005-02-12 14:38:23  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:36:53  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:59:45  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.1  1998/06/26 21:24:34  andy
>># In test 5, made geometry change for destroyed widget occur within
>># destroy callback. SR #189.
>>#
>># Revision 6.0  1998/03/02 05:28:00  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.1  1998/02/24 03:17:11  andy
>># Made test 9 contingent on coverage
>>#
>># Revision 5.0  1998/01/26 03:24:34  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:17:42  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:21:57  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>
#include <AvsForm.h>
#include <AvsForm2.h>
#include <AvsForm3.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;

Widget cooperative_widget5;
XtWidgetGeometry intended5, geom5;

/*destroy callback for test 5*/
void XtCBP(w, client_data, call_data)
Widget w;
XtPointer client_data, call_data;
{
	XtGeometryResult result;
	Dimension width, height;
	Dimension width_return, height_return;

	tet_infoline("INFO: Inside destroy callback");
        avs_set_event(2,1);
	tet_infoline("PREP: Change geometry of cooperative widget");
	width = geom5.width + 10;
	height = geom5.height + 10;
	result = XtMakeResizeRequest(cooperative_widget5, width, height, &width_return, &height_return);
	tet_infoline("TEST: Return value is XtGeometyNo");
	check_dec(XtGeometryNo, result, "XtGeometryYes");
}

void XtWMH_Proc(str1, str2, str3, str4, str5, car)
String str1, str2, str3, str4, *str5;
Cardinal *car;
{
        avs_set_event(1,1);
        exit(1);
}

extern WidgetClass avsWidgetClass, avsCompWidgetClass;

>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtMakeResizeRequest Xt8
XtGeometryResult
XtMakeResizeRequest(w, width, height, width_return, height_return)
>>ASSERTION Good A
When the widget
.A w 
is unmanaged a call to
XtGeometryResult XtMakeResizeRequest(w, width, height, 
width_return, height_return)
shall change the width and the height of the widget 
to 
.A width
and
.A height
respectively and return XtGeometryYes.
>>CODE
Widget cooperative_composite, cooperative_widget;
XtWidgetGeometry intended, geom;
XtGeometryResult result;
Dimension width, height;
Dimension width_return, height_return;

	avs_xt_hier("Tmkrsizrt1", "XtMakeResizeRequest");
	tet_infoline("PREP: Createcooperative composite widget in boxw1");
	cooperative_composite = XtCreateManagedWidget("cooperative_widget",
						avsCompWidgetClass,
						boxw1,
						(ArgList) 0, 0);
	tet_infoline("PREP: Create cooperative widget in cooperative composite");
	cooperative_widget = XtCreateManagedWidget("cooperative_widget",
						avsWidgetClass,
						cooperative_composite,
						(ArgList) 0, 0);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Query geometry of cooperative widget");
	intended.request_mode = CWWidth|CWHeight;
	XtQueryGeometry(cooperative_widget, &intended, &geom);
	tet_infoline("PREP: Change geometry of cooperative widget");
	width = geom.width + 10;
	height = geom.height + 10;
	result = XtMakeResizeRequest(cooperative_widget, width, height, &width_return, &height_return);
	tet_infoline("TEST: Return value is XtGeometyYes");
	check_dec(XtGeometryYes, result, "XtGeometryYes");
	tet_infoline("TEST: Returned width and height");
	check_dec(width, width_return, "width");
	check_dec(height, height_return, "height");
	tet_infoline("PREP: Request geometry of cooperative_widget widget");
	intended.request_mode = CWWidth|CWHeight;
	XtQueryGeometry(cooperative_widget, NULL, &geom);
	tet_infoline("TEST: Cooperative_widget widget is resized");
	check_dec(width, geom.width, "width");
	check_dec(height, geom.height, "height");
	tet_result(TET_PASS);
>>ASSERTION Good A
When the parent of the widget 
.A w 
is not realized a call to
XtGeometryResult XtMakeResizeRequest(w, width, height, 
width_return, height_return)
shall change the width and the height of the widget 
to 
.A width
and
.A height
respectively and return XtGeometryYes.
>>CODE
Widget cooperative_composite, cooperative_widget;
XtWidgetGeometry intended, geom;
XtGeometryResult result;
Dimension width, height;
Dimension width_return, height_return;

	avs_xt_hier("Tmkrsizrt1", "XtMakeResizeRequest");
	tet_infoline("PREP: Createcooperative composite widget in boxw1");
	cooperative_composite = XtCreateManagedWidget("cooperative_widget",
						avsCompWidgetClass,
						boxw1,
						(ArgList) 0, 0);
	tet_infoline("PREP: Create cooperative widget in cooperative composite");
	cooperative_widget = XtCreateManagedWidget("cooperative_widget",
						avsWidgetClass,
						cooperative_composite,
						(ArgList) 0, 0);
	tet_infoline("PREP: Query geometry of cooperative widget");
	intended.request_mode = CWWidth|CWHeight;
	XtQueryGeometry(cooperative_widget, &intended, &geom);
	tet_infoline("PREP: Change geometry of cooperative widget");
	width = geom.width + 10;
	height = geom.height + 10;
	result = XtMakeResizeRequest(cooperative_widget, width, height, &width_return, &height_return);
	tet_infoline("TEST: Return value is XtGeometyYes");
	check_dec(XtGeometryYes, result, "XtGeometryYes");
	tet_infoline("TEST: Returned width and height");
	check_dec(width, width_return, "width");
	check_dec(height, height_return, "height");
	tet_infoline("PREP: Request geometry of cooperative_widget widget");
	intended.request_mode = CWWidth|CWHeight;
	XtQueryGeometry(cooperative_widget, NULL, &geom);
	tet_infoline("TEST: Cooperative_widget widget is resized");
	check_dec(width, geom.width, "width");
	check_dec(height, geom.height, "height");
	tet_result(TET_PASS);
>>ASSERTION Good A
When the class of the parent of the widget 
.A w 
is not a subclass of compositeWidgetClass a call to
XtGeometryResult XtMakeResizeRequest(w, width, height, 
width_return, height_return)
shall issue an invalidParent error.
>>CODE
Widget cooperative_composite, cooperative_widget, cooperative_widget2;
XtWidgetGeometry intended, geom;
XtGeometryResult result;
Dimension width, height;
Dimension width_return, height_return;
Widget labelw_good, labelw_good2;
pid_t pid2;
int	invoked;

	FORK(pid2);
	avs_xt_hier("Tmkrsizrt3", "XtMakeResizeRequest");
        XtAppSetErrorMsgHandler(app_ctext, XtWMH_Proc);
        tet_infoline("PREP: Create test widgets");
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
	tet_infoline("TEST: Call XtMakeResizeRequest");
	result = XtMakeResizeRequest(labelw_good2, width, height, &width_return, &height_return);
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
XtGeometryResult XtMakeResizeRequest(w, width, height, 
width_return, height_return)
shall issue an invalidGeometryManager error.
>>CODE
XtWidgetGeometry request;
XtWidgetGeometry reply_return;
XtWidgetGeometry intended, geom;
XtGeometryResult result;
Widget formw_good, formw_good2, labelw_good;
pid_t pid2;
int invoked;
Dimension width_return, height_return;

	FORK(pid2);
	avs_xt_hier("Tmkrsizrt1", "XtMakeGeometryRequest");
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
	tet_infoline("TEST: Call XtMakeResizeRequest");
	result = XtMakeResizeRequest(labelw_good, 10, 10, &width_return, &height_return);
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
XtGeometryResult XtMakeResizeRequest(w, width, height, 
width_return, height_return)
shall return XtGeometryNo.
>>CODE
int	invoked;
Widget cooperative_composite;
pid_t pid2;

        avs_set_event(2,0);
	FORK(pid2);
	avs_xt_hier("Tmkrsizrt1", "XtMakeResizeRequest");
	tet_infoline("PREP: Createcooperative composite widget in boxw1");
	cooperative_composite = XtCreateManagedWidget("cooperative_widget",
						avsCompWidgetClass,
						boxw1,
						(ArgList) 0, 0);
	tet_infoline("PREP: Create cooperative widget in cooperative composite");
	cooperative_widget5 = XtCreateManagedWidget("cooperative_widget",
						avsWidgetClass,
						cooperative_composite,
						(ArgList) 0, 0);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Query geometry of cooperative widget");
	intended5.request_mode = CWWidth|CWHeight;
	XtQueryGeometry(cooperative_widget5, &intended5, &geom5);
	tet_infoline("PREP: Add destroy callback procedure to cooperative widget");
	XtAddCallback(cooperative_widget5,
			XtNdestroyCallback,
			XtCBP,
			(XtPointer)NULL
			);
	tet_infoline("PREP: Destroy cooperative widget");
	XtDestroyWidget(cooperative_widget5);
        LKROF(pid2, AVSXTTIMEOUT-2);
        invoked = avs_get_event(2);
        if (!invoked) {
                sprintf(ebuf, "ERROR: Destroy callback was not invoked");
                tet_infoline(ebuf);
                tet_result(TET_FAIL);
        } else
		tet_result(TET_PASS);
	tet_result(TET_PASS);
>>ASSERTION Good A
When the width and the height fields of the
widget
.A w
are equal to 
.A width
and
.A height
respectively a call to
XtGeometryResult XtMakeResizeRequest(w, width, height, 
width_return, height_return)
shall return XtGeometryYes.
>>CODE
Widget cooperative_composite, cooperative_widget;
XtWidgetGeometry intended, geom;
XtGeometryResult result;
Dimension width, height;
Dimension width_return, height_return;

	avs_xt_hier("Tmkrsizrt1", "XtMakeResizeRequest");
	tet_infoline("PREP: Createcooperative composite widget in boxw1");
	cooperative_composite = XtCreateManagedWidget("cooperative_widget",
						avsCompWidgetClass,
						boxw1,
						(ArgList) 0, 0);
	tet_infoline("PREP: Create cooperative widget in cooperative composite");
	cooperative_widget = XtCreateManagedWidget("cooperative_widget",
						avsWidgetClass,
						cooperative_composite,
						(ArgList) 0, 0);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Query geometry of cooperative widget");
	intended.request_mode = CWWidth|CWHeight;
	XtQueryGeometry(cooperative_widget, &intended, &geom);
	tet_infoline("PREP: Do not change width and height of cooperative widget");
	width = geom.width;
	height = geom.height;
	result = XtMakeResizeRequest(cooperative_widget, width, height, &width_return, &height_return);
	tet_infoline("TEST: Return value is XtGeometyYes");
	check_dec(XtGeometryYes, result, "XtGeometryYes");
	tet_infoline("TEST: Returned width and height");
	check_dec(width, width_return, "width");
	check_dec(height, height_return, "height");
	tet_infoline("PREP: Request geometry of cooperative_widget widget");
	intended.request_mode = CWWidth|CWHeight;
	XtQueryGeometry(cooperative_widget, NULL, &geom);
	tet_infoline("TEST: Cooperative_widget widget is resized");
	check_dec(width, geom.width, "width");
	check_dec(height, geom.height, "height");
	tet_result(TET_PASS);
>>ASSERTION Good A
When the width field of the widget
.A w
is not equal to
.A width
or the height field is not equal to
.A height
a call to
XtGeometryResult XtMakeResizeRequest(w, width, height, 
width_return, height_return)
shall call the geometry_manager procedure of the specified 
widget's parent.
>>CODE
XtWidgetGeometry request;
XtWidgetGeometry reply_return;
XtWidgetGeometry intended, geom;
XtGeometryResult result;
Widget formw_good, formw_good2, labelw_good;
pid_t pid2;
int invoked;
Dimension width_return, height_return;
Dimension width, height;

	FORK(pid2);
	avs_xt_hier("Tmkrsizrt1", "XtMakeResizeRequest");
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
	tet_infoline("TEST: Change size of avsform2 widget");
	intended.request_mode = CWX|CWY|CWWidth|CWHeight|CWBorderWidth;
	XtQueryGeometry(formw_good2, &intended, &geom);
	width = geom.width + 10;
	height = geom.height + 10;
	result = XtMakeResizeRequest(formw_good2, width, height, &width_return, &height_return);
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
XtGeometryResult XtMakeResizeRequest(w, width, height, 
width_return, height_return)
when the widget
.A w
is realized, the width field of the widget is not
equal to
.A width
or the height field is not equal to
.A height,
and the call to the geometry_manager procedure of 
the widget's parent returns XtGeometryYes with 
request->request_mode set to a value other than XtCWQueryOnly 
it shall call the XConfigureWindow Xlib function.
>>ASSERTION Good A
A call to
XtGeometryResult XtMakeResizeRequest(w, width, height, 
width_return, height_return)
when the widget
.A w
is realized, the width field of the widget is not
equal to
.A width
or the height field is not equal to
.A height,
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
Dimension width_return, height_return;
Dimension width, height;

/*this test does not pass prior do R6.4gamma due to issues with
consistency of the spec, test suite, and sample code*/
if (config.coverage < 2) {
	FORK(pid2);
	avs_xt_hier("Tmkrsizrt1", "XtMakeResizeRequest");
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
	width = geom.width + 10;
	height = geom.height + 10;
	/*this forces the avsForm (parent) widget's geometry manager to
	return XtMakeGeometryDone*/
	avs_set_event(5, 77);
	result = XtMakeResizeRequest(formw_good2, width, height, &width_return, &height_return);
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
} else {
	tet_infoline("INFO: Test surpressed due to XT_COVERAGE value");
	tet_result(TET_UNTESTED);
}
>>ASSERTION Good A
A call to
XtGeometryResult XtMakeResizeRequest(w, width, height, 
width_return, height_return)
when the widget
.A w
is realized, the width field of the widget is not
equal to
.A width
or the height field is not equal to
.A height,
and the call to the geometry_manager procedure of the 
the widget's parent neither returns XtGeometryYes with 
request->request_mode set to a value other than XtCWQueryOnly 
nor returns XtGeometryDone shall return what the geometry_manager 
procedure returns.
>>CODE
Widget cooperative_composite, cooperative_widget;
XtWidgetGeometry intended, geom;
XtGeometryResult result;
Dimension width, height;
Dimension width_return, height_return;

	avs_xt_hier("Tmkrsizrt1", "XtMakeResizeRequest");
	tet_infoline("PREP: Createcooperative composite widget in boxw1");
	cooperative_composite = XtCreateManagedWidget("cooperative_widget",
						avsCompWidgetClass,
						boxw1,
						(ArgList) 0, 0);
	tet_infoline("PREP: Create cooperative widget in cooperative composite");
	cooperative_widget = XtCreateManagedWidget("cooperative_widget",
						avsWidgetClass,
						cooperative_composite,
						(ArgList) 0, 0);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Query geometry of cooperative widget");
	intended.request_mode = CWWidth|CWHeight;
	XtQueryGeometry(cooperative_widget, &intended, &geom);
	tet_infoline("PREP: Change width and height of cooperative widget");
	width = geom.width+10;
	height = geom.height+10;
	result = XtMakeResizeRequest(cooperative_widget, width, height, &width_return, &height_return);
	tet_infoline("TEST: Return value is XtGeometyYes");
	check_dec(XtGeometryYes, result, "XtGeometryYes");
	tet_result(TET_PASS);
>>ASSERTION Good A
On a call to
XtGeometryResult XtMakeResizeRequest(w, width, height, 
width_return, height_return)
when the return value is XtGeometryAlmost,
.A width_return
and
.A height_return
shall contain the compromise width and height respectively.
>>CODE
XtWidgetGeometry request;
XtWidgetGeometry reply_return;
XtWidgetGeometry intended, geom;
XtGeometryResult result;
Widget formw_good, formw_good2, labelw_good;
pid_t pid2;
int invoked;
Dimension width_return, height_return;
Dimension width, height;

	FORK(pid2);
	avs_xt_hier("Tmkrsizrt1", "XtMakeResizeRequest");
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
	width = geom.width + 10;
	height = geom.height + 10;
	/*this forces the avsForm (parent) widget's geometry manager to
	return XtMakeGeometryAlmost*/
	avs_set_event(5, 88);
	result = XtMakeResizeRequest(formw_good2, width, height, &width_return, &height_return);
	tet_infoline("TEST: return value is XtGeometryAlmost");
	check_dec(XtGeometryAlmost, result, "XtMakeGeometryRequest result");
	tet_infoline("TEST: Returned width and height");
	check_dec(88, width_return, "width");
	check_dec(99, height_return, "height");
        LKROF(pid2, AVSXTTIMEOUT-2);
        tet_infoline("TEST: Parent's Geometry manager was invoked");
        invoked = avs_get_event(5);
        if (!invoked) {
                sprintf(ebuf, "ERROR: Geometry manager was not invoked");
                tet_infoline(ebuf);
                tet_result(TET_FAIL);
        }
	tet_result(TET_PASS);
>>ASSERTION Good B 3
When 
.A width
and
.A height
are both NULL a call to
XtGeometryResult XtMakeResizeRequest(w, width, height, 
width_return, height_return)
shall not return XtGeometryAlmost.
