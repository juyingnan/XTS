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
* $Header: /cvs/xtest/xtest/xts5/tset/Xopen/kysym/Test3.c,v 1.1 2005-02-12 14:37:43 anderson Exp $
* 
* Project: VSW5
* 
* File: vsw5/tset/Xopen/kysym/Test3.c
* 
* Description:
* 	Tests for keysym()
* 
* Modifications:
* $Log: Test3.c,v $
* Revision 1.1  2005-02-12 14:37:43  anderson
* Initial revision
*
* Revision 8.0  1998/12/23 23:35:32  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:58:01  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:26:46  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:23:19  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.1  1996/05/09 21:14:55  andy
* Fixed X includes
*
* Revision 4.0  1995/12/15  09:13:30  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  01:16:45  andy
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

kysym3()
{ 
int	pass = 0, fail = 0;
#ifdef XK_Hstroke
	if(test("XK_Hstroke", XK_Hstroke, 0x2A1) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Hstroke");
	FAIL;
#endif

#ifdef XK_Hcircumflex
	if(test("XK_Hcircumflex", XK_Hcircumflex, 0x2A6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Hcircumflex");
	FAIL;
#endif

#ifdef XK_Iabovedot
	if(test("XK_Iabovedot", XK_Iabovedot, 0x2A9) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Iabovedot");
	FAIL;
#endif

#ifdef XK_Gbreve
	if(test("XK_Gbreve", XK_Gbreve, 0x2AB) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Gbreve");
	FAIL;
#endif

#ifdef XK_Jcircumflex
	if(test("XK_Jcircumflex", XK_Jcircumflex, 0x2AC) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Jcircumflex");
	FAIL;
#endif

#ifdef XK_hstroke
	if(test("XK_hstroke", XK_hstroke, 0x2B1) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_hstroke");
	FAIL;
#endif

#ifdef XK_hcircumflex
	if(test("XK_hcircumflex", XK_hcircumflex, 0x2B6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_hcircumflex");
	FAIL;
#endif

#ifdef XK_idotless
	if(test("XK_idotless", XK_idotless, 0x2B9) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_idotless");
	FAIL;
#endif

#ifdef XK_gbreve
	if(test("XK_gbreve", XK_gbreve, 0x2BB) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_gbreve");
	FAIL;
#endif

#ifdef XK_jcircumflex
	if(test("XK_jcircumflex", XK_jcircumflex, 0x2BC) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_jcircumflex");
	FAIL;
#endif

#ifdef XK_Cabovedot
	if(test("XK_Cabovedot", XK_Cabovedot, 0x2C5) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cabovedot");
	FAIL;
#endif

#ifdef XK_Ccircumflex
	if(test("XK_Ccircumflex", XK_Ccircumflex, 0x2C6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Ccircumflex");
	FAIL;
#endif

#ifdef XK_Gabovedot
	if(test("XK_Gabovedot", XK_Gabovedot, 0x2D5) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Gabovedot");
	FAIL;
#endif

#ifdef XK_Gcircumflex
	if(test("XK_Gcircumflex", XK_Gcircumflex, 0x2D8) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Gcircumflex");
	FAIL;
#endif

#ifdef XK_Ubreve
	if(test("XK_Ubreve", XK_Ubreve, 0x2DD) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Ubreve");
	FAIL;
#endif

#ifdef XK_Scircumflex
	if(test("XK_Scircumflex", XK_Scircumflex, 0x2DE) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Scircumflex");
	FAIL;
#endif

#ifdef XK_cabovedot
	if(test("XK_cabovedot", XK_cabovedot, 0x2E5) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_cabovedot");
	FAIL;
#endif

#ifdef XK_ccircumflex
	if(test("XK_ccircumflex", XK_ccircumflex, 0x2E6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_ccircumflex");
	FAIL;
#endif

#ifdef XK_gabovedot
	if(test("XK_gabovedot", XK_gabovedot, 0x2F5) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_gabovedot");
	FAIL;
#endif

#ifdef XK_gcircumflex
	if(test("XK_gcircumflex", XK_gcircumflex, 0x2F8) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_gcircumflex");
	FAIL;
#endif

#ifdef XK_ubreve
	if(test("XK_ubreve", XK_ubreve, 0x2FD) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_ubreve");
	FAIL;
#endif

#ifdef XK_scircumflex
	if(test("XK_scircumflex", XK_scircumflex, 0x2FE) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_scircumflex");
	FAIL;
#endif


	CHECKPASS(22);
}
