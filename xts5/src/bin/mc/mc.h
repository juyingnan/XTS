/*
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
*/
/*
* $Header: /cvs/xtest/xtest/xts5/src/bin/mc/mc.h,v 1.1 2005-02-12 14:37:14 anderson Exp $
*
* Copyright (c) Applied Testing and Technology, Inc. 1995
* All Rights Reserved.
*
* Project: VSW5
*
* File: src/bin/mc/mc.h
*
* Description:
*       Include file for mc utilities
*
* Modifications:
* $Log: mc.h,v $
* Revision 1.1  2005-02-12 14:37:14  anderson
* Initial revision
*
* Revision 8.0  1998/12/23 23:24:15  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:42:25  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:16:42  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:13:14  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.1  1997/01/22 22:14:29  andy
* Added State.xtathena as Xt6 no longer needed Athena widgets
*
* Revision 4.0  1995/12/15  08:41:23  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:38:12  andy
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

*/

#ifndef EXIT_FAILURE
#define EXIT_FAILURE 1
#endif

#define	MAXLINE	1024

/* Defines for the directives that introduce each section */
#define D_AVSCODE	">>AVSCODE"
#define D_HEADER	">>TITLE"
#define D_ASSERTION	">>ASSERTION"
#define D_STRATEGY	">>STRATEGY"
#define D_CODE		">>CODE"
#define D_MAKE		">>MAKE"
#define D_EXTERN	">>EXTERN"
#define	D_INCLUDE	">>INCLUDE"
#define D_CFILE		">>CFILES"
#define D_COMMENT	">>#"
#define D_COMMENT_LEN	3
#define D_SET		">>SET"

#define SECSTART(buf)	((buf)[0] == '>' && (buf)[2] != '#')

#define XCALLSYM	"XCALL"
#define XNAMESYM	"xname"

#define	ASLENGTH	60

struct	settings	{
	char	*startup;
	char	*cleanup;
	char	*tpstartup;
	char	*tpcleanup;
	short 	needgcflush;
	char	*display;	/* Name of the display variable if there is one */
	short	failreturn;	/* return after a failure */
	char	*valreturn;	/* Symbol value that should be returned */
	char	*beginfunc;	/* Function to call at beginning of TP */
	char	*endfunc;	/* Function to call at end of TP */
	int 	macro;		/* Has a macro version */
	char	*macroname;	/* Name of the macro version */
	short	noerrcheck;	/* No error status check */
};

struct	state	{
	char	*name;		/* test name */
	char	*chap;		/* associated chapter or section */
	int 	assertion;	/* assertion number */
	char	*type;		/* type code */
	short	category;	/* category code */
	char	*reason;	/* reason code string for categories B, D */
	short	sectype;	/* Current section we are in */
	short	defaultreq;	/* Default strat/code is needed */
	short	discardtest;/* We are discarding this assertion */
	short	err;		/* State within a .ER assertion */
	short	skipsec;	/* Skip some sections */
	short	abortafter;	/* stop after this many sections */
	short	xproto;		/* This is an xproto test */
	short	xtoolkit;	/* This is a Xt test */
	short	xtathena;	/* This is a Xt test needing Athena widgets*/
	short	xcms;		/* This is a Xcms test */
};

#define	ER_NONE		0	/* No error */
#define	ER_NORM		1	/* Normal error */
#define	ER_VALUE	2	/* A Value error */

/* Commands  */
#define	CMD_MEXPAND	0
#define	CMD_MC	1
#define	CMD_MKMF 2
#define	CMD_MA	3
#define	CMD_MAS	4

/*Section types */
#define	SEC_COPYRIGHT	0
#define	SEC_HEADER	1
#define	SEC_ASSERTION	2
#define	SEC_DEFASSERT	3
#define	SEC_STRATEGY	4
#define	SEC_CODE	5
#define	SEC_EXTERNCODE	6
#define	SEC_FILE	7
#define	SEC_MAKE	8
#define	SEC_AVSCODE	9
#define	NSEC	10

/* Hook types.  These allow commands to obtain information about
  various things that happen.
*/
#define	HOOK_START	0
#define	HOOK_END	1
#define	HOOK_INCSTART	2
#define	HOOK_INCEND	3
#define	HOOK_SET	4
#define	HOOK_COMMENT	5
#define	NHOOK	6

struct	mclist {
	int 	num;	/* Number used */
	int 	size;	/* Number available */
	char	*items[1];/* strings */
	/* Really longer */
};

/*Some temporary file names */
#define	F_TVAL		"Mval.tmc"	/* Value assertion */
#define	F_TVCODE	"Mvcode.tmc"	/* BadValue code */
#define	F_TDEFCODE	"Mdefcode.tmc"	/* default code */

/* Category codes */
#define	CAT_NONE	'\0'
#define	CAT_A		'A'
#define	CAT_B		'B'
#define	CAT_C		'C'
#define	CAT_D		'D'
#define	CAT_DEF		'-'

#define	SEPS	" \t\n"
#define	ARGSEP	" \t\n*[]();"

#define	NELEM(A)	(sizeof(A)/sizeof(A[0]))

#include	"mcproto.h"
