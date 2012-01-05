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
*
* Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
* Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
* All Rights Reserved.
*
* Project: VSW5
*
* File: xts5/src/lib/libXtTest/avs_widget.c
*
* Description:
*	Functions to Create different widgets
*
* Modifications:
* $Log: avs_widget.c,v $
* Revision 1.2  2005-11-03 08:42:02  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:10  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:25:36  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:43:50  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:17:55  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:14:27  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:45:12  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:43:04  andy
* Prepare for GA Release
*
*/

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <XtTest.h>

/* Toolkit definitions */

#include <X11/Xaw/Viewport.h>
#include <X11/Core.h>
#include <X11/Xaw/Form.h>
#include <X11/Xaw/Paned.h>
#include <X11/Xaw/Command.h>
#include <X11/Xaw/Label.h>
#include <X11/Xaw/SimpleMenu.h>
#include <xt/Box.h>


Widget CreateMainWidget(w)
Widget w;
{
	Widget mainw;

	mainw = XtVaCreateManagedWidget(
	  "mainw",			/* arbitrary widget name */
		viewportWidgetClass,	 	/* widget class  */
		w,				/* parent widget */
		NULL			/* terminate list */
		);

	return((Widget)mainw);

}

Widget CreateDrawWidget(w)
Widget w;
{
	Widget drawaw;

	drawaw = XtVaCreateManagedWidget(
		"drawaw",		/* arbitrary widget name */
		formWidgetClass,  	/* widget class  */
		w,			/* parent widget */
		NULL		/* terminate list */
		);

	return((Widget)drawaw);
}

Widget CreateFormWidget(w)
Widget w;
{

	Widget formw;

	formw = XtVaCreateManagedWidget(
		"formw",		/* arbitrary widget name */
		formWidgetClass,	/* widget class  */
		w,			/* parent widget */
		NULL	/* terminate list */
		);

	return((Widget)formw);
}

Widget CreateScrollWidget(w)
Widget w;
{

	Widget scrollw;

	scrollw = XtVaCreateManagedWidget(
		"scrollw",		/* arbitrary widget name */
		viewportWidgetClass,	/* widget class  */
		w,			/* parent widget */
		NULL		/* terminate list */
		);

	return((Widget)scrollw);
}


Widget CreateRowColWidget(w)
Widget w;
{

	Widget rowcolw;

	rowcolw = XtVaCreateManagedWidget(
		"rowcolw",		/* arbitrary widget name */
		formWidgetClass,	/* widget class  */
		w,			/* parent widget */
		NULL		/* terminate list */
		);

	return((Widget)rowcolw);
}

Widget CreateFrameWidget(w)
Widget w;
{
	Widget framew;

	framew = XtVaCreateManagedWidget(
		"framew",		/* arbitrary widget name */
		boxWidgetClass,		/* widget class  */
		w,			/* parent widget */
		NULL		/* terminate list */
		);

	return((Widget)framew);
}

Widget CreatePanedWidget(w)
Widget w;
{
	Widget panedw;

	panedw = XtVaCreateManagedWidget(
		"panedw",		/* arbitrary widget name */
		panedWidgetClass,	/* widget class  */
		w,			/* parent widget */
		NULL		/* terminate list */
		);

	return((Widget)panedw);
}

Widget CreateBoxWidget(w)
Widget w;
{
	Widget boxw;

	boxw = XtVaCreateManagedWidget(
		"panedw",		/* arbitrary widget name */
		boxWidgetClass,	   	/* widget class  */
		w,			/* parent widget */
		NULL		/* terminate list */
		);

	return((Widget)boxw);
}

Widget CreateLabelWidget(string, w)
char *string;
Widget w;
{
	Widget labelw;

	labelw = XtVaCreateManagedWidget(
		string,			/* arbitrary widget name */
		labelWidgetClass,	/* widget class  */
		w,			/* parent widget */
		NULL		/* terminate list */
		);

	return((Widget)labelw);
}


Widget CreatePushButtonGadget(string, w)
char *string;
Widget w;
{
	Widget pushb;

	pushb = XtVaCreateManagedWidget(
		string,			/* arbitrary widget name */
		commandWidgetClass,	/* widget class  */
		w,			/* parent widget */
		NULL		/* terminate list */
		);

	return((Widget)pushb);
}

Widget CreateMenuShellWidget(w)
Widget w;
{
	Widget menuw;

	menuw = XtVaCreateManagedWidget(
		"menuw",		/* arbitrary widget name */
		simpleMenuWidgetClass,  /* widget class  */
		w,			/* parent widget */
		XtNheight,100,
		XtNwidth, 100,
		NULL		/* terminate list */
		);

	return((Widget)menuw);
}

Widget CreateDialogShellWidget(w)
Widget w;
{
	Widget dialogsw;

	dialogsw = XtVaCreateWidget(
		"dialogsw",		/* arbitrary widget name */
		simpleMenuWidgetClass,	/* widget class  */
		w,			/* parent widget */
		NULL		/* terminate list */
		);

	return((Widget)dialogsw);
}
