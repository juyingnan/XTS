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
$Header: /cvs/xtest/xtest/xts5/tset/Xt11/tvastvals/tvastvals.m,v 1.1 2005-02-12 14:37:55 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt11/tvastvals/tvastvals.m
>># 
>># Description:
>>#	Tests for XtVaSetValues()
>># 
>># Modifications:
>># $Log: tvastvals.m,v $
>># Revision 1.1  2005-02-12 14:37:55  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:37:52  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:00:50  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:28:55  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.1  1998/02/24 02:03:28  andy
>># Made test 13 conditional on coverage.
>>#
>># Revision 5.0  1998/01/26 03:25:29  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.2  1998/01/20 19:47:14  andy
>># Added return statement to SetValuesHook procedures and changed
>># compress exposure for squarew to XtExposeNoCompress.
>>#
>># Revision 4.0  1995/12/15 09:20:46  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:15:52  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>
#include <xt/SquareCelP.h>
#include <X11/Xaw/Form.h>
#include <AvsForm.h>
#include <AvsForm2.h>

extern WidgetClass avsCompWidgetClass, avsWidgetClass;
extern WidgetClass avsComp2WidgetClass;

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;

/* procedure XtTMO_Proc */
void XtTMO_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	exit(0);
}
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
static Boolean SetValuesHook();
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
	/* compress_exposure	*/ XtExposeNoCompress,
	/* compress_enterleave	*/ TRUE,
	/* visible_interest	*/ FALSE,
	/* destroy	 */ Destroy,
	/* resize	 */ Resize,
	/* expose	 */ Redisplay,
	/* set_values	*/ SetValues,
	/* set_values_hook	*/ SetValuesHook,
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
	XtWarning("SquareCell: pixmapWidth and/or pixmapHeight is too small (using 10 x 10)."); 
	new->squareCell.pixmap_width_in_cells = 10;
	new->squareCell.pixmap_height_in_cells = 10;
	}
	if (new->squareCell.cell_size_in_pixels < 5) {
	XtWarning("SquareCell: cellSize is too small (using 5)."); 
	new->squareCell.cell_size_in_pixels = 5;
	}
	if ((new->squareCell.cur_x < 0) || (new->squareCell.cur_y < 0)) {
	XtWarning("SquareCell: cur_x and cur_y must be non-negative (using 0, 0)."); 
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

	avs_set_event(6, avs_get_event(6)+1);
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
SetValuesHook(w, args, num_args)
Widget w;
ArgList args;
Cardinal *num_args;
{
	avs_set_event(2,avs_get_event(1)+1);
	return TRUE;
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
	avs_set_event(1,avs_get_event(2)+1);
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
	}
	if (curcw->squareCell.pixmap_height_in_cells != 
	 newcw->squareCell.pixmap_height_in_cells) {
	newcw->squareCell.pixmap_height_in_cells = 
	curcw->squareCell.pixmap_height_in_cells;
	}
	/*force true for test 13*/
	return TRUE;
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
>>TITLE XtVaSetValues Xt11
void
XtVaSetValues(object, ...)
>>ASSERTION Good A
A successful call to
void XtVaSetValues(object, ...) 
shall set the resource value in the instance structure of the
widget
.A object
for the resource specified in the name field of each name/value pair 
of the varargs style variable argument list to the value at 
the location specified by the corresponding value field.
>>CODE
Widget squarew;
int cur_x , cur_y;
int invoked = 0;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tvastvals1", "XtVaSetValues");
	tet_infoline("PREP: Create Square Cell widget");
	squarew = XtVaCreateManagedWidget("squarew",
			squareCellWidgetClass, boxw1, (char *)NULL);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Set resource values");
	XtVaSetValues(squarew, XavsNcurX, 2, XavsNcurY, 2 , (char *)NULL);
	tet_infoline("PREP: Get resource values");
	XtVaGetValues(squarew,
			XavsNcurX, &cur_x, XavsNcurY, &cur_y, (char *)NULL);
	tet_infoline("TEST: Resource values");
	check_dec(2, cur_x, "XavsNcurX");
	check_dec(2, cur_y, "XavsNcurY");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When the class of the specified widget's parent
is a subclass of constraintWidgetClass
a call to
void XtVaSetValues(object, ...) 
shall set the resource values in the widget instance for any
constraint resources specified in the argument list.
>>CODE
Widget pushb_good, formw_good;
Arg getargs[1];
Boolean resizable;
int invoked = 0;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tvastvals4", "XtVaSetValues");
	tet_infoline("PREP: Create formw_good widget subclass of constraint");
	tet_infoline("PREP: widgetclass in boxw1 widget");
	formw_good = (Widget) CreateFormWidget(boxw1);
	tet_infoline("PREP: Create pushb_good gadget");
		pushb_good = (Widget)CreatePushButtonGadget("Hello", formw_good);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Set constraint resource values for pushb_good widget");
	XtVaSetValues(pushb_good, XtNresizable, TRUE, (char *)NULL);
	tet_infoline("PREP: Get constraint resource values");
	XtVaGetValues(pushb_good, XtNresizable, &resizable, (char *)NULL);
	tet_infoline("TEST: Constraint resource values");
	check_dec(TRUE, resizable, "TRUE");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to
void XtVaSetValues(object, ...) 
shall call the set_values procedures for 
.A object
in a superclass-to-subclass order.
>>CODE
Widget squarew;
int cur_x , cur_y;
int invoked = 0;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tvastvals1", "XtVaSetValues");
	tet_infoline("PREP: Create Square Cell widget");
	squarew = XtVaCreateManagedWidget("squarew",
			squareCellWidgetClass, boxw1, (char *)NULL);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Set resource values");
	XtVaSetValues(squarew, XavsNcurX, 2, XavsNcurY, 2 , (char *)NULL);
	tet_infoline("PREP: Get resource values");
	XtVaGetValues(squarew,
			XavsNcurX, &cur_x, XavsNcurY, &cur_y, (char *)NULL);
	tet_infoline("TEST: Resource values");
	check_dec(2, cur_x, "XavsNcurX");
	check_dec(2, cur_y, "XavsNcurY");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Set_values procedure SetValues was invoked");
	invoked = avs_get_event(1);
	if (!invoked) {
		sprintf(ebuf, "ERROR: The procedure SetValues was not invoked");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
>>ASSERTION Good A
A successful call to
void XtVaSetValues(object, ...) 
when a set_values_hook field for
.A object
is non-NULL shall call the procedures specified by that field
immediately after the call to the corresponding set_values
procedure.
>>CODE
Widget squarew;
int cur_x , cur_y;
int invoked = 0;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tvastvals1", "XtVaSetValues");
	tet_infoline("PREP: Create Square Cell widget");
	squarew = XtVaCreateManagedWidget("squarew",
			squareCellWidgetClass, boxw1, (char *)NULL);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Set resource values");
	XtVaSetValues(squarew, XavsNcurX, 2, XavsNcurY, 2 , (char *)NULL);
	tet_infoline("PREP: Get resource values");
	XtVaGetValues(squarew,
			XavsNcurX, &cur_x, XavsNcurY, &cur_y, (char *)NULL);
	tet_infoline("TEST: Resource values");
	check_dec(2, cur_x, "XavsNcurX");
	check_dec(2, cur_y, "XavsNcurY");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: set_values procedure was invoked first");
	invoked = avs_get_event(1);
	if (invoked != 1) {
		sprintf(ebuf, "ERROR: Expected procedure invocation to be #1, is #%d", invoked);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: set_values_hook procedure was invoked second");
	invoked = avs_get_event(2);
	if (invoked != 2) {
		sprintf(ebuf, "ERROR: Expected procedure invocation to be #2, is #%d", invoked);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
>>ASSERTION Good A
When the class of the specified widget's parent
is a subclass of constraintWidgetClass
a call to
void XtVaSetValues(object, ...) 
shall call the constraint set_values procedures from 
constraintWidgetClass on down to the parent's class, passing
to them the specified widget as an argument.
>>CODE
Arg setargs[2];
int cur_x, cur_y;
int invoked = 0;
pid_t pid2;
Widget formw_good , labelw_good, formw_good2;

	FORK(pid2);
	avs_xt_hier("Tstvalues1", "XtSetValues");
	tet_infoline("PREP: Create avsform widget in boxw1 widget");
	formw_good = XtCreateManagedWidget("avsform",
			avsformWidgetClass,
			boxw1,
			NULL,
			0);
	tet_infoline("PREP: Create avsform2 widget in avsform widget");
	formw_good2 = XtCreateManagedWidget("avsform2",
			avsform2WidgetClass,
			formw_good,
			NULL,
			0);
	labelw_good = (Widget) CreateLabelWidget("Hello", formw_good2);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Set constraint resource values for pushb_good widget");
	XtVaSetValues(labelw_good, XtNresizable, TRUE, (char *)NULL);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: set_values procedure two levels up was invoked first");
	invoked = avs_get_event(4);
	if (invoked != 1) {
		sprintf(ebuf, "ERROR: Expected procedure invocation to be #1, is #%d", invoked);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: set_values procedure of parent was invoked second");
	invoked = avs_get_event(3);
	if (invoked != 2) {
		sprintf(ebuf, "ERROR: Expected procedure invocation to be #2, is #%d", invoked);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
>>ASSERTION Good B 0
A  call to
void XtVaSetValues(object, ...) 
when 
.A object
is of a subclass of RectObj and any of the resource values updated
in the widget instance require a geometry request shall restore
the original geometry values for the widget and call the geometry 
manager specified for the widget.
>>ASSERTION Good A
A  call to
void XtVaSetValues(object, ...) 
when 
.A object
is of a subclass of RectObj, any of the resource values updated
in the widget instance require a geometry request, and  the geometry 
manager specified for the widget returns XtGeometryYes shall call
the resize procedure of the specified widget.
>>CODE
Widget cooperative_composite, cooperative_widget;
XtWidgetGeometry geom;
int new_width, new_height;
int invoked = 0;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tvastvals2", "XtVaSetValues");
	tet_infoline("PREP: Create cooperative composite widget");
	cooperative_composite = XtVaCreateManagedWidget("cooperative_composite", avsCompWidgetClass, boxw1, NULL);
	tet_infoline("PREP: Create cooperative widget");
	cooperative_widget = XtVaCreateManagedWidget("cooperative_widget", avsWidgetClass, cooperative_composite, NULL);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Set resource values");
	XtVaSetValues(cooperative_widget, XtNwidth, 40 , XtNheight, 40, (char *)NULL);
	tet_infoline("PREP: Request geometry of cooperative_widget widget");
	XtQueryGeometry(cooperative_widget, NULL, &geom);
	tet_infoline("TEST: Cooperative_widget widget is resized");
	check_dec(40, geom.width, "width");
	check_dec(40, geom.height, "height");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good B 0
On a  call to
void XtVaSetValues(object, ...) 
when 
.A object
is of a subclass of RectObj, any of the resource values updated
in the widget instance require a geometry request, and  the geometry 
manager specified for the widget returns XtGeometryDone the geometry 
fields for the widget instance shall hold the new values.
>>ASSERTION Good A
On a  call to
void XtVaSetValues(object, ...) 
when 
.A object
is of a subclass of RectObj, any of the resource values updated
in the widget instance require a geometry request, and  the geometry 
manager specified for the widget returns XtGeometryNo the
geometry fields for the widget instance shall hold the original
values.
>>CODE
Widget squarew;
Dimension cell_width , cell_height;
int invoked = 0;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tvastvals3", "XtVaSetValues");
	tet_infoline("PREP: Create Square Cell widget");
	squarew = XtVaCreateManagedWidget("squarew",
			squareCellWidgetClass, boxw1, (char *)NULL);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Set resource values return XtGeometryNo");
	XtVaSetValues(squarew, XtNwidth, -1, 
			XtNheight, -1,(char *)NULL);
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
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
A  call to
void XtVaSetValues(object, ...) 
when 
.A object
is of a subclass of RectObj, any of the resource values updated
in the widget instance require a geometry request, and  the geometry 
manager specified for the widget returns XtGeometryAlmost shall call
the set_values_almost procedure of the specified widget.
>>CODE
Widget cooperative_composite, cooperative_widget;
Arg setargs[2];
Dimension new_width, new_height;
int invoked = 0;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tvastvals5", "XtVaSetValues");
	tet_infoline("PREP: Create cooperative composite widget");
	cooperative_composite = XtVaCreateManagedWidget("cooperative_composite", avsComp2WidgetClass, boxw1, NULL);
	tet_infoline("PREP: Create cooperative widget");
	cooperative_widget = XtVaCreateManagedWidget("cooperative_widget", avsWidgetClass, cooperative_composite, NULL);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Set resource values");
	XtVaSetValues(cooperative_widget, XtNwidth, 10, XtNheight, 10 , (char *)NULL);
	invoked = avs_get_event(4);
	tet_infoline("TEST: Geometry manager called");
	check_dec(1, invoked, "geometry manager invocations count");
	invoked = avs_get_event(3);
	tet_infoline("TEST: Set_values_almost procedure called");
	check_dec(1, invoked, "set_values_almost invocations count");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good B 0
A  call to
void XtVaSetValues(object, ...) 
when 
.A object
is of a subclass of RectObj, any of the resource values updated
in the widget instance require a geometry request, the geometry 
manager specified for the widget returns XtGeometryAlmost, and the
call to the set_values_almost procedure of the specified widget
does not request for an alternate geometry shall call the resize
procedure of the widget.
>>ASSERTION Good B 0
A  call to
void XtVaSetValues(object, ...) 
when 
.A object
is of a subclass of RectObj, any of the resource values updated
in the widget instance require a geometry request, the geometry 
manager specified for the widget returns XtGeometryAlmost, and the
call to the set_values_almost procedure of the specified widget
requests for an alternate geometry shall again call the geometry 
manager of the widget for the newly requested geometry values.
>>ASSERTION Good A
A  call to
void XtVaSetValues(object, ...) 
when 
.A object
is realized and a set_values procedure for the widget
returns True shall cause the widget's expose procedure to be
invoked.
>>CODE
Widget squarew;
Arg setargs[2];
int cur_x, cur_y;
int invoked = 0;
pid_t pid2, pid3;

/*this test is in the process of review vis consistency of the spec,
test suite, and sample code*/
if (config.coverage == 0) {
	FORK(pid2);
	avs_xt_hier("Tstvalues1", "XtSetValues");
	tet_infoline("PREP: Create Square Cell widget");
	squarew = XtVaCreateManagedWidget("squarew",
			squareCellWidgetClass, boxw1, NULL);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Set resource values");
	XtVaGetValues(squarew,
			XavsNcurX, &cur_x, XavsNcurY, &cur_y, (char *)NULL);
	setargs[0].name = XavsNcurX;
	setargs[0].value = (XtArgVal) cur_x+5;
	setargs[1].name = XavsNcurY;
	setargs[1].value = (XtArgVal) cur_y+5;
	XtVaSetValues(squarew, XavsNcurX, (XtArgVal) cur_x+5, XavsNcurY, (XtArgVal) cur_y+5 , (char *)NULL);
	tet_infoline("PREP: Get resource values");
	XtVaGetValues(squarew,
			XavsNcurX, &cur_x, XavsNcurY, &cur_y, (char *)NULL);
	tet_infoline("TEST: Resource values");
	check_dec(5, cur_x, "XavsNcurX");
	check_dec(5, cur_y, "XavsNcurY");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTMO_Proc, topLevel);
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: set_values procedure was invoked");
	invoked = avs_get_event(1);
	if (!invoked) {
		sprintf(ebuf, "ERROR: Procedure was not invoked");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: expose procedure was invoked");
	invoked = avs_get_event(6);
	if (invoked < 2) {
		sprintf(ebuf, "ERROR: Procedure was invoked %d times, expected at least 2", invoked);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
}
else {
	tet_result(TET_UNTESTED);
}
>>ASSERTION Good A
On a call to
void XtVaSetValues(object, ...) 
when the name XtVaTypedArg is specified in place of a resource name
in the variable argument list it shall interpret the four arguments
following this argument as a name/type/value/size tuple.
>>CODE
Widget squarew;
int cur_x , cur_y;
int invoked = 0;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tvastvals1", "XtVaSetValues");
	tet_infoline("PREP: Create Square Cell widget");
	squarew = XtVaCreateManagedWidget("squarew",
			squareCellWidgetClass, boxw1, (char *)NULL);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Set resource values");
	XtVaSetValues(squarew, XavsNcurX, 2, XtVaTypedArg, XavsNcurY, XtRInt, 2 , sizeof(XtRInt), (char *)NULL);
	tet_infoline("PREP: Get resource values");
	XtVaGetValues(squarew,
			XavsNcurX, &cur_x, XavsNcurY, &cur_y, (char *)NULL);
	tet_infoline("TEST: Resource values");
	check_dec(2, cur_x, "XavsNcurX");
	check_dec(2, cur_y, "XavsNcurY");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
On a call to
void XtVaSetValues(object, ...) 
when the name XtVaNestedList is specified in place of a resource name
in the variable argument list it shall interpret the next argument 
as a value specifying another varargs style variable argument list and 
logically insert it in the original list at the point of declaration.
>>CODE
Widget squarew;
int cur_x , cur_y;
int invoked = 0;
pid_t pid2;
XtVarArgsList sublist;

	FORK(pid2);
	avs_xt_hier("Tvastvals1", "XtVaSetValues");
	tet_infoline("PREP: Create Square Cell widget");
	squarew = XtVaCreateManagedWidget("squarew",
			squareCellWidgetClass, boxw1, (char *)NULL);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
        tet_infoline("PREP: Create nested list");
        sublist = XtVaCreateArgsList(NULL, XavsNcurX, 2, NULL);
	tet_infoline("TEST: Set resource values");
	XtVaSetValues(squarew, XtVaNestedList, sublist, XavsNcurY, 2 , (char *)NULL);
	tet_infoline("PREP: Get resource values");
	XtVaGetValues(squarew,
			XavsNcurX, &cur_x, XavsNcurY, &cur_y, (char *)NULL);
	tet_infoline("TEST: Resource values");
	check_dec(2, cur_x, "XavsNcurX");
	check_dec(2, cur_y, "XavsNcurY");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
