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
* File: src/bin/mc/error.c
*
* Description:
*       error handling routines for mc utilities
*
* Modifications:
* $Log: error.c,v $
* Revision 1.1  2005-02-12 14:37:14  anderson
* Initial revision
*
* Revision 8.0  1998/12/23 23:24:11  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:42:22  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:16:38  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:13:11  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:41:12  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:37:52  andy
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


#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <stdio.h>
#include <string.h>

#include "mc.h"

extern	struct	state	State;

static	char	*elist[] = {
	"Access grab", "EAcc1.mc",
	"Access colormap-free", "EAcc2.mc",
	"Access colormap-store", "EAcc3.mc",
	"Access acl", "EAcc4.mc",
	"Access select", "EAcc5.mc",
	"Alloc", "EAll.mc",
	"Atom", "EAto.mc",
	"Color", "ECol.mc",
	"Cursor", "ECur.mc",
	"Drawable", "EDra.mc",
	"Font bad-fontable", "EFon2.mc",
	"Font bad-font", "EFon1.mc",
	"GC", "EGC.mc",
	"Match inputonly", "EMat1.mc",
	"Match gc-drawable-depth", "EMat2.mc",
	"Match gc-drawable-screen", "EMat3.mc",
	"Match wininputonly", "EMat4.mc",
	"Name font", "ENam1.mc",
	"Name colour", "ENam2.mc",
	"Pixmap", "EPix.mc",
	"Value", "EVal.mc",
	"Window", "EWin.mc",
	(char*)0
};

#define	MAXALTS	128

static	char	errfile[32];
static	char	*Alts[MAXALTS];
static	int 	Nalts;

errtext(buf)
char	*buf;
{
char	**mp;
char	*savline;
char	*type;
char	*strtok();
static	char	*sep = " ,\t";

	State.err = ER_NORM;

	type = buf+3;
	if (type[strlen(type)-1] == '\n')
		type[strlen(type)-1] = '\0';

	while (type[0] == ' ' || type[0] == '\t')
		type++;

	/* Skip over any initial 'Bad' */
	if (strncmp(type, "Bad", 3) == 0)
		type += 3;

	for (mp = elist; *mp; mp++) {
		if (strncmp(*mp, type, strlen(*mp)) == 0)
		    break;
	}

	if (*mp == NULL) {
		err("Bad .ER error code");
		fprintf(stderr, " (%s)\n", type);
		errexit();
	}


	/*
	 * This is only used on BadPixmap etc. but we do it for all.
	 */
	savline = mcstrdup(type);
	Alts[0] = strtok(savline, sep);
	for (Nalts = 1; Nalts < MAXALTS; Nalts++) {
		if ((Alts[Nalts] = strtok((char*)0, sep)) == NULL)
			break;
	}

	strcpy(errfile, "error/");
	strcat(errfile, *(mp+1));

	/* BadValue is a special case to be dealt with */
	if (strncmp(type, "Value", 5) == 0) {
		valerror(buf);
	} else {
		State.abortafter = 1;
		includefile(errfile, buf);
	}
}

static int 	wasmasktype;

valerror(buf)
char	*buf;
{
int 	i;
FILE	*fp;
char	*tmpfile;

	State.err = ER_VALUE;

	fp = cretmpfile(F_TVAL, &tmpfile);

	fprintf(fp, ">>ASSERTION Bad A\n");
	fprintf(fp, "When the value of\n.A %s\n", Alts[1]);

	i = 2;
	if (strcmp(Alts[i], "mask") == 0) {
		wasmasktype = 1;
		i++;
	} else
		wasmasktype = 0;

	if (wasmasktype)
		fprintf(fp, "is not a bitwise combination of\n");
	else
		fprintf(fp, "is other than\n");

	for (; i < Nalts; i++) {
		fprintf(fp, ".S %s", Alts[i]);
		if (i == Nalts-2)
			fprintf(fp, "%s", "\nor\n");
		else
			fprintf(fp, "%s", " ,\n");
	}

	fprintf(fp, "then a\n.S BadValue\nerror occurs.\n");

	fprintf(fp, ">>EXTERN\n\n");
	fprintf(fp, "/* Value list for use in test t%03d */\n", State.assertion+1);
	fprintf(fp, "static %s	%svallist[] = {\n",
		wasmasktype? "unsigned long": "int ", Alts[1]);


	for (i = (wasmasktype)? 3: 2; i < Nalts; i++) {
		fprintf(fp, "\t%s,\n", Alts[i]);
	}

	fprintf(fp, "};\n\n");
	fclose(fp);

	includefile(tmpfile, buf);
}

valerrdefs()
{
char	line[MAXLINE];

	/*
	 * Do the define bits.
	 */
	line[0] = '\0';
	strcat(line, "#undef\tVALUE_ARG\n");
	sprintf(line+strlen(line), "#define\tVALUE_ARG %s\n", Alts[1]);
	strcat(line, "#undef\tVALUE_LIST\n");
	sprintf(line+strlen(line), "#define\tVALUE_LIST %svallist\n", Alts[1]);
	sprintf(line+strlen(line), "#undef NOTMEMTYPE\n");
	sprintf(line+strlen(line), "#define NOTMEMTYPE %s\n",
		(wasmasktype)? "unsigned": "");
	strcat(line, "#undef\tNOTMEMBER\n");
	if (wasmasktype)
		strcat(line, "#define\tNOTMEMBER notmaskmember\n");
	else
		strcat(line, "#define\tNOTMEMBER notmember\n");

	putbackline(line);
}


/*
 * List out all the alternatives that have been defined for this error.
 * This allows you to do things like 'a valid Pixmap or None'.
 */
erralternates(out)
char	*out;
{
int 	i;
char	*word;

	*out = '\0';
	for (i = 0; i < Nalts; i++) {
		word = Alts[i];
		strcat(out, word);

		if (i < Nalts-2)
			strcat(out, ",\n.S ");
		if (i == Nalts-2)
			strcat(out, "\nor\n.S ");
	}
	if (Nalts > 1)
		strcat(out, " ");
	strcat(out, ",\n");

	return(strlen(out));
}

/*
 * If there has not been any user supplied code then use the default
 * error code in the file.
 */
errcode(bp)
char	*bp;
{
	if (State.err != ER_VALUE)
		State.skipsec = 2;
	includefile(errfile, bp);
}

