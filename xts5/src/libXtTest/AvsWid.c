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
* $Header: /cvs/xtest/xtest/xts5/src/libXtTest/AvsWid.c,v 1.2 2005-11-03 08:42:02 jmichael Exp $
*
* Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
* Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
* Copyright 1987, 1988 by Digital Equipment Corporation, Maynard,
* Massachusetts, and the Massachusetts Institute of Technology,
* Cambridge, Massachusetts.
* All Rights Reserved.
*
* Project: VSW5
*
* File: xts5/src/lib/libXtTest/AvsWid.c
*
* Description:
*	Test widget
*
* Modifications:
* $Log: AvsWid.c,v $
* Revision 1.2  2005-11-03 08:42:02  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:10  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:25:32  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:43:46  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:17:52  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:14:24  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:45:02  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:42:54  andy
* Prepare for GA Release
*
*/

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <XtTest.h>

#include <X11/IntrinsicP.h>
#include <X11/Xaw/XawInit.h>
#include "AvsWidP.h"

#define UnspecifiedPixmap 2	/* %%% should be NULL, according to the spec */

#ifdef ADD_RESOURCES
static XtResource resources[] = {
#define offset(field) XtOffset(AvsWidget, avsWid.field)
#undef offset
};
#endif

static void ClassPartInitialize(), Realize(), Initialize();
static Boolean SetValues();
static XtGeometryResult QueryGeometry();
static Boolean sv_almost();

AvsWidClassRec avsWidClassRec = {
  { /* core fields */
    /* superclass		*/	(WidgetClass) &widgetClassRec,
    /* class_name		*/	"AvsWid",
    /* widget_size		*/	sizeof(AvsWidRec),
    /* class_initialize		*/	XawInitializeWidgetSet,
    /* class_part_initialize	*/	ClassPartInitialize,
    /* class_inited		*/	FALSE,
    /* initialize		*/	Initialize,
    /* initialize_hook		*/	NULL,
    /* realize			*/	Realize,
    /* actions			*/	NULL,
    /* num_actions		*/	0,
#ifdef ADD_RESOURCES
    /* resources		*/	resources,
    /* num_resources	*/	XtNumber(resources),
#else
    /* resources		*/	NULL,
    /* num_resources	*/	0,
#endif
    /* xrm_class		*/	NULLQUARK,
    /* compress_motion		*/	TRUE,
    /* compress_exposure	*/	TRUE,
    /* compress_enterleave	*/	TRUE,
    /* visible_interest		*/	FALSE,
    /* destroy			*/	NULL,
    /* resize			*/	NULL,
    /* expose			*/	NULL,
    /* set_values		*/	SetValues,
    /* set_values_hook		*/	NULL,
    /* set_values_almost	*/	(XtAlmostProc)sv_almost,
    /* get_values_hook		*/	NULL,
    /* accept_focus		*/	NULL,
    /* version			*/	XtVersion,
    /* callback_private		*/	NULL,
    /* tm_table			*/	NULL,
    /* query_geometry		*/	QueryGeometry,
    /* display_accelerator	*/	XtInheritDisplayAccelerator,
    /* extension		*/	NULL
  },
  { /* avsWid fields */
    /* extension		*/	NULL
  }
};

WidgetClass avsWidgetClass = (WidgetClass)&avsWidClassRec;

static void ClassPartInitialize(class)
    WidgetClass class;
{
/*
    register AvsWidgetClass c = (AvsWidgetClass)class;
*/

	/* Nothing to check or change */
}

static void Realize(w, valueMask, attributes)
	register Widget w;
    Mask *valueMask;
    XSetWindowAttributes *attributes;
{

    XtCreateWindow( w, (unsigned int)InputOutput, (Visual *)CopyFromParent,
		    *valueMask, attributes );
}

static void Initialize (grequest, gnew)
    Widget grequest, gnew;
{
	AvsWidget request = (AvsWidget) grequest, new = (AvsWidget) gnew;

	/*
	 * Make sure the widget's width and height are
	 * greater than zero.
	*/
	if (request->core.width <= 0) new->core.width = 5;
	if (request->core.height <= 0) new->core.height = 5;
}

static Boolean sv_almost(current, request, new)
    Widget current, request, new;
{
/*
    AvsWidget s_old = (AvsWidget) current;
    AvsWidget s_new = (AvsWidget) new;
*/
	avs_set_event(3, avs_get_event(3)+1);

    return False;   
}

/* ARGSUSED */
static Boolean SetValues(current, request, new)
    Widget current, request, new;
{
/*
    AvsWidget s_old = (AvsWidget) current;
    AvsWidget s_new = (AvsWidget) new;
*/

    return False;   
}

static XtGeometryResult QueryGeometry(w, request, preferred)
Widget w;
XtWidgetGeometry *request, *preferred;
{
	AvsWidget me = (AvsWidget)w;

	if (!request) {
		preferred->x = me->core.x;
		preferred->y = me->core.y;
		preferred->width = me->core.width;
		preferred->height = me->core.height;
		preferred->border_width = me->core.border_width;
		preferred->request_mode = CWX|CWY|CWWidth|CWHeight|CWBorderWidth;
	} else {
		if (request->request_mode & CWX) {
			preferred->request_mode |= CWX;
			preferred->x = request->x;
		}
		if (request->request_mode & CWY) {
			preferred->request_mode |= CWY;
			preferred->y = request->y;
		}
		if (request->request_mode & CWWidth) {
			preferred->request_mode |= CWWidth;
			preferred->width = request->width;
		}
		if (request->request_mode & CWHeight) {
			preferred->request_mode |= CWHeight;
			preferred->height = request->height;
		}
		if (request->request_mode & CWBorderWidth) {
			preferred->request_mode |= CWBorderWidth;
			preferred->border_width = request->border_width;
		}
		if (request->request_mode & CWSibling) {
			preferred->request_mode |= CWSibling;
			preferred->sibling = request->sibling;
		}
		if (request->request_mode & CWStackMode) {
			preferred->request_mode |= CWStackMode;
			preferred->stack_mode = request->stack_mode;
		}
	}
	
	return XtGeometryYes;
}
