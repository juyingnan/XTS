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
* $Header: /cvs/xtest/xtest/xts5/include/r5.h,v 1.1 2005-02-12 14:37:13 anderson Exp $
*
* Copyright Applied Testing and Technology Inc. 1995
* All rights reserved
*
* Project: VSW5
*
* File:	vsw5/src/libXR5/r5.h
*
* Description:
*	Definitions for xlib r5 tests
*
* Modifications:
* $Log: r5.h,v $
* Revision 1.1  2005-02-12 14:37:13  anderson
* Initial revision
*
* Revision 8.0  1998/12/23 23:23:32  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:41:37  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:16:03  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:12:34  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.2  1996/02/13 23:41:21  andy
* Editorial
*
* Revision 4.1  1996/01/25  01:19:52  andy
* Portability improvements from DEPLOY tools
*
* Revision 4.0  1995/12/15  08:38:43  tbr
* Branch point for Release 5.0.0
*
* Revision 3.2  1995/12/15  02:07:13  andy
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

#ifndef _R5H_
#define _R5H_

#include	<X11/Xlib.h>

Display *display_arg;                           /* default display structure */
int estatus[10];                                /* expected status returns */
int time_delay = 0;                             /* Default time delay*/
Display    *dpy_save;                           /* display struct for save stat */
Window     wid_save;                            /* window id for save stat */
Pixmap     pid_save;                            /* pixmap id for save stat */
XWindowAttributes wat_save;                     /* window attribute status for save stat */
char *buf_next;
int  buf_size, buf_left;
char *regr_buf;
int  errlmt = 10;
int  errcnt;
int  errflg;
int first_error = 0;                            /* Indicates the first error from the service under test was encountered */
int  chkflg = 0;                                /* Indicates status return [not] checked */
int over_flow_flg;

struct args regr_args;

char    *svc_user_arg;         /* user param to pass info...*/

Window 	window_arg;                     /* default window identifier */
Drawable drawable_id; 			/* problems in save_stat */
Display  *display_struc;
GC      gc_save;                        /* GC for save stat */
GC 	gc_id;                          /* Global decls to cover */

unsigned long BackgroundPixel;	/* Pixel to use for window background */
int blowup_size = 200;		/* Default blowup window size */
int PixPerCM;			/* Number of pixels per CM */
int region_mode = 0;		/* default region_mode */
int max_width = 400;       /* size of max pixel validation region     */
int max_height = 400;

int MaxDisplayWidth;              /* Number of display width pixels */
int MaxDisplayHeight;             /* Number of display height pixels */
int DisplayCenterX;               /* Center of the screen in pixels */
int DisplayCenterY;

unsigned int BorderWidth = 5;    /* Border width to use for default window */
unsigned long BorderPixel;       /* Pixel to use for window border */
unsigned long BackgroundPixel;   /* Pixel to use for window background */
Colormap colormap_arg;           /* default colormap */


/* Extern declarations */
extern      Display *Dsp;
extern 	char ebuf[];

#endif
