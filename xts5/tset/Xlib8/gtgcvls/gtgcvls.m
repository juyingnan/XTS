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
$Header: /cvs/xtest/xtest/xts5/tset/Xlib8/gtgcvls/gtgcvls.m,v 1.2 2005-11-03 08:43:49 jmichael Exp $

Copyright (c) Applied Testing and Technology, Inc. 1995
All Rights Reserved.

>># Project: VSW5
>># 
>># File: xts5/tset/Xlib8/gtgcvls/gtgcvls.m
>># 
>># Description:
>># 	Tests for XGetGCValues()
>># 
>># Modifications:
>># $Log: gtgcvls.m,v $
>># Revision 1.2  2005-11-03 08:43:49  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:32  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:27:26  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:45:45  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:19:38  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:16:09  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 08:50:54  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  00:51:27  andy
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
>>TITLE XGetGCValues Xlib8
Status
XGetGCValues(display, gc, valuemask, values)
Display *display = Dsp;
GC gc;
unsigned long valuemask;
XGCValues *values = &rvals;
>>SET startup fontstartup
>>SET cleanup fontcleanup
>>EXTERN
#define FONTNAME "xtfont0"
XGCValues rvals;
>>ASSERTION Good A
A call to xname copies the components
specified by the
.A valuemask
argument 
from the specified GC
to the contents of the 
.A values_return
argument.
>>STRATEGY
Create a GC with non-default values for function,
 planemask, foreground, background, linewidth, linestyle,
 capstyle, joinstyle, fillstyle, fillrule, tile, stipple,
 stipple origin, font, subwindowmode, graphics exposures,
 clip origin, dash offset and arcmode using XCreateGC.
Read the GC structure components using XGetGCValues.
Verify that the returned values match the created values.
>>CODE
XVisualInfo	*vp;
XGCValues	vals;
Pixmap		tile, stipple;
Status		status;
Font 		font;
XFontStruct	*fontinfo;

	if( (fontinfo = XLoadQueryFont(display, FONTNAME)) == (XFontStruct *) 0) {
		delete("Could not load font %s",FONTNAME);
		return;
	} else
		CHECK;

	resetvinf(VI_WIN);

	/*
	 * Find the visual information associated with the default
	 * visual, since we will be testing using the root window.
	 */
	do
		nextvinf(&vp);	
	while(vp->visual != DefaultVisual(display, DefaultScreen(display)));

	font = fontinfo -> fid;
	tile = makepixm(display, vp);
	stipple = XCreatePixmap(display, DRW(display), 1, 1, 1);
	vals.function = GXxor;
	vals.plane_mask = 42;
	vals.foreground = 1;
	vals.background = 0;
	vals.line_width = 10;
	vals.line_style = LineOnOffDash;
	vals.cap_style = CapProjecting;
	vals.join_style = JoinBevel;
	vals.fill_style = FillStippled;
	vals.fill_rule =  WindingRule;
	vals.arc_mode = ArcChord;
	vals.tile = tile;
	vals.stipple = stipple;
	vals.ts_x_origin = 2000;
	vals.ts_y_origin = -13;
	vals.font = font;
	vals.subwindow_mode = ClipByChildren;
	vals.graphics_exposures = False;
	vals.clip_x_origin = 2003;
	vals.clip_y_origin = 78435;
	vals.dash_offset = 14;

	valuemask =
		GCFunction | GCPlaneMask | GCForeground |
		GCBackground | GCLineWidth | GCLineStyle  |
		GCCapStyle | GCJoinStyle | GCFillStyle |
		GCFillRule | GCTile | GCStipple |
		GCTileStipXOrigin | GCTileStipYOrigin | GCFont |
		GCSubwindowMode | GCGraphicsExposures | GCClipXOrigin |
		GCClipYOrigin	| GCDashOffset	| GCArcMode ;

	gc = XCreateGC(display, DRW(display), valuemask, &vals);
	
	status = XCALL;

	if(status == 0) {
		delete("XGetGCValues() unexpectedly returned zero");
		return;
	} else
		CHECK;

	if( vals.function  == rvals.function  ) {
		CHECK;
	} else {
		report("Expected GCValue function differs from that observed");
		FAIL;
	}
	if( vals.plane_mask  == rvals.plane_mask  ) {
		CHECK;
	} else {
		report("Expected GCValue plane_mask differs from that observed");
		FAIL;
	}
	if( vals.foreground  == rvals.foreground  ) {
		CHECK;
	} else {
		report("Expected GCValue foreground differs from that observed");
		FAIL;
	}
	if( vals.background  == rvals.background  ) {
		CHECK;
	} else {
		report("Expected GCValue background differs from that observed");
		FAIL;
	}
	if( vals.line_width  == rvals.line_width  ) {
		CHECK;
	} else {
		report("Expected GCValue line_width differs from that observed");
		FAIL;
	}
	if( vals.line_style  == rvals.line_style  ) {
		CHECK;
	} else {
		report("Expected GCValue line_style differs from that observed");
		FAIL;
	}
	if( vals.cap_style  == rvals.cap_style  ) {
		CHECK;
	} else {
		report("Expected GCValue cap_style differs from that observed");
		FAIL;
	}
	if( vals.join_style  == rvals.join_style  ) {
		CHECK;
	} else {
		report("Expected GCValue join_style differs from that observed");
		FAIL;
	}
	if( vals.fill_style  == rvals.fill_style  ) {
		CHECK;
	} else {
		report("Expected GCValue fill_style differs from that observed");
		FAIL;
	}
	if( vals.fill_rule  == rvals.fill_rule  ) {
		CHECK;
	} else {
		report("Expected GCValue fill_rule differs from that observed");
		FAIL;
	}
	if( vals.arc_mode  == rvals.arc_mode  ) {
		CHECK;
	} else {
		report("Expected GCValue arc_mode differs from that observed");
		FAIL;
	}
	if( vals.tile  == rvals.tile  ) {
		CHECK;
	} else {
		report("Expected GCValue tile differs from that observed");
		FAIL;
	}
	if( vals.stipple  == rvals.stipple  ) {
		CHECK;
	} else {
		report("Expected GCValue stipple differs from that observed");
		FAIL;
	}
	if( vals.ts_x_origin  == rvals.ts_x_origin  ) {
		CHECK;
	} else {
		report("Expected GCValue ts_x_origin differs from that observed");
		FAIL;
	}
	if( vals.ts_y_origin  == rvals.ts_y_origin  ) {
		CHECK;
	} else {
		report("Expected GCValue ts_y_origin differs from that observed");
		FAIL;
	}
	if( vals.font  == rvals.font  ) {
		CHECK;
	} else {
		report("Expected GCValue font differs from that observed");
		FAIL;
	}
	if( vals.subwindow_mode  == rvals.subwindow_mode  ) {
		CHECK;
	} else {
		report("Expected GCValue subwindow_mode differs from that observed");
		FAIL;
	}
	if( vals.graphics_exposures  == rvals.graphics_exposures  ) {
		CHECK;
	} else {
		report("Expected GCValue graphics_exposures differs from that observed");
		FAIL;
	}
	if( vals.clip_x_origin  == rvals.clip_x_origin  ) {
		CHECK;
	} else {
		report("Expected GCValue clip_x_origin differs from that observed");
		FAIL;
	}
	if( vals.clip_y_origin  == rvals.clip_y_origin  ) {
		CHECK;
	} else {
		report("Expected GCValue clip_y_origin differs from that observed");
		FAIL;
	}
	if( vals.dash_offset  == rvals.dash_offset  ) {
		CHECK;
	} else {
		report("Expected GCValue dash_offset differs from that observed");
		FAIL;
	}

	CHECKPASS(23);

>>#Assertion added following external review 13/4/91
>>ASSERTION Good A
When the
.A valuemask
argument is a bitwise OR of any of
.S GCFunction ,
.S GCPlaneMask , 
.S GCForeground , 
.S GCBackground , 
.S GCLineWidth , 
.S GCLineStyle , 
.S GCCapStyle , 
.S GCJoinStyle , 
.S GCFillStyle , 
.S GCFillRule , 
.S GCTile , 
.S GCStipple , 
.S GCTileStipXOrigin , 
.S GCTileStipYOrigin , 
.S GCFont , 
.S GCSubwindowMode , 
.S GCGraphicsExposures , 
.S GCClipXOrigin , 
.S GCCLipYOrigin , 
.S GCDashOffset , 
or
.S GCArcMode,
then a call to XGetGCValues returns a non-zero value.
>>STRATEGY
Call XGetGCValues with a valuemask of
	GCFunction | GCPlaneMask | GCForeground |
	GCBackground | GCLineWidth | GCLineStyle  |
	GCCapStyle | GCJoinStyle | GCFillStyle |
	GCFillRule | GCTile | GCStipple |
	GCTileStipXOrigin | GCTileStipYOrigin | GCFont |
	GCSubwindowMode | GCGraphicsExposures | GCClipXOrigin |
	GCClipYOrigin	| GCDashOffset	| GCArcMode .
Verify that XGetGCValues returns non-zero.
>>CODE
XVisualInfo	*vp;
XGCValues	vals;
Pixmap		tile, stipple;
Status		status;
Font 		font;
XFontStruct	*fontinfo;

	if( (fontinfo = XLoadQueryFont(display, FONTNAME)) == (XFontStruct *) 0) {
		delete("Could not load font %s",FONTNAME);
		return;
	} else
		CHECK;

	/*
	 * Find the visual information associated with the default
	 * visual, since we will be testing using the root window.
	 */
	resetvinf(VI_WIN);
	do
		nextvinf(&vp);	
	while(vp->visual != DefaultVisual(display, DefaultScreen(display)));

	font = fontinfo -> fid;
	tile = makepixm(display, vp);
	stipple = XCreatePixmap(display, DRW(display), 1, 1, 1);
	vals.function = GXxor;
	vals.plane_mask = 42;
	vals.foreground = 1;
	vals.background = 0;
	vals.line_width = 10;
	vals.line_style = LineOnOffDash;
	vals.cap_style = CapProjecting;
	vals.join_style = JoinBevel;
	vals.fill_style = FillStippled;
	vals.fill_rule =  WindingRule;
	vals.arc_mode = ArcChord;
	vals.tile = tile;
	vals.stipple = stipple;
	vals.ts_x_origin = 2000;
	vals.ts_y_origin = -13;
	vals.font = font;
	vals.subwindow_mode = ClipByChildren;
	vals.graphics_exposures = False;
	vals.clip_x_origin = 2003;
	vals.clip_y_origin = 78435;
	vals.dash_offset = 14;

	valuemask =
		GCFunction | GCPlaneMask | GCForeground |
		GCBackground | GCLineWidth | GCLineStyle  |
		GCCapStyle | GCJoinStyle | GCFillStyle |
		GCFillRule | GCTile | GCStipple |
		GCTileStipXOrigin | GCTileStipYOrigin | GCFont |
		GCSubwindowMode | GCGraphicsExposures | GCClipXOrigin |
		GCClipYOrigin	| GCDashOffset	| GCArcMode ;

	gc = XCreateGC(display, DRW(display), valuemask, &vals);
	
	status = XCALL;

	if(status == 0) {
		report("XGetGCValues() did not return non-zero.");
		FAIL;
	} else
		CHECK;

	CHECKPASS(2);

>>ASSERTION Good A
When the
.A valuemask
argument is other than a bitwise OR of any
of
.S GCFunction ,
.S GCPlaneMask , 
.S GCForeground , 
.S GCBackground , 
.S GCLineWidth , 
.S GCLineStyle , 
.S GCCapStyle , 
.S GCJoinStyle , 
.S GCFillStyle , 
.S GCFillRule , 
.S GCTile , 
.S GCStipple , 
.S GCTileStipXOrigin , 
.S GCTileStipYOrigin , 
.S GCFont , 
.S GCSubwindowMode , 
.S GCGraphicsExposures , 
.S GCClipXOrigin , 
.S GCCLipYOrigin , 
.S GCDashOffset , 
or
.S GCArcMode,
then a call to xname returns zero.
>>STRATEGY
Call XGetGCValues with a valuemask of  GCClipmask | GCForeground.
Verify that XGetGCValues returns zero.
Call XGetGCValues with a valuemask of  GCDashList | GCForeground.
Verify that XGetGCValues returns zero.
>>CODE
XGCValues vals;
Status status;

	vals.foreground = 1;
	vals.clip_mask = None;
	vals.dashes = 1;
	valuemask = GCClipMask | GCDashList | GCForeground;
	gc = XCreateGC(display,DRW(display), valuemask, &vals);
	
	status = XCALL;

	if(status != 0) {
		report("XGetGCValues() did not return zero with GCClipMask in valuemask.");
		FAIL;
	} else
		CHECK;

	valuemask = GCDashList | GCForeground;
	
	status = XCALL;

	if(status != 0) {
		report("XGetGCValues() did not return zero with GCDashList in valuemask.");
		FAIL;
	} else
		CHECK;

	CHECKPASS(2);

>>#HISTORY	Cal	Completed	Written in new style and format.
>>#HISTORY	Kieron	Completed		<Have a look>
>>#HISTORY	Cal	Action		Writing code.
