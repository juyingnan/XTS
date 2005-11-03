/*
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
*/
/*
* $Header: /cvs/xtest/xtest/xts5/src/libXtTest/waitfor.c,v 1.2 2005-11-03 08:42:02 jmichael Exp $
*
* Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
* Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
* All Rights Reserved.
*
* Project: VSW5
*
* File: xts5/src/lib/libXtTest/waitfor.c
*
* Description:
*	Routine to wait for child process exit
*
* Modifications:
* $Log: waitfor.c,v $
* Revision 1.2  2005-11-03 08:42:02  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:10  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:25:42  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:43:56  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:18:01  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:14:33  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:45:27  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:43:23  andy
* Prepare for GA Release
*
*/

#include <XtTest.h>
#include <sys/wait.h>

#include <errno.h>

/*error messages formatted here*/
char ebuf[4096];
int s2;

/*signal handler*/
static void lsah2(s)
int s;
{
	got_sigalrm++;
}

/*
** Wait for a child process to exit, then return child's process status.
**
** Arguments
**	pid		Process ID of the child we are waiting for.
**	timeout		Maximum time (in seconds) to wait.
*/

int wait_for(pid, timeout)
pid_t	pid;
int	timeout;
{
	int	child, save_errno;
	pid_t	ret_val;

	got_sigalrm = 0;

	SIGNAL_RET(SIGALRM, lsah2);

	alarm(timeout);

	errno=0;
	ret_val = waitpid(pid, &child, 0);
	save_errno = errno;

	unused_time = alarm(0);

	SIGNAL_RET(SIGALRM, SIG_DFL);

	if (got_sigalrm) {
		(void) kill(pid, SIGKILL);

		sleep(2);

		(void) waitpid(pid, &child, WNOHANG);
		sprintf(ebuf, "ERROR: wait_for: Timed-out waiting for child to exit.");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
		return (child);
	}

	if (ret_val == (pid_t) -1) {
		sprintf(ebuf, "ERROR: wait_for: wait returned -1, errno=%d", save_errno);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	return (child);
}
