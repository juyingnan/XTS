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
$Header: /cvs/xtest/xtest/xts5/tset/Xlib15/strgbclrmp/strgbclrmp.m,v 1.1 2005-02-12 14:37:23 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1995
All Rights Reserved.

>># Project: VSW5
>># 
>># File: vsw5/tset/Xlib15/strgbclrmp/strgbclrmp.m
>># 
>># Description:
>># 	Tests for XSetRGBColormaps()
>># 
>># Modifications:
>># $Log: strgbclrmp.m,v $
>># Revision 1.1  2005-02-12 14:37:23  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:34:01  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:56:03  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:25:23  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:21:55  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.1  1996/05/09 00:29:02  andy
>># Corrected Xatom include
>>#
>># Revision 4.0  1995/12/15  09:09:28  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:11:30  andy
>># Prepare for GA Release
>>#
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
>>TITLE XSetRGBColormaps Xlib15
void
XSetRGBColormaps(display, w, std_colormap, count, property)
Display			*display = Dsp;
Window			w = DRW(Dsp);
XStandardColormap	*std_colormp = &sclrmp;
int			count = 1;
Atom			property = XA_RGB_DEFAULT_MAP;
>>EXTERN
#include		"X11/Xatom.h"
static XStandardColormap	sclrmp;
static XStandardColormap	scmp1 = { (Colormap)  1,  2L,  3L,  4L,  5L,  6L,  7L,  8L, (VisualID) 9L, (XID) 10L };
>>ASSERTION Good A
A call to xname sets the property, specified by
the
.A property
argument, for the window
.A w
to be of type
.S RGB_COLOR_MAP ,
format 32, and to have value set to the
.A count
.S XStandardColormap
structures specified by the
.A std_colormap
argument.
>>STRATEGY
Create a window using XCreateWindow.
Set the RGB_DEFAULT_MAP property using XSetRGBColormaps.
Obtain the RGB_DEFAULT_MAP property using XGetWindowProperty.
Verify that the property type is RGB_COLOR_MAP.
Verify that the property format is 32.
Verify that property value is correct.
>>CODE
Atom			actual_type;
int			actual_format;
unsigned long		leftover;
unsigned long		nitems;
XVisualInfo		*vp;
XStandardColormap	*rcmap = (XStandardColormap *) NULL;

	resetvinf(VI_WIN);
	nextvinf(&vp);
	w = makewin(display, vp);

	std_colormp = &scmp1;
	XCALL;

	if( XGetWindowProperty(display, w, property, 0L, 40L, False, XA_RGB_COLOR_MAP, &actual_type,
				&actual_format, &nitems, &leftover, (unsigned char **) &rcmap) != Success ) {
		delete("XGetWindowProperty() did not return Success.");
		return;
	} else
		CHECK;
	
	if(leftover != 0) {
		report("The leftover elements numbered %lu instead of 0", leftover);
		FAIL;
	} else
		CHECK;

	if(actual_format != 32) {
		report("The format of the RGB_DEFAULT_MAP property was %lu instead of 32", actual_format);
		FAIL;
	} else
		CHECK;

	if(actual_type != XA_RGB_COLOR_MAP) {
		report("The type of the RGB_DEFAULT_MAP property was %lu instead of RGB_DEFAULT_MAP (%lu)", actual_type,
				 (long) XA_RGB_DEFAULT_MAP);
		FAIL;
	} else
		CHECK;

	if( rcmap == (XStandardColormap *) NULL) {
		report("No value was obtained for the RGB_DEFAULT_MAP property.");
		FAIL;
	} else {

		CHECK;
		
		if(nitems != 10) {
			report("The RGB_DEFAULT_MAP property comprised %d elements instead of %d", nitems, 10);
			FAIL;
		} else
			if(actual_format == 32) {
				CHECK;
  				if(rcmap->colormap != scmp1.colormap) {
					report("The colormap component of the XStandardColormap structure %d was incorrect.");
					FAIL;
				} else
					CHECK;
			
				if(rcmap->red_max != scmp1.red_max)  {
					report("The red_max component of the XStandardColormap structure %d was incorrect.");
					FAIL;
				} else
					CHECK;
			
				if(rcmap->red_mult != scmp1.red_mult) {
					report("The red_mult component of the XStandardColormap structure %d was incorrect.");
					FAIL;
				} else
					CHECK;
			
				if(rcmap->green_max != scmp1.green_max) {
					report("The green_max component of the XStandardColormap structure %d was incorrect.");
					FAIL;
				} else
					CHECK;
			
				if(rcmap->green_mult != scmp1.green_mult) {
					report("The green_mult component of the XStandardColormap structure %d was incorrect.");
					FAIL;
				} else
					CHECK;
			
				if(rcmap->blue_max != scmp1.blue_max) {
					report("The blue_max component of the XStandardColormap structure %d was incorrect.");
					FAIL;
				} else
					CHECK;
			
				if(rcmap->blue_mult != scmp1.blue_mult) {
					report("The blue_mult component of the XStandardColormap structure %d was incorrect.");
					FAIL;
				} else
					CHECK;
			
				if(rcmap->base_pixel != scmp1.base_pixel) {
					report("The base_pixel component of the XStandardColormap structure %d was incorrect.");
					FAIL;
				} else
					CHECK;
			
				if(rcmap->visualid != scmp1.visualid) {
					report("The visualid component of the XStandardColormap structure %d was incorrect.");
					FAIL;
				} else
					CHECK;
			
				if(rcmap->killid != scmp1.killid ) {
					report("The killid component of the XStandardColormap structure %d was incorrect.");
					FAIL;
				} else
					CHECK;
			
			}
			XFree((char *) rcmap);
		}

	CHECKPASS(16);

>>ASSERTION Bad A
.ER BadAlloc
>>ASSERTION Bad A
.ER BadAtom
>>ASSERTION Bad A
.ER BadWindow 
>># Kieron	Action	Review
