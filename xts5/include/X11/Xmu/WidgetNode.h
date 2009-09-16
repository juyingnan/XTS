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
* Copyright (c) Applied Testing and Technology, Inc. 1995
* All Rights Reserved.
*
* Project: VSW5
*
* File: xts5/include/X11/Xmu/WidgetNode.h
*
* Description:
*	Defines used by the version of Athena widgets include in VSW5
*
* Modifications:
* $Log: WidgetNode.h,v $
* Revision 1.2  2005-11-03 08:42:01  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:07  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:23:19  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:41:23  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:15:50  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:12:22  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:39:46  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:36:02  andy
* Prepare for GA Release
*
*/

/*
 * 
 *
 * Copyright 1990 Massachusetts Institute of Technology
 *
 * Permission to use, copy, modify, distribute, and sell this software and its
 * documentation for any purpose is hereby granted without fee, provided that
 * the above copyright notice appear in all copies and that both that
 * copyright notice and this permission notice appear in supporting
 * documentation, and that the name of M.I.T. not be used in advertising or
 * publicity pertaining to distribution of the software without specific,
 * written prior permission.  M.I.T. makes no representations about the
 * suitability of this software for any purpose.  It is provided "as is"
 * without express or implied warranty.
 *
 * M.I.T. DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING ALL
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT SHALL M.I.T.
 * BE LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
 * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN 
 * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *
 * Author:  Jim Fulton, MIT X Consortium
 */

#ifndef _XmuWidgetNode_h
#define _XmuWidgetNode_h

#include <X11/Xfuncproto.h>

/*
 * This is usually initialized by setting the first two fields and letting
 * rest be implicitly nulled (by genlist.sh, for example)
 */
typedef struct _XmuWidgetNode {
    char *label;			/* mixed case name */
    WidgetClass *widget_class_ptr;	/* addr of widget class */
    struct _XmuWidgetNode *superclass;	/* superclass of widget_class */
    struct _XmuWidgetNode *children, *siblings;	/* subclass links */
    char *lowered_label;		/* lowercase version of label */
    char *lowered_classname;		/* lowercase version of class_name */
    Bool have_resources;		/* resources have been fetched */
    XtResourceList resources;		/* extracted resource database */
    struct _XmuWidgetNode **resourcewn;	/* where resources come from */
    Cardinal nresources;		/* number of resources */
    XtResourceList constraints;		/* extracted constraint resources */
    struct _XmuWidgetNode **constraintwn;  /* where constraints come from */
    Cardinal nconstraints;		/* number of constraint resources */
    XtPointer data;			/* extra data */
} XmuWidgetNode;

#define XmuWnClass(wn) ((wn)->widget_class_ptr[0])
#define XmuWnClassname(wn) (XmuWnClass(wn)->core_class.class_name)
#define XmuWnSuperclass(wn) ((XmuWnClass(wn))->core_class.superclass)

					/* external interfaces */
_XFUNCPROTOBEGIN

extern void XmuWnInitializeNodes (
#if NeedFunctionPrototypes
    XmuWidgetNode *	/* nodearray */,
    int			/* nnodes */
#endif
);

extern void XmuWnFetchResources (
#if NeedFunctionPrototypes
    XmuWidgetNode *	/* node */,
    Widget		/* toplevel */,
    XmuWidgetNode *	/* topnode */
#endif
);

extern int XmuWnCountOwnedResources (
#if NeedFunctionPrototypes
    XmuWidgetNode *	/* node */,
    XmuWidgetNode *	/* ownernode */,
    Bool		/* constraints */
#endif
);

extern XmuWidgetNode *XmuWnNameToNode (
#if NeedFunctionPrototypes
    XmuWidgetNode *	/* nodelist */,
    int			/* nnodes */,
    _Xconst char *	/* name */
#endif
);

_XFUNCPROTOEND

#endif /* _XmuWidgetNode_h */

