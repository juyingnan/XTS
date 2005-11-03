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
$Header: /cvs/xtest/xtest/xts5/tset/Xlib12/stioerrrhn/stioerrrhn.m,v 1.3 2005-11-03 08:42:36 jmichael Exp $

Copyright (c) 2001 The Open Group
Copyright (c) Applied Testing and Technology, Inc. 1995
All Rights Reserved.

>># Project: VSW5
>># 
>># File: xts5/tset/Xlib12/stioerrrhn/stioerrrhn.m
>># 
>># Description:
>># 	Tests for XSetIOErrorHandler()
>># 
>># Modifications:
>># $Log: stioerrrhn.m,v $
>># Revision 1.3  2005-11-03 08:42:36  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.2  2005/04/21 09:40:42  ajosey
>># resync to VSW5.1.5
>>#
>># Revision 8.2  2005/01/21 10:39:27  gwc
>># Updated copyright notice
>>#
>># Revision 8.1  2001/03/28 14:47:38  vsx
>># tp1,7 - make conditional on POSIX support
>>#
>># Revision 8.0  1998/12/23 23:33:28  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:54:59  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:24:53  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:21:25  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:07:53  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:08:35  andy
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
>>TITLE XSetIOErrorHandler Xlib12
int ((*)())()
XSetIOErrorHandler(handler)
int (*handler)();
>>EXTERN
#include <signal.h>
#include <sys/wait.h>

#define	_xcall_(rvalue)		rvalue = XSetIOErrorHandler(handler)

static	Display	*client;
static	int	exit_status = -1;
static	int	counter = 0;

/*
 * various exit values are used because we do not know the exit status
 * used by the default handler
 */
static	int	exit_statuses[] = {
	2, 3, 4, 8, 16
};

static int
errorhandler(display)
Display *display;
{
	/* Handler exits with exit status of exit_status. */
	exit(exit_status);
}

static int
_errorhandler(display)
Display *display;
{
	/* Handler returns first time called. */
	/* Handler exits upon second and subsequent invocations */
	/* with exit status of exit_status. */
	if (counter++)
		exit(exit_status);
	return(0);
}

/*
 * Child exits with exit_status on success.
 * Child exits with exit_status+1 to indicate TET_DELETE.
 * Child exits with exit_status-1 to indicate failure.
 */
static	void
child_proc1()
{
	Window	w;
	int 	fail = 0;

	/* Child process closes connection number. */
	if (close(ConnectionNumber(client))) {
		report("Close failed on ConnectionNumber number.");
		exit(exit_status + 1);
	}
	/* Child process attempts to communicate to server, */
	/* causing handler to be invoked. */
	w = XCreateSimpleWindow(client, DefaultRootWindow(client), 1, 1, 50, 50, 1, 0, 0);
	XFlush(client);

	report("Handler not invoked or did not exit");
	FAIL;
	exit(exit_status - 1);
}

>>#NOTE	Because the handler does not return, most of these tests must
>>#NOTE	be done through a child process.
>>ASSERTION Good A
A call to xname sets the fatal I/O error handler to
.A handler .
>>STRATEGY
Call XSetIOErrorHandler to set the handler to errorhandler.
Open display.
Set exit_status.
Create child process.
Child process closes connection number.
Child process attempts to communicate to server,
causing handler to be invoked.
Handler exits with exit status of exit_status.
Verify that child's exit status was exit_status.
Repeat for various other exit_status values.
>>CODE
int	(*proc)();
int	child_exit;
int	i;

/* The strategy uses ConnectionNumber, so can only be used on POSIX systems */
	if(config.posix_system != 1) {
		untested("The assertion can only be tested on a POSIX compliant system.");
		return;
	}

/* Call XSetIOErrorHandler to set the handler to errorhandler. */
	handler = errorhandler;
	_xcall_(proc);
	for (i=0; i<NELEM(exit_statuses); i++) {
/* Open display. */
		client = opendisplay();
		if (client == (Display *) NULL) {
			delete("Can not open display");
			return;
		}
		else
			CHECK;
/* Set exit_status. */
		exit_status = exit_statuses[i];
		XFlush(client);
/* Create child process. */
		child_exit = tet_fork(child_proc1, (void (*)()) NULL, 20, ~0);
/* Child process closes connection number. */
/* Child process attempts to communicate to server, */
/* causing handler to be invoked. */
/* Handler exits with exit status of exit_status. */
/* Verify that child's exit status was exit_status. */
		if (child_exit == (exit_statuses[i]+1)) {
			delete("Child process experienced unexpected problem.");
			return;
		}
		else
			CHECK;
		if (child_exit != exit_statuses[i]) {
			report("Handler not invoked (got %d exit status, expected %d.", child_exit, exit_statuses[i]);
			FAIL;
		}
		else
			CHECK;
/* Repeat for various other exit_status values. */
	}
	CHECKPASS(3*NELEM(exit_statuses));
>>ASSERTION Good A
A call to xname returns the previous fatal I/O error handler.
>>STRATEGY
Call XSetIOErrorHandler to set error handler to errorhandler.
Call XSetIOErrorHandler to set error handler to _errorhandler.
Verify that errorhandler was returned.
Call XSetIOErrorHandler to set error handler to errorhandler.
Verify that _errorhandler was returned.
>>CODE
int	(*proc)();

/* Call XSetIOErrorHandler to set error handler to errorhandler. */
	handler = errorhandler;
	_xcall_(proc);
/* Call XSetIOErrorHandler to set error handler to _errorhandler. */
	handler = _errorhandler;
	_xcall_(proc);
/* Verify that errorhandler was returned. */
	if (proc != errorhandler) {
		report("Returned 0x%x, expected 0x%x", proc, errorhandler);
		FAIL;
	}
	else
		CHECK;
/* Call XSetIOErrorHandler to set error handler to errorhandler. */
	handler = errorhandler;
	_xcall_(proc);
/* Verify that _errorhandler was returned. */
	if (proc != _errorhandler) {
		report("Returned 0x%x, expected 0x%x", proc, _errorhandler);
		FAIL;
	}
	else
		CHECK;
	CHECKPASS(2);
>>ASSERTION Good B 1
On a call to xname with
.A handler
set to NULL
the fatal I/O error handler is set to the default fatal I/O error handler.
>>ASSERTION Good A
>>#NOTE May want to fork() and have the child invoke the error handler.
>>#NOTE Verify merely that XSetIOErrorHandler does not return and that
>>#NOTE the child exited.
The default fatal I/O error handler prints a message and exits.
>>STRATEGY
Get default error handler.
Create child process.
Child calls default error handler and loops forever.
Parent sleeps for 10 seconds.
Parent verifies that child no longer exists.
>>EXTERN

#include <stdio.h>
#define	MESSBUF	55

>>CODE
int	(*proc)();
pid_t	child;
int	stat_loc;
int	waitstatus;
int     p[2];
int     gotmessage = 0;
char    buf[MESSBUF];
FILE    *fp;

	client = Dsp;
/* Get default error handler. */
	handler = (int (*)()) NULL;
	_xcall_(proc);
	/* requires two calls! */
	_xcall_(proc);

	if (pipe(p) == -1) {
		delete("Could not create pipe");
		return;
	}

/* Create child process. */
	child = fork();
	if (!child) {

		close(p[0]);
		/*
		 * Capture both stdout and stderr into the pipe.
		 */
		dup2(p[1], 1);
		dup2(p[1], 2);

/* Child calls default error handler and loops forever. */
		(*proc)(client);
		/*
		 * Now close the pipe to make sure that the parent will not hang.
		 */
		close(p[1]);
		close(1);
		close(2);

		for (;;)
			continue;
	}
	else
		CHECK;

	close(p[1]);

/* Parent sleeps for 10 seconds. */
	sleep(10);
    /*
     * Read message in reasonable size chunks.
     */
    fp = fdopen(p[0], "r");
    if (fp == NULL) {
        delete("Could not fdopen pipe");
        return;
    }
    trace("The message produced by the default handler:");
    gotmessage = 0;
    while (fgets(buf, MESSBUF-1, fp)) {
        gotmessage = 1;
        buf[MESSBUF-1] = '\0';
        trace("Message: %s", buf);
    }

    if (!gotmessage) {
        report("No message was printed");
        FAIL;
    } else
        CHECK;

/* Parent verifies that child no longer exists. */
	waitstatus = waitpid(child, &stat_loc, WNOHANG);
	if (waitstatus != child) {
		report("Child did not exit.");
		FAIL;
		(void) kill(child, SIGKILL);
		(void) waitpid(child, &stat_loc, WNOHANG);
	}
	else
		CHECK;
	CHECKPASS(3);
>>ASSERTION Good B 5
There is no limit to the number of times xname may be called.
>>STRATEGY
Set handler to errorhandler.
Call XSetIOErrorHandler 1000 times.
Report untested.
>>CODE
int	(*proc)();
int	i;

/* Set handler to errorhandler. */
	handler = errorhandler;
/* Call XSetIOErrorHandler 1000 times. */
	for (i=0; i<1000; i++) {
		if (i == 0)
			CHECK;
		proc = XCALL;
	}
/* Report untested. */
	CHECKUNTESTED(1);
>>ASSERTION def
>>#NOTE	This is tested in the first assertion where we force
>>#NOTE a system call error to cause the handler to be called.
When a system call error occurs, then Xlib calls
.A handler .
>>ASSERTION Good A
>>#NOTE	It appears that when the handler returns Xlib prints
>>#NOTE	some diagnostics.
When
.A handler
returns,
then the client process exits.
>>STRATEGY
Call XSetIOErrorHandler to set the handler to _errorhandler.
Open display.
Set exit_status.
Create child process.
Child process closes connection number.
Child process attempts to communicate to server,
causing handler to be invoked.
Handler returns first time called.
Verify that handler exited in the child proc.
>>CODE
int	(*proc)();
int	child_exit;
char	*server;

/* The strategy uses ConnectionNumber, so can only be used on POSIX systems */
	if(config.posix_system != 1) {
		untested("The assertion can only be tested on a POSIX compliant system.");
		return;
	}

	if ((server = config.display) == (char *) NULL) {
		delete("XT_DISPLAY not set");
		return;
	}
	else
		CHECK;
/* Call XSetIOErrorHandler to set the handler to _errorhandler. */
	handler = _errorhandler;
	_xcall_(proc);
/* Open display. */

	client = XOpenDisplay(server);
	if (client == (Display *) NULL) {
		delete("Can not open display: %s", server);
		return;
	}
	else
		CHECK;

/* Set exit_status. */
	exit_status = exit_statuses[0];

	counter = 0;
/* Create child process. */
/* Child process closes connection number. */
/* Child process attempts to communicate to server, */
/* causing handler to be invoked. */
/* Handler returns first time called. */
	XFlush(client);
	child_exit = tet_fork(child_proc1, (void (*)()) NULL, 10, ~0);

	/*
	 * Since the exit status when the handler returns is not known, then
	 * no checks can be made on it.
	 * If the handler did not exit then this will have been reported in the
	 * child.  In this case the pass here will be spurious, however the
	 * TET will give precedence to the fail, so a false pass will not result.
	 */
	CHECKPASS(2);
