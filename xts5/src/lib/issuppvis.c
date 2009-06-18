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
* $Header: /cvs/xtest/xtest/xts5/src/lib/issuppvis.c,v 1.2 2005-11-03 08:42:01 jmichael Exp $
*
* Copyright Applied Testing and Technology Inc. 1995
* All rights reserved
*
* Project: VSW5
*
* File:	xts5/src/lib/issuppvis.c
*
* Description:
*	Visual Class support routines
*
* Modifications:
* $Log: issuppvis.c,v $
* Revision 1.2  2005-11-03 08:42:01  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:10  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:24:38  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:42:50  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:17:03  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:13:36  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.1  1996/01/25 01:57:14  andy
* Portability improvements from DEPLOY tools
*
* Revision 4.0  1995/12/15  08:42:27  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:39:42  andy
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
*/

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include	"X11/Xlib.h"
#include	"X11/Xutil.h"
#include	"xtest.h"
#include	"xtestlib.h"
#include	"pixval.h"
#include	"string.h"

static int Nsupvis;
static unsigned long Supvismsk;

static int
issupid(n, vip)
int		n;
XVisualInfo	*vip;
{
XVisualInfo	*vp;
char	*idlist;
int 	id;
int 	i;

	idlist = config.debug_visual_ids;
	while (idlist) {
		id = atov(idlist); /* Allow hex/octal/decimal values */
		for (vp = vip,i = 0; i < n; vp++,i++) {

			if (vp->visualid == id)
				return True;
		}

		idlist = strchr(idlist, ',');
		if (idlist)
			idlist++;
	}
	return False;
}
/*
 * issuppvis() takes a visual class as argument and returns true
 * if such a class is supported.
 * This function uses the XGetVisualInfo() function rather than
 * use the XT_VISUAL_CLASSES parameter.
 */
int
issuppvis(disp, vis)
Display	*disp;
int 	vis;
{
XVisualInfo	templ;
XVisualInfo	*vip;
int 	n;
int	result;

	templ.class = vis;
	templ.screen = DefaultScreen(disp);
	vip = XGetVisualInfo(disp, VisualClassMask|VisualScreenMask, &templ, &n);

	/*
	 * The visual may be supported by the server, but the user may
	 * wish to avoid testing against it so check XT_DEBUG_VISUAL_IDS.
	 * - Cal, UniSoft.  Thu Aug 26 14:30:21 1993
	 */
	if(config.debug_visual_ids)
		result = issupid(n, vip);
	else
		result = (n>0)? True: False;

	if(vip != (XVisualInfo *) 0)
		XFree((char*)vip);

	return result;
}

/*
 * Takes a mask indicating a set of visuals, and returns
 * a mask indicating the subset that is supported.
 * If the mask is 0L then the mask shows all supported 
 * visuals.
 */
unsigned long
visualsupported(disp, mask)      
Display *disp;
unsigned long mask;
{
	unsigned long resultmask = 0;

	if(mask == 0L)
		mask =  ((1L<<DirectColor) | (1L<<PseudoColor) | (1L<<GrayScale)|
			 (1L<<TrueColor) | (1L<<StaticColor) | (1L<<StaticGray));

	if(mask & (1L<<PseudoColor))
		if(issuppvis(disp, PseudoColor))
			resultmask |= (1L<<PseudoColor);

	if(mask & (1L<<DirectColor))
		if(issuppvis(disp, DirectColor))
			resultmask |= (1L<<DirectColor);

	if(mask & (1L<<GrayScale))
		if(issuppvis(disp, GrayScale))
			resultmask |= (1L<<GrayScale);

	if(mask & (1L<<StaticGray))
		if(issuppvis(disp, StaticGray))
			resultmask |= (1L<<StaticGray);

	if(mask & (1L<<StaticColor))
		if(issuppvis(disp, StaticColor))
			resultmask |= (1L<<StaticColor);

	if(mask & (1L<<TrueColor))
		if(issuppvis(disp, TrueColor))
			resultmask |= (1L<<TrueColor);

	return resultmask;
}

void
resetsupvis(vismask)
unsigned long vismask;
{
	resetvinf(VI_WIN);
	Nsupvis = 0;
	Supvismsk = vismask;
}


int
nextsupvis(vi)
XVisualInfo **vi;
{
	while(nextvinf(vi))
		if(Supvismsk & (1L<<(*vi)->class)) {
			Nsupvis++;
			trace("--- Testing with supported visual class %s", displayclassname((*vi)->class));
			return True;
		}

	return False;
}

int
nsupvis()
{
	return Nsupvis;
}
