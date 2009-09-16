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
>># File: xts/Xt3/CompositeWidget/CompositeWidget.m
>>#
>># Description:
>>#	 Tests for Composite widget data structures
>>#
>># Modifications:
>># $Log: wdgtcmpst.m,v $
>># Revision 1.1  2005-02-12 14:38:00  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:36:02  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:58:49  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:27:15  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:23:48  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:14:59  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:18:27  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/CompositeP.h>
XtAppContext app_ctext ;
Widget topLevel, panedw, boxw1, boxw2 ;
Widget labelw, rowcolw, click_quit ;
Widget testwidget;
CompositeWidget testwidget2;
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

>>TITLE CompositeWidget Xt3
>>ASSERTION Good A
The class structure for composite widgets CompositeClassPart
shall be defined and contain the fields listed in
section 3.4.2 of the Specification.
>>CODE
CompositeClassPart testStruct;

	check_size("CompositeClassPart.geometry_manager", "XtGeometryHandler", sizeof(testStruct.geometry_manager), sizeof(XtGeometryHandler));
	myXtGeometryHandler = testStruct.geometry_manager;
	pmyXtGeometryHandler = &testStruct.geometry_manager;
	
	check_size("CompositeClassPart.change_managed", "XtWidgetProc", sizeof(testStruct.change_managed), sizeof(XtWidgetProc));
	myXtWidgetProc = testStruct.change_managed;
	pmyXtWidgetProc = &testStruct.change_managed;

	check_size("CompositeClassPart.insert_child", "XtWidgetProc", sizeof(testStruct.insert_child), sizeof(XtWidgetProc));
	myXtWidgetProc = testStruct.insert_child;
	pmyXtWidgetProc = &testStruct.insert_child;

	check_size("CompositeClassPart.delete_child", "XtWidgetProc", sizeof(testStruct.delete_child), sizeof(XtWidgetProc));
	myXtWidgetProc = testStruct.delete_child;
	pmyXtWidgetProc = &testStruct.delete_child;

	check_size("CompositeClassPart.extension", "XtPointer", sizeof(testStruct.extension), sizeof(XtPointer));
	myXtPointer = testStruct.extension;
	pmyXtPointer = &testStruct.extension;

	tet_result(TET_PASS);
>>ASSERTION Good A
The extension structure for composite widgets CompositeClassExtensionRec
shall be defined and contain the fields listed in
section 3.4.2 of the Specification.
>>CODE
CompositeClassExtensionRec testStruct;

	check_size("CompositeClassExtensionRec.next_extension", "XtPointer", sizeof(testStruct.next_extension), sizeof(XtPointer));
	myXtPointer = testStruct.next_extension;
	pmyXtPointer = &testStruct.next_extension;

	check_size("CompositeClassExtensionRec.record_type", "XrmQuark", sizeof(testStruct.record_type), sizeof(XrmQuark));
	myXrmQuark = testStruct.record_type;
	pmyXrmQuark = &testStruct.record_type;

	check_size("CompositeClassExtensionRec.version", "long", sizeof(testStruct.version), sizeof(long));
	mylong = testStruct.version;
	pmylong = &testStruct.version;

	check_size("CompositeClassExtensionRec.record_size", "Cardinal", sizeof(testStruct.record_size), sizeof(Cardinal));
	myCardinal = testStruct.record_size;
	pmyCardinal = &testStruct.record_size;

	check_size("CompositeClassExtensionRec.accepts_objects", "Boolean", sizeof(testStruct.accepts_objects), sizeof(Boolean));
	myBoolean = testStruct.accepts_objects;
	pmyBoolean = &testStruct.accepts_objects;

	tet_result(TET_PASS);
>>ASSERTION Good A
The class record structure for composite widgets CompositeRec
shall be defined and contain the fields listed in
section 3.4.2 of the Specification.
>>CODE
CompositeClassRec testStruct;

	check_size("CompositeClassRec.core_class.superclass", "WidgetClass", sizeof(testStruct.core_class.superclass), sizeof(WidgetClass));
	myWidgetClass = testStruct.core_class.superclass;
	pmyWidgetClass = &testStruct.core_class.superclass;

	check_size("CompositeClassRec.core_class.class_name", "String", sizeof(testStruct.core_class.class_name), sizeof(String));
	myString = testStruct.core_class.class_name;
	pmyString = &testStruct.core_class.class_name;

	check_size("CompositeClassRec.core_class.widget_size", "Cardinal", sizeof(testStruct.core_class.widget_size), sizeof(Cardinal));
	myCardinal = testStruct.core_class.widget_size;
	pmyCardinal = &testStruct.core_class.widget_size;

	check_size("CompositeClassRec.core_class.class_initialize", "XtProc", sizeof(testStruct.core_class.class_initialize), sizeof(XtProc));
	myXtProc = testStruct.core_class.class_initialize;
	pmyXtProc = &testStruct.core_class.class_initialize;

	check_size("CompositeClassRec.core_class.class_part_initialize", "XtWidgetClassProc", sizeof(testStruct.core_class.class_part_initialize), sizeof(XtWidgetClassProc));
	myXtWidgetClassProc = testStruct.core_class.class_part_initialize;
	pmyXtWidgetClassProc = &testStruct.core_class.class_part_initialize;

	check_size("CompositeClassRec.core_class.class_inited", "XtEnum", sizeof(testStruct.core_class.class_inited), sizeof(XtEnum));
	myXtEnum = testStruct.core_class.class_inited;
	pmyXtEnum = &testStruct.core_class.class_inited;

	check_size("CompositeClassRec.core_class.initialize", "XtInitProc", sizeof(testStruct.core_class.initialize), sizeof(XtInitProc));
	myXtInitProc = testStruct.core_class.initialize;
	pmyXtInitProc = &testStruct.core_class.initialize;

	check_size("CompositeClassRec.core_class.initialize_hook", "XtArgsProc", sizeof(testStruct.core_class.initialize_hook), sizeof(XtArgsProc));
	myXtArgsProc = testStruct.core_class.initialize_hook;
	pmyXtArgsProc = &testStruct.core_class.initialize_hook;

	check_size("CompositeClassRec.core_class.realize", "XtRealizeProc", sizeof(testStruct.core_class.realize), sizeof(XtRealizeProc));
	myXtRealizeProc = testStruct.core_class.realize;
	pmyXtRealizeProc = &testStruct.core_class.realize;

	check_size("CompositeClassRec.core_class.actions", "XtActionList", sizeof(testStruct.core_class.actions), sizeof(XtActionList));
	myXtActionList = testStruct.core_class.actions;
	pmyXtActionList = &testStruct.core_class.actions;

	check_size("CompositeClassRec.core_class.num_actions", "Cardinal", sizeof(testStruct.core_class.num_actions), sizeof(Cardinal));
	myCardinal = testStruct.core_class.num_actions;
	pmyCardinal = &testStruct.core_class.num_actions;

	check_size("CompositeClassRec.core_class.resources", "XtResourceList", sizeof(testStruct.core_class.resources), sizeof(XtResourceList));
	myXtResourceList = testStruct.core_class.resources;
	pmyXtResourceList = &testStruct.core_class.resources;

	check_size("CompositeClassRec.core_class.num_resources", "Cardinal", sizeof(testStruct.core_class.num_resources), sizeof(Cardinal));
	myCardinal = testStruct.core_class.num_resources;
	pmyCardinal = &testStruct.core_class.num_resources;

	check_size("CompositeClassRec.core_class.xrm_class", "XrmClass", sizeof(testStruct.core_class.xrm_class), sizeof(XrmClass));
	myXrmClass = testStruct.core_class.xrm_class;
	pmyXrmClass = &testStruct.core_class.xrm_class;

	check_size("CompositeClassRec.core_class.compress_motion", "Boolean", sizeof(testStruct.core_class.compress_motion), sizeof(Boolean));
	myBoolean = testStruct.core_class.compress_motion;
	pmyBoolean = &testStruct.core_class.compress_motion;

	check_size("CompositeClassRec.core_class.compress_exposure", "XtEnum", sizeof(testStruct.core_class.compress_exposure), sizeof(XtEnum));
	myXtEnum = testStruct.core_class.compress_exposure;
	pmyXtEnum = &testStruct.core_class.compress_exposure;

	check_size("CompositeClassRec.core_class.compress_enterleave", "Boolean", sizeof(testStruct.core_class.compress_enterleave), sizeof(Boolean));
	myBoolean = testStruct.core_class.compress_enterleave;
	pmyBoolean = &testStruct.core_class.compress_enterleave;

	check_size("CompositeClassRec.core_class.visible_interest", "Boolean", sizeof(testStruct.core_class.visible_interest), sizeof(Boolean));
	myBoolean = testStruct.core_class.visible_interest;
	pmyBoolean = &testStruct.core_class.visible_interest;

	check_size("CompositeClassRec.core_class.destroy", "XtWidgetProc", sizeof(testStruct.core_class.destroy), sizeof(XtWidgetProc));
	myXtWidgetProc = testStruct.core_class.destroy;
	pmyXtWidgetProc = &testStruct.core_class.destroy;

	check_size("CompositeClassRec.core_class.resize", "XtWidgetProc", sizeof(testStruct.core_class.resize), sizeof(XtWidgetProc));
	myXtWidgetProc = testStruct.core_class.resize;
	pmyXtWidgetProc = &testStruct.core_class.resize;

	check_size("CompositeClassRec.core_class.expose", "XtExposeProc", sizeof(testStruct.core_class.expose), sizeof(XtExposeProc));
	myXtExposeProc = testStruct.core_class.expose;
	pmyXtExposeProc = &testStruct.core_class.expose;

	check_size("CompositeClassRec.core_class.set_values", "XtSetValuesFunc", sizeof(testStruct.core_class.set_values), sizeof(XtSetValuesFunc));
	myXtSetValuesFunc = testStruct.core_class.set_values;
	pmyXtSetValuesFunc = &testStruct.core_class.set_values;

	check_size("CompositeClassRec.core_class.set_values_hook", "XtArgsFunc", sizeof(testStruct.core_class.set_values_hook), sizeof(XtArgsFunc));
	myXtArgsFunc = testStruct.core_class.set_values_hook;
	pmyXtArgsFunc = &testStruct.core_class.set_values_hook;

	check_size("CompositeClassRec.core_class.set_values_almost", "XtAlmostProc", sizeof(testStruct.core_class.set_values_almost), sizeof(XtAlmostProc));
	myXtAlmostProc = testStruct.core_class.set_values_almost;
	pmyXtAlmostProc = &testStruct.core_class.set_values_almost;

	check_size("CompositeClassRec.core_class.get_values_hook", "XtArgsProc", sizeof(testStruct.core_class.get_values_hook), sizeof(XtArgsProc));
	myXtArgsProc = testStruct.core_class.get_values_hook;
	pmyXtArgsProc = &testStruct.core_class.get_values_hook;

	check_size("CompositeClassRec.core_class.accept_focus", "XtAcceptFocusProc", sizeof(testStruct.core_class.accept_focus), sizeof(XtAcceptFocusProc));
	myXtAcceptFocusProc = testStruct.core_class.accept_focus;
	pmyXtAcceptFocusProc = &testStruct.core_class.accept_focus;

	check_size("CompositeClassRec.core_class.version", "XtVersionType", sizeof(testStruct.core_class.version), sizeof(XtVersionType));
	myXtVersionType = testStruct.core_class.version;
	pmyXtVersionType = &testStruct.core_class.version;

	check_size("CompositeClassRec.core_class.callback_private", "XtPointer", sizeof(testStruct.core_class.callback_private), sizeof(XtPointer));
	myXtPointer = testStruct.core_class.callback_private;
	pmyXtPointer = &testStruct.core_class.callback_private;

	check_size("CompositeClassRec.core_class.tm_table", "String", sizeof(testStruct.core_class.tm_table), sizeof(String));
	myString = testStruct.core_class.tm_table;
	pmyString = &testStruct.core_class.tm_table;

	check_size("CompositeClassRec.core_class.query_geometry", "XtGeometryHandler", sizeof(testStruct.core_class.query_geometry), sizeof(XtGeometryHandler));
	myXtGeometryHandler = testStruct.core_class.query_geometry;
	pmyXtGeometryHandler = &testStruct.core_class.query_geometry;

	check_size("CompositeClassRec.core_class.display_accelerator", "XtStringProc", sizeof(testStruct.core_class.display_accelerator), sizeof(XtStringProc));
	myXtStringProc = testStruct.core_class.display_accelerator;
	pmyXtStringProc = &testStruct.core_class.display_accelerator;

	check_size("CompositeClassRec.core_class.extension", "XtPointer", sizeof(testStruct.core_class.extension), sizeof(XtPointer));
	myXtPointer = testStruct.core_class.extension;
	pmyXtPointer = &testStruct.core_class.extension;

	check_size("CompositeClassRec.composite_class.geometry_manager", "XtGeometryHandler", sizeof(testStruct.composite_class.geometry_manager), sizeof(XtGeometryHandler));
	myXtGeometryHandler = testStruct.composite_class.geometry_manager;
	pmyXtGeometryHandler = &testStruct.composite_class.geometry_manager;

	check_size("CompositeClassRec.composite_class.change_managed", "XtWidgetProc", sizeof(testStruct.composite_class.change_managed), sizeof(XtWidgetProc));
	myXtWidgetProc = testStruct.composite_class.change_managed;
	pmyXtWidgetProc = &testStruct.composite_class.change_managed;

	check_size("CompositeClassRec.composite_class.insert_child", "XtWidgetProc", sizeof(testStruct.composite_class.insert_child), sizeof(XtWidgetProc));
	myXtWidgetProc = testStruct.composite_class.insert_child;
	pmyXtWidgetProc = &testStruct.composite_class.insert_child;

	check_size("CompositeClassRec.composite_class.delete_child", "XtWidgetProc", sizeof(testStruct.composite_class.delete_child), sizeof(XtWidgetProc));
	myXtWidgetProc = testStruct.composite_class.delete_child;
	pmyXtWidgetProc = &testStruct.composite_class.delete_child;

	check_size("CompositeClassRec.composite_class.extension", "XtPointer", sizeof(testStruct.composite_class.extension), sizeof(XtPointer));
	myXtPointer = testStruct.composite_class.extension;
	pmyXtPointer = &testStruct.composite_class.extension;

	tet_result(TET_PASS);
>>ASSERTION Good A
The class record for composite widgets compositeClassRec
shall exist and be an instance of the CompositeRec
structure.
>>CODE

	check_size("compositeClassRec.core_class.superclass", "WidgetClass", sizeof(compositeClassRec.core_class.superclass), sizeof(WidgetClass));
	compositeClassRec.core_class.superclass = compositeClassRec.core_class.superclass;

	check_size("compositeClassRec.core_class.class_name" , "String", sizeof(compositeClassRec.core_class.class_name), sizeof(String));
	myString = compositeClassRec.core_class.class_name;
	pmyString = &compositeClassRec.core_class.class_name;

	check_size("compositeClassRec.core_class.widget_size" , "Cardinal", sizeof(compositeClassRec.core_class.widget_size), sizeof(Cardinal));
	myCardinal = compositeClassRec.core_class.widget_size;
	pmyCardinal = &compositeClassRec.core_class.widget_size;

	check_size("compositeClassRec.core_class.class_initialize" , "XtProc", sizeof(compositeClassRec.core_class.class_initialize), sizeof(XtProc));
	myXtProc = compositeClassRec.core_class.class_initialize;
	pmyXtProc = &compositeClassRec.core_class.class_initialize;

	check_size("compositeClassRec.core_class.class_part_initialize" , "XtWidgetClassProc", sizeof(compositeClassRec.core_class.class_part_initialize), sizeof(XtWidgetClassProc));
	myXtWidgetClassProc = compositeClassRec.core_class.class_part_initialize;
	pmyXtWidgetClassProc = &compositeClassRec.core_class.class_part_initialize;

	check_size("compositeClassRec.core_class.class_inited" , "XtEnum", sizeof(compositeClassRec.core_class.class_inited), sizeof(XtEnum));
	myXtEnum = compositeClassRec.core_class.class_inited;
	pmyXtEnum = &compositeClassRec.core_class.class_inited;

	check_size("compositeClassRec.core_class.initialize" , "XtInitProc", sizeof(compositeClassRec.core_class.initialize), sizeof(XtInitProc));
	myXtInitProc = compositeClassRec.core_class.initialize;
	pmyXtInitProc = &compositeClassRec.core_class.initialize;

	check_size("compositeClassRec.core_class.initialize_hook" , "XtArgsProc", sizeof(compositeClassRec.core_class.initialize_hook), sizeof(XtArgsProc));
	myXtArgsProc = compositeClassRec.core_class.initialize_hook;
	pmyXtArgsProc = &compositeClassRec.core_class.initialize_hook;

	check_size("compositeClassRec.core_class.realize" , "XtRealizeProc", sizeof(compositeClassRec.core_class.realize), sizeof(XtRealizeProc));
	myXtRealizeProc = compositeClassRec.core_class.realize;
	pmyXtRealizeProc = &compositeClassRec.core_class.realize;

	check_size("compositeClassRec.core_class.actions" , "XtActionList", sizeof(compositeClassRec.core_class.actions), sizeof(XtActionList));
	myXtActionList= compositeClassRec.core_class.actions;
	pmyXtActionList= &compositeClassRec.core_class.actions;

	check_size("compositeClassRec.core_class.num_actions" , "Cardinal", sizeof(compositeClassRec.core_class.num_actions), sizeof(Cardinal));
	myCardinal = compositeClassRec.core_class.num_actions;
	pmyCardinal = &compositeClassRec.core_class.num_actions;

	check_size("compositeClassRec.core_class.resources" , "XtResourceList", sizeof(compositeClassRec.core_class.resources), sizeof(XtResourceList));
	myXtResourceList = compositeClassRec.core_class.resources;
	pmyXtResourceList = &compositeClassRec.core_class.resources;

	check_size("compositeClassRec.core_class.num_resources" , "Cardinal", sizeof(compositeClassRec.core_class.num_resources), sizeof(Cardinal));
	myCardinal = compositeClassRec.core_class.num_resources;
	pmyCardinal = &compositeClassRec.core_class.num_resources;

	check_size("compositeClassRec.core_class.xrm_class" , "XrmClass", sizeof(compositeClassRec.core_class.xrm_class), sizeof(XrmClass));
	myXrmClass = compositeClassRec.core_class.xrm_class;
	pmyXrmClass = &compositeClassRec.core_class.xrm_class;

	check_size("compositeClassRec.core_class.compress_motion" , "Boolean", sizeof(compositeClassRec.core_class.compress_motion), sizeof(Boolean));
	myBoolean = compositeClassRec.core_class.compress_motion;
	pmyBoolean = &compositeClassRec.core_class.compress_motion;

	check_size("compositeClassRec.core_class.compress_exposure" , "XtEnum", sizeof(compositeClassRec.core_class.compress_exposure), sizeof(XtEnum));
	myXtEnum = compositeClassRec.core_class.compress_exposure;
	pmyXtEnum = &compositeClassRec.core_class.compress_exposure;

	check_size("compositeClassRec.core_class.compress_enterleave" , "Boolean", sizeof(compositeClassRec.core_class.compress_enterleave), sizeof(Boolean));
	myBoolean = compositeClassRec.core_class.compress_enterleave;
	pmyBoolean = &compositeClassRec.core_class.compress_enterleave;

	check_size("compositeClassRec.core_class.visible_interest" , "Boolean", sizeof(compositeClassRec.core_class.visible_interest), sizeof(Boolean));
	myBoolean = compositeClassRec.core_class.visible_interest;
	pmyBoolean = &compositeClassRec.core_class.visible_interest;

	check_size("compositeClassRec.core_class.destroy" , "XtWidgetProc", sizeof(compositeClassRec.core_class.destroy), sizeof(XtWidgetProc));
	myXtWidgetProc = compositeClassRec.core_class.destroy;
	pmyXtWidgetProc = &compositeClassRec.core_class.destroy;

	check_size("compositeClassRec.core_class.resize" , "XtWidgetProc", sizeof(compositeClassRec.core_class.resize), sizeof(XtWidgetProc));
	myXtWidgetProc = compositeClassRec.core_class.resize;
	pmyXtWidgetProc = &compositeClassRec.core_class.resize;

	check_size("compositeClassRec.core_class.expose" , "XtExposeProc", sizeof(compositeClassRec.core_class.expose), sizeof(XtExposeProc));
	myXtExposeProc = compositeClassRec.core_class.expose;
	pmyXtExposeProc = &compositeClassRec.core_class.expose;

	check_size("compositeClassRec.core_class.set_values" , "XtSetValuesFunc", sizeof(compositeClassRec.core_class.set_values), sizeof(XtSetValuesFunc));
	myXtSetValuesFunc = compositeClassRec.core_class.set_values;
	pmyXtSetValuesFunc = &compositeClassRec.core_class.set_values;

	check_size("compositeClassRec.core_class.set_values_hook" , "XtArgsFunc", sizeof(compositeClassRec.core_class.set_values_hook), sizeof(XtArgsFunc));
	myXtArgsFunc = compositeClassRec.core_class.set_values_hook;
	pmyXtArgsFunc = &compositeClassRec.core_class.set_values_hook;

	check_size("compositeClassRec.core_class.set_values_almost" , "XtAlmostProc", sizeof(compositeClassRec.core_class.set_values_almost), sizeof(XtAlmostProc));
	myXtAlmostProc = compositeClassRec.core_class.set_values_almost;
	pmyXtAlmostProc = &compositeClassRec.core_class.set_values_almost;

	check_size("compositeClassRec.core_class.get_values_hook" , "XtArgsProc", sizeof(compositeClassRec.core_class.get_values_hook), sizeof(XtArgsProc));
	myXtArgsProc = compositeClassRec.core_class.get_values_hook;
	pmyXtArgsProc = &compositeClassRec.core_class.get_values_hook;

	check_size("compositeClassRec.core_class.accept_focus" , "XtAcceptFocusProc", sizeof(compositeClassRec.core_class.accept_focus), sizeof(XtAcceptFocusProc));
	myXtAcceptFocusProc = compositeClassRec.core_class.accept_focus;
	pmyXtAcceptFocusProc = &compositeClassRec.core_class.accept_focus;

	check_size("compositeClassRec.core_class.version" , "XtVersionType", sizeof(compositeClassRec.core_class.version), sizeof(XtVersionType));
	myXtVersionType = compositeClassRec.core_class.version;
	pmyXtVersionType = &compositeClassRec.core_class.version;

	check_size("compositeClassRec.core_class.callback_private" , "XtPointer", sizeof(compositeClassRec.core_class.callback_private), sizeof(XtPointer));
	myXtPointer = compositeClassRec.core_class.callback_private;
	pmyXtPointer = &compositeClassRec.core_class.callback_private;

	check_size("compositeClassRec.core_class.tm_table" , "String", sizeof(compositeClassRec.core_class.tm_table), sizeof(String));
	compositeClassRec.core_class.tm_table;

	check_size("compositeClassRec.core_class.query_geometry" , "XtGeometryHandler", sizeof(compositeClassRec.core_class.query_geometry), sizeof(XtGeometryHandler));
	myXtGeometryHandler = compositeClassRec.core_class.query_geometry;
	pmyXtGeometryHandler = &compositeClassRec.core_class.query_geometry;

	check_size("compositeClassRec.core_class.display_accelerator" , "XtStringProc", sizeof(compositeClassRec.core_class.display_accelerator), sizeof(XtStringProc));
	myXtStringProc = compositeClassRec.core_class.display_accelerator;
	pmyXtStringProc = &compositeClassRec.core_class.display_accelerator;

	check_size("compositeClassRec.core_class.extension" , "XtPointer", sizeof(compositeClassRec.core_class.extension), sizeof(XtPointer));
	myXtPointer = compositeClassRec.core_class.extension;
	pmyXtPointer = &compositeClassRec.core_class.extension;

	check_size("compositeClassRec.composite_class.geometry_manager" , "XtGeometryHandler", sizeof(compositeClassRec.composite_class.geometry_manager), sizeof(XtGeometryHandler));
	myXtGeometryHandler = compositeClassRec.composite_class.geometry_manager;
	pmyXtGeometryHandler = &compositeClassRec.composite_class.geometry_manager;

	check_size("compositeClassRec.composite_class.change_managed" , "XtWidgetProc", sizeof(compositeClassRec.composite_class.change_managed), sizeof(XtWidgetProc));
	myXtWidgetProc = compositeClassRec.composite_class.change_managed;
	pmyXtWidgetProc = &compositeClassRec.composite_class.change_managed;

	check_size("compositeClassRec.composite_class.insert_child" , "XtWidgetProc", sizeof(compositeClassRec.composite_class.insert_child), sizeof(XtWidgetProc));
	myXtWidgetProc = compositeClassRec.composite_class.insert_child;
	pmyXtWidgetProc = &compositeClassRec.composite_class.insert_child;

	check_size("compositeClassRec.composite_class.delete_child" , "XtWidgetProc", sizeof(compositeClassRec.composite_class.delete_child), sizeof(XtWidgetProc));
	myXtWidgetProc = compositeClassRec.composite_class.delete_child;
	pmyXtWidgetProc = &compositeClassRec.composite_class.delete_child;

	check_size("compositeClassRec.composite_class.extension" , "XtPointer", sizeof(compositeClassRec.composite_class.extension), sizeof(XtPointer));
	myXtPointer = compositeClassRec.composite_class.extension;
	pmyXtPointer = &compositeClassRec.composite_class.extension;
	tet_result(TET_PASS);
>>ASSERTION Good A
The class pointer for composite widgets compositeWidgetClass
shall exist and point to the composite class record.
>>CODE

	tet_infoline("TEST: compositeClass");
	if (compositeWidgetClass != (WidgetClass)&compositeClassRec) {
		sprintf(ebuf, "ERROR: compositeWidgetClass does not point to compositeClassRec");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
>>ASSERTION Good A
The type CompositeWidgetClass shall be defined as a pointer
to a composite widget class structure.
>>CODE
CompositeWidgetClass testvar;
XtPointer testvar2;

	/* this will not build if the define is not correct*/
	tet_infoline("TEST: CompositeWidgetClass");
	testvar = &compositeClassRec;
	testvar2 = testvar->core_class.superclass;
	tet_result(TET_PASS);
>>ASSERTION Good A
The instance structure for composite widgets CompositePart
shall be defined and contain the fields listed in
section 3.4.2 of the Specification.
>>CODE
CompositePart testStruct;

	check_size("CompositePart.children", "WidgetList", sizeof(testStruct.children), sizeof(WidgetList));
	myWidgetList = testStruct.children;
	pmyWidgetList = &testStruct.children;

	check_size("CompositePart.num_children", "Cardinal", sizeof(testStruct.num_children), sizeof(Cardinal));
	myCardinal = testStruct.num_children;
	pmyCardinal = &testStruct.num_children;

	check_size("CompositePart.num_slots", "Cardinal", sizeof(testStruct.num_slots), sizeof(Cardinal));
	myCardinal = testStruct.num_slots;
	pmyCardinal = &testStruct.num_slots;

	check_size("CompositePart.insert_position", "XtOrderProc", sizeof(testStruct.insert_position), sizeof(XtOrderProc));
	myXtOrderProc = testStruct.insert_position;
	pmyXtOrderProc = &testStruct.insert_position;

	tet_result(TET_PASS);
>>ASSERTION Good A
The instance record structure for composite widgets CompositeRec
shall be defined and contain the fields listed in
section 3.4.2 of the Specification.
>>CODE
CompositeRec testStruct;

	check_size("CompositeRec.core.self", "Widget", sizeof(testStruct.core.self), sizeof(Widget));
	myWidget = testStruct.core.self;
	pmyWidget = &testStruct.core.self;

	check_size("CompositeRec.core.widget_class", "WidgetClass", sizeof(testStruct.core.widget_class), sizeof(WidgetClass));
	myWidgetClass = testStruct.core.widget_class;
	pmyWidgetClass = &testStruct.core.widget_class;

	check_size("CompositeRec.core.parent", "Widget", sizeof(testStruct.core.parent), sizeof(Widget));
	myWidget = testStruct.core.parent;
	pmyWidget = &testStruct.core.parent;

	check_size("CompositeRec.core.xrm_name", "XrmName", sizeof(testStruct.core.xrm_name), sizeof(XrmName));
	myXrmName = testStruct.core.xrm_name;
	pmyXrmName = &testStruct.core.xrm_name;

	check_size("CompositeRec.core.being_destroyed", "Boolean", sizeof(testStruct.core.being_destroyed), sizeof(Boolean));
	myBoolean = testStruct.core.being_destroyed;
	pmyBoolean = &testStruct.core.being_destroyed;

	check_size("CompositeRec.core.destroy_callbacks", "XtCallbackList", sizeof(testStruct.core.destroy_callbacks), sizeof(XtCallbackList));
	myXtCallbackList = testStruct.core.destroy_callbacks;
	pmyXtCallbackList = &testStruct.core.destroy_callbacks;

	check_size("CompositeRec.core.constraints", "XtPointer", sizeof(testStruct.core.constraints), sizeof(XtPointer));
	myXtPointer = testStruct.core.constraints;
	pmyXtPointer = &testStruct.core.constraints;

	check_size("CompositeRec.core.border_width", "Dimension", sizeof(testStruct.core.border_width), sizeof(Dimension));
	myDimension = testStruct.core.border_width;
	pmyDimension = &testStruct.core.border_width;

	check_size("CompositeRec.core.managed", "Boolean", sizeof(testStruct.core.managed), sizeof(Boolean));
	myBoolean = testStruct.core.managed;
	pmyBoolean = &testStruct.core.managed;

	check_size("CompositeRec.core.sensitive", "Boolean", sizeof(testStruct.core.sensitive), sizeof(Boolean));
	myBoolean = testStruct.core.sensitive;
	pmyBoolean = &testStruct.core.sensitive;

	check_size("CompositeRec.core.ancestor_sensitive", "Boolean", sizeof(testStruct.core.ancestor_sensitive), sizeof(Boolean));
	myBoolean = testStruct.core.ancestor_sensitive;
	pmyBoolean = &testStruct.core.ancestor_sensitive;

	check_size("CompositeRec.core.event_table", "XtEventTable", sizeof(testStruct.core.event_table), sizeof(XtEventTable));
	myXtEventTable = testStruct.core.event_table;
	pmyXtEventTable = &testStruct.core.event_table;

	check_size("CompositeRec.core.tm", "XtTMRec", sizeof(testStruct.core.tm), sizeof(XtTMRec));
	myXtTMRec = testStruct.core.tm;
	pmyXtTMRec = &testStruct.core.tm;

	check_size("CompositeRec.core.accelerators", "XtTranslations", sizeof(testStruct.core.accelerators), sizeof(XtTranslations));
	myXtTranslations = testStruct.core.accelerators;
	pmyXtTranslations = &testStruct.core.accelerators;

	check_size("CompositeRec.core.border_pixel", "Pixel", sizeof(testStruct.core.border_pixel), sizeof(Pixel));
	myPixel = testStruct.core.border_pixel;
	pmyPixel = &testStruct.core.border_pixel;

	check_size("CompositeRec.core.border_pixmap", "Pixmap", sizeof(testStruct.core.border_pixmap), sizeof(Pixmap));
	myPixmap = testStruct.core.border_pixmap;
	pmyPixmap = &testStruct.core.border_pixmap;

	check_size("CompositeRec.core.popup_list", "WidgetList", sizeof(testStruct.core.popup_list), sizeof(WidgetList));
	myWidgetList = testStruct.core.popup_list;
	pmyWidgetList = &testStruct.core.popup_list;

	check_size("CompositeRec.core.num_popups", "Cardinal", sizeof(testStruct.core.num_popups), sizeof(Cardinal));
	myCardinal = testStruct.core.num_popups;
	pmyCardinal = &testStruct.core.num_popups;

	check_size("CompositeRec.core.name", "String", sizeof(testStruct.core.name), sizeof(String));
	myString = testStruct.core.name;
	pmyString = &testStruct.core.name;

	check_size("CompositeRec.core.screen", "Screen *", sizeof(testStruct.core.screen), sizeof(Screen *));
	pmyScreen = testStruct.core.screen;

	check_size("CompositeRec.core.colormap", "Colormap", sizeof(testStruct.core.colormap), sizeof(Colormap));
	myColormap = testStruct.core.colormap;
	pmyColormap = &testStruct.core.colormap;

	check_size("CompositeRec.core.window", "Window", sizeof(testStruct.core.window), sizeof(Window));
	myWindow = testStruct.core.window;
	pmyWindow = &testStruct.core.window;

	check_size("CompositeRec.core.depth", "Cardinal", sizeof(testStruct.core.depth), sizeof(Cardinal));
	myCardinal = testStruct.core.depth;
	pmyCardinal = &testStruct.core.depth;

	check_size("CompositeRec.core.background_pixel", "Pixel", sizeof(testStruct.core.background_pixel), sizeof(Pixel));
	myPixel = testStruct.core.background_pixel;
	pmyPixel = &testStruct.core.background_pixel;

	check_size("CompositeRec.core.background_pixmap", "Pixmap", sizeof(testStruct.core.background_pixmap), sizeof(Pixmap));
	myPixmap = testStruct.core.background_pixmap;
	pmyPixmap = &testStruct.core.background_pixmap;

	check_size("CompositeRec.core.visible", "Boolean", sizeof(testStruct.core.visible), sizeof(Boolean));
	myBoolean = testStruct.core.visible;
	pmyBoolean = &testStruct.core.visible;

	check_size("CompositeRec.core.mapped_when_managed", "Boolean", sizeof(testStruct.core.mapped_when_managed), sizeof(Boolean));
	myBoolean = testStruct.core.mapped_when_managed;
	pmyBoolean = &testStruct.core.mapped_when_managed;

	check_size("CompositeRec.composite.children", "WidgetList", sizeof(testStruct.composite.children), sizeof(WidgetList));
	myWidgetList = testStruct.composite.children;
	pmyWidgetList = &testStruct.composite.children;

	check_size("CompositeRec.composite.num_children", "Cardinal", sizeof(testStruct.composite.num_children), sizeof(Cardinal));
	myCardinal = testStruct.composite.num_children;
	pmyCardinal = &testStruct.composite.num_children;

	check_size("CompositeRec.composite.num_slots", "Cardinal", sizeof(testStruct.composite.num_slots), sizeof(Cardinal));
	myCardinal = testStruct.composite.num_slots;
	pmyCardinal = &testStruct.composite.num_slots;

	check_size("CompositeRec.composite.insert_position", "XtOrderProc", sizeof(testStruct.composite.insert_position), sizeof(XtOrderProc));
	myXtOrderProc = testStruct.composite.insert_position;
	pmyXtOrderProc = &testStruct.composite.insert_position;

	tet_result(TET_PASS);
>>ASSERTION Good A
The type CompositeWidget shall be defined as a
pointer to a composite widget instance.
>>CODE
CompositeRec	testwid;
CompositeWidget testvar;
XtPointer testvar2;

	/* this will not build if the define is not correct*/
	tet_infoline("TEST: CompositeWidget");
	/*doesn't matter where we point, just testing syntax*/
	testvar = &testwid;
	testvar2 = testvar->composite.children;
	tet_result(TET_PASS);
>>ASSERTION Good A
Composite widgets shall be a subclass of core widgets.
>>CODE

	avs_xt_hier("Hcomp10", "XtComposite");
	tet_infoline("PREP: Create fresh widget");
	testwidget = XtCreateWidget("ApTest", compositeWidgetClass, topLevel, NULL, 0);
	tet_infoline("TEST: composite superclass is core");
	if (compositeClassRec.core_class.superclass != coreWidgetClass) {
		tet_infoline("ERROR: superclass is not core");
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
>>ASSERTION Good A
CompositeRec shall be initialized to the default values
specified in sections 3.4.1 and 3.4.2 of the
Specification on creation of a new composite widget instance.
>>CODE
/* Conversion arguments and results */
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

	avs_xt_hier("Hcomp11", "XtComposite");
	tet_infoline("PREP: Create fresh widget");
	testwidget2 = (CompositeWidget)XtCreateWidget("ApTest", compositeWidgetClass, topLevel, NULL, 0);
	tet_infoline("TEST: core.self");
	if (testwidget2->core.self != (Widget)testwidget2) {
		tet_infoline("ERROR: self member is not address of widget structure");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: core.widget_class");
	if (testwidget2->core.widget_class != compositeWidgetClass) {
		tet_infoline("ERROR: widget_class member is not compositeWidgetClass");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: core.parent");
	if (testwidget2->core.parent != topLevel) {
		tet_infoline("ERROR: parent member is not address of parent widget structure");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: core.being_destroyed");
	if (testwidget2->core.being_destroyed != topLevel->core.being_destroyed) {
		sprintf(ebuf, "ERROR: Expected being_destroyed of %#x, is %#x", topLevel->core.being_destroyed, testwidget2->core.being_destroyed);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: core.destroy_callbacks");
	if (testwidget2->core.destroy_callbacks != NULL) {
		tet_infoline("ERROR: destroy_callbacks member is not NULL");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: core.constraints");
	if (testwidget2->core.constraints != NULL) {
		tet_infoline("ERROR: constraints member is not NULL");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: core.x");
	if (testwidget2->core.x != 0) {
		sprintf(ebuf, "ERROR: x member is %d, expected 0", testwidget2->core.x);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: core.y");
	if (testwidget2->core.y != 0) {
		sprintf(ebuf, "ERROR: y member is %d, expected 0", testwidget2->core.y);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: core.width");
	if (testwidget2->core.width != 0) {
		sprintf(ebuf, "ERROR: width member is %d, expected 0", testwidget2->core.width);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: core.height");
	if (testwidget2->core.height != 0) {
		sprintf(ebuf, "ERROR: height member is %d, expected 0", testwidget2->core.height);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: core.border_width");
	if (testwidget2->core.border_width != 1) {
		sprintf(ebuf, "ERROR: border_width member is %d, expected 1", testwidget2->core.border_width);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: core.managed");
	if (testwidget2->core.managed != False) {
		sprintf(ebuf, "ERROR: managed member is %d,  expected False", testwidget2->core.managed);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: core.sensitive");
	if (testwidget2->core.sensitive != True) {
		sprintf(ebuf, "ERROR: sensitive member is %d, expected True", testwidget2->core.sensitive);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: core.ancestor_sensitive");
	if (testwidget2->core.ancestor_sensitive != (topLevel->core.sensitive & topLevel->core.ancestor_sensitive)) {
		sprintf(ebuf, "ERROR: Expected ancestor_sensitive of %#x, is %#x", (topLevel->core.sensitive & topLevel->core.ancestor_sensitive), testwidget2->core.ancestor_sensitive);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: core.accelerators");
	if (testwidget2->core.accelerators != NULL) {
		tet_infoline("ERROR: accelerators member is not NULL");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: core.border_pixel");
        fromVal.addr = pixstr;
        fromVal.size = strlen(pixstr)+1;
        toVal.addr = (XtPointer) &res;
        toVal.size = sizeof(Pixel);
        status = XtConvertAndStore((Widget)testwidget2, XtRString, &fromVal, XtRPixel, &toVal); 
	if (testwidget2->core.border_pixel != res) {
		tet_infoline("ERROR: border_pixel member is not XtDefaultForeground");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: core.border_pixmap");
	if (testwidget2->core.border_pixmap != XtUnspecifiedPixmap) {
		sprintf(ebuf, "ERROR: border_pixmap member is %d, expected XtUnspecifiedPixmap", testwidget2->core.border_pixmap);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: core.popup_list");
	if (testwidget2->core.popup_list != NULL) {
		tet_infoline("ERROR: popup_list member is not NULL");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: core.num_popups");
	if (testwidget2->core.num_popups != 0) {
		sprintf(ebuf, "ERROR: num_popups member is %d, expected 0", testwidget2->core.num_popups);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: core.screen");
	if (testwidget2->core.screen != topLevel->core.screen) {
		sprintf(ebuf, "ERROR: Expected screen of %#x, is %#x", topLevel->core.screen, testwidget2->core.screen);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: core.name");
	if (strcmp(testwidget2->core.name, "ApTest") != 0) {
		sprintf(ebuf, "ERROR: Expected name of %s, is %s", "ApTest", testwidget2->core.name);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: core.colormap");
	if (testwidget2->core.colormap != topLevel->core.colormap) {
		sprintf(ebuf, "ERROR: Expected colormap of %#x, is %#x", topLevel->core.colormap, testwidget2->core.colormap);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: core.window");
	if (testwidget2->core.window != NULL) {
		tet_infoline("ERROR: window member is not NULL");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: core.depth");
	if (testwidget2->core.depth != topLevel->core.depth) {
		sprintf(ebuf, "ERROR: Expected depth of %#x, is %#x", topLevel->core.depth, testwidget2->core.depth);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: core.background_pixel");
        fromVal.addr = pixstr2;
        fromVal.size = strlen(pixstr2)+1;
        toVal.addr = (XtPointer) &res;
        toVal.size = sizeof(Pixel);
        status = XtConvertAndStore((Widget)testwidget2, XtRString, &fromVal, XtRPixel, &toVal); 
	if (testwidget2->core.background_pixel != res) {
		tet_infoline("ERROR: background_pixel member is not XtDefaultBackground");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: core.background_pixmap");
	if (testwidget2->core.background_pixmap != XtUnspecifiedPixmap) {
		tet_infoline("ERROR: background_pixmap member is not XtUnspecifiedPixmap");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: core.visible");
	if (testwidget2->core.visible != True) {
		sprintf(ebuf, "ERROR: visible member is %d, expected True", testwidget2->core.visible);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: core.mapped_when_managed");
	if (testwidget2->core.mapped_when_managed != True) {
		sprintf(ebuf, "ERROR: mapped_when_managed member is %d, expected True", testwidget2->core.mapped_when_managed);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: composite.children");
	if (testwidget2->composite.children != NULL) {
		tet_infoline("ERROR: children member is not NULL");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: composite.num_children");
	if (testwidget2->composite.num_children != 0) {
		sprintf(ebuf, "ERROR: num_children member is %d, expected 0", testwidget2->composite.num_children);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: composite.num_slots");
	if (testwidget2->composite.num_slots != 0) {
		sprintf(ebuf, "ERROR: num_slots member is %d, expected 0", testwidget2->composite.num_slots);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
