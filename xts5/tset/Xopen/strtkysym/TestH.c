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
* $Header: /cvs/xtest/xtest/xts5/tset/Xopen/strtkysym/TestH.c,v 1.2 2005-11-03 08:44:01 jmichael Exp $
* 
* Project: VSW5
* 
* File: xts5/tset/Xopen/strtkysym/TestH.c
* 
* Description:
* 	Tests for XStringToKeysym()
* 
* Modifications:
* $Log: TestH.c,v $
* Revision 1.2  2005-11-03 08:44:01  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:40  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:35:56  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:58:40  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:27:09  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:23:43  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.1  1996/05/09 21:19:34  andy
* Fixed X includes
*
* Revision 4.0  1995/12/15  09:14:41  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  01:18:06  andy
* Prepare for GA Release
*
*/
/*
 *      SCCS:  @(#)  TestH.c Rel 1.1	    (11/28/91)
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
test(symbol, str)
KeySym	symbol;
char	*str;
{
KeySym	rsym;

	rsym = XStringToKeysym(str);

	if(rsym == NoSymbol) {
		report("XStringToKeysym() returned NoSymbol for string \"%s\".", str);
		return(0);
	}

	if(rsym != symbol) {
		report("XStringToKeysym() returned KeySym 0x%lx instead of 0x%lx.", (long) rsym, (long) symbol);
		return(0);
	}
	return(1);
}

static void
reporterr(s)
char	*s;
{
	report("Symbol \"%s\" is not defined.", s);
}
#define XK_HEBREW
#include	<X11/keysymdef.h>
#undef XK_HEBREW 

strtsymH()
{ 
int 	pass = 0, fail = 0;
char	*symstr;
KeySym	rsym;


#ifdef XK_hebrew_doublelowline
	if(test(XK_hebrew_doublelowline, "hebrew_doublelowline") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_hebrew_doublelowline");
	FAIL;
#endif

#ifdef XK_hebrew_aleph
	if(test(XK_hebrew_aleph, "hebrew_aleph") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_hebrew_aleph");
	FAIL;
#endif

#ifdef XK_hebrew_bet
	if(test(XK_hebrew_bet, "hebrew_bet") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_hebrew_bet");
	FAIL;
#endif

#ifdef XK_hebrew_beth
	if(test(XK_hebrew_beth, "hebrew_beth") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_hebrew_beth");
	FAIL;
#endif

#ifdef XK_hebrew_gimel
	if(test(XK_hebrew_gimel, "hebrew_gimel") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_hebrew_gimel");
	FAIL;
#endif

#ifdef XK_hebrew_gimmel
	if(test(XK_hebrew_gimmel, "hebrew_gimmel") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_hebrew_gimmel");
	FAIL;
#endif

#ifdef XK_hebrew_dalet
	if(test(XK_hebrew_dalet, "hebrew_dalet") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_hebrew_dalet");
	FAIL;
#endif

#ifdef XK_hebrew_daleth
	if(test(XK_hebrew_daleth, "hebrew_daleth") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_hebrew_daleth");
	FAIL;
#endif

#ifdef XK_hebrew_he
	if(test(XK_hebrew_he, "hebrew_he") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_hebrew_he");
	FAIL;
#endif

#ifdef XK_hebrew_waw
	if(test(XK_hebrew_waw, "hebrew_waw") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_hebrew_waw");
	FAIL;
#endif

#ifdef XK_hebrew_zain
	if(test(XK_hebrew_zain, "hebrew_zain") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_hebrew_zain");
	FAIL;
#endif

#ifdef XK_hebrew_zayin
	if(test(XK_hebrew_zayin, "hebrew_zayin") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_hebrew_zayin");
	FAIL;
#endif

#ifdef XK_hebrew_chet
	if(test(XK_hebrew_chet, "hebrew_chet") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_hebrew_chet");
	FAIL;
#endif

#ifdef XK_hebrew_het
	if(test(XK_hebrew_het, "hebrew_het") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_hebrew_het");
	FAIL;
#endif

#ifdef XK_hebrew_tet
	if(test(XK_hebrew_tet, "hebrew_tet") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_hebrew_tet");
	FAIL;
#endif

#ifdef XK_hebrew_teth
	if(test(XK_hebrew_teth, "hebrew_teth") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_hebrew_teth");
	FAIL;
#endif

#ifdef XK_hebrew_yod
	if(test(XK_hebrew_yod, "hebrew_yod") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_hebrew_yod");
	FAIL;
#endif

#ifdef XK_hebrew_finalkaph
	if(test(XK_hebrew_finalkaph, "hebrew_finalkaph") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_hebrew_finalkaph");
	FAIL;
#endif

#ifdef XK_hebrew_kaph
	if(test(XK_hebrew_kaph, "hebrew_kaph") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_hebrew_kaph");
	FAIL;
#endif

#ifdef XK_hebrew_lamed
	if(test(XK_hebrew_lamed, "hebrew_lamed") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_hebrew_lamed");
	FAIL;
#endif

#ifdef XK_hebrew_finalmem
	if(test(XK_hebrew_finalmem, "hebrew_finalmem") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_hebrew_finalmem");
	FAIL;
#endif

#ifdef XK_hebrew_mem
	if(test(XK_hebrew_mem, "hebrew_mem") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_hebrew_mem");
	FAIL;
#endif

#ifdef XK_hebrew_finalnun
	if(test(XK_hebrew_finalnun, "hebrew_finalnun") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_hebrew_finalnun");
	FAIL;
#endif

#ifdef XK_hebrew_nun
	if(test(XK_hebrew_nun, "hebrew_nun") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_hebrew_nun");
	FAIL;
#endif

#ifdef XK_hebrew_samech
	if(test(XK_hebrew_samech, "hebrew_samech") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_hebrew_samech");
	FAIL;
#endif

#ifdef XK_hebrew_samekh
	if(test(XK_hebrew_samekh, "hebrew_samekh") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_hebrew_samekh");
	FAIL;
#endif

#ifdef XK_hebrew_ayin
	if(test(XK_hebrew_ayin, "hebrew_ayin") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_hebrew_ayin");
	FAIL;
#endif

#ifdef XK_hebrew_finalpe
	if(test(XK_hebrew_finalpe, "hebrew_finalpe") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_hebrew_finalpe");
	FAIL;
#endif

#ifdef XK_hebrew_pe
	if(test(XK_hebrew_pe, "hebrew_pe") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_hebrew_pe");
	FAIL;
#endif

#ifdef XK_hebrew_finalzade
	if(test(XK_hebrew_finalzade, "hebrew_finalzade") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_hebrew_finalzade");
	FAIL;
#endif

#ifdef XK_hebrew_finalzadi
	if(test(XK_hebrew_finalzadi, "hebrew_finalzadi") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_hebrew_finalzadi");
	FAIL;
#endif

#ifdef XK_hebrew_zade
	if(test(XK_hebrew_zade, "hebrew_zade") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_hebrew_zade");
	FAIL;
#endif

#ifdef XK_hebrew_zadi
	if(test(XK_hebrew_zadi, "hebrew_zadi") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_hebrew_zadi");
	FAIL;
#endif

#ifdef XK_hebrew_qoph
	if(test(XK_hebrew_qoph, "hebrew_qoph") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_hebrew_qoph");
	FAIL;
#endif

#ifdef XK_hebrew_kuf
	if(test(XK_hebrew_kuf, "hebrew_kuf") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_hebrew_kuf");
	FAIL;
#endif

#ifdef XK_hebrew_resh
	if(test(XK_hebrew_resh, "hebrew_resh") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_hebrew_resh");
	FAIL;
#endif

#ifdef XK_hebrew_shin
	if(test(XK_hebrew_shin, "hebrew_shin") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_hebrew_shin");
	FAIL;
#endif

#ifdef XK_hebrew_taw
	if(test(XK_hebrew_taw, "hebrew_taw") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_hebrew_taw");
	FAIL;
#endif

#ifdef XK_hebrew_taf
	if(test(XK_hebrew_taf, "hebrew_taf") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_hebrew_taf");
	FAIL;
#endif

#ifdef XK_Hebrew_switch
	if(test(XK_Hebrew_switch, "Hebrew_switch") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Hebrew_switch");
	FAIL;
#endif

	CHECKPASS(40);
}
