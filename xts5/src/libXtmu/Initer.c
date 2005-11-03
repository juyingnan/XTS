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
* $Header: /cvs/xtest/xtest/xts5/src/libXtmu/Initer.c,v 1.3 2005-11-03 08:42:02 jmichael Exp $
*
* Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
* All Rights Reserved.
*
* Project: VSW5
*
* File: xts5/src/lib/libXtaw/Initer.c
*
* Description:
*	Subset of libXmu need for VSW5.  Use if implementation does not
*	support Athena.
*
* Modifications:
* $Log: Initer.c,v $
* Revision 1.3  2005-11-03 08:42:02  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.2  2005/04/15 14:32:12  anderson
* Merge basline changes
*
* Revision 1.1  2005/02/12 14:37:15  anderson
* Initial revision
*
* Revision 8.0  1998/12/23 23:26:01  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:44:16  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:18:19  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:14:51  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:46:26  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:44:34  andy
* Prepare for GA Release
*
*/
/* 
 * Copyright 1988, 1989 by the Massachusetts Institute of Technology
 *
 * Permission to use, copy, modify, and distribute this software and its
 * documentation for any purpose and without fee is hereby granted, provided 
 * that the above copyright notice appear in all copies and that both that 
 * copyright notice and this permission notice appear in supporting 
 * documentation, and that the name of M.I.T. not be used in advertising
 * or publicity pertaining to distribution of the software without specific, 
 * written prior permission. M.I.T. makes no representations about the 
 * suitability of this software for any purpose.  It is provided "as is"
 * without express or implied warranty.
 *
 */

/* Created By:  Chris D. Peterson
 *              MIT X Consortium
 * Date:        May 8, 1989
 */

#include <X11/Intrinsic.h>
#include <X11/Xmu/Initer.h>

struct InitializerList {
  XmuInitializerProc function;	/* function to call */
  caddr_t data;			/* Data to pass the function. */
  XtAppContext * app_con_list;	/* a null terminated list of app_contexts. */
};
  
static struct InitializerList * init_list = NULL;
static Cardinal init_list_length = 0;

static Boolean AddToAppconList();

void
XmuAddInitializer(func, data) 
XmuInitializerProc func;
caddr_t data;
{
  init_list_length++;
  init_list = (struct InitializerList *) XtRealloc( (char *) init_list, 
					    (sizeof(struct InitializerList) * 
					     init_list_length) );

  init_list[init_list_length - 1].function = func;
  init_list[init_list_length - 1].data = data;
  init_list[init_list_length - 1].app_con_list = NULL;
}

void
XmuCallInitializers(app_con)
XtAppContext app_con;
{
  int i;

  for (i = 0 ; i < init_list_length ; i++) {
    if (AddToAppconList(&(init_list[i].app_con_list), app_con))
      (init_list[i].function) (app_con, init_list[i].data);
  }
}

/*	Function Name: AddToAppconList
 *	Description: Adds an action to the application context list and
 *                   returns TRUE, if this app_con is already on the list then
 *                   it is NOT added and FALSE is returned.
 *	Arguments: app_list - a NULL terminated list of application contexts.
 *                 app_con - an application context to test.
 *	Returns: TRUE if not found, FALSE if found.
 */

static Boolean
AddToAppconList(app_list, app_con)
XtAppContext **app_list, app_con;
{
  int i;
  XtAppContext *local_list;

  i = 0;
  local_list = *app_list;
  if (*app_list != NULL) {
    for ( ; *local_list != NULL ; i++, local_list++) {
      if (*local_list == app_con)
	return(FALSE);
    }
  }

  *app_list = (XtAppContext *)  XtRealloc((char *)(*app_list),
					  sizeof(XtAppContext *) * (i + 2) );
  (*app_list)[i++] = app_con;
  (*app_list)[i] = NULL;
  return(TRUE);
}
  
