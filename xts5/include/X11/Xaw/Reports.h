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
* $Header: /cvs/xtest/xtest/xts5/include/X11/Xaw/Reports.h,v 1.1 2005-02-12 14:37:13 anderson Exp $
*
* Copyright (c) Applied Testing and Technology, Inc. 1995
* All Rights Reserved.
*
* Project: VSW5
*
* File: vsw5/include/X11/Xaw/Reports.h
*
* Description:
*	Defines used by the version of Athena widgets include in VSW5
*
* Modifications:
* $Log: Reports.h,v $
* Revision 1.1  2005-02-12 14:37:13  anderson
* Initial revision
*
* Revision 8.0  1998/12/23 23:23:07  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:41:07  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:15:39  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:12:11  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:39:13  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:35:19  andy
* Prepare for GA Release
*
*/

/*
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
 */

#ifndef _Xaw_Reports_h
#define _Xaw_Reports_h

/*
 * XawPannerReport - this structure is used by the reportCallback of the
 * Panner, Porthole, Viewport, and Scrollbar widgets to report its position.
 * All fields must be filled in, although the changed field may be used as
 * a hint as to which fields have been altered since the last report.
 */
typedef struct {
    unsigned int changed;		/* mask, see below */
    Position slider_x, slider_y;	/* location of slider within outer */
    Dimension slider_width, slider_height;  /* size of slider */
    Dimension canvas_width, canvas_height;  /* size of canvas */
} XawPannerReport;

#define XawPRSliderX		(1 << 0)
#define XawPRSliderY		(1 << 1)
#define XawPRSliderWidth	(1 << 2)
#define XawPRSliderHeight	(1 << 3)
#define XawPRCanvasWidth	(1 << 4)
#define XawPRCanvasHeight	(1 << 5)
#define XawPRAll		(63)	/* union of above */

#define XtNreportCallback "reportCallback"
#define XtCReportCallback "reportCallback"

#endif /* _Xaw_Reports_h */