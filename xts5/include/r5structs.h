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
* $Header: /cvs/xtest/xtest/xts5/include/r5structs.h,v 1.1 2005-02-12 14:37:13 anderson Exp $
*
* Copyright Applied Testing and Technology Inc. 1995
* All rights reserved
*
* Project: VSW5
*
* File:	vsw5/src/libXR5/r5structs.h
*
* Description:
*	Definitions for r5 xlib tests
*
* Modifications:
* $Log: r5structs.h,v $
* Revision 1.1  2005-02-12 14:37:13  anderson
* Initial revision
*
* Revision 8.0  1998/12/23 23:23:34  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:41:39  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:16:04  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:12:36  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.2  1996/02/13 23:41:21  andy
* Editorial
*
* Revision 4.1  1996/01/25  01:19:52  andy
* Portability improvements from DEPLOY tools
*
* Revision 4.0  1995/12/15  08:38:48  tbr
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

#ifndef _R5STRUCTS_
#define _R5STRUCTS_

#include	<X11/Xlib.h>
/* X memory allocation procedure */

#define	TEST_MODULE

typedef char *ADDRESS;

#define DEFBUFSIZ	8192
#define REGR_NORMAL 	0
#define REGR_FAILURE	1

/* text width and height for blowup stuff */
#define key_win_width 	68        /* this works well for current DEC fonts */
#define x_win_height 	17         /* ditto for this */

/* save_stat item masks */
#define gc_msk  1
#define dpy_msk 2
#define win_msk 4
#define pix_msk 8

struct args 
{
    	long int arg_cnt;                   /* Argument count */
    	struct  
	{                           	 /* Service routine control flags    */
		unsigned setup : 1;      /* Perform service routine setup code */
		unsigned check : 1;      /* Perform all checking code        */
		unsigned chksta : 1;     /* Perform status return check only */
		unsigned cleanup : 1;    /* Perform cleanup code             */
		unsigned perf : 1;       /* Perform performance code         */
		unsigned sync : 1;       /* Perform external synchronization */
		unsigned nostat : 1;     /* Disable STAT checking            */
		unsigned filler : 18;
		unsigned bufrout : 1;    /* Buffer output from REGR$MESSAGE  */
		unsigned dmpstp : 1;     /* Dump all step descriptors        */
		unsigned mode : 1;       /* Record mode = 1                  */
		unsigned chkdpy : 1;     /* Check the display for correctness*/
		unsigned chkpix : 1;     /* Pixmap checking on / off         */
		unsigned good : 1;
		unsigned verbose : 1;	/* Print large structures in long error reports */ 
        } l_flags;
    	int *expsta;                    /* Address of expected status return list */
    	long int iter;                  /* Iteration count for loop flag    */
};


union msglst {                          /* union for fao list */
    long          	typ_dec;
    float         	typ_flo;
    double        	typ_dou;
    unsigned long 	typ_oct;
    unsigned long 	typ_hex;
    unsigned long 	typ_uns;
    char          	typ_cha;
    char          	*typ_str;
    char		*typ_adr;
};

/*** drawable info data structure ***/

typedef struct drawable_info_record { /*** helps test keep track of all active drawables ***/
    Drawable drawable_id;
    int x,y;
    unsigned int width,height;
    unsigned long background_color;
    short is_pixmap; /* set to ~0 if this drawable is a pixmap */
} Drawable_Info_Record;

/*** font info data structure ***/

typedef struct font_info_record { /*** helps test keep track of all active fonts ***/
    XFontStruct *fstruct;		/* font structure returned from QueryFont */
    XFontStruct *kgfstruct;	      	/* known good font struct from *.h file */
    char	name[132];   		/* name of font */
    short 	is_16bit;		/* X11 font structure */
    int		min_encoding;		/* min character code */
    int		max_encoding;		/* max character code (linear assumption) */
} Font_Info_Record;

/******* define font type codes ********/

/******* Test pixel validation structures ******/

#ifdef TEST_MODULE
typedef struct {
        int drawable_number;     /* number of drawable in drawable_info[] array */
        int region;              /* WindowCenter, TopLeft, TopRight, BottomLeft, ... */
        int region_offset_x;     /* positive is num pixels in from region left edge */
        int region_offset_y;     /* positive is num pixels in from region top edge */
	int function;	 	 /* logical operation */
	unsigned long foreground;/* foreground pixel */
	unsigned long background;/* background pixel */
	unsigned long plane_mask;/* plane mask */
	int line_width;		 /* line width */
	int line_style;	 	 /* LineSolid, LineOnOffDash, LineDoubleDash */
	int cap_style;	  	 /* CapNotLast, CapButt, CapRound, CapProjecting */
	int join_style;	 	 /* JoinMiter, JoinRound, JoinBevel */
	int fill_style;	 	 /* FillSolid, FillTiled, FillStippled, FillOpaeueStippled */
	int fill_rule;	  	 /* EvenOddRule, WindingRule */
	int arc_mode;		 /* ArcChord, ArcPieSlice */
        int font_number;	 /* default text font number in font_info[] array for text operations */
	int subwindow_mode;      /* ClipByChildren, IncludeInferiors */
	Bool graphics_exposures; /* boolean, should exposures be generated */
        int shape; 		 /* shape used in FillPolygon */
        int coord_mode;		 /* Coordinate mode used with XPoints structure */
        short validation_mode;	 /* VALIDATE_PIXEL_POSITION or VALIDATE_PIXEL_COLOR_AND_POSITION */
} PVvalues;

#define VALIDATE_PIXEL_POSITION 	  0
#define VALIDATE_PIXEL_COLOR_AND_POSITION 1


#define FORWARD_FONT 0
#define REVERSE_FONT 1
#define SPECIAL_FONT 2

#endif /* TEST_MODULE defined */

/*** codes used in region_mode ****/

#define WindowCenter 	0
#define TopLeft 	1
#define TopRight 	2
#define BottomLeft 	3
#define BottomRight 	4
#define TopMiddle 	5
#define LeftMiddle 	6
#define RightMiddle 	7
#define BottomMiddle 	8

#define UNTESTED        tet_result(TET_UNTESTED)

#endif
