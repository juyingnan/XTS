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
$Header: /cvs/xtest/xtest/xts5/tset/Xlib15/XSetIconSizes/XSetIconSizes.m,v 1.2 2005-11-03 08:42:51 jmichael Exp $

Copyright (c) Applied Testing and Technology, Inc. 1995
All Rights Reserved.

>># Project: VSW5
>># 
>># File: xts5/tset/Xlib15/XSetIconSizes/XSetIconSizes.m
>># 
>># Description:
>># 	Tests for XSetIconSizes()
>># 
>># Modifications:
>># $Log: sticnszs.m,v $
>># Revision 1.2  2005-11-03 08:42:51  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:21  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:34:01  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:56:02  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:25:23  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:21:55  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.1  1996/05/09 00:29:01  andy
>># Corrected Xatom include
>>#
>># Revision 4.0  1995/12/15  09:09:26  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:11:28  andy
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
>>TITLE XSetIconSizes Xlib15

XSetIconSizes(display, w, size_list, count)
Display		*display = Dsp;
Window		w = DRW(Dsp);
XIconSize	*size_list = &sizelist;
int		count = 1;
>>EXTERN
#include	"X11/Xatom.h"
XIconSize	sizelist;
>>ASSERTION Good A
A call to xname sets the WM_ICON_SIZE property for the window
.A w
to be of
type
.S WM_ICON_SIZE ,
format 32 and to have value set
to the
.A count
.S XIconSize
structures named by the
.A size_list
argument.
>>STRATEGY
Create a window using XCreateWindow.
Set the WM_ICON_SIZE property using XSetIconSizes.
Obtain the WM_ICON_SIZE property using XGetWindowProperty.
Verify that the property type is WM_ICON_SIZE.
Verify that the property format is 32.
Verify that the returned number of elements is correct.
Verify that the property value is correct.
>>CODE
#define		NumPropIconSizeElements 6
XVisualInfo	*vp;
unsigned long	leftover, nitems, len;
int		actual_format;
Atom		actual_type;
long		*rsizelist = (long *) NULL, *rsp;
XIconSize	sizelist[7], *sp;
int		cnt = 7;
int		i, v;

	resetvinf(VI_WIN);
	nextvinf(&vp);
	w = makewin(display, vp);

	for(i=0, sp=sizelist, v=0; i<cnt; i++, sp++) {
		sp->min_width = v++;
		sp->min_height = v++;
		sp->max_width = v++;
		sp->max_height = v++;
		sp->width_inc = v++;
		sp->height_inc = v++;
	}

	count = cnt;
	size_list = sizelist;
	XCALL;

	len = cnt * NumPropIconSizeElements;
	if(XGetWindowProperty(display, w, XA_WM_ICON_SIZE,
                            0L, len, False,
                            AnyPropertyType, &actual_type, &actual_format,
                            &nitems, &leftover, (unsigned char **) &rsizelist) != Success) {
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
		report("The format of the WM_ICON_SIZE property was %lu instead of 32", actual_format);
		FAIL;
	} else
		CHECK;

	if(actual_type != XA_WM_ICON_SIZE) {
		report("The type of the WM_ICON_SIZE property was %lu instead of WM_ICON_SIZE (%lu)", actual_type, (long) XA_WM_ICON_SIZE);
		FAIL;
	} else
		CHECK;

	if( rsizelist == (long *) NULL) {
		report("No value was obtained for the WM_ICON_SIZES property.");
		FAIL;
	} else {

		CHECK;
		if( nitems != len) {
			report("The WM_ICON_SIZES property comprised %ul elements instead of %d", nitems, cnt);
			FAIL;
		} else 
			if(actual_format == 32) {

				CHECK;
				for(i=0, rsp=rsizelist, v=0; i<cnt; i++) {
				
					if(*rsp++ != v++) {
						report("The min_width component of the XIconSize structure %d was %d instead of %d.", i, rsp[-1], v-1);
						FAIL;
					} else
						CHECK;
				
					if(*rsp++ != v++) {
						report("The min_height component of the XIconSize structure %d was %d instead of %d.", i, rsp[-1], v-1);
						FAIL;
					} else
						CHECK;
				
					if(*rsp++ != v++) {
						report("The max_width component of the XIconSize structure %d was %d instead of %d.", i, rsp[-1], v-1);
						FAIL;
					} else
						CHECK;
				
					if(*rsp++ != v++) {
						report("The max_height component of the XIconSize structure %d was %d instead of %d.", i, rsp[-1], v-1);
						FAIL;
					} else
						CHECK;
				
					if(*rsp++ != v++) {
						report("The width_inc component of the XIconSize structure %d was %d instead of %d.", i, rsp[-1], v-1);
						FAIL;
					} else
						CHECK;
				
					if(*rsp++ != v++) {
						report("The height_inc component of the XIconSize structure %d was %d instead of %d.", i, rsp[-1], v-1);
						FAIL;
					} else
						CHECK;
				}
				XFree( (char*) rsizelist);			
			}
	}

	CHECKPASS(6*cnt+6);

>>ASSERTION Bad B 1
.ER BadAlloc 
>>ASSERTION Bad A
.ER BadWindow 
>># Kieron	Action	Review
