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
* $Header: /cvs/xtest/xtest/xts5/src/libXR5/item.c,v 1.2 2005-11-03 08:42:02 jmichael Exp $
*
* Copyright Applied Testing and Technology Inc. 1995
* All rights reserved
*
* Project: VSW5
*
* File:	xts5/src/libXR5/item.c
*
* Description:
*	Routines to check actual and expected values.
*
* Modifications:
* $Log: item.c,v $
* Revision 1.2  2005-11-03 08:42:02  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:10  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:25:47  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:44:02  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:18:05  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:14:37  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:45:39  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:43:40  andy
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
#include <r5structs.h>
#include <r5decl.h>

extern int errflg;

void check_dec(exp, rec, item_name)
long exp, rec;
char *item_name;
{
    if (exp != rec)
    {
    	union msglst f_lst[3];
	f_lst[0].typ_str = item_name;
	f_lst[1].typ_dec = exp;
	f_lst[2].typ_dec = rec;
	message("ERROR: Expected %s of %d, received %d\n", f_lst, 3);
	errflg = 1;
    }
}

void check_flo(exp, rec, item_name)
float exp, rec;
char *item_name;
{
    if (exp != rec)
    {
    	union msglst f_lst[3];
	f_lst[0].typ_str = item_name;
	f_lst[1].typ_flo = exp;
	f_lst[2].typ_flo = rec;
	message("ERROR: Expected %s of %f, received %f\n", f_lst, 3);
	errflg = 1;
    }
}

void check_dou(exp, rec, item_name)
double exp, rec;
char *item_name;
{
    if (exp != rec)
    {
    	union msglst f_lst[3];
	f_lst[0].typ_str = item_name;
	f_lst[1].typ_dou = exp;
	f_lst[2].typ_dou = rec;
	message("ERROR: Expected %s of %e, received %e\n", f_lst, 3);
	errflg = 1;
    }
}

void check_oct(exp, rec, item_name)
long exp, rec;
char *item_name;
{
    if (exp != rec)
    {
    	union msglst f_lst[3];
	f_lst[0].typ_str = item_name;
	f_lst[1].typ_oct = exp;
	f_lst[2].typ_oct = rec;
	message("ERROR: Expected %s of %o, received %o\n", f_lst, 3);
	errflg = 1;
    }
}

void check_hex(exp, rec, item_name)
long exp, rec;
char *item_name;
{
    if (exp != rec)
    {
    	union msglst f_lst[3];
	f_lst[0].typ_str = item_name;
	f_lst[1].typ_hex = exp;
	f_lst[2].typ_hex = rec;
	message("ERROR: Expected %s of %x, received %x\n", f_lst, 3);
	errflg = 1;
    }
}

void check_uns(exp, rec, item_name)
unsigned long exp, rec;
char *item_name;
{
    if (exp != rec)
    {
    	union msglst f_lst[3];
	f_lst[0].typ_str = item_name;
	f_lst[1].typ_uns = exp;
	f_lst[2].typ_uns = rec;
	message("ERROR: Expected %s of %u, received %u\n", f_lst, 3);
	errflg = 1;
    }
}

void check_cha(exp, rec, item_name)
char exp, rec;
char *item_name;
{
    if (exp != rec)
    {
    	union msglst f_lst[3];
	f_lst[0].typ_str = item_name;
	f_lst[1].typ_cha = exp;
	f_lst[2].typ_cha = rec;
	message("ERROR: Expected %s of %c, received %c\n", f_lst, 3);
	errflg = 1;
    }
}

void check_adr(char *exp, char *rec, char *item_name)
{
    if (exp != rec)
    {
    	union msglst f_lst[3];
	f_lst[0].typ_str = item_name;
	f_lst[1].typ_adr = (char *)exp;
	f_lst[2].typ_adr = (char *)rec;
	message("ERROR: Expected %s of %a, received %a\n", f_lst, 3);
	errflg = 1;
    }
}

void check_str(exp, rec, item_name)
char *exp, *rec;
char *item_name;
{
    union msglst f_lst[3];
    if (&exp[0] == 0) 
    {
        if (&rec[0] != 0)
        {
	    f_lst[0].typ_str = item_name;
   	    f_lst[1].typ_str = rec;
	    message("ERROR: Expected %s of null address string, received %s\n", f_lst, 2);
	    errflg = 1;
        }
    }
    else if (&rec[0] == 0)
    {
	f_lst[0].typ_str = item_name;
	f_lst[1].typ_str = exp;
	message("ERROR: Expected %s of '%s', received null address string\n", f_lst, 2);
	errflg = 1;
    }
    else if (strcmp(&exp[0], &rec[0]) != 0)
    {
	f_lst[0].typ_str = item_name;
	f_lst[1].typ_str = exp;
	f_lst[2].typ_str = rec;
	message("ERROR: Expected %s of '%s', received '%s'\n", f_lst, 3);
	errflg = 1;
    }
}

 
void check_strn (exp, rec, len, item_name)
char   *exp,
       *rec;
int    len;
char   *item_name;      
{
    union msglst f_lst[4];
    if (&exp[0] == 0) 
    {
        if (&rec[0] != 0)
        {
	    f_lst[0].typ_str = item_name;
   	    f_lst[1].typ_str = rec;
	    message("ERROR: Expected %s of null address string, received %s\n", f_lst, 2);
	    errflg = 1;
        }
    }
    else if (&rec[0] == 0)
    {
	f_lst[0].typ_str = item_name;
	f_lst[1].typ_str = exp;
	message("ERROR: Expected %s of '%s', received null address string\n", f_lst, 2);
	errflg = 1;
    }
    else if (strncmp (&exp[0], &rec[0], len) != 0)
    {
	f_lst[0].typ_str = item_name;
	f_lst[1].typ_str = exp;
	f_lst[2].typ_str = rec;
        f_lst[3].typ_dec = len;
	message ("ERROR: Expected %s of '%s', received '%s', based on length %d\n", f_lst, 4);
	errflg = 1;
    }
}
 

