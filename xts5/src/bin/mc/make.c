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
* $Header: /cvs/xtest/xtest/xts5/src/bin/mc/make.c,v 1.1 2005-02-12 14:37:14 anderson Exp $
*
* Copyright (c) Applied Testing and Technology, Inc. 1995
* All Rights Reserved.
*
* Project: VSW5
*
* File: src/bin/mc/make.c
*
* Description:
*       routines for mkmf  utilitie
*
* Modifications:
* $Log: make.c,v $
* Revision 1.1  2005-02-12 14:37:14  anderson
* Initial revision
*
* Revision 8.0  1998/12/23 23:24:14  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:42:25  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:16:41  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:13:13  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.2  1997/01/22 22:14:29  andy
* Xt6 section now flagged as not needing Athena
*
* Revision 4.1  1997/01/17  21:43:30  andy
* In getmclistitem, changed comparision from > to >= as this was a bug.
*
* Revision 4.0  1995/12/15  08:41:20  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:38:07  andy
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

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#include "mc.h"

#define MAXNAMES	20
#define MAXMLINES	20
#define	CFILELINELEN	65

extern	struct	state	State;

#define	F_BANNER	"mmbanner.tmc"
#define	F_DEFINES	"mmdefs.tmc"
#define	F_SA		"mmsa.mc"
#define	F_XTSA		"mmxtsa.mc"
#define	F_XTSAA		"mmxtsaa.mc"
#define	F_XCMSSA	"mmxcmssa.mc"
#define	F_MSA		"mmmsa.mc"
#define	F_LINK		"mmlink.mc"
#define	F_MLINK		"mmmlink.mc"
#define	F_LIB		"mmlib.mc"
#define	F_MISC		"mmmisc.mc"
#define	F_PGEN		"mmpgen.mc"
#define	F_XPINIT	"mmxpinit.mc"
#define	F_XTINIT	"mmxtinit.mc"
#define	F_XPLIB		"mmxplib.mc"
#define	F_XTLIB		"mmxtlib.mc"
#define	F_XCMSLIB	"mmxcmslib.mc"
#define	F_DEPS		"mmdeps.tmc"
#define	F_TOP		"mmtop.tmc"

static	FILE	*FpBanner;
static	FILE	*FpDefines;
static	FILE	*FpDepends;
static	FILE	*FpTop;

/*
 * Which parts to include, this is so the makefiles can be made
 * without eg. pixgen, or the library stuff.
 */
static	char	*incwhich = "lLmp";

extern	struct	settings	Settings;
extern	int 	dflag;
extern	int 	lflag;
extern	int 	sflag;
extern	char	*sopt;

void	makename();
void	makeline();

extern	struct	mclist	*Sources;
struct	mclist	*filenames;

/*ARGSUSED*/
void
mmstart(buf)
char	*buf;
{

	/* sections to include */
	if (sflag)
		incwhich = sopt;

	/* Index into files is one more than number of files */
	filenames = createmclist();

	FpBanner = cretmpfile(F_BANNER);
	FpDefines = cretmpfile(F_DEFINES);
	FpDepends = cretmpfile(F_DEPS);
	FpTop = cretmpfile(F_TOP);
}


/*ARGSUSED*/
void
mmend(buf)
char	*buf;
{
char	*lp;
int 	i;
int 	linepos;

	(void) fprintf(FpDefines, "SOURCES=");
	linepos = strlen("SOURCES=");
	for (i = 0; lp = getmclistitem(Sources, i); i++) {
		linepos += strlen(lp);
		if (linepos > CFILELINELEN) {
			(void) fprintf(FpDefines, "\\\n\t");
			linepos = 8;
		}
		(void) fprintf(FpDefines, "%s ", lp);
		
	}
	(void) fprintf(FpDefines, "\n");
	(void) fprintf(FpDefines, "CFILES=Test.c ");
	linepos = strlen("CFILES=Test.c ");
	for (i = 0; lp = getmclistitem(filenames, i); i++) {
		linepos += strlen(lp);
		if (linepos > CFILELINELEN) {
			(void) fprintf(FpDefines, "\\\n\t");
			linepos = 8;
		}
		(void) fprintf(FpDefines, "%s ", lp);
		
	}
	(void) fprintf(FpDefines, "\n");

	(void) fprintf(FpDefines, "OFILES=Test.o ");
	linepos = strlen("OFILES=Test.o ");
	for (i = 0; lp = getmclistitem(filenames, i); i++) {
		linepos += strlen(lp);
		if (linepos > CFILELINELEN) {
			(void) fprintf(FpDefines, "\\\n\t");
			linepos = 8;
		}
		/* Convert to dot-o */
		lp[strlen(lp)-1] = 'o';
		(void) fprintf(FpDefines, "%s ", lp);
		
	}
	(void) fprintf(FpDefines, "\n");

	if (Settings.macro) {
		(void) fprintf(FpDefines, "MOFILES=MTest.o ");
		linepos = strlen("OFILES=MTest.o ");
		for (i = 0; lp = getmclistitem(filenames, i); i++) {
			linepos += strlen(lp);
			if (linepos > CFILELINELEN) {
				(void) fprintf(FpDefines, "\\\n\t");
				linepos = 8;
			}
			/* Convert to dot-o */
			lp[strlen(lp)-1] = 'o';
			(void) fprintf(FpDefines, "%s ", lp);
			
		}
		(void) fprintf(FpDefines, "\n");
	}

	(void) fprintf(FpDefines, "LOFILES=link.o ");
	if (Settings.macro)
		fprintf(FpDefines, "mlink.o ");
	linepos = strlen("LOFILES=link.o ");
	for (i = 0; lp = getmclistitem(filenames, i); i++) {
		linepos += strlen(lp);
		if (linepos > CFILELINELEN) {
			(void) fprintf(FpDefines, "\\\n\t");
			linepos = 8;
		}
		/* Convert to dot-o */
		lp[strlen(lp)-1] = 'o';
		(void) fprintf(FpDefines, "%s ", lp);
	}
	(void) fprintf(FpDefines, "\n");


	(void) fprintf(FpDefines, "LINKOBJ=%s.o\n", name10lc(State.name));
	(void) fprintf(FpDefines, "LINKEXEC=%s\n", name10lc(State.name));

	(void) fprintf(FpDefines, "\n\n");

	/*
	 * Now the makefile is output using the saved information and
	 * the skeleton files.  There are a few variations depending
	 * on whether the test has a macro version or is an X protocol
	 * test.
	 */

	/* The top of the makefile */
	outfile(FpBanner);
	outfile(FpDefines);
	if (State.xproto)
		outcopy(F_XPINIT);
	if (State.xtoolkit)
		outcopy(F_XTINIT);

	outfile(FpTop);

	/* The rules for the standalone tests */
	if (State.xtoolkit) {
		if (State.xtathena)
			outcopy(F_XTSAA);
		else
			outcopy(F_XTSA);
	} else if (State.xcms)
		outcopy(F_XCMSSA);
	else 
	{
		outcopy(F_SA);
		if (Settings.macro)
			outcopy(F_MSA);

		/* Do the combined parts, if they are wanted */
		if (strchr(incwhich, 'l')) 
		{
			outcopy(F_LINK);
			if (Settings.macro)
				outcopy(F_MLINK);
		}
	}

	/* Do the library rules, if they are wanted */
	if (strchr(incwhich, 'L')) {
		if (State.xproto)
			outcopy(F_XPLIB);
		else {
			if (State.xtoolkit)
				outcopy(F_XTLIB);
			else if (State.xcms)
				outcopy(F_XCMSLIB);
			else
				outcopy(F_LIB);
		}
	}

	/* The misc rules, if wanted */
	if (strchr(incwhich, 'm'))
		outcopy(F_MISC);

	/*
	 * We assume here that neither the xproto tests or tests that have
	 * a macro version or use Pixel Generation.
	 * This is true at present.
	 */
	if (!State.xproto && !State.xtoolkit && !State.xcms && !Settings.macro && strchr(incwhich, 'p'))
		outcopy(F_PGEN);

	/* Depends */
	outfile(FpDepends);
}


void
mmcopyright(fp, buf)
FILE	*fp;
char	*buf;
{
int	i;

	while (newline(fp, buf) != NULL && !SECSTART(buf)) {
		i = 0;
		while ((buf[i] == ' ') || (buf[i] == '*') || (buf[i] == '/')) 
			i++;
		if (strlen(&buf[i]) == 0) {
			fputs("# \n", FpBanner);
		}
		else {
			fputs("# ", FpBanner);
			fputs(&buf[i], FpBanner);
		}
	}
}

void
mmheader(fp, buf)
FILE	*fp;
char	*buf;
{
	/*
	 * This is a name of the function that the test is being
	 * built for.
	 */
	if (State.name) {
		(void) fprintf(FpDefines, "#\n# Makefile for %s\n", State.name);
		(void) fprintf(FpDefines, "#\n\n");
	}
	skip(fp, buf);
}

void
mmmake(fp, buf)
FILE	*fp;
char	*buf;
{
	echon(fp, buf, FpTop);
}

void
mmcfiles(fp, buf)
FILE	*fp;
char	*buf;
{
char	*cp;
char	*tok;

	cp = buf+strlen(D_CFILE);
	for (tok = strtok(cp, " \t\n"); tok; tok = strtok((char*)0, " \t\n")) {
		filenames = addmclist(filenames, tok);
	}
	skip(fp, buf);
}

void
mmincstart(name)
char	*name;
{

	/* If this is temp file then don't bother with it */
	if (strcmp(name+strlen(name)-4, ".tmc") == 0)
		return;

	/* If this is a gc or error include then put in a dependency */
	if (strncmp(name, "gc/", 3) == 0 || strncmp(name, "error/", 6) == 0) {
		fprintf(FpDepends, "Test.c link.c: $(XTESTLIBDIR)/%s\n", name);
	} else {
		/* Otherwise put in dependency as it is */
		fprintf(FpDepends, "Test.c link.c: %s\n", name);
	}
}

#define MCLINIT 10	/* Initial number of slots to create */
/*
 * create an mclist structure and initialise it
 */
struct	mclist *
createmclist()
{
struct	mclist	*mclp;

	mclp = (struct mclist *)malloc(sizeof(struct mclist)+MCLINIT*sizeof(char*));
	if (mclp == NULL) {
		(void) fprintf(stderr, "Out of memory\n");
		errexit();
	}

	mclp->num = 0;
	mclp->size = MCLINIT;

	return(mclp);
}

/*
 * Add a string to the list.  The given string will be copied.
 * A pointer to the list is returned, it may have been realloced so
 * it could have changed.
 */
struct	mclist *
addmclist(list, string)
struct	mclist	*list;
char	*string;
{
int 	size;

	if (list->num > list->size) {
		/* Need to alloc more space */
		list->size += MCLINIT;
		size = sizeof(struct mclist) + (list->size-1)*sizeof(char*);
		list = (struct mclist *)realloc((char*)list, (unsigned)size);
		if (list == NULL) {
			(void) fprintf(stderr, "Out of memory\n");
			errexit();
		}
	}

	list->items[list->num++] = mcstrdup(string);

	return(list);
}

/*
 * Get a list string item.
 */
char *
getmclistitem(list, n)
struct mclist *list;
int 	n;
{

	if (n >= list->num)
		return((char*)0);

	return(list->items[n]);
}


