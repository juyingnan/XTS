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
>># File: tset/Xt11/XtGetValues/XtGetValues.m
>># 
>># Description:
>>#	Tests for XtGetValues()
>># 
>># Modifications:
>># $Log: tgtvalues.m,v $
>># Revision 1.1  2005-02-12 14:37:54  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:37:49  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:00:47  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:28:53  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:25:26  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:20:35  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:15:37  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>
#include <X11/Xaw/Form.h>
#include <xt/SquareCelP.h>
#include <AvsForm.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;


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
static void GetValuesHook();
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
	/* get_values_hook	*/ GetValuesHook,
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
GetValuesHook(w, args, num_args)
Widget w;
ArgList args ;
Cardinal *num_args ;
{
   avs_set_event(1,1);
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
>>TITLE XtGetValues Xt11
void
XtGetValues(object, args, num_args)
>>ASSERTION Good A
A successful call to 
void XtGetValues(object, args, num_args)
shall copy the resource value from the instance structure of the 
widget 
.A object 
for the resource specified in the name field of each member of
the argument list 
.A args
to the location specified by the corresponding value field.
>>CODE
Widget squarew;
Arg setargs[2], getargs[2];
int invoked = 0;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tgtvalues1", "XtGetValues");
	tet_infoline("PREP: Create Square Cell widget");
	squarew = XtVaCreateManagedWidget("squarew",
			squareCellWidgetClass, 
			boxw1,
			(char *)NULL);
	tet_infoline("PREP: Set resource values");
	setargs[0].name = XavsNcurX;
	setargs[0].value = (XtArgVal) 10;
	setargs[1].name = XavsNcurY;
	setargs[1].value = (XtArgVal) 10;
	XtSetValues(squarew, setargs, 2);
	tet_infoline("PREP: Get resource values");
	getargs[0].name = XavsNcurX;
	getargs[1].name = XavsNcurY;
	getargs[0].value = (XtArgVal)malloc(sizeof(int));
	getargs[1].value = (XtArgVal)malloc(sizeof(int));
	XtGetValues(squarew, getargs, 2);
	tet_infoline("TEST: Resource values");
	check_dec(10, *((int *)getargs[0].value), XavsNcurX);
	check_dec(10, *((int *)getargs[1].value), XavsNcurY);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When the class of the specified widget's parent 
is a subclass of constraintWidgetClass
a call to 
void XtGetValues(object, args, num_args)
shall obtain the resource values from the widget instance for any 
constraint resources specified in the argument list.
>>CODE
Widget formw_good , labelw_good;
Arg getargs[1];
Arg setargs[1];
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tgtvalues2", "XtGetValues");
	tet_infoline("PREP: Create formw_good widget subclass of constraintWidgetClass");
	tet_infoline(ebuf);
	formw_good = (Widget) CreateFormWidget(boxw1);
	tet_infoline("PREP: Create label widget Hello");
	labelw_good = (Widget) CreateLabelWidget("Hello", formw_good);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Set XtNresizable constraint resource value ");
	setargs[0].name = XtNresizable;
	setargs[0].value = (XtArgVal) TRUE;
	XtSetValues(labelw_good, setargs, 1);
	tet_infoline("PREP: Get XtNresizable constraint resource value");
	getargs[0].name = XtNresizable;
	getargs[0].value = (XtArgVal)malloc(sizeof(unsigned char));
	XtGetValues(labelw_good, getargs, 1);
	tet_infoline("TEST: XtNresizable resource value");
	check_dec(TRUE, *((Boolean *)getargs[0].value),XtNresizable);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When a resource specified in the argument list is not found in any resource
list for the specified widget a call to 
void XtGetValues(object, args, num_args)
shall not modify the value at the location specified by the corresponding
value field.
>>CODE
Arg getargs[1];
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tgtvalues3", "XtGetValues");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get bogus resource NoSuchResource value");
	getargs[0].name = "NoSuchResource";
	getargs[0].value =	10;
	XtGetValues(rowcolw, getargs, 1);
	tet_infoline("TEST: Address field is not modified");
	check_dec(10, getargs[0].value, "NoSuchResource");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
A call to 
void XtGetValues(object, args, num_args)
shall call the get_values_hook procedures in the widget's 
class and superclass records that are non-NULL in a
superclass-to-subclass order.
>>CODE
Widget squarew;
Arg setargs[2], getargs[2];
int invoked = 0;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tgtvalues4", "XtGetValues");
	tet_infoline("PREP: Create Square Cell widget");
	squarew = XtVaCreateManagedWidget("squarew",
			squareCellWidgetClass, boxw1, NULL);
	tet_infoline("PREP: Set resource values");
	setargs[0].name = XavsNcurX;
	setargs[0].value = (XtArgVal) 10;
	setargs[1].name = XavsNcurY;
	setargs[1].value = (XtArgVal) 10;
	XtSetValues(squarew, setargs, 2);
	tet_infoline("PREP: Get resource values");
	getargs[0].name = XavsNcurX;
	getargs[1].name = XavsNcurY;
	getargs[0].value = (XtArgVal)malloc(sizeof(int));
	getargs[1].value = (XtArgVal)malloc(sizeof(int));
	XtGetValues(squarew, getargs, 2);
	check_dec(10, *((int *)getargs[0].value), XavsNcurX);
	check_dec(10, *((int *)getargs[1].value), XavsNcurY);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Get_values_hook procedure GetValuesHook was invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "GetValuesHook invocations count");
	tet_result(TET_PASS);
>>ASSERTION Good A
When the class of the specified widget's parent 
is a subclass of constraintWidgetClass, any of the parent's
class or superclass records have declared ConstraintClassExtension
records in the Constraint class part extension field with a record
type of NULLQUARK, and the get_values_hook field in the extension
record is non-NULL, a call to 
void XtGetValues(object, args, num_args)
shall call the get_values_hook procedures in superclass-to-subclass order.
>>CODE
Widget squarew;
Arg setargs[2], getargs[2];
int invoked = 0;
pid_t pid2;
Widget formw_good, labelw_good;

	/*avsForm is a subclass of constraint with the appropriate
	get_value_hook procedures.  See libXtTest AvsForm.c*/
	FORK(pid2);
	avs_xt_hier("Tgtvalues4", "XtGetValues");
	tet_infoline("PREP: Create avsform widget in boxw1 widget");
	formw_good = XtCreateManagedWidget("avsform",
			avsformWidgetClass,
			boxw1,
			NULL,
			0);
	labelw_good = (Widget) CreateLabelWidget("Hello", formw_good);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get XtNresizable constraint resource value");
	getargs[0].name = XtNresizable;
	getargs[0].value = (XtArgVal)malloc(sizeof(unsigned char));
	XtGetValues(labelw_good, getargs, 1);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Parent's extension get_values_hook procedure GetValuesHook was invoked");
	invoked = avs_get_event(7);
	check_dec(1, invoked, "parent's extension get_values_hook invocation count");
	tet_result(TET_PASS);
