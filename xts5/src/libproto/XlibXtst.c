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
* $Header: /cvs/xtest/xtest/xts5/src/libproto/XlibXtst.c,v 1.3 2005-11-03 08:42:02 jmichael Exp $
*
* Copyright (c) 2001 The Open Group
* Copyright Applied Testing and Technology Inc. 1995
* All rights reserved
*
* Project: VSW5
*
* File:	xts5/src/libproto/XlibXtst.c
*
* Description:
*	Protocol test support routines
*
* Modifications:
* $Log: XlibXtst.c,v $
* Revision 1.3  2005-11-03 08:42:02  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.2  2005/04/21 09:40:42  ajosey
* resync to VSW5.1.5
*
* Revision 8.3  2005/01/20 16:42:55  gwc
* Updated copyright notice
*
* Revision 8.2  2001/02/05 12:45:17  vsx
* fix fd_set usage; return value in XstDisconnectDisplay
*
* Revision 8.1  1999/04/03 01:26:48  mar
* req.4.W.00136: add low-level BigRequests support to Xlib-less connections
*
* Revision 8.0  1998/12/23 23:25:15  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:43:29  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.1  1998/07/31 14:42:33  andy
* Argument definitions for auth_proto and auth_string added to
* XstSendClientPrefix().
*
* Revision 6.0  1998/03/02 05:17:37  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:14:09  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.3  1998/01/25 19:38:44  tbr
* Added include needed for select() usage
*
* Revision 4.2  1998/01/12 22:57:58  andy
* Changed select to use fd_set types
*
* Revision 4.1  1996/01/25 01:58:33  andy
* Portability improvements from DEPLOY tools
*
* Revision 4.0  1995/12/15  08:44:19  tbr
* Branch point for Release 5.0.0
*
* Revision 3.3  1995/12/15  00:42:02  andy
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

/*
 * Full, and portable, functionality is available in XlibWithXTest.c if your
 * Xlib has the post R5 release patches to move auth/conn handling from
 * XOpenDis.c into XConDis.c and hence returned by _XConnectDisplay().
 * You can portably do client-native only testing with XlibOpaque.c
 * which uses XOpenDisplay to make the connection and then ConnectionNumber()
 * to get the fd. This route is also appropriate if your Xlib has a different
 * internal interface to the MIT release or else you don't have source.
 * All byte-sexes can also be tested with XlibNoXTest.c but that file is only
 * really for BSD type environments and may represent a portability constraint.
 * See the documentation of the build parameter XP_OPEN_DIS for more details.
 */
#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <stdio.h>
#include <string.h>
#include <sys/time.h>
#include "XstlibInt.h"
#include "XstosInt.h"
#include "DataMove.h"

#ifdef notdef
#include <stdio.h>
#include <string.h>
#include "X11/Xlib.h"
#include "X11/Xutil.h"
#include "XstlibInt.h"
#include "XstosInt.h"
#include "Xstos.h"
#include "DataMove.h"
#endif /* notdef */


/* use of _XConnectDisplay to get the fd for us may give us one with NBIO set */
#ifdef EWOULDBLOCK
#define MAYBE_BLOCK(d)	if (errno == EWOULDBLOCK) \
				{ _XstWaitForReadable(d); continue; }
#else
#define MAYBE_BLOCK(d)
#endif

#ifdef EAGAIN
#define MAYBE_AGAIN(d)	if (errno == EAGAIN) \
				{ _XstWaitForReadable(d); continue; }
#else
#define MAYBE_AGAIN(d)
#endif

/* time_proc used to set timeout routines and on error in Xst_EINTR_Read */
static void	(*time_proc)() = 0;

/* assume that connection info always fits in one read's worth XXX - CAREFUL */

#define Xst_EINTR_Read(dpy, buffer, len) \
    while (errno=0, *(char *)buffer=xFalse, 0 > Xst_Read (dpy, (char *) buffer, (long) len)) { \
	MAYBE_BLOCK(dpy); \
	MAYBE_AGAIN(dpy); \
	if (errno != EINTR) { \
		if (time_proc) \
			(*time_proc)(); \
		else { \
			Log_Msg ("read failed with errno = %d\n", errno); \
			Delete(); \
		} \
		/*NOTREACHED*/ \
	} \
    }

static int complain(dpy)
Display *dpy; /* Yes, an Xlib display */
{
	static char buf[256];

	sprintf(buf, "Connection error to server '%s'\n\t", DisplayString(dpy));
	/* pass the Xlib Display secure in the knowledge that XstIOError
	 * never uses it. THIS BETTER NOT CHANGE without a change here too!
	 */
	XstIOError((XstDisplay *)dpy, buf, 1);

	/*NOTREACHED*/ /* we hope */
	Delete(); /* just in case */

	/*NOTREACHED*/ /* definite */
	return 1; /* never */
}

/* 
 * Attempts to connect to server, given display name. Returns file descriptor
 * (network socket) or -1 if connection fails. The expanded display name
 * of the form hostname:number.screen ("::" if DECnet) is returned in a result
 * parameter. The screen number to use is also returned.
 */
int XstConnectDisplay (display_name, expanded_name, screen_num,
		       auth_proto, auth_length, auth_string, auth_strlen,
		       xlib_dpy)
    char *display_name;
    char *expanded_name;	/* return */
    int *screen_num;		/* return */
    char **auth_proto;		/* return */
    int *auth_length;		/* return */
    char **auth_string;		/* return */
    int *auth_strlen;		/* return */
    Display **xlib_dpy;		/* return */
{
    int idisplay;

    *xlib_dpy = (Display *)NULL;
    XSetIOErrorHandler(complain);
    return _XConnectDisplay(display_name, expanded_name, &idisplay, screen_num,
			    auth_proto, auth_length, auth_string, auth_strlen);
}

/* 
 * Disconnect from server.
 */

int XstDisconnectDisplay (server)

    int server;

{
    return close(server);
}

#undef NULL
#define NULL ((char *) 0)

_XstWaitForReadable(dpy)
  XstDisplay *dpy;
{
    fd_set r_mask;
    int result;
	
    FD_ZERO(&r_mask);
    do {
	FD_SET(dpy->fd, &r_mask);
	result = select(dpy->fd + 1, &r_mask, (fd_set *) 0, (fd_set *) 0, (struct timeval *)NULL);
	if (result == -1 && errno != EINTR) {
	    XstIOError(dpy,"_XstWaitForReadable",1);
	}
    } while (result <= 0);
}

static unsigned int padlength[4] = {0, 3, 2, 1};

void XstSendClientPrefix (dpy, client, auth_proto, auth_string, needswap)
     XstDisplay *dpy;
     xConnClientPrefix *client;
	char	*auth_proto;
	char	*auth_string;
     int needswap;
{
	/*
	 * Authorization string stuff....  Must always transmit multiple of 4
	 * bytes.
	 */

	int auth_length, auth_strlen;
	char pad[3];
	char buffer[BUFSIZ], *bptr;

        int bytes=0;

        auth_length = client->nbytesAuthProto;
        auth_strlen = client->nbytesAuthString;

	bytes = (sizeof(xConnClientPrefix) + 
                       auth_length + padlength[auth_length & 3] +
                       auth_strlen + padlength[auth_strlen & 3]);

	/* wbcopy(client, buffer, sizeof(xConnClientPrefix)); */
	bptr = buffer;
	BPRINTF1 ("OpenDisplay message:\n");
	pack1(&bptr,client->byteOrder);
	BPRINTF2 ("\tbyteOrder = 0x%x\n", (unsigned) client->byteOrder);
	packpad(&bptr,sizeof(client->pad));
	BPRINTF2 ("\tpad = %d\n", (int) *(bptr-1));
	pack2(&bptr,(short)client->majorVersion,needswap);
	BPRINTF2 ("\tmajorVersion = %d\n", client->majorVersion);
	pack2(&bptr,(short)client->minorVersion,needswap);
	BPRINTF2 ("\tminorVersion = %d\n", client->minorVersion);
	pack2(&bptr,(short)client->nbytesAuthProto,needswap);
	BPRINTF2 ("\tnbytesAuthProto = %d\n", client->nbytesAuthProto);
	pack2(&bptr,(short)client->nbytesAuthString,needswap);
	BPRINTF2 ("\tnbytesAuthString = %d\n", client->nbytesAuthString);
	packpad(&bptr,sizeof(client->pad2));
	BPRINTF2 ("\tpad2 = %d\n", (int) *(bptr-1));

        /* bptr = buffer + sizeof(xConnClientPrefix); */
	BPRINTF2 ("\tAuthProtoName = %d bytes\n", auth_length);
        if (auth_length)
	{
	    wbcopy(auth_proto, bptr, auth_length);
            bptr += auth_length;
            if (padlength[auth_length & 3])
	    {
		wbcopy(pad, bptr, padlength[auth_length & 3]);
	        bptr += padlength[auth_length & 3];
		BPRINTF2 ("\tAuthProtoName pad = %d bytes\n", padlength[auth_length & 3]);
	    }
	}
	BPRINTF2 ("\tAuthProtoData = %d bytes\n", auth_strlen);
        if (auth_strlen)
	{
	    wbcopy(auth_string, bptr, auth_strlen);
            bptr += auth_strlen;
            if (padlength[auth_strlen & 3])
	    {
		wbcopy(pad, bptr, padlength[auth_strlen & 3]);
	        bptr += padlength[auth_strlen & 3];
		BPRINTF2 ("\tAuthProtoData pad = %d bytes\n", padlength[auth_strlen & 3]);
	    }
	}
	BPRINTF2 ("\tTotal OpenDisplay message length = %d bytes\n", bytes);
	BPRINTF2 ("\t\ton fd %d\n", dpy->fd);
	BPRINTF2 ("\t\t%d bytes used of buffer\n", bptr - buffer);
	(void) WriteToServer(dpy->fd, buffer, bytes);
	return;
}

/*
 * The Timeout function(s) must all exit -- we don't want to get
 * into longjmp from out of signal (SIGALARM) handlers etc. So
 * we have to use the test type and request type to work out
 * what messages to put out and what exit code to give back to the TET.
 * NOTE that we use the timeout functions on Xst_EINTR_Read fails, as well.
 *
 * Behaviour is as follows:
 *
 * Request Type: OPEN_DISPLAY_REQUEST_TYPE    || anything else
 * Test Type: OPEN_DISPLAY   |  anything else || anything at all
 * __________(bad byte order)| (0x42 or 0x6C) || (0x42 or 0x6C)
 * Getting:  \---------------+----------------++------------------
 * 	      |		     |		      ||
 * SetupPrefix|	PASS(Exit_OK)|  FAIL(Abort)   || Delete
 * 	      |		     |		      ||
 * SetupData  |	Not Reached  |  FAIL(Abort)   || Delete
 *	      | (Delete)     |		      ||
 *
 */


#define		PASS_action	1
#define		FAIL_action	2
#define		DELETE_action	3

static char *nothing = "No reply from server when trying to connect to %s\n";

static void
Timeout_Func(action)
int action;
{
    char *server = Xst_server_node == NULL ? "Default Server" : Xst_server_node;

    switch(action) {
    case PASS_action:
	Log_Trace("No prefix sent in response to bad byte order open request.");
	Exit_OK ();
	/*NOTREACHED*/
	break;
    case FAIL_action:
	Log_Msg(nothing, server);
	Abort ();
	/*NOTREACHED*/
	break;
    case DELETE_action:
	Log_Msg(nothing, server);
	Delete ();
	/*NOTREACHED*/
	break;
    default:
	Log_Msg("INTERNAL TEST SUITE ERROR: bad action (%d) in Timeout_Func with server %s.", action, server);
	Delete ();
	/*NOTREACHED*/
	break;
    }
}

static void
Normal_Timeout_Func() {
    Timeout_Func(DELETE_action);
}

static void
Good_Open_Timeout_Func() {
    Timeout_Func(FAIL_action);
}

static void
Bad_Open_Timeout_Func() {
    Timeout_Func(PASS_action);
}

GetConnSetupPrefix (client, prefixp, needswap)
int client;
xConnSetupPrefix * prefixp;
int     needswap;
{
    XstDisplay * dpy;
    char    buffer[OBUFSIZE];
    char   *bptr;

    dpy = Get_Display(client);

    if (Get_Req_Type(client) == OPEN_DISPLAY_REQUEST_TYPE) {
	if (Get_Test_Type(client) == OPEN_DISPLAY)
		time_proc = Bad_Open_Timeout_Func; 
	else
		time_proc = Good_Open_Timeout_Func;
    } else
	time_proc = Normal_Timeout_Func;

    Set_Timer (CONNECT_TIMER_ID, Xst_timeout_value, time_proc);

    Xst_EINTR_Read (dpy, (char *) buffer, (long) sizeof (xConnSetupPrefix));

    Stop_Timer (CONNECT_TIMER_ID);

    BPRINTF1 ("Connection setup prefix:\n");
    bptr = buffer;
    prefixp -> success = unpack1 (&bptr);
    BPRINTF2 ("\tsuccess = %s\n", boolname(prefixp->success));
    prefixp -> lengthReason = unpack1 (&bptr);
    BPRINTF2 ("\tlengthReason = %d\n", prefixp->lengthReason);
    prefixp -> majorVersion = unpack2 (&bptr, needswap);
    BPRINTF2 ("\tmajorVersion = %d\n", prefixp->majorVersion);
    prefixp -> minorVersion = unpack2 (&bptr, needswap);
    BPRINTF2 ("\tminorVersion = %d\n", prefixp->minorVersion);
    prefixp -> length = unpack2 (&bptr, needswap);
    BPRINTF2 ("\tlength = %d\n", prefixp->length);
}

/* 
 *	GetConnSetupData - reads & byte swaps (as appropriate)
 *		the rest of the connection setup data
*		(Note this is somewhat redundant with logic
 *		in XOpenDisplay - might merge later)
 */

void GetConnSetupData (client, setupdp, len, needswap)
int client;
xConnSetup * setupdp;
int     len;
int     needswap;
{
    XstDisplay * dpy;
    char    buffer[OBUFSIZE];
    char   *bptr;
    char   *sptr;		/* pointer into setup data area */
    int     pad;
    int i;
    int d;
    int s;
    int v;
    int f;
    int ndepths;
    int nvisuals;

    dpy = Get_Display(client);

    if (Get_Req_Type(client) == OPEN_DISPLAY_REQUEST_TYPE) {
	if (Get_Test_Type(client) == OPEN_DISPLAY) {
		Log_Msg ("INTERNAL ERROR: should not be getting SetupData with TestType == OPEN_DISPLAY.");
		Delete();
		/*NOTREACHED*/
	}
	time_proc = Good_Open_Timeout_Func;
    } else
	time_proc = Normal_Timeout_Func;

    Set_Timer (CONNECT_TIMER_ID, Xst_timeout_value, time_proc);

    if (!needswap) {
	Xst_EINTR_Read (dpy, (char *) setupdp, len);
	Stop_Timer (CONNECT_TIMER_ID);
	return;
    }
    else {
	Xst_EINTR_Read (dpy, (char *) buffer, len);
	Stop_Timer (CONNECT_TIMER_ID);
	bptr = buffer;

	setupdp -> release = unpack4 (&bptr, needswap);
	setupdp -> ridBase = unpack4 (&bptr, needswap);
	setupdp -> ridMask = unpack4 (&bptr, needswap);
	setupdp -> motionBufferSize = unpack4 (&bptr, needswap);
	setupdp -> nbytesVendor = unpack2 (&bptr, needswap);
	setupdp -> maxRequestSize = unpack2 (&bptr, needswap);
	setupdp -> numRoots = unpack1 (&bptr);
	setupdp -> numFormats = unpack1 (&bptr);
	setupdp -> imageByteOrder = unpack1 (&bptr);
	setupdp -> bitmapBitOrder = unpack1 (&bptr);
	setupdp -> bitmapScanlineUnit = unpack1 (&bptr);
	setupdp -> bitmapScanlinePad = unpack1 (&bptr);
	setupdp -> minKeyCode = unpack1 (&bptr);
	setupdp -> maxKeyCode = unpack1 (&bptr);
	setupdp -> pad2 = unpack4 (&bptr, needswap);

	sptr = (char *) (setupdp + 1);

/*	get the vendor string */
	wbcopy (bptr, sptr, setupdp -> nbytesVendor);
	pad = (setupdp -> nbytesVendor + 3) & ~3;
	bptr += pad;
	sptr += pad;

 /* Z axis screen format info */
 /* NOTE - this counts on only 1 byte quantities in the format!! */
	for (f = 0; f < (int)setupdp->numFormats; f++) {
	wbcopy (bptr, sptr, sizeof (xPixmapFormat));
	bptr += sizeof (xPixmapFormat);
	sptr += sizeof (xPixmapFormat);
	}
 /* Screen structures */
	for (s = 0; s < (int)setupdp->numRoots; s++) {
	for (i = 0; i < 5; i++) {
	    swapcplp (bptr, sptr);
	    bptr += 4;
	    sptr += 4;
	}
	for (i = 0; i < 6; i++) {
	    swapcpsp (bptr, sptr);
	    bptr += 2;
	    sptr += 2;
	}
	swapcplp (bptr, sptr);	/* visualID */
	bptr += 4;
	sptr += 4;
	wbcopy (bptr, sptr, 4);
	ndepths = bptr[3];	/* pull out nDepths */
	bptr += 4;
	sptr += 4;
	for (d = 0; d < ndepths; d++) {
	    *sptr++ = *bptr++;
	    *sptr++ = *bptr++;
	    swapcpsp (bptr, sptr);/* nVisuals */
	    nvisuals = * (short *) sptr;
	    bptr += 2;
	    sptr += 2;

	    bptr += 4;		/* pad */
	    sptr += 4;

	    for (v = 0; v < nvisuals; v++) {
		swapcplp (bptr, sptr);/* visualid */
		bptr += 4;
		sptr += 4;
		*sptr++ = *bptr++;
		*sptr++ = *bptr++;
		swapcpsp (bptr, sptr);/* colormapEntries */
		bptr += 2;
		sptr += 2;
		for (i = 0; i < 4; i++) {
		    swapcplp (bptr, sptr);
		    bptr += 4;
		    sptr += 4;
		}
	    }
	}
	}
    }
}

/* Big Request additions */

#define X_BigReqEnable		0

#define XBigReqNumberEvents	0

#define XBigReqNumberErrors	0

#define XBigReqExtensionName	"BIG-REQUESTS"

typedef struct {
    CARD8	reqType;	/* always XBigReqCode */
    CARD8	brReqType;	/* always X_BigReqEnable */
    CARD16	length B16;
} xBigReqEnableReq;
#define sz_xBigReqEnableReq 4

typedef struct {
    BYTE	type;			/* X_Reply */
    CARD8	pad0;
    CARD16	sequenceNumber B16;
    CARD32	length B32;
    CARD32	max_request_size B32;
    CARD32	pad1 B32;
    CARD32	pad2 B32;
    CARD32	pad3 B32;
    CARD32	pad4 B32;
    CARD32	pad5 B32;
} xBigReqEnableReply;
#define sz_xBigReqEnableReply 32


typedef struct {
	CARD8 reqType;
	CARD8 data;
	CARD16 zero B16;
        CARD32 length B32;
} xBigReq;

#define bignamelen (sizeof(XBigReqExtensionName) - 1)

BigRequestsSetup(client, dpy, needswap)
int client;
XstDisplay  *dpy;
int     needswap;
{
    xQueryExtensionReq queryreq;
    xQueryExtensionReply queryreply;
    xBigReqEnableReq bigreq;
    xBigReqEnableReply bigreply;
    char pad[3];
    char buffer[BUFSIZ], *bptr;
    char *query_name = XBigReqExtensionName;
    int query_len;
    int bytes;
    
    dpy->bigreq_size = 0;

    /* QueryExtension for BIG-REQUESTS to see if it is supported */

    query_len = strlen(query_name);
    bytes = sizeof(xQueryExtensionReq) + query_len + padlength[query_len & 3];

    queryreq.reqType = X_QueryExtension;
    queryreq.length = 2 + (query_len+padlength[query_len & 3]) / 4;
    queryreq.nbytes = query_len;
    
    bptr = buffer;
    BPRINTF1 ("QueryExtension message:\n");
    pack1(&bptr, queryreq.reqType);
    BPRINTF2 ("\topcode = %d\n", queryreq.reqType);
    packpad(&bptr,sizeof(queryreq.pad));
    BPRINTF2 ("\tpad = %d\n", (int) *(bptr-1));
    pack2(&bptr,(short)queryreq.length,needswap);
    BPRINTF2 ("\tlength = %d\n", queryreq.length);
    pack2(&bptr,(short)queryreq.nbytes,needswap);
    BPRINTF2 ("\tnbytes = %d\n", queryreq.nbytes);
    packpad(&bptr,sizeof(queryreq.pad1));
    BPRINTF2 ("\tpad1 = %d\n", (int) *(bptr-1));
    packpad(&bptr,sizeof(queryreq.pad2));
    BPRINTF2 ("\tpad2 = %d\n", (int) *(bptr-1));
    BPRINTF2 ("\tQueryName = %d bytes\n", queryreq.length);
    wbcopy(query_name, bptr, query_len);
            bptr += query_len;
            if (padlength[query_len & 3])
	    {
		wbcopy(pad, bptr, padlength[query_len & 3]);
	        bptr += padlength[query_len & 3];
		BPRINTF2 ("\tQueryName pad = %d bytes\n", padlength[query_len & 3]);
	    }
    BPRINTF2 ("\tTotal QueryExtension message length = %d bytes\n", bytes);
    BPRINTF2 ("\t\ton fd %d\n", dpy->fd);
    BPRINTF2 ("\t\t%d bytes used of buffer\n", bptr - buffer);
    dpy->request++; /* increment sequence counter */
    (void) WriteToServer(dpy->fd, buffer, bytes);
    if (Get_Req_Type(client) == OPEN_DISPLAY_REQUEST_TYPE) {
	if (Get_Test_Type(client) == OPEN_DISPLAY) {
		Log_Msg ("INTERNAL ERROR: should not be getting QueryExtensionReply with TestType == OPEN_DISPLAY.");
		Delete();
		/*NOT REACHED*/
	}
	time_proc = Good_Open_Timeout_Func;
    } else
	time_proc = Normal_Timeout_Func;

    Set_Timer (CONNECT_TIMER_ID, Xst_timeout_value, time_proc);
    if (!needswap) {
	Xst_EINTR_Read (dpy, &queryreply, sizeof(queryreply));
	Stop_Timer (CONNECT_TIMER_ID);
	BPRINTF2 ("Total Query reply read %d bytes\n",sizeof(queryreply));
    }
    else {
	Xst_EINTR_Read (dpy, (char *) buffer, sizeof(queryreply));
	Stop_Timer (CONNECT_TIMER_ID);
	BPRINTF2 ("Total swapped Query reply read %d bytes\n",sizeof(queryreply));
	bptr = buffer;

	queryreply.type = unpack1 (&bptr);
	queryreply.pad1 = unpack1 (&bptr);
	queryreply.sequenceNumber = unpack2 (&bptr, needswap);
	queryreply.length = unpack4 (&bptr, needswap);
	queryreply.present = unpack1 (&bptr);
	queryreply.major_opcode = unpack1 (&bptr);
	queryreply.first_event = unpack1 (&bptr);
	queryreply.first_error = unpack1 (&bptr);
    }

    /* If present then enable the extension */
    if (queryreply.present) {

	/* Send big request enable request */

	bptr = buffer;
	bytes = sizeof(bigreq);

	bigreq.reqType = queryreply.major_opcode; /* XBigReqCode */
	bigreq.brReqType = X_BigReqEnable;
	bigreq.length = 1;

	bptr = buffer;
	BPRINTF1 ("BigReqEnable message:\n");
	pack1(&bptr, bigreq.reqType);
	BPRINTF2 ("\topcode = %d\n", bigreq.reqType);
	pack1(&bptr, bigreq.brReqType);
	BPRINTF2 ("\tbrReqType = %d\n", bigreq.brReqType);
	pack2(&bptr,(short)bigreq.length,needswap);
	BPRINTF2 ("\tlength = %d\n", bigreq.length);

	BPRINTF2 ("\tTotal BigReqEnable message length = %d bytes\n", bytes);
	BPRINTF2 ("\t\ton fd %d\n", dpy->fd);
	BPRINTF2 ("\t\t%d bytes used of buffer\n", bptr - buffer);
	dpy->request++; /* increment sequence counter */
	(void) WriteToServer(dpy->fd, buffer, bytes);

	/* time_proc already set */
	Set_Timer (CONNECT_TIMER_ID, Xst_timeout_value, time_proc);
	if (!needswap) {
	    Xst_EINTR_Read (dpy, &bigreply, sizeof(bigreply));
	    Stop_Timer (CONNECT_TIMER_ID);
	}
	else {
	    Xst_EINTR_Read (dpy, (char *) buffer, sizeof(bigreply));
	    Stop_Timer (CONNECT_TIMER_ID);
	    bptr = buffer;

	    bigreply.type = unpack1 (&bptr);
	    bigreply.pad0 = unpack1 (&bptr);
	    bigreply.sequenceNumber = unpack2 (&bptr, needswap);
	    bigreply.length = unpack4 (&bptr, needswap);
	    bigreply.max_request_size = unpack4 (&bptr, needswap);
	}
	dpy->bigreq_size = bigreply.max_request_size;
	BPRINTF2 ("Big Request Size set to %d\n", dpy->bigreq_size);
    }
    else
      	BPRINTF1 ("Big Requests not supported\n");
}

