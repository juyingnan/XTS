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
* $Header: /cvs/xtest/xtest/xts5/include/X11/Xmu/Converters.h,v 1.1 2005-02-12 14:37:13 anderson Exp $
*
* Copyright (c) Applied Testing and Technology, Inc. 1995
* All Rights Reserved.
*
* Project: VSW5
*
* File: vsw5/include/X11/Xmu/Converters.h
*
* Description:
*	Defines used by the version of Athena widgets include in VSW5
*
* Modifications:
* $Log: Converters.h,v $
* Revision 1.1  2005-02-12 14:37:13  anderson
* Initial revision
*
* Revision 8.0  1998/12/23 23:23:15  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:41:19  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:15:47  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:12:19  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.1  1996/02/27 00:59:45  andy
* Ifdefed XtRGravity define (SR 93)
*
* Revision 4.0  1995/12/15  08:39:37  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:35:49  andy
* Prepare for GA Release
*
*/

/* 
 *
 * Copyright 1988 by the Massachusetts Institute of Technology
 *
 * Permission to use, copy, modify, and distribute this software and its
 * documentation for any purpose and without fee is hereby granted, provided 
 * that the above copyright notice appear in all copies and that both that 
 * copyright notice and this permission notice appear in supporting 
 * documentation, and that the name of M.I.T. not be used in advertising
 * or publicity pertaining to distribution of the software without specific, 
 * written prior permission. M.I.T. makes no representations about the 
 * suitability of this software for any purpose.  It is provided "as is"
 * without express or implied warranty.
 *
 * The X Window System is a Trademark of MIT.
 *
 * The interfaces described by this header file are for miscellaneous utilities
 * and are not part of the Xlib standard.
 */

#ifndef _XMU_STRCONVERT_H_
#define _XMU_STRCONVERT_H_

#include <X11/Xfuncproto.h>

_XFUNCPROTOBEGIN

/*
 * Converters - insert in alphabetical order
 */

/******************************************************************************
 * XmuCvtFunctionToCallback
 */
extern void XmuCvtFunctionToCallback(
#if NeedFunctionPrototypes
    XrmValue*		/* args */,
    Cardinal*		/* num_args */,
    XrmValuePtr		/* fromVal */,
    XrmValuePtr		/* toVal */
#endif
);


/******************************************************************************
 * XmuCvtStringToBackingStore
 */
#define XtNbackingStore "backingStore"
#define XtCBackingStore "BackingStore"
#define XtRBackingStore "BackingStore"
#define XtEnotUseful "notUseful"
#define XtEwhenMapped "whenMapped"
#define XtEalways "always"
#define XtEdefault "default"
extern void XmuCvtStringToBackingStore(
#if NeedFunctionPrototypes
    XrmValue*		/* args */,
    Cardinal*		/* num_args */,
    XrmValuePtr		/* fromVal */,
    XrmValuePtr		/* toVal */
#endif
);


/******************************************************************************
 * XmuCvtStringToCursor
 */
extern void XmuCvtStringToCursor(
#if NeedFunctionPrototypes
    XrmValue*		/* args */,
    Cardinal*		/* num_args */,
    XrmValuePtr		/* fromVal */,
    XrmValuePtr		/* toVal */
#endif
);
extern Boolean XmuCvtStringToColorCursor(
#if NeedFunctionPrototypes
    Display*		/* dpy */,
    XrmValue*		/* args */,
    Cardinal*		/* num_args */,
    XrmValuePtr		/* fromVal */,
    XrmValuePtr		/* toVal */,
    XtPointer*		/* converter_data */
#endif
);

#define XtRColorCursor "ColorCursor"
#define XtNpointerColor "pointerColor"
#define XtNpointerColorBackground "pointerColorBackground"


/******************************************************************************
 * XmuCvtStringToGravity
 */
typedef int XtGravity;

#ifndef XtRGravity  /* in X11/StringDefs.h */
#define XtRGravity "Gravity"
#endif
#define XtEForget "forget"
#define XtENorthWest "northwest"
#define XtENorth "north"
#define XtENorthEast "northeast"
#define XtEWest "west"
#define XtECenter "center"
#define XtEEast "east"
#define XtESouthWest "southwest"
#define XtESouth "south"
#define XtESouthEast "southeast"
#define XtEStatic "static"
#define XtEUnmap "unmap"

extern void XmuCvtStringToGravity (
#if NeedFunctionPrototypes
    XrmValue*		/* args */,
    Cardinal*		/* num_args */,
    XrmValuePtr		/* fromVal */,
    XrmValuePtr		/* toVal */
#endif
);


/******************************************************************************
 * XmuCvtStringToJustify
 */
typedef enum {
    XtJustifyLeft,       /* justify text to left side of button   */
    XtJustifyCenter,     /* justify text in center of button      */
    XtJustifyRight       /* justify text to right side of button  */
} XtJustify;
#define XtEleft "left"
#define XtEcenter "center"
#define XtEright "right"
#define XtEtop "top"
#define XtEbottom "bottom"

extern void XmuCvtStringToJustify(
#if NeedFunctionPrototypes
    XrmValue*		/* args */,
    Cardinal*		/* num_args */,
    XrmValuePtr		/* fromVal */,
    XrmValuePtr		/* toVal */
#endif
);


/******************************************************************************
 * XmuCvtStringToLong
 */
#define XtRLong "Long"
extern void XmuCvtStringToLong(
#if NeedFunctionPrototypes
    XrmValue*		/* args */,
    Cardinal*		/* num_args */,
    XrmValuePtr		/* fromVal */,
    XrmValuePtr		/* toVal */
#endif
);


/******************************************************************************
 * XmuCvtStringToOrientation
 */
typedef enum {XtorientHorizontal, XtorientVertical} XtOrientation;
extern void XmuCvtStringToOrientation(
#if NeedFunctionPrototypes
    XrmValue*		/* args */,
    Cardinal*		/* num_args */,
    XrmValuePtr		/* fromVal */,
    XrmValuePtr		/* toVal */
#endif
);


/******************************************************************************
 * XmuCvtStringToBitmap
 */
extern void XmuCvtStringToBitmap(
#if NeedFunctionPrototypes
    XrmValue*		/* args */,
    Cardinal*		/* num_args */,
    XrmValuePtr		/* fromVal */,
    XrmValuePtr		/* toVal */
#endif
);


/******************************************************************************
 * XmuCvtStringToShapeStyle; is XtTypeConverter (i.e. new style)
 * no conversion arguments, not particularly useful to cache the results.
 */

#define XtRShapeStyle "ShapeStyle"
#define XtERectangle "Rectangle"
#define XtEOval "Oval"
#define XtEEllipse "Ellipse"
#define XtERoundedRectangle "RoundedRectangle"

#define XmuShapeRectangle 1
#define XmuShapeOval 2
#define XmuShapeEllipse 3
#define XmuShapeRoundedRectangle 4

extern Boolean XmuCvtStringToShapeStyle(
#if NeedFunctionPrototypes
    Display*		/* dpy */,
    XrmValue*		/* args */,
    Cardinal*		/* num_args */,
    XrmValuePtr		/* fromVal */,
    XrmValuePtr		/* toVal */,
    XtPointer*		/* converter_data */
#endif
);

extern Boolean XmuReshapeWidget(
#if NeedFunctionPrototypes
    Widget	/* w */,
    int		/* shape_style */,
    int		/* corner_width */,
    int		/* corner_height */
#endif
);

/******************************************************************************
 * XmuCvtStringToWidget
 */
extern void XmuCvtStringToWidget(
#if NeedFunctionPrototypes
    XrmValue*		/* args */,
    Cardinal*		/* num_args */,
    XrmValuePtr		/* fromVal */,
    XrmValuePtr		/* toVal */
#endif
);

/******************************************************************************
 * XmuNewCvtStringToWidget
 */
extern Boolean XmuNewCvtStringToWidget(
#if NeedFunctionPrototypes
    Display*            /* display */,
    XrmValue*		/* args */,
    Cardinal*		/* num_args */,
    XrmValue*		/* fromVal */,
    XrmValue*		/* toVal */,
    XtPointer*          /* converter_data */
#endif
);

_XFUNCPROTOEND

#endif /* _XMU_STRCONVERT_H_ */
