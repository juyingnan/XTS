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
* $Header: /cvs/xtest/xtest/xts5/tset/Xopen/strtkysym/TestS.c,v 1.1 2005-02-12 14:37:44 anderson Exp $
* 
* Project: VSW5
* 
* File: vsw5/tset/Xopen/strtkysym/TestS.c
* 
* Description:
* 	Tests for XStringToKeysym()
* 
* Modifications:
* $Log: TestS.c,v $
* Revision 1.1  2005-02-12 14:37:44  anderson
* Initial revision
*
* Revision 8.0  1998/12/23 23:35:59  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:58:44  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:27:12  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:23:45  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.1  1996/05/09 21:19:34  andy
* Fixed X includes
*
* Revision 4.0  1995/12/15  09:14:48  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  01:18:14  andy
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
#define XK_SPECIAL
#include	<X11/keysymdef.h>
#undef XK_SPECIAL

strtsymS()
{ 
int 	pass = 0, fail = 0;
char	*symstr;
KeySym	rsym;


#ifdef XK_blank
	if(test(XK_blank, "blank") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_blank");
	FAIL;
#endif

#ifdef XK_soliddiamond
	if(test(XK_soliddiamond, "soliddiamond") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_soliddiamond");
	FAIL;
#endif

#ifdef XK_checkerboard
	if(test(XK_checkerboard, "checkerboard") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_checkerboard");
	FAIL;
#endif

#ifdef XK_ht
	if(test(XK_ht, "ht") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_ht");
	FAIL;
#endif

#ifdef XK_ff
	if(test(XK_ff, "ff") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_ff");
	FAIL;
#endif

#ifdef XK_cr
	if(test(XK_cr, "cr") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_cr");
	FAIL;
#endif

#ifdef XK_lf
	if(test(XK_lf, "lf") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_lf");
	FAIL;
#endif

#ifdef XK_nl
	if(test(XK_nl, "nl") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_nl");
	FAIL;
#endif

#ifdef XK_vt
	if(test(XK_vt, "vt") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_vt");
	FAIL;
#endif

#ifdef XK_lowrightcorner
	if(test(XK_lowrightcorner, "lowrightcorner") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_lowrightcorner");
	FAIL;
#endif

#ifdef XK_uprightcorner
	if(test(XK_uprightcorner, "uprightcorner") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_uprightcorner");
	FAIL;
#endif

#ifdef XK_upleftcorner
	if(test(XK_upleftcorner, "upleftcorner") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_upleftcorner");
	FAIL;
#endif

#ifdef XK_lowleftcorner
	if(test(XK_lowleftcorner, "lowleftcorner") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_lowleftcorner");
	FAIL;
#endif

#ifdef XK_crossinglines
	if(test(XK_crossinglines, "crossinglines") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_crossinglines");
	FAIL;
#endif

#ifdef XK_horizlinescan1
	if(test(XK_horizlinescan1, "horizlinescan1") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_horizlinescan1");
	FAIL;
#endif

#ifdef XK_horizlinescan3
	if(test(XK_horizlinescan3, "horizlinescan3") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_horizlinescan3");
	FAIL;
#endif

#ifdef XK_horizlinescan5
	if(test(XK_horizlinescan5, "horizlinescan5") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_horizlinescan5");
	FAIL;
#endif

#ifdef XK_horizlinescan7
	if(test(XK_horizlinescan7, "horizlinescan7") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_horizlinescan7");
	FAIL;
#endif

#ifdef XK_horizlinescan9
	if(test(XK_horizlinescan9, "horizlinescan9") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_horizlinescan9");
	FAIL;
#endif

#ifdef XK_leftt
	if(test(XK_leftt, "leftt") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_leftt");
	FAIL;
#endif

#ifdef XK_rightt
	if(test(XK_rightt, "rightt") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_rightt");
	FAIL;
#endif

#ifdef XK_bott
	if(test(XK_bott, "bott") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_bott");
	FAIL;
#endif

#ifdef XK_topt
	if(test(XK_topt, "topt") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_topt");
	FAIL;
#endif

#ifdef XK_vertbar
	if(test(XK_vertbar, "vertbar") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_vertbar");
	FAIL;
#endif

	CHECKPASS(24);
}
