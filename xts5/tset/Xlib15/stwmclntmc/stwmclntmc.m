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
$Header: /cvs/xtest/xtest/xts5/tset/Xlib15/stwmclntmc/stwmclntmc.m,v 1.1 2005-02-12 14:37:23 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1995
All Rights Reserved.

>># Project: VSW5
>># 
>># File: vsw5/tset/Xlib15/stwmclntmc/stwmclntmc.m
>># 
>># Description:
>># 	Tests for XSetWMClientMachine()
>># 
>># Modifications:
>># $Log: stwmclntmc.m,v $
>># Revision 1.1  2005-02-12 14:37:23  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:34:04  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:56:08  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:25:25  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:21:58  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.1  1996/05/09 00:29:05  andy
>># Corrected Xatom include
>>#
>># Revision 4.0  1995/12/15  09:09:34  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:11:39  andy
>># Prepare for GA Release
>>#
/*
Portions of this software are based on Xlib and X Protocol Test Suite.
We have used this material under the terms of its copyright, which grants
free use, subject to the conditions below.  Note however that those
portions of this software that are based on the original Test Suite have
been significantly revised and that all such revisions are copyright (c)
1995 Applied Testing and Technology, Inc.  Insomuch as the proprietary
revisions cannot be separated from the freely copyable material, the net
result is that use of this software is governed by the ApTest copyright.

Copyright (c) 1990, 1991  X Consortium

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
X CONSORTIUM BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

Except as contained in this notice, the name of the X Consortium shall not be
used in advertising or otherwise to promote the sale, use or other dealings
in this Software without prior written authorization from the X Consortium.

Permission to use, copy, modify, distribute, and sell this software and
its documentation for any purpose is hereby granted without fee,
provided that the above copyright notice appear in all copies and that
both that copyright notice and this permission notice appear in
supporting documentation, and that the name of UniSoft not be
used in advertising or publicity pertaining to distribution of the
software without specific, written prior permission.  UniSoft
makes no representations about the suitability of this software for any
purpose.  It is provided "as is" without express or implied warranty.
*/
>>TITLE XSetWMClientMachine Xlib15
void
XSetWMClientMachine(display, w, text_prop)
Display		*display = Dsp;
Window		w = DRW(Dsp);
XTextProperty	*text_prop = &textprop;
>>EXTERN
#include	"X11/Xatom.h"
static XTextProperty	textprop = { (unsigned char *) 0, XA_STRING, 8, (unsigned long) 0 };
>>ASSERTION Good A
A call to xname sets
the
.S WM_CLIENT_MACHINE
property for the window
.A w
to be of data, type, format and number of items as specified by the
.M value
field, the
.M encoding
field, the
.M format
field, and the
.M nitems
field of the
.S XTextProperty 
structure named by the
.A text_prop
argument.
>>STRATEGY
Create a window with XCreateWindow.
Set the WM_CLIENT_MACHINE property with XSetWMClientMachine.
Verify that the call did not return False.
Obtain the WM_CLIENT_MACHINE text property using XGetTextProperty.
Verify that the encoding component of the text property is correct.
Verify that the format component of the text property is correct.
Verify that the nitems component of the text property is correct.
Verify that the value of the text property is correct using XTextPropertyToStringList.
Release the allocated memory using XFree.
>>CODE
Window	win;
char	*str1 = "Xtest Client Machine String";
char	*str[1];
Status	status;
char	**list_return;
int	count_return;
XTextProperty	tp, rtp;
XVisualInfo	*vp;

	str[0] = str1;

	resetvinf(VI_WIN);
	nextvinf(&vp);
	win = makewin(display, vp);

	if(XStringListToTextProperty(str, 1, &tp) == False) {
		delete("XStringListToTextProperty() Failed.");
		return;
	} else
		CHECK;
	w = win;
	text_prop = &tp;
	XCALL;

	if(XGetWMClientMachine(display, win, &rtp) == False) {
		delete("XGetWMClientMachine() returned False.");
		return;
	} else
		CHECK;

	if(XGetTextProperty(display, win, &rtp, XA_WM_CLIENT_MACHINE) == False) {
		delete("XGetTextProperty() returned False.");
		return;
	} else
		CHECK;

	if(tp.encoding != rtp.encoding) {
		report("The encoding component of the XTextProperty was incorrect.");
		FAIL;
	} else
		CHECK;

	if(tp.format != rtp.format) {
		report("The format component of the XTextProperty was incorrect.");
		FAIL;
	} else
		CHECK;

	if(tp.nitems != rtp.nitems) {
		report("The nitems component of the XTextProperty was incorrect.");
		FAIL;
	} else
		CHECK;

	if(XTextPropertyToStringList( &rtp, &list_return, &count_return) == False) {
		delete("XTextPropertyToStringList() returned False.");
		return;
	} else
		CHECK;

	if (count_return != 1) {
		delete("XTextPropertyToStringList() count_return was %d instead of 1.", count_return);
		return;
	} else
		CHECK;

	if( strcmp(str1, list_return[0] ) != 0 ) {
		report("Value string was \"%s\" instead of \"%s\"", list_return[0], str1);
		FAIL;
	} else
		CHECK;

	XFree((char*)tp.value);
	XFree((char*)rtp.value);
	XFreeStringList(list_return);

	CHECKPASS(9);

>>ASSERTION Bad B 1
.ER BadAlloc
>>ASSERTION Good A
When the
.M encoding
component of the
.S XTextProperty
structure named by the
.A text_prop
argument does not name a valid atom, then a
.S BadAtom
error occurs.
>>STRATEGY
Create a window with XCreateWindow.
Create an XTextProperty structure with XStringListToTextProperty.
Set the encoding component of the structure to -1L.
Set the WM_CLIENT_MACHINE property using XSetWMClientMachine.
Verify that a BadAtom error occurred.
>>CODE BadAtom
Window	win;
char	*str1 = "Xtest Client Machine string1";
char	*str2 = "Xtest Client Machine string_2";
char	*str[2];
XTextProperty	tp;
XVisualInfo	*vp;

	resetvinf(VI_WIN);
	nextvinf(&vp);
	win = makewin(display, vp);

	str[0] = str1;
	str[1] = str2;

	if(XStringListToTextProperty(str, 2, &tp) == False) {
		delete("XStringListToTextProperty() Failed.");
		return;
	} else
		CHECK;

	w = win;
	tp.encoding = (Atom) -1L;
	text_prop = &tp;

	XCALL;

	if(geterr() != BadAtom) 
		FAIL;
	else
		CHECK;

	CHECKPASS(2);

>>ASSERTION Bad A
.ER BadWindow
>>ASSERTION Bad A
When the
.M format
component of the
.S XTextProperty
structure named by the
.A text_prop
argument is other than 8, 16 or 32, then a
.S BadValue
error occurs.
>>STRATEGY
Create a window with XCreateWindow
Create a TextProperty structure with format {0, 1, 7, 15, 31}
with XStringListToTextProperty.
Set the WM_CLIENT_MACHINE property with XSetWMClientMachine.
Verify that a BadValue error occurs.
>>EXTERN
static int bad_ones[] = {0, 1, 7, 15, 31};
>>CODE BadValue
Window	win;
char	*str1 = "Xtest test string1";
char	*str2 = "Xtest test string2";
char	*str[2];
XTextProperty	tp;
XVisualInfo	*vp;
int	i;

	resetvinf(VI_WIN);
	nextvinf(&vp);
	win = makewin(display, vp);

	str[0] = str1;
	str[1] = str2;

	if(XStringListToTextProperty(str, 2, &tp) == False) {
		delete("XStringListToTextProperty() Failed.");
		return;
	} else
		CHECK;

	for(i=0; i < NELEM(bad_ones); i++) {
		tp.format = bad_ones[i];
		w = win;
		text_prop = &tp;
		XCALL;

		if(geterr() != BadValue) 
			FAIL;
		else
			CHECK;
	}

	CHECKPASS(NELEM(bad_ones) + 1);

>># Wot no History ?
