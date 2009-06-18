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
* $Header: /cvs/xtest/xtest/xts5/src/libXtTest/check.c,v 1.3 2007-10-15 20:44:37 anholt Exp $
*
* Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
* Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
* All Rights Reserved.
*
* Project: VSW5
*
* File: xts5/src/lib/libXtTest/check.c
*
* Description:
*	procedures check_str(), check_dec(), check_size()
*
* Modifications:
* $Log: check.c,v $
* Revision 1.3  2007-10-15 20:44:37  anholt
* Bug #8081: Fix bad prototypes that broke xtest on I32LP64.
*
* While here, fix some printf formatting.
*
* Submitted by:	Gordon Jin <gordon.jin@intel.com>
*
* Revision 1.2  2005-11-03 08:42:02  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:10  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:25:38  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:43:51  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.1  1998/08/05 22:12:15  andy
* Check check_dec arguments from int to long.
*
* Revision 6.0  1998/03/02 05:17:57  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:14:29  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:45:16  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:43:09  andy
* Prepare for GA Release
*
*/

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <XtTest.h>

char ebuf[4096];

int check_dec(goesin, shouldbe, item_name)
long goesin;
long shouldbe;
char *item_name;
{
	if (goesin != shouldbe) {
		sprintf(ebuf, "ERROR: Expected %s of %ld, Received %ld", item_name, goesin, shouldbe);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
		return 1;
	}
	return 0;
}

int check_not_dec(goesin, shouldnotbe, item_name)
long goesin;
long shouldnotbe;
char *item_name;
{
	if (goesin == shouldnotbe) {
		sprintf(ebuf, "ERROR: Expected %s not = %ld, received %ld", item_name, goesin, shouldnotbe);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
		return 1;
	}
	return 0;
}

/* ARGUSED */
int check_str(str1, str2, item_name)
char *str1 ;
char *str2 ;
char *item_name;
{
	char buf1[100] ;
	char buf2[100] ; 

	strncpy(buf1, str1, 100);
	strncpy(buf2, str2, 100);
	if (strcmp(buf1,buf2) != 0 ) {
		sprintf(ebuf, "ERROR: Expected %s of \"%s\", received \"%s\"", item_name, buf1, buf2);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
		return 1;
	}
	return 0;
}

int check_char(char1, char2, item_name)
char char1 ;
char char2 ;
char *item_name;
{
	if (char1 != char2) {
		sprintf(ebuf, "ERROR: Expected %s of '%c', received '%c'", item_name, char1, char2);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
		return 1;
	}
	return 0;
}

int check_size(data_object, ref_object, data_size, ref_size)
char	*data_object;
char	*ref_object;
size_t	data_size;
size_t	ref_size;
{
	sprintf(ebuf, "TEST %s", data_object);
	tet_infoline(ebuf);

	if (data_size != ref_size) {
		sprintf(ebuf, "ERROR: Size of %s is %d, expected %d (size of %s)", data_object, data_size, ref_size, ref_object);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
		return 1;
	}
	return 0;
}
