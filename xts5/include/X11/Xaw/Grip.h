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
* $Header: /cvs/xtest/xtest/xts5/include/X11/Xaw/Grip.h,v 1.1 2005-02-12 14:37:13 anderson Exp $
*
* Copyright (c) Applied Testing and Technology, Inc. 1995
* All Rights Reserved.
*
* Project: VSW5
*
* File: vsw5/include/X11/Xaw/Grip.h
*
* Description:
*	Defines used by the version of Athena widgets include in VSW5
*
* Modifications:
* $Log: Grip.h,v $
* Revision 1.1  2005-02-12 14:37:13  anderson
* Initial revision
*
* Revision 8.0  1998/12/23 23:23:03  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:41:04  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:15:36  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:12:08  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:39:04  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:35:07  andy
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

/*
 *  Grip.h - Public Definitions for Grip widget (used by VPane Widget)
 *
 */

#ifndef _XawGrip_h
#define _XawGrip_h

#include <X11/Xaw/Simple.h>

/***************************************************************************
 *
 * Grip Widget 
 *
 **************************************************************************/

/* Parameters:

 Name		     Class		RepType		Default Value
 ----		     -----		-------		-------------
 foreground	     Foreground		Pixel		XtDefaultForeground
 border		     BorderColor	Pixel		XtDefaultForeground
 borderWidth	     BorderWidth	Dimension	0
 callback	     Callback		Pointer		GripAction
 cursor		     Cursor		Cursor		None
 cursorName	     Cursor		String		NULL
 destroyCallback     Callback		Pointer		NULL
 height		     Height		Dimension	8
 mappedWhenManaged   MappedWhenManaged	Boolean		True
 pointerColor	     Foreground		Pixel		XtDefaultForeground
 pointerColorBackground Background	Pixel		XtDefaultBackground
 sensitive	     Sensitive		Boolean		True
 width		     Width		Dimension	8
 x		     Position		Position	0
 y		     Position		Position	0

*/

#define XtNgripTranslations "gripTranslations"

typedef struct _XawGripCallData {
  XEvent *event;		/* the event causing the GripAction */
  String *params;		/* the TranslationTable params */
  Cardinal num_params;		/* count of params */
} XawGripCallDataRec, *XawGripCallData,
    GripCallDataRec, *GripCallData; /* supported for R4 compatibility */

/* Class Record Constant */

extern WidgetClass gripWidgetClass;

typedef struct _GripClassRec *GripWidgetClass;
typedef struct _GripRec      *GripWidget;

#endif /* _XawGrip_h */
