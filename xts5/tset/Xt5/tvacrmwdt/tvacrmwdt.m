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
$Header: /cvs/xtest/xtest/xts5/tset/Xt5/tvacrmwdt/tvacrmwdt.m,v 1.1 2005-02-12 14:38:14 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>>#
>># Project: VSW5
>># 
>># File: tset/Xt5/tvacrmwdt/tvacrmwdt.m
>># 
>># Description:
>>#	Tests for XtVaCreateManagedWidget()
>># 
>># Modifications:
>># $Log: tvacrmwdt.m,v $
>># Revision 1.1  2005-02-12 14:38:14  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:36:35  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:59:27  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:27:44  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:18  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:16:35  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:20:34  andy
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
void XtWMH_Proc(str1, str2, str3, str4, str5, car)
String str1, str2, str3, str4, *str5;
Cardinal *car;
{
	avs_set_event(1,1);
}

/*
** XtEMH_Proc
*/
void XtEMH_Proc(str1, str2, str3, str4, str5, car)
String str1, str2, str3, str4, *str5;
Cardinal *car;
{
	avs_set_event(1,1);
	exit(0);
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
    /* display_accelerator       */ XtInheritDisplayAccelerator,
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
>>TITLE XtVaCreateManagedWidget Xt5
Widget
XtVaCreateManagedWidget(name, widget_class, parent, ...)
>>ASSERTION Good A
A call to 
Widget XtVaCreateManagedWidget(name, widget_class, parent, ...) 
shall create an instance of a widget belonging to the class
widget_class, set the widget to be managed by its parent, and return 
a pointer to the newly created widget instance structure.
>>CODE
Boolean status;
Widget widget_good , labelw_good;
Widget rowcolw_good;

	avs_xt_hier("Tvacrmwdt1", "XtVaCreateManagedWidget");
	tet_infoline("PREP: Create rowcolw_good widget in box1w widget");
	rowcolw_good = (Widget) CreateRowColWidget(boxw1);
	tet_infoline("PREP: Create label widget Hello");
	labelw_good = XtVaCreateManagedWidget(
			"Hello",
			labelWidgetClass,
			rowcolw_good,
			(char *)NULL);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Labelw_good widget is managed");
	status = XtIsManaged(labelw_good);
	check_dec(True, status, "XtIsManaged return value");
	tet_infoline("TEST: Labelw_good widget is child of rowcolumn widget");
	widget_good = (Widget)XtParent(labelw_good);
	if (widget_good == NULL) {
	 	sprintf(ebuf, "ERROR: Expected parent widget instance returned NULL");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	check_str("rowcolw", XtName(widget_good), "widget name");
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to 
Widget XtVaCreateManagedWidget(name, widget_class, parent, ...) 
shall initialize the resource fields of the widget instance using the
the CoreClassPart resource list specified for widget_class and all 
superclasses, overridden by the resource values specified in the varargs style
arguments.
>>CODE
Boolean value_good;
char string[10];
Widget squarew;
Dimension cell_width, cell_height;

	avs_xt_hier("Tvcrtwdgt2", "XtVaCreateManagedWidget");
	tet_infoline("TEST: Create Square Cell widget");
	squarew = XtVaCreateManagedWidget("squarew",
		    squareCellWidgetClass,
		    boxw1,
		    NULL
		    );
	tet_infoline("PREP: Get resource values");
	XtVaGetValues(squarew,
		    XavsNpixmapWidthInCells,
		    &cell_width,
		    XavsNpixmapHeightInCells,
		    &cell_height,
		    (char *)NULL);
	tet_infoline("TEST: Original values returned");
	check_dec(DEFAULT_PIXMAP_WIDTH, cell_width,
			"XavsNpixmapWidthInCells");
	check_dec(DEFAULT_PIXMAP_HEIGHT, cell_height,
			"XavsNpixmapHeightInCells");
	tet_result(TET_PASS);
>>ASSERTION Good A
When parent is a subclass of constraintWidgetClass a successful call to Widget
Widget XtVaCreateManagedWidget(name, widget_class, parent, ...) 
shall initialize the resource fields of the constraint record by
using the constraint resource list specified for the parent's class 
and all superclasses up to constraintWidgetClass, overridden by the resource
values specified in the varargs style arguments.
>>CODE
Boolean value_good;
char string[10];
Widget formw_good, labelw_msg;
char *msg = "Failsafe widget";
Widget labelw_good;
Boolean resizable;

	avs_xt_hier("Tvcrtwdgt3", "XtVaCreateManagedWidget");
	tet_infoline("PREP: Create formw_good widget subclass of constraintWidgetClass");
	formw_good = (Widget) CreateFormWidget(boxw1);
	tet_infoline("PREP: Create failsafe widget in formw_good");
	labelw_msg = (Widget) CreateLabelWidget(msg, formw_good);
	tet_infoline("TEST: Create labelw_good widget Hello");
	labelw_good = XtVaCreateManagedWidget(
			  "Hello",
			   labelWidgetClass,
			   formw_good,
			   XtNresizable,
			   TRUE,
			   NULL
			   );
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get XtNresizable constraint resource value.");
	XtVaGetValues(labelw_good, XtNresizable, &resizable, (char *)NULL);
	tet_infoline("TEST: XtNresizable resource value");
	check_dec(TRUE, resizable, "XtNresizable resource");
	tet_result(TET_PASS);
>>ASSERTION Good B 0
When parent is a subclass of compositeWidgetClass a successful call to 
Widget XtVaCreateManagedWidget(name, widget_class, parent, ...) 
shall call the insert_child procedure of the parent.
>>ASSERTION Good A
A call to 
Widget XtVaCreateManagedWidget(name, widget_class, parent, ...) 
when widget_class is not a member of coreWidgetClass, the class 
of parent is a subclass of compositeWidgetClass, and there is no extension 
record in the composite class part extension field of parent with the 
record_type equal to NULLQUARK shall issue a fatal error.
>>CODE
Boolean value_good;
char string[10];
Widget test_widget, test_widget2;
int status;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tcrwidget5", "XtCreateManagerWidget");
	tet_infoline("PREP: Register error message handler");
	XtAppSetErrorMsgHandler(app_ctext, XtEMH_Proc);
	tet_infoline("TEST: Create composite widget");
	test_widget = XtCreateWidget(
			   "Composite",
			    avsCompWidgetClass,
			    topLevel,
			    NULL,
				0
			    );
	tet_infoline("PREP: Create rect obj in it");
	test_widget2 = XtVaCreateManagedWidget(
			   "RectObj",
			    avsrectObjClass,
			    test_widget,
			    (ArgList)NULL
			    );
	KROF(pid2);
	tet_infoline("TEST: Error handler was invoked");
	status = avs_get_event(1);
	check_dec(1, status , "handler invocations count");
	tet_result(TET_PASS);
>>ASSERTION Good B 0
A call to 
Widget XtVaCreateManagedWidget(name, widget_class, parent, ...) 
when widget_class is not a member of coreWidgetClass, the class of 
parent is a subclass of compositeWidgetClass, and the accepts_object 
field in the parent's composite class part extension record is False shall 
issue a fatal error.
>>ASSERTION Good B 0
A successful call to 
Widget XtVaCreateManagedWidget(name, widget_class, parent, ...) 
shall invoke the class_initialize procedure for the class
widget_class and all superclasses for which this procedure has not been
invoked prior to this call in a superclass-to-subclass order.
>>ASSERTION Good B 0
A successful call to 
Widget XtVaCreateManagedWidget(name, widget_class, parent, ...) 
when parent belongs to the class constraintWidgetClass or a
subclass thereof shall allocate memory for the constraints of parent
and store the address of this memory in the constraints field of the
widget instance structure.
>>ASSERTION Good B 0
A successful call to 
Widget XtVaCreateManagedWidget(name, widget_class, parent, ...) 
shall initialize the Core non-resource data fields of the widget instance 
structure.
>>ASSERTION Good B 0
A successful call to 
Widget XtVaCreateManagedWidget(name, widget_class, parent, ...) 
shall call the initialize procedure of Object and all
the initialize procedures down to initialize procedure of the widget.
>>ASSERTION Good B 0
A successful call to 
Widget XtVaCreateManagedWidget(name, widget_class, parent, ...) 
when parent belongs to the class contraintWidgetClass
or a subclass thereof shall call all the ConstraintClassPart initialize 
procedures starting at constraintWidgetClass down to ConstraintClassPart 
initialize procedure of the parent.
>>ASSERTION Good B 0
A successful call to 
Widget XtVaCreateManagedWidget(name, widget_class, parent, ...) 
when the varargs style argument specifies the name XtVaTypedArg in place of
a resource name and the second argument following this name is XtRString shall
initialize the resource specified by the first argument following the 
XtVaTypedArg name to the string pointed to by the third argument of a length
specified by the fourth argument following the XtVaTypedArg name argument.
>>ASSERTION Good B 0
A successful call to 
Widget XtVaCreateManagedWidget(name, widget_class, parent, ...) 
when the varargs style argument specifies the name XtVaTypedArg in place of
a resource name, the second argument following this name is not XtRString, and
the fourth argument is less than sizeof(XtArgVal) shall
initialize the resource specified by the first argument following the 
XtVaTypedArg name to the value specified in the third argument following the 
XtVaTypedArg name argument.
>>ASSERTION Good B 0
A successful call to 
Widget XtVaCreateManagedWidget(name, widget_class, parent, ...) 
when the varargs style argument specifies the name XtVaTypedArg in place of
a resource name, the second argument following this argument is not XtRString, 
and the fourth argument is more than sizeof(XtArgVal) shall initialize the 
resource specified by the first argument following the XtVaTypedArg name to 
the value pointed to by the third argument following the XtVaTypedArg name 
argument.
>>ASSERTION Good B 0
A call to 
Widget XtVaCreateManagedWidget(name, widget_class, parent, ...) 
when the varargs style argument specifies the name XtVaTypedArg in place of
a resource name and the type conversion fails during the resource initialization
using the arguments following the XtVaTypedArg argument shall issue a warning 
message.
>>ASSERTION Good B 0
A call to 
Widget XtVaCreateManagedWidget(name, widget_class, parent, ...) 
when the newly created widget has the map_when_managed field set to True and 
parent is realized shall call the change_managed procedure of the parent, 
realize the widget, and map the widget window.
>>ASSERTION Good B 0
On a successful call to 
Widget XtVaCreateManagedWidget(name, widget_class, parent, ...) 
when the newly created widget has the map_when_managed field set to a value 
other than True shall not have its window mapped.
>>ASSERTION Good A
A call to 
Widget XtVaCreateManagedWidget(name, widget_class, parent, ...) 
when parent does not belong to a subclass of compositeWidgetClass shall issue
an invalidParent error.
>>CODE
Boolean status;
Widget labelw_good, labelw_good2, test_widget;
pid_t pid2;
int invoked;

	FORK(pid2);
	avs_xt_hier("Tvacrmwdt", "XtVaCreateManagedWidget");
	XtAppSetErrorMsgHandler(app_ctext, XtEMH_Proc);
	tet_infoline("PREP: Create test widgets");
	labelw_good = XtVaCreateWidget(
			"labelw_good",
			coreWidgetClass,
			boxw1,
			NULL
			);
	(void) ConfigureDimension(topLevel, labelw_good);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Create a widget with non-composite parent");
	labelw_good2 = XtVaCreateManagedWidget(
			"labelw_good2",
			coreWidgetClass,
			labelw_good,
			NULL
			);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Error handler was invoked");
	invoked = avs_get_event(1);
	if (!invoked) {
		sprintf(ebuf, "ERROR: Error handler was not invoked");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
>>ASSERTION Good B 0
A call to 
Widget XtVaCreateManagedWidget(name, widget_class, parent, ...) 
when parent is in the process of being destroyed shall return immediately.
