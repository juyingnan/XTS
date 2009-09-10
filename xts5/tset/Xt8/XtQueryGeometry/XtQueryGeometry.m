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
$Header: /cvs/xtest/xtest/xts5/tset/Xt8/XtQueryGeometry/XtQueryGeometry.m,v 1.1 2005-02-12 14:38:23 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt8/XtQueryGeometry/XtQueryGeometry.m
>># 
>># Description:
>>#	Tests for XtQueryGeometry()
>># 
>># Modifications:
>># $Log: tqrygomty.m,v $
>># Revision 1.1  2005-02-12 14:38:23  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:36:56  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:59:48  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:28:03  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:37  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:17:55  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:22:15  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>
#include <xt/SquareCelP.h>

void test5A();
void test6A();

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;

Dimension	height_ret;
Dimension	width_ret;

int test_for;

/*
 * SquareCell.c - Square Widget 
 */
#define INTERNAL_WIDTH	2
#define INTERNAL_HEIGHT 4
#define DEFAULT_PIXMAP_WIDTH	1 /* in cells */
#define DEFAULT_PIXMAP_HEIGHT	1 /* in cells */
#define DEFAULT_CELL_SIE	20 /* in pixels */
/* values for instance variable is_drawn */
#define DRAWN 1
#define UNDRAWN 0
/* modes for drawing */
#define DRAW 1
#define UNDRAW 0
#define MAXLINES 10	/* max of horiz or vertical cells */
#define SCROLLBARWIDTH 15
#define DEFAULTWIDTH 300 /* widget size when show_all is False */
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
	"<Btn1Down>:	DrawCell()		\n\
	<Btn2Down>:	UndrawCell()	 \n\
	<Btn3Down>:	ToggleCell()	 \n\
	<Btn1Motion>: DrawCell()		\n\
	<Btn2Motion>: UndrawCell()	 \n\
	<Btn3Motion>: ToggleCell()";
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
	/* superclass	*/ (WidgetClass) &coreClassRec,
	/* class_name	*/ "SquareCell",
	/* widget_size	*/ sizeof(SquareCellRec),
	/* class_initialize	*/ NULL,
	/* class_part_initialize	*/ NULL,
	/* class_inited	*/ FALSE,
	/* initialize	*/ Initialize,
	/* initialize_hook	*/ NULL,
	/* realize	 */ XtInheritRealize,
	/* actions	 */ actions,
	/* num_actions	*/ XtNumber(actions),
	/* resources	 */ resources,
	/* num_resources	 */ XtNumber(resources),
	/* xrm_class	 */ NULLQUARK,
	/* compress_motion	*/ TRUE,
	/* compress_exposure	*/ XtExposeCompressMultiple,
	/* compress_enterleave	*/ TRUE,
	/* visible_interest	*/ FALSE,
	/* destroy	 */ Destroy,
	/* resize	 */ Resize,
	/* expose	 */ Redisplay,
	/* set_values	*/ SetValues,
	/* set_values_hook	*/ NULL,
	/* set_values_almost	*/ XtInheritSetValuesAlmost,
	/* get_values_hook	*/ NULL,
	/* accept_focus	*/ NULL,
	/* version	 */ XtVersion,
	/* callback_private	*/ NULL,
	/* tm_table	*/ defaultTranslations,
	/* query_geometry	*/ QueryGeometry,
	/* display_accelerator	*/ XtInheritDisplayAccelerator,
	/* extension	 */ NULL
	},
	{/* simple_class fields */
	/* change_sensitive */	XtInheritChangeSensitive,
	},
	{
	/* extension	*/	0,
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
	* kludge but isn't. This GC is used for drawing
	* into a pixmap of depth one. Real colors are applied with a
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
	/* this looks like a kludge but isn't. This GC is used for drawing
	* into a pixmap of depth one. Real colors are applied as the 
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
	* Check instance values set by resources that may be invalid. 
	*/
	if ((new->squareCell.pixmap_width_in_cells < 1) ||
	 (new->squareCell.pixmap_height_in_cells < 1)) {
	XtWarning("SquareCell: pixmapWidth and/or pixmapHeight is too small (using 10 x 10)"); 
	new->squareCell.pixmap_width_in_cells = 10;
	new->squareCell.pixmap_height_in_cells = 10;
	}
	if (new->squareCell.cell_size_in_pixels < 5) {
	XtWarning("SquareCell: cellSize is too small (using 5)"); 
	new->squareCell.cell_size_in_pixels = 5;
	}
	if ((new->squareCell.cur_x < 0) || (new->squareCell.cur_y < 0)) {
	XtWarning("SquareCell: cur_x and cur_y must be non-negative (using 0, 0)"); 
	new->squareCell.cur_x = 0;
	new->squareCell.cur_y = 0;
	}
	if (new->squareCell.cell == NULL)
	new->squareCell.cell = XtCalloc( 
	new->squareCell.pixmap_width_in_cells * 
	new->squareCell.pixmap_height_in_cells, sizeof(char));
	else
	new->squareCell.user_allocated = True; /* user supplied cell array */
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
	if (event) { /* called from btn-event or expose */
	x = event->x;
	y = event->y; 
	width = event->width;
	height = event->height;
	} 
	else {	/* called because complete redraw */
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
	 newcw->squareCell.pixmap_width_in_cells) {
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
	XFreePixmap(XtDisplay((Widget)cw), cw->squareCell.big_picture);
	if (cw->squareCell.draw_gc)
	XFreeGC(XtDisplay((Widget)cw), cw->squareCell.draw_gc);
	if (cw->squareCell.undraw_gc)
	XFreeGC(XtDisplay((Widget)cw), cw->squareCell.undraw_gc);
	if (cw->squareCell.copy_gc)
	XFreeGC(XtDisplay((Widget)cw), cw->squareCell.copy_gc);
	/* Free memory allocated with Calloc. This was done
	* only if application didn't supply cell array.
	*/
	if (!cw->squareCell.user_allocated)
	XtFree(cw->squareCell.cell);
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
	else {
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
	cw->squareCell.big_picture = XCreatePixmap(XtDisplay((Widget)cw),
	 RootWindow(XtDisplay((Widget)cw), DefaultScreen(XtDisplay((Widget)cw))),
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
	XFillRectangle(XtDisplay((Widget)cw), cw->squareCell.big_picture,
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
	XDrawSegments(XtDisplay((Widget)cw), cw->squareCell.big_picture, cw->squareCell.draw_gc, segment, n_horiz_segments);
	for (y = 0; y < n_vert_segments; y++) {
	segment[y].x1 = (short) y * cw->squareCell.cell_size_in_pixels;
	segment[y].x2 = (short) y * cw->squareCell.cell_size_in_pixels;
	segment[y].y1 = 0;
	segment[y].y2 = (short) cw->squareCell.pixmap_height_in_pixels;
	}
	XDrawSegments(XtDisplay((Widget)cw), cw->squareCell.big_picture, cw->squareCell.draw_gc, segment, n_vert_segments);
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
	XFreePixmap(XtDisplay((Widget)cw), cw->squareCell.big_picture);
	CreateBigPixmap((Widget)cw);
	
	/* draw lines into new pixmap */
	DrawIntoBigPixmap((Widget)cw);
	
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
	XFillRectangle(XtDisplay((Widget)cw), cw->squareCell.big_picture, gc,
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

	if (test_for == 2) {
		tet_infoline("TEST: request_mode passed to query_geometry procedure");
		if (proposed->request_mode != 0) {
			sprintf(ebuf, "ERROR: Expected request_mode = 0, is %d", proposed->request_mode);
			tet_infoline(ebuf);
			tet_result(TET_FAIL);
		}
	}
	avs_set_event(1,1);
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
	height_ret = answer->height;
	width_ret = answer->width;
	if ( ((proposed->request_mode & (CWWidth | CWHeight))
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
>>CFILES tqrygomty.c
>>TITLE XtQueryGeometry Xt8
XtGeometryResult
XtQueryGeometry(w, intended, preferred_return)
>>ASSERTION Good A
A successful call to 
XtGeometryResult XtQueryGeometry(w, intended, preferred_return)
when the query_geometry field of the widget
.A w
is not NULL shall invoke the procedure specified by this field,
passing
.A w,
.A intended,
and
.A preferred_return
as arguments, and return the value this procedure returns.
>>CODE
XtWidgetGeometry intended, geom;
Widget squarew;
int result;
int invoked = 0;
pid_t pid2;

	FORK(pid2);
	test_for = 1;
	avs_xt_hier("Tqrygomty1", "XtQueryGeometry");
	tet_infoline("PREP: Create Square Cell widget");
	squarew = XtVaCreateManagedWidget("squarew",
			squareCellWidgetClass, boxw1, NULL);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Call XtQueryGeometry");
	intended.request_mode = CWX|CWY|CWWidth|CWHeight|CWBorderWidth;
	result = XtQueryGeometry(squarew, &intended, &geom);
	KROF(pid2);
	tet_infoline("TEST: Query_geometry procedure was invoked");
	invoked = avs_get_event(1);
	if (!invoked) {
		sprintf(ebuf, "ERROR: Procedure query_geometry not invoked");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to 
XtGeometryResult XtQueryGeometry(w, intended, preferred_return)
when the query_geometry field of the widget
.A w
is not NULL and 
.A intended
is NULL shall pass a pointer to an XtWidgetGeometry structure
that has the request_mode set to zero as the request argument to
the query_geometry procedure.
>>CODE
XtWidgetGeometry intended, geom;
Widget squarew;
int result;
int invoked = 0;
pid_t pid2;

	FORK(pid2);
	test_for = 2;
	avs_xt_hier("Tqrygomty1", "XtQueryGeometry");
	tet_infoline("PREP: Create Square Cell widget");
	squarew = XtVaCreateManagedWidget("squarew",
			squareCellWidgetClass, boxw1, NULL);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Call XtQueryGeometry");
	result = XtQueryGeometry(squarew, NULL, &geom);
	KROF(pid2);
	tet_infoline("TEST: Query_geometry procedure was invoked");
	invoked = avs_get_event(1);
	if (!invoked) {
		sprintf(ebuf, "ERROR: Procedure query_geometry not invoked");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to 
XtGeometryResult XtQueryGeometry(w, intended, preferred_return)
when the query_geometry field of the widget
.A w
is not NULL shall set the fields of 
.A preferred_return
corresponding to bits that are not set in preferred_return->request_mode to
the current values for the widget instance, with fields corresponding to
bits set in
.A preferred_return
set to values by the widget's query_geometry procedure.
>>CODE
XtWidgetGeometry intended, geom;
Widget squarew;
int result;
int invoked = 0;
pid_t pid2;

	FORK(pid2);
	test_for = 3;
	avs_xt_hier("Tqrygomty1", "XtQueryGeometry");
	tet_infoline("PREP: Create Square Cell widget");
	squarew = XtVaCreateManagedWidget("squarew",
			squareCellWidgetClass, boxw1, NULL);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	memset(&geom, -1, sizeof(geom));
	tet_infoline("PREP: Call XtQueryGeometry");
	intended.request_mode = CWX|CWY|CWWidth|CWHeight|CWBorderWidth;
	result = XtQueryGeometry(squarew, &intended, &geom);
	tet_infoline("TEST: preferred_return->request_mode");
	check_dec(CWWidth | CWHeight, (long)geom.request_mode, "preferred_return->request_mode");
	tet_infoline("TEST: Returned values");
	check_dec((long)width_ret, (long)geom.width, "preferred_return.width");
	check_dec((long)height_ret, (long)geom.height, "preferred_return.height");
	check_not_dec(-1, (long)geom.x, "preferred_return.height");
	check_not_dec(-1, (long)geom.y, "preferred_return.height");
	check_not_dec(-1, (long)geom.border_width, "preferred_return.height");
	KROF(pid2);
	tet_infoline("TEST: Query_geometry procedure was invoked");
	invoked = avs_get_event(1);
	if (!invoked) {
		sprintf(ebuf, "ERROR: Procedure query_geometry not invoked");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to 
XtGeometryResult XtQueryGeometry(w, intended, preferred_return)
when the query_geometry field of the widget
.A w
is not NULL and the query_geometry procedure does not set
CWStackMode in preferred_return->return_mode shall set
preferred_return.stack_mode to XtSMDontChange.
>>CODE
XtWidgetGeometry intended, geom;
Widget squarew;
int result;
int invoked = 0;
pid_t pid2;

	FORK(pid2);
	test_for = 4;
	avs_xt_hier("Tqrygomty1", "XtQueryGeometry");
	tet_infoline("PREP: Create Square Cell widget");
	squarew = XtVaCreateManagedWidget("squarew",
			squareCellWidgetClass, boxw1, NULL);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Call XtQueryGeometry");
	intended.request_mode = CWX|CWY|CWWidth|CWHeight|CWBorderWidth;
	result = XtQueryGeometry(squarew, NULL, &geom);
	tet_infoline("TEST: preferred_return.stack_mode");
	check_dec(XtSMDontChange, (long)geom.stack_mode, "preferred_return.stack_mode");
	KROF(pid2);
	tet_infoline("TEST: Query_geometry procedure was invoked");
	invoked = avs_get_event(1);
	if (!invoked) {
		sprintf(ebuf, "ERROR: Procedure query_geometry not invoked");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to 
XtGeometryResult XtQueryGeometry(w, intended, preferred_return)
when the query_geometry field of the widget
.A w
is NULL shall set all the fields in 
.A preferred_return
to the current values for the widget instance
and return XtGeometryYes.
>>CODE

	test_for = 5;
	test5A();
>>ASSERTION Good A
A successful call to 
XtGeometryResult XtQueryGeometry(w, intended, preferred_return)
when the query_geometry field of the widget
.A w
is NULL shall set preferred_return.stack_mode to XtSMDontChange.
>>CODE

	test_for = 6;
	test6A();
