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
* $Header: /cvs/xtest/xtest/xts5/tset/Xopen/kysymdf/TestC.c,v 1.2 2005-11-03 08:44:00 jmichael Exp $
* 
* Project: VSW5
* 
* File: xts5/tset/Xopen/kysymdf/TestC.c
* 
* Description:
* 	Tests for keysymdef()
* 
* Modifications:
* $Log: TestC.c,v $
* Revision 1.2  2005-11-03 08:44:00  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:40  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:35:38  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:58:13  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:26:52  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:23:25  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.1  1996/05/09 21:16:18  andy
* Fixed X includes
*
* Revision 4.0  1995/12/15  09:13:46  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  01:17:04  andy
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

#define XK_CYRILLIC
#include	<X11/keysymdef.h>
#undef XK_CYRILLIC 

kysymdf6()
{ 
int 	pass = 0, fail = 0;
#ifdef XK_Serbian_dje
	if(test("XK_Serbian_dje", XK_Serbian_dje, 0x6A1) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Serbian_dje");
	FAIL;
#endif

#ifdef XK_Macedonia_gje
	if(test("XK_Macedonia_gje", XK_Macedonia_gje, 0x6A2) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Macedonia_gje");
	FAIL;
#endif

#ifdef XK_Cyrillic_io
	if(test("XK_Cyrillic_io", XK_Cyrillic_io, 0x6A3) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_io");
	FAIL;
#endif

#ifdef XK_Ukrainian_ie
	if(test("XK_Ukrainian_ie", XK_Ukrainian_ie, 0x6A4) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Ukrainian_ie");
	FAIL;
#endif

#ifdef XK_Ukranian_je
	if(test("XK_Ukranian_je", XK_Ukranian_je, 0x6A4) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Ukranian_je");
	FAIL;
#endif

#ifdef XK_Macedonia_dse
	if(test("XK_Macedonia_dse", XK_Macedonia_dse, 0x6A5) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Macedonia_dse");
	FAIL;
#endif

#ifdef XK_Ukrainian_i
	if(test("XK_Ukrainian_i", XK_Ukrainian_i, 0x6A6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Ukrainian_i");
	FAIL;
#endif

#ifdef XK_Ukranian_i
	if(test("XK_Ukranian_i", XK_Ukranian_i, 0x6A6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Ukranian_i");
	FAIL;
#endif

#ifdef XK_Ukrainian_yi
	if(test("XK_Ukrainian_yi", XK_Ukrainian_yi, 0x6A7) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Ukrainian_yi");
	FAIL;
#endif

#ifdef XK_Ukranian_yi
	if(test("XK_Ukranian_yi", XK_Ukranian_yi, 0x6A7) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Ukranian_yi");
	FAIL;
#endif

#ifdef XK_Cyrillic_je
	if(test("XK_Cyrillic_je", XK_Cyrillic_je, 0x6A8) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_je");
	FAIL;
#endif

#ifdef XK_Serbian_je
	if(test("XK_Serbian_je", XK_Serbian_je, 0x6A8) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Serbian_je");
	FAIL;
#endif

#ifdef XK_Cyrillic_lje
	if(test("XK_Cyrillic_lje", XK_Cyrillic_lje, 0x6A9) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_lje");
	FAIL;
#endif

#ifdef XK_Serbian_lje
	if(test("XK_Serbian_lje", XK_Serbian_lje, 0x6A9) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Serbian_lje");
	FAIL;
#endif

#ifdef XK_Cyrillic_nje
	if(test("XK_Cyrillic_nje", XK_Cyrillic_nje, 0x6AA) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_nje");
	FAIL;
#endif

#ifdef XK_Serbian_nje
	if(test("XK_Serbian_nje", XK_Serbian_nje, 0x6AA) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Serbian_nje");
	FAIL;
#endif

#ifdef XK_Serbian_tshe
	if(test("XK_Serbian_tshe", XK_Serbian_tshe, 0x6AB) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Serbian_tshe");
	FAIL;
#endif

#ifdef XK_Macedonia_kje
	if(test("XK_Macedonia_kje", XK_Macedonia_kje, 0x6AC) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Macedonia_kje");
	FAIL;
#endif

#ifdef XK_Byelorussian_shortu
	if(test("XK_Byelorussian_shortu", XK_Byelorussian_shortu, 0x6AE) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Byelorussian_shortu");
	FAIL;
#endif

#ifdef XK_Cyrillic_dzhe
	if(test("XK_Cyrillic_dzhe", XK_Cyrillic_dzhe, 0x6AF) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_dzhe");
	FAIL;
#endif

#ifdef XK_Serbian_dze
	if(test("XK_Serbian_dze", XK_Serbian_dze, 0x6AF) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Serbian_dze");
	FAIL;
#endif

#ifdef XK_numerosign
	if(test("XK_numerosign", XK_numerosign, 0x6B0) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_numerosign");
	FAIL;
#endif

#ifdef XK_Serbian_DJE
	if(test("XK_Serbian_DJE", XK_Serbian_DJE, 0x6B1) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Serbian_DJE");
	FAIL;
#endif

#ifdef XK_Macedonia_GJE
	if(test("XK_Macedonia_GJE", XK_Macedonia_GJE, 0x6B2) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Macedonia_GJE");
	FAIL;
#endif

#ifdef XK_Cyrillic_IO
	if(test("XK_Cyrillic_IO", XK_Cyrillic_IO, 0x6B3) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_IO");
	FAIL;
#endif

#ifdef XK_Ukrainian_IE
	if(test("XK_Ukrainian_IE", XK_Ukrainian_IE, 0x6B4) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Ukrainian_IE");
	FAIL;
#endif

#ifdef XK_Ukranian_JE
	if(test("XK_Ukranian_JE", XK_Ukranian_JE, 0x6B4) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Ukranian_JE");
	FAIL;
#endif

#ifdef XK_Macedonia_DSE
	if(test("XK_Macedonia_DSE", XK_Macedonia_DSE, 0x6B5) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Macedonia_DSE");
	FAIL;
#endif

#ifdef XK_Ukrainian_I
	if(test("XK_Ukrainian_I", XK_Ukrainian_I, 0x6B6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Ukrainian_I");
	FAIL;
#endif

#ifdef XK_Ukranian_I
	if(test("XK_Ukranian_I", XK_Ukranian_I, 0x6B6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Ukranian_I");
	FAIL;
#endif

#ifdef XK_Ukrainian_YI
	if(test("XK_Ukrainian_YI", XK_Ukrainian_YI, 0x6B7) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Ukrainian_YI");
	FAIL;
#endif

#ifdef XK_Ukranian_YI
	if(test("XK_Ukranian_YI", XK_Ukranian_YI, 0x6B7) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Ukranian_YI");
	FAIL;
#endif

#ifdef XK_Cyrillic_JE
	if(test("XK_Cyrillic_JE", XK_Cyrillic_JE, 0x6B8) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_JE");
	FAIL;
#endif

#ifdef XK_Serbian_JE
	if(test("XK_Serbian_JE", XK_Serbian_JE, 0x6B8) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Serbian_JE");
	FAIL;
#endif

#ifdef XK_Cyrillic_LJE
	if(test("XK_Cyrillic_LJE", XK_Cyrillic_LJE, 0x6B9) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_LJE");
	FAIL;
#endif

#ifdef XK_Serbian_LJE
	if(test("XK_Serbian_LJE", XK_Serbian_LJE, 0x6B9) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Serbian_LJE");
	FAIL;
#endif

#ifdef XK_Cyrillic_NJE
	if(test("XK_Cyrillic_NJE", XK_Cyrillic_NJE, 0x6BA) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_NJE");
	FAIL;
#endif

#ifdef XK_Serbian_NJE
	if(test("XK_Serbian_NJE", XK_Serbian_NJE, 0x6BA) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Serbian_NJE");
	FAIL;
#endif

#ifdef XK_Serbian_TSHE
	if(test("XK_Serbian_TSHE", XK_Serbian_TSHE, 0x6BB) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Serbian_TSHE");
	FAIL;
#endif

#ifdef XK_Macedonia_KJE
	if(test("XK_Macedonia_KJE", XK_Macedonia_KJE, 0x6BC) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Macedonia_KJE");
	FAIL;
#endif

#ifdef XK_Byelorussian_SHORTU
	if(test("XK_Byelorussian_SHORTU", XK_Byelorussian_SHORTU, 0x6BE) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Byelorussian_SHORTU");
	FAIL;
#endif

#ifdef XK_Cyrillic_DZHE
	if(test("XK_Cyrillic_DZHE", XK_Cyrillic_DZHE, 0x6BF) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_DZHE");
	FAIL;
#endif

#ifdef XK_Serbian_DZE
	if(test("XK_Serbian_DZE", XK_Serbian_DZE, 0x6BF) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Serbian_DZE");
	FAIL;
#endif

#ifdef XK_Cyrillic_yu
	if(test("XK_Cyrillic_yu", XK_Cyrillic_yu, 0x6C0) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_yu");
	FAIL;
#endif

#ifdef XK_Cyrillic_a
	if(test("XK_Cyrillic_a", XK_Cyrillic_a, 0x6C1) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_a");
	FAIL;
#endif

#ifdef XK_Cyrillic_be
	if(test("XK_Cyrillic_be", XK_Cyrillic_be, 0x6C2) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_be");
	FAIL;
#endif

#ifdef XK_Cyrillic_tse
	if(test("XK_Cyrillic_tse", XK_Cyrillic_tse, 0x6C3) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_tse");
	FAIL;
#endif

#ifdef XK_Cyrillic_de
	if(test("XK_Cyrillic_de", XK_Cyrillic_de, 0x6C4) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_de");
	FAIL;
#endif

#ifdef XK_Cyrillic_ie
	if(test("XK_Cyrillic_ie", XK_Cyrillic_ie, 0x6C5) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_ie");
	FAIL;
#endif

#ifdef XK_Cyrillic_ef
	if(test("XK_Cyrillic_ef", XK_Cyrillic_ef, 0x6C6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_ef");
	FAIL;
#endif

#ifdef XK_Cyrillic_ghe
	if(test("XK_Cyrillic_ghe", XK_Cyrillic_ghe, 0x6C7) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_ghe");
	FAIL;
#endif

#ifdef XK_Cyrillic_ha
	if(test("XK_Cyrillic_ha", XK_Cyrillic_ha, 0x6C8) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_ha");
	FAIL;
#endif

#ifdef XK_Cyrillic_i
	if(test("XK_Cyrillic_i", XK_Cyrillic_i, 0x6C9) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_i");
	FAIL;
#endif

#ifdef XK_Cyrillic_shorti
	if(test("XK_Cyrillic_shorti", XK_Cyrillic_shorti, 0x6CA) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_shorti");
	FAIL;
#endif

#ifdef XK_Cyrillic_ka
	if(test("XK_Cyrillic_ka", XK_Cyrillic_ka, 0x6CB) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_ka");
	FAIL;
#endif

#ifdef XK_Cyrillic_el
	if(test("XK_Cyrillic_el", XK_Cyrillic_el, 0x6CC) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_el");
	FAIL;
#endif

#ifdef XK_Cyrillic_em
	if(test("XK_Cyrillic_em", XK_Cyrillic_em, 0x6CD) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_em");
	FAIL;
#endif

#ifdef XK_Cyrillic_en
	if(test("XK_Cyrillic_en", XK_Cyrillic_en, 0x6CE) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_en");
	FAIL;
#endif

#ifdef XK_Cyrillic_o
	if(test("XK_Cyrillic_o", XK_Cyrillic_o, 0x6CF) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_o");
	FAIL;
#endif

#ifdef XK_Cyrillic_pe
	if(test("XK_Cyrillic_pe", XK_Cyrillic_pe, 0x6D0) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_pe");
	FAIL;
#endif

#ifdef XK_Cyrillic_ya
	if(test("XK_Cyrillic_ya", XK_Cyrillic_ya, 0x6D1) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_ya");
	FAIL;
#endif

#ifdef XK_Cyrillic_er
	if(test("XK_Cyrillic_er", XK_Cyrillic_er, 0x6D2) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_er");
	FAIL;
#endif

#ifdef XK_Cyrillic_es
	if(test("XK_Cyrillic_es", XK_Cyrillic_es, 0x6D3) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_es");
	FAIL;
#endif

#ifdef XK_Cyrillic_te
	if(test("XK_Cyrillic_te", XK_Cyrillic_te, 0x6D4) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_te");
	FAIL;
#endif

#ifdef XK_Cyrillic_u
	if(test("XK_Cyrillic_u", XK_Cyrillic_u, 0x6D5) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_u");
	FAIL;
#endif

#ifdef XK_Cyrillic_zhe
	if(test("XK_Cyrillic_zhe", XK_Cyrillic_zhe, 0x6D6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_zhe");
	FAIL;
#endif

#ifdef XK_Cyrillic_ve
	if(test("XK_Cyrillic_ve", XK_Cyrillic_ve, 0x6D7) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_ve");
	FAIL;
#endif

#ifdef XK_Cyrillic_softsign
	if(test("XK_Cyrillic_softsign", XK_Cyrillic_softsign, 0x6D8) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_softsign");
	FAIL;
#endif

#ifdef XK_Cyrillic_yeru
	if(test("XK_Cyrillic_yeru", XK_Cyrillic_yeru, 0x6D9) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_yeru");
	FAIL;
#endif

#ifdef XK_Cyrillic_ze
	if(test("XK_Cyrillic_ze", XK_Cyrillic_ze, 0x6DA) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_ze");
	FAIL;
#endif

#ifdef XK_Cyrillic_sha
	if(test("XK_Cyrillic_sha", XK_Cyrillic_sha, 0x6DB) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_sha");
	FAIL;
#endif

#ifdef XK_Cyrillic_e
	if(test("XK_Cyrillic_e", XK_Cyrillic_e, 0x6DC) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_e");
	FAIL;
#endif

#ifdef XK_Cyrillic_shcha
	if(test("XK_Cyrillic_shcha", XK_Cyrillic_shcha, 0x6DD) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_shcha");
	FAIL;
#endif

#ifdef XK_Cyrillic_che
	if(test("XK_Cyrillic_che", XK_Cyrillic_che, 0x6DE) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_che");
	FAIL;
#endif

#ifdef XK_Cyrillic_hardsign
	if(test("XK_Cyrillic_hardsign", XK_Cyrillic_hardsign, 0x6DF) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_hardsign");
	FAIL;
#endif

#ifdef XK_Cyrillic_YU
	if(test("XK_Cyrillic_YU", XK_Cyrillic_YU, 0x6E0) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_YU");
	FAIL;
#endif

#ifdef XK_Cyrillic_A
	if(test("XK_Cyrillic_A", XK_Cyrillic_A, 0x6E1) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_A");
	FAIL;
#endif

#ifdef XK_Cyrillic_BE
	if(test("XK_Cyrillic_BE", XK_Cyrillic_BE, 0x6E2) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_BE");
	FAIL;
#endif

#ifdef XK_Cyrillic_TSE
	if(test("XK_Cyrillic_TSE", XK_Cyrillic_TSE, 0x6E3) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_TSE");
	FAIL;
#endif

#ifdef XK_Cyrillic_DE
	if(test("XK_Cyrillic_DE", XK_Cyrillic_DE, 0x6E4) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_DE");
	FAIL;
#endif

#ifdef XK_Cyrillic_IE
	if(test("XK_Cyrillic_IE", XK_Cyrillic_IE, 0x6E5) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_IE");
	FAIL;
#endif

#ifdef XK_Cyrillic_EF
	if(test("XK_Cyrillic_EF", XK_Cyrillic_EF, 0x6E6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_EF");
	FAIL;
#endif

#ifdef XK_Cyrillic_GHE
	if(test("XK_Cyrillic_GHE", XK_Cyrillic_GHE, 0x6E7) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_GHE");
	FAIL;
#endif

#ifdef XK_Cyrillic_HA
	if(test("XK_Cyrillic_HA", XK_Cyrillic_HA, 0x6E8) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_HA");
	FAIL;
#endif

#ifdef XK_Cyrillic_I
	if(test("XK_Cyrillic_I", XK_Cyrillic_I, 0x6E9) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_I");
	FAIL;
#endif

#ifdef XK_Cyrillic_SHORTI
	if(test("XK_Cyrillic_SHORTI", XK_Cyrillic_SHORTI, 0x6EA) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_SHORTI");
	FAIL;
#endif

#ifdef XK_Cyrillic_KA
	if(test("XK_Cyrillic_KA", XK_Cyrillic_KA, 0x6EB) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_KA");
	FAIL;
#endif

#ifdef XK_Cyrillic_EL
	if(test("XK_Cyrillic_EL", XK_Cyrillic_EL, 0x6EC) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_EL");
	FAIL;
#endif

#ifdef XK_Cyrillic_EM
	if(test("XK_Cyrillic_EM", XK_Cyrillic_EM, 0x6ED) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_EM");
	FAIL;
#endif

#ifdef XK_Cyrillic_EN
	if(test("XK_Cyrillic_EN", XK_Cyrillic_EN, 0x6EE) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_EN");
	FAIL;
#endif

#ifdef XK_Cyrillic_O
	if(test("XK_Cyrillic_O", XK_Cyrillic_O, 0x6EF) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_O");
	FAIL;
#endif

#ifdef XK_Cyrillic_PE
	if(test("XK_Cyrillic_PE", XK_Cyrillic_PE, 0x6F0) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_PE");
	FAIL;
#endif

#ifdef XK_Cyrillic_YA
	if(test("XK_Cyrillic_YA", XK_Cyrillic_YA, 0x6F1) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_YA");
	FAIL;
#endif

#ifdef XK_Cyrillic_ER
	if(test("XK_Cyrillic_ER", XK_Cyrillic_ER, 0x6F2) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_ER");
	FAIL;
#endif

#ifdef XK_Cyrillic_ES
	if(test("XK_Cyrillic_ES", XK_Cyrillic_ES, 0x6F3) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_ES");
	FAIL;
#endif

#ifdef XK_Cyrillic_TE
	if(test("XK_Cyrillic_TE", XK_Cyrillic_TE, 0x6F4) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_TE");
	FAIL;
#endif

#ifdef XK_Cyrillic_U
	if(test("XK_Cyrillic_U", XK_Cyrillic_U, 0x6F5) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_U");
	FAIL;
#endif

#ifdef XK_Cyrillic_ZHE
	if(test("XK_Cyrillic_ZHE", XK_Cyrillic_ZHE, 0x6F6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_ZHE");
	FAIL;
#endif

#ifdef XK_Cyrillic_VE
	if(test("XK_Cyrillic_VE", XK_Cyrillic_VE, 0x6F7) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_VE");
	FAIL;
#endif

#ifdef XK_Cyrillic_SOFTSIGN
	if(test("XK_Cyrillic_SOFTSIGN", XK_Cyrillic_SOFTSIGN, 0x6F8) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_SOFTSIGN");
	FAIL;
#endif

#ifdef XK_Cyrillic_YERU
	if(test("XK_Cyrillic_YERU", XK_Cyrillic_YERU, 0x6F9) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_YERU");
	FAIL;
#endif

#ifdef XK_Cyrillic_ZE
	if(test("XK_Cyrillic_ZE", XK_Cyrillic_ZE, 0x6FA) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_ZE");
	FAIL;
#endif

#ifdef XK_Cyrillic_SHA
	if(test("XK_Cyrillic_SHA", XK_Cyrillic_SHA, 0x6FB) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_SHA");
	FAIL;
#endif

#ifdef XK_Cyrillic_E
	if(test("XK_Cyrillic_E", XK_Cyrillic_E, 0x6FC) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_E");
	FAIL;
#endif

#ifdef XK_Cyrillic_SHCHA
	if(test("XK_Cyrillic_SHCHA", XK_Cyrillic_SHCHA, 0x6FD) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_SHCHA");
	FAIL;
#endif

#ifdef XK_Cyrillic_CHE
	if(test("XK_Cyrillic_CHE", XK_Cyrillic_CHE, 0x6FE) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_CHE");
	FAIL;
#endif

#ifdef XK_Cyrillic_HARDSIGN
	if(test("XK_Cyrillic_HARDSIGN", XK_Cyrillic_HARDSIGN, 0x6FF) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cyrillic_HARDSIGN");
	FAIL;
#endif


	CHECKPASS(107);
}
