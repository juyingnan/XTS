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
* $Header: /cvs/xtest/xtest/xts5/tset/Xopen/kysymdf/TestP.c,v 1.1 2005-02-12 14:37:43 anderson Exp $
* 
* Project: VSW5
* 
* File: vsw5/tset/Xopen/kysymdf/TestP.c
* 
* Description:
* 	Tests for keysymdef()
* 
* Modifications:
* $Log: TestP.c,v $
* Revision 1.1  2005-02-12 14:37:43  anderson
* Initial revision
*
* Revision 8.0  1998/12/23 23:35:41  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:58:17  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:26:55  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:23:28  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.1  1996/05/09 21:16:18  andy
* Fixed X includes
*
* Revision 4.0  1995/12/15  09:13:55  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  01:17:14  andy
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

#define XK_PUBLISHING
#include	<X11/keysymdef.h>
#undef XK_PUBLISHING

kysymdf12()
{ 
int 	pass = 0, fail = 0;
#ifdef XK_emspace
	if(test("XK_emspace", XK_emspace, 0xAA1) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_emspace");
	FAIL;
#endif

#ifdef XK_enspace
	if(test("XK_enspace", XK_enspace, 0xAA2) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_enspace");
	FAIL;
#endif

#ifdef XK_em3space
	if(test("XK_em3space", XK_em3space, 0xAA3) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_em3space");
	FAIL;
#endif

#ifdef XK_em4space
	if(test("XK_em4space", XK_em4space, 0xAA4) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_em4space");
	FAIL;
#endif

#ifdef XK_digitspace
	if(test("XK_digitspace", XK_digitspace, 0xAA5) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_digitspace");
	FAIL;
#endif

#ifdef XK_punctspace
	if(test("XK_punctspace", XK_punctspace, 0xAA6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_punctspace");
	FAIL;
#endif

#ifdef XK_thinspace
	if(test("XK_thinspace", XK_thinspace, 0xAA7) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_thinspace");
	FAIL;
#endif

#ifdef XK_hairspace
	if(test("XK_hairspace", XK_hairspace, 0xAA8) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_hairspace");
	FAIL;
#endif

#ifdef XK_emdash
	if(test("XK_emdash", XK_emdash, 0xAA9) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_emdash");
	FAIL;
#endif

#ifdef XK_endash
	if(test("XK_endash", XK_endash, 0xAAA) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_endash");
	FAIL;
#endif

#ifdef XK_signifblank
	if(test("XK_signifblank", XK_signifblank, 0xAAC) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_signifblank");
	FAIL;
#endif

#ifdef XK_ellipsis
	if(test("XK_ellipsis", XK_ellipsis, 0xAAE) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_ellipsis");
	FAIL;
#endif

#ifdef XK_doubbaselinedot
	if(test("XK_doubbaselinedot", XK_doubbaselinedot, 0xAAF) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_doubbaselinedot");
	FAIL;
#endif

#ifdef XK_onethird
	if(test("XK_onethird", XK_onethird, 0xAB0) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_onethird");
	FAIL;
#endif

#ifdef XK_twothirds
	if(test("XK_twothirds", XK_twothirds, 0xAB1) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_twothirds");
	FAIL;
#endif

#ifdef XK_onefifth
	if(test("XK_onefifth", XK_onefifth, 0xAB2) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_onefifth");
	FAIL;
#endif

#ifdef XK_twofifths
	if(test("XK_twofifths", XK_twofifths, 0xAB3) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_twofifths");
	FAIL;
#endif

#ifdef XK_threefifths
	if(test("XK_threefifths", XK_threefifths, 0xAB4) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_threefifths");
	FAIL;
#endif

#ifdef XK_fourfifths
	if(test("XK_fourfifths", XK_fourfifths, 0xAB5) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_fourfifths");
	FAIL;
#endif

#ifdef XK_onesixth
	if(test("XK_onesixth", XK_onesixth, 0xAB6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_onesixth");
	FAIL;
#endif

#ifdef XK_fivesixths
	if(test("XK_fivesixths", XK_fivesixths, 0xAB7) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_fivesixths");
	FAIL;
#endif

#ifdef XK_careof
	if(test("XK_careof", XK_careof, 0xAB8) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_careof");
	FAIL;
#endif

#ifdef XK_figdash
	if(test("XK_figdash", XK_figdash, 0xABB) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_figdash");
	FAIL;
#endif

#ifdef XK_leftanglebracket
	if(test("XK_leftanglebracket", XK_leftanglebracket, 0xABC) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_leftanglebracket");
	FAIL;
#endif

#ifdef XK_decimalpoint
	if(test("XK_decimalpoint", XK_decimalpoint, 0xABD) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_decimalpoint");
	FAIL;
#endif

#ifdef XK_rightanglebracket
	if(test("XK_rightanglebracket", XK_rightanglebracket, 0xABE) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_rightanglebracket");
	FAIL;
#endif

#ifdef XK_marker
	if(test("XK_marker", XK_marker, 0xABF) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_marker");
	FAIL;
#endif

#ifdef XK_oneeighth
	if(test("XK_oneeighth", XK_oneeighth, 0xAC3) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_oneeighth");
	FAIL;
#endif

#ifdef XK_threeeighths
	if(test("XK_threeeighths", XK_threeeighths, 0xAC4) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_threeeighths");
	FAIL;
#endif

#ifdef XK_fiveeighths
	if(test("XK_fiveeighths", XK_fiveeighths, 0xAC5) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_fiveeighths");
	FAIL;
#endif

#ifdef XK_seveneighths
	if(test("XK_seveneighths", XK_seveneighths, 0xAC6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_seveneighths");
	FAIL;
#endif

#ifdef XK_trademark
	if(test("XK_trademark", XK_trademark, 0xAC9) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_trademark");
	FAIL;
#endif

#ifdef XK_signaturemark
	if(test("XK_signaturemark", XK_signaturemark, 0xACA) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_signaturemark");
	FAIL;
#endif

#ifdef XK_trademarkincircle
	if(test("XK_trademarkincircle", XK_trademarkincircle, 0xACB) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_trademarkincircle");
	FAIL;
#endif

#ifdef XK_leftopentriangle
	if(test("XK_leftopentriangle", XK_leftopentriangle, 0xACC) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_leftopentriangle");
	FAIL;
#endif

#ifdef XK_rightopentriangle
	if(test("XK_rightopentriangle", XK_rightopentriangle, 0xACD) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_rightopentriangle");
	FAIL;
#endif

#ifdef XK_emopencircle
	if(test("XK_emopencircle", XK_emopencircle, 0xACE) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_emopencircle");
	FAIL;
#endif

#ifdef XK_emopenrectangle
	if(test("XK_emopenrectangle", XK_emopenrectangle, 0xACF) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_emopenrectangle");
	FAIL;
#endif

#ifdef XK_leftsinglequotemark
	if(test("XK_leftsinglequotemark", XK_leftsinglequotemark, 0xAD0) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_leftsinglequotemark");
	FAIL;
#endif

#ifdef XK_rightsinglequotemark
	if(test("XK_rightsinglequotemark", XK_rightsinglequotemark, 0xAD1) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_rightsinglequotemark");
	FAIL;
#endif

#ifdef XK_leftdoublequotemark
	if(test("XK_leftdoublequotemark", XK_leftdoublequotemark, 0xAD2) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_leftdoublequotemark");
	FAIL;
#endif

#ifdef XK_rightdoublequotemark
	if(test("XK_rightdoublequotemark", XK_rightdoublequotemark, 0xAD3) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_rightdoublequotemark");
	FAIL;
#endif

#ifdef XK_prescription
	if(test("XK_prescription", XK_prescription, 0xAD4) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_prescription");
	FAIL;
#endif

#ifdef XK_minutes
	if(test("XK_minutes", XK_minutes, 0xAD6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_minutes");
	FAIL;
#endif

#ifdef XK_seconds
	if(test("XK_seconds", XK_seconds, 0xAD7) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_seconds");
	FAIL;
#endif

#ifdef XK_latincross
	if(test("XK_latincross", XK_latincross, 0xAD9) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_latincross");
	FAIL;
#endif

#ifdef XK_hexagram
	if(test("XK_hexagram", XK_hexagram, 0xADA) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_hexagram");
	FAIL;
#endif

#ifdef XK_filledrectbullet
	if(test("XK_filledrectbullet", XK_filledrectbullet, 0xADB) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_filledrectbullet");
	FAIL;
#endif

#ifdef XK_filledlefttribullet
	if(test("XK_filledlefttribullet", XK_filledlefttribullet, 0xADC) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_filledlefttribullet");
	FAIL;
#endif

#ifdef XK_filledrighttribullet
	if(test("XK_filledrighttribullet", XK_filledrighttribullet, 0xADD) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_filledrighttribullet");
	FAIL;
#endif

#ifdef XK_emfilledcircle
	if(test("XK_emfilledcircle", XK_emfilledcircle, 0xADE) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_emfilledcircle");
	FAIL;
#endif

#ifdef XK_emfilledrect
	if(test("XK_emfilledrect", XK_emfilledrect, 0xADF) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_emfilledrect");
	FAIL;
#endif

#ifdef XK_enopencircbullet
	if(test("XK_enopencircbullet", XK_enopencircbullet, 0xAE0) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_enopencircbullet");
	FAIL;
#endif

#ifdef XK_enopensquarebullet
	if(test("XK_enopensquarebullet", XK_enopensquarebullet, 0xAE1) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_enopensquarebullet");
	FAIL;
#endif

#ifdef XK_openrectbullet
	if(test("XK_openrectbullet", XK_openrectbullet, 0xAE2) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_openrectbullet");
	FAIL;
#endif

#ifdef XK_opentribulletup
	if(test("XK_opentribulletup", XK_opentribulletup, 0xAE3) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_opentribulletup");
	FAIL;
#endif

#ifdef XK_opentribulletdown
	if(test("XK_opentribulletdown", XK_opentribulletdown, 0xAE4) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_opentribulletdown");
	FAIL;
#endif

#ifdef XK_openstar
	if(test("XK_openstar", XK_openstar, 0xAE5) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_openstar");
	FAIL;
#endif

#ifdef XK_enfilledcircbullet
	if(test("XK_enfilledcircbullet", XK_enfilledcircbullet, 0xAE6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_enfilledcircbullet");
	FAIL;
#endif

#ifdef XK_enfilledsqbullet
	if(test("XK_enfilledsqbullet", XK_enfilledsqbullet, 0xAE7) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_enfilledsqbullet");
	FAIL;
#endif

#ifdef XK_filledtribulletup
	if(test("XK_filledtribulletup", XK_filledtribulletup, 0xAE8) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_filledtribulletup");
	FAIL;
#endif

#ifdef XK_filledtribulletdown
	if(test("XK_filledtribulletdown", XK_filledtribulletdown, 0xAE9) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_filledtribulletdown");
	FAIL;
#endif

#ifdef XK_leftpointer
	if(test("XK_leftpointer", XK_leftpointer, 0xAEA) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_leftpointer");
	FAIL;
#endif

#ifdef XK_rightpointer
	if(test("XK_rightpointer", XK_rightpointer, 0xAEB) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_rightpointer");
	FAIL;
#endif

#ifdef XK_club
	if(test("XK_club", XK_club, 0xAEC) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_club");
	FAIL;
#endif

#ifdef XK_diamond
	if(test("XK_diamond", XK_diamond, 0xAED) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_diamond");
	FAIL;
#endif

#ifdef XK_heart
	if(test("XK_heart", XK_heart, 0xAEE) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_heart");
	FAIL;
#endif

#ifdef XK_maltesecross
	if(test("XK_maltesecross", XK_maltesecross, 0xAF0) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_maltesecross");
	FAIL;
#endif

#ifdef XK_dagger
	if(test("XK_dagger", XK_dagger, 0xAF1) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_dagger");
	FAIL;
#endif

#ifdef XK_doubledagger
	if(test("XK_doubledagger", XK_doubledagger, 0xAF2) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_doubledagger");
	FAIL;
#endif

#ifdef XK_checkmark
	if(test("XK_checkmark", XK_checkmark, 0xAF3) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_checkmark");
	FAIL;
#endif

#ifdef XK_ballotcross
	if(test("XK_ballotcross", XK_ballotcross, 0xAF4) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_ballotcross");
	FAIL;
#endif

#ifdef XK_musicalsharp
	if(test("XK_musicalsharp", XK_musicalsharp, 0xAF5) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_musicalsharp");
	FAIL;
#endif

#ifdef XK_musicalflat
	if(test("XK_musicalflat", XK_musicalflat, 0xAF6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_musicalflat");
	FAIL;
#endif

#ifdef XK_malesymbol
	if(test("XK_malesymbol", XK_malesymbol, 0xAF7) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_malesymbol");
	FAIL;
#endif

#ifdef XK_femalesymbol
	if(test("XK_femalesymbol", XK_femalesymbol, 0xAF8) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_femalesymbol");
	FAIL;
#endif

#ifdef XK_telephone
	if(test("XK_telephone", XK_telephone, 0xAF9) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_telephone");
	FAIL;
#endif

#ifdef XK_telephonerecorder
	if(test("XK_telephonerecorder", XK_telephonerecorder, 0xAFA) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_telephonerecorder");
	FAIL;
#endif

#ifdef XK_phonographcopyright
	if(test("XK_phonographcopyright", XK_phonographcopyright, 0xAFB) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_phonographcopyright");
	FAIL;
#endif

#ifdef XK_caret
	if(test("XK_caret", XK_caret, 0xAFC) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_caret");
	FAIL;
#endif

#ifdef XK_singlelowquotemark
	if(test("XK_singlelowquotemark", XK_singlelowquotemark, 0xAFD) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_singlelowquotemark");
	FAIL;
#endif

#ifdef XK_doublelowquotemark
	if(test("XK_doublelowquotemark", XK_doublelowquotemark, 0xAFE) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_doublelowquotemark");
	FAIL;
#endif

#ifdef XK_cursor
	if(test("XK_cursor", XK_cursor, 0xAFF) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_cursor");
	FAIL;
#endif


	CHECKPASS(83);
}
