/*
Copyright (c) 2005 X.Org Foundation LLC

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
* $Header: /cvs/xtest/xtest/xts5/src/libproto/DataMove.h,v 1.1 2005-02-12 14:37:15 anderson Exp $
*
* Copyright Applied Testing and Technology Inc. 1995
* All rights reserved
*
* Project: VSW5
*
* File:	vsw5/src/libproto/DataMove.h
*
* Description:
*	X test suite protocol test library include file
*
* Modifications:
* $Log: DataMove.h,v $
* Revision 1.1  2005-02-12 14:37:15  anderson
* Initial revision
*
* Revision 8.0  1998/12/23 23:24:56  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:43:09  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:17:19  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:13:52  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:43:19  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:40:51  andy
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

/*
 *	Macros for byte swapping
 *
 *	Derived from X.V11R1 server code.
 *
 */

/*	swap, copy long to long	*/
#define swapcpl(src, dst) \
                 ((char *) &(dst))[0] = ((char *) &(src))[3];\
                 ((char *) &(dst))[1] = ((char *) &(src))[2];\
                 ((char *) &(dst))[2] = ((char *) &(src))[1];\
                 ((char *) &(dst))[3] = ((char *) &(src))[0]

/*	swap, copy short to short	*/
#define swapcps(src, dst)\
		 ((char *) &(dst))[0] = ((char *) &(src))[1];\
		 ((char *) &(dst))[1] = ((char *) &(src))[0]

/*	swap, copy longptr to longptr	*/
#define swapcplp(srcp, dstp) \
                 ((dstp))[0] = ((srcp))[3];\
                 ((dstp))[1] = ((srcp))[2];\
                 ((dstp))[2] = ((srcp))[1];\
                 ((dstp))[3] = ((srcp))[0]

/*	swap, copy shortptr to shortptr	*/
#define swapcpsp(srcp, dstp)\
		 ((dstp))[0] = ((srcp))[1];\
		 ((dstp))[1] = ((srcp))[0]

/*	swap, inplace long (using char temp)	*/
#define swapinl(x, n) n = ((char *) &(x))[0];\
		 ((char *) &(x))[0] = ((char *) &(x))[3];\
		 ((char *) &(x))[3] = n;\
		 n = ((char *) &(x))[1];\
		 ((char *) &(x))[1] = ((char *) &(x))[2];\
		 ((char *) &(x))[2] = n

/*	swap, inplace short (using char temp)	*/
#define swapins(x, n) n = ((char *) &(x))[0];\
		 ((char *) &(x))[0] = ((char *) &(x))[1];\
		 ((char *) &(x))[1] = n

/*	swap, inplace longptr (using char temp)	*/
#define swapinlp(x, n) n = ((x))[0];\
		 ((x))[0] = ((x))[3];\
		 ((x))[3] = n;\
		 n = ((x))[1];\
		 ((x))[1] = ((x))[2];\
		 ((x))[2] = n

/*	swap, inplace shortptr (using char temp)	*/
#define swapinsp(x, n) n = ((x))[0];\
		 ((x))[0] = ((x))[1];\
		 ((x))[1] = n

/*
 *	macros for packing/unpacking shorts/longs 
 *	these are here to centralize any issues with word alignment,
 *	byte addressing, etc.
 */

/*	nonswap, copy shortptr to shortptr	*/
#define nonswapcpsp(srcp, dstp)\
		 ((dstp))[1] = ((srcp))[1];\
		 ((dstp))[0] = ((srcp))[0]


/*	nonswap, copy longptr to longptr	*/
#define nonswapcplp(srcp, dstp) \
                 ((dstp))[3] = ((srcp))[3];\
                 ((dstp))[2] = ((srcp))[2];\
                 ((dstp))[1] = ((srcp))[1];\
                 ((dstp))[0] = ((srcp))[0]

/*
 *	pads a number of bytes up to next multiple of 4
 */
#define padup(n)	((((n)+3)>>2)<<2)
