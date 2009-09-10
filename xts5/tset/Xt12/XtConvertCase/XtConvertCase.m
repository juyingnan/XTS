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
$Header: /cvs/xtest/xtest/xts5/tset/Xt12/XtConvertCase/XtConvertCase.m,v 1.1 2005-02-12 14:37:55 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt12/XtConvertCase/XtConvertCase.m
>># 
>># Description:
>>#	Tests for XtConvertCase()
>># 
>># Modifications:
>># $Log: tcnvrtcas.m,v $
>># Revision 1.1  2005-02-12 14:37:55  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:38:02  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:02  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:29:05  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:25:38  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:21:14  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:16:55  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;

void XtCPP_Proc(dpy, sym, lower, upper)
Display *dpy;
KeySym sym;
KeySym *lower;
KeySym *upper;
{
	avs_set_event(1,1);
	*upper = XStringToKeysym("u");
	*lower = XStringToKeysym("l");
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtConvertCase Xt12
void
XtConvertCase(display, keysym, lower_return, upper_return)
>>ASSERTION Good A
A successful call to 
void XtConvertCase(display, keysym, lower_return, upper_return)
shall call the case converter for the KeySym
.A keysym
associated with the display
.A display
and return the upper and lower case equivalents for the KeySym in
the locations specified by
.A upper_return
and
.A lower_return
respectively.
>>CODE
Display *display;
KeySym keysym;
KeySym lower_return;
KeySym upper_return;
int invoked;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tcnvrtcas1", "XtConvertCase");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get display");
	display = XtDisplay(topLevel);
	tet_infoline("PREP: Get keysym for alphabet 'a'");
	keysym = XStringToKeysym("a");
	tet_infoline("PREP: Register case converter XtCPP_Proc");
	XtRegisterCaseConverter(display, &XtCPP_Proc, keysym, keysym);
	tet_infoline("PREP: Get upper and lower case version of a keysym");
	XtConvertCase(display, keysym, &lower_return, &upper_return);
	tet_infoline("TEST: Case converter XtCPP_Proc was indeed invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtCPP_Proc invoked status");
	tet_infoline("TEST: Values returned");
	if (strcmp(XKeysymToString(lower_return), "l") != 0) {
		sprintf(ebuf, "ERROR: Expected lower_return to be keysym for \"l\", is keysym for \"%s\"",  XKeysymToString(lower_return));
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	if (strcmp(XKeysymToString(upper_return), "u") != 0) {
		sprintf(ebuf, "ERROR: Expected upper_return to be keysym for \"u\", is keysym for \"%s\"",  XKeysymToString(upper_return));
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good B 3
A call to
void XtConvertCase(display, keysym, lower_return, upper_return)
when no user-registered case converter exists for
.A keysym
shall invoke the default case converter.
