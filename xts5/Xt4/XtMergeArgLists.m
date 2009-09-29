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
>># File: xts/Xt4/XtMergeArgLists.m
>># 
>># Description:
>>#	Tests for XtMergeArgLists()
>># 
>># Modifications:
>># $Log: tmrgarglst.m,v $
>># Revision 1.1  2005-02-12 14:38:02  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:36:22  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:59:11  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:27:32  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:06  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:15:56  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:19:42  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;
>>TITLE XtMergeArgLists Xt4
ArgList
XtMergeArgLists(args1, num_args1, args2, num_args2)
>>ASSERTION Good A
A call to ArgList XtMergeArgLists(args1, num_args1, args2, num_args2) shall
combine args1 and args2, store them in a newly allocated ArgList, and 
return a pointer the new ArgList.
>>CODE
Arg list_one[1], list_two[1] ;
ArgList ArgPtr;

	avs_xt_hier("Tmrgarglst1", "XtMergeArgLists");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Allocate memory for list");
	ArgPtr = (Arg *) malloc(sizeof(Arg));
	tet_infoline("PREP: Construct two argument lists to be merged");
	list_one[0].name = "Hello";
	list_one[0].value = (XtArgVal) 100;
	list_two[0].name = "World";
	list_two[0].value = (XtArgVal) 100;
	tet_infoline("PREP: Call XtMergeArgList");
	ArgPtr = XtMergeArgLists(&list_one[0], 1, &list_two[0], 1);
	tet_infoline("TEST: Two lists were merged");
	check_str("Hello", ArgPtr[0].name, "ArgPtr[0].name");
	check_dec(100, ArgPtr[0].value, "ArgPtr[0].value");
	check_str("World", ArgPtr[1].name, "ArgPtr[1].name");
	check_dec(100, ArgPtr[1].value, "ArgPtr[1].value");
	XtFree((char *)ArgPtr);
	tet_result(TET_PASS);
>>ASSERTION Good A
A call to ArgList XtMergeArgLists(args1, num_args1, args2, num_args2)
shall not check for duplicate entries in args1 and args2.
>>CODE
Arg	list_one[1], list_two[1] ;
ArgList	ArgPtr;

	avs_xt_hier("Tmrgarglst2", "XtMergeArgLists");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Allocate memory for list");
	ArgPtr = (Arg *) malloc(sizeof(Arg));
	tet_infoline("PREP: Construct two overlapping argument lists to be merged");
	list_one[0].name = "Hello";
	list_one[0].value = (XtArgVal) 100;
	list_two[0].name = "Hello";
	list_two[0].value = (XtArgVal) 100;
	tet_infoline("PREP: Call XtMergeArgList");
	ArgPtr = XtMergeArgLists(&list_one[0], 1, &list_two[0], 1);
	tet_infoline("TEST: Duplicates retained when two lists were merged");
	check_str("Hello", ArgPtr[0].name, "ArgPtr[0].name");
	check_dec(100, ArgPtr[0].value, "ArgPtr[0].value");
	check_str("Hello", ArgPtr[1].name, "ArgPtr[1].name");
	check_dec(100, ArgPtr[1].value, "ArgPtr[1].value");
	XtFree((char *)ArgPtr);
	tet_result(TET_PASS);
>>ASSERTION Good B 3
On a call to 
ArgList XtMergeArgLists(args1, num_args1, args2, num_args2)
the length of the new list shall be the sum of args1 and args2.
