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
* File: xts5/tset/Xopen/XKeysymToKeycode/Test1.c
* 
* Description:
* 	Tests for XKeysymToKeycode()
* 
* Modifications:
* $Log: Test1.c,v $
* Revision 1.2  2005-11-03 08:44:00  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:40  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:35:43  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:58:21  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:26:57  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:23:31  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.1  1996/05/09 21:17:34  andy
* Fixed X includes
*
* Revision 4.0  1995/12/15  09:14:03  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  01:17:24  andy
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
extern Display	*Dsp;

int		minkc;
int		maxkc;
int		keysyms_per_keycode;

static int
test(symbol, str)
KeySym	symbol;
char	*str;
{
KeyCode	kycd;
int	mod;

	kycd = XKeysymToKeycode(Dsp, symbol);
	if(kycd == 0) {
		trace("XKeysymToKeycode() returned 0 for KeySym \"XK_%s\".", str);
		return(1);
	}

	if(kycd > maxkc || kycd < minkc) {
		report("XKeysymToKeycode() returned invalid keycode value %d for KeySym \"XK_%s\".", kycd, str);
		return(0);
	}

	for(mod = 0; mod < keysyms_per_keycode; mod++) {
		if( symbol == XKeycodeToKeysym(Dsp, kycd, mod))  {
			trace("KeySym \"XK_%s\", keycode %d, mod %d", 
								str, kycd, mod);
			return(1);
		}
	}

	report("The keycode value %d for KeySym \"XK_%s\"", kycd, str);
	report("never returns that KeySym when using XKeycodeToKeysym()");
	return(0);
}

static void
reporterr(s)
char	*s;
{
	report("Symbol XK_\"%s\" is not defined.", s);
}
#define XK_LATIN1
#include	<X11/keysymdef.h>
#undef XK_LATIN1 

kysymtcd1()
{ 
int 	pass = 0, fail = 0;

	XDisplayKeycodes(Dsp, &minkc, &maxkc);
	XGetKeyboardMapping(Dsp, (KeyCode)minkc, 1, &keysyms_per_keycode);

#ifdef XK_space
	if(test(XK_space, "space") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("space");
	FAIL;
#endif

#ifdef XK_exclam
	if(test(XK_exclam, "exclam") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("exclam");
	FAIL;
#endif

#ifdef XK_quotedbl
	if(test(XK_quotedbl, "quotedbl") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("quotedbl");
	FAIL;
#endif

#ifdef XK_numbersign
	if(test(XK_numbersign, "numbersign") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("numbersign");
	FAIL;
#endif

#ifdef XK_dollar
	if(test(XK_dollar, "dollar") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("dollar");
	FAIL;
#endif

#ifdef XK_percent
	if(test(XK_percent, "percent") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("percent");
	FAIL;
#endif

#ifdef XK_ampersand
	if(test(XK_ampersand, "ampersand") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("ampersand");
	FAIL;
#endif

#ifdef XK_apostrophe
	if(test(XK_apostrophe, "apostrophe") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("apostrophe");
	FAIL;
#endif

#ifdef XK_quoteright
	if(test(XK_quoteright, "quoteright") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("quoteright");
	FAIL;
#endif

#ifdef XK_parenleft
	if(test(XK_parenleft, "parenleft") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("parenleft");
	FAIL;
#endif

#ifdef XK_parenright
	if(test(XK_parenright, "parenright") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("parenright");
	FAIL;
#endif

#ifdef XK_asterisk
	if(test(XK_asterisk, "asterisk") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("asterisk");
	FAIL;
#endif

#ifdef XK_plus
	if(test(XK_plus, "plus") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("plus");
	FAIL;
#endif

#ifdef XK_comma
	if(test(XK_comma, "comma") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("comma");
	FAIL;
#endif

#ifdef XK_minus
	if(test(XK_minus, "minus") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("minus");
	FAIL;
#endif

#ifdef XK_period
	if(test(XK_period, "period") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("period");
	FAIL;
#endif

#ifdef XK_slash
	if(test(XK_slash, "slash") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("slash");
	FAIL;
#endif

#ifdef XK_0
	if(test(XK_0, "0") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("0");
	FAIL;
#endif

#ifdef XK_1
	if(test(XK_1, "1") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("1");
	FAIL;
#endif

#ifdef XK_2
	if(test(XK_2, "2") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("2");
	FAIL;
#endif

#ifdef XK_3
	if(test(XK_3, "3") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("3");
	FAIL;
#endif

#ifdef XK_4
	if(test(XK_4, "4") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("4");
	FAIL;
#endif

#ifdef XK_5
	if(test(XK_5, "5") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("5");
	FAIL;
#endif

#ifdef XK_6
	if(test(XK_6, "6") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("6");
	FAIL;
#endif

#ifdef XK_7
	if(test(XK_7, "7") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("7");
	FAIL;
#endif

#ifdef XK_8
	if(test(XK_8, "8") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("8");
	FAIL;
#endif

#ifdef XK_9
	if(test(XK_9, "9") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("9");
	FAIL;
#endif

#ifdef XK_colon
	if(test(XK_colon, "colon") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("colon");
	FAIL;
#endif

#ifdef XK_semicolon
	if(test(XK_semicolon, "semicolon") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("semicolon");
	FAIL;
#endif

#ifdef XK_less
	if(test(XK_less, "less") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("less");
	FAIL;
#endif

#ifdef XK_equal
	if(test(XK_equal, "equal") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("equal");
	FAIL;
#endif

#ifdef XK_greater
	if(test(XK_greater, "greater") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("greater");
	FAIL;
#endif

#ifdef XK_question
	if(test(XK_question, "question") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("question");
	FAIL;
#endif

#ifdef XK_at
	if(test(XK_at, "at") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("at");
	FAIL;
#endif

#ifdef XK_A
	if(test(XK_A, "A") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("A");
	FAIL;
#endif

#ifdef XK_B
	if(test(XK_B, "B") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("B");
	FAIL;
#endif

#ifdef XK_C
	if(test(XK_C, "C") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("C");
	FAIL;
#endif

#ifdef XK_D
	if(test(XK_D, "D") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("D");
	FAIL;
#endif

#ifdef XK_E
	if(test(XK_E, "E") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("E");
	FAIL;
#endif

#ifdef XK_F
	if(test(XK_F, "F") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("F");
	FAIL;
#endif

#ifdef XK_G
	if(test(XK_G, "G") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("G");
	FAIL;
#endif

#ifdef XK_H
	if(test(XK_H, "H") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("H");
	FAIL;
#endif

#ifdef XK_I
	if(test(XK_I, "I") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("I");
	FAIL;
#endif

#ifdef XK_J
	if(test(XK_J, "J") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("J");
	FAIL;
#endif

#ifdef XK_K
	if(test(XK_K, "K") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("K");
	FAIL;
#endif

#ifdef XK_L
	if(test(XK_L, "L") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("L");
	FAIL;
#endif

#ifdef XK_M
	if(test(XK_M, "M") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("M");
	FAIL;
#endif

#ifdef XK_N
	if(test(XK_N, "N") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("N");
	FAIL;
#endif

#ifdef XK_O
	if(test(XK_O, "O") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("O");
	FAIL;
#endif

#ifdef XK_P
	if(test(XK_P, "P") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("P");
	FAIL;
#endif

#ifdef XK_Q
	if(test(XK_Q, "Q") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Q");
	FAIL;
#endif

#ifdef XK_R
	if(test(XK_R, "R") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("R");
	FAIL;
#endif

#ifdef XK_S
	if(test(XK_S, "S") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("S");
	FAIL;
#endif

#ifdef XK_T
	if(test(XK_T, "T") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("T");
	FAIL;
#endif

#ifdef XK_U
	if(test(XK_U, "U") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("U");
	FAIL;
#endif

#ifdef XK_V
	if(test(XK_V, "V") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("V");
	FAIL;
#endif

#ifdef XK_W
	if(test(XK_W, "W") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("W");
	FAIL;
#endif

#ifdef XK_X
	if(test(XK_X, "X") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("X");
	FAIL;
#endif

#ifdef XK_Y
	if(test(XK_Y, "Y") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Y");
	FAIL;
#endif

#ifdef XK_Z
	if(test(XK_Z, "Z") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Z");
	FAIL;
#endif

#ifdef XK_bracketleft
	if(test(XK_bracketleft, "bracketleft") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("bracketleft");
	FAIL;
#endif

#ifdef XK_backslash
	if(test(XK_backslash, "backslash") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("backslash");
	FAIL;
#endif

#ifdef XK_bracketright
	if(test(XK_bracketright, "bracketright") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("bracketright");
	FAIL;
#endif

#ifdef XK_asciicircum
	if(test(XK_asciicircum, "asciicircum") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("asciicircum");
	FAIL;
#endif

#ifdef XK_underscore
	if(test(XK_underscore, "underscore") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("underscore");
	FAIL;
#endif

#ifdef XK_grave
	if(test(XK_grave, "grave") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("grave");
	FAIL;
#endif

#ifdef XK_quoteleft
	if(test(XK_quoteleft, "quoteleft") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("quoteleft");
	FAIL;
#endif

#ifdef XK_a
	if(test(XK_a, "a") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("a");
	FAIL;
#endif

#ifdef XK_b
	if(test(XK_b, "b") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("b");
	FAIL;
#endif

#ifdef XK_c
	if(test(XK_c, "c") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("c");
	FAIL;
#endif

#ifdef XK_d
	if(test(XK_d, "d") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("d");
	FAIL;
#endif

#ifdef XK_e
	if(test(XK_e, "e") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("e");
	FAIL;
#endif

#ifdef XK_f
	if(test(XK_f, "f") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("f");
	FAIL;
#endif

#ifdef XK_g
	if(test(XK_g, "g") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("g");
	FAIL;
#endif

#ifdef XK_h
	if(test(XK_h, "h") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("h");
	FAIL;
#endif

#ifdef XK_i
	if(test(XK_i, "i") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("i");
	FAIL;
#endif

#ifdef XK_j
	if(test(XK_j, "j") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("j");
	FAIL;
#endif

#ifdef XK_k
	if(test(XK_k, "k") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("k");
	FAIL;
#endif

#ifdef XK_l
	if(test(XK_l, "l") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("l");
	FAIL;
#endif

#ifdef XK_m
	if(test(XK_m, "m") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("m");
	FAIL;
#endif

#ifdef XK_n
	if(test(XK_n, "n") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("n");
	FAIL;
#endif

#ifdef XK_o
	if(test(XK_o, "o") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("o");
	FAIL;
#endif

#ifdef XK_p
	if(test(XK_p, "p") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("p");
	FAIL;
#endif

#ifdef XK_q
	if(test(XK_q, "q") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("q");
	FAIL;
#endif

#ifdef XK_r
	if(test(XK_r, "r") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("r");
	FAIL;
#endif

#ifdef XK_s
	if(test(XK_s, "s") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("s");
	FAIL;
#endif

#ifdef XK_t
	if(test(XK_t, "t") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("t");
	FAIL;
#endif

#ifdef XK_u
	if(test(XK_u, "u") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("u");
	FAIL;
#endif

#ifdef XK_v
	if(test(XK_v, "v") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("v");
	FAIL;
#endif

#ifdef XK_w
	if(test(XK_w, "w") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("w");
	FAIL;
#endif

#ifdef XK_x
	if(test(XK_x, "x") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("x");
	FAIL;
#endif

#ifdef XK_y
	if(test(XK_y, "y") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("y");
	FAIL;
#endif

#ifdef XK_z
	if(test(XK_z, "z") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("z");
	FAIL;
#endif

#ifdef XK_braceleft
	if(test(XK_braceleft, "braceleft") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("braceleft");
	FAIL;
#endif

#ifdef XK_bar
	if(test(XK_bar, "bar") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("bar");
	FAIL;
#endif

#ifdef XK_braceright
	if(test(XK_braceright, "braceright") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("braceright");
	FAIL;
#endif

#ifdef XK_asciitilde
	if(test(XK_asciitilde, "asciitilde") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("asciitilde");
	FAIL;
#endif

#ifdef XK_nobreakspace
	if(test(XK_nobreakspace, "nobreakspace") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("nobreakspace");
	FAIL;
#endif

#ifdef XK_exclamdown
	if(test(XK_exclamdown, "exclamdown") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("exclamdown");
	FAIL;
#endif

#ifdef XK_cent
	if(test(XK_cent, "cent") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("cent");
	FAIL;
#endif

#ifdef XK_sterling
	if(test(XK_sterling, "sterling") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("sterling");
	FAIL;
#endif

#ifdef XK_currency
	if(test(XK_currency, "currency") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("currency");
	FAIL;
#endif

#ifdef XK_yen
	if(test(XK_yen, "yen") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("yen");
	FAIL;
#endif

#ifdef XK_brokenbar
	if(test(XK_brokenbar, "brokenbar") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("brokenbar");
	FAIL;
#endif

#ifdef XK_section
	if(test(XK_section, "section") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("section");
	FAIL;
#endif

#ifdef XK_diaeresis
	if(test(XK_diaeresis, "diaeresis") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("diaeresis");
	FAIL;
#endif

#ifdef XK_copyright
	if(test(XK_copyright, "copyright") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("copyright");
	FAIL;
#endif

#ifdef XK_ordfeminine
	if(test(XK_ordfeminine, "ordfeminine") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("ordfeminine");
	FAIL;
#endif

#ifdef XK_guillemotleft
	if(test(XK_guillemotleft, "guillemotleft") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("guillemotleft");
	FAIL;
#endif

#ifdef XK_notsign
	if(test(XK_notsign, "notsign") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("notsign");
	FAIL;
#endif

#ifdef XK_hyphen
	if(test(XK_hyphen, "hyphen") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("hyphen");
	FAIL;
#endif

#ifdef XK_registered
	if(test(XK_registered, "registered") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("registered");
	FAIL;
#endif

#ifdef XK_macron
	if(test(XK_macron, "macron") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("macron");
	FAIL;
#endif

#ifdef XK_degree
	if(test(XK_degree, "degree") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("degree");
	FAIL;
#endif

#ifdef XK_plusminus
	if(test(XK_plusminus, "plusminus") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("plusminus");
	FAIL;
#endif

#ifdef XK_twosuperior
	if(test(XK_twosuperior, "twosuperior") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("twosuperior");
	FAIL;
#endif

#ifdef XK_threesuperior
	if(test(XK_threesuperior, "threesuperior") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("threesuperior");
	FAIL;
#endif

#ifdef XK_acute
	if(test(XK_acute, "acute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("acute");
	FAIL;
#endif

#ifdef XK_mu
	if(test(XK_mu, "mu") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("mu");
	FAIL;
#endif

#ifdef XK_paragraph
	if(test(XK_paragraph, "paragraph") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("paragraph");
	FAIL;
#endif

#ifdef XK_periodcentered
	if(test(XK_periodcentered, "periodcentered") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("periodcentered");
	FAIL;
#endif

#ifdef XK_cedilla
	if(test(XK_cedilla, "cedilla") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("cedilla");
	FAIL;
#endif

#ifdef XK_onesuperior
	if(test(XK_onesuperior, "onesuperior") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("onesuperior");
	FAIL;
#endif

#ifdef XK_masculine
	if(test(XK_masculine, "masculine") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("masculine");
	FAIL;
#endif

#ifdef XK_guillemotright
	if(test(XK_guillemotright, "guillemotright") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("guillemotright");
	FAIL;
#endif

#ifdef XK_onequarter
	if(test(XK_onequarter, "onequarter") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("onequarter");
	FAIL;
#endif

#ifdef XK_onehalf
	if(test(XK_onehalf, "onehalf") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("onehalf");
	FAIL;
#endif

#ifdef XK_threequarters
	if(test(XK_threequarters, "threequarters") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("threequarters");
	FAIL;
#endif

#ifdef XK_questiondown
	if(test(XK_questiondown, "questiondown") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("questiondown");
	FAIL;
#endif

#ifdef XK_Agrave
	if(test(XK_Agrave, "Agrave") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Agrave");
	FAIL;
#endif

#ifdef XK_Aacute
	if(test(XK_Aacute, "Aacute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Aacute");
	FAIL;
#endif

#ifdef XK_Acircumflex
	if(test(XK_Acircumflex, "Acircumflex") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Acircumflex");
	FAIL;
#endif

#ifdef XK_Atilde
	if(test(XK_Atilde, "Atilde") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Atilde");
	FAIL;
#endif

#ifdef XK_Adiaeresis
	if(test(XK_Adiaeresis, "Adiaeresis") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Adiaeresis");
	FAIL;
#endif

#ifdef XK_Aring
	if(test(XK_Aring, "Aring") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Aring");
	FAIL;
#endif

#ifdef XK_AE
	if(test(XK_AE, "AE") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("AE");
	FAIL;
#endif

#ifdef XK_Ccedilla
	if(test(XK_Ccedilla, "Ccedilla") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Ccedilla");
	FAIL;
#endif

#ifdef XK_Egrave
	if(test(XK_Egrave, "Egrave") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Egrave");
	FAIL;
#endif

#ifdef XK_Eacute
	if(test(XK_Eacute, "Eacute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Eacute");
	FAIL;
#endif

#ifdef XK_Ecircumflex
	if(test(XK_Ecircumflex, "Ecircumflex") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Ecircumflex");
	FAIL;
#endif

#ifdef XK_Ediaeresis
	if(test(XK_Ediaeresis, "Ediaeresis") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Ediaeresis");
	FAIL;
#endif

#ifdef XK_Igrave
	if(test(XK_Igrave, "Igrave") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Igrave");
	FAIL;
#endif

#ifdef XK_Iacute
	if(test(XK_Iacute, "Iacute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Iacute");
	FAIL;
#endif

#ifdef XK_Icircumflex
	if(test(XK_Icircumflex, "Icircumflex") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Icircumflex");
	FAIL;
#endif

#ifdef XK_Idiaeresis
	if(test(XK_Idiaeresis, "Idiaeresis") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Idiaeresis");
	FAIL;
#endif

#ifdef XK_ETH
	if(test(XK_ETH, "ETH") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("ETH");
	FAIL;
#endif

#ifdef XK_Eth
	if(test(XK_Eth, "Eth") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Eth");
	FAIL;
#endif

#ifdef XK_Ntilde
	if(test(XK_Ntilde, "Ntilde") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Ntilde");
	FAIL;
#endif

#ifdef XK_Ograve
	if(test(XK_Ograve, "Ograve") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Ograve");
	FAIL;
#endif

#ifdef XK_Oacute
	if(test(XK_Oacute, "Oacute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Oacute");
	FAIL;
#endif

#ifdef XK_Ocircumflex
	if(test(XK_Ocircumflex, "Ocircumflex") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Ocircumflex");
	FAIL;
#endif

#ifdef XK_Otilde
	if(test(XK_Otilde, "Otilde") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Otilde");
	FAIL;
#endif

#ifdef XK_Odiaeresis
	if(test(XK_Odiaeresis, "Odiaeresis") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Odiaeresis");
	FAIL;
#endif

#ifdef XK_multiply
	if(test(XK_multiply, "multiply") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("multiply");
	FAIL;
#endif

#ifdef XK_Ooblique
	if(test(XK_Ooblique, "Ooblique") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Ooblique");
	FAIL;
#endif

#ifdef XK_Ugrave
	if(test(XK_Ugrave, "Ugrave") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Ugrave");
	FAIL;
#endif

#ifdef XK_Uacute
	if(test(XK_Uacute, "Uacute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Uacute");
	FAIL;
#endif

#ifdef XK_Ucircumflex
	if(test(XK_Ucircumflex, "Ucircumflex") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Ucircumflex");
	FAIL;
#endif

#ifdef XK_Udiaeresis
	if(test(XK_Udiaeresis, "Udiaeresis") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Udiaeresis");
	FAIL;
#endif

#ifdef XK_Yacute
	if(test(XK_Yacute, "Yacute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Yacute");
	FAIL;
#endif

#ifdef XK_THORN
	if(test(XK_THORN, "THORN") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("THORN");
	FAIL;
#endif

#ifdef XK_Thorn
	if(test(XK_Thorn, "Thorn") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Thorn");
	FAIL;
#endif

#ifdef XK_ssharp
	if(test(XK_ssharp, "ssharp") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("ssharp");
	FAIL;
#endif

#ifdef XK_agrave
	if(test(XK_agrave, "agrave") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("agrave");
	FAIL;
#endif

#ifdef XK_aacute
	if(test(XK_aacute, "aacute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("aacute");
	FAIL;
#endif

#ifdef XK_acircumflex
	if(test(XK_acircumflex, "acircumflex") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("acircumflex");
	FAIL;
#endif

#ifdef XK_atilde
	if(test(XK_atilde, "atilde") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("atilde");
	FAIL;
#endif

#ifdef XK_adiaeresis
	if(test(XK_adiaeresis, "adiaeresis") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("adiaeresis");
	FAIL;
#endif

#ifdef XK_aring
	if(test(XK_aring, "aring") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("aring");
	FAIL;
#endif

#ifdef XK_ae
	if(test(XK_ae, "ae") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("ae");
	FAIL;
#endif

#ifdef XK_ccedilla
	if(test(XK_ccedilla, "ccedilla") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("ccedilla");
	FAIL;
#endif

#ifdef XK_egrave
	if(test(XK_egrave, "egrave") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("egrave");
	FAIL;
#endif

#ifdef XK_eacute
	if(test(XK_eacute, "eacute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("eacute");
	FAIL;
#endif

#ifdef XK_ecircumflex
	if(test(XK_ecircumflex, "ecircumflex") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("ecircumflex");
	FAIL;
#endif

#ifdef XK_ediaeresis
	if(test(XK_ediaeresis, "ediaeresis") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("ediaeresis");
	FAIL;
#endif

#ifdef XK_igrave
	if(test(XK_igrave, "igrave") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("igrave");
	FAIL;
#endif

#ifdef XK_iacute
	if(test(XK_iacute, "iacute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("iacute");
	FAIL;
#endif

#ifdef XK_icircumflex
	if(test(XK_icircumflex, "icircumflex") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("icircumflex");
	FAIL;
#endif

#ifdef XK_idiaeresis
	if(test(XK_idiaeresis, "idiaeresis") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("idiaeresis");
	FAIL;
#endif

#ifdef XK_eth
	if(test(XK_eth, "eth") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("eth");
	FAIL;
#endif

#ifdef XK_ntilde
	if(test(XK_ntilde, "ntilde") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("ntilde");
	FAIL;
#endif

#ifdef XK_ograve
	if(test(XK_ograve, "ograve") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("ograve");
	FAIL;
#endif

#ifdef XK_oacute
	if(test(XK_oacute, "oacute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("oacute");
	FAIL;
#endif

#ifdef XK_ocircumflex
	if(test(XK_ocircumflex, "ocircumflex") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("ocircumflex");
	FAIL;
#endif

#ifdef XK_otilde
	if(test(XK_otilde, "otilde") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("otilde");
	FAIL;
#endif

#ifdef XK_odiaeresis
	if(test(XK_odiaeresis, "odiaeresis") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("odiaeresis");
	FAIL;
#endif

#ifdef XK_division
	if(test(XK_division, "division") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("division");
	FAIL;
#endif

#ifdef XK_oslash
	if(test(XK_oslash, "oslash") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("oslash");
	FAIL;
#endif

#ifdef XK_ugrave
	if(test(XK_ugrave, "ugrave") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("ugrave");
	FAIL;
#endif

#ifdef XK_uacute
	if(test(XK_uacute, "uacute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("uacute");
	FAIL;
#endif

#ifdef XK_ucircumflex
	if(test(XK_ucircumflex, "ucircumflex") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("ucircumflex");
	FAIL;
#endif

#ifdef XK_udiaeresis
	if(test(XK_udiaeresis, "udiaeresis") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("udiaeresis");
	FAIL;
#endif

#ifdef XK_yacute
	if(test(XK_yacute, "yacute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("yacute");
	FAIL;
#endif

#ifdef XK_thorn
	if(test(XK_thorn, "thorn") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("thorn");
	FAIL;
#endif

#ifdef XK_ydiaeresis
	if(test(XK_ydiaeresis, "ydiaeresis") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("ydiaeresis");
	FAIL;
#endif

	CHECKPASS(195);
}
