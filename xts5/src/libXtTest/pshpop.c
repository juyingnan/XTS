/*
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
*/
/*
* $Header: /cvs/xtest/xtest/xts5/src/libXtTest/pshpop.c,v 1.1 2005-02-12 14:37:15 anderson Exp $
*
* Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
* Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
* All Rights Reserved.
*
* Project: VSW5
*
* File: vsw5/src/lib/libXtTest/pshpop.c
*
* Description:
*	This file contains code to manipulate stdin and stderr
*
* Modifications:
* $Log: pshpop.c,v $
* Revision 1.1  2005-02-12 14:37:15  anderson
* Initial revision
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

#include <XtTest.h>

/*error messages formatted here*/
char ebuf[4096];

static	int	Dup_stdout = -1;	/* Duplicate of stdout fd */
static	int	Dup_stderr = -1;	/* Duplicate of stderr fd */

/*
** push_stdout
**	This redirects stdout to a file, but saves a copy
**	of the file descriptor attached to stdout so we can
**	restore it later.
**
** Arguments
**	file	Filename to open stdout to
**	mode	What mode to open the file to
*/

int push_stdout(file,mode)
char	*file;
char	*mode;
{
	char	pathname[4096];

	if ((Dup_stdout = dup(fileno(stdout))) == -1){
		sprintf(ebuf, "ERROR: push_stdout: dup of fileno(stdout) failed");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
		return -1;
	}

	strcpy(pathname, "/tmp/");
	strcat(pathname,file);

	if (freopen(pathname,mode,stdout) == NULL) {
		fclose(stdout);
		fdopen(Dup_stdout,"w");
		sprintf(ebuf, "ERROR: push_stdout: could not freopen(stdout)");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
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
		tet_result(TET_FAIL);
		return;
	}

	fclose(stdout);
	if (dup2(Dup_stdout,1) != 1) {
		sprintf(ebuf, "ERROR: pop_stdout: dup of stdout back to 1 failed");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
		return;
	}

	if ((FILE *)fdopen(1,"w") != stdout) {
		sprintf(ebuf, "ERROR: pop_stdout: couldn't fdopen stdout");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
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
**	mode	What mode to open the file to
*/

int push_stderr(file,mode)
char	*file;
char	*mode;
{
	char	pathname[4096];

	if (Dup_stderr != -1)  {
		sprintf(ebuf, "ERROR: push_stderr: stderr has already been pushed\n");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
		return -1;
	}

	if ((Dup_stderr = dup(fileno(stderr))) == -1) {
		sprintf(ebuf, "ERROR: push_stderr: dup of fileno(stderr) failed");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
		return -1;
	}

	strcpy(pathname, "/tmp/");
	strcat(pathname,file);

	if (freopen(pathname,mode,stderr) == NULL) {
		fclose(stderr);
		fdopen(Dup_stderr,"w");
		sprintf(ebuf, "ERROR: push_stderr: could not freopen(stderr). pathname = %s", pathname);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
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
		tet_result(TET_FAIL);
		return;
	}

	fclose(stderr);

	if (dup2(Dup_stderr,2) != 2) {
		sprintf(ebuf, "ERROR: pop_stderr: dup of stderr back to 2 failed");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
		return;
	}

	if ((FILE *)fdopen (2,"w") != stderr) {
		sprintf(ebuf, "ERROR: pop_stderr: couldn't fdopen stderr");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
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
		tet_result(TET_FAIL);
		return;
	}

	if (freopen(file,mode,stdout) == NULL) {
		fclose(stdout);
		fdopen(Dup_stdout,"w");
		sprintf(ebuf, "ERROR: push_to_devnull: could not freopen(stdout)");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
		return;
	}

	if (Dup_stderr != -1) {
		sprintf(ebuf, "ERROR: push_to_devnull: stderr has already been pushed\n");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
		return;
	}

	if ((Dup_stderr = dup(fileno(stderr))) == -1) {
		sprintf(ebuf, "ERROR: dup of fileno(stderr) failed");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
		return;
	}

	if (freopen(file,mode,stderr) == NULL) {
		fclose(stderr);
		fdopen(Dup_stderr,"w");
		sprintf(ebuf, "ERROR: push_to_devnull: could not freopen(stderr)");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
		return;
	}
}

int restore_from_devnull()
{
	if (Dup_stdout == -1) {
			sprintf(ebuf, "ERROR: restore_from_devnull: push_to_devnull never called");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
		return -1;
	}

	fclose(stdout);

	if (dup2(Dup_stdout,1) != 1) {
		sprintf(ebuf, "ERROR: restore_from_devnull: dup of stdout back to 1 failed");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
		return -1;
	}

	if ((FILE *)fdopen(1,"w") != stdout) {
		sprintf(ebuf, "ERROR: restore_from_devnull: couldn't fdopen stdout");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
		return -1;
	}

	close(Dup_stdout);

	if (Dup_stderr == -1) {
		sprintf(ebuf, "ERROR: restore_from_devnull: push_to_devnull never called");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
		return -1;
	}

	fclose(stderr);

	if (dup2(Dup_stderr,2) != 2) {
		sprintf(ebuf, "ERROR: restore_from_devnull: dup of stderr back to 2 failed");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
		return -1;
	}

	if ((FILE *)fdopen (2,"w") != stderr) {
		sprintf(ebuf, "ERROR: restore_from_devnull: couldn't fdopen stderr");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
		return -1;
	}

	close(Dup_stderr);

	Dup_stderr = -1;
	return 0;
}
