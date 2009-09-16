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
* Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
* All Rights Reserved.
*
* Project: VSW5
*
* File: xts5/src/lib/libXtaw/CvtCache.c
*
* Description:
*	Subset of libXmu need for VSW5.  Use if implementation does not
*	support Athena.
*
* Modifications:
* $Log: CvtCache.c,v $
* Revision 1.3  2005-11-03 08:42:02  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.2  2005/04/15 14:32:12  anderson
* Merge basline changes
*
* Revision 1.1  2005/02/12 14:37:15  anderson
* Initial revision
*
* Revision 8.0  1998/12/23 23:26:00  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:44:14  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:18:17  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:14:49  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:46:21  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:44:29  andy
* Prepare for GA Release
*
*/
/*
 *
 * Copyright 1989 Massachusetts Institute of Technology
 *
 * Permission to use, copy, modify, and distribute this software and its
 * documentation for any purpose and without fee is hereby granted, provided
 * that the above copyright notice appear in all copies and that both that
 * copyright notice and this permission notice appear in supporting
 * documentation, and that the name of M.I.T. not be used in advertising
 * or publicity pertaining to distribution of the software without specific,
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

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <stdio.h>
#include <stdlib.h>
#include <X11/Xlib.h>
#include <X11/Xos.h>
#include <X11/Xmu/CvtCache.h>

static XmuDisplayQueue *dq = NULL;
static int _CloseDisplay(), _FreeCCDQ();



/*
 * internal utility callbacks
 */

static int _FreeCCDQ (q)
    XmuDisplayQueue *q;
{
    XmuDQDestroy (dq, False);
    dq = NULL;
}


static int _CloseDisplay (q, e)
    XmuDisplayQueue *q;
    XmuDisplayQueueEntry *e;
{
    XmuCvtCache *c;
    extern void _XmuStringToBitmapFreeCache();

    if (e && (c = (XmuCvtCache *)(e->data))) {
	_XmuStringToBitmapFreeCache (c);
	/* insert calls to free any cached memory */

    }
    return 0;
}

static void _InitializeCvtCache (c)
    register XmuCvtCache *c;
{
    extern void _XmuStringToBitmapInitCache();

    _XmuStringToBitmapInitCache (c);
    /* insert calls to init any cached memory */
}


/*
 * XmuCCLookupDisplay - return the cache entry for the indicated display;
 * initialize the cache if necessary
 */
XmuCvtCache *_XmuCCLookupDisplay (dpy)
    Display *dpy;
{
    XmuDisplayQueueEntry *e;

    /*
     * If no displays have been added before this, create the display queue.
     */
    if (!dq) {
	dq = XmuDQCreate (_CloseDisplay, _FreeCCDQ, NULL);
	if (!dq) return NULL;
    }
    
    /*
     * See if the display is already there
     */
    e = XmuDQLookupDisplay (dq, dpy);	/* see if it's there */
    if (!e) {				/* else create it */
	XmuCvtCache *c = (XmuCvtCache *) malloc (sizeof (XmuCvtCache));
	if (!c) return NULL;

	/*
	 * Add the display to the queue
	 */
	e = XmuDQAddDisplay (dq, dpy, (caddr_t) c);
	if (!e) {
	    free ((char *) c);
	    return NULL;
	}

	/*
	 * initialize fields in cache
	 */
	_InitializeCvtCache (c);
    }

    /*
     * got it
     */
    return (XmuCvtCache *)(e->data);
}


