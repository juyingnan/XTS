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
* File: src/bin/xim/nextlclmod.c
*
* Description:
*       Input Method tests' library routines
*
* Modifications:
* $Log: nextlclmod.c,v $
* Revision 1.1  2005-02-12 14:37:16  anderson
* Initial revision
*
* Revision 8.0  1998/12/23 23:25:24  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:43:37  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.1  1998/07/31 16:00:16  andy
* Added include of stdlib.h
*
* Revision 6.0  1998/03/02 05:17:44  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:14:16  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.1  1996/01/25 01:59:23  andy
* Portability improvements from DEPLOY tools
*
* Revision 4.0  1995/12/15  08:44:40  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:42:26  andy
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

Copyright (c) 1993  X Consortium

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


Copyright 1993 by Sun Microsystems, Inc. Mountain View, CA.

                  All Rights Reserved

Permission  to  use,  copy,  modify,  and  distribute   this
software  and  its documentation for any purpose and without
fee is hereby granted, provided that the above copyright no-
tice  appear  in all copies and that both that copyright no-
tice and this permission notice appear in  supporting  docu-
mentation,  and  that the name of Sun not be used in
advertising or publicity pertaining to distribution  of  the
software  without specific prior written permission. Sun 
makes no representations about the suitability of this
software for any purpose. It is provided "as is" without any
express or implied warranty.

SUN DISCLAIMS ALL WARRANTIES WITH REGARD TO  THIS  SOFTWARE,
INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FIT-
NESS FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL SUN BE  LI-
ABLE  FOR  ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR
ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE,  DATA  OR
PROFITS,  WHETHER  IN  AN  ACTION OF CONTRACT, NEGLIGENCE OR
OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION  WITH
THE USE OR PERFORMANCE OF THIS SOFTWARE.
*/

/*
 * Functions to cycle through all the locale modifiers that are supported.
 */

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include	<stdlib.h>
#include	<stdio.h>
#include	<string.h>
#include	"xtest.h"
#include	<X11/Xlib.h>
#include	<X11/Xutil.h>
#include	<X11/Xresource.h>
#include	"xtestlib.h"
#include	"tet_api.h"
#include	"pixval.h"
#include 	"ximtest.h"

Display	*Dsp;

static	int 	CurLclMod = 0;
static	int		NumLclMod = 0;

#define MAX_LOCALE_MODS		32

static	char *lclmod_strs[MAX_LOCALE_MODS];

/* Start again at the beginning of the list of locale modifiers */
void
resetlclmod()
{
	char *pstr,*npstr;
	int i,nchars;
	char str[MAXLINELEN];

	CurLclMod = 0;
	if(NumLclMod > 0)
		return;			/* already read 'em in */

	for(i=0;i<MAX_LOCALE_MODS;i++)
		lclmod_strs[i] = NULL;

	/* build an array of locales from the ximconfig struct */
	pstr = ximconfig.locale_modifiers;
	if(pstr == NULL)
	{
		delete("No Locale modifiers specified");
		return;
	}

	/* the locale modifiers are of the form: */
	/* @category=value@category=value... */
	/* several sets of modifiers can be specified by seperating */
	/* the modifiers by commas  ie: */
	/* @c1=v1@c2=v2,@c11=v11,@c21=v21@c22=v22@c23=v23 */
	NumLclMod =0;
	while(*pstr != '\0')
	{
		npstr = pstr;
		nchars = 0;
		/* skip white space */
		while((*npstr != 0) && ((*npstr == ' ') || (*npstr == '\t'))) 
			npstr++;
		while((*npstr != '\0') && (*npstr != ';') && (*npstr != ',') &&
			  (*npstr != ' ') && (*npstr != '\t'))
		{
			npstr++;
			nchars++;
		}
		if(nchars > 0)
		{
			if(NumLclMod >= MAX_LOCALE_MODS)
			{
				sprintf(str,"Too many locale modifiers (max supported is %d)",
					MAX_LOCALE_MODS);
				delete(str);
			}
			lclmod_strs[NumLclMod] = (char *)malloc(nchars+1);
			strncpy(lclmod_strs[NumLclMod],pstr,nchars);
			lclmod_strs[NumLclMod][nchars] = '\0';
			NumLclMod++;
		}
		pstr = npstr;
		if(*npstr != '\0')
			pstr++;
	}

	/* maybe 'C' locale should be assumed? */
	if(NumLclMod == 0)
		delete("No Locales found");
}

/*
 * Get the next locale modifier 
 * Returns False if there is one, otherwise True.
 */
int
nextlclmod(lclmod)
	char **lclmod;
{
	/* cycle through the list of locale modifiers from the config file. */
	if(CurLclMod >= NumLclMod)
		return(False);
	
	*lclmod = lclmod_strs[CurLclMod++]; 
	trace("--- Running test with locale modifiers %s", *lclmod);
	return(True);
}

/*
 * Returns the number of times that nextlclmod will succeed. Only valid
 * after a call to resetlclmod().
 */
int
nlclmod()
{
	return(NumLclMod);
}
