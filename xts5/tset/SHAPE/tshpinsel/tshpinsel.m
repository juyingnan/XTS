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
$Header: /cvs/xtest/xtest/xts5/tset/SHAPE/tshpinsel/tshpinsel.m,v 1.1 2005-02-12 14:37:16 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>>#
>># Project: VSW5
>>#
>># File: tset/SHAPE/XShapeOffsetShape/tshpinsel.m
>>#
>># Description:
>>#     Tests for XShapeInputSelected()
>>#
>># Modifications:
>># $Log: tshpinsel.m,v $
>># Revision 1.1  2005-02-12 14:37:16  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:31:29  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:51:14  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:23:08  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:19:40  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.1  1997/10/26 22:38:10  andy
>># Corrected file name
>>#
>># Revision 4.0  1995/12/15  09:02:15  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.2  1995/12/15  01:47:53  andy
>># Prepare for GA Release
>>#

>>EXTERN
#include <X11/Xlib.h>
#include <X11/Xutil.h>
#include <X11/extensions/shape.h>
extern Display *display ;

>>TITLE XShapeInputSelected ShapeExt
unsigned long
XShapeInputSelected(display, window)
>>ASSERTION Good A
A call to unsigned long XShapeInputSelected(display, window) shall return the
current input mask for extension events on the specified window.
>>CODE
Window  window ;
unsigned long mask_good ;
pid_t pid2;

	FORK(pid2);
	tet_infoline("PREP: Open display and create window");
	window = (Window) avs_xext_init();
	tet_infoline("PREP: Set ShapeNotifyMask mask");
	XShapeSelectInput(display, window, ShapeNotifyMask) ;
	tet_infoline("PREP: Get mask of current window");
	mask_good = XShapeInputSelected(display, window);
	tet_infoline("TEST: Mask value is ShapeNotifyMask");
	check_dec(ShapeNotifyMask,mask_good, "mask value");
	LKROF(pid2, AVSXTTIMEOUT);
        tet_result(TET_PASS);
