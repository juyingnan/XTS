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
>># File: xts5/Xlib16/XrmStringToQuarkList.m
>># 
>># Description:
>># 	Tests for XrmStringToQuarkList()
>># 
>># Modifications:
>># $Log: rmstrtqrkl.m,v $
>># Revision 1.2  2005-11-03 08:43:00  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:23  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:34:23  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:56:42  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:25:42  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:22:15  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:10:24  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:12:48  andy
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
>>TITLE XrmStringToQuarkList Xlib16
void

char *string;
XrmQuarkList quarks_return = (XrmQuarkList)xstql_ret;
>>SET startup rmstartup
>>EXTERN
#define XSTQL_MAX_RETURN 10
static XrmQuark xstql_ret[XSTQL_MAX_RETURN];

static char *xstql_s1[]={
	"xstql_test",
	"ena",
	"deo",
	"tria"};

static char *xstql_s1sep[]={
	".",
	".",
	".",
	""};

static int xstql_ns1=NELEM(xstql_s1);

static char *xstql_s2[]={
	"XStql_test",
	"une",
	"deux",
	"trois",
	"erm",
	"five"};
static char *xstql_s2sep[]={
	"*",
	".",
	"*",
	"*",
	".",
	""};
static int xstql_ns2=NELEM(xstql_s2);

static char *xstql_s3[]={
	"XStqL_test.",
	"jack.",
	"and.",
	"jill"};
static int xstql_ns3=NELEM(xstql_s3);

static void
xstqlclear(value)
XrmQuark value;
{
	int i;

/* Clear the return array, to avoid rogue results. */
	for(i=0; i<XSTQL_MAX_RETURN; i++) 
		xstql_ret[i]=value;

}

>>ASSERTION Good A
When
.A string
is a valid null-terminated resource name format string, then a call to xname
returns a quark list in
.A quarks_return
corresponding to the components of
.A string .
>>STRATEGY
Create the test string.
Call xname to obtain quark list.
Verify that the quark list returned was as expected.
>>CODE
int  t;
char *buffer1;
char *buffer2;

	buffer1 = (char *)malloc( (size_t)256);
	if (buffer1==(char *)NULL) {
		delete("Could not malloc 256 bytes for buffer1.");
		return;
	} else
		CHECK;

	buffer2 = (char *)malloc( (size_t)4096);
	if (buffer2==(char *)NULL) {
		delete("Could not malloc 4096 bytes for buffer2.");
		return;
	} else
		CHECK;

	*buffer1='\0'; /* Make the buffers empty strings. */
	*buffer2='\0';

/* Create the test string. */
	for(t=0; t<xstql_ns1; t++) {
		strcat(buffer1, xstql_s1[t]);
		strcat(buffer1, xstql_s1sep[t]);
	}
	trace("Testing with '%s'", buffer1);

	xstqlclear((XrmQuark)0);

/* Call xname to obtain quark list. */
	string= buffer1;
	XCALL;

#ifdef TESTING
	xstql_ret[0]=0;
	xstql_ret[1]=XrmStringToQuark("TESTING");
#endif

/* Verify that the quark list returned was as expected. */
	for(t=0; t<xstql_ns1; t++) {
		char *ts;

		ts = XrmQuarkToString( xstql_ret[t] );
		if (ts == (char *)NULL) {
			FAIL;
			report("Quark array[%d]=%d. Represents: NO STRING (expecting '%s')",
				t, xstql_ret[t], xstql_s1[t]);
			strcat(buffer2,"<NO STRING>");
		} else
		{
			if(strcmp(xstql_s1[t], ts)) {
				FAIL;
				report("Quark array[%d]=%d. Represents: '%s' (expecting '%s')",
					t, xstql_ret[t], ts, xstql_s1[t]);
			} else {
				CHECK;
				trace("Quark array[%d]=%d. Represents: '%s' as expected.",
					t, xstql_ret[t], ts );
			}
			strcat(buffer2, ts);
		}
		strcat(buffer2, " ");
	}

	if (fail) {
		report("%s did not split the string into the quarks as expected",
			TestName);
		report("String passed to %s: '%s'", TestName, buffer1);
		report("Quark array represents: %s", buffer2);
	} else
		CHECK;

	CHECKPASS(2+xstql_ns1+1);
	free(buffer1);
	free(buffer2);

>>ASSERTION Good A
On a call to xname, the
.A string
is separated into components according to the
positions of periods and asterisks.
>>STRATEGY
Create the test string.
Call xname to obtain quark list.
Verify that the quark list returned was as expected.
>>CODE
int  t;
char *buffer1;
char *buffer2;

	buffer1 = (char *)malloc( (size_t)256);
	if (buffer1==(char *)NULL) {
		delete("Could not malloc 256 bytes for buffer1.");
		return;
	} else
		CHECK;

	buffer2 = (char *)malloc( (size_t)4096);
	if (buffer2==(char *)NULL) {
		delete("Could not malloc 4096 bytes for buffer2.");
		return;
	} else
		CHECK;

	*buffer1='\0'; /* Make the buffers empty strings. */
	*buffer2='\0';

/* Create the test string. */
	for(t=0; t<xstql_ns2; t++) {
		strcat(buffer1, xstql_s2[t]);
		strcat(buffer1, xstql_s2sep[t]);
	}
	trace("Testing with '%s'", buffer1);

	xstqlclear((XrmQuark)0);

/* Call xname to obtain quark list. */
	string= buffer1;
	XCALL;

#ifdef TESTING
	xstql_ret[0]=0;
	xstql_ret[1]=XrmStringToQuark("TESTING");
#endif

/* Verify that the quark list returned was as expected. */
	for(t=0; t<xstql_ns2; t++) {
		char *ts;

		ts = XrmQuarkToString( xstql_ret[t] );
		if (ts == (char *)NULL) {
			FAIL;
			report("Quark array[%d]=%d. Represents: NO STRING (expecting '%s')",
				t, xstql_ret[t], xstql_s2[t]);
			strcat(buffer2,"<NO STRING>");
		} else
		{
			if(strcmp(xstql_s2[t], ts)) {
				FAIL;
				report("Quark array[%d]=%d. Represents: '%s' (expecting '%s')",
					t, xstql_ret[t], ts, xstql_s2[t]);
			} else {
				CHECK;
				trace("Quark array[%d]=%d. Represents: '%s' as expected.",
					t, xstql_ret[t], ts );
			}
			strcat(buffer2, ts);
		}
		strcat(buffer2, " ");
	}

	if (fail) {
		report("%s did not split the string into the quarks as expected",
			TestName);
		report("String passed to %s: '%s'", TestName, buffer1);
		report("Quark array represents: '%s'", buffer2);
	} else
		CHECK;

	CHECKPASS(2+xstql_ns2+1);
	free(buffer1);
	free(buffer2);

>>ASSERTION Good A
On a call to xname, the
.A quarks_return
list is terminated with a zero.
>>STRATEGY
Create the test string.
Set return buffer with unique quark value.
Call xname to obtain quark list.
Verify that the quark list was zero terminated.
>>CODE
char *buffer1;
XrmQuark unq;
int t;

	buffer1 = (char *)malloc( (size_t)256);
	if (buffer1==(char *)NULL) {
		delete("Could not malloc 256 bytes for buffer1.");
		return;
	} else
		CHECK;

	*buffer1='\0';

/* Create the test string. */
	for(t=0; t<xstql_ns3; t++) {
		strcat(buffer1, xstql_s3[t]);
	}
	trace("Testing with '%s'", buffer1);

/* Set return buffer with unique quark value. */
	unq=XrmUniqueQuark();
	xstqlclear(unq);

/* Call xname to obtain quark list. */
	string= buffer1;
	XCALL;

/* Verify that the quark list was zero terminated. */
	t=0;
	while(t<XSTQL_MAX_RETURN
		&& xstql_ret[t] != unq
		&& xstql_ret[t] != (XrmQuark)0) {
		t++;
	}

	if (t==XSTQL_MAX_RETURN) {
		int i;
		FAIL;
		report("%s did not return the quark array as expected.",
			TestName);
		report("At least %d quarks returned.", XSTQL_MAX_RETURN);
		for (i=0; i<XSTQL_MAX_RETURN; i++)
			report("Quark array[%d]=%d", i, xstql_ret[i]);
	} else {
		if (xstql_ret[t] == unq) {
			FAIL;
			report("%s did not terminate the array with a zero.",
				TestName);
		} else
			CHECK;
	}

	CHECKPASS(2);
	free(buffer1);
