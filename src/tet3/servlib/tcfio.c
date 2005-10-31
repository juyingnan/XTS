/*
 *      SCCS:  @(#)tcfio.c	1.6 (96/11/04) 
 *
 *	UniSoft Ltd., London, England
 *
 * (C) Copyright 1992 X/Open Company Limited
 *
 * All rights reserved.  No part of this source code may be reproduced,
 * stored in a retrieval system, or transmitted, in any form or by any
 * means, electronic, mechanical, photocopying, recording or otherwise,
 * except as stated in the end-user licence agreement, without the prior
 * permission of the copyright owners.
 *
 * X/Open and the 'X' symbol are trademarks of X/Open Company Limited in
 * the UK and other countries.
 */

#ifndef lint
static char sccsid[] = "@(#)tcfio.c	1.6 (96/11/04) TET3 release 3.3";
#endif

/************************************************************************

SCCS:   	@(#)tcfio.c	1.6 96/11/04 TETware release 3.3
NAME:		tcfio.c
PRODUCT:	TETware
AUTHOR:		Andrew Dingwall, UniSoft Ltd.
DATE CREATED:	May 1992

DESCRIPTION:
	functions to request TCCD to open, close and write ascii files

MODIFICATIONS:

************************************************************************/

#include <stdio.h>
#include <errno.h>
#include "dtmac.h"
#include "dtmsg.h"
#include "avmsg.h"
#include "valmsg.h"
#include "error.h"
#include "servlib.h"
#include "dtetlib.h"

#ifdef NEEDsrcFile
static char srcFile[] = __FILE__;	/* file name for error reporting */
#endif


/* static function declarations */
static char *tc_fio PROTOLIST((int, int));


/*
**	tet_tcfopen() - send an OP_FOPEN message to STCC and receive a reply
**
**	return file ID if successful or -1 on error
*/

int tet_tcfopen(sysid, file)
int sysid;
char *file;
{
	register char *dp;

	/* make sure that file is non-null */
	if (!file || !*file) {
		tet_tcerrno = ER_INVAL;
		return(-1);
	}

	/* get the TCCD message buffer */
	if ((dp = tet_tcmsgbuf(sysid, avmsgsz(OP_FOPEN_ARGC))) == (char *) 0) {
		tet_tcerrno = ER_ERR;
		return(-1);
	}

#define mp	((struct avmsg *) dp)

	/* set up the request message */
	mp->av_argc = OP_FOPEN_ARGC;
	AV_FNAME(mp) = file;
	AV_FTYPE(mp) = "w";

#undef mp

	dp = tc_fio(sysid, OP_FOPEN);

#define rp ((struct valmsg *) dp)

	return(dp ? (int) VM_FID(rp) : -1);

#undef rp

}

/*
**	tet_tcfclose() - send an OP_FCLOSE message to TCCD and receive a reply
**
**	return file ID if successful or -1 on error
*/

int tet_tcfclose(sysid, fid)
int sysid, fid;
{
	register struct valmsg *mp;

	/* get the TCCD message buffer */
	if ((mp = (struct valmsg *) tet_tcmsgbuf(sysid, valmsgsz(OP_FCLOSE_NVALUE))) == (struct valmsg *) 0) {
		tet_tcerrno = ER_ERR;
		return(-1);
	}

	/* set up the request message */
	mp->vm_nvalue = OP_FCLOSE_NVALUE;
	VM_FID(mp) = (long) fid;

	return(tc_fio(sysid, OP_FCLOSE) == (char *) 0 ? -1 : 0);
}

/*
**	tet_tcputs() - send a single line OP_PUTS message to TCCD and receive a
**		reply
**
**	return 0 if successful or -1 on error
*/

int tet_tcputs(sysid, fid, line)
int sysid, fid;
char *line;
{
	return(tet_tcputsv(sysid, fid, &line, 1));
}

/*
**	tet_tcputsv() - send a multi-line OP_PUTS message to TCCD and
**		receive a reply
**
**	return 0 if successful or -1 on error
*/

int tet_tcputsv(sysid, fid, lines, nline)
int sysid, fid;
register int nline;
register char **lines;
{

	register struct avmsg *mp;
	register int n;

	/* make sure that lines is non-zero and that nline is +ve */
	if (!lines || nline <= 0) {
		tet_tcerrno = ER_INVAL;
		return(-1);
	}

	/* get the TCCD message buffer */
	if ((mp = (struct avmsg *) tet_tcmsgbuf(sysid, avmsgsz(OP_PUTS_ARGC(nline)))) == (struct avmsg *) 0) {
		tet_tcerrno = ER_ERR;
		return(-1);
	}

	/* set up the request message */
	mp->av_argc = OP_PUTS_ARGC(nline);
	AV_FID(mp) = (long) fid;
	for (n = 0; n < nline; n++)
		AV_FLINE(mp, n) = *lines++;

	return(tc_fio(sysid, OP_PUTS) == (char *) 0 ? -1 : 0);
}

/*
**	tc_fio() - common tet_tctalk() interface used by several functions
**
**	return pointer to TCCD reply buffer if successful
**		or (char *) 0 on error
*/

static char *tc_fio(sysid, request)
int sysid, request;
{
	register char *dp;
	extern char tet_tcerrmsg[];

	/* send the request and receive the reply */
	dp = tet_tctalk(sysid, request, TALK_DELAY);

	/* handle the return codes */
	if (tet_tcerrno == ER_OK)
		return(dp);
	else if ((errno = tet_unmaperrno(tet_tcerrno)) == 0)
		switch (tet_tcerrno) {
		case ER_FID:
		case ER_INVAL:
			break;
		case ER_ERR:
			if (!dp)
				break;
			/* else fall through */
		default:
			error(0, tet_tcerrmsg, tet_ptrepcode(tet_tcerrno));
			break;
		}

	/* here for server error return */
	return((char *) 0);
}

