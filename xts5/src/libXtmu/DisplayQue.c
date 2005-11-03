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
* $Header: /cvs/xtest/xtest/xts5/src/libXtmu/DisplayQue.c,v 1.3 2005-11-03 08:42:02 jmichael Exp $
*
* Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
* All Rights Reserved.
*
* Project: VSW5
*
* File: xts5/src/lib/libXtaw/DisplayQue.c
*
* Description:
*	Subset of libXmu need for VSW5.  Use if implementation does not
*	support Athena.
*
* Modifications:
* $Log: DisplayQue.c,v $
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
* Revision 7.0  1998/10/30 22:44:15  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:18:18  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:14:50  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:46:23  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:44:30  andy
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

#include <stdio.h>
#include <X11/Xos.h>
#include <X11/Xlib.h>
#include <X11/Xmu/DisplayQue.h>

static int _DQCloseDisplay();

#define CallCloseCallback(q,e) (void) (*((q)->closefunc)) ((q), (e))
#define CallFreeCallback(q) (void) (*((q)->freefunc)) ((q))

/*
 * XmuDQCreate - create a display queue
 */
XmuDisplayQueue *XmuDQCreate (closefunc, freefunc, data)
    XmuCloseDisplayQueueProc closefunc;
    XmuFreeDisplayQueueProc freefunc;
    caddr_t data;
{
    XmuDisplayQueue *q = (XmuDisplayQueue *) malloc (sizeof (XmuDisplayQueue));
    if (q) {
	q->nentries = 0;
	q->head = q->tail = NULL;
	q->closefunc = closefunc;
	q->freefunc = freefunc;
	q->data = data;
    }
    return q;
}


/*
 * XmuDQDestroy - free all storage associated with this display queue, 
 * optionally invoking the close callbacks.
 */

Bool XmuDQDestroy (q, docallbacks)
    XmuDisplayQueue *q;
    Bool docallbacks;
{
    XmuDisplayQueueEntry *e = q->head;

    while (e) {
	XmuDisplayQueueEntry *nexte = e->next;
	if (docallbacks && q->closefunc) CallCloseCallback (q, e);
	free ((char *) e);
	e = nexte;
    }
    free ((char *) q);
    return True;
}


/*
 * XmuDQLookupDisplay - finds the indicated display on the given queue
 */
XmuDisplayQueueEntry *XmuDQLookupDisplay (q, dpy)
    XmuDisplayQueue *q;
    Display *dpy;
{
    XmuDisplayQueueEntry *e;

    for (e = q->head; e; e = e->next) {
	if (e->display == dpy) return e;
    }
    return NULL;
}


/*
 * XmuDQAddDisplay - add the specified display to the queue; set data as a
 * convenience.  Does not ensure that dpy hasn't already been added.
 */
XmuDisplayQueueEntry *XmuDQAddDisplay (q, dpy, data)
    XmuDisplayQueue *q;
    Display *dpy;
    caddr_t data;
{
    XmuDisplayQueueEntry *e;

    if (!(e = (XmuDisplayQueueEntry *) malloc (sizeof (XmuDisplayQueueEntry)))) {
	return NULL;
    }
    if (!(e->closehook = XmuAddCloseDisplayHook (dpy, _DQCloseDisplay,
						 (caddr_t) q))) {
	free ((char *) e);
	return NULL;
    }

    e->display = dpy;
    e->next = NULL;
    e->data = data;

    if (q->tail) {
	q->tail->next = e;
	e->prev = q->tail;
    } else {
	q->head = e;
	e->prev = NULL;
    }
    q->tail = e;
    q->nentries++;
    return e;
}


/*
 * XmuDQRemoveDisplay - remove the specified display from the queue
 */
Bool XmuDQRemoveDisplay (q, dpy)
    XmuDisplayQueue *q;
    Display *dpy;
{
    XmuDisplayQueueEntry *e;

    for (e = q->head; e; e = e->next) {
	if (e->display == dpy) {
	    if (q->head == e)
	      q->head = e->next;	/* if at head, then bump head */
	    else
	      e->prev->next = e->next;	/* else splice out */
	    if (q->tail == e)
	      q->tail = e->prev;	/* if at tail, then bump tail */
	    else
	      e->next->prev = e->prev;	/* else splice out */
	    (void) XmuRemoveCloseDisplayHook (dpy, e->closehook,
					      _DQCloseDisplay, (caddr_t) q);
	    free ((char *) e);
	    q->nentries--;
	    return True;
	}
    }
    return False;
}


/*****************************************************************************
 *			       private functions                             *
 *****************************************************************************/

/*
 * _DQCloseDisplay - upcalled from CloseHook to notify this queue; remove the
 * display when finished
 */
static int _DQCloseDisplay (dpy, arg)
    Display *dpy;
    caddr_t arg;
{
    XmuDisplayQueue *q = (XmuDisplayQueue *) arg;
    XmuDisplayQueueEntry *e;

    for (e = q->head; e; e = e->next) {
	if (e->display == dpy) {
	    if (q->closefunc) CallCloseCallback (q, e);
	    (void) XmuDQRemoveDisplay (q, dpy);
	    if (q->nentries == 0 && q->freefunc) CallFreeCallback (q);
	    return 1;
	}
    }

    return 0;
}
