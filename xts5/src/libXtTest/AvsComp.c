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
* $Header: /cvs/xtest/xtest/xts5/src/libXtTest/AvsComp.c,v 1.2 2005-11-03 08:42:02 jmichael Exp $
*
* Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
* Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
* All Rights Reserved.
*
* Project: VSW5
*
* File: xts5/src/lib/libXtTest/AvsComp.c
*
* Description:
*	Test widget
*
* Modifications:
* $Log: AvsComp.c,v $
* Revision 1.2  2005-11-03 08:42:02  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:10  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:25:29  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:43:42  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:17:48  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:14:20  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:44:53  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:42:41  andy
* Prepare for GA Release
*
*/

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <XtTest.h>

#include <X11/IntrinsicP.h>
#include <X11/CompositeP.h>
#include <X11/ConstrainP.h>
#include <X11/Xaw/XawInit.h>
#include <X11/Xaw/Cardinals.h>
#include "AvsCompP.h"

					/* widget class method */
static void             ClassInitialize();
static void             Initialize();
static void             Destroy();
static Boolean          SetValues();
static XtGeometryResult GeometryManager();
static XtGeometryResult	QueryGeometry();


#ifdef ADD_RESOURCES
static XtResource resources[] = {
};
#endif

static void actproc1(a1, a2, a3, a4)
Widget a1;
XEvent* a2;
String* a3;
Cardinal* a4;
{}
static void actproc2(a1, a2, a3, a4)
Widget a1;
XEvent* a2;
String* a3;
Cardinal* a4;
{}

static XtActionsRec actions[] = {
	{"action1", actproc1},
	{"action2", actproc2},
};

static char defaultTranslations[] =
	"<Btn1Down>:	actproc1()	\n\
	 <Btn2Down>:	actproc2()";

AvsCompClassRec avsCompClassRec = {
  {
					/* core_class fields  */
    (WidgetClass) &compositeClassRec,	/* superclass         */
    "AvsComp",				/* class_name         */
    sizeof(AvsCompRec),			/* widget_size        */
    ClassInitialize,			/* class_init         */
    NULL,				/* class_part_init    */
    FALSE,				/* class_inited       */	
    Initialize,				/* initialize         */
    NULL,				/* initialize_hook    */	
    XtInheritRealize,			/* realize            */
    actions,				/* actions            */
    XtNumber(actions),			/* num_actions        */	
#ifdef ADD_RESOURCES
    resources,				/* resources          */
    XtNumber(resources),		/* num_resources      */
#else
	NULL,
	0,
#endif
    NULLQUARK,				/* xrm_class          */
    TRUE,				/* compress_motion    */	
    TRUE,				/* compress_exposure  */	
    TRUE,				/* compress_enterleave*/	
    TRUE,				/* visible_interest   */
    Destroy,				/* destroy            */
    NULL,				/* resize             */
    XtInheritExpose,				/* expose             */
    SetValues,				/* set_values         */
    NULL,				/* set_values_hook    */	
    XtInheritSetValuesAlmost,		/* set_values_almost  */
    NULL,				/* get_values_hook    */	
    NULL,				/* accept_focus       */
    XtVersion,				/* version            */	
    NULL,				/* callback_private   */
    NULL,				/* tm_table           */
    XtInheritQueryGeometry,			/* query_geometry     */	
    NULL,				/* display_accelerator*/
    NULL,				/* extension          */
  },
  {
					/* composite_class fields */
    GeometryManager,			/* geometry_manager    */
    XtInheritChangeManaged,			/* change_managed      */
    XtInheritInsertChild,		/* insert_child        */	
    XtInheritDeleteChild,		/* delete_child        */	
    NULL,				/* extension           */
  },
  {
					/* AvsComp class fields */
    NULL,					/* extension              */	
  }
};

WidgetClass avsCompWidgetClass = (WidgetClass) &avsCompClassRec;


/*****************************************************************************
 *                                                                           *
 * 			      avsComp class methods                             *
 *                                                                           *
 *****************************************************************************/

static void ClassInitialize ()
{
    XawInitializeWidgetSet();
}


static void Initialize (grequest, gnew)
    Widget grequest, gnew;
{
    AvsCompWidget request = (AvsCompWidget) grequest, new = (AvsCompWidget) gnew;

    /*
     * Make sure the widget's width and height are 
     * greater than zero.
     */
    if (request->core.width <= 0) new->core.width = 5;
    if (request->core.height <= 0) new->core.height = 5;
} 


/* ARGSUSED */
static Boolean SetValues (gcurrent, grequest, gnew)
    Widget gcurrent, grequest, gnew;
{
/*
    AvsCompWidget current = (AvsCompWidget) gcurrent, new = (AvsCompWidget) gnew;
	*/
    Boolean redraw = FALSE;

    return redraw;
}


/* ARGSUSED */
static XtGeometryResult GeometryManager (w, request, reply)
    Widget w;
    XtWidgetGeometry *request;
    XtWidgetGeometry *reply;
{
/*
	AvsCompRec *me = (AvsCompRec*)XtParent(w);
*/


	if (!request) {
		reply->x = w->core.x;
		reply->y = w->core.y;
		reply->width = w->core.width;
		reply->height = w->core.height;
		reply->border_width = w->core.border_width;
		reply->request_mode = CWX|CWY|CWWidth|CWHeight|CWBorderWidth;
	} else {
		/* Ignore the children, accept the request */
		if (request->request_mode & CWX) {
			reply->request_mode |= CWX;
			reply->x = request->x;
			if (!(request->request_mode & XtCWQueryOnly))
				w->core.x = request->x;
		}
		if (request->request_mode & CWY) {
			reply->request_mode |= CWY;
			reply->y = request->y;
			if (!(request->request_mode & XtCWQueryOnly))
				w->core.y = request->y;
		}
		if (request->request_mode & CWWidth) {
			reply->request_mode |= CWWidth;
			reply->width = request->width;
			if (!(request->request_mode & XtCWQueryOnly))
				w->core.width = request->width;
		}
		if (request->request_mode & CWHeight) {
			reply->request_mode |= CWHeight;
			reply->height = request->height;
			if (!(request->request_mode & XtCWQueryOnly))
				w->core.height = request->height;
		}
		if (request->request_mode & CWBorderWidth) {
			reply->request_mode |= CWBorderWidth;
			reply->border_width = request->border_width;
			if (!(request->request_mode & XtCWQueryOnly))
				w->core.border_width = request->border_width;
		}
		if (request->request_mode & CWSibling) {
			reply->request_mode |= CWSibling;
			reply->sibling = request->sibling;
			if (!(request->request_mode & XtCWQueryOnly)) {
				/* ??? */
			}
		}
		if (request->request_mode & CWStackMode) {
			reply->request_mode |= CWStackMode;
			reply->stack_mode = request->stack_mode;
			if (!(request->request_mode & XtCWQueryOnly)) {
				/* ??? */
			}
		}
	}
	
	return XtGeometryYes;
}

static void Destroy (gw)
    Widget gw;
{
}

static XtGeometryResult QueryGeometry (w, request, preferred)
    Widget w;
    XtWidgetGeometry *request, *preferred;
{
	AvsCompRec *me = (AvsCompRec*)w;


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
