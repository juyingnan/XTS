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
* $Header: /cvs/xtest/xtest/xts5/include/X11/Xaw/Logo.h,v 1.1 2005-02-12 14:37:13 anderson Exp $
*
* Copyright (c) Applied Testing and Technology, Inc. 1995
* All Rights Reserved.
*
* Project: VSW5
*
* File: vsw5/include/X11/Xaw/Logo.h
*
* Description:
*	Defines used by the version of Athena widgets include in VSW5
*
* Modifications:
* $Log: Logo.h,v $
* Revision 1.1  2005-02-12 14:37:13  anderson
* Initial revision
*
* Revision 8.0  1998/12/23 23:23:05  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:41:06  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:15:38  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:12:10  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:39:09  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:35:13  andy
* Prepare for GA Release
*
*/


/*
Copyright 1988 by the Massachusetts Institute of Technology

Permission to use, copy, modify, and distribute this
software and its documentation for any purpose and without
fee is hereby granted, provided that the above copyright
notice appear in all copies and that both that copyright
notice and this permission notice appear in supporting
documentation, and that the name of M.I.T. not be used in
advertising or publicity pertaining to distribution of the
software without specific, written prior permission.
M.I.T. makes no representations about the suitability of
this software for any purpose.  It is provided "as is"
without express or implied warranty.
*/

#ifndef _XawLogo_h
#define _XawLogo_h

/* Parameters:

 Name		     Class		RepType		Default Value
 ----		     -----		-------		-------------
 background	     Background		Pixel		XtDefaultBackground
 border		     BorderColor	Pixel		XtDefaultForeground
 borderWidth	     BorderWidth	Dimension	1
 destroyCallback     Callback		Pointer		NULL
 foreground	     Foreground		Pixel		XtDefaultForeground
 height		     Height		Dimension	100
 mappedWhenManaged   MappedWhenManaged	Boolean		True
 shapeWindow	     ShapeWindow	Boolean		False
 width		     Width		Dimension	100
 x		     Position		Position	0
 y		     Position		Position	0

*/

#define XtNshapeWindow "shapeWindow"
#define XtCShapeWindow "ShapeWindow"

typedef struct _LogoRec *LogoWidget;
typedef struct _LogoClassRec *LogoWidgetClass;

extern WidgetClass logoWidgetClass;

#endif /* _XawLogo_h */
