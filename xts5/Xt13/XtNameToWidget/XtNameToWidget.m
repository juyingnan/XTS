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
$Header: /cvs/xtest/xtest/xts5/tset/Xt13/XtNameToWidget/XtNameToWidget.m,v 1.1 2005-02-12 14:37:58 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt13/XtNameToWidget/XtNameToWidget.m
>># 
>># Description:
>>#	Tests for XtNameToWidget()
>># 
>># Modifications:
>># $Log: tnmtowidg.m,v $
>># Revision 1.1  2005-02-12 14:37:58  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:38:06  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:05  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:29:08  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:25:42  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:21:24  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:17:20  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;
>>TITLE XtNameToWidget Xt13
Widget
XtNameToWidget(reference, names)
>>ASSERTION Good A
When 
.A names
specifies a simple object name
a successful call to 
Widget XtNameToWidget(reference, names)
shall return a pointer to the immediate descendant of the
widget
.A reference
that matches the specified name.
>>CODE
Widget labelw_good, widget_good;
char string[10];
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tnmtowidg1", "XtNameToWidget");
	tet_infoline("PREP: Create test label widget name `Hello' in rowcol widget");
	labelw_good = (Widget) CreateLabelWidget("Hello", rowcolw);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Unqualified child name returns direct descendent");
	if ((widget_good = (Widget)XtNameToWidget(rowcolw, "Hello")) == NULL) {
			sprintf(ebuf, "ERROR: Expected a Widget, got NULL");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	strcpy(string, XtName(widget_good) );
	check_str("Hello", string, "Widget name");
	tet_infoline("TEST: Unqualified child name returns only direct descendent");
	if ((widget_good = (Widget)XtNameToWidget(boxw1, "Hello")) != NULL) {
		sprintf(ebuf, "ERROR: Expected NULL, got a Widget");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When 
.A names
specifies a series of simple object name
components separated by periods and asterisks
a successful call to 
Widget XtNameToWidget(reference, names)
shall search the subtree rooted at the widget
.A reference
in a breadth-first order for the first object that matches
the specified name, where each component of
.A names
matches exactly the corresponding component of the 
name obtained by qualifying the object name and names of all
its ancestors up to but not including the widget
.A reference
and asterisk matches any series of components, including
none, and return a pointer to it.
>>CODE
Widget labelw_good, widget_good;
char string[10];
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tnmtowidg3", "XtNameToWidget");
	tet_infoline("PREP: Create test label widget name `Hello' in rowcol widget");
	labelw_good = (Widget) CreateLabelWidget("Hello", rowcolw);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Name with period returns correct descendent");
	if ((widget_good = (Widget)XtNameToWidget(boxw1, "rowcolw.Hello")) == NULL) {
		sprintf(ebuf, "ERROR: Expected a Widget, got NULL");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	strcpy(string, XtName(widget_good) );
	check_str("Hello", string, "Widget name");
	tet_infoline("TEST: Name with asterisk returns correct descendent");
	if ((widget_good = (Widget)XtNameToWidget(boxw1, "*Hello")) == NULL) {
		sprintf(ebuf, "ERROR: Expected a Widget, got NULL");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	strcpy(string, XtName(widget_good) );
	check_str("Hello", string, "Widget name");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
A call to 
Widget XtNameToWidget(reference, names)
when no object matching
.A names
exists in the subtree rooted at the widget
.A reference
shall return NULL.
>>CODE
Widget widget_bad;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tnmtowidg2", "XtNameToWidget");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Non-existant widget shall return NULL");
	if ((widget_bad = (Widget)XtNameToWidget(rowcolw, "Help")) != NULL ) {
		sprintf(ebuf, "ERROR: Expected NULL returned widget instance");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good B 2
The object returned by a call to
Widget XtNameToWidget(reference, names)
when multiple objects that match
.A names
exist at the same level in the subtree rooted at
.A reference.
>>ASSERTION Good A
A call to 
Widget XtNameToWidget(reference, names)
shall interpret consecutive asterisks in
.A names
as a single asterisk.
>>CODE
Widget labelw_good, widget_good;
char string[10];
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tnmtowidg6", "XtNameToWidget");
	tet_infoline("PREP: Create test label widget name `Hello' in rowcol widget");
	labelw_good = (Widget) CreateLabelWidget("Hello", rowcolw);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Multiple asterisks same as one");
	if ((widget_good = (Widget)XtNameToWidget(boxw1, "*****Hello")) == NULL) {
		sprintf(ebuf, "ERROR: Expected a Widget, got NULL");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	strcpy(string, XtName(widget_good) );
	check_str("Hello", string, "Widget name");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
A call to 
Widget XtNameToWidget(reference, names)
shall interpret consecutive periods that include
at least one asterisk in
.A names
as a single asterisk.
>>CODE
Widget labelw_good, widget_good;
char string[10];
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tnmtowidg6", "XtNameToWidget");
	tet_infoline("PREP: Create test label widget name `Hello' in rowcol widget");
	labelw_good = (Widget) CreateLabelWidget("Hello", rowcolw);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Consecutive periods and asterisks same as one asterisk");
	if ((widget_good = (Widget)XtNameToWidget(boxw1, ".*...Hello")) == NULL) {
		sprintf(ebuf, "ERROR: Expected a Widget, got NULL");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	strcpy(string, XtName(widget_good) );
	check_str("Hello", string, "Widget name");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
A call to 
Widget XtNameToWidget(reference, names)
shall interpret consecutive periods in 
.A names 
as a single period.
>>CODE
Widget labelw_good, widget_good;
char string[10];
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tnmtowidg5", "XtNameToWidget");
	tet_infoline("PREP: Create test label widget name `Hello' in rowcol widget");
	labelw_good = (Widget) CreateLabelWidget("Hello", rowcolw);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Multiple periods same as one");
	if ((widget_good = (Widget)XtNameToWidget(boxw1, "rowcolw....Hello")) == NULL) {
		sprintf(ebuf, "ERROR: Expected a Widget, got NULL");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	strcpy(string, XtName(widget_good) );
	check_str("Hello", string, "Widget name");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
