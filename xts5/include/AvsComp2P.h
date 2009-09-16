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
* All Rights Reserved.
*
* Project: VSW5
*
* File: xts5/include/AvsComp2P.h
*
* Description:
*	Widget Class
*
* Modifications:
* $Log: AvsComp2P.h,v $
* Revision 1.2  2005-11-03 08:42:00  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:07  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:23:20  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:41:25  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:15:51  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:12:23  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:38:07  tbr
* Branch point for Release 5.0.0
*
* Revision 3.2  1995/12/15  00:37:14  andy
* Prepare for GA Release
*
*/

#ifndef AvsComp2P_h
#define AvsComp2P_h

#include <AvsComp2.h>

typedef struct _AvsComp2ClassPart {
    XtPointer extension;
} AvsComp2ClassPart;

typedef struct _AvsComp2ClassRec {
    CoreClassPart core_class;
    CompositeClassPart composite_class;
    ConstraintClassPart constraint_class;
    AvsComp2ClassPart avs_comp2_class;
} AvsComp2ClassRec;

extern AvsComp2ClassRec avsComp2ClassRec;

typedef struct {
    /* private fields */
	XtPointer placeholder;
} AvsComp2Part;


typedef struct _AvsComp2Rec {
    CorePart core;
    CompositePart composite;
    ConstraintPart constraint;
    AvsComp2Part avs_comp2;
}  AvsComp2Rec;

#endif /* AvsComp2P_h */
