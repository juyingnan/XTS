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
* $Header: /cvs/xtest/xtest/xts5/src/libXtTest/misc.c,v 1.2 2005-11-03 08:42:02 jmichael Exp $
*
* Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
* All Rights Reserved.
*
* Project: VSW5
*
* File: xts5/src/lib/libXtTest/misc.c
*
* Description:
*	Assorted VSW routines
*
* Modifications:
* $Log: misc.c,v $
* Revision 1.2  2005-11-03 08:42:02  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:10  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:25:40  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:43:53  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:17:59  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:14:30  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:45:21  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:43:15  andy
* Prepare for GA Release
*
*/

#include <XtTest.h>

#include <fcntl.h>
#include <ctype.h>

/*error messages formatted here*/
extern char ebuf[4096];

char	debug_buf[512];
int	fchecked_debug = 0;
int	do_debug_enter = 0;
int	do_debug_exit = 0;
int	do_debug_level = 0;

void fwerrno(funcname)
char *funcname;
{
	sprintf(ebuf, "ERROR: %s failed, errno = %s", funcname, err_lookup(errno));
	tet_infoline(ebuf);
	tet_result(TET_FAIL);
}

void uwerrno(funcname)
char *funcname;
{
	sprintf(ebuf, "ERROR: %s failed, errno = %s", funcname, err_lookup(errno));
	tet_infoline(ebuf);
	tet_result(TET_UNRESOLVED);
}

void ferrno(funcname)
char *funcname;
{
	sprintf(ebuf, "ERROR: %s set errno to %s", funcname, err_lookup(errno));
	tet_infoline(ebuf);
	tet_result(TET_FAIL);
}

/*read config file variables and set in memory versions to*/
/*minimize performance hit of checking for on each call*/
static void check_debug()
{
	char * str;

	if (fchecked_debug)
		return;

	do_debug_enter = 0;
	if ((str = tet_getvar("XT_DEBUG_ENTER")) != 0)
		if (atoi(str) >= 1)
			do_debug_enter = 1;
	if ((str = tet_getvar("XT_DEBUG_EXIT")) != 0)
		if (atoi(str) >= 1)
			do_debug_exit = 1;
	if ((str = tet_getvar("XT_DEBUG")) != 0)
			do_debug_level = atoi(str);
}

void vsw_debug_enter(s, s2)
char *s;
char *s2;
{
	if (!fchecked_debug)
		check_debug();
	if (do_debug_enter) {
		sprintf((char *)&debug_buf[0], "DEBUG: Entering %s", s);
		tet_infoline(debug_buf);
		if (s2 != 0) {
			sprintf((char *)&debug_buf[0],"       %s", s2);
			tet_infoline(debug_buf);
		}
	}
}

void vsw_debug_exit(s, s2)
char *s;
char *s2;
{
	if (!fchecked_debug)
		check_debug();
	if (do_debug_exit) {
		sprintf((char *)&debug_buf[0], "DEBUG: Exiting %s", s);
		tet_infoline(debug_buf);
		if (s2 != 0) {
			sprintf((char *)&debug_buf[0],"       %s", s2);
			tet_infoline(debug_buf);
		}
	}
}

void vsw_debug(dlevel, s, s2)
int dlevel;
char *s;
char *s2;
{
	if (!fchecked_debug)
		check_debug();
	if (do_debug_level >= dlevel) {
		sprintf((char *)&debug_buf[0], "DEBUG: %s", s);
		tet_infoline(debug_buf);
		if (s2 != 0) {
			sprintf((char *)&debug_buf[0],"       %s", s2);
			tet_infoline(debug_buf);
		}
	}
}
