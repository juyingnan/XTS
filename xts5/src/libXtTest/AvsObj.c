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
* $Header: /cvs/xtest/xtest/xts5/src/libXtTest/AvsObj.c,v 1.1 2005-02-12 14:37:15 anderson Exp $
*
* Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
* Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
* All Rights Reserved.
*
* Project: VSW5
*
* File: vsw5/src/lib/libXtTest/AvsObj.c
*
* Description:
*	Test widget
*
* Modifications:
* $Log: AvsObj.c,v $
* Revision 1.1  2005-02-12 14:37:15  anderson
* Initial revision
*
* Revision 8.0  1998/12/23 23:25:31  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:43:45  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:17:51  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:14:23  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:45:00  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:42:51  andy
* Prepare for GA Release
*
*/


/*
** This is the source for AvsObject.  The AvsObject is an X11 Object that
** serves two purposes.  First it allows testing of calls that require an
** object that is not a widget (it may be desirable in the future to add
** an AvsAvsObj, which would allow tests that require a "gadget").  Second,
** it includes convenience routines to allow testing of XtCallCallbackList.
** It is necessary to enclose these test inside an Object so that the internal
** CallbackList, as created by Xt, is available.
*/

/*
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

*/
#include <XtTest.h>

#include <X11/IntrinsicP.h>
#include "AvsObjP.h"
/*
** Resources for the AVS Object
*/

#ifdef ADD_RESOURCES
static XtResource resources[] = {
    };
#endif

static void AvsObjInitialize();
static void AvsObjClassPartInitialize();
static void AvsObjSetValuesAlmost();

AvsObjClassRec avsObjClassRec = {
  {
    /* superclass	  */	(WidgetClass)&objectClassRec,
    /* class_name	  */	"AvsObj",
    /* widget_size	  */	sizeof(AvsObjRec),
    /* class_initialize   */    NULL,
    /* class_part_initialize*/	AvsObjClassPartInitialize,
    /* class_inited       */	FALSE,
    /* initialize	  */	AvsObjInitialize,
    /* initialize_hook    */	NULL,		
    /* realize		  */	NULL,
    /* actions		  */	NULL,
    /* num_actions	  */	0,
#ifdef ADD_RESROUCES
    /* resources	  */	resources,
    /* num_resources	  */	XtNumber(resources),
#else
    /* resources	  */	NULL,
    /* num_resources	  */	0,
#endif
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
    /* set_values_almost  */	AvsObjSetValuesAlmost,  
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


WidgetClass avsObjClass = (WidgetClass)&avsObjClassRec;

/*
 * Start of AVS object methods
 */


static void AvsObjClassPartInitialize(wc)
    register WidgetClass wc;
{
/*
    register AvsObjClass roc = (AvsObjClass)wc;
    register AvsObjClass super = ((AvsObjClass)roc->avsobj_class.superclass);
*/

}

/* ARGSUSED */
static void AvsObjInitialize(requested_widget, new_widget)
    Widget   requested_widget;
    register Widget new_widget;
{
}

/*ARGSUSED*/
static void AvsObjSetValuesAlmost(old, new, request, reply)
    Widget		old;
    Widget		new;
    XtWidgetGeometry    *request;
    XtWidgetGeometry    *reply;
{
    *request = *reply;
}

void AvsObjCallCallbackList(w, call_data, event_num)
Widget w;
XtPointer call_data;
int event_num;
{
	XtCallCallbackList(w, w->core.destroy_callbacks, call_data);
	avs_set_event(event_num, 1);
}
