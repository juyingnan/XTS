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
* $Header: /cvs/xtest/xtest/xts5/tset/Xopen/kysymdf/TestL.c,v 1.2 2005-11-03 08:44:00 jmichael Exp $
* 
* Project: VSW5
* 
* File: xts5/tset/Xopen/kysymdf/TestL.c
* 
* Description:
* 	Tests for keysymdef()
* 
* Modifications:
* $Log: TestL.c,v $
* Revision 1.2  2005-11-03 08:44:00  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:40  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:35:40  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:58:15  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:26:54  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:23:27  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.1  1996/05/09 21:16:18  andy
* Fixed X includes
*
* Revision 4.0  1995/12/15  09:13:52  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  01:17:10  andy
* Prepare for GA Release
*
*/
/*
 *      SCCS:  @(#)  TestL.c Rel 1.1	    (11/28/91)
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

#define XK_APL
#include	<X11/keysymdef.h>
#undef XK_APL

kysymdf10()
{ 
int 	pass = 0, fail = 0;
#ifdef XK_leftcaret
	if(test("XK_leftcaret", XK_leftcaret, 0xBA3) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_leftcaret");
	FAIL;
#endif

#ifdef XK_rightcaret
	if(test("XK_rightcaret", XK_rightcaret, 0xBA6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_rightcaret");
	FAIL;
#endif

#ifdef XK_downcaret
	if(test("XK_downcaret", XK_downcaret, 0xBA8) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_downcaret");
	FAIL;
#endif

#ifdef XK_upcaret
	if(test("XK_upcaret", XK_upcaret, 0xBA9) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_upcaret");
	FAIL;
#endif

#ifdef XK_overbar
	if(test("XK_overbar", XK_overbar, 0xBC0) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_overbar");
	FAIL;
#endif

#ifdef XK_downtack
	if(test("XK_downtack", XK_downtack, 0xBC2) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_downtack");
	FAIL;
#endif

#ifdef XK_upshoe
	if(test("XK_upshoe", XK_upshoe, 0xBC3) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_upshoe");
	FAIL;
#endif

#ifdef XK_downstile
	if(test("XK_downstile", XK_downstile, 0xBC4) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_downstile");
	FAIL;
#endif

#ifdef XK_underbar
	if(test("XK_underbar", XK_underbar, 0xBC6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_underbar");
	FAIL;
#endif

#ifdef XK_jot
	if(test("XK_jot", XK_jot, 0xBCA) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_jot");
	FAIL;
#endif

#ifdef XK_quad
	if(test("XK_quad", XK_quad, 0xBCC) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_quad");
	FAIL;
#endif

#ifdef XK_uptack
	if(test("XK_uptack", XK_uptack, 0xBCE) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_uptack");
	FAIL;
#endif

#ifdef XK_circle
	if(test("XK_circle", XK_circle, 0xBCF) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_circle");
	FAIL;
#endif

#ifdef XK_upstile
	if(test("XK_upstile", XK_upstile, 0xBD3) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_upstile");
	FAIL;
#endif

#ifdef XK_downshoe
	if(test("XK_downshoe", XK_downshoe, 0xBD6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_downshoe");
	FAIL;
#endif

#ifdef XK_rightshoe
	if(test("XK_rightshoe", XK_rightshoe, 0xBD8) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_rightshoe");
	FAIL;
#endif

#ifdef XK_leftshoe
	if(test("XK_leftshoe", XK_leftshoe, 0xBDA) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_leftshoe");
	FAIL;
#endif

#ifdef XK_lefttack
	if(test("XK_lefttack", XK_lefttack, 0xBDC) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_lefttack");
	FAIL;
#endif

#ifdef XK_righttack
	if(test("XK_righttack", XK_righttack, 0xBFC) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_righttack");
	FAIL;
#endif


	CHECKPASS(19);
}
