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
* $Header: /cvs/xtest/xtest/xts5/src/lib/regid.c,v 1.2 2005-11-03 08:42:01 jmichael Exp $
*
* Copyright Applied Testing and Technology Inc. 1995
* All rights reserved
*
* Project: VSW5
*
* File:	xts5/src/lib/regid.c
*
* Description:
*	Resource registration routines
*
* Modifications:
* $Log: regid.c,v $
* Revision 1.2  2005-11-03 08:42:01  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:10  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:24:46  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:42:58  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:17:10  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:13:43  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.1  1996/01/25 01:57:14  andy
* Portability improvements from DEPLOY tools
*
* Revision 4.0  1995/12/15  08:42:54  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:40:17  andy
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

#include	<stdlib.h>
#include	<stdio.h>
#include	"xtest.h"
#include	<X11/Xlib.h>
#include	<X11/Xutil.h>
#include	"xtestlib.h"
#include	"tet_api.h"
#include	"pixval.h"

/*
 * All resources created by the library routines are to be
 * resistered here.  They are then freed automaticaly at the test end.
 * Options are provided to not free certain types of resource for
 * stress testing.
 */


/* Number of entries to allocate at once */
#define	NALLOC	256

struct	regid {
	int 	type;
	Display	*display;
	union	regtypes id;
};

static struct	regid	*saved;
static int 	savsize;
static int 	savcount;

static int 	Regenabled = 1;

/*
 * Get a free place to store something of the given type.
 * Finds a place in the list, expanding it it necessary.
 */
static	struct	regid *
getcell()
{
struct	regid	*rp;

	rp = saved;
	/*
	 * If not allocated yet then allocate a few cells for use.
	 */
	if (rp == NULL) {
		saved = (struct regid *)malloc(sizeof(struct regid)*NALLOC);
		savsize = NALLOC;
		savcount = 0;
	}

	/* If no more room then reallocate */
	if (savcount >= savsize) {
		saved = (struct regid *)realloc(rp, (savsize+NALLOC)*sizeof(struct regid));
		if (saved == NULL) {
			saved = rp;
			return((struct regid *)0);
		}
		savsize += NALLOC;
	}

	return(&saved[savcount++]);

}

/*
 * Register a resource for automatic freeing at the end of the
 * test.  Library functions that create resources register them here.
 * Tests may do so. It is important to not free anything that has
 * been registered manually.
 */
void
regid(disp, id, type)
Display	*disp;
union	regtypes	*id;
int 	type;
{
struct	regid	*savcell;

	if (!Regenabled)
		return;

	if (type >= REG_MAX)
		return;

	if (id == NULL)
		return;
	savcell = getcell();
	if (savcell == NULL)
		return;

	debug(2, "Save id 0x%x, type %d", *id, type);

	savcell->display = disp;
	savcell->type    = type;
	switch (type) {
	case	REG_IMAGE:
		savcell->id.image = id->image;
		break;
	case	REG_WINDOW:
		savcell->id.window = id->window;
		break;
	case	REG_PIXMAP:
		savcell->id.pixmap = id->pixmap;
		break;
	case	REG_GC:
		savcell->id.gc = id->gc;
		break;
	case	REG_COLORMAP:
		savcell->id.colormap = id->colormap;
		break;
	case	REG_CURSOR:
		savcell->id.cursor = id->cursor;
		break;
	case	REG_OPEN:
		savcell->id.display = id->display;
		break;
	case	REG_WINH:
		savcell->id.winh = id->winh;
		break;
	case	REG_POINTER:
		savcell->id.pointer = id->pointer;
		break;
	case	REG_MALLOC:
	case	REG_XMALLOC:
		savcell->id.malloc = id->malloc;
		break;
	case	REG_REGION:
		savcell->id.region = id->region;
		break;
	default:
		printf("Unknown type in regid\n");
		delete("Unknown type in regid, internal error");
	}

}

void
freereg()
{
struct	regid	*rp;

	if (savcount == 0)
		return;

	for (rp = &saved[savcount-1]; rp >= saved; rp--) {
		savcount--;
		debug(2, "Free id 0x%x, type %d", rp->id, rp->type);
		switch (rp->type) {
		case	REG_IMAGE:
			XDestroyImage(rp->id.image);
			break;
		case	REG_PIXMAP:
			XFreePixmap(rp->display, rp->id.pixmap);
			break;
		case	REG_WINDOW:
			XDestroyWindow(rp->display, rp->id.window);
			break;
		case	REG_GC:
			XFreeGC(rp->display, rp->id.gc);
			break;
		case	REG_COLORMAP:
			XFreeColormap(rp->display, rp->id.colormap);
			break;
		case	REG_CURSOR:
			XFreeCursor(rp->display, rp->id.cursor);
			break;
		case	REG_OPEN:
			XCloseDisplay(rp->id.display);
			break;
		case	REG_WINH:
			winh_free(rp->id.winh);
			break;
		case	REG_POINTER:
			unwarppointer(rp->display, rp->id.pointer);
			break;
		case	REG_MALLOC:
			free(rp->id.malloc);
			break;
		case	REG_XMALLOC:
			XFree(rp->id.malloc);
			break;
		case	REG_REGION:
			XDestroyRegion(rp->id.region);
			break;
		default:
			printf("Unknown type in freereg\n");
			delete("Unknown type in freereg, internal error");
		}
	}
	savcount = 0;
}

/*
 * Functions to enable and disable resource registration.  After disabling
 * it then resources can be freed explicitly.
 */
regenable()
{
	Regenabled = 1;
}
regdisable()
{
	Regenabled = 0;
}
