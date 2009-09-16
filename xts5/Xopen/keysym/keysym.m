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

>># Project: VSW5
>># 
>># File: xts5/Xopen/keysym/keysym.m
>># 
>># Description:
>># 	Tests for keysym()
>># 
>># Modifications:
>># $Log: kysym.m,v $
>># Revision 1.2  2005-11-03 08:44:00  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:40  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:35:34  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:58:07  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:26:48  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:23:22  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:13:36  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:16:53  andy
>># Prepare for GA Release
>>#
/*
 *      SCCS:  @(#)  kysym.m Rel 1.11	    (5/12/92)
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
>>TITLE keysym Xopen
>>CFILES Test0.c Test1.c Test2.c Test3.c Test4.c TestG.c TestM.c
>>ASSERTION Good A
When the header file <X11/keysym.h> is included, 
then the symbols in the table which have code 1
are defined to have the hexadecimal values given in the table.
.tL "Code" "Value" "Name"
.tL "1" "20" "XK_space"
.tL "1" "21" "XK_exclam"
.tL "1" "22" "XK_quotedbl"
.tL "1" "23" "XK_numbersign"
.tL "1" "24" "XK_dollar"
.tL "1" "25" "XK_percent"
.tL "1" "26" "XK_ampersand"
.tL "1" "27" "XK_apostrophe"
.tL "1" "27" "XK_quoteright"
.tL "1" "28" "XK_parenleft"
.tL "1" "29" "XK_parenright"
.tL "1" "2A" "XK_asterisk"
.tL "1" "2B" "XK_plus"
.tL "1" "2C" "XK_comma"
.tL "1" "2D" "XK_minus"
.tL "1" "2E" "XK_period"
.tL "1" "2F" "XK_slash"
.tL "1" "30" "XK_0"
.tL "1" "31" "XK_1"
.tL "1" "32" "XK_2"
.tL "1" "33" "XK_3"
.tL "1" "34" "XK_4"
.tL "1" "35" "XK_5"
.tL "1" "36" "XK_6"
.tL "1" "37" "XK_7"
.tL "1" "38" "XK_8"
.tL "1" "39" "XK_9"
.tL "1" "3A" "XK_colon"
.tL "1" "3B" "XK_semicolon"
.tL "1" "3C" "XK_less"
.tL "1" "3D" "XK_equal"
.tL "1" "3E" "XK_greater"
.tL "1" "3F" "XK_question"
.tL "1" "40" "XK_at"
.tL "1" "41" "XK_A"
.tL "1" "42" "XK_B"
.tL "1" "43" "XK_C"
.tL "1" "44" "XK_D"
.tL "1" "45" "XK_E"
.tL "1" "46" "XK_F"
.tL "1" "47" "XK_G"
.tL "1" "48" "XK_H"
.tL "1" "49" "XK_I"
.tL "1" "4A" "XK_J"
.tL "1" "4B" "XK_K"
.tL "1" "4C" "XK_L"
.tL "1" "4D" "XK_M"
.tL "1" "4E" "XK_N"
.tL "1" "4F" "XK_O"
.tL "1" "50" "XK_P"
.tL "1" "51" "XK_Q"
.tL "1" "52" "XK_R"
.tL "1" "53" "XK_S"
.tL "1" "54" "XK_T"
.tL "1" "55" "XK_U"
.tL "1" "56" "XK_V"
.tL "1" "57" "XK_W"
.tL "1" "58" "XK_X"
.tL "1" "59" "XK_Y"
.tL "1" "5A" "XK_Z"
.tL "1" "5B" "XK_bracketleft"
.tL "1" "5C" "XK_backslash"
.tL "1" "5D" "XK_bracketright"
.tL "1" "5E" "XK_asciicircum"
.tL "1" "5F" "XK_underscore"
.tL "1" "60" "XK_grave"
.tL "1" "60" "XK_quoteleft"
.tL "1" "61" "XK_a"
.tL "1" "62" "XK_b"
.tL "1" "63" "XK_c"
.tL "1" "64" "XK_d"
.tL "1" "65" "XK_e"
.tL "1" "66" "XK_f"
.tL "1" "67" "XK_g"
.tL "1" "68" "XK_h"
.tL "1" "69" "XK_i"
.tL "1" "6A" "XK_j"
.tL "1" "6B" "XK_k"
.tL "1" "6C" "XK_l"
.tL "1" "6D" "XK_m"
.tL "1" "6E" "XK_n"
.tL "1" "6F" "XK_o"
.tL "1" "70" "XK_p"
.tL "1" "71" "XK_q"
.tL "1" "72" "XK_r"
.tL "1" "73" "XK_s"
.tL "1" "74" "XK_t"
.tL "1" "75" "XK_u"
.tL "1" "76" "XK_v"
.tL "1" "77" "XK_w"
.tL "1" "78" "XK_x"
.tL "1" "79" "XK_y"
.tL "1" "7A" "XK_z"
.tL "1" "7B" "XK_braceleft"
.tL "1" "7C" "XK_bar"
.tL "1" "7D" "XK_braceright"
.tL "1" "7E" "XK_asciitilde"
.tL "1" "A0" "XK_nobreakspace"
.tL "1" "A1" "XK_exclamdown"
.tL "1" "A2" "XK_cent"
.tL "1" "A3" "XK_sterling"
.tL "1" "A4" "XK_currency"
.tL "1" "A5" "XK_yen"
.tL "1" "A6" "XK_brokenbar"
.tL "1" "A7" "XK_section"
.tL "1" "A8" "XK_diaeresis"
.tL "1" "A9" "XK_copyright"
.tL "1" "AA" "XK_ordfeminine"
.tL "1" "AB" "XK_guillemotleft"
.tL "1" "AC" "XK_notsign"
.tL "1" "AD" "XK_hyphen"
.tL "1" "AE" "XK_registered"
.tL "1" "AF" "XK_macron"
.tL "1" "B0" "XK_degree"
.tL "1" "B1" "XK_plusminus"
.tL "1" "B2" "XK_twosuperior"
.tL "1" "B3" "XK_threesuperior"
.tL "1" "B4" "XK_acute"
.tL "1" "B5" "XK_mu"
.tL "1" "B6" "XK_paragraph"
.tL "1" "B7" "XK_periodcentered"
.tL "1" "B8" "XK_cedilla"
.tL "1" "B9" "XK_onesuperior"
.tL "1" "BA" "XK_masculine"
.tL "1" "BB" "XK_guillemotright"
.tL "1" "BC" "XK_onequarter"
.tL "1" "BD" "XK_onehalf"
.tL "1" "BE" "XK_threequarters"
.tL "1" "BF" "XK_questiondown"
.tL "1" "C0" "XK_Agrave"
.tL "1" "C1" "XK_Aacute"
.tL "1" "C2" "XK_Acircumflex"
.tL "1" "C3" "XK_Atilde"
.tL "1" "C4" "XK_Adiaeresis"
.tL "1" "C5" "XK_Aring"
.tL "1" "C6" "XK_AE"
.tL "1" "C7" "XK_Ccedilla"
.tL "1" "C8" "XK_Egrave"
.tL "1" "C9" "XK_Eacute"
.tL "1" "CA" "XK_Ecircumflex"
.tL "1" "CB" "XK_Ediaeresis"
.tL "1" "CC" "XK_Igrave"
.tL "1" "CD" "XK_Iacute"
.tL "1" "CE" "XK_Icircumflex"
.tL "1" "CF" "XK_Idiaeresis"
.tL "1" "D0" "XK_ETH"
.tL "1" "D0" "XK_Eth"
.tL "1" "D1" "XK_Ntilde"
.tL "1" "D2" "XK_Ograve"
.tL "1" "D3" "XK_Oacute"
.tL "1" "D4" "XK_Ocircumflex"
.tL "1" "D5" "XK_Otilde"
.tL "1" "D6" "XK_Odiaeresis"
.tL "1" "D7" "XK_multiply"
.tL "1" "D8" "XK_Ooblique"
.tL "1" "D9" "XK_Ugrave"
.tL "1" "DA" "XK_Uacute"
.tL "1" "DB" "XK_Ucircumflex"
.tL "1" "DC" "XK_Udiaeresis"
.tL "1" "DD" "XK_Yacute"
.tL "1" "DE" "XK_THORN"
.tL "1" "DE" "XK_Thorn"
.tL "1" "DF" "XK_ssharp"
.tL "1" "E0" "XK_agrave"
.tL "1" "E1" "XK_aacute"
.tL "1" "E2" "XK_acircumflex"
.tL "1" "E3" "XK_atilde"
.tL "1" "E4" "XK_adiaeresis"
.tL "1" "E5" "XK_aring"
.tL "1" "E6" "XK_ae"
.tL "1" "E7" "XK_ccedilla"
.tL "1" "E8" "XK_egrave"
.tL "1" "E9" "XK_eacute"
.tL "1" "EA" "XK_ecircumflex"
.tL "1" "EB" "XK_ediaeresis"
.tL "1" "EC" "XK_igrave"
.tL "1" "ED" "XK_iacute"
.tL "1" "EE" "XK_icircumflex"
.tL "1" "EF" "XK_idiaeresis"
.tL "1" "F0" "XK_eth"
.tL "1" "F1" "XK_ntilde"
.tL "1" "F2" "XK_ograve"
.tL "1" "F3" "XK_oacute"
.tL "1" "F4" "XK_ocircumflex"
.tL "1" "F5" "XK_otilde"
.tL "1" "F6" "XK_odiaeresis"
.tL "1" "F7" "XK_division"
.tL "1" "F8" "XK_oslash"
.tL "1" "F9" "XK_ugrave"
.tL "1" "FA" "XK_uacute"
.tL "1" "FB" "XK_ucircumflex"
.tL "1" "FC" "XK_udiaeresis"
.tL "1" "FD" "XK_yacute"
.tL "1" "FE" "XK_thorn"
.tL "1" "FF" "XK_ydiaeresis"
>>STRATEGY
Include header file <X11/keysym.h>
For each KeySym in table with code 1:
	Verify that the symbol is defined using #ifdef.
	Verify that the symbol has the expected value using #if.
>>CODE 

	kysym1();

>>ASSERTION Good A
When the header file <X11/keysym.h> is included, 
then the symbols in the table which have code 2
are defined to have the hexadecimal values given in the table.
.tL "Code" "Value" "Name"
.tL "2" "1A1" "XK_Aogonek"
.tL "2" "1A2" "XK_breve"
.tL "2" "1A3" "XK_Lstroke"
.tL "2" "1A5" "XK_Lcaron"
.tL "2" "1A6" "XK_Sacute"
.tL "2" "1A9" "XK_Scaron"
.tL "2" "1AA" "XK_Scedilla"
.tL "2" "1AB" "XK_Tcaron"
.tL "2" "1AC" "XK_Zacute"
.tL "2" "1AE" "XK_Zcaron"
.tL "2" "1AF" "XK_Zabovedot"
.tL "2" "1B1" "XK_aogonek"
.tL "2" "1B2" "XK_ogonek"
.tL "2" "1B3" "XK_lstroke"
.tL "2" "1B5" "XK_lcaron"
.tL "2" "1B6" "XK_sacute"
.tL "2" "1B7" "XK_caron"
.tL "2" "1B9" "XK_scaron"
.tL "2" "1BA" "XK_scedilla"
.tL "2" "1BB" "XK_tcaron"
.tL "2" "1BC" "XK_zacute"
.tL "2" "1BD" "XK_doubleacute"
.tL "2" "1BE" "XK_zcaron"
.tL "2" "1BF" "XK_zabovedot"
.tL "2" "1C0" "XK_Racute"
.tL "2" "1C3" "XK_Abreve"
.tL "2" "1C5" "XK_Lacute"
.tL "2" "1C6" "XK_Cacute"
.tL "2" "1C8" "XK_Ccaron"
.tL "2" "1CA" "XK_Eogonek"
.tL "2" "1CC" "XK_Ecaron"
.tL "2" "1CF" "XK_Dcaron"
.tL "2" "1D0" "XK_Dstroke"
.tL "2" "1D1" "XK_Nacute"
.tL "2" "1D2" "XK_Ncaron"
.tL "2" "1D5" "XK_Odoubleacute"
.tL "2" "1D8" "XK_Rcaron"
.tL "2" "1D9" "XK_Uring"
.tL "2" "1DB" "XK_Udoubleacute"
.tL "2" "1DE" "XK_Tcedilla"
.tL "2" "1E0" "XK_racute"
.tL "2" "1E3" "XK_abreve"
.tL "2" "1E5" "XK_lacute"
.tL "2" "1E6" "XK_cacute"
.tL "2" "1E8" "XK_ccaron"
.tL "2" "1EA" "XK_eogonek"
.tL "2" "1EC" "XK_ecaron"
.tL "2" "1EF" "XK_dcaron"
.tL "2" "1F0" "XK_dstroke"
.tL "2" "1F1" "XK_nacute"
.tL "2" "1F2" "XK_ncaron"
.tL "2" "1F5" "XK_odoubleacute"
.tL "2" "1F8" "XK_rcaron"
.tL "2" "1F9" "XK_uring"
.tL "2" "1FB" "XK_udoubleacute"
.tL "2" "1FE" "XK_tcedilla"
.tL "2" "1FF" "XK_abovedot"
>>STRATEGY
Include header file <X11/keysym.h>
For each KeySym in table with code 2:
	Verify that the symbol is defined using #ifdef.
	Verify that the symbol has the expected value using #if.
>>CODE 

	kysym2();

>>ASSERTION Good A
When the header file <X11/keysym.h> is included, 
then the symbols in the table which have code 3
are defined to have the hexadecimal values given in the table.
.tL "Code" "Value" "Name"
.tL "3" "2A1" "XK_Hstroke"
.tL "3" "2A6" "XK_Hcircumflex"
.tL "3" "2A9" "XK_Iabovedot"
.tL "3" "2AB" "XK_Gbreve"
.tL "3" "2AC" "XK_Jcircumflex"
.tL "3" "2B1" "XK_hstroke"
.tL "3" "2B6" "XK_hcircumflex"
.tL "3" "2B9" "XK_idotless"
.tL "3" "2BB" "XK_gbreve"
.tL "3" "2BC" "XK_jcircumflex"
.tL "3" "2C5" "XK_Cabovedot"
.tL "3" "2C6" "XK_Ccircumflex"
.tL "3" "2D5" "XK_Gabovedot"
.tL "3" "2D8" "XK_Gcircumflex"
.tL "3" "2DD" "XK_Ubreve"
.tL "3" "2DE" "XK_Scircumflex"
.tL "3" "2E5" "XK_cabovedot"
.tL "3" "2E6" "XK_ccircumflex"
.tL "3" "2F5" "XK_gabovedot"
.tL "3" "2F8" "XK_gcircumflex"
.tL "3" "2FD" "XK_ubreve"
.tL "3" "2FE" "XK_scircumflex"
>>STRATEGY
Include header file <X11/keysym.h>
For each KeySym in table with code 3:
	Verify that the symbol is defined using #ifdef.
	Verify that the symbol has the expected value using #if.
>>CODE 

	kysym3();

>>ASSERTION Good A
When the header file <X11/keysym.h> is included, 
then the symbols in the table which have code 4
are defined to have the hexadecimal values given in the table.
.tL "Code" "Value" "Name"
.tL "4" "3A2" "XK_kra"
.tL "4" "3A2" "XK_kappa"
.tL "4" "3A3" "XK_Rcedilla"
.tL "4" "3A5" "XK_Itilde"
.tL "4" "3A6" "XK_Lcedilla"
.tL "4" "3AA" "XK_Emacron"
.tL "4" "3AB" "XK_Gcedilla"
.tL "4" "3AC" "XK_Tslash"
.tL "4" "3B3" "XK_rcedilla"
.tL "4" "3B5" "XK_itilde"
.tL "4" "3B6" "XK_lcedilla"
.tL "4" "3BA" "XK_emacron"
.tL "4" "3BB" "XK_gcedilla"
.tL "4" "3BC" "XK_tslash"
.tL "4" "3BD" "XK_ENG"
.tL "4" "3BF" "XK_eng"
.tL "4" "3C0" "XK_Amacron"
.tL "4" "3C7" "XK_Iogonek"
.tL "4" "3CC" "XK_Eabovedot"
.tL "4" "3CF" "XK_Imacron"
.tL "4" "3D1" "XK_Ncedilla"
.tL "4" "3D2" "XK_Omacron"
.tL "4" "3D3" "XK_Kcedilla"
.tL "4" "3D9" "XK_Uogonek"
.tL "4" "3DD" "XK_Utilde"
.tL "4" "3DE" "XK_Umacron"
.tL "4" "3E0" "XK_amacron"
.tL "4" "3E7" "XK_iogonek"
.tL "4" "3EC" "XK_eabovedot"
.tL "4" "3EF" "XK_imacron"
.tL "4" "3F1" "XK_ncedilla"
.tL "4" "3F2" "XK_omacron"
.tL "4" "3F3" "XK_kcedilla"
.tL "4" "3F9" "XK_uogonek"
.tL "4" "3FD" "XK_utilde"
.tL "4" "3FE" "XK_umacron"
>>STRATEGY
Include header file <X11/keysym.h>
For each KeySym in table with code 4:
	Verify that the symbol is defined using #ifdef.
	Verify that the symbol has the expected value using #if.
>>CODE 

	kysym4();

>>ASSERTION Good A
When the header file <X11/keysym.h> is included, 
then the symbols in the table which have code G
are defined to have the hexadecimal values given in the table.
.tL "Code" "Value" "Name"
.tL "G" "7A1" "XK_Greek_ALPHAaccent"
.tL "G" "7A2" "XK_Greek_EPSILONaccent"
.tL "G" "7A3" "XK_Greek_ETAaccent"
.tL "G" "7A4" "XK_Greek_IOTAaccent"
.tL "G" "7A5" "XK_Greek_IOTAdiaeresis"
.tL "G" "7A7" "XK_Greek_OMICRONaccent"
.tL "G" "7A8" "XK_Greek_UPSILONaccent"
.tL "G" "7A9" "XK_Greek_UPSILONdieresis"
.tL "G" "7AB" "XK_Greek_OMEGAaccent"
.tL "G" "7AE" "XK_Greek_accentdieresis"
.tL "G" "7AF" "XK_Greek_horizbar"
.tL "G" "7B1" "XK_Greek_alphaaccent"
.tL "G" "7B2" "XK_Greek_epsilonaccent"
.tL "G" "7B3" "XK_Greek_etaaccent"
.tL "G" "7B4" "XK_Greek_iotaaccent"
.tL "G" "7B5" "XK_Greek_iotadieresis"
.tL "G" "7B6" "XK_Greek_iotaaccentdieresis"
.tL "G" "7B7" "XK_Greek_omicronaccent"
.tL "G" "7B8" "XK_Greek_upsilonaccent"
.tL "G" "7B9" "XK_Greek_upsilondieresis"
.tL "G" "7BA" "XK_Greek_upsilonaccentdieresis"
.tL "G" "7BB" "XK_Greek_omegaaccent"
.tL "G" "7C1" "XK_Greek_ALPHA"
.tL "G" "7C2" "XK_Greek_BETA"
.tL "G" "7C3" "XK_Greek_GAMMA"
.tL "G" "7C4" "XK_Greek_DELTA"
.tL "G" "7C5" "XK_Greek_EPSILON"
.tL "G" "7C6" "XK_Greek_ZETA"
.tL "G" "7C7" "XK_Greek_ETA"
.tL "G" "7C8" "XK_Greek_THETA"
.tL "G" "7C9" "XK_Greek_IOTA"
.tL "G" "7CA" "XK_Greek_KAPPA"
.tL "G" "7CB" "XK_Greek_LAMBDA"
.tL "G" "7CB" "XK_Greek_LAMDA"
.tL "G" "7CC" "XK_Greek_MU"
.tL "G" "7CD" "XK_Greek_NU"
.tL "G" "7CE" "XK_Greek_XI"
.tL "G" "7CF" "XK_Greek_OMICRON"
.tL "G" "7D0" "XK_Greek_PI"
.tL "G" "7D1" "XK_Greek_RHO"
.tL "G" "7D2" "XK_Greek_SIGMA"
.tL "G" "7D4" "XK_Greek_TAU"
.tL "G" "7D5" "XK_Greek_UPSILON"
.tL "G" "7D6" "XK_Greek_PHI"
.tL "G" "7D7" "XK_Greek_CHI"
.tL "G" "7D8" "XK_Greek_PSI"
.tL "G" "7D9" "XK_Greek_OMEGA"
.tL "G" "7E1" "XK_Greek_alpha"
.tL "G" "7E2" "XK_Greek_beta"
.tL "G" "7E3" "XK_Greek_gamma"
.tL "G" "7E4" "XK_Greek_delta"
.tL "G" "7E5" "XK_Greek_epsilon"
.tL "G" "7E6" "XK_Greek_zeta"
.tL "G" "7E7" "XK_Greek_eta"
.tL "G" "7E8" "XK_Greek_theta"
.tL "G" "7E9" "XK_Greek_iota"
.tL "G" "7EA" "XK_Greek_kappa"
.tL "G" "7EB" "XK_Greek_lambda"
.tL "G" "7EB" "XK_Greek_lamda"
.tL "G" "7EC" "XK_Greek_mu"
.tL "G" "7ED" "XK_Greek_nu"
.tL "G" "7EE" "XK_Greek_xi"
.tL "G" "7EF" "XK_Greek_omicron"
.tL "G" "7F0" "XK_Greek_pi"
.tL "G" "7F1" "XK_Greek_rho"
.tL "G" "7F2" "XK_Greek_sigma"
.tL "G" "7F3" "XK_Greek_finalsmallsigma"
.tL "G" "7F4" "XK_Greek_tau"
.tL "G" "7F5" "XK_Greek_upsilon"
.tL "G" "7F6" "XK_Greek_phi"
.tL "G" "7F7" "XK_Greek_chi"
.tL "G" "7F8" "XK_Greek_psi"
.tL "G" "7F9" "XK_Greek_omega"
.tL "G" "FF7E" "XK_Greek_switch"
>>STRATEGY
Include header file <X11/keysym.h>
For each KeySym in table with code G:
	Verify that the symbol is defined using #ifdef.
	Verify that the symbol has the expected value using #if.
>>CODE 

	kysymG();

>>ASSERTION Good A
When the header file <X11/keysym.h> is included, 
then the symbols in the table which have code M
are defined to have the hexadecimal values given in the table.
.tL "Code" "Value" "Name"
.tL "M" "FF08" "XK_BackSpace"
.tL "M" "FF09" "XK_Tab"
.tL "M" "FF0A" "XK_Linefeed"
.tL "M" "FF0B" "XK_Clear"
.tL "M" "FF0D" "XK_Return"
.tL "M" "FF13" "XK_Pause"
.tL "M" "FF14" "XK_Scroll_Lock"
.tL "M" "FF1B" "XK_Escape"
.tL "M" "FF20" "XK_Multi_key"
.tL "M" "FF21" "XK_Kanji"
.tL "M" "FF22" "XK_Muhenkan"
.tL "M" "FF23" "XK_Henkan"
.tL "M" "FF23" "XK_Henkan_Mode"
.tL "M" "FF24" "XK_Romaji"
.tL "M" "FF25" "XK_Hiragana"
.tL "M" "FF26" "XK_Katakana"
.tL "M" "FF27" "XK_Hiragana_Katakana"
.tL "M" "FF28" "XK_Zenkaku"
.tL "M" "FF29" "XK_Hankaku"
.tL "M" "FF2A" "XK_Zenkaku_Hankaku"
.tL "M" "FF2B" "XK_Touroku"
.tL "M" "FF2C" "XK_Massyo"
.tL "M" "FF2D" "XK_Kana_Lock"
.tL "M" "FF2E" "XK_Kana_Shift"
.tL "M" "FF2F" "XK_Eisu_Shift"
.tL "M" "FF30" "XK_Eisu_toggle"
.tL "M" "FF50" "XK_Home"
.tL "M" "FF51" "XK_Left"
.tL "M" "FF52" "XK_Up"
.tL "M" "FF53" "XK_Right"
.tL "M" "FF54" "XK_Down"
.tL "M" "FF55" "XK_Prior"
.tL "M" "FF56" "XK_Next"
.tL "M" "FF57" "XK_End"
.tL "M" "FF58" "XK_Begin"
.tL "M" "FF60" "XK_Select"
.tL "M" "FF61" "XK_Print"
.tL "M" "FF62" "XK_Execute"
.tL "M" "FF63" "XK_Insert"
.tL "M" "FF65" "XK_Undo"
.tL "M" "FF66" "XK_Redo"
.tL "M" "FF67" "XK_Menu"
.tL "M" "FF68" "XK_Find"
.tL "M" "FF69" "XK_Cancel"
.tL "M" "FF6A" "XK_Help"
.tL "M" "FF6B" "XK_Break"
.tL "M" "FF7E" "XK_Mode_switch"
.tL "M" "FF7E" "XK_script_switch"
.tL "M" "FF7F" "XK_Num_Lock"
.tL "M" "FF80" "XK_KP_Space"
.tL "M" "FF89" "XK_KP_Tab"
.tL "M" "FF8D" "XK_KP_Enter"
.tL "M" "FF91" "XK_KP_F1"
.tL "M" "FF92" "XK_KP_F2"
.tL "M" "FF93" "XK_KP_F3"
.tL "M" "FF94" "XK_KP_F4"
.tL "M" "FFAA" "XK_KP_Multiply"
.tL "M" "FFAB" "XK_KP_Add"
.tL "M" "FFAC" "XK_KP_Separator"
.tL "M" "FFAD" "XK_KP_Subtract"
.tL "M" "FFAE" "XK_KP_Decimal"
.tL "M" "FFAF" "XK_KP_Divide"
.tL "M" "FFB0" "XK_KP_0"
.tL "M" "FFB1" "XK_KP_1"
.tL "M" "FFB2" "XK_KP_2"
.tL "M" "FFB3" "XK_KP_3"
.tL "M" "FFB4" "XK_KP_4"
.tL "M" "FFB5" "XK_KP_5"
.tL "M" "FFB6" "XK_KP_6"
.tL "M" "FFB7" "XK_KP_7"
.tL "M" "FFB8" "XK_KP_8"
.tL "M" "FFB9" "XK_KP_9"
.tL "M" "FFBD" "XK_KP_Equal"
.tL "M" "FFBE" "XK_F1"
.tL "M" "FFBF" "XK_F2"
.tL "M" "FFC0" "XK_F3"
.tL "M" "FFC1" "XK_F4"
.tL "M" "FFC2" "XK_F5"
.tL "M" "FFC3" "XK_F6"
.tL "M" "FFC4" "XK_F7"
.tL "M" "FFC5" "XK_F8"
.tL "M" "FFC6" "XK_F9"
.tL "M" "FFC7" "XK_F10"
.tL "M" "FFC8" "XK_F11"
.tL "M" "FFC8" "XK_L1"
.tL "M" "FFC9" "XK_F12"
.tL "M" "FFC9" "XK_L2"
.tL "M" "FFCA" "XK_F13"
.tL "M" "FFCA" "XK_L3"
.tL "M" "FFCB" "XK_F14"
.tL "M" "FFCB" "XK_L4"
.tL "M" "FFCC" "XK_F15"
.tL "M" "FFCC" "XK_L5"
.tL "M" "FFCD" "XK_F16"
.tL "M" "FFCD" "XK_L6"
.tL "M" "FFCE" "XK_F17"
.tL "M" "FFCE" "XK_L7"
.tL "M" "FFCF" "XK_F18"
.tL "M" "FFCF" "XK_L8"
.tL "M" "FFD0" "XK_F19"
.tL "M" "FFD0" "XK_L9"
.tL "M" "FFD1" "XK_F20"
.tL "M" "FFD1" "XK_L10"
.tL "M" "FFD2" "XK_F21"
.tL "M" "FFD2" "XK_R1"
.tL "M" "FFD3" "XK_F22"
.tL "M" "FFD3" "XK_R2"
.tL "M" "FFD4" "XK_F23"
.tL "M" "FFD4" "XK_R3"
.tL "M" "FFD5" "XK_F24"
.tL "M" "FFD5" "XK_R4"
.tL "M" "FFD6" "XK_F25"
.tL "M" "FFD6" "XK_R5"
.tL "M" "FFD7" "XK_F26"
.tL "M" "FFD7" "XK_R6"
.tL "M" "FFD8" "XK_F27"
.tL "M" "FFD8" "XK_R7"
.tL "M" "FFD9" "XK_F28"
.tL "M" "FFD9" "XK_R8"
.tL "M" "FFDA" "XK_F29"
.tL "M" "FFDA" "XK_R9"
.tL "M" "FFDB" "XK_F30"
.tL "M" "FFDB" "XK_R10"
.tL "M" "FFDC" "XK_F31"
.tL "M" "FFDC" "XK_R11"
.tL "M" "FFDD" "XK_F32"
.tL "M" "FFDD" "XK_R12"
.tL "M" "FFDE" "XK_F33"
.tL "M" "FFDE" "XK_R13"
.tL "M" "FFDF" "XK_F34"
.tL "M" "FFDF" "XK_R14"
.tL "M" "FFE0" "XK_F35"
.tL "M" "FFE0" "XK_R15"
.tL "M" "FFE1" "XK_Shift_L"
.tL "M" "FFE2" "XK_Shift_R"
.tL "M" "FFE3" "XK_Control_L"
.tL "M" "FFE4" "XK_Control_R"
.tL "M" "FFE5" "XK_Caps_Lock"
.tL "M" "FFE6" "XK_Shift_Lock"
.tL "M" "FFE7" "XK_Meta_L"
.tL "M" "FFE8" "XK_Meta_R"
.tL "M" "FFE9" "XK_Alt_L"
.tL "M" "FFEA" "XK_Alt_R"
.tL "M" "FFEB" "XK_Super_L"
.tL "M" "FFEC" "XK_Super_R"
.tL "M" "FFED" "XK_Hyper_L"
.tL "M" "FFEE" "XK_Hyper_R"
.tL "M" "FFFF" "XK_Delete"
>>STRATEGY
Include header file <X11/keysym.h>
For each KeySym in table with code M:
	Verify that the symbol is defined using #ifdef.
	Verify that the symbol has the expected value using #if.
>>CODE 

	kysymM();

>>ASSERTION Good A
When the header file <X11/keysym.h> is included, 
then the symbols in the table
are defined to have the hexadecimal values given in the table.
.tL "Value" "Name"
.tL "FFFFFF" "XK_VoidSymbol"
>>STRATEGY
Include header file <X11/keysym.h>
For each KeySym in table:
	Verify that the symbol is defined using #ifdef.
	Verify that the symbol has the expected value using #if.
>>CODE 

	kysym0();
