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
* $Header: /cvs/xtest/xtest/xts5/src/xim/parse.c,v 1.1 2005-02-12 14:37:16 anderson Exp $
*
* Copyright (c) Applied Testing and Technology, Inc. 1995
* All Rights Reserved.
*
* Project: VSW5
*
* File: src/bin/xim/parse.c
*
* Description:
*       Input Method tests' library routines
*
* Modifications:
* $Log: parse.c,v $
* Revision 1.1  2005-02-12 14:37:16  anderson
* Initial revision
*
* Revision 8.0  1998/12/23 23:25:25  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:43:39  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:17:46  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:14:18  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.1  1996/01/25 01:59:23  andy
* Portability improvements from DEPLOY tools
*
* Revision 4.0  1995/12/15  08:44:44  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:42:30  andy
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

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <stdio.h>
#include <string.h>

#include	"X11/Xlib.h"

#define MAXIDLEN 32

Bool parse_skwhite(ppstr)
	char **ppstr;
{
	Bool ret;
	char *pstr;

	pstr = *ppstr;
	while((*pstr != '\0') && isspace(*pstr))
		pstr++;
	
	ret = (pstr == *ppstr) ? False : True;
	*ppstr = pstr;	
	return(ret);
}


Bool parse_getid(ppstr,pid,upit)
	char **ppstr;
	char *pid;
	Bool upit;
{
	Bool ret;
	char *pstr;
	int cnt;

	pstr = *ppstr;
	
	cnt = 0;
	while((*pstr != '\0') && (cnt < MAXIDLEN) && 
		  (isalnum(*pstr) || *pstr == '_' || *pstr == '.'))
	{
		cnt++;
		if(upit)
		{
			if(islower(*pstr))
				*pid = *pstr - 'a' + 'A';
			else
				*pid = *pstr;
		}
		else
			*pid = *pstr;
		pstr++;	
		pid++;	
	}

	*pid = '\0';	
	ret = (*ppstr == pstr) ? False : True;
	*ppstr = pstr;
	return(ret);
}

Bool parse_getnum(ppstr,pnum)
	char **ppstr;
	int *pnum;
{
	Bool ret;
	char *pstr;
	int num,sign,digit;

	pstr = *ppstr;
	sign = 1;
	if(*pstr == '-')
	{
		sign = -1;
		pstr++;
	}
	else if(*pstr == '+')
		pstr++;

	num = 0;
	while((*pstr != '\0') && (isdigit(*pstr)))
	{
		digit = *pstr - '0';
		num = num * 10 + digit;
		pstr++;	
	}

	num *= sign;
	*pnum = num;
	ret = (*ppstr == pstr) ? False : True;
	*ppstr = pstr;
	return(ret);
}

Bool parse_gethex(ppstr,pnum)
	char **ppstr;
	int *pnum;
{
	Bool ret;
	char *pstr;
	int num,sign,digit;

	pstr = *ppstr;
	sign = 1;
	if(*pstr == '-')
	{
		sign = -1;
		pstr++;
	}
	else if(*pstr == '+')
		pstr++;

	num = 0;
	while((*pstr != '\0') && (isxdigit(*pstr)))
	{
		if(*pstr >= 'a' && *pstr <= 'f')
			digit = *pstr - 'a' + 10;
		else if(*pstr >= 'A' && *pstr <= 'F')
			digit = *pstr - 'A' + 10;
		else
			digit = *pstr - '0';
		num = num * 16 + digit;
		pstr++;	
	}

	num *= sign;
	*pnum = num;
	ret = (*ppstr == pstr) ? False : True;
	*ppstr = pstr;
	return(ret);
}

int
parse_find_key(id,keys,cnt)
    char *id;           /*IN:  keyword to search for */
    char *keys[];       /*IN:  list of legal keys to search */
    int cnt;            /*IN:  number of keys in the list */
{
    int i;

    for(i=0;i<cnt;i++)
    {
        if(strcmp(id,keys[i]) == 0)
            return(i);
    }
    return(-1);
}
