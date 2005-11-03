/*
Copyright (c) 2005 X.Org Foundation L.L.C.

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
* $Header: /cvs/xtest/xtest/xts5/src/libXtTest/avs_hierd.c,v 1.2 2005-11-03 08:42:02 jmichael Exp $
*
* Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
* Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
* All Rights Reserved.
*
* Project: VSW5
*
* File: xts5/src/lib/libXtTest/avs_hierd.c
*
* Description:
* 	Creates the test suites standard widget hierarchy, the old style
*
* Modifications:
* $Log: avs_hierd.c,v $
* Revision 1.2  2005-11-03 08:42:02  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:10  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:25:35  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:43:49  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:17:54  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:14:26  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:45:09  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:43:00  andy
* Prepare for GA Release
*
*/

#include <XtTest.h>


extern Widget topLevel, panedw, boxw1, boxw2, rowcolw, click_quit, labelw;
extern void xt_handler() ;
extern void DestroyTree() ;
extern void xt_whandler();
extern char *title() ;
extern char ebuf[];
char label[80] ;

Widget avs_xt_hier_def(stitle, slabel)
char *stitle, *slabel;
{
	/*get the right display*/
	sprintf(ebuf, "DISPLAY=%s", config.display);
	putenv(ebuf);
	tet_infoline("PREP: Initialize toolkit, Open display and Create topLevel root widget");
	topLevel = (Widget) avs_xt_def(stitle);
	trace("Set up the XtToolkitError handler");
	XtAppSetErrorMsgHandler(XtWidgetToApplicationContext(topLevel), xt_handler);
	XtAppSetWarningMsgHandler(XtWidgetToApplicationContext(topLevel), xt_whandler);
	trace("Set up widget tree of depth eight (8) return panedw widget");
	panedw = (Widget) avs_xt_tree(topLevel);
	trace("Create boxw1 widget in panedw widget");
	boxw1 = (Widget) CreateBoxWidget(panedw);
         
	trace("Create rowcolw widget in boxw1 widget");
	rowcolw = (Widget) CreateRowColWidget(boxw1);
        trace("Create push button gadget `Quit' in rowcolw widget");
        click_quit = (Widget) CreatePushButtonGadget("Quit", rowcolw);
        trace("Add callback procedure DestroyTree to push button gadget `Quit' ");
        XtAddCallback(click_quit,
                          XtNcallback,
                          DestroyTree,
                          (XtPointer)topLevel
                          );
	trace("Get the label widget name");
	sprintf(label, "Xt Function: %s", slabel);
	trace("Create label widget `%s' in boxw1 widget", label);
	labelw = (Widget) CreateLabelWidget(label, boxw1);
	trace("Register procedure DestroyTree to handle events to rowcolw widget");
	XtAddEventHandler(rowcolw,
		  ButtonReleaseMask,
		  False,
		  (XtEventHandler)DestroyTree,
		  (Widget)topLevel
		  );
	trace("Create boxw2 widget in panedw widget");
	boxw2 = (Widget) CreateBoxWidget(panedw);
	trace("Set the height and width of boxw2 widget");
	(void) ConfigureDimension(topLevel, boxw2);
	return topLevel;
}
