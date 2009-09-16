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
>># File: xts5/Xlib10/XAddHosts/XAddHosts.m
>># 
>># Description:
>># 	Tests for XAddHosts()
>># 
>># Modifications:
>># $Log: addhsts.m,v $
>># Revision 1.2  2005-11-03 08:42:15  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:15  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:30:53  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:50:11  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:22:39  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:19:11  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:00:26  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  00:56:05  andy
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
>>TITLE XAddHosts Xlib10
void

Display	*display = Dsp;
XHostAddress	*hosts = xthosts;
int 	num_hosts = nxthosts;
>>EXTERN

#include	"xthost.h"

>>ASSERTION Good B 1
A call to xname adds each specified host to the access control list
for the display.
>>STRATEGY
Get current acl.
If current list includes the hosts to be added:
  Remove hosts with XRemoveHosts
  Get current acl.
  Check that hosts to be added are not in the list.
Call xname to add hosts.
If call fails with a BadAccess:
  Report that assertion can not be tested from this host.
Get new acl.
Verify that hosts are in new acl.
>>CODE
XHostAddress	*oldhosts;
XHostAddress	*newhosts;
int 	nhosts;
Bool	state;

	oldhosts = XListHosts(display, &nhosts, &state);

	/*
	 * Try to set up the current list so as to exclude hosts to
	 * be added.
	 */
	if (hostsinacl(hosts, nxthosts, oldhosts, nhosts) != 0) {
		/* Have to remove them first, may get BadAccess */
		debug(1, "Removing hosts");
		CATCH_ERROR(display);
		XRemoveHosts(display, hosts, nxthosts);
		RESTORE_ERROR(display);
		oldhosts = XListHosts(display, &nhosts, &state);
		if (hostsinacl(hosts, nxthosts, oldhosts, nhosts) != 0) {
			delete("Could not set up host list to exclude hosts to be added");
			return;
		}
	}
	if (isdeleted())
		return;

>>SET no-error-status-check
	XCALL;

	if (geterr() == BadAccess) {
		untested("This host does not have permission to change the list");
		report("  so this assertion cannot be tested");
		return;
	} else
		CHECK;

	newhosts = XListHosts(display, &nhosts, &state);
	if (hostsinacl(hosts, nxthosts, newhosts, nhosts) == nxthosts)
		CHECK;
	else {
		report("All hosts were not added to the access control list");
		FAIL;
	}

	CHECKPASS(2);

	XRemoveHosts(display, hosts, nxthosts);
>>EXTERN

/*
 * Returns the number of hosts in hosts[] that are in the acl.
 */
static int
hostsinacl(hosts, nxthosts, acl, nhosts)
XHostAddress	*hosts;
int 	nxthosts;
XHostAddress	*acl;
int 	nhosts;
{
int 	i, j;
int 	n;

	n = 0;
	for (i = 0; i < nxthosts; i++) {
		for (j = 0; j < nhosts; j++) {
			if (samehost(&hosts[i], &acl[j])) {
				n++;
				break;
			}
		}
	}
	return(n);
}

>>ASSERTION Good B 1
.ER Access acl
>>STRATEGY
Attempt to change access control list.
If an error occurs
  If error is BadAccess
    Report Pass.
  else
	Report Fail.
else
  Report that assertion is untestable for this host.
>>CODE

>>SET no-error-status-check
	XCALL;

	if (geterr() != Success) {
		if (geterr() == BadAccess)
			PASS;
		else {
			report("Received %s error, expecting BadAccess", errorname(geterr()));
			FAIL;
		}
	} else {
		untested("This host has permission to change the list");
		report("  so this assertion cannot be tested");
	}
>>ASSERTION Good B 1
When the host family, address length and address data do not form a valid
address, then a
.S BadValue
error occurs.
>>STRATEGY
Call xname with known bad address data.
If BadAccess error:
  Report that assertion cannot be tested.
Verify that a BadValue error occurs.
>>CODE BadValue

	hosts = xtbadhosts;
	num_hosts = nxtbadhosts;

>>SET no-error-status-check
	XCALL;

	if (geterr() == BadAccess) {
		untested("This host does not have permission to change the list");
		report("  so this assertion cannot be tested");
		return;
	} else
		CHECK;

	if (geterr() == BadValue)
		CHECK;
	else {
		report("Got %s, expecting BadValue", errorname(geterr()));
		FAIL;
	}

	CHECKPASS(2);
