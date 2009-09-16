/*
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
*/
/*
* 
* Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
* Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
* All Rights Reserved.
* 
* Project: VSW5
* 
* File: tset/Xt3/XtCheckSubclass/Test12.c
* 
* Description:
*	Tests for assertions 1 and 2.  Since DEBUG must be defined for 
*	these tests this needs to be a separate compilation unit. 
*
* Modifications:
* $Log: Test12.c,v $
* Revision 1.1  2005-02-12 14:37:59  anderson
* Initial revision
*
* Revision 8.0  1998/12/23 23:36:11  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:59:00  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:27:23  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:23:56  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 09:15:28  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  01:19:03  andy
* Prepare for GA Release
*
* 
*/

/*must be defined for these tests before Intrinsic.h is included
in XtTest.h*/
#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#define DEBUG

#include <XtTest.h>

/* Toolkit definitions */
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>
#include <AvsComp.h>
#include <X11/Xaw/Label.h>
#include <X11/Xaw/Command.h>

char	ebuf[4096];

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;


void XtEM_Proc();

void XtEM_Proc2();

void test1sub();
void test2sub();

void test1sub(){

Widget labelw_msg;
int status;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tchcksbcls1", "XtCheckSubclass");
	tet_infoline("PREP: Install error message handler");
	XtAppSetErrorMsgHandler(app_ctext, &XtEM_Proc);
        tet_infoline("PREP: Create test label widget");
        labelw_msg = (Widget) CreateLabelWidget("Test", boxw1);
        tet_infoline("PREP: Create windows for widgets and map them");
        XtRealizeWidget(topLevel);
	tet_infoline("TEST: Error message is generated for non-subclass widget");
	XtCheckSubclass(labelw_msg, commandWidgetClass, "ApTest");
	KROF(pid2);
	status = avs_get_event(1);
	if (status != 1) {
		tet_infoline("ERROR: Error message handler was not called");
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
}

void test2sub(){

Widget labelw_msg;
int status;

	avs_xt_hier("Tchcksbcls2", "XtCheckSubclass");
	tet_infoline("PREP: Install error message handler");
	XtAppSetErrorMsgHandler(app_ctext, &XtEM_Proc2);
        tet_infoline("PREP: Create test label widget");
        labelw_msg = (Widget) CreateLabelWidget("Test", boxw1);
        tet_infoline("PREP: Create windows for widgets and map them");
        XtRealizeWidget(topLevel);
	tet_infoline("TEST: Error message is not generated for subclass widget");
	XtCheckSubclass(labelw_msg, coreWidgetClass, "ApTest");
	status = avs_get_event(1);
	if (status != 0) {
		tet_infoline("ERROR: Error message handler was called");
		tet_result(TET_FAIL);
		avs_set_event(1,0);
	}
	tet_infoline("TEST: Error message is not generated for class of widget");
	XtCheckSubclass(labelw_msg, XtClass(labelw_msg), "ApTest");
	status = avs_get_event(1);
	if (status != 0) {
		tet_infoline("ERROR: Error message handler was called");
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
}
