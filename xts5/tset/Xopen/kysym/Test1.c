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
* $Header: /cvs/xtest/xtest/xts5/tset/Xopen/kysym/Test1.c,v 1.2 2005-11-03 08:44:00 jmichael Exp $
* 
* Project: VSW5
* 
* File: xts5/tset/Xopen/kysym/Test1.c
* 
* Description:
* 	Tests for keysym()
* 
* Modifications:
* $Log: Test1.c,v $
* Revision 1.2  2005-11-03 08:44:00  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:40  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:35:31  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:58:00  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:26:45  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:23:18  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.1  1996/05/09 21:14:55  andy
* Fixed X includes
*
* Revision 4.0  1995/12/15  09:13:27  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  01:16:42  andy
* Prepare for GA Release
*
*/
/*
 *      SCCS:  @(#)  Test1.c Rel 1.1	    (11/28/91)
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

kysym1()
{ 
int	pass = 0, fail = 0;
#ifdef XK_space
	if(test("XK_space", XK_space, 0x20) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_space");
	FAIL;
#endif

#ifdef XK_exclam
	if(test("XK_exclam", XK_exclam, 0x21) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_exclam");
	FAIL;
#endif

#ifdef XK_quotedbl
	if(test("XK_quotedbl", XK_quotedbl, 0x22) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_quotedbl");
	FAIL;
#endif

#ifdef XK_numbersign
	if(test("XK_numbersign", XK_numbersign, 0x23) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_numbersign");
	FAIL;
#endif

#ifdef XK_dollar
	if(test("XK_dollar", XK_dollar, 0x24) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_dollar");
	FAIL;
#endif

#ifdef XK_percent
	if(test("XK_percent", XK_percent, 0x25) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_percent");
	FAIL;
#endif

#ifdef XK_ampersand
	if(test("XK_ampersand", XK_ampersand, 0x26) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_ampersand");
	FAIL;
#endif

#ifdef XK_apostrophe
	if(test("XK_apostrophe", XK_apostrophe, 0x27) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_apostrophe");
	FAIL;
#endif

#ifdef XK_quoteright
	if(test("XK_quoteright", XK_quoteright, 0x27) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_quoteright");
	FAIL;
#endif

#ifdef XK_parenleft
	if(test("XK_parenleft", XK_parenleft, 0x28) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_parenleft");
	FAIL;
#endif

#ifdef XK_parenright
	if(test("XK_parenright", XK_parenright, 0x29) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_parenright");
	FAIL;
#endif

#ifdef XK_asterisk
	if(test("XK_asterisk", XK_asterisk, 0x2A) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_asterisk");
	FAIL;
#endif

#ifdef XK_plus
	if(test("XK_plus", XK_plus, 0x2B) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_plus");
	FAIL;
#endif

#ifdef XK_comma
	if(test("XK_comma", XK_comma, 0x2C) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_comma");
	FAIL;
#endif

#ifdef XK_minus
	if(test("XK_minus", XK_minus, 0x2D) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_minus");
	FAIL;
#endif

#ifdef XK_period
	if(test("XK_period", XK_period, 0x2E) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_period");
	FAIL;
#endif

#ifdef XK_slash
	if(test("XK_slash", XK_slash, 0x2F) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_slash");
	FAIL;
#endif

#ifdef XK_0
	if(test("XK_0", XK_0, 0x30) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_0");
	FAIL;
#endif

#ifdef XK_1
	if(test("XK_1", XK_1, 0x31) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_1");
	FAIL;
#endif

#ifdef XK_2
	if(test("XK_2", XK_2, 0x32) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_2");
	FAIL;
#endif

#ifdef XK_3
	if(test("XK_3", XK_3, 0x33) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_3");
	FAIL;
#endif

#ifdef XK_4
	if(test("XK_4", XK_4, 0x34) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_4");
	FAIL;
#endif

#ifdef XK_5
	if(test("XK_5", XK_5, 0x35) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_5");
	FAIL;
#endif

#ifdef XK_6
	if(test("XK_6", XK_6, 0x36) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_6");
	FAIL;
#endif

#ifdef XK_7
	if(test("XK_7", XK_7, 0x37) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_7");
	FAIL;
#endif

#ifdef XK_8
	if(test("XK_8", XK_8, 0x38) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_8");
	FAIL;
#endif

#ifdef XK_9
	if(test("XK_9", XK_9, 0x39) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_9");
	FAIL;
#endif

#ifdef XK_colon
	if(test("XK_colon", XK_colon, 0x3A) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_colon");
	FAIL;
#endif

#ifdef XK_semicolon
	if(test("XK_semicolon", XK_semicolon, 0x3B) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_semicolon");
	FAIL;
#endif

#ifdef XK_less
	if(test("XK_less", XK_less, 0x3C) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_less");
	FAIL;
#endif

#ifdef XK_equal
	if(test("XK_equal", XK_equal, 0x3D) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_equal");
	FAIL;
#endif

#ifdef XK_greater
	if(test("XK_greater", XK_greater, 0x3E) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_greater");
	FAIL;
#endif

#ifdef XK_question
	if(test("XK_question", XK_question, 0x3F) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_question");
	FAIL;
#endif

#ifdef XK_at
	if(test("XK_at", XK_at, 0x40) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_at");
	FAIL;
#endif

#ifdef XK_A
	if(test("XK_A", XK_A, 0x41) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_A");
	FAIL;
#endif

#ifdef XK_B
	if(test("XK_B", XK_B, 0x42) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_B");
	FAIL;
#endif

#ifdef XK_C
	if(test("XK_C", XK_C, 0x43) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_C");
	FAIL;
#endif

#ifdef XK_D
	if(test("XK_D", XK_D, 0x44) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_D");
	FAIL;
#endif

#ifdef XK_E
	if(test("XK_E", XK_E, 0x45) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_E");
	FAIL;
#endif

#ifdef XK_F
	if(test("XK_F", XK_F, 0x46) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_F");
	FAIL;
#endif

#ifdef XK_G
	if(test("XK_G", XK_G, 0x47) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_G");
	FAIL;
#endif

#ifdef XK_H
	if(test("XK_H", XK_H, 0x48) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_H");
	FAIL;
#endif

#ifdef XK_I
	if(test("XK_I", XK_I, 0x49) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_I");
	FAIL;
#endif

#ifdef XK_J
	if(test("XK_J", XK_J, 0x4A) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_J");
	FAIL;
#endif

#ifdef XK_K
	if(test("XK_K", XK_K, 0x4B) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_K");
	FAIL;
#endif

#ifdef XK_L
	if(test("XK_L", XK_L, 0x4C) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_L");
	FAIL;
#endif

#ifdef XK_M
	if(test("XK_M", XK_M, 0x4D) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_M");
	FAIL;
#endif

#ifdef XK_N
	if(test("XK_N", XK_N, 0x4E) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_N");
	FAIL;
#endif

#ifdef XK_O
	if(test("XK_O", XK_O, 0x4F) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_O");
	FAIL;
#endif

#ifdef XK_P
	if(test("XK_P", XK_P, 0x50) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_P");
	FAIL;
#endif

#ifdef XK_Q
	if(test("XK_Q", XK_Q, 0x51) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Q");
	FAIL;
#endif

#ifdef XK_R
	if(test("XK_R", XK_R, 0x52) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_R");
	FAIL;
#endif

#ifdef XK_S
	if(test("XK_S", XK_S, 0x53) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_S");
	FAIL;
#endif

#ifdef XK_T
	if(test("XK_T", XK_T, 0x54) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_T");
	FAIL;
#endif

#ifdef XK_U
	if(test("XK_U", XK_U, 0x55) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_U");
	FAIL;
#endif

#ifdef XK_V
	if(test("XK_V", XK_V, 0x56) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_V");
	FAIL;
#endif

#ifdef XK_W
	if(test("XK_W", XK_W, 0x57) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_W");
	FAIL;
#endif

#ifdef XK_X
	if(test("XK_X", XK_X, 0x58) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_X");
	FAIL;
#endif

#ifdef XK_Y
	if(test("XK_Y", XK_Y, 0x59) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Y");
	FAIL;
#endif

#ifdef XK_Z
	if(test("XK_Z", XK_Z, 0x5A) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Z");
	FAIL;
#endif

#ifdef XK_bracketleft
	if(test("XK_bracketleft", XK_bracketleft, 0x5B) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_bracketleft");
	FAIL;
#endif

#ifdef XK_backslash
	if(test("XK_backslash", XK_backslash, 0x5C) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_backslash");
	FAIL;
#endif

#ifdef XK_bracketright
	if(test("XK_bracketright", XK_bracketright, 0x5D) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_bracketright");
	FAIL;
#endif

#ifdef XK_asciicircum
	if(test("XK_asciicircum", XK_asciicircum, 0x5E) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_asciicircum");
	FAIL;
#endif

#ifdef XK_underscore
	if(test("XK_underscore", XK_underscore, 0x5F) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_underscore");
	FAIL;
#endif

#ifdef XK_grave
	if(test("XK_grave", XK_grave, 0x60) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_grave");
	FAIL;
#endif

#ifdef XK_quoteleft
	if(test("XK_quoteleft", XK_quoteleft, 0x60) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_quoteleft");
	FAIL;
#endif

#ifdef XK_a
	if(test("XK_a", XK_a, 0x61) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_a");
	FAIL;
#endif

#ifdef XK_b
	if(test("XK_b", XK_b, 0x62) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_b");
	FAIL;
#endif

#ifdef XK_c
	if(test("XK_c", XK_c, 0x63) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_c");
	FAIL;
#endif

#ifdef XK_d
	if(test("XK_d", XK_d, 0x64) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_d");
	FAIL;
#endif

#ifdef XK_e
	if(test("XK_e", XK_e, 0x65) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_e");
	FAIL;
#endif

#ifdef XK_f
	if(test("XK_f", XK_f, 0x66) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_f");
	FAIL;
#endif

#ifdef XK_g
	if(test("XK_g", XK_g, 0x67) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_g");
	FAIL;
#endif

#ifdef XK_h
	if(test("XK_h", XK_h, 0x68) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_h");
	FAIL;
#endif

#ifdef XK_i
	if(test("XK_i", XK_i, 0x69) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_i");
	FAIL;
#endif

#ifdef XK_j
	if(test("XK_j", XK_j, 0x6A) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_j");
	FAIL;
#endif

#ifdef XK_k
	if(test("XK_k", XK_k, 0x6B) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_k");
	FAIL;
#endif

#ifdef XK_l
	if(test("XK_l", XK_l, 0x6C) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_l");
	FAIL;
#endif

#ifdef XK_m
	if(test("XK_m", XK_m, 0x6D) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_m");
	FAIL;
#endif

#ifdef XK_n
	if(test("XK_n", XK_n, 0x6E) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_n");
	FAIL;
#endif

#ifdef XK_o
	if(test("XK_o", XK_o, 0x6F) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_o");
	FAIL;
#endif

#ifdef XK_p
	if(test("XK_p", XK_p, 0x70) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_p");
	FAIL;
#endif

#ifdef XK_q
	if(test("XK_q", XK_q, 0x71) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_q");
	FAIL;
#endif

#ifdef XK_r
	if(test("XK_r", XK_r, 0x72) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_r");
	FAIL;
#endif

#ifdef XK_s
	if(test("XK_s", XK_s, 0x73) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_s");
	FAIL;
#endif

#ifdef XK_t
	if(test("XK_t", XK_t, 0x74) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_t");
	FAIL;
#endif

#ifdef XK_u
	if(test("XK_u", XK_u, 0x75) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_u");
	FAIL;
#endif

#ifdef XK_v
	if(test("XK_v", XK_v, 0x76) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_v");
	FAIL;
#endif

#ifdef XK_w
	if(test("XK_w", XK_w, 0x77) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_w");
	FAIL;
#endif

#ifdef XK_x
	if(test("XK_x", XK_x, 0x78) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_x");
	FAIL;
#endif

#ifdef XK_y
	if(test("XK_y", XK_y, 0x79) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_y");
	FAIL;
#endif

#ifdef XK_z
	if(test("XK_z", XK_z, 0x7A) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_z");
	FAIL;
#endif

#ifdef XK_braceleft
	if(test("XK_braceleft", XK_braceleft, 0x7B) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_braceleft");
	FAIL;
#endif

#ifdef XK_bar
	if(test("XK_bar", XK_bar, 0x7C) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_bar");
	FAIL;
#endif

#ifdef XK_braceright
	if(test("XK_braceright", XK_braceright, 0x7D) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_braceright");
	FAIL;
#endif

#ifdef XK_asciitilde
	if(test("XK_asciitilde", XK_asciitilde, 0x7E) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_asciitilde");
	FAIL;
#endif

#ifdef XK_nobreakspace
	if(test("XK_nobreakspace", XK_nobreakspace, 0xA0) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_nobreakspace");
	FAIL;
#endif

#ifdef XK_exclamdown
	if(test("XK_exclamdown", XK_exclamdown, 0xA1) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_exclamdown");
	FAIL;
#endif

#ifdef XK_cent
	if(test("XK_cent", XK_cent, 0xA2) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_cent");
	FAIL;
#endif

#ifdef XK_sterling
	if(test("XK_sterling", XK_sterling, 0xA3) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_sterling");
	FAIL;
#endif

#ifdef XK_currency
	if(test("XK_currency", XK_currency, 0xA4) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_currency");
	FAIL;
#endif

#ifdef XK_yen
	if(test("XK_yen", XK_yen, 0xA5) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_yen");
	FAIL;
#endif

#ifdef XK_brokenbar
	if(test("XK_brokenbar", XK_brokenbar, 0xA6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_brokenbar");
	FAIL;
#endif

#ifdef XK_section
	if(test("XK_section", XK_section, 0xA7) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_section");
	FAIL;
#endif

#ifdef XK_diaeresis
	if(test("XK_diaeresis", XK_diaeresis, 0xA8) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_diaeresis");
	FAIL;
#endif

#ifdef XK_copyright
	if(test("XK_copyright", XK_copyright, 0xA9) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_copyright");
	FAIL;
#endif

#ifdef XK_ordfeminine
	if(test("XK_ordfeminine", XK_ordfeminine, 0xAA) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_ordfeminine");
	FAIL;
#endif

#ifdef XK_guillemotleft
	if(test("XK_guillemotleft", XK_guillemotleft, 0xAB) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_guillemotleft");
	FAIL;
#endif

#ifdef XK_notsign
	if(test("XK_notsign", XK_notsign, 0xAC) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_notsign");
	FAIL;
#endif

#ifdef XK_hyphen
	if(test("XK_hyphen", XK_hyphen, 0xAD) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_hyphen");
	FAIL;
#endif

#ifdef XK_registered
	if(test("XK_registered", XK_registered, 0xAE) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_registered");
	FAIL;
#endif

#ifdef XK_macron
	if(test("XK_macron", XK_macron, 0xAF) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_macron");
	FAIL;
#endif

#ifdef XK_degree
	if(test("XK_degree", XK_degree, 0xB0) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_degree");
	FAIL;
#endif

#ifdef XK_plusminus
	if(test("XK_plusminus", XK_plusminus, 0xB1) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_plusminus");
	FAIL;
#endif

#ifdef XK_twosuperior
	if(test("XK_twosuperior", XK_twosuperior, 0xB2) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_twosuperior");
	FAIL;
#endif

#ifdef XK_threesuperior
	if(test("XK_threesuperior", XK_threesuperior, 0xB3) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_threesuperior");
	FAIL;
#endif

#ifdef XK_acute
	if(test("XK_acute", XK_acute, 0xB4) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_acute");
	FAIL;
#endif

#ifdef XK_mu
	if(test("XK_mu", XK_mu, 0xB5) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_mu");
	FAIL;
#endif

#ifdef XK_paragraph
	if(test("XK_paragraph", XK_paragraph, 0xB6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_paragraph");
	FAIL;
#endif

#ifdef XK_periodcentered
	if(test("XK_periodcentered", XK_periodcentered, 0xB7) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_periodcentered");
	FAIL;
#endif

#ifdef XK_cedilla
	if(test("XK_cedilla", XK_cedilla, 0xB8) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_cedilla");
	FAIL;
#endif

#ifdef XK_onesuperior
	if(test("XK_onesuperior", XK_onesuperior, 0xB9) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_onesuperior");
	FAIL;
#endif

#ifdef XK_masculine
	if(test("XK_masculine", XK_masculine, 0xBA) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_masculine");
	FAIL;
#endif

#ifdef XK_guillemotright
	if(test("XK_guillemotright", XK_guillemotright, 0xBB) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_guillemotright");
	FAIL;
#endif

#ifdef XK_onequarter
	if(test("XK_onequarter", XK_onequarter, 0xBC) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_onequarter");
	FAIL;
#endif

#ifdef XK_onehalf
	if(test("XK_onehalf", XK_onehalf, 0xBD) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_onehalf");
	FAIL;
#endif

#ifdef XK_threequarters
	if(test("XK_threequarters", XK_threequarters, 0xBE) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_threequarters");
	FAIL;
#endif

#ifdef XK_questiondown
	if(test("XK_questiondown", XK_questiondown, 0xBF) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_questiondown");
	FAIL;
#endif

#ifdef XK_Agrave
	if(test("XK_Agrave", XK_Agrave, 0xC0) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Agrave");
	FAIL;
#endif

#ifdef XK_Aacute
	if(test("XK_Aacute", XK_Aacute, 0xC1) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Aacute");
	FAIL;
#endif

#ifdef XK_Acircumflex
	if(test("XK_Acircumflex", XK_Acircumflex, 0xC2) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Acircumflex");
	FAIL;
#endif

#ifdef XK_Atilde
	if(test("XK_Atilde", XK_Atilde, 0xC3) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Atilde");
	FAIL;
#endif

#ifdef XK_Adiaeresis
	if(test("XK_Adiaeresis", XK_Adiaeresis, 0xC4) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Adiaeresis");
	FAIL;
#endif

#ifdef XK_Aring
	if(test("XK_Aring", XK_Aring, 0xC5) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Aring");
	FAIL;
#endif

#ifdef XK_AE
	if(test("XK_AE", XK_AE, 0xC6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_AE");
	FAIL;
#endif

#ifdef XK_Ccedilla
	if(test("XK_Ccedilla", XK_Ccedilla, 0xC7) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Ccedilla");
	FAIL;
#endif

#ifdef XK_Egrave
	if(test("XK_Egrave", XK_Egrave, 0xC8) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Egrave");
	FAIL;
#endif

#ifdef XK_Eacute
	if(test("XK_Eacute", XK_Eacute, 0xC9) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Eacute");
	FAIL;
#endif

#ifdef XK_Ecircumflex
	if(test("XK_Ecircumflex", XK_Ecircumflex, 0xCA) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Ecircumflex");
	FAIL;
#endif

#ifdef XK_Ediaeresis
	if(test("XK_Ediaeresis", XK_Ediaeresis, 0xCB) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Ediaeresis");
	FAIL;
#endif

#ifdef XK_Igrave
	if(test("XK_Igrave", XK_Igrave, 0xCC) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Igrave");
	FAIL;
#endif

#ifdef XK_Iacute
	if(test("XK_Iacute", XK_Iacute, 0xCD) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Iacute");
	FAIL;
#endif

#ifdef XK_Icircumflex
	if(test("XK_Icircumflex", XK_Icircumflex, 0xCE) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Icircumflex");
	FAIL;
#endif

#ifdef XK_Idiaeresis
	if(test("XK_Idiaeresis", XK_Idiaeresis, 0xCF) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Idiaeresis");
	FAIL;
#endif

#ifdef XK_ETH
	if(test("XK_ETH", XK_ETH, 0xD0) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_ETH");
	FAIL;
#endif

#ifdef XK_Eth
	if(test("XK_Eth", XK_Eth, 0xD0) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Eth");
	FAIL;
#endif

#ifdef XK_Ntilde
	if(test("XK_Ntilde", XK_Ntilde, 0xD1) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Ntilde");
	FAIL;
#endif

#ifdef XK_Ograve
	if(test("XK_Ograve", XK_Ograve, 0xD2) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Ograve");
	FAIL;
#endif

#ifdef XK_Oacute
	if(test("XK_Oacute", XK_Oacute, 0xD3) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Oacute");
	FAIL;
#endif

#ifdef XK_Ocircumflex
	if(test("XK_Ocircumflex", XK_Ocircumflex, 0xD4) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Ocircumflex");
	FAIL;
#endif

#ifdef XK_Otilde
	if(test("XK_Otilde", XK_Otilde, 0xD5) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Otilde");
	FAIL;
#endif

#ifdef XK_Odiaeresis
	if(test("XK_Odiaeresis", XK_Odiaeresis, 0xD6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Odiaeresis");
	FAIL;
#endif

#ifdef XK_multiply
	if(test("XK_multiply", XK_multiply, 0xD7) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_multiply");
	FAIL;
#endif

#ifdef XK_Ooblique
	if(test("XK_Ooblique", XK_Ooblique, 0xD8) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Ooblique");
	FAIL;
#endif

#ifdef XK_Ugrave
	if(test("XK_Ugrave", XK_Ugrave, 0xD9) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Ugrave");
	FAIL;
#endif

#ifdef XK_Uacute
	if(test("XK_Uacute", XK_Uacute, 0xDA) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Uacute");
	FAIL;
#endif

#ifdef XK_Ucircumflex
	if(test("XK_Ucircumflex", XK_Ucircumflex, 0xDB) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Ucircumflex");
	FAIL;
#endif

#ifdef XK_Udiaeresis
	if(test("XK_Udiaeresis", XK_Udiaeresis, 0xDC) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Udiaeresis");
	FAIL;
#endif

#ifdef XK_Yacute
	if(test("XK_Yacute", XK_Yacute, 0xDD) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Yacute");
	FAIL;
#endif

#ifdef XK_THORN
	if(test("XK_THORN", XK_THORN, 0xDE) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_THORN");
	FAIL;
#endif

#ifdef XK_Thorn
	if(test("XK_Thorn", XK_Thorn, 0xDE) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Thorn");
	FAIL;
#endif

#ifdef XK_ssharp
	if(test("XK_ssharp", XK_ssharp, 0xDF) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_ssharp");
	FAIL;
#endif

#ifdef XK_agrave
	if(test("XK_agrave", XK_agrave, 0xE0) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_agrave");
	FAIL;
#endif

#ifdef XK_aacute
	if(test("XK_aacute", XK_aacute, 0xE1) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_aacute");
	FAIL;
#endif

#ifdef XK_acircumflex
	if(test("XK_acircumflex", XK_acircumflex, 0xE2) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_acircumflex");
	FAIL;
#endif

#ifdef XK_atilde
	if(test("XK_atilde", XK_atilde, 0xE3) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_atilde");
	FAIL;
#endif

#ifdef XK_adiaeresis
	if(test("XK_adiaeresis", XK_adiaeresis, 0xE4) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_adiaeresis");
	FAIL;
#endif

#ifdef XK_aring
	if(test("XK_aring", XK_aring, 0xE5) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_aring");
	FAIL;
#endif

#ifdef XK_ae
	if(test("XK_ae", XK_ae, 0xE6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_ae");
	FAIL;
#endif

#ifdef XK_ccedilla
	if(test("XK_ccedilla", XK_ccedilla, 0xE7) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_ccedilla");
	FAIL;
#endif

#ifdef XK_egrave
	if(test("XK_egrave", XK_egrave, 0xE8) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_egrave");
	FAIL;
#endif

#ifdef XK_eacute
	if(test("XK_eacute", XK_eacute, 0xE9) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_eacute");
	FAIL;
#endif

#ifdef XK_ecircumflex
	if(test("XK_ecircumflex", XK_ecircumflex, 0xEA) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_ecircumflex");
	FAIL;
#endif

#ifdef XK_ediaeresis
	if(test("XK_ediaeresis", XK_ediaeresis, 0xEB) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_ediaeresis");
	FAIL;
#endif

#ifdef XK_igrave
	if(test("XK_igrave", XK_igrave, 0xEC) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_igrave");
	FAIL;
#endif

#ifdef XK_iacute
	if(test("XK_iacute", XK_iacute, 0xED) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_iacute");
	FAIL;
#endif

#ifdef XK_icircumflex
	if(test("XK_icircumflex", XK_icircumflex, 0xEE) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_icircumflex");
	FAIL;
#endif

#ifdef XK_idiaeresis
	if(test("XK_idiaeresis", XK_idiaeresis, 0xEF) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_idiaeresis");
	FAIL;
#endif

#ifdef XK_eth
	if(test("XK_eth", XK_eth, 0xF0) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_eth");
	FAIL;
#endif

#ifdef XK_ntilde
	if(test("XK_ntilde", XK_ntilde, 0xF1) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_ntilde");
	FAIL;
#endif

#ifdef XK_ograve
	if(test("XK_ograve", XK_ograve, 0xF2) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_ograve");
	FAIL;
#endif

#ifdef XK_oacute
	if(test("XK_oacute", XK_oacute, 0xF3) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_oacute");
	FAIL;
#endif

#ifdef XK_ocircumflex
	if(test("XK_ocircumflex", XK_ocircumflex, 0xF4) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_ocircumflex");
	FAIL;
#endif

#ifdef XK_otilde
	if(test("XK_otilde", XK_otilde, 0xF5) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_otilde");
	FAIL;
#endif

#ifdef XK_odiaeresis
	if(test("XK_odiaeresis", XK_odiaeresis, 0xF6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_odiaeresis");
	FAIL;
#endif

#ifdef XK_division
	if(test("XK_division", XK_division, 0xF7) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_division");
	FAIL;
#endif

#ifdef XK_oslash
	if(test("XK_oslash", XK_oslash, 0xF8) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_oslash");
	FAIL;
#endif

#ifdef XK_ugrave
	if(test("XK_ugrave", XK_ugrave, 0xF9) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_ugrave");
	FAIL;
#endif

#ifdef XK_uacute
	if(test("XK_uacute", XK_uacute, 0xFA) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_uacute");
	FAIL;
#endif

#ifdef XK_ucircumflex
	if(test("XK_ucircumflex", XK_ucircumflex, 0xFB) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_ucircumflex");
	FAIL;
#endif

#ifdef XK_udiaeresis
	if(test("XK_udiaeresis", XK_udiaeresis, 0xFC) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_udiaeresis");
	FAIL;
#endif

#ifdef XK_yacute
	if(test("XK_yacute", XK_yacute, 0xFD) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_yacute");
	FAIL;
#endif

#ifdef XK_thorn
	if(test("XK_thorn", XK_thorn, 0xFE) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_thorn");
	FAIL;
#endif

#ifdef XK_ydiaeresis
	if(test("XK_ydiaeresis", XK_ydiaeresis, 0xFF) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_ydiaeresis");
	FAIL;
#endif


	CHECKPASS(195);
}
