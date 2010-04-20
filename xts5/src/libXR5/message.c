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
*
* Copyright Applied Testing and Technology Inc. 1995
* All rights reserved
*
* Project: VSW5
*
* File:	xts5/src/libXR5/message.c
*
* Description:
*	Error message routines
*
* Modifications:
* $Log: message.c,v $
* Revision 1.2  2005-11-03 08:42:02  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:10  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:25:48  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:44:02  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:18:06  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:14:38  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:45:40  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:43:42  andy
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

#include <inttypes.h>
#include <stdio.h>                                   
#include <string.h>
#include <r5structs.h>                                   
#include <r5decl.h>

#define MAX_STR_LEN 255

extern char *buf_next;
extern int  buf_left;
extern struct args regr_args;
extern int over_flow_flg;
extern char ebuf[];

void
message(char *fmtstr, union msglst f_lst[], int f_cnt)
{
	int i;
	static char *buf_over_flow = "\nError buffer overflow. Check BUFFER_SIZE in xtestknobs.dat\n\nEnd of error\
 report\n*********************\n";
	char *fmtptr;
	char *tmpptr;                   
	char *tmpptr1;
	char tmpstr[MAX_STR_LEN+1];        
	char tmpstr1[MAX_STR_LEN+1];
	char char_type;

	fmtptr = &fmtstr[0];
	tmpptr = &tmpstr[0];

	if (f_cnt != 0) 		/* if we have arguments */ 
	{ 			
	    for (i=0; i<f_cnt; i++) {		/* for each argument    */
	 	    while ((tmpptr < &tmpstr[MAX_STR_LEN]) && (*fmtptr != '%') && (*fmtptr != '\0'))
			*tmpptr++ = *fmtptr++;	/* find the percent sign */
		    fmtptr++;	                /* find the type character */
		    char_type = *fmtptr++;	/* save it */
                    tmpptr1 = &tmpstr1[0]; 
		    switch (char_type) {		             
		    case 'd' :
                        (void)sprintf(tmpstr1,"%ld", f_lst[i].typ_dec);
		     	break;
		    case 'o' :
		   	(void)sprintf(tmpstr1,"%lo", f_lst[i].typ_oct);
		    	break;
		    case 'x' :
		    	(void)sprintf(tmpstr1,"%lx", f_lst[i].typ_hex);
		    	break;
		    case 'u' :
		    	(void)sprintf(tmpstr1,"%lu", f_lst[i].typ_uns);
		    	break;
		    case 'c' :
		        (void)sprintf(tmpstr1,"%c", f_lst[i].typ_cha);
		    	break;
		    case 's' :
                        tmpptr1 = f_lst[i].typ_str;
		    	break;
		    case 'f' :			/* this is assumed to be float */
		    	(void)sprintf(tmpstr1,"%f",f_lst[i].typ_flo);
		    	break;
		    case 'e' :			/* this is assumed to be double */
		    	(void)sprintf(tmpstr1,"%e",f_lst[i].typ_dou);
		    	break;
		    case 'a' :			/* this is for addresses - type ADDRESS is regrdef.h */
			(void)sprintf(tmpstr1,"%" PRIuPTR, (uintptr_t)f_lst[i].typ_adr);
			break;
		    default:
		        sprintf(ebuf, "Programming error calling message type %%%c not supported or\n",*fmtptr);
			tet_infoline(ebuf);
			sprintf(ebuf, "argument count is incorrectly specified for format string - A B O R T I N G ...\n");
			tet_infoline(ebuf);
			return;
		    }
                    while ((tmpptr < &tmpstr[MAX_STR_LEN]) && ((*tmpptr++ = *tmpptr1++) != '\0'));
                    	tmpptr--;
	    }
	} /* end if */

	while ((tmpptr < &tmpstr[MAX_STR_LEN]) && (*fmtptr != '\0'))
	    *tmpptr++ = *fmtptr++;
	*tmpptr = '\0';

	if (regr_args.l_flags.bufrout == 0)
	{
		sprintf(ebuf, "%s", tmpstr);
		tet_infoline(ebuf);
	}
	else 
	{				/* buffer the output if there's room */
		if (!over_flow_flg)	
		{	/* if the buffer is not already full */
			if ((buf_left - strlen(tmpstr)) < strlen(buf_over_flow)) 
			{ 
		    		if (over_flow_flg == 0) 
				{
		        		over_flow_flg = 1;
		        		(void)strcpy(buf_next, buf_over_flow);
	       	        		buf_next += strlen(buf_over_flow);
		        		buf_left -= strlen(buf_over_flow);
		    		}
	        	}
	        	else 
			{		
		    		(void)strcpy(buf_next,tmpstr);
		    		buf_next += strlen(tmpstr);
		    		buf_left -= strlen(tmpstr);
	        	}
		}
	}
}
