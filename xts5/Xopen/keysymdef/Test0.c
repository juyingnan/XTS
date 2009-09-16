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
* Project: VSW5
* 
* File: xts5/Xopen/keysymdef/Test0.c
* 
* Description:
* 	Tests for keysymdef()
* 
* Modifications:
* $Log: Test0.c,v $
* Revision 1.2  2005-11-03 08:44:00  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:40  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:35:35  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:58:08  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:26:49  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:23:22  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.1  1996/05/09 21:16:18  andy
* Fixed X includes
*
* Revision 4.0  1995/12/15  09:13:38  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  01:16:55  andy
* Prepare for GA Release
*
*/
/*
 *      SCCS:  @(#)  Test0.c Rel 1.2	    (7/17/92)
 *
 *	UniSoft Ltd., London, England
 *
 * (C) Copyright 1991 X/Open Company Limited
 *
 * All rights reserved.  No part of this source code may be reproduced,
 * stored in a retrieval system, or transmitted, in any form or by any
 * means, electronic, mechanical, photocopying, recording or otherwise,
 * except as stated in the end-user licence agreement, without the prior
 * permission of the copyright owners.
 *
 * X/Open and the 'X' symbol are trademarks of X/Open Company Limited in
 * the UK and other countries.
 */

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include        <stdlib.h>
#include        "xtest.h"
#include        "X11/Xlib.h"
#include        "X11/Xutil.h"
#include        "X11/Xresource.h"
#include        "tet_api.h"
#include        "xtestlib.h"
#include        "pixval.h"

extern char	*TestName;

static int
test(name, val, aval)
char	*name;
int	val;
int	aval;
{

	if(val != aval) {
		report("KeySym \"%s\" is defined to have value 0x%x instead of 0x%x.", name, val, aval);
		return(0);
	} 
	return(1);
}



static void
reporterr(s)
char	*s;
{
	report("Keysym \"%s\" is not defined.", s);
}

#define XK_LATIN2
#include      <X11/keysymdef.h>
#undef XK_LATIN2


kysymdf0()
{ 
int	pass = 0, fail = 0;
#ifdef XK_VoidSymbol
	if(test("XK_VoidSymbol", XK_VoidSymbol, 0xFFFFFF) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_VoidSymbol");
	FAIL;
#endif

	CHECKPASS(1);
}
