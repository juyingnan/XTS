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
>># File: xts5/Xlib16/XrmQGetSearchList.m
>># 
>># Description:
>># 	Tests for XrmQGetSearchList()
>># 
>># Modifications:
>># $Log: rmqgtsrchl.m,v $
>># Revision 1.2  2005-11-03 08:42:58  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:22  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:34:19  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:56:38  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:25:39  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:22:11  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:10:14  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:12:34  andy
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
>>TITLE XrmQGetSearchList Xlib16
Bool

XrmDatabase database = (XrmDatabase)NULL;
XrmNameList names = nl;
XrmClassList classes = cl;
XrmHashTable *list_return = sl; 	/* This is a XrmSearchList */
int list_length = XQGSL_LENGTH;
>>SET startup rmstartup
>>EXTERN

#define XQGSL_LENGTH 3
static	XrmHashTable	sl[XQGSL_LENGTH];

#define XQGSL_N_QUARK 10

static	XrmName	nl[XQGSL_N_QUARK];
static	XrmClass	cl[XQGSL_N_QUARK];

#define XQGSL_T3_ENTRIES 2
static char *t3_data[XQGSL_T3_ENTRIES] = {
	"a:one",
	"b:two" };

#define XQGSL_T4_ENTRIES 10
static char *t4_data[XQGSL_T4_ENTRIES] = {
	"a*z:one",
	"a.b*z:two",
	"a.b.c*z:three",
	"a.b.c.d*z:four",
	"a.b.c.d.e*z:five",
	"A*Z:six",
	"A.B*Z:seven",
	"A.B.C*Z:eight",
	"A.B.C.D*Z:nine",
	"A.B.C.D.E*Z:ten" };

>>ASSERTION Good B 2
A call to xname returns a list of database levels in
.A list_return
where a match for the specified
.A names
and
.A classes 
in the
.A database
could occur.
>>#
>># The problem here is that the XrmSearchList is a pointer to a
>># Xlib defined structure (it is defined in Xrm.c). Therefore, we
>># cannot perform any processing on the pointer in a portable
>># manner.
>># 
>># The essence of this assertion is tested in XrmQGetSearchResource,
>># which must call XrmQGetSearchList to build it's XrmSearchList
>># argument.
>>#
>>ASSERTION Good B 2
On a call to xname, the list returned in
.A list_return
is in best-to-worst match order.
>>#
>># The problem here is that the XrmSearchList is a pointer to a
>># Xlib defined structure (it is defined in Xrm.c). Therefore, we
>># cannot perform any processing on the pointer in a portable
>># manner.
>># 
>>ASSERTION Good A
When
.A list_length
is greater than or equal to the number of database levels 
where a match could occur,
then a call to xname returns
.S True .
>>STRATEGY
Create a test database with insufficient database levels to fill the list.
Call xname to obtain search list.
Verify that True was returned.
>>CODE
int a;
Bool ret;

/* Create a test database with insufficient database levels to fill the list. */
	for(a=0; a<XQGSL_T3_ENTRIES; a++) {
		XrmPutLineResource(&database, t3_data[a]);
	}

/* Call xname to obtain search list. */
	for(a=0; a<XQGSL_N_QUARK; a++) {
		nl[a]=(XrmName)0;
		cl[a]=(XrmClass)0;
	}
	XrmStringToNameList( "a", nl );
	XrmStringToClassList("A", cl );
	ret = XCALL;

/* Verify that True was returned. */
	if (ret != True) {
		FAIL;
		report("%s did not return True when the list_length was",
			TestName);
		report("greater than or equal to the number of");
		report("possible match database levels.");
		report("Returned value: %s", boolname(ret));
	} else
		CHECK;

	CHECKPASS(1);

	XrmDestroyDatabase(database);

>>ASSERTION Good A
When
.A list_length
is less than the number of database levels 
where a match could occur,
then a call to xname returns
.S False .
>>STRATEGY
Create a test database with sufficient database levels to fill the list.
Call xname to obtain search list.
Verify that False was returned.
>>CODE
int a;
Bool ret;

/* Create a test database with sufficient database levels to fill the list. */
	for(a=0; a<XQGSL_T4_ENTRIES; a++) {
		XrmPutLineResource(&database, t4_data[a]);
	}

/* Call xname to obtain search list. */
	for(a=0; a<XQGSL_N_QUARK; a++) {
		nl[a]=(XrmName)0;
		cl[a]=(XrmClass)0;
	}
	XrmStringToNameList( "a.b.c.d.e.f.g.h.z", nl );
	XrmStringToClassList( "A.B.C.D.E.F.G.H.Z", cl );
	ret = XCALL;

/* Verify that False was returned. */
	if (ret != False) {
		FAIL;
		report("%s did not return False when the list_length was",
			TestName);
		report("less than the number of possible match database levels.");
		report("Returned value: %s", boolname(ret));
	} else
		CHECK;

	CHECKPASS(1);

	XrmDestroyDatabase(database);
