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
$Header: /cvs/xtest/xtest/xts5/tset/Xt12/tinaclrts/tinaclrts.m,v 1.1 2005-02-12 14:37:56 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt12/tinaclrts/tinaclrts.m
>># 
>># Description:
>>#	Tests for XtInstallAccelerators()
>># 
>># Modifications:
>># $Log: tinaclrts.m,v $
>># Revision 1.1  2005-02-12 14:37:56  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:37:59  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:00:58  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:29:02  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:25:35  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:21:05  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:16:44  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>
#include <X11/Xaw/Label.h>
#include <xt/SquareCelP.h>
#include <X11/Xaw/Form.h>
#include <AvsComp.h>
#include <AvsRectObj.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;
Widget squarew;

extern char *event_names[];

void XtACT_Proc(w, event, params, num_params)
Widget w;
XEvent *event;
String *params;
Cardinal *num_params;
{
	avs_set_event(1,1);
	tet_infoline("TEST: Action went to source widget");
	if (w != rowcolw) {
		tet_infoline("ERROR: action went to wrong window");
		tet_result(TET_FAIL);
	}
	exit(0);
}

void XtACT_Proc2(w, event, params, num_params)
Widget w;
XEvent *event;
String *params;
Cardinal *num_params;
{
	avs_set_event(1,1);
	tet_infoline("TEST: Action went to source widget");
	if (w != squarew) {
		tet_infoline("ERROR: action went to wrong window");
		tet_result(TET_FAIL);
	}
	exit(0);
}

void StringProc1(w, accel) 
Widget w;
String accel;
{
	tet_infoline("TEST: widget passed correctly");
	if (w != squarew) {
		sprintf(ebuf, "ERROR: Expected widget to point to squarew, is %x", 2);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: accelerator table passed correctly");
	if (accel == NULL) {
		tet_infoline("ERROR: Accelerator table is NULL");
		tet_result(TET_FAIL);
	}
	else {
		if (strstr(accel, "<ButtonPress>") == NULL) {
			sprintf(ebuf, "ERROR: Expected accelerator table to contain \"%s\", is \"%s\"", "<ButtonPress>", accel);
			tet_infoline(ebuf);
			tet_result(TET_FAIL);
		}
	}
		
	avs_set_event(2,1);
}
/*
 * SquareCell.c - Square Widget 
 */
#define INTERNAL_WIDTH    2
#define INTERNAL_HEIGHT 4
#define DEFAULT_PIXMAP_WIDTH    1  /* in cells */
#define DEFAULT_PIXMAP_HEIGHT   1  /* in cells */
#define DEFAULT_CELL_SIE   20  /* in pixels */
/* values for instance variable is_drawn */
#define DRAWN 1
#define UNDRAWN 0
/* modes for drawing */
#define DRAW 1
#define UNDRAW 0
#define MAXLINES 10   /* max of horiz or vertical cells */
#define SCROLLBARWIDTH 15
#define DEFAULTWIDTH 300  /* widget size when show_all is False */
#define offset(field) XtOffsetOf(SquareCellRec, field)
static XtResource resources[] = {
	{
	XtNforeground, 
	XtCForeground, 
	XtRPixel, 
	sizeof(Pixel),
	offset(squareCell.foreground), 
	XtRString, 
	XtDefaultForeground
	},
     {
    XavsNtoggleCallback, 
    XavsCToggleCallback, 
    XtRCallback, 
    sizeof(XtPointer),
    offset(squareCell.callback), 
    XtRCallback, 
    NULL
     },
     {
    XavsNcellSizeInPixels, 
    XavsCCellSizeInPixels, 
    XtRInt, sizeof(int),
    offset(squareCell.cell_size_in_pixels), 
    XtRImmediate, 
    (XtPointer)DEFAULT_CELL_SIE
     },
     {
    XavsNpixmapWidthInCells, 
    XavsCPixmapWidthInCells, 
    XtRDimension, 
    sizeof(Dimension),
    offset(squareCell.pixmap_width_in_cells), 
    XtRImmediate, 
    (XtPointer)DEFAULT_PIXMAP_WIDTH
     },
     {
    XavsNpixmapHeightInCells, 
    XavsCPixmapHeightInCells, 
    XtRDimension, 
    sizeof(Dimension),
    offset(squareCell.pixmap_height_in_cells), 
    XtRImmediate, 
    (XtPointer)DEFAULT_PIXMAP_HEIGHT
     },
     {
    XavsNcurX, 
    XavsCCurX, 
    XtRInt, 
    sizeof(int),
    offset(squareCell.cur_x), 
    XtRImmediate, 
    (XtPointer) 0
     },
     {
    XavsNcurY, 
    XavsCCurY, 
    XtRInt, 
    sizeof(int),
    offset(squareCell.cur_y), 
    XtRImmediate, 
    (XtPointer) 0
     },
     {
    XavsNcellArray, 
    XavsCCellArray, 
    XtRString, 
    sizeof(String),
    offset(squareCell.cell), 
    XtRImmediate, 
    (XtPointer) 0
     },
     {
    XavsNshowEntireBitmap, 
    XavsCShowEntireBitmap, 
    XtRBoolean, 
    sizeof(Boolean),
    offset(squareCell.show_all), 
    XtRImmediate, 
    (XtPointer) TRUE
     },
};
/* Declaration of methods */
static void Initialize();
static void Redisplay();
static void Destroy();
static void Resize();
static Boolean SetValues();
static XtGeometryResult QueryGeometry();
/* these Core methods not needed by SquareCell:
 *
 * static void ClassInitialize();
 * static void Realize();
 */
/* the following are private functions unique to SquareCell */
static void DrawPixmaps(), DoCell(), ChangeCellSize();
/* the following are actions of SquareCell */
static void DrawCell(), UndrawCell(), ToggleCell();
/* The following are public functions of SquareCell, declared extern
 * in the public include file: */
char *SquareCellGetArray(); 
static char defaultTranslations[] =
    "<Btn1Down>:    DrawCell()	    \n\
    <Btn2Down>:    UndrawCell()	  \n\
    <Btn3Down>:    ToggleCell()	  \n\
    <Btn1Motion>:  DrawCell()	    \n\
    <Btn2Motion>:  UndrawCell()	  \n\
    <Btn3Motion>:  ToggleCell()";
static XtActionsRec actions[] = {
        {"DrawCell", DrawCell},
        {"UndrawCell", UndrawCell},
        {"ToggleCell", ToggleCell},
};
/* definition in SquareCell.h */
static SquareCellPointInfo info;
SquareCellClassRec squareCellClassRec = {
    {
    /* core_class fields */
    /* superclass        */ (WidgetClass) &coreClassRec,
    /* class_name        */ "SquareCell",
    /* widget_size       */ sizeof(SquareCellRec),
    /* class_initialize      */ NULL,
    /* class_part_initialize     */ NULL,
    /* class_inited	*/ FALSE,
    /* initialize        */ Initialize,
    /* initialize_hook       */ NULL,
    /* realize	 */ XtInheritRealize,
    /* actions	 */ actions,
    /* num_actions       */ XtNumber(actions),
    /* resources         */ resources,
    /* num_resources         */ XtNumber(resources),
    /* xrm_class         */ NULLQUARK,
    /* compress_motion       */ TRUE,
    /* compress_exposure     */ XtExposeCompressMultiple,
    /* compress_enterleave   */ TRUE,
    /* visible_interest      */ FALSE,
    /* destroy	 */ Destroy,
    /* resize	  */ Resize,
    /* expose	  */ Redisplay,
    /* set_values        */ SetValues,
    /* set_values_hook       */ NULL,
    /* set_values_almost     */ XtInheritSetValuesAlmost,
    /* get_values_hook       */ NULL,
    /* accept_focus      */ NULL,
    /* version	 */ XtVersion,
    /* callback_private      */ NULL,
    /* tm_table	*/ defaultTranslations,
    /* query_geometry        */ QueryGeometry,
    /* display_accelerator       */ StringProc1,
    /* extension	 */ NULL
    },
	{/* simple_class fields */
	/* change_sensitive */	XtInheritChangeSensitive,
	},
    {
    /* extension	*/        0,
    },
};
WidgetClass squareCellWidgetClass = (WidgetClass) & squareCellClassRec;
static void
GetDrawGC(w)
Widget w;
{
    SquareCellWidget cw = (SquareCellWidget) w;
    XGCValues values;
    XtGCMask mask = GCForeground | GCBackground | GCDashOffset | 
	  GCDashList | GCLineStyle;
    /* 
     * Setting foreground and background to 1 and 0 looks like a 
     * kludge but isn't.  This GC is used for drawing
     * into a pixmap of depth one.  Real colors are applied with a
     * separate GC when the pixmap is copied into the window.
     */
    values.foreground = 1;
    values.background = 0;
    values.dashes = 1;
    values.dash_offset = 0;
    values.line_style = LineOnOffDash;
    cw->squareCell.draw_gc = XCreateGC(XtDisplay((Widget)cw), 
	   cw->squareCell.big_picture, mask, &values);
}
static void
GetUndrawGC(w)
Widget w;
{
    SquareCellWidget cw = (SquareCellWidget) w;
    XGCValues values;
    XtGCMask mask = GCForeground | GCBackground;
    /* this looks like a kludge but isn't.  This GC is used for drawing
     * into a pixmap of depth one.  Real colors are applied as the 
     * pixmap is copied into the window.
     */
    values.foreground = 0;
    values.background = 1;
    cw->squareCell.undraw_gc = XCreateGC(XtDisplay((Widget)cw), 
	    cw->squareCell.big_picture, mask, &values);
}
static void
GetCopyGC(w)
Widget w;
{
    SquareCellWidget cw = (SquareCellWidget) w;
    XGCValues values;
    XtGCMask mask = GCForeground | GCBackground;
    values.foreground = cw->squareCell.foreground;
    values.background = cw->core.background_pixel;
    cw->squareCell.copy_gc = XtGetGC((Widget)cw, mask, &values);
}
static void
Initialize(treq, tnew, args, num_args)
Widget treq, tnew;
ArgList args;
Cardinal *num_args;
{
    SquareCellWidget new = (SquareCellWidget) tnew;
    new->squareCell.cur_x = 0;
    new->squareCell.cur_y = 0;
    /* 
     *  Check instance values set by resources that may be invalid. 
     */
    if ((new->squareCell.pixmap_width_in_cells < 1) ||
	  (new->squareCell.pixmap_height_in_cells < 1))  {
        XtWarning("SquareCell: pixmapWidth and/or pixmapHeight is too small (using 10 x 10)."); 
        new->squareCell.pixmap_width_in_cells = 10;
        new->squareCell.pixmap_height_in_cells = 10;
    }
    if (new->squareCell.cell_size_in_pixels < 5) {
        XtWarning("SquareCell: cellSize is too small (using 5)."); 
        new->squareCell.cell_size_in_pixels = 5;
    }
    if ((new->squareCell.cur_x < 0) ||  (new->squareCell.cur_y < 0)) {
        XtWarning("SquareCell: cur_x and cur_y must be non-negative (using 0, 0)."); 
        new->squareCell.cur_x = 0;
        new->squareCell.cur_y = 0;
    }
    if (new->squareCell.cell == NULL)
        new->squareCell.cell = XtCalloc( 
	new->squareCell.pixmap_width_in_cells * 
	new->squareCell.pixmap_height_in_cells, sizeof(char));
    else
        new->squareCell.user_allocated = True;  /* user supplied cell array */
    new->squareCell.pixmap_width_in_pixels = 
	 new->squareCell.pixmap_width_in_cells * 
	 new->squareCell.cell_size_in_pixels;
    new->squareCell.pixmap_height_in_pixels = 
	 new->squareCell.pixmap_height_in_cells * 
	 new->squareCell.cell_size_in_pixels;
    if (new->core.width == 0) {
        if (new->squareCell.show_all == False)
	  new->core.width = (new->squareCell.pixmap_width_in_pixels 
	    > DEFAULTWIDTH) ? DEFAULTWIDTH : 
	    (new->squareCell.pixmap_width_in_pixels);
        else
	  new->core.width = new->squareCell.pixmap_width_in_pixels;
    }
    if (new->core.height == 0) {
        if (new->squareCell.show_all == False)
	  new->core.height = 
	    (new->squareCell.pixmap_height_in_pixels > 
	    DEFAULTWIDTH) ? DEFAULTWIDTH : 
	    (new->squareCell.pixmap_height_in_pixels);
        else
	  new->core.height = new->squareCell.pixmap_height_in_pixels;
    }
    CreateBigPixmap(new);
    GetDrawGC(new);
    GetUndrawGC(new);
    GetCopyGC(new);
    DrawIntoBigPixmap(new);
}
static void
Redisplay(w, event)
Widget w;
XExposeEvent *event;
{
    SquareCellWidget cw = (SquareCellWidget) w;
    register int x, y;
    unsigned int width, height;
    if (!XtIsRealized((Widget)cw))
    return;
    if (event) {  /* called from btn-event or expose */
        x = event->x;
        y = event->y; 
        width = event->width;
        height =  event->height;
    } 
    else {        /* called because complete redraw */
        x = 0;
        y = 0; 
        width = cw->squareCell.pixmap_width_in_pixels;
        height = cw->squareCell.pixmap_height_in_pixels;
    }
    if (DefaultDepthOfScreen(XtScreen((Widget)cw)) == 1)
        XCopyArea(XtDisplay((Widget)cw), cw->squareCell.big_picture, 
	XtWindow((Widget)cw), cw->squareCell.copy_gc, x + 
	cw->squareCell.cur_x, y + cw->squareCell.cur_y, 
	width, height, x, y);
    else
        XCopyPlane(XtDisplay((Widget)cw), cw->squareCell.big_picture, 
	XtWindow((Widget)cw), cw->squareCell.copy_gc, x + 
	cw->squareCell.cur_x, y + cw->squareCell.cur_y, 
	width, height, x, y, 1);
}
static Boolean
SetValues(current, request, new, args, num_args)
Widget current, request, new;
ArgList args;
Cardinal *num_args;
{
    SquareCellWidget curcw = (SquareCellWidget) current;
    SquareCellWidget newcw = (SquareCellWidget) new;
    Boolean do_redisplay = False;
    /*
    ** XtSetValues invoked procedure SetValues
    */
    if (curcw->squareCell.foreground != newcw->squareCell.foreground) {
        XtReleaseGC((Widget)curcw, curcw->squareCell.copy_gc);
        GetCopyGC(newcw);
        do_redisplay = True;
    }
    if ((curcw->squareCell.cur_x != newcw->squareCell.cur_x) || 
	  (curcw->squareCell.cur_y != newcw->squareCell.cur_y))
        do_redisplay = True;
    if (curcw->squareCell.cell_size_in_pixels != 
	  newcw->squareCell.cell_size_in_pixels) {
        ChangeCellSize(curcw, newcw->squareCell.cell_size_in_pixels);
        do_redisplay = True;
    }
    if (curcw->squareCell.pixmap_width_in_cells != 
	  newcw->squareCell.pixmap_width_in_cells)  {
        newcw->squareCell.pixmap_width_in_cells = 
	curcw->squareCell.pixmap_width_in_cells;
        XtWarning("SquareCell: pixmap_width_in_cells cannot be set by XtSetValues.\n");
    }
    if (curcw->squareCell.pixmap_height_in_cells != 
	  newcw->squareCell.pixmap_height_in_cells) {
        newcw->squareCell.pixmap_height_in_cells = 
	curcw->squareCell.pixmap_height_in_cells;
        XtWarning("SquareCell: pixmap_height_in_cells cannot be set by XtSetValues.\n");
    }
    return do_redisplay;
}
static void
Destroy(w)
Widget w;
{
    SquareCellWidget cw = (SquareCellWidget) w;
    if (cw->squareCell.big_picture)
        XFreePixmap(XtDisplay(cw), cw->squareCell.big_picture);
    if (cw->squareCell.draw_gc)
        XFreeGC(XtDisplay(cw), cw->squareCell.draw_gc);
    if (cw->squareCell.undraw_gc)
        XFreeGC(XtDisplay(cw), cw->squareCell.undraw_gc);
    if (cw->squareCell.copy_gc)
        XFreeGC(XtDisplay(cw), cw->squareCell.copy_gc);
    /* Free memory allocated with Calloc.  This was done
     * only if application didn't supply cell array.
     */
    if (!cw->squareCell.user_allocated)
        XtFree((char *)cw->squareCell.cell);
}
static void
DrawCell(w, event)
Widget w;
XEvent *event;
{
    SquareCellWidget cw = (SquareCellWidget) w;
    DrawPixmaps(cw->squareCell.draw_gc, DRAW, cw, event);
}
static void
UndrawCell(w, event)
Widget w;
XEvent *event;
{
    SquareCellWidget cw = (SquareCellWidget) w;
    DrawPixmaps(cw->squareCell.undraw_gc, UNDRAW, cw, event);
}
static void
ToggleCell(w, event)
Widget w;
XEvent *event;
{
    SquareCellWidget cw = (SquareCellWidget) w;
    static int oldx = -1, oldy = -1;
    GC gc;
    int mode;
    int newx, newy;
    /* This is strictly correct, but doesn't
     * seem to be necessary */
    if (event->type == ButtonPress) {
        newx = (cw->squareCell.cur_x + ((XButtonEvent *)event)->x) / 
        cw->squareCell.cell_size_in_pixels;
        newy = (cw->squareCell.cur_y + ((XButtonEvent *)event)->y) / 
        cw->squareCell.cell_size_in_pixels;
    }
    else  {
        newx = (cw->squareCell.cur_x + ((XMotionEvent *)event)->x) / 
        cw->squareCell.cell_size_in_pixels;
        newy = (cw->squareCell.cur_y + ((XMotionEvent *)event)->y) / 
        cw->squareCell.cell_size_in_pixels;
    }
    if ((mode = cw->squareCell.cell[newx + newy * cw->squareCell.pixmap_width_in_cells]) == DRAWN) {
        gc = cw->squareCell.undraw_gc;
        mode = UNDRAW;
    }
    else {
        gc = cw->squareCell.draw_gc;
        mode = DRAW;
    }
    if (oldx != newx || oldy != newy) {
        oldx = newx;
        oldy = newy;
        DrawPixmaps(gc, mode, cw, event);
    } 
}
static void
DrawPixmaps(gc, mode, w, event)
GC gc;
int mode;
Widget w;
XButtonEvent *event;
{
    SquareCellWidget cw = (SquareCellWidget) w;
    int newx = (cw->squareCell.cur_x + event->x) / 
	   cw->squareCell.cell_size_in_pixels;
    int newy = (cw->squareCell.cur_y + event->y) / 
	   cw->squareCell.cell_size_in_pixels;
    XExposeEvent fake_event;
    /* if already done, return */
    if (cw->squareCell.cell[newx + newy * cw->squareCell.pixmap_width_in_cells] == mode)
        return;
    /* otherwise, draw or undraw */
    XFillRectangle(XtDisplay((Widget)cw), cw->squareCell.big_picture, gc,
	  cw->squareCell.cell_size_in_pixels*newx + 2, 
        cw->squareCell.cell_size_in_pixels*newy + 2, 
        (unsigned int)cw->squareCell.cell_size_in_pixels - 3, 
        (unsigned int)cw->squareCell.cell_size_in_pixels - 3);
    cw->squareCell.cell[newx + newy * cw->squareCell.pixmap_width_in_cells] = mode;
    info.mode = mode;
    info.newx = newx;
    info.newy = newy;
    fake_event.x = cw->squareCell.cell_size_in_pixels * newx - cw->squareCell.cur_x;
    fake_event.y = cw->squareCell.cell_size_in_pixels * newy - cw->squareCell.cur_y;
    fake_event.width = cw->squareCell.cell_size_in_pixels;
    fake_event.height = cw->squareCell.cell_size_in_pixels;
    Redisplay(cw, &fake_event);
    XtCallCallbacks((Widget)cw, XavsNtoggleCallback, &info);
}
CreateBigPixmap(w)
Widget w;
{
    SquareCellWidget cw = (SquareCellWidget) w;
    /* always a 1 bit deep pixmap, regardless of screen depth */
    cw->squareCell.big_picture = XCreatePixmap(XtDisplay(cw),
	  RootWindow(XtDisplay(cw), DefaultScreen(XtDisplay(cw))),
	  cw->squareCell.pixmap_width_in_pixels + 2, 
	  cw->squareCell.pixmap_height_in_pixels + 2, 1);
}
DrawIntoBigPixmap(w)
Widget w;
{
    SquareCellWidget cw = (SquareCellWidget) w;
    int n_horiz_segments, n_vert_segments;
    XSegment segment[MAXLINES];
    register int x, y;
    XFillRectangle(XtDisplay(cw), cw->squareCell.big_picture,
        cw->squareCell.undraw_gc, 0, 0, 
        cw->squareCell.pixmap_width_in_pixels 
        + 2, cw->squareCell.pixmap_height_in_pixels + 2);
    n_horiz_segments = cw->squareCell.pixmap_height_in_cells + 1;
    n_vert_segments = cw->squareCell.pixmap_width_in_cells + 1;
    for (x = 0; x < n_horiz_segments; x++) {
        segment[x].x1 = 0;
        segment[x].x2 = (short) cw->squareCell.pixmap_width_in_pixels;
        segment[x].y1 = (short) cw->squareCell.cell_size_in_pixels * x;
        segment[x].y2 = (short) cw->squareCell.cell_size_in_pixels * x;
    }
    XDrawSegments(XtDisplay(cw), cw->squareCell.big_picture, cw->squareCell.draw_gc, segment, n_horiz_segments);
    for (y = 0; y < n_vert_segments; y++) {
        segment[y].x1 = (short) y * cw->squareCell.cell_size_in_pixels;
        segment[y].x2 = (short) y * cw->squareCell.cell_size_in_pixels;
        segment[y].y1 = 0;
        segment[y].y2 = (short) cw->squareCell.pixmap_height_in_pixels;
    }
    XDrawSegments(XtDisplay(cw), cw->squareCell.big_picture, cw->squareCell.draw_gc, segment, n_vert_segments);
    /* draw current cell array into pixmap */
    for (x = 0; x < cw->squareCell.pixmap_width_in_cells; x++) {
        for (y = 0; y < cw->squareCell.pixmap_height_in_cells; y++) {
	  if (cw->squareCell.cell[x + (y * cw->squareCell.pixmap_width_in_cells)] == DRAWN)
	DoCell(cw, x, y, cw->squareCell.draw_gc);
	  else
	DoCell(cw, x, y, cw->squareCell.undraw_gc);
        }
    }
}
/* A Public function, not static */
char *
SquareCellGetArray(w, width_in_cells, height_in_cells)
Widget w;
int *width_in_cells, *height_in_cells;
{
    SquareCellWidget cw = (SquareCellWidget) w;
    *width_in_cells = cw->squareCell.pixmap_width_in_cells;
    *height_in_cells = cw->squareCell.pixmap_height_in_cells;
    return (cw->squareCell.cell);
}
static void
Resize(w)
Widget w;
{
    SquareCellWidget cw = (SquareCellWidget) w;
    /* resize does nothing unless new size is bigger than entire pixmap */
    if ((cw->core.width > cw->squareCell.pixmap_width_in_pixels) &&
	  (cw->core.height > cw->squareCell.pixmap_height_in_pixels)) {
        /* 
         * Calculate the maximum cell size that will allow the
         * entire bitmap to be displayed.
         */
        Dimension w_temp_cell_size_in_pixels, h_temp_cell_size_in_pixels;
        Dimension new_cell_size_in_pixels;
    
        w_temp_cell_size_in_pixels = cw->core.width / cw->squareCell.pixmap_width_in_cells;
        h_temp_cell_size_in_pixels = cw->core.height / cw->squareCell.pixmap_height_in_cells;
    
        if (w_temp_cell_size_in_pixels < h_temp_cell_size_in_pixels)
	  new_cell_size_in_pixels = w_temp_cell_size_in_pixels;
        else
	  new_cell_size_in_pixels = h_temp_cell_size_in_pixels;
    
        /* if size change mandates a new pixmap, make one */
        if (new_cell_size_in_pixels != cw->squareCell.cell_size_in_pixels)
	  ChangeCellSize(cw, new_cell_size_in_pixels);
    }
}
static void
ChangeCellSize(w, new_cell_size)
Widget w;
int new_cell_size;
{
    SquareCellWidget cw = (SquareCellWidget) w;
    int x, y;
    cw->squareCell.cell_size_in_pixels = new_cell_size;
    /* recalculate variables based on cell size */
    cw->squareCell.pixmap_width_in_pixels = 
	   cw->squareCell.pixmap_width_in_cells * 
	   cw->squareCell.cell_size_in_pixels;
    cw->squareCell.pixmap_height_in_pixels = 
	   cw->squareCell.pixmap_height_in_cells * 
	   cw->squareCell.cell_size_in_pixels;
    
    /* destroy old and create new pixmap of correct size */
    XFreePixmap(XtDisplay(cw), cw->squareCell.big_picture);
    CreateBigPixmap(cw);
    
    /* draw lines into new pixmap */
    DrawIntoBigPixmap(cw);
    
    /* draw current cell array into pixmap */
    for (x = 0; x < cw->squareCell.pixmap_width_in_cells; x++) {
        for (y = 0; y < cw->squareCell.pixmap_height_in_cells; y++) {
	  if (cw->squareCell.cell[x + (y * cw->squareCell.pixmap_width_in_cells)] == DRAWN)
	DoCell(cw, x, y, cw->squareCell.draw_gc);
	  else
	DoCell(cw, x, y, cw->squareCell.undraw_gc);
        }
    }
}
static void
DoCell(w, x, y, gc)
Widget w;
int x, y;
GC gc;
{
    SquareCellWidget cw = (SquareCellWidget) w;
        /* otherwise, draw or undraw */
    XFillRectangle(XtDisplay(cw), cw->squareCell.big_picture, gc,
	   cw->squareCell.cell_size_in_pixels * x + 2,
	   cw->squareCell.cell_size_in_pixels * y + 2,
	   (unsigned int)cw->squareCell.cell_size_in_pixels - 3,
	   (unsigned int)cw->squareCell.cell_size_in_pixels - 3);
}
static XtGeometryResult QueryGeometry(w, proposed, answer)
Widget w;
XtWidgetGeometry *proposed, *answer;
{
    SquareCellWidget cw = (SquareCellWidget) w;
	/* set fields we care about */
    answer->request_mode = CWWidth | CWHeight;
    /* initial width and height */
    if (cw->squareCell.show_all == True)
        answer->width = cw->squareCell.pixmap_width_in_pixels;
    else
        answer->width = (cw->squareCell.pixmap_width_in_pixels > 
	DEFAULTWIDTH) ? DEFAULTWIDTH : 
	cw->squareCell.pixmap_width_in_pixels;
    if (cw->squareCell.show_all == True)
        answer->height = cw->squareCell.pixmap_height_in_pixels;
    else
        answer->height = (cw->squareCell.pixmap_height_in_pixels > 
	DEFAULTWIDTH) ? DEFAULTWIDTH : 
	cw->squareCell.pixmap_height_in_pixels;
    if (  ((proposed->request_mode & (CWWidth | CWHeight))
	  == (CWWidth | CWHeight)) &&
	  proposed->width == answer->width &&
	  proposed->height == answer->height)
        return XtGeometryYes;
    else if (answer->width == cw->core.width &&
	  answer->height == cw->core.height)
        return XtGeometryNo;
    else
        return XtGeometryAlmost;
}

>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtInstallAccelerators Xt12
void
XtInstallAccelerators(destination, source)
>>ASSERTION Good A
A successful call to 
void XtInstallAccelerators(destination, source)
shall merge the accelerator specified by the 
XtNaccelerators resource value for the widget
.A source
into the translation table of the widget
.A destination
such that event sequences that occur in the
destination widget when the source widget is sensitive
will cause the source widget accelerator actions 
to be executed.
>>CODE
pid_t pid2;
int invoked = 0;
XtAccelerators accelerator;
static char accel_good[] = "#override \n\
	<ButtonPress>:	XtACT_Proc()";
static XtActionsRec actions[] = {
	 {"XtACT_Proc",	(XtActionProc)XtACT_Proc},
};

	FORK(pid2);
	avs_xt_hier("Tinaclrts1", "XtInstallAccelerators");
	tet_infoline("PREP: Register action table");
	XtAppAddActions(app_ctext, actions, 1);
	tet_infoline("PREP: Parse accelerator table");
	accelerator = XtParseAcceleratorTable(accel_good);
	tet_infoline("PREP: Set accelerator table");
	XtVaSetValues(rowcolw, XtNaccelerators, accelerator, NULL);
	tet_infoline("TEST: Install accelerator destination = boxw1 source = rowcolw");
	XtInstallAccelerators(boxw1, rowcolw);
	tet_infoline("TEST: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	send_event(boxw1, ButtonPress, ButtonPressMask, TRUE);
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Accelerator was invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtACT_Proc invoked status");
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to
void XtInstallAccelerators(destination, source)
when the display_accelerator field for the widget
.A source
is non-NULL shall call the procedure specified by that field
with the source widget and a string representation of the 
accelerator table passed as arguments.
>>CODE
pid_t pid2;
int invoked = 0;
XtAccelerators accelerator;
static char accel_good[] = "#override \n\
	<ButtonPress>:	XtACT_Proc2()";
static XtActionsRec actions[] = {
	 {"XtACT_Proc2",	(XtActionProc)XtACT_Proc2},
};

	FORK(pid2);
	avs_xt_hier("Tinaclrts1", "XtInstallAccelerators");
	tet_infoline("PREP: Register action table");
	XtAppAddActions(app_ctext, actions, 1);
	tet_infoline("PREP: Parse accelerator table");
	accelerator = XtParseAcceleratorTable(accel_good);
	squarew = XtVaCreateWidget("squarew",
		    squareCellWidgetClass,
		    boxw1,
		    NULL);
	tet_infoline("PREP: Set accelerator table");
	XtVaSetValues(squarew, XtNaccelerators, accelerator, NULL);
	tet_infoline("TEST: Install accelerator");
	XtInstallAccelerators(boxw1, squarew);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: display_accelerator procedure was invoked");
	invoked = avs_get_event(2);
	check_dec(1, invoked, "display_accelerator procedure invocations");
	tet_result(TET_PASS);
