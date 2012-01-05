/*
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
*/
/*
*
* Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
* All Rights Reserved.
*
* Project: VSW5
*
* File: xts5/src/lib/libXtaw/StrToWid.c
*
* Description:
*	Subset of libXmu need for VSW5.  Use if implementation does not
*	support Athena.
*
* Modifications:
* $Log: StrToWidg.c,v $
* Revision 1.2  2005-11-03 08:42:02  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:11  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:26:07  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:44:22  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:18:24  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:14:56  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:46:39  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:45:06  andy
* Prepare for GA Release
*
*/
/* Copyright 1988, 1991 Massachusetts Institute of Technology
 *
 * Permission to use, copy, modify, distribute, and sell this software and its
 * documentation for any purpose is hereby granted without fee, provided that
 * the above copyright notice appear in all copies and that both that
 * copyright notice and this permission notice appear in supporting
 * documentation, and that the name of M.I.T. not be used in advertising or
 * publicity pertaining to distribution of the software without specific,
 * written prior permission.  M.I.T. makes no representations about the
 * suitability of this software for any purpose.  It is provided "as is"
 * without express or implied warranty.
 *
 * M.I.T. DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING ALL
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT SHALL M.I.T.
 * BE LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
 * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
 * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *
 *
 * XmuCvtStringToWidget
 *
 *   static XtConvertArgRec parentCvtArgs[] = {
 *	{XtBaseOffset, (caddr_t)XtOffset(Widget, core.parent), sizeof(Widget)},
 *   };
 *
 * matches the string against the name of the immediate children (normal
 * or popup) of the parent.  If none match, compares string to classname
 * & returns first match.  Case is significant.
 */
#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <X11/IntrinsicP.h>
#include <X11/StringDefs.h>
#include <X11/ObjectP.h>

#define	done(address, type) \
	{ toVal->size = sizeof(type); \
	  toVal->addr = (XPointer) address; \
	  return; \
	}

/* ARGSUSED */
void XmuCvtStringToWidget(args, num_args, fromVal, toVal)
    XrmValuePtr args;		/* parent */
    Cardinal    *num_args;      /* 1 */
    XrmValuePtr fromVal;
    XrmValuePtr toVal;
{
    static Widget widget, *widgetP, parent;
    XrmName name = XrmStringToName(fromVal->addr);
    int i;

    if (*num_args != 1)
	XtErrorMsg("wrongParameters", "cvtStringToWidget", "xtToolkitError",
		   "StringToWidget conversion needs parent arg", NULL, 0);

    parent = *(Widget*)args[0].addr;
    /* try to match names of normal children */
    if (XtIsComposite(parent)) {
	i = ((CompositeWidget)parent)->composite.num_children;
	for (widgetP = ((CompositeWidget)parent)->composite.children;
	     i; i--, widgetP++) {
	    if ((*widgetP)->core.xrm_name == name) {
		widget = *widgetP;
		done(&widget, Widget);
	    }
	}
    }
    /* try to match names of popup children */
    i = parent->core.num_popups;
    for (widgetP = parent->core.popup_list; i; i--, widgetP++) {
	if ((*widgetP)->core.xrm_name == name) {
	    widget = *widgetP;
	    done(&widget, Widget);
	}
    }
    /* try to match classes of normal children */
    if (XtIsComposite(parent)) {
	i = ((CompositeWidget)parent)->composite.num_children;
	for (widgetP = ((CompositeWidget)parent)->composite.children;
	     i; i--, widgetP++) {
	    if ((*widgetP)->core.widget_class->core_class.xrm_class == name) {
		widget = *widgetP;
		done(&widget, Widget);
	    }
	}
    }
    /* try to match classes of popup children */
    i = parent->core.num_popups;
    for (widgetP = parent->core.popup_list; i; i--, widgetP++) {
	if ((*widgetP)->core.widget_class->core_class.xrm_class == name) {
	    widget = *widgetP;
	    done(&widget, Widget);
	}
    }
    XtStringConversionWarning(fromVal->addr, XtRWidget);
    toVal->addr = NULL;
    toVal->size = 0;
}

#undef done

#define	newDone(type, value) \
	{							\
	    if (toVal->addr != NULL) {				\
		if (toVal->size < sizeof(type)) {		\
		    toVal->size = sizeof(type);			\
		    return False;				\
		}						\
		*(type*)(toVal->addr) = (value);		\
	    }							\
	    else {						\
		static type static_val;				\
		static_val = (value);				\
		toVal->addr = (XtPointer)&static_val;		\
	    }							\
	    toVal->size = sizeof(type);				\
	    return True;					\
	}


/*ARGSUSED*/
Boolean XmuNewCvtStringToWidget(dpy, args, num_args, fromVal, toVal, 
				converter_data)
     Display *dpy;
     XrmValue *args;		/* parent */
     Cardinal *num_args;	/* 1 */
     XrmValue *fromVal;
     XrmValue *toVal;
     XtPointer *converter_data;
{
    Widget *widgetP, parent;
    XrmName name = XrmStringToName(fromVal->addr);
    int i;

    if (*num_args != 1)
	XtAppWarningMsg(XtDisplayToApplicationContext(dpy),
			"wrongParameters","cvtStringToWidget","xtToolkitError",
			"String To Widget conversion needs parent argument",
			NULL, NULL);

    parent = *(Widget*)args[0].addr;
    /* try to match names of normal children */
    if (XtIsComposite(parent)) {
	i = ((CompositeWidget)parent)->composite.num_children;
	for (widgetP = ((CompositeWidget)parent)->composite.children;
	     i; i--, widgetP++) {
	    if ((*widgetP)->core.xrm_name == name)
		newDone(Widget, *widgetP);
	}
    }
    /* try to match names of popup children */
    i = parent->core.num_popups;
    for (widgetP = parent->core.popup_list; i; i--, widgetP++) {
	if ((*widgetP)->core.xrm_name == name)
	    newDone(Widget, *widgetP);
    }
    /* try to match classes of normal children */
    if (XtIsComposite(parent)) {
	i = ((CompositeWidget)parent)->composite.num_children;
	for (widgetP = ((CompositeWidget)parent)->composite.children;
	     i; i--, widgetP++) {
	    if ((*widgetP)->core.widget_class->core_class.xrm_class == name)
		newDone(Widget, *widgetP);
	}
    }
    /* try to match classes of popup children */
    i = parent->core.num_popups;
    for (widgetP = parent->core.popup_list; i; i--, widgetP++) {
	if ((*widgetP)->core.widget_class->core_class.xrm_class == name)
	    newDone(Widget, *widgetP);
    }
    XtDisplayStringConversionWarning(dpy, (String)fromVal->addr, XtRWidget);
    return False;
}
