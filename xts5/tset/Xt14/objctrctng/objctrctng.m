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
$Header: /cvs/xtest/xtest/xts5/tset/Xt14/objctrctng/objctrctng.m,v 1.1 2005-02-12 14:37:58 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt14/hrectobj/hrectobj.m
>># 
>># Description:
>>#	Tests for Rectangle Objects
>># 
>># Modifications:
>># $Log: objctrctng.m,v $
>># Revision 1.1  2005-02-12 14:37:58  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:37:16  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:00:11  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:28:22  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:56  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:19:02  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:13:07  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>
#include <X11/RectObjP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;
/*used for assignments to solicit compiler failures due to type mismatches*/
WidgetClass             myWidgetClass, *pmyWidgetClass;
String                  myString, *pmyString;
Cardinal                myCardinal, *pmyCardinal;
Boolean                 myBoolean, *pmyBoolean;
XtProc                  myXtProc, *pmyXtProc;
long			mylong, *pmylong;
XrmQuark                myXrmQuark, *pmyXrmQuark;
XtWidgetClassProc       myXtWidgetClassProc, *pmyXtWidgetClassProc;
XtEnum                  myXtEnum, *pmyXtEnum;
XtInitProc              myXtInitProc, *pmyXtInitProc;
XtArgsProc              myXtArgsProc, *pmyXtArgsProc;
XtRealizeProc           myXtRealizeProc, *pmyXtRealizeProc;
XtActionList            myXtActionList, *pmyXtActionList;
XtResourceList          myXtResourceList, *pmyXtResourceList;
XrmClass                myXrmClass, *pmyXrmClass;
XtWidgetProc            myXtWidgetProc, *pmyXtWidgetProc;
XtExposeProc            myXtExposeProc, *pmyXtExposeProc;
XtSetValuesFunc         myXtSetValuesFunc, *pmyXtSetValuesFunc;
XtArgsFunc              myXtArgsFunc, *pmyXtArgsFunc;
XtAlmostProc            myXtAlmostProc, *pmyXtAlmostProc;
XtArgsProc              myXtArgsProc, *pmyXtArgsProc;
XtAcceptFocusProc       myXtAcceptFocusProc, *pmyXtAcceptFocusProc;
XtVersionType           myXtVersionType, *pmyXtVersionType;
XtPointer               myXtPointer, *pmyXtPointer;
XtGeometryHandler       myXtGeometryHandler, *pmyXtGeometryHandler;
XtStringProc            myXtStringProc, *pmyXtStringProc;
Window                  myWindow, *pmyWindow;
WidgetList              myWidgetList, *pmyWidgetList;
Widget                  myWidget, *pmyWidget;
XrmName                 myXrmName, *pmyXrmName;
XtCallbackList          myXtCallbackList, *pmyXtCallbackList;
Dimension               myDimension, *pmyDimension;
XtEventTable            myXtEventTable, *pmyXtEventTable;
XtTMRec                 myXtTMRec, *pmyXtTMRec;
XtTranslations          myXtTranslations, *pmyXtTranslations;
Pixel                   myPixel, *pmyPixel;
Pixmap                  myPixmap, *pmyPixmap;
Colormap                myColormap, *pmyColormap;
Screen                  *pmyScreen;
>>TITLE RectangleObject Xt14
>>ASSERTION Good A
The class structure for rectangular objects
RectObjClassPart shall be defined and contain the
fields listed in section 14.3.1 of the Specification.
>>CODE
RectObjClassPart testStruct;

	check_size("RectObjClassPart.superclass", "WidgetClass", sizeof(testStruct.superclass), sizeof(WidgetClass));
	myWidgetClass = testStruct.superclass;
	pmyWidgetClass = &testStruct.superclass;

	check_size("RectObjClassPart.class_name", "String", sizeof(testStruct.class_name), sizeof(String));
	myString = testStruct.class_name;
	pmyString = &testStruct.class_name;

	check_size("RectObjClassPart.widget_size", "Cardinal", sizeof(testStruct.widget_size), sizeof(Cardinal));
	myCardinal = testStruct.widget_size;
	pmyCardinal = &testStruct.widget_size;

	check_size("RectObjClassPart.class_initialize", "XtProc", sizeof(testStruct.class_initialize), sizeof(XtProc));
	myXtProc = testStruct.class_initialize;
	pmyXtProc = &testStruct.class_initialize;

	check_size("RectObjClassPart.class_part_initialize", "XtWidgetClassProc", sizeof(testStruct.class_part_initialize), sizeof(XtWidgetClassProc));
	myXtWidgetClassProc = testStruct.class_part_initialize;
	pmyXtWidgetClassProc = &testStruct.class_part_initialize;

	check_size("RectObjClassPart.class_inited", "XtEnum", sizeof(testStruct.class_inited), sizeof(XtEnum));
	myXtEnum = testStruct.class_inited;
	pmyXtEnum = &testStruct.class_inited;

	check_size("RectObjClassPart.initialize", "XtInitProc", sizeof(testStruct.initialize), sizeof(XtInitProc));
	myXtInitProc = testStruct.initialize;
	pmyXtInitProc = &testStruct.initialize;

	check_size("RectObjClassPart.initialize_hook", "XtArgsProc", sizeof(testStruct.initialize_hook), sizeof(XtArgsProc));
	myXtArgsProc = testStruct.initialize_hook;
	pmyXtArgsProc = &testStruct.initialize_hook;

	check_size("RectObjClassPart.rect1", "XtProc", sizeof(testStruct.rect1), sizeof(XtProc));
	myXtProc = testStruct.rect1;
	pmyXtProc = &testStruct.rect1;

	check_size("RectObjClassPart.rect2", "XtPointer", sizeof(testStruct.rect2), sizeof(XtPointer));
	myXtPointer = testStruct.rect2;
	pmyXtPointer = &testStruct.rect2;

	check_size("RectObjClassPart.rect3", "Cardinal", sizeof(testStruct.rect3), sizeof(Cardinal));
	myCardinal = testStruct.rect3;
	pmyCardinal = &testStruct.rect3;

	check_size("RectObjClassPart.resources", "XtResourceList", sizeof(testStruct.resources), sizeof(XtResourceList));
	myXtResourceList = testStruct.resources;
	pmyXtResourceList = &testStruct.resources;

	check_size("RectObjClassPart.num_resources", "Cardinal", sizeof(testStruct.num_resources), sizeof(Cardinal));
	myCardinal = testStruct.num_resources;
	pmyCardinal = &testStruct.num_resources;

	check_size("RectObjClassPart.xrm_class", "XrmClass", sizeof(testStruct.xrm_class), sizeof(XrmClass));
	myXrmClass = testStruct.xrm_class;
	pmyXrmClass = &testStruct.xrm_class;

	check_size("RectObjClassPart.rect4", "Boolean", sizeof(testStruct.rect4), sizeof(Boolean));
	myBoolean = testStruct.rect4;
	pmyBoolean = &testStruct.rect4;

	check_size("RectObjClassPart.rect5", "XtEnum", sizeof(testStruct.rect5), sizeof(XtEnum));
	myXtEnum = testStruct.rect5;
	pmyXtEnum = &testStruct.rect5;

	check_size("RectObjClassPart.rect6", "Boolean", sizeof(testStruct.rect6), sizeof(Boolean));
	myBoolean = testStruct.rect6;
	pmyBoolean = &testStruct.rect6;

	check_size("RectObjClassPart.rect7", "Boolean", sizeof(testStruct.rect7), sizeof(Boolean));
	myBoolean = testStruct.rect7;
	pmyBoolean = &testStruct.rect7;

	check_size("RectObjClassPart.destroy", "XtWidgetProc", sizeof(testStruct.destroy), sizeof(XtWidgetProc));
	myXtWidgetProc = testStruct.destroy;
	pmyXtWidgetProc = &testStruct.destroy;

	check_size("RectObjClassPart.resize", "XtWidgetProc", sizeof(testStruct.resize), sizeof(XtWidgetProc));
	myXtWidgetProc = testStruct.resize;
	pmyXtWidgetProc = &testStruct.resize;

	check_size("RectObjClassPart.expose", "XtExposeProc", sizeof(testStruct.expose), sizeof(XtExposeProc));
	myXtExposeProc = testStruct.expose;
	pmyXtExposeProc = &testStruct.expose;

	check_size("RectObjClassPart.set_values", "XtSetValuesFunc", sizeof(testStruct.set_values), sizeof(XtSetValuesFunc));
	myXtSetValuesFunc = testStruct.set_values;
	pmyXtSetValuesFunc = &testStruct.set_values;

	check_size("RectObjClassPart.set_values_hook", "XtArgsFunc", sizeof(testStruct.set_values_hook), sizeof(XtArgsFunc));
	myXtArgsFunc = testStruct.set_values_hook;
	pmyXtArgsFunc = &testStruct.set_values_hook;

	check_size("RectObjClassPart.set_values_almost", "XtAlmostProc", sizeof(testStruct.set_values_almost), sizeof(XtAlmostProc));
	myXtAlmostProc = testStruct.set_values_almost;
	pmyXtAlmostProc = &testStruct.set_values_almost;

	check_size("RectObjClassPart.get_values_hook", "XtArgsProc", sizeof(testStruct.get_values_hook), sizeof(XtArgsProc));
	myXtArgsProc = testStruct.get_values_hook;
	pmyXtArgsProc = &testStruct.get_values_hook;

	check_size("RectObjClassPart.rect9", "XtProc", sizeof(testStruct.rect9), sizeof(XtProc));
	myXtProc = testStruct.rect9;
	pmyXtProc = &testStruct.rect9;

	check_size("RectObjClassPart.version", "XtVersionType", sizeof(testStruct.version), sizeof(XtVersionType));
	myXtVersionType = testStruct.version;
	pmyXtVersionType = &testStruct.version;

	check_size("RectObjClassPart.callback_private", "XtPointer", sizeof(testStruct.callback_private), sizeof(XtPointer));
	myXtPointer = testStruct.callback_private;
	pmyXtPointer = &testStruct.callback_private;

	check_size("RectObjClassPart.rect10", "String", sizeof(testStruct.rect10), sizeof(String));
	myString = testStruct.rect10;
	pmyString = &testStruct.rect10;

	check_size("RectObjClassPart.query_geometry", "XtGeometryHandler", sizeof(testStruct.query_geometry), sizeof(XtGeometryHandler));
	myXtGeometryHandler = testStruct.query_geometry;
	pmyXtGeometryHandler = &testStruct.query_geometry;

	check_size("RectObjClassPart.rect11", "XtProc", sizeof(testStruct.rect11), sizeof(XtProc));
	myXtProc = testStruct.rect11;
	pmyXtProc = &testStruct.rect11;

	check_size("RectObjClassPart.extension", "XtPointer", sizeof(testStruct.extension), sizeof(XtPointer));
	myXtPointer = testStruct.extension;
	pmyXtPointer = &testStruct.extension;
	tet_result(TET_PASS);
>>ASSERTION Good A
The class record structure for Rectangular Objects
RectObjClassRec shall be defined and contain the
fields listed in section 14.3.1 of the Specification.
>>CODE
	RectObjClassRec testStruct;

	check_size("RectObjClassRec.rect_class.superclass", "WidgetClass", sizeof(testStruct.rect_class.superclass), sizeof(WidgetClass));
	myWidgetClass = testStruct.rect_class.superclass;
	pmyWidgetClass = &testStruct.rect_class.superclass;

	check_size("RectObjClassRec.rect_class.class_name", "String", sizeof(testStruct.rect_class.class_name), sizeof(String));
	myString = testStruct.rect_class.class_name;
	pmyString = &testStruct.rect_class.class_name;

	check_size("RectObjClassRec.rect_class.widget_size", "Cardinal", sizeof(testStruct.rect_class.widget_size), sizeof(Cardinal));
	myCardinal = testStruct.rect_class.widget_size;
	pmyCardinal = &testStruct.rect_class.widget_size;

	check_size("RectObjClassRec.rect_class.class_initialize", "XtProc", sizeof(testStruct.rect_class.class_initialize), sizeof(XtProc));
	myXtProc = testStruct.rect_class.class_initialize;
	pmyXtProc = &testStruct.rect_class.class_initialize;

	check_size("RectObjClassRec.rect_class.class_part_initialize", "XtWidgetClassProc", sizeof(testStruct.rect_class.class_part_initialize), sizeof(XtWidgetClassProc));
	myXtWidgetClassProc = testStruct.rect_class.class_part_initialize;
	pmyXtWidgetClassProc = &testStruct.rect_class.class_part_initialize;

	check_size("RectObjClassRec.rect_class.class_inited", "XtEnum", sizeof(testStruct.rect_class.class_inited), sizeof(XtEnum));
	myXtEnum = testStruct.rect_class.class_inited;
	pmyXtEnum = &testStruct.rect_class.class_inited;

	check_size("RectObjClassRec.rect_class.initialize", "XtInitProc", sizeof(testStruct.rect_class.initialize), sizeof(XtInitProc));
	myXtInitProc = testStruct.rect_class.initialize;
	pmyXtInitProc = &testStruct.rect_class.initialize;

	check_size("RectObjClassRec.rect_class.initialize_hook", "XtArgsProc", sizeof(testStruct.rect_class.initialize_hook), sizeof(XtArgsProc));
	myXtArgsProc = testStruct.rect_class.initialize_hook;
	pmyXtArgsProc = &testStruct.rect_class.initialize_hook;

	check_size("RectObjClassRec.rect_class.rect1", "XtProc", sizeof(testStruct.rect_class.rect1), sizeof(XtProc));
	myXtProc = testStruct.rect_class.rect1;
	pmyXtProc = &testStruct.rect_class.rect1;

	check_size("RectObjClassRec.rect_class.rect2", "XtPointer", sizeof(testStruct.rect_class.rect2), sizeof(XtPointer));
	myXtPointer = testStruct.rect_class.rect2;
	pmyXtPointer = &testStruct.rect_class.rect2;

	check_size("RectObjClassRec.rect_class.rect3", "Cardinal", sizeof(testStruct.rect_class.rect3), sizeof(Cardinal));
	myCardinal = testStruct.rect_class.rect3;
	pmyCardinal = &testStruct.rect_class.rect3;

	check_size("RectObjClassRec.rect_class.resources", "XtResourceList", sizeof(testStruct.rect_class.resources), sizeof(XtResourceList));
	myXtResourceList = testStruct.rect_class.resources;
	pmyXtResourceList = &testStruct.rect_class.resources;

	check_size("RectObjClassRec.rect_class.num_resources", "Cardinal", sizeof(testStruct.rect_class.num_resources), sizeof(Cardinal));
	myCardinal = testStruct.rect_class.num_resources;
	pmyCardinal = &testStruct.rect_class.num_resources;

	check_size("RectObjClassRec.rect_class.xrm_class", "XrmClass", sizeof(testStruct.rect_class.xrm_class), sizeof(XrmClass));
	myXrmClass = testStruct.rect_class.xrm_class;
	pmyXrmClass = &testStruct.rect_class.xrm_class;

	check_size("RectObjClassRec.rect_class.rect4", "Boolean", sizeof(testStruct.rect_class.rect4), sizeof(Boolean));
	myBoolean = testStruct.rect_class.rect4;
	pmyBoolean = &testStruct.rect_class.rect4;

	check_size("RectObjClassRec.rect_class.rect5", "XtEnum", sizeof(testStruct.rect_class.rect5), sizeof(XtEnum));
	myXtEnum = testStruct.rect_class.rect5;
	pmyXtEnum = &testStruct.rect_class.rect5;

	check_size("RectObjClassRec.rect_class.rect6", "Boolean", sizeof(testStruct.rect_class.rect6), sizeof(Boolean));
	myBoolean = testStruct.rect_class.rect6;
	pmyBoolean = &testStruct.rect_class.rect6;

	check_size("RectObjClassRec.rect_class.rect7", "Boolean", sizeof(testStruct.rect_class.rect7), sizeof(Boolean));
	myBoolean = testStruct.rect_class.rect7;
	pmyBoolean = &testStruct.rect_class.rect7;

	check_size("RectObjClassRec.rect_class.destroy", "XtWidgetProc", sizeof(testStruct.rect_class.destroy), sizeof(XtWidgetProc));
	myXtWidgetProc = testStruct.rect_class.destroy;
	pmyXtWidgetProc = &testStruct.rect_class.destroy;

	check_size("RectObjClassRec.rect_class.resize", "XtWidgetProc", sizeof(testStruct.rect_class.resize), sizeof(XtWidgetProc));
	myXtWidgetProc = testStruct.rect_class.resize;
	pmyXtWidgetProc = &testStruct.rect_class.resize;

	check_size("RectObjClassRec.rect_class.expose", "XtExposeProc", sizeof(testStruct.rect_class.expose), sizeof(XtExposeProc));
	myXtExposeProc = testStruct.rect_class.expose;
	pmyXtExposeProc = &testStruct.rect_class.expose;

	check_size("RectObjClassRec.rect_class.set_values", "XtSetValuesFunc", sizeof(testStruct.rect_class.set_values), sizeof(XtSetValuesFunc));
	myXtSetValuesFunc = testStruct.rect_class.set_values;
	pmyXtSetValuesFunc = &testStruct.rect_class.set_values;

	check_size("RectObjClassRec.rect_class.set_values_hook", "XtArgsFunc", sizeof(testStruct.rect_class.set_values_hook), sizeof(XtArgsFunc));
	myXtArgsFunc = testStruct.rect_class.set_values_hook;
	pmyXtArgsFunc = &testStruct.rect_class.set_values_hook;

	check_size("RectObjClassRec.rect_class.set_values_almost", "XtAlmostProc", sizeof(testStruct.rect_class.set_values_almost), sizeof(XtAlmostProc));
	myXtAlmostProc = testStruct.rect_class.set_values_almost;
	pmyXtAlmostProc = &testStruct.rect_class.set_values_almost;

	check_size("RectObjClassRec.rect_class.get_values_hook", "XtArgsProc", sizeof(testStruct.rect_class.get_values_hook), sizeof(XtArgsProc));
	myXtArgsProc = testStruct.rect_class.get_values_hook;
	pmyXtArgsProc = &testStruct.rect_class.get_values_hook;

	check_size("RectObjClassRec.rect_class.rect9", "XtProc", sizeof(testStruct.rect_class.rect9), sizeof(XtProc));
	myXtProc = testStruct.rect_class.rect9;
	pmyXtProc = &testStruct.rect_class.rect9;

	check_size("RectObjClassRec.rect_class.version", "XtVersionType", sizeof(testStruct.rect_class.version), sizeof(XtVersionType));
	myXtVersionType = testStruct.rect_class.version;
	pmyXtVersionType = &testStruct.rect_class.version;

	check_size("RectObjClassRec.rect_class.callback_private", "XtPointer", sizeof(testStruct.rect_class.callback_private), sizeof(XtPointer));
	myXtPointer = testStruct.rect_class.callback_private;
	pmyXtPointer = &testStruct.rect_class.callback_private;

	check_size("RectObjClassRec.rect_class.rect10", "String", sizeof(testStruct.rect_class.rect10), sizeof(String));
	myString = testStruct.rect_class.rect10;
	pmyString = &testStruct.rect_class.rect10;

	check_size("RectObjClassRec.rect_class.query_geometry", "XtGeometryHandler", sizeof(testStruct.rect_class.query_geometry), sizeof(XtGeometryHandler));
	myXtGeometryHandler = testStruct.rect_class.query_geometry;
	pmyXtGeometryHandler = &testStruct.rect_class.query_geometry;

	check_size("RectObjClassRec.rect_class.rect11", "XtProc", sizeof(testStruct.rect_class.rect11), sizeof(XtProc));
	myXtProc = testStruct.rect_class.rect11;
	pmyXtProc = &testStruct.rect_class.rect11;

	check_size("RectObjClassRec.rect_class.extension", "XtPointer", sizeof(testStruct.rect_class.extension), sizeof(XtPointer));
	myXtPointer = testStruct.rect_class.extension;
	pmyXtPointer = &testStruct.rect_class.extension;
	tet_result(TET_PASS);
>>ASSERTION Good A
The class record for objects recObjClassRec shall
exist and be an instance of the RectObjClassRec
structure.
>>CODE

	check_size("rectObjClassRec.rect_class.superclass", "WidgetClass", sizeof(rectObjClassRec.rect_class.superclass), sizeof(WidgetClass));
	myWidgetClass = rectObjClassRec.rect_class.superclass;
	pmyWidgetClass = &rectObjClassRec.rect_class.superclass;

	check_size("rectObjClassRec.rect_class.class_name", "String", sizeof(rectObjClassRec.rect_class.class_name), sizeof(String));
	myString = rectObjClassRec.rect_class.class_name;
	pmyString = &rectObjClassRec.rect_class.class_name;

	check_size("rectObjClassRec.rect_class.widget_size", "Cardinal", sizeof(rectObjClassRec.rect_class.widget_size), sizeof(Cardinal));
	myCardinal = rectObjClassRec.rect_class.widget_size;
	pmyCardinal = &rectObjClassRec.rect_class.widget_size;

	check_size("rectObjClassRec.rect_class.class_initialize", "XtProc", sizeof(rectObjClassRec.rect_class.class_initialize), sizeof(XtProc));
	myXtProc = rectObjClassRec.rect_class.class_initialize;
	pmyXtProc = &rectObjClassRec.rect_class.class_initialize;

	check_size("rectObjClassRec.rect_class.class_part_initialize", "XtWidgetClassProc", sizeof(rectObjClassRec.rect_class.class_part_initialize), sizeof(XtWidgetClassProc));
	myXtWidgetClassProc = rectObjClassRec.rect_class.class_part_initialize;
	pmyXtWidgetClassProc = &rectObjClassRec.rect_class.class_part_initialize;

	check_size("rectObjClassRec.rect_class.class_inited", "XtEnum", sizeof(rectObjClassRec.rect_class.class_inited), sizeof(XtEnum));
	myXtEnum = rectObjClassRec.rect_class.class_inited;
	pmyXtEnum = &rectObjClassRec.rect_class.class_inited;

	check_size("rectObjClassRec.rect_class.initialize", "XtInitProc", sizeof(rectObjClassRec.rect_class.initialize), sizeof(XtInitProc));
	myXtInitProc = rectObjClassRec.rect_class.initialize;
	pmyXtInitProc = &rectObjClassRec.rect_class.initialize;

	check_size("rectObjClassRec.rect_class.initialize_hook", "XtArgsProc", sizeof(rectObjClassRec.rect_class.initialize_hook), sizeof(XtArgsProc));
	myXtArgsProc = rectObjClassRec.rect_class.initialize_hook;
	pmyXtArgsProc = &rectObjClassRec.rect_class.initialize_hook;

	check_size("rectObjClassRec.rect_class.rect1", "XtProc", sizeof(rectObjClassRec.rect_class.rect1), sizeof(XtProc));
	myXtProc = rectObjClassRec.rect_class.rect1;
	pmyXtProc = &rectObjClassRec.rect_class.rect1;

	check_size("rectObjClassRec.rect_class.rect2", "XtPointer", sizeof(rectObjClassRec.rect_class.rect2), sizeof(XtPointer));
	myXtPointer = rectObjClassRec.rect_class.rect2;
	pmyXtPointer = &rectObjClassRec.rect_class.rect2;

	check_size("rectObjClassRec.rect_class.rect3", "Cardinal", sizeof(rectObjClassRec.rect_class.rect3), sizeof(Cardinal));
	myCardinal = rectObjClassRec.rect_class.rect3;
	pmyCardinal = &rectObjClassRec.rect_class.rect3;

	check_size("rectObjClassRec.rect_class.resources", "XtResourceList", sizeof(rectObjClassRec.rect_class.resources), sizeof(XtResourceList));
	myXtResourceList = rectObjClassRec.rect_class.resources;
	pmyXtResourceList = &rectObjClassRec.rect_class.resources;

	check_size("rectObjClassRec.rect_class.num_resources", "Cardinal", sizeof(rectObjClassRec.rect_class.num_resources), sizeof(Cardinal));
	myCardinal = rectObjClassRec.rect_class.num_resources;
	pmyCardinal = &rectObjClassRec.rect_class.num_resources;

	check_size("rectObjClassRec.rect_class.xrm_class", "XrmClass", sizeof(rectObjClassRec.rect_class.xrm_class), sizeof(XrmClass));
	myXrmClass = rectObjClassRec.rect_class.xrm_class;
	pmyXrmClass = &rectObjClassRec.rect_class.xrm_class;

	check_size("rectObjClassRec.rect_class.rect4", "Boolean", sizeof(rectObjClassRec.rect_class.rect4), sizeof(Boolean));
	myBoolean = rectObjClassRec.rect_class.rect4;
	pmyBoolean = &rectObjClassRec.rect_class.rect4;

	check_size("rectObjClassRec.rect_class.rect5", "XtEnum", sizeof(rectObjClassRec.rect_class.rect5), sizeof(XtEnum));
	myXtEnum = rectObjClassRec.rect_class.rect5;
	pmyXtEnum = &rectObjClassRec.rect_class.rect5;

	check_size("rectObjClassRec.rect_class.rect6", "Boolean", sizeof(rectObjClassRec.rect_class.rect6), sizeof(Boolean));
	myBoolean = rectObjClassRec.rect_class.rect6;
	pmyBoolean = &rectObjClassRec.rect_class.rect6;

	check_size("rectObjClassRec.rect_class.rect7", "Boolean", sizeof(rectObjClassRec.rect_class.rect7), sizeof(Boolean));
	myBoolean = rectObjClassRec.rect_class.rect7;
	pmyBoolean = &rectObjClassRec.rect_class.rect7;

	check_size("rectObjClassRec.rect_class.destroy", "XtWidgetProc", sizeof(rectObjClassRec.rect_class.destroy), sizeof(XtWidgetProc));
	myXtWidgetProc = rectObjClassRec.rect_class.destroy;
	pmyXtWidgetProc = &rectObjClassRec.rect_class.destroy;

	check_size("rectObjClassRec.rect_class.resize", "XtWidgetProc", sizeof(rectObjClassRec.rect_class.resize), sizeof(XtWidgetProc));
	myXtWidgetProc = rectObjClassRec.rect_class.resize;
	pmyXtWidgetProc = &rectObjClassRec.rect_class.resize;

	check_size("rectObjClassRec.rect_class.expose", "XtExposeProc", sizeof(rectObjClassRec.rect_class.expose), sizeof(XtExposeProc));
	myXtExposeProc = rectObjClassRec.rect_class.expose;
	pmyXtExposeProc = &rectObjClassRec.rect_class.expose;

	check_size("rectObjClassRec.rect_class.set_values", "XtSetValuesFunc", sizeof(rectObjClassRec.rect_class.set_values), sizeof(XtSetValuesFunc));
	myXtSetValuesFunc = rectObjClassRec.rect_class.set_values;
	pmyXtSetValuesFunc = &rectObjClassRec.rect_class.set_values;

	check_size("rectObjClassRec.rect_class.set_values_hook", "XtArgsFunc", sizeof(rectObjClassRec.rect_class.set_values_hook), sizeof(XtArgsFunc));
	myXtArgsFunc = rectObjClassRec.rect_class.set_values_hook;
	pmyXtArgsFunc = &rectObjClassRec.rect_class.set_values_hook;

	check_size("rectObjClassRec.rect_class.set_values_almost", "XtAlmostProc", sizeof(rectObjClassRec.rect_class.set_values_almost), sizeof(XtAlmostProc));
	myXtAlmostProc = rectObjClassRec.rect_class.set_values_almost;
	pmyXtAlmostProc = &rectObjClassRec.rect_class.set_values_almost;

	check_size("rectObjClassRec.rect_class.get_values_hook", "XtArgsProc", sizeof(rectObjClassRec.rect_class.get_values_hook), sizeof(XtArgsProc));
	myXtArgsProc = rectObjClassRec.rect_class.get_values_hook;
	pmyXtArgsProc = &rectObjClassRec.rect_class.get_values_hook;

	check_size("rectObjClassRec.rect_class.rect9", "XtProc", sizeof(rectObjClassRec.rect_class.rect9), sizeof(XtProc));
	myXtProc = rectObjClassRec.rect_class.rect9;
	pmyXtProc = &rectObjClassRec.rect_class.rect9;

	check_size("rectObjClassRec.rect_class.version", "XtVersionType", sizeof(rectObjClassRec.rect_class.version), sizeof(XtVersionType));
	myXtVersionType = rectObjClassRec.rect_class.version;
	pmyXtVersionType = &rectObjClassRec.rect_class.version;

	check_size("rectObjClassRec.rect_class.callback_private", "XtPointer", sizeof(rectObjClassRec.rect_class.callback_private), sizeof(XtPointer));
	myXtPointer = rectObjClassRec.rect_class.callback_private;
	pmyXtPointer = &rectObjClassRec.rect_class.callback_private;

	check_size("rectObjClassRec.rect_class.rect10", "String", sizeof(rectObjClassRec.rect_class.rect10), sizeof(String));
	myString = rectObjClassRec.rect_class.rect10;
	pmyString = &rectObjClassRec.rect_class.rect10;

	check_size("rectObjClassRec.rect_class.query_geometry", "XtGeometryHandler", sizeof(rectObjClassRec.rect_class.query_geometry), sizeof(XtGeometryHandler));
	myXtGeometryHandler = rectObjClassRec.rect_class.query_geometry;
	pmyXtGeometryHandler = &rectObjClassRec.rect_class.query_geometry;

	check_size("rectObjClassRec.rect_class.rect11", "XtProc", sizeof(rectObjClassRec.rect_class.rect11), sizeof(XtProc));
	myXtProc = rectObjClassRec.rect_class.rect11;
	pmyXtProc = &rectObjClassRec.rect_class.rect11;

	check_size("rectObjClassRec.rect_class.extension", "XtPointer", sizeof(rectObjClassRec.rect_class.extension), sizeof(XtPointer));
	myXtPointer = rectObjClassRec.rect_class.extension;
	pmyXtPointer = &rectObjClassRec.rect_class.extension;
	tet_result(TET_PASS);
>>ASSERTION Good A
The class pointer for rectangular objects rectObjClass
shall exist and point to the rectObjClassRec class
record.
>>CODE

	tet_infoline("TEST: rectObjClass");
	if (rectObjClass != (WidgetClass)&rectObjClassRec) {
		sprintf(ebuf, "ERROR: rectObjClass does not point to rectObjClassRec");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
>>ASSERTION Good A
The type RectObjClass shall be defined as a pointer to
an object class structure.
>>CODE
RectObjClass testvar;
XtPointer testvar2;

	/* this will not build if the define is not correct*/
	tet_infoline("TEST: RectObjClass");
	testvar = &rectObjClassRec;
	testvar2 = testvar->rect_class.superclass;
	tet_result(TET_PASS);
>>ASSERTION Good A
The instance structure for rectangular objects
RectObjPart shall be defined and contain the fields
listed in section 14.3.2 of the Specification.
>>CODE
	RectObjPart testStruct;

	check_size("RectObjPart.border_width", "Dimension", sizeof(testStruct.border_width), sizeof(Dimension));
	myDimension = testStruct.border_width;
	pmyDimension = &testStruct.border_width;

	check_size("RectObjPart.managed", "Boolean", sizeof(testStruct.managed), sizeof(Boolean));
	myBoolean = testStruct.managed;
	pmyBoolean = &testStruct.managed;

	check_size("RectObjPart.sensitive", "Boolean", sizeof(testStruct.sensitive), sizeof(Boolean));
	myBoolean = testStruct.sensitive;
	pmyBoolean = &testStruct.sensitive;

	check_size("RectObjPart.ancestor_sensitive", "Boolean", sizeof(testStruct.ancestor_sensitive), sizeof(Boolean));
	myBoolean = testStruct.ancestor_sensitive;
	pmyBoolean = &testStruct.ancestor_sensitive;
	tet_result(TET_PASS);
>>ASSERTION Good A
The instance record structure for rectangular objects
RectObjRec shall be defined and contain the fields
listed in section 14.3.2 of the Specification.
>>CODE
RectObjRec testStruct;

	check_size("RectObjRec.object.self", "Widget", sizeof(testStruct.object.self), sizeof(Widget));
	myWidget = testStruct.object.self;
	pmyWidget = &testStruct.object.self;

	check_size("RectObjRec.object.widget_class", "WidgetClass", sizeof(testStruct.object.widget_class), sizeof(WidgetClass));
	myWidgetClass = testStruct.object.widget_class;
	pmyWidgetClass = &testStruct.object.widget_class;

	check_size("RectObjRec.object.parent", "Widget", sizeof(testStruct.object.parent), sizeof(Widget));
	myWidget = testStruct.object.parent;
	pmyWidget = &testStruct.object.parent;

	check_size("RectObjRec.object.xrm_name", "XrmName", sizeof(testStruct.object.xrm_name), sizeof(XrmName));
	myXrmName = testStruct.object.xrm_name;
	pmyXrmName = &testStruct.object.xrm_name;

	check_size("RectObjRec.object.being_destroyed", "Boolean", sizeof(testStruct.object.being_destroyed), sizeof(Boolean));
	myBoolean = testStruct.object.being_destroyed;
	pmyBoolean = &testStruct.object.being_destroyed;

	check_size("RectObjRec.object.destroy_callbacks", "XtCallbackList", sizeof(testStruct.object.destroy_callbacks), sizeof(XtCallbackList));
	myXtCallbackList = testStruct.object.destroy_callbacks;
	pmyXtCallbackList = &testStruct.object.destroy_callbacks;

	check_size("RectObjRec.object.constraints", "XtPointer", sizeof(testStruct.object.constraints), sizeof(XtPointer));
	myXtPointer = testStruct.object.constraints;
	pmyXtPointer = &testStruct.object.constraints;

	check_size("RectObjRec.rectangle.border_width", "Dimension", sizeof(testStruct.rectangle.border_width), sizeof(Dimension));
	myDimension = testStruct.rectangle.border_width;
	pmyDimension = &testStruct.rectangle.border_width;

	check_size("RectObjRec.rectangle.managed", "Boolean", sizeof(testStruct.rectangle.managed), sizeof(Boolean));
	myBoolean = testStruct.rectangle.managed;
	pmyBoolean = &testStruct.rectangle.managed;

	check_size("RectObjRec.rectangle.sensitive", "Boolean", sizeof(testStruct.rectangle.sensitive), sizeof(Boolean));
	myBoolean = testStruct.rectangle.sensitive;
	pmyBoolean = &testStruct.rectangle.sensitive;

	check_size("RectObjRec.rectangle.ancestor_sensitive", "Boolean", sizeof(testStruct.rectangle.ancestor_sensitive), sizeof(Boolean));
	myBoolean = testStruct.rectangle.ancestor_sensitive;
	pmyBoolean = &testStruct.rectangle.ancestor_sensitive;

	tet_result(TET_PASS);
>>ASSERTION Good A
The type RectObj shall be defined as a pointer to a
rectangular object instance.
>>CODE
RectObjRec testobj;
RectObj testvar;
Position testvar2;

	/* this will not build if the define is not correct*/
	tet_infoline("TEST: RectObj");
	/*doesn't matter where we point, just testing syntax*/
	testvar = &testobj;
	testvar2 = testvar->rectangle.x;
	tet_result(TET_PASS);
>>ASSERTION Good A
The fields of the RectObjPart element of the
RectObjRec shall be initialized to the default values
specified in section 14.3.4 of the Specification on
creation of a new RectObj instance.
>>CODE
RectObj testwidget, testwidget3;
Object testwidget2;

	avs_xt_hier("Hrectobj9", "XtRectObj");
	tet_infoline("PREP: Create clean rectobj");
	testwidget2 = (Object)XtCreateWidget("test2", objectClass, topLevel, NULL, 0);
	testwidget3 = (RectObj)XtCreateWidget("test3", rectObjClass, (Widget)testwidget2, NULL, 0);
	testwidget = (RectObj)XtCreateWidget("ApTest", rectObjClass, (Widget)testwidget3, NULL, 0);
	tet_infoline("TEST: x");
	if (testwidget->rectangle.x != 0) {
		
		sprintf(ebuf, "ERROR: x member is %d, not 0", testwidget->rectangle.x);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: y");
	if (testwidget->rectangle.y != 0) {
		sprintf(ebuf, "ERROR: y member is %d, not 0", testwidget->rectangle.y);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: width");
	if (testwidget->rectangle.width != 0) {
		sprintf(ebuf, "ERROR: width member is %d, not 0", testwidget->rectangle.width);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: height");
	if (testwidget->rectangle.height != 0) {
		sprintf(ebuf, "ERROR: height member is %d, not 0", testwidget->rectangle.height);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: border_width");
	if (testwidget->rectangle.border_width != 1) {
		sprintf(ebuf, "ERROR: border_width member is %d, not 1", testwidget->rectangle.border_width);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: managed");
	if (testwidget->rectangle.managed != False) {
		sprintf(ebuf, "ERROR: managed member is %d, not False", testwidget->rectangle.managed);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: sensitive");
	if (testwidget->rectangle.sensitive != True) {
		sprintf(ebuf, "ERROR: sensitive member is %d, not True", testwidget->rectangle.sensitive);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: ancestor_sensitive");
	if (testwidget->rectangle.ancestor_sensitive != (testwidget3->rectangle.sensitive & testwidget3->rectangle.ancestor_sensitive)) {
		sprintf(ebuf, "ERROR: Expected ancestor_sensitive of %#x, is %#x", (testwidget3->rectangle.sensitive & testwidget3->rectangle.ancestor_sensitive), testwidget->rectangle.ancestor_sensitive);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
