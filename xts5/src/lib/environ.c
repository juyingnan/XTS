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
* $Header: /cvs/xtest/xtest/xts5/src/lib/environ.c,v 1.1 2005-02-12 14:37:15 anderson Exp $
*
* Copyright Applied Testing and Technology Inc. 1995
* All rights reserved
*
* Project: VSW5
*
* File:	vsw5/src/lib/environ.c
*
* Description:
*	Environment manipulation routines
*
* Modifications:
* $Log: environ.c,v $
* Revision 1.1  2005-02-12 14:37:15  anderson
* Initial revision
*
* Revision 8.0  1998/12/23 23:24:33  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:42:43  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:16:57  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:13:30  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.1  1998/01/13 07:49:00  andy
* Added include of stdlib.h (SR 113).
*
* Revision 4.0  1995/12/15 08:42:13  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:39:24  andy
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
 * Add a string to the environment. This is sourced from the tet api.
 * References to size_t have been removed for maximum portability
 */

#include "xtest.h"

#include "string.h"
#include "stdlib.h"

extern char **environ;

int
xtest_putenv(envstr)
char *envstr;
{
        /*
         * This routine mimics putenv(), and is provided purely
         * because putenv() is not in POSIX.1
         */

        char **newenv, **cur, *envname;
        int n, count = 0;
        static char **allocp = NULL;

        if (environ == NULL)
	{
                newenv = (char **)malloc((2*sizeof(char *)));
                if (newenv == NULL)
                        return -1;

                newenv[0] = envstr;
                newenv[1] = NULL;
                environ = newenv;
                allocp = newenv;
                return 0;
        }

        cur = environ;
        while (*cur != NULL)
        {
                count++;
                envname = *cur;
                n = strcspn(envstr, "=");
                if (strncmp(envname, envstr, n) || envname[n] != '=')
                        cur++;
                else
                {
                        *cur = envstr;
                        return 0;
                }
        }
        /*
         * If we previously allocated this environment enlarge it using
         * realloc(), otherwise allocate a new one and copy it over.
         * Note that only the last malloc()/realloc() pointer is saved, so
         * if environ has since been changed the old space will be wasted.
         */
        if (environ == allocp)
                newenv = (char **) realloc((void *) environ,
                                ((count+2)*sizeof(char *)));
        else
                newenv = (char **) malloc(((count+2)*sizeof(char *)));

        if (newenv == NULL)
                return -1;

        if (environ != allocp)
        {
                for (n = 0; environ[n] != NULL; n++)
                        newenv[n] = environ[n];
                allocp = newenv;
        }
        newenv[count] = envstr;
        newenv[count+1] = NULL;
        environ = newenv;

        return 0;
}

