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
* File: xts5/tset/Xopen/keysymdef/TestA.c
* 
* Description:
* 	Tests for keysymdef()
* 
* Modifications:
* $Log: TestA.c,v $
* Revision 1.2  2005-11-03 08:44:00  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:40  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:35:37  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:58:12  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:26:51  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:23:25  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.1  1996/05/09 21:16:18  andy
* Fixed X includes
*
* Revision 4.0  1995/12/15  09:13:45  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  01:17:02  andy
* Prepare for GA Release
*
*/
/*
 *      SCCS:  @(#)  TestA.c Rel 1.1	    (11/28/91)
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

#define XK_ARABIC
#include	<X11/keysymdef.h>
#undef XK_ARABIC 

kysymdf5()
{ 
int 	pass = 0, fail = 0;
#ifdef XK_Arabic_comma
	if(test("XK_Arabic_comma", XK_Arabic_comma, 0x5AC) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Arabic_comma");
	FAIL;
#endif

#ifdef XK_Arabic_semicolon
	if(test("XK_Arabic_semicolon", XK_Arabic_semicolon, 0x5BB) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Arabic_semicolon");
	FAIL;
#endif

#ifdef XK_Arabic_question_mark
	if(test("XK_Arabic_question_mark", XK_Arabic_question_mark, 0x5BF) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Arabic_question_mark");
	FAIL;
#endif

#ifdef XK_Arabic_hamza
	if(test("XK_Arabic_hamza", XK_Arabic_hamza, 0x5C1) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Arabic_hamza");
	FAIL;
#endif

#ifdef XK_Arabic_maddaonalef
	if(test("XK_Arabic_maddaonalef", XK_Arabic_maddaonalef, 0x5C2) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Arabic_maddaonalef");
	FAIL;
#endif

#ifdef XK_Arabic_hamzaonalef
	if(test("XK_Arabic_hamzaonalef", XK_Arabic_hamzaonalef, 0x5C3) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Arabic_hamzaonalef");
	FAIL;
#endif

#ifdef XK_Arabic_hamzaonwaw
	if(test("XK_Arabic_hamzaonwaw", XK_Arabic_hamzaonwaw, 0x5C4) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Arabic_hamzaonwaw");
	FAIL;
#endif

#ifdef XK_Arabic_hamzaunderalef
	if(test("XK_Arabic_hamzaunderalef", XK_Arabic_hamzaunderalef, 0x5C5) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Arabic_hamzaunderalef");
	FAIL;
#endif

#ifdef XK_Arabic_hamzaonyeh
	if(test("XK_Arabic_hamzaonyeh", XK_Arabic_hamzaonyeh, 0x5C6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Arabic_hamzaonyeh");
	FAIL;
#endif

#ifdef XK_Arabic_alef
	if(test("XK_Arabic_alef", XK_Arabic_alef, 0x5C7) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Arabic_alef");
	FAIL;
#endif

#ifdef XK_Arabic_beh
	if(test("XK_Arabic_beh", XK_Arabic_beh, 0x5C8) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Arabic_beh");
	FAIL;
#endif

#ifdef XK_Arabic_tehmarbuta
	if(test("XK_Arabic_tehmarbuta", XK_Arabic_tehmarbuta, 0x5C9) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Arabic_tehmarbuta");
	FAIL;
#endif

#ifdef XK_Arabic_teh
	if(test("XK_Arabic_teh", XK_Arabic_teh, 0x5CA) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Arabic_teh");
	FAIL;
#endif

#ifdef XK_Arabic_theh
	if(test("XK_Arabic_theh", XK_Arabic_theh, 0x5CB) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Arabic_theh");
	FAIL;
#endif

#ifdef XK_Arabic_jeem
	if(test("XK_Arabic_jeem", XK_Arabic_jeem, 0x5CC) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Arabic_jeem");
	FAIL;
#endif

#ifdef XK_Arabic_hah
	if(test("XK_Arabic_hah", XK_Arabic_hah, 0x5CD) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Arabic_hah");
	FAIL;
#endif

#ifdef XK_Arabic_khah
	if(test("XK_Arabic_khah", XK_Arabic_khah, 0x5CE) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Arabic_khah");
	FAIL;
#endif

#ifdef XK_Arabic_dal
	if(test("XK_Arabic_dal", XK_Arabic_dal, 0x5CF) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Arabic_dal");
	FAIL;
#endif

#ifdef XK_Arabic_thal
	if(test("XK_Arabic_thal", XK_Arabic_thal, 0x5D0) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Arabic_thal");
	FAIL;
#endif

#ifdef XK_Arabic_ra
	if(test("XK_Arabic_ra", XK_Arabic_ra, 0x5D1) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Arabic_ra");
	FAIL;
#endif

#ifdef XK_Arabic_zain
	if(test("XK_Arabic_zain", XK_Arabic_zain, 0x5D2) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Arabic_zain");
	FAIL;
#endif

#ifdef XK_Arabic_seen
	if(test("XK_Arabic_seen", XK_Arabic_seen, 0x5D3) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Arabic_seen");
	FAIL;
#endif

#ifdef XK_Arabic_sheen
	if(test("XK_Arabic_sheen", XK_Arabic_sheen, 0x5D4) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Arabic_sheen");
	FAIL;
#endif

#ifdef XK_Arabic_sad
	if(test("XK_Arabic_sad", XK_Arabic_sad, 0x5D5) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Arabic_sad");
	FAIL;
#endif

#ifdef XK_Arabic_dad
	if(test("XK_Arabic_dad", XK_Arabic_dad, 0x5D6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Arabic_dad");
	FAIL;
#endif

#ifdef XK_Arabic_tah
	if(test("XK_Arabic_tah", XK_Arabic_tah, 0x5D7) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Arabic_tah");
	FAIL;
#endif

#ifdef XK_Arabic_zah
	if(test("XK_Arabic_zah", XK_Arabic_zah, 0x5D8) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Arabic_zah");
	FAIL;
#endif

#ifdef XK_Arabic_ain
	if(test("XK_Arabic_ain", XK_Arabic_ain, 0x5D9) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Arabic_ain");
	FAIL;
#endif

#ifdef XK_Arabic_ghain
	if(test("XK_Arabic_ghain", XK_Arabic_ghain, 0x5DA) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Arabic_ghain");
	FAIL;
#endif

#ifdef XK_Arabic_tatweel
	if(test("XK_Arabic_tatweel", XK_Arabic_tatweel, 0x5E0) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Arabic_tatweel");
	FAIL;
#endif

#ifdef XK_Arabic_feh
	if(test("XK_Arabic_feh", XK_Arabic_feh, 0x5E1) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Arabic_feh");
	FAIL;
#endif

#ifdef XK_Arabic_qaf
	if(test("XK_Arabic_qaf", XK_Arabic_qaf, 0x5E2) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Arabic_qaf");
	FAIL;
#endif

#ifdef XK_Arabic_kaf
	if(test("XK_Arabic_kaf", XK_Arabic_kaf, 0x5E3) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Arabic_kaf");
	FAIL;
#endif

#ifdef XK_Arabic_lam
	if(test("XK_Arabic_lam", XK_Arabic_lam, 0x5E4) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Arabic_lam");
	FAIL;
#endif

#ifdef XK_Arabic_meem
	if(test("XK_Arabic_meem", XK_Arabic_meem, 0x5E5) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Arabic_meem");
	FAIL;
#endif

#ifdef XK_Arabic_noon
	if(test("XK_Arabic_noon", XK_Arabic_noon, 0x5E6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Arabic_noon");
	FAIL;
#endif

#ifdef XK_Arabic_ha
	if(test("XK_Arabic_ha", XK_Arabic_ha, 0x5E7) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Arabic_ha");
	FAIL;
#endif

#ifdef XK_Arabic_heh
	if(test("XK_Arabic_heh", XK_Arabic_heh, 0x5E7) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Arabic_heh");
	FAIL;
#endif

#ifdef XK_Arabic_waw
	if(test("XK_Arabic_waw", XK_Arabic_waw, 0x5E8) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Arabic_waw");
	FAIL;
#endif

#ifdef XK_Arabic_alefmaksura
	if(test("XK_Arabic_alefmaksura", XK_Arabic_alefmaksura, 0x5E9) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Arabic_alefmaksura");
	FAIL;
#endif

#ifdef XK_Arabic_yeh
	if(test("XK_Arabic_yeh", XK_Arabic_yeh, 0x5EA) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Arabic_yeh");
	FAIL;
#endif

#ifdef XK_Arabic_fathatan
	if(test("XK_Arabic_fathatan", XK_Arabic_fathatan, 0x5EB) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Arabic_fathatan");
	FAIL;
#endif

#ifdef XK_Arabic_dammatan
	if(test("XK_Arabic_dammatan", XK_Arabic_dammatan, 0x5EC) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Arabic_dammatan");
	FAIL;
#endif

#ifdef XK_Arabic_kasratan
	if(test("XK_Arabic_kasratan", XK_Arabic_kasratan, 0x5ED) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Arabic_kasratan");
	FAIL;
#endif

#ifdef XK_Arabic_fatha
	if(test("XK_Arabic_fatha", XK_Arabic_fatha, 0x5EE) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Arabic_fatha");
	FAIL;
#endif

#ifdef XK_Arabic_damma
	if(test("XK_Arabic_damma", XK_Arabic_damma, 0x5EF) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Arabic_damma");
	FAIL;
#endif

#ifdef XK_Arabic_kasra
	if(test("XK_Arabic_kasra", XK_Arabic_kasra, 0x5F0) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Arabic_kasra");
	FAIL;
#endif

#ifdef XK_Arabic_shadda
	if(test("XK_Arabic_shadda", XK_Arabic_shadda, 0x5F1) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Arabic_shadda");
	FAIL;
#endif

#ifdef XK_Arabic_sukun
	if(test("XK_Arabic_sukun", XK_Arabic_sukun, 0x5F2) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Arabic_sukun");
	FAIL;
#endif

#ifdef XK_Arabic_switch
	if(test("XK_Arabic_switch", XK_Arabic_switch, 0xFF7E) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Arabic_switch");
	FAIL;
#endif


	CHECKPASS(50);
}
