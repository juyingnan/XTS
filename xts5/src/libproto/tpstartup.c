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
*
* Copyright Applied Testing and Technology Inc. 1995
* All rights reserved
*
* Project: VSW5
*
* File:	xts5/src/libproto/tpstartup.c
*
* Description:
*	Protocol test support routines
*
* Modifications:
* $Log: tpstartup.c,v $
* Revision 1.2  2005-11-03 08:42:02  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:12  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:25:19  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:43:32  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:17:40  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:14:12  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.1  1996/01/25 01:58:33  andy
* Portability improvements from DEPLOY tools
*
* Revision 4.0  1995/12/15  08:44:29  tbr
* Branch point for Release 5.0.0
*
* Revision 3.2  1995/12/15  00:42:12  andy
* Prepare for GA Release
*
*/

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

Copyright 1990, 1991 by UniSoft Group Limited.

Permission to use, copy, modify, distribute, and sell this software and
its documentation for any purpose is hereby granted without fee,
provided that the above copyright notice appear in all copies and that
both that copyright notice and this permission notice appear in
supporting documentation, and that the name of UniSoft not be
used in advertising or publicity pertaining to distribution of the
software without specific, written prior permission.  UniSoft
makes no representations about the suitability of this software for any
purpose.  It is provided "as is" without express or implied warranty.

Copyright 1988 by Sequent Computer Systems, Inc., Portland, Oregon

                        All Rights Reserved

Permission to use, copy, modify, and distribute this software and its
documentation for any purpose and without fee is hereby granted,
provided that the above copyright notice appears in all copies and that
both that copyright notice and this permission notice appear in
supporting documentation, and that the name of Sequent not be used
in advertising or publicity pertaining to distribution or use of the
software without specific, written prior permission.

SEQUENT DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING
ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT SHALL
SEQUENT BE LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR
ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS,
WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION,
ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS
SOFTWARE.
*/

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include "stdio.h"
#include "unistd.h"
#include "string.h"
#include "tet_api.h"
#include "xtest.h"
#include "X11/Xlib.h"
#include "X11/Xutil.h"
#include "xtestlib.h"
#include "XstlibInt.h"

/*
 * Actions to take at the beginning of a test purpose.
 * This version of tpstartup.c is for the X protocol test suite.
 */
void
tpstartup()
{
}

/*
 * Actions to take at the end of a test purpose.
 */
void
tpcleanup()
{
}

static char *savedfontpath = NULL;

static char *
put_in_commas(rep)
xGetFontPathReply *rep;
{
	char *p = NULL; /* for now, need Xstrealloc() etc. */
	unsigned int total_len;
	int npaths;
	char *endptr;
	CARD8 *fromptr;
	char *toptr;
	int reqlen = sizeof(xGetFontPathReply) + (int) (rep->length << 2);

	if (reqlen < sizeof(xGetFontPathReply)) {
		Log_Del ("Current server fontpath returned with bad length (%d)\n", reqlen);
		Free_Reply(rep);
		return NULL;
	}
	for (total_len=npaths=0,
		    fromptr=(CARD8 *)(((char *)rep)+sizeof(xGetFontPathReply));
		    npaths < (int)rep->nPaths;
		    npaths++) {
		total_len += *fromptr;
		fromptr += *fromptr + 1;
	}
	total_len += (npaths * sizeof(char)); /* commas + final nul */
	Log_Debug("Server's initial fontpath required %d bytes and had %d components\n", total_len, npaths);
	if (total_len <= 1 || npaths == 0) {
		Free_Reply(rep);
		return NULL;
	}
	p = (char *) Xstmalloc(total_len);
	if (p == NULL) {
		Log_Del ("Could not allocate %d bytes to store server's initial fontpath\n", total_len);
		Free_Reply(rep);
		return NULL;
	}
	endptr = p + total_len - 1;
	for (toptr=p,fromptr=(CARD8 *)(((char *)rep)+sizeof(xGetFontPathReply));
		    npaths > 0;
		    npaths--) {
		CARD8 len = *fromptr;

		wbcopy(fromptr+1, toptr, (unsigned int)len);
		fromptr += len + 1;
		toptr += len;
		*toptr++ = ',';
	}
	*endptr = '\0'; /* stamp on last comma to terminate the string. */

	Free_Reply(rep);
	return p;
}

static char *
getfontpath(client)
int client;
{
	xReq *req;
	xGetFontPathReply *rep;

	req = (xReq *) Make_Req(client, X_GetFontPath);
	Send_Req(client, (xReq *) req);
	Log_Trace("client %d sent startup GetFontPath request\n", client);
	if ((rep = (xGetFontPathReply *) Expect_Reply(client, X_GetFontPath)) == NULL) {
		Log_Del("Failed to receive startup GetFontPath reply\n");
		Free_Req(req);
		return NULL;
	}  else  {
		Log_Trace("client %d received startup GetFontPath reply\n", client);
	}
	(void) Expect_Nothing(client);
	Free_Req(req);

	return put_in_commas(rep);
}

static void
setfontpath(client,prevpath)
int client;
char *prevpath;
{
	xReq *req;
	char *commaptr;
	CARD8 n;
	CARD16 nf;

	req = (xReq *) Make_Req(client, X_SetFontPath);
	req = Clear_Counted_Value(req);
	((xSetFontPathReq *)req)->nFonts = 0;
	/* don't touch nFonts until all Add_Counted_Value calls done
	   as it uses nFonts as a count of bytes added. We must start
	   with it zero and only set it to the actual value after all of
	   value bytes added.
	*/

	for (n=nf=0, commaptr=prevpath; commaptr && *commaptr;) {
		char *p = SearchString(commaptr, ',');
		int i;

		if (p != NULL)
			*p = '\0';
		n = strlen(commaptr);
		if (n > 0) {
			req = Add_Counted_Value(req, n);
			for (i=n; i-- > 0; commaptr++)
				req = Add_Counted_Value(req, *commaptr);
			nf++;
		}
		if (p != NULL) {
			if (commaptr != p) {
				Log_Del("INTERNAL ERROR in fontsetting\n");
				return;
			}
			*commaptr++ = ',';
		}
	}
	/* must do this as Add_Counted_Value uses nFonts as byte count */
	((xSetFontPathReq *)req)->nFonts = nf;
	Log_Debug("Set font path to '%s': %d components\n", prevpath, nf);

	Send_Req(client, (xReq *) req);
	Log_Trace("client %d sent startup SetFontPath request\n", client);
	(void) Expect_Nothing(client);

	Free_Req(req);
}

/*
 * Actions to take at the beginning of a test purpose.
 * This version of tpstartup.c is for the X protocol test suite.
 * Special version to set font path and create long lived client.
 */
void
tpfontstartup()
{
	/*
	 * Reset SIGALRM signals to be caught in case the TCM has messed 
	 * with the signal settings. This only needs to be done in 
	 * tpfontstartup(), not in startup(), because in the default case
	 * we don't make any protocol requests in this process (parent), 
	 * so the timer is not even switched on in the parent.
	 * Normally, all the action happens only in the child process.
	 */
	Set_Init_Timer();
	Create_Client(LONG_LIVED_CLIENT);
	savedfontpath = getfontpath(LONG_LIVED_CLIENT);
	Log_Trace("Server's initial fontpath was '%s'\n",
		(savedfontpath == NULL) ? "<Nothing>" : savedfontpath);
	if (config.fontpath == NULL || *config.fontpath == '\0') {
		Log_Del("No, or empty, XT_FONTPATH set\n");
		return;
	}
	setfontpath(LONG_LIVED_CLIENT, config.fontpath);
}

/*
 * Actions to take at the end of a test purpose.
 * Special version to reset font path and destroy long lived client.
 */
void
tpfontcleanup()
{
	setfontpath(LONG_LIVED_CLIENT, savedfontpath);
	if (savedfontpath != NULL)
		free(savedfontpath);
	Destroy_Client(LONG_LIVED_CLIENT);
}
