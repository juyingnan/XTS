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
* File:	xts5/src/libXR5/misc.c
*
* Description:
*	Misc. support routines
*
* Modifications:
* $Log: misc.c,v $
* Revision 1.2  2005-11-03 08:42:02  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:10  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:25:48  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:44:03  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:18:06  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:14:38  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:45:41  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:43:44  andy
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
#include <string.h>
#include <X11/X.h>
#include <X11/Xlib.h>
#include <r5structs.h>
#include <r5decl.h>

#define BUFFER_SIZE 256;

int 
badstat(display, expected, received)
Display *display;
int expected[];
int received;
{
	extern int chkflg;

	char *ss_fail1;
	char *ss_fail2;
	char *ss_fail3;
	char *ss_fail4;
	char *message_ptr;
	char message_string[80];

    	union msglst f_lst[2];
        int lst_siz, i, j;

	ss_fail1 = "\n\nExpected a status of\n";
	ss_fail2 = "    %s\n";
	ss_fail3 = "    %s or\n";
	ss_fail4 = "\nReceived status was\n    %s\n\n";
                         
	message_ptr = message_string;
     	lst_siz = expected[0];
        if (lst_siz == 0) {
		expected[1] = Success; 
		lst_siz = 1;
	}

	i = 1;
	while ( (received != expected[i]) && (i < lst_siz))
	    i++;

	if (received != expected[i]) {
		j = 1;
		message( ss_fail1, f_lst, 0);

		if (lst_siz == 1) {
			if (expected[j] != Success)
			    XGetErrorText(display, expected[j], message_ptr, 80);
			else
			    (void)strcpy(message_string,"Success");
			f_lst[0].typ_str = message_string;              
			message( ss_fail2, f_lst, 1);            
			if (received != Success)
			    XGetErrorText(display, received, message_ptr, 80);
			else                 
			    (void)strcpy(message_string,"Success");
			f_lst[0].typ_str = message_string;
			message( ss_fail4, f_lst, 1);            
		}
		else {
			i = lst_siz - 1;
			while (i-- != 0) {                                  
			    if (expected[j] != Success)
				XGetErrorText(display, expected[j], message_ptr, 80);
			    else                                       
			        (void)strcpy(message_string,"Success");
			   f_lst[0].typ_str = message_string;
			   message( ss_fail3, f_lst, 1);           
			   j++; 
			}                                  
			if (expected[j] != Success)
			    XGetErrorText(display, expected[j], message_ptr, 80);
			else                                       
			    (void)strcpy(message_string,"Success");
			f_lst[0].typ_str = message_string;
			message( ss_fail2, f_lst, 1);            
			if (received != Success)
			    XGetErrorText(display, received, message_ptr, 80);
			else
			    (void)strcpy(message_string,"Success");
			f_lst[0].typ_str = message_string;
			message( ss_fail4, f_lst, 1);            
		}
		return (REGR_FAILURE);
	}
	else
	    chkflg = 1;
	    return (REGR_NORMAL);
}
                                      
                                        
void r_wait(disp, wind, seconds, cmap)
Display *disp;
Window wind;
int seconds;
Colormap cmap;
{                
	extern void blowup();                                          
        extern int blowup_size,region_mode,PixPerCM;
        extern struct args regr_args;
	extern XWindowAttributes wat_save;

	Window b_win, n_win, key_win, highlight;
	XEvent xev;
	GC textgc;                     
	XGCValues xgcv;
        extern unsigned long BackgroundPixel;
        extern int w_init,h_init;

	switch(seconds) {
	    case 0:
		break;
	    case -1:
            case -2:
		if ((regr_args.l_flags.chkdpy == 1) && (regr_args.l_flags.chkpix == 0)) {
        	    key_win = XCreateSimpleWindow(disp, (Window)XRootWindow(disp, XDefaultScreen(disp)), 
					(XDisplayWidth(disp, XDefaultScreen(disp)) - key_win_width - 7 - blowup_size),
					(XDisplayHeight(disp, XDefaultScreen(disp)) - (2 * x_win_height) + 1),
					key_win_width, (2 * x_win_height) - 2, 1, XWhitePixel(disp,XDefaultScreen(disp)),
					XBlackPixel(disp,XDefaultScreen(disp)));
		    XMapWindow(disp, key_win);
        	    n_win = XCreateSimpleWindow(disp, key_win, 0, x_win_height - 1, 
					key_win_width, x_win_height - 2, 0, XWhitePixel(disp,XDefaultScreen(disp)),
					XBlackPixel(disp,XDefaultScreen(disp)));
        	    b_win = XCreateSimpleWindow(disp, key_win, 0, 0, 
					key_win_width, x_win_height - 2, 0, XWhitePixel(disp,XDefaultScreen(disp)),
					XBlackPixel(disp,XDefaultScreen(disp)));
		    XMapSubwindows(disp, key_win); 
		    xgcv.function = GXinvert;
		    xgcv.background = XBlackPixel(disp, XDefaultScreen(disp));
		    xgcv.foreground = XWhitePixel(disp, XDefaultScreen(disp));
		    textgc = XCreateGC(disp, key_win, GCFunction | GCForeground | GCBackground, &xgcv); 
		    XDrawImageString(disp, b_win, textgc, 0, 11, "   blowup  ", 11);
		    XSetForeground(disp, textgc, XBlackPixel(disp, XDefaultScreen(disp)));
		    XSetBackground(disp, textgc, XWhitePixel(disp, XDefaultScreen(disp)));
		    XDrawImageString(disp, n_win, textgc, 0, 11, "   next    ", 11);
		    highlight = n_win;
		    XSelectInput(disp, n_win, ButtonPressMask | PointerMotionMask); 
		    XSelectInput(disp, b_win, ButtonPressMask | PointerMotionMask); 
		    XSync(disp, 1);
		    while (1) {
	    		XNextEvent(disp, &xev);                                      
   	    		if (xev.type != MotionNotify) { 	/* not a highlight event */
			    if (xev.xbutton.window == n_win) 		/* quit */
		    		break;
			    else { 
                                int x_position,y_position;
                                switch(region_mode)
                                {
                                    case 2: case 7: /* region in upper right or mid right */
                                        /* put blowup window in lower left corner */
                                        x_position = 1;                             
                                        y_position = XDisplayHeight(disp,XDefaultScreen(disp))-(x_win_height+5)-blowup_size;
                                        break;
                                    case 3: case 8: /* region in lower left or mid bottom */
                                        /* put blowup in upper right corner */
                                        x_position = XDisplayWidth(disp,XDefaultScreen(disp))-key_win_width-7-blowup_size;     
                                        y_position = PixPerCM;
                                        break;
                                    case 4: /* region in lower right */
                                        /* put blowup in upper left corner */
                                        x_position = 1;  
                                        y_position = PixPerCM;
                                        break;
                                    default: /* 0=middle,1=upper left,5=mid_top,6=mid_left, or any number out of range */
                                        /* put blowup in lower right corner */
                                        x_position = XDisplayWidth(disp,XDefaultScreen(disp))-key_win_width-7-blowup_size;     
                                        y_position = XDisplayHeight(disp,XDefaultScreen(disp))-(x_win_height+5)-blowup_size;
                                        break;
                                }
        	                XSelectInput(disp, n_win, 0L);
    	                        XSelectInput(disp, b_win, 0L);
    	                        XSync(disp, 1);
                                VBlowup(disp,wind,x_position,y_position,blowup_size,1,cmap,None,0,0,
                                        BackgroundPixel,w_init/2,h_init/2,0);
/*            			blowup(disp, wind, (XDisplayWidth(disp, XDefaultScreen(disp)) - key_win_width - 7 - blowup_size), 
			                   (XDisplayHeight(disp, XDefaultScreen(disp)) - (x_win_height + 5) - blowup_size), 
			                   blowup_size, 1, cmap); */
				break;
			    }
			}                                           
			else  { /* highlight */
		    	    if (highlight != xev.xmotion.window) {                                                     
	     			XSetForeground(disp, textgc, XWhitePixel(disp, XDefaultScreen(disp)));
				XSetBackground(disp, textgc, XBlackPixel(disp, XDefaultScreen(disp)));
                        	if (highlight == n_win) {
				    XDrawImageString(disp, n_win, textgc, 0, 11, "   next    ", 11);
	     			    XSetForeground(disp, textgc, XBlackPixel(disp, XDefaultScreen(disp)));
				    XSetBackground(disp, textgc, XWhitePixel(disp, XDefaultScreen(disp)));
				    XDrawImageString(disp, b_win, textgc, 0, 11, "   blowup  ", 11);
				}
                        	else {
				    XDrawImageString(disp, b_win, textgc, 0, 11, "   blowup  ", 11);
	     			    XSetForeground(disp, textgc, XBlackPixel(disp, XDefaultScreen(disp)));
				    XSetBackground(disp, textgc, XWhitePixel(disp, XDefaultScreen(disp)));
				    XDrawImageString(disp, n_win, textgc, 0, 11, "   next    ", 11);
				}
				highlight = xev.xmotion.window;
				XSync(disp, 0);
                            }
			}
		    } /* end while */
		    XClearWindow(disp, n_win);
		    XClearWindow(disp, b_win);
		    XSelectInput(disp, wind, wat_save.your_event_mask);
		    XSync(disp, 0);
		    wat_save.all_event_masks = wat_save.your_event_mask;
		} 
		break;   
	    default:
	      	(void)sleep((unsigned)seconds);
		break;                                   
	}                                                                                               
}
