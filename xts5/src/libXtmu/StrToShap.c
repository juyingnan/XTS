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
* File: xts5/src/lib/libXtaw/StrToShap.c
*
* Description:
*	Subset of libXmu need for VSW5.  Use if implementation does not
*	support Athena.
*
* Modifications:
* $Log: StrToShap.c,v $
* Revision 1.2  2005-11-03 08:42:02  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:11  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:26:06  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:44:22  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:18:23  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:14:55  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:46:38  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:45:02  andy
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

/* ARGSUSED */
#define	done(type, value) \
	{							\
	    if (toVal->addr != NULL) {				\
		if (toVal->size < sizeof(type)) {		\
		    toVal->size = sizeof(type);			\
		    return False;				\
		}						\
		*(type*)(toVal->addr) = (value);		\
	    }							\
	    else {						\
		static type static_val;				\
		static_val = (value);				\
		toVal->addr = (XtPointer)&static_val;		\
	    }							\
	    toVal->size = sizeof(type);				\
	    return True;					\
	}


Boolean XmuCvtStringToShapeStyle(dpy, args, num_args, from, toVal, data)
    Display *dpy;
    XrmValue *args;		/* unused */
    Cardinal *num_args;		/* unused */
    XrmValue *from;
    XrmValue *toVal;
    XtPointer *data;		/* unused */
{
    if (   XmuCompareISOLatin1((char*)from->addr, XtERectangle) == 0
	|| XmuCompareISOLatin1((char*)from->addr, "ShapeRectangle") == 0)
	done( int, XmuShapeRectangle );
    if (   XmuCompareISOLatin1((char*)from->addr, XtEOval) == 0
	|| XmuCompareISOLatin1((char*)from->addr, "ShapeOval") == 0)
	done( int, XmuShapeOval );
    if (   XmuCompareISOLatin1((char*)from->addr, XtEEllipse) == 0
	|| XmuCompareISOLatin1((char*)from->addr, "ShapeEllipse") == 0)
	done( int, XmuShapeEllipse );
    if (   XmuCompareISOLatin1((char*)from->addr, XtERoundedRectangle) == 0
	|| XmuCompareISOLatin1((char*)from->addr, "ShapeRoundedRectangle") == 0)
	done( int, XmuShapeRoundedRectangle );
    {
	int style = 0;
	char ch, *p = (char*)from->addr;
	while (ch = *p++) {
	    if (ch >= '0' && ch <= '9') {
		style *= 10;
		style += ch - '0';
	    }
	    else break;
	}
	if (ch == '\0' && style <= XmuShapeRoundedRectangle)
	    done( int, style );
    }
    XtDisplayStringConversionWarning( dpy, (char*)from->addr, XtRShapeStyle );
    return False;
}
