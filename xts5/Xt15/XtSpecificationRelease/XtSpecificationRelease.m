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
$Header: /cvs/xtest/xtest/xts5/tset/Xt15/XtSpecificationRelease/XtSpecificationRelease.m,v 1.1 2005-02-12 14:37:59 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt15/XtSpecificationRelease/XtSpecificationRelease.m
>># 
>># Description:
>>#	Tests for XtSpecificationRelease
>># 
>># Modifications:
>># $Log: spcfctnr.m,v $
>># Revision 1.1  2005-02-12 14:37:59  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:36:15  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:59:04  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:27:26  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:00  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:15:38  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:48:57  andy
>># Prepare for GA Release
>>#

>>TITLE XtSpecificationRelease Xt15
>>ASSERTION Good C
If the implementation is X11R5:
XtSpecificationRelease shall be defined and shall be equal to 5.
>>CODE

#if XT_X_RELEASE == 5
	if (XtSpecificationRelease != 5) {
		sprintf(ebuf, "ERROR: Expected XtSpecificationRelease = 5, is %d", XtSpecificationRelease);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
#else
	sprintf(ebuf, "INFO: Implementation being tested is X11R%d.", XT_X_RELEASE);
	tet_infoline(ebuf);
	tet_result(TET_UNSUPPORTED);
#endif
>>ASSERTION Good C
If the implementation is X11R4:
XtSpecificationRelease shall be defined and shall be equal to 4.
>>CODE

#if XT_X_RELEASE == 4
	if (XtSpecificationRelease != 4) {
		sprintf(ebuf, "ERROR: Expected XtSpecificationRelease = 4, is %d", XtSpecificationRelease);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
#else
	sprintf(ebuf, "INFO: Implementation being tested is X11R%d.", XT_X_RELEASE);
	tet_infoline(ebuf);
	tet_result(TET_UNSUPPORTED);
#endif
