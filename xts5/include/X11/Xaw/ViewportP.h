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
* $Header: /cvs/xtest/xtest/xts5/include/X11/Xaw/ViewportP.h,v 1.2 2005-11-03 08:42:01 jmichael Exp $
*
* Copyright (c) Applied Testing and Technology, Inc. 1995
* All Rights Reserved.
*
* Project: VSW5
*
* File: xts5/include/X11/Xaw/ViewportP.h
*
* Description:
*	Defines used by the version of Athena widgets include in VSW5
*
* Modifications:
* $Log: ViewportP.h,v $
* Revision 1.2  2005-11-03 08:42:01  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:07  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:23:13  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:41:17  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:15:45  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:12:17  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:39:32  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:35:42  andy
* Prepare for GA Release
*
*/

/************************************************************
Copyright 1987 by Digital Equipment Corporation, Maynard, Massachusetts,
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

********************************************************/

#ifndef _ViewportP_h
#define _ViewportP_h

#include <X11/Xaw/Viewport.h>
#include <X11/Xaw/FormP.h>

typedef struct {int empty;} ViewportClassPart;

typedef struct _ViewportClassRec {
    CoreClassPart	core_class;
    CompositeClassPart	composite_class;
    ConstraintClassPart	constraint_class;
    FormClassPart	form_class;
    ViewportClassPart	viewport_class;
} ViewportClassRec;

extern ViewportClassRec viewportClassRec;

typedef struct _ViewportPart {
    /* resources */
    Boolean forcebars;		/* Whether we should always display */
				/* the selected scrollbars. */
    Boolean allowhoriz;		/* Whether we allow horizontal scrollbars. */
    Boolean allowvert;		/* Whether we allow vertical scrollbars. */
    Boolean usebottom;		/* True iff horiz bars appear at bottom. */
    Boolean useright;		/* True iff vert bars appear at right. */
    XtCallbackList report_callbacks;	/* when size/position changes */
    /* private state */
    Widget clip, child;		/* The clipping and (scrolled) child widgets */
    Widget  horiz_bar, vert_bar;/* What scrollbars we currently have. */
} ViewportPart;

typedef struct _ViewportRec {
    CorePart	core;
    CompositePart	composite;
    ConstraintPart	constraint;
    FormPart		form;
    ViewportPart	viewport;
} ViewportRec;

typedef struct {
    /* resources */

    /* private state */
    Boolean		reparented; /* True if child has been re-parented */
} ViewportConstraintsPart;

typedef struct _ViewportConstraintsRec {
    FormConstraintsPart		form;
    ViewportConstraintsPart	viewport;
} ViewportConstraintsRec, *ViewportConstraints;

#endif /* _ViewportP_h */
