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
* File: xts5/tset/Xopen/XKeysymToKeycode/TestP.c
* 
* Description:
* 	Tests for XKeysymToKeycode()
* 
* Modifications:
* $Log: TestP.c,v $
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
* Revision 6.0  1998/03/02 05:27:02  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:23:36  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.1  1996/05/09 21:17:34  andy
* Fixed X includes
*
* Revision 4.0  1995/12/15  09:14:19  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  01:17:42  andy
* Prepare for GA Release
*
*/
/*
 *      SCCS:  @(#)  TestP.c Rel 1.1	    (11/28/91)
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
#define XK_PUBLISHING
#include	<X11/keysymdef.h>
#undef XK_PUBLISHING

kysymtcdP()
{ 
int 	pass = 0, fail = 0;

	XDisplayKeycodes(Dsp, &minkc, &maxkc);
	XGetKeyboardMapping(Dsp, (KeyCode)minkc, 1, &keysyms_per_keycode);

#ifdef XK_emspace
	if(test(XK_emspace, "emspace") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("emspace");
	FAIL;
#endif

#ifdef XK_enspace
	if(test(XK_enspace, "enspace") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("enspace");
	FAIL;
#endif

#ifdef XK_em3space
	if(test(XK_em3space, "em3space") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("em3space");
	FAIL;
#endif

#ifdef XK_em4space
	if(test(XK_em4space, "em4space") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("em4space");
	FAIL;
#endif

#ifdef XK_digitspace
	if(test(XK_digitspace, "digitspace") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("digitspace");
	FAIL;
#endif

#ifdef XK_punctspace
	if(test(XK_punctspace, "punctspace") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("punctspace");
	FAIL;
#endif

#ifdef XK_thinspace
	if(test(XK_thinspace, "thinspace") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("thinspace");
	FAIL;
#endif

#ifdef XK_hairspace
	if(test(XK_hairspace, "hairspace") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("hairspace");
	FAIL;
#endif

#ifdef XK_emdash
	if(test(XK_emdash, "emdash") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("emdash");
	FAIL;
#endif

#ifdef XK_endash
	if(test(XK_endash, "endash") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("endash");
	FAIL;
#endif

#ifdef XK_signifblank
	if(test(XK_signifblank, "signifblank") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("signifblank");
	FAIL;
#endif

#ifdef XK_ellipsis
	if(test(XK_ellipsis, "ellipsis") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("ellipsis");
	FAIL;
#endif

#ifdef XK_doubbaselinedot
	if(test(XK_doubbaselinedot, "doubbaselinedot") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("doubbaselinedot");
	FAIL;
#endif

#ifdef XK_onethird
	if(test(XK_onethird, "onethird") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("onethird");
	FAIL;
#endif

#ifdef XK_twothirds
	if(test(XK_twothirds, "twothirds") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("twothirds");
	FAIL;
#endif

#ifdef XK_onefifth
	if(test(XK_onefifth, "onefifth") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("onefifth");
	FAIL;
#endif

#ifdef XK_twofifths
	if(test(XK_twofifths, "twofifths") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("twofifths");
	FAIL;
#endif

#ifdef XK_threefifths
	if(test(XK_threefifths, "threefifths") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("threefifths");
	FAIL;
#endif

#ifdef XK_fourfifths
	if(test(XK_fourfifths, "fourfifths") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("fourfifths");
	FAIL;
#endif

#ifdef XK_onesixth
	if(test(XK_onesixth, "onesixth") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("onesixth");
	FAIL;
#endif

#ifdef XK_fivesixths
	if(test(XK_fivesixths, "fivesixths") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("fivesixths");
	FAIL;
#endif

#ifdef XK_careof
	if(test(XK_careof, "careof") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("careof");
	FAIL;
#endif

#ifdef XK_figdash
	if(test(XK_figdash, "figdash") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("figdash");
	FAIL;
#endif

#ifdef XK_leftanglebracket
	if(test(XK_leftanglebracket, "leftanglebracket") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("leftanglebracket");
	FAIL;
#endif

#ifdef XK_decimalpoint
	if(test(XK_decimalpoint, "decimalpoint") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("decimalpoint");
	FAIL;
#endif

#ifdef XK_rightanglebracket
	if(test(XK_rightanglebracket, "rightanglebracket") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("rightanglebracket");
	FAIL;
#endif

#ifdef XK_marker
	if(test(XK_marker, "marker") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("marker");
	FAIL;
#endif

#ifdef XK_oneeighth
	if(test(XK_oneeighth, "oneeighth") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("oneeighth");
	FAIL;
#endif

#ifdef XK_threeeighths
	if(test(XK_threeeighths, "threeeighths") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("threeeighths");
	FAIL;
#endif

#ifdef XK_fiveeighths
	if(test(XK_fiveeighths, "fiveeighths") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("fiveeighths");
	FAIL;
#endif

#ifdef XK_seveneighths
	if(test(XK_seveneighths, "seveneighths") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("seveneighths");
	FAIL;
#endif

#ifdef XK_trademark
	if(test(XK_trademark, "trademark") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("trademark");
	FAIL;
#endif

#ifdef XK_signaturemark
	if(test(XK_signaturemark, "signaturemark") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("signaturemark");
	FAIL;
#endif

#ifdef XK_trademarkincircle
	if(test(XK_trademarkincircle, "trademarkincircle") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("trademarkincircle");
	FAIL;
#endif

#ifdef XK_leftopentriangle
	if(test(XK_leftopentriangle, "leftopentriangle") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("leftopentriangle");
	FAIL;
#endif

#ifdef XK_rightopentriangle
	if(test(XK_rightopentriangle, "rightopentriangle") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("rightopentriangle");
	FAIL;
#endif

#ifdef XK_emopencircle
	if(test(XK_emopencircle, "emopencircle") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("emopencircle");
	FAIL;
#endif

#ifdef XK_emopenrectangle
	if(test(XK_emopenrectangle, "emopenrectangle") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("emopenrectangle");
	FAIL;
#endif

#ifdef XK_leftsinglequotemark
	if(test(XK_leftsinglequotemark, "leftsinglequotemark") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("leftsinglequotemark");
	FAIL;
#endif

#ifdef XK_rightsinglequotemark
	if(test(XK_rightsinglequotemark, "rightsinglequotemark") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("rightsinglequotemark");
	FAIL;
#endif

#ifdef XK_leftdoublequotemark
	if(test(XK_leftdoublequotemark, "leftdoublequotemark") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("leftdoublequotemark");
	FAIL;
#endif

#ifdef XK_rightdoublequotemark
	if(test(XK_rightdoublequotemark, "rightdoublequotemark") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("rightdoublequotemark");
	FAIL;
#endif

#ifdef XK_prescription
	if(test(XK_prescription, "prescription") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("prescription");
	FAIL;
#endif

#ifdef XK_minutes
	if(test(XK_minutes, "minutes") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("minutes");
	FAIL;
#endif

#ifdef XK_seconds
	if(test(XK_seconds, "seconds") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("seconds");
	FAIL;
#endif

#ifdef XK_latincross
	if(test(XK_latincross, "latincross") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("latincross");
	FAIL;
#endif

#ifdef XK_hexagram
	if(test(XK_hexagram, "hexagram") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("hexagram");
	FAIL;
#endif

#ifdef XK_filledrectbullet
	if(test(XK_filledrectbullet, "filledrectbullet") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("filledrectbullet");
	FAIL;
#endif

#ifdef XK_filledlefttribullet
	if(test(XK_filledlefttribullet, "filledlefttribullet") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("filledlefttribullet");
	FAIL;
#endif

#ifdef XK_filledrighttribullet
	if(test(XK_filledrighttribullet, "filledrighttribullet") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("filledrighttribullet");
	FAIL;
#endif

#ifdef XK_emfilledcircle
	if(test(XK_emfilledcircle, "emfilledcircle") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("emfilledcircle");
	FAIL;
#endif

#ifdef XK_emfilledrect
	if(test(XK_emfilledrect, "emfilledrect") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("emfilledrect");
	FAIL;
#endif

#ifdef XK_enopencircbullet
	if(test(XK_enopencircbullet, "enopencircbullet") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("enopencircbullet");
	FAIL;
#endif

#ifdef XK_enopensquarebullet
	if(test(XK_enopensquarebullet, "enopensquarebullet") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("enopensquarebullet");
	FAIL;
#endif

#ifdef XK_openrectbullet
	if(test(XK_openrectbullet, "openrectbullet") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("openrectbullet");
	FAIL;
#endif

#ifdef XK_opentribulletup
	if(test(XK_opentribulletup, "opentribulletup") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("opentribulletup");
	FAIL;
#endif

#ifdef XK_opentribulletdown
	if(test(XK_opentribulletdown, "opentribulletdown") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("opentribulletdown");
	FAIL;
#endif

#ifdef XK_openstar
	if(test(XK_openstar, "openstar") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("openstar");
	FAIL;
#endif

#ifdef XK_enfilledcircbullet
	if(test(XK_enfilledcircbullet, "enfilledcircbullet") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("enfilledcircbullet");
	FAIL;
#endif

#ifdef XK_enfilledsqbullet
	if(test(XK_enfilledsqbullet, "enfilledsqbullet") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("enfilledsqbullet");
	FAIL;
#endif

#ifdef XK_filledtribulletup
	if(test(XK_filledtribulletup, "filledtribulletup") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("filledtribulletup");
	FAIL;
#endif

#ifdef XK_filledtribulletdown
	if(test(XK_filledtribulletdown, "filledtribulletdown") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("filledtribulletdown");
	FAIL;
#endif

#ifdef XK_leftpointer
	if(test(XK_leftpointer, "leftpointer") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("leftpointer");
	FAIL;
#endif

#ifdef XK_rightpointer
	if(test(XK_rightpointer, "rightpointer") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("rightpointer");
	FAIL;
#endif

#ifdef XK_club
	if(test(XK_club, "club") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("club");
	FAIL;
#endif

#ifdef XK_diamond
	if(test(XK_diamond, "diamond") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("diamond");
	FAIL;
#endif

#ifdef XK_heart
	if(test(XK_heart, "heart") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("heart");
	FAIL;
#endif

#ifdef XK_maltesecross
	if(test(XK_maltesecross, "maltesecross") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("maltesecross");
	FAIL;
#endif

#ifdef XK_dagger
	if(test(XK_dagger, "dagger") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("dagger");
	FAIL;
#endif

#ifdef XK_doubledagger
	if(test(XK_doubledagger, "doubledagger") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("doubledagger");
	FAIL;
#endif

#ifdef XK_checkmark
	if(test(XK_checkmark, "checkmark") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("checkmark");
	FAIL;
#endif

#ifdef XK_ballotcross
	if(test(XK_ballotcross, "ballotcross") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("ballotcross");
	FAIL;
#endif

#ifdef XK_musicalsharp
	if(test(XK_musicalsharp, "musicalsharp") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("musicalsharp");
	FAIL;
#endif

#ifdef XK_musicalflat
	if(test(XK_musicalflat, "musicalflat") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("musicalflat");
	FAIL;
#endif

#ifdef XK_malesymbol
	if(test(XK_malesymbol, "malesymbol") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("malesymbol");
	FAIL;
#endif

#ifdef XK_femalesymbol
	if(test(XK_femalesymbol, "femalesymbol") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("femalesymbol");
	FAIL;
#endif

#ifdef XK_telephone
	if(test(XK_telephone, "telephone") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("telephone");
	FAIL;
#endif

#ifdef XK_telephonerecorder
	if(test(XK_telephonerecorder, "telephonerecorder") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("telephonerecorder");
	FAIL;
#endif

#ifdef XK_phonographcopyright
	if(test(XK_phonographcopyright, "phonographcopyright") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("phonographcopyright");
	FAIL;
#endif

#ifdef XK_caret
	if(test(XK_caret, "caret") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("caret");
	FAIL;
#endif

#ifdef XK_singlelowquotemark
	if(test(XK_singlelowquotemark, "singlelowquotemark") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("singlelowquotemark");
	FAIL;
#endif

#ifdef XK_doublelowquotemark
	if(test(XK_doublelowquotemark, "doublelowquotemark") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("doublelowquotemark");
	FAIL;
#endif

#ifdef XK_cursor
	if(test(XK_cursor, "cursor") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("cursor");
	FAIL;
#endif

	CHECKPASS(83);
}
