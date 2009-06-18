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
* $Header: /cvs/xtest/xtest/xts5/src/libXR5/blowup.c,v 1.2 2005-11-03 08:42:02 jmichael Exp $
*
* Copyright Applied Testing and Technology Inc. 1995
* All rights reserved
*
* Project: VSW5
*
* File:	xts5/src/libXR5/blowup.c
*
* Description:
*	Drawable support routines
*
* Modifications:
* $Log: blowup.c,v $
* Revision 1.2  2005-11-03 08:42:02  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:10  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:25:44  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:43:59  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:18:03  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:14:35  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.1  1996/01/27 03:24:32  andy
* Replaced externs for malloc and free with include of stdlib
*
* Revision 4.0  1995/12/15  08:45:34  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:43:31  andy
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

#include <stdio.h>
#include <stdlib.h>
#include <X11/Xlib.h>  		/* xlib defs */
#include <X11/cursorfont.h>	/* cursor info */
#include <r5structs.h>
#include <r5decl.h>		/* color thingys */

#define DRAWUTIL_GLOBAL /* causes globals in drawutil.h to declare storage in this module */
#include <r5draw.h>		/* color thingys */

/******** module globals **********/

short pixel_wrong;
unsigned long expected_pixel;
int windx,windy,wind_width,wind_height,scrn_width,scrn_height;


/*
 * get the image and blow it up
 */                          
void vmakebig(vdisplay, window, blowup_win, x, y, zoom_factor,pixels_across, size, format, gc, gcback, gcfore, kgi, ix, iy, 
              background, view_color, test_color)
Display *vdisplay;
Window window;
Window blowup_win;
int x, y, zoom_factor;
int pixels_across;               
int format;
GC gc;                  
unsigned long gcback,gcfore;
XImage *kgi;			/* known good image */
int ix, iy;		  	/* origin of known good image relative to the screen */
unsigned long background;       /* background color */
int view_color,test_color;
{
	XImage *ximage;
	int across,down,e,f, azf;    
	unsigned long pixel, old_pixel, testpixel,goodpixel;               
	XSegment h_lines[200];                                                  
	XSegment v_lines[200];
        int half_pixels_across = pixels_across>>1;

            pixel_wrong = 0;

	    ximage = XGetImage(vdisplay, XRootWindow(vdisplay, XDefaultScreen(vdisplay)), x, y, 
			       pixels_across, pixels_across, XAllPlanes(), format);
	    old_pixel = XWhitePixel(vdisplay, XDefaultScreen(vdisplay));

            XSetForeground(vdisplay, gc, XBlackPixel(vdisplay,XDefaultScreen(vdisplay)));  /* put in for monochrome case */
	    XSetBackground(vdisplay, gc, XWhitePixel(vdisplay,XDefaultScreen(vdisplay)));

	    for (across = 0; across < pixels_across; across++) {            
		azf = (across * zoom_factor) + key_win_width + 2; 
		for (down = 0; down < pixels_across; down++) { 
                    pixel = XGetPixel(ximage,across,down);
 		    if (pixel != background) {
                        if (view_color)
        	            XSetForeground(vdisplay, gc, pixel);
                        else
                            XSetForeground(vdisplay, gc, gcfore);
  		        XFillRectangle(vdisplay, blowup_win, gc, azf, 
			               ((down * zoom_factor) + x_win_height + 1), zoom_factor, zoom_factor);
		    }
/*************/ 
                    if (kgi != None) {
                        testpixel = pixel;
                        if (!test_color) {
                            if (testpixel == background)
                                testpixel = 0;
                            else
                                testpixel = 1;
                        }
     			if (((across + x - ix - windx) < kgi->width) && ((down + y - iy - windy) < kgi->height) &&
			    ((across + x - ix - windx) > -1) && ((down + y - iy - windy) > -1)) {
                            goodpixel = XGetPixel(kgi,across+x-ix-windx,down+y-iy-windy);
                            if (!test_color) {
                                if (goodpixel == 0)
                                    goodpixel = 0;
                                else 
                                    goodpixel = 1;
                            }
			    if (testpixel != goodpixel) {
                                if ((across == half_pixels_across)&&(down == half_pixels_across))
                                {
                                    pixel_wrong = 1;
                                    expected_pixel = goodpixel;
                                }
			    	XSetForeground(vdisplay, gc, validate_color?1:XWhitePixel(vdisplay, XDefaultScreen(vdisplay)));
			    	XDrawLine(vdisplay, blowup_win, gc, azf, ((down * zoom_factor) + x_win_height + 1),
				      azf + zoom_factor, ((down * zoom_factor) + x_win_height + 1) + zoom_factor);  
			    	XDrawLine(vdisplay, blowup_win, gc, azf + zoom_factor + 1, ((down * zoom_factor) + x_win_height + 1),
				      azf + 1, ((down * zoom_factor) + x_win_height + 1) + zoom_factor);  
			    	XSetForeground(vdisplay, gc, validate_color?0:XBlackPixel(vdisplay, XDefaultScreen(vdisplay)));
			    	XDrawLine(vdisplay, blowup_win, gc, azf + zoom_factor, ((down * zoom_factor) + x_win_height + 1),
				      azf, ((down * zoom_factor) + x_win_height + 1) + zoom_factor);  
			    	XDrawLine(vdisplay, blowup_win, gc, azf + 1, ((down * zoom_factor) + x_win_height + 1),
				      azf + zoom_factor + 1, ((down * zoom_factor) + x_win_height + 1) + zoom_factor);
			    }
			}                                                                                          
		    }
/*************/ 
                }                    
	    }
	    XDestroyImage(ximage);
/*
 * setup and draw the pixel boundaries
 */                                                                      
	    for (e = zoom_factor,f = 0; f < pixels_across; e += zoom_factor, f++) {
	     	v_lines[f].x1 = e + key_win_width + 2;
		v_lines[f].y1 =	x_win_height + 1;
		v_lines[f].x2 =	e + key_win_width + 2;
		v_lines[f].y2 =	size + x_win_height + 1;                
		h_lines[f].x1 = key_win_width + 2;
		h_lines[f].y1 = e + x_win_height + 1;
		h_lines[f].x2 = size + key_win_width + 2;
		h_lines[f].y2 = e + x_win_height + 1;
	    }   
                                
            /* add highlights to middle pair of lines */

            f = pixels_across;
            v_lines[f].x1 = (pixels_across>>1)*zoom_factor + key_win_width + 2 + 1;
	    v_lines[f].y1 = x_win_height + 1;
	    v_lines[f].x2 = v_lines[f].x1;
	    v_lines[f].y2 = size + x_win_height + 1;                
	    h_lines[f].x1 = key_win_width + 2;
	    h_lines[f].y1 = (pixels_across>>1)*zoom_factor + x_win_height + 1 + 1;
	    h_lines[f].x2 = size + key_win_width + 2;
	    h_lines[f].y2 = h_lines[f].y1;
            f++;
     	    v_lines[f].x1 = ((pixels_across>>1)+1)*zoom_factor + key_win_width + 2 + 1;
	    v_lines[f].y1 = x_win_height + 1;
	    v_lines[f].x2 = v_lines[f].x1;
	    v_lines[f].y2 = size + x_win_height + 1;                
	    h_lines[f].x1 = key_win_width + 2;
	    h_lines[f].y1 = ((pixels_across>>1)+1)*zoom_factor + x_win_height + 1 + 1;
	    h_lines[f].x2 = size + key_win_width + 2;
	    h_lines[f].y2 = h_lines[f].y1;
	    
	    /* set the plane mask to the low order bit to really invert black and white on multi plane systems */
	    XSetState(vdisplay, gc, XWhitePixel(vdisplay, XDefaultScreen(vdisplay)), XBlackPixel(vdisplay, XDefaultScreen(vdisplay)),
			GXinvert, 1L);
	    XDrawSegments(vdisplay, blowup_win, gc, v_lines, pixels_across+2);
	    XDrawSegments(vdisplay, blowup_win, gc, h_lines, pixels_across+2);
	    XSetState(vdisplay, gc, XWhitePixel(vdisplay, XDefaultScreen(vdisplay)), XBlackPixel(vdisplay, XDefaultScreen(vdisplay)),
			GXcopy, XAllPlanes());
	    XSync(vdisplay, 1);  	                                        
}
                                                  
                                                
/*
 * do initialization and handle events                                                                
 */


void VBlowup(vdisplay, window, init_x, init_y, size, granularity, cmap, kgi, ix,
             iy, background, warp_pointer_x, warp_pointer_y,show_banner,compare_color)
Display *vdisplay;
Window window;
int init_x, init_y;
int size;
int granularity;
Colormap cmap;
XImage *kgi;
int ix, iy;
unsigned long background;
int warp_pointer_x, warp_pointer_y;
int show_banner;
int compare_color;                 
{                                                      
        int	show_color = compare_color;
                                                                                     
	XImage *ximage2;
        Window highlight = 0, head_win, pix_win, exp_win, blowup_win, tar_win, key_win, key[8];
	GC textgc, gc, dgc, rect_gc;
	XGCValues xgcv;
	XEvent xev;
	int zoom_factor = 10, size2;                                                    
	int pixels_across = 20; 
	int start_x = 0, start_y = 0;
        int old_start_x = -9999, old_start_y = -9999, old_pixels_across = -9999;
	int max_x, max_y;
	char xypair[80];                    
	Cursor curse;
  	int format;
	unsigned long gcfore, gcback;                                           
	Window		tracewind;
        XWindowAttributes win_attr;

        /* initialize rectangle pixmap overlay gc */        

        rect_gc = XCreateGC(vdisplay,window,(unsigned long)0,(XGCValues *)NULL);
        XSetForeground(vdisplay,rect_gc,1L); /* this works well with xor function */
        XSetBackground(vdisplay,rect_gc,0L);
        XSetFunction(vdisplay,rect_gc,GXxor);                                    
        XSetLineAttributes(vdisplay,rect_gc,0,LineSolid,CapButt,JoinBevel); /* specify line width */

        /* find window offset from root window */

	tracewind = window;
	windx = 0;
      	windy = 0;

        scrn_width = wind_width = XDisplayWidth(vdisplay,XDefaultScreen(vdisplay));
        scrn_height = wind_height = XDisplayHeight(vdisplay,XDefaultScreen(vdisplay));

	while (tracewind != XRootWindow(vdisplay,XDefaultScreen(vdisplay)))
	    {
	    XWindowAttributes	Xwatt;                                     
	    Window	rootwind,parwind,*childlist;
	    unsigned int		nchild;

	    XGetWindowAttributes(vdisplay,tracewind,&Xwatt);

            if (tracewind == window)
            {
                wind_width = Xwatt.width;
                wind_height = Xwatt.height;
            }

	    windx += Xwatt.x + Xwatt.border_width;
	    windy += Xwatt.y + Xwatt.border_width;
         
	    XQueryTree(vdisplay,tracewind,&rootwind,&parwind,&childlist,&nchild);
	    tracewind = parwind;
	    }
                                  
	if (XDefaultDepth(vdisplay, XDefaultScreen(vdisplay)) == 1) 	/* check for color */
	    format = XYPixmap;
	else 
	    format = ZPixmap;
	dgc = XDefaultGC(vdisplay, XDefaultScreen(vdisplay));
/*                   
	gcfore = GetGCVforeground(dgc);
	gcback = GetGCVbackground(dgc);
*/

        if (validate_color)
          {
            gcfore = 0;
            gcback = 1;
          }
        else
          {
            gcfore = XBlackPixel(vdisplay,XDefaultScreen(vdisplay));
            gcback = XWhitePixel(vdisplay,XDefaultScreen(vdisplay));
          }

	size2 = size / 2;
        blowup_win = XCreateSimpleWindow(vdisplay,(Window)XRootWindow(vdisplay,XDefaultScreen(vdisplay)),init_x,init_y,
					 (size + 4 + key_win_width),(size + 2 + x_win_height),1, gcfore, gcback);
	XMapWindow(vdisplay,blowup_win);
	if (cmap != None)
            XSetWindowColormap(vdisplay, blowup_win, cmap);
	XSync(vdisplay, 0);
        head_win = XCreateSimpleWindow(vdisplay,blowup_win,0,0,
					 (size + 2 + key_win_width), (x_win_height - 2),1, gcfore, gcback);
        key_win = XCreateSimpleWindow(vdisplay,blowup_win,0,x_win_height,
				 	 key_win_width, size,1, gcfore, gcback);
	XMapSubwindows(vdisplay, blowup_win); 

        key[0] = XCreateSimpleWindow(vdisplay,key_win,0,0,
					 key_win_width,15,0,gcfore, gcback);
        key[1] = XCreateSimpleWindow(vdisplay,key_win,0,15,
					 key_win_width,15,0,gcfore, gcback);
/*      key[2] = XCreateSimpleWindow(vdisplay,key_win,0, (size2 - 30),
					 key_win_width,15,0,gcfore, gcback);  
*/
        key[3] = XCreateSimpleWindow(vdisplay,key_win,0, (size2 - 15),
					 key_win_width,15,0,gcfore, gcback);  
        if (kgi)
            key[4] = XCreateSimpleWindow(vdisplay,key_win,0, size2 - 30,
      					 key_win_width,15,0,gcfore, gcback);  
        key[5] = XCreateSimpleWindow(vdisplay,key_win,0, (size2 + 15),
					 key_win_width,15,0,gcfore, gcback);
        key[6] = XCreateSimpleWindow(vdisplay,key_win,0, (size2 + 30),
					 key_win_width,15,0,gcfore, gcback);
        key[7] = XCreateSimpleWindow(vdisplay,key_win,0,size - 15,
					 key_win_width,15,0,gcfore, gcback);
	XMapSubwindows(vdisplay, key_win); 
        pix_win = XCreateSimpleWindow(vdisplay,head_win,0,0,
					 key_win_width+40,15,0,gcfore, gcback);
        exp_win = XCreateSimpleWindow(vdisplay,head_win,(size - 30),0,
					 key_win_width+40,15,0,gcfore, gcback);
	XMapSubwindows(vdisplay, head_win); 
	XSync(vdisplay, 0);                            
             
	xgcv.function = GXcopy;
	xgcv.background = gcback; 
	xgcv.foreground = gcfore; 
	textgc = XCreateGC(vdisplay, window, GCFunction | GCForeground | GCBackground, &xgcv); 
	gc = XCreateGC(vdisplay, (Window)XRootWindow(vdisplay, XDefaultScreen(vdisplay)), 
			   GCFunction | GCForeground | GCBackground, &xgcv);    

        if (kgi == None) {
            if (show_banner)
      	        XDrawString(vdisplay, head_win, textgc, ((size2 +(key_win_width/2))-25*6/2), 11, " Blowup - Pixmap Correct ",25);
            else
      	        XDrawString(vdisplay, head_win, textgc, ((size2 +(key_win_width/2))-10*6/2), 11, " Blowup   ",10);
        }
        else 
  	    XDrawString(vdisplay, head_win, textgc, ((size2 +(key_win_width/2))-25*6/2), 11, "Blowup - Pixmap Incorrect", 25);
	XDrawString(vdisplay, pix_win, textgc, 0, 11, " Pixel  ", 7);
	XDrawString(vdisplay, key[0], textgc, 0, 11, " X         ", 11);
	XDrawImageString(vdisplay, key[1], textgc, 0, 11, " Y         ", 11);
/*	XDrawImageString(vdisplay, key[2], textgc, 0, 11, " move left ", 11);  
*/
	XDrawImageString(vdisplay, key[3], textgc, 0, 11, " color/mono", 11);  
        if (kgi)
   	    XDrawImageString(vdisplay, key[4], textgc, 0, 11, " next error", 11);  
	XDrawImageString(vdisplay, key[5], textgc, 0, 11, " zoom in   ", 11);
	XDrawImageString(vdisplay, key[6], textgc, 0, 11, " zoom out  ", 11);
	XDrawImageString(vdisplay, key[7], textgc, 0, 11, " quit      ", 11);
	XSync(vdisplay, 0);                            

	max_x = XDisplayWidth(vdisplay, XDefaultScreen(vdisplay)) - 1;
	max_y = XDisplayHeight(vdisplay, XDefaultScreen(vdisplay)) - 1;

	curse = XCreateFontCursor(vdisplay, XC_sb_right_arrow);
        XSync(vdisplay,0);
	XDefineCursor(vdisplay, window, curse);
        XSync(vdisplay,0);
	XStoreName(vdisplay, blowup_win, "Blowup");              
        XSync(vdisplay,0);                                         

/*
 * select the event inputs.  Note we will do highlight events with pointer motion not enter and leave events,
 * this is because the user interface across the net appears much smoother and only slightly slower with
 * this approach
 */
	XSelectInput(vdisplay, window, ButtonPressMask); 
	XSelectInput(vdisplay, blowup_win, ButtonPressMask);
	XSelectInput(vdisplay,(Window)XRootWindow(vdisplay,XDefaultScreen(vdisplay)), ButtonPressMask | PointerMotionMask ); 
/*	XSelectInput(vdisplay, key[1], ButtonPressMask | PointerMotionMask); 
	XSelectInput(vdisplay, key[2], ButtonPressMask | PointerMotionMask);  
*/
	XSelectInput(vdisplay, key[3], ButtonPressMask | PointerMotionMask);  
        if (kgi)
    	    XSelectInput(vdisplay, key[4], ButtonPressMask | PointerMotionMask);  
	XSelectInput(vdisplay, key[5], ButtonPressMask | PointerMotionMask); 
	XSelectInput(vdisplay, key[6], ButtonPressMask | PointerMotionMask); 
	XSelectInput(vdisplay, key[7], ButtonPressMask | PointerMotionMask); 
	XSync(vdisplay, 0);    


/***************/

        if (kgi != None)
	{       
	    XEvent fake;                                                                       

            XGetWindowAttributes(vdisplay,window,&win_attr);

            fake.xbutton.display = vdisplay;
            fake.xbutton.window = window;
            fake.xbutton.root = XRootWindow(vdisplay,XDefaultScreen(vdisplay));
            fake.xbutton.time = CurrentTime;
            fake.xbutton.x = warp_pointer_x;
            fake.xbutton.y = warp_pointer_y;
            fake.xbutton.x_root = warp_pointer_x+windx;
            fake.xbutton.y_root = warp_pointer_y+windy;
	    fake.type = ButtonPress; 
            fake.xbutton.state = Button1Mask;
	    XPutBackEvent(vdisplay, &fake);

            XSync(vdisplay,0);

            XWarpPointer(vdisplay,None,XRootWindow(vdisplay,XDefaultScreen(vdisplay)),0,0,0,0,
                         warp_pointer_x+windx,warp_pointer_y+windy);
	    XSync(vdisplay, 0);
            XWarpPointer(vdisplay,XRootWindow(vdisplay,XDefaultScreen(vdisplay)),window,warp_pointer_x+windx,warp_pointer_y+windy,
                         XDisplayWidth(vdisplay,0),XDisplayHeight(vdisplay,0),warp_pointer_x,warp_pointer_y);
	    XSync(vdisplay, 0);
	}
/***************/
                                            
/*                           
 * now get events until the user requests a quit
 */
	while (1) {
	    XNextEvent(vdisplay, &xev);                                      
   	    if (xev.type != MotionNotify) { 	/* not a highlight event */
		if (xev.xbutton.window == key[7]) 		/* quit */
		    break;
		else if (xev.xbutton.window == key[6]) {        /* zoom out */
		    if (zoom_factor > (granularity + 1)) {
			zoom_factor -= granularity;   
			start_x += (pixels_across / 2);
			start_y += (pixels_across / 2);
	    	        pixels_across = size / zoom_factor;
			start_x -= (pixels_across / 2);
			start_y -= (pixels_across / 2);
		    }
		}
		else if (xev.xbutton.window == key[5]) {   	/* zoom in */
		    if (zoom_factor < (size - granularity)) {
		   	zoom_factor += granularity;	             
			start_x += (pixels_across / 2);
			start_y += (pixels_across / 2);
	    	        pixels_across = size / zoom_factor;
			start_x -= (pixels_across / 2);
			start_y -= (pixels_across / 2);
		    }
		}
/*     		else if (xev.xbutton.window == key[1]) 		/* move up */
/*		    start_y++;
     		else if (xev.xbutton.window == key[2])		/* move left */
/*		    start_x++;              */
     		else if (xev.xbutton.window == key[3])		/* color/mono */
		    show_color = (!show_color);                           
     		else if ((kgi) &&(xev.xbutton.window == key[4]))	/* move to next error */
                {
              	    XEvent fake; 
                    int x_scan,y_scan;
                    XImage *ximage;                
                    unsigned long test_pixel, good_pixel;
                    unsigned char test_monopix, good_monopix;
                    int begin_x;
                    short found_mismatch;
                    int old_x_scan,old_y_scan;      
                    int lox,loy,hix,hiy;
                    short done;         

                    lox = ix + windx;
                    if (lox < 0)
                        lox = 0;

                    hix = ix + windx + kgi->width;
                    if (hix > scrn_width)
                        hix = scrn_width;

                    loy = iy + windy;
                    if (loy < 0)
                        loy = 0;

                    hiy = iy + windy + kgi->height;
                    if (hiy > scrn_height)
                        hiy = scrn_height;
                    
                    if (old_start_x != -9999)
                        XDrawRectangle(vdisplay,window,rect_gc,old_start_x-windx,old_start_y-windy,old_pixels_across,
                                       old_pixels_across);
                    old_start_x = -9999;
                    x_scan = start_x + (pixels_across>>1) + 1;
                    y_scan = start_y + (pixels_across>>1);
                    if (y_scan < loy) {
                        y_scan = loy;
                        x_scan = lox;
                    }
                    else if (y_scan > hiy) {
                        y_scan = loy;
                        x_scan = lox;
                    }
                  
                    if (x_scan > hix) {
                        x_scan = lox;
                        y_scan++;
                    }             
                    else if (x_scan < lox)
                        x_scan = lox;
                    
                    old_x_scan = x_scan;
                    old_y_scan = y_scan;

                    found_mismatch = done = 0;
                    while (!done && (y_scan < hiy)) {
                        begin_x = x_scan;
                        ximage = XGetImage(vdisplay, XRootWindow(vdisplay,XDefaultScreen(vdisplay)), begin_x,
                                           y_scan, hix - begin_x, 1, XAllPlanes(), format);
                        while (!done && (x_scan < hix)) {
                            test_pixel = XGetPixel(ximage,x_scan-begin_x,0);
                            good_pixel = XGetPixel(kgi,x_scan-ix-windx,y_scan-iy-windy);
                            if (!compare_color)
                            {
                                if (test_pixel == background)
                                    test_pixel = 0;
                                else 
                                    test_pixel = 1;
                                if (good_pixel != 0)
                                    good_pixel = 1;
                            }
                            if (good_pixel != test_pixel)
                                found_mismatch = done = 1;
                            else {
                                x_scan++;
                                if ((x_scan == old_x_scan)&&(y_scan == old_y_scan))
                                    done = 1;
                            }
                        }
                        XDestroyImage(ximage);
                        if (!done) {
                            x_scan = lox;
                            y_scan++;
                            if (y_scan >= hiy)
                                y_scan = loy;
                        }
                    }
                    if (found_mismatch) {
/*
                        fake.xbutton.display = vdisplay;
                        fake.xbutton.window = window;
                        fake.xbutton.root = XRootWindow(vdisplay,XDefaultScreen(vdisplay));
                        fake.xbutton.time = CurrentTime;
                        fake.xbutton.x = x_scan - windx - 1;
                        fake.xbutton.y = y_scan - windy - 1;
                        fake.xbutton.x_root = x_scan - 1;
                        fake.xbutton.y_root = y_scan - 1;
                        fake.type = ButtonPress;        
                        fake.xbutton.state = Button1Mask;
                        XPutBackEvent(vdisplay, &fake);

                        XSync(vdisplay,0);
                
                        XWarpPointer(vdisplay,None,
                                     window,0,0,0,0,x_scan - windx, y_scan - windy);
                        XSync(vdisplay, 0);
*/
                        start_x = x_scan - (pixels_across>>1);
                        start_y = y_scan - (pixels_across>>1);               
                    }
                }                               
		else if (xev.xbutton.window == blowup_win)
		    {
		    start_x += (xev.xbutton.x - key_win_width - 2) / zoom_factor - (pixels_across>>1);
		    start_y += (xev.xbutton.y - x_win_height - 1) / zoom_factor - (pixels_across>>1);
		    }
		else {
			/* target or root window */
		    if (xev.xbutton.window == window) 
			tar_win = 1; /* current window is target window */
		    else 
			tar_win = 0;
	    	    pixels_across = size / zoom_factor;
		    start_x = xev.xbutton.x_root - (pixels_across / 2);
		    start_y = xev.xbutton.y_root - (pixels_across / 2);
		}
		XSetForeground(vdisplay, textgc, gcfore); 
		XSetBackground(vdisplay, textgc, gcback); 
                if (show_color) 
                    XSetWindowBackground(vdisplay,blowup_win,background);
                else
                    XSetWindowBackground(vdisplay,blowup_win,gcback);
	    	XClearWindow(vdisplay, blowup_win);
	    	XClearWindow(vdisplay, pix_win);
                XClearWindow(vdisplay, exp_win);
	    	XClearWindow(vdisplay, key[0]);             
                XClearWindow(vdisplay, key[1]);
	    	if (start_x > (max_x - pixels_across)) start_x = max_x - pixels_across;
	    	if (start_x < 0) start_x = 0;
	    	if (start_y > (max_y - pixels_across)) start_y = max_y - pixels_across;
	    	if (start_y < 0) start_y = 0;

  	        ximage2 = XGetImage(vdisplay, XRootWindow(vdisplay, XDefaultScreen(vdisplay)), 
                                   start_x + (pixels_across>>1), start_y + (pixels_across>>1), 
		   	           1,1, XAllPlanes(), format);
      	        (void)sprintf(xypair, " Pixel = %X        ",XGetPixel(ximage2,0,0));
	    	XDrawString(vdisplay, pix_win, textgc, 2, 10, xypair, 18);
		if (tar_win)
		    {
	    	    (void)sprintf(xypair, " X = %dW      ",start_x - windx + (pixels_across>>1)); 
	    	    XDrawString(vdisplay, key[0], textgc, 2, 10, xypair, 13);
	    	    (void)sprintf(xypair, " Y = %dW      ",start_y - windy + (pixels_across>>1));
	    	    XDrawString(vdisplay, key[1], textgc, 2, 10, xypair, 13);
		    }
		else
		    {
	    	    (void)sprintf(xypair, " X = %dR      ",start_x + (pixels_across>>1)); 
	    	    XDrawString(vdisplay, key[0], textgc, 2, 10, xypair, 13);
	    	    (void)sprintf(xypair, " Y = %dR      ",start_y + (pixels_across>>1));
	    	    XDrawString(vdisplay, key[1], textgc, 2, 10, xypair, 13);
		    }
                if (old_start_x != -9999)
                {    
                    XDrawRectangle(vdisplay,window,rect_gc,old_start_x-windx,old_start_y-windy,old_pixels_across,old_pixels_across);
                }
                old_start_x = start_x;
                old_start_y = start_y;
                old_pixels_across = pixels_across;
	    	vmakebig(vdisplay, window, blowup_win, start_x, start_y,
		   	zoom_factor, pixels_across, size, format, gc, gcback, gcfore, kgi, ix, iy, background,
                        show_color,compare_color);
                XDrawRectangle(vdisplay,window,rect_gc,start_x-windx,start_y-windy,pixels_across,pixels_across);
                if ((pixel_wrong)&&(show_color))
                {                                                
      	            (void)sprintf(xypair, " Expect = %X        ",expected_pixel);
	    	    XDrawImageString(vdisplay, exp_win, textgc, 2, 10, xypair, 18);
                }
                else
                {
                    sprintf(xypair,"                     ");
	    	    XDrawImageString(vdisplay, exp_win, textgc, 2, 10, xypair, 18);
                }
  	    }
	    else {	/* highlight movement option */                              
		if (xev.xmotion.window == XRootWindow(vdisplay, XDefaultScreen(vdisplay))) {
		    if (highlight != None) { 			/* unhighlight the currently highlighted window */
			XSetForeground(vdisplay, textgc, gcfore); 
			XSetBackground(vdisplay, textgc, gcback); 
/*                      if (highlight == key[1])
			    XDrawImageString(vdisplay, key[1], textgc, 0, 11, " move up   ", 11);
                        else if (highlight == key[2])
			    XDrawImageString(vdisplay, key[2], textgc, 0, 11, " move left ", 11); */
             /* else */ if (highlight == key[3])
			    XDrawImageString(vdisplay, key[3], textgc, 0, 11, " color/mono", 11); 
                        else if (kgi && (highlight == key[4]))
			    XDrawImageString(vdisplay, key[4], textgc, 0, 11, " next error", 11); 
                        else if (highlight == key[5])        
			    XDrawImageString(vdisplay, key[5], textgc, 0, 11, " zoom in   ", 11);  
                        else if (highlight == key[6])
			    XDrawImageString(vdisplay, key[6], textgc, 0, 11, " zoom out  ", 11);
                        else 
			    XDrawImageString(vdisplay, key[7], textgc, 0, 11, " quit      ", 11);
			highlight = None; 
			XSync(vdisplay, 1);
		    }
	    	}
		else {                                       	/* someone is requesting a highlight */
		    if (highlight != xev.xmotion.window) {
			if (highlight != None) {                /* if someone is currently highlighted, unhighlight them */
			    XSetForeground(vdisplay, textgc, gcfore); 
			    XSetBackground(vdisplay, textgc, gcback); 
/*                          if (highlight == key[1])
			    	XDrawImageString(vdisplay, key[1], textgc, 0, 11, " move up   ", 11);
                            else if (highlight == key[2])
			    	XDrawImageString(vdisplay, key[2], textgc, 0, 11, " move left ", 11); */
                 /* else */ if (highlight == key[3])
			    	XDrawImageString(vdisplay, key[3], textgc, 0, 11, " color/mono", 11); 
                            else if (kgi && (highlight == key[4]))
			    	XDrawImageString(vdisplay, key[4], textgc, 0, 11, " next error", 11); 
                            else if (highlight == key[5])
			    	XDrawImageString(vdisplay, key[5], textgc, 0, 11, " zoom in   ", 11);
                            else if (highlight == key[6])
			    	XDrawImageString(vdisplay, key[6], textgc, 0, 11, " zoom out  ", 11);
                            else 
			    	XDrawImageString(vdisplay, key[7], textgc, 0, 11, " quit      ", 11);
			}                                  	/* now highlight the requestor */
			XSetBackground(vdisplay, textgc, gcfore); 
			XSetForeground(vdisplay, textgc, gcback); 
/*                      if (xev.xmotion.window == key[1])
			    XDrawImageString(vdisplay, key[1], textgc, 0, 11, " move up   ", 11);
                        else if (xev.xmotion.window == key[2])
			    XDrawImageString(vdisplay, key[2], textgc, 0, 11, " move left ", 11); */
             /* else */ if (xev.xmotion.window == key[3])
			    XDrawImageString(vdisplay, key[3], textgc, 0, 11, " color/mono", 11); 
                        else if (kgi && (xev.xmotion.window == key[4]))
			    XDrawImageString(vdisplay, key[4], textgc, 0, 11, " next error", 11); 
                        else if (xev.xmotion.window == key[5])
			    XDrawImageString(vdisplay, key[5], textgc, 0, 11, " zoom in   ", 11);
                        else if (xev.xmotion.window == key[6])
			    XDrawImageString(vdisplay, key[6], textgc, 0, 11, " zoom out  ", 11);
                        else 
			    XDrawImageString(vdisplay, key[7], textgc, 0, 11, " quit      ", 11);
			highlight = xev.xmotion.window; 
			XSync(vdisplay, 1);
	     	    } /* end not current selection */
		}  /* end not root */
	    } /* end highlight */
	}  /* end while(1) */                                
        XDrawRectangle(vdisplay,window,rect_gc,start_x-windx,start_y-windy,pixels_across,pixels_across);
	XDestroyWindow(vdisplay, blowup_win);
	XFreeCursor(vdisplay, curse);
	XFreeGC(vdisplay, textgc);
	XFreeGC(vdisplay, gc);
	XSync(vdisplay, 0);
}                                                                 
