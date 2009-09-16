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
* File: xts5/Xopen/XStringToKeysym/TestK.c
* 
* Description:
* 	Tests for XStringToKeysym()
* 
* Modifications:
* $Log: TestK.c,v $
* Revision 1.2  2005-11-03 08:44:01  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:40  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:35:57  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:58:41  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:27:10  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:23:43  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.1  1996/05/09 21:19:34  andy
* Fixed X includes
*
* Revision 4.0  1995/12/15  09:14:42  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  01:18:08  andy
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
test(symbol, str)
KeySym	symbol;
char	*str;
{
KeySym	rsym;

	rsym = XStringToKeysym(str);

	if(rsym == NoSymbol) {
		report("XStringToKeysym() returned NoSymbol for string \"%s\".", str);
		return(0);
	}

	if(rsym != symbol) {
		report("XStringToKeysym() returned KeySym 0x%lx instead of 0x%lx.", (long) rsym, (long) symbol);
		return(0);
	}
	return(1);
}

static void
reporterr(s)
char	*s;
{
	report("Symbol \"%s\" is not defined.", s);
}
#define XK_KATAKANA
#include	<X11/keysymdef.h>
#undef XK_KATAKANA 

strtsymK()
{ 
int 	pass = 0, fail = 0;
char	*symstr;
KeySym	rsym;


#ifdef XK_overline
	if(test(XK_overline, "overline") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_overline");
	FAIL;
#endif

#ifdef XK_kana_fullstop
	if(test(XK_kana_fullstop, "kana_fullstop") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_fullstop");
	FAIL;
#endif

#ifdef XK_kana_openingbracket
	if(test(XK_kana_openingbracket, "kana_openingbracket") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_openingbracket");
	FAIL;
#endif

#ifdef XK_kana_closingbracket
	if(test(XK_kana_closingbracket, "kana_closingbracket") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_closingbracket");
	FAIL;
#endif

#ifdef XK_kana_comma
	if(test(XK_kana_comma, "kana_comma") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_comma");
	FAIL;
#endif

#ifdef XK_kana_conjunctive
	if(test(XK_kana_conjunctive, "kana_conjunctive") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_conjunctive");
	FAIL;
#endif

#ifdef XK_kana_middledot
	if(test(XK_kana_middledot, "kana_middledot") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_middledot");
	FAIL;
#endif

#ifdef XK_kana_WO
	if(test(XK_kana_WO, "kana_WO") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_WO");
	FAIL;
#endif

#ifdef XK_kana_a
	if(test(XK_kana_a, "kana_a") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_a");
	FAIL;
#endif

#ifdef XK_kana_i
	if(test(XK_kana_i, "kana_i") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_i");
	FAIL;
#endif

#ifdef XK_kana_u
	if(test(XK_kana_u, "kana_u") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_u");
	FAIL;
#endif

#ifdef XK_kana_e
	if(test(XK_kana_e, "kana_e") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_e");
	FAIL;
#endif

#ifdef XK_kana_o
	if(test(XK_kana_o, "kana_o") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_o");
	FAIL;
#endif

#ifdef XK_kana_ya
	if(test(XK_kana_ya, "kana_ya") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_ya");
	FAIL;
#endif

#ifdef XK_kana_yu
	if(test(XK_kana_yu, "kana_yu") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_yu");
	FAIL;
#endif

#ifdef XK_kana_yo
	if(test(XK_kana_yo, "kana_yo") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_yo");
	FAIL;
#endif

#ifdef XK_kana_tsu
	if(test(XK_kana_tsu, "kana_tsu") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_tsu");
	FAIL;
#endif

#ifdef XK_kana_tu
	if(test(XK_kana_tu, "kana_tu") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_tu");
	FAIL;
#endif

#ifdef XK_prolongedsound
	if(test(XK_prolongedsound, "prolongedsound") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_prolongedsound");
	FAIL;
#endif

#ifdef XK_kana_A
	if(test(XK_kana_A, "kana_A") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_A");
	FAIL;
#endif

#ifdef XK_kana_I
	if(test(XK_kana_I, "kana_I") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_I");
	FAIL;
#endif

#ifdef XK_kana_U
	if(test(XK_kana_U, "kana_U") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_U");
	FAIL;
#endif

#ifdef XK_kana_E
	if(test(XK_kana_E, "kana_E") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_E");
	FAIL;
#endif

#ifdef XK_kana_O
	if(test(XK_kana_O, "kana_O") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_O");
	FAIL;
#endif

#ifdef XK_kana_KA
	if(test(XK_kana_KA, "kana_KA") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_KA");
	FAIL;
#endif

#ifdef XK_kana_KI
	if(test(XK_kana_KI, "kana_KI") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_KI");
	FAIL;
#endif

#ifdef XK_kana_KU
	if(test(XK_kana_KU, "kana_KU") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_KU");
	FAIL;
#endif

#ifdef XK_kana_KE
	if(test(XK_kana_KE, "kana_KE") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_KE");
	FAIL;
#endif

#ifdef XK_kana_KO
	if(test(XK_kana_KO, "kana_KO") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_KO");
	FAIL;
#endif

#ifdef XK_kana_SA
	if(test(XK_kana_SA, "kana_SA") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_SA");
	FAIL;
#endif

#ifdef XK_kana_SHI
	if(test(XK_kana_SHI, "kana_SHI") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_SHI");
	FAIL;
#endif

#ifdef XK_kana_SU
	if(test(XK_kana_SU, "kana_SU") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_SU");
	FAIL;
#endif

#ifdef XK_kana_SE
	if(test(XK_kana_SE, "kana_SE") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_SE");
	FAIL;
#endif

#ifdef XK_kana_SO
	if(test(XK_kana_SO, "kana_SO") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_SO");
	FAIL;
#endif

#ifdef XK_kana_TA
	if(test(XK_kana_TA, "kana_TA") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_TA");
	FAIL;
#endif

#ifdef XK_kana_CHI
	if(test(XK_kana_CHI, "kana_CHI") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_CHI");
	FAIL;
#endif

#ifdef XK_kana_TI
	if(test(XK_kana_TI, "kana_TI") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_TI");
	FAIL;
#endif

#ifdef XK_kana_TSU
	if(test(XK_kana_TSU, "kana_TSU") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_TSU");
	FAIL;
#endif

#ifdef XK_kana_TU
	if(test(XK_kana_TU, "kana_TU") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_TU");
	FAIL;
#endif

#ifdef XK_kana_TE
	if(test(XK_kana_TE, "kana_TE") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_TE");
	FAIL;
#endif

#ifdef XK_kana_TO
	if(test(XK_kana_TO, "kana_TO") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_TO");
	FAIL;
#endif

#ifdef XK_kana_NA
	if(test(XK_kana_NA, "kana_NA") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_NA");
	FAIL;
#endif

#ifdef XK_kana_NI
	if(test(XK_kana_NI, "kana_NI") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_NI");
	FAIL;
#endif

#ifdef XK_kana_NU
	if(test(XK_kana_NU, "kana_NU") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_NU");
	FAIL;
#endif

#ifdef XK_kana_NE
	if(test(XK_kana_NE, "kana_NE") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_NE");
	FAIL;
#endif

#ifdef XK_kana_NO
	if(test(XK_kana_NO, "kana_NO") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_NO");
	FAIL;
#endif

#ifdef XK_kana_HA
	if(test(XK_kana_HA, "kana_HA") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_HA");
	FAIL;
#endif

#ifdef XK_kana_HI
	if(test(XK_kana_HI, "kana_HI") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_HI");
	FAIL;
#endif

#ifdef XK_kana_FU
	if(test(XK_kana_FU, "kana_FU") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_FU");
	FAIL;
#endif

#ifdef XK_kana_HU
	if(test(XK_kana_HU, "kana_HU") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_HU");
	FAIL;
#endif

#ifdef XK_kana_HE
	if(test(XK_kana_HE, "kana_HE") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_HE");
	FAIL;
#endif

#ifdef XK_kana_HO
	if(test(XK_kana_HO, "kana_HO") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_HO");
	FAIL;
#endif

#ifdef XK_kana_MA
	if(test(XK_kana_MA, "kana_MA") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_MA");
	FAIL;
#endif

#ifdef XK_kana_MI
	if(test(XK_kana_MI, "kana_MI") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_MI");
	FAIL;
#endif

#ifdef XK_kana_MU
	if(test(XK_kana_MU, "kana_MU") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_MU");
	FAIL;
#endif

#ifdef XK_kana_ME
	if(test(XK_kana_ME, "kana_ME") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_ME");
	FAIL;
#endif

#ifdef XK_kana_MO
	if(test(XK_kana_MO, "kana_MO") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_MO");
	FAIL;
#endif

#ifdef XK_kana_YA
	if(test(XK_kana_YA, "kana_YA") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_YA");
	FAIL;
#endif

#ifdef XK_kana_YU
	if(test(XK_kana_YU, "kana_YU") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_YU");
	FAIL;
#endif

#ifdef XK_kana_YO
	if(test(XK_kana_YO, "kana_YO") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_YO");
	FAIL;
#endif

#ifdef XK_kana_RA
	if(test(XK_kana_RA, "kana_RA") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_RA");
	FAIL;
#endif

#ifdef XK_kana_RI
	if(test(XK_kana_RI, "kana_RI") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_RI");
	FAIL;
#endif

#ifdef XK_kana_RU
	if(test(XK_kana_RU, "kana_RU") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_RU");
	FAIL;
#endif

#ifdef XK_kana_RE
	if(test(XK_kana_RE, "kana_RE") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_RE");
	FAIL;
#endif

#ifdef XK_kana_RO
	if(test(XK_kana_RO, "kana_RO") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_RO");
	FAIL;
#endif

#ifdef XK_kana_WA
	if(test(XK_kana_WA, "kana_WA") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_WA");
	FAIL;
#endif

#ifdef XK_kana_N
	if(test(XK_kana_N, "kana_N") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_N");
	FAIL;
#endif

#ifdef XK_voicedsound
	if(test(XK_voicedsound, "voicedsound") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_voicedsound");
	FAIL;
#endif

#ifdef XK_semivoicedsound
	if(test(XK_semivoicedsound, "semivoicedsound") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_semivoicedsound");
	FAIL;
#endif

#ifdef XK_kana_switch
	if(test(XK_kana_switch, "kana_switch") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_kana_switch");
	FAIL;
#endif

	CHECKPASS(70);
}
