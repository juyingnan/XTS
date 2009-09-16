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
>># File: xts/SHAPE/XShapeQueryVersion/XShapeQueryVersion.m
>>#
>># Description:
>>#     Tests for XShapeQueryVersion()
>>#
>># Modifications:
>># $Log: tshpqyver.m,v $
>># Revision 1.1  2005-02-12 14:37:16  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:31:30  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:51:16  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:23:09  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:19:42  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:02:19  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.2  1995/12/15  01:47:55  andy
>># Prepare for GA Release
>>#

>>EXTERN
#include <X11/Xlib.h>
#include <X11/Xutil.h>
#include <X11/extensions/shape.h>
extern Display *display ;

>>TITLE XShapeQueryVersion ShapeExt
Status
XShapeQueryVersion(display, major_version, minor_version)
>>ASSERTION Good A
A call to Status XShapeQueryVersion(display, major_version, minor_version)
shall return a non-zero value and  set the major and minor version
numbers of the extension supported by the display.
>>CODE
Window  window;
int   value_good;
int   major_version;
int   minor_version;
pid_t pid2;

	FORK(pid2);
	tet_infoline("PREP: Open display and create window");
	window = (Window) avs_xext_init();
	tet_infoline("TEST: XShapeQueryVersion");
	value_good = XShapeQueryVersion(display,
		     &major_version, &minor_version) ;
	tet_infoline("TEST: Non zero value is returned");
	if (value_good <=0 ) {
		sprintf(ebuf, "ERROR: Expected non zero, returned %d", value_good);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TESTING: major_version is set to valid value");
	if (major_version <= 0) {
		sprintf(ebuf, "ERROR: Expected non zero returned %d", major_version);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TESTING: minor_version is set to valid value");
	if (minor_version < 0) {
		sprintf(ebuf, "ERROR: Expected positive number returned %d", minor_version);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}

	LKROF(pid2, AVSXTTIMEOUT);
        tet_result(TET_PASS);
