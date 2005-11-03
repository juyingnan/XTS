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
* $Header: /cvs/xtest/xtest/xts5/tset/Xopen/kysym/Test4.c,v 1.2 2005-11-03 08:44:00 jmichael Exp $
* 
* Project: VSW5
* 
* File: xts5/tset/Xopen/kysym/Test4.c
* 
* Description:
* 	Tests for keysym()
* 
* Modifications:
* $Log: Test4.c,v $
* Revision 1.2  2005-11-03 08:44:00  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:40  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:35:32  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:58:02  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:26:46  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:23:20  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.1  1996/05/09 21:14:55  andy
* Fixed X includes
*
* Revision 4.0  1995/12/15  09:13:31  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  01:16:46  andy
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

kysym4()
{ 
int	pass = 0, fail = 0;
#ifdef XK_kra
	if(test("XK_kra", XK_kra, 0x3A2) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kra");
	FAIL;
#endif

#ifdef XK_kappa
	if(test("XK_kappa", XK_kappa, 0x3A2) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kappa");
	FAIL;
#endif

#ifdef XK_Rcedilla
	if(test("XK_Rcedilla", XK_Rcedilla, 0x3A3) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Rcedilla");
	FAIL;
#endif

#ifdef XK_Itilde
	if(test("XK_Itilde", XK_Itilde, 0x3A5) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Itilde");
	FAIL;
#endif

#ifdef XK_Lcedilla
	if(test("XK_Lcedilla", XK_Lcedilla, 0x3A6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Lcedilla");
	FAIL;
#endif

#ifdef XK_Emacron
	if(test("XK_Emacron", XK_Emacron, 0x3AA) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Emacron");
	FAIL;
#endif

#ifdef XK_Gcedilla
	if(test("XK_Gcedilla", XK_Gcedilla, 0x3AB) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Gcedilla");
	FAIL;
#endif

#ifdef XK_Tslash
	if(test("XK_Tslash", XK_Tslash, 0x3AC) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Tslash");
	FAIL;
#endif

#ifdef XK_rcedilla
	if(test("XK_rcedilla", XK_rcedilla, 0x3B3) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_rcedilla");
	FAIL;
#endif

#ifdef XK_itilde
	if(test("XK_itilde", XK_itilde, 0x3B5) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_itilde");
	FAIL;
#endif

#ifdef XK_lcedilla
	if(test("XK_lcedilla", XK_lcedilla, 0x3B6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_lcedilla");
	FAIL;
#endif

#ifdef XK_emacron
	if(test("XK_emacron", XK_emacron, 0x3BA) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_emacron");
	FAIL;
#endif

#ifdef XK_gcedilla
	if(test("XK_gcedilla", XK_gcedilla, 0x3BB) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_gcedilla");
	FAIL;
#endif

#ifdef XK_tslash
	if(test("XK_tslash", XK_tslash, 0x3BC) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_tslash");
	FAIL;
#endif

#ifdef XK_ENG
	if(test("XK_ENG", XK_ENG, 0x3BD) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_ENG");
	FAIL;
#endif

#ifdef XK_eng
	if(test("XK_eng", XK_eng, 0x3BF) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_eng");
	FAIL;
#endif

#ifdef XK_Amacron
	if(test("XK_Amacron", XK_Amacron, 0x3C0) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Amacron");
	FAIL;
#endif

#ifdef XK_Iogonek
	if(test("XK_Iogonek", XK_Iogonek, 0x3C7) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Iogonek");
	FAIL;
#endif

#ifdef XK_Eabovedot
	if(test("XK_Eabovedot", XK_Eabovedot, 0x3CC) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Eabovedot");
	FAIL;
#endif

#ifdef XK_Imacron
	if(test("XK_Imacron", XK_Imacron, 0x3CF) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Imacron");
	FAIL;
#endif

#ifdef XK_Ncedilla
	if(test("XK_Ncedilla", XK_Ncedilla, 0x3D1) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Ncedilla");
	FAIL;
#endif

#ifdef XK_Omacron
	if(test("XK_Omacron", XK_Omacron, 0x3D2) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Omacron");
	FAIL;
#endif

#ifdef XK_Kcedilla
	if(test("XK_Kcedilla", XK_Kcedilla, 0x3D3) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Kcedilla");
	FAIL;
#endif

#ifdef XK_Uogonek
	if(test("XK_Uogonek", XK_Uogonek, 0x3D9) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Uogonek");
	FAIL;
#endif

#ifdef XK_Utilde
	if(test("XK_Utilde", XK_Utilde, 0x3DD) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Utilde");
	FAIL;
#endif

#ifdef XK_Umacron
	if(test("XK_Umacron", XK_Umacron, 0x3DE) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Umacron");
	FAIL;
#endif

#ifdef XK_amacron
	if(test("XK_amacron", XK_amacron, 0x3E0) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_amacron");
	FAIL;
#endif

#ifdef XK_iogonek
	if(test("XK_iogonek", XK_iogonek, 0x3E7) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_iogonek");
	FAIL;
#endif

#ifdef XK_eabovedot
	if(test("XK_eabovedot", XK_eabovedot, 0x3EC) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_eabovedot");
	FAIL;
#endif

#ifdef XK_imacron
	if(test("XK_imacron", XK_imacron, 0x3EF) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_imacron");
	FAIL;
#endif

#ifdef XK_ncedilla
	if(test("XK_ncedilla", XK_ncedilla, 0x3F1) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_ncedilla");
	FAIL;
#endif

#ifdef XK_omacron
	if(test("XK_omacron", XK_omacron, 0x3F2) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_omacron");
	FAIL;
#endif

#ifdef XK_kcedilla
	if(test("XK_kcedilla", XK_kcedilla, 0x3F3) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_kcedilla");
	FAIL;
#endif

#ifdef XK_uogonek
	if(test("XK_uogonek", XK_uogonek, 0x3F9) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_uogonek");
	FAIL;
#endif

#ifdef XK_utilde
	if(test("XK_utilde", XK_utilde, 0x3FD) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_utilde");
	FAIL;
#endif

#ifdef XK_umacron
	if(test("XK_umacron", XK_umacron, 0x3FE) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_umacron");
	FAIL;
#endif


	CHECKPASS(36);
}
