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
* $Header: /cvs/xtest/xtest/xts5/src/libXtmu/StrToBS.c,v 1.3 2005-11-03 08:42:02 jmichael Exp $
*
* Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
* All Rights Reserved.
*
* Project: VSW5
*
* File: xts5/src/lib/libXtaw/StrToBS.c
*
* Description:
*	Subset of libXmu need for VSW5.  Use if implementation does not
*	support Athena.
*
* Modifications:
* $Log: StrToBS.c,v $
* Revision 1.3  2005-11-03 08:42:02  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.2  2005/04/15 14:32:12  anderson
* Merge basline changes
*
* Revision 1.1  2005/02/12 14:37:15  anderson
* Initial revision
*
* Revision 8.0  1998/12/23 23:26:04  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:44:20  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:18:22  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:14:54  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:46:33  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:44:45  andy
* Prepare for GA Release
*
*/
/* 
 * Copyright 1988 by the Massachusetts Institute of Technology
 *
 * Permission to use, copy, modify, and distribute this software and its
 * documentation for any purpose and without fee is hereby granted, provided 
 * that the above copyright notice appear in all copies and that both that 
 * copyright notice and this permission notice appear in supporting 
 * documentation, and that the name of M.I.T. not be used in advertising
 * or publicity pertaining to distribution of the software without specific, 
 * written prior permission. M.I.T. makes no representations about the 
 * suitability of this software for any purpose.  It is provided "as is"
 * without express or implied warranty.
 *
 */

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <X11/Intrinsic.h>
#include <X11/Xmu/Converters.h>
#include <X11/Xmu/CharSet.h>

#define	done(address, type) \
	{ (*toVal).size = sizeof(type); (*toVal).addr = (caddr_t) address; }

/* ARGSUSED */
void
XmuCvtStringToBackingStore (args, num_args, fromVal, toVal)
    XrmValue	*args;		/* unused */
    Cardinal	*num_args;	/* unused */
    XrmValuePtr fromVal;
    XrmValuePtr toVal;
{
    char	lowerString[1024];
    XrmQuark	q;
    static int	backingStoreType;
    static XrmQuark XtQEnotUseful, XtQEwhenMapped, XtQEalways, XtQEdefault;
    static int haveQuarks = 0;

    if (*num_args != 0)
        XtWarning("String to BackingStore conversion needs no extra arguments");
    if (!haveQuarks) {
	XmuCopyISOLatin1Lowered (lowerString, XtEnotUseful);
	XtQEnotUseful = XrmStringToQuark(lowerString);
	XmuCopyISOLatin1Lowered (lowerString, XtEwhenMapped);
	XtQEwhenMapped = XrmStringToQuark(lowerString);
	XmuCopyISOLatin1Lowered (lowerString, XtEalways);
	XtQEalways = XrmStringToQuark(lowerString);
	XmuCopyISOLatin1Lowered (lowerString, XtEdefault);
	XtQEdefault = XrmStringToQuark(lowerString);
	haveQuarks = 1;
    }
    XmuCopyISOLatin1Lowered (lowerString, (char *) fromVal->addr);
    q = XrmStringToQuark (lowerString);
    if (q == XtQEnotUseful) {
	backingStoreType = NotUseful;
	done (&backingStoreType, int);
    } else if (q == XtQEwhenMapped) {
    	backingStoreType = WhenMapped;
	done (&backingStoreType, int);
    } else if (q == XtQEalways) {
	backingStoreType = Always;
	done (&backingStoreType, int);
    } else if (q == XtQEdefault) {
    	backingStoreType = Always + WhenMapped + NotUseful;
	done (&backingStoreType, int);
    } else {
        XtStringConversionWarning((char *) fromVal->addr, "BackingStore");
    }
}
