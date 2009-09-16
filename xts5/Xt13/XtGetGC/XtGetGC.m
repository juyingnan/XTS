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

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: xts/Xt13/XtGetGC/XtGetGC.m
>># 
>># Description:
>>#	Tests for XtGetGC()
>># 
>># Modifications:
>># $Log: tgtgc.m,v $
>># Revision 1.1  2005-02-12 14:37:57  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:38:09  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:10  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:29:12  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:25:46  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:21:35  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:17:35  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;

/*
** actual gc values 
*/
void CheckValues(values_good)
XGCValues *values_good;
{
	check_dec((long) GXcopy,
		(long) values_good->function, "function");
	check_dec((long) ~0L, (long) values_good->plane_mask, "plane_mask");
	check_dec((long) 0, (long) values_good->foreground, "foreground");
	check_dec((long) 1, (long) values_good->background, "background");
	check_dec((long) 0, (long)values_good->line_width, "line_width");
	 check_dec((long)LineSolid, (long)values_good->line_style, "line_style");
	check_dec((long)CapButt, (long)values_good->cap_style, "cap_style");
	check_dec((long)JoinMiter, (long)values_good->join_style, "join_style");
	check_dec((long)FillSolid, (long)values_good->fill_style, "fill_style");
	check_dec((long)ArcPieSlice, (long)values_good->arc_mode, "arc_mode");
	check_dec((long)0, (long)values_good->ts_x_origin, "ts_x_origin");
	check_dec((long)0, (long)values_good->ts_y_origin, "ts_y_origin");
	check_dec((long)ClipByChildren, (long)values_good->subwindow_mode, "subwindow_mode");
	check_dec((long)True, (long)values_good->graphics_exposures, "graphics_exposures");
	check_dec((long)0, (long)values_good->clip_x_origin, "clip_x_origin");
	check_dec((long)0, (long)values_good->clip_y_origin, "clip_y_origin");
	check_dec((long)0, (long)values_good->dash_offset, "dash_offset");
}
XtGCMask ConstructGC(w, vals)
Widget w;
XGCValues *vals;
{
	Display *display_good;
	Window window_good;
	XtGCMask value_mask;
	Pixmap pixmap1, tilemap, stipmap;
	display_good = XtDisplay(w);
	window_good = XtWindow(w);
	value_mask = ( GCFunction | GCPlaneMask | GCForeground |
		GCBackground | GCLineWidth | GCLineStyle |
		GCCapStyle | GCJoinStyle | GCFillStyle |
		GCFillRule | GCTile | GCStipple |
		GCTileStipXOrigin | GCTileStipYOrigin |
		GCSubwindowMode | GCGraphicsExposures |
		GCClipXOrigin | GCClipYOrigin | GCDashOffset |
		GCArcMode );
	pixmap1 = XCreatePixmap(display_good, window_good,
		 (unsigned int)100,
		 (unsigned int)100,
		 (unsigned int)XDefaultDepth(display_good,
		 XDefaultScreen(display_good)));
	tilemap = pixmap1;
	{
	static unsigned short pixarr[] = {
		0xaa55, 0x0a55, 0xaa22, 0xaa55,
		0xaacc, 0xaa55, 0xaa55, 0x1a55,
		0xaa55, 0xaa05, 0xaa55, 0xa355,
		0xaa51, 0xaa55, 0xa455, 0x0055
			};
	stipmap = XCreateBitmapFromData (display_good,
			XDefaultRootWindow(display_good),
			(char *)pixarr, 16, 16);
	}
	vals->function = (int)GXcopy;
	vals->plane_mask = ~0L;
	vals->foreground = (unsigned long)0;
	vals->background = (unsigned long)1;
	vals->line_width = (int)0;
	vals->line_style = (int)LineSolid;
	vals->cap_style = (int)CapButt;
	vals->join_style = (int)JoinMiter;
	vals->fill_style = (int)FillSolid;
	vals->fill_rule = (int)EvenOddRule;
	vals->arc_mode = (int)ArcPieSlice;
	vals->tile =	tilemap;
	vals->stipple = stipmap;
	vals->ts_x_origin = (int)0;
	vals->ts_y_origin = (int)0;
	vals->subwindow_mode = (int)ClipByChildren;
	vals->graphics_exposures = (Bool)True;
	vals->clip_x_origin = (int)0;
	vals->clip_y_origin = (int)0;
	vals->dash_offset = (int)0;
	vals->dashes = (char)4;
	return((XtGCMask)value_mask);
}
>>TITLE XtGetGC Xt13
GC
XtGetGC(object, value_mask, values)
>>ASSERTION Good A
A call to 
GC XtGetGC(object, value_mask, values)
shall return a sharable graphics context that has its root set
to the screen associated with the object
.A object
and its drawable depth set to the value specified by the 
depth field of the object.
>>CODE
GC GC_good;
XtGCMask value_mask;
XGCValues values, org_val;
Display *display_good;
Boolean status;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tgtgc1", "XtGetGC");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Obtain read-only shareable GC");
	display_good = XtDisplay(topLevel);
	value_mask = ConstructGC(topLevel, &org_val);
	GC_good = XtGetGC(topLevel, value_mask, &org_val);
	tet_infoline("TEST: GC is valid");
	status = XGetGCValues(display_good, GC_good, value_mask, &values);
	if (!status) {
		sprintf(ebuf, "ERROR: XGetGCValues failed, expected non-zero value");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("CLEANUP: Release GC");
	XtReleaseGC(topLevel, GC_good);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
On a call to
GC XtGetGC(object, value_mask, values)
the fields in the graphics context returned that are
specified in 
.A value_mask
shall be set to the corresponding values specified in
.A values.
>>CODE
GC GC_good;
XtGCMask value_mask;
XGCValues values, org_val;
Display *display_good;
Boolean status;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tgtgc2", "XtGetGC");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Obtain read-only shareable GC");
	display_good = XtDisplay(topLevel);
	value_mask = ConstructGC(topLevel, &org_val);
	GC_good = XtGetGC(topLevel, value_mask, &org_val);
	tet_infoline("TEST: GC values");
	status = XGetGCValues(display_good, GC_good, value_mask, &values);
	if (status)
		CheckValues(&values);
	else {
		sprintf(ebuf, "ERROR: XGetGCValues failed, expected non-zero value");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("CLEANUP: Release GC");
	XtReleaseGC(topLevel, GC_good);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good B 1
On a call to
GC XtGetGC(object, value_mask, values)
the fields in the graphics context returned that are not
specified in
.A value_mask 
shall be set to default values.
>>ASSERTION Good B 2
On a call to
GC XtGetGC(object, value_mask, values)
the graphics context returned shall have no 
fields that are modifiable by the calling process.
