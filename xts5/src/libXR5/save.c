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
* $Header: /cvs/xtest/xtest/xts5/src/libXR5/save.c,v 1.2 2005-11-03 08:42:02 jmichael Exp $
*
* Copyright Applied Testing and Technology Inc. 1995
* All rights reserved
*
* Project: VSW5
*
* File:	xts5/src/libXR5/save.c
*
* Description:
*	GC copy routines
*
* Modifications:
* $Log: save.c,v $
* Revision 1.2  2005-11-03 08:42:02  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:10  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:25:49  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:44:04  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:18:07  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:14:39  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.1  1996/01/25 01:28:53  andy
* Portability improvements from DEPLOY tools
*
* Revision 4.0  1995/12/15  08:45:44  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:43:47  andy
* Prepare for GA Release
*
*/

/*
Portions of this software are based on Xlib and X Protocol Test Suite.
We have used this material under the terms of its copyright, which grants
free use, subject to the conditions below.  Note however that those
portions of this software that are based on the original Test Suite have
been significantly revised and that all such revisions are copyright (c)
1995 Applied Testing and Technology, Inc.  Insomuch as the proprietary
revisions cannot be separated from the freely copyable material, the net
result is that use of this software is governed by the ApTest copyright.

Copyright (c) 1990, 1991  X Consortium

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
X CONSORTIUM BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

Except as contained in this notice, the name of the X Consortium shall not be
used in advertising or otherwise to promote the sale, use or other dealings
in this Software without prior written authorization from the X Consortium.

Copyright 1990, 1991 by UniSoft Group Limited.

Permission to use, copy, modify, distribute, and sell this software and
its documentation for any purpose is hereby granted without fee,
provided that the above copyright notice appear in all copies and that
both that copyright notice and this permission notice appear in
supporting documentation, and that the name of UniSoft not be
used in advertising or publicity pertaining to distribution of the
software without specific, written prior permission.  UniSoft
makes no representations about the suitability of this software for any
purpose.  It is provided "as is" without express or implied warranty.
*/

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <stdio.h>
#include <X11/Xlib.h>
#include <X11/Xutil.h>
#include <r5structs.h>
#include <r5decl.h>

int errorflag;	/**return value of function**/

int 
DummyEH(display_struc, error_event)
Display      *display_struc;
XErrorEvent  *error_event;
{
	errorflag = 1;
	return (REGR_FAILURE);
}


int 
save_stat(save_mask, gc_id, display_struc, drawable_id)
int     save_mask;
GC      gc_id;
Display *display_struc;
Drawable  drawable_id;
{
	extern int unexp_err();
	extern Display *dpy_save;
	extern Window wid_save;
	extern Pixmap pid_save;
	extern GC gc_save;
	extern XWindowAttributes wat_save;
	int DummyEH();

	errorflag = 0;
	XSetErrorHandler(DummyEH);
	if (((gc_msk & save_mask) != 0) && (gc_id != 0)) /* graphics context */
	    XCopyGC(display_struc, gc_id, 
		    GCFunction | GCPlaneMask | GCForeground | GCBackground |
		    GCLineWidth | GCLineStyle | GCCapStyle | GCJoinStyle | GCFillStyle |
		    GCFillRule | GCTile | GCStipple | GCTileStipXOrigin |
		    GCTileStipYOrigin | GCFont | GCSubwindowMode | 
		    GCGraphicsExposures | GCClipXOrigin | GCClipYOrigin |
		    GCClipMask | GCDashOffset | GCDashList | GCArcMode,
		    gc_save);
/*	if ((dpy_msk & save_mask) != 0) 		* disable display structure checking for now *
	    dpy_save = display_struc; */
	if ((win_msk & save_mask) != 0) {		/* window attributes for default window*/
	    XGetWindowAttributes (display_struc, drawable_id, &wat_save);
	    wid_save = drawable_id;         
	}
	if ((pix_msk & save_mask) != 0) 		/* pixmap id */
	    pid_save = drawable_id;
	XSetErrorHandler(unexp_err);
	return (errorflag);				/*return status*/
}
