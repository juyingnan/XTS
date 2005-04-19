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
$Header: /cvs/xtest/xtest/xts5/tset/Xlib16/rmstrtbndn/rmstrtbndn.m,v 1.1 2005-02-12 14:37:29 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1995
All Rights Reserved.

>># Project: VSW5
>># 
>># File: vsw5/tset/Xlib16/rmstrtbndn/rmstrtbndn.m
>># 
>># Description:
>># 	Tests for XrmStringToBindingQuarkList()
>># 
>># Modifications:
>># $Log: rmstrtbndn.m,v $
>># Revision 1.1  2005-02-12 14:37:29  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:34:22  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:56:41  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:25:41  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:22:14  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.1  1996/07/23 22:26:18  srini
>># Enhancements and clean-up
>>#
>># Revision 4.0  1995/12/15  09:10:21  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:12:43  andy
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
>>TITLE XrmStringToBindingQuarkList Xlib16
void

char *string;
XrmBindingList bindings_return = (XrmBindingList) xstbql_bret;
XrmQuarkList quarks_return = (XrmQuarkList) xstbql_qret; 
>>SET startup rmstartup
>>EXTERN
#define XSTBQL_MAX_RETURN 10
static XrmBinding xstbql_bret[XSTBQL_MAX_RETURN];
static XrmQuark xstbql_qret[XSTBQL_MAX_RETURN];

static char *xstbql_s1[]={
	"xstbql_test",
	"einse",
	"zwei",
	"drei",
	"vier",
	"funf",};

static char *xstbql_s1prefix[]={
	"*",
	".",
	"*",
	".",
	"*",
	"."};

static int xstbql_ns1=NELEM(xstbql_s1);

static char *xstbql_s2[]={
	"xstbql_test2",
	"Binkleys",
	"Dads",
	"1972",
	"Ford",
	"Pinto"};

static char *xstbql_s2sep[]={
	"*",
	".",
	"*",
	"*",
	".",
	""};

static int xstbql_ns2=NELEM(xstbql_s2);

static char *xstbql_s4[]={
	"xstbql_test2",
	"hazel",
	"wal",
	"coco",
	"pea"};

static char *xstbql_s4prefix[]={
	".",
	"*",
	".",
	"*",
	"."};

static int xstbql_ns4=NELEM(xstbql_s4);


static char *xstbql_s5[]={
	"xstbql_test5.",
	"Calvin*",
	"Hobbes",
	};
static int xstbql_ns5=NELEM(xstbql_s5);

static void
xstbqlclear(value)
XrmQuark value;
{
	int i;

/* Clear the return arrays, to avoid rogue results. */
	for(i=0; i<XSTBQL_MAX_RETURN; i++) 
	{
		xstbql_qret[i]=value;
		xstbql_bret[i]=XrmBindTightly; /* Have to use a value. */
	}

}


static
xstbqlname(value, ptr)
XrmBinding value;
char *ptr;
{
	if(value==XrmBindTightly) {
		strcpy(ptr, "XrmBindTightly");
	} else
	if(value==XrmBindLoosely) {
		strcpy(ptr, "XrmBindLoosely");
	} else
		sprintf(ptr, "UNKNOWN(%d)", (int)value);
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
Call xname to obtain the quark and binding lists.
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
	for(t=0; t<xstbql_ns1; t++) {
		(void) strcat(buffer1, xstbql_s1prefix[t]);
		(void) strcat(buffer1, xstbql_s1[t]);
	}
	trace("Testing with '%s'", buffer1);

	xstbqlclear((XrmQuark)0);

/* Call xname to obtain the quark and binding lists. */
	string= buffer1;
	XCALL;

#ifdef TESTING
	xstbql_qret[0]=0;
	xstbql_qret[1]=XrmStringToQuark("TESTING");
#endif

/* Verify that the quark list returned was as expected. */
	for(t=0; t<xstbql_ns1; t++) {
		char *ts;

		ts = XrmQuarkToString( xstbql_qret[t] );
		if (ts == (char *)NULL) {
			FAIL;
			report("Quark array[%d]=%d. Represents: NO STRING (expecting '%s')",
				t, xstbql_qret[t], xstbql_s1[t]);
			strcat(buffer2,"<NO STRING>");
		} else
		{
			if(strcmp(xstbql_s1[t], ts)) {
				FAIL;
				report("Quark array[%d]=%d. Represents: '%s' (expecting '%s')",
					t, xstbql_qret[t], ts, xstbql_s1[t]);
			} else {
				CHECK;
				trace("Quark array[%d]=%d. Represents: '%s' as expected.",
					t, xstbql_qret[t], ts );
			}
			(void) strcat(buffer2, ts);
		}
		(void) strcat(buffer2, " ");
	}

	if (fail) {
		report("%s did not split the string into the quarks as expected",
			TestName);
		report("String passed to %s: '%s'", TestName, buffer1);
		report("Quark array represents: %s", buffer2);
	} else
		CHECK;

	CHECKPASS(2+xstbql_ns1+1);
	free(buffer1);
	free(buffer2);

>>ASSERTION Good A
>># Two assertions for "strings are separeted by periods & asterisks"
On a call to xname, the
.A string
is separated into components according to the
positions of periods and asterisks.
>>STRATEGY
Create the test string.
Call xname to obtain quark and binding lists.
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
	for(t=0; t<xstbql_ns2; t++) {
		(void) strcat(buffer1, xstbql_s2[t]);
		(void) strcat(buffer1, xstbql_s2sep[t]);
	}
	trace("Testing with '%s'", buffer1);

	xstbqlclear((XrmQuark)0);

/* Call xname to obtain the quark and binding list. */
	string= buffer1;
	XCALL;

#ifdef TESTING
	xstbql_qret[0]=0;
	xstbql_qret[1]=XrmStringToQuark("TESTING");
#endif

/* Verify that the quark list returned was as expected. */
	for(t=0; t<xstbql_ns2; t++) {
		char *ts;

		ts = XrmQuarkToString( xstbql_qret[t] );
		if (ts == (char *)NULL) {
			FAIL;
			report("Quark array[%d]=%d. Represents: NO STRING (expecting '%s')",
				t, xstbql_qret[t], xstbql_s2[t]);
			strcat(buffer2,"<NO STRING>");
		} else
		{
			if(strcmp(xstbql_s2[t], ts)) {
				FAIL;
				report("Quark array[%d]=%d. Represents: '%s' (expecting '%s')",
					t, xstbql_qret[t], ts, xstbql_s2[t]);
			} else {
				CHECK;
				trace("Quark array[%d]=%d. Represents: '%s' as expected.",
					t, xstbql_qret[t], ts );
			}
			(void) strcat(buffer2, ts);
		}
		(void) strcat(buffer2, " ");
	}

	if (fail) {
		report("%s did not split the string into the quarks as expected",
			TestName);
		report("String passed to %s: '%s'", TestName, buffer1);
		report("Quark array represents: '%s'", buffer2);
	} else
		CHECK;

	CHECKPASS(2+xstbql_ns2+1);
	free(buffer1);
	free(buffer2);

>>ASSERTION Good A
When
.A string
does not start with a period or asterisk, then a leading period is assumed.
>>STRATEGY
Call xname to obtain quark and binding lists.
Verify that the binding was correct .
>>CODE
char ts[64];

/* Call xname to obtain quark and binding lists. */
	string = "xstbql_test3";
	XCALL;

/* Verify that the binding was correct. */
	if ( xstbql_bret[0] != XrmBindTightly ) {
		FAIL;
		xstbqlname(xstbql_bret[0], ts);
		report("%s did not assume a leading period", TestName);
		report("Returned %s", ts);
		report("Expected XrmBindTightly");
	} else
		CHECK;

	CHECKPASS(1);
	
>>ASSERTION Good A
When
.A string
is a valid resource name format string, then a call to xname
returns a binding list in
.S bindings_return
corresponding to the components of 
.A string ,
with components of
.A string
starting with an asterisk set to
.M XrmBindLoosely
and
other components set to
.M XrmBindTightly .
>>STRATEGY
Create the test string.
Call xname to obtain the quark and binding lists.
Verify that the binding list returned was as expected.
>>CODE
int  t;
char *buffer1;
char *buffer2, *buffer3;

	buffer1 = (char *)malloc( (size_t)256);
	if (buffer1==(char *)NULL) {
		delete("Could not malloc 256 bytes for buffer1.");
		return;
	} else
		CHECK;

	buffer2 = (char *)malloc( (size_t)1024);
	if (buffer2==(char *)NULL) {
		delete("Could not malloc 1024 bytes for buffer2.");
		return;
	} else
		CHECK;

	buffer3 = (char *)malloc( (size_t)1024);
	if (buffer3==(char *)NULL) {
		delete("Could not malloc 1024 bytes for buffer3.");
		return;
	} else
		CHECK;

	*buffer1='\0'; /* Make the buffers empty strings. */
	*buffer2='\0';
	*buffer3='\0';

/* Create the test string. */
	for(t=0; t<xstbql_ns4; t++) {
		(void) strcat(buffer1, xstbql_s4prefix[t]);
		(void) strcat(buffer1, xstbql_s4[t]);
	}
	trace("Testing with '%s'", buffer1);

	xstbqlclear((XrmQuark)0);

/* Call xname to obtain the quark and binding lists. */
	string= buffer1;
	XCALL;

#ifdef TESTING
	xstbql_bret[0]=(XrmBinding) -256;
#endif

/* Verify that the binding list returned was as expected. */
	for(t=0; t<xstbql_ns4; t++) {
		char retstr[64], expstr[64];
		XrmBinding expect;

		expect = *(xstbql_s4prefix[t])=='*'? XrmBindLoosely:XrmBindTightly;

		xstbqlname(expect, expstr);
		xstbqlname(xstbql_bret[t], retstr);

		if (xstbql_bret[t] != expect) {
			FAIL;
			report("Binding array[%d]=%s. Expecting %s",
				t, retstr, expstr);
		} else {
			CHECK;
			trace("Binding array[%d]=%s as expected.",
				t, retstr);
		}

		(void) strcat(buffer2, expstr);
		(void) strcat(buffer2, " ");

		(void) strcat(buffer3, retstr);
		(void) strcat(buffer3, " ");
	}

	if (fail) {
		report("%s did not split the string into the bindings as expected",
			TestName);
		report("String passed to %s: '%s'", TestName, buffer1);
		report("Expected bindings: %s", buffer2);
		report("Returned bindings: %s", buffer3);
	} else
		CHECK;

	CHECKPASS(3+xstbql_ns4+1);
	free(buffer1);
	free(buffer2);
	free(buffer3);

>>ASSERTION Good A
On a call to xname, the
.A quarks_return
list is terminated with a zero.
>>STRATEGY
Create the test string.
Set return buffer with unique quark value.
Call xname to obtain the quark and binding lists.
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
	for(t=0; t<xstbql_ns5; t++) {
		(void) strcat(buffer1, xstbql_s5[t]);
	}
	trace("Testing with '%s'", buffer1);

/* Set return buffer with unique quark value. */
	unq=XrmUniqueQuark();
	xstbqlclear(unq);

/* Call xname to obtain the quark and binding lists. */
	string= buffer1;
	XCALL;

/* Verify that the quark list was zero terminated. */
	t=0;
	while(t<XSTBQL_MAX_RETURN
		&& xstbql_qret[t] != unq
		&& xstbql_qret[t] != (XrmQuark)0) {
		t++;
	}

	if (t==XSTBQL_MAX_RETURN) {
		int i;
		FAIL;
		report("%s did not return the quark array as expected.",
			TestName);
		report("At least %d quarks returned.", XSTBQL_MAX_RETURN);
		for (i=0; i<XSTBQL_MAX_RETURN; i++)
			report("Quark array[%d]=%d", i, xstbql_qret[i]);
	} else {
		if (xstbql_qret[t] == unq) {
			FAIL;
			report("%s did not terminate the array with a zero.",
				TestName);
		} else
			CHECK;
	}

	CHECKPASS(2);
	free(buffer1);
>>ASSERTION Good B 2
The result of a call to xname when 
.A string
is in an encoding other than the Host Portable Character set.