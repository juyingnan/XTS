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
$Header: /cvs/xtest/xtest/xts5/tset/Xlib10/lsthsts/lsthsts.m,v 1.2 2005-11-03 08:42:18 jmichael Exp $

Copyright (c) Applied Testing and Technology, Inc. 1995
All Rights Reserved.

>># Project: VSW5
>># 
>># File: xts5/tset/Xlib10/lsthsts/lsthsts.m
>># 
>># Description:
>># 	Tests for XListHosts()
>># 
>># Modifications:
>># $Log: lsthsts.m,v $
>># Revision 1.2  2005-11-03 08:42:18  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:15  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:30:59  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:50:21  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:22:43  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:19:16  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:00:40  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  00:56:38  andy
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
>>TITLE XListHosts Xlib10
XHostAdress *

Display	*display = Dsp;
int 	*nhosts_return = &Nhosts;
Bool	*state_return = &State;
>>EXTERN

#include	"xthost.h"

static	int 	Nhosts;
static	Bool	State;

>>ASSERTION Good A
A call to xname
returns a pointer to a list of host structures,
that can be freed with
.F XFree ,
for hosts that
are in the current access control list and
returns the size of the list in
.A nhosts_return .
>>STRATEGY
Attempt to add some hosts to the access list.
If BadAccess error:
  Note that the known address will not necessarily be in list.
Call xname.
If hosts were added to the access list:
  Verify that nhosts_return is greater than or equal to number of known names.
  Verify that each known name is in the list.
Verify that nhosts_return addresses can be accessed in the return value.
Free returned value with XFree.
>>CODE
XHostAddress	*list;
int 	couldadd = 0;
int 	i, j;

	CATCH_ERROR(display);
	XAddHosts(display, xthosts, nxthosts);
	RESTORE_ERROR(display);

	if (GET_ERROR(display) == BadAccess) {
		couldadd = False;
		debug(1, "Could not add hosts");
	} else {
		couldadd = True;
	}

	list = XCALL;

	if (couldadd) {
		if (*nhosts_return >= nxthosts)
			CHECK;
		else {
			report("nhosts was %d, expecting at least %d",
				*nhosts_return, nxthosts);
			FAIL;
		}

		for (i = 0; i < nxthosts; i++) {
			for (j = 0; j < *nhosts_return; j++) {
				if (samehost(&xthosts[i], &list[j]))
					break;
			}
			if (j == *nhosts_return) {
				report("Host list did not include xthosts[%d]", i);
				FAIL;
			} else if (i == 0)
				CHECK;
		}
	} else {
		CHECK; CHECK;	/* For balance */
	}

	for (j = 0; j < *nhosts_return; j++) {
		/* Do something to access addresses */
		trace("family=%d, length=%d", list[j].family, list[j].length);
	}
	XFree((char*)list);

	CHECKPASS(2);
>>ASSERTION Good A
A call to xname returns a boolean to
.A state_return
that is
.S True
to mean that the use of the list is enabled for restricting the hosts
that are allowed to make connections
and is
.S False
to mean that the use of the list is disabled and that any host
can connect.
>>STRATEGY
Call xname.
Verify that state_return is either True or False.
>>CODE
XHostAddress	*list;

	list = XCALL;

	if (*state_return == True || *state_return == False)
		CHECK;
	else {
		report("State return was neither True or False");
		FAIL;
	}

	CHECKPASS(1);

	XFree((char*)list);
