/*
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
*/
/*
* $Header: /cvs/xtest/xtest/xts5/src/libXtTest/AvsForm2.c,v 1.1 2005-02-12 14:37:15 anderson Exp $
*
* Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
* Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
* Copyright 1987, 1988 by Digital Equipment Corporation, Maynard,
* Massachusetts, and the Massachusetts Institute of Technology,
* Cambridge, Massachusetts.
* All Rights Reserved.
*
* Project: VSW5
*
* File: vsw5/src/lib/libXtTest/AvsForm2.c
*
* Description:
*	Test widget
*
* Modifications:
* $Log: AvsForm2.c,v $
* Revision 1.1  2005-02-12 14:37:15  anderson
* Initial revision
*
* Revision 8.0  1998/12/23 23:25:30  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:43:44  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:17:50  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:14:22  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.1  1998/01/16 23:49:57  andy
* ConstraintSetValues needed to set a semaphore (TSD 141).
*
* Revision 4.0  1995/12/15 08:44:58  tbr
* Branch point for Release 5.0.0
*
* Revision 3.2  1995/12/15  00:42:47  andy
* Prepare for GA Release
*
*/

/*
This is a custom widget used in combination with the avsForm widget
in the tests for XtGetConstraintResourceList.  avsForm is the
superclass of avsForm2.  Each has different subclass resource
populations which are employed to determine if the superclass'
resources are reported
*/

#include <X11/Intrinsic.h>
#include <X11/IntrinsicP.h>
#include <X11/StringDefs.h>
#include <X11/Xmu/Converters.h>
#include <X11/Xmu/CharSet.h>
#include <X11/Xaw/XawInit.h>
#include <X11/Xaw/FormP.h>
#include <AvsFormP.h>

/* Private Definitions */

static int default_value = -99999;

#define Offset(field) XtOffset(FormWidget, form.field)
static XtResource resources[] = {
    {XtNdefaultDistance, XtCThickness, XtRInt, sizeof(int),
	Offset(default_spacing), XtRImmediate, &default_value}
};
#undef Offset

static XtEdgeType defEdge = XtRubber;

#define Offset(field) XtOffset(FormConstraints, form.field)
static XtResource formConstraintResources[] = {
    {XtNresizable, XtCBoolean, XtRBoolean, sizeof(Boolean),
	Offset(allow_resize), XtRImmediate, (XtPointer) FALSE},
};
#undef Offset

static void ClassInitialize(), ClassPartInitialize(), Initialize(), Resize();
static void ConstraintInitialize();
static Boolean SetValues(), ConstraintSetValues();
static XtGeometryResult GeometryManager(), PreferredGeometry();
static void ChangeManaged();
static Boolean Layout();

FormClassRec avsform2ClassRec = {
  { /* core_class fields */
    /* superclass         */    (WidgetClass) &avsformClassRec,
    /* class_name         */    "avsForm2",
    /* widget_size        */    sizeof(FormRec),
    /* class_initialize   */    ClassInitialize,
    /* class_part_init    */    ClassPartInitialize,
    /* class_inited       */    FALSE,
    /* initialize         */    Initialize,
    /* initialize_hook    */    NULL,
    /* realize            */    XtInheritRealize,
    /* actions            */    NULL,
    /* num_actions        */    0,
    /* resources          */    resources,
    /* num_resources      */    XtNumber(resources),
    /* xrm_class          */    NULLQUARK,
    /* compress_motion    */    TRUE,
    /* compress_exposure  */    TRUE,
    /* compress_enterleave*/    TRUE,
    /* visible_interest   */    FALSE,
    /* destroy            */    NULL,
    /* resize             */    Resize,
    /* expose             */    XtInheritExpose,
    /* set_values         */    SetValues,
    /* set_values_hook    */    NULL,
    /* set_values_almost  */    XtInheritSetValuesAlmost,
    /* get_values_hook    */    NULL,
    /* accept_focus       */    NULL,
    /* version            */    XtVersion,
    /* callback_private   */    NULL,
    /* tm_table           */    NULL,
    /* query_geometry     */	PreferredGeometry,
    /* display_accelerator*/	XtInheritDisplayAccelerator,
    /* extension          */	NULL
  },
  { /* composite_class fields */
    /* geometry_manager   */   GeometryManager,
    /* change_managed     */   ChangeManaged,
    /* insert_child       */   XtInheritInsertChild,
    /* delete_child       */   XtInheritDeleteChild,
    /* extension          */   NULL
  },
  { /* constraint_class fields */
    /* subresourses       */   formConstraintResources,
    /* subresource_count  */   XtNumber(formConstraintResources),
    /* constraint_size    */   sizeof(FormConstraintsRec),
    /* initialize         */   ConstraintInitialize,
    /* destroy            */   NULL,
    /* set_values         */   ConstraintSetValues,
    /* extension          */   NULL
  },
  { /* form_class fields */
    /* layout             */   Layout
  }
};

WidgetClass avsform2WidgetClass = (WidgetClass)&avsform2ClassRec;

/****************************************************************
 *
 * Private Procedures
 *
 ****************************************************************/


static XrmQuark	XtQChainLeft, XtQChainRight, XtQChainTop,
		XtQChainBottom, XtQRubber;

#define	done(address, type) \
	{ toVal->size = sizeof(type); \
	  toVal->addr = (XtPointer)address; \
	  return; \
	}

/* ARGSUSED */
static void _CvtStringToEdgeType(args, num_args, fromVal, toVal)
    XrmValuePtr args;		/* unused */
    Cardinal    *num_args;      /* unused */
    XrmValuePtr fromVal;
    XrmValuePtr toVal;
{
    static XtEdgeType edgeType;
    XrmQuark q;
    char lowerName[1000];

    XmuCopyISOLatin1Lowered (lowerName, (char*)fromVal->addr);
    q = XrmStringToQuark(lowerName);
    if (q == XtQChainLeft) {
	edgeType = XtChainLeft;
	done(&edgeType, XtEdgeType);
    }
    if (q == XtQChainRight) {
	edgeType = XtChainRight;
	done(&edgeType, XtEdgeType);
    }
    if (q == XtQChainTop) {
	edgeType = XtChainTop;
	done(&edgeType, XtEdgeType);
    }
    if (q == XtQChainBottom) {
	edgeType = XtChainBottom;
	done(&edgeType, XtEdgeType);
    }
    if (q == XtQRubber) {
	edgeType = XtRubber;
	done(&edgeType, XtEdgeType);
    }
    XtStringConversionWarning(fromVal->addr, "edgeType");
    toVal->addr = NULL;
    toVal->size = 0;
}

static void ClassInitialize()
{
    static XtConvertArgRec parentCvtArgs[] = {
	{XtBaseOffset, (XtPointer)XtOffset(Widget, core.parent), sizeof(Widget)}
    };
    XawInitializeWidgetSet();
    XtQChainLeft   = XrmStringToQuark("chainleft");
    XtQChainRight  = XrmStringToQuark("chainright");
    XtQChainTop    = XrmStringToQuark("chaintop");
    XtQChainBottom = XrmStringToQuark("chainbottom");
    XtQRubber      = XrmStringToQuark("rubber");

    XtAddConverter( XtRString, XtREdgeType, _CvtStringToEdgeType, NULL, 0 );
    XtAddConverter( XtRString, XtRWidget, XmuCvtStringToWidget,
		    parentCvtArgs, XtNumber(parentCvtArgs) );
}

static void ClassPartInitialize(class)
    WidgetClass class;
{
    register FormWidgetClass c = (FormWidgetClass)class;

    if (c->form_class.layout == XtInheritLayout)
	c->form_class.layout = Layout;
}

/* ARGSUSED */
static void Initialize(request, new)
    Widget request, new;
{
    FormWidget fw = (FormWidget)new;

    fw->form.old_width = fw->core.width;
    fw->form.old_height = fw->core.height;
    fw->form.no_refigure = False;
    fw->form.needs_relayout = False;
    fw->form.resize_in_layout = True;
}

/*	Function Name: ChangeFormGeometry
 *	Description: Ask the parent to change the form widget's geometry.
 *	Arguments: w - the Form widget.
 *                 query_only - TRUE if this is only a query.
 *                 width, height - the new width and height.
 *                 ret_width, ret_height - the actual size the form is allowed
 *                                         to resize to.
 *	Returns: TRUE of children may always be resized.
 */

static Boolean
ChangeFormGeometry(w, query_only, width, height, ret_width, ret_height)
Widget w;
Boolean query_only;
Dimension width, height;
Dimension *ret_width, *ret_height;
{
    FormWidget fw = (FormWidget) w;
    Boolean always_resize_children;
    XtGeometryResult result;
    XtWidgetGeometry request, return_request;

    /*
     * If we are already at the desired size then there is no need
     * to ask our parent of we can change size.
     */

    if ( (width == fw->core.width) && (height == fw->core.height) )
	return(TRUE);

    request.width = width;
    request.height = height;
    request.request_mode = CWWidth | CWHeight;
    if (query_only)
	request.request_mode |= XtCWQueryOnly;

    /*
     * Do no invoke the resize rules if our size changes here.
     */

    fw->form.resize_is_no_op = TRUE;

    result = XtMakeGeometryRequest(w, &request, &return_request);
    if (result == XtGeometryAlmost) {
	request = return_request;
	(void) XtMakeGeometryRequest(w, &request, &return_request);
	always_resize_children = FALSE;
    }
    else
	always_resize_children = (result == XtGeometryYes);

    fw->form.resize_is_no_op = FALSE;

    if (ret_width != NULL)
	*ret_width = request.width;
    if (ret_height != NULL)
	*ret_height = request.height;

    return(always_resize_children);
}

static void LayoutChild(w)
    Widget w;
{
    FormConstraints form = (FormConstraints)w->core.constraints;
    Widget ref;

    switch (form->form.layout_state) {

      case LayoutPending:
	form->form.layout_state = LayoutInProgress;
	break;

      case LayoutDone:
	return;

      case LayoutInProgress:
	{
	String subs[2];
	Cardinal num_subs = 2;
	subs[0] = w->core.name;
	subs[1] = w->core.parent->core.name;
	XtAppWarningMsg(XtWidgetToApplicationContext(w),
			"constraintLoop","xawFormLayout","XawToolkitError",
   "constraint loop detected while laying out child '%s' in FormWidget '%s'",
			subs, &num_subs);
	return;
	}
    }

    form->form.new_x = form->form.dx;
    form->form.new_y = form->form.dy;
    if ((ref = form->form.horiz_base) != (Widget)NULL) {
	FormConstraints ref_form = (FormConstraints) ref->core.constraints;

	LayoutChild(ref);
	form->form.new_x += (ref_form->form.new_x + 
			     ref->core.width + (ref->core.border_width << 1));
    }
    if ((ref = form->form.vert_base) != (Widget)NULL) {
	FormConstraints ref_form = (FormConstraints) ref->core.constraints;

	LayoutChild(ref);
	form->form.new_y += (ref_form->form.new_y + 
			     ref->core.height + (ref->core.border_width << 1));
    }

    form->form.layout_state = LayoutDone;
}

/*	Function Name: ResizeChildren
 *	Description: Resizes all children to new_x and new_y.
 *	Arguments: w - the form widget.
 *	Returns: none.
 */

static void ResizeChildren(w) 
Widget w;
{
    FormWidget fw = (FormWidget) w;
    int num_children = fw->composite.num_children;
    WidgetList children = fw->composite.children;
    Widget *childP;

    for (childP = children; childP - children < num_children; childP++) {
	FormConstraints form;

	if (!XtIsManaged(*childP)) 
	    continue;

	form = (FormConstraints)(*childP)->core.constraints;
	if (fw->form.no_refigure) {
/* 
 * I am changing the widget wrapper w/o modifing the window.  This is
 * risky, but I can get away with it since I am the parent of this
 * widget, and he must ask me for any geometry changes.
 *
 * The window will be updated when no_refigure is set back to False.
 */	
	    (*childP)->core.x = form->form.new_x;
	    (*childP)->core.y = form->form.new_y;
	}
	else
	    XtMoveWidget(*childP, form->form.new_x, form->form.new_y);
    }
}




/*	Function Name: Layout
 *	Description: Moves all the children around.
 *	Arguments: fw - the Form widget.
 *                 width, height - ** UNUSED **.
 *                 force_relayout - will force the children to be
 *                                 moved, event if some go past the edge
 *                                 of the form.
 *	Returns: True if the children are allowed to move from their
 *               current locations to the new ones.
 */

/* ARGSUSED */
static Boolean Layout(fw, width, height, force_relayout)
    FormWidget fw;
    Dimension width, height;
    Boolean force_relayout;
{
    int num_children = fw->composite.num_children;
    WidgetList children = fw->composite.children;
    Widget *childP;
    Dimension maxx, maxy;
    Boolean ret_val;

    for (childP = children; childP - children < num_children; childP++) {
	FormConstraints form = (FormConstraints)(*childP)->core.constraints;
	form->form.layout_state = LayoutPending;
    }

    maxx = maxy = 1;
    for (childP = children; childP - children < num_children; childP++) {
	if (XtIsManaged(*childP)) {
	    register FormConstraints form;
	    register Position x, y;

	    form = (FormConstraints)(*childP)->core.constraints;

	    LayoutChild(*childP);

	    x = form->form.new_x + (*childP)->core.width + 
		((*childP)->core.border_width << 1);
	    if ( x > (Position)maxx)
		maxx = x;

	    y = form->form.new_y + (*childP)->core.height +
		((*childP)->core.border_width << 1);
	    if (y > (Position)maxy)
		maxy = y;
	}
    }

    fw->form.preferred_width = (maxx += fw->form.default_spacing);
    fw->form.preferred_height = (maxy += fw->form.default_spacing);

    if (fw->form.resize_in_layout) {
	Boolean always_resize_children;

	always_resize_children = ChangeFormGeometry( (Widget) fw, FALSE,
						    maxx, maxy, NULL, NULL);

	fw->form.old_width  = fw->core.width;
	fw->form.old_height = fw->core.height;

	ret_val = (always_resize_children || ( (fw->core.width >= maxx) &&
					      (fw->core.height >= maxy)));

	if (force_relayout)
	    ret_val = TRUE;

	if (ret_val)
	    ResizeChildren((Widget) fw);
    }
    else
	ret_val = False;

    return ret_val;
}

static Position TransformCoord(loc, old, new, type)
    register Position loc;
    Dimension old, new;
    XtEdgeType type;
{
    if (type == XtRubber) {
        if ( ((int) old) > 0)
	    loc = (Position)((int)(loc * new) / (int)old);
    }
    else if (type == XtChainBottom || type == XtChainRight)
      loc += (Position)new - (Position)old;

    /* I don't see any problem with returning values less than zero. */

    return (loc);
}

static void Resize(w)
    Widget w;
{
    FormWidget fw = (FormWidget)w;
    WidgetList children = fw->composite.children;
    int num_children = fw->composite.num_children;
    Widget *childP;
    Position x, y;
    Dimension width, height;

    if (!fw->form.resize_is_no_op)
	for (childP = children; childP - children < num_children; childP++) {
	    FormConstraints form= (FormConstraints)(*childP)->core.constraints;
	    if (!XtIsManaged(*childP)) continue;
	    x = TransformCoord( (*childP)->core.x, fw->form.old_width,
			       fw->core.width, form->form.left );
	    y = TransformCoord( (*childP)->core.y, fw->form.old_height,
			       fw->core.height, form->form.top );
	    
	    form->form.virtual_width =
		TransformCoord((Position)((*childP)->core.x
					  + form->form.virtual_width
					  + 2 * (*childP)->core.border_width),
			       fw->form.old_width, fw->core.width,
			       form->form.right )
		    - (x + 2 * (*childP)->core.border_width);
	    
	    form->form.virtual_height =
		TransformCoord((Position)((*childP)->core.y
					  + form->form.virtual_height
					  + 2 * (*childP)->core.border_width),
			       fw->form.old_height, fw->core.height,
			       form->form.bottom ) 
		    - ( y + 2 * (*childP)->core.border_width);
	    
	    width = (Dimension) 
		(form->form.virtual_width < 1) ? 1 : form->form.virtual_width;
	    height = (Dimension)
	       (form->form.virtual_height < 1) ? 1 : form->form.virtual_height;
	    
	    XtConfigureWidget(*childP,x,y, (Dimension)width, (Dimension)height,
			      (*childP)->core.border_width );
	}

    fw->form.old_width = fw->core.width;
    fw->form.old_height = fw->core.height;
}

/*
 * I don't want to even think about what ``Almost'' would mean - Chris.
 */

/* ARGSUSED */
static XtGeometryResult GeometryManager(w, request, reply)
    Widget w;
    XtWidgetGeometry *request;
    XtWidgetGeometry *reply;	/* RETURN */
{
    Dimension old_width, old_height;
    FormWidget fw = (FormWidget) XtParent(w);
    FormConstraints form = (FormConstraints) w->core.constraints;
    XtWidgetGeometry allowed;
    XtGeometryResult ret_val;

    if ((request->request_mode & ~(XtCWQueryOnly | CWWidth | CWHeight)) ||
	!form->form.allow_resize)
	return(XtGeometryNo);

    if (request->request_mode & CWWidth)
	allowed.width = request->width;
    else
	allowed.width = w->core.width;

    if (request->request_mode & CWHeight)
	allowed.height = request->height;
    else
	allowed.height = w->core.height;

    if (allowed.width == w->core.width && allowed.height == w->core.height)
	return(XtGeometryNo);

    /*
     * Remember the old size, and then set the size to the requested size.
     */

    old_width = w->core.width;
    old_height = w->core.height;
    w->core.width = allowed.width;
    w->core.height = allowed.height;

    if (request->request_mode & XtCWQueryOnly) {
	Boolean always_resize_children;
	Dimension ret_width, ret_height;

	fw->form.resize_in_layout = FALSE;

	(*((FormWidgetClass)fw->core.widget_class)->form_class.layout)
  	                                 ( fw, w->core.width, w->core.height,
					   FALSE );

	/*
	 * Reset the size of this child back to what it used to be.
	 */

	w->core.width = old_width;
	w->core.height = old_height;

	fw->form.resize_in_layout = TRUE;

	always_resize_children = ChangeFormGeometry(w, TRUE, 
				   fw->form.preferred_width,
				   fw->form.preferred_height,
				   &ret_width, &ret_height);

	if (always_resize_children || 
	    ((ret_width >= fw->form.preferred_width) &&
	     (ret_height >= fw->form.preferred_height)))
	{
	    ret_val = XtGeometryYes;
	}
	else
	    ret_val = XtGeometryNo;
    }
    else {
	if ((*((FormWidgetClass)fw->core.widget_class)->form_class.layout)
	                                  ( fw, w->core.width, w->core.height,
					    FALSE))
	{
	    form->form.virtual_width = w->core.width;   /* reset virtual */
	    form->form.virtual_height = w->core.height; /* width and height. */
	    if (fw->form.no_refigure) {
/* 
 * I am changing the widget wrapper w/o modifing the window.  This is
 * risky, but I can get away with it since I am the parent of this
 * widget, and he must ask me for any geometry changes.
 *
 * The window will be updated when no_refigure is set back to False.
 */	
		ret_val = XtGeometryDone;
	    }
	    else 
		ret_val = XtGeometryYes;
	}
	else {
	    w->core.width = old_width;
	    w->core.height = old_height;
	    ret_val = XtGeometryNo;
	}
    }

    return(ret_val);
}


/* ARGSUSED */
static Boolean SetValues(current, request, new)
    Widget current, request, new;
{
    return( FALSE );
}


/* ARGSUSED */
static void ConstraintInitialize(request, new)
    Widget request, new;
{
    FormConstraints form = (FormConstraints)new->core.constraints;
    FormWidget fw = (FormWidget)new->core.parent;

    form->form.virtual_width = (int) new->core.width;
    form->form.virtual_height = (int) new->core.height;

    if (form->form.dx == default_value)
        form->form.dx = fw->form.default_spacing;

    if (form->form.dy == default_value)
        form->form.dy = fw->form.default_spacing;
}

/* ARGSUSED */
static Boolean ConstraintSetValues(current, request, new)
    Widget current, request, new;
{
/*avsform's procedure does event 4, allows order checking*/
	avs_set_event(3, avs_get_event(4)+1);
    return( TRUE );
}

static void ChangeManaged(w)
    Widget w;
{
  FormWidget fw = (FormWidget)w;
  FormConstraints form;
  WidgetList children, childP;
  int num_children = fw->composite.num_children;
  Widget child;

  /*
   * Reset virtual width and height for all children.
   */
  
  for (children = childP = fw->composite.children ;
       childP - children < num_children; childP++) {
    child = *childP;
    if (XtIsManaged(child)) {
      form = (FormConstraints)child->core.constraints;

/*
 * If the size is one (1) then we must not change the virtual sizes, as
 * they contain useful information.  If someone actually wants a widget of
 * width or height one (1) in a form widget he will lose, can't win them all.
 *
 * Chris D. Peterson 2/9/89.
 */
	 
      if ( child->core.width != 1)
	form->form.virtual_width = (int) child->core.width;
      if ( child->core.height != 1)
	form->form.virtual_height = (int) child->core.height;
    }
  }
  (*((FormWidgetClass)w->core.widget_class)->form_class.layout)
  	                                 ((FormWidget) w, w->core.width, 
					  w->core.height, TRUE);
}


static XtGeometryResult PreferredGeometry( widget, request, reply  )
    Widget widget;
    XtWidgetGeometry *request, *reply;
{
    FormWidget w = (FormWidget)widget;
    
    reply->width = w->form.preferred_width;
    reply->height = w->form.preferred_height;
    reply->request_mode = CWWidth | CWHeight;
    if (  request->request_mode & (CWWidth | CWHeight) ==
	    (CWWidth | CWHeight)
	  && request->width == reply->width
	  && request->height == reply->height)
	return XtGeometryYes;
    else if (reply->width == w->core.width && reply->height == w->core.height)
	return XtGeometryNo;
    else
	return XtGeometryAlmost;
}
