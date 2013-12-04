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
>># File: xts5/Xlib15/XFreeStringList.m
>># 
>># Description:
>># 	Tests for XFreeStringList()
>># 
>># Modifications:
>># $Log: frstrlst.m,v $
>># Revision 1.2  2005-11-03 08:42:48  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:20  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:33:49  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:55:40  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:25:12  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:21:44  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:08:56  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:10:33  andy
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
>>TITLE XFreeStringList Xlib15
void
XFreeStringList(list)
char	**list = NULL;
>>EXTERN
#include "XFuzz.h"
>>ASSERTION Good A
A call to xname frees the memory allocated by a call to
.S XTextPropertyToStringList
or
.S XGetCommand . 
>>STRATEGY
Create a window using XCreateWindow.
Allocate a text property structure using XStringListToTextProperty.
Set the WM_COMMAND property using XSetCommand.
Obtain the value of the WM_COMMAND property using XGetCommand.
Obtain the strings from the XTextPropertyStructure using XTextPropertyToStringlist.
Release the memory allocated in the call to XGetCommand.
Release the memory allocated in the call to XTextPropertyToStringList.
>>CODE
char		*str1 = "TestString1";
char		*str2 = "TestString2";
char		*str3 = "TestString3";
int		argc = 3;
char		*argv[3];
int		rargc;
char		**rargv = NULL;
char		**rargv1 = NULL;
Window		w;
XVisualInfo	*vp;
XTextProperty	tp;

	argv[0] = str1;
	argv[1] = str2;
	argv[2] = str3;


	if( XStringListToTextProperty(argv, 3, &tp) == 0) {
		delete("XStringListToTextProperty() returned zero.");
		return;
	} else
		CHECK;

	if( XTextPropertyToStringList(&tp, &rargv, &rargc) == 0) {
		delete("XTextPropertyToStringList() returned zero.");
		return;
	} else
		CHECK;

	XFree((char*)tp.value);
	resetvinf(VI_WIN);
	nextvinf(&vp);
	w = makewin(Dsp, vp);

	XSetCommand(Dsp, w, argv, argc);

	if(XGetCommand(Dsp, w, &rargv1, &rargc) == 0 ) {
		delete("XGetCommand() returned zero.");
		return;
	} else
		CHECK;

	XFreeStringList(rargv1);
	XFreeStringList(rargv);

	CHECKPASS(3);
>>ASSERTION Good A
A call to xname frees the memory allocated by a call to
.S XTextPropertyToStringList
or
.S XGetCommand . 
>>STRATEGY
Create a window using XCreateWindow.
Allocate a text property structure using XStringListToTextProperty.
Set the WM_COMMAND property using XSetCommand.
Obtain the value of the WM_COMMAND property using XGetCommand.
Obtain the strings from the XTextPropertyStructure using XTextPropertyToStringlist.
Release the memory allocated in the call to XGetCommand.
Release the memory allocated in the call to XTextPropertyToStringList.
>>CODE
int		rargc;
char		**rargv = NULL;
char		**rargv1 = NULL;
Window		w;
XVisualInfo	*vp;
XTextProperty	tp;
int 		count;

for(count = 0; count < FUZZ_MAX; count ++){
	int 		fuzz = rand () % 100 + 1;
	char		*str[fuzz];
	int		argc = fuzz;
	char		*argv[fuzz];
	int i;
	for(i=0; i < fuzz; i++){
		str[i] = "TestString";
		argv[i] = str[i];	
	}

	if( XStringListToTextProperty(argv, fuzz, &tp) == 0) {
		delete("XStringListToTextProperty() returned zero.");
		return;
	} else
		CHECK;

	if( XTextPropertyToStringList(&tp, &rargv, &rargc) == 0) {
		delete("XTextPropertyToStringList() returned zero.");
		return;
	} else
		CHECK;

	XFree((char*)tp.value);
	resetvinf(VI_WIN);
	nextvinf(&vp);
	w = makewin(Dsp, vp);

	XSetCommand(Dsp, w, argv, argc);

	if(XGetCommand(Dsp, w, &rargv1, &rargc) == 0 ) {
		delete("XGetCommand() returned zero.");
		return;
	} else
		CHECK;

	XFreeStringList(rargv1);
	XFreeStringList(rargv);
}

	CHECKPASS(3 * FUZZ_MAX);
