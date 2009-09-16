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

>># Project: VSW5
>># 
>># File: xts5/Xopen/XLookupColor/XLookupColor.m
>># 
>># Description:
>># 	Tests for XLookupColor()
>># 
>># Modifications:
>># $Log: lkpclr.m,v $
>># Revision 1.2  2005-11-03 08:44:00  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:40  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:35:52  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:58:34  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:27:05  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:23:39  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:14:27  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:17:52  andy
>># Prepare for GA Release
>>#
/*
 *      SCCS:  @(#)  lkpclr.m Rel 1.10	    (12/10/91)
 *
 *	UniSoft Ltd., London, England
 *
 * (C) Copyright 1991 X/Open Company Limited
 *
 * All rights reserved.  No part of this source code may be reproduced,
 * stored in a retrieval system, or transmitted, in any form or by any
 * means, electronic, mechanical, photocopying, recording or otherwise,
 * except as stated in the end-user licence agreement, without the prior
 * permission of the copyright owners.
 *
 * X/Open and the 'X' symbol are trademarks of X/Open Company Limited in
 * the UK and other countries.
 */
>>TITLE XLookupColor Xopen
Status
LookupColor(display, colormap, color_name, exact_def_return, screen_def_return)
Display *display = Dsp;
Colormap colormap = DefaultColormap(display, DefaultScreen(display));
char *color_name = "";
XColor *exact_def_return = &dummycol;
XColor *screen_def_return = &dummycol;
>>EXTERN

XColor dummycol;

static char *convertname(s)
char *s;
{
	char *res;
	char *rp;
	char *cp = s;
	int  len = strlen(s);

	if(s == (char *) NULL)
		return((char *) NULL);

	if((res = rp = (char*) malloc(len + 1)) == (char *) NULL) {
		delete("Malloc returned NULL.");
		return((char *) NULL);
	}

	while(*cp == ' ')
		cp++;
		
	*rp++ = toupper(*cp++);
	while(*cp) {
		if(*cp == ' ') {
			while(*cp == ' ')
				cp++;
			if(*cp)
				*rp++ = toupper(*cp++);
		} else
			*rp++ = *cp++;
	}

	*rp = '\0';
	return(res);
}

>>ASSERTION Good A
When a colour name in the table is recognised on a call to xname,
then all other colour names on the same line of the table 
are also recognised on another call to xname
using the same
.A display
and
.A colormap ,
and the same values are returned by each call to xname in the
.M red ,
.M green
and
.M blue
components of the
.S XColor
structures named by the
.A exact_def_return
argument and
.A screen_def_return
arguments.
.tL "Set" "Color name(s)"
.tL "M" "gray" "grey"
.tL "M" "dark gray" "dark grey"
.tL "X" "dark slate gray" "dark slate grey"
.tL "X" "dim gray" "dim grey"
.tL "X" "light gray" "light grey"
>>STRATEGY
For each supported visual type:
  Create a colourmap of that type using XCreateColormap.
  For each equivalent colour name:
    Obtain the rgb values for the colour.
    Verify that the exact rgb values are identical.
    Verify that the supported rbg values are identical.
>>CODE
int		i;
int		firstunsupported;
int		secondunsupported;
XVisualInfo 	*vp;
Status		status;
XColor 		exactcol, screencol;
XColor 		exactcol2, screencol2;
unsigned long 	vmask;
static char	*p[5][2] = 
	{{ "gray", "grey"},
	 { "dark gray", "dark grey"},
	 { "dark slate gray", "dark slate grey"},
	 { "dim gray", "dim grey"},
	 { "light gray", "light grey"}};

	if( (vmask = visualsupported(display, 0L)) == 0L) {
		delete("No visuals reported as valid.");
		return;
	} else
		CHECK;

	for(resetsupvis(vmask); nextsupvis(&vp); ) {

		colormap = makecolmap(display, vp->visual, AllocNone);
		for(i=0; i< NELEM(p); i++) {

			firstunsupported = secondunsupported = 0;
			trace("Compare \"%s\" against \"%s\".", p[i][0], p[i][1]);

			exact_def_return = &exactcol;
			screen_def_return = &screencol;
			color_name= p[i][0];
		
			status = XCALL;
	
			if( status == (Status) 0) {
				trace("Colour \"%s\" is not supported.", color_name);
				firstunsupported = 1;
			}

			exact_def_return = &exactcol2;
			screen_def_return = &screencol2;
			color_name= p[i][1];

			status = XCALL;
	
			if( status == (Status) 0) {
				trace("Colour \"%s\" is not supported.", color_name);
				secondunsupported = 1;
			}

			if(firstunsupported && secondunsupported) {
				CHECK;
				CHECK;				
				CHECK;
				continue;
			}

			if(firstunsupported && !secondunsupported) {
				report("Colour %s is unsupported.", p[i][0]);
				report("Colour %s is supported.", p[i][1]);
				FAIL;
			} else if(!firstunsupported && secondunsupported) {
				report("Colour %s is unsupported.", p[i][1]);
				report("Colour %s is supported.", p[i][0]);
				FAIL;
			} else {
				CHECK;

				if((exactcol2.red != exactcol.red) ||
				   (exactcol2.green != exactcol.green) ||
			 	   (exactcol2.blue != exactcol.blue) ) {
					report("Colour names \"%s\" and \"%s\" do not yield the same exact rgb values.",
						p[i][0], p[i][1]);
					report("( r %u g %u b %u instead of r %u g %u b %u respectively.)", 
						exactcol.red, exactcol.green, exactcol.blue,
						exactcol2.red, exactcol2.green, exactcol2.blue);
					FAIL;
				} else
					CHECK;
	
				if((screencol2.red != screencol.red) ||
				   (screencol2.green != screencol.green) ||
			 	   (screencol2.blue != screencol.blue) ) {
					report("Colour names \"%s\" and \"%s\" do not yield the same supported rgb values.",
						p[i][0], p[i][1]);
					report("( r %u g %u b %u instead of r %u g %u b %u respectively.)", 
						screencol.red, screencol.green, screencol.blue,
						screencol2.red, screencol2.green, screencol2.blue);
					FAIL;
				} else
					CHECK;
			}

		}
	}

	CHECKPASS(1 + 3 * nsupvis() * NELEM(p) );

>>ASSERTION  Good A
When a colour name in the table is recognised on a call to xname,
and a colour name on a different line of the table 
is also recognised on another call to xname
using the same
.A display
and
.A colormap ,
then distinct values are returned by each call to xname in the
.M red ,
.M green
and
.M blue
components of the
.S XColor
structures named by the
.A exact_def_return
argument and
.A screen_def_return
arguments.
.tL "Set" "Color name(s)"
.tL "A" "black"
.tL "A" "white"
.tL "C" "blue"
.tL "C" "cyan"
.tL "C" "green"
.tL "C" "magenta"
.tL "C" "red"
.tL "C" "yellow"
.tL "M" "gray" "grey"
.tL "M" "dark gray" "dark grey"
.tL "V" "dark blue"
.tL "V" "brown"
.tL "V" "dark cyan"
.tL "V" "dark green"
.tL "V" "dark magenta"
.tL "V" "dark red"
.tL "X" "medium blue"
.tL "X" "midnight blue"
.tL "X" "navy blue"
.tL "X" "sky blue"
.tL "X" "coral"
.tL "X" "gold"
.tL "X" "dark slate gray" "dark slate grey"
.tL "X" "dim gray" "dim grey"
.tL "X" "light gray" "light grey"
.tL "X" "light green"
.tL "X" "forest green"
.tL "X" "lime green"
.tL "X" "pale green"
.tL "X" "spring green"
.tL "X" "maroon"
.tL "X" "orange"
.tL "X" "pink"
.tL "X" "indian red"
.tL "X" "orange red"
.tL "X" "violet red"
.tL "X" "salmon"
.tL "X" "sienna"
.tL "X" "tan"
.tL "X" "turquoise"
.tL "X" "violet"
.tL "X" "blue violet"
.tL "X" "wheat"
>>STRATEGY
For each supported visual:
  Create a colourmap of that type using XCreateColormap.
  For each pair of colour names in the table:
    Obtain the rgb values corresponding to the name using xname.
    Verify that the rgb triples are different.
>>EXTERN
static int
compare(col1, col2, name1, name2, eflag)
XColor	*col1;
XColor	*col2;
char	*name1;
char	*name2;
int	eflag;
{

	if((col2->red == col1->red) &&
	   (col2->green == col1->green) &&
 	   (col2->blue == col1->blue) ) {
		report("Colour names \"%s\" and \"%s\" yield the same %s rgb values.",
			name1, name2, eflag ? "exact" : "supported");
		trace("%s = r %u g %u b %u,  %s = r %u g %u b %u",
		name1, col1->red, col1->green, col1->blue,
		name2, col2->red, col2->green, col2->blue);
		return(0);
	} 
	return(1);
}	
>>CODE
XColor		scols[43];
XColor		ecols[43];
XColor		scols2[5];
XColor		ecols2[5];
Status		status;
int		i, j;
unsigned long	vmask;
XVisualInfo	*vp;
static char	*list[43] = {
				"gray",
				"dark gray",
				"dark slate gray",
				"dim gray",
				"light gray",
				"black",
				"white",
				"blue",
				"cyan",
				"green",
				"magenta",
				"red",
				"yellow",
				"dark blue",
				"brown",
				"dark cyan",
				"dark green",
				"dark magenta",
				"dark red",
				"medium blue",
				"midnight blue",
				"navy blue",
				"sky blue",
				"coral",
				"gold",
				"light green",
				"forest green",
				"lime green",
				"pale green",
				"spring green",
				"maroon",
				"orange",
				"pink",
				"indian red",
				"orange red",
				"violet red",
				"salmon",
				"sienna",
				"tan",
				"turquoise",
				"violet",
				"blue violet",
				"wheat"};
static char	*list2[5] = {
				"grey",
				"dark grey",
				"dark slate grey",
				"dim grey",
				"light grey"};

	if( (vmask = visualsupported(display, 0L)) == 0L) {
		delete("No visuals reported as valid.");
		return;
	} else
		CHECK;

	for(resetsupvis(vmask); nextsupvis(&vp); ) {

		colormap = makecolmap(display, vp->visual, AllocNone);
		for(i=0; i<NELEM(list); i++) {

			color_name = list[i];
			exact_def_return = &ecols[i];
			screen_def_return = &scols[i];
	
			status = XCALL;
	
			if(status == 0) {
				trace("Colour \"%s\" is not supported.", color_name);
				ecols[i].flags = 0;
			} else {
				ecols[i].flags = 1;
			}
	
			if(i==0)
				CHECK;
		}

		/*
		 * test all pairs of colours -   n!
		 *			     2!(n-2)!
		 */
		for(i=0; i<NELEM(list)-1; i++) {
			for(j=i+1; j<NELEM(list); j++) {
				if((ecols[i].flags) && (ecols[j].flags)) {
					if(compare(&ecols[i], &ecols[j], list[i], list[j], 1) == 0)
						FAIL;
					if(compare(&scols[i], &scols[j], list[i], list[j], 0) == 0)
						FAIL;
				}
			}
					
			if(i==0)
				CHECK;
		}

		for(i=0; i<NELEM(list2); i++) {

			color_name = list2[i];
			exact_def_return = &ecols2[i];
			screen_def_return = &scols2[i];
	
			status = XCALL;
	
			if(status == 0) {
				trace("Colour \"%s\" is not supported.", color_name);
				ecols2[i].flags = 0;
			} else {
				ecols2[i].flags = 1;
			}
	
			if(i==0)
				CHECK;
		}

		for(i=0; i<NELEM(list2)-1; i++) {
			for(j=i+5; j<NELEM(list); j++) {
				if((ecols2[i].flags) && (ecols[j].flags)) {
					if(compare(&ecols2[i], &ecols[j], list2[i], list[j], 1) == 0)
						FAIL;
					if(compare(&scols2[i], &scols[j], list2[i], list[j], 0) == 0)
						FAIL;
				}
			}
					
			if(i==0)
				CHECK;

		}
	}

	CHECKPASS(1 + nsupvis() * 4);

>>ASSERTION  Good A
When a colour name in the table is recognised on a call to xname,
then the colour name with the first letter of each word in upper-case
and with no spaces between words 
is also recognised on another call to xname
using the same
.A display
and
.A colormap ,
and the same values are returned by each call to xname in the
.M red ,
.M green
and
.M blue
components of the
.S XColor
structures named by the
.A exact_def_return
argument and
.A screen_def_return
arguments.
.tL "Set" "Color name(s)"
.tL "A" "black"
.tL "A" "white"
.tL "C" "blue"
.tL "C" "cyan"
.tL "C" "green"
.tL "C" "magenta"
.tL "C" "red"
.tL "C" "yellow"
.tL "M" "gray" "grey"
.tL "M" "dark gray" "dark grey"
.tL "V" "dark blue"
.tL "V" "brown"
.tL "V" "dark cyan"
.tL "V" "dark green"
.tL "V" "dark magenta"
.tL "V" "dark red"
.tL "X" "medium blue"
.tL "X" "midnight blue"
.tL "X" "navy blue"
.tL "X" "sky blue"
.tL "X" "coral"
.tL "X" "gold"
.tL "X" "dark slate gray" "dark slate grey"
.tL "X" "dim gray" "dim grey"
.tL "X" "light gray" "light grey"
.tL "X" "light green"
.tL "X" "forest green"
.tL "X" "lime green"
.tL "X" "pale green"
.tL "X" "spring green"
.tL "X" "maroon"
.tL "X" "orange"
.tL "X" "pink"
.tL "X" "indian red"
.tL "X" "orange red"
.tL "X" "violet red"
.tL "X" "salmon"
.tL "X" "sienna"
.tL "X" "tan"
.tL "X" "turquoise"
.tL "X" "violet"
.tL "X" "blue violet"
.tL "X" "wheat"
>>STRATEGY
For each supported visual type:
  Create a colourmap of that type using XCreateColormap.
  For each equivalent colour name:
    Obtain the rgb values for the colour.
    Verify that the exact rgb values are identical.
    Verify that the supported rbg values are identical.
>>CODE
int		i;
XVisualInfo	*vp;
Status		status;
XColor 		exactcol, screencol;
XColor 		exactcol2, screencol2;
unsigned long 	vmask;
static char		*list[] = {
			"black",
			"white",
			"blue",
			"cyan",
			"green",
			"magenta",
			"red",
			"yellow",
			"gray",
			"grey",
			"dark gray",
			"dark grey",
			"dark blue",
			"brown",
			"dark cyan",
			"dark green",
			"dark magenta",
			"dark red",
			"medium blue",
			"midnight blue",
			"navy blue",
			"sky blue",
			"coral",
			"gold",
			"dark slate gray",
			"dark slate grey",
			"dim gray",
			"dim grey",
			"light gray",
			"light grey",
			"light green",
			"forest green",
			"lime green",
			"pale green",
			"spring green",
			"maroon",
			"orange",
			"pink",
			"indian red",
			"orange red",
			"violet red",
			"salmon",
			"sienna",
			"tan",
			"turquoise",
			"violet",
			"blue violet",
			"wheat" };


	if( (vmask = visualsupported(display, 0L)) == 0L) {
		delete("No visuals reported as valid.");
		return;
	}

	for(resetsupvis(vmask); nextsupvis(&vp); ) {
		
		for(i=0; i< NELEM(list); i++) {

			color_name = list[i];
			colormap = makecolmap(display, vp->visual, AllocNone);
			exact_def_return = &exactcol;
			screen_def_return = &screencol;
			status = XCALL;

			if(status == (Status) 0) {
				trace("Colour name \"%s\" is not supported.", color_name);
				CHECK; CHECK;CHECK;
			} else {

				color_name = convertname(list[i]);
				exact_def_return = &exactcol2;
				screen_def_return = &screencol2;
				status = XCALL;

				if(status == 0) {
					report("Colour name \"%s\" is supported but \"%s\" is not.", list[i], color_name);
					FAIL;
				} else {

					CHECK;

					if((exactcol2.red != exactcol.red) ||
					   (exactcol2.green != exactcol.green) ||
				 	   (exactcol2.blue != exactcol.blue) ) {
						report("Colour names \"%s\" and \"%s\" do not yield the same exact rgb values.",
							list[i], color_name);
						report("( r %u g %u b %u instead of r %u g %u b %u respectively.)", 
							exactcol.red, exactcol.green, exactcol.blue,
							exactcol2.red, exactcol2.green, exactcol2.blue);
						FAIL;
					} else
						CHECK;
	
					if((screencol2.red != screencol.red) ||
					   (screencol2.green != screencol.green) ||
				 	   (screencol2.blue != screencol.blue) ) {
						report("Colour names \"%s\" and \"%s\" do not yield the same supported rgb values.",
							list[i], color_name);
						report("( r %u g %u b %u instead of r %u g %u b %u respectively.)", 
							screencol.red, screencol.green, screencol.blue,
							screencol2.red, screencol2.green, screencol2.blue);
						FAIL;
					} else
						CHECK;

				}

				if(!isdeleted())
					free(color_name);
			}

		}

	}

	CHECKPASS(nsupvis() * 3 * NELEM(list));

>>ASSERTION  Good A
All colour names in the table which are in set A are recognised 
on a call to xname.
.tL "Set" "Color name(s)"
.tL "A" "black"
.tL "A" "white"
>>STRATEGY
For each supported visual type:
  Create a colourmap of that type using XCreateColormap.
  For the colournames in the table:
    Obtain the rgb values for the colour using xname.
    Verify that the call did not return 0.
>>CODE
int		i;
Status		status;
XVisualInfo	*vp;
unsigned long	vmask;
static char	*list[] = { "black", "white" };

	if( (vmask = visualsupported(display, 0L)) == 0L) {
		delete("No visuals reported as valid.");
		return;
	} else
		CHECK;

	for(resetsupvis(vmask); nextsupvis(&vp); ) {

		colormap = makecolmap(display, vp->visual, AllocNone);

		for(i=0; i< NELEM(list); i++) {

			color_name = list[i];
			status = XCALL;

			if(status == 0) {
				report("Colour name \"%s\" is not supported.", list[i]);
				FAIL;
			} else
				CHECK;
		}
	}

	CHECKPASS(1 + nsupvis() * NELEM(list));

>>ASSERTION  Good C
If any of the visual classes
.S GrayScale
or
.S StaticGray
support colourmaps with at least four colour cells:
When the visual type of the
.A colormap
argument is
.S GrayScale
or
.S StaticGray ,
and 
.A colormap
has at least four colour cells,
then all colour names in the table which are in set M are recognised 
on a call to xname.
.tL "Set" "Color name(s)"
.tL "M" "gray" "grey"
.tL "M" "dark gray" "dark grey"
>>STRATEGY
If the server supports GrayScale or StaticGray with colourmap size greater than 4:
  For those supported visuals:
    Create a colourmap using XCreateColormap.
    For each colour name in the table:
      Obtain the rgb values for the for the colour using xname.
      Verify that the call did not return 0.
>>CODE
int		i;
Status		status;
XVisualInfo	*vp;
unsigned long 	vmask;
static char	*list[] = { "gray", "grey", "dark gray", "dark grey" };


	if( (vmask = visualsupported(display, 1L<<GrayScale)) != 0L) {

		resetsupvis(vmask);
		(void) nextsupvis(&vp);
		if(vp->colormap_size < 4)
			vmask = 0L;
	}


	if( (vmask |= visualsupported(display, 1L<<StaticGray)) | StaticGray) {

		resetsupvis(1L<<StaticGray);
		(void) nextsupvis(&vp);
		if(vp->colormap_size < 4)
			vmask &= ~(1L<<StaticGray);
	}

	if(vmask == 0L) {
		unsupported("StaticGray and GrayScale visuals are not supported.");
		return;
	} else
		CHECK;

	for(resetsupvis(vmask); nextsupvis(&vp); ) {

		colormap = makecolmap(display, vp->visual, AllocNone);
		for(i=0; i< NELEM(list); i++) {

			color_name = list[i];
			status = XCALL;

			if(status == 0L) {
				report("Colour name \"%s\" is not supported.", color_name);
				FAIL;
			} else
				CHECK;
		}
	}

	CHECKPASS(1 + nsupvis()* NELEM(list));

>>ASSERTION  Good C
If any of the visual classes
.S PseudoColor ,
.S StaticColor ,
.S TrueColor ,
or
.S DirectColor
are supported:
When the visual type of the
.A colormap
argument is
.S PseudoColor ,
.S StaticColor ,
.S TrueColor ,
or
.S DirectColor ,
then all colour names in the table which are in set C are recognised 
on a call to xname.
.tL "Set" "Color name(s)"
.tL "C" "blue"
.tL "C" "cyan"
.tL "C" "green"
.tL "C" "magenta"
.tL "C" "red"
.tL "C" "yellow"
>>STRATEGY
For each supported visual type from PseudoColor, StaticColor, TrueColor and DirectColor:
  Create a colourmap of that type using XCreateColormap.
  For the colournames in the table:
    Obtain the rgb values for the colour using xname.
    Verify that the call did not return 0.
>>CODE
int		i;
unsigned long	vmask = (1L<<PseudoColor|1L<<StaticColor|1L<<TrueColor|1L<<DirectColor);
Status		status;
XVisualInfo	*vp;
static char	*list[] = { "blue", "cyan", "green", "magenta", "red", "yellow" };



	if( (vmask = visualsupported(display, vmask)) == 0L) {
		unsupported("Required visual types are not supported.");
		return;
	} else
		CHECK;


	for(resetsupvis(vmask); nextsupvis(&vp); ) {

		colormap = makecolmap(display, vp->visual, AllocNone);
		for(i=0; i< NELEM(list); i++) {

			color_name = list[i];
			status = XCALL;

			if(status == 0L) {
				report("Colour name \"%s\" is not supported.", color_name);
				FAIL;
			} else
				CHECK;
		}
	}

	CHECKPASS(nsupvis() * NELEM(list) + 1);

>>ASSERTION Good A
When a colour name in the table which is in set M, V or X 
is recognised on a call to xname,
then all other colour names in the table which are in set C, M, or V 
are also recognised on another call to xname.
.tL "Set" "Color name(s)"
.tL "C" "blue"
.tL "C" "cyan"
.tL "C" "green"
.tL "C" "magenta"
.tL "C" "red"
.tL "C" "yellow"
.tL "M" "gray" "grey"
.tL "M" "dark gray" "dark grey"
.tL "V" "dark blue"
.tL "V" "brown"
.tL "V" "dark cyan"
.tL "V" "dark green"
.tL "V" "dark magenta"
.tL "V" "dark red"
.tL "X" "medium blue"
.tL "X" "midnight blue"
.tL "X" "navy blue"
.tL "X" "sky blue"
.tL "X" "coral"
.tL "X" "gold"
.tL "X" "dark slate gray" "dark slate grey"
.tL "X" "dim gray" "dim grey"
.tL "X" "light gray" "light grey"
.tL "X" "light green"
.tL "X" "forest green"
.tL "X" "lime green"
.tL "X" "pale green"
.tL "X" "spring green"
.tL "X" "maroon"
.tL "X" "orange"
.tL "X" "pink"
.tL "X" "indian red"
.tL "X" "orange red"
.tL "X" "violet red"
.tL "X" "salmon"
.tL "X" "sienna"
.tL "X" "tan"
.tL "X" "turquoise"
.tL "X" "violet"
.tL "X" "blue violet"
.tL "X" "wheat"
>>STRATEGY
If a colourname in sets M, V or X causes xname to return non-zero:
  For each supported visual:
    Verify that all the colour names in C, M and V also cause xname to return non-zero:
>>CODE
XVisualInfo	*vp;
unsigned long	vmask;
int		i;
int		j;
int		supported = 0;
int		unsupported = 0;
Status		status;
static char *MVX[] = {	"gray", "grey", "dark gray","dark grey","dark blue","brown","dark cyan","dark green","dark magenta",
			"dark red","medium blue","midnight blue","navy blue","sky blue","coral","gold","dark slate gray",
			"dark slate grey","dim gray","dim grey","light gray","light grey","light green","forest green",
			"lime green","pale green","spring green","maroon","orange","pink","indian red","orange red",
			"violet red","salmon","sienna","tan","turquoise","violet","blue violet","wheat" };
static char *CMV[] = {	"blue","cyan","green","magenta","red","yellow","gray","grey","dark gray","dark grey",
			"dark blue","brown","dark cyan","dark green","dark magenta","dark red"};

	if( (vmask = visualsupported(display, 0L)) == 0L) {
		delete("No visuals reported as valid.");
		return;
	} else
		CHECK;

	for(resetsupvis(vmask); nextsupvis(&vp); ) {

		colormap = makecolmap(display, vp->visual, AllocNone);
		i = 0;
		supported = 0;
		color_name = MVX[i];
		status = XCALL;

		if(status != 0) {
			supported++;
			break;
		} else
			unsupported++;
	}

	if(unsupported == NELEM(MVX) && supported == 0) {
		PASS;
		return;
	}

	for(resetsupvis(vmask); nextsupvis(&vp); ) {
		colormap = makecolmap(display, vp->visual, AllocNone);
		for(j=0; j<NELEM(CMV); j++) {				
			color_name = CMV[j];
			status = XCALL;
			if(status == (Status) 0) {
				report("Colour name \"%s\" is not supported.", color_name);
				FAIL;
			} else
				CHECK;
		}
	}

	CHECKPASS(NELEM(CMV) * nsupvis() + 1);

