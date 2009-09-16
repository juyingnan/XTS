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
* File: xts5/Xopen/XKeysymToKeycode/Test2.c
* 
* Description:
* 	Tests for XKeysymToKeycode()
* 
* Modifications:
* $Log: Test2.c,v $
* Revision 1.2  2005-11-03 08:44:00  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:40  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:35:44  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:58:22  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:26:58  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:23:31  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.1  1996/05/09 21:17:34  andy
* Fixed X includes
*
* Revision 4.0  1995/12/15  09:14:05  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  01:17:25  andy
* Prepare for GA Release
*
*/
/*
 *      SCCS:  @(#)  Test2.c Rel 1.1	    (11/28/91)
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
#define XK_LATIN2
#include	<X11/keysymdef.h>
#undef XK_LATIN2 

kysymtcd2()
{ 
int 	pass = 0, fail = 0;

	XDisplayKeycodes(Dsp, &minkc, &maxkc);
	XGetKeyboardMapping(Dsp, (KeyCode)minkc, 1, &keysyms_per_keycode);

#ifdef XK_Aogonek
	if(test(XK_Aogonek, "Aogonek") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Aogonek");
	FAIL;
#endif

#ifdef XK_breve
	if(test(XK_breve, "breve") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("breve");
	FAIL;
#endif

#ifdef XK_Lstroke
	if(test(XK_Lstroke, "Lstroke") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Lstroke");
	FAIL;
#endif

#ifdef XK_Lcaron
	if(test(XK_Lcaron, "Lcaron") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Lcaron");
	FAIL;
#endif

#ifdef XK_Sacute
	if(test(XK_Sacute, "Sacute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Sacute");
	FAIL;
#endif

#ifdef XK_Scaron
	if(test(XK_Scaron, "Scaron") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Scaron");
	FAIL;
#endif

#ifdef XK_Scedilla
	if(test(XK_Scedilla, "Scedilla") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Scedilla");
	FAIL;
#endif

#ifdef XK_Tcaron
	if(test(XK_Tcaron, "Tcaron") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Tcaron");
	FAIL;
#endif

#ifdef XK_Zacute
	if(test(XK_Zacute, "Zacute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Zacute");
	FAIL;
#endif

#ifdef XK_Zcaron
	if(test(XK_Zcaron, "Zcaron") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Zcaron");
	FAIL;
#endif

#ifdef XK_Zabovedot
	if(test(XK_Zabovedot, "Zabovedot") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Zabovedot");
	FAIL;
#endif

#ifdef XK_aogonek
	if(test(XK_aogonek, "aogonek") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("aogonek");
	FAIL;
#endif

#ifdef XK_ogonek
	if(test(XK_ogonek, "ogonek") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("ogonek");
	FAIL;
#endif

#ifdef XK_lstroke
	if(test(XK_lstroke, "lstroke") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("lstroke");
	FAIL;
#endif

#ifdef XK_lcaron
	if(test(XK_lcaron, "lcaron") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("lcaron");
	FAIL;
#endif

#ifdef XK_sacute
	if(test(XK_sacute, "sacute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("sacute");
	FAIL;
#endif

#ifdef XK_caron
	if(test(XK_caron, "caron") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("caron");
	FAIL;
#endif

#ifdef XK_scaron
	if(test(XK_scaron, "scaron") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("scaron");
	FAIL;
#endif

#ifdef XK_scedilla
	if(test(XK_scedilla, "scedilla") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("scedilla");
	FAIL;
#endif

#ifdef XK_tcaron
	if(test(XK_tcaron, "tcaron") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("tcaron");
	FAIL;
#endif

#ifdef XK_zacute
	if(test(XK_zacute, "zacute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("zacute");
	FAIL;
#endif

#ifdef XK_doubleacute
	if(test(XK_doubleacute, "doubleacute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("doubleacute");
	FAIL;
#endif

#ifdef XK_zcaron
	if(test(XK_zcaron, "zcaron") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("zcaron");
	FAIL;
#endif

#ifdef XK_zabovedot
	if(test(XK_zabovedot, "zabovedot") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("zabovedot");
	FAIL;
#endif

#ifdef XK_Racute
	if(test(XK_Racute, "Racute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Racute");
	FAIL;
#endif

#ifdef XK_Abreve
	if(test(XK_Abreve, "Abreve") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Abreve");
	FAIL;
#endif

#ifdef XK_Lacute
	if(test(XK_Lacute, "Lacute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Lacute");
	FAIL;
#endif

#ifdef XK_Cacute
	if(test(XK_Cacute, "Cacute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cacute");
	FAIL;
#endif

#ifdef XK_Ccaron
	if(test(XK_Ccaron, "Ccaron") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Ccaron");
	FAIL;
#endif

#ifdef XK_Eogonek
	if(test(XK_Eogonek, "Eogonek") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Eogonek");
	FAIL;
#endif

#ifdef XK_Ecaron
	if(test(XK_Ecaron, "Ecaron") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Ecaron");
	FAIL;
#endif

#ifdef XK_Dcaron
	if(test(XK_Dcaron, "Dcaron") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Dcaron");
	FAIL;
#endif

#ifdef XK_Dstroke
	if(test(XK_Dstroke, "Dstroke") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Dstroke");
	FAIL;
#endif

#ifdef XK_Nacute
	if(test(XK_Nacute, "Nacute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Nacute");
	FAIL;
#endif

#ifdef XK_Ncaron
	if(test(XK_Ncaron, "Ncaron") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Ncaron");
	FAIL;
#endif

#ifdef XK_Odoubleacute
	if(test(XK_Odoubleacute, "Odoubleacute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Odoubleacute");
	FAIL;
#endif

#ifdef XK_Rcaron
	if(test(XK_Rcaron, "Rcaron") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Rcaron");
	FAIL;
#endif

#ifdef XK_Uring
	if(test(XK_Uring, "Uring") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Uring");
	FAIL;
#endif

#ifdef XK_Udoubleacute
	if(test(XK_Udoubleacute, "Udoubleacute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Udoubleacute");
	FAIL;
#endif

#ifdef XK_Tcedilla
	if(test(XK_Tcedilla, "Tcedilla") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Tcedilla");
	FAIL;
#endif

#ifdef XK_racute
	if(test(XK_racute, "racute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("racute");
	FAIL;
#endif

#ifdef XK_abreve
	if(test(XK_abreve, "abreve") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("abreve");
	FAIL;
#endif

#ifdef XK_lacute
	if(test(XK_lacute, "lacute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("lacute");
	FAIL;
#endif

#ifdef XK_cacute
	if(test(XK_cacute, "cacute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("cacute");
	FAIL;
#endif

#ifdef XK_ccaron
	if(test(XK_ccaron, "ccaron") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("ccaron");
	FAIL;
#endif

#ifdef XK_eogonek
	if(test(XK_eogonek, "eogonek") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("eogonek");
	FAIL;
#endif

#ifdef XK_ecaron
	if(test(XK_ecaron, "ecaron") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("ecaron");
	FAIL;
#endif

#ifdef XK_dcaron
	if(test(XK_dcaron, "dcaron") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("dcaron");
	FAIL;
#endif

#ifdef XK_dstroke
	if(test(XK_dstroke, "dstroke") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("dstroke");
	FAIL;
#endif

#ifdef XK_nacute
	if(test(XK_nacute, "nacute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("nacute");
	FAIL;
#endif

#ifdef XK_ncaron
	if(test(XK_ncaron, "ncaron") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("ncaron");
	FAIL;
#endif

#ifdef XK_odoubleacute
	if(test(XK_odoubleacute, "odoubleacute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("odoubleacute");
	FAIL;
#endif

#ifdef XK_rcaron
	if(test(XK_rcaron, "rcaron") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("rcaron");
	FAIL;
#endif

#ifdef XK_uring
	if(test(XK_uring, "uring") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("uring");
	FAIL;
#endif

#ifdef XK_udoubleacute
	if(test(XK_udoubleacute, "udoubleacute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("udoubleacute");
	FAIL;
#endif

#ifdef XK_tcedilla
	if(test(XK_tcedilla, "tcedilla") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("tcedilla");
	FAIL;
#endif

#ifdef XK_abovedot
	if(test(XK_abovedot, "abovedot") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("abovedot");
	FAIL;
#endif

	CHECKPASS(57);
}
