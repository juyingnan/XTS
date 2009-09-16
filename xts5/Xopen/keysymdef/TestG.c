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
* File: xts5/tset/Xopen/keysymdef/TestG.c
* 
* Description:
* 	Tests for keysymdef()
* 
* Modifications:
* $Log: TestG.c,v $
* Revision 1.2  2005-11-03 08:44:00  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:40  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:35:38  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:58:13  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:26:52  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:23:26  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.1  1996/05/09 21:16:18  andy
* Fixed X includes
*
* Revision 4.0  1995/12/15  09:13:48  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  01:17:06  andy
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

#define XK_GREEK
#include	<X11/keysymdef.h>
#undef XK_GREEK 

kysymdf7()
{ 
int 	pass = 0, fail = 0;
#ifdef XK_Greek_ALPHAaccent
	if(test("XK_Greek_ALPHAaccent", XK_Greek_ALPHAaccent, 0x7A1) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_ALPHAaccent");
	FAIL;
#endif

#ifdef XK_Greek_EPSILONaccent
	if(test("XK_Greek_EPSILONaccent", XK_Greek_EPSILONaccent, 0x7A2) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_EPSILONaccent");
	FAIL;
#endif

#ifdef XK_Greek_ETAaccent
	if(test("XK_Greek_ETAaccent", XK_Greek_ETAaccent, 0x7A3) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_ETAaccent");
	FAIL;
#endif

#ifdef XK_Greek_IOTAaccent
	if(test("XK_Greek_IOTAaccent", XK_Greek_IOTAaccent, 0x7A4) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_IOTAaccent");
	FAIL;
#endif

#ifdef XK_Greek_IOTAdiaeresis
	if(test("XK_Greek_IOTAdiaeresis", XK_Greek_IOTAdiaeresis, 0x7A5) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_IOTAdiaeresis");
	FAIL;
#endif

#ifdef XK_Greek_OMICRONaccent
	if(test("XK_Greek_OMICRONaccent", XK_Greek_OMICRONaccent, 0x7A7) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_OMICRONaccent");
	FAIL;
#endif

#ifdef XK_Greek_UPSILONaccent
	if(test("XK_Greek_UPSILONaccent", XK_Greek_UPSILONaccent, 0x7A8) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_UPSILONaccent");
	FAIL;
#endif

#ifdef XK_Greek_UPSILONdieresis
	if(test("XK_Greek_UPSILONdieresis", XK_Greek_UPSILONdieresis, 0x7A9) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_UPSILONdieresis");
	FAIL;
#endif

#ifdef XK_Greek_OMEGAaccent
	if(test("XK_Greek_OMEGAaccent", XK_Greek_OMEGAaccent, 0x7AB) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_OMEGAaccent");
	FAIL;
#endif

#ifdef XK_Greek_accentdieresis
	if(test("XK_Greek_accentdieresis", XK_Greek_accentdieresis, 0x7AE) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_accentdieresis");
	FAIL;
#endif

#ifdef XK_Greek_horizbar
	if(test("XK_Greek_horizbar", XK_Greek_horizbar, 0x7AF) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_horizbar");
	FAIL;
#endif

#ifdef XK_Greek_alphaaccent
	if(test("XK_Greek_alphaaccent", XK_Greek_alphaaccent, 0x7B1) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_alphaaccent");
	FAIL;
#endif

#ifdef XK_Greek_epsilonaccent
	if(test("XK_Greek_epsilonaccent", XK_Greek_epsilonaccent, 0x7B2) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_epsilonaccent");
	FAIL;
#endif

#ifdef XK_Greek_etaaccent
	if(test("XK_Greek_etaaccent", XK_Greek_etaaccent, 0x7B3) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_etaaccent");
	FAIL;
#endif

#ifdef XK_Greek_iotaaccent
	if(test("XK_Greek_iotaaccent", XK_Greek_iotaaccent, 0x7B4) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_iotaaccent");
	FAIL;
#endif

#ifdef XK_Greek_iotadieresis
	if(test("XK_Greek_iotadieresis", XK_Greek_iotadieresis, 0x7B5) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_iotadieresis");
	FAIL;
#endif

#ifdef XK_Greek_iotaaccentdieresis
	if(test("XK_Greek_iotaaccentdieresis", XK_Greek_iotaaccentdieresis, 0x7B6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_iotaaccentdieresis");
	FAIL;
#endif

#ifdef XK_Greek_omicronaccent
	if(test("XK_Greek_omicronaccent", XK_Greek_omicronaccent, 0x7B7) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_omicronaccent");
	FAIL;
#endif

#ifdef XK_Greek_upsilonaccent
	if(test("XK_Greek_upsilonaccent", XK_Greek_upsilonaccent, 0x7B8) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_upsilonaccent");
	FAIL;
#endif

#ifdef XK_Greek_upsilondieresis
	if(test("XK_Greek_upsilondieresis", XK_Greek_upsilondieresis, 0x7B9) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_upsilondieresis");
	FAIL;
#endif

#ifdef XK_Greek_upsilonaccentdieresis
	if(test("XK_Greek_upsilonaccentdieresis", XK_Greek_upsilonaccentdieresis, 0x7BA) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_upsilonaccentdieresis");
	FAIL;
#endif

#ifdef XK_Greek_omegaaccent
	if(test("XK_Greek_omegaaccent", XK_Greek_omegaaccent, 0x7BB) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_omegaaccent");
	FAIL;
#endif

#ifdef XK_Greek_ALPHA
	if(test("XK_Greek_ALPHA", XK_Greek_ALPHA, 0x7C1) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_ALPHA");
	FAIL;
#endif

#ifdef XK_Greek_BETA
	if(test("XK_Greek_BETA", XK_Greek_BETA, 0x7C2) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_BETA");
	FAIL;
#endif

#ifdef XK_Greek_GAMMA
	if(test("XK_Greek_GAMMA", XK_Greek_GAMMA, 0x7C3) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_GAMMA");
	FAIL;
#endif

#ifdef XK_Greek_DELTA
	if(test("XK_Greek_DELTA", XK_Greek_DELTA, 0x7C4) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_DELTA");
	FAIL;
#endif

#ifdef XK_Greek_EPSILON
	if(test("XK_Greek_EPSILON", XK_Greek_EPSILON, 0x7C5) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_EPSILON");
	FAIL;
#endif

#ifdef XK_Greek_ZETA
	if(test("XK_Greek_ZETA", XK_Greek_ZETA, 0x7C6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_ZETA");
	FAIL;
#endif

#ifdef XK_Greek_ETA
	if(test("XK_Greek_ETA", XK_Greek_ETA, 0x7C7) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_ETA");
	FAIL;
#endif

#ifdef XK_Greek_THETA
	if(test("XK_Greek_THETA", XK_Greek_THETA, 0x7C8) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_THETA");
	FAIL;
#endif

#ifdef XK_Greek_IOTA
	if(test("XK_Greek_IOTA", XK_Greek_IOTA, 0x7C9) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_IOTA");
	FAIL;
#endif

#ifdef XK_Greek_KAPPA
	if(test("XK_Greek_KAPPA", XK_Greek_KAPPA, 0x7CA) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_KAPPA");
	FAIL;
#endif

#ifdef XK_Greek_LAMBDA
	if(test("XK_Greek_LAMBDA", XK_Greek_LAMBDA, 0x7CB) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_LAMBDA");
	FAIL;
#endif

#ifdef XK_Greek_LAMDA
	if(test("XK_Greek_LAMDA", XK_Greek_LAMDA, 0x7CB) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_LAMDA");
	FAIL;
#endif

#ifdef XK_Greek_MU
	if(test("XK_Greek_MU", XK_Greek_MU, 0x7CC) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_MU");
	FAIL;
#endif

#ifdef XK_Greek_NU
	if(test("XK_Greek_NU", XK_Greek_NU, 0x7CD) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_NU");
	FAIL;
#endif

#ifdef XK_Greek_XI
	if(test("XK_Greek_XI", XK_Greek_XI, 0x7CE) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_XI");
	FAIL;
#endif

#ifdef XK_Greek_OMICRON
	if(test("XK_Greek_OMICRON", XK_Greek_OMICRON, 0x7CF) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_OMICRON");
	FAIL;
#endif

#ifdef XK_Greek_PI
	if(test("XK_Greek_PI", XK_Greek_PI, 0x7D0) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_PI");
	FAIL;
#endif

#ifdef XK_Greek_RHO
	if(test("XK_Greek_RHO", XK_Greek_RHO, 0x7D1) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_RHO");
	FAIL;
#endif

#ifdef XK_Greek_SIGMA
	if(test("XK_Greek_SIGMA", XK_Greek_SIGMA, 0x7D2) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_SIGMA");
	FAIL;
#endif

#ifdef XK_Greek_TAU
	if(test("XK_Greek_TAU", XK_Greek_TAU, 0x7D4) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_TAU");
	FAIL;
#endif

#ifdef XK_Greek_UPSILON
	if(test("XK_Greek_UPSILON", XK_Greek_UPSILON, 0x7D5) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_UPSILON");
	FAIL;
#endif

#ifdef XK_Greek_PHI
	if(test("XK_Greek_PHI", XK_Greek_PHI, 0x7D6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_PHI");
	FAIL;
#endif

#ifdef XK_Greek_CHI
	if(test("XK_Greek_CHI", XK_Greek_CHI, 0x7D7) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_CHI");
	FAIL;
#endif

#ifdef XK_Greek_PSI
	if(test("XK_Greek_PSI", XK_Greek_PSI, 0x7D8) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_PSI");
	FAIL;
#endif

#ifdef XK_Greek_OMEGA
	if(test("XK_Greek_OMEGA", XK_Greek_OMEGA, 0x7D9) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_OMEGA");
	FAIL;
#endif

#ifdef XK_Greek_alpha
	if(test("XK_Greek_alpha", XK_Greek_alpha, 0x7E1) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_alpha");
	FAIL;
#endif

#ifdef XK_Greek_beta
	if(test("XK_Greek_beta", XK_Greek_beta, 0x7E2) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_beta");
	FAIL;
#endif

#ifdef XK_Greek_gamma
	if(test("XK_Greek_gamma", XK_Greek_gamma, 0x7E3) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_gamma");
	FAIL;
#endif

#ifdef XK_Greek_delta
	if(test("XK_Greek_delta", XK_Greek_delta, 0x7E4) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_delta");
	FAIL;
#endif

#ifdef XK_Greek_epsilon
	if(test("XK_Greek_epsilon", XK_Greek_epsilon, 0x7E5) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_epsilon");
	FAIL;
#endif

#ifdef XK_Greek_zeta
	if(test("XK_Greek_zeta", XK_Greek_zeta, 0x7E6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_zeta");
	FAIL;
#endif

#ifdef XK_Greek_eta
	if(test("XK_Greek_eta", XK_Greek_eta, 0x7E7) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_eta");
	FAIL;
#endif

#ifdef XK_Greek_theta
	if(test("XK_Greek_theta", XK_Greek_theta, 0x7E8) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_theta");
	FAIL;
#endif

#ifdef XK_Greek_iota
	if(test("XK_Greek_iota", XK_Greek_iota, 0x7E9) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_iota");
	FAIL;
#endif

#ifdef XK_Greek_kappa
	if(test("XK_Greek_kappa", XK_Greek_kappa, 0x7EA) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_kappa");
	FAIL;
#endif

#ifdef XK_Greek_lambda
	if(test("XK_Greek_lambda", XK_Greek_lambda, 0x7EB) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_lambda");
	FAIL;
#endif

#ifdef XK_Greek_lamda
	if(test("XK_Greek_lamda", XK_Greek_lamda, 0x7EB) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_lamda");
	FAIL;
#endif

#ifdef XK_Greek_mu
	if(test("XK_Greek_mu", XK_Greek_mu, 0x7EC) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_mu");
	FAIL;
#endif

#ifdef XK_Greek_nu
	if(test("XK_Greek_nu", XK_Greek_nu, 0x7ED) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_nu");
	FAIL;
#endif

#ifdef XK_Greek_xi
	if(test("XK_Greek_xi", XK_Greek_xi, 0x7EE) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_xi");
	FAIL;
#endif

#ifdef XK_Greek_omicron
	if(test("XK_Greek_omicron", XK_Greek_omicron, 0x7EF) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_omicron");
	FAIL;
#endif

#ifdef XK_Greek_pi
	if(test("XK_Greek_pi", XK_Greek_pi, 0x7F0) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_pi");
	FAIL;
#endif

#ifdef XK_Greek_rho
	if(test("XK_Greek_rho", XK_Greek_rho, 0x7F1) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_rho");
	FAIL;
#endif

#ifdef XK_Greek_sigma
	if(test("XK_Greek_sigma", XK_Greek_sigma, 0x7F2) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_sigma");
	FAIL;
#endif

#ifdef XK_Greek_finalsmallsigma
	if(test("XK_Greek_finalsmallsigma", XK_Greek_finalsmallsigma, 0x7F3) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_finalsmallsigma");
	FAIL;
#endif

#ifdef XK_Greek_tau
	if(test("XK_Greek_tau", XK_Greek_tau, 0x7F4) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_tau");
	FAIL;
#endif

#ifdef XK_Greek_upsilon
	if(test("XK_Greek_upsilon", XK_Greek_upsilon, 0x7F5) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_upsilon");
	FAIL;
#endif

#ifdef XK_Greek_phi
	if(test("XK_Greek_phi", XK_Greek_phi, 0x7F6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_phi");
	FAIL;
#endif

#ifdef XK_Greek_chi
	if(test("XK_Greek_chi", XK_Greek_chi, 0x7F7) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_chi");
	FAIL;
#endif

#ifdef XK_Greek_psi
	if(test("XK_Greek_psi", XK_Greek_psi, 0x7F8) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_psi");
	FAIL;
#endif

#ifdef XK_Greek_omega
	if(test("XK_Greek_omega", XK_Greek_omega, 0x7F9) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_omega");
	FAIL;
#endif

#ifdef XK_Greek_switch
	if(test("XK_Greek_switch", XK_Greek_switch, 0xFF7E) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Greek_switch");
	FAIL;
#endif


	CHECKPASS(74);
}
