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
*
* Copyright (c) 2001 The Open Group
* Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
* Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
* All Rights Reserved.
*
* Project: VSW5
*
* File: xts5/src/lib/libXtTest/pshpop.c
*
* Description:
*	This file contains code to manipulate stdin and stderr
*
* Modifications:
* $Log: pshpop.c,v $
* Revision 1.3  2005-11-03 08:42:02  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.2  2005/04/21 09:40:42  ajosey
* resync to VSW5.1.5
*
* Revision 8.2  2005/01/20 15:59:56  gwc
* Updated copyright notice
*
* Revision 8.1  2001/02/05 17:36:09  vsx
* use a more portable method to redirect stdout and stderr
*
* Revision 8.0  1998/12/23 23:25:40  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:43:54  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:17:59  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:14:31  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:45:22  tbr
* Branch point for Release 5.0.0
*
* Revision 3.2  1995/12/15  00:43:16  andy
* Prepare for GA Release
*
*/

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <XtTest.h>
#include <fcntl.h>

/*error messages formatted here*/
char ebuf[4096];

static	int	Dup_stdout = -1;	/* Duplicate of stdout fd */
static	int	Dup_stderr = -1;	/* Duplicate of stderr fd */

/* Internal routine to reopen the fd for stdout or stderr */

static int
reopen(pathname, omode, fp)
char *pathname;
int omode;
FILE *fp;
{
	int newfd;

	newfd = open(pathname, omode|O_CREAT|O_TRUNC, S_IRWXU|S_IRWXG|S_IRWXO);
	if (newfd == -1)
		return -1;

	if (fflush(fp) != 0) {
		close(newfd);
		return -1;
	}

	if (dup2(newfd, fileno(fp)) == -1) {
		close(newfd);
		return -1;
	}

	close(newfd);
	return 0;
}

/*
** push_stdout
**	This redirects stdout to a file, but saves a copy
**	of the file descriptor attached to stdout so we can
**	restore it later.
**
** Arguments
**	file	Filename to open stdout to
**	mode	Unused
*/

int push_stdout(file,mode)
char	*file;
char	*mode;
{
	char	pathname[4096];

	if ((Dup_stdout = dup(fileno(stdout))) == -1){
		sprintf(ebuf, "ERROR: push_stdout: dup of fileno(stdout) failed");
		tet_infoline(ebuf);
		tet_result(TET_UNRESOLVED);
		return -1;
	}

	strcpy(pathname, "/tmp/");
	strcat(pathname,file);

	if (reopen(pathname,O_WRONLY,stdout) != 0) {
		dup2(Dup_stdout,fileno(stdout));
		sprintf(ebuf, "ERROR: push_stdout: could not reopen stdout");
		tet_infoline(ebuf);
		tet_result(TET_UNRESOLVED);
		return -1;
	}
	return 0;
}

/*
** pop_stdout
**	Reset stdout back to what it used to point to.
**
** Assumes
**	You want stdout opened for writing...
*/

void pop_stdout()
{
	if (Dup_stdout == -1) {
		sprintf(ebuf, "ERROR: pop_stdout: push_stdout never called");
		tet_infoline(ebuf);
		tet_result(TET_UNRESOLVED);
		return;
	}

	fflush(stdout);
	if (dup2(Dup_stdout,fileno(stdout)) == -1) {
		sprintf(ebuf, "ERROR: pop_stdout: could not restore stdout");
		tet_infoline(ebuf);
		tet_result(TET_UNRESOLVED);
		return;
	}

	close(Dup_stdout);
	Dup_stdout = -1;
}



/*
** push_stderr
**	This redirects stderr to a file, but saves a copy
**	of the file descriptor attached to stderr so we can
**	restore it later.
**
** Arguments
**	file	Filename to open stderr to
**	mode	Unused
*/

int push_stderr(file,mode)
char	*file;
char	*mode;
{
	char	pathname[4096];

	if (Dup_stderr != -1)  {
		sprintf(ebuf, "ERROR: push_stderr: stderr has already been pushed\n");
		tet_infoline(ebuf);
		tet_result(TET_UNRESOLVED);
		return -1;
	}

	if ((Dup_stderr = dup(fileno(stderr))) == -1) {
		sprintf(ebuf, "ERROR: push_stderr: dup of fileno(stderr) failed");
		tet_infoline(ebuf);
		tet_result(TET_UNRESOLVED);
		return -1;
	}

	strcpy(pathname, "/tmp/");
	strcat(pathname,file);

	if (reopen(pathname,O_WRONLY,stderr) != 0) {
		dup2(Dup_stderr,fileno(stderr));
		sprintf(ebuf, "ERROR: push_stderr: could not reopen stderr");
		tet_infoline(ebuf);
		tet_result(TET_UNRESOLVED);
		return -1;
	}
	return 0;
}

/*
** pop_stderr
**	Reset stderr back to what it used to point to.
**
** Assumes
**	You want stderr opened for writing...
*/

void pop_stderr()
{
	if (Dup_stderr == -1) {
		sprintf(ebuf, "ERROR: pop_stderr: push_stderr never called");
		tet_infoline(ebuf);
		tet_result(TET_UNRESOLVED);
		return;
	}

	fflush(stderr);
	if (dup2(Dup_stderr,fileno(stderr)) == -1) {
		sprintf(ebuf, "ERROR: pop_stderr: could not restore stderr");
		tet_infoline(ebuf);
		tet_result(TET_UNRESOLVED);
		return;
	}

	close(Dup_stderr);
	Dup_stderr = -1;
}

/***************************************************************************/
/* push_to_devnull() redirects the stdout and stderr to /dev/null          */
/* restore_from_devnull() restores the stdout and stderr                   */
/***************************************************************************/ 

void push_to_devnull(file,mode)
char    *file;
char    *mode;
{
	if ((Dup_stdout = dup(fileno(stdout))) == -1) {
		sprintf(ebuf, "ERROR: push_to_devnull: dup of fileno(stdout) failed");
		tet_infoline(ebuf);
		tet_result(TET_UNRESOLVED);
		return;
	}

	if (reopen(file,O_WRONLY,stdout) != 0) {
		dup2(Dup_stdout,fileno(stdout));
		sprintf(ebuf, "ERROR: push_to_devnull: could not reopen stdout");
		tet_infoline(ebuf);
		tet_result(TET_UNRESOLVED);
		return;
	}

	if (Dup_stderr != -1) {
		sprintf(ebuf, "ERROR: push_to_devnull: stderr has already been pushed\n");
		tet_infoline(ebuf);
		tet_result(TET_UNRESOLVED);
		return;
	}

	if ((Dup_stderr = dup(fileno(stderr))) == -1) {
		sprintf(ebuf, "ERROR: push_to_devnull: dup of fileno(stderr) failed");
		tet_infoline(ebuf);
		tet_result(TET_UNRESOLVED);
		return;
	}

	if (reopen(file,O_WRONLY,stderr) != 0) {
		dup2(Dup_stderr,fileno(stderr));
		sprintf(ebuf, "ERROR: push_to_devnull: could not reopen stderr");
		tet_infoline(ebuf);
		tet_result(TET_UNRESOLVED);
		return;
	}
}

int restore_from_devnull()
{
	if (Dup_stdout == -1) {
			sprintf(ebuf, "ERROR: restore_from_devnull: push_to_devnull never called");
		tet_infoline(ebuf);
		tet_result(TET_UNRESOLVED);
		return -1;
	}

	fflush(stdout);
	if (dup2(Dup_stdout,fileno(stdout)) == -1) {
		sprintf(ebuf, "ERROR: restore_from_devnull: could not restore stdout");
		tet_infoline(ebuf);
		tet_result(TET_UNRESOLVED);
		return -1;
	}

	close(Dup_stdout);
	Dup_stdout = -1;

	if (Dup_stderr == -1) {
		sprintf(ebuf, "ERROR: restore_from_devnull: push_to_devnull never called");
		tet_infoline(ebuf);
		tet_result(TET_UNRESOLVED);
		return -1;
	}

	fflush(stderr);
	if (dup2(Dup_stderr,fileno(stderr)) == -1) {
		sprintf(ebuf, "ERROR: restore_from_devnull: could not restore stderr");
		tet_infoline(ebuf);
		tet_result(TET_UNRESOLVED);
		return -1;
	}

	close(Dup_stderr);
	Dup_stderr = -1;

	return 0;
}
