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
* $Header: /cvs/xtest/xtest/xts5/tset/Xopen/kysymtkycd/Test4.c,v 1.1 2005-02-12 14:37:43 anderson Exp $
* 
* Project: VSW5
* 
* File: vsw5/tset/Xopen/kysymtkycd/Test4.c
* 
* Description:
* 	Tests for XKeysymToKeycode()
* 
* Modifications:
* $Log: Test4.c,v $
* Revision 1.1  2005-02-12 14:37:43  anderson
* Initial revision
*
* Revision 8.0  1998/12/23 23:35:45  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:58:24  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:26:59  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:23:32  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.1  1996/05/09 21:17:34  andy
* Fixed X includes
*
* Revision 4.0  1995/12/15  09:14:07  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  01:17:28  andy
* Prepare for GA Release
*
*/
/*
 *      SCCS:  @(#)  Test4.c Rel 1.1	    (11/28/91)
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
#define XK_LATIN4
#include	<X11/keysymdef.h>
#undef XK_LATIN4 

kysymtcd4()
{ 
int 	pass = 0, fail = 0;

	XDisplayKeycodes(Dsp, &minkc, &maxkc);
	XGetKeyboardMapping(Dsp, (KeyCode)minkc, 1, &keysyms_per_keycode);

#ifdef XK_kra
	if(test(XK_kra, "kra") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("kra");
	FAIL;
#endif

#ifdef XK_kappa
	if(test(XK_kappa, "kappa") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("kappa");
	FAIL;
#endif

#ifdef XK_Rcedilla
	if(test(XK_Rcedilla, "Rcedilla") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Rcedilla");
	FAIL;
#endif

#ifdef XK_Itilde
	if(test(XK_Itilde, "Itilde") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Itilde");
	FAIL;
#endif

#ifdef XK_Lcedilla
	if(test(XK_Lcedilla, "Lcedilla") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Lcedilla");
	FAIL;
#endif

#ifdef XK_Emacron
	if(test(XK_Emacron, "Emacron") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Emacron");
	FAIL;
#endif

#ifdef XK_Gcedilla
	if(test(XK_Gcedilla, "Gcedilla") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Gcedilla");
	FAIL;
#endif

#ifdef XK_Tslash
	if(test(XK_Tslash, "Tslash") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Tslash");
	FAIL;
#endif

#ifdef XK_rcedilla
	if(test(XK_rcedilla, "rcedilla") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("rcedilla");
	FAIL;
#endif

#ifdef XK_itilde
	if(test(XK_itilde, "itilde") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("itilde");
	FAIL;
#endif

#ifdef XK_lcedilla
	if(test(XK_lcedilla, "lcedilla") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("lcedilla");
	FAIL;
#endif

#ifdef XK_emacron
	if(test(XK_emacron, "emacron") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("emacron");
	FAIL;
#endif

#ifdef XK_gcedilla
	if(test(XK_gcedilla, "gcedilla") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("gcedilla");
	FAIL;
#endif

#ifdef XK_tslash
	if(test(XK_tslash, "tslash") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("tslash");
	FAIL;
#endif

#ifdef XK_ENG
	if(test(XK_ENG, "ENG") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("ENG");
	FAIL;
#endif

#ifdef XK_eng
	if(test(XK_eng, "eng") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("eng");
	FAIL;
#endif

#ifdef XK_Amacron
	if(test(XK_Amacron, "Amacron") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Amacron");
	FAIL;
#endif

#ifdef XK_Iogonek
	if(test(XK_Iogonek, "Iogonek") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Iogonek");
	FAIL;
#endif

#ifdef XK_Eabovedot
	if(test(XK_Eabovedot, "Eabovedot") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Eabovedot");
	FAIL;
#endif

#ifdef XK_Imacron
	if(test(XK_Imacron, "Imacron") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Imacron");
	FAIL;
#endif

#ifdef XK_Ncedilla
	if(test(XK_Ncedilla, "Ncedilla") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Ncedilla");
	FAIL;
#endif

#ifdef XK_Omacron
	if(test(XK_Omacron, "Omacron") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Omacron");
	FAIL;
#endif

#ifdef XK_Kcedilla
	if(test(XK_Kcedilla, "Kcedilla") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Kcedilla");
	FAIL;
#endif

#ifdef XK_Uogonek
	if(test(XK_Uogonek, "Uogonek") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Uogonek");
	FAIL;
#endif

#ifdef XK_Utilde
	if(test(XK_Utilde, "Utilde") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Utilde");
	FAIL;
#endif

#ifdef XK_Umacron
	if(test(XK_Umacron, "Umacron") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Umacron");
	FAIL;
#endif

#ifdef XK_amacron
	if(test(XK_amacron, "amacron") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("amacron");
	FAIL;
#endif

#ifdef XK_iogonek
	if(test(XK_iogonek, "iogonek") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("iogonek");
	FAIL;
#endif

#ifdef XK_eabovedot
	if(test(XK_eabovedot, "eabovedot") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("eabovedot");
	FAIL;
#endif

#ifdef XK_imacron
	if(test(XK_imacron, "imacron") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("imacron");
	FAIL;
#endif

#ifdef XK_ncedilla
	if(test(XK_ncedilla, "ncedilla") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("ncedilla");
	FAIL;
#endif

#ifdef XK_omacron
	if(test(XK_omacron, "omacron") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("omacron");
	FAIL;
#endif

#ifdef XK_kcedilla
	if(test(XK_kcedilla, "kcedilla") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("kcedilla");
	FAIL;
#endif

#ifdef XK_uogonek
	if(test(XK_uogonek, "uogonek") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("uogonek");
	FAIL;
#endif

#ifdef XK_utilde
	if(test(XK_utilde, "utilde") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("utilde");
	FAIL;
#endif

#ifdef XK_umacron
	if(test(XK_umacron, "umacron") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("umacron");
	FAIL;
#endif

	CHECKPASS(36);
}
