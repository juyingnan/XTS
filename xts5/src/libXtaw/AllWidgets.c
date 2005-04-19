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
* $Header: /cvs/xtest/xtest/xts5/src/libXtaw/AllWidgets.c,v 1.1 2005-02-12 14:37:15 anderson Exp $
*
* Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
* All Rights Reserved.
*
* Project: VSW5
*
* File: vsw5/src/lib/libXtaw/AllWidgets.c
*
* Description:
*	Subset of libXaw need for VSW5.  Use if implementation does not
*	support Athena.
*
* Modifications:
* $Log: AllWidgets.c,v $
* Revision 1.1  2005-02-12 14:37:15  anderson
* Initial revision
*
* Revision 8.0  1998/12/23 23:25:50  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:44:05  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:18:08  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:14:40  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:45:52  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:43:50  andy
* Prepare for GA Release
*
*/
/*
 * This file is generated by the genlist.sh script and contains an array of
 * all the widgets in Athena widget set.
 *
 */
#include <X11/IntrinsicP.h>
#include <X11/Xmu/WidgetNode.h>

extern WidgetClass applicationShellWidgetClass;
extern WidgetClass asciiSinkObjectClass;
extern WidgetClass asciiSrcObjectClass;
extern WidgetClass asciiTextWidgetClass;
extern WidgetClass boxWidgetClass;
extern WidgetClass clockWidgetClass;
extern WidgetClass commandWidgetClass;
extern WidgetClass compositeWidgetClass;
extern WidgetClass constraintWidgetClass;
extern WidgetClass coreWidgetClass;
extern WidgetClass dialogWidgetClass;
extern WidgetClass formWidgetClass;
extern WidgetClass gripWidgetClass;
extern WidgetClass labelWidgetClass;
extern WidgetClass listWidgetClass;
extern WidgetClass logoWidgetClass;
extern WidgetClass mailboxWidgetClass;
extern WidgetClass menuButtonWidgetClass;
extern WidgetClass objectClass;
extern WidgetClass overrideShellWidgetClass;
extern WidgetClass panedWidgetClass;
extern WidgetClass pannerWidgetClass;
extern WidgetClass portholeWidgetClass;
extern WidgetClass rectObjClass;
extern WidgetClass repeaterWidgetClass;
extern WidgetClass scrollbarWidgetClass;
extern WidgetClass shellWidgetClass;
extern WidgetClass simpleMenuWidgetClass;
extern WidgetClass simpleWidgetClass;
extern WidgetClass smeBSBObjectClass;
extern WidgetClass smeLineObjectClass;
extern WidgetClass smeObjectClass;
extern WidgetClass stripChartWidgetClass;
extern WidgetClass textSinkObjectClass;
extern WidgetClass textSrcObjectClass;
extern WidgetClass textWidgetClass;
extern WidgetClass toggleWidgetClass;
extern WidgetClass topLevelShellWidgetClass;
extern WidgetClass transientShellWidgetClass;
extern WidgetClass treeWidgetClass;
extern WidgetClass vendorShellWidgetClass;
extern WidgetClass viewportWidgetClass;
extern WidgetClass wmShellWidgetClass;

XmuWidgetNode XawWidgetArray[] = {
{ "applicationShell", &applicationShellWidgetClass },
{ "asciiSink", &asciiSinkObjectClass },
{ "asciiSrc", &asciiSrcObjectClass },
{ "asciiText", &asciiTextWidgetClass },
{ "box", &boxWidgetClass },
{ "clock", &clockWidgetClass },
{ "command", &commandWidgetClass },
{ "composite", &compositeWidgetClass },
{ "constraint", &constraintWidgetClass },
{ "core", &coreWidgetClass },
{ "dialog", &dialogWidgetClass },
{ "form", &formWidgetClass },
{ "grip", &gripWidgetClass },
{ "label", &labelWidgetClass },
{ "list", &listWidgetClass },
{ "logo", &logoWidgetClass },
{ "mailbox", &mailboxWidgetClass },
{ "menuButton", &menuButtonWidgetClass },
{ "object", &objectClass },
{ "overrideShell", &overrideShellWidgetClass },
{ "paned", &panedWidgetClass },
{ "panner", &pannerWidgetClass },
{ "porthole", &portholeWidgetClass },
{ "rect", &rectObjClass },
{ "repeater", &repeaterWidgetClass },
{ "scrollbar", &scrollbarWidgetClass },
{ "shell", &shellWidgetClass },
{ "simpleMenu", &simpleMenuWidgetClass },
{ "simple", &simpleWidgetClass },
{ "smeBSB", &smeBSBObjectClass },
{ "smeLine", &smeLineObjectClass },
{ "sme", &smeObjectClass },
{ "stripChart", &stripChartWidgetClass },
{ "textSink", &textSinkObjectClass },
{ "textSrc", &textSrcObjectClass },
{ "text", &textWidgetClass },
{ "toggle", &toggleWidgetClass },
{ "topLevelShell", &topLevelShellWidgetClass },
{ "transientShell", &transientShellWidgetClass },
{ "tree", &treeWidgetClass },
{ "vendorShell", &vendorShellWidgetClass },
{ "viewport", &viewportWidgetClass },
{ "wmShell", &wmShellWidgetClass },
};

int XawWidgetCount = XtNumber(XawWidgetArray);
