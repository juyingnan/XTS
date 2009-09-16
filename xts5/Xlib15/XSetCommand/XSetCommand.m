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
$Header: /cvs/xtest/xtest/xts5/tset/Xlib15/XSetCommand/XSetCommand.m,v 1.2 2005-11-03 08:42:50 jmichael Exp $

Copyright (c) Applied Testing and Technology, Inc. 1995
All Rights Reserved.

>># Project: VSW5
>># 
>># File: xts5/tset/Xlib15/XSetCommand/XSetCommand.m
>># 
>># Description:
>># 	Tests for XSetCommand()
>># 
>># Modifications:
>># $Log: stcmmnd.m,v $
>># Revision 1.2  2005-11-03 08:42:50  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:21  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:34:00  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:56:00  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:25:22  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:21:54  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.1  1996/05/09 00:29:00  andy
>># Corrected Xatom include
>>#
>># Revision 4.0  1995/12/15  09:09:24  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:11:23  andy
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
>>TITLE XSetCommand Xlib15

XSetCommand(display, w, argv, argc)
Display	*display = Dsp;
Window	w = DRW(Dsp);
char	**argv = & argp;
int	argc = 0;
>>EXTERN
#include	"X11/Xatom.h"
char	*argp;
>>#
>># COMMENT:	We now assume that the WM_COMMAND property is
>>#		of type STRING and of format 8.
>>#
>># Cal 7/6/91
>>#
>># >>ASSERTION Good A
>># A call to xname sets the WM_COMMAND property for the window
>># .A w
>># to
>># .A argc
>># of the arguments specified by the
>># .A argv
>># argument.
>>#
>>ASSERTION Good A
A call to xname sets the WM_COMMAND property
for the window
.A w
to
.A argc
of the arguments specified by the
.A argv
argument and to have
.M type 
STRING and
.M format
8.
>>STRATEGY
Create a window using XCreateWindow.
Set the WM_COMMAND property using XSetCommand.
Obtain the value of the WM_COMMAND property using XGetTextProperty.
Verify that the number and value of the returned strings is correct.
Release the allocated memory using XFreeStringList.
>>CODE
XVisualInfo	*vp;
char	*nullstr = "<NULL>";
char	**strpp, *strp;
char	*str1 = "XTest string 1";
char	*str2 = "XTest string 2";
char	*prop[2];
char	**rstrings = (char**) NULL;
int	rcount = 0;
int	i;
XTextProperty	rtp;
Status	status;
char	**list_return;
int	count_return;
int	len;

	prop[0] = str1;
	prop[1] = str2;

	resetvinf(VI_WIN);
	nextvinf(&vp);
	w = makewin(display, vp);
	argv = prop;
	argc = 2;
	XCALL;

	if(XGetTextProperty(display, w, &rtp, XA_WM_COMMAND) == False) {
		delete("XGetTextProperty() returned False.");
		return;
	} else
		CHECK;

	if(rtp.encoding != XA_STRING ) {
		report("The encoding component of the XTextProperty was %lu instead of STRING (%lu).",
			(unsigned long)rtp.encoding, (unsigned long)XA_STRING);
		FAIL;
	} else
		CHECK;

	if(rtp.format != 8) {
		report("The format component of the XTextProperty was %d instead of %d.", rtp.format, 8 );
		FAIL;
	} else
		CHECK;

	len = strlen(str1) + 1 + strlen(str2) + 1;

	if(rtp.nitems != len) {
		report("The nitems component of the XTextProperty was %lu instead of %lu.", rtp.nitems, len);
		FAIL;
	} else
		CHECK;

    /*
     * Ignore final <NUL> if present since UNIX WM_COMMAND is nul-terminated, unlike
     * the nul-separated text properties.
     * Cal - 7/6/91
     */
	if (rtp.value[rtp.nitems - 1] == '\0') rtp.nitems--;


	if(XTextPropertyToStringList( &rtp, &list_return, &count_return) == False) {
		delete("XTextPropertyToStringList() returned False.");
		return;
	} else
		CHECK;
	
	if (count_return != argc) {
		delete("XTextPropertyToStringList() count_return was %d instead of %d.", count_return, argc);
		return;
	} else
		CHECK;

	if( (strcmp(str1, list_return[0]) != 0) || (strcmp(str2, list_return[1]) != 0) ) {
		report("Value strings were:");
		report("\"%s\" and \"%s\"", list_return[0], list_return[1]);
		report("Instead of:");
		report("\"%s\" and \"%s\"", str1, str2);
		FAIL;
	} else
		CHECK;

	XFree((char*)rtp.value);
	XFreeStringList(list_return);

	CHECKPASS(7);

>>ASSERTION Bad B 1
.ER BadAlloc 
>>ASSERTION Bad A
.ER BadWindow 
>># Kieron	Action	Review
