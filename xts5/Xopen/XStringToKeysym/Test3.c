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
* File: xts5/tset/Xopen/XStringToKeysym/Test3.c
* 
* Description:
* 	Tests for XStringToKeysym()
* 
* Modifications:
* $Log: Test3.c,v $
* Revision 1.2  2005-11-03 08:44:01  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:40  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:35:54  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:58:36  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:27:07  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:23:40  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.1  1996/05/09 21:19:34  andy
* Fixed X includes
*
* Revision 4.0  1995/12/15  09:14:34  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  01:17:58  andy
* Prepare for GA Release
*
*/
/*
 *      SCCS:  @(#)  Test3.c Rel 1.1	    (11/28/91)
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
#define XK_LATIN3
#include	<X11/keysymdef.h>
#undef XK_LATIN3 

strtsym3()
{ 
int 	pass = 0, fail = 0;
char	*symstr;
KeySym	rsym;


#ifdef XK_Hstroke
	if(test(XK_Hstroke, "Hstroke") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Hstroke");
	FAIL;
#endif

#ifdef XK_Hcircumflex
	if(test(XK_Hcircumflex, "Hcircumflex") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Hcircumflex");
	FAIL;
#endif

#ifdef XK_Iabovedot
	if(test(XK_Iabovedot, "Iabovedot") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Iabovedot");
	FAIL;
#endif

#ifdef XK_Gbreve
	if(test(XK_Gbreve, "Gbreve") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Gbreve");
	FAIL;
#endif

#ifdef XK_Jcircumflex
	if(test(XK_Jcircumflex, "Jcircumflex") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Jcircumflex");
	FAIL;
#endif

#ifdef XK_hstroke
	if(test(XK_hstroke, "hstroke") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_hstroke");
	FAIL;
#endif

#ifdef XK_hcircumflex
	if(test(XK_hcircumflex, "hcircumflex") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_hcircumflex");
	FAIL;
#endif

#ifdef XK_idotless
	if(test(XK_idotless, "idotless") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_idotless");
	FAIL;
#endif

#ifdef XK_gbreve
	if(test(XK_gbreve, "gbreve") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_gbreve");
	FAIL;
#endif

#ifdef XK_jcircumflex
	if(test(XK_jcircumflex, "jcircumflex") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_jcircumflex");
	FAIL;
#endif

#ifdef XK_Cabovedot
	if(test(XK_Cabovedot, "Cabovedot") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Cabovedot");
	FAIL;
#endif

#ifdef XK_Ccircumflex
	if(test(XK_Ccircumflex, "Ccircumflex") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Ccircumflex");
	FAIL;
#endif

#ifdef XK_Gabovedot
	if(test(XK_Gabovedot, "Gabovedot") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Gabovedot");
	FAIL;
#endif

#ifdef XK_Gcircumflex
	if(test(XK_Gcircumflex, "Gcircumflex") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Gcircumflex");
	FAIL;
#endif

#ifdef XK_Ubreve
	if(test(XK_Ubreve, "Ubreve") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Ubreve");
	FAIL;
#endif

#ifdef XK_Scircumflex
	if(test(XK_Scircumflex, "Scircumflex") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Scircumflex");
	FAIL;
#endif

#ifdef XK_cabovedot
	if(test(XK_cabovedot, "cabovedot") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_cabovedot");
	FAIL;
#endif

#ifdef XK_ccircumflex
	if(test(XK_ccircumflex, "ccircumflex") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_ccircumflex");
	FAIL;
#endif

#ifdef XK_gabovedot
	if(test(XK_gabovedot, "gabovedot") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_gabovedot");
	FAIL;
#endif

#ifdef XK_gcircumflex
	if(test(XK_gcircumflex, "gcircumflex") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_gcircumflex");
	FAIL;
#endif

#ifdef XK_ubreve
	if(test(XK_ubreve, "ubreve") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_ubreve");
	FAIL;
#endif

#ifdef XK_scircumflex
	if(test(XK_scircumflex, "scircumflex") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_scircumflex");
	FAIL;
#endif

	CHECKPASS(22);
}
