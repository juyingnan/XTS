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
* $Header: /cvs/xtest/xtest/xts5/include/AvsObjP.h,v 1.1 2005-02-12 14:37:13 anderson Exp $
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
* File: vsw5/include/AvsObjP.h
*
* Description:
*	Widget Class
*
* Modifications:
* $Log: AvsObjP.h,v $
* Revision 1.1  2005-02-12 14:37:13  anderson
* Initial revision
*
* Revision 8.0  1998/12/23 23:23:25  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:41:30  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:15:56  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:12:27  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:38:15  tbr
* Branch point for Release 5.0.0
*
* Revision 3.2  1995/12/15  00:37:31  andy
* Prepare for GA Release
*
*/

#ifndef AvsObjP_h_
#define AvsObjP_h_

#include <AvsObj.h>
#include <X11/ObjectP.h>

/**********************************************************
 * AVS Object Instance Data Structures
 *
 **********************************************************/
/* these fields match CorePart and can not be changed */

typedef struct _AvsObjPart {
    Position        x, y;               /* rectangle position               */
    Dimension       width, height;      /* rectangle dimensions             */
    Dimension       border_width;       /* rectangle border width           */
    Boolean         managed;            /* is widget geometry managed?       */
    Boolean         sensitive;          /* is widget sensitive to user events*/
    Boolean         ancestor_sensitive; /* are all ancestors sensitive?      */
}AvsObjPart;

typedef struct _AvsObjRec {
    ObjectPart object;
    AvsObjPart avsobject;
} AvsObjRec;



/********************************************************
 * AVS Object Class Data Structures
 *
 ********************************************************/
/* these fields match CoreClassPart and can not be changed */
/* ideally these structures would only contain the fields required;
   but because the CoreClassPart cannot be changed at this late date
   extraneous fields are necessary to make the field offsets match */

typedef struct _AvsObjClassPart {

    WidgetClass     superclass;         /* pointer to superclass ClassRec   */
    String          class_name;         /* widget resource class name       */
    Cardinal        widget_size;        /* size in bytes of widget record   */
    XtProc          class_initialize;   /* class initialization proc        */
    XtWidgetClassProc class_part_initialize; /* dynamic initialization      */
    XtEnum          class_inited;       /* has class been initialized?      */
    XtInitProc      initialize;         /* initialize subclass fields       */
    XtArgsProc      initialize_hook;    /* notify that initialize called    */
    XtProc          holder1;		/* NULL                             */
    XtPointer       holder2;              /* NULL                             */
    Cardinal        holder3;              /* NULL                             */
    XtResourceList  resources;          /* resources for subclass fields    */
    Cardinal        num_resources;      /* number of entries in resources   */
    XrmClass        xrm_class;          /* resource class quarkified        */
    Boolean         holder4;              /* NULL                             */
    Boolean         holder5;              /* NULL                             */
    Boolean         holder6;              /* NULL				    */
    Boolean         holder7;              /* NULL                             */
    XtWidgetProc    destroy;            /* free data for subclass pointers  */
    XtWidgetProc    resize;             /* geom manager changed widget size */
    XtExposeProc    expose;             /* rediplay holderangle               */
    XtSetValuesFunc set_values;         /* set subclass resource values     */
    XtArgsFunc      set_values_hook;    /* notify that set_values called    */
    XtAlmostProc    set_values_almost;  /* set values almost for geometry   */
    XtArgsProc      get_values_hook;    /* notify that get_values called    */
    XtProc          holder9;              /* NULL                             */
    XtVersionType   version;            /* version of intrinsics used       */
    XtPointer       callback_private;   /* list of callback offsets         */
    String          holder10;             /* NULL                             */
    XtGeometryHandler query_geometry;   /* return preferred geometry        */
    XtProc          holder11;             /* NULL                             */
    XtPointer       extension;          /* pointer to extension record      */
} AvsObjClassPart;

typedef struct _AvsObjClassRec {
    AvsObjClassPart avsobj_class;
} AvsObjClassRec;

extern AvsObjClassRec avsObjClassRec;

#endif /*AvsObjP_h_*/
