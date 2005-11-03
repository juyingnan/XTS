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
* $Header: /cvs/xtest/xtest/xts5/include/AvsForm3.h,v 1.2 2005-11-03 08:42:00 jmichael Exp $
*
* Copyright (c) Applied Testing and Technology, Inc. 1995
* Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
* Copyright 1987, 1988 by Digital Equipment Corporation, Maynard,
* Massachusetts, and the Massachusetts Institute of Technology,
* Cambridge, Massachusetts.
* All Rights Reserved.
*
* Project: VSW5
*
* File: xts5/include/AvsForm3.h
*
* Description:
*	Widget Class
*
* Modifications:
* $Log: AvsForm3.h,v $
* Revision 1.2  2005-11-03 08:42:00  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:07  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:23:22  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:41:28  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:15:54  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:12:25  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:38:52  tbr
* Branch point for Release 5.0.0
*
* Revision 3.2  1995/12/15  02:08:48  andy
* Prepare for GA Release
*
*/


#ifndef avsForm3_h
#define avsForm3_h

#include <X11/Constraint.h>

/***********************************************************************
 *
 * Form Widget
 *
 ***********************************************************************/

/* Parameters:

 Name		     Class		RepType		Default Value
 ----		     -----		-------		-------------
 background	     Background		Pixel		XtDefaultBackground
 border		     BorderColor	Pixel		XtDefaultForeground
 borderWidth	     BorderWidth	Dimension	1
 defaultDistance     Thickness		int		4
 destroyCallback     Callback		Pointer		NULL
 height		     Height		Dimension	computed at realize
 mappedWhenManaged   MappedWhenManaged	Boolean		True
 sensitive	     Sensitive		Boolean		True
 width		     Width		Dimension	computed at realize
 x		     Position		Position	0
 y		     Position		Position	0

*/

/* Constraint parameters:

 Name		     Class		RepType		Default Value
 ----		     -----		-------		-------------
 bottom		     Edge		XtEdgeType	XtRubber
 fromHoriz	     Widget		Widget		(left edge of form)
 fromVert	     Widget		Widget		(top of form)
 horizDistance	     Thickness		int		defaultDistance
 left		     Edge		XtEdgeType	XtRubber
 resizable	     Boolean		Boolean		False
 right		     Edge		XtEdgeType	XtRubber
 top		     Edge		XtEdgeType	XtRubber
 vertDistance	     Thickness		int		defaultDistance

*/



#define XtNdefaultDistance "defaultDistance"
#ifndef XtNtop
#define XtNtop "top"
#endif
#define XtNbottom "bottom"
#define XtNleft "left"
#define XtNright "right"
#define XtNfromHoriz "fromHoriz"
#define XtNfromVert "fromVert"
#define XtNhorizDistance "horizDistance"
#define XtNvertDistance "vertDistance"
#define XtNresizable "resizable"

#define XtCEdge "Edge"
#define XtCWidget "Widget"

#ifndef XtRWidget
#define XtRWidget "Widget"
#endif

#ifndef _XawEdgeType_e
#define _XawEdgeType_e
typedef enum {
    XawChainTop,		/* Keep this edge a constant distance from
				   the top of the form */
    XawChainBottom,		/* Keep this edge a constant distance from
				   the bottom of the form */
    XawChainLeft,		/* Keep this edge a constant distance from
				   the left of the form */
    XawChainRight,		/* Keep this edge a constant distance from
				   the right of the form */
    XawRubber			/* Keep this edge a proportional distance
				   from the edges of the form*/
} XawEdgeType;
#endif /* _XawEdgeType_e */

/*
 * Unfortunatly I missed this definition for R4, so I cannot
 * protect it with XAW_BC, it looks like this particular problem is
 * one that we will have to live with for a while.
 *
 * Chris D. Peterson - 3/23/90.
 */

#define XtEdgeType XawEdgeType

#define XtChainTop XawChainTop
#define XtChainBottom XawChainBottom
#define XtChainLeft XawChainLeft
#define XtChainRight XawChainRight
#define XtRubber XawRubber

typedef struct _avsForm3ClassRec	*avsForm3WidgetClass;
typedef struct _avsForm3Rec		*avsForm3Widget;

extern WidgetClass avsform3WidgetClass;

#ifdef XAW_BC
/*************************************************************
 * For Compatibility only.                                   */

#define XtFormDoLayout                XawFormDoLayout

/*************************************************************/
#endif /* XAW_BC */

#ifdef __cplusplus
extern "C" {					/* for C++ V2.0 */
#endif

extern void XawFormDoLayout(
#if NeedFunctionPrototypes
    Widget		/* w */,
#if NeedWidePrototypes
    /* Boolean */ int	/* do_layout */
#else
    Boolean		/* do_layout */
#endif
#endif
);

#ifdef __cplusplus
}						/* for C++ V2.0 */
#endif
 
#endif /* XawForm_h */
