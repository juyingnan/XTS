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
* $Header: /cvs/xtest/xtest/xts5/src/libXtaw/Simple.c,v 1.2 2005-11-03 08:42:02 jmichael Exp $
*
* Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
* All Rights Reserved.
*
* Project: VSW5
*
* File: xts5/src/lib/libXtaw/Simple.c
*
* Description:
*	Subset of libXaw need for VSW5.  Use if implementation does not
*	support Athena.
*
* Modifications:
* $Log: Simple.c,v $
* Revision 1.2  2005-11-03 08:42:02  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:11  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:25:55  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:44:09  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:18:13  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:14:45  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:46:06  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:44:08  andy
* Prepare for GA Release
*
*/
/***********************************************************
Copyright 1987, 1988 by Digital Equipment Corporation, Maynard, Massachusetts,
and the Massachusetts Institute of Technology, Cambridge, Massachusetts.

                        All Rights Reserved

Permission to use, copy, modify, and distribute this software and its 
documentation for any purpose and without fee is hereby granted, 
provided that the above copyright notice appear in all copies and that
both that copyright notice and this permission notice appear in 
supporting documentation, and that the names of Digital or MIT not be
used in advertising or publicity pertaining to distribution of the
software without specific, written prior permission.  

DIGITAL DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING
ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT SHALL
DIGITAL BE LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR
ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS,
WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION,
ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS
SOFTWARE.

******************************************************************/

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <stdio.h>
#include <X11/IntrinsicP.h>
#include <X11/StringDefs.h>
#include <X11/Xaw/XawInit.h>
#include <X11/Xaw/SimpleP.h>
#include <X11/Xmu/Drawing.h>

#define offset(field) XtOffsetOf(SimpleRec, simple.field)

static XtResource resources[] = {
  {XtNcursor, XtCCursor, XtRCursor, sizeof(Cursor),
     offset(cursor), XtRImmediate, (XtPointer) None},
  {XtNinsensitiveBorder, XtCInsensitive, XtRPixmap, sizeof(Pixmap),
     offset(insensitive_border), XtRImmediate, (XtPointer) NULL},
  {XtNpointerColor, XtCForeground, XtRPixel, sizeof(Pixel),
     offset(pointer_fg), XtRString, XtDefaultForeground},
  {XtNpointerColorBackground, XtCBackground, XtRPixel, sizeof(Pixel),
     offset(pointer_bg), XtRString, XtDefaultBackground},
  {XtNcursorName, XtCCursor, XtRString, sizeof(String),
     offset(cursor_name), XtRString, NULL},
#undef offset
};

static void ClassPartInitialize(), ClassInitialize(),Realize(),ConvertCursor();
static Boolean SetValues(), ChangeSensitive();

SimpleClassRec simpleClassRec = {
  { /* core fields */
    /* superclass		*/	(WidgetClass) &widgetClassRec,
    /* class_name		*/	"Simple",
    /* widget_size		*/	sizeof(SimpleRec),
    /* class_initialize		*/	ClassInitialize,
    /* class_part_initialize	*/	ClassPartInitialize,
    /* class_inited		*/	FALSE,
    /* initialize		*/	NULL,
    /* initialize_hook		*/	NULL,
    /* realize			*/	Realize,
    /* actions			*/	NULL,
    /* num_actions		*/	0,
    /* resources		*/	resources,
    /* num_resources		*/	XtNumber(resources),
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
    /* set_values_almost	*/	XtInheritSetValuesAlmost,
    /* get_values_hook		*/	NULL,
    /* accept_focus		*/	NULL,
    /* version			*/	XtVersion,
    /* callback_private		*/	NULL,
    /* tm_table			*/	NULL,
    /* query_geometry		*/	XtInheritQueryGeometry,
    /* display_accelerator	*/	XtInheritDisplayAccelerator,
    /* extension		*/	NULL
  },
  { /* simple fields */
    /* change_sensitive		*/	ChangeSensitive
  }
};

WidgetClass simpleWidgetClass = (WidgetClass)&simpleClassRec;

static void ClassInitialize()
{
    static XtConvertArgRec convertArg[] = {
        {XtWidgetBaseOffset, (XtPointer) XtOffsetOf(WidgetRec, core.screen),
	     sizeof(Screen *)},
        {XtResourceString, (XtPointer) XtNpointerColor, sizeof(Pixel)},
        {XtResourceString, (XtPointer) XtNpointerColorBackground, 
	     sizeof(Pixel)},
        {XtWidgetBaseOffset, (XtPointer) XtOffsetOf(WidgetRec, core.colormap),
	     sizeof(Colormap)}
    };

    XawInitializeWidgetSet();
    XtSetTypeConverter( XtRString, XtRColorCursor, XmuCvtStringToColorCursor,
		       convertArg, XtNumber(convertArg), 
		       XtCacheByDisplay, NULL);
}

static void ClassPartInitialize(class)
    WidgetClass class;
{
    register SimpleWidgetClass c = (SimpleWidgetClass)class;
    register SimpleWidgetClass super = (SimpleWidgetClass) 
	c->core_class.superclass;

    if (c->simple_class.change_sensitive == NULL) {
	char buf[BUFSIZ];

	sprintf(buf,
		"%s Widget: The Simple Widget class method 'change_sensitive' is undefined.\nA function must be defined or inherited.",
		c->core_class.class_name);
	XtWarning(buf);
	c->simple_class.change_sensitive = ChangeSensitive;
    }

    if (c->simple_class.change_sensitive == XtInheritChangeSensitive)
	c->simple_class.change_sensitive = super->simple_class.change_sensitive;
}

static void Realize(w, valueMask, attributes)
    register Widget w;
    Mask *valueMask;
    XSetWindowAttributes *attributes;
{
    Pixmap border_pixmap;

    if (!XtIsSensitive(w)) {
	/* change border to gray; have to remember the old one,
	 * so XtDestroyWidget deletes the proper one */
	if (((SimpleWidget)w)->simple.insensitive_border == None)
	    ((SimpleWidget)w)->simple.insensitive_border =
		XmuCreateStippledPixmap(XtScreen(w),
					w->core.border_pixel, 
					w->core.background_pixel,
					w->core.depth);
        border_pixmap = w->core.border_pixmap;
	attributes->border_pixmap =
	  w->core.border_pixmap = ((SimpleWidget)w)->simple.insensitive_border;

	*valueMask |= CWBorderPixmap;
	*valueMask &= ~CWBorderPixel;
    }

    ConvertCursor(w);

    if ((attributes->cursor = ((SimpleWidget)w)->simple.cursor) != None)
	*valueMask |= CWCursor;

    XtCreateWindow( w, (unsigned int)InputOutput, (Visual *)CopyFromParent,
		    *valueMask, attributes );

    if (!XtIsSensitive(w))
	w->core.border_pixmap = border_pixmap;
}

/*	Function Name: ConvertCursor
 *	Description: Converts a name to a new cursor.
 *	Arguments: w - the simple widget.
 *	Returns: none.
 */

static void
ConvertCursor(w)
Widget w;
{
    SimpleWidget simple = (SimpleWidget) w;
    XrmValue from, to;
    Cursor cursor;
   
    if (simple->simple.cursor_name == NULL)
	return;

    from.addr = (XPointer) simple->simple.cursor_name;
    from.size = strlen((char *) from.addr) + 1;

    to.size = sizeof(Cursor);
    to.addr = (XPointer) &cursor;

    if (XtConvertAndStore(w, XtRString, &from, XtRColorCursor, &to)) {
	if ( cursor !=  None) 
	    simple->simple.cursor = cursor;
    } 
    else {
	XtAppErrorMsg(XtWidgetToApplicationContext(w),
		      "convertFailed","ConvertCursor","XawError",
		      "Simple: ConvertCursor failed.",
		      (String *)NULL, (Cardinal *)NULL);
    }
}


/* ARGSUSED */
static Boolean SetValues(current, request, new)
    Widget current, request, new;
{
    SimpleWidget s_old = (SimpleWidget) current;
    SimpleWidget s_new = (SimpleWidget) new;
    Boolean new_cursor = FALSE;

    if ( XtIsSensitive(current) != XtIsSensitive(new) )
	(*((SimpleWidgetClass)XtClass(new))->
	     simple_class.change_sensitive) ( new );

    if (s_old->simple.cursor != s_new->simple.cursor) {
	new_cursor = TRUE;
    }
	
/*
 * We are not handling the string cursor_name correctly here.
 */

    if ( (s_old->simple.pointer_fg != s_new->simple.pointer_fg) ||
	(s_old->simple.pointer_bg != s_new->simple.pointer_bg) ||
	(s_old->simple.cursor_name != s_new->simple.cursor_name) ) {
	ConvertCursor(new);
	new_cursor = TRUE;
    }

    if (new_cursor && XtIsRealized(new))
        XDefineCursor(XtDisplay(new), XtWindow(new), s_new->simple.cursor);

    return False;   
}


static Boolean ChangeSensitive(w)
    register Widget w;
{
    if (XtIsRealized(w)) {
	if (XtIsSensitive(w))
	    if (w->core.border_pixmap != XtUnspecifiedPixmap)
		XSetWindowBorderPixmap( XtDisplay(w), XtWindow(w),
				        w->core.border_pixmap );
	    else
		XSetWindowBorder( XtDisplay(w), XtWindow(w), 
				  w->core.border_pixel );
	else {
	    if (((SimpleWidget)w)->simple.insensitive_border == None)
		((SimpleWidget)w)->simple.insensitive_border =
		    XmuCreateStippledPixmap(XtScreen(w),
					    w->core.border_pixel, 
					    w->core.background_pixel,
					    w->core.depth);
	    XSetWindowBorderPixmap( XtDisplay(w), XtWindow(w),
				    ((SimpleWidget)w)->
				        simple.insensitive_border );
	}
    }
    return False;
}
