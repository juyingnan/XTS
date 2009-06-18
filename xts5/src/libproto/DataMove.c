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
* $Header: /cvs/xtest/xtest/xts5/src/libproto/DataMove.c,v 1.2 2005-11-03 08:42:02 jmichael Exp $
*
* Copyright Applied Testing and Technology Inc. 1995
* All rights reserved
*
* Project: VSW5
*
* File:	xts5/src/libproto/DataMove.c
*
* Description:
*	Data movement support routines
*
* Modifications:
* $Log: DataMove.c,v $
* Revision 1.2  2005-11-03 08:42:02  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:11  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:24:56  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:43:08  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.1  1998/07/31 14:36:04  andy
* Changed unpack4 to manipulate an int rather than a long in order to
* accomodate 64-bit systems.
*
* Revision 6.0  1998/03/02 05:17:19  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:13:51  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:43:17  tbr
* Branch point for Release 5.0.0
*
* Revision 3.2  1995/12/15  00:40:49  andy
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

Copyright 1988 by Sequent Computer Systems, Inc., Portland, Oregon

                        All Rights Reserved

Permission to use, copy, modify, and distribute this software and its
documentation for any purpose and without fee is hereby granted,
provided that the above copyright notice appears in all copies and that
both that copyright notice and this permission notice appear in
supporting documentation, and that the name of Sequent not be used
in advertising or publicity pertaining to distribution or use of the
software without specific, written prior permission.

SEQUENT DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING
ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT SHALL
SEQUENT BE LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR
ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS,
WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION,
ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS
SOFTWARE.
*/


extern unsigned char native_byte_sex ();

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include "XstlibInt.h"
#include "DataMove.h"

/*ARGSUSED*/
void pack1(bufpp,val)
char **bufpp;
char val;
{

    *(*bufpp) = (char) val;
    *bufpp += 1;
}

void
pack2(bufpp,val,swap)
char **bufpp;
CARD16 val;
int swap;
{

    if (swap) {
	swapcpsp(((char *)&val),(*bufpp));
    }
    else {
	nonswapcpsp(((char *)&val),(*bufpp));
    }
    *bufpp += 2;
}

void
pack4(bufpp,val,swap)
char **bufpp;
CARD32 val;
int swap;
{

    if (swap) {
	swapcplp(((char *)&val),(*bufpp));
    }
    else {
	nonswapcplp(((char *)&val),(*bufpp));
    }
    *bufpp += 4;
}

/*
 *	Routine: pack2_lsb - stuffs short into output buffer in lsb order
 *
 *	Input: bufpp - pointer to output buffer
 *             val - value to stuff into output buffer
 *
 *	Output: **bufpp is replaced with val
 *
 *	Returns: nothing
 *
 *	Globals used:
 *
 *	Side Effects:
 *
 *	Methods:
 *
 */

void
pack2_lsb (bufpp,val)
    char **bufpp;
    CARD16 val;
{
    if (native_byte_sex () == 1) { 
	swapcpsp(((char *)&val),(*bufpp));     /* msb, so swap */
    }
    else {
	nonswapcpsp(((char *)&val),(*bufpp));  /* already lsb, so don't swap */
    }
    *bufpp += 2;
}

void
packpad(bufpp,cnt)
char **bufpp;
int cnt;
{

    wbzero(*bufpp,(unsigned)cnt);
    *bufpp += cnt;
}

/*ARGSUSED*/
unsigned char unpack1(bufpp)
unsigned char **bufpp;
{
    unsigned char ret;

    ret = **bufpp;
    *bufpp += 1;
    return(ret);
}

unsigned short
unpack2(bufpp,swap)
unsigned char **bufpp;
int swap;
{
    unsigned short ret;

    if (swap) {
	swapcpsp(*bufpp,(char *) &ret);
    }
    else {
	nonswapcpsp(*bufpp,(char *) &ret);
    }
    *bufpp += 2;
    return(ret);
}
unsigned long
unpack4(bufpp,swap)
unsigned char **bufpp;
int swap;
{
    unsigned int ret;

    if (swap) {
	swapcplp(*bufpp,(char *) &ret);
    }
    else {
	nonswapcplp(*bufpp,(char *) &ret);
    }
    *bufpp += 4;
    return((unsigned long)ret);
}

void
Copy_String8(to,from)
char **to;
char *from;
{
int len;

	len = strlen(from);
	wbcopy (from, *to, len);
	(*to) += len;
}


void
Copy_Padded_String8(to,from)
char **to;
char *from;
{
    int len;

    len = strlen(from);
    wbcopy (from, *to, len);
    (*to) += padup(len);
}

void
Copy_Padded_String16(to,from)
char **to;
char *from;
{
    int len;
    int i;
/*
 *	NOTE: this routine assumes that the tests will just be using
 *	"real" character strings (ie. STRING8) for convenience in
 *	specifying test strings, even though a test may call for
 *	STRING16 (CHAR2B).
 */

    len = strlen(from);
    for(i=0;i<len;i++) {
	**to = 0;
	(*to)++;
	**to = *from;
	(*to)++;
	from++;
    }
}

void
Set_Value1(to,val)
char **to;
char val;
{
    **to = val;
    (*to)++;
}

void
Set_Value2(to,val)
char **to;
CARD16 val;
{
    nonswapcpsp(((char *)&val),(*to));
    *to += 2;
}

void
Set_Value4(to,val)
char **to;
CARD32 val;
{
    nonswapcplp(((char *)&val),(*to));
    *to += 4;
}

void
Unpack_Shorts(to,from,count,swap)
CARD16 *to;
unsigned char **from;
int count;
int swap;
{
    int i;

    for(i=0;i<count;i++) {
	*to = unpack2(from,swap);
	to++;
    }
}

void
Unpack_Longs(to,from,count,swap)
CARD32 *to;
unsigned char **from;
int count;
int swap;
{
    int i;

    for(i=0;i<count;i++) {
	*to = unpack4(from,swap);
	to++;
    }
}
