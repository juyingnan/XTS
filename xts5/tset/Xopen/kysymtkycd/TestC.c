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
* $Header: /cvs/xtest/xtest/xts5/tset/Xopen/kysymtkycd/TestC.c,v 1.1 2005-02-12 14:37:43 anderson Exp $
* 
* Project: VSW5
* 
* File: vsw5/tset/Xopen/kysymtkycd/TestC.c
* 
* Description:
* 	Tests for XKeysymToKeycode()
* 
* Modifications:
* $Log: TestC.c,v $
* Revision 1.1  2005-02-12 14:37:43  anderson
* Initial revision
*
* Revision 8.0  1998/12/23 23:35:46  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:58:25  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:27:00  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:23:33  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.1  1996/05/09 21:17:34  andy
* Fixed X includes
*
* Revision 4.0  1995/12/15  09:14:10  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  01:17:31  andy
* Prepare for GA Release
*
*/
/*
 *      SCCS:  @(#)  TestC.c Rel 1.1	    (11/28/91)
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

#include        <stdlib.h>
#include        "xtest.h"
#include        "X11/Xlib.h"
#include        "X11/Xutil.h"
#include        "X11/Xresource.h"
#include        "tet_api.h"
#include        "xtestlib.h"
#include        "pixval.h"

extern char	*TestName;
extern Display	*Dsp;

int		minkc;
int		maxkc;
int		keysyms_per_keycode;

static int
test(symbol, str)
KeySym	symbol;
char	*str;
{
KeyCode	kycd;
int	mod;

	kycd = XKeysymToKeycode(Dsp, symbol);
	if(kycd == 0) {
		trace("XKeysymToKeycode() returned 0 for KeySym \"XK_%s\".", str);
		return(1);
	}

	if(kycd > maxkc || kycd < minkc) {
		report("XKeysymToKeycode() returned invalid keycode value %d for KeySym \"XK_%s\".", kycd, str);
		return(0);
	}

	for(mod = 0; mod < keysyms_per_keycode; mod++) {
		if( symbol == XKeycodeToKeysym(Dsp, kycd, mod))  {
			trace("KeySym \"XK_%s\", keycode %d, mod %d", 
								str, kycd, mod);
			return(1);
		}
	}

	report("The keycode value %d for KeySym \"XK_%s\"", kycd, str);
	report("never returns that KeySym when using XKeycodeToKeysym()");
	return(0);
}

static void
reporterr(s)
char	*s;
{
	report("Symbol XK_\"%s\" is not defined.", s);
}
#define XK_CYRILLIC
#include	<X11/keysymdef.h>
#undef XK_CYRILLIC 

kysymtcdC()
{ 
int 	pass = 0, fail = 0;

	XDisplayKeycodes(Dsp, &minkc, &maxkc);
	XGetKeyboardMapping(Dsp, (KeyCode)minkc, 1, &keysyms_per_keycode);

#ifdef XK_Serbian_dje
	if(test(XK_Serbian_dje, "Serbian_dje") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Serbian_dje");
	FAIL;
#endif

#ifdef XK_Macedonia_gje
	if(test(XK_Macedonia_gje, "Macedonia_gje") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Macedonia_gje");
	FAIL;
#endif

#ifdef XK_Cyrillic_io
	if(test(XK_Cyrillic_io, "Cyrillic_io") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_io");
	FAIL;
#endif

#ifdef XK_Ukrainian_ie
	if(test(XK_Ukrainian_ie, "Ukrainian_ie") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Ukrainian_ie");
	FAIL;
#endif

#ifdef XK_Ukranian_je
	if(test(XK_Ukranian_je, "Ukranian_je") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Ukranian_je");
	FAIL;
#endif

#ifdef XK_Macedonia_dse
	if(test(XK_Macedonia_dse, "Macedonia_dse") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Macedonia_dse");
	FAIL;
#endif

#ifdef XK_Ukrainian_i
	if(test(XK_Ukrainian_i, "Ukrainian_i") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Ukrainian_i");
	FAIL;
#endif

#ifdef XK_Ukranian_i
	if(test(XK_Ukranian_i, "Ukranian_i") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Ukranian_i");
	FAIL;
#endif

#ifdef XK_Ukrainian_yi
	if(test(XK_Ukrainian_yi, "Ukrainian_yi") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Ukrainian_yi");
	FAIL;
#endif

#ifdef XK_Ukranian_yi
	if(test(XK_Ukranian_yi, "Ukranian_yi") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Ukranian_yi");
	FAIL;
#endif

#ifdef XK_Cyrillic_je
	if(test(XK_Cyrillic_je, "Cyrillic_je") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_je");
	FAIL;
#endif

#ifdef XK_Serbian_je
	if(test(XK_Serbian_je, "Serbian_je") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Serbian_je");
	FAIL;
#endif

#ifdef XK_Cyrillic_lje
	if(test(XK_Cyrillic_lje, "Cyrillic_lje") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_lje");
	FAIL;
#endif

#ifdef XK_Serbian_lje
	if(test(XK_Serbian_lje, "Serbian_lje") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Serbian_lje");
	FAIL;
#endif

#ifdef XK_Cyrillic_nje
	if(test(XK_Cyrillic_nje, "Cyrillic_nje") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_nje");
	FAIL;
#endif

#ifdef XK_Serbian_nje
	if(test(XK_Serbian_nje, "Serbian_nje") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Serbian_nje");
	FAIL;
#endif

#ifdef XK_Serbian_tshe
	if(test(XK_Serbian_tshe, "Serbian_tshe") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Serbian_tshe");
	FAIL;
#endif

#ifdef XK_Macedonia_kje
	if(test(XK_Macedonia_kje, "Macedonia_kje") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Macedonia_kje");
	FAIL;
#endif

#ifdef XK_Byelorussian_shortu
	if(test(XK_Byelorussian_shortu, "Byelorussian_shortu") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Byelorussian_shortu");
	FAIL;
#endif

#ifdef XK_Cyrillic_dzhe
	if(test(XK_Cyrillic_dzhe, "Cyrillic_dzhe") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_dzhe");
	FAIL;
#endif

#ifdef XK_Serbian_dze
	if(test(XK_Serbian_dze, "Serbian_dze") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Serbian_dze");
	FAIL;
#endif

#ifdef XK_numerosign
	if(test(XK_numerosign, "numerosign") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("numerosign");
	FAIL;
#endif

#ifdef XK_Serbian_DJE
	if(test(XK_Serbian_DJE, "Serbian_DJE") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Serbian_DJE");
	FAIL;
#endif

#ifdef XK_Macedonia_GJE
	if(test(XK_Macedonia_GJE, "Macedonia_GJE") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Macedonia_GJE");
	FAIL;
#endif

#ifdef XK_Cyrillic_IO
	if(test(XK_Cyrillic_IO, "Cyrillic_IO") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_IO");
	FAIL;
#endif

#ifdef XK_Ukrainian_IE
	if(test(XK_Ukrainian_IE, "Ukrainian_IE") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Ukrainian_IE");
	FAIL;
#endif

#ifdef XK_Ukranian_JE
	if(test(XK_Ukranian_JE, "Ukranian_JE") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Ukranian_JE");
	FAIL;
#endif

#ifdef XK_Macedonia_DSE
	if(test(XK_Macedonia_DSE, "Macedonia_DSE") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Macedonia_DSE");
	FAIL;
#endif

#ifdef XK_Ukrainian_I
	if(test(XK_Ukrainian_I, "Ukrainian_I") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Ukrainian_I");
	FAIL;
#endif

#ifdef XK_Ukranian_I
	if(test(XK_Ukranian_I, "Ukranian_I") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Ukranian_I");
	FAIL;
#endif

#ifdef XK_Ukrainian_YI
	if(test(XK_Ukrainian_YI, "Ukrainian_YI") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Ukrainian_YI");
	FAIL;
#endif

#ifdef XK_Ukranian_YI
	if(test(XK_Ukranian_YI, "Ukranian_YI") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Ukranian_YI");
	FAIL;
#endif

#ifdef XK_Cyrillic_JE
	if(test(XK_Cyrillic_JE, "Cyrillic_JE") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_JE");
	FAIL;
#endif

#ifdef XK_Serbian_JE
	if(test(XK_Serbian_JE, "Serbian_JE") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Serbian_JE");
	FAIL;
#endif

#ifdef XK_Cyrillic_LJE
	if(test(XK_Cyrillic_LJE, "Cyrillic_LJE") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_LJE");
	FAIL;
#endif

#ifdef XK_Serbian_LJE
	if(test(XK_Serbian_LJE, "Serbian_LJE") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Serbian_LJE");
	FAIL;
#endif

#ifdef XK_Cyrillic_NJE
	if(test(XK_Cyrillic_NJE, "Cyrillic_NJE") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_NJE");
	FAIL;
#endif

#ifdef XK_Serbian_NJE
	if(test(XK_Serbian_NJE, "Serbian_NJE") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Serbian_NJE");
	FAIL;
#endif

#ifdef XK_Serbian_TSHE
	if(test(XK_Serbian_TSHE, "Serbian_TSHE") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Serbian_TSHE");
	FAIL;
#endif

#ifdef XK_Macedonia_KJE
	if(test(XK_Macedonia_KJE, "Macedonia_KJE") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Macedonia_KJE");
	FAIL;
#endif

#ifdef XK_Byelorussian_SHORTU
	if(test(XK_Byelorussian_SHORTU, "Byelorussian_SHORTU") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Byelorussian_SHORTU");
	FAIL;
#endif

#ifdef XK_Cyrillic_DZHE
	if(test(XK_Cyrillic_DZHE, "Cyrillic_DZHE") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_DZHE");
	FAIL;
#endif

#ifdef XK_Serbian_DZE
	if(test(XK_Serbian_DZE, "Serbian_DZE") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Serbian_DZE");
	FAIL;
#endif

#ifdef XK_Cyrillic_yu
	if(test(XK_Cyrillic_yu, "Cyrillic_yu") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_yu");
	FAIL;
#endif

#ifdef XK_Cyrillic_a
	if(test(XK_Cyrillic_a, "Cyrillic_a") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_a");
	FAIL;
#endif

#ifdef XK_Cyrillic_be
	if(test(XK_Cyrillic_be, "Cyrillic_be") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_be");
	FAIL;
#endif

#ifdef XK_Cyrillic_tse
	if(test(XK_Cyrillic_tse, "Cyrillic_tse") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_tse");
	FAIL;
#endif

#ifdef XK_Cyrillic_de
	if(test(XK_Cyrillic_de, "Cyrillic_de") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_de");
	FAIL;
#endif

#ifdef XK_Cyrillic_ie
	if(test(XK_Cyrillic_ie, "Cyrillic_ie") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_ie");
	FAIL;
#endif

#ifdef XK_Cyrillic_ef
	if(test(XK_Cyrillic_ef, "Cyrillic_ef") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_ef");
	FAIL;
#endif

#ifdef XK_Cyrillic_ghe
	if(test(XK_Cyrillic_ghe, "Cyrillic_ghe") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_ghe");
	FAIL;
#endif

#ifdef XK_Cyrillic_ha
	if(test(XK_Cyrillic_ha, "Cyrillic_ha") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_ha");
	FAIL;
#endif

#ifdef XK_Cyrillic_i
	if(test(XK_Cyrillic_i, "Cyrillic_i") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_i");
	FAIL;
#endif

#ifdef XK_Cyrillic_shorti
	if(test(XK_Cyrillic_shorti, "Cyrillic_shorti") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_shorti");
	FAIL;
#endif

#ifdef XK_Cyrillic_ka
	if(test(XK_Cyrillic_ka, "Cyrillic_ka") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_ka");
	FAIL;
#endif

#ifdef XK_Cyrillic_el
	if(test(XK_Cyrillic_el, "Cyrillic_el") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_el");
	FAIL;
#endif

#ifdef XK_Cyrillic_em
	if(test(XK_Cyrillic_em, "Cyrillic_em") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_em");
	FAIL;
#endif

#ifdef XK_Cyrillic_en
	if(test(XK_Cyrillic_en, "Cyrillic_en") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_en");
	FAIL;
#endif

#ifdef XK_Cyrillic_o
	if(test(XK_Cyrillic_o, "Cyrillic_o") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_o");
	FAIL;
#endif

#ifdef XK_Cyrillic_pe
	if(test(XK_Cyrillic_pe, "Cyrillic_pe") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_pe");
	FAIL;
#endif

#ifdef XK_Cyrillic_ya
	if(test(XK_Cyrillic_ya, "Cyrillic_ya") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_ya");
	FAIL;
#endif

#ifdef XK_Cyrillic_er
	if(test(XK_Cyrillic_er, "Cyrillic_er") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_er");
	FAIL;
#endif

#ifdef XK_Cyrillic_es
	if(test(XK_Cyrillic_es, "Cyrillic_es") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_es");
	FAIL;
#endif

#ifdef XK_Cyrillic_te
	if(test(XK_Cyrillic_te, "Cyrillic_te") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_te");
	FAIL;
#endif

#ifdef XK_Cyrillic_u
	if(test(XK_Cyrillic_u, "Cyrillic_u") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_u");
	FAIL;
#endif

#ifdef XK_Cyrillic_zhe
	if(test(XK_Cyrillic_zhe, "Cyrillic_zhe") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_zhe");
	FAIL;
#endif

#ifdef XK_Cyrillic_ve
	if(test(XK_Cyrillic_ve, "Cyrillic_ve") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_ve");
	FAIL;
#endif

#ifdef XK_Cyrillic_softsign
	if(test(XK_Cyrillic_softsign, "Cyrillic_softsign") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_softsign");
	FAIL;
#endif

#ifdef XK_Cyrillic_yeru
	if(test(XK_Cyrillic_yeru, "Cyrillic_yeru") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_yeru");
	FAIL;
#endif

#ifdef XK_Cyrillic_ze
	if(test(XK_Cyrillic_ze, "Cyrillic_ze") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_ze");
	FAIL;
#endif

#ifdef XK_Cyrillic_sha
	if(test(XK_Cyrillic_sha, "Cyrillic_sha") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_sha");
	FAIL;
#endif

#ifdef XK_Cyrillic_e
	if(test(XK_Cyrillic_e, "Cyrillic_e") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_e");
	FAIL;
#endif

#ifdef XK_Cyrillic_shcha
	if(test(XK_Cyrillic_shcha, "Cyrillic_shcha") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_shcha");
	FAIL;
#endif

#ifdef XK_Cyrillic_che
	if(test(XK_Cyrillic_che, "Cyrillic_che") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_che");
	FAIL;
#endif

#ifdef XK_Cyrillic_hardsign
	if(test(XK_Cyrillic_hardsign, "Cyrillic_hardsign") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_hardsign");
	FAIL;
#endif

#ifdef XK_Cyrillic_YU
	if(test(XK_Cyrillic_YU, "Cyrillic_YU") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_YU");
	FAIL;
#endif

#ifdef XK_Cyrillic_A
	if(test(XK_Cyrillic_A, "Cyrillic_A") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_A");
	FAIL;
#endif

#ifdef XK_Cyrillic_BE
	if(test(XK_Cyrillic_BE, "Cyrillic_BE") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_BE");
	FAIL;
#endif

#ifdef XK_Cyrillic_TSE
	if(test(XK_Cyrillic_TSE, "Cyrillic_TSE") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_TSE");
	FAIL;
#endif

#ifdef XK_Cyrillic_DE
	if(test(XK_Cyrillic_DE, "Cyrillic_DE") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_DE");
	FAIL;
#endif

#ifdef XK_Cyrillic_IE
	if(test(XK_Cyrillic_IE, "Cyrillic_IE") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_IE");
	FAIL;
#endif

#ifdef XK_Cyrillic_EF
	if(test(XK_Cyrillic_EF, "Cyrillic_EF") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_EF");
	FAIL;
#endif

#ifdef XK_Cyrillic_GHE
	if(test(XK_Cyrillic_GHE, "Cyrillic_GHE") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_GHE");
	FAIL;
#endif

#ifdef XK_Cyrillic_HA
	if(test(XK_Cyrillic_HA, "Cyrillic_HA") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_HA");
	FAIL;
#endif

#ifdef XK_Cyrillic_I
	if(test(XK_Cyrillic_I, "Cyrillic_I") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_I");
	FAIL;
#endif

#ifdef XK_Cyrillic_SHORTI
	if(test(XK_Cyrillic_SHORTI, "Cyrillic_SHORTI") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_SHORTI");
	FAIL;
#endif

#ifdef XK_Cyrillic_KA
	if(test(XK_Cyrillic_KA, "Cyrillic_KA") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_KA");
	FAIL;
#endif

#ifdef XK_Cyrillic_EL
	if(test(XK_Cyrillic_EL, "Cyrillic_EL") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_EL");
	FAIL;
#endif

#ifdef XK_Cyrillic_EM
	if(test(XK_Cyrillic_EM, "Cyrillic_EM") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_EM");
	FAIL;
#endif

#ifdef XK_Cyrillic_EN
	if(test(XK_Cyrillic_EN, "Cyrillic_EN") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_EN");
	FAIL;
#endif

#ifdef XK_Cyrillic_O
	if(test(XK_Cyrillic_O, "Cyrillic_O") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_O");
	FAIL;
#endif

#ifdef XK_Cyrillic_PE
	if(test(XK_Cyrillic_PE, "Cyrillic_PE") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_PE");
	FAIL;
#endif

#ifdef XK_Cyrillic_YA
	if(test(XK_Cyrillic_YA, "Cyrillic_YA") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_YA");
	FAIL;
#endif

#ifdef XK_Cyrillic_ER
	if(test(XK_Cyrillic_ER, "Cyrillic_ER") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_ER");
	FAIL;
#endif

#ifdef XK_Cyrillic_ES
	if(test(XK_Cyrillic_ES, "Cyrillic_ES") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_ES");
	FAIL;
#endif

#ifdef XK_Cyrillic_TE
	if(test(XK_Cyrillic_TE, "Cyrillic_TE") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_TE");
	FAIL;
#endif

#ifdef XK_Cyrillic_U
	if(test(XK_Cyrillic_U, "Cyrillic_U") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_U");
	FAIL;
#endif

#ifdef XK_Cyrillic_ZHE
	if(test(XK_Cyrillic_ZHE, "Cyrillic_ZHE") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_ZHE");
	FAIL;
#endif

#ifdef XK_Cyrillic_VE
	if(test(XK_Cyrillic_VE, "Cyrillic_VE") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_VE");
	FAIL;
#endif

#ifdef XK_Cyrillic_SOFTSIGN
	if(test(XK_Cyrillic_SOFTSIGN, "Cyrillic_SOFTSIGN") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_SOFTSIGN");
	FAIL;
#endif

#ifdef XK_Cyrillic_YERU
	if(test(XK_Cyrillic_YERU, "Cyrillic_YERU") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_YERU");
	FAIL;
#endif

#ifdef XK_Cyrillic_ZE
	if(test(XK_Cyrillic_ZE, "Cyrillic_ZE") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_ZE");
	FAIL;
#endif

#ifdef XK_Cyrillic_SHA
	if(test(XK_Cyrillic_SHA, "Cyrillic_SHA") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_SHA");
	FAIL;
#endif

#ifdef XK_Cyrillic_E
	if(test(XK_Cyrillic_E, "Cyrillic_E") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_E");
	FAIL;
#endif

#ifdef XK_Cyrillic_SHCHA
	if(test(XK_Cyrillic_SHCHA, "Cyrillic_SHCHA") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_SHCHA");
	FAIL;
#endif

#ifdef XK_Cyrillic_CHE
	if(test(XK_Cyrillic_CHE, "Cyrillic_CHE") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_CHE");
	FAIL;
#endif

#ifdef XK_Cyrillic_HARDSIGN
	if(test(XK_Cyrillic_HARDSIGN, "Cyrillic_HARDSIGN") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cyrillic_HARDSIGN");
	FAIL;
#endif

	CHECKPASS(107);
}
