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
* File: xts5/tset/Xopen/keysymdef/TestK.c
* 
* Description:
* 	Tests for keysymdef()
* 
* Modifications:
* $Log: TestK.c,v $
* Revision 1.2  2005-11-03 08:44:00  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:40  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:35:39  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:58:15  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:26:53  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:23:27  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.1  1996/05/09 21:16:18  andy
* Fixed X includes
*
* Revision 4.0  1995/12/15  09:13:50  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  01:17:09  andy
* Prepare for GA Release
*
*/
/*
 *      SCCS:  @(#)  TestK.c Rel 1.1	    (11/28/91)
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

#define XK_KATAKANA
#include	<X11/keysymdef.h>
#undef XK_KATAKANA 

kysymdf9()
{ 
int 	pass = 0, fail = 0;
#ifdef XK_overline
	if(test("XK_overline", XK_overline, 0x47E) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_overline");
	FAIL;
#endif

#ifdef XK_kana_fullstop
	if(test("XK_kana_fullstop", XK_kana_fullstop, 0x4A1) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_fullstop");
	FAIL;
#endif

#ifdef XK_kana_openingbracket
	if(test("XK_kana_openingbracket", XK_kana_openingbracket, 0x4A2) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_openingbracket");
	FAIL;
#endif

#ifdef XK_kana_closingbracket
	if(test("XK_kana_closingbracket", XK_kana_closingbracket, 0x4A3) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_closingbracket");
	FAIL;
#endif

#ifdef XK_kana_comma
	if(test("XK_kana_comma", XK_kana_comma, 0x4A4) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_comma");
	FAIL;
#endif

#ifdef XK_kana_conjunctive
	if(test("XK_kana_conjunctive", XK_kana_conjunctive, 0x4A5) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_conjunctive");
	FAIL;
#endif

#ifdef XK_kana_middledot
	if(test("XK_kana_middledot", XK_kana_middledot, 0x4A5) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_middledot");
	FAIL;
#endif

#ifdef XK_kana_WO
	if(test("XK_kana_WO", XK_kana_WO, 0x4A6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_WO");
	FAIL;
#endif

#ifdef XK_kana_a
	if(test("XK_kana_a", XK_kana_a, 0x4A7) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_a");
	FAIL;
#endif

#ifdef XK_kana_i
	if(test("XK_kana_i", XK_kana_i, 0x4A8) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_i");
	FAIL;
#endif

#ifdef XK_kana_u
	if(test("XK_kana_u", XK_kana_u, 0x4A9) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_u");
	FAIL;
#endif

#ifdef XK_kana_e
	if(test("XK_kana_e", XK_kana_e, 0x4AA) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_e");
	FAIL;
#endif

#ifdef XK_kana_o
	if(test("XK_kana_o", XK_kana_o, 0x4AB) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_o");
	FAIL;
#endif

#ifdef XK_kana_ya
	if(test("XK_kana_ya", XK_kana_ya, 0x4AC) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_ya");
	FAIL;
#endif

#ifdef XK_kana_yu
	if(test("XK_kana_yu", XK_kana_yu, 0x4AD) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_yu");
	FAIL;
#endif

#ifdef XK_kana_yo
	if(test("XK_kana_yo", XK_kana_yo, 0x4AE) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_yo");
	FAIL;
#endif

#ifdef XK_kana_tsu
	if(test("XK_kana_tsu", XK_kana_tsu, 0x4AF) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_tsu");
	FAIL;
#endif

#ifdef XK_kana_tu
	if(test("XK_kana_tu", XK_kana_tu, 0x4AF) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_tu");
	FAIL;
#endif

#ifdef XK_prolongedsound
	if(test("XK_prolongedsound", XK_prolongedsound, 0x4B0) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_prolongedsound");
	FAIL;
#endif

#ifdef XK_kana_A
	if(test("XK_kana_A", XK_kana_A, 0x4B1) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_A");
	FAIL;
#endif

#ifdef XK_kana_I
	if(test("XK_kana_I", XK_kana_I, 0x4B2) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_I");
	FAIL;
#endif

#ifdef XK_kana_U
	if(test("XK_kana_U", XK_kana_U, 0x4B3) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_U");
	FAIL;
#endif

#ifdef XK_kana_E
	if(test("XK_kana_E", XK_kana_E, 0x4B4) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_E");
	FAIL;
#endif

#ifdef XK_kana_O
	if(test("XK_kana_O", XK_kana_O, 0x4B5) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_O");
	FAIL;
#endif

#ifdef XK_kana_KA
	if(test("XK_kana_KA", XK_kana_KA, 0x4B6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_KA");
	FAIL;
#endif

#ifdef XK_kana_KI
	if(test("XK_kana_KI", XK_kana_KI, 0x4B7) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_KI");
	FAIL;
#endif

#ifdef XK_kana_KU
	if(test("XK_kana_KU", XK_kana_KU, 0x4B8) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_KU");
	FAIL;
#endif

#ifdef XK_kana_KE
	if(test("XK_kana_KE", XK_kana_KE, 0x4B9) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_KE");
	FAIL;
#endif

#ifdef XK_kana_KO
	if(test("XK_kana_KO", XK_kana_KO, 0x4BA) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_KO");
	FAIL;
#endif

#ifdef XK_kana_SA
	if(test("XK_kana_SA", XK_kana_SA, 0x4BB) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_SA");
	FAIL;
#endif

#ifdef XK_kana_SHI
	if(test("XK_kana_SHI", XK_kana_SHI, 0x4BC) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_SHI");
	FAIL;
#endif

#ifdef XK_kana_SU
	if(test("XK_kana_SU", XK_kana_SU, 0x4BD) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_SU");
	FAIL;
#endif

#ifdef XK_kana_SE
	if(test("XK_kana_SE", XK_kana_SE, 0x4BE) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_SE");
	FAIL;
#endif

#ifdef XK_kana_SO
	if(test("XK_kana_SO", XK_kana_SO, 0x4BF) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_SO");
	FAIL;
#endif

#ifdef XK_kana_TA
	if(test("XK_kana_TA", XK_kana_TA, 0x4C0) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_TA");
	FAIL;
#endif

#ifdef XK_kana_CHI
	if(test("XK_kana_CHI", XK_kana_CHI, 0x4C1) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_CHI");
	FAIL;
#endif

#ifdef XK_kana_TI
	if(test("XK_kana_TI", XK_kana_TI, 0x4C1) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_TI");
	FAIL;
#endif

#ifdef XK_kana_TSU
	if(test("XK_kana_TSU", XK_kana_TSU, 0x4C2) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_TSU");
	FAIL;
#endif

#ifdef XK_kana_TU
	if(test("XK_kana_TU", XK_kana_TU, 0x4C2) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_TU");
	FAIL;
#endif

#ifdef XK_kana_TE
	if(test("XK_kana_TE", XK_kana_TE, 0x4C3) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_TE");
	FAIL;
#endif

#ifdef XK_kana_TO
	if(test("XK_kana_TO", XK_kana_TO, 0x4C4) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_TO");
	FAIL;
#endif

#ifdef XK_kana_NA
	if(test("XK_kana_NA", XK_kana_NA, 0x4C5) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_NA");
	FAIL;
#endif

#ifdef XK_kana_NI
	if(test("XK_kana_NI", XK_kana_NI, 0x4C6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_NI");
	FAIL;
#endif

#ifdef XK_kana_NU
	if(test("XK_kana_NU", XK_kana_NU, 0x4C7) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_NU");
	FAIL;
#endif

#ifdef XK_kana_NE
	if(test("XK_kana_NE", XK_kana_NE, 0x4C8) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_NE");
	FAIL;
#endif

#ifdef XK_kana_NO
	if(test("XK_kana_NO", XK_kana_NO, 0x4C9) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_NO");
	FAIL;
#endif

#ifdef XK_kana_HA
	if(test("XK_kana_HA", XK_kana_HA, 0x4CA) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_HA");
	FAIL;
#endif

#ifdef XK_kana_HI
	if(test("XK_kana_HI", XK_kana_HI, 0x4CB) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_HI");
	FAIL;
#endif

#ifdef XK_kana_FU
	if(test("XK_kana_FU", XK_kana_FU, 0x4CC) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_FU");
	FAIL;
#endif

#ifdef XK_kana_HU
	if(test("XK_kana_HU", XK_kana_HU, 0x4CC) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_HU");
	FAIL;
#endif

#ifdef XK_kana_HE
	if(test("XK_kana_HE", XK_kana_HE, 0x4CD) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_HE");
	FAIL;
#endif

#ifdef XK_kana_HO
	if(test("XK_kana_HO", XK_kana_HO, 0x4CE) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_HO");
	FAIL;
#endif

#ifdef XK_kana_MA
	if(test("XK_kana_MA", XK_kana_MA, 0x4CF) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_MA");
	FAIL;
#endif

#ifdef XK_kana_MI
	if(test("XK_kana_MI", XK_kana_MI, 0x4D0) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_MI");
	FAIL;
#endif

#ifdef XK_kana_MU
	if(test("XK_kana_MU", XK_kana_MU, 0x4D1) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_MU");
	FAIL;
#endif

#ifdef XK_kana_ME
	if(test("XK_kana_ME", XK_kana_ME, 0x4D2) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_ME");
	FAIL;
#endif

#ifdef XK_kana_MO
	if(test("XK_kana_MO", XK_kana_MO, 0x4D3) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_MO");
	FAIL;
#endif

#ifdef XK_kana_YA
	if(test("XK_kana_YA", XK_kana_YA, 0x4D4) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_YA");
	FAIL;
#endif

#ifdef XK_kana_YU
	if(test("XK_kana_YU", XK_kana_YU, 0x4D5) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_YU");
	FAIL;
#endif

#ifdef XK_kana_YO
	if(test("XK_kana_YO", XK_kana_YO, 0x4D6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_YO");
	FAIL;
#endif

#ifdef XK_kana_RA
	if(test("XK_kana_RA", XK_kana_RA, 0x4D7) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_RA");
	FAIL;
#endif

#ifdef XK_kana_RI
	if(test("XK_kana_RI", XK_kana_RI, 0x4D8) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_RI");
	FAIL;
#endif

#ifdef XK_kana_RU
	if(test("XK_kana_RU", XK_kana_RU, 0x4D9) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_RU");
	FAIL;
#endif

#ifdef XK_kana_RE
	if(test("XK_kana_RE", XK_kana_RE, 0x4DA) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_RE");
	FAIL;
#endif

#ifdef XK_kana_RO
	if(test("XK_kana_RO", XK_kana_RO, 0x4DB) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_RO");
	FAIL;
#endif

#ifdef XK_kana_WA
	if(test("XK_kana_WA", XK_kana_WA, 0x4DC) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_WA");
	FAIL;
#endif

#ifdef XK_kana_N
	if(test("XK_kana_N", XK_kana_N, 0x4DD) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_N");
	FAIL;
#endif

#ifdef XK_voicedsound
	if(test("XK_voicedsound", XK_voicedsound, 0x4DE) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_voicedsound");
	FAIL;
#endif

#ifdef XK_semivoicedsound
	if(test("XK_semivoicedsound", XK_semivoicedsound, 0x4DF) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_semivoicedsound");
	FAIL;
#endif

#ifdef XK_kana_switch
	if(test("XK_kana_switch", XK_kana_switch, 0xFF7E) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kana_switch");
	FAIL;
#endif


	CHECKPASS(70);
}
