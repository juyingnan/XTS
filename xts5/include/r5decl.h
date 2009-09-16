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
* Copyright Applied Testing and Technology Inc. 1995
* All rights reserved
*
* Project: VSW5
*
* File:	xts5/src/libXR5/r5decl.h
*
* Description:
*	r5 xlib tests definitions
*
* Modifications:
* $Log: r5decl.h,v $
* Revision 1.2  2005-11-03 08:42:00  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:07  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:23:33  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:41:38  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:16:03  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:12:34  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.1  1996/02/13 23:41:21  andy
* Editorial
*
* Revision 4.0  1995/12/15  08:38:44  tbr
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

#ifndef _R5DECL
#define _R5DECL

#include <stdio.h>
#include <X11/Xlib.h>

extern Display *display_arg;        /* default display structure */
extern int estatus[];               /* expected status returns */
extern int time_delay;              /* Default time delay*/
extern Display    *dpy_save;            /* display struct for save stat */
extern Window     wid_save;             /* window id for save stat */
extern Pixmap     pid_save;             /* pixmap id for save stat */
extern XWindowAttributes wat_save;      /* window attribute status for save stat */
extern char *buf_next;
extern int  buf_size, buf_left;
extern char *regr_buf;
extern int  errlmt;
extern int  errcnt;
extern int  errflg;
/* Indicates the first error from the service under test was encountered */
extern int first_error;             
extern int  chkflg;                 /* Indicates status return [not] checked */
extern int over_flow_flg;
extern char ebuf[];
extern struct args regr_args;
extern Window 	window_arg;             /* default window identifier */
extern Drawable drawable_id; 		/* problems in save_stat */
extern Display  *display_struc;
extern GC      gc_save;                 /* GC for save stat */
extern GC 	gc_id;                  /* Global decls to cover */
extern unsigned long BackgroundPixel;	/* Pixel to use for window background */
extern int blowup_size;		/* Default blowup window size */
extern int PixPerCM;			/* Number of pixels per CM */
extern int region_mode;		/* default region_mode */

extern int MaxDisplayWidth;              /* Number of display width pixels */
extern int MaxDisplayHeight;             /* Number of display height pixels */
extern int DisplayCenterX;               /* Center of the screen in pixels */
extern int DisplayCenterY;

extern unsigned int BorderWidth;    /* Border width to use for default window */
extern unsigned long BorderPixel;       /* Pixel to use for window border */
extern unsigned long BackgroundPixel;   /* Pixel to use for window background */
extern Colormap colormap_arg;           /* default colormap */

#ifdef LATER
extern long 		good_pixmaps_written;
extern FILE 		*OldImageFile;
extern unsigned long 	image_record_id;
extern char 		image_record_description[255];
extern extent_record 	rel_extents;
extern extent_record	abs_extents;
extern int 		note_warnings;
extern int 		skip_image_record_copy;
extern short 		validate_color;
#endif

extern Display *Dsp;

/* function prototypes */
#include "avsr5_proto.h"
#endif
