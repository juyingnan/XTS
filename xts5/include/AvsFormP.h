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
* $Header: /cvs/xtest/xtest/xts5/include/AvsFormP.h,v 1.1 2005-02-12 14:37:13 anderson Exp $
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
* File: vsw5/include/AvsFormP.h
*
* Description:
*	Widget Class
*
* Modifications:
* $Log: AvsFormP.h,v $
* Revision 1.1  2005-02-12 14:37:13  anderson
* Initial revision
*
* Revision 8.0  1998/12/23 23:23:24  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:41:29  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:15:55  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:12:26  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:38:13  tbr
* Branch point for Release 5.0.0
*
* Revision 3.2  1995/12/15  00:37:27  andy
* Prepare for GA Release
*
*/

/* Form widget private definitions */

#ifndef _XawFormP_h
#define _XawFormP_h

#include <AvsForm.h>
#include <X11/ConstrainP.h>

#define XtREdgeType "EdgeType"

typedef enum {LayoutPending, LayoutInProgress, LayoutDone} LayoutState;
#define XtInheritLayout ((Boolean (*)())_XtInherit)
#endif
#ifndef _avsFormP_h
#define _avsFormP_h

typedef struct {
    Boolean	(*layout)(/* avsFormWidget, Dimension, Dimension */);
} avsFormClassPart;

/*
 * Layout(
 *	FormWidget w	- the widget whose children are to be configured
 *	Dimension w, h	- bounding box of layout to be calculated
 *
 *  Stores preferred geometry in w->form.preferred_{width,height}.
 *  If w->form.resize_in_layout is True, then a geometry request
 *  may be made for the preferred bounding box if necessary.
 *
 *  Returns True if a geometry request was granted, False otherwise.
 */

typedef struct _avsFormClassRec {
    CoreClassPart	core_class;
    CompositeClassPart	composite_class;
    ConstraintClassPart	constraint_class;
    avsFormClassPart	form_class;
} avsFormClassRec;

extern avsFormClassRec avsformClassRec;

typedef struct _avsFormPart {
    /* resources */
    int		default_spacing;    /* default distance between children */
    /* private state */
    Dimension	old_width, old_height; /* last known dimensions		 */
    int		no_refigure;	    /* no re-layout while > 0		 */
    Boolean	needs_relayout;	    /* next time no_refigure == 0	 */
    Boolean	resize_in_layout;   /* should layout() do geom request?  */
    Dimension	preferred_width, preferred_height; /* cached from layout */
    Boolean     resize_is_no_op;    /* Causes resize to take not action. */
} avsFormPart;

typedef struct _avsFormRec {
    CorePart		core;
    CompositePart	composite;
    ConstraintPart	constraint;
    avsFormPart		form;
} avsFormRec;

typedef struct _avsFormConstraintsPart {
/*
 * Constraint Resources.
 */
    XtEdgeType	top, bottom,	/* where to drag edge on resize		*/
		left, right;
    int		dx;		/* desired horiz offset			*/
    int		dy;		/* desired vertical offset		*/
    Widget	horiz_base;	/* measure dx from here if non-null	*/
    Widget	vert_base;	/* measure dy from here if non-null	*/
    Boolean	allow_resize;	/* TRUE if child may request resize	*/

/*
 * Private contstraint resources.
 */

/*
 * What the size of this child would be if we did not impose the 
 * constraint the width and height must be greater than zero (0).
 */
    int         virtual_width, virtual_height; 

/*
 * Temporary Storage for children's new possible possition.
 */

    Position new_x, new_y;

    LayoutState	layout_state;	/* temporary layout state		*/
} avsFormConstraintsPart;

typedef struct _avsFormConstraintsRec {
    avsFormConstraintsPart	form;
} avsFormConstraintsRec, *avsFormConstraints;

#endif /* _XawFormP_h */
