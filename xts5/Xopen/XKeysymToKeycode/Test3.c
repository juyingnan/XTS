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
* File: xts5/Xopen/XKeysymToKeycode/Test3.c
* 
* Description:
* 	Tests for XKeysymToKeycode()
* 
* Modifications:
* $Log: Test3.c,v $
* Revision 1.2  2005-11-03 08:44:00  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:40  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:35:44  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:58:23  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:26:58  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:23:32  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.1  1996/05/09 21:17:34  andy
* Fixed X includes
*
* Revision 4.0  1995/12/15  09:14:06  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  01:17:27  andy
* Prepare for GA Release
*
*/
/*
 *      SCCS:  @(#)  Test3.c Rel 1.1	    (11/28/91)
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
#define XK_LATIN3
#include	<X11/keysymdef.h>
#undef XK_LATIN3 

kysymtcd3()
{ 
int 	pass = 0, fail = 0;

	XDisplayKeycodes(Dsp, &minkc, &maxkc);
	XGetKeyboardMapping(Dsp, (KeyCode)minkc, 1, &keysyms_per_keycode);

#ifdef XK_Hstroke
	if(test(XK_Hstroke, "Hstroke") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Hstroke");
	FAIL;
#endif

#ifdef XK_Hcircumflex
	if(test(XK_Hcircumflex, "Hcircumflex") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Hcircumflex");
	FAIL;
#endif

#ifdef XK_Iabovedot
	if(test(XK_Iabovedot, "Iabovedot") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Iabovedot");
	FAIL;
#endif

#ifdef XK_Gbreve
	if(test(XK_Gbreve, "Gbreve") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Gbreve");
	FAIL;
#endif

#ifdef XK_Jcircumflex
	if(test(XK_Jcircumflex, "Jcircumflex") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Jcircumflex");
	FAIL;
#endif

#ifdef XK_hstroke
	if(test(XK_hstroke, "hstroke") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("hstroke");
	FAIL;
#endif

#ifdef XK_hcircumflex
	if(test(XK_hcircumflex, "hcircumflex") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("hcircumflex");
	FAIL;
#endif

#ifdef XK_idotless
	if(test(XK_idotless, "idotless") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("idotless");
	FAIL;
#endif

#ifdef XK_gbreve
	if(test(XK_gbreve, "gbreve") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("gbreve");
	FAIL;
#endif

#ifdef XK_jcircumflex
	if(test(XK_jcircumflex, "jcircumflex") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("jcircumflex");
	FAIL;
#endif

#ifdef XK_Cabovedot
	if(test(XK_Cabovedot, "Cabovedot") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cabovedot");
	FAIL;
#endif

#ifdef XK_Ccircumflex
	if(test(XK_Ccircumflex, "Ccircumflex") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Ccircumflex");
	FAIL;
#endif

#ifdef XK_Gabovedot
	if(test(XK_Gabovedot, "Gabovedot") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Gabovedot");
	FAIL;
#endif

#ifdef XK_Gcircumflex
	if(test(XK_Gcircumflex, "Gcircumflex") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Gcircumflex");
	FAIL;
#endif

#ifdef XK_Ubreve
	if(test(XK_Ubreve, "Ubreve") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Ubreve");
	FAIL;
#endif

#ifdef XK_Scircumflex
	if(test(XK_Scircumflex, "Scircumflex") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Scircumflex");
	FAIL;
#endif

#ifdef XK_cabovedot
	if(test(XK_cabovedot, "cabovedot") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("cabovedot");
	FAIL;
#endif

#ifdef XK_ccircumflex
	if(test(XK_ccircumflex, "ccircumflex") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("ccircumflex");
	FAIL;
#endif

#ifdef XK_gabovedot
	if(test(XK_gabovedot, "gabovedot") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("gabovedot");
	FAIL;
#endif

#ifdef XK_gcircumflex
	if(test(XK_gcircumflex, "gcircumflex") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("gcircumflex");
	FAIL;
#endif

#ifdef XK_ubreve
	if(test(XK_ubreve, "ubreve") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("ubreve");
	FAIL;
#endif

#ifdef XK_scircumflex
	if(test(XK_scircumflex, "scircumflex") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("scircumflex");
	FAIL;
#endif

	CHECKPASS(22);
}
