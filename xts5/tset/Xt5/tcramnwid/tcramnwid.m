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
$Header: /cvs/xtest/xtest/xts5/tset/Xt5/tcramnwid/tcramnwid.m,v 1.1 2005-02-12 14:38:14 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt5/tcramnwid/tcramnwid.m
>># 
>># Description:
>>#	Tests for XtCreateManagedWidget()
>># 
>># Modifications:
>># $Log: tcramnwid.m,v $
>># Revision 1.1  2005-02-12 14:38:14  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:36:34  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:59:27  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:27:44  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:18  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:16:33  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:20:32  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>
#include <X11/Xaw/Label.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;
>>TITLE XtCreateManagedWidget Xt5
Widget
XtCreateManagedWidget(name, widget_class, parent, args, num_args)
>>ASSERTION Good A
A call to 
Widget XtCreateManagedWidget(name, widget_class, parent,
args, num_args) 
shall create an instance of a widget belonging to the class
widget_class, set the widget to be managed by its parent, and return 
a pointer to the newly created widget instance structure.
>>CODE
Boolean status;
Widget widget_good , labelw_good;
Widget rowcolw_good;

	avs_xt_hier("Tcramnwid1", "XtCreateManagedWidget");
	tet_infoline("PREP: Create rowcolw_good widget in box1w widget");
	rowcolw_good = (Widget) CreateRowColWidget(boxw1);
	tet_infoline("TEST: Create label widget Hello");
	labelw_good = XtCreateManagedWidget(
			"Hello",
			labelWidgetClass,
			rowcolw_good,
			(ArgList)NULL,
			(Cardinal)NULL);
	tet_infoline("TEST: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: labelw_good widget is managed");
	status = XtIsManaged(labelw_good);
	check_dec(True, status, "XtIsManaged return value");
	tet_infoline("TEST: labelw_good widget is child of rowcolumn widget");
	widget_good = (Widget)XtParent(labelw_good);
	if (widget_good == NULL) {
	 	sprintf(ebuf, "ERROR: Expected parent widget instance returned NULL");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	check_str("rowcolw", XtName(widget_good), "Widget name");
	tet_result(TET_PASS);
>>ASSERTION Good B 0
A successful call to 
Widget XtCreateManagedWidget(name, widget_class, parent, args, num_args)
shall initialize the resource fields of the widget instance using the
CoreClassPart resource list specified for widget_class and all superclasses,
overridden by the resource values specified in args.
>>ASSERTION Good B 0
When parent is a subclass of constraintWidgetClass a successful call to Widget
XtCreateManagedWidget(name, widget_class, parent, args, num_args)
shall initialize the resource fields of the constraint record by
using the constraint resource list specified for the parent's class 
and all superclasses up to constraintWidgetClass, overridden by the resource
values specified in args.
>>ASSERTION Good B 0
When parent is a subclass of compositeWidgetClass a successful call to 
Widget XtCreateManagedWidget(name, widget_class, parent, args, num_args)
shall call the insert_child procedure of the parent.
>>ASSERTION Good B 0
A call to Widget XtCreateManagedWidget(name, widget_class, parent, args, 
num_args) when widget_class is not a member of coreWidgetClass, the class 
of parent is a subclass of compositeWidgetClass, and there is no extension 
record in the composite class part extension field of parent with the 
record_type equal to NULLQUARK shall issue a fatal error.
>>ASSERTION Good B 0
A call to 
Widget XtCreateManagedWidget(name, widget_class, parent, args, 
num_args)
when widget_class is not a member of coreWidgetClass, the class of 
parent is a subclass of compositeWidgetClass, and the accepts_object 
field in parent's composite class part extension record is False shall issue
a fatal error.
>>ASSERTION Good B 0
A successful call to 
Widget XtCreateManagedWidget(name, widget_class, parent, args, 
num_args) 
shall invoke the class_initialize procedure for the class
widget_class and all superclasses for which this procedure has not been
invoked prior to this call in a superclass-to-subclass order.
>>ASSERTION Good B 0
A successful call to 
Widget XtCreateManagedWidget(name, widget_class, parent, args, 
num_args) 
when parent belongs to the class constraintWidgetClass or a
subclass thereof shall allocate memory for the constraints of parent
and store the address of this memory in the constraints field of the
widget instance structure.
>>ASSERTION Good B 0
A successful call to 
Widget XtCreateManagedWidget(name, widget_class, parent, args, 
num_args) 
shall initialize the Core non-resource data fields of the widget instance 
structure.
>>ASSERTION Good B 0
A successful call to 
Widget XtCreateManagedWidget(name, widget_class, parent, args, 
num_args) 
shall call the initialize procedure of Object and all
the initialize procedures down to initialize procedure of the widget.
>>ASSERTION Good B 0
A successful call to 
Widget XtCreateManagedWidget(name, widget_class, parent, args, 
num_args) 
when parent belongs to the class contraintWidgetClass
or a subclass thereof shall call all the ConstraintClassPart initialize 
procedures starting at constraintWidgetClass down to ConstraintClassPart 
initialize procedure of the parent.
>>ASSERTION Good B 0
A call to 
Widget XtCreateManagedWidget(name, widget_class, parent, args, num_args)
when the newly created widget has the map_when_managed field set to True and 
parent is realized shall call the change_managed procedure of the parent, 
realize the widget, and map the widget window.
>>ASSERTION Good B 0
On a successful call to 
Widget XtCreateManagedWidget(name, widget_class, parent, args, num_args)
when the newly created widget has the map_when_managed field set to a value 
other than True shall not have its window mapped.
>>ASSERTION Good B 0
A call to 
Widget XtCreateManagedWidget(name, widget_class, parent, args, num_args)
when parent does not belong to a subclass of compositeWidgetClass shall issue
an invalidParent error.
>>ASSERTION Good B 0
A call to 
Widget XtCreateManagedWidget(name, widget_class, parent, args, num_args)
when parent is in the process of being destroyed shall return immediately.
