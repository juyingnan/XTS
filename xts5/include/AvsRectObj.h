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
* Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
* Copyright 1987, 1988 by Digital Equipment Corporation, Maynard,
* Massachusetts, and the Massachusetts Institute of Technology,
* Cambridge, Massachusetts.
* All Rights Reserved.
*
* Project: VSW5
*
* File: xts5/include/AvsRectObj.h
*
* Description:
*	Widget Class
*
* Modifications:
* $Log: AvsRectObj.h,v $
* Revision 1.2  2005-11-03 08:42:00  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:07  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:23:25  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:41:31  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:15:56  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:12:27  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:38:16  tbr
* Branch point for Release 5.0.0
*
* Revision 3.2  1995/12/15  00:37:33  andy
* Prepare for GA Release
*
*/

#ifndef AvsRect_h
#define AvsRect_h

typedef struct _AvsRectObjRec *AvsRectObj;
typedef struct Avs_RectObjClassRec *AvsRectObjClass;

#ifndef AVSRECTOBJ
externalref WidgetClass avsrectObjClass;
#endif
#endif /* AvsRect_h */
