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
$Header: /cvs/xtest/xtest/xts5/tset/Xt3/wdgtcnstrn/wdgtcnstrn.m,v 1.1 2005-02-12 14:38:00 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt3/wdgtcnstrn/wdgtcnstrn.m
>># 
>># Description:
>>#	Tests for Constraint widget data structures
>># 
>># Modifications:
>># $Log: wdgtcnstrn.m,v $
>># Revision 1.1  2005-02-12 14:38:00  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:36:04  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:58:51  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:27:16  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:23:49  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:15:07  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:18:38  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

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
XtOrderProc		myXtOrderProc, *pmyXtOrderProc;

>>TITLE ConstraintWidget Xt3
>>ASSERTION Good A
The class structure for constraint widgets ConstraintClassPart");
shall be defined and contain the fields listed in");
section 3.4.3 of the Specification.");
>>CODE
ConstraintClassPart testStruct;

	check_size("ConstraintClassPart.resources", "XtResourceList", sizeof(testStruct.resources), sizeof(XtResourceList));
	myXtResourceList = testStruct.resources;
	pmyXtResourceList = &testStruct.resources;

	check_size("ConstraintClassPart.num_resources", "Cardinal", sizeof(testStruct.num_resources), sizeof(Cardinal));
	myCardinal = testStruct.num_resources;
	pmyCardinal = &testStruct.num_resources;

	check_size("ConstraintClassPart.constraint_size", "Cardinal", sizeof(testStruct.constraint_size), sizeof(Cardinal));
	myCardinal = testStruct.constraint_size;
	pmyCardinal = &testStruct.constraint_size;

	check_size("ConstraintClassPart.initialize", "XtInitProc", sizeof(testStruct.initialize), sizeof(XtInitProc));
	myXtInitProc = testStruct.initialize;
	pmyXtInitProc = &testStruct.initialize;

	check_size("ConstraintClassPart.destroy", "XtWidgetProc", sizeof(testStruct.destroy), sizeof(XtWidgetProc));
	myXtWidgetProc = testStruct.destroy;
	pmyXtWidgetProc = &testStruct.destroy;

	check_size("ConstraintClassPart.set_values", "XtSetValuesFunc", sizeof(testStruct.set_values), sizeof(XtSetValuesFunc));
	myXtSetValuesFunc = testStruct.set_values;
	pmyXtSetValuesFunc = &testStruct.set_values;

	check_size("ConstraintClassPart.extension", "XtPointer", sizeof(testStruct.extension), sizeof(XtPointer));
	myXtPointer = testStruct.extension;
	pmyXtPointer = &testStruct.extension;

	tet_result(TET_PASS);
>>ASSERTION Good A
The extension structure for constraint widgets ConstraintClassExtensionRec
shall be defined and contain the fields listed in section 3.4.3 of the
Specification.
>>CODE
ConstraintClassExtensionRec testStruct;

	check_size("ConstraintClassExtensionRec.next_extension", "XtPointer", sizeof(testStruct.next_extension), sizeof(XtPointer));
	myXtPointer = testStruct.next_extension;
	pmyXtPointer = &testStruct.next_extension;

	check_size("ConstraintClassExtensionRec.record_type", "XrmQuark", sizeof(testStruct.record_type), sizeof(XrmQuark));
	myXrmQuark = testStruct.record_type;
	pmyXrmQuark = &testStruct.record_type;

	check_size("ConstraintClassExtensionRec.version", "long", sizeof(testStruct.version), sizeof(long));
	mylong = testStruct.version;
	pmylong = &testStruct.version;

	check_size("ConstraintClassExtensionRec.record_size", "Cardinal", sizeof(testStruct.record_size), sizeof(Cardinal));
	myCardinal = testStruct.record_size;
	pmyCardinal = &testStruct.record_size;

	check_size("ConstraintClassExtensionRec.get_values_hook", "XtArgsProc", sizeof(testStruct.get_values_hook), sizeof(XtArgsProc));
	myXtArgsProc = testStruct.get_values_hook;
	pmyXtArgsProc = &testStruct.get_values_hook;

	tet_result(TET_PASS);
>>ASSERTION Good A
The class record structure for constraint widgets ConstraintClassRec shall
be defined and contain the fields listed in section 3.4.3 of the Specification.
>>CODE
ConstraintClassRec testStruct;

	check_size("ConstraintClassRec.core_class.superclass", "WidgetClass", sizeof(testStruct.core_class.superclass), sizeof(WidgetClass));
	myWidgetClass = testStruct.core_class.superclass;
	pmyWidgetClass = &testStruct.core_class.superclass;

	check_size("ConstraintClassRec.core_class.class_name", "String", sizeof(testStruct.core_class.class_name), sizeof(String));
	myString = testStruct.core_class.class_name;
	pmyString = &testStruct.core_class.class_name;

	check_size("ConstraintClassRec.core_class.widget_size", "Cardinal", sizeof(testStruct.core_class.widget_size), sizeof(Cardinal));
	myCardinal = testStruct.core_class.widget_size;
	pmyCardinal = &testStruct.core_class.widget_size;

	check_size("ConstraintClassRec.core_class.class_initialize", "XtProc", sizeof(testStruct.core_class.class_initialize), sizeof(XtProc));
	myXtProc = testStruct.core_class.class_initialize;
	pmyXtProc = &testStruct.core_class.class_initialize;

	check_size("ConstraintClassRec.core_class.class_part_initialize", "XtWidgetClassProc", sizeof(testStruct.core_class.class_part_initialize), sizeof(XtWidgetClassProc));
	myXtWidgetClassProc = testStruct.core_class.class_part_initialize;
	pmyXtWidgetClassProc = &testStruct.core_class.class_part_initialize;

	check_size("ConstraintClassRec.core_class.class_inited", "XtEnum", sizeof(testStruct.core_class.class_inited), sizeof(XtEnum));
	myXtEnum = testStruct.core_class.class_inited;
	pmyXtEnum = &testStruct.core_class.class_inited;

	check_size("ConstraintClassRec.core_class.initialize", "XtInitProc", sizeof(testStruct.core_class.initialize), sizeof(XtInitProc));
	myXtInitProc = testStruct.core_class.initialize;
	pmyXtInitProc = &testStruct.core_class.initialize;

	check_size("ConstraintClassRec.core_class.initialize_hook", "XtArgsProc", sizeof(testStruct.core_class.initialize_hook), sizeof(XtArgsProc));
	myXtArgsProc = testStruct.core_class.initialize_hook;
	pmyXtArgsProc = &testStruct.core_class.initialize_hook;

	check_size("ConstraintClassRec.core_class.realize", "XtRealizeProc", sizeof(testStruct.core_class.realize), sizeof(XtRealizeProc));
	myXtRealizeProc = testStruct.core_class.realize;
	pmyXtRealizeProc = &testStruct.core_class.realize;

	check_size("ConstraintClassRec.core_class.actions", "XtActionList", sizeof(testStruct.core_class.actions), sizeof(XtActionList));
	myXtActionList = testStruct.core_class.actions;
	pmyXtActionList = &testStruct.core_class.actions;

	check_size("ConstraintClassRec.core_class.num_actions", "Cardinal", sizeof(testStruct.core_class.num_actions), sizeof(Cardinal));
	myCardinal = testStruct.core_class.num_actions;
	pmyCardinal = &testStruct.core_class.num_actions;

	check_size("ConstraintClassRec.core_class.resources", "XtResourceList", sizeof(testStruct.core_class.resources), sizeof(XtResourceList));
	myXtResourceList = testStruct.core_class.resources;
	pmyXtResourceList = &testStruct.core_class.resources;

	check_size("ConstraintClassRec.core_class.num_resources", "Cardinal", sizeof(testStruct.core_class.num_resources), sizeof(Cardinal));
	myCardinal = testStruct.core_class.num_resources;
	pmyCardinal = &testStruct.core_class.num_resources;

	check_size("ConstraintClassRec.core_class.xrm_class", "XrmClass", sizeof(testStruct.core_class.xrm_class), sizeof(XrmClass));
	myXrmClass = testStruct.core_class.xrm_class;
	pmyXrmClass = &testStruct.core_class.xrm_class;

	check_size("ConstraintClassRec.core_class.compress_motion", "Boolean", sizeof(testStruct.core_class.compress_motion), sizeof(Boolean));
	myBoolean = testStruct.core_class.compress_motion;
	pmyBoolean = &testStruct.core_class.compress_motion;

	check_size("ConstraintClassRec.core_class.compress_exposure", "XtEnum", sizeof(testStruct.core_class.compress_exposure), sizeof(XtEnum));
	myXtEnum = testStruct.core_class.compress_exposure;
	pmyXtEnum = &testStruct.core_class.compress_exposure;

	check_size("ConstraintClassRec.core_class.compress_enterleave", "Boolean", sizeof(testStruct.core_class.compress_enterleave), sizeof(Boolean));
	myBoolean = testStruct.core_class.compress_enterleave;
	pmyBoolean = &testStruct.core_class.compress_enterleave;

	check_size("ConstraintClassRec.core_class.visible_interest", "Boolean", sizeof(testStruct.core_class.visible_interest), sizeof(Boolean));
	myBoolean = testStruct.core_class.visible_interest;
	pmyBoolean = &testStruct.core_class.visible_interest;

	check_size("ConstraintClassRec.core_class.destroy", "XtWidgetProc", sizeof(testStruct.core_class.destroy), sizeof(XtWidgetProc));
	myXtWidgetProc = testStruct.core_class.destroy;
	pmyXtWidgetProc = &testStruct.core_class.destroy;

	check_size("ConstraintClassRec.core_class.resize", "XtWidgetProc", sizeof(testStruct.core_class.resize), sizeof(XtWidgetProc));
	myXtWidgetProc = testStruct.core_class.resize;
	pmyXtWidgetProc = &testStruct.core_class.resize;

	check_size("ConstraintClassRec.core_class.expose", "XtExposeProc", sizeof(testStruct.core_class.expose), sizeof(XtExposeProc));
	myXtExposeProc = testStruct.core_class.expose;
	pmyXtExposeProc = &testStruct.core_class.expose;

	check_size("ConstraintClassRec.core_class.set_values", "XtSetValuesFunc", sizeof(testStruct.core_class.set_values), sizeof(XtSetValuesFunc));
	myXtSetValuesFunc = testStruct.core_class.set_values;
	pmyXtSetValuesFunc = &testStruct.core_class.set_values;

	check_size("ConstraintClassRec.core_class.set_values_hook", "XtArgsFunc", sizeof(testStruct.core_class.set_values_hook), sizeof(XtArgsFunc));
	myXtArgsFunc = testStruct.core_class.set_values_hook;
	pmyXtArgsFunc = &testStruct.core_class.set_values_hook;

	check_size("ConstraintClassRec.core_class.set_values_almost", "XtAlmostProc", sizeof(testStruct.core_class.set_values_almost), sizeof(XtAlmostProc));
	myXtAlmostProc = testStruct.core_class.set_values_almost;
	pmyXtAlmostProc = &testStruct.core_class.set_values_almost;

	check_size("ConstraintClassRec.core_class.get_values_hook", "XtArgsProc", sizeof(testStruct.core_class.get_values_hook), sizeof(XtArgsProc));
	myXtArgsProc = testStruct.core_class.get_values_hook;
	pmyXtArgsProc = &testStruct.core_class.get_values_hook;

	check_size("ConstraintClassRec.core_class.accept_focus", "XtAcceptFocusProc", sizeof(testStruct.core_class.accept_focus), sizeof(XtAcceptFocusProc));
	myXtAcceptFocusProc = testStruct.core_class.accept_focus;
	pmyXtAcceptFocusProc = &testStruct.core_class.accept_focus;

	check_size("ConstraintClassRec.core_class.version", "XtVersionType", sizeof(testStruct.core_class.version), sizeof(XtVersionType));
	myXtVersionType = testStruct.core_class.version;
	pmyXtVersionType = &testStruct.core_class.version;

	check_size("ConstraintClassRec.core_class.callback_private", "XtPointer", sizeof(testStruct.core_class.callback_private), sizeof(XtPointer));
	myXtPointer = testStruct.core_class.callback_private;
	pmyXtPointer = &testStruct.core_class.callback_private;

	check_size("ConstraintClassRec.core_class.tm_table", "String", sizeof(testStruct.core_class.tm_table), sizeof(String));
	myString = testStruct.core_class.tm_table;
	pmyString = &testStruct.core_class.tm_table;

	check_size("ConstraintClassRec.core_class.query_geometry", "XtGeometryHandler", sizeof(testStruct.core_class.query_geometry), sizeof(XtGeometryHandler));
	myXtGeometryHandler = testStruct.core_class.query_geometry;
	pmyXtGeometryHandler = &testStruct.core_class.query_geometry;

	check_size("ConstraintClassRec.core_class.display_accelerator", "XtStringProc", sizeof(testStruct.core_class.display_accelerator), sizeof(XtStringProc));
	myXtStringProc = testStruct.core_class.display_accelerator;
	pmyXtStringProc = &testStruct.core_class.display_accelerator;

	check_size("ConstraintClassRec.core_class.extension", "XtPointer", sizeof(testStruct.core_class.extension), sizeof(XtPointer));
	myXtPointer = testStruct.core_class.extension;
	pmyXtPointer = &testStruct.core_class.extension;

	check_size("ConstraintClassRec.composite_class.geometry_manager", "XtGeometryHandler", sizeof(testStruct.composite_class.geometry_manager), sizeof(XtGeometryHandler));
	myXtGeometryHandler = testStruct.composite_class.geometry_manager;
	pmyXtGeometryHandler = &testStruct.composite_class.geometry_manager;

	check_size("ConstraintClassRec.composite_class.change_managed", "XtWidgetProc", sizeof(testStruct.composite_class.change_managed), sizeof(XtWidgetProc));
	myXtWidgetProc = testStruct.composite_class.change_managed;
	pmyXtWidgetProc = &testStruct.composite_class.change_managed;

	check_size("ConstraintClassRec.composite_class.insert_child", "XtWidgetProc", sizeof(testStruct.composite_class.insert_child), sizeof(XtWidgetProc));
	myXtWidgetProc = testStruct.composite_class.insert_child;
	pmyXtWidgetProc = &testStruct.composite_class.insert_child;

	check_size("ConstraintClassRec.composite_class.delete_child", "XtWidgetProc", sizeof(testStruct.composite_class.delete_child), sizeof(XtWidgetProc));
	myXtWidgetProc = testStruct.composite_class.delete_child;
	pmyXtWidgetProc = &testStruct.composite_class.delete_child;

	check_size("ConstraintClassRec.composite_class.extension", "XtPointer", sizeof(testStruct.composite_class.extension), sizeof(XtPointer));
	myXtPointer = testStruct.composite_class.extension;
	pmyXtPointer = &testStruct.composite_class.extension;

	check_size("ConstraintClassRec.constraint_class.resources", "XtResourceList", sizeof(testStruct.constraint_class.resources), sizeof(XtResourceList));
	myXtResourceList = testStruct.constraint_class.resources;
	pmyXtResourceList = &testStruct.constraint_class.resources;

	check_size("ConstraintClassRec.constraint_class.num_resources", "Cardinal", sizeof(testStruct.constraint_class.num_resources), sizeof(Cardinal));
	myCardinal = testStruct.constraint_class.num_resources;
	pmyCardinal = &testStruct.constraint_class.num_resources;

	check_size("ConstraintClassRec.constraint_class.constraint_size", "Cardinal", sizeof(testStruct.constraint_class.constraint_size), sizeof(Cardinal));
	myCardinal = testStruct.constraint_class.constraint_size;
	pmyCardinal = &testStruct.constraint_class.constraint_size;

	check_size("ConstraintClassRec.constraint_class.initialize", "XtInitProc", sizeof(testStruct.constraint_class.initialize), sizeof(XtInitProc));
	myXtInitProc = testStruct.constraint_class.initialize;
	pmyXtInitProc = &testStruct.constraint_class.initialize;

	check_size("ConstraintClassRec.constraint_class.destroy", "XtWidgetProc", sizeof(testStruct.constraint_class.destroy), sizeof(XtWidgetProc));
	myXtWidgetProc = testStruct.constraint_class.destroy;
	pmyXtWidgetProc = &testStruct.constraint_class.destroy;

	check_size("ConstraintClassRec.constraint_class.set_values", "XtSetValuesFunc", sizeof(testStruct.constraint_class.set_values), sizeof(XtSetValuesFunc));
	myXtSetValuesFunc = testStruct.constraint_class.set_values;
	pmyXtSetValuesFunc = &testStruct.constraint_class.set_values;

	check_size("ConstraintClassRec.constraint_class.extension", "XtPointer", sizeof(testStruct.constraint_class.extension), sizeof(XtPointer));
	myXtPointer = testStruct.constraint_class.extension;
	pmyXtPointer = &testStruct.constraint_class.extension;

	tet_result(TET_PASS);
>>ASSERTION Good A
The class record for constraint widgets constraintClassRec shall exist
and be an instance of the ConstraintClassRec structure.");
>>CODE

	check_size("constraintClassRec.core_class.superclass", "WidgetClass", sizeof(constraintClassRec.core_class.superclass), sizeof(WidgetClass));
	myWidgetClass = constraintClassRec.core_class.superclass;
	pmyWidgetClass = &constraintClassRec.core_class.superclass;

	check_size("constraintClassRec.core_class.class_name", "String", sizeof(constraintClassRec.core_class.class_name), sizeof(String));
	myString = constraintClassRec.core_class.class_name;
	pmyString = &constraintClassRec.core_class.class_name;

	check_size("constraintClassRec.core_class.widget_size", "Cardinal", sizeof(constraintClassRec.core_class.widget_size), sizeof(Cardinal));
	myCardinal = constraintClassRec.core_class.widget_size;
	pmyCardinal = &constraintClassRec.core_class.widget_size;

	check_size("constraintClassRec.core_class.class_initialize", "XtProc", sizeof(constraintClassRec.core_class.class_initialize), sizeof(XtProc));
	myXtProc = constraintClassRec.core_class.class_initialize;
	pmyXtProc = &constraintClassRec.core_class.class_initialize;

	check_size("constraintClassRec.core_class.class_part_initialize", "XtWidgetClassProc", sizeof(constraintClassRec.core_class.class_part_initialize), sizeof(XtWidgetClassProc));
	myXtWidgetClassProc = constraintClassRec.core_class.class_part_initialize;
	pmyXtWidgetClassProc = &constraintClassRec.core_class.class_part_initialize;

	check_size("constraintClassRec.core_class.class_inited", "XtEnum", sizeof(constraintClassRec.core_class.class_inited), sizeof(XtEnum));
	myXtEnum = constraintClassRec.core_class.class_inited;
	pmyXtEnum = &constraintClassRec.core_class.class_inited;

	check_size("constraintClassRec.core_class.initialize", "XtInitProc", sizeof(constraintClassRec.core_class.initialize), sizeof(XtInitProc));
	myXtInitProc = constraintClassRec.core_class.initialize;
	pmyXtInitProc = &constraintClassRec.core_class.initialize;

	check_size("constraintClassRec.core_class.initialize_hook", "XtArgsProc", sizeof(constraintClassRec.core_class.initialize_hook), sizeof(XtArgsProc));
	myXtArgsProc = constraintClassRec.core_class.initialize_hook;
	pmyXtArgsProc = &constraintClassRec.core_class.initialize_hook;

	check_size("constraintClassRec.core_class.realize", "XtRealizeProc", sizeof(constraintClassRec.core_class.realize), sizeof(XtRealizeProc));
	myXtRealizeProc = constraintClassRec.core_class.realize;
	pmyXtRealizeProc = &constraintClassRec.core_class.realize;

	check_size("constraintClassRec.core_class.actions", "XtActionList", sizeof(constraintClassRec.core_class.actions), sizeof(XtActionList));
	myXtActionList = constraintClassRec.core_class.actions;
	pmyXtActionList = &constraintClassRec.core_class.actions;

	check_size("constraintClassRec.core_class.num_actions", "Cardinal", sizeof(constraintClassRec.core_class.num_actions), sizeof(Cardinal));
	myCardinal = constraintClassRec.core_class.num_actions;
	pmyCardinal = &constraintClassRec.core_class.num_actions;

	check_size("constraintClassRec.core_class.resources", "XtResourceList", sizeof(constraintClassRec.core_class.resources), sizeof(XtResourceList));
	myXtResourceList = constraintClassRec.core_class.resources;
	pmyXtResourceList = &constraintClassRec.core_class.resources;

	check_size("constraintClassRec.core_class.num_resources", "Cardinal", sizeof(constraintClassRec.core_class.num_resources), sizeof(Cardinal));
	myCardinal = constraintClassRec.core_class.num_resources;
	pmyCardinal = &constraintClassRec.core_class.num_resources;

	check_size("constraintClassRec.core_class.xrm_class", "XrmClass", sizeof(constraintClassRec.core_class.xrm_class), sizeof(XrmClass));
	myXrmClass = constraintClassRec.core_class.xrm_class;
	pmyXrmClass = &constraintClassRec.core_class.xrm_class;

	check_size("constraintClassRec.core_class.compress_motion", "Boolean", sizeof(constraintClassRec.core_class.compress_motion), sizeof(Boolean));
	myBoolean = constraintClassRec.core_class.compress_motion;
	pmyBoolean = &constraintClassRec.core_class.compress_motion;

	check_size("constraintClassRec.core_class.compress_exposure", "XtEnum", sizeof(constraintClassRec.core_class.compress_exposure), sizeof(XtEnum));
	myXtEnum = constraintClassRec.core_class.compress_exposure;
	pmyXtEnum = &constraintClassRec.core_class.compress_exposure;

	check_size("constraintClassRec.core_class.compress_enterleave", "Boolean", sizeof(constraintClassRec.core_class.compress_enterleave), sizeof(Boolean));
	myBoolean = constraintClassRec.core_class.compress_enterleave;
	pmyBoolean = &constraintClassRec.core_class.compress_enterleave;

	check_size("constraintClassRec.core_class.visible_interest", "Boolean", sizeof(constraintClassRec.core_class.visible_interest), sizeof(Boolean));
	myBoolean = constraintClassRec.core_class.visible_interest;
	pmyBoolean = &constraintClassRec.core_class.visible_interest;

	check_size("constraintClassRec.core_class.destroy", "XtWidgetProc", sizeof(constraintClassRec.core_class.destroy), sizeof(XtWidgetProc));
	myXtWidgetProc = constraintClassRec.core_class.destroy;
	pmyXtWidgetProc = &constraintClassRec.core_class.destroy;

	check_size("constraintClassRec.core_class.resize", "XtWidgetProc", sizeof(constraintClassRec.core_class.resize), sizeof(XtWidgetProc));
	myXtWidgetProc = constraintClassRec.core_class.resize;
	pmyXtWidgetProc = &constraintClassRec.core_class.resize;

	check_size("constraintClassRec.core_class.expose", "XtExposeProc", sizeof(constraintClassRec.core_class.expose), sizeof(XtExposeProc));
	myXtExposeProc = constraintClassRec.core_class.expose;
	pmyXtExposeProc = &constraintClassRec.core_class.expose;

	check_size("constraintClassRec.core_class.set_values", "XtSetValuesFunc", sizeof(constraintClassRec.core_class.set_values), sizeof(XtSetValuesFunc));
	myXtSetValuesFunc = constraintClassRec.core_class.set_values;
	pmyXtSetValuesFunc = &constraintClassRec.core_class.set_values;

	check_size("constraintClassRec.core_class.set_values_hook", "XtArgsFunc", sizeof(constraintClassRec.core_class.set_values_hook), sizeof(XtArgsFunc));
	myXtArgsFunc = constraintClassRec.core_class.set_values_hook;
	pmyXtArgsFunc = &constraintClassRec.core_class.set_values_hook;

	check_size("constraintClassRec.core_class.set_values_almost", "XtAlmostProc", sizeof(constraintClassRec.core_class.set_values_almost), sizeof(XtAlmostProc));
	myXtAlmostProc = constraintClassRec.core_class.set_values_almost;
	pmyXtAlmostProc = &constraintClassRec.core_class.set_values_almost;

	check_size("constraintClassRec.core_class.get_values_hook", "XtArgsProc", sizeof(constraintClassRec.core_class.get_values_hook), sizeof(XtArgsProc));
	myXtArgsProc = constraintClassRec.core_class.get_values_hook;
	pmyXtArgsProc = &constraintClassRec.core_class.get_values_hook;

	check_size("constraintClassRec.core_class.accept_focus", "XtAcceptFocusProc", sizeof(constraintClassRec.core_class.accept_focus), sizeof(XtAcceptFocusProc));
	myXtAcceptFocusProc = constraintClassRec.core_class.accept_focus;
	pmyXtAcceptFocusProc = &constraintClassRec.core_class.accept_focus;

	check_size("constraintClassRec.core_class.version", "XtVersionType", sizeof(constraintClassRec.core_class.version), sizeof(XtVersionType));
	myXtVersionType = constraintClassRec.core_class.version;
	pmyXtVersionType = &constraintClassRec.core_class.version;

	check_size("constraintClassRec.core_class.callback_private", "XtPointer", sizeof(constraintClassRec.core_class.callback_private), sizeof(XtPointer));
	myXtPointer = constraintClassRec.core_class.callback_private;
	pmyXtPointer = &constraintClassRec.core_class.callback_private;

	check_size("constraintClassRec.core_class.tm_table", "String", sizeof(constraintClassRec.core_class.tm_table), sizeof(String));
	myString = constraintClassRec.core_class.tm_table;
	pmyString = &constraintClassRec.core_class.tm_table;

	check_size("constraintClassRec.core_class.query_geometry", "XtGeometryHandler", sizeof(constraintClassRec.core_class.query_geometry), sizeof(XtGeometryHandler));
	myXtGeometryHandler = constraintClassRec.core_class.query_geometry;
	pmyXtGeometryHandler = &constraintClassRec.core_class.query_geometry;

	check_size("constraintClassRec.core_class.display_accelerator", "XtStringProc", sizeof(constraintClassRec.core_class.display_accelerator), sizeof(XtStringProc));
	myXtStringProc = constraintClassRec.core_class.display_accelerator;
	pmyXtStringProc = &constraintClassRec.core_class.display_accelerator;

	check_size("constraintClassRec.core_class.extension", "XtPointer", sizeof(constraintClassRec.core_class.extension), sizeof(XtPointer));
	myXtPointer = constraintClassRec.core_class.extension;
	pmyXtPointer = &constraintClassRec.core_class.extension;

	check_size("constraintClassRec.composite_class.geometry_manager", "XtGeometryHandler", sizeof(constraintClassRec.composite_class.geometry_manager), sizeof(XtGeometryHandler));
	myXtGeometryHandler = constraintClassRec.composite_class.geometry_manager;
	pmyXtGeometryHandler = &constraintClassRec.composite_class.geometry_manager;

	check_size("constraintClassRec.composite_class.change_managed", "XtWidgetProc", sizeof(constraintClassRec.composite_class.change_managed), sizeof(XtWidgetProc));
	myXtWidgetProc = constraintClassRec.composite_class.change_managed;
	pmyXtWidgetProc = &constraintClassRec.composite_class.change_managed;

	check_size("constraintClassRec.composite_class.insert_child", "XtWidgetProc", sizeof(constraintClassRec.composite_class.insert_child), sizeof(XtWidgetProc));
	myXtWidgetProc = constraintClassRec.composite_class.insert_child;
	pmyXtWidgetProc = &constraintClassRec.composite_class.insert_child;

	check_size("constraintClassRec.composite_class.delete_child", "XtWidgetProc", sizeof(constraintClassRec.composite_class.delete_child), sizeof(XtWidgetProc));
	myXtWidgetProc = constraintClassRec.composite_class.delete_child;
	pmyXtWidgetProc = &constraintClassRec.composite_class.delete_child;

	check_size("constraintClassRec.composite_class.extension", "XtPointer", sizeof(constraintClassRec.composite_class.extension), sizeof(XtPointer));
	myXtPointer = constraintClassRec.composite_class.extension;
	pmyXtPointer = &constraintClassRec.composite_class.extension;

	check_size("constraintClassRec.constraint_class.resources", "XtResourceList", sizeof(constraintClassRec.constraint_class.resources), sizeof(XtResourceList));
	myXtResourceList = constraintClassRec.constraint_class.resources;
	pmyXtResourceList = &constraintClassRec.constraint_class.resources;

	check_size("constraintClassRec.constraint_class.num_resources", "Cardinal", sizeof(constraintClassRec.constraint_class.num_resources), sizeof(Cardinal));
	myCardinal = constraintClassRec.constraint_class.num_resources;
	pmyCardinal = &constraintClassRec.constraint_class.num_resources;

	check_size("constraintClassRec.constraint_class.constraint_size", "Cardinal", sizeof(constraintClassRec.constraint_class.constraint_size), sizeof(Cardinal));
	myCardinal = constraintClassRec.constraint_class.constraint_size;
	pmyCardinal = &constraintClassRec.constraint_class.constraint_size;

	check_size("constraintClassRec.constraint_class.initialize", "XtInitProc", sizeof(constraintClassRec.constraint_class.initialize), sizeof(XtInitProc));
	myXtInitProc = constraintClassRec.constraint_class.initialize;
	pmyXtInitProc = &constraintClassRec.constraint_class.initialize;

	check_size("constraintClassRec.constraint_class.destroy", "XtWidgetProc", sizeof(constraintClassRec.constraint_class.destroy), sizeof(XtWidgetProc));
	myXtWidgetProc = constraintClassRec.constraint_class.destroy;
	pmyXtWidgetProc = &constraintClassRec.constraint_class.destroy;

	check_size("constraintClassRec.constraint_class.set_values", "XtSetValuesFunc", sizeof(constraintClassRec.constraint_class.set_values), sizeof(XtSetValuesFunc));
	myXtSetValuesFunc = constraintClassRec.constraint_class.set_values;
	pmyXtSetValuesFunc = &constraintClassRec.constraint_class.set_values;

	check_size("constraintClassRec.constraint_class.extension", "XtPointer", sizeof(constraintClassRec.constraint_class.extension), sizeof(XtPointer));
	myXtPointer = constraintClassRec.constraint_class.extension;
	pmyXtPointer = &constraintClassRec.constraint_class.extension;
	tet_result(TET_PASS);
>>ASSERTION Good A
The class pointer for constraint widgets constraintWidgetClass shall exist
and point to the constraint class record.
>>CODE

	tet_infoline("TEST: constraintWidgetClass");
	if (constraintWidgetClass != (WidgetClass)&constraintClassRec) {
		sprintf(ebuf, "ERROR: constraintWidgetClass does not point to ConstraintClassRec");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
>>ASSERTION Good A
The type ConstraintWidgetClass shall be defined as a pointer to a
constraint widget class structure.
>>CODE
	ConstraintWidgetClass testvar;
	XtPointer testvar2;

	/* this will not build if the define is not correct*/
	tet_infoline("TEST: ConstraintWidgetClass");
	testvar = &constraintClassRec;
	testvar2 = testvar->core_class.superclass;
	tet_result(TET_PASS);
>>ASSERTION Good A
The instance structure for constraint widgets ConstraintPart shall be
defined and contain the fields listed in section 3.4.3 of the Specification.
>>CODE
	ConstraintPart testStruct;

	tet_infoline("TEST: mumble");
	if (sizeof(testStruct.mumble) != sizeof(XtPointer)) {
		sprintf(ebuf, "ERROR: Size of ConstraintPart.mumble was %d, expected %d", sizeof(testStruct.mumble), sizeof(XtPointer));
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
>>ASSERTION Good A
The instance record structure for constraint widgets ConstraintRec shall
be defined and contain the fields listed in section 3.4.3 of the Specification.
>>CODE
	ConstraintRec testStruct;

	check_size("ConstraintRec.core.self", "Widget", sizeof(testStruct.core.self), sizeof(Widget));
	myWidget = testStruct.core.self;
	pmyWidget = &testStruct.core.self;

	check_size("ConstraintRec.core.widget_class", "WidgetClass", sizeof(testStruct.core.widget_class), sizeof(WidgetClass));
	myWidgetClass = testStruct.core.widget_class;
	pmyWidgetClass = &testStruct.core.widget_class;

	check_size("ConstraintRec.core.parent", "Widget", sizeof(testStruct.core.parent), sizeof(Widget));
	myWidget = testStruct.core.parent;
	pmyWidget = &testStruct.core.parent;

	check_size("ConstraintRec.core.xrm_name", "XrmName", sizeof(testStruct.core.xrm_name), sizeof(XrmName));
	myXrmName = testStruct.core.xrm_name;
	pmyXrmName = &testStruct.core.xrm_name;

	check_size("ConstraintRec.core.being_destroyed", "Boolean", sizeof(testStruct.core.being_destroyed), sizeof(Boolean));
	myBoolean = testStruct.core.being_destroyed;
	pmyBoolean = &testStruct.core.being_destroyed;

	check_size("ConstraintRec.core.destroy_callbacks", "XtCallbackList", sizeof(testStruct.core.destroy_callbacks), sizeof(XtCallbackList));
	myXtCallbackList = testStruct.core.destroy_callbacks;
	pmyXtCallbackList = &testStruct.core.destroy_callbacks;

	check_size("ConstraintRec.core.constraints", "XtPointer", sizeof(testStruct.core.constraints), sizeof(XtPointer));
	myXtPointer = testStruct.core.constraints;
	pmyXtPointer = &testStruct.core.constraints;

	check_size("ConstraintRec.core.border_width", "Dimension", sizeof(testStruct.core.border_width), sizeof(Dimension));
	myDimension = testStruct.core.border_width;
	pmyDimension = &testStruct.core.border_width;

	check_size("ConstraintRec.core.managed", "Boolean", sizeof(testStruct.core.managed), sizeof(Boolean));
	myBoolean = testStruct.core.managed;
	pmyBoolean = &testStruct.core.managed;

	check_size("ConstraintRec.core.sensitive", "Boolean", sizeof(testStruct.core.sensitive), sizeof(Boolean));
	myBoolean = testStruct.core.sensitive;
	pmyBoolean = &testStruct.core.sensitive;

	check_size("ConstraintRec.core.ancestor_sensitive", "Boolean", sizeof(testStruct.core.ancestor_sensitive), sizeof(Boolean));
	myBoolean = testStruct.core.ancestor_sensitive;
	pmyBoolean = &testStruct.core.ancestor_sensitive;

	check_size("ConstraintRec.core.event_table", "XtEventTable", sizeof(testStruct.core.event_table), sizeof(XtEventTable));
	myXtEventTable = testStruct.core.event_table;
	pmyXtEventTable = &testStruct.core.event_table;

	check_size("ConstraintRec.core.tm", "XtTMRec", sizeof(testStruct.core.tm), sizeof(XtTMRec));
	myXtTMRec = testStruct.core.tm;
	pmyXtTMRec = &testStruct.core.tm;

	check_size("ConstraintRec.core.accelerators", "XtTranslations", sizeof(testStruct.core.accelerators), sizeof(XtTranslations));
	myXtTranslations = testStruct.core.accelerators;
	pmyXtTranslations = &testStruct.core.accelerators;

	check_size("ConstraintRec.core.border_pixel", "Pixel", sizeof(testStruct.core.border_pixel), sizeof(Pixel));
	myPixel = testStruct.core.border_pixel;
	pmyPixel = &testStruct.core.border_pixel;

	check_size("ConstraintRec.core.border_pixmap", "Pixmap", sizeof(testStruct.core.border_pixmap), sizeof(Pixmap));
	myPixmap = testStruct.core.border_pixmap;
	pmyPixmap = &testStruct.core.border_pixmap;

	check_size("ConstraintRec.core.popup_list", "WidgetList", sizeof(testStruct.core.popup_list), sizeof(WidgetList));
	myWidgetList = testStruct.core.popup_list;
	pmyWidgetList = &testStruct.core.popup_list;

	check_size("ConstraintRec.core.num_popups", "Cardinal", sizeof(testStruct.core.num_popups), sizeof(Cardinal));
	myCardinal = testStruct.core.num_popups;
	pmyCardinal = &testStruct.core.num_popups;

	check_size("ConstraintRec.core.name", "String", sizeof(testStruct.core.name), sizeof(String));
	myString = testStruct.core.name;
	pmyString = &testStruct.core.name;

	check_size("ConstraintRec.core.screen", "Screen *", sizeof(testStruct.core.screen), sizeof(Screen *));
	pmyScreen = testStruct.core.screen;

	check_size("ConstraintRec.core.colormap", "Colormap", sizeof(testStruct.core.colormap), sizeof(Colormap));
	myColormap = testStruct.core.colormap;
	pmyColormap = &testStruct.core.colormap;

	check_size("ConstraintRec.core.window", "Window", sizeof(testStruct.core.window), sizeof(Window));
	myWindow = testStruct.core.window;
	pmyWindow = &testStruct.core.window;

	check_size("ConstraintRec.core.depth", "Cardinal", sizeof(testStruct.core.depth), sizeof(Cardinal));
	myCardinal = testStruct.core.depth;
	pmyCardinal = &testStruct.core.depth;

	check_size("ConstraintRec.core.background_pixel", "Pixel", sizeof(testStruct.core.background_pixel), sizeof(Pixel));
	myPixel = testStruct.core.background_pixel;
	pmyPixel = &testStruct.core.background_pixel;

	check_size("ConstraintRec.core.background_pixmap", "Pixmap", sizeof(testStruct.core.background_pixmap), sizeof(Pixmap));
	myPixmap = testStruct.core.background_pixmap;
	pmyPixmap = &testStruct.core.background_pixmap;

	check_size("ConstraintRec.core.visible", "Boolean", sizeof(testStruct.core.visible), sizeof(Boolean));
	myBoolean = testStruct.core.visible;
	pmyBoolean = &testStruct.core.visible;

	check_size("ConstraintRec.core.mapped_when_managed", "Boolean", sizeof(testStruct.core.mapped_when_managed), sizeof(Boolean));
	myBoolean = testStruct.core.mapped_when_managed;
	pmyBoolean = &testStruct.core.mapped_when_managed;

	check_size("ConstraintRec.composite.children", "WidgetList", sizeof(testStruct.composite.children), sizeof(WidgetList));
	myWidgetList = testStruct.composite.children;
	pmyWidgetList = &testStruct.composite.children;

	check_size("ConstraintRec.composite.num_children", "Cardinal", sizeof(testStruct.composite.num_children), sizeof(Cardinal));
	myCardinal = testStruct.composite.num_children;
	pmyCardinal = &testStruct.composite.num_children;

	check_size("ConstraintRec.composite.num_slots", "Cardinal", sizeof(testStruct.composite.num_slots), sizeof(Cardinal));
	myCardinal = testStruct.composite.num_slots;
	pmyCardinal = &testStruct.composite.num_slots;

	check_size("ConstraintRec.composite.insert_position", "XtOrderProc", sizeof(testStruct.composite.insert_position), sizeof(XtOrderProc));
	myXtOrderProc = testStruct.composite.insert_position;
	pmyXtOrderProc = &testStruct.composite.insert_position;

	check_size("ConstraintRec.constraint.mumble", "XtPointer", sizeof(testStruct.constraint.mumble), sizeof(XtPointer));
	myXtPointer = testStruct.constraint.mumble;
	pmyXtPointer = &testStruct.constraint.mumble;

	tet_result(TET_PASS);
>>ASSERTION Good A
The type ConstraintWidget shall be defined as a pointer to a constraint
widget instance.
>>CODE
	ConstraintWidget testvar;
	ConstraintRec	testwid;
	XtPointer testvar2;

	/* this will not build if the define is not correct*/
	tet_infoline("TEST: ConstraintWidget");
	/*doesn't matter where we point, just testing syntax*/
	testvar = &testwid;
	testvar2 = testvar->constraint.mumble;
	tet_result(TET_PASS);
>>ASSERTION Good A
Constraint widgets shall be a subclass of composite widgets.
>>CODE
Widget testwidget;

	avs_xt_hier("Hconst10", "XtConstraint");
	tet_infoline("PREP: Create fresh widget");
	testwidget = XtCreateWidget("ApTest", constraintWidgetClass, topLevel, NULL, 0);
	tet_infoline("TEST: constraint superclass is composite");
	if (constraintClassRec.core_class.superclass != compositeWidgetClass) {
		tet_infoline("ERROR: superclass is not composite");
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
>>ASSERTION Good A
ConstraintRec shall be initialized to the default values specified
in sections 3.4.1 and 3.4.2 of the Specification on creation of a
new composite widget instance.
>>CODE
/* Conversion arguments and results */
ConstraintWidget testwidget;
Boolean status;
Display *display;
XrmValue args[2];
Cardinal num_args;
XrmValue fromVal;
XrmValue toVal;
Boolean closure;
XtPointer *closure_ret = (XtPointer *) &closure;
/* String to Pixel specific */
Screen *screen;
Colormap colormap;
char  *pixstr = "XtDefaultForeground";
char  *pixstr2 = "XtDefaultBackground";
Pixel res;

	avs_xt_hier("Hconst11", "XtConstraint");
	tet_infoline("PREP: Create fresh widget");
	testwidget = (ConstraintWidget)XtCreateWidget("ApTest", constraintWidgetClass, topLevel, NULL, 0);
	tet_infoline("TEST: core.self");
	if (testwidget->core.self != (Widget)testwidget) {
		tet_infoline("ERROR: self member is not address of widget structure");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: core.widget_class");
	if (testwidget->core.widget_class != constraintWidgetClass) {
		tet_infoline("ERROR: widget_class member is not constraintWidgetClass");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: core.parent");
	if (testwidget->core.parent != topLevel) {
		tet_infoline("ERROR: parent member is not address of parent widget structure");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: core.being_destroyed");
	if (testwidget->core.being_destroyed != topLevel->core.being_destroyed) {
		sprintf(ebuf, "ERROR: Expected being_destroyed of %#x, is %#x", topLevel->core.being_destroyed, testwidget->core.being_destroyed);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: core.destroy_callbacks");
	if (testwidget->core.destroy_callbacks != NULL) {
		tet_infoline("ERROR: destroy_callbacks member is not NULL");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: core.constraints");
	if (testwidget->core.constraints != NULL) {
		tet_infoline("ERROR: constraints member is not NULL");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: core.x");
	if (testwidget->core.x != 0) {
		sprintf(ebuf, "ERROR: x member is %d, expected 0", testwidget->core.x);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: core.y");
	if (testwidget->core.y != 0) {
		sprintf(ebuf, "ERROR: y member is %d, expected 0", testwidget->core.y);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: core.width");
	if (testwidget->core.width != 0) {
		sprintf(ebuf, "ERROR: width member is %d, expected 0", testwidget->core.width);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: core.height");
	if (testwidget->core.height != 0) {
		sprintf(ebuf, "ERROR: height member is %d, expected 0", testwidget->core.height);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: core.border_width");
	if (testwidget->core.border_width != 1) {
		sprintf(ebuf, "ERROR: border_width member is %d, expected 1", testwidget->core.border_width);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: core.managed");
	if (testwidget->core.managed != False) {
		sprintf(ebuf, "ERROR: managed member is %d,  expected False", testwidget->core.managed);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: core.sensitive");
	if (testwidget->core.sensitive != True) {
		sprintf(ebuf, "ERROR: sensitive member is %d, expected True", testwidget->core.sensitive);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: core.ancestor_sensitive");
	if (testwidget->core.ancestor_sensitive != (topLevel->core.sensitive & topLevel->core.ancestor_sensitive)) {
		sprintf(ebuf, "ERROR: Expected ancestor_sensitive of %#x, is %#x", (topLevel->core.sensitive & topLevel->core.ancestor_sensitive), testwidget->core.ancestor_sensitive);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: core.accelerators");
	if (testwidget->core.accelerators != NULL) {
		tet_infoline("ERROR: accelerators member is not NULL");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: core.border_pixel");
	fromVal.addr = pixstr;
	fromVal.size = strlen(pixstr)+1;
	toVal.addr = (XtPointer) &res;
	toVal.size = sizeof(Pixel);
	status = XtConvertAndStore((Widget)testwidget, XtRString, &fromVal, XtRPixel, &toVal); 
	if (testwidget->core.border_pixel != res) {
		tet_infoline("ERROR: border_pixel member is not XtDefaultForeground");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: core.border_pixmap");
	if (testwidget->core.border_pixmap != XtUnspecifiedPixmap) {
		sprintf(ebuf, "ERROR: border_pixmap member is %d, expected XtUnspecifiedPixmap", testwidget->core.border_pixmap);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: core.popup_list");
	if (testwidget->core.popup_list != NULL) {
		tet_infoline("ERROR: popup_list member is not NULL");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: core.num_popups");
	if (testwidget->core.num_popups != 0) {
		sprintf(ebuf, "ERROR: num_popups member is %d, expected 0", testwidget->core.num_popups);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: core.screen");
	if (testwidget->core.screen != topLevel->core.screen) {
		sprintf(ebuf, "ERROR: Expected screen of %#x, is %#x", topLevel->core.screen, testwidget->core.screen);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: core.name");
	if (strcmp(testwidget->core.name, "ApTest") != 0) {
		sprintf(ebuf, "ERROR: Expected name of %s, is %s", "ApTest", testwidget->core.name);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: core.colormap");
	if (testwidget->core.colormap != topLevel->core.colormap) {
		sprintf(ebuf, "ERROR: Expected colormap of %#x, is %#x", topLevel->core.colormap, testwidget->core.colormap);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: core.window");
	if (testwidget->core.window != NULL) {
		tet_infoline("ERROR: window member is not NULL");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: core.depth");
	if (testwidget->core.depth != topLevel->core.depth) {
		sprintf(ebuf, "ERROR: Expected depth of %#x, is %#x", topLevel->core.depth, testwidget->core.depth);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: core.background_pixel");
	fromVal.addr = pixstr2;
	fromVal.size = strlen(pixstr2)+1;
	toVal.addr = (XtPointer) &res;
	toVal.size = sizeof(Pixel);
	status = XtConvertAndStore((Widget)testwidget, XtRString, &fromVal, XtRPixel, &toVal); 
	if (testwidget->core.background_pixel != res) {
		tet_infoline("ERROR: background_pixel member is not XtDefaultBackground");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: core.background_pixmap");
	if (testwidget->core.background_pixmap != XtUnspecifiedPixmap) {
		tet_infoline("ERROR: background_pixmap member is not XtUnspecifiedPixmap");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: core.visible");
	if (testwidget->core.visible != True) {
		sprintf(ebuf, "ERROR: visible member is %d, expected True", testwidget->core.visible);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: core.mapped_when_managed");
	if (testwidget->core.mapped_when_managed != True) {
		sprintf(ebuf, "ERROR: mapped_when_managed member is %d, expected True", testwidget->core.mapped_when_managed);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: composite.children");
	if (testwidget->composite.children != NULL) {
		tet_infoline("ERROR: children member is not NULL");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: composite.num_children");
	if (testwidget->composite.num_children != 0) {
		sprintf(ebuf, "ERROR: num_children member is %d, expected 0", testwidget->composite.num_children);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: composite.num_slots");
	if (testwidget->composite.num_slots != 0) {
		sprintf(ebuf, "ERROR: num_slots member is %d, expected 0", testwidget->composite.num_slots);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
