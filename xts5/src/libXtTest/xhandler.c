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
* $Header: /cvs/xtest/xtest/xts5/src/libXtTest/xhandler.c,v 1.1 2005-02-12 14:37:15 anderson Exp $
*
* Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
* Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
* All Rights Reserved.
*
* Project: VSW5
*
* File: vsw5/src/lib/libXtTest/x_handler.c
*
* Description:
*	Function: x_handler()
*
* Modifications:
* $Log: xhandler.c,v $
* Revision 1.1  2005-02-12 14:37:15  anderson
* Initial revision
*
* Revision 8.0  1998/12/23 23:25:42  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:43:57  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:18:01  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:14:33  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:45:28  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:43:24  andy
* Prepare for GA Release
*
*/

#include <XtTest.h>

/*
 *	Invoked by X when an IO error occurs (ie an
 *	unexpected server disconnect)
 *	
 *	setup by test cases with XSetIOErrorHandler(io_handler);
 *
*/

#include <X11/Xlib.h>

/*error messages formatted here*/
char ebuf[4096];

int x_handler(disp)
Display *disp;
{

    char *stars, *errormsg, *server;

/*
 * set up the error message
 */
    stars	= "ERROR: ****************************************************";
    errormsg	= "ERROR: An unexpected XIOError occurred while testing";
    server	= "ERROR: Check for server disconnect";

/*
 * print the error message
*/
	tet_infoline(stars);
	tet_infoline(errormsg);
	tet_infoline(server);
	tet_infoline(stars);
	tet_result(TET_FAIL);	
	exit(0);
}
