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
* $Header: /cvs/xtest/xtest/xts5/src/libXtTest/avs_func.c,v 1.3 2005-11-03 08:42:02 jmichael Exp $
*
* Copyright (c) 2004 The Open Group
* Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
* Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
* All Rights Reserved.
*
* Project: VSW5
*
* File: xts5/src/lib/libXtTest/avs_func.c
*
* Description:
* 	procedures title(), PostMenu(), ConfigureDimension(), DestroyTree()
* 	mem_limit(), alloc_handler()
*
* Modifications:
* $Log: avs_func.c,v $
* Revision 1.3  2005-11-03 08:42:02  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.2  2005/04/21 09:40:42  ajosey
* resync to VSW5.1.5
*
* Revision 8.2  2005/01/14 11:19:53  gwc
* Updated copyright notice
*
* Revision 8.1  2004/02/12 16:46:28  gwc
* Changed mem_limit() to use/return size_t
*
* Revision 8.0  1998/12/23 23:25:34  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:43:48  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:17:53  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:14:25  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:45:06  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:42:57  andy
* Prepare for GA Release
*
*/

#include <XtTest.h>

void XtConfigureWidget();

/*
** Form the title string with function name
*/
char tit_string[80];

char *title(function)
char *function;
{
	strcpy(tit_string, "Xt Function: ");
	strcat(tit_string, function);

	return(tit_string);
}

/*ARGUSED*/
void PostMenu(w, client_data, event)
Widget   w;
XtPointer  client_data;
XButtonEvent  *event;
{
	Widget popupmenu = (Widget) client_data;

	/* invoke the menu at the co-ordinates of click button */
	XtVaSetValues(
		popupmenu,
		XtNx, event->x_root,
		XtNy, event->y_root,
		NULL );
	XtPopup(popupmenu, False);
}

/*
** Configure the dimension of box widget
*/
/*ARGSUSED*/
void ConfigureDimension(root, boxw)
Widget root;
Widget boxw;
{
	XtWidgetGeometry intended, geom;

	intended.request_mode = CWX|CWY|CWWidth|CWHeight;

	XtQueryGeometry(root, &intended, &geom);
	XtConfigureWidget(boxw, geom.x, geom.y,
		(geom.width -  geom.x),
		(geom.height - 2 * geom.y), 1);
}

/*
** destroy the widget tree
*/
/*ARGSUSED*/
void DestroyTree(w, client_data, call_data)
Widget w;
XtPointer client_data, call_data;
{
	Widget root = (Widget) client_data;
	XtDestroyWidget(root);
}

size_t
mem_limit()
{
	char	*ptr;
	size_t	hbit,i,j;

	j = 0;
	for (hbit=(((size_t)-1)>>1)+1;hbit;hbit=(ptr)?(i>>1):(i>>2)){
		for(i=1;
			(ptr=malloc(i|j)) && (free(ptr),1) && (i<hbit);
		i<<=1);
			j |= (ptr) ? i : i >> 1;
	}
	return(j);
}

/*
** called by XtMalloc, XtCalloc and XtRealloc XtNewString
*/
int alloc_handler_called = 0;
/*ARGUSED*/
void alloc_handler(name, type, class, defaultp, params, num_params)
String name;
String type;
String class;
String defaultp;
String *params;
Cardinal *num_params;
{
alloc_handler_called = 1;
}
