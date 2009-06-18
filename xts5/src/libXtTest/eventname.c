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
* $Header: /cvs/xtest/xtest/xts5/src/libXtTest/eventname.c,v 1.2 2005-11-03 08:42:02 jmichael Exp $
*
* Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
* Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
* All Rights Reserved.
*
* Project: VSW5
*
* File: xts5/src/lib/libXtTest/eventname.c
*
* Description:
*	Procedure x_event_name()
*
* Modifications:
* $Log: eventname.c,v $
* Revision 1.2  2005-11-03 08:42:02  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:10  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:25:39  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:43:53  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:17:58  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:14:30  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:45:20  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:43:14  andy
* Prepare for GA Release
*
*/

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <XtTest.h>



/*
** FORMAL PARAMETERS:
**
**      event_type 
**          input event type 
**
*/

#include <stdio.h>              /* standard i/o functions */
#include <X11/Xlib.h>               /* standard x defs */


char *event_names[] = {
      "",
      "",
      "KeyPress",
      "KeyRelease",
      "ButtonPress",
      "ButtonRelease",
      "MotionNotify",
      "EnterNotify",
      "LeaveNotify",
      "FocusIn",
      "FocusOut",
      "KeymapNotify",
      "Expose",
      "GraphicsExpose",
      "NoExpose",
      "VisibilityNotify",
      "CreateNotify",
      "DestroyNotify",
      "UnmapNotify",
      "MapNotify",
      "MapRequest",
      "ReparentNotify",
      "ConfigureNotify",
      "ConfigureRequest",
      "GravityNotify",
      "ResizeRequest",
      "CirculateNotify",
      "CirculateRequest",
      "PropertyNotify",
      "SelectionClear",
      "SelectionRequest",
      "SelectionNotify",
      "ColormapNotify",
      "ClientMessage",
      "MappingNotify",
} ;

void x_event_name(type)
int type ;
{
    return;
}
