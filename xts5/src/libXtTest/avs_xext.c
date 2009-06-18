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
* $Header: /cvs/xtest/xtest/xts5/src/libXtTest/avs_xext.c,v 1.3 2005-11-03 08:42:02 jmichael Exp $
*
* Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
* Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
* All Rights Reserved.
*
* Project: VSW5
*
* File: xts5/src/lib/libXtTest/avs_xext.c
*
* Description:
*	Function avs_xext_init()
*	Function avs_xext_close()
*	Open display and create a window
*
* Modifications:
* $Log: avs_xext.c,v $
* Revision 1.3  2005-11-03 08:42:02  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.2  2005/04/21 09:40:42  ajosey
* resync to VSW5.1.5
*
* Revision 8.1  2003/12/08 16:49:41  gwc
* Removed bogus window_arg == NULL check in avs_xext_init()
*
* Revision 8.0  1998/12/23 23:25:37  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:43:51  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.2  1998/06/22 21:23:27  andy
* Editorial
*
* Revision 6.1  1998/06/22 21:16:58  andy
* Added retry loop on opening display. SR #84.
*
* Revision 6.0  1998/03/02 05:17:56  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:14:28  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:45:13  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:43:05  andy
* Prepare for GA Release
*
*/

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <XtTest.h>

#include <X11/Xlib.h>			

Display *display;
extern char ebuf[];

Window avs_xext_init()
{
	Window window_arg;

	int x_origin, y_origin;	/* x, y origin of widget */
	int width, height;		/* height and width of widget */

	int DisplayWidthInPix;		/* Number of display width pixels */
	int DisplayHeightInPix;		/* Number of display height pixels */
	int DisplayWidthInMM;		/* display width in mm */
	int PixelPerCM;		/* number of pixels in cms */
	int BorderPixel;
	int BackgroundPixel;
	int BorderWidth = 1;
	int	i;

	char *  cfgdisplay;

	(void)XSetIOErrorHandler(x_handler);    /*X Handler for severe errors */
	(void)XSetErrorHandler(x_unexperr);     /* Unexpected XError handler */

	cfgdisplay = tet_getvar("XT_DISPLAY");
	if (cfgdisplay == 0) {
		tet_infoline("ERROR: avs_xt_init: XT_DISPLAY not set in tet_exec.cfg");
		tet_result(TET_UNRESOLVED);
		exit(0);
	}
	if (strlen(cfgdisplay) == 0) {
		tet_infoline("ERROR: avs_xt_init: XT_DISPLAY has empty value in tet_exec.cfg");
		tet_result(TET_UNRESOLVED);
		exit(1);
	}

	for (i = 0; i < (config.reset_delay*2)+1; i++) {
		display = XOpenDisplay(cfgdisplay);

		if (display != NULL)
			break;
		sleep(1);
	}

	if (!display) {
		sprintf(ebuf,"ERROR: avs_xext_init: Unable to open display %s", cfgdisplay);
		tet_infoline(ebuf);
		tet_result(TET_UNRESOLVED);
		exit(1);
	}

	/*
	** Get height and width of display in pixels and create a window
	** with consistent height and width for any display.
	*/
	DisplayWidthInPix = XDisplayWidth(display,XDefaultScreen(display));
	DisplayHeightInPix = XDisplayHeight(display,XDefaultScreen(display));
	DisplayWidthInMM = XDisplayWidthMM(display,XDefaultScreen(display));

	PixelPerCM = (DisplayWidthInPix * 10)/DisplayWidthInMM;

	x_origin =  2 * PixelPerCM;
	y_origin = 2 * PixelPerCM;
	width = DisplayWidthInPix - (4 * PixelPerCM);
	height = DisplayHeightInPix - (4 * PixelPerCM);

	BorderPixel = XBlackPixel(display,XDefaultScreen(display));
	BackgroundPixel = XWhitePixel(display,XDefaultScreen(display));

	window_arg = XCreateSimpleWindow(display,
		(Window)XRootWindow(display, XDefaultScreen(display)),
		 x_origin, y_origin,
		 (unsigned int)width,
		 (unsigned int)height,
		 BorderWidth,
		 BorderPixel,
		 BackgroundPixel
		 );

	XMapWindow (display, window_arg);
	XSync (display, 0);

	/* return window_arg */
	return(window_arg);
}

void avs_xext_close()
{
	XCloseDisplay(display);
}
