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
$Header: /cvs/xtest/xtest/xts5/tset/Xlib9/lstfnts/lstfnts.m,v 1.2 2005-11-03 08:43:58 jmichael Exp $

Copyright (c) Applied Testing and Technology, Inc. 1995
All Rights Reserved.

>># Project: VSW5
>># 
>># File: xts5/tset/Xlib9/lstfnts/lstfnts.m
>># 
>># Description:
>># 	Tests for XListFonts()
>># 
>># Modifications:
>># $Log: lstfnts.m,v $
>># Revision 1.2  2005-11-03 08:43:58  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:39  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:30:44  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:49:53  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:22:31  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:19:03  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:00:00  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  00:55:18  andy
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
>>TITLE XListFonts Xlib9
char	**

Display	*display = Dsp;
char	*patternarg;
int 	maxnames = 1000;
int 	*actual_count_return = &Count;
>>SET startup fontstartup
>>SET cleanup fontcleanup
>>EXTERN
#include	<ctype.h>
#include	<string.h>

static	int 	Count;

extern	struct	fontinfo	fontinfo[];
extern	int 	nfontinfo;

static lowerstring(str)
char	*str;
{
	for (; *str; str++) {
		if (isupper(*str))
			tolower(*str);
	}
}
>>ASSERTION Good A
When the
.A patternarg
argument
is a string in ISO Latin-1 encoding terminated with ASCII nul,
then a call to xname returns an array of
strings terminated with ASCII nul which are available font names 
that match the
.A patternarg
argument
and returns the number of fonts in the
.A actual_count_return
argument.
>>STRATEGY
Set patternarg to \"xtfont0\"
Call XListFonts.
Verify that returned count was 1.
Verify that the returned names pointer was non-NULL.
Lower-case the returned string.
Verify that xtfont0 was returned.
>>CODE
char	**names;

	patternarg = "xtfont0";
	names = XCALL;

	if (Count != 1) {
		report("actual_count_return was %d, expecting 1", Count);
		FAIL;
	} else
		CHECK;

	if (names == NULL) {
		report("NULL was returned");
		FAIL;
		return;
	} else
		CHECK;

	lowerstring(*names);
	if (strcmp(*names, patternarg) != 0) {
		report("returned name was '%s', expecting '%s'", *names, patternarg);
		FAIL;
	} else
		CHECK;

	CHECKPASS(3);

>>ASSERTION Good A
Upper and lower case characters in the
.A patternarg
argument refer to the same font.
>>STRATEGY
Try matching with XtFoNt0
Call XListFonts.
Verify that returned count was 1.
Verify that the returned names pointer was non-NULL.
Lower-case the returned string.
Verify that xtfont0 was returned.
>>CODE
char	**names;

	patternarg = "XtFoNt0";
	names = XCALL;

	if (Count != 1) {
		report("actual_count_return was %d, expecting 1", Count);
		FAIL;
	} else
		CHECK;

	if (names == NULL) {
		report("NULL was returned");
		FAIL;
		return;
	} else
		CHECK;

	lowerstring(*names);
	patternarg = "xtfont0";
	if (strcmp(*names, patternarg) != 0) {
		report("returned name was '%s', expecting '%s'", *names, patternarg);
		FAIL;
	} else
		CHECK;

	CHECKPASS(3);
>>ASSERTION Good A
Each asterisk (*) in the string is a wildcard for any number of characters.
>>STRATEGY
Set patternarg to \"x*t*t*\"
Call XListFonts.
Verify that at least all the VSW5 fonts are returned, and
that any other returned string matches the patternarg.
>>CODE
char	**names;
char	*curname;
int 	i;
int 	j;

	patternarg = "x*t*t*";
	names = XCALL;

	if (Count < XT_NFONTS) {
		report("returned count was %d, expecting at least %d", Count,XT_NFONTS);
		FAIL;
	} else
		CHECK;

	if (names == NULL) {
		report("returned name pointer was NULL");
		FAIL;
		return;
	} else
		CHECK;

	for (i = 0; i < Count; i++) {
		curname = names[i];
		lowerstring(curname);
		for (j = 0; j < nfontinfo; j++) {
			if (strcmp(curname, fontinfo[j].name) == 0) {
				/* Check if we have already seen this one */
				if (fontinfo[j].flag) {
					report("name %s repeated in list", curname);
					FAIL;
				} else {
					fontinfo[j].flag++;
					CHECK;
				}
				break;
			}
		}
		if (j == nfontinfo) {
		char	*cp;

			/* It wasn't one of ours... */
			trace("extra font name %s found", curname);
			cp = strchr(curname, 'x');
			if (cp == NULL) {
				report("Found name %s that did not match patternarg");
				FAIL;
			} else if ((cp = strchr(cp, 't')) == NULL) {
				report("Found name %s that did not match patternarg");
				FAIL;
			} else if ((cp = strchr(cp, 't')) == NULL) {
				report("Found name %s that did not match patternarg");
				FAIL;
			} else {
				CHECK;
			}
		}
	}
	for (i = 0; i < nfontinfo; i++) {
		if (fontinfo[i].flag == 0) {
			report("VSW5 font '%s' was not found", fontinfo[i].name);
			FAIL;
		} else {
			/* reset to zero for next test */
			fontinfo[i].flag = 0;
			CHECK;
		}
	}
	CHECKPASS(2+Count+nfontinfo);
>>ASSERTION Good A
Each question mark (?) in the string is a wildcard for a single character.
>>STRATEGY
Set patternarg to \"x?f?nt?\"
Call XListFonts.
Verify that returned count is at least XT_NFONTS
Verify that the VSW5 font names are returned.
Verify that any other name returned matches the patternarg.
>>CODE
char	**names;
char	*curname;
int 	i;
int 	j;

	patternarg = "x?f?nt?";
	names = XCALL;

	if (Count < XT_NFONTS) {
		report("returned count was %d, expecting at least %d", Count,XT_NFONTS);
		FAIL;
	} else
		CHECK;

	if (names == NULL) {
		report("returned name pointer was NULL");
		FAIL;
		return;
	} else
		CHECK;

	for (i = 0; i < Count; i++) {
		curname = names[i];
		lowerstring(curname);
		for (j = 0; j < nfontinfo; j++) {
			if (strcmp(curname, fontinfo[j].name) == 0) {
				/* Check if we have already seen this one */
				/* XXX I am assuming that duplicates are not allowed ??? */
				if (fontinfo[j].flag) {
					report("name %s repeated in list", curname);
					FAIL;
				} else {
					fontinfo[j].flag++;
					CHECK;
				}
				break;
			}
		}
		if (j == nfontinfo) {
		int 	len;

			/* It wasn't one of ours... */
			trace("extra font name %s found", curname);
			len = strlen(patternarg);
			if (strlen(curname) != len) {
				report("name '%s' did not match patternarg");
				FAIL;
			} else {
				for (j = 0; j < len; j++) {
					if (patternarg[j] == '?')
						continue;
					if (curname[j] != patternarg[j]) {
						report("name '%s' did not match patternarg");
						FAIL;
						break;
					}
				}
				if (j == len)
					CHECK;
			}
		}
	}
	for (i = 0; i < nfontinfo; i++) {
		if (fontinfo[i].flag == 0) {
			report("VSW5 font '%s' was not found", fontinfo[i].name);
			FAIL;
		} else {
			/* reset to zero for next test */
			fontinfo[i].flag = 0;
			CHECK;
		}
	}
	CHECKPASS(2+Count+nfontinfo);

>>ASSERTION Good A
The number of fonts returned in the actual_count_return argument will not
exceed maxnames.
>>STRATEGY
Set maxnames to 1
Set patternarg to \"*\"
Verify that only one name was returned.
>>CODE
char	**names;

	maxnames = 1;
	patternarg = "*";

	names = XCALL;

	if (Count > maxnames) {
		report("returned count was %d, not expecting it to exceed %d", Count, maxnames);
		FAIL;
	} else {
		PASS;
	}
>>ASSERTION Bad A
When there are no available font names that match the patternarg argument,
then a call to xname returns NULL.
>>STRATEGY
Set patternarg to a bad name.
Call XListFonts.
Verify that NULL is returned.
>>CODE
char	**names;

	/* Of course if someone deliberately adds such a name.. */
	patternarg = "xtfont non existant name";

	names = XCALL;

	if (names != NULL) {
		report("returned pointer was not NULL");
		FAIL;
	} else
		PASS;

>># HISTORY kieron Completed	Reformat and tidy to ca pass
