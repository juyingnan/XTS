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
>># File: xts5/Xlib3/XConnectionNumber.m
>># 
>># Description:
>># 	Tests for XConnectionNumber()
>># 
>># Modifications:
>># $Log: cnnctnnmbr.m,v $
>># Revision 1.2  2005-11-03 08:43:17  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:24  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:35:03  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:57:29  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:26:19  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:22:52  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:12:14  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:15:08  andy
>># Prepare for GA Release
>>#
>>#:
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
>>SET   macro
>>TITLE XConnectionNumber Xlib3
int
XConnectionNumber(display)
Display	*display = Dsp;
>>EXTERN
static	Display	*client;
static	int	exit_status = -1;
static	int	path_checker = -1;

static int
errorhandler(display)
Display *display;
{
	/* Handler exits with exit status of exit_status. */
	if(path_checker == 2)
		exit(exit_status);
	else
		exit(exit_status - 1);
}

/*
 * Child exits with exit_status on success.
 * Child exits with exit_status+1 to indicate TET_DELETE.
 * Child exits with exit_status-1 to indicate close failure.
 */
static	void
closer()
{
int	cnn;	

	path_checker = 0;
	XSetIOErrorHandler( errorhandler );
	client = opendisplay();

	if (client == NULL) {
		report("Cannot open display.");
		exit(exit_status + 1);
	} else
		path_checker++;

	cnn = XConnectionNumber(client); 

	if (close(cnn)) {
		report("Close failed on ConnectionNumber %d.", cnn);
		exit(exit_status + 1);
	} else
		path_checker++;

	XNoOp(client);
	XFlush(client);
	report("Handler not invoked or did not exit");
	exit(exit_status - 1);
}

>>ASSERTION Good D 1
If the system is POSIX compliant:
A call to xname returns the file descriptor of the display
specified by the 
.A display
argument.
Otherwise:
A call to xname returns the connection number of the display
specified by the 
.A display
argument.
>>STRATEGY
If the system is POSIX compliant:
  Open a display using XOpenDisplay.
  Create a child process.
  In Child :
    Set IOErrorHandler to an errorhandler function which exits immediately.
    Obtain the connection number of the display using xname.
    Close the connection using close.
    Perform a XNoOp request on the display.
    Flush the O/P using using XFlush.
  In parent:
    Obtain child's exit status.
    Verify that the child exited from the error handler.
Otherwise:
  UNTESTED
>>CODE
int	child_exit;

	if(config.posix_system == 1) {
		exit_status = 1;
		child_exit = tet_fork(closer, TET_NULLFP, 0, ~0);

		if (child_exit == exit_status+1) {
			delete("Child process experienced unexpected problem.");
			return;
		} else {
			CHECK;

			if (child_exit != exit_status) {
				report("The IOError handler was not invoked (got %d exit status, expected %d).", child_exit, exit_status);
				FAIL;
			} else
				CHECK;
		}
		CHECKPASS(2);
	} else
		untested("The assertion can only be tested on a POSIX compliant system.");
