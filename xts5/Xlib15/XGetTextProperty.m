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

Copyright (c) Applied Testing and Technology, Inc. 1995
All Rights Reserved.

>># Project: VSW5
>># 
>># File: xts5/Xlib15/XGetTextProperty.m
>># 
>># Description:
>># 	Tests for XGetTextProperty()
>># 
>># Modifications:
>># $Log: gttxtprprt.m,v $
>># Revision 1.2  2005-11-03 08:42:49  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:20  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:33:54  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:55:48  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:25:16  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:21:48  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.1  1996/05/09 00:28:50  andy
>># Corrected Xatom include
>>#
>># Revision 4.0  1995/12/15  09:09:07  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:10:53  andy
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
>>TITLE XGetTextProperty Xlib15
Status
XGetTextProperty(display, w, text_prop_return, property);
Display		*display = Dsp;
Window		w = DRW(Dsp);
XTextProperty	*text_prop_return = &textprop;
Atom		property = XA_WM_NAME;
>>EXTERN
#include	"X11/Xatom.h"
#include 	"XFuzz.h"
static XTextProperty	textprop = { (unsigned char *) 0, XA_STRING, 8, (unsigned long) 0 };
>>ASSERTION Good A
When the property specified by the 
.A property
argument exists on the window specified by the
.A w
argument, then a call to xname stores
the data, which can be freed with XFree, in the
.M value
field, the type of the data in the
.M encoding
field, the format of the data in the
.M format
field, and the number of items of data in the
.M nitems
field of the 
.S XTextProperty 
structure named by the
.A text_prop_return
argument and returns non-zero.
>>STRATEGY
Create a window with XCreateWindow.
Set the property WM_NAME for the window with XSetTextProperty.
Obtain the value of the WM_NAME property with XGetTextProperty.
Verify that the encoding, format, value and nitems fields of the returned structure are correct.
Release the allocated memory using XFree.
>>CODE
Window	win;
char	*str1 = "Xtest test string1";
char	*str2 = "Xtest test string2";
char	*str[2];
Status	status;
char	**list_return;
int	count_return;
XTextProperty	tp, rtp;
XVisualInfo	*vp;

	str[0] = str1;
	str[1] = str2;

	resetvinf(VI_WIN);
	nextvinf(&vp);
	win = makewin(display, vp);

	if(XStringListToTextProperty(str, 2, &tp) == False) {
		delete("XStringListToTextProperty() Failed.");
		return;
	} else 
		CHECK;

	XSetTextProperty(display, win, &tp, property);

	text_prop_return = &rtp;
	w = win;
	status = XCALL;

	if(status == False) {
		report("XGetTextProperty() returned False.");
		FAIL;
	} else
		CHECK;

	if(rtp.encoding != XA_STRING) {
		report("Property was not of type STRING");
		FAIL;
	} else
		CHECK;

	if(rtp.format != 8) {
		report("Format was %d instead of 8", rtp.format);
		FAIL;
	} else
		CHECK;

	if(rtp.nitems != strlen(str1) + strlen(str2) + 1) {
		report("The nitems component was %lu instead of %d", rtp.nitems,1 +  strlen(str1) + strlen(str2) );
		FAIL;
	} else
		CHECK;

	if(XTextPropertyToStringList( &rtp, &list_return, &count_return) == False) {
		delete("XTextPropertyToStringList() returned False.");
		return;
	} else
		CHECK;

	if (count_return != 2) {
		delete("count_return was %d instead of 2.", count_return);
		return;
	} else
		CHECK;

	if( (strncmp(str1, list_return[0], strlen(str1)) != 0) ||
		(strncmp(str2, list_return[1], strlen(str2)) != 0) ) {

		report("Value strings were:");
		report("\"%s\" and \"%s\"", list_return[0], list_return[1]);
		report("Instead of:");
		report("\"%s\" and \"%s\"", str1, str2);
		FAIL;
	} else
		CHECK;

	XFree((char*)tp.value);
	XFree((char*)rtp.value);
	XFreeStringList(list_return);
	CHECKPASS(8);

>>ASSERTION Good A
When the property specified by the
.A property
argument does not exist on the window
specified by the
.A w
argument, then a call to xname sets the 
.M value
field to NULL, the 
.M encoding
field to None, the
.M format
field to 0 and the 
.M nitems
field to 0 of the
.S XTextProperty
structure named by the
.A text_prop_return
argument and returns zero.
>>STRATEGY
Create a window with XCreateWindow
Get the value of the unset property WM_NAME with XGetTextProperty
Verify that the call returned False
Verify that in the returned structure the encoding field was none,
  the format component was 0, the nitems component was 0 and the
  value component was NULL.
>>CODE
Window	win;
Status	status;
XTextProperty	tp;
XVisualInfo	*vp;

	tp.value = (unsigned char *) "XTuninit";
	tp.format = 1;
	tp.encoding = (Atom) 1;
	tp.nitems = (unsigned long) 1;

	resetvinf(VI_WIN);
	nextvinf(&vp);
	win = makewin(display, vp);

	text_prop_return = &tp;
	w = win;
	status = XCALL;

	if(status != False) {
		report("XGetTextProperty() did not return False.");
		FAIL;
	} else
		CHECK;

	if(tp.encoding != None) {
		report("Property was not of type None");
		FAIL;
	} else
		CHECK;
	
	if(tp.format != 0) {
		report("The format component was %d instead of 0", tp.format);
		FAIL;
	} else
		CHECK;

	if(tp.nitems != 0) {
		report("The nitems component was %lu instead of 0", tp.nitems);
		FAIL;
	} else
		CHECK;

	if(tp.value != (unsigned char *) NULL) {
		report("The value component was not NULL."); 
		FAIL;
	} else
		CHECK;

	CHECKPASS(5);

>>ASSERTION Bad A
.ER BadAtom 
>>ASSERTION Bad A
.ER BadWindow
>>ASSERTION Good A
When the property specified by the 
.A property
argument exists on the window specified by the
.A w
argument, then a call to xname stores
the data, which can be freed with XFree, in the
.M value
field, the type of the data in the
.M encoding
field, the format of the data in the
.M format
field, and the number of items of data in the
.M nitems
field of the 
.S XTextProperty 
structure named by the
.A text_prop_return
argument and returns non-zero.
>>STRATEGY
Create a window with XCreateWindow.
Set the property WM_NAME for the window with XSetTextProperty.
Obtain the value of the WM_NAME property with XGetTextProperty.
Verify that the encoding, format, value and nitems fields of the returned structure are correct.
Release the allocated memory using XFree.
>>CODE
Window	win;
Status	status;
char	**list_return;
int	count_return;
XTextProperty	tp, rtp;
XVisualInfo	*vp;
int 		count;

for(count = 0; count < FUZZ_MAX; count ++){
	int 		fuzz = rand () % 100 + 1;
	char		*str[fuzz];
	int i;
	for(i=0; i < fuzz; i++){
		str[i] = "TestString";
	}
	
	resetvinf(VI_WIN);
	nextvinf(&vp);
	win = makewin(display, vp);

	if(XStringListToTextProperty(str, fuzz , &tp) == False) {
		delete("XStringListToTextProperty() Failed.");
		return;
	} else 
		CHECK;

	XSetTextProperty(display, win, &tp, property);

	text_prop_return = &rtp;
	w = win;
	status = XCALL;

	if(status == False) {
		report("XGetTextProperty() returned False.");
		FAIL;
	} else
		CHECK;

	if(rtp.encoding != XA_STRING) {
		report("Property was not of type STRING");
		FAIL;
	} else
		CHECK;

	if(rtp.format != 8) {
		report("Format was %d instead of 8", rtp.format);
		FAIL;
	} else
		CHECK;

	if(XTextPropertyToStringList( &rtp, &list_return, &count_return) == False) {
		delete("XTextPropertyToStringList() returned False.");
		return;
	} else
		CHECK;

	if (count_return != fuzz) {
		delete("count_return was %d instead of %d.", count_return, fuzz);
		return;
	} else
		CHECK;

	XFree((char*)tp.value);
	XFree((char*)rtp.value);
	XFreeStringList(list_return);
}
	CHECKPASS(6 * FUZZ_MAX);
>># Does this contain the XStringListToTextProperty that crashes servers??
>>#		kieron
>># See comment in test 1 for the answer to that question.
>>#		Cal
>># Kieron	Completed	Review
