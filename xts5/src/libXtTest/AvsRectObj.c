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
* $Header: /cvs/xtest/xtest/xts5/src/libXtTest/AvsRectObj.c,v 1.2 2005-11-03 08:42:02 jmichael Exp $
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
* File: xts5/src/lib/libXtTest/AvsRectObj.c
*
* Description:
*	Test widget
*
* Modifications:
* $Log: AvsRectObj.c,v $
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
* Revision 6.0  1998/03/02 05:17:51  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:14:23  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:45:01  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:42:52  andy
* Prepare for GA Release
*
*/

#define AVSRECTOBJ
#include <X11/Intrinsic.h>
#include <X11/IntrinsicP.h>
#include <X11/StringDefs.h>
#include <AvsRectObjP.h>

/******************************************************************
 *
 * Rectangle Object Resources
 *
 ******************************************************************/

static void XtCopyAncestorSensitive();

static XtResource resources[] = {

    {XtNancestorSensitive, XtCSensitive, XtRBoolean, sizeof(Boolean),
      XtOffsetOf(AvsRectObjRec,rectangle.ancestor_sensitive),XtRCallProc,
      (XtPointer)XtCopyAncestorSensitive},
    {XtNx, XtCPosition, XtRPosition, sizeof(Position),
         XtOffsetOf(AvsRectObjRec,rectangle.x), XtRImmediate, (XtPointer)0},
    {XtNy, XtCPosition, XtRPosition, sizeof(Position),
         XtOffsetOf(AvsRectObjRec,rectangle.y), XtRImmediate, (XtPointer)0},
    {XtNwidth, XtCWidth, XtRDimension, sizeof(Dimension),
         XtOffsetOf(AvsRectObjRec,rectangle.width), XtRImmediate, (XtPointer)0},
    {XtNheight, XtCHeight, XtRDimension, sizeof(Dimension),
         XtOffsetOf(AvsRectObjRec,rectangle.height), XtRImmediate, (XtPointer)0},
    {XtNborderWidth, XtCBorderWidth, XtRDimension, sizeof(Dimension),
         XtOffsetOf(AvsRectObjRec,rectangle.border_width), XtRImmediate,
	 (XtPointer)1},
    {XtNsensitive, XtCSensitive, XtRBoolean, sizeof(Boolean),
         XtOffsetOf(AvsRectObjRec,rectangle.sensitive), XtRImmediate,
	 (XtPointer)True}
    };

static void RectObjInitialize();
static void RectClassPartInitialize();
static void RectSetValuesAlmost();

static void actproc11(a1, a2, a3, a4)
Widget a1;
XEvent* a2;
String* a3;
Cardinal* a4;
{}
static void actproc12(a1, a2, a3, a4)
Widget a1;
XEvent* a2;
String* a3;
Cardinal* a4;
{}

static XtActionsRec actions[] = {
	{"rectobj1", actproc11},
	{"rectobj2", actproc12},
};


externaldef(rectobjclassrec) AvsRectObjClassRec avsrectObjClassRec = {
  {
    /* superclass	  */	(WidgetClass)&objectClassRec,
    /* class_name	  */	"AvsRect",
    /* widget_size	  */	sizeof(AvsRectObjRec),
    /* class_initialize   */    NULL,
    /* class_part_initialize*/	RectClassPartInitialize,
    /* class_inited       */	FALSE,
    /* initialize	  */	RectObjInitialize,
    /* initialize_hook    */	NULL,		
    /* realize		  */	NULL,
    /* actions		  */	(XtPointer)actions,
    /* num_actions	  */	2,
    /* resources	  */	resources,
    /* num_resources	  */	XtNumber(resources),
    /* xrm_class	  */	NULLQUARK,
    /* compress_motion	  */	FALSE,
    /* compress_exposure  */	TRUE,
    /* compress_enterleave*/ 	FALSE,
    /* visible_interest	  */	FALSE,
    /* destroy		  */	NULL,
    /* resize		  */	NULL,
    /* expose		  */	NULL,
    /* set_values	  */	NULL,
    /* set_values_hook    */	NULL,			
    /* set_values_almost  */	RectSetValuesAlmost,  
    /* get_values_hook    */	NULL,			
    /* accept_focus	  */	NULL,
    /* version		  */	XtVersion,
    /* callback_offsets   */    NULL,
    /* tm_table           */    NULL,
    /* query_geometry	    */  NULL,
    /* display_accelerator  */	NULL,
    /* extension	    */  NULL
  }
};

externaldef(avsrectObjClass)
WidgetClass avsrectObjClass = (WidgetClass)&avsrectObjClassRec;

/*ARGSUSED*/
static void XtCopyAncestorSensitive(widget, offset, value)
    Widget      widget;
    int		offset;
    XrmValue    *value;
{
    static Boolean  sensitive;
    Widget parent = widget->core.parent;

    sensitive = (parent->core.ancestor_sensitive & parent->core.sensitive);
    value->addr = &sensitive;
}


/*
 * Start of rectangle object methods
 */


static void RectClassPartInitialize(wc)
    register WidgetClass wc;
{
    register RectObjClass roc = (RectObjClass)wc;
    register RectObjClass super = ((RectObjClass)roc->rect_class.superclass);

    /* We don't need to check for null super since we'll get to object
       eventually, and it had better define them!  */


    if (roc->rect_class.resize == XtInheritResize) {
	roc->rect_class.resize = super->rect_class.resize;
    }

    if (roc->rect_class.expose == XtInheritExpose) {
	roc->rect_class.expose = super->rect_class.expose;
    }

    if (roc->rect_class.set_values_almost == XtInheritSetValuesAlmost) {
	roc->rect_class.set_values_almost = super->rect_class.set_values_almost;
    }


    if (roc->rect_class.query_geometry == XtInheritQueryGeometry) {
	roc->rect_class.query_geometry = super->rect_class.query_geometry;
    }
}

/* ARGSUSED */
static void RectObjInitialize(requested_widget, new_widget, args, num_args)
    Widget   requested_widget;
    register Widget new_widget;
    ArgList args;
    Cardinal *num_args;
{
    ((RectObj)new_widget)->rectangle.managed = FALSE;
}

/*ARGSUSED*/
static void RectSetValuesAlmost(old, new, request, reply)
    Widget		old;
    Widget		new;
    XtWidgetGeometry    *request;
    XtWidgetGeometry    *reply;
{
    *request = *reply;
}
