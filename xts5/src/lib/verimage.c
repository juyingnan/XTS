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
* $Header: /cvs/xtest/xtest/xts5/src/lib/verimage.c,v 1.1 2005-02-12 14:37:15 anderson Exp $
*
* Copyright Applied Testing and Technology Inc. 1995
* All rights reserved
*
* Project: VSW5
*
* File:	vsw5/src/lib/verimage.c
*
* Description:
*	Image verification routines
*
* Modifications:
* $Log: verimage.c,v $
* Revision 1.1  2005-02-12 14:37:15  anderson
* Initial revision
*
* Revision 8.0  1998/12/23 23:24:54  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:43:06  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:17:16  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:13:49  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.2  1998/01/13 07:54:27  andy
* Use %l formats in scanf for long variables.
*
* Revision 4.1  1996/01/25 01:57:14  andy
* Portability improvements from DEPLOY tools
*
* Revision 4.0  1995/12/15  08:43:07  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:40:34  andy
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

#include	"stdio.h"
#include	"string.h"

#include	"xtest.h"
#include	"X11/Xlib.h"
#include	"X11/Xutil.h"
#include	"tet_api.h"
#include	"xtestlib.h"
#include	"pixval.h"

#define	BUF_LEN	512

extern	int 	tet_thistest;
extern	struct	tet_testlist tet_testlist[];


int 	Errnum;	/* Number of error record */

int verifyimage(disp, d, ap, vlite)
Display		*disp;
Drawable	d;
struct	area	*ap;
int		vlite;
{
static FILE	*fp;
long	initfpos;
XImage	*imp;
register int 	x, y;
register unsigned long	ipix;
unsigned long	pix;
unsigned long 	count;
int 	good, bad;
int 	ic;
unsigned int width, height;
long depth;
long	imdepth;
char	buf[BUF_LEN];
char	name[128];
static	int lasttest;
static	int lastvinf;
extern	int CurVinf;

	if(!config.save_server_image && config.debug_no_pixcheck) {
		trace("pixcheck code subverted");
		return(True);
	}

	if (ap == NULL) {
		getsize(disp, d, &width, &height);
		x = 0;
		y = 0;
	} else {
		x = ap->x;
		y = ap->y;
		width = ap->width;
		height = ap->height;
	}

	depth = getdepth(disp, d);
	imp = XGetImage(disp, d, x, y, width, height, AllPlanes, ZPixmap);
	if (imp == 0) {
		delete("get image failed");
		return(False);
	}

	ic = tet_testlist[tet_thistest-1].icref;
	(void) sprintf(name, "a%d.dat", ic);

#ifdef GENERATE_PIXMAPS
	if (tet_thistest != lasttest || CurVinf == lastvinf) {
		dumpimage(imp, name, ap);
		XDestroyImage(imp);
		lasttest = tet_thistest;
		lastvinf = CurVinf;
		report("Created reference image file");
		return(True);
	}
#endif

	if (tet_thistest != lasttest || CurVinf != lastvinf) {
		if (fp)
			fclose(fp);
		fp = fopen(name, "r");
		lasttest = tet_thistest;
		lastvinf = CurVinf;
	}

	/*
	 * If option to dump out server generated versions of files, do this
	 * here.
	 */
	if (config.save_server_image) {
		(void) sprintf(name, "a%d.sav", ic);
		dumpimage(imp, name, ap);
		trace("Created server image file %s", name);
	}

	if(config.debug_no_pixcheck) {
		XDestroyImage(imp);
		trace("pixcheck code subverted");
		return(True);
	}

	if (fp == NULL) {
		XDestroyImage(imp);
		delete("Could not open pixel validation data file %s", name);
		return(True);	/* We don't want to generate a FAIL */
	}

	initfpos = ftell(fp);

	do {
	    if (fgets(buf, BUF_LEN, fp) == NULL)
		goto badformat;
	} while (buf[0] == '!');
	if (sscanf(buf, "%d %d %ld", &width, &height, &imdepth) < 3) {
badformat:
	    delete("Bad format pixel validation data file %s", name);
	    XDestroyImage(imp);
	    return(False);
	}

	/*
	 * Choose the smaller of the depths in the image and in the drawable.
	 */
	if (imdepth < depth)
		depth = imdepth;

	if (width != imp->width) {
		delete("width mismatch");
		XDestroyImage(imp);
		return(False);
	}
	if (height != imp->height) {
		delete("height mismatch");
		XDestroyImage(imp);
		return(False);
	}

	count = 0;
	good  = 0;
	bad   = 0;

	x = y = 0;

	while (fgets(buf, BUF_LEN, fp) != NULL) {
		if (strchr(buf, ',') != NULL) {
			if (sscanf(buf, "%lx,%lx", &count, &pix) < 2)
			    goto badformat;
		} else {
			count = 1;
			if (sscanf(buf, "%lx", &pix) < 1)
			    goto badformat;
		}
		pix &= (1<<depth)-1;

		for (; count; count--) {
			ipix = XGetPixel(imp, x, y);
			ipix &= (1<<depth)-1;
			if (pix == ipix) {
				good++;
			} else {
				bad++;
			}
			if (++x >= width) {
				x = 0;
				y++;
			}
			if (y >= height)
				goto ok;
		}
	}

	fclose(fp);

ok:

	if (bad) {
	/*
	 * Make this separate routine XXX
	 */
	char	buf[BUF_LEN];
	char	errfile[64];
	long	newpos;
	int 	n;
	FILE	*errfp;

		report("A total of %d out of %d pixels were bad", bad, good+bad);
		(void) sprintf(errfile, "Err%04d.err", Errnum);
		(void) unlink(errfile);
		dumpimage(imp, errfile, ap);
	
		newpos = ftell(fp);
		errfp = fopen(errfile, "a");
		if (errfp == NULL) {
				report("Could not open pixel error file %s", errfile);
		} else {
			fseek(fp, initfpos, 0);
			for (n = newpos-initfpos; n > 0; ) {
				fread(buf, 1, (n>BUF_LEN)? BUF_LEN: n, fp);
				fwrite(buf, 1, (n>BUF_LEN)? BUF_LEN: n, errfp);
				n -= BUF_LEN;
			}
			report("Pixel check failed. See file %s for results", errfile);
			Errnum++;
			fclose(errfp);
		}
		if (good + bad < width*height) {
			delete("Early end of file in pixmap checking");
			/*
	 		* Return is true so that the test does not give a failure;
	 		* it is the data file that needs attention.
	 		*/
			XDestroyImage(imp);
			return(True);
		}
	
		XDestroyImage(imp);
	}
	if (good == width*height && bad == 0)
		return(True);
	else {
		if (bad < vlite)
			/*arbitrary - not T or F so generates a warning*/
			return(193);
		return(False);
	}
}
