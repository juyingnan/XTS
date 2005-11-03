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
* $Header: /cvs/xtest/xtest/xts5/src/libproto/DfltVals.c,v 1.2 2005-11-03 08:42:02 jmichael Exp $
*
* Copyright Applied Testing and Technology Inc. 1995
* All rights reserved
*
* Project: VSW5
*
* File:	xts5/src/libproto/DfltVals.c
*
* Description:
*	Default values support routines
*
* Modifications:
* $Log: DfltVals.c,v $
* Revision 1.2  2005-11-03 08:42:02  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:11  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:24:57  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:43:09  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:17:20  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:13:52  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:43:20  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:40:52  andy
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

#include "XstlibInt.h"

/*ARGSUSED*/
Gen_Good_accelDenum (client) {
    return (0);
}
/*ARGSUSED*/
Gen_Good_accelNum (client) {
    return (0);
}
/*ARGSUSED*/
Gen_Good_backBlue (client) {
    return (0);
}
/*ARGSUSED*/
Gen_Good_backGreen (client) {
    return (0);
}
/*ARGSUSED*/
Gen_Good_backRed (client) {
    return (0);
}
/*ARGSUSED*/
Gen_Good_bitPlane (client) {
    return (0);
}
/*ARGSUSED*/
Gen_Good_blue (client) {
    return (0);
}
/*ARGSUSED*/
Gen_Good_colors (client) {
    return (0);
}
/*ARGSUSED*/
Gen_Good_contiguous (client) {
    return (0);
}
/*ARGSUSED*/
Gen_Good_count (client) {
    return (0);
}
Gen_Good_depth (client) {
XstDisplay	*dpy = Get_Display(client);
    return (XstDefaultDepth(dpy, XstDefaultScreen(dpy)));
}
/*ARGSUSED*/
Gen_Good_doAccel (client) {
    return (0);
}
/*ARGSUSED*/
Gen_Good_doThresh (client) {
    return (0);
}
/*ARGSUSED*/
Gen_Good_dstDrawable (client) {
    return (0);
}
/*ARGSUSED*/
Gen_Good_dstX (client) {
    return (0);
}
/*ARGSUSED*/
Gen_Good_dstY (client) {
    return (0);
}
/*ARGSUSED*/
Gen_Good_firstKeyCode (client) {
    return (0);
}
/*ARGSUSED*/
Gen_Good_foreBlue (client) {
    return (0);
}
/*ARGSUSED*/
Gen_Good_foreGreen (client) {
    return (0);
}
/*ARGSUSED*/
Gen_Good_foreRed (client) {
    return (0);
}
/*ARGSUSED*/
Gen_Good_green (client) {
    return (0);
}
/*ARGSUSED*/
Gen_Good_hostLength (client) {
    return (0);
}
/*ARGSUSED*/
Gen_Good_id (client) {
    return (0);
}
/*ARGSUSED*/
Gen_Good_interval (client) {
    return (0);
}
/*ARGSUSED*/
Gen_Good_leftPad (client) {
    return (0);
}
/*ARGSUSED*/
Gen_Good_mask (client) {
    return (0);
}
/*ARGSUSED*/
Gen_Good_maskChar (client) {
    return (0);
}
/*ARGSUSED*/
Gen_Good_mid (client) {
    return (0);
}
/*ARGSUSED*/
Gen_Good_pixel (client) {
    return (0);
}
/*ARGSUSED*/
Gen_Good_planeMask (client) {
    return (0);
}
/*ARGSUSED*/
Gen_Good_planes (client) {
    return (0);
}
/*ARGSUSED*/
Gen_Good_red (client) {
    return(0);
}
/*ARGSUSED*/
Gen_Good_source (client) {
    return (0);
}
/*ARGSUSED*/
Gen_Good_sourceChar (client) {
    return (0);
}
/*ARGSUSED*/
Gen_Good_srcCmap (client) {
    return (0);
}
/*ARGSUSED*/
Gen_Good_srcDrawable (client) {
    return (0);
}
/*ARGSUSED*/
Gen_Good_srcX (client) {
    return (0);
}
/*ARGSUSED*/
Gen_Good_srcY (client) {
    return (0);
}
/*ARGSUSED*/
Gen_Good_threshold (client) {
    return (0);
}
/*ARGSUSED*/
Gen_Good_time (client) {
    return (0);
}
/*ARGSUSED*/
Gen_Good_timeout (client) {
    return (0);
}

/*
 *	Routine: Gen_Good_Visual - return the resource ID for the client's 
 *      visual
 *
 *	Input:  client - integer from 0 to MAX_CLIENTS
 *              scr - integer from 0 to ?
 *
 *	Output: Visual ID - CARD32 from ? to ?
 *
 *	Returns:
 *
 *	Globals used: Xst_clients, SCREEN
 *
 *	Side Effects:
 *
 *	Methods: see X11/.../xdpyinfo.c, print_screen_info()
 *
 */

VisualID
Gen_Good_Visual (client,scr)
    int client;         /* client number */
    int scr;            /* screen number */
{
    XstVisual *vp;         /* pointer to visual structure */

    vp = Get_Visual (client,scr);
    return (Get_Visual_ID (vp));
}

/*ARGSUSED*/
Gen_Good_x (client) {
    return (0);
}
/*ARGSUSED*/
Gen_Good_y (client) {
    return (0);
}

XID
Get_Resource_Id(client)
int client;
{
    XstDisplay *dpy = Get_Display(client);
    return(dpy->resource_base + (dpy->resource_id++ << dpy->resource_shift));
}

/*ARGSUSED*/
Gen_Good_Event(client,rp)
int client;
xReq *rp;
{
}

/* func. to give min of 3 vars */
static
int min3(a, b, c)
	int a,b,c;
{
	if (a < b)
		b = a;
	if (b < c)
		c = b;
	return c;
}

/*
 * Get a suitable number of colormap entries to allocate.
 */
Get_Maxsize(client)
	int 	client;
{
	XstVisual	*vp;
	int	 	r,g,b;
	unsigned long 	mask;

	vp = Get_Visual(client, XstDefaultScreen(Get_Display(client)));

	if (vp->class != DirectColor && vp->class != TrueColor)
		return vp->map_entries;

	for(r=0, mask=vp->red_mask; mask; mask >>= 1) {
		if (mask & 0x1)
			r++;
	}
	for(g=0, mask=vp->green_mask; mask; mask >>= 1) {
		if (mask & 0x1)
			g++;
	}
	for(b=0, mask=vp->blue_mask; mask; mask >>= 1) {
		if (mask & 0x1)
			b++;
	}
	return (1 << min3(r,g,b));
}
