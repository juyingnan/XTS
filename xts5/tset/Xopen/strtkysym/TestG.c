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
* $Header: /cvs/xtest/xtest/xts5/tset/Xopen/strtkysym/TestG.c,v 1.2 2005-11-03 08:44:01 jmichael Exp $
* 
* Project: VSW5
* 
* File: xts5/tset/Xopen/strtkysym/TestG.c
* 
* Description:
* 	Tests for XStringToKeysym()
* 
* Modifications:
* $Log: TestG.c,v $
* Revision 1.2  2005-11-03 08:44:01  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:40  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:35:56  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:58:39  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:27:09  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:23:42  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.1  1996/05/09 21:19:34  andy
* Fixed X includes
*
* Revision 4.0  1995/12/15  09:14:39  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  01:18:05  andy
* Prepare for GA Release
*
*/
/*
 *      SCCS:  @(#)  TestG.c Rel 1.1	    (11/28/91)
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
#define XK_GREEK
#include	<X11/keysymdef.h>
#undef XK_GREEK 

strtsymG()
{ 
int 	pass = 0, fail = 0;
char	*symstr;
KeySym	rsym;


#ifdef XK_Greek_ALPHAaccent
	if(test(XK_Greek_ALPHAaccent, "Greek_ALPHAaccent") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_ALPHAaccent");
	FAIL;
#endif

#ifdef XK_Greek_EPSILONaccent
	if(test(XK_Greek_EPSILONaccent, "Greek_EPSILONaccent") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_EPSILONaccent");
	FAIL;
#endif

#ifdef XK_Greek_ETAaccent
	if(test(XK_Greek_ETAaccent, "Greek_ETAaccent") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_ETAaccent");
	FAIL;
#endif

#ifdef XK_Greek_IOTAaccent
	if(test(XK_Greek_IOTAaccent, "Greek_IOTAaccent") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_IOTAaccent");
	FAIL;
#endif

#ifdef XK_Greek_IOTAdiaeresis
	if(test(XK_Greek_IOTAdiaeresis, "Greek_IOTAdiaeresis") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_IOTAdiaeresis");
	FAIL;
#endif

#ifdef XK_Greek_OMICRONaccent
	if(test(XK_Greek_OMICRONaccent, "Greek_OMICRONaccent") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_OMICRONaccent");
	FAIL;
#endif

#ifdef XK_Greek_UPSILONaccent
	if(test(XK_Greek_UPSILONaccent, "Greek_UPSILONaccent") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_UPSILONaccent");
	FAIL;
#endif

#ifdef XK_Greek_UPSILONdieresis
	if(test(XK_Greek_UPSILONdieresis, "Greek_UPSILONdieresis") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_UPSILONdieresis");
	FAIL;
#endif

#ifdef XK_Greek_OMEGAaccent
	if(test(XK_Greek_OMEGAaccent, "Greek_OMEGAaccent") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_OMEGAaccent");
	FAIL;
#endif

#ifdef XK_Greek_accentdieresis
	if(test(XK_Greek_accentdieresis, "Greek_accentdieresis") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_accentdieresis");
	FAIL;
#endif

#ifdef XK_Greek_horizbar
	if(test(XK_Greek_horizbar, "Greek_horizbar") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_horizbar");
	FAIL;
#endif

#ifdef XK_Greek_alphaaccent
	if(test(XK_Greek_alphaaccent, "Greek_alphaaccent") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_alphaaccent");
	FAIL;
#endif

#ifdef XK_Greek_epsilonaccent
	if(test(XK_Greek_epsilonaccent, "Greek_epsilonaccent") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_epsilonaccent");
	FAIL;
#endif

#ifdef XK_Greek_etaaccent
	if(test(XK_Greek_etaaccent, "Greek_etaaccent") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_etaaccent");
	FAIL;
#endif

#ifdef XK_Greek_iotaaccent
	if(test(XK_Greek_iotaaccent, "Greek_iotaaccent") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_iotaaccent");
	FAIL;
#endif

#ifdef XK_Greek_iotadieresis
	if(test(XK_Greek_iotadieresis, "Greek_iotadieresis") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_iotadieresis");
	FAIL;
#endif

#ifdef XK_Greek_iotaaccentdieresis
	if(test(XK_Greek_iotaaccentdieresis, "Greek_iotaaccentdieresis") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_iotaaccentdieresis");
	FAIL;
#endif

#ifdef XK_Greek_omicronaccent
	if(test(XK_Greek_omicronaccent, "Greek_omicronaccent") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_omicronaccent");
	FAIL;
#endif

#ifdef XK_Greek_upsilonaccent
	if(test(XK_Greek_upsilonaccent, "Greek_upsilonaccent") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_upsilonaccent");
	FAIL;
#endif

#ifdef XK_Greek_upsilondieresis
	if(test(XK_Greek_upsilondieresis, "Greek_upsilondieresis") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_upsilondieresis");
	FAIL;
#endif

#ifdef XK_Greek_upsilonaccentdieresis
	if(test(XK_Greek_upsilonaccentdieresis, "Greek_upsilonaccentdieresis") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_upsilonaccentdieresis");
	FAIL;
#endif

#ifdef XK_Greek_omegaaccent
	if(test(XK_Greek_omegaaccent, "Greek_omegaaccent") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_omegaaccent");
	FAIL;
#endif

#ifdef XK_Greek_ALPHA
	if(test(XK_Greek_ALPHA, "Greek_ALPHA") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_ALPHA");
	FAIL;
#endif

#ifdef XK_Greek_BETA
	if(test(XK_Greek_BETA, "Greek_BETA") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_BETA");
	FAIL;
#endif

#ifdef XK_Greek_GAMMA
	if(test(XK_Greek_GAMMA, "Greek_GAMMA") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_GAMMA");
	FAIL;
#endif

#ifdef XK_Greek_DELTA
	if(test(XK_Greek_DELTA, "Greek_DELTA") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_DELTA");
	FAIL;
#endif

#ifdef XK_Greek_EPSILON
	if(test(XK_Greek_EPSILON, "Greek_EPSILON") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_EPSILON");
	FAIL;
#endif

#ifdef XK_Greek_ZETA
	if(test(XK_Greek_ZETA, "Greek_ZETA") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_ZETA");
	FAIL;
#endif

#ifdef XK_Greek_ETA
	if(test(XK_Greek_ETA, "Greek_ETA") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_ETA");
	FAIL;
#endif

#ifdef XK_Greek_THETA
	if(test(XK_Greek_THETA, "Greek_THETA") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_THETA");
	FAIL;
#endif

#ifdef XK_Greek_IOTA
	if(test(XK_Greek_IOTA, "Greek_IOTA") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_IOTA");
	FAIL;
#endif

#ifdef XK_Greek_KAPPA
	if(test(XK_Greek_KAPPA, "Greek_KAPPA") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_KAPPA");
	FAIL;
#endif

#ifdef XK_Greek_LAMBDA
	if(test(XK_Greek_LAMBDA, "Greek_LAMBDA") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_LAMBDA");
	FAIL;
#endif

#ifdef XK_Greek_LAMDA
	if(test(XK_Greek_LAMDA, "Greek_LAMDA") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_LAMDA");
	FAIL;
#endif

#ifdef XK_Greek_MU
	if(test(XK_Greek_MU, "Greek_MU") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_MU");
	FAIL;
#endif

#ifdef XK_Greek_NU
	if(test(XK_Greek_NU, "Greek_NU") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_NU");
	FAIL;
#endif

#ifdef XK_Greek_XI
	if(test(XK_Greek_XI, "Greek_XI") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_XI");
	FAIL;
#endif

#ifdef XK_Greek_OMICRON
	if(test(XK_Greek_OMICRON, "Greek_OMICRON") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_OMICRON");
	FAIL;
#endif

#ifdef XK_Greek_PI
	if(test(XK_Greek_PI, "Greek_PI") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_PI");
	FAIL;
#endif

#ifdef XK_Greek_RHO
	if(test(XK_Greek_RHO, "Greek_RHO") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_RHO");
	FAIL;
#endif

#ifdef XK_Greek_SIGMA
	if(test(XK_Greek_SIGMA, "Greek_SIGMA") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_SIGMA");
	FAIL;
#endif

#ifdef XK_Greek_TAU
	if(test(XK_Greek_TAU, "Greek_TAU") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_TAU");
	FAIL;
#endif

#ifdef XK_Greek_UPSILON
	if(test(XK_Greek_UPSILON, "Greek_UPSILON") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_UPSILON");
	FAIL;
#endif

#ifdef XK_Greek_PHI
	if(test(XK_Greek_PHI, "Greek_PHI") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_PHI");
	FAIL;
#endif

#ifdef XK_Greek_CHI
	if(test(XK_Greek_CHI, "Greek_CHI") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_CHI");
	FAIL;
#endif

#ifdef XK_Greek_PSI
	if(test(XK_Greek_PSI, "Greek_PSI") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_PSI");
	FAIL;
#endif

#ifdef XK_Greek_OMEGA
	if(test(XK_Greek_OMEGA, "Greek_OMEGA") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_OMEGA");
	FAIL;
#endif

#ifdef XK_Greek_alpha
	if(test(XK_Greek_alpha, "Greek_alpha") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_alpha");
	FAIL;
#endif

#ifdef XK_Greek_beta
	if(test(XK_Greek_beta, "Greek_beta") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_beta");
	FAIL;
#endif

#ifdef XK_Greek_gamma
	if(test(XK_Greek_gamma, "Greek_gamma") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_gamma");
	FAIL;
#endif

#ifdef XK_Greek_delta
	if(test(XK_Greek_delta, "Greek_delta") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_delta");
	FAIL;
#endif

#ifdef XK_Greek_epsilon
	if(test(XK_Greek_epsilon, "Greek_epsilon") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_epsilon");
	FAIL;
#endif

#ifdef XK_Greek_zeta
	if(test(XK_Greek_zeta, "Greek_zeta") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_zeta");
	FAIL;
#endif

#ifdef XK_Greek_eta
	if(test(XK_Greek_eta, "Greek_eta") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_eta");
	FAIL;
#endif

#ifdef XK_Greek_theta
	if(test(XK_Greek_theta, "Greek_theta") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_theta");
	FAIL;
#endif

#ifdef XK_Greek_iota
	if(test(XK_Greek_iota, "Greek_iota") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_iota");
	FAIL;
#endif

#ifdef XK_Greek_kappa
	if(test(XK_Greek_kappa, "Greek_kappa") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_kappa");
	FAIL;
#endif

#ifdef XK_Greek_lambda
	if(test(XK_Greek_lambda, "Greek_lambda") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_lambda");
	FAIL;
#endif

#ifdef XK_Greek_lamda
	if(test(XK_Greek_lamda, "Greek_lamda") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_lamda");
	FAIL;
#endif

#ifdef XK_Greek_mu
	if(test(XK_Greek_mu, "Greek_mu") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_mu");
	FAIL;
#endif

#ifdef XK_Greek_nu
	if(test(XK_Greek_nu, "Greek_nu") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_nu");
	FAIL;
#endif

#ifdef XK_Greek_xi
	if(test(XK_Greek_xi, "Greek_xi") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_xi");
	FAIL;
#endif

#ifdef XK_Greek_omicron
	if(test(XK_Greek_omicron, "Greek_omicron") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_omicron");
	FAIL;
#endif

#ifdef XK_Greek_pi
	if(test(XK_Greek_pi, "Greek_pi") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_pi");
	FAIL;
#endif

#ifdef XK_Greek_rho
	if(test(XK_Greek_rho, "Greek_rho") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_rho");
	FAIL;
#endif

#ifdef XK_Greek_sigma
	if(test(XK_Greek_sigma, "Greek_sigma") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_sigma");
	FAIL;
#endif

#ifdef XK_Greek_finalsmallsigma
	if(test(XK_Greek_finalsmallsigma, "Greek_finalsmallsigma") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_finalsmallsigma");
	FAIL;
#endif

#ifdef XK_Greek_tau
	if(test(XK_Greek_tau, "Greek_tau") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_tau");
	FAIL;
#endif

#ifdef XK_Greek_upsilon
	if(test(XK_Greek_upsilon, "Greek_upsilon") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_upsilon");
	FAIL;
#endif

#ifdef XK_Greek_phi
	if(test(XK_Greek_phi, "Greek_phi") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_phi");
	FAIL;
#endif

#ifdef XK_Greek_chi
	if(test(XK_Greek_chi, "Greek_chi") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_chi");
	FAIL;
#endif

#ifdef XK_Greek_psi
	if(test(XK_Greek_psi, "Greek_psi") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_psi");
	FAIL;
#endif

#ifdef XK_Greek_omega
	if(test(XK_Greek_omega, "Greek_omega") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_omega");
	FAIL;
#endif

#ifdef XK_Greek_switch
	if(test(XK_Greek_switch, "Greek_switch") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Greek_switch");
	FAIL;
#endif

	CHECKPASS(74);
}
