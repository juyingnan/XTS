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
>># File: xts5/tset/Xlib16/XrmGetStringDatabase/XrmGetStringDatabase.m
>># 
>># Description:
>># 	Tests for XrmGetStringDatabase()
>># 
>># Modifications:
>># $Log: rmgtstrdtb.m,v $
>># Revision 1.2  2005-11-03 08:42:56  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:21  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:34:13  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:56:27  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:25:34  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:22:06  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.1  1996/08/15 23:02:24  srini
>># Enhancements and clean-up
>>#
>># Revision 4.0  1995/12/15  09:09:58  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:12:12  andy
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
>>TITLE XrmGetStringDatabase Xlib16
XrmDatabase

char *data;
>>SET startup rmstartup
>>INCLUDE ../XrmPutResource/fn.mc
>>EXTERN

#define XGSD_T1_COUNT 23

static char *t1_lines[XGSD_T1_COUNT][5] = {
/* Capital 'T' is transformed to TAB in the prefix and conjunct. */
/* prefix, resource, conjunt, value, specifier, newvalue */
{"",	"a.a",	":",	"one",	"a.a"	}, /* Normal Line */

{" ",	"a.b",	":",	"two",	"a.b"	}, /* pre-resource space */
{"T",	"a.c",	":",	"three","a.c"	}, /* pre-resource tab*/
{" T ",	"a.d",	":",	"four",	"a.d"	}, /* pre-resource ws */

{"",	"a.e",	" :",	"five",	"a.e"	}, /* post-resource space */
{"",	"a.f",	"T:",	"six",	"a.f"	}, /* post-resource tab */
{"",	"a.g",	" T :",	"seven","a.g"	}, /* post-resource ws */

{"",	"a.h",	": ",	"eight","a.h"	}, /* pre-value space */
{"",	"a.i",	":T",	"nine",	"a.i"	}, /* pre-value tab */
{"",	"a.j",	": T ",	"ten",	"a.j"	}, /* pre-value ws */

{"  ",	"a.k",	"   :  ","eleven","a.k"	}, /* multiple space */
{"TT",	"a.l",	"TT:TTTT","twelve","a.l"}, /* multiple tab */
{"T  T","a.m",	" T:T   ","thirteen","a.m"}, /* multiple ws */

{"",	".a.n",	":",	"fourteen","a.n"}, /* pre-resource binding . */
{"",	"*a.o",	":",	"fifteen", "b.a.o"}, /* pre-resource binding * */

{"",	"a*p",	":",	"sixteen", "a.z.p"}, /* inclusive binding * */
{"",	".a*q",	":",	"seventeen","a.z.q"}, /* inclusive binding * */

{"",	"*a*r",	":",	"eighteen","b.a.c.r"}, /* inclusive binding * */

{"",	"b",	":",	"nineteen","b"	}, /* lone component */
{"",	".c",	":",	"twenty", "c"	}, /* lone component */
{"",	"*z",	":",	"twenty one","b.z"	}, /* lone component */

{"",	"d",	":",	"Aa9! @#$%^&*()_+~", "d"}, /* complex value */

{"T ",	"a-z.r_9A-*a-8B","T: ","A* bZ_% !?", "a-z.r_9A-.z.a-8B"} };/* complex entry */

>>ASSERTION Good A
When 
.A data
is a sequence of 
newline separated lines in
ResourceLine format,
then a call to xname 
creates a new database, 
stores a resource name and value pair from each line of
.A data
in the database,
and returns the database.
>>STRATEGY
Create test string.
Call xname to get database from string.
Verify the database was non-NULL, and contained the test information.
Free test database memory.
>>CODE
char *ts, *tp;
int a,b,l;
XrmDatabase rdb;

/* Create test string. */
	l=0;
	for(a=0; a<XGSD_T1_COUNT; a++) {
		for(b=0; b<4 ; b++) {
			l+=strlen(t1_lines[a][b]); /* Allow for string */
		}
		l++;	/* Allow for newlines */
	}
	l++;	/* Allow for terminating null. */

	ts = (char *) malloc( (size_t)l );
	if (ts==(char *)NULL) {
		delete("malloc(%d) for the database string failed.", l);
		return;
	} else
		CHECK;

	trace("Test database string is %d bytes", l);

	tp = ts;
	for(a=0; a<XGSD_T1_COUNT; a++) {
		for(b=0; b<4; b++) {
			tp += xrm_tabulate(t1_lines[a][b], tp);
			CHECK;
		}
		*tp++ = '\n' ;
	}
	*tp='\0';

/* Call xname to get database from string. */
	data = ts;
	rdb = XCALL;

/* Verify the database was non-NULL, and contained the test information. */
	if (rdb == (XrmDatabase)NULL) {
		FAIL;
		report("%s returned a NULL database when expecting a database.",
			TestName);
	} else {
		for(a=0; a<XGSD_T1_COUNT; a++) {
			tp=ts;
			tp[ xrm_tabulate(t1_lines[a][3], tp) ] = '\0';
			if(xrm_check_entry(rdb, t1_lines[a][4], t1_lines[a][4],
				"String", ts)) {
				FAIL;
			} else
				CHECK;
		}
	}

	CHECKPASS(1 + 4*XGSD_T1_COUNT + XGSD_T1_COUNT);

/* Free test database memory. */
	free( (void *)ts );
>>ASSERTION Good A
On a call to xname the database is created in the current locale.
>>STRATEGY
Set the current locale
Create test string.
Call xname to get database from string.
Obtain the locale of the database with XrmLocaleOfDatabase
Compare the return value to the current locale.
Free test database memory.
>>CODE
char *plocale;
char *prmlocale;
char *ts, *tp;
int a,b,l;
XrmDatabase rdb;

	resetlocale();
	while(nextlocale(&plocale))
	{
		if (locale_set(plocale))
			CHECK;
		else
		{
			report("Couldn't set locale.");
			FAIL;
			continue;
		}

		/* Create test string. */
		l=0;
		for(a=0; a<XGSD_T1_COUNT; a++) {
			for(b=0; b<4 ; b++) {
				l+=strlen(t1_lines[a][b]); /* Allow for string */
			}
			l++;	/* Allow for newlines */
		}
		l++;	/* Allow for terminating null. */

		ts = (char *) malloc( (size_t)l );
		if (ts==(char *)NULL) {
			delete("malloc(%d) for the database string failed.", l);
			return;
		} else
			CHECK;

		trace("Test database string is %d bytes", l);

		tp = ts;
		for(a=0; a<XGSD_T1_COUNT; a++) {
			for(b=0; b<4; b++) {
				tp += xrm_tabulate(t1_lines[a][b], tp);
				CHECK;
			}
			*tp++ = '\n' ;
		}
		*tp='\0';

		/* Call xname to get database from string. */
		data = ts;
		rdb = XCALL;

		/* Verify the database was non-NULL, and contained the test information. */
		if (rdb == (XrmDatabase)NULL) {
			delete("Could not create target database.");
			FAIL;
			continue;
		}

		/* get the locale of the database */
		prmlocale = XrmLocaleOfDatabase(rdb);
		if (strcmp(prmlocale, plocale) != 0)
		{
			report("Locale for resource database, %s, differs from current locale, %s",
				prmlocale,plocale);
			FAIL;
		}
		else
			CHECK;

		XrmDestroyDatabase(rdb);

	}	/* nextlocale */
	tet_result(TET_PASS);
