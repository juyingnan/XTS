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
* File: xts5/tset/Xopen/keysymdef/TestH.c
* 
* Description:
* 	Tests for keysymdef()
* 
* Modifications:
* $Log: TestH.c,v $
* Revision 1.2  2005-11-03 08:44:00  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:40  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:35:39  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:58:14  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:26:53  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:23:26  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.1  1996/05/09 21:16:18  andy
* Fixed X includes
*
* Revision 4.0  1995/12/15  09:13:49  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  01:17:07  andy
* Prepare for GA Release
*
*/
/*
 *      SCCS:  @(#)  TestH.c Rel 1.1	    (11/28/91)
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

#define XK_HEBREW
#include	<X11/keysymdef.h>
#undef XK_HEBREW 

kysymdf8()
{ 
int 	pass = 0, fail = 0;
#ifdef XK_hebrew_doublelowline
	if(test("XK_hebrew_doublelowline", XK_hebrew_doublelowline, 0xCDF) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_hebrew_doublelowline");
	FAIL;
#endif

#ifdef XK_hebrew_aleph
	if(test("XK_hebrew_aleph", XK_hebrew_aleph, 0xCE0) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_hebrew_aleph");
	FAIL;
#endif

#ifdef XK_hebrew_bet
	if(test("XK_hebrew_bet", XK_hebrew_bet, 0xCE1) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_hebrew_bet");
	FAIL;
#endif

#ifdef XK_hebrew_beth
	if(test("XK_hebrew_beth", XK_hebrew_beth, 0xCE1) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_hebrew_beth");
	FAIL;
#endif

#ifdef XK_hebrew_gimel
	if(test("XK_hebrew_gimel", XK_hebrew_gimel, 0xCE2) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_hebrew_gimel");
	FAIL;
#endif

#ifdef XK_hebrew_gimmel
	if(test("XK_hebrew_gimmel", XK_hebrew_gimmel, 0xCE2) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_hebrew_gimmel");
	FAIL;
#endif

#ifdef XK_hebrew_dalet
	if(test("XK_hebrew_dalet", XK_hebrew_dalet, 0xCE3) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_hebrew_dalet");
	FAIL;
#endif

#ifdef XK_hebrew_daleth
	if(test("XK_hebrew_daleth", XK_hebrew_daleth, 0xCE3) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_hebrew_daleth");
	FAIL;
#endif

#ifdef XK_hebrew_he
	if(test("XK_hebrew_he", XK_hebrew_he, 0xCE4) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_hebrew_he");
	FAIL;
#endif

#ifdef XK_hebrew_waw
	if(test("XK_hebrew_waw", XK_hebrew_waw, 0xCE5) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_hebrew_waw");
	FAIL;
#endif

#ifdef XK_hebrew_zain
	if(test("XK_hebrew_zain", XK_hebrew_zain, 0xCE6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_hebrew_zain");
	FAIL;
#endif

#ifdef XK_hebrew_zayin
	if(test("XK_hebrew_zayin", XK_hebrew_zayin, 0xCE6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_hebrew_zayin");
	FAIL;
#endif

#ifdef XK_hebrew_chet
	if(test("XK_hebrew_chet", XK_hebrew_chet, 0xCE7) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_hebrew_chet");
	FAIL;
#endif

#ifdef XK_hebrew_het
	if(test("XK_hebrew_het", XK_hebrew_het, 0xCE7) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_hebrew_het");
	FAIL;
#endif

#ifdef XK_hebrew_tet
	if(test("XK_hebrew_tet", XK_hebrew_tet, 0xCE8) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_hebrew_tet");
	FAIL;
#endif

#ifdef XK_hebrew_teth
	if(test("XK_hebrew_teth", XK_hebrew_teth, 0xCE8) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_hebrew_teth");
	FAIL;
#endif

#ifdef XK_hebrew_yod
	if(test("XK_hebrew_yod", XK_hebrew_yod, 0xCE9) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_hebrew_yod");
	FAIL;
#endif

#ifdef XK_hebrew_finalkaph
	if(test("XK_hebrew_finalkaph", XK_hebrew_finalkaph, 0xCEA) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_hebrew_finalkaph");
	FAIL;
#endif

#ifdef XK_hebrew_kaph
	if(test("XK_hebrew_kaph", XK_hebrew_kaph, 0xCEB) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_hebrew_kaph");
	FAIL;
#endif

#ifdef XK_hebrew_lamed
	if(test("XK_hebrew_lamed", XK_hebrew_lamed, 0xCEC) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_hebrew_lamed");
	FAIL;
#endif

#ifdef XK_hebrew_finalmem
	if(test("XK_hebrew_finalmem", XK_hebrew_finalmem, 0xCED) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_hebrew_finalmem");
	FAIL;
#endif

#ifdef XK_hebrew_mem
	if(test("XK_hebrew_mem", XK_hebrew_mem, 0xCEE) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_hebrew_mem");
	FAIL;
#endif

#ifdef XK_hebrew_finalnun
	if(test("XK_hebrew_finalnun", XK_hebrew_finalnun, 0xCEF) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_hebrew_finalnun");
	FAIL;
#endif

#ifdef XK_hebrew_nun
	if(test("XK_hebrew_nun", XK_hebrew_nun, 0xCF0) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_hebrew_nun");
	FAIL;
#endif

#ifdef XK_hebrew_samech
	if(test("XK_hebrew_samech", XK_hebrew_samech, 0xCF1) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_hebrew_samech");
	FAIL;
#endif

#ifdef XK_hebrew_samekh
	if(test("XK_hebrew_samekh", XK_hebrew_samekh, 0xCF1) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_hebrew_samekh");
	FAIL;
#endif

#ifdef XK_hebrew_ayin
	if(test("XK_hebrew_ayin", XK_hebrew_ayin, 0xCF2) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_hebrew_ayin");
	FAIL;
#endif

#ifdef XK_hebrew_finalpe
	if(test("XK_hebrew_finalpe", XK_hebrew_finalpe, 0xCF3) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_hebrew_finalpe");
	FAIL;
#endif

#ifdef XK_hebrew_pe
	if(test("XK_hebrew_pe", XK_hebrew_pe, 0xCF4) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_hebrew_pe");
	FAIL;
#endif

#ifdef XK_hebrew_finalzade
	if(test("XK_hebrew_finalzade", XK_hebrew_finalzade, 0xCF5) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_hebrew_finalzade");
	FAIL;
#endif

#ifdef XK_hebrew_finalzadi
	if(test("XK_hebrew_finalzadi", XK_hebrew_finalzadi, 0xCF5) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_hebrew_finalzadi");
	FAIL;
#endif

#ifdef XK_hebrew_zade
	if(test("XK_hebrew_zade", XK_hebrew_zade, 0xCF6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_hebrew_zade");
	FAIL;
#endif

#ifdef XK_hebrew_zadi
	if(test("XK_hebrew_zadi", XK_hebrew_zadi, 0xCF6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_hebrew_zadi");
	FAIL;
#endif

#ifdef XK_hebrew_qoph
	if(test("XK_hebrew_qoph", XK_hebrew_qoph, 0xCF7) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_hebrew_qoph");
	FAIL;
#endif

#ifdef XK_hebrew_kuf
	if(test("XK_hebrew_kuf", XK_hebrew_kuf, 0xCF7) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_hebrew_kuf");
	FAIL;
#endif

#ifdef XK_hebrew_resh
	if(test("XK_hebrew_resh", XK_hebrew_resh, 0xCF8) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_hebrew_resh");
	FAIL;
#endif

#ifdef XK_hebrew_shin
	if(test("XK_hebrew_shin", XK_hebrew_shin, 0xCF9) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_hebrew_shin");
	FAIL;
#endif

#ifdef XK_hebrew_taw
	if(test("XK_hebrew_taw", XK_hebrew_taw, 0xCFA) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_hebrew_taw");
	FAIL;
#endif

#ifdef XK_hebrew_taf
	if(test("XK_hebrew_taf", XK_hebrew_taf, 0xCFA) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_hebrew_taf");
	FAIL;
#endif

#ifdef XK_Hebrew_switch
	if(test("XK_Hebrew_switch", XK_Hebrew_switch, 0xFF7E) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Hebrew_switch");
	FAIL;
#endif


	CHECKPASS(40);
}
