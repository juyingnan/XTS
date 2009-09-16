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
* File: xts5/Xopen/keysymdef/TestS.c
* 
* Description:
* 	Tests for keysymdef()
* 
* Modifications:
* $Log: TestS.c,v $
* Revision 1.2  2005-11-03 08:44:00  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:40  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:35:41  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:58:18  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:26:55  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:23:29  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.1  1996/05/09 21:16:18  andy
* Fixed X includes
*
* Revision 4.0  1995/12/15  09:13:56  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  01:17:15  andy
* Prepare for GA Release
*
*/
/*
 *      SCCS:  @(#)  TestS.c Rel 1.1	    (11/28/91)
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

#define XK_SPECIAL
#include	<X11/keysymdef.h>
#undef XK_SPECIAL

kysymdf13()
{ 
int 	pass = 0, fail = 0;
#ifdef XK_blank
	if(test("XK_blank", XK_blank, 0x9DF) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_blank");
	FAIL;
#endif

#ifdef XK_soliddiamond
	if(test("XK_soliddiamond", XK_soliddiamond, 0x9E0) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_soliddiamond");
	FAIL;
#endif

#ifdef XK_checkerboard
	if(test("XK_checkerboard", XK_checkerboard, 0x9E1) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_checkerboard");
	FAIL;
#endif

#ifdef XK_ht
	if(test("XK_ht", XK_ht, 0x9E2) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_ht");
	FAIL;
#endif

#ifdef XK_ff
	if(test("XK_ff", XK_ff, 0x9E3) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_ff");
	FAIL;
#endif

#ifdef XK_cr
	if(test("XK_cr", XK_cr, 0x9E4) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_cr");
	FAIL;
#endif

#ifdef XK_lf
	if(test("XK_lf", XK_lf, 0x9E5) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_lf");
	FAIL;
#endif

#ifdef XK_nl
	if(test("XK_nl", XK_nl, 0x9E8) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_nl");
	FAIL;
#endif

#ifdef XK_vt
	if(test("XK_vt", XK_vt, 0x9E9) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_vt");
	FAIL;
#endif

#ifdef XK_lowrightcorner
	if(test("XK_lowrightcorner", XK_lowrightcorner, 0x9EA) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_lowrightcorner");
	FAIL;
#endif

#ifdef XK_uprightcorner
	if(test("XK_uprightcorner", XK_uprightcorner, 0x9EB) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_uprightcorner");
	FAIL;
#endif

#ifdef XK_upleftcorner
	if(test("XK_upleftcorner", XK_upleftcorner, 0x9EC) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_upleftcorner");
	FAIL;
#endif

#ifdef XK_lowleftcorner
	if(test("XK_lowleftcorner", XK_lowleftcorner, 0x9ED) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_lowleftcorner");
	FAIL;
#endif

#ifdef XK_crossinglines
	if(test("XK_crossinglines", XK_crossinglines, 0x9EE) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_crossinglines");
	FAIL;
#endif

#ifdef XK_horizlinescan1
	if(test("XK_horizlinescan1", XK_horizlinescan1, 0x9EF) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_horizlinescan1");
	FAIL;
#endif

#ifdef XK_horizlinescan3
	if(test("XK_horizlinescan3", XK_horizlinescan3, 0x9F0) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_horizlinescan3");
	FAIL;
#endif

#ifdef XK_horizlinescan5
	if(test("XK_horizlinescan5", XK_horizlinescan5, 0x9F1) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_horizlinescan5");
	FAIL;
#endif

#ifdef XK_horizlinescan7
	if(test("XK_horizlinescan7", XK_horizlinescan7, 0x9F2) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_horizlinescan7");
	FAIL;
#endif

#ifdef XK_horizlinescan9
	if(test("XK_horizlinescan9", XK_horizlinescan9, 0x9F3) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_horizlinescan9");
	FAIL;
#endif

#ifdef XK_leftt
	if(test("XK_leftt", XK_leftt, 0x9F4) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_leftt");
	FAIL;
#endif

#ifdef XK_rightt
	if(test("XK_rightt", XK_rightt, 0x9F5) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_rightt");
	FAIL;
#endif

#ifdef XK_bott
	if(test("XK_bott", XK_bott, 0x9F6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_bott");
	FAIL;
#endif

#ifdef XK_topt
	if(test("XK_topt", XK_topt, 0x9F7) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_topt");
	FAIL;
#endif

#ifdef XK_vertbar
	if(test("XK_vertbar", XK_vertbar, 0x9F8) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_vertbar");
	FAIL;
#endif


	CHECKPASS(24);
}
