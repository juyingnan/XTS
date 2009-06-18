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
* $Header: /cvs/xtest/xtest/xts5/tset/Xopen/kysymtkycd/TestA.c,v 1.2 2005-11-03 08:44:00 jmichael Exp $
* 
* Project: VSW5
* 
* File: xts5/tset/Xopen/kysymtkycd/TestA.c
* 
* Description:
* 	Tests for XKeysymToKeycode()
* 
* Modifications:
* $Log: TestA.c,v $
* Revision 1.2  2005-11-03 08:44:00  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:40  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:35:45  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:58:25  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:26:59  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:23:33  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.1  1996/05/09 21:17:34  andy
* Fixed X includes
*
* Revision 4.0  1995/12/15  09:14:09  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  01:17:30  andy
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
#define XK_ARABIC
#include	<X11/keysymdef.h>
#undef XK_ARABIC 

kysymtcdA()
{ 
int 	pass = 0, fail = 0;

	XDisplayKeycodes(Dsp, &minkc, &maxkc);
	XGetKeyboardMapping(Dsp, (KeyCode)minkc, 1, &keysyms_per_keycode);

#ifdef XK_Arabic_comma
	if(test(XK_Arabic_comma, "Arabic_comma") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Arabic_comma");
	FAIL;
#endif

#ifdef XK_Arabic_semicolon
	if(test(XK_Arabic_semicolon, "Arabic_semicolon") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Arabic_semicolon");
	FAIL;
#endif

#ifdef XK_Arabic_question_mark
	if(test(XK_Arabic_question_mark, "Arabic_question_mark") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Arabic_question_mark");
	FAIL;
#endif

#ifdef XK_Arabic_hamza
	if(test(XK_Arabic_hamza, "Arabic_hamza") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Arabic_hamza");
	FAIL;
#endif

#ifdef XK_Arabic_maddaonalef
	if(test(XK_Arabic_maddaonalef, "Arabic_maddaonalef") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Arabic_maddaonalef");
	FAIL;
#endif

#ifdef XK_Arabic_hamzaonalef
	if(test(XK_Arabic_hamzaonalef, "Arabic_hamzaonalef") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Arabic_hamzaonalef");
	FAIL;
#endif

#ifdef XK_Arabic_hamzaonwaw
	if(test(XK_Arabic_hamzaonwaw, "Arabic_hamzaonwaw") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Arabic_hamzaonwaw");
	FAIL;
#endif

#ifdef XK_Arabic_hamzaunderalef
	if(test(XK_Arabic_hamzaunderalef, "Arabic_hamzaunderalef") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Arabic_hamzaunderalef");
	FAIL;
#endif

#ifdef XK_Arabic_hamzaonyeh
	if(test(XK_Arabic_hamzaonyeh, "Arabic_hamzaonyeh") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Arabic_hamzaonyeh");
	FAIL;
#endif

#ifdef XK_Arabic_alef
	if(test(XK_Arabic_alef, "Arabic_alef") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Arabic_alef");
	FAIL;
#endif

#ifdef XK_Arabic_beh
	if(test(XK_Arabic_beh, "Arabic_beh") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Arabic_beh");
	FAIL;
#endif

#ifdef XK_Arabic_tehmarbuta
	if(test(XK_Arabic_tehmarbuta, "Arabic_tehmarbuta") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Arabic_tehmarbuta");
	FAIL;
#endif

#ifdef XK_Arabic_teh
	if(test(XK_Arabic_teh, "Arabic_teh") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Arabic_teh");
	FAIL;
#endif

#ifdef XK_Arabic_theh
	if(test(XK_Arabic_theh, "Arabic_theh") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Arabic_theh");
	FAIL;
#endif

#ifdef XK_Arabic_jeem
	if(test(XK_Arabic_jeem, "Arabic_jeem") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Arabic_jeem");
	FAIL;
#endif

#ifdef XK_Arabic_hah
	if(test(XK_Arabic_hah, "Arabic_hah") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Arabic_hah");
	FAIL;
#endif

#ifdef XK_Arabic_khah
	if(test(XK_Arabic_khah, "Arabic_khah") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Arabic_khah");
	FAIL;
#endif

#ifdef XK_Arabic_dal
	if(test(XK_Arabic_dal, "Arabic_dal") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Arabic_dal");
	FAIL;
#endif

#ifdef XK_Arabic_thal
	if(test(XK_Arabic_thal, "Arabic_thal") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Arabic_thal");
	FAIL;
#endif

#ifdef XK_Arabic_ra
	if(test(XK_Arabic_ra, "Arabic_ra") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Arabic_ra");
	FAIL;
#endif

#ifdef XK_Arabic_zain
	if(test(XK_Arabic_zain, "Arabic_zain") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Arabic_zain");
	FAIL;
#endif

#ifdef XK_Arabic_seen
	if(test(XK_Arabic_seen, "Arabic_seen") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Arabic_seen");
	FAIL;
#endif

#ifdef XK_Arabic_sheen
	if(test(XK_Arabic_sheen, "Arabic_sheen") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Arabic_sheen");
	FAIL;
#endif

#ifdef XK_Arabic_sad
	if(test(XK_Arabic_sad, "Arabic_sad") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Arabic_sad");
	FAIL;
#endif

#ifdef XK_Arabic_dad
	if(test(XK_Arabic_dad, "Arabic_dad") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Arabic_dad");
	FAIL;
#endif

#ifdef XK_Arabic_tah
	if(test(XK_Arabic_tah, "Arabic_tah") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Arabic_tah");
	FAIL;
#endif

#ifdef XK_Arabic_zah
	if(test(XK_Arabic_zah, "Arabic_zah") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Arabic_zah");
	FAIL;
#endif

#ifdef XK_Arabic_ain
	if(test(XK_Arabic_ain, "Arabic_ain") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Arabic_ain");
	FAIL;
#endif

#ifdef XK_Arabic_ghain
	if(test(XK_Arabic_ghain, "Arabic_ghain") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Arabic_ghain");
	FAIL;
#endif

#ifdef XK_Arabic_tatweel
	if(test(XK_Arabic_tatweel, "Arabic_tatweel") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Arabic_tatweel");
	FAIL;
#endif

#ifdef XK_Arabic_feh
	if(test(XK_Arabic_feh, "Arabic_feh") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Arabic_feh");
	FAIL;
#endif

#ifdef XK_Arabic_qaf
	if(test(XK_Arabic_qaf, "Arabic_qaf") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Arabic_qaf");
	FAIL;
#endif

#ifdef XK_Arabic_kaf
	if(test(XK_Arabic_kaf, "Arabic_kaf") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Arabic_kaf");
	FAIL;
#endif

#ifdef XK_Arabic_lam
	if(test(XK_Arabic_lam, "Arabic_lam") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Arabic_lam");
	FAIL;
#endif

#ifdef XK_Arabic_meem
	if(test(XK_Arabic_meem, "Arabic_meem") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Arabic_meem");
	FAIL;
#endif

#ifdef XK_Arabic_noon
	if(test(XK_Arabic_noon, "Arabic_noon") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Arabic_noon");
	FAIL;
#endif

#ifdef XK_Arabic_ha
	if(test(XK_Arabic_ha, "Arabic_ha") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Arabic_ha");
	FAIL;
#endif

#ifdef XK_Arabic_heh
	if(test(XK_Arabic_heh, "Arabic_heh") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Arabic_heh");
	FAIL;
#endif

#ifdef XK_Arabic_waw
	if(test(XK_Arabic_waw, "Arabic_waw") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Arabic_waw");
	FAIL;
#endif

#ifdef XK_Arabic_alefmaksura
	if(test(XK_Arabic_alefmaksura, "Arabic_alefmaksura") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Arabic_alefmaksura");
	FAIL;
#endif

#ifdef XK_Arabic_yeh
	if(test(XK_Arabic_yeh, "Arabic_yeh") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Arabic_yeh");
	FAIL;
#endif

#ifdef XK_Arabic_fathatan
	if(test(XK_Arabic_fathatan, "Arabic_fathatan") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Arabic_fathatan");
	FAIL;
#endif

#ifdef XK_Arabic_dammatan
	if(test(XK_Arabic_dammatan, "Arabic_dammatan") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Arabic_dammatan");
	FAIL;
#endif

#ifdef XK_Arabic_kasratan
	if(test(XK_Arabic_kasratan, "Arabic_kasratan") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Arabic_kasratan");
	FAIL;
#endif

#ifdef XK_Arabic_fatha
	if(test(XK_Arabic_fatha, "Arabic_fatha") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Arabic_fatha");
	FAIL;
#endif

#ifdef XK_Arabic_damma
	if(test(XK_Arabic_damma, "Arabic_damma") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Arabic_damma");
	FAIL;
#endif

#ifdef XK_Arabic_kasra
	if(test(XK_Arabic_kasra, "Arabic_kasra") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Arabic_kasra");
	FAIL;
#endif

#ifdef XK_Arabic_shadda
	if(test(XK_Arabic_shadda, "Arabic_shadda") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Arabic_shadda");
	FAIL;
#endif

#ifdef XK_Arabic_sukun
	if(test(XK_Arabic_sukun, "Arabic_sukun") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Arabic_sukun");
	FAIL;
#endif

#ifdef XK_Arabic_switch
	if(test(XK_Arabic_switch, "Arabic_switch") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Arabic_switch");
	FAIL;
#endif

	CHECKPASS(50);
}
