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
* $Header: /cvs/xtest/xtest/xts5/include/X11/Xmu/DisplayQue.h,v 1.2 2005-04-15 14:27:44 anderson Exp $
*
* Copyright (c) Applied Testing and Technology, Inc. 1995
* All Rights Reserved.
*
* Project: VSW5
*
* File: vsw5/include/X11/Xmu/DisplayQue.h
*
* Description:
*	Defines used by the version of Athena widgets include in VSW5
*
* Modifications:
* $Log: DisplayQue.h,v $
* Revision 1.2  2005-04-15 14:27:44  anderson
* Merge basline changes
*
* Revision 1.1  2005/02/12 14:37:13  anderson
* Initial revision
*
* Revision 8.0  1998/12/23 23:23:17  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:41:21  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:15:48  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:12:20  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:39:41  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:35:53  andy
* Prepare for GA Release
*
*/

/* 
 *
 * Copyright 1989 Massachusetts Institute of Technology
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
 *
 */

#ifndef _XMU_DISPLAYQUE_H_
#define _XMU_DISPLAYQUE_H_

#include <X11/Xmu/CloseHook.h>
#include <X11/Xfuncproto.h>

/*
 *			      Public Entry Points
 * 
 * 
 * XmuDisplayQueue *XmuDQCreate (closefunc, freefunc, data)
 *     XmuCloseDisplayQueueProc closefunc;
 *     XmuFreeDisplayQueueProc freefunc;
 *     caddr_t data;
 * 
 *         Creates and returns a queue into which displays may be placed.  When
 *         the display is closed, the closefunc (if non-NULL) is upcalled with
 *         as follows:
 *
 *                 (*closefunc) (queue, entry)
 *
 *         The freeproc, if non-NULL, is called whenever the last display is
 *         closed, notifying the creator that display queue may be released
 *         using XmuDQDestroy.
 *
 *
 * Bool XmuDQDestroy (q, docallbacks)
 *     XmuDisplayQueue *q;
 *     Bool docallbacks;
 * 
 *         Releases all memory for the indicated display queue.  If docallbacks
 *         is true, then the closefunc (if non-NULL) is called for each 
 *         display.
 * 
 * 
 * XmuDisplayQueueEntry *XmuDQLookupDisplay (q, dpy)
 *     XmuDisplayQueue *q;
 *     Display *dpy;
 *
 *         Returns the queue entry for the specified display or NULL if the
 *         display is not in the queue.
 *
 * 
 * XmuDisplayQueueEntry *XmuDQAddDisplay (q, dpy, data)
 *     XmuDisplayQueue *q;
 *     Display *dpy;
 *     caddr_t data;
 *
 *         Adds the indicated display to the end of the queue or NULL if it
 *         is unable to allocate memory.  The data field may be used by the
 *         caller to attach arbitrary data to this display in this queue.  The
 *         caller should use XmuDQLookupDisplay to make sure that the display
 *         hasn't already been added.
 * 
 * 
 * Bool XmuDQRemoveDisplay (q, dpy)
 *     XmuDisplayQueue *q;
 *     Display *dpy;
 *
 *         Removes the specified display from the given queue.  If the 
 *         indicated display is not found on this queue, False is returned,
 *         otherwise True is returned.
 */

typedef struct _XmuDisplayQueue XmuDisplayQueue;
typedef struct _XmuDisplayQueueEntry XmuDisplayQueueEntry;

typedef int (*XmuCloseDisplayQueueProc)(
#if NeedFunctionPrototypes
    XmuDisplayQueue*		/* queue */,
    XmuDisplayQueueEntry*	/* entry */
#endif
);

typedef int (*XmuFreeDisplayQueueProc)(
#if NeedFunctionPrototypes
    XmuDisplayQueue*		/* queue */
#endif
);

struct _XmuDisplayQueueEntry {
    struct _XmuDisplayQueueEntry *prev, *next;
    Display *display;
    CloseHook closehook;
    caddr_t data;
};

struct _XmuDisplayQueue {
    int nentries;
    XmuDisplayQueueEntry *head, *tail;
    XmuCloseDisplayQueueProc closefunc;
    XmuFreeDisplayQueueProc freefunc;
    caddr_t data;
};

_XFUNCPROTOBEGIN

extern XmuDisplayQueue *XmuDQCreate(
#if NeedFunctionPrototypes
    XmuCloseDisplayQueueProc	/* closefunc */,
    XmuFreeDisplayQueueProc	/* freefunc */,
    caddr_t	/* data */
#endif
);

extern Bool XmuDQDestroy(
#if NeedFunctionPrototypes
    XmuDisplayQueue*	/* q */,
    Bool		/* docallbacks */
#endif
);

extern XmuDisplayQueueEntry *XmuDQLookupDisplay(
#if NeedFunctionPrototypes
    XmuDisplayQueue*	/* q */,
    Display*		/* dpy */
#endif
);

extern XmuDisplayQueueEntry *XmuDQAddDisplay(
#if NeedFunctionPrototypes
    XmuDisplayQueue*	/* q */,
    Display*		/* dpy */,
    caddr_t		/* data */
#endif
);

extern Bool XmuDQRemoveDisplay(
#if NeedFunctionPrototypes
    XmuDisplayQueue*	/* q */,
    Display*		/* dpy */
#endif
);

_XFUNCPROTOEND

#define XmuDQNDisplays(q) ((q)->nentries)

#endif /* _XMU_DISPLAYQUE_H_ */
