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
* $Header: /cvs/xtest/xtest/xts5/src/lib/makewin2.c,v 1.1 2005-02-12 14:37:15 anderson Exp $
*
* Copyright Applied Testing and Technology Inc. 1995
* All rights reserved
*
* Project: VSW5
*
* File:	vsw5/src/lib/makewin2.c
*
* Description:
*	Window creation routines
*
* Modifications:
* $Log: makewin2.c,v $
* Revision 1.1  2005-02-12 14:37:15  anderson
* Initial revision
*
* Revision 8.0  1998/12/23 23:24:43  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:42:55  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:17:07  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:13:40  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.1  1996/01/25 01:57:14  andy
* Portability improvements from DEPLOY tools
*
* Revision 4.0  1995/12/15  08:42:40  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:39:59  andy
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

#include	"stdlib.h"

#include	"xtest.h"
#include	"X11/Xlib.h"
#include	"X11/Xutil.h"
#include	"tet_api.h"
#include	"xtestlib.h"
#include	"pixval.h"

#define	BORDER	1

/*
 * Position for windows.  It is not neccessary to place them all at differing
 * positions but it useful to see what is happening.
 */
static	int 	xpos = 10;
static	int 	ypos = 5;

Drawable	mkwinpos();
Drawable	mkunmapwinpos();
static void incxy();

#define	GAP	10

/*
 * Creates a general purpose window that can be used within the
 * test suite.  It has parent as parent, and can inherits its depth
 * visual etc.  The border and background are not set to
 * any particular colour, but have pixel values of 1 and 0. (???)
 * If mapflag:
 *	The window is mapped, but the routine does *NOT* waits
 *	for the first expose event.
 * No events are selected for the created window.
 */
Window
mkwinchild(disp, vp, ap, mapflag, parent, border_width)
Display	*disp;
XVisualInfo	*vp;
struct	area	*ap;
int		mapflag;
Window		parent;
int		border_width;
{
Window	w;
struct	area	area;
XSetWindowAttributes	atts;
int	depth;
Visual	*visual;
unsigned long cmap_attr = 0;

	if (ap == (struct area *) NULL) {
		ap = &area;
		incxy(disp, border_width, vp);
		ap->x = xpos;
		ap->y = ypos;
		ap->width = W_STDWIDTH;
		ap->height = W_STDHEIGHT;
	}
	if (vp == (XVisualInfo *) NULL) {
		depth = CopyFromParent;
		visual = (Visual *) CopyFromParent;
	}
	else {
		/*
               * If depth and visual are specified, there are no guarantees
		 * that they will match that of the parent.  In this instance,
		 * explicitly create a colormap of the visual type to ensure
               * that no unexpected BadMatch error is generated.
               */
		depth = vp->depth;
		visual= vp->visual;
                atts.colormap = makecolmap(disp, visual, AllocNone);
                cmap_attr = CWColormap;
	}

	atts.override_redirect = config.debug_override_redirect;
	atts.border_pixel = BORDER;
	atts.background_pixel = W_BG;

	w = XCreateWindow(disp
		, parent
		, ap->x
		, ap->y
		, ap->width
		, ap->height
		, border_width
		, depth
		, InputOutput
		, visual
		, CWOverrideRedirect | CWBorderPixel | CWBackPixel | cmap_attr
		, &atts
		);
	/* Any errors are handled by unexp_err */

	regid(disp, (union regtypes *)&w, REG_WINDOW);

	if (mapflag) {
		XMapWindow(disp, w);
	}
	return(w);
}

/*
 * Creates a general purpose window that can be used within the
 * test suite.  It has the Root as parent, and inherits its depth
 * visual etc.  The border and background are not set to
 * any particular colour, but have pixel values of 1 and 0. (???)
 * If mapflag:
 *	The window is mapped, but the routine does *NOT* waits
 *	for the first expose event.
 * No events are selected for the created window.
 */
Window
mkwin(disp, vp, ap, mapflag)
Display	*disp;
XVisualInfo	*vp;
struct	area	*ap;
int		mapflag;
{
	return(mkwinchild(disp, vp, ap, mapflag, DefaultRootWindow(disp), 1));
}


static void
incxy(disp, bw, vp)
Display	*disp;
XVisualInfo *vp;
{
unsigned int 	dwidth, dheight;

	/*
	 * Increment the positions so that the windows do not overlap.  This is
	 * essential for winpair() and useful to see what is happening for
	 * the rest.  Avoid positions with x or y zero.
	 */
	xpos += 23;
	ypos += W_STDHEIGHT+2*bw+1;

	dwidth = DisplayWidth(disp, (vp? vp->screen : DefaultScreen(disp)));
	dheight = DisplayHeight(disp, (vp? vp->screen: DefaultScreen(disp)));

	while (ypos+W_STDHEIGHT+2*bw > dheight)
		ypos -= dheight;
	while (ypos <= 0)
		ypos += W_STDHEIGHT;
	while (xpos+(2*bw+W_STDWIDTH) > dwidth)
		xpos -= dwidth;
	while (xpos <= 0)
		xpos += W_STDWIDTH;
}
