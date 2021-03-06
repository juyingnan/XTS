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

Copyright (c) Applied Testing and Technology, Inc. 1995
All Rights Reserved.

>># Project: VSW5
>># 
>># File: xts5/Xlib7/XStoreNamedColor.m
>># 
>># Description:
>># 	Tests for XStoreNamedColor()
>># 
>># Modifications:
>># $Log: strnmdclr.m,v $
>># Revision 1.2  2005-11-03 08:43:44  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:31  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:27:01  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:45:20  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.1  1998/07/25 00:18:15  mar
>># req.4.W.00121: avoid undefined ANSI usage
>>#
>># Revision 6.0  1998/03/02 05:19:14  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:15:45  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 08:49:31  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  00:48:58  andy
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
>>TITLE XStoreNamedColor Xlib7
void
XStoreNamedColor(display, colormap, color, pixel, flags)
Display *display = Dsp;
Colormap colormap = DefaultColormap(display, DefaultScreen(display));
char *color = "";
unsigned long pixel;
int flags = DoRed|DoGreen|DoBlue;
>>ASSERTION Good C
>>#
>># TODO 					dave - Jan 17
>># The X11R4 spec is vague about whether it's the closest available or 
>># or the actual values that are stored. 
>># O'Reilly Vol one page 190 has a footnote saying the actual values 
>># you tried to store may not be stored.
>>#
If any of the visual classes DirectColor, PseudoColor or GrayScale is supported:
A call to xname obtains the closest available RGB values for the
.A colormap
argument  to those specified for the colour named
.A color
in the database, and stores those values in the read-write colourmap entry
specified by the
.M pixel
component of the
.S XColor
structure.
>>STRATEGY
For each visual class DirectColor, PseudoColor and GrayScale:
  Create a colormap with alloc set to AllocAll.
  Store the r,g and b colour values of XT_GOOD_COLOUR_NAME in the colourmap with XStoreNamedColor.
  Obtain the rbg values of the stored color with XQueryColor.
  Store those rgb values in the colormap with XStoreColor.
  Obtain the stored rgb values with XQueryColor.
  Verify the rgb values stored in the two cells are identical.
>>CODE
XVisualInfo *vp;
char *goodname;
XColor namedcol, testcol, storedcol;
unsigned long vmask = (1<<DirectColor)|(1<<PseudoColor)|(1<<GrayScale);

	if( (vmask = visualsupported(display, vmask)) == 0L) {
		UNSUPPORTED;
		return;
	}

	if((goodname = tet_getvar("XT_GOOD_COLORNAME")) == (char *) 0) {
		delete("XT_GOOD_COLORNAME is not defined.");
		return;
	}

	flags = DoRed|DoGreen|DoBlue;
	for(resetsupvis(vmask); nextsupvis(&vp); ) {
		trace("Attempting XStoreNamedColor() for class %s, color %s", displayclassname(vp->class), goodname);
		colormap = makecolmap(display, vp -> visual, AllocAll);
		color = goodname;
		pixel = 0L;

		XCALL;

		namedcol.pixel = 0L;
		XQueryColor(display, colormap, &namedcol);
		testcol = namedcol;
		testcol.pixel = 1L;
		testcol.flags = flags;
		XStoreColor(display, colormap, &testcol);
		storedcol.pixel = 1L;
		storedcol.flags = flags;
		XQueryColor(display, colormap, &storedcol);

		trace("Named Color : pixel %lu, r %u g %u b %u", namedcol.pixel , namedcol.red, namedcol.green, namedcol.blue);
		trace("Stored Color: pixel %lu, r %u g %u b %u", storedcol.pixel, storedcol.red, storedcol.green, storedcol.blue);


		if( (namedcol.red != storedcol.red) || (namedcol.green != storedcol.green) || (namedcol.blue != storedcol.blue) ) {
			report("XStoreNamedColor() return RGB values r %u g %u b %u instead of r %u g %u b %u.", 
				namedcol.red, namedcol.green, namedcol.blue, storedcol.red, storedcol.green, storedcol.blue);
				FAIL;
		} else
			CHECK;
	}

	CHECKPASS(nsupvis());


>>ASSERTION Good A
If any of the visual classes DirectColor, PseudoColor or GrayScale is supported:
A call to xname changes the red, green and blue values
in the read-write colourmap entry in accordance with the 
.A flags
argument.
>>STRATEGY
For each supported visual class DirectColor, PseudoColor and GrayScale:
  Create a colormap with XCreateColormap.
  Store XT_GOOD_COLOR_NAME r, g and b values in cell 0 with XStoreNamedColor.
  Obtain the r,g and b values with XQueryColor.
  Complement the rgb values and store the value in cell 0 with XStoreColor.
  Obtain the bitwise complemented rgb values using XQueryColor.
  For each possible combination DoRed, DoGreen and DoBlue in flags:
    Store the bitwise complementary rgb values in the same cell with XStoreColor.
    Store the XT_GOOD_COLOR_NAME values in the colourmap cell using XStoreNamedColor.
    Verify that only the components of the colourcell specified by the flags value have been altered with XQueryColor.
>>CODE
XVisualInfo *vp;
int 		i;
char 		*goodname;
XColor		namedcol, testcol, storedcol;
unsigned long 	vmask = (1<<DirectColor)|(1<<PseudoColor)|(1<<GrayScale);
unsigned short	redval, greenval, blueval;


	if( (vmask = visualsupported(display, vmask)) == 0L) {
		UNSUPPORTED;
		return;
	}

	if((goodname = tet_getvar("XT_GOOD_COLORNAME")) == (char *) 0) {
		delete("XT_GOOD_COLORNAME is not defined.");
		return;
	}

	color = goodname;
	pixel = 0L;
	storedcol.pixel = 0L;
	testcol.pixel = 0L;
	namedcol.pixel = 0L;

	for(resetsupvis(vmask); nextsupvis(&vp); ) {
		trace("Attempting XStoreNamedColor() for class %s, color %s", displayclassname(vp->class), goodname);
		colormap = makecolmap(display, vp -> visual, AllocAll);
		flags = DoRed|DoGreen|DoBlue;
		XCALL;
		XQueryColor(display, colormap, &namedcol);

		testcol = namedcol;
		testcol.red ^= 0xffff;
		testcol.green ^= 0xffff;
		testcol.blue ^= 0xffff;
		testcol.flags = DoRed | DoGreen | DoBlue;

		XStoreColor(display, colormap, &testcol);
		XQueryColor(display, colormap, &testcol);

		for(i=0; i<8; i++) {

			flags = 0;

			if(i&DoRed) {
				flags |= DoRed;
				redval = namedcol.red;
			} else
				redval = testcol.red;

			if(i&DoGreen) {
				flags |= DoGreen;
				greenval = namedcol.green;
			} else
				greenval = testcol.green;

			if(i&DoBlue) {
				flags |= DoBlue;
				blueval = namedcol.blue;
			} else
				blueval = testcol.blue;

			XStoreColor(display, colormap, &testcol);
			XCALL;
			XQueryColor(display, colormap, &storedcol);

			if( (redval != storedcol.red) || (greenval != storedcol.green) || (blueval != storedcol.blue) ){
				report("XStoreNamedColor() RGB value r %u g %u b %u instead of r %u g %u b %u.", 
					storedcol.red, storedcol.green, storedcol.blue, redval, greenval, blueval);
				FAIL;
				}
		}

		if(i == 8)
			CHECK;
	}

	CHECKPASS(nsupvis());

>>ASSERTION Good A
If any of the visual classes DirectColor, PseudoColor or GrayScale is supported:
Upper and lower case characters in the
.A color
argument refer to the same color.
>>STRATEGY
For each supported visual class:
  Create a colomap with alloc set to AllocAll.
  Store colour XT_GOOD_COLOR_NAME in the colourmap with XStoreNamedColor.
  Obtain the stored rgb values with XQueryColor,
  Store colour XT_GOOD_COLOR_NAME  with alternating characters in alternating case with XStoreNamedColor.
  Verify that the rgb values written by both calls was identical.
>>CODE
XVisualInfo *vp;
char *cp, *goodname, *casename;
XColor casecol, testcol;
unsigned long vmask = (1<<DirectColor)|(1<<PseudoColor)|(1<<GrayScale);
int		i;

	if( (vmask = visualsupported(display, vmask)) == 0L) {
		UNSUPPORTED;
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


	testcol.pixel = 0L;
	casecol.pixel = 0L;
	pixel = 0L;
	flags = DoRed|DoGreen|DoBlue;

	for(resetsupvis(vmask); nextsupvis(&vp); ) {

		colormap = makecolmap(display, vp -> visual, AllocAll);
		color = goodname;

		XCALL;
			
		XQueryColor(display, colormap, &testcol);

	
		color = casename;
		trace("Testing colourname %s", color);
		
		XCALL;
		
		XQueryColor(display, colormap, &casecol);

		if((casecol.pixel != testcol.pixel) || (casecol.red != testcol.red) || (casecol.green != testcol.green) || (casecol.blue != testcol.blue)) {
			report("Colour name %s pixel %lu ( r %u g %u b %u) instead of pixel %lu ( r %u g %u b %u)",
				goodname, casecol.pixel, casecol.red, casecol.green, casecol.blue,
					  testcol.pixel, testcol.red, testcol.green, testcol.blue);
			FAIL;
		} else
			CHECK;

	}
	CHECKPASS(nsupvis());


>>ASSERTION Bad A
If any of the visual classes DirectColor, PseudoColor or GrayScale is supported:
When the
.A pixel
argument is not a valid entry in the
.A colormap
argument,
then a
.S BadValue 
error occurs.
>>STRATEGY
For each visual class DirectColor, PseudoColor and GrayScale:
  Create a colourmap with alloc set to AllocAll.
  Store the colour XT_GOOD_COLOR_NAME at pixel = colourmap_size with XStoreNamedColor.
  Verify that a BadValue error is generated.
>>CODE BadValue
XVisualInfo *vp;
char *goodname;
unsigned long vmask = (1<<DirectColor)|(1<<PseudoColor)|(1<<GrayScale);

	if( (vmask = visualsupported(display, vmask)) == 0L) {
		UNSUPPORTED;
		return;
	}

	if((goodname = tet_getvar("XT_GOOD_COLORNAME")) == (char *) 0) {
		delete("XT_GOOD_COLORNAME is not defined.");
		return;
	}

	flags = DoRed|DoGreen|DoBlue;
	for(resetsupvis(vmask); nextsupvis(&vp); ) {
		trace("Attempting XStoreNamedColor() for class %s, color %s", displayclassname(vp->class), goodname);
		colormap = makecolmap(display, vp -> visual, AllocAll);
		color = goodname;
		pixel = maxsize(vp) + 1;
		if (vp->class == DirectColor) {
			pixel = (vp->red_mask | vp->green_mask | vp->blue_mask);
			pixel |= pixel << 1;
		}
		trace("Pixel set to %ld", pixel);
		XCALL;
		if(geterr() == BadValue)
			CHECK;
	}

	CHECKPASS(nsupvis());

>>ASSERTION Bad A
.ER BadAccess colormap-store
>>STRATEGY
For each visual class DirectColor, PseudoColor and GrayScale:
  Create a colormap (r/o) with alloc set to AllocNone.
  Store the color XT_GOOD_COLORNAME with XStoreNamedColor
  Verify that a BadAccess error is generated.
  Create a new client with XOpenDisplay.
  Allocate a full red readonly cell for the new client with XAllocColor.
  Store the color XT_GOOD_COLORNAME with XStoreNamedColor.
  Verify that a BadAccess error occurred.
  Allocate another readonly cell with XAllocColor.
  Store the color XT_GOOD_COLORNAME with XStoreNamedColor.
  Verify that a BadAccess error occurred.
>>CODE BadAccess
XVisualInfo	*vp;
XColor		testcol;
char 		*goodname;
Display		*disp2;
unsigned long vmask = (1<<DirectColor)|(1<<PseudoColor)|(1<<GrayScale);

	if( (vmask = visualsupported(display, vmask)) == 0L) {
		UNSUPPORTED;
		return;
	}

	if((goodname = tet_getvar("XT_GOOD_COLORNAME")) == (char *) 0) {
		delete("XT_GOOD_COLORNAME is not defined.");
		return;
	}

	color = goodname;
	for(resetsupvis(vmask); nextsupvis(&vp); ) {		

		pixel = 0L;
		colormap = makecolmap(display, vp->visual, AllocNone);
		trace("Testing a colormap with no allocated cells.");
		XCALL;

		if(geterr() == BadAccess)
			CHECK;

		disp2 = opendisplay();

		testcol.flags = DoRed;
		testcol.red = 65535;
		if(XAllocColor(disp2, colormap, &testcol) == False) {
			delete("XAllocColor() failed to allocate a full red r/o cell for a second client.");
			return;
		} else
			CHECK;

		trace("Trying to write into a r/o cell allocated by another client.");
		pixel = testcol.pixel;
		XCALL;
		if(geterr() == BadAccess)
			CHECK;

		testcol.red ^= 0xffff;
		testcol.green ^= 0xffff;
		testcol.blue ^= 0xffff;
		testcol.flags = flags;

		if(XAllocColor(display, colormap, &testcol) == False) {
			delete("XAllocColor() failed to allocate a r/o cell with r,g,b = 0x%x,0x%x,0x%x", testcol.red, testcol.green, testcol.blue);
			return;
		} else
			CHECK;

		trace("Trying to write into a r/o cell allocated by self.");
		pixel = testcol.pixel;
		XCALL;

		if(geterr() == BadAccess)
			CHECK;
	}

	CHECKPASS(5*nsupvis());

>>ASSERTION Bad A
.ER BadColor
>>ASSERTION Bad A
.ER BadName colour
>>STRATEGY
For the visual classes DirectColor, PseudoColor and GrayScale :
  Create a colormap with alloc set to AllocAll.
  Allocate a cell with colour XT_BAD_COLORNAME 
    in the colourmap with XStoreNamedColor.
  Verify that a BadName error occurred.
>>CODE BadName
XVisualInfo *vp;
char *badname;
unsigned long vmask = (1<<DirectColor)|(1<<PseudoColor)|(1<<GrayScale);

	if( (vmask = visualsupported(display, vmask)) == 0L) {
		unsupported("DirectColor, PseudoColor visual classes are not supported.");
		return;
	}

	if( (badname = tet_getvar("XT_BAD_COLORNAME")) == (char *) 0) {
		delete("XT_BAD_COLORNAME is not defined.");
		return;
	}

	for(resetsupvis(vmask); nextsupvis(&vp); ) {
		colormap = makecolmap(display, vp -> visual, AllocAll);
		color = badname;		
		XCALL;		
		if(geterr() == BadName)
			CHECK;
	}

	CHECKPASS(nsupvis());

>>ASSERTION Good D 3
When
.A rmask_return ,
.A gmask_return
and
.A bmask_return
have been returned by
a previous call to
.S XAllocColorPlanes
and  a read-write colourmap entry
for a pixel value is changed by a call to xname,  then the pixel value
is decomposed   into   three   components using   the   masks and  the
independent colourmap entries are updated.
>>ASSERTION Good D 3
If the visual class
.S DirectColor
is supported:
When the
.A colormap
argument was created with visual type
.S DirectColor
and with
.A alloc
set to
.S AllocAll ,
and a read-write colourmap entry for a pixel value is changed by a call to xname, then
the pixel value is decomposed into three components using the
.S red_mask ,
.S green_mask
and
.S blue_mask
in the visual and the independent colourmap entries are updated.
>>#HISTORY	Cal	Completed	Written in new format and style.
>>#HISTORY	Kieron	Completed		<Have a look>
>>#HISTORY	Cal	Completed		Writing code.
>>#HISTORY	Kieron	Completed		Bug-fixes and re-engineering
