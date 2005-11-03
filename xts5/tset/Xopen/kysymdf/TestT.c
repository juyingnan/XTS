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
* $Header: /cvs/xtest/xtest/xts5/tset/Xopen/kysymdf/TestT.c,v 1.2 2005-11-03 08:44:00 jmichael Exp $
* 
* Project: VSW5
* 
* File: xts5/tset/Xopen/kysymdf/TestT.c
* 
* Description:
* 	Tests for keysymdef()
* 
* Modifications:
* $Log: TestT.c,v $
* Revision 1.2  2005-11-03 08:44:00  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:40  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:35:42  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:58:19  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:26:56  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:23:29  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.1  1996/05/09 21:16:18  andy
* Fixed X includes
*
* Revision 4.0  1995/12/15  09:13:57  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  01:17:17  andy
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

#define XK_TECHNICAL
#include	<X11/keysymdef.h>
#undef XK_TECHNICAL

kysymdf14()
{ 
int 	pass = 0, fail = 0;
#ifdef XK_leftradical
	if(test("XK_leftradical", XK_leftradical, 0x8A1) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_leftradical");
	FAIL;
#endif

#ifdef XK_topleftradical
	if(test("XK_topleftradical", XK_topleftradical, 0x8A2) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_topleftradical");
	FAIL;
#endif

#ifdef XK_horizconnector
	if(test("XK_horizconnector", XK_horizconnector, 0x8A3) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_horizconnector");
	FAIL;
#endif

#ifdef XK_topintegral
	if(test("XK_topintegral", XK_topintegral, 0x8A4) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_topintegral");
	FAIL;
#endif

#ifdef XK_botintegral
	if(test("XK_botintegral", XK_botintegral, 0x8A5) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_botintegral");
	FAIL;
#endif

#ifdef XK_vertconnector
	if(test("XK_vertconnector", XK_vertconnector, 0x8A6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_vertconnector");
	FAIL;
#endif

#ifdef XK_topleftsqbracket
	if(test("XK_topleftsqbracket", XK_topleftsqbracket, 0x8A7) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_topleftsqbracket");
	FAIL;
#endif

#ifdef XK_botleftsqbracket
	if(test("XK_botleftsqbracket", XK_botleftsqbracket, 0x8A8) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_botleftsqbracket");
	FAIL;
#endif

#ifdef XK_toprightsqbracket
	if(test("XK_toprightsqbracket", XK_toprightsqbracket, 0x8A9) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_toprightsqbracket");
	FAIL;
#endif

#ifdef XK_botrightsqbracket
	if(test("XK_botrightsqbracket", XK_botrightsqbracket, 0x8AA) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_botrightsqbracket");
	FAIL;
#endif

#ifdef XK_topleftparens
	if(test("XK_topleftparens", XK_topleftparens, 0x8AB) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_topleftparens");
	FAIL;
#endif

#ifdef XK_botleftparens
	if(test("XK_botleftparens", XK_botleftparens, 0x8AC) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_botleftparens");
	FAIL;
#endif

#ifdef XK_toprightparens
	if(test("XK_toprightparens", XK_toprightparens, 0x8AD) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_toprightparens");
	FAIL;
#endif

#ifdef XK_botrightparens
	if(test("XK_botrightparens", XK_botrightparens, 0x8AE) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_botrightparens");
	FAIL;
#endif

#ifdef XK_leftmiddlecurlybrace
	if(test("XK_leftmiddlecurlybrace", XK_leftmiddlecurlybrace, 0x8AF) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_leftmiddlecurlybrace");
	FAIL;
#endif

#ifdef XK_rightmiddlecurlybrace
	if(test("XK_rightmiddlecurlybrace", XK_rightmiddlecurlybrace, 0x8B0) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_rightmiddlecurlybrace");
	FAIL;
#endif

#ifdef XK_topleftsummation
	if(test("XK_topleftsummation", XK_topleftsummation, 0x8B1) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_topleftsummation");
	FAIL;
#endif

#ifdef XK_botleftsummation
	if(test("XK_botleftsummation", XK_botleftsummation, 0x8B2) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_botleftsummation");
	FAIL;
#endif

#ifdef XK_topvertsummationconnector
	if(test("XK_topvertsummationconnector", XK_topvertsummationconnector, 0x8B3) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_topvertsummationconnector");
	FAIL;
#endif

#ifdef XK_botvertsummationconnector
	if(test("XK_botvertsummationconnector", XK_botvertsummationconnector, 0x8B4) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_botvertsummationconnector");
	FAIL;
#endif

#ifdef XK_toprightsummation
	if(test("XK_toprightsummation", XK_toprightsummation, 0x8B5) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_toprightsummation");
	FAIL;
#endif

#ifdef XK_botrightsummation
	if(test("XK_botrightsummation", XK_botrightsummation, 0x8B6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_botrightsummation");
	FAIL;
#endif

#ifdef XK_rightmiddlesummation
	if(test("XK_rightmiddlesummation", XK_rightmiddlesummation, 0x8B7) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_rightmiddlesummation");
	FAIL;
#endif

#ifdef XK_lessthanequal
	if(test("XK_lessthanequal", XK_lessthanequal, 0x8BC) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_lessthanequal");
	FAIL;
#endif

#ifdef XK_notequal
	if(test("XK_notequal", XK_notequal, 0x8BD) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_notequal");
	FAIL;
#endif

#ifdef XK_greaterthanequal
	if(test("XK_greaterthanequal", XK_greaterthanequal, 0x8BE) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_greaterthanequal");
	FAIL;
#endif

#ifdef XK_integral
	if(test("XK_integral", XK_integral, 0x8BF) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_integral");
	FAIL;
#endif

#ifdef XK_therefore
	if(test("XK_therefore", XK_therefore, 0x8C0) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_therefore");
	FAIL;
#endif

#ifdef XK_variation
	if(test("XK_variation", XK_variation, 0x8C1) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_variation");
	FAIL;
#endif

#ifdef XK_infinity
	if(test("XK_infinity", XK_infinity, 0x8C2) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_infinity");
	FAIL;
#endif

#ifdef XK_nabla
	if(test("XK_nabla", XK_nabla, 0x8C5) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_nabla");
	FAIL;
#endif

#ifdef XK_approximate
	if(test("XK_approximate", XK_approximate, 0x8C8) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_approximate");
	FAIL;
#endif

#ifdef XK_similarequal
	if(test("XK_similarequal", XK_similarequal, 0x8C9) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_similarequal");
	FAIL;
#endif

#ifdef XK_ifonlyif
	if(test("XK_ifonlyif", XK_ifonlyif, 0x8CD) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_ifonlyif");
	FAIL;
#endif

#ifdef XK_implies
	if(test("XK_implies", XK_implies, 0x8CE) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_implies");
	FAIL;
#endif

#ifdef XK_identical
	if(test("XK_identical", XK_identical, 0x8CF) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_identical");
	FAIL;
#endif

#ifdef XK_radical
	if(test("XK_radical", XK_radical, 0x8D6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_radical");
	FAIL;
#endif

#ifdef XK_includedin
	if(test("XK_includedin", XK_includedin, 0x8DA) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_includedin");
	FAIL;
#endif

#ifdef XK_includes
	if(test("XK_includes", XK_includes, 0x8DB) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_includes");
	FAIL;
#endif

#ifdef XK_intersection
	if(test("XK_intersection", XK_intersection, 0x8DC) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_intersection");
	FAIL;
#endif

#ifdef XK_union
	if(test("XK_union", XK_union, 0x8DD) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_union");
	FAIL;
#endif

#ifdef XK_logicaland
	if(test("XK_logicaland", XK_logicaland, 0x8DE) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_logicaland");
	FAIL;
#endif

#ifdef XK_logicalor
	if(test("XK_logicalor", XK_logicalor, 0x8DF) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_logicalor");
	FAIL;
#endif

#ifdef XK_partialderivative
	if(test("XK_partialderivative", XK_partialderivative, 0x8EF) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_partialderivative");
	FAIL;
#endif

#ifdef XK_function
	if(test("XK_function", XK_function, 0x8F6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_function");
	FAIL;
#endif

#ifdef XK_leftarrow
	if(test("XK_leftarrow", XK_leftarrow, 0x8FB) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_leftarrow");
	FAIL;
#endif

#ifdef XK_uparrow
	if(test("XK_uparrow", XK_uparrow, 0x8FC) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_uparrow");
	FAIL;
#endif

#ifdef XK_rightarrow
	if(test("XK_rightarrow", XK_rightarrow, 0x8FD) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_rightarrow");
	FAIL;
#endif

#ifdef XK_downarrow
	if(test("XK_downarrow", XK_downarrow, 0x8FE) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_downarrow");
	FAIL;
#endif


	CHECKPASS(49);
}
