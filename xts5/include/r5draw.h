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
* $Header: /cvs/xtest/xtest/xts5/include/r5draw.h,v 1.1 2005-02-12 14:37:13 anderson Exp $
*
* Copyright Applied Testing and Technology Inc. 1995
* All rights reserved
*
* Project: VSW5
*
* File:	vsw5/src/libXR5/r5draw.h
*
* Description:
*	R5 xlib tests Drawable support routines
*
* Modifications:
* $Log: r5draw.h,v $
* Revision 1.1  2005-02-12 14:37:13  anderson
* Initial revision
*
* Revision 8.0  1998/12/23 23:23:33  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:41:38  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:16:04  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:12:35  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.1  1996/02/13 23:41:21  andy
* Editorial
*
* Revision 4.0  1995/12/15  08:38:46  tbr
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

#ifndef _DRAWUTIL
#define _DRAWUTIL

#include <stdio.h>
#include <vmath.h>
#include <X11/Xlib.h>
                                 

/**** define DRAWUTIL_GLOBAL and D_INIT() ******/

#ifndef DRAWUTIL_GLOBAL   

#define D_INIT(x) 
#define DRAWUTIL_GLOBAL extern

#else

#define D_INIT(x) = x
#define DRAWUTIL_GLOBAL

#endif /* DRAWUTIL_GLOBAL not defined */

           

/************************* DECLARE GLOBALS ************************************/

/*** globals declared in regr_decl.h and setup up in knobs file for pixel validation ***/

#ifndef TEST_MODULE   
extern		int 		region_mode;	   		/* Region of window to pixel validate */
extern 		int 		max_width;			/* Max width of region to pixel validate */
extern 		int 		max_height;			/* Max height of region to pixel validate */
extern		int 		blowup_size;			/* Size of blowup window width and height in pixels */
extern		int 		extent_fringe_size;		/* Num pixels band around extent rectangle to validate */
#endif


/******** drawable info **********************************/

DRAWUTIL_GLOBAL Display 	*display;			/* The display structure that was opened in the test */
DRAWUTIL_GLOBAL Drawable 	root_id;			/* The display's default screen's root window */
DRAWUTIL_GLOBAL Drawable 	drawable_id;			/* The drawable that we are to pixel validate */
DRAWUTIL_GLOBAL short 		is_pixmap;			/* Set to True if drawable is a pixmap, False if window */
DRAWUTIL_GLOBAL int 		window_x,window_y;		/* Position of pixel validatable window relative to root */
DRAWUTIL_GLOBAL int 		drawable_width,drawable_height;	/* Size of pixel validatable drawable */
/*DRAWUTIL_GLOBAL int 		screen_width,screen_height;	/* Size of pixel validatable screen */
DRAWUTIL_GLOBAL unsigned long 	window_background;		/* Background color index of pixel validatable drawable */
DRAWUTIL_GLOBAL int 		window_frac_x,window_frac_y;	/* Position of pixel validation region relative to drawable*/
                                                                 /* expressed as a fraction between 0 and 1 scaled by 2^10.*/
                                                                 /* 0 means along left-most edge or top-most edge */
DRAWUTIL_GLOBAL int		region_x_offset,region_y_offset;/* Number of pixels in from leading region edges */


/******** Known-good image file globals (see compress.h for a description of the file contents) *******************/

DRAWUTIL_GLOBAL FILE 		*ImageFile 	D_INIT(0);	/* File pointer to known-good image file */
DRAWUTIL_GLOBAL char 		image_file_name[255];		/* Image file name string */
DRAWUTIL_GLOBAL int 		num_image_records;		/* Number of elements in following 3 arrays */
DRAWUTIL_GLOBAL long 		*file_position;			/* Array of file positions from ftell() */
DRAWUTIL_GLOBAL long 		*record_size;			/* Array of image record sizes in bytes */
DRAWUTIL_GLOBAL unsigned long 	*old_image_record_id;       	/* Array of image record id's */
DRAWUTIL_GLOBAL int 		number_of_pvcolors;		/* Number of unique colors in an image record */
DRAWUTIL_GLOBAL int 		number_of_base_colors;		/* Number of base colors in image record */
DRAWUTIL_GLOBAL unsigned long 	pvcolors[64];			/* Image record color table */


/******** Known-good image file globals used only in VGenerate mode **************/

DRAWUTIL_GLOBAL long 		good_pixmaps_written D_INIT(0); /* number of pixmaps written out to file */

DRAWUTIL_GLOBAL FILE 		*OldImageFile 	     D_INIT(0);	/* In generate-mode, pointer to last version of file*/
typedef struct _rec_id {   /*                                   /* Record used in image_record info linked list: */
    		unsigned long 	id;				    /* image record id */
    		long 		file_position;			    /* file position of record using ftell() and fseek() */
    		long 		record_size;			    /* number of bytes in image record */
    		struct _rec_id 	*next;				    /* pointer to next rec_id_record */
} rec_id_record;

DRAWUTIL_GLOBAL rec_id_record 	*first_rec_id;			/* first rec_id_record in linked list */
DRAWUTIL_GLOBAL rec_id_record 	*last_rec_id; 			/* last rec_id_record in linked list */


/************ Miscellaneous pixel validation global variables ***************/

DRAWUTIL_GLOBAL unsigned long 	image_record_id	    D_INIT(0);		/* Unique 32-bit id that goes with image record */

DRAWUTIL_GLOBAL char 		image_record_description[255];		/* Unique description of image record */

DRAWUTIL_GLOBAL extent_record 	rel_extents;				/* lowx,highx,lowy,highy relative to region */
DRAWUTIL_GLOBAL extent_record	abs_extents;				/* lowx,highx,lowy,highy relative to window */

DRAWUTIL_GLOBAL int 		note_warnings 	    D_INIT(0);		/* 0=wrong pixels are indicated with errors */
 									/* 1=wrong pixels are indicated with warnings */

DRAWUTIL_GLOBAL int 		skip_image_record_copy D_INIT(0);	/* 0=In gen mode, if exists, copy old image record */
									/* 1=In gen mode, generate new image record */

DRAWUTIL_GLOBAL short 		validate_color	    D_INIT(0);		/* 0=validate pixel position only */
									/* 1=validate pixel position and color */

/******* Define user-flag bits in image record *******/

#define LAST_MATCH_MASK (1<<0)
#define     LAST_MATCH     (0<<0)
#define     OR_NEXT_MATCH  (1<<0)

#define WARNINGS_MASK (1<<1)
#define     NOTE_ERRORS    (0<<1)
#define     NOTE_WARNINGS  (1<<1)

#define CHECK_PIXMAP_MASK (1<<2)
#define     CHECK_PIXMAP      (0<<2)
#define     DONT_CHECK_PIXMAP (1<<2)

#define	VALIDATE_COLOR_MASK (1<<3)
#define     DONT_VALIDATE_COLOR (0<<3)
#define     VALIDATE_COLOR      (1<<3)


/************************* DECLARE FUNCTIONS ************************************/

/* NOTE: PARAMS is defined in VMATH */

extern void vsetup_modes PARAMS((int note_warnings, int skip_image_copy, int validation_mode));

extern void vsetup_drawable_info PARAMS((Display *display_in, Drawable root, Drawable window, int is_pixmap,
                                         unsigned long background, int x, int y, unsigned int width, unsigned int height));

extern void vinit_extents PARAMS(());

extern void vsetup_extents PARAMS((int min_x, int min_y, int max_x, int max_y));

extern void vget_extents PARAMS((int *min_x, int *min_y, int *max_x, int *max_y));

extern int  vget_extents2 PARAMS((extent_record *extents));

extern void vcalc_points_extents PARAMS((XPoint *points, int num_points, int mode));

extern void vcalc_segments_extents PARAMS((XSegment *segments, int num_segments, int thickness, int cap));
                            
extern void vcalc_lines_extents PARAMS((XPoint *points, int num_points, int thickness, int cap, int join, int mode));
                            
extern void vcalc_rectangles_extents PARAMS((XRectangle *rectangles, int num_rectangles, int thickness));

extern void vcalc_filled_rectangles_extents PARAMS((XRectangle *rectangles, int num_rectangles));

extern void vcalc_arcs_extents PARAMS((XArc *arcs, int num_arcs, int thickness, int cap, int join));

extern void vcalc_area_extents PARAMS((int x, int y, unsigned int width, unsigned int height));

extern void vcalc_filled_arcs_extents PARAMS((XArc *arcs, int num_arcs, int arc_mode));

extern void vsetup_region PARAMS((int region, int region_offset_x, int region_offset_y));

extern void vcalc_region_origin PARAMS((int region,int extent_width,int extent_height,int *x,int *y));

extern void vcalc_origin PARAMS((int *x_origin, int *y_origin));

extern void vsetup_test_colors PARAMS((int func, unsigned long color1, unsigned long color2, 
                                       unsigned long plane_mask, int num_colors));

extern void vsetup_base_colors PARAMS((unsigned long *colors, int num_colors));

extern void vadd_color_entry PARAMS((unsigned long color));

extern void vsetup_record_id PARAMS((unsigned long record_id));

extern void vsetup_description PARAMS((char *description));

extern void VGenerateCompImage PARAMS(());

extern void VCompareCompImage PARAMS(());

extern void close_image_file PARAMS(());

extern FILE *open_image_file PARAMS((char *file_name));


/*************
*  Functions to mask during pixval generation runs
**************/

#ifdef GENERATE_PIXMAPS
#define XSync(a,b) 
#define XMapWindow(a,b) VMapWindow(a,b)
#define XClearWindow(a,b)  VClearWindow(a,b)
#define XClearArea(a,b,x,y,w,h,e) VClearArea(a,b,x,y,w,h,e) 
#define save_stat(a,b,c,d) REGR_NORMAL
#define chek_stat(a,b,c,d,e) REGR_NORMAL
#define badstat(a,b,c) REGR_NORMAL
#define r_init() vr_init()
#define r_close() vr_close()
#define step(str) vstep(str)
#define r_wait(a,b,c,d)
#define bufrdisp(a)
#define bufrgc(a,b)
#define signal_status arbitrary
#define XSetErrorHandler(a)                                       
#define XSetIOErrorHandler(a)
#define XDrawPoint(a,b,c,d,e) VDrawPoint(a,b,c,d,e)
#define XDrawPoints(a,b,c,d,e,f) VDrawPoints(a,b,c,d,e,f)
#define XDrawLine(a,b,c,d,e,f,g) VDrawLine(a,b,c,d,e,f,g)
#define XDrawLines(a,b,c,d,e,f) VDrawLines(a,b,c,d,e,f)
#define XDrawSegments(a,b,c,d,e) VDrawSegments(a,b,c,d,e)
#define XDrawRectangle(a,b,c,d,e,f,g) VDrawRectangle(a,b,c,d,e,f,g)
#define XDrawRectangles(a,b,c,d,e) VDrawRectangles(a,b,c,d,e)
#define XFillRectangle(a,b,c,d,e,f,g) VFillRectangle(a,b,c,d,e,f,g)
#define XFillRectangles(a,b,c,d,e) VFillRectangles(a,b,c,d,e)
#define XFillPolygon(a,b,c,d,e,f,g) VFillPolygon(a,b,c,d,e,f,g)
#define XDrawArc(a,b,c,d,e,f,g,h,i) VDrawArc(a,b,c,d,e,f,g,h,i)
#define XDrawArcs(a,b,c,d,e) VDrawArcs(a,b,c,d,e)
#define XFillArc(a,b,c,d,e,f,g,h,i) VFillArc(a,b,c,d,e,f,g,h,i)
#define XFillArcs(a,b,c,d,e) VFillArcs(a,b,c,d,e)
#define XCloseDisplay(a) VCloseDisplay(a)
#define XCopyGC(d,gc,vm,xgcv) VCopyGC(d,gc,vm,xgcv)
#define XCreateGC(d,w,vm,xgcv) VCreateGC(d,w,vm,xgcv)
#define XCreatePixmap(a,b,c,d,e) VCreatePixmap(a,b,c,d,e)
#define XCreateSimpleWindow(a,b,c,d,e,f,g,h,i) VCreateSimpleWindow(a,b,c,d,e,f,g,h,i) 
#define XCreateWindow(a,b,c,d,e,f,g,h,i,j,k,l) VCreateSimpleWindow(a,b,c,d,e,f,g,h,i,j,k,l)
#define XChangeWindowAttributes(a,b,c,d)  VChangeWindowAttributes(a,b,c,d) 
#define XGetWindowAttributes(a,b,c)  VGetWindowAttributes(a,b,c) 
#define XQueryTree(di,w,rr,pr,cr,n) VQueryTree(di,w,rr,pr,cr,n)
#define XDestroyWindow(a,b) VDestroyWindow(a,b) 
#define XFreeGC(a,b) VFreeGC(a,b)
#define XFreePixmap(a,b) VFreePixmap(a,b)
#define XOpenDisplay(a) VOpenDisplay(a)
#define XSetBackground(a,b,c) VSetBackground(a,b,c)
#define XSetForeground(a,b,c) VSetForeground(a,b,c)
#define XSetFunction(a,b,c) VSetFunction(a,b,c)
#define XSetState(a,b,c,d,e,f) VSetState(a,b,c,d,e,f)
#define XSetLineAttributes(disp,gc,a,b,c,d) VSetLineAttributes(disp,gc,a,b,c,d)
#define XSetDashes(disp,gc,do,dl,n) VSetDashes(disp,gc,do,dl,n)
#define XSetFillStyle(disp,gc,fs) VSetFillStyle(disp,gc,fs)
#define XSetFillRule(disp,gc,fr) VSetFillRule(disp,gc,fr)
#define XSetArcMode(disp,gc,am) VSetArcMode(disp,gc,am)
#define XSetStipple(disp,gc,s) VSetStipple(disp,gc,s)
#define XSetTile(disp,gc,t) VSetTile(disp,gc,t)
#define XSetClipMask(disp,gc,cm) VSetClipMask(disp,gc,cm)
#define XSetTSOrigin(disp,gc,tsx,tsy) VSetTSOrigin(disp,gc,tsx,tsy)
#define XSetClipOrigin(disp,gc,clx,cly) VSetClipOrigin(disp,gc,clx,cly)
#define XSetWindowBackground(a,b,c) VSetWindowBackground(a,b,c)
#define XSetWindowBackgroundPixmap(a,b,c) VSetWindowBackgroundPixmap(a,b,c)
#define XMoveWindow(d,w,x,y) VMoveWindow(d,w,x,y)
#define XRaiseWindow(d,w) VRaiseWindow(d,w)
#define XLoadFont(d,fn) VLoadFont(d,fn)
#define XQueryFont(d,fid) VQueryFont(d,fid)
#define XLoadQueryFont(d,fn) VLoadQueryFont(d,fn)
#define XSetFont(d,gc,f) VSetFont(d,gc,f)
#define XTextExtents(fs,s,n,dr,ar,dtr,or) VTextExtents(fs,s,n,dr,ar,dtr,or)
#define XTextExtents16(fs,s,n,dr,ar,dtr,or) VTextExtents16(fs,s,n,dr,ar,dtr,or)
#define XTextWidth(fs,s,len) VTextWidth(fs,s,len)
#define XTextWidth16(fs,s,len) VTextWidth16(fs,s,len)
#define XUnloadFont(d,f) VUnloadFont(d,f)
#define XFreeFont(d,fs) VFreeFont(d,fs)
#define XDrawImageString(a,b,c,d,e,f,g) VDrawImageString(a,b,c,d,e,f,g)
#define XDrawString(a,b,c,d,e,f,g) VDrawString(a,b,c,d,e,f,g)
#define XDrawImageString16(a,b,c,d,e,f,g) VDrawImageString16(a,b,c,d,e,f,g)
#define XDrawString16(a,b,c,d,e,f,g) VDrawString16(a,b,c,d,e,f,g)
#define XDrawText(di,dr,gc,x,y,items,nitems) VDrawText(di,dr,gc,x,y,items,nitems)
#define XDrawText16(di,dr,gc,x,y,items,nitems) VDrawText16(di,dr,gc,x,y,items,nitems)
#define XDestroySubwindows(di,wi) VDestroySubwindows(di,wi) 
#define XMapSubwindows(di,wi) VMapSubwindows(di,wi) 
#define XMoveResizeWindow(di,wi,x,y,w,h) VMoveResizeWindow(di,wi,x,y,w,h)
#define XSetWindowBorder(di,wi,b) VSetWindowBorder(di,wi,b)
#define XSetWindowBorderPixmap(di,wi,p) VSetWindowBorderPixmap(di,wi,p)
#define XSetWindowBorderWidth(di,wi,w) VSetWindowBorderWidth(di,wi,w)
#define XCreateColormap(disp,w,vis,alloc) NULL
#define XFreeColormap(disp,colormap)
#define XInstallColormap(disp,colormap)
#define XSetWindowColormap(disp,w,colormap)
#define XStoreColor(disp,colormap,color)
#define XCreateRegion() NULL
#define XEmptyRegion(anything) True
#define XEqualRegion(aand, b) True
#define XIntersectRegion(three, para, meters)
#define XNextEvent(has, twoparameters)
#define XSelectInput(hasone, two, threethreeparameters)
#define XSubtractRegion(one, two, three)
#define XUnionRectWithRegion(onetwo, three, also)
#define XUnionRegion(has, threeparameters, howboutthat)
/* display macros */            

#define XConnectionNumber(dpy) 	((dpy)->fd)
#define XRootWindow(dpy, scr) 	(((dpy)->screens[(scr)]).root)
#define XDefaultScreen(dpy) 	((dpy)->default_screen)
#define XDefaultRootWindow(dpy) (((dpy)->screens[(dpy)->default_screen]).root)
#define XDefaultVisual(dpy, scr) (((dpy)->screens[(scr)]).root_visual)
#define XDefaultGC(dpy, scr) 	(((dpy)->screens[(scr)]).default_gc)
#define XBlackPixel(dpy, scr) 	(((dpy)->screens[(scr)]).black_pixel)
#define XWhitePixel(dpy, scr) 	(((dpy)->screens[(scr)]).white_pixel)
#define XAllPlanes() 		(~0)
#define XQLength(dpy) 		((dpy)->qlen)
#define XDisplayWidth(dpy, scr) (((dpy)->screens[(scr)]).width)
#define XDisplayHeight(dpy, scr) (((dpy)->screens[(scr)]).height)
#define XDisplayWidthMM(dpy, scr)(((dpy)->screens[(scr)]).mwidth)
#define XDisplayHeightMM(dpy, scr)(((dpy)->screens[(scr)]).mheight)
#define XDisplayPlanes(dpy, scr) (((dpy)->screens[(scr)]).root_depth)
#define XDisplayCells(dpy, scr) (DefaultVisual((dpy), (scr))->map_entries)
#define XScreenCount(dpy) 	((dpy)->nscreens)
#define XServerVendor(dpy) 	((dpy)->vendor)
#define XProtocolVersion(dpy) 	((dpy)->proto_major_version)
#define XProtocolRevision(dpy) 	((dpy)->proto_minor_version)
#define XVendorRelease(dpy) 	((dpy)->release)
#define XDisplayString(dpy) 	((dpy)->display_name)
#define XDefaultDepth(dpy, scr) (((dpy)->screens[(scr)]).root_depth)
#define XDefaultColormap(dpy, scr)(((dpy)->screens[(scr)]).cmap)
#define XBitmapUnit(dpy) 	((dpy)->bitmap_unit)
#define XBitmapBitOrder(dpy) 	((dpy)->bitmap_bit_order)
#define XBitmapPad(dpy) 	((dpy)->bitmap_pad)
#define XImageByteOrder(dpy) 	((dpy)->byte_order)
#define XNextRequest(dpy)	((dpy)->request + 1)
#define XLastKnownRequestProcessed(dpy)	((dpy)->last_request_read)

/* macros for screen oriented applications (toolkit) */

#define XScreenOfDisplay(dpy, scr)(&((dpy)->screens[(scr)]))
#define XDefaultScreenOfDisplay(dpy) (&((dpy)->screens[(dpy)->default_screen]))
#define XDisplayOfScreen(s)	((s)->display)
#define XRootWindowOfScreen(s)	((s)->root)
#define XBlackPixelOfScreen(s)	((s)->black_pixel)
#define XWhitePixelOfScreen(s)	((s)->white_pixel)
#define XDefaultColormapOfScreen(s)((s)->cmap)
#define XDefaultDepthOfScreen(s)((s)->root_depth)
#define XDefaultGCOfScreen(s)	((s)->default_gc)
#define XDefaultVisualOfScreen(s)((s)->root_visual)
#define XWidthOfScreen(s)	((s)->width)
#define XHeightOfScreen(s)	((s)->height)
#define XWidthMMOfScreen(s)	((s)->mwidth)
#define XHeightMMOfScreen(s)	((s)->mheight)
#define XPlanesOfScreen(s)	((s)->root_depth)
#define XCellsOfScreen(s)	(DefaultVisualOfScreen((s))->map_entries)
#define XMinCmapsOfScreen(s)	((s)->min_maps)
#define XMaxCmapsOfScreen(s)	((s)->max_maps)
#define XDoesSaveUnders(s)	((s)->save_unders)
#define XDoesBackingStore(s)	((s)->backing_store)
#define XEventMaskOfScreen(s)	((s)->root_input_mask)

#define VCompareCompImage() VGenerateCompImage()

#ifdef DUMP_KNOWN_GOOD_IMAGES /* for debug purposes - dumps known good image at generate time to given server for viewing */
#define VCompareCompImage() VGenerateCompImage2()
#endif


#ifdef DUMP_PIXMAPS /* for debug purposes - dumps pixmap record to given server for viewing 1 at a time */
#define VCompareCompImage() VDumpCompImage()
#endif

#endif /* ifdef GENERATE_PIXMAPS */

#endif /* ifndef _DRAWUTIL */
