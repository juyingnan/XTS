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
$Header: /cvs/xtest/xtest/xts5/tset/Xt11/tgtconrsl/tgtconrsl.m,v 1.1 2005-02-12 14:37:53 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt11/tgtconrsl/tgtconrsl.m
>># 
>># Description:
>>#	Tests for XtGetConstraintResourceList()
>># 
>># Modifications:
>># $Log: tgtconrsl.m,v $
>># Revision 1.1  2005-02-12 14:37:53  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:37:22  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:00:18  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:28:27  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:25:01  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:19:17  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:13:55  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>
#include <X11/Xaw/Form.h>
#include <X11/Xaw/Label.h>
#include <AvsForm.h>
#include <AvsForm2.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;

void XtWMH_Proc(str1, str2, str3, str4, str5, car)
String str1, str2, str3, str4, *str5;
Cardinal *car;
{
}

>>TITLE XtGetConstraintResourceList Xt11
void
XtGetConstraintResourceList(class, resources_return, num_resources_return)
>>ASSERTION Good A
When the widget class 
.A class
is not initialized a successful call to
void XtGetConstraintResourceList(class, resources_return, num_resources_return)
shall return a pointer to the resource list as 
specified in the widget class Constraint part in
.A resources_return
and the number of resources in this list in
.A num_resources_return.
>>CODE
Widget formw_good, labelw_good;
XtResourceList resources_return;
Cardinal num_resources_return;
Boolean resize_value;
int i;
int found;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tgtconrsl1", "XtGetConstraintResourceList");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get avsform2 class resource list");
	XtGetConstraintResourceList(avsform2WidgetClass, &resources_return, &num_resources_return);
	tet_infoline("TEST: Resource count does not include superclass'");
	if (num_resources_return != 1) {
		sprintf(ebuf, "ERROR: Number of resources returned %d, should be 1", num_resources_return);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}

	tet_infoline("TEST: avsform2's XtNresizable resource in list");
	found = 0;
	for ( i = 0; i < num_resources_return; i++ ) {
		if (strcmp(XtNresizable, resources_return[i].resource_name) == 0 ) {
	 		found = 1;
	 		check_dec(FALSE, (long)resources_return[i].default_addr, XtNresizable);
	 	} /* end if */
	} /* end for */
	if (!found) {
		sprintf(ebuf, "ERROR: Did not find XtNresizable resource value");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	 }
	
	tet_infoline("TEST: Superclass' XtNfromVert resource not in list");
	found = 0;
	for ( i = 0; i < num_resources_return; i++ ) {
		if (strcmp(XtNfromVert, (char *)resources_return[i].resource_name) == 0 ) {
			sprintf(ebuf, "ERROR: Found XtNfromVert resource");
			tet_infoline(ebuf);
			tet_result(TET_FAIL);
	 	}
	}
	tet_infoline("CLEANUP: Free the resource list.");
	XtFree((void *)resources_return);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When the widget class 
.A class
is initialized a successful call to
void XtGetConstraintResourceList(class, resources_return, num_resources_return)
shall return a pointer to the merged resource list that 
includes the resources as specified in the widget class Constraint 
part and for all Constraint superclasses in
.A resources_return
and the number of resources in this list in
.A num_resources_return.
>>CODE
XtResourceList resources_return;
Cardinal num_resources_return;
int i , value;
Widget formw_good, labelw_msg;
int found;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tgtconrsl2", "XtGetConstraintResourceList");
	XtAppSetWarningMsgHandler(app_ctext, XtWMH_Proc);
	tet_infoline("PREP: Create avs2form widget in boxw1 widget");
	formw_good = XtCreateManagedWidget("avsform2",
			avsform2WidgetClass,
			boxw1,
			NULL,
			0);
	labelw_msg = (Widget) CreateLabelWidget("ApTest", formw_good);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get avsform2 class resource list");
	XtGetConstraintResourceList(avsform2WidgetClass, &resources_return, &num_resources_return);
	tet_infoline("TEST: Resource count includes superclass'");
	if (num_resources_return != 9 ) {
		sprintf(ebuf, "ERROR: Resource list size was %d, expected 9 - did not include superclass resource.", num_resources_return);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Superclass' XtNfromVert resource in list");
	found = 0;
	for ( i = 0; i < num_resources_return; i++ ) {
		if (strcmp(XtNfromVert, resources_return[i].resource_name) == 0 ) {
			found = 1;
			check_dec(0, (long)resources_return[i].default_addr, "XtNfromVert value");
		} /* end if */
	} /* end for */
	if (!found) {
	 	sprintf(ebuf, "ERROR: Could not find XtNfromVert resource value");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: avsform2's XtNresizable resource in list");
	found = 0;
	for ( i = 0; i < num_resources_return; i++ ) {
		if (strcmp(XtNresizable, resources_return[i].resource_name) == 0 ) {
			found = 1;
			check_dec(FALSE, (long)resources_return[i].default_addr, "XtNresizable value");
		} /* end if */
	} /* end for */
	if (!found) {
	 	sprintf(ebuf, "ERROR: Could not find XtNresizable resource value");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
A call to
void XtGetConstraintResourceList(class, resources_return, num_resources_return)
when 
.A class 
is not a subclass of
constraintWidgetClass 
shall set 
.A resources_return 
to NULL and 
.A num_resources_return 
to zero.
>>CODE
Widget labelw_good;
XtResourceList resources_return;
Cardinal num_resources_return;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tgtconrsl3", "XtGetConstraintResourceList");
	tet_infoline("PREP: Create label widget");
	labelw_good = (Widget) CreateLabelWidget("ApTest", boxw1);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get label widget resource list");
	XtGetConstraintResourceList(labelWidgetClass, &resources_return, &num_resources_return);
	tet_infoline("TEST: Resources_return and num_resources_return values");
	if (resources_return != NULL) {
			sprintf(ebuf, "ERROR: Expected resources_return NULL");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	check_dec(0, (long)num_resources_return, "Number of Resources");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
