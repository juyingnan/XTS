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
* $Header: /cvs/xtest/xtest/xts5/src/libXtmu/CloseHook.c,v 1.3 2005-11-03 08:42:02 jmichael Exp $
*
* Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
* All Rights Reserved.
*
* Project: VSW5
*
* File: xts5/src/lib/libXtaw/CloseHook.c
*
* Description:
*	Subset of libXmu need for VSW5.  Use if implementation does not
*	support Athena.
*
* Modifications:
* $Log: CloseHook.c,v $
* Revision 1.3  2005-11-03 08:42:02  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.2  2005/04/15 14:32:12  anderson
* Merge basline changes
*
* Revision 1.1  2005/02/12 14:37:15  anderson
* Initial revision
*
* Revision 8.0  1998/12/23 23:25:59  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:44:13  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:18:17  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:14:48  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:46:19  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:44:26  andy
* Prepare for GA Release
*
*/
/*
 *
 * CloseDisplayHook package - provide callback on XCloseDisplay
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
 * 
 * 
 *			      Public Entry Points
 * 
 * CloseHook XmuAddCloseDisplayHook (dpy, func, arg)
 *     Display *dpy;
 *     XmuCloseHookProc func;
 *     caddr_t arg;
 * 
 * Bool XmuRemoveCloseDisplayHook (dpy, hook, func, arg)
 *     Display *dpy;
 *     CloseHook hook;
 *     XmuCloseHookProc func;
 *     caddr_t arg;
 * 
 * Bool XmuLookupCloseDisplayHook (dpy, hook, func, arg)
 *     Display *dpy;
 *     CloseHook hook;
 *     XmuCloseHookProc func;
 *     caddr_t arg;
 * 
 */

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <stdio.h>					/* for NULL */
#include <stdlib.h>
#include <X11/Xos.h>
#include <X11/Xlib.h>
#include <X11/Xmu/CloseHook.h>

/*
 *				 Private data
 *
 * This is a list of display entries, each of which contains a list of callback
 * records.
 */

typedef struct _CallbackRec {
    struct _CallbackRec *next;		/* next link in chain */
    XmuCloseHookProc func;		/* function to call */
    caddr_t arg;			/* argument to pass with function */
} CallbackRec;


typedef struct _DisplayEntry {
    struct _DisplayEntry *next;		/* next link in chain */
    Display *dpy;			/* the display this represents */
    int extension;			/* from XAddExtension */
    struct _CallbackRec *start, *end;	/* linked list of callbacks */
    struct _CallbackRec *calling;	/* currently being called back */
} DisplayEntry;


static DisplayEntry *elist = NULL;
static Bool _MakeExtension();
static DisplayEntry *_FindDisplayEntry();


/*
 *****************************************************************************
 *			      Public Entry Points                            *
 *****************************************************************************
 */

/*
 * Add - add a callback for the given display.  When the display is closed,
 * the given function will be called as:
 *
 *         (*func) (dpy, arg)
 *
 * This function is declared to return an int even though the value is ignored
 * because some compilers have problems with functions returning void.
 *
 * This routine returns NULL if it was unable to add the callback, otherwise
 * it returns an untyped pointer that can be used with Remove or Lookup, but
 * not dereferenced.
 */
CloseHook XmuAddCloseDisplayHook (dpy, func, arg)
    Display *dpy;
    XmuCloseHookProc func;		/* function to call on close display */
    caddr_t arg;			/* arg to pass */
{
    DisplayEntry *de;
    CallbackRec *cb;

    /* allocate ahead of time so that we can fail atomically */
    cb = (CallbackRec *) malloc (sizeof (CallbackRec));
    if (!cb) return ((caddr_t) NULL);

    de = _FindDisplayEntry (dpy, NULL);
    if (!de) {
	if ((de = (DisplayEntry *) malloc (sizeof (DisplayEntry))) == NULL ||
	    !_MakeExtension (dpy, &de->extension)) {
	    free ((char *) cb);
	    if (de) free ((char *) de);
	    return ((CloseHook) NULL);
	}
	de->dpy = dpy;
	de->start = de->end = NULL;
	de->calling = NULL;
	de->next = elist;
	elist = de;
    }

    /* add to end of list of callback recordss */
    cb->func = func;
    cb->arg = arg;
    cb->next = NULL;
    if (de->end) {
	de->end->next = cb;
    } else {
	de->start = cb;
    }
    de->end = cb;

    return ((CloseHook) cb);
}


/*
 * Remove - get rid of a callback.  If handle is non-null, use that to compare
 * entries.  Otherwise, remove first instance of the function/argument pair.
 */
Bool XmuRemoveCloseDisplayHook (dpy, handle, func, arg)
    Display *dpy;
    CloseHook handle;			/* value from XmuAddCloseDisplayHook */
    XmuCloseHookProc func;		/* function to call on close display */
    caddr_t arg;			/* arg to pass */
{
    DisplayEntry *de = _FindDisplayEntry (dpy, NULL);
    register CallbackRec *h, *prev;

    if (!de) return False;

    /* look for handle or function/argument pair */
    for (h = de->start, prev = NULL; h; h = h->next) {
	if (handle) {
	    if (h == (CallbackRec *) handle) break;
	} else {
	    if (h->func == func && h->arg == arg) break;
	}
	prev = h;
    }
    if (!h) return False;


    /* remove from list, watch head and tail */
    if (de->start == h) {
	de->start = h->next;
    } else {
	prev->next = h->next;
    }
    if (de->end == h) de->end = prev;
    if (de->calling != h) free ((char *) h);
    return True;
}


/*
 * Lookup - see whether or not a handle has been installed.  If handle is 
 * non-NULL, look for an entry that matches it; otherwise look for an entry 
 * with the same function/argument pair.
 */
Bool XmuLookupCloseDisplayHook (dpy, handle, func, arg)
    Display *dpy;
    CloseHook handle;			/* value from XmuAddCloseDisplayHook */
    XmuCloseHookProc func;		/* function to call on close display */
    caddr_t arg;			/* arg to pass */
{
    DisplayEntry *de = _FindDisplayEntry (dpy, NULL);
    register CallbackRec *h;

    if (!de) return False;

    for (h = de->start; h; h = h->next) {
	if (handle) {
	    if (h == (CallbackRec *) handle) break;
	} else {
	    if (h->func == func && h->arg == arg) break;
	}
    }
    return (h ? True : False);
}


/*
 *****************************************************************************
 *			       internal routines                             *
 *****************************************************************************
 */


/*
 * Find the specified display on the linked list of displays.  Also return
 * the preceeding link so that the display can be unlinked without having
 * back pointers.
 */
static DisplayEntry *_FindDisplayEntry (dpy, prevp)
    register Display *dpy;
    DisplayEntry **prevp;
{
    register DisplayEntry *d, *prev;

    for (d = elist, prev = NULL; d; d = d->next) {
	if (d->dpy == dpy) {
	    if (prevp) *prevp = prev;
	    return d;
	}
	prev = d;
    }
    return NULL;
}



/*
 * _DoCallbacks - process all of the callbacks for this display and free
 * the associated callback data (callback records and display entries).
 */
/* ARGSUSED */
static int _DoCallbacks (dpy, codes)
    Display *dpy;
    XExtCodes *codes;
{
    register CallbackRec *h;
    DisplayEntry *prev;
    DisplayEntry *de = _FindDisplayEntry (dpy, &prev);

    if (!de) return 0;

    /* walk the list doing the callbacks and freeing callback record */
    for (h = de->start; h;) {
	register CallbackRec *nexth = h->next;
	de->calling = h;		/* let remove know we'll free it */
	(*(h->func)) (dpy, h->arg);
	de->calling = NULL;
	free ((char *) h);
	h = nexth;
    }

    /* unlink this display from chain */
    if (elist == de) {
	elist = de->next;
    } else {
	prev->next = de->next;
    }
    free ((char *) de);
    return 1;
}


/*
 * _MakeExtension - create an extension for this display; done once per display
 */
static Bool _MakeExtension (dpy, extensionp)
    Display *dpy;
    int *extensionp;
{
    XExtCodes *codes;

    codes = XAddExtension (dpy);
    if (!codes) return False;

    (void) XESetCloseDisplay (dpy, codes->extension, _DoCallbacks);

    *extensionp = codes->extension;
    return True;
}
