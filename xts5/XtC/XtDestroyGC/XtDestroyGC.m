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
>># File: xts/XtC/XtDestroyGC/XtDestroyGC.m
>># 
>># Description:
>>#	Tests for XtDestroyGC()
>># 
>># Modifications:
>># $Log: tdestygc.m,v $
>># Revision 1.1  2005-02-12 14:38:24  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:38:35  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:38  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:29:37  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:26:10  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:22:53  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:19:35  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;

GC_error_handler2(disp, error_event)
Display *disp;
XErrorEvent *error_event;
{
	avs_set_event(2,1);
	exit(0);
}
GC_error_handler(disp, error_event)
Display *disp;
XErrorEvent *error_event;
{
	int code = error_event->error_code;
	if ( code != 13 ) {
		sprintf(ebuf, "ERROR: Expected failure due to BadGC(13) Received %d",code);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	} else
	avs_set_event(1,1);
	exit(0);
}
/*
** actual gc values
*/
void CheckValues(values_good)
XGCValues *values_good;
{
	check_dec((long) GXcopy,
		(long) values_good->function,
	 "function");
	check_dec((long) ~0L,
		(long) values_good->plane_mask,
	 "plane_mask");
	check_dec((long) 0,
		(long) values_good->foreground,
	 "foreground");
	check_dec((long) 1,
		(long) values_good->background,
	 "background");
	check_dec((long) 0,
		(long)values_good->line_width,
	 "line_width");
	 check_dec((long)LineSolid,
		(long)values_good->line_style,
	 "line_style");
	check_dec((long)CapButt,
		(long)values_good->cap_style,
	 "cap_style");
	check_dec((long)JoinMiter,
	 (long)values_good->join_style,
	 "join_style");
	check_dec((long)FillSolid,
	 (long)values_good->fill_style,
	 "fill_style");
	check_dec((long)ArcPieSlice,
		(long)values_good->arc_mode,
	 "arc_mode");
	check_dec((long)0,
		(long)values_good->ts_x_origin,
	 "ts_x_origin");
	check_dec((long)0,
		(long)values_good->ts_y_origin,
	 "ts_y_origin");
	check_dec((long)ClipByChildren,
		(long)values_good->subwindow_mode,
	 "subwindow_mode");
	check_dec((long)True,
		(long)values_good->graphics_exposures,
	 "graphics_exposures");
	check_dec((long)0,
		(long)values_good->clip_x_origin,
	 "clip_x_origin");
	check_dec((long)0,
		(long)values_good->clip_y_origin,
	 "clip_y_origin");
	check_dec((long)0,
		(long)values_good->dash_offset,
	 "dash_offset");
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
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtDestroyGC XtC
void
XtDestroyGC(gc)
>>ASSERTION Good A
A successful call to 
void XtDestroyGC(w, gc)
when the graphics context
.A gc
has no other references shall deallocate 
the graphics context.
>>CODE
/*Although the documentation says this routine has two arguments, the*/
/*first being a widget, the code actually only takes one*/
GC GC_good;
XtGCMask value_mask;
XGCValues values, org_val;
Display *display_good;
Boolean status;
Window window_good;
pid_t pid2;
int invoked = 0;

	FORK(pid2);
	avs_xt_hier("Tdestygc1", "XtDestroyGC");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Obtain read-only shareable GC");
	display_good = XtDisplay(topLevel);
	window_good = XtWindow(topLevel);
	value_mask = ConstructGC(topLevel, &org_val);
	GC_good = XtGetGC(topLevel, value_mask, &org_val);
	tet_infoline("TEST: All GC values");
	status = XGetGCValues(display_good,GC_good,value_mask, &values);
	if (status)
	 	CheckValues(&values);
	else {
	 	sprintf(ebuf, "ERROR: XGetGCValues failed expected non zero value");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Access after DestroyGC should invoke GC_error_handler");
	XtDestroyGC(GC_good);
	XSync(display_good, 0);
	XSetErrorHandler(GC_error_handler);
	XDrawLine(display_good, window_good, GC_good, 10, 10, 20, 20);
	XSync(display_good, 0);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Procedure GC_error_handler was invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "GC_error_handler invocations count");
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to 
void XtDestroyGC(w, gc)
when the graphics context
.A gc
has a reference count of more than one 
shall decrement the reference count.
>>CODE
/*Although the documentation says this routine has two arguments, the*/
/*first being a widget, the code actually only takes one*/
GC GC_good, GC_good2;
XtGCMask value_mask;
XGCValues values, org_val;
Display *display_good;
Boolean status;
Window window_good;
pid_t pid2;
int invoked = 0;

	FORK(pid2);
	avs_xt_hier("Tdestygc1", "XtDestroyGC");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Obtain read-only shareable GC");
	display_good = XtDisplay(topLevel);
	window_good = XtWindow(topLevel);
	value_mask = ConstructGC(topLevel, &org_val);
	GC_good = XtGetGC(topLevel, value_mask, &org_val);
	status = XGetGCValues(display_good,GC_good,value_mask, &values);
	if (status)
	 	CheckValues(&values);
	else {
	 	sprintf(ebuf, "ERROR: XGetGCValues failed expected non zero value");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("PREP: Obtain another reference");
	GC_good2 = XtGetGC(topLevel, value_mask, &org_val);
	status = XGetGCValues(display_good,GC_good2,value_mask, &values);
	if (status)
	 	CheckValues(&values);
	else {
	 	sprintf(ebuf, "ERROR: XGetGCValues failed expected non zero value");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Access after DestroyGC should not invoke GC_error_handler");
	XtDestroyGC(GC_good);
	XSync(display_good, 0);
	XSetErrorHandler(GC_error_handler2);
	XDrawLine(display_good, window_good, GC_good2, 10, 10, 20, 20);
	XSync(display_good, 0);
	tet_infoline("TEST: Access after DestroyGC should invoke GC_error_handler");
	XtDestroyGC(GC_good2);
	XSync(display_good, 0);
	XSetErrorHandler(GC_error_handler);
	XDrawLine(display_good, window_good, GC_good, 10, 10, 20, 20);
	XSync(display_good, 0);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Error handler not invoked on first access");
	invoked = avs_get_event(2);
	check_dec(0, invoked, "GC_error_handler2 invocations count");
	tet_infoline("TEST: Error handler invoked on second access");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "GC_error_handler invocations count");
	tet_result(TET_PASS);
