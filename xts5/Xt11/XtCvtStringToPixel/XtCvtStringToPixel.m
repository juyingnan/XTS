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
>># File: xts/Xt11/XtCvtStringToPixel/XtCvtStringToPixel.m
>># 
>># Description:
>>#	Tests for XtCvtStringToPixel()
>># 
>># Modifications:
>># $Log: tcstpix.m,v $
>># Revision 1.1  2005-02-12 14:37:53  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:37:33  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:00:30  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:28:37  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.1  1998/02/03 22:18:04  andy
>># Added warning handler install to test 2 (SR 160).
>>#
>># Revision 5.0  1998/01/26 03:25:12  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.2  1998/01/13 04:43:01  andy
>># Changed closure_ret from XtPointer * to XtPointer (SR 139).
>>#
>># Revision 4.0  1995/12/15  09:19:49  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:14:37  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;

void XtWMH_Proc(str1, str2, str3, str4, str5, car)
String str1, str2, str3, str4, *str5;
Cardinal *car;
{
	avs_set_event(1,1);
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtCvtStringToPixel Xt11
Boolean
XtCvtStringToPixel(display, args, num_args, from, to, converter_data)
>>ASSERTION Good C
If the implementation is X11R5 or later:
A successful call to
Boolean XtCvtStringToPixel(display, args, num_args, from, to, converter_data)
when 
.A to->addr 
is not NULL and 
.A to->size 
is large enough to store
an XtRPixel type shall convert the string specified in 
.A from
to an XtRPixel type, store it at the location specified by
.A to->addr,
set
.A to->size 
to the actual size of the converted data, and return True.
>>CODE
/* Conversion arguments and results */
Boolean status;
Display *display;
XrmValue args[2];
Cardinal num_args;
XrmValue fromVal;
XrmValue toVal;
Boolean closure;
XtPointer closure_ret = (XtPointer *) &closure;
/* String to Pixel specific */
Screen *screen;
Colormap colormap;
char *pixstr = "black";
Pixel res;
pid_t pid2;
#endif

#if XT_X_RELEASE > 4
	FORK(pid2);
	avs_xt_hier("Tcstpix1", "XtCvtStringToPixel");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get display");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Set up required conversion args");
	screen = DefaultScreenOfDisplay(display);
	args[0].addr = (XtPointer )&screen;
	args[0].size = sizeof(Screen*);
	colormap = DefaultColormapOfScreen(screen);
	args[1].addr = (XtPointer) &colormap;
	args[1].size = sizeof(Colormap);
	num_args = 2;
	tet_infoline("TEST: Conversion succeeds");
	fromVal.addr = pixstr;
	fromVal.size = strlen(pixstr)+1;
	toVal.addr = (XtPointer)&res;
	toVal.size = sizeof(Pixel);
	res = 0;
	status = XtCvtStringToPixel(display,
			&args[0],
			&num_args,
			&fromVal,
			&toVal,
			&closure_ret);
	tet_infoline("TEST: Return value");
	check_dec(True, status, "XtCvtStringToPixel return value");
	check_dec(XBlackPixelOfScreen(DefaultScreenOfDisplay(display)), res, "returned pixel");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
>>ASSERTION Good C
If the implementation is X11R5 or later:
A call to 
Boolean XtCvtStringToPixel(display, args, num_args, from, to, converter_data)
when 
.A to->addr 
is not NULL and 
.A to->size 
is too small for an
XtRPixel type shall not perform a
conversion, set the 
.A to->size 
field to the number of bytes required to store the converted data,
and return False.
>>CODE
#if XT_X_RELEASE > 4
/* Conversion arguments and results */
Boolean status;
Display *display;
XrmValue args[2];
Cardinal num_args;
XrmValue fromVal;
XrmValue toVal;
Boolean closure;
XtPointer closure_ret = (XtPointer *) &closure;
/* String to Pixel specific */
Screen *screen;
Colormap colormap;
char *pixstr = "XtDefaultBackground";
Pixel res;
pid_t pid2;
#endif

#if XT_X_RELEASE > 4
	FORK(pid2);
	avs_xt_hier("Tcstpix2", "XtCvtStringToPixel");
	XtAppSetWarningMsgHandler(app_ctext, XtWMH_Proc);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get display");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Set up required conversion args");
	screen = DefaultScreenOfDisplay(display);
	args[0].addr = (XtPointer )&screen;
	args[0].size = sizeof(Screen*);
	colormap = DefaultColormapOfScreen(screen);
	args[1].addr = (XtPointer) &colormap;
	args[1].size = sizeof(Colormap);
	num_args = 2;
	tet_infoline("TEST: Conversion fails");
	fromVal.addr = pixstr;
	fromVal.size = strlen(pixstr)+1;
	toVal.addr = (XtPointer) &res;
	toVal.size = 0;
	status = XtCvtStringToPixel(display,
			&args[0],
			&num_args,
			&fromVal,
			&toVal,
			&closure_ret);
	check_dec(False, status, "XtCvtStringToPixel return value");
	tet_infoline("TEST: to_size");
	if (toVal.size != sizeof(Pixel)) {
		sprintf(ebuf, "ERROR: to_size not set correctly, expected %d, received %d", sizeof(Pixel), toVal.size);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
>>ASSERTION Good C
If the implementation is X11R5 or later:
A successful call to 
Boolean XtCvtStringToPixel(display, args, num_args, from, to, converter_data)
when 
.A to->addr 
is NULL shall convert the string specified in
.A from
to an XtRPixel type, allocate space for the converted data,
set
.A to->addr 
to specify the location of the data,
set
.A to->size
to the size of the coverted data, and return True.
>>CODE
#if XT_X_RELEASE > 4
/* Conversion arguments and results */
Boolean status;
Display *display;
XrmValue args[2];
Cardinal num_args;
XrmValue fromVal;
XrmValue toVal;
Boolean closure;
XtPointer closure_ret = (XtPointer *) &closure;
/* String to Pixel specific */
Screen *screen;
Colormap colormap;
char *pixstr = "XtDefaultBackground";
pid_t pid2;
#endif

#if XT_X_RELEASE > 4
	FORK(pid2);
	avs_xt_hier("Tcstpix3", "XtCvtStringToPixel");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get display");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Set up required conversion args");
	screen = DefaultScreenOfDisplay(display);
	args[0].addr = (XtPointer )&screen;
	args[0].size = sizeof(Screen*);
	colormap = DefaultColormapOfScreen(screen);
	args[1].addr = (XtPointer) &colormap;
	args[1].size = sizeof(Colormap);
	num_args = 2;
	tet_infoline("TEST: Conversion succeeds");
	fromVal.addr = pixstr;
	fromVal.size = strlen(pixstr)+1;
	toVal.addr = (XtPointer)0;
	toVal.size = 0;
	status = XtCvtStringToPixel(display,
			&args[0],
			&num_args,
			&fromVal,
			&toVal,
			&closure_ret);
	check_dec(True, status, "XtCvtStringToPixel return value");
	tet_infoline("TEST: to->addr and to->size are set");
	if (!toVal.addr) {
		sprintf(ebuf, "ERROR: to->addr was not set");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	if (toVal.size != sizeof(Pixel)) {
		sprintf(ebuf, "ERROR: to_size not set correctly, expected %d, received %d", sizeof(Pixel), toVal.size);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
>>ASSERTION Good A
If the implementation is X11R5 or later:
A call to
Boolean XtCvtStringToPixel(display, args, num_args, from, to, converter_data)
when the conversion is not performed due to an improper value 
specified in
.A from
shall issue a warning message and return False.
>>CODE
#if XT_X_RELEASE > 4
/* Conversion arguments and results */
Boolean status;
Display *display;
XrmValue args[2];
Cardinal num_args;
XrmValue fromVal;
XrmValue toVal;
Boolean closure;
XtPointer closure_ret = (XtPointer *) &closure;
/* String to Pixel specific */
Screen *screen;
Colormap colormap;
char *pixstr = "not a real color name";
Pixel res;
pid_t pid2;
#endif

#if XT_X_RELEASE > 4
	FORK(pid2);
	avs_set_event(1, 0);
	avs_xt_hier("Tcstpix4", "XtCvtStringToPixel");
	XtAppSetWarningMsgHandler(app_ctext, XtWMH_Proc);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get display");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Set up required conversion args");
	screen = DefaultScreenOfDisplay(display);
	args[0].addr = (XtPointer )&screen;
	args[0].size = sizeof(Screen*);
	colormap = DefaultColormapOfScreen(screen);
	args[1].addr = (XtPointer) &colormap;
	args[1].size = sizeof(Colormap);
	num_args = 2;
	tet_infoline("TEST: Conversion fails");
	fromVal.addr = pixstr;
	fromVal.size = strlen(pixstr)+1;
	toVal.addr = (XtPointer) &res;
	toVal.size = sizeof(Pixel);
	status = XtCvtStringToPixel(display,
			&args[0],
			&num_args,
			&fromVal,
			&toVal,
			&closure_ret);
	check_dec(False, status, "XtCvtStringToPixel return value");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Warning handler is called");
	status = avs_get_event(1);
	check_dec(1, status, "calls to warning handler count");
	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
>>ASSERTION Good C
If the implementation is X11R5 or later:
A call to
Boolean XtCvtStringToPixel(display, args, num_args, from, to, converter_data)
when 
.A args 
specifies an improper value shall not perform a conversion,
issue a warning message, and return False.
>>CODE
#if XT_X_RELEASE > 4
/* Conversion arguments and results */
Boolean status;
Display *display;
XrmValue args[2];
Cardinal num_args;
XrmValue fromVal;
XrmValue toVal;
Boolean closure;
XtPointer closure_ret = (XtPointer *) &closure;
/* String to Pixel specific */
char *pixstr = "XtDefaultBackground";
pid_t pid2;
#endif

#if XT_X_RELEASE > 4
	FORK(pid2);
	avs_set_event(1, 0);
	avs_xt_hier("Tcstpix5", "XtCvtStringToPixel");
	XtAppSetWarningMsgHandler(app_ctext, XtWMH_Proc);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get display");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Set up required conversion args incorrectly");
	num_args = 0;
	tet_infoline("TEST: Conversion fails");
	fromVal.addr = pixstr;
	fromVal.size = strlen(pixstr)+1;
	toVal.addr = (XtPointer)0;
	toVal.size = 0;
	status = XtCvtStringToPixel(display,
			&args[0],
			&num_args,
			&fromVal,
			&toVal,
			&closure_ret);
	check_dec(False, status, "conversion status");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Warning handler is called");
	status = avs_get_event(1);
	check_dec(1, status, "calls to warning handler count");
	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
>>ASSERTION Good C
If the implementation is X11R5 or later:
On a successful call to
Boolean XtCvtStringToPixel(display, args, num_args, from, to, converter_data)
when 
.A from
specifies the constant XtDefaultForeground and the resource
.S reverseVideo
is not True the converted data shall specify the black pixel value 
of the widget screen specified in
.A args.
>>CODE
#if XT_X_RELEASE > 4
/* Conversion arguments and results */
Boolean status;
Display *display;
XrmValue args[2];
Cardinal num_args;
XrmValue fromVal;
XrmValue toVal;
Boolean closure;
XtPointer closure_ret = (XtPointer *) &closure;
/* String to Pixel specific */
Screen *screen;
Colormap colormap;
char *pixstr = XtDefaultBackground;
Pixel res;
pid_t pid2;
int     argcount = 2;
char	*cargs[] = {NULL, "-rv", NULL};
char	**arg_string;
#endif

#if XT_X_RELEASE > 4
	FORK(pid2);
	arg_string = &cargs[0];
	avs_xt_hier_args("Tcstpix6", "XtCvtStringToPixel", arg_string, argcount);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get display");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Set up required conversion args");
	screen = DefaultScreenOfDisplay(display);
	args[0].addr = (XtPointer )&screen;
	args[0].size = sizeof(Screen*);
	colormap = DefaultColormapOfScreen(screen);
	args[1].addr = (XtPointer) &colormap;
	args[1].size = sizeof(Colormap);
	num_args = 2;
	tet_infoline("TEST: Conversion succeeds");
	fromVal.addr = pixstr;
	fromVal.size = strlen(pixstr)+1;
	toVal.addr = (XtPointer) &res;
	toVal.size = sizeof(Pixel);
	status = XtCvtStringToPixel(display,
			&args[0],
			&num_args,
			&fromVal,
			&toVal,
			&closure_ret);
	check_dec(True, status, "XtCvtStringToPixel return value");
	tet_infoline("TEST: Conversion result");
	check_dec(XBlackPixelOfScreen(DefaultScreenOfDisplay(display)), res, "returned pixel");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
>>ASSERTION Good C
If the implementation is X11R5 or later:
On a successful call to
Boolean XtCvtStringToPixel(display, args, num_args, from, to, converter_data)
when 
.A from
specifies the constant XtDefaultForeground and the resource
.S reverseVideo
is True the converted data shall specify the white pixel value of the
widget screen specified in
.A args.
>>CODE
#if XT_X_RELEASE > 4
/* Conversion arguments and results */
Boolean status;
Display *display;
XrmValue args[2];
Cardinal num_args;
XrmValue fromVal;
XrmValue toVal;
Boolean closure;
XtPointer closure_ret = (XtPointer *) &closure;
/* String to Pixel specific */
Screen *screen;
Colormap colormap;
char *pixstr = XtDefaultForeground;
Pixel res;
pid_t pid2;
int     argcount = 2;
char	*cargs[] = {NULL, "-rv", NULL};
char	**arg_string;
#endif

#if XT_X_RELEASE > 4
	FORK(pid2);
	arg_string = &cargs[0];
	avs_xt_hier_args("Tcstpix7", "XtCvtStringToPixel", arg_string, argcount);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get display");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Set up required conversion args");
	screen = DefaultScreenOfDisplay(display);
	args[0].addr = (XtPointer )&screen;
	args[0].size = sizeof(Screen*);
	colormap = DefaultColormapOfScreen(screen);
	args[1].addr = (XtPointer) &colormap;
	args[1].size = sizeof(Colormap);
	num_args = 2;
	tet_infoline("TEST: Conversion succeeds");
	fromVal.addr = pixstr;
	fromVal.size = strlen(pixstr)+1;
	toVal.addr = (XtPointer) &res;
	toVal.size = sizeof(Pixel);
	status = XtCvtStringToPixel(display,
			&args[0],
			&num_args,
			&fromVal,
			&toVal,
			&closure_ret);
	check_dec(True, status, "XtCvtStringToPixel return value");
	tet_infoline("TEST: Conversion result");
	check_dec(XWhitePixelOfScreen(DefaultScreenOfDisplay(display)), res, "returned pixel");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
>>ASSERTION Good C
If the implementation is X11R5 or later:
On a successful call to
Boolean XtCvtStringToPixel(display, args, num_args, from, to, converter_data)
when 
.A from
specifies the constant XtDefaultBackground and the resource
.S reverseVideo
is not True the converted data shall specify the white pixel value 
of the widget screen specified in
.A args.
>>CODE
#if XT_X_RELEASE > 4
/* Conversion arguments and results */
Boolean status;
Display *display;
XrmValue args[2];
Cardinal num_args;
XrmValue fromVal;
XrmValue toVal;
Boolean closure;
XtPointer closure_ret = (XtPointer *) &closure;
/* String to Pixel specific */
Screen *screen;
Colormap colormap;
char *pixstr = "XtDefaultBackground";
Pixel res;
pid_t pid2;
int     argcount = 2;
char	*cargs[] = {NULL, "+rv", NULL};
char	**arg_string;
#endif

#if XT_X_RELEASE > 4
	FORK(pid2);
	arg_string = &cargs[0];
	avs_xt_hier_args("Tcstpix8", "XtCvtStringToPixel", arg_string, argcount);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get display");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Set up required conversion args");
	screen = DefaultScreenOfDisplay(display);
	args[0].addr = (XtPointer )&screen;
	args[0].size = sizeof(Screen*);
	colormap = DefaultColormapOfScreen(screen);
	args[1].addr = (XtPointer) &colormap;
	args[1].size = sizeof(Colormap);
	num_args = 2;
	tet_infoline("TEST: Conversion succeeds");
	fromVal.addr = pixstr;
	fromVal.size = strlen(pixstr)+1;
	toVal.addr = (XtPointer) &res;
	toVal.size = sizeof(Pixel);
	status = XtCvtStringToPixel(display,
			&args[0],
			&num_args,
			&fromVal,
			&toVal,
			&closure_ret);
	check_dec(True, status, "XtCvtStringToPixel return value");
	tet_infoline("TEST: Conversion result");
	check_dec(XWhitePixelOfScreen(DefaultScreenOfDisplay(display)), res, "returned pixel");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
>>ASSERTION Good C
If the implementation is X11R5 or later:
On a successful call to
Boolean XtCvtStringToPixel(display, args, num_args, from, to, converter_data)
when 
.A from
specifies the constant XtDefaultForeground and the resource
.S reverseVideo
is True the converted data shall specify the black pixel value 
of the widget screen specified in
.A args.
>>CODE
#if XT_X_RELEASE > 4
/* Conversion arguments and results */
Boolean status;
Display *display;
XrmValue args[2];
Cardinal num_args;
XrmValue fromVal;
XrmValue toVal;
Boolean closure;
XtPointer closure_ret = (XtPointer *) &closure;
/* String to Pixel specific */
Screen *screen;
Colormap colormap;
char *pixstr = XtDefaultForeground;
Pixel res;
pid_t pid2;
int     argcount = 2;
char	*cargs[] = {NULL, "+rv", NULL};
char	**arg_string;
#endif

#if XT_X_RELEASE > 4
	FORK(pid2);
	arg_string = &cargs[0];
	avs_xt_hier_args("Tcstpix9", "XtCvtStringToPixel", arg_string, argcount);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get display");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Set up required conversion args");
	screen = DefaultScreenOfDisplay(display);
	args[0].addr = (XtPointer )&screen;
	args[0].size = sizeof(Screen*);
	colormap = DefaultColormapOfScreen(screen);
	args[1].addr = (XtPointer) &colormap;
	args[1].size = sizeof(Colormap);
	num_args = 2;
	tet_infoline("TEST: Conversion succeeds");
	fromVal.addr = pixstr;
	fromVal.size = strlen(pixstr)+1;
	toVal.addr = (XtPointer) &res;
	toVal.size = sizeof(Pixel);
	status = XtCvtStringToPixel(display,
			&args[0],
			&num_args,
			&fromVal,
			&toVal,
			&closure_ret);
	check_dec(True, status, "XtCvtStringToPixel return value");
	tet_infoline("TEST: Conversion result");
	check_dec(XBlackPixelOfScreen(DefaultScreenOfDisplay(display)), res, "returned pixel");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
