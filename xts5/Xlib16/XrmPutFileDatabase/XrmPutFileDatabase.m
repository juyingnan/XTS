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
>># File: xts5/Xlib16/XrmPutFileDatabase/XrmPutFileDatabase.m
>># 
>># Description:
>># 	Tests for XrmPutFileDatabase()
>># 
>># Modifications:
>># $Log: rmptfldtbs.m,v $
>># Revision 1.2  2005-11-03 08:42:57  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:21  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:34:16  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:56:31  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:25:36  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:22:08  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.2  1996/08/06 23:53:09  srini
>># More tests added
>>#
>># Revision 4.1  1996/08/06  23:38:01  srini
>># Enhancements and clean-up
>>#
>># Revision 4.0  1995/12/15  09:10:04  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:12:21  andy
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
>>TITLE XrmPutFileDatabase Xlib16
void

XrmDatabase database = (XrmDatabase)NULL;
char *stored_db = "xpfd_file";
>>SET startup rmstartup
>>INCLUDE ../XrmPutResource/fn.mc
>>EXTERN

#define XPFD_T1_COUNT	4
static char *t1_data[XPFD_T1_COUNT][3] = {
	{ "a.b.c",	"ONE",	"a.b.c" },
	{ "D.E.F",	"TWO",	"D.E.F"},
	{ "*Z",	"THREE",	"A.Z"	},
	{ ".e.f.g.h.i.j",	"*!++ X&",	"e.f.g.h.i.j"	} };

>>ASSERTION Good A
A call to xname stores the resource name and value pairs 
in the specified file
.A stored_db 
from the specified
.A database
in ResourceLine format.
>>STRATEGY
Create a new database containing the test information.
Call xname to write the database.
Call XrmGetFileDatabase to check the database was written out.
Check the retrieved database contents were as expected.
Remove created file.
>>CODE
int a;
XrmDatabase rdb;

/* Create a new database containing the test information. */
	for(a=0; a<XPFD_T1_COUNT; a++) {
		XrmPutStringResource(&database, t1_data[a][0], t1_data[a][1]);
		CHECK;
	}

/* Call xname to write the database. */
	unlink( stored_db );
	XCALL;

/* Call XrmGetFileDatabase to check the database was written out. */
	rdb = XrmGetFileDatabase( stored_db );
	if (rdb == (XrmDatabase)NULL) {
		FAIL;
		delete("XrmGetFileDatabase could not open the written database.");
		return;
	} else {
/* Check the retrieved database contents were as expected. */
		for(a=0; a<XPFD_T1_COUNT; a++) {
			if (xrm_check_entry(rdb, t1_data[a][2], t1_data[a][2],
				"String", t1_data[a][1])) {
				delete("Unexpected data item returned from read in database");
				report("%s may have failed.", TestName);
			} else
				CHECK;
		}
	}

	CHECKPASS(XPFD_T1_COUNT + XPFD_T1_COUNT);

/* Remove created file. */
#ifndef TESTING
	unlink( stored_db ); 	/* To examine test file, */
				/* use pmake CFLOCAL=-DTESTING */
#endif
>>ASSERTION Good A
On a call to xname entries with representation types other than
String shall be ignored.
>>STRATEGY
Create a new database containing the test information.
Call xname to write the database with a representation other than String.
Call XrmGetFileDatabase to check the database was written out.
Check that the entry was not added.
Remove created file.
>>CODE
int a;
XrmDatabase rdb;
static XrmValue xpr_value;
char    	*type_ret;
XrmValue        value_ret;

	/* Create a new database containing the test information. */
	for(a=0; a<XPFD_T1_COUNT; a++) {
		XrmPutStringResource(&database, t1_data[a][0], t1_data[a][1]);
	}

	/* Add a non-string resource to the database */
	xrm_fill_value(&xpr_value, "Value One");
	XrmPutResource(&database, "calvin*and.hobbes", "Thing", &xpr_value);
	/* Call xname to write the database. */
	unlink( stored_db );
	XCALL;

	/* Call XrmGetFileDatabase to check the database was written out. */
	rdb = XrmGetFileDatabase( stored_db );
	if (rdb == (XrmDatabase)NULL) {
		FAIL;
		delete("XrmGetFileDatabase could not open the written database.");
		return;
	} 
	else
	{
		/* Check the retrieved database contents were as expected. */
/*
		if (xrm_check_entry(rdb, "calvin.and.hobbes","Boy.Thingy0.Tiger",
				"Thing", "Value One")) 
		{
			delete("Unexpected data item returned from read in database");
			report("%s may have failed.", TestName);
		}
*/
	
		if (XrmGetResource(rdb,  "calvin.and.hobbes", "Boy.Thingy0.Tiger", &type_ret, &value_ret) != False) 
		{
                	report("Non-string entry was added to the database file");
			tet_result(TET_FAIL);
			return;
        	}
	}

/* Remove created file. */
#ifndef TESTING
	unlink( stored_db ); 	/* To examine test file, */
				/* use pmake CFLOCAL=-DTESTING */
#endif
	tet_result(TET_PASS);

>>ASSERTION Good B 1
The order in which entries from 
.A database
are written to the stored database file 
.A stored_db 
on a call to xname.
