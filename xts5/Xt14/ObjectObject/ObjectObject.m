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
>># File: tset/Xt14/ObjectObject/ObjectObject.m
>># 
>># Description:
>>#	Tests for Object Objects
>># 
>># Modifications:
>># $Log: objctobjct.m,v $
>># Revision 1.1  2005-02-12 14:37:58  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:37:15  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:00:10  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:28:21  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:56  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:18:59  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:13:03  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>
#include <X11/ObjectP.h>

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
>>TITLE ObjectObject Xt14
>>ASSERTION Good A
The class structure for objects ObjectClassPart shall
be defined and contain the fields listed in section
14.2.1 of the Specification.
>>CODE
ObjectClassPart testStruct;

	check_size("ObjectClassPart.superclass", "WidgetClass", sizeof(testStruct.superclass), sizeof(WidgetClass));
	myWidgetClass = testStruct.superclass;
	pmyWidgetClass = &testStruct.superclass;

	check_size("ObjectClassPart.class_name", "String", sizeof(testStruct.class_name), sizeof(String));

	check_size("ObjectClassPart.widget_size", "Cardinal", sizeof(testStruct.widget_size), sizeof(Cardinal));
	myCardinal = testStruct.widget_size;
	pmyCardinal = &testStruct.widget_size;

	check_size("ObjectClassPart.class_initialize", "XtProc", sizeof(testStruct.class_initialize), sizeof(XtProc));
	myXtProc = testStruct.class_initialize;
	pmyXtProc = &testStruct.class_initialize;

	check_size("ObjectClassPart.class_part_initialize", "XtWidgetClassProc", sizeof(testStruct.class_part_initialize), sizeof(XtWidgetClassProc));
	myXtWidgetClassProc = testStruct.class_part_initialize;
	pmyXtWidgetClassProc = &testStruct.class_part_initialize;

	check_size("ObjectClassPart.class_inited", "XtEnum", sizeof(testStruct.class_inited), sizeof(XtEnum));
	myXtEnum = testStruct.class_inited;
	pmyXtEnum = &testStruct.class_inited;

	check_size("ObjectClassPart.initialize", "XtInitProc", sizeof(testStruct.initialize), sizeof(XtInitProc));
	myXtInitProc = testStruct.initialize;
	pmyXtInitProc = &testStruct.initialize;

	check_size("ObjectClassPart.initialize_hook", "XtArgsProc", sizeof(testStruct.initialize_hook), sizeof(XtArgsProc));
	myXtArgsProc = testStruct.initialize_hook;
	pmyXtArgsProc = &testStruct.initialize_hook;

	check_size("ObjectClassPart.obj1", "XtProc", sizeof(testStruct.obj1), sizeof(XtProc));
	myXtProc = testStruct.obj1;
	pmyXtProc = &testStruct.obj1;

	check_size("ObjectClassPart.obj2", "XtPointer", sizeof(testStruct.obj2), sizeof(XtPointer));
	myXtPointer = testStruct.obj2;
	pmyXtPointer = &testStruct.obj2;

	check_size("ObjectClassPart.obj3", "Cardinal", sizeof(testStruct.obj3), sizeof(Cardinal));
	myCardinal = testStruct.obj3;
	pmyCardinal = &testStruct.obj3;

	check_size("ObjectClassPart.resources", "XtResourceList", sizeof(testStruct.resources), sizeof(XtResourceList));
	myXtResourceList = testStruct.resources;
	pmyXtResourceList = &testStruct.resources;

	check_size("ObjectClassPart.num_resources", "Cardinal", sizeof(testStruct.num_resources), sizeof(Cardinal));
	myCardinal = testStruct.num_resources;
	pmyCardinal = &testStruct.num_resources;

	check_size("ObjectClassPart.xrm_class", "XrmClass", sizeof(testStruct.xrm_class), sizeof(XrmClass));
	myXrmClass = testStruct.xrm_class;
	pmyXrmClass = &testStruct.xrm_class;

	check_size("ObjectClassPart.obj4", "Boolean", sizeof(testStruct.obj4), sizeof(Boolean));
	myBoolean = testStruct.obj4;
	pmyBoolean = &testStruct.obj4;

	check_size("ObjectClassPart.obj5", "XtEnum", sizeof(testStruct.obj5), sizeof(XtEnum));
	myXtEnum = testStruct.obj5;
	pmyXtEnum = &testStruct.obj5;

	check_size("ObjectClassPart.obj6", "Boolean", sizeof(testStruct.obj6), sizeof(Boolean));
	myBoolean = testStruct.obj6;
	pmyBoolean = &testStruct.obj6;

	check_size("ObjectClassPart.obj7", "Boolean", sizeof(testStruct.obj7), sizeof(Boolean));
	myBoolean = testStruct.obj7;
	pmyBoolean = &testStruct.obj7;

	check_size("ObjectClassPart.destroy", "XtWidgetProc", sizeof(testStruct.destroy), sizeof(XtWidgetProc));
	myXtWidgetProc = testStruct.destroy;
	pmyXtWidgetProc = &testStruct.destroy;

	check_size("ObjectClassPart.obj8", "XtProc", sizeof(testStruct.obj8), sizeof(XtProc));
	myXtProc = testStruct.obj8;
	pmyXtProc = &testStruct.obj8;

	check_size("ObjectClassPart.obj9", "XtProc", sizeof(testStruct.obj9), sizeof(XtProc));
	myXtProc = testStruct.obj9;
	pmyXtProc = &testStruct.obj9;

	check_size("ObjectClassPart.set_values", "XtSetValuesFunc", sizeof(testStruct.set_values), sizeof(XtSetValuesFunc));
	myXtSetValuesFunc = testStruct.set_values;
	pmyXtSetValuesFunc = &testStruct.set_values;

	check_size("ObjectClassPart.set_values_hook", "XtArgsFunc", sizeof(testStruct.set_values_hook), sizeof(XtArgsFunc));
	myXtArgsFunc = testStruct.set_values_hook;
	pmyXtArgsFunc = &testStruct.set_values_hook;

	check_size("ObjectClassPart.obj10", "XtProc", sizeof(testStruct.obj10), sizeof(XtProc));
	myXtProc = testStruct.obj10;
	pmyXtProc = &testStruct.obj10;

	check_size("ObjectClassPart.get_values_hook", "XtArgsProc", sizeof(testStruct.get_values_hook), sizeof(XtArgsProc));
	myXtArgsProc = testStruct.get_values_hook;
	pmyXtArgsProc = &testStruct.get_values_hook;

	check_size("ObjectClassPart.obj11", "XtProc", sizeof(testStruct.obj11), sizeof(XtProc));
	myXtProc = testStruct.obj11;
	pmyXtProc = &testStruct.obj11;

	check_size("ObjectClassPart.version", "XtVersionType", sizeof(testStruct.version), sizeof(XtVersionType));
	myXtVersionType = testStruct.version;
	pmyXtVersionType = &testStruct.version;

	check_size("ObjectClassPart.callback_private", "XtPointer", sizeof(testStruct.callback_private), sizeof(XtPointer));
	myXtPointer = testStruct.callback_private;
	pmyXtPointer = &testStruct.callback_private;

	check_size("ObjectClassPart.obj12", "String", sizeof(testStruct.obj12), sizeof(String));
	myString = testStruct.obj12;
	pmyString = &testStruct.obj12;

	check_size("ObjectClassPart.obj13", "XtProc", sizeof(testStruct.obj13), sizeof(XtProc));
	myXtProc = testStruct.obj13;
	pmyXtProc = &testStruct.obj13;

	check_size("ObjectClassPart.obj14", "XtProc", sizeof(testStruct.obj14), sizeof(XtProc));
	myXtProc = testStruct.obj14;
	pmyXtProc = &testStruct.obj14;

	check_size("ObjectClassPart.extension", "XtPointer", sizeof(testStruct.extension), sizeof(XtPointer));
	myXtPointer = testStruct.extension;
	pmyXtPointer = &testStruct.extension;
	tet_result(TET_PASS);
>>ASSERTION Good A
The class record structure for Objects ObjectClassRec
shall be defined and contain the fields listed in
section 14.2.1 of the Specification.
>>CODE
ObjectClassRec testStruct;

	check_size("ObjectClassRec.object_class.superclass", "WidgetClass", sizeof(testStruct.object_class.superclass), sizeof(WidgetClass));
	myWidgetClass = testStruct.object_class.superclass;
	pmyWidgetClass = &testStruct.object_class.superclass;

	check_size("ObjectClassRec.object_class.class_name", "String", sizeof(testStruct.object_class.class_name), sizeof(String));

	check_size("ObjectClassRec.object_class.widget_size", "Cardinal", sizeof(testStruct.object_class.widget_size), sizeof(Cardinal));
	myCardinal = testStruct.object_class.widget_size;
	pmyCardinal = &testStruct.object_class.widget_size;

	check_size("ObjectClassRec.object_class.class_initialize", "XtProc", sizeof(testStruct.object_class.class_initialize), sizeof(XtProc));
	myXtProc = testStruct.object_class.class_initialize;
	pmyXtProc = &testStruct.object_class.class_initialize;

	check_size("ObjectClassRec.object_class.class_part_initialize", "XtWidgetClassProc", sizeof(testStruct.object_class.class_part_initialize), sizeof(XtWidgetClassProc));
	myXtWidgetClassProc = testStruct.object_class.class_part_initialize;
	pmyXtWidgetClassProc = &testStruct.object_class.class_part_initialize;

	check_size("ObjectClassRec.object_class.class_inited", "XtEnum", sizeof(testStruct.object_class.class_inited), sizeof(XtEnum));
	myXtEnum = testStruct.object_class.class_inited;
	pmyXtEnum = &testStruct.object_class.class_inited;

	check_size("ObjectClassRec.object_class.initialize", "XtInitProc", sizeof(testStruct.object_class.initialize), sizeof(XtInitProc));
	myXtInitProc = testStruct.object_class.initialize;
	pmyXtInitProc = &testStruct.object_class.initialize;

	check_size("ObjectClassRec.object_class.initialize_hook", "XtArgsProc", sizeof(testStruct.object_class.initialize_hook), sizeof(XtArgsProc));
	myXtArgsProc = testStruct.object_class.initialize_hook;
	pmyXtArgsProc = &testStruct.object_class.initialize_hook;

	check_size("ObjectClassRec.object_class.obj1", "XtProc", sizeof(testStruct.object_class.obj1), sizeof(XtProc));
	myXtProc = testStruct.object_class.obj1;
	pmyXtProc = &testStruct.object_class.obj1;

	check_size("ObjectClassRec.object_class.obj2", "XtPointer", sizeof(testStruct.object_class.obj2), sizeof(XtPointer));
	myXtPointer = testStruct.object_class.obj2;
	pmyXtPointer = &testStruct.object_class.obj2;

	check_size("ObjectClassRec.object_class.obj3", "Cardinal", sizeof(testStruct.object_class.obj3), sizeof(Cardinal));
	myCardinal = testStruct.object_class.obj3;
	pmyCardinal = &testStruct.object_class.obj3;

	check_size("ObjectClassRec.object_class.resources", "XtResourceList", sizeof(testStruct.object_class.resources), sizeof(XtResourceList));
	myXtResourceList = testStruct.object_class.resources;
	pmyXtResourceList = &testStruct.object_class.resources;

	check_size("ObjectClassRec.object_class.num_resources", "Cardinal", sizeof(testStruct.object_class.num_resources), sizeof(Cardinal));
	myCardinal = testStruct.object_class.num_resources;
	pmyCardinal = &testStruct.object_class.num_resources;

	check_size("ObjectClassRec.object_class.xrm_class", "XrmClass", sizeof(testStruct.object_class.xrm_class), sizeof(XrmClass));
	myXrmClass = testStruct.object_class.xrm_class;
	pmyXrmClass = &testStruct.object_class.xrm_class;

	check_size("ObjectClassRec.object_class.obj4", "Boolean", sizeof(testStruct.object_class.obj4), sizeof(Boolean));
	myBoolean = testStruct.object_class.obj4;
	pmyBoolean = &testStruct.object_class.obj4;

	check_size("ObjectClassRec.object_class.obj5", "XtEnum", sizeof(testStruct.object_class.obj5), sizeof(XtEnum));
	myXtEnum = testStruct.object_class.obj5;
	pmyXtEnum = &testStruct.object_class.obj5;

	check_size("ObjectClassRec.object_class.obj6", "Boolean", sizeof(testStruct.object_class.obj6), sizeof(Boolean));
	myBoolean = testStruct.object_class.obj6;
	pmyBoolean = &testStruct.object_class.obj6;

	check_size("ObjectClassRec.object_class.obj7", "Boolean", sizeof(testStruct.object_class.obj7), sizeof(Boolean));
	myBoolean = testStruct.object_class.obj7;
	pmyBoolean = &testStruct.object_class.obj7;

	check_size("ObjectClassRec.object_class.destroy", "XtWidgetProc", sizeof(testStruct.object_class.destroy), sizeof(XtWidgetProc));
	myXtWidgetProc = testStruct.object_class.destroy;
	pmyXtWidgetProc = &testStruct.object_class.destroy;

	check_size("ObjectClassRec.object_class.obj8", "XtProc", sizeof(testStruct.object_class.obj8), sizeof(XtProc));
	myXtProc = testStruct.object_class.obj8;
	pmyXtProc = &testStruct.object_class.obj8;

	check_size("ObjectClassRec.object_class.obj9", "XtProc", sizeof(testStruct.object_class.obj9), sizeof(XtProc));
	myXtProc = testStruct.object_class.obj9;
	pmyXtProc = &testStruct.object_class.obj9;

	check_size("ObjectClassRec.object_class.set_values", "XtSetValuesFunc", sizeof(testStruct.object_class.set_values), sizeof(XtSetValuesFunc));
	myXtSetValuesFunc = testStruct.object_class.set_values;
	pmyXtSetValuesFunc = &testStruct.object_class.set_values;

	check_size("ObjectClassRec.object_class.set_values_hook", "XtArgsFunc", sizeof(testStruct.object_class.set_values_hook), sizeof(XtArgsFunc));
	myXtArgsFunc = testStruct.object_class.set_values_hook;
	pmyXtArgsFunc = &testStruct.object_class.set_values_hook;

	check_size("ObjectClassRec.object_class.obj10", "XtProc", sizeof(testStruct.object_class.obj10), sizeof(XtProc));
	myXtProc = testStruct.object_class.obj10;
	pmyXtProc = &testStruct.object_class.obj10;

	check_size("ObjectClassRec.object_class.get_values_hook", "XtArgsProc", sizeof(testStruct.object_class.get_values_hook), sizeof(XtArgsProc));
	myXtArgsProc = testStruct.object_class.get_values_hook;
	pmyXtArgsProc = &testStruct.object_class.get_values_hook;

	check_size("ObjectClassRec.object_class.obj11", "XtProc", sizeof(testStruct.object_class.obj11), sizeof(XtProc));
	myXtProc = testStruct.object_class.obj11;
	pmyXtProc = &testStruct.object_class.obj11;

	check_size("ObjectClassRec.object_class.version", "XtVersionType", sizeof(testStruct.object_class.version), sizeof(XtVersionType));
	myXtVersionType = testStruct.object_class.version;
	pmyXtVersionType = &testStruct.object_class.version;

	check_size("ObjectClassRec.object_class.callback_private", "XtPointer", sizeof(testStruct.object_class.callback_private), sizeof(XtPointer));
	myXtPointer = testStruct.object_class.callback_private;
	pmyXtPointer = &testStruct.object_class.callback_private;

	check_size("ObjectClassRec.object_class.obj12", "String", sizeof(testStruct.object_class.obj12), sizeof(String));
	myString = testStruct.object_class.obj12;
	pmyString = &testStruct.object_class.obj12;

	check_size("ObjectClassRec.object_class.obj13", "XtProc", sizeof(testStruct.object_class.obj13), sizeof(XtProc));
	myXtProc = testStruct.object_class.obj13;
	pmyXtProc = &testStruct.object_class.obj13;

	check_size("ObjectClassRec.object_class.obj14", "XtProc", sizeof(testStruct.object_class.obj14), sizeof(XtProc));
	myXtProc = testStruct.object_class.obj14;
	pmyXtProc = &testStruct.object_class.obj14;

	check_size("ObjectClassRec.object_class.extension", "XtPointer", sizeof(testStruct.object_class.extension), sizeof(XtPointer));
	myXtPointer = testStruct.object_class.extension;
	pmyXtPointer = &testStruct.object_class.extension;
	tet_result(TET_PASS);
>>ASSERTION Good A
The class record for objects objectClassRec shall
exist and be an instance of the ObjectClassRec
structure.
>>CODE

	check_size("objectClassRec.object_class.superclass", "WidgetClass", sizeof(objectClassRec.object_class.superclass), sizeof(WidgetClass));
	myWidgetClass = objectClassRec.object_class.superclass;
	pmyWidgetClass = &objectClassRec.object_class.superclass;

	check_size("objectClassRec.object_class.class_name", "String", sizeof(objectClassRec.object_class.class_name), sizeof(String));
	myString = objectClassRec.object_class.class_name;
	pmyString = &objectClassRec.object_class.class_name;

	check_size("objectClassRec.object_class.widget_size", "Cardinal", sizeof(objectClassRec.object_class.widget_size), sizeof(Cardinal));
	myCardinal = objectClassRec.object_class.widget_size;
	pmyCardinal = &objectClassRec.object_class.widget_size;

	check_size("objectClassRec.object_class.class_initialize", "XtProc", sizeof(objectClassRec.object_class.class_initialize), sizeof(XtProc));
	myXtProc = objectClassRec.object_class.class_initialize;
	pmyXtProc = &objectClassRec.object_class.class_initialize;

	check_size("objectClassRec.object_class.class_part_initialize", "XtWidgetClassProc", sizeof(objectClassRec.object_class.class_part_initialize), sizeof(XtWidgetClassProc));
	myXtWidgetClassProc = objectClassRec.object_class.class_part_initialize;
	pmyXtWidgetClassProc = &objectClassRec.object_class.class_part_initialize;

	check_size("objectClassRec.object_class.class_inited", "XtEnum", sizeof(objectClassRec.object_class.class_inited), sizeof(XtEnum));
	myXtEnum = objectClassRec.object_class.class_inited;
	pmyXtEnum = &objectClassRec.object_class.class_inited;

	check_size("objectClassRec.object_class.initialize", "XtInitProc", sizeof(objectClassRec.object_class.initialize), sizeof(XtInitProc));
	myXtInitProc = objectClassRec.object_class.initialize;
	pmyXtInitProc = &objectClassRec.object_class.initialize;

	check_size("objectClassRec.object_class.initialize_hook", "XtArgsProc", sizeof(objectClassRec.object_class.initialize_hook), sizeof(XtArgsProc));
	myXtArgsProc = objectClassRec.object_class.initialize_hook;
	pmyXtArgsProc = &objectClassRec.object_class.initialize_hook;

	check_size("objectClassRec.object_class.obj1", "XtProc", sizeof(objectClassRec.object_class.obj1), sizeof(XtProc));
	myXtProc = objectClassRec.object_class.obj1;
	pmyXtProc = &objectClassRec.object_class.obj1;

	check_size("objectClassRec.object_class.obj2", "XtPointer", sizeof(objectClassRec.object_class.obj2), sizeof(XtPointer));
	myXtPointer = objectClassRec.object_class.obj2;
	pmyXtPointer = &objectClassRec.object_class.obj2;

	check_size("objectClassRec.object_class.obj3", "Cardinal", sizeof(objectClassRec.object_class.obj3), sizeof(Cardinal));
	myCardinal = objectClassRec.object_class.obj3;
	pmyCardinal = &objectClassRec.object_class.obj3;

	check_size("objectClassRec.object_class.resources", "XtResourceList", sizeof(objectClassRec.object_class.resources), sizeof(XtResourceList));
	myXtResourceList = objectClassRec.object_class.resources;
	pmyXtResourceList = &objectClassRec.object_class.resources;

	check_size("objectClassRec.object_class.num_resources", "Cardinal", sizeof(objectClassRec.object_class.num_resources), sizeof(Cardinal));
	myCardinal = objectClassRec.object_class.num_resources;
	pmyCardinal = &objectClassRec.object_class.num_resources;

	check_size("objectClassRec.object_class.xrm_class", "XrmClass", sizeof(objectClassRec.object_class.xrm_class), sizeof(XrmClass));
	myXrmClass = objectClassRec.object_class.xrm_class;
	pmyXrmClass = &objectClassRec.object_class.xrm_class;

	check_size("objectClassRec.object_class.obj4", "Boolean", sizeof(objectClassRec.object_class.obj4), sizeof(Boolean));
	myBoolean = objectClassRec.object_class.obj4;
	pmyBoolean = &objectClassRec.object_class.obj4;

	check_size("objectClassRec.object_class.obj5", "XtEnum", sizeof(objectClassRec.object_class.obj5), sizeof(XtEnum));
	myXtEnum = objectClassRec.object_class.obj5;
	pmyXtEnum = &objectClassRec.object_class.obj5;

	check_size("objectClassRec.object_class.obj6", "Boolean", sizeof(objectClassRec.object_class.obj6), sizeof(Boolean));
	myBoolean = objectClassRec.object_class.obj6;
	pmyBoolean = &objectClassRec.object_class.obj6;

	check_size("objectClassRec.object_class.obj7", "Boolean", sizeof(objectClassRec.object_class.obj7), sizeof(Boolean));
	myBoolean = objectClassRec.object_class.obj7;
	pmyBoolean = &objectClassRec.object_class.obj7;

	check_size("objectClassRec.object_class.destroy", "XtWidgetProc", sizeof(objectClassRec.object_class.destroy), sizeof(XtWidgetProc));
	myXtWidgetProc = objectClassRec.object_class.destroy;
	pmyXtWidgetProc = &objectClassRec.object_class.destroy;

	check_size("objectClassRec.object_class.obj8", "XtProc", sizeof(objectClassRec.object_class.obj8), sizeof(XtProc));
	myXtProc = objectClassRec.object_class.obj8;
	pmyXtProc = &objectClassRec.object_class.obj8;

	check_size("objectClassRec.object_class.obj9", "XtProc", sizeof(objectClassRec.object_class.obj9), sizeof(XtProc));
	myXtProc = objectClassRec.object_class.obj9;
	pmyXtProc = &objectClassRec.object_class.obj9;

	check_size("objectClassRec.object_class.set_values", "XtSetValuesFunc", sizeof(objectClassRec.object_class.set_values), sizeof(XtSetValuesFunc));
	myXtSetValuesFunc = objectClassRec.object_class.set_values;
	pmyXtSetValuesFunc = &objectClassRec.object_class.set_values;

	check_size("objectClassRec.object_class.set_values_hook", "XtArgsFunc", sizeof(objectClassRec.object_class.set_values_hook), sizeof(XtArgsFunc));
	myXtArgsFunc = objectClassRec.object_class.set_values_hook;
	pmyXtArgsFunc = &objectClassRec.object_class.set_values_hook;

	check_size("objectClassRec.object_class.obj10", "XtProc", sizeof(objectClassRec.object_class.obj10), sizeof(XtProc));
	myXtProc = objectClassRec.object_class.obj10;
	pmyXtProc = &objectClassRec.object_class.obj10;

	check_size("objectClassRec.object_class.get_values_hook", "XtArgsProc", sizeof(objectClassRec.object_class.get_values_hook), sizeof(XtArgsProc));
	myXtArgsProc = objectClassRec.object_class.get_values_hook;
	pmyXtArgsProc = &objectClassRec.object_class.get_values_hook;

	check_size("objectClassRec.object_class.obj11", "XtProc", sizeof(objectClassRec.object_class.obj11), sizeof(XtProc));
	myXtProc = objectClassRec.object_class.obj11;
	pmyXtProc = &objectClassRec.object_class.obj11;

	check_size("objectClassRec.object_class.version", "XtVersionType", sizeof(objectClassRec.object_class.version), sizeof(XtVersionType));
	myXtVersionType = objectClassRec.object_class.version;
	pmyXtVersionType = &objectClassRec.object_class.version;

	check_size("objectClassRec.object_class.callback_private", "XtPointer", sizeof(objectClassRec.object_class.callback_private), sizeof(XtPointer));
	myXtPointer = objectClassRec.object_class.callback_private;
	pmyXtPointer = &objectClassRec.object_class.callback_private;

	check_size("objectClassRec.object_class.obj12", "String", sizeof(objectClassRec.object_class.obj12), sizeof(String));
	myString = objectClassRec.object_class.obj12;
	pmyString = &objectClassRec.object_class.obj12;

	check_size("objectClassRec.object_class.obj13", "XtProc", sizeof(objectClassRec.object_class.obj13), sizeof(XtProc));
	myXtProc = objectClassRec.object_class.obj13;
	pmyXtProc = &objectClassRec.object_class.obj13;

	check_size("objectClassRec.object_class.obj14", "XtProc", sizeof(objectClassRec.object_class.obj14), sizeof(XtProc));
	myXtProc = objectClassRec.object_class.obj14;
	pmyXtProc = &objectClassRec.object_class.obj14;

	check_size("objectClassRec.object_class.extension", "XtPointer", sizeof(objectClassRec.object_class.extension), sizeof(XtPointer));
	myXtPointer = objectClassRec.object_class.extension;
	pmyXtPointer = &objectClassRec.object_class.extension;
	tet_result(TET_PASS);
>>ASSERTION Good A
The class pointer for objects objectClass shall exist
and point to the objectClassRec class record.
>>CODE

	tet_infoline("TEST: objectClass");
	if (objectClass != (WidgetClass)&objectClassRec) {
		sprintf(ebuf, "ERROR: objectClass does not point to objectClassRec");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
>>ASSERTION Good A
The type ObjectClass shall be defined as a pointer to
an object class structure.
>>CODE
ObjectClass testvar;
XtPointer testvar2;

	/* this will not build if the define is not correct*/
	tet_infoline("TEST: ObjectClass");
	testvar = &objectClassRec;
	testvar2 = testvar->object_class.superclass;
	tet_result(TET_PASS);
>>ASSERTION Good A
The instance structure for objects ObjectPart shall be
defined and contain the fields listed in section
14.2.2 of the Specification.
>>CODE
ObjectPart testStruct;

	check_size("ObjectPart.self", "Widget", sizeof(testStruct.self), sizeof(Widget));
	myWidget = testStruct.self;
	pmyWidget = &testStruct.self;

	check_size("ObjectPart.widget_class", "WidgetClass", sizeof(testStruct.widget_class), sizeof(WidgetClass));
	myWidgetClass = testStruct.widget_class;
	pmyWidgetClass = &testStruct.widget_class;

	check_size("ObjectPart.parent", "Widget", sizeof(testStruct.parent), sizeof(Widget));
	myWidget = testStruct.parent;
	pmyWidget = &testStruct.parent;

	check_size("ObjectPart.xrm_name", "XrmName", sizeof(testStruct.xrm_name), sizeof(XrmName));
	myXrmName = testStruct.xrm_name;
	pmyXrmName = &testStruct.xrm_name;

	check_size("ObjectPart.being_destroyed", "Boolean", sizeof(testStruct.being_destroyed), sizeof(Boolean));
	myBoolean = testStruct.being_destroyed;
	pmyBoolean = &testStruct.being_destroyed;

	check_size("ObjectPart.destroy_callbacks", "XtCallbackList", sizeof(testStruct.destroy_callbacks), sizeof(XtCallbackList));
	myXtCallbackList = testStruct.destroy_callbacks;
	pmyXtCallbackList = &testStruct.destroy_callbacks;

	check_size("ObjectPart.constraints", "XtPointer", sizeof(testStruct.constraints), sizeof(XtPointer));
	myXtPointer = testStruct.constraints;
	pmyXtPointer = &testStruct.constraints;

	tet_result(TET_PASS);
>>ASSERTION Good A
The instance record structure for objects ObjectRec
shall be defined and contain the fields listed in
section 14.2.2 of the Specification.
>>CODE
ObjectRec testStruct;

	check_size("ObjectRec.object.self", "Widget", sizeof(testStruct.object.self), sizeof(Widget));
	myWidget = testStruct.object.self;
	pmyWidget = &testStruct.object.self;

	check_size("ObjectRec.object.widget_class", "WidgetClass", sizeof(testStruct.object.widget_class), sizeof(WidgetClass));
	myWidgetClass = testStruct.object.widget_class;
	pmyWidgetClass = &testStruct.object.widget_class;

	check_size("ObjectRec.object.parent", "Widget", sizeof(testStruct.object.parent), sizeof(Widget));
	myWidget = testStruct.object.parent;
	pmyWidget = &testStruct.object.parent;

	check_size("ObjectRec.object.xrm_name", "XrmName", sizeof(testStruct.object.xrm_name), sizeof(XrmName));
	myXrmName = testStruct.object.xrm_name;
	pmyXrmName = &testStruct.object.xrm_name;

	check_size("ObjectRec.object.being_destroyed", "Boolean", sizeof(testStruct.object.being_destroyed), sizeof(Boolean));
	myBoolean = testStruct.object.being_destroyed;
	pmyBoolean = &testStruct.object.being_destroyed;

	check_size("ObjectRec.object.destroy_callbacks", "XtCallbackList", sizeof(testStruct.object.destroy_callbacks), sizeof(XtCallbackList));
	myXtCallbackList = testStruct.object.destroy_callbacks;
	pmyXtCallbackList = &testStruct.object.destroy_callbacks;

	check_size("ObjectRec.object.constraints", "XtPointer", sizeof(testStruct.object.constraints), sizeof(XtPointer));
	myXtPointer = testStruct.object.constraints;
	pmyXtPointer = &testStruct.object.constraints;

	tet_result(TET_PASS);
>>ASSERTION Good A
The type Object shall be defined as a pointer to an
object instance.
>>CODE
ObjectRec testobj;
Object testvar;
XtPointer testvar2;

	/* this will not build if the define is not correct*/
	tet_infoline("TEST: Object");
	/*doesn't matter where we point, just testing syntax*/
	testvar = &testobj;
	testvar2 = testvar->object.self;
	tet_result(TET_PASS);
>>ASSERTION Good A
The fields of the ObjectPart element of the ObjectRec
shall be initialized to the default values specified
in section 14.2.4 of the Specification on creation of
a new object instance.
>>CODE
Object testwidget;
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

	avs_xt_hier("Hobj9", "XtObject");
	tet_infoline("PREP: Create fresh object");
	testwidget = (Object)XtCreateWidget("ApTest", objectClass, topLevel, NULL, 0);
	tet_infoline("TEST: self");
	if (testwidget->object.self != (Widget)testwidget) {
		tet_infoline("ERROR: self member is not address of widget structure");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: widget_class");
	if (testwidget->object.widget_class != objectClass) {
		tet_infoline("ERROR: widget_class member is not coreWidgetClass");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: parent");
	if (testwidget->object.parent != topLevel) {
		tet_infoline("ERROR: parent member is not address of parent widget structure");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: being_destroyed");
	if (testwidget->object.being_destroyed != topLevel->core.being_destroyed) {
		sprintf(ebuf, "ERROR: Expected being_destroyed of %#x, is %#x", topLevel->core.being_destroyed, testwidget->object.being_destroyed);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: destroy_callbacks");
	if (testwidget->object.destroy_callbacks != NULL) {
		tet_infoline("ERROR: destroy_callbacks member is not NULL");
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: constraints");
	if (testwidget->object.constraints != NULL) {
		tet_infoline("ERROR: constraints member is not NULL");
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
