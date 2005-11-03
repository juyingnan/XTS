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
* $Header: /cvs/xtest/xtest/xts5/tset/Xopen/kysymtkycd/TestS.c,v 1.2 2005-11-03 08:44:00 jmichael Exp $
* 
* Project: VSW5
* 
* File: xts5/tset/Xopen/kysymtkycd/TestS.c
* 
* Description:
* 	Tests for XKeysymToKeycode()
* 
* Modifications:
* $Log: TestS.c,v $
* Revision 1.2  2005-11-03 08:44:00  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:40  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:35:49  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:58:30  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:27:03  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:23:36  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.1  1996/05/09 21:17:34  andy
* Fixed X includes
*
* Revision 4.0  1995/12/15  09:14:20  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  01:17:43  andy
* Prepare for GA Release
*
*/
/*
 *      SCCS:  @(#)  TestS.c Rel 1.1	    (11/28/91)
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
#define XK_SPECIAL
#include	<X11/keysymdef.h>
#undef XK_SPECIAL

kysymtcdS()
{ 
int 	pass = 0, fail = 0;

	XDisplayKeycodes(Dsp, &minkc, &maxkc);
	XGetKeyboardMapping(Dsp, (KeyCode)minkc, 1, &keysyms_per_keycode);

#ifdef XK_blank
	if(test(XK_blank, "blank") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("blank");
	FAIL;
#endif

#ifdef XK_soliddiamond
	if(test(XK_soliddiamond, "soliddiamond") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("soliddiamond");
	FAIL;
#endif

#ifdef XK_checkerboard
	if(test(XK_checkerboard, "checkerboard") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("checkerboard");
	FAIL;
#endif

#ifdef XK_ht
	if(test(XK_ht, "ht") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("ht");
	FAIL;
#endif

#ifdef XK_ff
	if(test(XK_ff, "ff") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("ff");
	FAIL;
#endif

#ifdef XK_cr
	if(test(XK_cr, "cr") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("cr");
	FAIL;
#endif

#ifdef XK_lf
	if(test(XK_lf, "lf") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("lf");
	FAIL;
#endif

#ifdef XK_nl
	if(test(XK_nl, "nl") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("nl");
	FAIL;
#endif

#ifdef XK_vt
	if(test(XK_vt, "vt") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("vt");
	FAIL;
#endif

#ifdef XK_lowrightcorner
	if(test(XK_lowrightcorner, "lowrightcorner") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("lowrightcorner");
	FAIL;
#endif

#ifdef XK_uprightcorner
	if(test(XK_uprightcorner, "uprightcorner") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("uprightcorner");
	FAIL;
#endif

#ifdef XK_upleftcorner
	if(test(XK_upleftcorner, "upleftcorner") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("upleftcorner");
	FAIL;
#endif

#ifdef XK_lowleftcorner
	if(test(XK_lowleftcorner, "lowleftcorner") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("lowleftcorner");
	FAIL;
#endif

#ifdef XK_crossinglines
	if(test(XK_crossinglines, "crossinglines") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("crossinglines");
	FAIL;
#endif

#ifdef XK_horizlinescan1
	if(test(XK_horizlinescan1, "horizlinescan1") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("horizlinescan1");
	FAIL;
#endif

#ifdef XK_horizlinescan3
	if(test(XK_horizlinescan3, "horizlinescan3") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("horizlinescan3");
	FAIL;
#endif

#ifdef XK_horizlinescan5
	if(test(XK_horizlinescan5, "horizlinescan5") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("horizlinescan5");
	FAIL;
#endif

#ifdef XK_horizlinescan7
	if(test(XK_horizlinescan7, "horizlinescan7") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("horizlinescan7");
	FAIL;
#endif

#ifdef XK_horizlinescan9
	if(test(XK_horizlinescan9, "horizlinescan9") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("horizlinescan9");
	FAIL;
#endif

#ifdef XK_leftt
	if(test(XK_leftt, "leftt") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("leftt");
	FAIL;
#endif

#ifdef XK_rightt
	if(test(XK_rightt, "rightt") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("rightt");
	FAIL;
#endif

#ifdef XK_bott
	if(test(XK_bott, "bott") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("bott");
	FAIL;
#endif

#ifdef XK_topt
	if(test(XK_topt, "topt") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("topt");
	FAIL;
#endif

#ifdef XK_vertbar
	if(test(XK_vertbar, "vertbar") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("vertbar");
	FAIL;
#endif

	CHECKPASS(24);
}
