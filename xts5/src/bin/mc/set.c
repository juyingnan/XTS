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
* $Header: /cvs/xtest/xtest/xts5/src/bin/mc/set.c,v 1.1 2005-02-12 14:37:14 anderson Exp $
*
* Copyright (c) Applied Testing and Technology, Inc. 1995
* All Rights Reserved.
*
* Project: VSW5
*
* File: src/bin/mc/set.c
*
* Description:
*       misc routines mc utilities
*
* Modifications:
* $Log: set.c,v $
* Revision 1.1  2005-02-12 14:37:14  anderson
* Initial revision
*
* Revision 8.0  1998/12/23 23:24:17  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:42:27  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:16:43  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:13:16  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:41:28  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:38:19  andy
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

#include	<stdio.h>
#include	<string.h>
#include	"mc.h"

struct	settings Settings;

setcmd(bp)
char	*bp;
{
char	*tok;
char	*arg1;

	(void) strtok(bp, SEPS);

	tok = strtok((char *)0, SEPS);
	arg1 = strtok((char *)0, SEPS);
	if (arg1)
		arg1 = mcstrdup(arg1);

	if (strcmp(tok, "startup") == 0) {
		Settings.startup = arg1;
	} else if (strcmp(tok, "cleanup") == 0) {
		Settings.cleanup = arg1;
	} else if (strcmp(tok, "tpstartup") == 0) {
		Settings.tpstartup = arg1;
	} else if (strcmp(tok, "tpcleanup") == 0) {
		Settings.tpcleanup = arg1;
	} else if (strcmp(tok, "need-gc-flush") == 0) {
		Settings.needgcflush = 1;
	} else if (strcmp(tok, "fail-return") == 0) {
		Settings.failreturn = 1;
	} else if (strcmp(tok, "fail-no-return") == 0) {
		Settings.failreturn = 0;
	} else if (strcmp(tok, "return-value") == 0) {
		Settings.valreturn = arg1;
	} else if (strcmp(tok, "macro") == 0) {
		Settings.macro = 1;
		if (arg1)
			Settings.macroname = arg1;
	} else if (strcmp(tok, "begin-function") == 0) {
		Settings.beginfunc = arg1;
	} else if (strcmp(tok, "end-function") == 0) {
		Settings.endfunc = arg1;
	} else if (strcmp(tok, "no-error-status-check") == 0) {
		Settings.noerrcheck = 1;
	} else if (strcmp(tok, "error-status-check") == 0) {
		Settings.noerrcheck = 0;
	} else {
		err("Unrecognised set option\n");
		errexit();
	}

}

