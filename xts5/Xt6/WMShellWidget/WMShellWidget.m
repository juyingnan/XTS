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
$Header: /cvs/xtest/xtest/xts5/tset/Xt6/WMShellWidget/WMShellWidget.m,v 1.1 2005-02-12 14:38:14 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt6/WMShellWidget/WMShellWidget.m
>># 
>># Description:
>>#	Tests for WMShell Widgets
>># 
>># Modifications:
>># $Log: wdgtwmshll.m,v $
>># Revision 1.1  2005-02-12 14:38:14  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:36:41  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:59:33  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:27:49  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:23  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.1  1997/01/22 22:38:35  andy
>># Removed use of Athena widgets
>>#
>># Revision 4.0  1995/12/15  09:16:54  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:20:58  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>
#include <X11/ShellP.h>
#include <X11/Xatom.h>

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
char                  	*pmychar, **ppmychar;
int                  	myint, *pmyint;
long                  	mylong, *pmylong;
Atom			myAtom, *pmyAtom;
XWMHints		myXWMHints, *pmyXWMHints;
XtGrabKind		myXtGrabKind, *pmyXtGrabKind;
XtOrderProc		myXtOrderProc, *pmyXtOrderProc;
XtCreatePopupChildProc	myXtCreatePopupChildProc, *pmyXtCreatePopupChildProc;
Visual			*pmyVisual;
extern void xt_whandler();
>>TITLE WMShellWidget Xt6
>>ASSERTION Good A
The class structure for shell widgets WMShellClassPart
shall be defined and contain the fields listed in
section 6.1 of the Specification.
>>CODE
WMShellClassPart testStruct;

	check_size("WMShellClassPart.extension", "XtPointer", sizeof(testStruct.extension), sizeof(XtPointer));
	myXtPointer = testStruct.extension;
	pmyXtPointer = &testStruct.extension;

	tet_result(TET_PASS);
>>ASSERTION Good A
The class record structure for shell widgets
WMShellClassRec shall be defined and contain the
fields listed in section 6.1 of the Specification.
>>CODE
WMShellClassRec testStruct;

	check_size("WMShellClassRec.core_class.superclass", "WidgetClass", sizeof(testStruct.core_class.superclass), sizeof(WidgetClass));
	myWidgetClass = testStruct.core_class.superclass;
	pmyWidgetClass = &testStruct.core_class.superclass;

	check_size("WMShellClassRec.core_class.class_name", "String", sizeof(testStruct.core_class.class_name), sizeof(String));
	myString = testStruct.core_class.class_name;
	pmyString = &testStruct.core_class.class_name;

	check_size("WMShellClassRec.core_class.widget_size", "Cardinal", sizeof(testStruct.core_class.widget_size), sizeof(Cardinal));
	myCardinal = testStruct.core_class.widget_size;
	pmyCardinal = &testStruct.core_class.widget_size;

	check_size("WMShellClassRec.core_class.class_initialize", "XtProc", sizeof(testStruct.core_class.class_initialize), sizeof(XtProc));
	myXtProc = testStruct.core_class.class_initialize;
	pmyXtProc = &testStruct.core_class.class_initialize;

	check_size("WMShellClassRec.core_class.class_part_initialize", "XtWidgetClassProc", sizeof(testStruct.core_class.class_part_initialize), sizeof(XtWidgetClassProc));
	myXtWidgetClassProc = testStruct.core_class.class_part_initialize;
	pmyXtWidgetClassProc = &testStruct.core_class.class_part_initialize;

	check_size("WMShellClassRec.core_class.class_inited", "XtEnum", sizeof(testStruct.core_class.class_inited), sizeof(XtEnum));
	myXtEnum = testStruct.core_class.class_inited;
	pmyXtEnum = &testStruct.core_class.class_inited;

	check_size("WMShellClassRec.core_class.initialize", "XtInitProc", sizeof(testStruct.core_class.initialize), sizeof(XtInitProc));
	myXtInitProc = testStruct.core_class.initialize;
	pmyXtInitProc = &testStruct.core_class.initialize;

	check_size("WMShellClassRec.core_class.initialize_hook", "XtArgsProc", sizeof(testStruct.core_class.initialize_hook), sizeof(XtArgsProc));
	myXtArgsProc = testStruct.core_class.initialize_hook;
	pmyXtArgsProc = &testStruct.core_class.initialize_hook;

	check_size("WMShellClassRec.core_class.realize", "XtRealizeProc", sizeof(testStruct.core_class.realize), sizeof(XtRealizeProc));
	myXtRealizeProc = testStruct.core_class.realize;
	pmyXtRealizeProc = &testStruct.core_class.realize;

	check_size("WMShellClassRec.core_class.actions", "XtActionList", sizeof(testStruct.core_class.actions), sizeof(XtActionList));
	myXtActionList = testStruct.core_class.actions;
	pmyXtActionList = &testStruct.core_class.actions;

	check_size("WMShellClassRec.core_class.num_actions", "Cardinal", sizeof(testStruct.core_class.num_actions), sizeof(Cardinal));
	myCardinal = testStruct.core_class.num_actions;
	pmyCardinal = &testStruct.core_class.num_actions;

	check_size("WMShellClassRec.core_class.resources", "XtResourceList", sizeof(testStruct.core_class.resources), sizeof(XtResourceList));
	myXtResourceList = testStruct.core_class.resources;
	pmyXtResourceList = &testStruct.core_class.resources;

	check_size("WMShellClassRec.core_class.num_resources", "Cardinal", sizeof(testStruct.core_class.num_resources), sizeof(Cardinal));
	myCardinal = testStruct.core_class.num_resources;
	pmyCardinal = &testStruct.core_class.num_resources;

	check_size("WMShellClassRec.core_class.xrm_class", "XrmClass", sizeof(testStruct.core_class.xrm_class), sizeof(XrmClass));
	myXrmClass = testStruct.core_class.xrm_class;
	pmyXrmClass = &testStruct.core_class.xrm_class;

	check_size("WMShellClassRec.core_class.compress_motion", "Boolean", sizeof(testStruct.core_class.compress_motion), sizeof(Boolean));
	myBoolean = testStruct.core_class.compress_motion;
	pmyBoolean = &testStruct.core_class.compress_motion;

	check_size("WMShellClassRec.core_class.compress_exposure", "XtEnum", sizeof(testStruct.core_class.compress_exposure), sizeof(XtEnum));
	myXtEnum = testStruct.core_class.compress_exposure;
	pmyXtEnum = &testStruct.core_class.compress_exposure;

	check_size("WMShellClassRec.core_class.compress_enterleave", "Boolean", sizeof(testStruct.core_class.compress_enterleave), sizeof(Boolean));
	myBoolean = testStruct.core_class.compress_enterleave;
	pmyBoolean = &testStruct.core_class.compress_enterleave;

	check_size("WMShellClassRec.core_class.visible_interest", "Boolean", sizeof(testStruct.core_class.visible_interest), sizeof(Boolean));
	myBoolean = testStruct.core_class.visible_interest;
	pmyBoolean = &testStruct.core_class.visible_interest;

	check_size("WMShellClassRec.core_class.destroy", "XtWidgetProc", sizeof(testStruct.core_class.destroy), sizeof(XtWidgetProc));
	myXtWidgetProc = testStruct.core_class.destroy;
	pmyXtWidgetProc = &testStruct.core_class.destroy;

	check_size("WMShellClassRec.core_class.resize", "XtWidgetProc", sizeof(testStruct.core_class.resize), sizeof(XtWidgetProc));
	myXtWidgetProc = testStruct.core_class.resize;
	pmyXtWidgetProc = &testStruct.core_class.resize;

	check_size("WMShellClassRec.core_class.expose", "XtExposeProc", sizeof(testStruct.core_class.expose), sizeof(XtExposeProc));
	myXtExposeProc = testStruct.core_class.expose;
	pmyXtExposeProc = &testStruct.core_class.expose;

	check_size("WMShellClassRec.core_class.set_values", "XtSetValuesFunc", sizeof(testStruct.core_class.set_values), sizeof(XtSetValuesFunc));
	myXtSetValuesFunc = testStruct.core_class.set_values;
	pmyXtSetValuesFunc = &testStruct.core_class.set_values;

	check_size("WMShellClassRec.core_class.set_values_hook", "XtArgsFunc", sizeof(testStruct.core_class.set_values_hook), sizeof(XtArgsFunc));
	myXtArgsFunc = testStruct.core_class.set_values_hook;
	pmyXtArgsFunc = &testStruct.core_class.set_values_hook;

	check_size("WMShellClassRec.core_class.set_values_almost", "XtAlmostProc", sizeof(testStruct.core_class.set_values_almost), sizeof(XtAlmostProc));
	myXtAlmostProc = testStruct.core_class.set_values_almost;
	pmyXtAlmostProc = &testStruct.core_class.set_values_almost;

	check_size("WMShellClassRec.core_class.get_values_hook", "XtArgsProc", sizeof(testStruct.core_class.get_values_hook), sizeof(XtArgsProc));
	myXtArgsProc = testStruct.core_class.get_values_hook;
	pmyXtArgsProc = &testStruct.core_class.get_values_hook;

	check_size("WMShellClassRec.core_class.accept_focus", "XtAcceptFocusProc", sizeof(testStruct.core_class.accept_focus), sizeof(XtAcceptFocusProc));
	myXtAcceptFocusProc = testStruct.core_class.accept_focus;
	pmyXtAcceptFocusProc = &testStruct.core_class.accept_focus;

	check_size("WMShellClassRec.core_class.version", "XtVersionType", sizeof(testStruct.core_class.version), sizeof(XtVersionType));
	myXtVersionType = testStruct.core_class.version;
	pmyXtVersionType = &testStruct.core_class.version;

	check_size("WMShellClassRec.core_class.callback_private", "XtPointer", sizeof(testStruct.core_class.callback_private), sizeof(XtPointer));
	myXtPointer = testStruct.core_class.callback_private;
	pmyXtPointer = &testStruct.core_class.callback_private;

	check_size("WMShellClassRec.core_class.tm_table", "String", sizeof(testStruct.core_class.tm_table), sizeof(String));
	myString = testStruct.core_class.tm_table;
	pmyString = &testStruct.core_class.tm_table;

	check_size("WMShellClassRec.core_class.query_geometry", "XtGeometryHandler", sizeof(testStruct.core_class.query_geometry), sizeof(XtGeometryHandler));
	myXtGeometryHandler = testStruct.core_class.query_geometry;
	pmyXtGeometryHandler = &testStruct.core_class.query_geometry;

	check_size("WMShellClassRec.core_class.display_accelerator", "XtStringProc", sizeof(testStruct.core_class.display_accelerator), sizeof(XtStringProc));
	myXtStringProc = testStruct.core_class.display_accelerator;
	pmyXtStringProc = &testStruct.core_class.display_accelerator;

	check_size("WMShellClassRec.core_class.extension", "XtPointer", sizeof(testStruct.core_class.extension), sizeof(XtPointer));
	myXtPointer = testStruct.core_class.extension;
	pmyXtPointer = &testStruct.core_class.extension;

	check_size("WMShellClassRec.composite_class.geometry_manager", "XtGeometryHandler", sizeof(testStruct.composite_class.geometry_manager), sizeof(XtGeometryHandler));
	myXtGeometryHandler = testStruct.composite_class.geometry_manager;
	pmyXtGeometryHandler = &testStruct.composite_class.geometry_manager;

	check_size("WMShellClassRec.composite_class.change_managed", "XtWidgetProc", sizeof(testStruct.composite_class.change_managed), sizeof(XtWidgetProc));
	myXtWidgetProc = testStruct.composite_class.change_managed;
	pmyXtWidgetProc = &testStruct.composite_class.change_managed;

	check_size("WMShellClassRec.composite_class.insert_child", "XtWidgetProc", sizeof(testStruct.composite_class.insert_child), sizeof(XtWidgetProc));
	myXtWidgetProc = testStruct.composite_class.insert_child;
	pmyXtWidgetProc = &testStruct.composite_class.insert_child;

	check_size("WMShellClassRec.composite_class.delete_child", "XtWidgetProc", sizeof(testStruct.composite_class.delete_child), sizeof(XtWidgetProc));
	myXtWidgetProc = testStruct.composite_class.delete_child;
	pmyXtWidgetProc = &testStruct.composite_class.delete_child;

	check_size("WMShellClassRec.composite_class.extension", "XtPointer", sizeof(testStruct.composite_class.extension), sizeof(XtPointer));
	myXtPointer = testStruct.composite_class.extension;
	pmyXtPointer = &testStruct.composite_class.extension;

	check_size("WMShellClassRec.shell_class.extension", "XtPointer", sizeof(testStruct.shell_class.extension), sizeof(XtPointer));
	myXtPointer = testStruct.shell_class.extension;
	pmyXtPointer = &testStruct.shell_class.extension;

	check_size("WMShellClassRec.wm_shell_class.extension", "XtPointer", sizeof(testStruct.wm_shell_class.extension), sizeof(XtPointer));
	myXtPointer = testStruct.wm_shell_class.extension;
	pmyXtPointer = &testStruct.wm_shell_class.extension;

	tet_result(TET_PASS);
>>ASSERTION Good A
The class record for shell widgets wmShellClassRec
shall exist and be an instance of the WMShellClassRec
structure.
>>CODE

	check_size("wmShellClassRec.core_class.superclass", "WidgetClass", sizeof(wmShellClassRec.core_class.superclass), sizeof(WidgetClass));
	myWidgetClass = wmShellClassRec.core_class.superclass;
	pmyWidgetClass = &wmShellClassRec.core_class.superclass;

	check_size("wmShellClassRec.core_class.class_name", "String", sizeof(wmShellClassRec.core_class.class_name), sizeof(String));
	myString = wmShellClassRec.core_class.class_name;
	pmyString = &wmShellClassRec.core_class.class_name;

	check_size("wmShellClassRec.core_class.widget_size", "Cardinal", sizeof(wmShellClassRec.core_class.widget_size), sizeof(Cardinal));
	myCardinal = wmShellClassRec.core_class.widget_size;
	pmyCardinal = &wmShellClassRec.core_class.widget_size;

	check_size("wmShellClassRec.core_class.class_initialize", "XtProc", sizeof(wmShellClassRec.core_class.class_initialize), sizeof(XtProc));
	myXtProc = wmShellClassRec.core_class.class_initialize;
	pmyXtProc = &wmShellClassRec.core_class.class_initialize;

	check_size("wmShellClassRec.core_class.class_part_initialize", "XtWidgetClassProc", sizeof(wmShellClassRec.core_class.class_part_initialize), sizeof(XtWidgetClassProc));
	myXtWidgetClassProc = wmShellClassRec.core_class.class_part_initialize;
	pmyXtWidgetClassProc = &wmShellClassRec.core_class.class_part_initialize;

	check_size("wmShellClassRec.core_class.class_inited", "XtEnum", sizeof(wmShellClassRec.core_class.class_inited), sizeof(XtEnum));
	myXtEnum = wmShellClassRec.core_class.class_inited;
	pmyXtEnum = &wmShellClassRec.core_class.class_inited;

	check_size("wmShellClassRec.core_class.initialize", "XtInitProc", sizeof(wmShellClassRec.core_class.initialize), sizeof(XtInitProc));
	myXtInitProc = wmShellClassRec.core_class.initialize;
	pmyXtInitProc = &wmShellClassRec.core_class.initialize;

	check_size("wmShellClassRec.core_class.initialize_hook", "XtArgsProc", sizeof(wmShellClassRec.core_class.initialize_hook), sizeof(XtArgsProc));
	myXtArgsProc = wmShellClassRec.core_class.initialize_hook;
	pmyXtArgsProc = &wmShellClassRec.core_class.initialize_hook;

	check_size("wmShellClassRec.core_class.realize", "XtRealizeProc", sizeof(wmShellClassRec.core_class.realize), sizeof(XtRealizeProc));
	myXtRealizeProc = wmShellClassRec.core_class.realize;
	pmyXtRealizeProc = &wmShellClassRec.core_class.realize;

	check_size("wmShellClassRec.core_class.actions", "XtActionList", sizeof(wmShellClassRec.core_class.actions), sizeof(XtActionList));
	myXtActionList = wmShellClassRec.core_class.actions;
	pmyXtActionList = &wmShellClassRec.core_class.actions;

	check_size("wmShellClassRec.core_class.num_actions", "Cardinal", sizeof(wmShellClassRec.core_class.num_actions), sizeof(Cardinal));
	myCardinal = wmShellClassRec.core_class.num_actions;
	pmyCardinal = &wmShellClassRec.core_class.num_actions;

	check_size("wmShellClassRec.core_class.resources", "XtResourceList", sizeof(wmShellClassRec.core_class.resources), sizeof(XtResourceList));
	myXtResourceList = wmShellClassRec.core_class.resources;
	pmyXtResourceList = &wmShellClassRec.core_class.resources;

	check_size("wmShellClassRec.core_class.num_resources", "Cardinal", sizeof(wmShellClassRec.core_class.num_resources), sizeof(Cardinal));
	myCardinal = wmShellClassRec.core_class.num_resources;
	pmyCardinal = &wmShellClassRec.core_class.num_resources;

	check_size("wmShellClassRec.core_class.xrm_class", "XrmClass", sizeof(wmShellClassRec.core_class.xrm_class), sizeof(XrmClass));
	myXrmClass = wmShellClassRec.core_class.xrm_class;
	pmyXrmClass = &wmShellClassRec.core_class.xrm_class;

	check_size("wmShellClassRec.core_class.compress_motion", "Boolean", sizeof(wmShellClassRec.core_class.compress_motion), sizeof(Boolean));
	myBoolean = wmShellClassRec.core_class.compress_motion;
	pmyBoolean = &wmShellClassRec.core_class.compress_motion;

	check_size("wmShellClassRec.core_class.compress_exposure", "XtEnum", sizeof(wmShellClassRec.core_class.compress_exposure), sizeof(XtEnum));
	myXtEnum = wmShellClassRec.core_class.compress_exposure;
	pmyXtEnum = &wmShellClassRec.core_class.compress_exposure;

	check_size("wmShellClassRec.core_class.compress_enterleave", "Boolean", sizeof(wmShellClassRec.core_class.compress_enterleave), sizeof(Boolean));
	myBoolean = wmShellClassRec.core_class.compress_enterleave;
	pmyBoolean = &wmShellClassRec.core_class.compress_enterleave;

	check_size("wmShellClassRec.core_class.visible_interest", "Boolean", sizeof(wmShellClassRec.core_class.visible_interest), sizeof(Boolean));
	myBoolean = wmShellClassRec.core_class.visible_interest;
	pmyBoolean = &wmShellClassRec.core_class.visible_interest;

	check_size("wmShellClassRec.core_class.destroy", "XtWidgetProc", sizeof(wmShellClassRec.core_class.destroy), sizeof(XtWidgetProc));
	myXtWidgetProc = wmShellClassRec.core_class.destroy;
	pmyXtWidgetProc = &wmShellClassRec.core_class.destroy;

	check_size("wmShellClassRec.core_class.resize", "XtWidgetProc", sizeof(wmShellClassRec.core_class.resize), sizeof(XtWidgetProc));
	myXtWidgetProc = wmShellClassRec.core_class.resize;
	pmyXtWidgetProc = &wmShellClassRec.core_class.resize;

	check_size("wmShellClassRec.core_class.expose", "XtExposeProc", sizeof(wmShellClassRec.core_class.expose), sizeof(XtExposeProc));
	myXtExposeProc = wmShellClassRec.core_class.expose;
	pmyXtExposeProc = &wmShellClassRec.core_class.expose;

	check_size("wmShellClassRec.core_class.set_values", "XtSetValuesFunc", sizeof(wmShellClassRec.core_class.set_values), sizeof(XtSetValuesFunc));
	myXtSetValuesFunc = wmShellClassRec.core_class.set_values;
	pmyXtSetValuesFunc = &wmShellClassRec.core_class.set_values;

	check_size("wmShellClassRec.core_class.set_values_hook", "XtArgsFunc", sizeof(wmShellClassRec.core_class.set_values_hook), sizeof(XtArgsFunc));
	myXtArgsFunc = wmShellClassRec.core_class.set_values_hook;
	pmyXtArgsFunc = &wmShellClassRec.core_class.set_values_hook;

	check_size("wmShellClassRec.core_class.set_values_almost", "XtAlmostProc", sizeof(wmShellClassRec.core_class.set_values_almost), sizeof(XtAlmostProc));
	myXtAlmostProc = wmShellClassRec.core_class.set_values_almost;
	pmyXtAlmostProc = &wmShellClassRec.core_class.set_values_almost;

	check_size("wmShellClassRec.core_class.get_values_hook", "XtArgsProc", sizeof(wmShellClassRec.core_class.get_values_hook), sizeof(XtArgsProc));
	myXtArgsProc = wmShellClassRec.core_class.get_values_hook;
	pmyXtArgsProc = &wmShellClassRec.core_class.get_values_hook;

	check_size("wmShellClassRec.core_class.accept_focus", "XtAcceptFocusProc", sizeof(wmShellClassRec.core_class.accept_focus), sizeof(XtAcceptFocusProc));
	myXtAcceptFocusProc = wmShellClassRec.core_class.accept_focus;
	pmyXtAcceptFocusProc = &wmShellClassRec.core_class.accept_focus;

	check_size("wmShellClassRec.core_class.version", "XtVersionType", sizeof(wmShellClassRec.core_class.version), sizeof(XtVersionType));
	myXtVersionType = wmShellClassRec.core_class.version;
	pmyXtVersionType = &wmShellClassRec.core_class.version;

	check_size("wmShellClassRec.core_class.callback_private", "XtPointer", sizeof(wmShellClassRec.core_class.callback_private), sizeof(XtPointer));
	myXtPointer = wmShellClassRec.core_class.callback_private;
	pmyXtPointer = &wmShellClassRec.core_class.callback_private;

	check_size("wmShellClassRec.core_class.tm_table", "String", sizeof(wmShellClassRec.core_class.tm_table), sizeof(String));
	myString = wmShellClassRec.core_class.tm_table;
	pmyString = &wmShellClassRec.core_class.tm_table;

	check_size("wmShellClassRec.core_class.query_geometry", "XtGeometryHandler", sizeof(wmShellClassRec.core_class.query_geometry), sizeof(XtGeometryHandler));
	myXtGeometryHandler = wmShellClassRec.core_class.query_geometry;
	pmyXtGeometryHandler = &wmShellClassRec.core_class.query_geometry;

	check_size("wmShellClassRec.core_class.display_accelerator", "XtStringProc", sizeof(wmShellClassRec.core_class.display_accelerator), sizeof(XtStringProc));
	myXtStringProc = wmShellClassRec.core_class.display_accelerator;
	pmyXtStringProc = &wmShellClassRec.core_class.display_accelerator;

	check_size("wmShellClassRec.core_class.extension", "XtPointer", sizeof(wmShellClassRec.core_class.extension), sizeof(XtPointer));
	myXtPointer = wmShellClassRec.core_class.extension;
	pmyXtPointer = &wmShellClassRec.core_class.extension;

	check_size("wmShellClassRec.composite_class.geometry_manager", "XtGeometryHandler", sizeof(wmShellClassRec.composite_class.geometry_manager), sizeof(XtGeometryHandler));
	myXtGeometryHandler = wmShellClassRec.composite_class.geometry_manager;
	pmyXtGeometryHandler = &wmShellClassRec.composite_class.geometry_manager;

	check_size("wmShellClassRec.composite_class.change_managed", "XtWidgetProc", sizeof(wmShellClassRec.composite_class.change_managed), sizeof(XtWidgetProc));
	myXtWidgetProc = wmShellClassRec.composite_class.change_managed;
	pmyXtWidgetProc = &wmShellClassRec.composite_class.change_managed;

	check_size("wmShellClassRec.composite_class.insert_child", "XtWidgetProc", sizeof(wmShellClassRec.composite_class.insert_child), sizeof(XtWidgetProc));
	myXtWidgetProc = wmShellClassRec.composite_class.insert_child;
	pmyXtWidgetProc = &wmShellClassRec.composite_class.insert_child;

	check_size("wmShellClassRec.composite_class.delete_child", "XtWidgetProc", sizeof(wmShellClassRec.composite_class.delete_child), sizeof(XtWidgetProc));
	myXtWidgetProc = wmShellClassRec.composite_class.delete_child;
	pmyXtWidgetProc = &wmShellClassRec.composite_class.delete_child;

	check_size("wmShellClassRec.composite_class.extension", "XtPointer", sizeof(wmShellClassRec.composite_class.extension), sizeof(XtPointer));
	myXtPointer = wmShellClassRec.composite_class.extension;
	pmyXtPointer = &wmShellClassRec.composite_class.extension;

	check_size("wmShellClassRec.shell_class.extension", "XtPointer", sizeof(wmShellClassRec.shell_class.extension), sizeof(XtPointer));
	myXtPointer = wmShellClassRec.shell_class.extension;
	pmyXtPointer = &wmShellClassRec.shell_class.extension;

	check_size("wmShellClassRec.wm_shell_class.extension", "XtPointer", sizeof(wmShellClassRec.wm_shell_class.extension), sizeof(XtPointer));
	myXtPointer = wmShellClassRec.wm_shell_class.extension;
	pmyXtPointer = &wmShellClassRec.wm_shell_class.extension;

	tet_result(TET_PASS);
>>ASSERTION Good A
The class pointer for wm shell widgets
wmShellWidgetClass shall exist and point to the wm
shell class record.
>>CODE

	tet_infoline("TEST: wmShellClass");
	if (wmShellWidgetClass != (WidgetClass)&wmShellClassRec) {
		sprintf(ebuf, "ERROR: wmShellWidgetClass does not point to wmShellClassRec");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}

	tet_result(TET_PASS);
>>ASSERTION Good A
The type WMShellWidgetClass shall be defined as a
pointer to a vendor shell widget class structure.
>>CODE
WMShellWidgetClass testvar;
XtPointer testvar2;

	/* this will not build if the define is not correct*/
	tet_infoline("TEST: WMShellWidgetClass");
	testvar = &wmShellClassRec;
	testvar2 = testvar->core_class.superclass;
	tet_result(TET_PASS);
>>ASSERTION Good A
The instance structure for shell widgets WMShellPart
shall be defined and contain the fields listed in
section 6.1.2 of the Specification.
>>CODE
WMShellPart testStruct;

	check_size("WMShellPart.title", "String", sizeof(testStruct.title), sizeof(String));
	myString = testStruct.title;
	pmyString = &testStruct.title;

	check_size("WMShellPart.wm_timeout", "int", sizeof(testStruct.wm_timeout), sizeof(int));
	myint = testStruct.wm_timeout;
	pmyint = &testStruct.wm_timeout;

	check_size("WMShellPart.wait_for_wm", "Boolean", sizeof(testStruct.wait_for_wm), sizeof(Boolean));
	myBoolean = testStruct.wait_for_wm;
	pmyBoolean = &testStruct.wait_for_wm;

	check_size("WMShellPart.transient", "Boolean", sizeof(testStruct.transient), sizeof(Boolean));
	myBoolean = testStruct.transient;
	pmyBoolean = &testStruct.transient;

#if XT_X_RELEASE == 4
	check_size("WMShellPart.wm_configure_denied", "Atom", sizeof(testStruct.wm_configure_denied), sizeof(Atom));
	myAtom = testStruct.wm_configure_denied;
	pmyAtom = &testStruct.wm_configure_denied;

	check_size("WMShellPart.wm_moved", "Atom", sizeof(testStruct.wm_moved), sizeof(Atom));
	myAtom = testStruct.wm_moved;
	pmyAtom = &testStruct.wm_moved;
#endif

	check_size("WMShellPart.size_hints.flags", "long", sizeof(testStruct.size_hints.flags), sizeof(long));
	mylong = testStruct.size_hints.flags;
	pmylong = &testStruct.size_hints.flags;

	check_size("WMShellPart.size_hints.x", "int", sizeof(testStruct.size_hints.x), sizeof(int));
	myint = testStruct.size_hints.x;
	pmyint = &testStruct.size_hints.x;

	check_size("WMShellPart.size_hints.y", "int", sizeof(testStruct.size_hints.y), sizeof(int));
	myint = testStruct.size_hints.y;
	pmyint = &testStruct.size_hints.y;

	check_size("WMShellPart.size_hints.width", "int", sizeof(testStruct.size_hints.width), sizeof(int));
	myint = testStruct.size_hints.width;
	pmyint = &testStruct.size_hints.width;

	check_size("WMShellPart.size_hints.height", "int", sizeof(testStruct.size_hints.height), sizeof(int));
	myint = testStruct.size_hints.height;
	pmyint = &testStruct.size_hints.height;

	check_size("WMShellPart.size_hints.min_width", "int", sizeof(testStruct.size_hints.min_width), sizeof(int));
	myint = testStruct.size_hints.min_width;
	pmyint = &testStruct.size_hints.min_width;

	check_size("WMShellPart.size_hints.min_height", "int", sizeof(testStruct.size_hints.min_height), sizeof(int));
	myint = testStruct.size_hints.min_height;
	pmyint = &testStruct.size_hints.min_height;

	check_size("WMShellPart.size_hints.max_width", "int", sizeof(testStruct.size_hints.max_width), sizeof(int));
	myint = testStruct.size_hints.max_width;
	pmyint = &testStruct.size_hints.max_width;

	check_size("WMShellPart.size_hints.max_height", "int", sizeof(testStruct.size_hints.max_height), sizeof(int));
	myint = testStruct.size_hints.max_height;
	pmyint = &testStruct.size_hints.max_height;

	check_size("WMShellPart.size_hints.width_inc", "int", sizeof(testStruct.size_hints.width_inc), sizeof(int));
	myint = testStruct.size_hints.width_inc;
	pmyint = &testStruct.size_hints.width_inc;

	check_size("WMShellPart.size_hints.height_inc", "int", sizeof(testStruct.size_hints.height_inc), sizeof(int));
	myint = testStruct.size_hints.height_inc;
	pmyint = &testStruct.size_hints.height_inc;

	check_size("WMShellPart.size_hints.min_aspect.x", "int", sizeof(testStruct.size_hints.min_aspect.x), sizeof(int));
	myint = testStruct.size_hints.min_aspect.x;
	pmyint = &testStruct.size_hints.min_aspect.x;

	check_size("WMShellPart.size_hints.min_aspect.y", "int", sizeof(testStruct.size_hints.min_aspect.y), sizeof(int));
	myint = testStruct.size_hints.min_aspect.y;
	pmyint = &testStruct.size_hints.min_aspect.y;

	check_size("WMShellPart.size_hints.max_aspect.x", "int", sizeof(testStruct.size_hints.max_aspect.x), sizeof(int));
	myint = testStruct.size_hints.max_aspect.x;
	pmyint = &testStruct.size_hints.max_aspect.x;

	check_size("WMShellPart.size_hints.max_aspect.y", "int", sizeof(testStruct.size_hints.max_aspect.y), sizeof(int));
	myint = testStruct.size_hints.max_aspect.y;
	pmyint = &testStruct.size_hints.max_aspect.y;

	check_size("WMShellPart.wm_hints", "XWMHints", sizeof(testStruct.wm_hints), sizeof(XWMHints));
	myXWMHints = testStruct.wm_hints;
	pmyXWMHints = &testStruct.wm_hints;

	check_size("WMShellPart.base_width", "int", sizeof(testStruct.base_width), sizeof(int));
	myint = testStruct.base_width;
	pmyint = &testStruct.base_width;

	check_size("WMShellPart.base_height", "int", sizeof(testStruct.base_height), sizeof(int));
	myint = testStruct.base_height;
	pmyint = &testStruct.base_height;

	check_size("WMShellPart.win_gravity", "int", sizeof(testStruct.win_gravity), sizeof(int));
	myint = testStruct.win_gravity;
	pmyint = &testStruct.win_gravity;

	check_size("WMShellPart.title_encoding", "Atom", sizeof(testStruct.title_encoding), sizeof(Atom));
	myAtom = testStruct.title_encoding;
	pmyAtom = &testStruct.title_encoding;

	tet_result(TET_PASS);
>>ASSERTION Good A
The instance record structure for shell widgets
WMShellRec shall be defined and contain the fields
listed in section 6.1.2 of the Specification.
>>CODE
WMShellRec testStruct;

	check_size("WMShellRec.core.self", "Widget", sizeof(testStruct.core.self), sizeof(Widget));
	myWidget = testStruct.core.self;
	pmyWidget = &testStruct.core.self;

	check_size("WMShellRec.core.widget_class", "WidgetClass", sizeof(testStruct.core.widget_class), sizeof(WidgetClass));
	myWidgetClass = testStruct.core.widget_class;
	pmyWidgetClass = &testStruct.core.widget_class;

	check_size("WMShellRec.core.parent", "Widget", sizeof(testStruct.core.parent), sizeof(Widget));
	myWidget = testStruct.core.parent;
	pmyWidget = &testStruct.core.parent;

	check_size("WMShellRec.core.xrm_name", "XrmName", sizeof(testStruct.core.xrm_name), sizeof(XrmName));
	myXrmName = testStruct.core.xrm_name;
	pmyXrmName = &testStruct.core.xrm_name;

	check_size("WMShellRec.core.being_destroyed", "Boolean", sizeof(testStruct.core.being_destroyed), sizeof(Boolean));
	myBoolean = testStruct.core.being_destroyed;
	pmyBoolean = &testStruct.core.being_destroyed;

	check_size("WMShellRec.core.destroy_callbacks", "XtCallbackList", sizeof(testStruct.core.destroy_callbacks), sizeof(XtCallbackList));
	myXtCallbackList = testStruct.core.destroy_callbacks;
	pmyXtCallbackList = &testStruct.core.destroy_callbacks;

	check_size("WMShellRec.core.constraints", "XtPointer", sizeof(testStruct.core.constraints), sizeof(XtPointer));
	myXtPointer = testStruct.core.constraints;
	pmyXtPointer = &testStruct.core.constraints;

	check_size("WMShellRec.core.border_width", "Dimension", sizeof(testStruct.core.border_width), sizeof(Dimension));
	myDimension = testStruct.core.border_width;
	pmyDimension = &testStruct.core.border_width;

	check_size("WMShellRec.core.managed", "Boolean", sizeof(testStruct.core.managed), sizeof(Boolean));
	myBoolean = testStruct.core.managed;
	pmyBoolean = &testStruct.core.managed;

	check_size("WMShellRec.core.sensitive", "Boolean", sizeof(testStruct.core.sensitive), sizeof(Boolean));
	myBoolean = testStruct.core.sensitive;
	pmyBoolean = &testStruct.core.sensitive;

	check_size("WMShellRec.core.ancestor_sensitive", "Boolean", sizeof(testStruct.core.ancestor_sensitive), sizeof(Boolean));
	myBoolean = testStruct.core.ancestor_sensitive;
	pmyBoolean = &testStruct.core.ancestor_sensitive;

	check_size("WMShellRec.core.event_table", "XtEventTable", sizeof(testStruct.core.event_table), sizeof(XtEventTable));
	myXtEventTable = testStruct.core.event_table;
	pmyXtEventTable = &testStruct.core.event_table;

	check_size("WMShellRec.core.tm", "XtTMRec", sizeof(testStruct.core.tm), sizeof(XtTMRec));
	myXtTMRec = testStruct.core.tm;
	pmyXtTMRec = &testStruct.core.tm;

	check_size("WMShellRec.core.accelerators", "XtTranslations", sizeof(testStruct.core.accelerators), sizeof(XtTranslations));
	myXtTranslations = testStruct.core.accelerators;
	pmyXtTranslations = &testStruct.core.accelerators;

	check_size("WMShellRec.core.border_pixel", "Pixel", sizeof(testStruct.core.border_pixel), sizeof(Pixel));
	myPixel = testStruct.core.border_pixel;
	pmyPixel = &testStruct.core.border_pixel;

	check_size("WMShellRec.core.border_pixmap", "Pixmap", sizeof(testStruct.core.border_pixmap), sizeof(Pixmap));
	myPixmap = testStruct.core.border_pixmap;
	pmyPixmap = &testStruct.core.border_pixmap;

	check_size("WMShellRec.core.popup_list", "WidgetList", sizeof(testStruct.core.popup_list), sizeof(WidgetList));
	myWidgetList = testStruct.core.popup_list;
	pmyWidgetList = &testStruct.core.popup_list;

	check_size("WMShellRec.core.num_popups", "Cardinal", sizeof(testStruct.core.num_popups), sizeof(Cardinal));
	myCardinal = testStruct.core.num_popups;
	pmyCardinal = &testStruct.core.num_popups;

	check_size("WMShellRec.core.name", "String", sizeof(testStruct.core.name), sizeof(String));
	myString = testStruct.core.name;
	pmyString = &testStruct.core.name;

	check_size("WMShellRec.core.screen", "Screen *", sizeof(testStruct.core.screen), sizeof(Screen *));
	pmyScreen = testStruct.core.screen;

	check_size("WMShellRec.core.colormap", "Colormap", sizeof(testStruct.core.colormap), sizeof(Colormap));
	myColormap = testStruct.core.colormap;
	pmyColormap = &testStruct.core.colormap;

	check_size("WMShellRec.core.window", "Window", sizeof(testStruct.core.window), sizeof(Window));
	myWindow = testStruct.core.window;
	pmyWindow = &testStruct.core.window;

	check_size("WMShellRec.core.depth", "Cardinal", sizeof(testStruct.core.depth), sizeof(Cardinal));
	myCardinal = testStruct.core.depth;
	pmyCardinal = &testStruct.core.depth;

	check_size("WMShellRec.core.background_pixel", "Pixel", sizeof(testStruct.core.background_pixel), sizeof(Pixel));
	myPixel = testStruct.core.background_pixel;
	pmyPixel = &testStruct.core.background_pixel;

	check_size("WMShellRec.core.background_pixmap", "Pixmap", sizeof(testStruct.core.background_pixmap), sizeof(Pixmap));
	myPixmap = testStruct.core.background_pixmap;
	pmyPixmap = &testStruct.core.background_pixmap;

	check_size("WMShellRec.core.visible", "Boolean", sizeof(testStruct.core.visible), sizeof(Boolean));
	myBoolean = testStruct.core.visible;
	pmyBoolean = &testStruct.core.visible;

	check_size("WMShellRec.core.mapped_when_managed", "Boolean", sizeof(testStruct.core.mapped_when_managed), sizeof(Boolean));
	myBoolean = testStruct.core.mapped_when_managed;
	pmyBoolean = &testStruct.core.mapped_when_managed;

	check_size("WMShellRec.composite.children", "WidgetList", sizeof(testStruct.composite.children), sizeof(WidgetList));
	myWidgetList = testStruct.composite.children;
	pmyWidgetList = &testStruct.composite.children;

	check_size("WMShellRec.composite.num_children", "Cardinal", sizeof(testStruct.composite.num_children), sizeof(Cardinal));
	myCardinal = testStruct.composite.num_children;
	pmyCardinal = &testStruct.composite.num_children;

	check_size("WMShellRec.composite.num_slots", "Cardinal", sizeof(testStruct.composite.num_slots), sizeof(Cardinal));
	myCardinal = testStruct.composite.num_slots;
	pmyCardinal = &testStruct.composite.num_slots;

	check_size("WMShellRec.composite.insert_position", "XtOrderProc", sizeof(testStruct.composite.insert_position), sizeof(XtOrderProc));
	myXtOrderProc = testStruct.composite.insert_position;
	pmyXtOrderProc = &testStruct.composite.insert_position;

	check_size("WMShellRec.shell.geometry", "String", sizeof(testStruct.shell.geometry), sizeof(String));
	myString = testStruct.shell.geometry;
	pmyString = &testStruct.shell.geometry;

	check_size("WMShellRec.shell.create_popup_child_proc", "XtCreatePopupChildProc", sizeof(testStruct.shell.create_popup_child_proc), sizeof(XtCreatePopupChildProc));
	myXtCreatePopupChildProc = testStruct.shell.create_popup_child_proc;
	pmyXtCreatePopupChildProc = &testStruct.shell.create_popup_child_proc;

	check_size("WMShellRec.shell.grab_kind", "XtGrabKind", sizeof(testStruct.shell.grab_kind), sizeof(XtGrabKind));
	myXtGrabKind = testStruct.shell.grab_kind;
	pmyXtGrabKind = &testStruct.shell.grab_kind;

	check_size("WMShellRec.shell.spring_loaded", "Boolean", sizeof(testStruct.shell.spring_loaded), sizeof(Boolean));
	myBoolean = testStruct.shell.spring_loaded;
	pmyBoolean = &testStruct.shell.spring_loaded;

	check_size("WMShellRec.shell.popped_up", "Boolean", sizeof(testStruct.shell.popped_up), sizeof(Boolean));
	myBoolean = testStruct.shell.popped_up;
	pmyBoolean = &testStruct.shell.popped_up;

	check_size("WMShellRec.shell.allow_shell_resize", "Boolean", sizeof(testStruct.shell.allow_shell_resize), sizeof(Boolean));
	myBoolean = testStruct.shell.allow_shell_resize;
	pmyBoolean = &testStruct.shell.allow_shell_resize;

	check_size("WMShellRec.shell.client_specified", "Boolean", sizeof(testStruct.shell.client_specified), sizeof(Boolean));
	myBoolean = testStruct.shell.client_specified;
	pmyBoolean = &testStruct.shell.client_specified;

	check_size("WMShellRec.shell.save_under", "Boolean", sizeof(testStruct.shell.save_under), sizeof(Boolean));
	myBoolean = testStruct.shell.save_under;
	pmyBoolean = &testStruct.shell.save_under;

	check_size("WMShellRec.shell.override_redirect", "Boolean", sizeof(testStruct.shell.override_redirect), sizeof(Boolean));
	myBoolean = testStruct.shell.override_redirect;
	pmyBoolean = &testStruct.shell.override_redirect;

	check_size("WMShellRec.shell.popup_callback", "XtCallbackList", sizeof(testStruct.shell.popup_callback), sizeof(XtCallbackList));
	myXtCallbackList = testStruct.shell.popup_callback;
	pmyXtCallbackList = &testStruct.shell.popup_callback;

	check_size("WMShellRec.shell.popdown_callback", "XtCallbackList", sizeof(testStruct.shell.popdown_callback), sizeof(XtCallbackList));
	myXtCallbackList = testStruct.shell.popdown_callback;
	pmyXtCallbackList = &testStruct.shell.popdown_callback;

	check_size("WMShellRec.shell.visual", "Visual *", sizeof(testStruct.shell.visual), sizeof(Visual *));
	pmyVisual = testStruct.shell.visual;

	check_size("WMShellRec.wm.title", "String", sizeof(testStruct.wm.title), sizeof(String));
	myString = testStruct.wm.title;
	pmyString = &testStruct.wm.title;

	check_size("WMShellRec.wm.wm_timeout", "int", sizeof(testStruct.wm.wm_timeout), sizeof(int));
	myint = testStruct.wm.wm_timeout;
	pmyint = &testStruct.wm.wm_timeout;

	check_size("WMShellRec.wm.wait_for_wm", "Boolean", sizeof(testStruct.wm.wait_for_wm), sizeof(Boolean));
	myBoolean = testStruct.wm.wait_for_wm;
	pmyBoolean = &testStruct.wm.wait_for_wm;

	check_size("WMShellRec.wm.transient", "Boolean", sizeof(testStruct.wm.transient), sizeof(Boolean));
	myBoolean = testStruct.wm.transient;
	pmyBoolean = &testStruct.wm.transient;

#if XT_X_RELEASE == 4
	check_size("WMShellRec.wm.wm_configure_denied", "Atom", sizeof(testStruct.wm.wm_configure_denied), sizeof(Atom));
	myAtom = testStruct.wm.wm_configure_denied;
	pmyAtom = &testStruct.wm.wm_configure_denied;

	check_size("WMShellRec.wm.wm_moved", "Atom", sizeof(testStruct.wm.wm_moved), sizeof(Atom));
	myAtom = testStruct.wm.wm_moved;
	pmyAtom = &testStruct.wm.wm_moved;
#endif

	check_size("WMShellRec.wm.size_hints.flags", "long", sizeof(testStruct.wm.size_hints.flags), sizeof(long));
	mylong = testStruct.wm.size_hints.flags;
	pmylong = &testStruct.wm.size_hints.flags;

	check_size("WMShellRec.wm.size_hints.x", "int", sizeof(testStruct.wm.size_hints.x), sizeof(int));
	myint = testStruct.wm.size_hints.x;
	pmyint = &testStruct.wm.size_hints.x;

	check_size("WMShellRec.wm.size_hints.y", "int", sizeof(testStruct.wm.size_hints.y), sizeof(int));
	myint = testStruct.wm.size_hints.y;
	pmyint = &testStruct.wm.size_hints.y;

	check_size("WMShellRec.wm.size_hints.width", "int", sizeof(testStruct.wm.size_hints.width), sizeof(int));
	myint = testStruct.wm.size_hints.width;
	pmyint = &testStruct.wm.size_hints.width;

	check_size("WMShellRec.wm.size_hints.height", "int", sizeof(testStruct.wm.size_hints.height), sizeof(int));
	myint = testStruct.wm.size_hints.height;
	pmyint = &testStruct.wm.size_hints.height;

	check_size("WMShellRec.wm.size_hints.min_width", "int", sizeof(testStruct.wm.size_hints.min_width), sizeof(int));
	myint = testStruct.wm.size_hints.min_width;
	pmyint = &testStruct.wm.size_hints.min_width;

	check_size("WMShellRec.wm.size_hints.min_height", "int", sizeof(testStruct.wm.size_hints.min_height), sizeof(int));
	myint = testStruct.wm.size_hints.min_height;
	pmyint = &testStruct.wm.size_hints.min_height;

	check_size("WMShellRec.wm.size_hints.max_width", "int", sizeof(testStruct.wm.size_hints.max_width), sizeof(int));
	myint = testStruct.wm.size_hints.max_width;
	pmyint = &testStruct.wm.size_hints.max_width;

	check_size("WMShellRec.wm.size_hints.max_height", "int", sizeof(testStruct.wm.size_hints.max_height), sizeof(int));
	myint = testStruct.wm.size_hints.max_height;
	pmyint = &testStruct.wm.size_hints.max_height;

	check_size("WMShellRec.wm.size_hints.width_inc", "int", sizeof(testStruct.wm.size_hints.width_inc), sizeof(int));
	myint = testStruct.wm.size_hints.width_inc;
	pmyint = &testStruct.wm.size_hints.width_inc;

	check_size("WMShellRec.wm.size_hints.height_inc", "int", sizeof(testStruct.wm.size_hints.height_inc), sizeof(int));
	myint = testStruct.wm.size_hints.height_inc;
	pmyint = &testStruct.wm.size_hints.height_inc;

	check_size("WMShellRec.wm.size_hints.min_aspect.x", "int", sizeof(testStruct.wm.size_hints.min_aspect.x), sizeof(int));
	myint = testStruct.wm.size_hints.min_aspect.x;
	pmyint = &testStruct.wm.size_hints.min_aspect.x;

	check_size("WMShellRec.wm.size_hints.min_aspect.y", "int", sizeof(testStruct.wm.size_hints.min_aspect.y), sizeof(int));
	myint = testStruct.wm.size_hints.min_aspect.y;
	pmyint = &testStruct.wm.size_hints.min_aspect.y;

	check_size("WMShellRec.wm.size_hints.max_aspect.x", "int", sizeof(testStruct.wm.size_hints.max_aspect.x), sizeof(int));
	myint = testStruct.wm.size_hints.max_aspect.x;
	pmyint = &testStruct.wm.size_hints.max_aspect.x;

	check_size("WMShellRec.wm.size_hints.max_aspect.y", "int", sizeof(testStruct.wm.size_hints.max_aspect.y), sizeof(int));
	myint = testStruct.wm.size_hints.max_aspect.y;
	pmyint = &testStruct.wm.size_hints.max_aspect.y;

	tet_result(TET_PASS);
>>ASSERTION Good A
The type WMShellWidget shall be defined as a pointer
to a shell widget instance.
>>CODE
WMShellRec	testwid;
WMShellWidget testvar;
XtPointer testvar2;

	/* this will not build if the define is not correct*/
	tet_infoline("TEST: WMShellWidget");
	/*doesn't matter where we point, just testing syntax*/
	testvar = &testwid;
	testvar2 = testvar->shell.visual;
	tet_result(TET_PASS);
>>ASSERTION Good A
WM shell widgets shall be a subclass of shell widgets
>>CODE
WMShellWidget testwidget;

	tet_infoline("PREP: Initialize toolkit, Open display and Create topLevel root widget");
        topLevel = (Widget) avs_xt_init("Hwmshell9", NULL, 0);
        trace("Set up the XtToolkitError handler");
        app_ctext = XtWidgetToApplicationContext(topLevel) ;
        XtAppSetErrorMsgHandler(app_ctext, xt_handler);
        XtAppSetWarningMsgHandler(app_ctext, xt_whandler);
	tet_infoline("PREP: Create fresh widget");
	testwidget = (WMShellWidget)XtCreateWidget("ApTest", wmShellWidgetClass, topLevel, NULL, 0);
	tet_infoline("TEST: WMshell superclass is shell");
	if (wmShellClassRec.core_class.superclass != shellWidgetClass) {
		tet_infoline("ERROR: superclass is not shell");
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
>>ASSERTION Good A
WMShellRec shall be initialized to the default values
specified in sections 3.4.1, 3.4.2 and 6.1.4 of the
Specification on creation of a new shell widget
instance.
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
char *pixstr = "XtDefaultForeground";
char *pixstr2 = "XtDefaultBackground";
Pixel res;
WMShellWidget testwidget;

	tet_infoline("PREP: Initialize toolkit, Open display and Create topLevel root widget");
        topLevel = (Widget) avs_xt_init("Hwmshell10", NULL, 0);
        trace("Set up the XtToolkitError handler");
        app_ctext = XtWidgetToApplicationContext(topLevel) ;
        XtAppSetErrorMsgHandler(app_ctext, xt_handler);
        XtAppSetWarningMsgHandler(app_ctext, xt_whandler);
	tet_infoline("PREP: Create fresh widget");
	testwidget = (WMShellWidget)XtCreateWidget("ApTest", wmShellWidgetClass, topLevel, NULL, 0);
	tet_infoline("TEST: core.self");
	if (testwidget->core.self != (Widget)testwidget) {
		tet_infoline("ERROR: self member is not address of widget structure");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: core.widget_class");
	if (testwidget->core.widget_class != wmShellWidgetClass) {
		tet_infoline("ERROR: widget_class member is not wmShellWidgetClass");
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
		sprintf(ebuf, "ERROR: managed member is %d, expected False", testwidget->core.managed);
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
	tet_infoline("TEST: shell.geometry");
	if (testwidget->shell.geometry != NULL) {
		tet_infoline("ERROR: geometry member is not NULL");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: shell.create_popup_child_proc");
	if (testwidget->shell.create_popup_child_proc != NULL) {
		tet_infoline("ERROR: create_popup_child_proc member is not NULL");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: shell.popped_up");
	if (testwidget->shell.popped_up != False) {
		sprintf(ebuf, "ERROR: popped_up member is %d, expected False", testwidget->shell.popped_up);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: shell.allow_shell_resize");
	if (testwidget->shell.allow_shell_resize != False) {
		sprintf(ebuf, "ERROR: allow_shell_resize member is %d, expected False", testwidget->shell.allow_shell_resize);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: shell.save_under");
	if (testwidget->shell.save_under != False) {
		sprintf(ebuf, "ERROR: save_under member is %d, expected False", testwidget->shell.save_under);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: shell.override_redirect");
	if (testwidget->shell.override_redirect != False) {
		sprintf(ebuf, "ERROR: override_redirect member is %d, expected False", testwidget->shell.override_redirect);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: shell.popup_callback");
	if (testwidget->shell.popup_callback != NULL) {
		tet_infoline("ERROR: popup_callback member is not NULL");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: shell.popdown_callback");
	if (testwidget->shell.popdown_callback != NULL) {
		tet_infoline("ERROR: popdown_callback member is not NULL");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: wm.title");
	if (strcmp(testwidget->wm.title, "ApTest") != 0) {
		sprintf(ebuf, "ERROR: Expected title of %s, is %s", "ApTest", testwidget->wm.title);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: wm.wm_timeout");
	if (testwidget->wm.wm_timeout != 5000) {
		sprintf(ebuf, "ERROR: wm_timeout member is %d, expected 5000", testwidget->wm.wm_timeout);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: wm.wait_for_wm");
	if (testwidget->wm.wait_for_wm != True) {
		sprintf(ebuf, "ERROR: wait_for_wm member is %d, expected True", testwidget->wm.wait_for_wm);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: wm.transient");
	if (testwidget->wm.transient != False) {
		sprintf(ebuf, "ERROR: transient member is %d, expected False", testwidget->wm.transient);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: wm.size_hints.min_width");
	if (testwidget->wm.size_hints.min_width != XtUnspecifiedShellInt) {
		tet_infoline("ERROR: size_hints.min_width member is not XtUnspecifiedShellInt");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: wm.size_hints.min_height");
	if (testwidget->wm.size_hints.min_height != XtUnspecifiedShellInt) {
		tet_infoline("ERROR: size_hints.min_height member is not XtUnspecifiedShellInt");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: wm.size_hints.max_width");
	if (testwidget->wm.size_hints.max_width != XtUnspecifiedShellInt) {
		tet_infoline("ERROR: size_hints.max_width member is not XtUnspecifiedShellInt");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: wm.size_hints.max_height");
	if (testwidget->wm.size_hints.max_height != XtUnspecifiedShellInt) {
		tet_infoline("ERROR: size_hints.max_height member is not XtUnspecifiedShellInt");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: wm.size_hints.width_inc");
	if (testwidget->wm.size_hints.width_inc != XtUnspecifiedShellInt) {
		tet_infoline("ERROR: size_hints.width_inc member is not XtUnspecifiedShellInt");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: wm.size_hints.height_inc");
	if (testwidget->wm.size_hints.height_inc != XtUnspecifiedShellInt) {
		tet_infoline("ERROR: size_hints.height_inc member is not XtUnspecifiedShellInt");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: wm.size_hints.min_aspect.x");
	if (testwidget->wm.size_hints.min_aspect.x != XtUnspecifiedShellInt) {
		tet_infoline("ERROR: size_hints.min_aspect.x member is not XtUnspecifiedShellInt");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: wm.size_hints.min_aspect.y");
	if (testwidget->wm.size_hints.min_aspect.y != XtUnspecifiedShellInt) {
		tet_infoline("ERROR: size_hints.min_aspect.y member is not XtUnspecifiedShellInt");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: wm.size_hints.max_aspect.x");
	if (testwidget->wm.size_hints.max_aspect.x != XtUnspecifiedShellInt) {
		tet_infoline("ERROR: size_hints.max_aspect.x member is not XtUnspecifiedShellInt");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: wm.size_hints.max_aspect.y");
	if (testwidget->wm.size_hints.max_aspect.y != XtUnspecifiedShellInt) {
		tet_infoline("ERROR: size_hints.max_aspect.y member is not XtUnspecifiedShellInt");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: wm.wm_hints.input");
	if (testwidget->wm.wm_hints.input != False) {
		sprintf(ebuf, "ERROR: wm_hints.input member is %d, expected False", testwidget->wm.wm_hints.input);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: wm.wm_hints.icon_x");
	if (testwidget->wm.wm_hints.icon_x != XtUnspecifiedShellInt) {
		tet_infoline("ERROR: wm_hints.icon_x member is not XtUnspecifiedShellInt");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: wm.wm_hints.icon_y");
	if (testwidget->wm.wm_hints.icon_y != XtUnspecifiedShellInt) {
		tet_infoline("ERROR: wm_hints.icon_y member is not XtUnspecifiedShellInt");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: wm.wm_hints.window_group");
	if (testwidget->wm.wm_hints.window_group != XtUnspecifiedWindow) {
		tet_infoline("ERROR: wm_hints.window_group member is not XtUnspecifiedWindow");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: wm.base_width");
	if (testwidget->wm.base_width != XtUnspecifiedShellInt) {
		tet_infoline("ERROR: base_width member is not XtUnspecifiedShellInt");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: wm.base_height");
	if (testwidget->wm.base_height != XtUnspecifiedShellInt) {
		tet_infoline("ERROR: base_height member is not XtUnspecifiedShellInt");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: wm.win_gravity");
	if (testwidget->wm.win_gravity != XtUnspecifiedShellInt) {
		tet_infoline("ERROR: win_gravity member is not XtUnspecifiedShellInt");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: wm.title_encoding");
	if (testwidget->wm.title_encoding != XA_STRING) {
		tet_infoline("ERROR: title_encoding member is not XA_STRING");
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
