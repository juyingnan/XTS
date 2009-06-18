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
* $Header: /cvs/xtest/xtest/xts5/src/libXtmu/Lower.c,v 1.2 2005-11-03 08:42:02 jmichael Exp $
*
* Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
* All Rights Reserved.
*
* Project: VSW5
*
* File: xts5/src/lib/libXtaw/Lower.c
*
* Description:
*	Subset of libXmu need for VSW5.  Use if implementation does not
*	support Athena.
*
* Modifications:
* $Log: Lower.c,v $
* Revision 1.2  2005-11-03 08:42:02  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:11  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:26:02  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:44:18  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:18:20  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:14:52  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:46:29  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:44:38  andy
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

#define  XK_LATIN1
#include <X11/keysymdef.h>
#include <X11/Xmu/CharSet.h>

/*
 * ISO Latin-1 case conversion routine
 */

#if NeedFunctionPrototypes
void XmuCopyISOLatin1Lowered(char *dst, _Xconst char *src)
#else
void XmuCopyISOLatin1Lowered(dst, src)
    char *dst, *src;
#endif
{
    register unsigned char *dest, *source;

    for (dest = (unsigned char *)dst, source = (unsigned char *)src;
	 *source;
	 source++, dest++)
    {
	if ((*source >= XK_A) && (*source <= XK_Z))
	    *dest = *source + (XK_a - XK_A);
	else if ((*source >= XK_Agrave) && (*source <= XK_Odiaeresis))
	    *dest = *source + (XK_agrave - XK_Agrave);
	else if ((*source >= XK_Ooblique) && (*source <= XK_Thorn))
	    *dest = *source + (XK_oslash - XK_Ooblique);
	else
	    *dest = *source;
    }
    *dest = '\0';
}

#if NeedFunctionPrototypes
void XmuCopyISOLatin1Uppered(char *dst, _Xconst char *src)
#else
void XmuCopyISOLatin1Uppered(dst, src)
    char *dst, *src;
#endif
{
    register unsigned char *dest, *source;

    for (dest = (unsigned char *)dst, source = (unsigned char *)src;
	 *source;
	 source++, dest++)
    {
	if ((*source >= XK_a) && (*source <= XK_z))
	    *dest = *source - (XK_a - XK_A);
	else if ((*source >= XK_agrave) && (*source <= XK_odiaeresis))
	    *dest = *source - (XK_agrave - XK_Agrave);
	else if ((*source >= XK_slash) && (*source <= XK_thorn))
	    *dest = *source - (XK_oslash - XK_Ooblique);
	else
	    *dest = *source;
    }
    *dest = '\0';
}

#if NeedFunctionPrototypes
int XmuCompareISOLatin1 (_Xconst char *first, _Xconst char *second)
#else
int XmuCompareISOLatin1 (first, second)
    char *first, *second;
#endif
{
    register unsigned char *ap, *bp;

    for (ap = (unsigned char *) first, bp = (unsigned char *) second;
	 *ap && *bp; ap++, bp++) {
	register unsigned char a, b;

	if ((a = *ap) != (b = *bp)) {
	    /* try lowercasing and try again */

	    if ((a >= XK_A) && (a <= XK_Z))
	      a += (XK_a - XK_A);
	    else if ((a >= XK_Agrave) && (a <= XK_Odiaeresis))
	      a += (XK_agrave - XK_Agrave);
	    else if ((a >= XK_Ooblique) && (a <= XK_Thorn))
	      a += (XK_oslash - XK_Ooblique);

	    if ((b >= XK_A) && (b <= XK_Z))
	      b += (XK_a - XK_A);
	    else if ((b >= XK_Agrave) && (b <= XK_Odiaeresis))
	      b += (XK_agrave - XK_Agrave);
	    else if ((b >= XK_Ooblique) && (b <= XK_Thorn))
	      b += (XK_oslash - XK_Ooblique);

	    if (a != b) return (((int) a) - ((int) b));
	}
    }
    return (((int) *ap) - ((int) *bp));
}
