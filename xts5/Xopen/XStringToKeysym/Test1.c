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
* File: xts5/Xopen/XStringToKeysym/Test1.c
* 
* Description:
* 	Tests for XStringToKeysym()
* 
* Modifications:
* $Log: Test1.c,v $
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
* Revision 5.0  1998/01/26 03:23:39  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.1  1996/05/09 21:19:34  andy
* Fixed X includes
*
* Revision 4.0  1995/12/15  09:14:31  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  01:17:55  andy
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
#define XK_LATIN1
#include	<X11/keysymdef.h>
#undef XK_LATIN1 

strtsym1()
{ 
int 	pass = 0, fail = 0;
char	*symstr;
KeySym	rsym;


#ifdef XK_space
	if(test(XK_space, "space") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_space");
	FAIL;
#endif

#ifdef XK_exclam
	if(test(XK_exclam, "exclam") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_exclam");
	FAIL;
#endif

#ifdef XK_quotedbl
	if(test(XK_quotedbl, "quotedbl") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_quotedbl");
	FAIL;
#endif

#ifdef XK_numbersign
	if(test(XK_numbersign, "numbersign") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_numbersign");
	FAIL;
#endif

#ifdef XK_dollar
	if(test(XK_dollar, "dollar") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_dollar");
	FAIL;
#endif

#ifdef XK_percent
	if(test(XK_percent, "percent") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_percent");
	FAIL;
#endif

#ifdef XK_ampersand
	if(test(XK_ampersand, "ampersand") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_ampersand");
	FAIL;
#endif

#ifdef XK_apostrophe
	if(test(XK_apostrophe, "apostrophe") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_apostrophe");
	FAIL;
#endif

#ifdef XK_quoteright
	if(test(XK_quoteright, "quoteright") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_quoteright");
	FAIL;
#endif

#ifdef XK_parenleft
	if(test(XK_parenleft, "parenleft") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_parenleft");
	FAIL;
#endif

#ifdef XK_parenright
	if(test(XK_parenright, "parenright") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_parenright");
	FAIL;
#endif

#ifdef XK_asterisk
	if(test(XK_asterisk, "asterisk") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_asterisk");
	FAIL;
#endif

#ifdef XK_plus
	if(test(XK_plus, "plus") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_plus");
	FAIL;
#endif

#ifdef XK_comma
	if(test(XK_comma, "comma") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_comma");
	FAIL;
#endif

#ifdef XK_minus
	if(test(XK_minus, "minus") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_minus");
	FAIL;
#endif

#ifdef XK_period
	if(test(XK_period, "period") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_period");
	FAIL;
#endif

#ifdef XK_slash
	if(test(XK_slash, "slash") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_slash");
	FAIL;
#endif

#ifdef XK_0
	if(test(XK_0, "0") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_0");
	FAIL;
#endif

#ifdef XK_1
	if(test(XK_1, "1") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_1");
	FAIL;
#endif

#ifdef XK_2
	if(test(XK_2, "2") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_2");
	FAIL;
#endif

#ifdef XK_3
	if(test(XK_3, "3") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_3");
	FAIL;
#endif

#ifdef XK_4
	if(test(XK_4, "4") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_4");
	FAIL;
#endif

#ifdef XK_5
	if(test(XK_5, "5") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_5");
	FAIL;
#endif

#ifdef XK_6
	if(test(XK_6, "6") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_6");
	FAIL;
#endif

#ifdef XK_7
	if(test(XK_7, "7") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_7");
	FAIL;
#endif

#ifdef XK_8
	if(test(XK_8, "8") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_8");
	FAIL;
#endif

#ifdef XK_9
	if(test(XK_9, "9") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_9");
	FAIL;
#endif

#ifdef XK_colon
	if(test(XK_colon, "colon") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_colon");
	FAIL;
#endif

#ifdef XK_semicolon
	if(test(XK_semicolon, "semicolon") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_semicolon");
	FAIL;
#endif

#ifdef XK_less
	if(test(XK_less, "less") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_less");
	FAIL;
#endif

#ifdef XK_equal
	if(test(XK_equal, "equal") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_equal");
	FAIL;
#endif

#ifdef XK_greater
	if(test(XK_greater, "greater") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_greater");
	FAIL;
#endif

#ifdef XK_question
	if(test(XK_question, "question") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_question");
	FAIL;
#endif

#ifdef XK_at
	if(test(XK_at, "at") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_at");
	FAIL;
#endif

#ifdef XK_A
	if(test(XK_A, "A") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_A");
	FAIL;
#endif

#ifdef XK_B
	if(test(XK_B, "B") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_B");
	FAIL;
#endif

#ifdef XK_C
	if(test(XK_C, "C") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_C");
	FAIL;
#endif

#ifdef XK_D
	if(test(XK_D, "D") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_D");
	FAIL;
#endif

#ifdef XK_E
	if(test(XK_E, "E") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_E");
	FAIL;
#endif

#ifdef XK_F
	if(test(XK_F, "F") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_F");
	FAIL;
#endif

#ifdef XK_G
	if(test(XK_G, "G") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_G");
	FAIL;
#endif

#ifdef XK_H
	if(test(XK_H, "H") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_H");
	FAIL;
#endif

#ifdef XK_I
	if(test(XK_I, "I") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_I");
	FAIL;
#endif

#ifdef XK_J
	if(test(XK_J, "J") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_J");
	FAIL;
#endif

#ifdef XK_K
	if(test(XK_K, "K") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_K");
	FAIL;
#endif

#ifdef XK_L
	if(test(XK_L, "L") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_L");
	FAIL;
#endif

#ifdef XK_M
	if(test(XK_M, "M") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_M");
	FAIL;
#endif

#ifdef XK_N
	if(test(XK_N, "N") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_N");
	FAIL;
#endif

#ifdef XK_O
	if(test(XK_O, "O") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_O");
	FAIL;
#endif

#ifdef XK_P
	if(test(XK_P, "P") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_P");
	FAIL;
#endif

#ifdef XK_Q
	if(test(XK_Q, "Q") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Q");
	FAIL;
#endif

#ifdef XK_R
	if(test(XK_R, "R") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_R");
	FAIL;
#endif

#ifdef XK_S
	if(test(XK_S, "S") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_S");
	FAIL;
#endif

#ifdef XK_T
	if(test(XK_T, "T") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_T");
	FAIL;
#endif

#ifdef XK_U
	if(test(XK_U, "U") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_U");
	FAIL;
#endif

#ifdef XK_V
	if(test(XK_V, "V") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_V");
	FAIL;
#endif

#ifdef XK_W
	if(test(XK_W, "W") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_W");
	FAIL;
#endif

#ifdef XK_X
	if(test(XK_X, "X") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_X");
	FAIL;
#endif

#ifdef XK_Y
	if(test(XK_Y, "Y") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Y");
	FAIL;
#endif

#ifdef XK_Z
	if(test(XK_Z, "Z") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Z");
	FAIL;
#endif

#ifdef XK_bracketleft
	if(test(XK_bracketleft, "bracketleft") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_bracketleft");
	FAIL;
#endif

#ifdef XK_backslash
	if(test(XK_backslash, "backslash") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_backslash");
	FAIL;
#endif

#ifdef XK_bracketright
	if(test(XK_bracketright, "bracketright") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_bracketright");
	FAIL;
#endif

#ifdef XK_asciicircum
	if(test(XK_asciicircum, "asciicircum") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_asciicircum");
	FAIL;
#endif

#ifdef XK_underscore
	if(test(XK_underscore, "underscore") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_underscore");
	FAIL;
#endif

#ifdef XK_grave
	if(test(XK_grave, "grave") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_grave");
	FAIL;
#endif

#ifdef XK_quoteleft
	if(test(XK_quoteleft, "quoteleft") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_quoteleft");
	FAIL;
#endif

#ifdef XK_a
	if(test(XK_a, "a") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_a");
	FAIL;
#endif

#ifdef XK_b
	if(test(XK_b, "b") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_b");
	FAIL;
#endif

#ifdef XK_c
	if(test(XK_c, "c") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_c");
	FAIL;
#endif

#ifdef XK_d
	if(test(XK_d, "d") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_d");
	FAIL;
#endif

#ifdef XK_e
	if(test(XK_e, "e") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_e");
	FAIL;
#endif

#ifdef XK_f
	if(test(XK_f, "f") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_f");
	FAIL;
#endif

#ifdef XK_g
	if(test(XK_g, "g") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_g");
	FAIL;
#endif

#ifdef XK_h
	if(test(XK_h, "h") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_h");
	FAIL;
#endif

#ifdef XK_i
	if(test(XK_i, "i") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_i");
	FAIL;
#endif

#ifdef XK_j
	if(test(XK_j, "j") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_j");
	FAIL;
#endif

#ifdef XK_k
	if(test(XK_k, "k") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_k");
	FAIL;
#endif

#ifdef XK_l
	if(test(XK_l, "l") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_l");
	FAIL;
#endif

#ifdef XK_m
	if(test(XK_m, "m") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_m");
	FAIL;
#endif

#ifdef XK_n
	if(test(XK_n, "n") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_n");
	FAIL;
#endif

#ifdef XK_o
	if(test(XK_o, "o") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_o");
	FAIL;
#endif

#ifdef XK_p
	if(test(XK_p, "p") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_p");
	FAIL;
#endif

#ifdef XK_q
	if(test(XK_q, "q") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_q");
	FAIL;
#endif

#ifdef XK_r
	if(test(XK_r, "r") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_r");
	FAIL;
#endif

#ifdef XK_s
	if(test(XK_s, "s") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_s");
	FAIL;
#endif

#ifdef XK_t
	if(test(XK_t, "t") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_t");
	FAIL;
#endif

#ifdef XK_u
	if(test(XK_u, "u") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_u");
	FAIL;
#endif

#ifdef XK_v
	if(test(XK_v, "v") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_v");
	FAIL;
#endif

#ifdef XK_w
	if(test(XK_w, "w") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_w");
	FAIL;
#endif

#ifdef XK_x
	if(test(XK_x, "x") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_x");
	FAIL;
#endif

#ifdef XK_y
	if(test(XK_y, "y") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_y");
	FAIL;
#endif

#ifdef XK_z
	if(test(XK_z, "z") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_z");
	FAIL;
#endif

#ifdef XK_braceleft
	if(test(XK_braceleft, "braceleft") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_braceleft");
	FAIL;
#endif

#ifdef XK_bar
	if(test(XK_bar, "bar") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_bar");
	FAIL;
#endif

#ifdef XK_braceright
	if(test(XK_braceright, "braceright") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_braceright");
	FAIL;
#endif

#ifdef XK_asciitilde
	if(test(XK_asciitilde, "asciitilde") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_asciitilde");
	FAIL;
#endif

#ifdef XK_nobreakspace
	if(test(XK_nobreakspace, "nobreakspace") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_nobreakspace");
	FAIL;
#endif

#ifdef XK_exclamdown
	if(test(XK_exclamdown, "exclamdown") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_exclamdown");
	FAIL;
#endif

#ifdef XK_cent
	if(test(XK_cent, "cent") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_cent");
	FAIL;
#endif

#ifdef XK_sterling
	if(test(XK_sterling, "sterling") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_sterling");
	FAIL;
#endif

#ifdef XK_currency
	if(test(XK_currency, "currency") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_currency");
	FAIL;
#endif

#ifdef XK_yen
	if(test(XK_yen, "yen") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_yen");
	FAIL;
#endif

#ifdef XK_brokenbar
	if(test(XK_brokenbar, "brokenbar") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_brokenbar");
	FAIL;
#endif

#ifdef XK_section
	if(test(XK_section, "section") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_section");
	FAIL;
#endif

#ifdef XK_diaeresis
	if(test(XK_diaeresis, "diaeresis") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_diaeresis");
	FAIL;
#endif

#ifdef XK_copyright
	if(test(XK_copyright, "copyright") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_copyright");
	FAIL;
#endif

#ifdef XK_ordfeminine
	if(test(XK_ordfeminine, "ordfeminine") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_ordfeminine");
	FAIL;
#endif

#ifdef XK_guillemotleft
	if(test(XK_guillemotleft, "guillemotleft") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_guillemotleft");
	FAIL;
#endif

#ifdef XK_notsign
	if(test(XK_notsign, "notsign") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_notsign");
	FAIL;
#endif

#ifdef XK_hyphen
	if(test(XK_hyphen, "hyphen") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_hyphen");
	FAIL;
#endif

#ifdef XK_registered
	if(test(XK_registered, "registered") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_registered");
	FAIL;
#endif

#ifdef XK_macron
	if(test(XK_macron, "macron") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_macron");
	FAIL;
#endif

#ifdef XK_degree
	if(test(XK_degree, "degree") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_degree");
	FAIL;
#endif

#ifdef XK_plusminus
	if(test(XK_plusminus, "plusminus") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_plusminus");
	FAIL;
#endif

#ifdef XK_twosuperior
	if(test(XK_twosuperior, "twosuperior") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_twosuperior");
	FAIL;
#endif

#ifdef XK_threesuperior
	if(test(XK_threesuperior, "threesuperior") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_threesuperior");
	FAIL;
#endif

#ifdef XK_acute
	if(test(XK_acute, "acute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_acute");
	FAIL;
#endif

#ifdef XK_mu
	if(test(XK_mu, "mu") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_mu");
	FAIL;
#endif

#ifdef XK_paragraph
	if(test(XK_paragraph, "paragraph") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_paragraph");
	FAIL;
#endif

#ifdef XK_periodcentered
	if(test(XK_periodcentered, "periodcentered") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_periodcentered");
	FAIL;
#endif

#ifdef XK_cedilla
	if(test(XK_cedilla, "cedilla") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_cedilla");
	FAIL;
#endif

#ifdef XK_onesuperior
	if(test(XK_onesuperior, "onesuperior") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_onesuperior");
	FAIL;
#endif

#ifdef XK_masculine
	if(test(XK_masculine, "masculine") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_masculine");
	FAIL;
#endif

#ifdef XK_guillemotright
	if(test(XK_guillemotright, "guillemotright") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_guillemotright");
	FAIL;
#endif

#ifdef XK_onequarter
	if(test(XK_onequarter, "onequarter") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_onequarter");
	FAIL;
#endif

#ifdef XK_onehalf
	if(test(XK_onehalf, "onehalf") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_onehalf");
	FAIL;
#endif

#ifdef XK_threequarters
	if(test(XK_threequarters, "threequarters") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_threequarters");
	FAIL;
#endif

#ifdef XK_questiondown
	if(test(XK_questiondown, "questiondown") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_questiondown");
	FAIL;
#endif

#ifdef XK_Agrave
	if(test(XK_Agrave, "Agrave") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Agrave");
	FAIL;
#endif

#ifdef XK_Aacute
	if(test(XK_Aacute, "Aacute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Aacute");
	FAIL;
#endif

#ifdef XK_Acircumflex
	if(test(XK_Acircumflex, "Acircumflex") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Acircumflex");
	FAIL;
#endif

#ifdef XK_Atilde
	if(test(XK_Atilde, "Atilde") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Atilde");
	FAIL;
#endif

#ifdef XK_Adiaeresis
	if(test(XK_Adiaeresis, "Adiaeresis") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Adiaeresis");
	FAIL;
#endif

#ifdef XK_Aring
	if(test(XK_Aring, "Aring") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Aring");
	FAIL;
#endif

#ifdef XK_AE
	if(test(XK_AE, "AE") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_AE");
	FAIL;
#endif

#ifdef XK_Ccedilla
	if(test(XK_Ccedilla, "Ccedilla") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Ccedilla");
	FAIL;
#endif

#ifdef XK_Egrave
	if(test(XK_Egrave, "Egrave") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Egrave");
	FAIL;
#endif

#ifdef XK_Eacute
	if(test(XK_Eacute, "Eacute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Eacute");
	FAIL;
#endif

#ifdef XK_Ecircumflex
	if(test(XK_Ecircumflex, "Ecircumflex") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Ecircumflex");
	FAIL;
#endif

#ifdef XK_Ediaeresis
	if(test(XK_Ediaeresis, "Ediaeresis") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Ediaeresis");
	FAIL;
#endif

#ifdef XK_Igrave
	if(test(XK_Igrave, "Igrave") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Igrave");
	FAIL;
#endif

#ifdef XK_Iacute
	if(test(XK_Iacute, "Iacute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Iacute");
	FAIL;
#endif

#ifdef XK_Icircumflex
	if(test(XK_Icircumflex, "Icircumflex") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Icircumflex");
	FAIL;
#endif

#ifdef XK_Idiaeresis
	if(test(XK_Idiaeresis, "Idiaeresis") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Idiaeresis");
	FAIL;
#endif

#ifdef XK_ETH
	if(test(XK_ETH, "ETH") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_ETH");
	FAIL;
#endif

#ifdef XK_Eth
	if(test(XK_Eth, "Eth") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Eth");
	FAIL;
#endif

#ifdef XK_Ntilde
	if(test(XK_Ntilde, "Ntilde") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Ntilde");
	FAIL;
#endif

#ifdef XK_Ograve
	if(test(XK_Ograve, "Ograve") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Ograve");
	FAIL;
#endif

#ifdef XK_Oacute
	if(test(XK_Oacute, "Oacute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Oacute");
	FAIL;
#endif

#ifdef XK_Ocircumflex
	if(test(XK_Ocircumflex, "Ocircumflex") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Ocircumflex");
	FAIL;
#endif

#ifdef XK_Otilde
	if(test(XK_Otilde, "Otilde") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Otilde");
	FAIL;
#endif

#ifdef XK_Odiaeresis
	if(test(XK_Odiaeresis, "Odiaeresis") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Odiaeresis");
	FAIL;
#endif

#ifdef XK_multiply
	if(test(XK_multiply, "multiply") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_multiply");
	FAIL;
#endif

#ifdef XK_Ooblique
	if(test(XK_Ooblique, "Ooblique") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Ooblique");
	FAIL;
#endif

#ifdef XK_Ugrave
	if(test(XK_Ugrave, "Ugrave") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Ugrave");
	FAIL;
#endif

#ifdef XK_Uacute
	if(test(XK_Uacute, "Uacute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Uacute");
	FAIL;
#endif

#ifdef XK_Ucircumflex
	if(test(XK_Ucircumflex, "Ucircumflex") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Ucircumflex");
	FAIL;
#endif

#ifdef XK_Udiaeresis
	if(test(XK_Udiaeresis, "Udiaeresis") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Udiaeresis");
	FAIL;
#endif

#ifdef XK_Yacute
	if(test(XK_Yacute, "Yacute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Yacute");
	FAIL;
#endif

#ifdef XK_THORN
	if(test(XK_THORN, "THORN") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_THORN");
	FAIL;
#endif

#ifdef XK_Thorn
	if(test(XK_Thorn, "Thorn") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_Thorn");
	FAIL;
#endif

#ifdef XK_ssharp
	if(test(XK_ssharp, "ssharp") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_ssharp");
	FAIL;
#endif

#ifdef XK_agrave
	if(test(XK_agrave, "agrave") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_agrave");
	FAIL;
#endif

#ifdef XK_aacute
	if(test(XK_aacute, "aacute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_aacute");
	FAIL;
#endif

#ifdef XK_acircumflex
	if(test(XK_acircumflex, "acircumflex") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_acircumflex");
	FAIL;
#endif

#ifdef XK_atilde
	if(test(XK_atilde, "atilde") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_atilde");
	FAIL;
#endif

#ifdef XK_adiaeresis
	if(test(XK_adiaeresis, "adiaeresis") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_adiaeresis");
	FAIL;
#endif

#ifdef XK_aring
	if(test(XK_aring, "aring") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_aring");
	FAIL;
#endif

#ifdef XK_ae
	if(test(XK_ae, "ae") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_ae");
	FAIL;
#endif

#ifdef XK_ccedilla
	if(test(XK_ccedilla, "ccedilla") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_ccedilla");
	FAIL;
#endif

#ifdef XK_egrave
	if(test(XK_egrave, "egrave") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_egrave");
	FAIL;
#endif

#ifdef XK_eacute
	if(test(XK_eacute, "eacute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_eacute");
	FAIL;
#endif

#ifdef XK_ecircumflex
	if(test(XK_ecircumflex, "ecircumflex") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_ecircumflex");
	FAIL;
#endif

#ifdef XK_ediaeresis
	if(test(XK_ediaeresis, "ediaeresis") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_ediaeresis");
	FAIL;
#endif

#ifdef XK_igrave
	if(test(XK_igrave, "igrave") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_igrave");
	FAIL;
#endif

#ifdef XK_iacute
	if(test(XK_iacute, "iacute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_iacute");
	FAIL;
#endif

#ifdef XK_icircumflex
	if(test(XK_icircumflex, "icircumflex") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_icircumflex");
	FAIL;
#endif

#ifdef XK_idiaeresis
	if(test(XK_idiaeresis, "idiaeresis") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_idiaeresis");
	FAIL;
#endif

#ifdef XK_eth
	if(test(XK_eth, "eth") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_eth");
	FAIL;
#endif

#ifdef XK_ntilde
	if(test(XK_ntilde, "ntilde") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_ntilde");
	FAIL;
#endif

#ifdef XK_ograve
	if(test(XK_ograve, "ograve") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_ograve");
	FAIL;
#endif

#ifdef XK_oacute
	if(test(XK_oacute, "oacute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_oacute");
	FAIL;
#endif

#ifdef XK_ocircumflex
	if(test(XK_ocircumflex, "ocircumflex") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_ocircumflex");
	FAIL;
#endif

#ifdef XK_otilde
	if(test(XK_otilde, "otilde") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_otilde");
	FAIL;
#endif

#ifdef XK_odiaeresis
	if(test(XK_odiaeresis, "odiaeresis") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_odiaeresis");
	FAIL;
#endif

#ifdef XK_division
	if(test(XK_division, "division") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_division");
	FAIL;
#endif

#ifdef XK_oslash
	if(test(XK_oslash, "oslash") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_oslash");
	FAIL;
#endif

#ifdef XK_ugrave
	if(test(XK_ugrave, "ugrave") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_ugrave");
	FAIL;
#endif

#ifdef XK_uacute
	if(test(XK_uacute, "uacute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_uacute");
	FAIL;
#endif

#ifdef XK_ucircumflex
	if(test(XK_ucircumflex, "ucircumflex") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_ucircumflex");
	FAIL;
#endif

#ifdef XK_udiaeresis
	if(test(XK_udiaeresis, "udiaeresis") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_udiaeresis");
	FAIL;
#endif

#ifdef XK_yacute
	if(test(XK_yacute, "yacute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_yacute");
	FAIL;
#endif

#ifdef XK_thorn
	if(test(XK_thorn, "thorn") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_thorn");
	FAIL;
#endif

#ifdef XK_ydiaeresis
	if(test(XK_ydiaeresis, "ydiaeresis") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("XK_ydiaeresis");
	FAIL;
#endif

	CHECKPASS(195);
}
