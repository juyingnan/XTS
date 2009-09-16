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
>># File: tset/Xt3/CoreWidget/CoreWidget.m
>># 
>># Description:
>>#	Tests for Core widget data structures
>># 
>># Modifications:
>># $Log: wdgtcr.m,v $
>># Revision 1.1  2005-02-12 14:38:00  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:36:03  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:58:50  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:27:16  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:23:49  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:15:02  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:18:32  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/CompositeP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext ;
Widget topLevel, panedw, boxw1, boxw2 ;
Widget labelw, rowcolw, click_quit ;
CoreWidget testwidget;

/*used for assignments to solicit compiler failures due to type mismatches*/
WidgetClass		myWidgetClass, *pmyWidgetClass;
String			myString, *pmyString;
Cardinal		myCardinal, *pmyCardinal;
Boolean			myBoolean, *pmyBoolean;
XtProc			myXtProc, *pmyXtProc;
XtWidgetClassProc	myXtWidgetClassProc, *pmyXtWidgetClassProc;
XtEnum			myXtEnum, *pmyXtEnum;
XtInitProc		myXtInitProc, *pmyXtInitProc;
XtArgsProc		myXtArgsProc, *pmyXtArgsProc;
XtRealizeProc		myXtRealizeProc, *pmyXtRealizeProc;
XtActionList		myXtActionList, *pmyXtActionList;
XtResourceList		myXtResourceList, *pmyXtResourceList;
XrmClass		myXrmClass, *pmyXrmClass;
XtWidgetProc		myXtWidgetProc, *pmyXtWidgetProc;
XtExposeProc		myXtExposeProc, *pmyXtExposeProc;
XtSetValuesFunc		myXtSetValuesFunc, *pmyXtSetValuesFunc;
XtArgsFunc		myXtArgsFunc, *pmyXtArgsFunc;
XtAlmostProc		myXtAlmostProc, *pmyXtAlmostProc;
XtArgsProc		myXtArgsProc, *pmyXtArgsProc;
XtAcceptFocusProc	myXtAcceptFocusProc, *pmyXtAcceptFocusProc;
XtVersionType		myXtVersionType, *pmyXtVersionType;
XtPointer		myXtPointer, *pmyXtPointer;
XtGeometryHandler	myXtGeometryHandler, *pmyXtGeometryHandler;
XtStringProc		myXtStringProc, *pmyXtStringProc;
Window			myWindow, *pmyWindow;
WidgetList		myWidgetList, *pmyWidgetList;
Widget			myWidget, *pmyWidget;
XrmName			myXrmName, *pmyXrmName;
XtCallbackList		myXtCallbackList, *pmyXtCallbackList;
Dimension		myDimension, *pmyDimension;
XtEventTable		myXtEventTable, *pmyXtEventTable;
XtTMRec			myXtTMRec, *pmyXtTMRec;
XtTranslations		myXtTranslations, *pmyXtTranslations;
Pixel			myPixel, *pmyPixel;
Pixmap			myPixmap, *pmyPixmap;
Colormap		myColormap, *pmyColormap;
Screen			*pmyScreen;
>>TITLE CoreWidget Xt3
>>ASSERTION Good A
The class structure for core widgets CoreClassPart shall be defined
and contain the fields listed in section 3.4.1 of the Specification.
>>CODE
CoreClassPart		testStruct;

	/*check sizes and do some assignments which should cause compiler
	warnings if types are wrong*/

	check_size("CoreClassPart.superclass", "WidgetClass", sizeof(testStruct.superclass), sizeof(WidgetClass));
	myWidgetClass = testStruct.superclass;
	pmyWidgetClass = &testStruct.superclass;

	check_size("CoreClassPart.class_name", "String", sizeof(testStruct.class_name), sizeof(String));
	myString = testStruct.class_name;
	pmyString = &testStruct.class_name;

	check_size("CoreClassPart.widget_size", "Cardinal", sizeof(testStruct.widget_size), sizeof(Cardinal));
	myCardinal = testStruct.widget_size;
	pmyCardinal = &testStruct.widget_size;

	check_size("CoreClassPart.class_initialize", "XtProc", sizeof(testStruct.class_initialize), sizeof(XtProc));
	myXtProc = testStruct.class_initialize;
	pmyXtProc = &testStruct.class_initialize;

	check_size("CoreClassPart.class_part_initialize", "XtWidgetClassProc", sizeof(testStruct.class_part_initialize), sizeof(XtWidgetClassProc));
	myXtWidgetClassProc = testStruct.class_part_initialize;
	pmyXtWidgetClassProc = &testStruct.class_part_initialize;

	check_size("CoreClassPart.class_inited", "XtEnum", sizeof(testStruct.class_inited), sizeof(XtEnum));
	myXtEnum = testStruct.class_inited;
	pmyXtEnum = &testStruct.class_inited;

	check_size("CoreClassPart.initialize", "XtInitProc", sizeof(testStruct.initialize), sizeof(XtInitProc));
	myXtInitProc = testStruct.initialize;
	pmyXtInitProc = &testStruct.initialize;

	check_size("CoreClassPart.initialize_hook", "XtArgsProc", sizeof(testStruct.initialize_hook), sizeof(XtArgsProc));
	myXtArgsProc = testStruct.initialize_hook;
	pmyXtArgsProc = &testStruct.initialize_hook;

	check_size("CoreClassPart.realize", "XtRealizeProc", sizeof(testStruct.realize), sizeof(XtRealizeProc));
	myXtRealizeProc = testStruct.realize;
	pmyXtRealizeProc = &testStruct.realize;

	check_size("CoreClassPart.actions", "XtActionList", sizeof(testStruct.actions), sizeof(XtActionList));
	myXtActionList = testStruct.actions;
	pmyXtActionList = &testStruct.actions;

	check_size("CoreClassPart.num_actions", "Cardinal", sizeof(testStruct.num_actions), sizeof(Cardinal));
	myCardinal = testStruct.num_actions;
	pmyCardinal = &testStruct.num_actions;

	check_size("CoreClassPart.resources", "XtResourceList", sizeof(testStruct.resources), sizeof(XtResourceList));
	myXtResourceList = testStruct.resources;
	pmyXtResourceList = &testStruct.resources;
	
	check_size("CoreClassPart.num_resources", "Cardinal", sizeof(testStruct.num_resources), sizeof(Cardinal));
	myCardinal = testStruct.num_resources;
	pmyCardinal = &testStruct.num_resources;

	check_size("CoreClassPart.xrm_class", "XrmClass", sizeof(testStruct.xrm_class), sizeof(XrmClass));
	myXrmClass = testStruct.xrm_class;
	pmyXrmClass = &testStruct.xrm_class;

	check_size("CoreClassPart.compress_motion", "Boolean", sizeof(testStruct.compress_motion), sizeof(Boolean));
	myBoolean = testStruct.compress_motion;
	pmyBoolean = &testStruct.compress_motion;

	check_size("CoreClassPart.compress_exposure", "XtEnum", sizeof(testStruct.compress_exposure), sizeof(XtEnum));
	myXtEnum = testStruct.compress_exposure;
	pmyXtEnum = &testStruct.compress_exposure;

	check_size("CoreClassPart.compress_enterleave", "Boolean", sizeof(testStruct.compress_enterleave), sizeof(Boolean));
	myBoolean = testStruct.compress_enterleave;
	pmyBoolean = &testStruct.compress_enterleave;

	check_size("CoreClassPart.visible_interest", "Boolean", sizeof(testStruct.visible_interest), sizeof(Boolean));
	myBoolean = testStruct.visible_interest;
	pmyBoolean = &testStruct.visible_interest;

	check_size("CoreClassPart.destroy", "XtWidgetProc", sizeof(testStruct.destroy), sizeof(XtWidgetProc));
	myXtWidgetProc = testStruct.destroy;
	pmyXtWidgetProc = &testStruct.destroy;

	check_size("CoreClassPart.resize", "XtWidgetProc", sizeof(testStruct.resize), sizeof(XtWidgetProc));
	myXtWidgetProc = testStruct.resize;
	pmyXtWidgetProc = &testStruct.resize;

	check_size("CoreClassPart.expose", "XtExposeProc", sizeof(testStruct.expose), sizeof(XtExposeProc));
	myXtExposeProc = testStruct.expose;
	pmyXtExposeProc = &testStruct.expose;

	check_size("CoreClassPart.set_values", "XtSetValuesFunc", sizeof(testStruct.set_values), sizeof(XtSetValuesFunc));
	myXtSetValuesFunc = testStruct.set_values;
	pmyXtSetValuesFunc = &testStruct.set_values;

	check_size("CoreClassPart.set_values_hook", "XtArgsFunc", sizeof(testStruct.set_values_hook), sizeof(XtArgsFunc));
	myXtArgsFunc = testStruct.set_values_hook;
	pmyXtArgsFunc = &testStruct.set_values_hook;

	check_size("CoreClassPart.set_values_almost", "XtAlmostProc", sizeof(testStruct.set_values_almost), sizeof(XtAlmostProc));
	myXtAlmostProc = testStruct.set_values_almost;
	pmyXtAlmostProc = &testStruct.set_values_almost;

	check_size("CoreClassPart.get_values_hook", "XtArgsProc", sizeof(testStruct.get_values_hook), sizeof(XtArgsProc));
	myXtArgsProc = testStruct.get_values_hook;
	pmyXtArgsProc = &testStruct.get_values_hook;

	check_size("CoreClassPart.accept_focus", "XtAcceptFocusProc", sizeof(testStruct.accept_focus), sizeof(XtAcceptFocusProc));
	myXtAcceptFocusProc = testStruct.accept_focus;
	pmyXtAcceptFocusProc = &testStruct.accept_focus;

	check_size("CoreClassPart.version", "XtVersionType", sizeof(testStruct.version), sizeof(XtVersionType));
	myXtVersionType = testStruct.version;
	pmyXtVersionType = &testStruct.version;

	check_size("CoreClassPart.callback_private", "XtPointer", sizeof(testStruct.callback_private), sizeof(XtPointer));
	myXtPointer = testStruct.callback_private;
	pmyXtPointer = &testStruct.callback_private;

	check_size("CoreClassPart.tm_table", "String", sizeof(testStruct.tm_table), sizeof(String));
	myString = testStruct.tm_table;
	pmyString = &testStruct.tm_table;

	check_size("CoreClassPart.query_geometry", "XtGeometryHandler", sizeof(testStruct.query_geometry), sizeof(XtGeometryHandler));
	myXtGeometryHandler = testStruct.query_geometry;
	pmyXtGeometryHandler = &testStruct.query_geometry;

	check_size("CoreClassPart.display_accelerator", "XtStringProc", sizeof(testStruct.display_accelerator), sizeof(XtStringProc));
	myXtStringProc = testStruct.display_accelerator;
	pmyXtStringProc = &testStruct.display_accelerator;

	check_size("CoreClassPart.extension", "XtPointer", sizeof(testStruct.extension), sizeof(XtPointer));
	myXtPointer = testStruct.extension;
	pmyXtPointer = &testStruct.extension;

	tet_result(TET_PASS);
>>ASSERTION Good A
The class record structures for core widgets CoreClassRec/WidgetClassRec
shall be defined and contain the fields listed in section 3.4.1
of the Specification.
>>CODE
CoreClassRec testStruct;
WidgetClassRec testStruct2;

	/*check sizes and do some assignments which should cause compiler
	warnings if types are wrong*/

	check_size("CoreClassRec.core_class.superclass", "WidgetClass", sizeof(testStruct.core_class.superclass), sizeof(WidgetClass));
	myWidgetClass = testStruct.core_class.superclass;
	pmyWidgetClass = &testStruct.core_class.superclass;

	check_size("CoreClassRec.core_class.class_name", "String", sizeof(testStruct.core_class.class_name), sizeof(String));
	myString = testStruct.core_class.class_name;
	pmyString = &testStruct.core_class.class_name;

	check_size("CoreClassRec.core_class.widget_size", "Cardinal", sizeof(testStruct.core_class.widget_size), sizeof(Cardinal));
	myCardinal = testStruct.core_class.widget_size;
	pmyCardinal = &testStruct.core_class.widget_size;

	check_size("CoreClassRec.core_class.class_initialize", "XtProc", sizeof(testStruct.core_class.class_initialize), sizeof(XtProc));
	myXtProc = testStruct.core_class.class_initialize;
	pmyXtProc = &testStruct.core_class.class_initialize;

	check_size("CoreClassRec.core_class.class_part_initialize", "XtWidgetClassProc", sizeof(testStruct.core_class.class_part_initialize), sizeof(XtWidgetClassProc));
	myXtWidgetClassProc = testStruct.core_class.class_part_initialize;
	pmyXtWidgetClassProc = &testStruct.core_class.class_part_initialize;

	check_size("CoreClassRec.core_class.class_inited", "XtEnum", sizeof(testStruct.core_class.class_inited), sizeof(XtEnum));
	myXtEnum = testStruct.core_class.class_inited;
	pmyXtEnum = &testStruct.core_class.class_inited;

	check_size("CoreClassRec.core_class.initialize", "XtInitProc", sizeof(testStruct.core_class.initialize), sizeof(XtInitProc));
	myXtInitProc = testStruct.core_class.initialize;
	pmyXtInitProc = &testStruct.core_class.initialize;

	check_size("CoreClassRec.core_class.initialize_hook", "XtArgsProc", sizeof(testStruct.core_class.initialize_hook), sizeof(XtArgsProc));
	myXtArgsProc = testStruct.core_class.initialize_hook;
	pmyXtArgsProc = &testStruct.core_class.initialize_hook;

	check_size("CoreClassRec.core_class.realize", "XtRealizeProc", sizeof(testStruct.core_class.realize), sizeof(XtRealizeProc));
	myXtRealizeProc = testStruct.core_class.realize;
	pmyXtRealizeProc = &testStruct.core_class.realize;

	check_size("CoreClassRec.core_class.actions", "XtActionList", sizeof(testStruct.core_class.actions), sizeof(XtActionList));
	myXtActionList = testStruct.core_class.actions;
	pmyXtActionList = &testStruct.core_class.actions;

	check_size("CoreClassRec.core_class.num_actions", "Cardinal", sizeof(testStruct.core_class.num_actions), sizeof(Cardinal));
	myCardinal = testStruct.core_class.num_actions;
	pmyCardinal = &testStruct.core_class.num_actions;

	check_size("CoreClassRec.core_class.resources", "XtResourceList", sizeof(testStruct.core_class.resources), sizeof(XtResourceList));
	myXtResourceList = testStruct.core_class.resources;
	pmyXtResourceList = &testStruct.core_class.resources;

	check_size("CoreClassRec.core_class.num_resources", "Cardinal", sizeof(testStruct.core_class.num_resources), sizeof(Cardinal));
	myCardinal = testStruct.core_class.num_resources;
	pmyCardinal = &testStruct.core_class.num_resources;

	check_size("CoreClassRec.core_class.xrm_class", "XrmClass", sizeof(testStruct.core_class.xrm_class), sizeof(XrmClass));
	myXrmClass = testStruct.core_class.xrm_class;
	pmyXrmClass = &testStruct.core_class.xrm_class;

	check_size("CoreClassRec.core_class.compress_motion", "Boolean", sizeof(testStruct.core_class.compress_motion), sizeof(Boolean));
	myBoolean = testStruct.core_class.compress_motion;
	pmyBoolean = &testStruct.core_class.compress_motion;

	check_size("CoreClassRec.core_class.compress_exposure", "XtEnum", sizeof(testStruct.core_class.compress_exposure), sizeof(XtEnum));
	myXtEnum = testStruct.core_class.compress_exposure;
	pmyXtEnum = &testStruct.core_class.compress_exposure;

	check_size("CoreClassRec.core_class.compress_enterleave", "Boolean", sizeof(testStruct.core_class.compress_enterleave), sizeof(Boolean));
	myBoolean = testStruct.core_class.compress_enterleave;
	pmyBoolean = &testStruct.core_class.compress_enterleave;

	check_size("CoreClassRec.core_class.visible_interest", "Boolean", sizeof(testStruct.core_class.visible_interest), sizeof(Boolean));
	myBoolean = testStruct.core_class.visible_interest;
	pmyBoolean = &testStruct.core_class.visible_interest;

	check_size("CoreClassRec.core_class.destroy", "XtWidgetProc", sizeof(testStruct.core_class.destroy), sizeof(XtWidgetProc));
	myXtWidgetProc = testStruct.core_class.destroy;
	pmyXtWidgetProc = &testStruct.core_class.destroy;

	check_size("CoreClassRec.core_class.resize", "XtWidgetProc", sizeof(testStruct.core_class.resize), sizeof(XtWidgetProc));
	myXtWidgetProc = testStruct.core_class.resize;
	pmyXtWidgetProc = &testStruct.core_class.resize;

	check_size("CoreClassRec.core_class.expose", "XtExposeProc", sizeof(testStruct.core_class.expose), sizeof(XtExposeProc));
	myXtExposeProc = testStruct.core_class.expose;
	pmyXtExposeProc = &testStruct.core_class.expose;

	check_size("CoreClassRec.core_class.set_values", "XtSetValuesFunc", sizeof(testStruct.core_class.set_values), sizeof(XtSetValuesFunc));
	myXtSetValuesFunc = testStruct.core_class.set_values;
	pmyXtSetValuesFunc = &testStruct.core_class.set_values;

	check_size("CoreClassRec.core_class.set_values_hook", "XtArgsFunc", sizeof(testStruct.core_class.set_values_hook), sizeof(XtArgsFunc));
	myXtArgsFunc = testStruct.core_class.set_values_hook;
	pmyXtArgsFunc = &testStruct.core_class.set_values_hook;

	check_size("CoreClassRec.core_class.set_values_almost", "XtAlmostProc", sizeof(testStruct.core_class.set_values_almost), sizeof(XtAlmostProc));
	myXtAlmostProc = testStruct.core_class.set_values_almost;
	pmyXtAlmostProc = &testStruct.core_class.set_values_almost;

	check_size("CoreClassRec.core_class.get_values_hook", "XtArgsProc", sizeof(testStruct.core_class.get_values_hook), sizeof(XtArgsProc));
	myXtArgsProc = testStruct.core_class.get_values_hook;
	pmyXtArgsProc = &testStruct.core_class.get_values_hook;

	check_size("CoreClassRec.core_class.accept_focus", "XtAcceptFocusProc", sizeof(testStruct.core_class.accept_focus), sizeof(XtAcceptFocusProc));
	myXtAcceptFocusProc = testStruct.core_class.accept_focus;
	pmyXtAcceptFocusProc = &testStruct.core_class.accept_focus;

	check_size("CoreClassRec.core_class.version", "XtVersionType", sizeof(testStruct.core_class.version), sizeof(XtVersionType));
	myXtVersionType = testStruct.core_class.version;
	pmyXtVersionType = &testStruct.core_class.version;

	check_size("CoreClassRec.core_class.callback_private", "XtPointer", sizeof(testStruct.core_class.callback_private), sizeof(XtPointer));
	myXtPointer = testStruct.core_class.callback_private;
	pmyXtPointer = &testStruct.core_class.callback_private;

	check_size("CoreClassRec.core_class.tm_table", "String", sizeof(testStruct.core_class.tm_table), sizeof(String));
	myString = testStruct.core_class.tm_table;
	pmyString = &testStruct.core_class.tm_table;

	check_size("CoreClassRec.core_class.query_geometry", "XtGeometryHandler", sizeof(testStruct.core_class.query_geometry), sizeof(XtGeometryHandler));
	myXtGeometryHandler = testStruct.core_class.query_geometry;
	pmyXtGeometryHandler = &testStruct.core_class.query_geometry;

	check_size("CoreClassRec.core_class.display_accelerator", "XtStringProc", sizeof(testStruct.core_class.display_accelerator), sizeof(XtStringProc));
	myXtStringProc = testStruct.core_class.display_accelerator;
	pmyXtStringProc = &testStruct.core_class.display_accelerator;

	check_size("CoreClassRec.core_class.extension", "XtPointer", sizeof(testStruct.core_class.extension), sizeof(XtPointer));
	myXtPointer = testStruct.core_class.extension;
	pmyXtPointer = &testStruct.core_class.extension;

	check_size("WidgetClassRec.core_class.superclass", "WidgetClass", sizeof(testStruct2.core_class.superclass), sizeof(WidgetClass));
	myWidgetClass = testStruct2.core_class.superclass;
	pmyWidgetClass = &testStruct2.core_class.superclass;

	check_size("WidgetClassRec.core_class.class_name", "String", sizeof(testStruct2.core_class.class_name), sizeof(String));
	myString = testStruct2.core_class.class_name;
	pmyString = &testStruct2.core_class.class_name;

	check_size("WidgetClassRec.core_class.widget_size", "Cardinal", sizeof(testStruct2.core_class.widget_size), sizeof(Cardinal));
	myCardinal = testStruct2.core_class.widget_size;
	pmyCardinal = &testStruct2.core_class.widget_size;

	check_size("WidgetClassRec.core_class.class_initialize", "XtProc", sizeof(testStruct2.core_class.class_initialize), sizeof(XtProc));
	myXtProc = testStruct2.core_class.class_initialize;
	pmyXtProc = &testStruct2.core_class.class_initialize;

	check_size("WidgetClassRec.core_class.class_part_initialize", "XtWidgetClassProc", sizeof(testStruct2.core_class.class_part_initialize), sizeof(XtWidgetClassProc));
	myXtWidgetClassProc = testStruct2.core_class.class_part_initialize;
	pmyXtWidgetClassProc = &testStruct2.core_class.class_part_initialize;

	check_size("WidgetClassRec.core_class.class_inited", "XtEnum", sizeof(testStruct2.core_class.class_inited), sizeof(XtEnum));
	myXtEnum = testStruct2.core_class.class_inited;
	pmyXtEnum = &testStruct2.core_class.class_inited;

	check_size("WidgetClassRec.core_class.initialize", "XtInitProc", sizeof(testStruct2.core_class.initialize), sizeof(XtInitProc));
	myXtInitProc = testStruct2.core_class.initialize;
	pmyXtInitProc = &testStruct2.core_class.initialize;

	check_size("WidgetClassRec.core_class.initialize_hook", "XtArgsProc", sizeof(testStruct2.core_class.initialize_hook), sizeof(XtArgsProc));
	myXtArgsProc = testStruct2.core_class.initialize_hook;
	pmyXtArgsProc = &testStruct2.core_class.initialize_hook;

	check_size("WidgetClassRec.core_class.realize", "XtRealizeProc", sizeof(testStruct2.core_class.realize), sizeof(XtRealizeProc));
	myXtRealizeProc = testStruct2.core_class.realize;
	pmyXtRealizeProc = &testStruct2.core_class.realize;

	check_size("WidgetClassRec.core_class.actions", "XtActionList", sizeof(testStruct2.core_class.actions), sizeof(XtActionList));
	myXtActionList = testStruct2.core_class.actions;
	pmyXtActionList = &testStruct2.core_class.actions;

	check_size("WidgetClassRec.core_class.num_actions", "Cardinal", sizeof(testStruct2.core_class.num_actions), sizeof(Cardinal));
	myCardinal = testStruct2.core_class.num_actions;
	pmyCardinal = &testStruct2.core_class.num_actions;

	check_size("WidgetClassRec.core_class.resources", "XtResourceList", sizeof(testStruct2.core_class.resources), sizeof(XtResourceList));
	myXtResourceList = testStruct2.core_class.resources;
	pmyXtResourceList = &testStruct2.core_class.resources;

	check_size("WidgetClassRec.core_class.num_resources", "Cardinal", sizeof(testStruct2.core_class.num_resources), sizeof(Cardinal));
	myCardinal = testStruct2.core_class.num_resources;
	pmyCardinal = &testStruct2.core_class.num_resources;

	check_size("WidgetClassRec.core_class.xrm_class", "XrmClass", sizeof(testStruct2.core_class.xrm_class), sizeof(XrmClass));
	myXrmClass = testStruct2.core_class.xrm_class;
	pmyXrmClass = &testStruct2.core_class.xrm_class;

	check_size("WidgetClassRec.core_class.compress_motion", "Boolean", sizeof(testStruct2.core_class.compress_motion), sizeof(Boolean));
	myBoolean = testStruct2.core_class.compress_motion;
	pmyBoolean = &testStruct2.core_class.compress_motion;

	check_size("WidgetClassRec.core_class.compress_exposure", "XtEnum", sizeof(testStruct2.core_class.compress_exposure), sizeof(XtEnum));
	myXtEnum = testStruct2.core_class.compress_exposure;
	pmyXtEnum = &testStruct2.core_class.compress_exposure;

	check_size("WidgetClassRec.core_class.compress_enterleave", "Boolean", sizeof(testStruct2.core_class.compress_enterleave), sizeof(Boolean));
	myBoolean = testStruct2.core_class.compress_enterleave;
	pmyBoolean = &testStruct2.core_class.compress_enterleave;

	check_size("WidgetClassRec.core_class.visible_interest", "Boolean", sizeof(testStruct2.core_class.visible_interest), sizeof(Boolean));
	myBoolean = testStruct2.core_class.visible_interest;
	pmyBoolean = &testStruct2.core_class.visible_interest;

	check_size("WidgetClassRec.core_class.destroy", "XtWidgetProc", sizeof(testStruct2.core_class.destroy), sizeof(XtWidgetProc));
	myXtWidgetProc = testStruct2.core_class.destroy;
	pmyXtWidgetProc = &testStruct2.core_class.destroy;

	check_size("WidgetClassRec.core_class.resize", "XtWidgetProc", sizeof(testStruct2.core_class.resize), sizeof(XtWidgetProc));
	myXtWidgetProc = testStruct2.core_class.resize;
	pmyXtWidgetProc = &testStruct2.core_class.resize;

	check_size("WidgetClassRec.core_class.expose", "XtExposeProc", sizeof(testStruct2.core_class.expose), sizeof(XtExposeProc));
	myXtExposeProc = testStruct2.core_class.expose;
	pmyXtExposeProc = &testStruct2.core_class.expose;

	check_size("WidgetClassRec.core_class.set_values", "XtSetValuesFunc", sizeof(testStruct2.core_class.set_values), sizeof(XtSetValuesFunc));
	myXtSetValuesFunc = testStruct2.core_class.set_values;
	pmyXtSetValuesFunc = &testStruct2.core_class.set_values;

	check_size("WidgetClassRec.core_class.set_values_hook", "XtArgsFunc", sizeof(testStruct2.core_class.set_values_hook), sizeof(XtArgsFunc));
	myXtArgsFunc = testStruct2.core_class.set_values_hook;
	pmyXtArgsFunc = &testStruct2.core_class.set_values_hook;

	check_size("WidgetClassRec.core_class.set_values_almost", "XtAlmostProc", sizeof(testStruct2.core_class.set_values_almost), sizeof(XtAlmostProc));
	myXtAlmostProc = testStruct2.core_class.set_values_almost;
	pmyXtAlmostProc = &testStruct2.core_class.set_values_almost;

	check_size("WidgetClassRec.core_class.get_values_hook", "XtArgsProc", sizeof(testStruct2.core_class.get_values_hook), sizeof(XtArgsProc));
	myXtArgsProc = testStruct2.core_class.get_values_hook;
	pmyXtArgsProc = &testStruct2.core_class.get_values_hook;

	check_size("WidgetClassRec.core_class.accept_focus", "XtAcceptFocusProc", sizeof(testStruct2.core_class.accept_focus), sizeof(XtAcceptFocusProc));
	myXtAcceptFocusProc = testStruct2.core_class.accept_focus;
	pmyXtAcceptFocusProc = &testStruct2.core_class.accept_focus;

	check_size("WidgetClassRec.core_class.version", "XtVersionType", sizeof(testStruct2.core_class.version), sizeof(XtVersionType));
	myXtVersionType = testStruct2.core_class.version;
	pmyXtVersionType = &testStruct2.core_class.version;

	check_size("WidgetClassRec.core_class.callback_private", "XtPointer", sizeof(testStruct2.core_class.callback_private), sizeof(XtPointer));
	myXtPointer = testStruct2.core_class.callback_private;
	pmyXtPointer = &testStruct2.core_class.callback_private;

	check_size("WidgetClassRec.core_class.tm_table", "String", sizeof(testStruct2.core_class.tm_table), sizeof(String));
	myString = testStruct2.core_class.tm_table;
	pmyString = &testStruct2.core_class.tm_table;

	check_size("WidgetClassRec.core_class.query_geometry", "XtGeometryHandler", sizeof(testStruct2.core_class.query_geometry), sizeof(XtGeometryHandler));
	myXtGeometryHandler = testStruct2.core_class.query_geometry;
	pmyXtGeometryHandler = &testStruct2.core_class.query_geometry;

	check_size("WidgetClassRec.core_class.display_accelerator", "XtStringProc", sizeof(testStruct2.core_class.display_accelerator), sizeof(XtStringProc));
	myXtStringProc = testStruct2.core_class.display_accelerator;
	pmyXtStringProc = &testStruct2.core_class.display_accelerator;

	check_size("WidgetClassRec.core_class.extension", "XtPointer", sizeof(testStruct2.core_class.extension), sizeof(XtPointer));
	myXtPointer = testStruct2.core_class.extension;
	pmyXtPointer = &testStruct2.core_class.extension;

	tet_result(TET_PASS);
>>ASSERTION Good A
The types WidgetClass and CoreWidgetClass shall be defined as pointers
to a core widget class structure.
>>CODE
WidgetClass testvar;
CoreWidgetClass testvar2;
XtPointer testvar3;

	/* this will not build if the define is not correct*/
	tet_infoline("TEST: WidgetClass");
	testvar = &widgetClassRec;
	testvar3 = testvar->core_class.superclass;
	tet_infoline("TEST: CoreWidgetClass");
	testvar2 = &widgetClassRec;
	testvar3 = testvar2->core_class.superclass;
	tet_result(TET_PASS);
>>ASSERTION Good A
The class record for core widgets widgetClassRec/coreClassRec
shall exist and be an instance of the WidgetClassRec structure.
>>CODE

	check_size("widgetClassRec.core_class.superclass", "WidgetClass", sizeof(widgetClassRec.core_class.superclass), sizeof(WidgetClass));
	myWidgetClass = widgetClassRec.core_class.superclass;
	pmyWidgetClass = &widgetClassRec.core_class.superclass;

	check_size("widgetClassRec.core_class.class_name", "String", sizeof(widgetClassRec.core_class.class_name), sizeof(String));
	myString = widgetClassRec.core_class.class_name;
	pmyString = &widgetClassRec.core_class.class_name;

	check_size("widgetClassRec.core_class.widget_size", "Cardinal", sizeof(widgetClassRec.core_class.widget_size), sizeof(Cardinal));
	myCardinal = widgetClassRec.core_class.widget_size;
	pmyCardinal = &widgetClassRec.core_class.widget_size;

	check_size("widgetClassRec.core_class.class_initialize", "XtProc", sizeof(widgetClassRec.core_class.class_initialize), sizeof(XtProc));
	myXtProc = widgetClassRec.core_class.class_initialize;
	pmyXtProc = &widgetClassRec.core_class.class_initialize;

	check_size("widgetClassRec.core_class.class_part_initialize", "XtWidgetClassProc", sizeof(widgetClassRec.core_class.class_part_initialize), sizeof(XtWidgetClassProc));
	myXtWidgetClassProc = widgetClassRec.core_class.class_part_initialize;
	pmyXtWidgetClassProc = &widgetClassRec.core_class.class_part_initialize;

	check_size("widgetClassRec.core_class.class_inited", "XtEnum", sizeof(widgetClassRec.core_class.class_inited), sizeof(XtEnum));
	myXtEnum = widgetClassRec.core_class.class_inited;
	pmyXtEnum = &widgetClassRec.core_class.class_inited;

	check_size("widgetClassRec.core_class.initialize", "XtInitProc", sizeof(widgetClassRec.core_class.initialize), sizeof(XtInitProc));
	myXtInitProc = widgetClassRec.core_class.initialize;
	pmyXtInitProc = &widgetClassRec.core_class.initialize;

	check_size("widgetClassRec.core_class.initialize_hook", "XtArgsProc", sizeof(widgetClassRec.core_class.initialize_hook), sizeof(XtArgsProc));
	myXtArgsProc = widgetClassRec.core_class.initialize_hook;
	pmyXtArgsProc = &widgetClassRec.core_class.initialize_hook;

	check_size("widgetClassRec.core_class.realize", "XtRealizeProc", sizeof(widgetClassRec.core_class.realize), sizeof(XtRealizeProc));
	myXtRealizeProc = widgetClassRec.core_class.realize;
	pmyXtRealizeProc = &widgetClassRec.core_class.realize;

	check_size("widgetClassRec.core_class.actions", "XtActionList", sizeof(widgetClassRec.core_class.actions), sizeof(XtActionList));
	myXtActionList = widgetClassRec.core_class.actions;
	pmyXtActionList = &widgetClassRec.core_class.actions;

	check_size("widgetClassRec.core_class.num_actions", "Cardinal", sizeof(widgetClassRec.core_class.num_actions), sizeof(Cardinal));
	myCardinal = widgetClassRec.core_class.num_actions;
	pmyCardinal = &widgetClassRec.core_class.num_actions;

	check_size("widgetClassRec.core_class.resources", "XtResourceList", sizeof(widgetClassRec.core_class.resources), sizeof(XtResourceList));
	myXtResourceList = widgetClassRec.core_class.resources;
	pmyXtResourceList = &widgetClassRec.core_class.resources;
	
	check_size("widgetClassRec.core_class.num_resources", "Cardinal", sizeof(widgetClassRec.core_class.num_resources), sizeof(Cardinal));
	myCardinal = widgetClassRec.core_class.num_resources;
	pmyCardinal = &widgetClassRec.core_class.num_resources;

	check_size("widgetClassRec.core_class.xrm_class", "XrmClass", sizeof(widgetClassRec.core_class.xrm_class), sizeof(XrmClass));
	myXrmClass = widgetClassRec.core_class.xrm_class;
	pmyXrmClass = &widgetClassRec.core_class.xrm_class;

	check_size("widgetClassRec.core_class.compress_motion", "Boolean", sizeof(widgetClassRec.core_class.compress_motion), sizeof(Boolean));
	myBoolean = widgetClassRec.core_class.compress_motion;
	pmyBoolean = &widgetClassRec.core_class.compress_motion;

	check_size("widgetClassRec.core_class.compress_exposure", "XtEnum", sizeof(widgetClassRec.core_class.compress_exposure), sizeof(XtEnum));
	myXtEnum = widgetClassRec.core_class.compress_exposure;
	pmyXtEnum = &widgetClassRec.core_class.compress_exposure;

	check_size("widgetClassRec.core_class.compress_enterleave", "Boolean", sizeof(widgetClassRec.core_class.compress_enterleave), sizeof(Boolean));
	myBoolean = widgetClassRec.core_class.compress_enterleave;
	pmyBoolean = &widgetClassRec.core_class.compress_enterleave;

	check_size("widgetClassRec.core_class.visible_interest", "Boolean", sizeof(widgetClassRec.core_class.visible_interest), sizeof(Boolean));
	myBoolean = widgetClassRec.core_class.visible_interest;
	pmyBoolean = &widgetClassRec.core_class.visible_interest;

	check_size("widgetClassRec.core_class.destroy", "XtWidgetProc", sizeof(widgetClassRec.core_class.destroy), sizeof(XtWidgetProc));
	myXtWidgetProc = widgetClassRec.core_class.destroy;
	pmyXtWidgetProc = &widgetClassRec.core_class.destroy;

	check_size("widgetClassRec.core_class.resize", "XtWidgetProc", sizeof(widgetClassRec.core_class.resize), sizeof(XtWidgetProc));
	myXtWidgetProc = widgetClassRec.core_class.resize;
	pmyXtWidgetProc = &widgetClassRec.core_class.resize;

	check_size("widgetClassRec.core_class.expose", "XtExposeProc", sizeof(widgetClassRec.core_class.expose), sizeof(XtExposeProc));
	myXtExposeProc = widgetClassRec.core_class.expose;
	pmyXtExposeProc = &widgetClassRec.core_class.expose;

	check_size("widgetClassRec.core_class.set_values", "XtSetValuesFunc", sizeof(widgetClassRec.core_class.set_values), sizeof(XtSetValuesFunc));
	myXtSetValuesFunc = widgetClassRec.core_class.set_values;
	pmyXtSetValuesFunc = &widgetClassRec.core_class.set_values;

	check_size("widgetClassRec.core_class.set_values_hook", "XtArgsFunc", sizeof(widgetClassRec.core_class.set_values_hook), sizeof(XtArgsFunc));
	myXtArgsFunc = widgetClassRec.core_class.set_values_hook;
	pmyXtArgsFunc = &widgetClassRec.core_class.set_values_hook;

	check_size("widgetClassRec.core_class.set_values_almost", "XtAlmostProc", sizeof(widgetClassRec.core_class.set_values_almost), sizeof(XtAlmostProc));
       myXtAlmostProc = widgetClassRec.core_class.set_values_almost;
	pmyXtAlmostProc = &widgetClassRec.core_class.set_values_almost;

	check_size("widgetClassRec.core_class.get_values_hook", "XtArgsProc", sizeof(widgetClassRec.core_class.get_values_hook), sizeof(XtArgsProc));
	myXtArgsProc = widgetClassRec.core_class.get_values_hook;
	pmyXtArgsProc = &widgetClassRec.core_class.get_values_hook;

	check_size("widgetClassRec.core_class.accept_focus", "XtAcceptFocusProc", sizeof(widgetClassRec.core_class.accept_focus), sizeof(XtAcceptFocusProc));
	myXtAcceptFocusProc = widgetClassRec.core_class.accept_focus;
	pmyXtAcceptFocusProc = &widgetClassRec.core_class.accept_focus;

	check_size("widgetClassRec.core_class.version", "XtVersionType", sizeof(widgetClassRec.core_class.version), sizeof(XtVersionType));
	myXtVersionType = widgetClassRec.core_class.version;
	pmyXtVersionType = &widgetClassRec.core_class.version;

	check_size("widgetClassRec.core_class.callback_private", "XtPointer", sizeof(widgetClassRec.core_class.callback_private), sizeof(XtPointer));
	myXtPointer = widgetClassRec.core_class.callback_private;
	pmyXtPointer = &widgetClassRec.core_class.callback_private;

	check_size("widgetClassRec.core_class.tm_table", "String", sizeof(widgetClassRec.core_class.tm_table), sizeof(String));
	myString = widgetClassRec.core_class.tm_table;
	pmyString = &widgetClassRec.core_class.tm_table;

	check_size("widgetClassRec.core_class.query_geometry", "XtGeometryHandler", sizeof(widgetClassRec.core_class.query_geometry), sizeof(XtGeometryHandler));
	myXtGeometryHandler = widgetClassRec.core_class.query_geometry;
	pmyXtGeometryHandler = &widgetClassRec.core_class.query_geometry;

	check_size("widgetClassRec.core_class.display_accelerator", "XtStringProc", sizeof(widgetClassRec.core_class.display_accelerator), sizeof(XtStringProc));
	myXtStringProc = widgetClassRec.core_class.display_accelerator;
	pmyXtStringProc = &widgetClassRec.core_class.display_accelerator;

	check_size("widgetClassRec.core_class.extension", "XtPointer", sizeof(widgetClassRec.core_class.extension), sizeof(XtPointer));
	myXtPointer = widgetClassRec.core_class.extension;
	pmyXtPointer = &widgetClassRec.core_class.extension;

	check_size("coreClassRec.core_class.superclass", "WidgetClass", sizeof(coreClassRec.core_class.superclass), sizeof(WidgetClass));
	myWidgetClass = coreClassRec.core_class.superclass;
	pmyWidgetClass = &coreClassRec.core_class.superclass;

	check_size("coreClassRec.core_class.class_name", "String", sizeof(coreClassRec.core_class.class_name), sizeof(String));
	myString = coreClassRec.core_class.class_name;
	pmyString = &coreClassRec.core_class.class_name;

	check_size("coreClassRec.core_class.widget_size", "Cardinal", sizeof(coreClassRec.core_class.widget_size), sizeof(Cardinal));
	myCardinal = coreClassRec.core_class.widget_size;
	pmyCardinal = &coreClassRec.core_class.widget_size;

	check_size("coreClassRec.core_class.class_initialize", "XtProc", sizeof(coreClassRec.core_class.class_initialize), sizeof(XtProc));
	myXtProc = coreClassRec.core_class.class_initialize;
	pmyXtProc = &coreClassRec.core_class.class_initialize;

	check_size("coreClassRec.core_class.class_part_initialize", "XtWidgetClassProc", sizeof(coreClassRec.core_class.class_part_initialize), sizeof(XtWidgetClassProc));
	myXtWidgetClassProc = coreClassRec.core_class.class_part_initialize;
	pmyXtWidgetClassProc = &coreClassRec.core_class.class_part_initialize;

	check_size("coreClassRec.core_class.class_inited", "XtEnum", sizeof(coreClassRec.core_class.class_inited), sizeof(XtEnum));
	myXtEnum = coreClassRec.core_class.class_inited;
	pmyXtEnum = &coreClassRec.core_class.class_inited;

	check_size("coreClassRec.core_class.initialize", "XtInitProc", sizeof(coreClassRec.core_class.initialize), sizeof(XtInitProc));
	myXtInitProc = coreClassRec.core_class.initialize;
	pmyXtInitProc = &coreClassRec.core_class.initialize;

	check_size("coreClassRec.core_class.initialize_hook", "XtArgsProc", sizeof(coreClassRec.core_class.initialize_hook), sizeof(XtArgsProc));
	myXtArgsProc = coreClassRec.core_class.initialize_hook;
	pmyXtArgsProc = &coreClassRec.core_class.initialize_hook;

	check_size("coreClassRec.core_class.realize", "XtRealizeProc", sizeof(coreClassRec.core_class.realize), sizeof(XtRealizeProc));
	myXtRealizeProc = coreClassRec.core_class.realize;
	pmyXtRealizeProc = &coreClassRec.core_class.realize;

	check_size("coreClassRec.core_class.actions", "XtActionList", sizeof(coreClassRec.core_class.actions), sizeof(XtActionList));
	myXtActionList = coreClassRec.core_class.actions;
	pmyXtActionList = &coreClassRec.core_class.actions;

	check_size("coreClassRec.core_class.num_actions", "Cardinal", sizeof(coreClassRec.core_class.num_actions), sizeof(Cardinal));
	myCardinal = coreClassRec.core_class.num_actions;
	pmyCardinal = &coreClassRec.core_class.num_actions;

	check_size("coreClassRec.core_class.resources", "XtResourceList", sizeof(coreClassRec.core_class.resources), sizeof(XtResourceList));
	myXtResourceList = coreClassRec.core_class.resources;
	pmyXtResourceList = &coreClassRec.core_class.resources;
	
	check_size("coreClassRec.core_class.num_resources", "Cardinal", sizeof(coreClassRec.core_class.num_resources), sizeof(Cardinal));
	myCardinal = coreClassRec.core_class.num_resources;
	pmyCardinal = &coreClassRec.core_class.num_resources;

	check_size("coreClassRec.core_class.xrm_class", "XrmClass", sizeof(coreClassRec.core_class.xrm_class), sizeof(XrmClass));
	myXrmClass = coreClassRec.core_class.xrm_class;
	pmyXrmClass = &coreClassRec.core_class.xrm_class;

	check_size("coreClassRec.core_class.compress_motion", "Boolean", sizeof(coreClassRec.core_class.compress_motion), sizeof(Boolean));
	myBoolean = coreClassRec.core_class.compress_motion;
	pmyBoolean = &coreClassRec.core_class.compress_motion;

	check_size("coreClassRec.core_class.compress_exposure", "XtEnum", sizeof(coreClassRec.core_class.compress_exposure), sizeof(XtEnum));
	myXtEnum = coreClassRec.core_class.compress_exposure;
	pmyXtEnum = &coreClassRec.core_class.compress_exposure;

	check_size("coreClassRec.core_class.compress_enterleave", "Boolean", sizeof(coreClassRec.core_class.compress_enterleave), sizeof(Boolean));
	myBoolean = coreClassRec.core_class.compress_enterleave;
	pmyBoolean = &coreClassRec.core_class.compress_enterleave;

	check_size("coreClassRec.core_class.visible_interest", "Boolean", sizeof(coreClassRec.core_class.visible_interest), sizeof(Boolean));
	myBoolean = coreClassRec.core_class.visible_interest;
	pmyBoolean = &coreClassRec.core_class.visible_interest;

	check_size("coreClassRec.core_class.destroy", "XtWidgetProc", sizeof(coreClassRec.core_class.destroy), sizeof(XtWidgetProc));
	myXtWidgetProc = coreClassRec.core_class.destroy;
	pmyXtWidgetProc = &coreClassRec.core_class.destroy;

	check_size("coreClassRec.core_class.resize", "XtWidgetProc", sizeof(coreClassRec.core_class.resize), sizeof(XtWidgetProc));
	myXtWidgetProc = coreClassRec.core_class.resize;
	pmyXtWidgetProc = &coreClassRec.core_class.resize;

	check_size("coreClassRec.core_class.expose", "XtExposeProc", sizeof(coreClassRec.core_class.expose), sizeof(XtExposeProc));
	myXtExposeProc = coreClassRec.core_class.expose;
	pmyXtExposeProc = &coreClassRec.core_class.expose;

	check_size("coreClassRec.core_class.set_values", "XtSetValuesFunc", sizeof(coreClassRec.core_class.set_values), sizeof(XtSetValuesFunc));
	myXtSetValuesFunc = coreClassRec.core_class.set_values;
	pmyXtSetValuesFunc = &coreClassRec.core_class.set_values;

	check_size("coreClassRec.core_class.set_values_hook", "XtArgsFunc", sizeof(coreClassRec.core_class.set_values_hook), sizeof(XtArgsFunc));
	myXtArgsFunc = coreClassRec.core_class.set_values_hook;
	pmyXtArgsFunc = &coreClassRec.core_class.set_values_hook;

	check_size("coreClassRec.core_class.set_values_almost", "XtAlmostProc", sizeof(coreClassRec.core_class.set_values_almost), sizeof(XtAlmostProc));
       myXtAlmostProc = coreClassRec.core_class.set_values_almost;
	pmyXtAlmostProc = &coreClassRec.core_class.set_values_almost;

	check_size("coreClassRec.core_class.get_values_hook", "XtArgsProc", sizeof(coreClassRec.core_class.get_values_hook), sizeof(XtArgsProc));
	myXtArgsProc = coreClassRec.core_class.get_values_hook;
	pmyXtArgsProc = &coreClassRec.core_class.get_values_hook;

	check_size("coreClassRec.core_class.accept_focus", "XtAcceptFocusProc", sizeof(coreClassRec.core_class.accept_focus), sizeof(XtAcceptFocusProc));
	myXtAcceptFocusProc = coreClassRec.core_class.accept_focus;
	pmyXtAcceptFocusProc = &coreClassRec.core_class.accept_focus;

	check_size("coreClassRec.core_class.version", "XtVersionType", sizeof(coreClassRec.core_class.version), sizeof(XtVersionType));
	myXtVersionType = coreClassRec.core_class.version;
	pmyXtVersionType = &coreClassRec.core_class.version;

	check_size("coreClassRec.core_class.callback_private", "XtPointer", sizeof(coreClassRec.core_class.callback_private), sizeof(XtPointer));
	myXtPointer = coreClassRec.core_class.callback_private;
	pmyXtPointer = &coreClassRec.core_class.callback_private;

	check_size("coreClassRec.core_class.tm_table", "String", sizeof(coreClassRec.core_class.tm_table), sizeof(String));
	myString = coreClassRec.core_class.tm_table;
	pmyString = &coreClassRec.core_class.tm_table;

	check_size("coreClassRec.core_class.query_geometry", "XtGeometryHandler", sizeof(coreClassRec.core_class.query_geometry), sizeof(XtGeometryHandler));
	myXtGeometryHandler = coreClassRec.core_class.query_geometry;
	pmyXtGeometryHandler = &coreClassRec.core_class.query_geometry;

	check_size("coreClassRec.core_class.display_accelerator", "XtStringProc", sizeof(coreClassRec.core_class.display_accelerator), sizeof(XtStringProc));
	myXtStringProc = coreClassRec.core_class.display_accelerator;
	pmyXtStringProc = &coreClassRec.core_class.display_accelerator;

	check_size("coreClassRec.core_class.extension", "XtPointer", sizeof(coreClassRec.core_class.extension), sizeof(XtPointer));
	myXtPointer = coreClassRec.core_class.extension;
	pmyXtPointer = &coreClassRec.core_class.extension;

	tet_infoline("TEST: coreClassRec = widgetClassRec");
	if (&coreClassRec != &widgetClassRec) {
		tet_infoline("ERROR: coreClassRec != widgetClassRec");
		tet_result(TET_FAIL);
	}

	tet_result(TET_PASS);
>>ASSERTION Good A
The class pointers for core widgets coreWidgetClass
and widgetClass shall exist and point to the
widgetClassRec class record.
>>CODE

	tet_infoline("TEST: widgetClass");
	if (widgetClass != &widgetClassRec) {
		sprintf(ebuf, "ERROR: widgetClass does not point to WidgetClassRec");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: coreWidgetClass");
	if (coreWidgetClass != &widgetClassRec) {
		sprintf(ebuf, "ERROR: widgetClass does not point to WidgetClassRec");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
>>ASSERTION Good A
The instance structure for core widgets CorePart
shall be defined and contain the fields listed in
section 3.4.1 of the Specification.
>>CODE
CorePart testStruct;

	/*check sizes and do some assignments which should cause compiler
	warnings if types are wrong*/

	check_size("CorePart.self", "Widget", sizeof(testStruct.self), sizeof(Widget));
	myWidget = testStruct.self;
	pmyWidget = &testStruct.self;

	check_size("CorePart.widget_class", "WidgetClass", sizeof(testStruct.widget_class), sizeof(WidgetClass));
	myWidgetClass = testStruct.widget_class;
	pmyWidgetClass = &testStruct.widget_class;

	check_size("CorePart.parent", "Widget", sizeof(testStruct.parent), sizeof(Widget));
	myWidget = testStruct.parent;
	pmyWidget = &testStruct.parent;

	check_size("CorePart.xrm_name", "XrmName", sizeof(testStruct.xrm_name), sizeof(XrmName));
	myXrmName = testStruct.xrm_name;
	pmyXrmName = &testStruct.xrm_name;

	check_size("CorePart.being_destroyed", "Boolean", sizeof(testStruct.being_destroyed), sizeof(Boolean));
	myBoolean = testStruct.being_destroyed;
	pmyBoolean = &testStruct.being_destroyed;

	check_size("CorePart.destroy_callbacks", "XtCallbackList", sizeof(testStruct.destroy_callbacks), sizeof(XtCallbackList));
	myXtCallbackList = testStruct.destroy_callbacks;
	pmyXtCallbackList = &testStruct.destroy_callbacks;

	check_size("CorePart.constraints", "XtPointer", sizeof(testStruct.constraints), sizeof(XtPointer));
	myXtPointer = testStruct.constraints;
	pmyXtPointer = &testStruct.constraints;

	check_size("CorePart.border_width", "Dimension", sizeof(testStruct.border_width), sizeof(Dimension));
	myDimension = testStruct.border_width;
	pmyDimension = &testStruct.border_width;

	check_size("CorePart.managed", "Boolean", sizeof(testStruct.managed), sizeof(Boolean));
	myBoolean = testStruct.managed;
	pmyBoolean = &testStruct.managed;

	check_size("CorePart.sensitive", "Boolean", sizeof(testStruct.sensitive), sizeof(Boolean));
	myBoolean = testStruct.sensitive;
	pmyBoolean = &testStruct.sensitive;

	check_size("CorePart.ancestor_sensitive", "Boolean", sizeof(testStruct.ancestor_sensitive), sizeof(Boolean));
	myBoolean = testStruct.ancestor_sensitive;
	pmyBoolean = &testStruct.ancestor_sensitive;

	check_size("CorePart.event_table", "XtEventTable", sizeof(testStruct.event_table), sizeof(XtEventTable));
	myXtEventTable = testStruct.event_table;
	pmyXtEventTable = &testStruct.event_table;

	check_size("CorePart.tm", "XtTMRec", sizeof(testStruct.tm), sizeof(XtTMRec));
	myXtTMRec = testStruct.tm;
	pmyXtTMRec = &testStruct.tm;

	check_size("CorePart.accelerators", "XtTranslations", sizeof(testStruct.accelerators), sizeof(XtTranslations));
	myXtTranslations = testStruct.accelerators;
	pmyXtTranslations = &testStruct.accelerators;

	check_size("CorePart.border_pixel", "Pixel", sizeof(testStruct.border_pixel), sizeof(Pixel));
	myPixel = testStruct.border_pixel;
	pmyPixel = &testStruct.border_pixel;

	check_size("CorePart.border_pixmap", "Pixmap", sizeof(testStruct.border_pixmap), sizeof(Pixmap));
	myPixmap = testStruct.border_pixmap;
	pmyPixmap = &testStruct.border_pixmap;

	check_size("CorePart.popup_list", "WidgetList", sizeof(testStruct.popup_list), sizeof(WidgetList));
	myWidgetList = testStruct.popup_list;
	pmyWidgetList = &testStruct.popup_list;

	check_size("CorePart.num_popups", "Cardinal", sizeof(testStruct.num_popups), sizeof(Cardinal));
	myCardinal = testStruct.num_popups;
	pmyCardinal = &testStruct.num_popups;

	check_size("CorePart.name", "String", sizeof(testStruct.name), sizeof(String));
	myString = testStruct.name;
	pmyString = &testStruct.name;

	check_size("CorePart.screen", "Screen *", sizeof(testStruct.screen), sizeof(Screen *));
	pmyScreen = testStruct.screen;

	check_size("CorePart.colormap", "Colormap", sizeof(testStruct.colormap), sizeof(Colormap));
	myColormap = testStruct.colormap;
	pmyColormap = &testStruct.colormap;

	check_size("CorePart.window", "Window", sizeof(testStruct.window), sizeof(Window));
	myWindow = testStruct.window;
	pmyWindow = &testStruct.window;

	check_size("CorePart.depth", "Cardinal", sizeof(testStruct.depth), sizeof(Cardinal));
	myCardinal = testStruct.depth;
	pmyCardinal = &testStruct.depth;

	check_size("CorePart.background_pixel", "Pixel", sizeof(testStruct.background_pixel), sizeof(Pixel));
	myPixel = testStruct.background_pixel;
	pmyPixel = &testStruct.background_pixel;

	check_size("CorePart.background_pixmap", "Pixmap", sizeof(testStruct.background_pixmap), sizeof(Pixmap));
	myPixmap = testStruct.background_pixmap;
	pmyPixmap = &testStruct.background_pixmap;

	check_size("CorePart.visible", "Boolean", sizeof(testStruct.visible), sizeof(Boolean));
	myBoolean = testStruct.visible;
	pmyBoolean = &testStruct.visible;

	check_size("CorePart.mapped_when_managed", "Boolean", sizeof(testStruct.mapped_when_managed), sizeof(Boolean));
	myBoolean = testStruct.mapped_when_managed;
	pmyBoolean = &testStruct.mapped_when_managed;

	tet_result(TET_PASS);
>>ASSERTION Good A
The instance record structure for core widgets WidgetRec/CoreRec
shall be defined and contain the fields listed in
section 3.4.1 of the Specification.
>>CODE
CoreRec testStruct;
WidgetRec testStruct2;

	/*check sizes and do some assignments which should cause compiler
	warnings if types are wrong*/

	check_size("CoreRec.core.self", "Widget", sizeof(testStruct.core.self), sizeof(Widget));
	myWidget = testStruct.core.self;
	pmyWidget = &testStruct.core.self;

	check_size("CoreRec.core.widget_class", "WidgetClass", sizeof(testStruct.core.widget_class), sizeof(WidgetClass));
	myWidgetClass = testStruct.core.widget_class;
	pmyWidgetClass = &testStruct.core.widget_class;

	check_size("CoreRec.core.parent", "Widget", sizeof(testStruct.core.parent), sizeof(Widget));
	myWidget = testStruct.core.parent;
	pmyWidget = &testStruct.core.parent;

	check_size("CoreRec.core.xrm_name", "XrmName", sizeof(testStruct.core.xrm_name), sizeof(XrmName));
	myXrmName = testStruct.core.xrm_name;
	pmyXrmName = &testStruct.core.xrm_name;

	check_size("CoreRec.core.being_destroyed", "Boolean", sizeof(testStruct.core.being_destroyed), sizeof(Boolean));
	myBoolean = testStruct.core.being_destroyed;
	pmyBoolean = &testStruct.core.being_destroyed;

	check_size("CoreRec.core.destroy_callbacks", "XtCallbackList", sizeof(testStruct.core.destroy_callbacks), sizeof(XtCallbackList));
	myXtCallbackList = testStruct.core.destroy_callbacks;
	pmyXtCallbackList = &testStruct.core.destroy_callbacks;

	check_size("CoreRec.core.constraints", "XtPointer", sizeof(testStruct.core.constraints), sizeof(XtPointer));
	myXtPointer = testStruct.core.constraints;
	pmyXtPointer = &testStruct.core.constraints;

	check_size("CoreRec.core.border_width", "Dimension", sizeof(testStruct.core.border_width), sizeof(Dimension));
	myDimension = testStruct.core.border_width;
	pmyDimension = &testStruct.core.border_width;

	check_size("CoreRec.core.managed", "Boolean", sizeof(testStruct.core.managed), sizeof(Boolean));
	myBoolean = testStruct.core.managed;
	pmyBoolean = &testStruct.core.managed;

	check_size("CoreRec.core.sensitive", "Boolean", sizeof(testStruct.core.sensitive), sizeof(Boolean));
	myBoolean = testStruct.core.sensitive;
	pmyBoolean = &testStruct.core.sensitive;

	check_size("CoreRec.core.ancestor_sensitive", "Boolean", sizeof(testStruct.core.ancestor_sensitive), sizeof(Boolean));
	myBoolean = testStruct.core.ancestor_sensitive;
	pmyBoolean = &testStruct.core.ancestor_sensitive;

	check_size("CoreRec.core.event_table", "XtEventTable", sizeof(testStruct.core.event_table), sizeof(XtEventTable));
	myXtEventTable = testStruct.core.event_table;
	pmyXtEventTable = &testStruct.core.event_table;

	check_size("CoreRec.core.tm", "XtTMRec", sizeof(testStruct.core.tm), sizeof(XtTMRec));
	myXtTMRec = testStruct.core.tm;
	pmyXtTMRec = &testStruct.core.tm;

	check_size("CoreRec.core.accelerators", "XtTranslations", sizeof(testStruct.core.accelerators), sizeof(XtTranslations));
	myXtTranslations = testStruct.core.accelerators;
	pmyXtTranslations = &testStruct.core.accelerators;

	check_size("CoreRec.core.border_pixel", "Pixel", sizeof(testStruct.core.border_pixel), sizeof(Pixel));
	myPixel = testStruct.core.border_pixel;
	pmyPixel = &testStruct.core.border_pixel;

	check_size("CoreRec.core.border_pixmap", "Pixmap", sizeof(testStruct.core.border_pixmap), sizeof(Pixmap));
	myPixmap = testStruct.core.border_pixmap;
	pmyPixmap = &testStruct.core.border_pixmap;

	check_size("CoreRec.core.popup_list", "WidgetList", sizeof(testStruct.core.popup_list), sizeof(WidgetList));
	myWidgetList = testStruct.core.popup_list;
	pmyWidgetList = &testStruct.core.popup_list;

	check_size("CoreRec.core.num_popups", "Cardinal", sizeof(testStruct.core.num_popups), sizeof(Cardinal));
	myCardinal = testStruct.core.num_popups;
	pmyCardinal = &testStruct.core.num_popups;

	check_size("CoreRec.core.name", "String", sizeof(testStruct.core.name), sizeof(String));
	myString = testStruct.core.name;
	pmyString = &testStruct.core.name;

	check_size("CoreRec.core.screen", "Screen *", sizeof(testStruct.core.screen), sizeof(Screen *));
	pmyScreen = testStruct.core.screen;

	check_size("CoreRec.core.colormap", "Colormap", sizeof(testStruct.core.colormap), sizeof(Colormap));
	myColormap = testStruct.core.colormap;
	pmyColormap = &testStruct.core.colormap;

	check_size("CoreRec.core.window", "Window", sizeof(testStruct.core.window), sizeof(Window));
	myWindow = testStruct.core.window;
	pmyWindow = &testStruct.core.window;

	check_size("CoreRec.core.depth", "Cardinal", sizeof(testStruct.core.depth), sizeof(Cardinal));
	myCardinal = testStruct.core.depth;
	pmyCardinal = &testStruct.core.depth;

	check_size("CoreRec.core.background_pixel", "Pixel", sizeof(testStruct.core.background_pixel), sizeof(Pixel));
	myPixel = testStruct.core.background_pixel;
	pmyPixel = &testStruct.core.background_pixel;

	check_size("CoreRec.core.background_pixmap", "Pixmap", sizeof(testStruct.core.background_pixmap), sizeof(Pixmap));
	myPixmap = testStruct.core.background_pixmap;
	pmyPixmap = &testStruct.core.background_pixmap;

	check_size("CoreRec.core.visible", "Boolean", sizeof(testStruct.core.visible), sizeof(Boolean));
	myBoolean = testStruct.core.visible;
	pmyBoolean = &testStruct.core.visible;

	check_size("CoreRec.core.mapped_when_managed", "Boolean", sizeof(testStruct.core.mapped_when_managed), sizeof(Boolean));
	myBoolean = testStruct.core.mapped_when_managed;
	pmyBoolean = &testStruct.core.mapped_when_managed;

	check_size("WidgetRec.core.self", "Widget", sizeof(testStruct2.core.self), sizeof(Widget));
	myWidget = testStruct2.core.self;
	pmyWidget = &testStruct2.core.self;

	check_size("WidgetRec.core.widget_class", "WidgetClass", sizeof(testStruct2.core.widget_class), sizeof(WidgetClass));
	myWidgetClass = testStruct2.core.widget_class;
	pmyWidgetClass = &testStruct2.core.widget_class;

	check_size("WidgetRec.core.parent", "Widget", sizeof(testStruct2.core.parent), sizeof(Widget));
	myWidget = testStruct2.core.parent;
	pmyWidget = &testStruct2.core.parent;

	check_size("WidgetRec.core.xrm_name", "XrmName", sizeof(testStruct2.core.xrm_name), sizeof(XrmName));
	myXrmName = testStruct2.core.xrm_name;
	pmyXrmName = &testStruct2.core.xrm_name;

	check_size("WidgetRec.core.being_destroyed", "Boolean", sizeof(testStruct2.core.being_destroyed), sizeof(Boolean));
	myBoolean = testStruct2.core.being_destroyed;
	pmyBoolean = &testStruct2.core.being_destroyed;

	check_size("WidgetRec.core.destroy_callbacks", "XtCallbackList", sizeof(testStruct2.core.destroy_callbacks), sizeof(XtCallbackList));
	myXtCallbackList = testStruct2.core.destroy_callbacks;
	pmyXtCallbackList = &testStruct2.core.destroy_callbacks;

	check_size("WidgetRec.core.constraints", "XtPointer", sizeof(testStruct2.core.constraints), sizeof(XtPointer));
	myXtPointer = testStruct2.core.constraints;
	pmyXtPointer = &testStruct2.core.constraints;

	check_size("WidgetRec.core.border_width", "Dimension", sizeof(testStruct2.core.border_width), sizeof(Dimension));
	myDimension = testStruct2.core.border_width;
	pmyDimension = &testStruct2.core.border_width;

	check_size("WidgetRec.core.managed", "Boolean", sizeof(testStruct2.core.managed), sizeof(Boolean));
	myBoolean = testStruct2.core.managed;
	pmyBoolean = &testStruct2.core.managed;

	check_size("WidgetRec.core.sensitive", "Boolean", sizeof(testStruct2.core.sensitive), sizeof(Boolean));
	myBoolean = testStruct2.core.sensitive;
	pmyBoolean = &testStruct2.core.sensitive;

	check_size("WidgetRec.core.ancestor_sensitive", "Boolean", sizeof(testStruct2.core.ancestor_sensitive), sizeof(Boolean));
	myBoolean = testStruct2.core.ancestor_sensitive;
	pmyBoolean = &testStruct2.core.ancestor_sensitive;

	check_size("WidgetRec.core.event_table", "XtEventTable", sizeof(testStruct2.core.event_table), sizeof(XtEventTable));
	myXtEventTable = testStruct2.core.event_table;
	pmyXtEventTable = &testStruct2.core.event_table;

	check_size("WidgetRec.core.tm", "XtTMRec", sizeof(testStruct2.core.tm), sizeof(XtTMRec));
	myXtTMRec = testStruct2.core.tm;
	pmyXtTMRec = &testStruct2.core.tm;

	check_size("WidgetRec.core.accelerators", "XtTranslations", sizeof(testStruct2.core.accelerators), sizeof(XtTranslations));
	myXtTranslations = testStruct2.core.accelerators;
	pmyXtTranslations = &testStruct2.core.accelerators;

	check_size("WidgetRec.core.border_pixel", "Pixel", sizeof(testStruct2.core.border_pixel), sizeof(Pixel));
	myPixel = testStruct2.core.border_pixel;
	pmyPixel = &testStruct2.core.border_pixel;

	check_size("WidgetRec.core.border_pixmap", "Pixmap", sizeof(testStruct2.core.border_pixmap), sizeof(Pixmap));
	myPixmap = testStruct2.core.border_pixmap;
	pmyPixmap = &testStruct2.core.border_pixmap;

	check_size("WidgetRec.core.popup_list", "WidgetList", sizeof(testStruct2.core.popup_list), sizeof(WidgetList));
	myWidgetList = testStruct2.core.popup_list;
	pmyWidgetList = &testStruct2.core.popup_list;

	check_size("WidgetRec.core.num_popups", "Cardinal", sizeof(testStruct2.core.num_popups), sizeof(Cardinal));
	myCardinal = testStruct2.core.num_popups;
	pmyCardinal = &testStruct2.core.num_popups;

	check_size("WidgetRec.core.name", "String", sizeof(testStruct2.core.name), sizeof(String));
	myString = testStruct2.core.name;
	pmyString = &testStruct2.core.name;

	check_size("WidgetRec.core.screen", "Screen *", sizeof(testStruct2.core.screen), sizeof(Screen *));
	pmyScreen = testStruct2.core.screen;

	check_size("WidgetRec.core.colormap", "Colormap", sizeof(testStruct2.core.colormap), sizeof(Colormap));
	myColormap = testStruct2.core.colormap;
	pmyColormap = &testStruct2.core.colormap;

	check_size("WidgetRec.core.window", "Window", sizeof(testStruct2.core.window), sizeof(Window));
	myWindow = testStruct2.core.window;
	pmyWindow = &testStruct2.core.window;

	check_size("WidgetRec.core.depth", "Cardinal", sizeof(testStruct2.core.depth), sizeof(Cardinal));
	myCardinal = testStruct2.core.depth;
	pmyCardinal = &testStruct2.core.depth;

	check_size("WidgetRec.core.background_pixel", "Pixel", sizeof(testStruct2.core.background_pixel), sizeof(Pixel));
	myPixel = testStruct2.core.background_pixel;
	pmyPixel = &testStruct2.core.background_pixel;

	check_size("WidgetRec.core.background_pixmap", "Pixmap", sizeof(testStruct2.core.background_pixmap), sizeof(Pixmap));
	myPixmap = testStruct2.core.background_pixmap;
	pmyPixmap = &testStruct2.core.background_pixmap;

	check_size("WidgetRec.core.visible", "Boolean", sizeof(testStruct2.core.visible), sizeof(Boolean));
	myBoolean = testStruct2.core.visible;
	pmyBoolean = &testStruct2.core.visible;

	check_size("WidgetRec.core.mapped_when_managed", "Boolean", sizeof(testStruct2.core.mapped_when_managed), sizeof(Boolean));
	myBoolean = testStruct2.core.mapped_when_managed;
	pmyBoolean = &testStruct2.core.mapped_when_managed;

	tet_result(TET_PASS);
>>ASSERTION Good A
The types Widget and CoreWidget shall be defined as a
pointers to a core widget instance.
>>CODE
WidgetRec	testwid;
Widget testvar;
Widget testvar2;
CoreWidget testvar3;

	/* this will not build if the define is not correct*/
	tet_infoline("TEST: Widget");
	/*doesn't matter where we point, just testing syntax*/
	testvar = &testwid;
	testvar2 = testvar->core.self;
	tet_infoline("TEST: CoreWidget");
	/*doesn't matter where we point, just testing syntax*/
	testvar3 = &testwid;
	testvar2 = testvar->core.self;
	tet_result(TET_PASS);
>>ASSERTION Good A
CoreRec shall be initialized to the default values
specified in section 3.4.1 of the
Specification on creation of a new widget instance.
>>CODE
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

	avs_xt_hier("HCore9", "XtCore");
	tet_infoline("PREP: Create fresh widget");
	testwidget = XtCreateWidget("ApTest", coreWidgetClass, topLevel, NULL, 0);
	tet_infoline("TEST: core.self");
	if (testwidget->core.self != testwidget) {
		tet_infoline("ERROR: self member is not address of widget structure");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: core.widget_class");
	if (testwidget->core.widget_class != coreWidgetClass) {
		tet_infoline("ERROR: widget_class member is not coreWidgetClass");
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
	status = XtConvertAndStore(testwidget, XtRString, &fromVal, XtRPixel, &toVal); 
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
	status = XtConvertAndStore(testwidget, XtRString, &fromVal, XtRPixel, &toVal); 
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
	tet_result(TET_PASS);
