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
*
* Copyright (c) Applied Testing and Technology, Inc. 1995
* All Rights Reserved.
*
* Project: VSW5
*
* File: src/bin/mc/cond.c
*
* Description:
*       conditional handling routines for mc utilities
*
* Modifications:
* $Log: cond.c,v $
* Revision 1.1  2005-02-12 14:37:14  anderson
* Initial revision
*
* Revision 8.0  1998/12/23 23:24:11  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:42:21  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:16:38  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:13:10  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:41:11  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:37:49  andy
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

/*
 * Filter out a limited number of conditional constructs from the
 * source.  We attempt only to remove the conditionals that are
 * designed for the included files, to make them work with different
 * functions.
 *
 * Only recognise:
 *    #ifdef A_<argtype>
 * and
 *    #if T_<name> [ || T_<name2> ]
 * Where argtype is WINDOW, PIXMAP etc. and name is the fuction name.
 * The '#' must be in column 1.
 *
 * This makes the resulting C file less a little less cumbersome.  All
 * other defines are left alone.  (This is not meant to replace
 * the C pre-processor...).
 */

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include	<stdio.h>
#include	"mc.h"

int	 Outputon = 1;

#define	MAXLEV	30	/* Not a real max -- just give up at this point */
static	int 	offlevel;
static	int 	level;
static	int 	uselev[MAXLEV] = {
	1};

#define	MAXDEF	64	/* Max number of defines */
static	char	*deftbl[MAXDEF];
static	int 	defind;
static	char	*knownargs[] = {
	"A_DRAWABLE",
	"A_DRAWABLE2",
	"A_WINDOW",
	"A_WINDOW2",
	"A_PIXMAP",
	"A_IMAGE",
};

extern	struct	state	State;

#define	False	0
#define True	1

hashcmd(buf)
char	*buf;
{
	if (strncmp(buf, "#if", 3) == 0)
		return doif(buf);
	else if (strncmp(buf, "#else", 5) == 0)
		return doelse();
	else if (strncmp(buf, "#endif", 6) == 0)
		return doendif();
	return True;
}

doif(buf)
char	*buf;
{
char	*line;
char	*tok;
int 	known;
int 	foundtrue;
char	*strtok();
int 	i;

	level++;

	line = mcstrdup(buf);
	known = False;
	foundtrue = False;

	tok = strtok(line, " \t");
	if (strcmp(tok, "#if") == 0) {

		while ((tok = strtok((char*)0, " \t\n()")) != 0) {
			if (strcmp(tok, "||") == 0)
				;
			else if (strcmp(tok, "defined") == 0)
				;
			else if (tok[0] == 'T' && tok[1] == '_' && tok[2] == 'X') {
				if (strcmp(tok+2, State.name) == 0)
					foundtrue = True;
				known = True;
			} else {
				known = False;
				break;
			}
		}
	} else if (defind && strcmp(tok, "#ifdef") == 0) {
		tok = strtok((char*)0, " \t\n");
		if (tok[0] == 'A' && tok[1] == '_') {
			for (i = 0; i < NELEM(knownargs); i++) {
				if (strcmp(knownargs[i], tok) == 0)
					known = True;
			}
			for (i = 0; i < defind; i++) {
				if (strcmp(deftbl[i], tok) == 0)
					foundtrue = True;
			}
		}
	} else {
		uselev[level] = False;
	}
	uselev[level] = known;
	if (offlevel == 0 && known && foundtrue == False) {
		Outputon = 0;
		offlevel = level;
	}

	return (known)? False: True;
}

doelse()
{

	if (uselev[level]) {
		if (offlevel == 0) {
			Outputon = 0;
			offlevel = level;
		} else if (offlevel == level) {
			Outputon = 1;
			offlevel = 0;
		}
		return(False);
	}
	return(True);
}

doendif()
{
	if (uselev[level]) {
		if (offlevel == level) {
			Outputon = 1;
			offlevel = 0;
		}
	}
	level--;
	return(!uselev[level+1]);
}

/*
 * Called to record the fact that the function has a particualar type
 * of argument, ie it uses a window or pixmap etc.
 */
void
defargtype(name, num)
char	*name;
int 	num;
{
char	buf[64];

	if (num > 1) {
		sprintf(buf, "%s%d", name, num);
		name = buf;
	}
	deftbl[defind++] = mcstrdup(name);
}
