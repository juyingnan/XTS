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
* $Header: /cvs/xtest/xtest/xts5/src/libXtmu/StrToOrnt.c,v 1.2 2005-04-15 14:32:12 anderson Exp $
*
* Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
* All Rights Reserved.
*
* Project: VSW5
*
* File: vsw5/src/lib/libXtaw/StrToOrnt.c
*
* Description:
*	Subset of libXmu need for VSW5.  Use if implementation does not
*	support Athena.
*
* Modifications:
* $Log: StrToOrnt.c,v $
* Revision 1.2  2005-04-15 14:32:12  anderson
* Merge basline changes
*
* Revision 1.1  2005/02/12 14:37:15  anderson
* Initial revision
*
* Revision 8.0  1998/12/23 23:26:06  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:44:21  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:18:23  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:14:55  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:46:37  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:44:57  andy
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

#include <X11/Intrinsic.h>
#include <X11/StringDefs.h>
#include <X11/Xmu/Converters.h>
#include <X11/Xmu/CharSet.h>


#define	done(address, type) \
	{ (*toVal).size = sizeof(type); (*toVal).addr = (caddr_t) address; }

/* ARGSUSED */
void
XmuCvtStringToOrientation(args, num_args, fromVal, toVal)
    XrmValuePtr args;		/* unused */
    Cardinal	*num_args;	/* unused */
    XrmValuePtr	fromVal;
    XrmValuePtr	toVal;
{
    static XtOrientation orient;
    static	XrmQuark  XtQEhorizontal;
    static	XrmQuark  XtQEvertical;
    static	int	  haveQuarks = 0;
    XrmQuark	q;
    char	lowerName[1000];

    if (!haveQuarks) {
	XtQEhorizontal = XrmPermStringToQuark(XtEhorizontal);
	XtQEvertical   = XrmPermStringToQuark(XtEvertical);
	haveQuarks = 1;
    }
    XmuCopyISOLatin1Lowered(lowerName, (char *) fromVal->addr);
    q = XrmStringToQuark(lowerName);
    if (q == XtQEhorizontal) {
    	orient = XtorientHorizontal;
	done(&orient, XtOrientation);
	return;
    }
    if (q == XtQEvertical) {
    	orient = XtorientVertical;
	done(&orient, XtOrientation);
	return;
    }
}
