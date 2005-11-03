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
* $Header: /cvs/xtest/xtest/xts5/src/libXtTest/xthandler.c,v 1.2 2005-11-03 08:42:02 jmichael Exp $
*
* Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
* Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
* All Rights Reserved.
*
* Project: VSW5
*
* File: xts5/src/lib/libXtTest/xthandler.c
*
* Description:
*	Function: xt_handler()
*	Function: wt_handler()
*
* Modifications:
* $Log: xthandler.c,v $
* Revision 1.2  2005-11-03 08:42:02  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:10  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:25:43  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:43:57  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:18:01  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:14:33  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:45:29  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:43:25  andy
* Prepare for GA Release
*
*/

#include <XtTest.h>
#define MIT_TET_WARNING 101
/*error messages formatted here*/
char ebuf[4096];


/*
 *	Invoked by Xt when an fatal error occurs
 *	set by test cases with XtAppSetErrorMsgHandler(app_ctext, xt_handler);
 *
 */

void xt_handler(name, type, class, defaultp, params, num_params)
String name;
String type;
String class;
String defaultp ;
String *params ;
Cardinal *num_params ;
{
String par[10];
int i;
char buffer[1000], buffer2[1000];

	tet_infoline("ERROR: ****************************************************************");
	tet_infoline("ERROR: An Xt error occured during a toolkit call:");
	XtGetErrorDatabaseText(name, type, class, defaultp, buffer, 1000);
	if (params == NULL || num_params == NULL || *num_params == 0) {
		sprintf(ebuf, "ERROR: %s", buffer);
		tet_infoline(ebuf);
	}
	else {
		i = *num_params;
		if (i > 10)
			i = 10;
		memcpy((char *)par, (char *)params, i*sizeof(String));
		memset(&par[i], 0, (10-i)*sizeof(String));
		strcpy(buffer2, "ERROR: ");
		strcat(buffer2, buffer);
		sprintf(ebuf, buffer2, par[0], par[1], par[2], par[3], par[4], par[5], par[6], par[7], par[8],par[9]);
		tet_infoline(ebuf);
	}
	tet_infoline("ERROR: ****************************************************************");
/*
	sprintf(ebuf, "ERROR: resource name = %s", name);
	tet_infoline(ebuf);
	sprintf(ebuf, "ERROR: resource type = %s", type);
	tet_infoline(ebuf);
	sprintf(ebuf, "ERROR: resource class = %s", class);
	tet_infoline(ebuf);
*/
	tet_result(TET_FAIL);
	/*ALL Xt calls MUST be in a child process!!*/
	exit(0);
}

/*
 *	Invoked by Xt when a warning occurs
 *	set by test cases with XtAppSetWarningMsgHandler(app_ctext, xt_handler);
 *
 */

void xt_whandler(name, type, class, defaultp, params, num_params)
String name;
String type;
String class;
String defaultp ;
String *params ;
Cardinal *num_params ;
{
String par[10];
int i;
char buffer[1000], buffer2[1000];

	tet_infoline("WARNING: ****************************************************************");
	tet_infoline("WARNING: An Xt warning occured during a toolkit call:");
	XtGetErrorDatabaseText(name, type, class, defaultp, buffer, 1000);
	if (params == NULL || num_params == NULL || *num_params == 0) {
		sprintf(ebuf, "WARNING: %s", buffer);
		tet_infoline(ebuf);
	}
	else {
		i = *num_params;
		if (i > 10)
			i = 10;
		memcpy((char *)par, (char *)params, i*sizeof(String));
		memset(&par[i], 0, (10-i)*sizeof(String));
		strcpy(buffer2, "WARNING: ");
		strcat(buffer2, buffer);
		sprintf(ebuf, buffer2, par[0], par[1], par[2], par[3], par[4], par[5], par[6], par[7], par[8],par[9]);
		tet_infoline(ebuf);
	}
	tet_infoline("WARNING: ****************************************************************");
/*
	sprintf(ebuf, "ERROR: resource name = %s", name);
	tet_infoline(ebuf);
	sprintf(ebuf, "ERROR: resource type = %s", type);
	tet_infoline(ebuf);
	sprintf(ebuf, "ERROR: resource class = %s", class);
	tet_infoline(ebuf);
*/
	tet_result(MIT_TET_WARNING);
}
