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
>># File: xts5/Xlib16/XrmMergeDatabases.m
>># 
>># Description:
>># 	Tests for XrmMergeDatabases()
>># 
>># Modifications:
>># $Log: rmmrgdtbss.m,v $
>># Revision 1.2  2005-11-03 08:42:57  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:21  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:34:14  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:56:29  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:25:35  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:22:07  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.1  1996/08/20 20:12:18  srini
>># Added tests #4-6
>>#
>># Revision 4.0  1995/12/15  09:10:01  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:12:16  andy
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
>>TITLE XrmMergeDatabases Xlib16
void

XrmDatabase source_db;
XrmDatabase *target_db = &target;
>>SET startup rmstartup
>>INCLUDE rescommon.mc
>>EXTERN
static XrmDatabase target;

#define XMD_SPEC 0
#define XMD_TYPE 1
#define XMD_VALUE 2
#define XMD_FSPEC 3
#define XMD_FCLASS 4
#define XMD_XTYPE 5
#define XMD_XVALUE 6

/* Test database data */
#define XMD_SIZE 3
static char	*d1_data[XMD_SIZE][5] = {
	/* spec, type, value, fullspec, fullclass */
	{ "one.data", "String", "one", "one.data", "One.Data" },
	{ "one.Misc", "Nylon",  "two", "one.misc", "One.Misc" },
	{ "one*type", "Cotton", "three", "one.type", "One.Type" } };

static char	*d2_data[XMD_SIZE][5] = {
	/* spec, type, value, fullspec, fullclass */
	{ "two.data", "Thread", "four", "two.data", "Two.Data" },
	{ "Two.star", "Lycra",  "five", "two.star", "Two.Star" },
	{ "two*Halt", "Silk",   "six", "two.halt", "Two.Halt" } };

static char *d3_data[XMD_SIZE][7] = {
	/* spec, type, value, fullspec, fullclass, exptype, expvalue */
/* These should replace test data in the target */
	{ "one.data", "Thread", "seven", "one.data", "One.Data", "Thread", "seven" },
	{ "one.Misc", "Lycra",  "eight", "one.misc", "One.Misc", "Lycra",  "eight" },
/* These is new data from the source. */
	{ "two.odd",	"Silk", 	"nine",	"two.odd",	"Two.Odd",	"Silk", "nine" } };

/* This defines from which point in d1_data entries the data is expected to
	remain in the target after the merge in test 3. */
#define XMD_UNREPLACED 2

>>ASSERTION Good A
A call to xname
merges the contents of
.A source_db
into
.A target_db .
>>STRATEGY
Create two test databases.
Add test data to the test databases.
Call xname to merge the databases.
Verify that the target database contains all the test data.
>>CODE
int a;
XrmValue val;

/* Create two test databases. */
	source_db = xrm_create_database("");
	if(source_db == (XrmDatabase)NULL) {
		delete("Could not create source database.");
		return;
	} else
		CHECK;

	target = xrm_create_database("");
	if(target == (XrmDatabase)NULL) {
		delete("Could not create target database.");
		return;
	} else
		CHECK;

/* Add test data to the test databases. */
	for(a=0; a<XMD_SIZE; a++) {
		CHECK;
		xrm_fill_value( &val, d1_data[a][XMD_VALUE] );
		XrmPutResource(&source_db,
			d1_data[a][XMD_SPEC],
			d1_data[a][XMD_TYPE],
			&val);
		
		xrm_fill_value( &val, d2_data[a][XMD_VALUE] );
		XrmPutResource(target_db,
			d2_data[a][XMD_SPEC],
			d2_data[a][XMD_TYPE],
			&val);
	}

/* Call xname to merge the databases. */
	XCALL;

/* Verify that the target database contains all the test data. */
	for(a=0; a<XMD_SIZE; a++) {

		if (xrm_check_entry(target,
			d1_data[a][XMD_FSPEC],
			d1_data[a][XMD_FCLASS],
			d1_data[a][XMD_TYPE],
			d1_data[a][XMD_VALUE])) {
			FAIL;
			report("%s did not merge in the source database correctly",
				TestName);
		} else
			CHECK;

		if (xrm_check_entry(target,
			d2_data[a][XMD_FSPEC],
			d2_data[a][XMD_FCLASS],
			d2_data[a][XMD_TYPE],
			d2_data[a][XMD_VALUE])) {
			FAIL;
			report("%s did not preserve the target database correctly",
				TestName);
		} else
			CHECK;
	}

	CHECKPASS(2 + XMD_SIZE + XMD_SIZE*2);

	XrmDestroyDatabase(target);
	
>>ASSERTION Good B 1
On a call to xname, the source database
.A source_db
is destroyed.
>>#
>># There is no portable way to verify that a resource database has been
>># destroyed.
>>#
>>ASSERTION Good A
When a resource is a member of both
.A target_db
and
.A source_db ,
then the value and type of the resource in
.A target_db
is overwritten with the corresponding value and type from the resource in
.A source_db .
>>STRATEGY
Create two test databases.
Add test data to the test databases.
Call xname to merge the databases.
Verify that the overlapping source database entries replaced the
	corresponding target database entries, and that unique source
	database entries were merged correctly.
Verify that unique target database entries remained following the merge.
>>CODE
int a;
XrmValue val;

/* Create two test databases. */
	source_db = xrm_create_database("");
	if(source_db == (XrmDatabase)NULL) {
		delete("Could not create source database.");
		return;
	} else
		CHECK;

	target = xrm_create_database("");
	if(target == (XrmDatabase)NULL) {
		delete("Could not create target database.");
		return;
	} else
		CHECK;

/* Add test data to the test databases. */
	for(a=0; a<XMD_SIZE; a++) {
		CHECK;
		
		xrm_fill_value( &val, d3_data[a][XMD_VALUE] );
		XrmPutResource(&source_db,
			d3_data[a][XMD_SPEC],
			d3_data[a][XMD_TYPE],
			&val);

		xrm_fill_value( &val, d1_data[a][XMD_VALUE] );
		XrmPutResource(target_db,
			d1_data[a][XMD_SPEC],
			d1_data[a][XMD_TYPE],
			&val);
	}

/* Call xname to merge the databases. */
	XCALL;

/* Verify that the overlapping source database entries replaced the */
/* 	corresponding target database entries, and that unique source */
/* 	database entries were merged correctly. */
	for(a=0; a<XMD_SIZE; a++) {
		if (xrm_check_entry(target,
			d3_data[a][XMD_FSPEC],
			d3_data[a][XMD_FCLASS],
			d3_data[a][XMD_XTYPE],
			d3_data[a][XMD_XVALUE])) {
			FAIL;
			report("%s did not merge the databases correctly",
				TestName);
		} else
			CHECK;
	}

/* Verify that unique target database entries remained following the merge. */
	for(a=XMD_UNREPLACED; a<XMD_SIZE; a++) {
		if (xrm_check_entry(target,
			d1_data[a][XMD_FSPEC],
			d1_data[a][XMD_FCLASS],
			d1_data[a][XMD_TYPE],
			d1_data[a][XMD_VALUE])) {
			FAIL;
			report("%s did not preserve the target database correctly",
				TestName);
		} else
			CHECK;
	}

	CHECKPASS(2 + XMD_SIZE + XMD_SIZE*2 - XMD_UNREPLACED) ;

	XrmDestroyDatabase(target);

>>ASSERTION Good A
A call to xname
when 
.A target_db 
is NULL shall store the contents of 
.A source_db
into it.
>>STRATEGY
Create a test database.
Add test data to the test database.
Call xname with target_db set to NULL.
Verify that the target database contains the source_db contents.
>>CODE
int a;
XrmValue val;

	/* Create a test database. */
	source_db = xrm_create_database("");
	if(source_db == (XrmDatabase)NULL) {
		delete("Could not create source database.");
		return;
	}

	target = (XrmDatabase)NULL;

	/* Add test data to the test database. */
	for(a=0; a<XMD_SIZE; a++)
	{
		CHECK;
		xrm_fill_value( &val, d1_data[a][XMD_VALUE] );
		XrmPutResource(&source_db,
			d1_data[a][XMD_SPEC],
			d1_data[a][XMD_TYPE],
			&val);
		
		xrm_fill_value( &val, d2_data[a][XMD_VALUE] );
		XrmPutResource(&source_db,
			d2_data[a][XMD_SPEC],
			d2_data[a][XMD_TYPE],
			&val);
	}

	/* Call xname to merge the databases. */
	XCALL;

	/* Verify that the target database contains all the test data. */
	for(a=0; a<XMD_SIZE; a++) 
	{
		if (xrm_check_entry(target,
			d1_data[a][XMD_FSPEC],
			d1_data[a][XMD_FCLASS],
			d1_data[a][XMD_TYPE],
			d1_data[a][XMD_VALUE])) {
			FAIL;
			report("%s did not merge in the source database correctly",
				TestName);
		}

		if (xrm_check_entry(target,
			d2_data[a][XMD_FSPEC],
			d2_data[a][XMD_FCLASS],
			d2_data[a][XMD_TYPE],
			d2_data[a][XMD_VALUE])) {
			FAIL;
			report("%s did not preserve the target database correctly",
				TestName);
		}
	}
	XrmDestroyDatabase(target);
	tet_result(TET_PASS);
>>ASSERTION Good B 1
A call to xname
shall merge database entries without changing values of types,
regardless of the locales of the databases.
>>ASSERTION Good B 1
A call to xname
shall not modify the locale of the target database.
