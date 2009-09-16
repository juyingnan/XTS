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
* $Header: /cvs/xtest/xtest/xts5/tset/Xopen/keysym/Test2.c,v 1.2 2005-11-03 08:44:00 jmichael Exp $
* 
* Project: VSW5
* 
* File: xts5/tset/Xopen/keysym/Test2.c
* 
* Description:
* 	Tests for keysym()
* 
* Modifications:
* $Log: Test2.c,v $
* Revision 1.2  2005-11-03 08:44:00  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:40  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:35:31  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:58:01  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:26:45  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:23:19  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.1  1996/05/09 21:14:55  andy
* Fixed X includes
*
* Revision 4.0  1995/12/15  09:13:28  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  01:16:43  andy
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

#include 	<X11/keysym.h>

kysym2()
{ 
int	pass = 0, fail = 0;
#ifdef XK_Aogonek
	if(test("XK_Aogonek", XK_Aogonek, 0x1A1) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Aogonek");
	FAIL;
#endif

#ifdef XK_breve
	if(test("XK_breve", XK_breve, 0x1A2) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_breve");
	FAIL;
#endif

#ifdef XK_Lstroke
	if(test("XK_Lstroke", XK_Lstroke, 0x1A3) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Lstroke");
	FAIL;
#endif

#ifdef XK_Lcaron
	if(test("XK_Lcaron", XK_Lcaron, 0x1A5) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Lcaron");
	FAIL;
#endif

#ifdef XK_Sacute
	if(test("XK_Sacute", XK_Sacute, 0x1A6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Sacute");
	FAIL;
#endif

#ifdef XK_Scaron
	if(test("XK_Scaron", XK_Scaron, 0x1A9) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Scaron");
	FAIL;
#endif

#ifdef XK_Scedilla
	if(test("XK_Scedilla", XK_Scedilla, 0x1AA) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Scedilla");
	FAIL;
#endif

#ifdef XK_Tcaron
	if(test("XK_Tcaron", XK_Tcaron, 0x1AB) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Tcaron");
	FAIL;
#endif

#ifdef XK_Zacute
	if(test("XK_Zacute", XK_Zacute, 0x1AC) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Zacute");
	FAIL;
#endif

#ifdef XK_Zcaron
	if(test("XK_Zcaron", XK_Zcaron, 0x1AE) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Zcaron");
	FAIL;
#endif

#ifdef XK_Zabovedot
	if(test("XK_Zabovedot", XK_Zabovedot, 0x1AF) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Zabovedot");
	FAIL;
#endif

#ifdef XK_aogonek
	if(test("XK_aogonek", XK_aogonek, 0x1B1) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_aogonek");
	FAIL;
#endif

#ifdef XK_ogonek
	if(test("XK_ogonek", XK_ogonek, 0x1B2) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_ogonek");
	FAIL;
#endif

#ifdef XK_lstroke
	if(test("XK_lstroke", XK_lstroke, 0x1B3) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_lstroke");
	FAIL;
#endif

#ifdef XK_lcaron
	if(test("XK_lcaron", XK_lcaron, 0x1B5) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_lcaron");
	FAIL;
#endif

#ifdef XK_sacute
	if(test("XK_sacute", XK_sacute, 0x1B6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_sacute");
	FAIL;
#endif

#ifdef XK_caron
	if(test("XK_caron", XK_caron, 0x1B7) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_caron");
	FAIL;
#endif

#ifdef XK_scaron
	if(test("XK_scaron", XK_scaron, 0x1B9) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_scaron");
	FAIL;
#endif

#ifdef XK_scedilla
	if(test("XK_scedilla", XK_scedilla, 0x1BA) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_scedilla");
	FAIL;
#endif

#ifdef XK_tcaron
	if(test("XK_tcaron", XK_tcaron, 0x1BB) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_tcaron");
	FAIL;
#endif

#ifdef XK_zacute
	if(test("XK_zacute", XK_zacute, 0x1BC) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_zacute");
	FAIL;
#endif

#ifdef XK_doubleacute
	if(test("XK_doubleacute", XK_doubleacute, 0x1BD) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_doubleacute");
	FAIL;
#endif

#ifdef XK_zcaron
	if(test("XK_zcaron", XK_zcaron, 0x1BE) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_zcaron");
	FAIL;
#endif

#ifdef XK_zabovedot
	if(test("XK_zabovedot", XK_zabovedot, 0x1BF) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_zabovedot");
	FAIL;
#endif

#ifdef XK_Racute
	if(test("XK_Racute", XK_Racute, 0x1C0) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Racute");
	FAIL;
#endif

#ifdef XK_Abreve
	if(test("XK_Abreve", XK_Abreve, 0x1C3) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Abreve");
	FAIL;
#endif

#ifdef XK_Lacute
	if(test("XK_Lacute", XK_Lacute, 0x1C5) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Lacute");
	FAIL;
#endif

#ifdef XK_Cacute
	if(test("XK_Cacute", XK_Cacute, 0x1C6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cacute");
	FAIL;
#endif

#ifdef XK_Ccaron
	if(test("XK_Ccaron", XK_Ccaron, 0x1C8) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Ccaron");
	FAIL;
#endif

#ifdef XK_Eogonek
	if(test("XK_Eogonek", XK_Eogonek, 0x1CA) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Eogonek");
	FAIL;
#endif

#ifdef XK_Ecaron
	if(test("XK_Ecaron", XK_Ecaron, 0x1CC) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Ecaron");
	FAIL;
#endif

#ifdef XK_Dcaron
	if(test("XK_Dcaron", XK_Dcaron, 0x1CF) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Dcaron");
	FAIL;
#endif

#ifdef XK_Dstroke
	if(test("XK_Dstroke", XK_Dstroke, 0x1D0) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Dstroke");
	FAIL;
#endif

#ifdef XK_Nacute
	if(test("XK_Nacute", XK_Nacute, 0x1D1) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Nacute");
	FAIL;
#endif

#ifdef XK_Ncaron
	if(test("XK_Ncaron", XK_Ncaron, 0x1D2) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Ncaron");
	FAIL;
#endif

#ifdef XK_Odoubleacute
	if(test("XK_Odoubleacute", XK_Odoubleacute, 0x1D5) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Odoubleacute");
	FAIL;
#endif

#ifdef XK_Rcaron
	if(test("XK_Rcaron", XK_Rcaron, 0x1D8) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Rcaron");
	FAIL;
#endif

#ifdef XK_Uring
	if(test("XK_Uring", XK_Uring, 0x1D9) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Uring");
	FAIL;
#endif

#ifdef XK_Udoubleacute
	if(test("XK_Udoubleacute", XK_Udoubleacute, 0x1DB) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Udoubleacute");
	FAIL;
#endif

#ifdef XK_Tcedilla
	if(test("XK_Tcedilla", XK_Tcedilla, 0x1DE) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Tcedilla");
	FAIL;
#endif

#ifdef XK_racute
	if(test("XK_racute", XK_racute, 0x1E0) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_racute");
	FAIL;
#endif

#ifdef XK_abreve
	if(test("XK_abreve", XK_abreve, 0x1E3) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_abreve");
	FAIL;
#endif

#ifdef XK_lacute
	if(test("XK_lacute", XK_lacute, 0x1E5) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_lacute");
	FAIL;
#endif

#ifdef XK_cacute
	if(test("XK_cacute", XK_cacute, 0x1E6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_cacute");
	FAIL;
#endif

#ifdef XK_ccaron
	if(test("XK_ccaron", XK_ccaron, 0x1E8) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_ccaron");
	FAIL;
#endif

#ifdef XK_eogonek
	if(test("XK_eogonek", XK_eogonek, 0x1EA) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_eogonek");
	FAIL;
#endif

#ifdef XK_ecaron
	if(test("XK_ecaron", XK_ecaron, 0x1EC) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_ecaron");
	FAIL;
#endif

#ifdef XK_dcaron
	if(test("XK_dcaron", XK_dcaron, 0x1EF) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_dcaron");
	FAIL;
#endif

#ifdef XK_dstroke
	if(test("XK_dstroke", XK_dstroke, 0x1F0) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_dstroke");
	FAIL;
#endif

#ifdef XK_nacute
	if(test("XK_nacute", XK_nacute, 0x1F1) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_nacute");
	FAIL;
#endif

#ifdef XK_ncaron
	if(test("XK_ncaron", XK_ncaron, 0x1F2) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_ncaron");
	FAIL;
#endif

#ifdef XK_odoubleacute
	if(test("XK_odoubleacute", XK_odoubleacute, 0x1F5) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_odoubleacute");
	FAIL;
#endif

#ifdef XK_rcaron
	if(test("XK_rcaron", XK_rcaron, 0x1F8) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_rcaron");
	FAIL;
#endif

#ifdef XK_uring
	if(test("XK_uring", XK_uring, 0x1F9) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_uring");
	FAIL;
#endif

#ifdef XK_udoubleacute
	if(test("XK_udoubleacute", XK_udoubleacute, 0x1FB) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_udoubleacute");
	FAIL;
#endif

#ifdef XK_tcedilla
	if(test("XK_tcedilla", XK_tcedilla, 0x1FE) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_tcedilla");
	FAIL;
#endif

#ifdef XK_abovedot
	if(test("XK_abovedot", XK_abovedot, 0x1FF) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_abovedot");
	FAIL;
#endif


	CHECKPASS(57);
}
