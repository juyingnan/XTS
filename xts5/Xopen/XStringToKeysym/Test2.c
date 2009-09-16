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
* File: xts5/tset/Xopen/XStringToKeysym/Test2.c
* 
* Description:
* 	Tests for XStringToKeysym()
* 
* Modifications:
* $Log: Test2.c,v $
* Revision 1.2  2005-11-03 08:44:01  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:40  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:35:53  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:58:35  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:27:06  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:23:40  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.1  1996/05/09 21:19:34  andy
* Fixed X includes
*
* Revision 4.0  1995/12/15  09:14:33  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  01:17:57  andy
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
#define XK_LATIN2
#include	<X11/keysymdef.h>
#undef XK_LATIN2 

strtsym2()
{ 
int 	pass = 0, fail = 0;
char	*symstr;
KeySym	rsym;


#ifdef XK_Aogonek
	if(test(XK_Aogonek, "Aogonek") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Aogonek");
	FAIL;
#endif

#ifdef XK_breve
	if(test(XK_breve, "breve") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_breve");
	FAIL;
#endif

#ifdef XK_Lstroke
	if(test(XK_Lstroke, "Lstroke") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Lstroke");
	FAIL;
#endif

#ifdef XK_Lcaron
	if(test(XK_Lcaron, "Lcaron") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Lcaron");
	FAIL;
#endif

#ifdef XK_Sacute
	if(test(XK_Sacute, "Sacute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Sacute");
	FAIL;
#endif

#ifdef XK_Scaron
	if(test(XK_Scaron, "Scaron") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Scaron");
	FAIL;
#endif

#ifdef XK_Scedilla
	if(test(XK_Scedilla, "Scedilla") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Scedilla");
	FAIL;
#endif

#ifdef XK_Tcaron
	if(test(XK_Tcaron, "Tcaron") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Tcaron");
	FAIL;
#endif

#ifdef XK_Zacute
	if(test(XK_Zacute, "Zacute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Zacute");
	FAIL;
#endif

#ifdef XK_Zcaron
	if(test(XK_Zcaron, "Zcaron") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Zcaron");
	FAIL;
#endif

#ifdef XK_Zabovedot
	if(test(XK_Zabovedot, "Zabovedot") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Zabovedot");
	FAIL;
#endif

#ifdef XK_aogonek
	if(test(XK_aogonek, "aogonek") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_aogonek");
	FAIL;
#endif

#ifdef XK_ogonek
	if(test(XK_ogonek, "ogonek") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_ogonek");
	FAIL;
#endif

#ifdef XK_lstroke
	if(test(XK_lstroke, "lstroke") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_lstroke");
	FAIL;
#endif

#ifdef XK_lcaron
	if(test(XK_lcaron, "lcaron") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_lcaron");
	FAIL;
#endif

#ifdef XK_sacute
	if(test(XK_sacute, "sacute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_sacute");
	FAIL;
#endif

#ifdef XK_caron
	if(test(XK_caron, "caron") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_caron");
	FAIL;
#endif

#ifdef XK_scaron
	if(test(XK_scaron, "scaron") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_scaron");
	FAIL;
#endif

#ifdef XK_scedilla
	if(test(XK_scedilla, "scedilla") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_scedilla");
	FAIL;
#endif

#ifdef XK_tcaron
	if(test(XK_tcaron, "tcaron") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_tcaron");
	FAIL;
#endif

#ifdef XK_zacute
	if(test(XK_zacute, "zacute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_zacute");
	FAIL;
#endif

#ifdef XK_doubleacute
	if(test(XK_doubleacute, "doubleacute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_doubleacute");
	FAIL;
#endif

#ifdef XK_zcaron
	if(test(XK_zcaron, "zcaron") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_zcaron");
	FAIL;
#endif

#ifdef XK_zabovedot
	if(test(XK_zabovedot, "zabovedot") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_zabovedot");
	FAIL;
#endif

#ifdef XK_Racute
	if(test(XK_Racute, "Racute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Racute");
	FAIL;
#endif

#ifdef XK_Abreve
	if(test(XK_Abreve, "Abreve") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Abreve");
	FAIL;
#endif

#ifdef XK_Lacute
	if(test(XK_Lacute, "Lacute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Lacute");
	FAIL;
#endif

#ifdef XK_Cacute
	if(test(XK_Cacute, "Cacute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Cacute");
	FAIL;
#endif

#ifdef XK_Ccaron
	if(test(XK_Ccaron, "Ccaron") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Ccaron");
	FAIL;
#endif

#ifdef XK_Eogonek
	if(test(XK_Eogonek, "Eogonek") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Eogonek");
	FAIL;
#endif

#ifdef XK_Ecaron
	if(test(XK_Ecaron, "Ecaron") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Ecaron");
	FAIL;
#endif

#ifdef XK_Dcaron
	if(test(XK_Dcaron, "Dcaron") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Dcaron");
	FAIL;
#endif

#ifdef XK_Dstroke
	if(test(XK_Dstroke, "Dstroke") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Dstroke");
	FAIL;
#endif

#ifdef XK_Nacute
	if(test(XK_Nacute, "Nacute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Nacute");
	FAIL;
#endif

#ifdef XK_Ncaron
	if(test(XK_Ncaron, "Ncaron") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Ncaron");
	FAIL;
#endif

#ifdef XK_Odoubleacute
	if(test(XK_Odoubleacute, "Odoubleacute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Odoubleacute");
	FAIL;
#endif

#ifdef XK_Rcaron
	if(test(XK_Rcaron, "Rcaron") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Rcaron");
	FAIL;
#endif

#ifdef XK_Uring
	if(test(XK_Uring, "Uring") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Uring");
	FAIL;
#endif

#ifdef XK_Udoubleacute
	if(test(XK_Udoubleacute, "Udoubleacute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Udoubleacute");
	FAIL;
#endif

#ifdef XK_Tcedilla
	if(test(XK_Tcedilla, "Tcedilla") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Tcedilla");
	FAIL;
#endif

#ifdef XK_racute
	if(test(XK_racute, "racute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_racute");
	FAIL;
#endif

#ifdef XK_abreve
	if(test(XK_abreve, "abreve") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_abreve");
	FAIL;
#endif

#ifdef XK_lacute
	if(test(XK_lacute, "lacute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_lacute");
	FAIL;
#endif

#ifdef XK_cacute
	if(test(XK_cacute, "cacute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_cacute");
	FAIL;
#endif

#ifdef XK_ccaron
	if(test(XK_ccaron, "ccaron") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_ccaron");
	FAIL;
#endif

#ifdef XK_eogonek
	if(test(XK_eogonek, "eogonek") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_eogonek");
	FAIL;
#endif

#ifdef XK_ecaron
	if(test(XK_ecaron, "ecaron") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_ecaron");
	FAIL;
#endif

#ifdef XK_dcaron
	if(test(XK_dcaron, "dcaron") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_dcaron");
	FAIL;
#endif

#ifdef XK_dstroke
	if(test(XK_dstroke, "dstroke") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_dstroke");
	FAIL;
#endif

#ifdef XK_nacute
	if(test(XK_nacute, "nacute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_nacute");
	FAIL;
#endif

#ifdef XK_ncaron
	if(test(XK_ncaron, "ncaron") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_ncaron");
	FAIL;
#endif

#ifdef XK_odoubleacute
	if(test(XK_odoubleacute, "odoubleacute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_odoubleacute");
	FAIL;
#endif

#ifdef XK_rcaron
	if(test(XK_rcaron, "rcaron") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_rcaron");
	FAIL;
#endif

#ifdef XK_uring
	if(test(XK_uring, "uring") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_uring");
	FAIL;
#endif

#ifdef XK_udoubleacute
	if(test(XK_udoubleacute, "udoubleacute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_udoubleacute");
	FAIL;
#endif

#ifdef XK_tcedilla
	if(test(XK_tcedilla, "tcedilla") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_tcedilla");
	FAIL;
#endif

#ifdef XK_abovedot
	if(test(XK_abovedot, "abovedot") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_abovedot");
	FAIL;
#endif

	CHECKPASS(57);
}
