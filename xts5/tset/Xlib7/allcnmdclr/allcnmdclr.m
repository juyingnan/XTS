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
$Header: /cvs/xtest/xtest/xts5/tset/Xlib7/allcnmdclr/allcnmdclr.m,v 1.1 2005-02-12 14:37:35 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1995
All Rights Reserved.

>># Project: VSW5
>># 
>># File: vsw5/tset/Xlib7/allcnmdclr/allcnmdclr.m
>># 
>># Description:
>># 	Tests for XAllocNamedColor()
>># 
>># Modifications:
>># $Log: allcnmdclr.m,v $
>># Revision 1.1  2005-02-12 14:37:35  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:26:56  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:45:14  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.1  1998/07/25 00:17:31  mar
>># req.4.W.00121: avoid undefined ANSI usage
>>#
>># Revision 6.0  1998/03/02 05:19:09  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:15:40  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 08:49:11  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  00:48:22  andy
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
>>TITLE XAllocNamedColor Xlib7
Status
XAllocNamedColor(display, colormap, color_name, screen_def_return, exact_def_return)
Display *display = Dsp;
Colormap colormap = DefaultColormap(display, DefaultScreen(display));
char *color_name = "";
XColor *screen_def_return = &dummycol;
XColor *exact_def_return = &dummycol;
>>EXTERN
XColor dummycol;
>>ASSERTION Good A
A call to xname 
allocates a read-only entry in the
.A colormap
argument
corresponding to the named colour specified by the
.A color_name
argument and 
returns the exact RGB values in the
.M red ,
.M green ,
and
.M blue
components in the
.S XColor
structure named by the 
.A exact_def_return
argument,
returns the closest colour supported by the screen with which the
.A colormap
argument is associated in the
.M red ,
.M green ,
and
.M blue
components in the
.S XColor
structure named by the 
.A screen_def_return
argument
and returns the colourmap entry in the
.M pixel
component in the 
.S XColor
structure named by the 
.A screen_def_return
argument.
>>STRATEGY
For each supported visual type:
  Create a colourmap with alloc set to AllocNone.
  Allocate a read/only cell with colour XT_GOOD_COLORNAME 
    in the colourmap with XAllocNamedColor.
  Verify that the function returned non-zero.
  Allocate a read/only cell using returned RGB values with XAllocColor 
    (which is assumed to return correct RGB values) .
  Verify that the pixel value and the RBG values from both calls are identical.
    (so XAllocNamedColor previously returned correct RGB values)
>>CODE
XVisualInfo *vp;
char *goodname;
Status status;
XColor screencol, exactcol, testcol;
unsigned long vmask;
unsigned short trunc;

	if( (vmask = visualsupported(display, 0L)) == 0L) {
		delete("No visuals reported as valid.");
		return;
	}

	if( (goodname = tet_getvar("XT_GOOD_COLORNAME")) == (char *) 0) {
		delete("XT_GOOD_COLORNAME is not defined.");
		return;
	}

	for(resetsupvis(vmask); nextsupvis(&vp); ) {
		trace("Attempting XAllocNamedColor() for class %s, color %s", displayclassname(vp->class), goodname);
		colormap = makecolmap(display, vp -> visual, AllocNone);
		color_name = goodname;		
		screen_def_return = &screencol;
		exact_def_return = &exactcol;
		status = XCALL;

		if( status == (Status) 0) {
			report("%s failed to return non-zero.", TestName);
			FAIL;
			continue;
		} else
			CHECK;

		testcol = screencol;
		trace("Screen: pixel %lu, r %u g %u b %u", screencol.pixel , screencol.red, screencol.green, screencol.blue);
		trace("Exact : pixel %lu, r %u g %u b %u", exactcol.pixel, exactcol.red, exactcol.green, exactcol.blue);
		trace("Test : pixel %lu, r %u g %u b %u", testcol.pixel, testcol.red, testcol.green, testcol.blue);

		status = XAllocColor(display, colormap, &testcol);
		if(status == (Status) 0) {
			report("XAllocColor() failed to return non-zero.");
			FAIL;
			continue;
		} else
			CHECK;

		trace("Exact : pixel %lu, r %u g %u b %u", exactcol.pixel, exactcol.red, exactcol.green, exactcol.blue);

		if( screencol.pixel != testcol.pixel ) {
			report("%s return pixel value %lu instead of %lu.", 
				TestName, screencol.pixel, testcol.pixel);
			FAIL;
		} else
			CHECK;

		if((screencol.red != testcol.red) ||
		   (screencol.green != testcol.green) ||
	 	   (screencol.blue != testcol.blue) ) {
			report("%s return RGB values r %u g %u b %u instead of r %u g %u b %u.", 
				TestName,
				screencol.red, screencol.green, screencol.blue,
				testcol.red, testcol.green, testcol.blue);
			FAIL;
		} else
			CHECK;
	}

	CHECKPASS(4 * nsupvis());

>>ASSERTION Good A
When the 
.A color_name
argument refers to a colour in the colour database, then xname
returns non-zero.
>>STRATEGY
For each supported visual type:
  Create a colourmap with alloc set to AllocNone.
  Allocate a read/only cell with colour XT_GOOD_COLORNAME 
    in the colourmap with XAllocNamedColor.
  Verify that the function returned non-zero.
>>CODE
XVisualInfo *vp;
char *goodname;
Status status;
XColor screencol, exactcol, testcol;
unsigned long vmask;
unsigned short trunc;

	if( (vmask = visualsupported(display, 0L)) == 0L) {
		delete("No visuals reported as valid.");
		return;
	}

	if( (goodname = tet_getvar("XT_GOOD_COLORNAME")) == (char *) 0) {
		delete("XT_GOOD_COLORNAME is not defined.");
		return;
	}

	for(resetsupvis(vmask); nextsupvis(&vp); ) {
		trace("Attempting XAllocNamedColor() for class %s, color %s", displayclassname(vp->class), goodname);
		colormap = makecolmap(display, vp -> visual, AllocNone);
		color_name = goodname;		
		screen_def_return = &screencol;
		exact_def_return = &exactcol;
		status = XCALL;
		if( status == (Status) 0) {
			report("%s failed to return non-zero with color %s.", 
				TestName, goodname);
			FAIL;
		} else 
			CHECK;
	}

	CHECKPASS(nsupvis());

>>ASSERTION Good A
When the
.A color_name
argument does not refer to a colour in the colour database, then xname
returns zero.
>>STRATEGY
For each supported visual type:
  Create a colomap with alloc set to AllocNone.
  Allocate a read/only cell with colour XT_BAD_COLORNAME 
    in the colourmap with XAllocNamedColor.
  Verify that the function returned zero.
>>CODE
XVisualInfo *vp;
char *badname;
Status status;
XColor screencol, exactcol, testcol;
unsigned long vmask;
unsigned short trunc;

	if( (vmask = visualsupported(display, 0L)) == 0L) {
		delete("No visuals reported as valid.");
		return;
	}

	if( (badname = tet_getvar("XT_BAD_COLORNAME")) == (char *) 0) {
		delete("XT_BAD_COLORNAME is not defined.");
		return;
	}

	for(resetsupvis(vmask); nextsupvis(&vp); ) {
		trace("Attempting XAllocNamedColor() for class %s, color %s", displayclassname(vp->class), badname);
		colormap = makecolmap(display, vp -> visual, AllocNone);
		color_name = badname;		
		screen_def_return = &screencol;
		exact_def_return = &exactcol;
		status = XCALL;
		if( status != (Status) 0) {
			report("%s failed to return zero with color %s.", 
				TestName, badname);
			FAIL;
		} else 
			CHECK;
	}

	CHECKPASS(nsupvis());


>>ASSERTION Good A
Upper and lower case characters in the
.A color_name
argument refer to the same colour.
>>STRATEGY
For each supported visual type:
  Create a colomap with alloc set to AllocNone.
  Allocate a read/only cell with colour name XT_GOOD_COLORNAME 
    in the colourmap with XAllocNamedColor.
  Allocate a read/only cell with colour name XT_GOOD_COLORNAME, 
    with alternate characters in alternating case,
    in the colourmap with XAllocNamedColor.
  Verify that the function returned non-zero.
  Verify that the exact and closest supported rbg values from both calls 
    are identical.
  Verify that the pixel value of the cell allocated by both calls 
    is the same.
>>CODE
XVisualInfo *vp;
char *cp, *goodname, *casename;
Status status;
XColor screencol, exactcol, alscreencol, alexactcol;
unsigned long vmask;
unsigned short trunc;
int i;

	if( (vmask = visualsupported(display, 0L)) == 0L) {
		delete("No visuals reported as valid.");
		return;
	}

	if( (goodname = tet_getvar("XT_GOOD_COLORNAME")) == (char *) 0) {
		delete("XT_GOOD_COLORNAME is not defined.");
		return;
	}

	casename = (char *) malloc( strlen(goodname) + 1);
	strcpy(casename, goodname);

	for(i=0, cp=casename; *cp; i++, cp++)
		if(i&1)
			*cp = tolower(*cp);
		else
			*cp = toupper(*cp);


	for(resetsupvis(vmask); nextsupvis(&vp); ) {
		trace("Attempting XAllocNamedColor() for class %s, color %s", displayclassname(vp->class), goodname);
		colormap = makecolmap(display, vp -> visual, AllocNone);
		color_name = goodname;		
		screen_def_return = &screencol;
		exact_def_return = &exactcol;
		status = XCALL;

		if( status == (Status) 0) {
			report("%s failed to return non-zero with color %s.", 
				TestName, goodname);
			FAIL;
			continue;
		} else
			CHECK;
			
		color_name = casename;
		trace("Testing colourname %s", color_name);
		screen_def_return = &alscreencol;
		exact_def_return = &alexactcol;
		status = XCALL;

		if( status == (Status) 0) {
			report("%s failed to return non-zero with color %s.", 
				TestName, casename);
			FAIL;
			continue;
		} else 
			CHECK;

		if(screencol.pixel != alscreencol.pixel) {
			report("%s for name %s", TestName, casename);
			report("returned pixel value %lu", alscreencol.pixel);
			report("%s for name %s", TestName, goodname);
			report("returned pixel value %lu", screencol.pixel);
			FAIL;
		} else
			CHECK;

		if((exactcol.red != alexactcol.red) ||
		   (exactcol.green != alexactcol.green) ||
		   (exactcol.blue != alexactcol.blue)) {
			report("%s for name %s", TestName, casename);
			report("returned exact RGB values r %u g %u b %u",
			  alexactcol.red, alexactcol.green, alexactcol.blue);
			report("%s for name %s", TestName, goodname);
			report("returned exact RGB values r %u g %u b %u",
			  exactcol.red, exactcol.green, exactcol.blue);
			FAIL;
		} else
			CHECK;

		if((screencol.red != alscreencol.red) ||
		   (screencol.green != alscreencol.green) ||
		   (screencol.blue != alscreencol.blue)) {
			report("%s for name %s", TestName, casename);
			report("returned closest RGB values r %u g %u b %u",
			  alscreencol.red, alscreencol.green, alscreencol.blue);
			report("%s for name %s", TestName, goodname);
			report("returned closest RGB values r %u g %u b %u",
			  screencol.red, screencol.green, screencol.blue);
			FAIL;
		} else
			CHECK;
	}

	free(casename);
	CHECKPASS(5 * nsupvis());

>>ASSERTION Bad A
.ER BadColor
>>ASSERTION Bad B 1
.ER Alloc
>>#HISTORY	Cal	Completed	Written in new format and style.
>>#HISTORY	Kieron	Completed		<Have a look>
>>#HISTORY	Cal	Action		Writting code.
