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
$Header: /cvs/xtest/xtest/xts5/tset/Xlib15/gtcmmnd/gtcmmnd.m,v 1.1 2005-02-12 14:37:23 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1995
All Rights Reserved.

>># Project: VSW5
>># 
>># File: vsw5/tset/Xlib15/gtcmmnd/gtcmmnd.m
>># 
>># Description:
>># 	Tests for XGetCommand()
>># 
>># Modifications:
>># $Log: gtcmmnd.m,v $
>># Revision 1.1  2005-02-12 14:37:23  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:33:51  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:55:44  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:25:13  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:21:46  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.1  1996/05/09 00:28:46  andy
>># Corrected Xatom include
>>#
>># Revision 4.0  1995/12/15  09:09:00  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:10:40  andy
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
>>TITLE XGetCommand Xlib15
Status
XGetCommand(display, w, argv_return, argc_return)
Display		*display = Dsp;
Window		w = DRW(Dsp);
char		***argv_return = &argvdef;
int		*argc_return = &argcdef;
>>EXTERN
#include	"X11/Xatom.h"
char		**argvdef;
int		argcdef;
>>ASSERTION Good A
When the WM_COMMAND property is set for the window
.A w ,
is of
.M type
STRING, and is of
.M format
8, then a call to xname returns the property string list,
which can be freed with XFree,
in the
.A argv_return
argument and the number of strings in the
.A argc_return
argument and returns non-zero.
>>STRATEGY
Set the WM_COMMAND property using XSetCommand.
Obtain the value of the WM_COMMAND property using XGetCommand.
Verify that the call did not return zero.
Verify that the number and value of the returned strings is correct.
>>CODE
XVisualInfo	*vp;
Status	status;
char	*nullstr = "<NULL>";
char	**strpp, *strp;
char	*str1 = "XTest string 1____";
char	*str2 = "XTest string 2__";
char	*str3 = "XTest string 3___";
int	nstrs = 3;
char	*prop[3];
char	**rstrings = (char**) NULL;
int	rcount = 0;
int	i;

	prop[0] = str1;
	prop[1] = str2;
	prop[2] = str3;

	resetvinf(VI_WIN);
	nextvinf(&vp);
	w = makewin(display, vp);

	XSetCommand(display, w, prop, nstrs);

	argv_return = &rstrings;
	argc_return = &rcount;
	status = XCALL;

	if(status == False) {
		delete("XGetCommand() returned False.");
		return;
	} else
		CHECK;

	if(rstrings == (char **) NULL) {
		report("Returned list of strings was NULL");
		FAIL;
	} else {
		CHECK;

		if(rcount != nstrs) {
			report("%d strings were returned instead of %d", rcount, nstrs);
			FAIL;
		} else {
			CHECK;

			for(i=0, strpp = rstrings; i< nstrs; i++, strpp++) {
				strp = (*strpp == NULL ? nullstr : *strpp);

				if(strcmp(strp, prop[i]) != 0) {
					report("String %d was \"%s\" instead of \"%s\"", i, strp, prop[i]);
					FAIL;
				} else
					CHECK;
			}

		}
		XFreeStringList(rstrings);
	}

	CHECKPASS(nstrs + 3);

>>ASSERTION Good A
When the WM_COMMAND property is not set for the window
.A w ,
or is not of
.M type
STRING, or is not of
.M format
8, then a call to xname returns zero.
>>STRATEGY
Create a window with XCreateWindow.
Obtain the value of the unset WM_ICON_SIZES property using XGetCommand.
Verify that the function returned zero.

Create a window with XCreateWindow.
Set the WM_COMMAND property to have format 16 type STRING using XChangeProperty.
Obtain the value of the WM_COMMAND property using XGetCommand.
Verify that the call returned zero

Create a window with XCreateWindow.
Set the WM_COMMAND property to have format 8 and type ATOM using XChangeProperty.
Obtain the value of the WM_COMMAND property using XGetCommand.
Verify that the call returned zero.
>>CODE
Status		status;
char		*s = "XTestString1";
XVisualInfo	*vp;
char		**rstrings = (char **) NULL;
int		rcount = 0;

	resetvinf(VI_WIN);
	nextvinf(&vp);
	argv_return = &rstrings;
	argc_return = &rcount;

	w = makewin(display, vp);

/* unset property */

	status = XCALL;

	if(status != False) {
		report("%s() did not return False when the property was unset.", TestName);
		FAIL;
	} else
		CHECK;


	w = makewin(display, vp);

/* format 16 */
	XChangeProperty(display, w, XA_WM_COMMAND, XA_STRING, 16, PropModeReplace, (unsigned char *) s, strlen(s) );

	status = XCALL;

	if(status != False) {
		report("%s() did not return False when property was of format 16.", TestName);
		FAIL;
	} else
		CHECK;


	w = makewin(display, vp);

/* type ATOM */
	XChangeProperty(display, w, XA_WM_COMMAND, XA_ATOM, 8, PropModeReplace, (unsigned char *) s, strlen(s) );

	status = XCALL;

	if(status != False) {
		report("%s() did not return False when property was of type Atom.", TestName);
		FAIL;
	} else
		CHECK;


	CHECKPASS(3);

>>ASSERTION Bad B 1
When insufficient memory is available to contain the string list,
then a call to xname returns a zero status.
>># Kieron	Completed	Review
