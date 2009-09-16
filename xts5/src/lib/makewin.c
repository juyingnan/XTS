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
* Copyright Applied Testing and Technology Inc. 1995
* All rights reserved
*
* Project: VSW5
*
* File:	xts5/src/lib/makewin.c
*
* Description:
*	Window creation routines
*
* Modifications:
* $Log: makewin.c,v $
* Revision 1.2  2005-11-03 08:42:01  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:10  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:24:43  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:42:55  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.2  1998/09/29 20:51:30  mar
* vswsr217: XSync the proper disp, since isdeleted() calls XSync(Dsp) instead
*
* Revision 6.1  1998/07/23 21:08:47  andy
* Added additional check for isdeleted in makewinpos in case color
* map allocation fails.  SR 200.
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
* Revision 4.0  1995/12/15  08:42:38  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:39:57  andy
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

#include	"stdlib.h"

#include	"xtest.h"
#include	"X11/Xlib.h"
#include	"X11/Xutil.h"
#include	"tet_api.h"
#include	"xtestlib.h"
#include	"pixval.h"

#define	BORDER	1

/* The border width must remain the same. */
#define	BWIDTH	1

/*
 * Position for windows.  It is not neccessary to place them all at differing
 * positions but it useful to see what is happening.
 */
static	int 	xpos = 10;
static	int 	ypos = 5;

Window	makewinpos();
static void incxy();


/*
 * Creates a general purpose window that can be used within the
 * test suite.  It has the Root as parent, and inherits its depth
 * visual etc.  The border and background are not set to
 * any particular colour, but have pixel values of 1 and 0. (???)
 * The window is mapped and the routine waits for the first expose event.
 * If the visual arg is NULL then a pixmap with the given depth is
 * created.  It has the same size as the window would.
 */
Window
makewin(disp, vp)
Display	*disp;
XVisualInfo	*vp;
{
Window	w;

	incxy(disp, vp);
	w = makewinpos(disp, vp, xpos, ypos);

	return(w);
}

/*
 * Make a pair of windows that are not overlapping.  They will both have the
 * same root and depth.  Otherwise just like makewin.
 */
void
winpair(disp, vp, w1p, w2p)
Display *disp;
XVisualInfo	*vp;
Window	*w1p;
Window	*w2p;
{

	incxy(disp, vp);
	*w1p = makewinpos(disp, vp, xpos, ypos);

	incxy(disp, vp);
	*w2p = makewinpos(disp, vp, xpos, ypos);

}

/*
 * Make a window at a particular position. Otherwise like makewin() which
 * calls this routine.  If the visual member of vp is NULL then a pixmap
 * of the given depth is created instead.
 */
Drawable
makewinpos(disp, vp, x, y)
Display	*disp;
XVisualInfo	*vp;
int 	x;
int 	y;
{
Window	w;
XEvent	event;
XSetWindowAttributes	atts;
Colormap	cmap;
char	*dboride;

	if (vp->visual == 0) {
		return((Drawable)makepixm(disp, vp));
	}

	dboride = tet_getvar("XT_DEBUG_OVERRIDE_REDIRECT");
	if (dboride && (*dboride == 'y' || *dboride == 'Y'))
		atts.override_redirect = 1;
	else
		atts.override_redirect = 0;
	atts.border_pixel = BORDER;
	atts.background_pixel = W_BG;

	switch (vp->class) {
	case StaticGray:
	case StaticColor:
	case TrueColor:
		cmap = XCreateColormap(disp, RootWindow(disp, vp->screen),
					vp->visual, AllocNone);
	
		break;
	case GrayScale:
	case PseudoColor:
	case DirectColor:
		cmap = XCreateColormap(disp, RootWindow(disp, vp->screen),
					vp->visual, AllocAll);
		break;
	}

	if (isdeleted())
		return None; /* avoid waiting for events that won't happen. */

	regid(disp, (union regtypes *) &cmap, REG_COLORMAP);
	atts.colormap = cmap;

	w = XCreateWindow(disp
		, RootWindow(disp, vp->screen)
		, x
		, y
		, W_STDWIDTH
		, W_STDHEIGHT
		, BWIDTH
		, vp->depth
		, InputOutput
		, vp->visual
		, CWOverrideRedirect | CWBorderPixel | CWBackPixel | CWColormap
		, &atts
		);
	/* Any errors are handled by unexp_err */

	XSync(disp, False);
	if (isdeleted())
		return None; /* avoid waiting for events that won't happen. */
	XSelectInput(disp, w, ExposureMask);
	XMapWindow(disp, w);
	XWindowEvent(disp, w, ExposureMask, &event);
	XSelectInput(disp, w, NoEventMask);

	regid(disp, (union regtypes *)&w, REG_WINDOW);

	return((Drawable)w);
}

static void
incxy(disp, vp)
Display	*disp;
XVisualInfo	*vp;
{
unsigned int 	dwidth, dheight;

	/*
	 * Increment the positions so that the windows do not overlap.  This is
	 * essential for winpair() and useful to see what is happening for
	 * the rest.  Avoid positions with x or y zero.
	 */
	xpos += 23;
	ypos += W_STDHEIGHT+2*BWIDTH+1;

	dwidth = DisplayWidth(disp, vp->screen);
	dheight = DisplayHeight(disp, vp->screen);

	while (ypos+W_STDHEIGHT+2*BWIDTH > dheight)
		ypos -= dheight;
	while (ypos <= 0)
		ypos += W_STDHEIGHT;
	while (xpos+(2*BWIDTH+W_STDWIDTH) > dwidth)
		xpos -= dwidth;
	while (xpos <= 0)
		xpos += W_STDWIDTH;
}
