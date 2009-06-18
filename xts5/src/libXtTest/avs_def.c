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
* $Header: /cvs/xtest/xtest/xts5/src/libXtTest/avs_def.c,v 1.2 2005-11-03 08:42:02 jmichael Exp $
*
* Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
* Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
* All Rights Reserved.
*
* Project: VSW5
*
* File: xts5/src/lib/libXtTest/avs_def.c
*
* Description:
*	Function avs_xt_def()
*	intialize the toolkit internals, creat application context, open
*	and intialize display and create initial shell instance
*	return the toplevel shell widget.
*
* Modifications:
* $Log: avs_def.c,v $
* Revision 1.2  2005-11-03 08:42:02  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:10  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:25:33  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:43:47  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.1  1998/06/22 21:33:37  andy
* Added sleep(XT_RESET_DELAY) before XtInitialize.  SR# 186.
*
* Revision 6.0  1998/03/02 05:17:53  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:14:24  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:45:05  tbr
* Branch point for Release 5.0.0
*
* Revision 3.2  1995/12/15  00:42:56  andy
* Prepare for GA Release
*
*/


#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <XtTest.h>

void XtConfigureWidget();

Widget avs_xt_def(string)
char *string;
{
	char app_class[4096]; 
	Display *display;
	Widget root_widget;

	int x_origin, y_origin;	 	/* x, y origin of widget */
	int width, height;		/* height and width of widget */

	int DisplayWidthInPix;		/* Number of display width pixels */
	int DisplayHeightInPix;		/* Number of display height pixels */
	int DisplayWidthInMM;		/* display width in mm */
	int PixelPerCM;		 	/* number of pixels in cms */

	int argcount = 0;

	/*
	** form application class name
	*/
	strcpy(app_class, string);

	(void)XSetIOErrorHandler(x_handler); /* X Handler for severe errors */
	(void)XSetErrorHandler(x_unexperr);  /* Unexpected XError handler */

	sleep(config.reset_delay);

	root_widget = (Widget)XtInitialize (
		   NULL, 
		  "Tmainloop1",
		   (XrmOptionDescRec *)NULL,  /* cmd options */
		   (Cardinal)0,			 /* num cmd */
		   &argcount,
		   (String *)NULL
		   );

	if (root_widget == NULL) {
		tet_infoline("ERROR: XtInitialize returned NULL");
		tet_result(TET_UNRESOLVED);
		exit(0);
	}

	/*
	** Get height and width of display in pixels and create a toplevel
	** shell with consistent height and width for any display.
	*/

	display = XtDisplay(root_widget);
	if (display == NULL) {
		tet_infoline("ERROR: XtDisplay returned NULL");
		tet_result(TET_UNRESOLVED);
		exit(0);
	}

	DisplayWidthInPix  = XDisplayWidth(display, XDefaultScreen(display));
	DisplayHeightInPix = XDisplayHeight(display, XDefaultScreen(display));
	DisplayWidthInMM = XDisplayWidthMM(display, XDefaultScreen(display));

	PixelPerCM = ( DisplayWidthInPix * 10 )/DisplayWidthInMM;

	x_origin =  2 * PixelPerCM;
	y_origin = 2 * PixelPerCM;
	width = DisplayWidthInPix - ( 4 * PixelPerCM );
	height = DisplayHeightInPix - ( 4 * PixelPerCM );

	XtConfigureWidget(root_widget, x_origin, y_origin, width, height, 1);

	/* return toplevel shell widget */
	return(root_widget);
}
