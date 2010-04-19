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
* File: xts5/Xopen/XStringToKeysym/TestT.c
* 
* Description:
* 	Tests for XStringToKeysym()
* 
* Modifications:
* $Log: TestT.c,v $
* Revision 1.2  2005-11-03 08:44:01  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:40  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:35:59  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:58:45  mar
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
* Revision 4.0  1995/12/15  09:14:49  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  01:18:15  andy
* Prepare for GA Release
*
*/
/*
 *      SCCS:  @(#)  TestT.c Rel 1.1	    (11/28/91)
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
#define XK_TECHNICAL
#include	<X11/keysymdef.h>
#undef XK_TECHNICAL

strtsymT()
{
	int	pass = 0, fail = 0;

#ifdef XK_leftradical
	if(test(XK_leftradical, "leftradical") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_leftradical");
	FAIL;
#endif

#ifdef XK_topleftradical
	if(test(XK_topleftradical, "topleftradical") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_topleftradical");
	FAIL;
#endif

#ifdef XK_horizconnector
	if(test(XK_horizconnector, "horizconnector") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_horizconnector");
	FAIL;
#endif

#ifdef XK_topintegral
	if(test(XK_topintegral, "topintegral") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_topintegral");
	FAIL;
#endif

#ifdef XK_botintegral
	if(test(XK_botintegral, "botintegral") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_botintegral");
	FAIL;
#endif

#ifdef XK_vertconnector
	if(test(XK_vertconnector, "vertconnector") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_vertconnector");
	FAIL;
#endif

#ifdef XK_topleftsqbracket
	if(test(XK_topleftsqbracket, "topleftsqbracket") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_topleftsqbracket");
	FAIL;
#endif

#ifdef XK_botleftsqbracket
	if(test(XK_botleftsqbracket, "botleftsqbracket") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_botleftsqbracket");
	FAIL;
#endif

#ifdef XK_toprightsqbracket
	if(test(XK_toprightsqbracket, "toprightsqbracket") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_toprightsqbracket");
	FAIL;
#endif

#ifdef XK_botrightsqbracket
	if(test(XK_botrightsqbracket, "botrightsqbracket") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_botrightsqbracket");
	FAIL;
#endif

#ifdef XK_topleftparens
	if(test(XK_topleftparens, "topleftparens") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_topleftparens");
	FAIL;
#endif

#ifdef XK_botleftparens
	if(test(XK_botleftparens, "botleftparens") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_botleftparens");
	FAIL;
#endif

#ifdef XK_toprightparens
	if(test(XK_toprightparens, "toprightparens") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_toprightparens");
	FAIL;
#endif

#ifdef XK_botrightparens
	if(test(XK_botrightparens, "botrightparens") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_botrightparens");
	FAIL;
#endif

#ifdef XK_leftmiddlecurlybrace
	if(test(XK_leftmiddlecurlybrace, "leftmiddlecurlybrace") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_leftmiddlecurlybrace");
	FAIL;
#endif

#ifdef XK_rightmiddlecurlybrace
	if(test(XK_rightmiddlecurlybrace, "rightmiddlecurlybrace") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_rightmiddlecurlybrace");
	FAIL;
#endif

#ifdef XK_topleftsummation
	if(test(XK_topleftsummation, "topleftsummation") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_topleftsummation");
	FAIL;
#endif

#ifdef XK_botleftsummation
	if(test(XK_botleftsummation, "botleftsummation") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_botleftsummation");
	FAIL;
#endif

#ifdef XK_topvertsummationconnector
	if(test(XK_topvertsummationconnector, "topvertsummationconnector") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_topvertsummationconnector");
	FAIL;
#endif

#ifdef XK_botvertsummationconnector
	if(test(XK_botvertsummationconnector, "botvertsummationconnector") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_botvertsummationconnector");
	FAIL;
#endif

#ifdef XK_toprightsummation
	if(test(XK_toprightsummation, "toprightsummation") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_toprightsummation");
	FAIL;
#endif

#ifdef XK_botrightsummation
	if(test(XK_botrightsummation, "botrightsummation") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_botrightsummation");
	FAIL;
#endif

#ifdef XK_rightmiddlesummation
	if(test(XK_rightmiddlesummation, "rightmiddlesummation") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_rightmiddlesummation");
	FAIL;
#endif

#ifdef XK_lessthanequal
	if(test(XK_lessthanequal, "lessthanequal") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_lessthanequal");
	FAIL;
#endif

#ifdef XK_notequal
	if(test(XK_notequal, "notequal") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_notequal");
	FAIL;
#endif

#ifdef XK_greaterthanequal
	if(test(XK_greaterthanequal, "greaterthanequal") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_greaterthanequal");
	FAIL;
#endif

#ifdef XK_integral
	if(test(XK_integral, "integral") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_integral");
	FAIL;
#endif

#ifdef XK_therefore
	if(test(XK_therefore, "therefore") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_therefore");
	FAIL;
#endif

#ifdef XK_variation
	if(test(XK_variation, "variation") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_variation");
	FAIL;
#endif

#ifdef XK_infinity
	if(test(XK_infinity, "infinity") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_infinity");
	FAIL;
#endif

#ifdef XK_nabla
	if(test(XK_nabla, "nabla") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_nabla");
	FAIL;
#endif

#ifdef XK_approximate
	if(test(XK_approximate, "approximate") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_approximate");
	FAIL;
#endif

#ifdef XK_similarequal
	if(test(XK_similarequal, "similarequal") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_similarequal");
	FAIL;
#endif

#ifdef XK_ifonlyif
	if(test(XK_ifonlyif, "ifonlyif") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_ifonlyif");
	FAIL;
#endif

#ifdef XK_implies
	if(test(XK_implies, "implies") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_implies");
	FAIL;
#endif

#ifdef XK_identical
	if(test(XK_identical, "identical") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_identical");
	FAIL;
#endif

#ifdef XK_radical
	if(test(XK_radical, "radical") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_radical");
	FAIL;
#endif

#ifdef XK_includedin
	if(test(XK_includedin, "includedin") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_includedin");
	FAIL;
#endif

#ifdef XK_includes
	if(test(XK_includes, "includes") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_includes");
	FAIL;
#endif

#ifdef XK_intersection
	if(test(XK_intersection, "intersection") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_intersection");
	FAIL;
#endif

#ifdef XK_union
	if(test(XK_union, "union") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_union");
	FAIL;
#endif

#ifdef XK_logicaland
	if(test(XK_logicaland, "logicaland") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_logicaland");
	FAIL;
#endif

#ifdef XK_logicalor
	if(test(XK_logicalor, "logicalor") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_logicalor");
	FAIL;
#endif

#ifdef XK_partialderivative
	if(test(XK_partialderivative, "partialderivative") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_partialderivative");
	FAIL;
#endif

#ifdef XK_function
	if(test(XK_function, "function") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_function");
	FAIL;
#endif

#ifdef XK_leftarrow
	if(test(XK_leftarrow, "leftarrow") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_leftarrow");
	FAIL;
#endif

#ifdef XK_uparrow
	if(test(XK_uparrow, "uparrow") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_uparrow");
	FAIL;
#endif

#ifdef XK_rightarrow
	if(test(XK_rightarrow, "rightarrow") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_rightarrow");
	FAIL;
#endif

#ifdef XK_downarrow
	if(test(XK_downarrow, "downarrow") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_downarrow");
	FAIL;
#endif

	CHECKPASS(49);
}
