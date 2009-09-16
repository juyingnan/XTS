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
>># File: xts5/tset/Xlib12/XGetErrorDatabaseText/XGetErrorDatabaseText.m
>># 
>># Description:
>># 	Tests for XGetErrorDatabaseText()
>># 
>># Modifications:
>># $Log: gterrrdtbs.m,v $
>># Revision 1.2  2005-11-03 08:42:35  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:18  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:33:21  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:54:44  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:24:46  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:21:18  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.1  1996/05/09 00:36:30  andy
>># Corrected Xproto include
>>#
>># Revision 4.0  1995/12/15  09:07:30  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:07:53  andy
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
>>TITLE XGetErrorDatabaseText Xlib12
void
XGetErrorDatabaseText()
Display *display = Dsp;
char *name;
char *message;
char *default_string = "default_string";
char *buffer_return = buffer;
int length = sizeof(buffer);
>>EXTERN
#include "X11/Xproto.h"

static char buffer[512];
>>ASSERTION Good A
>>#NOTE	As the precise format of a message is not defined,
>>#NOTE there is not too much which can be tested.
>>#NOTE Therefore, this assertion is deliberately vague.
A call to xname
returns a string in
.A buffer_return .
>>STRATEGY
Set each character in buffer_return to non-ASCII NUL.
Set name to \"foo\".
Set message to \"bar\".
Call XGetErrorText.
Verify that there exists at least one ASCII NUL
character in buffer_return.
>>CODE
int	i;

/* Set each character in buffer_return to non-ASCII NUL. */
	for (i=0; i < sizeof(buffer); i++) {
		if (!i)
			CHECK;
		buffer[i] = 'A';
	}
	buffer_return = buffer;
/* Set name to "foo". */
	name = "foo";
/* Set message to "bar". */
	message = "bar";
/* Call XGetErrorText. */
	XCALL;
/* Verify that there exists at least one ASCII NUL */
/* character in buffer_return. */
	for (i=0; i < sizeof(buffer); i++) {
		if (buffer[i] == '\0') {
			CHECK;
			break;
		}
	}
	if (i == sizeof(buffer)) {
		report("String not returned.");
		FAIL;
	}
	else
		CHECK;
	CHECKPASS(3);
>>ASSERTION Good A
A call to xname
with
.A name
set to the string
.S XProtoError
and
.A message
set to the string representation of a protocol error number
returns a string terminated with ASCII NUL in
.A buffer_return .
>>STRATEGY
Set each character in buffer_return to non-ASCII NUL.
Set name to \"XProtoError\".
Set message to the string representation of BadWindow.
Call XGetErrorText.
Verify that there exists at least one ASCII NUL
character in buffer_return.
>>CODE
int	i;
char	msgbuf[512];

/* Set each character in buffer_return to non-ASCII NUL. */
	for (i=0; i < sizeof(buffer); i++) {
		if (!i)
			CHECK;
		buffer[i] = 'A';
	}
	buffer_return = buffer;
/* Set name to "XProtoError". */
	name = "XProtoError";
/* Set message to the string representation of BadWindow. */
	(void) sprintf(msgbuf, "%d", BadWindow);
	message = msgbuf;
/* Call XGetErrorText. */
	XCALL;
/* Verify that there exists at least one ASCII NUL */
/* character in buffer_return. */
	for (i=0; i < sizeof(buffer); i++) {
		if (buffer[i] == '\0') {
			CHECK;
			break;
		}
	}
	if (i == sizeof(buffer)) {
		report("Returned string not terminated with ASCII NUL.");
		FAIL;
	}
	else
		CHECK;
	CHECKPASS(3);
>>ASSERTION Good A
A call to xname
with
.A name
set to the string
.S XRequest
and
.A message
set to the string representation of a major protocol number
returns a string terminated with ASCII NUL in
.A buffer_return .
>>STRATEGY
Set each character in buffer_return to non-ASCII NUL.
Set name to \"XRequest\".
Set message to the string representation of X_DestroyWindow.
Call XGetErrorText.
Verify that there exists at least one ASCII NUL
character in buffer_return.
>>CODE
int	i;
char	msgbuf[512];

/* Set each character in buffer_return to non-ASCII NUL. */
	for (i=0; i < sizeof(buffer); i++) {
		if (!i)
			CHECK;
		buffer[i] = 'A';
	}
	buffer_return = buffer;
/* Set name to "XRequest". */
	name = "XRequest";
/* Set message to the string representation of X_DestroyWindow. */
	(void) sprintf(msgbuf, "%d", X_DestroyWindow);
	message = msgbuf;
/* Call XGetErrorText. */
	XCALL;
/* Verify that there exists at least one ASCII NUL */
/* character in buffer_return. */
	for (i=0; i < sizeof(buffer); i++) {
		if (buffer[i] == '\0') {
			CHECK;
			break;
		}
	}
	if (i == sizeof(buffer)) {
		report("Returned string not terminated with ASCII NUL.");
		FAIL;
	}
	else
		CHECK;
	CHECKPASS(3);
>>ASSERTION Good D 1
If the implementation supports an error database:
The error message database used is
.S /usr/lib/X11/XErrorDB .
>>ASSERTION Good B 1
When a call to xname is made and
no string is found in the error database,
then
.A default_string
is returned in
.A buffer_return .
