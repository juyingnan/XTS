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
$Header: /cvs/xtest/xtest/xts5/tset/Xopen/XKeysymToKeycode/XKeysymToKeycode.m,v 1.2 2005-11-03 08:44:00 jmichael Exp $

>># Project: VSW5
>># 
>># File: xts5/tset/Xopen/XKeysymToKeycode/XKeysymToKeycode.m
>># 
>># Description:
>># 	Tests for XKeysymToKeycode()
>># 
>># Modifications:
>># $Log: kysymtkycd.m,v $
>># Revision 1.2  2005-11-03 08:44:00  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:40  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:35:51  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:58:32  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:27:04  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:23:38  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:14:23  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:17:48  andy
>># Prepare for GA Release
>>#
/*
 *      SCCS:  @(#)  kysymtkycd.m Rel 1.5	    (11/28/91)
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

>>TITLE XKeysymToKeycode Xopen
>>CFILES Test1.c Test2.c Test3.c Test4.c TestA.c TestC.c TestG.c TestH.c TestK.c TestL.c TestM.c TestP.c TestS.c TestT.c
>>ASSERTION Good A
When the
.A keysym
argument is a
.S KeySym
in the table which is defined and has code 1,
then a call to xname returns the
.S KeyCode
defined for that
.S KeySym .
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
For each KeySym in table with code 1:
	Call XKeysymToKeycode to obtain the KeyCode defined for that KeySym.
	Call XKeycodeToKeysym to obtain each KeySym for that KeyCode.
	Verify that one of the KeySyms returned is the original KeySym.
>>CODE 

	kysymtcd1();

>>ASSERTION Good A
When the
.A keysym
argument is a
.S KeySym
in the table which is defined and has code 2,
then a call to xname returns the
.S KeyCode
defined for that
.S KeySym .
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
For each KeySym in table with code 2:
	Call XKeysymToKeycode to obtain the KeyCode defined for that KeySym.
	Call XKeycodeToKeysym to obtain each KeySym for that KeyCode.
	Verify that one of the KeySyms returned is the original KeySym.
>>CODE 

	kysymtcd2();

>>ASSERTION Good A
When the
.A keysym
argument is a
.S KeySym
in the table which is defined and has code 3,
then a call to xname returns the
.S KeyCode
defined for that
.S KeySym .
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
For each KeySym in table with code 3:
	Call XKeysymToKeycode to obtain the KeyCode defined for that KeySym.
	Call XKeycodeToKeysym to obtain each KeySym for that KeyCode.
	Verify that one of the KeySyms returned is the original KeySym.
>>CODE 

	kysymtcd3();

>>ASSERTION Good A
When the
.A keysym
argument is a
.S KeySym
in the table which is defined and has code 4,
then a call to xname returns the
.S KeyCode
defined for that
.S KeySym .
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
For each KeySym in table with code 4:
	Call XKeysymToKeycode to obtain the KeyCode defined for that KeySym.
	Call XKeycodeToKeysym to obtain each KeySym for that KeyCode.
	Verify that one of the KeySyms returned is the original KeySym.
>>CODE 

	kysymtcd4();

>>ASSERTION Good A
When the
.A keysym
argument is a
.S KeySym
in the table which is defined and has code A,
then a call to xname returns the
.S KeyCode
defined for that
.S KeySym .
.tL "Code" "Value" "Name"
.tL "A" "5AC" "XK_Arabic_comma"
.tL "A" "5BB" "XK_Arabic_semicolon"
.tL "A" "5BF" "XK_Arabic_question_mark"
.tL "A" "5C1" "XK_Arabic_hamza"
.tL "A" "5C2" "XK_Arabic_maddaonalef"
.tL "A" "5C3" "XK_Arabic_hamzaonalef"
.tL "A" "5C4" "XK_Arabic_hamzaonwaw"
.tL "A" "5C5" "XK_Arabic_hamzaunderalef"
.tL "A" "5C6" "XK_Arabic_hamzaonyeh"
.tL "A" "5C7" "XK_Arabic_alef"
.tL "A" "5C8" "XK_Arabic_beh"
.tL "A" "5C9" "XK_Arabic_tehmarbuta"
.tL "A" "5CA" "XK_Arabic_teh"
.tL "A" "5CB" "XK_Arabic_theh"
.tL "A" "5CC" "XK_Arabic_jeem"
.tL "A" "5CD" "XK_Arabic_hah"
.tL "A" "5CE" "XK_Arabic_khah"
.tL "A" "5CF" "XK_Arabic_dal"
.tL "A" "5D0" "XK_Arabic_thal"
.tL "A" "5D1" "XK_Arabic_ra"
.tL "A" "5D2" "XK_Arabic_zain"
.tL "A" "5D3" "XK_Arabic_seen"
.tL "A" "5D4" "XK_Arabic_sheen"
.tL "A" "5D5" "XK_Arabic_sad"
.tL "A" "5D6" "XK_Arabic_dad"
.tL "A" "5D7" "XK_Arabic_tah"
.tL "A" "5D8" "XK_Arabic_zah"
.tL "A" "5D9" "XK_Arabic_ain"
.tL "A" "5DA" "XK_Arabic_ghain"
.tL "A" "5E0" "XK_Arabic_tatweel"
.tL "A" "5E1" "XK_Arabic_feh"
.tL "A" "5E2" "XK_Arabic_qaf"
.tL "A" "5E3" "XK_Arabic_kaf"
.tL "A" "5E4" "XK_Arabic_lam"
.tL "A" "5E5" "XK_Arabic_meem"
.tL "A" "5E6" "XK_Arabic_noon"
.tL "A" "5E7" "XK_Arabic_ha"
.tL "A" "5E7" "XK_Arabic_heh"
.tL "A" "5E8" "XK_Arabic_waw"
.tL "A" "5E9" "XK_Arabic_alefmaksura"
.tL "A" "5EA" "XK_Arabic_yeh"
.tL "A" "5EB" "XK_Arabic_fathatan"
.tL "A" "5EC" "XK_Arabic_dammatan"
.tL "A" "5ED" "XK_Arabic_kasratan"
.tL "A" "5EE" "XK_Arabic_fatha"
.tL "A" "5EF" "XK_Arabic_damma"
.tL "A" "5F0" "XK_Arabic_kasra"
.tL "A" "5F1" "XK_Arabic_shadda"
.tL "A" "5F2" "XK_Arabic_sukun"
.tL "A" "FF7E" "XK_Arabic_switch"
>>STRATEGY
For each KeySym in table with code A:
	Call XKeysymToKeycode to obtain the KeyCode defined for that KeySym.
	Call XKeycodeToKeysym to obtain each KeySym for that KeyCode.
	Verify that one of the KeySyms returned is the original KeySym.
>>CODE 

	kysymtcdA();

>>ASSERTION Good A
When the
.A keysym
argument is a
.S KeySym
in the table which is defined and has code C,
then a call to xname returns the
.S KeyCode
defined for that
.S KeySym .
.tL "Code" "Value" "Name"
.tL "C" "6A1" "XK_Serbian_dje"
.tL "C" "6A2" "XK_Macedonia_gje"
.tL "C" "6A3" "XK_Cyrillic_io"
.tL "C" "6A4" "XK_Ukrainian_ie"
.tL "C" "6A4" "XK_Ukranian_je"
.tL "C" "6A5" "XK_Macedonia_dse"
.tL "C" "6A6" "XK_Ukrainian_i"
.tL "C" "6A6" "XK_Ukranian_i"
.tL "C" "6A7" "XK_Ukrainian_yi"
.tL "C" "6A7" "XK_Ukranian_yi"
.tL "C" "6A8" "XK_Cyrillic_je"
.tL "C" "6A8" "XK_Serbian_je"
.tL "C" "6A9" "XK_Cyrillic_lje"
.tL "C" "6A9" "XK_Serbian_lje"
.tL "C" "6AA" "XK_Cyrillic_nje"
.tL "C" "6AA" "XK_Serbian_nje"
.tL "C" "6AB" "XK_Serbian_tshe"
.tL "C" "6AC" "XK_Macedonia_kje"
.tL "C" "6AE" "XK_Byelorussian_shortu"
.tL "C" "6AF" "XK_Cyrillic_dzhe"
.tL "C" "6AF" "XK_Serbian_dze"
.tL "C" "6B0" "XK_numerosign"
.tL "C" "6B1" "XK_Serbian_DJE"
.tL "C" "6B2" "XK_Macedonia_GJE"
.tL "C" "6B3" "XK_Cyrillic_IO"
.tL "C" "6B4" "XK_Ukrainian_IE"
.tL "C" "6B4" "XK_Ukranian_JE"
.tL "C" "6B5" "XK_Macedonia_DSE"
.tL "C" "6B6" "XK_Ukrainian_I"
.tL "C" "6B6" "XK_Ukranian_I"
.tL "C" "6B7" "XK_Ukrainian_YI"
.tL "C" "6B7" "XK_Ukranian_YI"
.tL "C" "6B8" "XK_Cyrillic_JE"
.tL "C" "6B8" "XK_Serbian_JE"
.tL "C" "6B9" "XK_Cyrillic_LJE"
.tL "C" "6B9" "XK_Serbian_LJE"
.tL "C" "6BA" "XK_Cyrillic_NJE"
.tL "C" "6BA" "XK_Serbian_NJE"
.tL "C" "6BB" "XK_Serbian_TSHE"
.tL "C" "6BC" "XK_Macedonia_KJE"
.tL "C" "6BE" "XK_Byelorussian_SHORTU"
.tL "C" "6BF" "XK_Cyrillic_DZHE"
.tL "C" "6BF" "XK_Serbian_DZE"
.tL "C" "6C0" "XK_Cyrillic_yu"
.tL "C" "6C1" "XK_Cyrillic_a"
.tL "C" "6C2" "XK_Cyrillic_be"
.tL "C" "6C3" "XK_Cyrillic_tse"
.tL "C" "6C4" "XK_Cyrillic_de"
.tL "C" "6C5" "XK_Cyrillic_ie"
.tL "C" "6C6" "XK_Cyrillic_ef"
.tL "C" "6C7" "XK_Cyrillic_ghe"
.tL "C" "6C8" "XK_Cyrillic_ha"
.tL "C" "6C9" "XK_Cyrillic_i"
.tL "C" "6CA" "XK_Cyrillic_shorti"
.tL "C" "6CB" "XK_Cyrillic_ka"
.tL "C" "6CC" "XK_Cyrillic_el"
.tL "C" "6CD" "XK_Cyrillic_em"
.tL "C" "6CE" "XK_Cyrillic_en"
.tL "C" "6CF" "XK_Cyrillic_o"
.tL "C" "6D0" "XK_Cyrillic_pe"
.tL "C" "6D1" "XK_Cyrillic_ya"
.tL "C" "6D2" "XK_Cyrillic_er"
.tL "C" "6D3" "XK_Cyrillic_es"
.tL "C" "6D4" "XK_Cyrillic_te"
.tL "C" "6D5" "XK_Cyrillic_u"
.tL "C" "6D6" "XK_Cyrillic_zhe"
.tL "C" "6D7" "XK_Cyrillic_ve"
.tL "C" "6D8" "XK_Cyrillic_softsign"
.tL "C" "6D9" "XK_Cyrillic_yeru"
.tL "C" "6DA" "XK_Cyrillic_ze"
.tL "C" "6DB" "XK_Cyrillic_sha"
.tL "C" "6DC" "XK_Cyrillic_e"
.tL "C" "6DD" "XK_Cyrillic_shcha"
.tL "C" "6DE" "XK_Cyrillic_che"
.tL "C" "6DF" "XK_Cyrillic_hardsign"
.tL "C" "6E0" "XK_Cyrillic_YU"
.tL "C" "6E1" "XK_Cyrillic_A"
.tL "C" "6E2" "XK_Cyrillic_BE"
.tL "C" "6E3" "XK_Cyrillic_TSE"
.tL "C" "6E4" "XK_Cyrillic_DE"
.tL "C" "6E5" "XK_Cyrillic_IE"
.tL "C" "6E6" "XK_Cyrillic_EF"
.tL "C" "6E7" "XK_Cyrillic_GHE"
.tL "C" "6E8" "XK_Cyrillic_HA"
.tL "C" "6E9" "XK_Cyrillic_I"
.tL "C" "6EA" "XK_Cyrillic_SHORTI"
.tL "C" "6EB" "XK_Cyrillic_KA"
.tL "C" "6EC" "XK_Cyrillic_EL"
.tL "C" "6ED" "XK_Cyrillic_EM"
.tL "C" "6EE" "XK_Cyrillic_EN"
.tL "C" "6EF" "XK_Cyrillic_O"
.tL "C" "6F0" "XK_Cyrillic_PE"
.tL "C" "6F1" "XK_Cyrillic_YA"
.tL "C" "6F2" "XK_Cyrillic_ER"
.tL "C" "6F3" "XK_Cyrillic_ES"
.tL "C" "6F4" "XK_Cyrillic_TE"
.tL "C" "6F5" "XK_Cyrillic_U"
.tL "C" "6F6" "XK_Cyrillic_ZHE"
.tL "C" "6F7" "XK_Cyrillic_VE"
.tL "C" "6F8" "XK_Cyrillic_SOFTSIGN"
.tL "C" "6F9" "XK_Cyrillic_YERU"
.tL "C" "6FA" "XK_Cyrillic_ZE"
.tL "C" "6FB" "XK_Cyrillic_SHA"
.tL "C" "6FC" "XK_Cyrillic_E"
.tL "C" "6FD" "XK_Cyrillic_SHCHA"
.tL "C" "6FE" "XK_Cyrillic_CHE"
.tL "C" "6FF" "XK_Cyrillic_HARDSIGN"
>>STRATEGY
For each KeySym in table with code C:
	Call XKeysymToKeycode to obtain the KeyCode defined for that KeySym.
	Call XKeycodeToKeysym to obtain each KeySym for that KeyCode.
	Verify that one of the KeySyms returned is the original KeySym.
>>CODE 

	kysymtcdC();

>>ASSERTION Good A
When the
.A keysym
argument is a
.S KeySym
in the table which is defined and has code G,
then a call to xname returns the
.S KeyCode
defined for that
.S KeySym .
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
For each KeySym in table with code G:
	Call XKeysymToKeycode to obtain the KeyCode defined for that KeySym.
	Call XKeycodeToKeysym to obtain each KeySym for that KeyCode.
	Verify that one of the KeySyms returned is the original KeySym.
>>CODE 

	kysymtcdG();

>>ASSERTION Good A
When the
.A keysym
argument is a
.S KeySym
in the table which is defined and has code H,
then a call to xname returns the
.S KeyCode
defined for that
.S KeySym .
.tL "Code" "Value" "Name"
.tL "H" "CDF" "XK_hebrew_doublelowline"
.tL "H" "CE0" "XK_hebrew_aleph"
.tL "H" "CE1" "XK_hebrew_bet"
.tL "H" "CE1" "XK_hebrew_beth"
.tL "H" "CE2" "XK_hebrew_gimel"
.tL "H" "CE2" "XK_hebrew_gimmel"
.tL "H" "CE3" "XK_hebrew_dalet"
.tL "H" "CE3" "XK_hebrew_daleth"
.tL "H" "CE4" "XK_hebrew_he"
.tL "H" "CE5" "XK_hebrew_waw"
.tL "H" "CE6" "XK_hebrew_zain"
.tL "H" "CE6" "XK_hebrew_zayin"
.tL "H" "CE7" "XK_hebrew_chet"
.tL "H" "CE7" "XK_hebrew_het"
.tL "H" "CE8" "XK_hebrew_tet"
.tL "H" "CE8" "XK_hebrew_teth"
.tL "H" "CE9" "XK_hebrew_yod"
.tL "H" "CEA" "XK_hebrew_finalkaph"
.tL "H" "CEB" "XK_hebrew_kaph"
.tL "H" "CEC" "XK_hebrew_lamed"
.tL "H" "CED" "XK_hebrew_finalmem"
.tL "H" "CEE" "XK_hebrew_mem"
.tL "H" "CEF" "XK_hebrew_finalnun"
.tL "H" "CF0" "XK_hebrew_nun"
.tL "H" "CF1" "XK_hebrew_samech"
.tL "H" "CF1" "XK_hebrew_samekh"
.tL "H" "CF2" "XK_hebrew_ayin"
.tL "H" "CF3" "XK_hebrew_finalpe"
.tL "H" "CF4" "XK_hebrew_pe"
.tL "H" "CF5" "XK_hebrew_finalzade"
.tL "H" "CF5" "XK_hebrew_finalzadi"
.tL "H" "CF6" "XK_hebrew_zade"
.tL "H" "CF6" "XK_hebrew_zadi"
.tL "H" "CF7" "XK_hebrew_qoph"
.tL "H" "CF7" "XK_hebrew_kuf"
.tL "H" "CF8" "XK_hebrew_resh"
.tL "H" "CF9" "XK_hebrew_shin"
.tL "H" "CFA" "XK_hebrew_taw"
.tL "H" "CFA" "XK_hebrew_taf"
.tL "H" "FF7E" "XK_Hebrew_switch"
>>STRATEGY
For each KeySym in table with code H:
	Call XKeysymToKeycode to obtain the KeyCode defined for that KeySym.
	Call XKeycodeToKeysym to obtain each KeySym for that KeyCode.
	Verify that one of the KeySyms returned is the original KeySym.
>>CODE 

	kysymtcdH();

>>ASSERTION Good A
When the
.A keysym
argument is a
.S KeySym
in the table which is defined and has code K,
then a call to xname returns the
.S KeyCode
defined for that
.S KeySym .
.tL "Code" "Value" "Name"
.tL "K" "47E" "XK_overline"
.tL "K" "4A1" "XK_kana_fullstop"
.tL "K" "4A2" "XK_kana_openingbracket"
.tL "K" "4A3" "XK_kana_closingbracket"
.tL "K" "4A4" "XK_kana_comma"
.tL "K" "4A5" "XK_kana_conjunctive"
.tL "K" "4A5" "XK_kana_middledot"
.tL "K" "4A6" "XK_kana_WO"
.tL "K" "4A7" "XK_kana_a"
.tL "K" "4A8" "XK_kana_i"
.tL "K" "4A9" "XK_kana_u"
.tL "K" "4AA" "XK_kana_e"
.tL "K" "4AB" "XK_kana_o"
.tL "K" "4AC" "XK_kana_ya"
.tL "K" "4AD" "XK_kana_yu"
.tL "K" "4AE" "XK_kana_yo"
.tL "K" "4AF" "XK_kana_tsu"
.tL "K" "4AF" "XK_kana_tu"
.tL "K" "4B0" "XK_prolongedsound"
.tL "K" "4B1" "XK_kana_A"
.tL "K" "4B2" "XK_kana_I"
.tL "K" "4B3" "XK_kana_U"
.tL "K" "4B4" "XK_kana_E"
.tL "K" "4B5" "XK_kana_O"
.tL "K" "4B6" "XK_kana_KA"
.tL "K" "4B7" "XK_kana_KI"
.tL "K" "4B8" "XK_kana_KU"
.tL "K" "4B9" "XK_kana_KE"
.tL "K" "4BA" "XK_kana_KO"
.tL "K" "4BB" "XK_kana_SA"
.tL "K" "4BC" "XK_kana_SHI"
.tL "K" "4BD" "XK_kana_SU"
.tL "K" "4BE" "XK_kana_SE"
.tL "K" "4BF" "XK_kana_SO"
.tL "K" "4C0" "XK_kana_TA"
.tL "K" "4C1" "XK_kana_CHI"
.tL "K" "4C1" "XK_kana_TI"
.tL "K" "4C2" "XK_kana_TSU"
.tL "K" "4C2" "XK_kana_TU"
.tL "K" "4C3" "XK_kana_TE"
.tL "K" "4C4" "XK_kana_TO"
.tL "K" "4C5" "XK_kana_NA"
.tL "K" "4C6" "XK_kana_NI"
.tL "K" "4C7" "XK_kana_NU"
.tL "K" "4C8" "XK_kana_NE"
.tL "K" "4C9" "XK_kana_NO"
.tL "K" "4CA" "XK_kana_HA"
.tL "K" "4CB" "XK_kana_HI"
.tL "K" "4CC" "XK_kana_FU"
.tL "K" "4CC" "XK_kana_HU"
.tL "K" "4CD" "XK_kana_HE"
.tL "K" "4CE" "XK_kana_HO"
.tL "K" "4CF" "XK_kana_MA"
.tL "K" "4D0" "XK_kana_MI"
.tL "K" "4D1" "XK_kana_MU"
.tL "K" "4D2" "XK_kana_ME"
.tL "K" "4D3" "XK_kana_MO"
.tL "K" "4D4" "XK_kana_YA"
.tL "K" "4D5" "XK_kana_YU"
.tL "K" "4D6" "XK_kana_YO"
.tL "K" "4D7" "XK_kana_RA"
.tL "K" "4D8" "XK_kana_RI"
.tL "K" "4D9" "XK_kana_RU"
.tL "K" "4DA" "XK_kana_RE"
.tL "K" "4DB" "XK_kana_RO"
.tL "K" "4DC" "XK_kana_WA"
.tL "K" "4DD" "XK_kana_N"
.tL "K" "4DE" "XK_voicedsound"
.tL "K" "4DF" "XK_semivoicedsound"
.tL "K" "FF7E" "XK_kana_switch"
>>STRATEGY
For each KeySym in table with code K:
	Call XKeysymToKeycode to obtain the KeyCode defined for that KeySym.
	Call XKeycodeToKeysym to obtain each KeySym for that KeyCode.
	Verify that one of the KeySyms returned is the original KeySym.
>>CODE 

	kysymtcdK();

>>ASSERTION Good A
When the
.A keysym
argument is a
.S KeySym
in the table which is defined and has code L,
then a call to xname returns the
.S KeyCode
defined for that
.S KeySym .
.tL "Code" "Value" "Name"
.tL "L" "BA3" "XK_leftcaret"
.tL "L" "BA6" "XK_rightcaret"
.tL "L" "BA8" "XK_downcaret"
.tL "L" "BA9" "XK_upcaret"
.tL "L" "BC0" "XK_overbar"
.tL "L" "BC2" "XK_downtack"
.tL "L" "BC3" "XK_upshoe"
.tL "L" "BC4" "XK_downstile"
.tL "L" "BC6" "XK_underbar"
.tL "L" "BCA" "XK_jot"
.tL "L" "BCC" "XK_quad"
.tL "L" "BCE" "XK_uptack"
.tL "L" "BCF" "XK_circle"
.tL "L" "BD3" "XK_upstile"
.tL "L" "BD6" "XK_downshoe"
.tL "L" "BD8" "XK_rightshoe"
.tL "L" "BDA" "XK_leftshoe"
.tL "L" "BDC" "XK_lefttack"
.tL "L" "BFC" "XK_righttack"
>>STRATEGY
For each KeySym in table with code L:
	Call XKeysymToKeycode to obtain the KeyCode defined for that KeySym.
	Call XKeycodeToKeysym to obtain each KeySym for that KeyCode.
	Verify that one of the KeySyms returned is the original KeySym.
>>CODE 

	kysymtcdL();

>>ASSERTION Good A
When the
.A keysym
argument is a
.S KeySym
in the table which is defined and has code M,
then a call to xname returns the
.S KeyCode
defined for that
.S KeySym .
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
For each KeySym in table with code M:
	Call XKeysymToKeycode to obtain the KeyCode defined for that KeySym.
	Call XKeycodeToKeysym to obtain each KeySym for that KeyCode.
	Verify that one of the KeySyms returned is the original KeySym.
>>CODE 

	kysymtcdM();

>>ASSERTION Good A
When the
.A keysym
argument is a
.S KeySym
in the table which is defined and has code P,
then a call to xname returns the
.S KeyCode
defined for that
.S KeySym .
.tL "Code" "Value" "Name"
.tL "P" "AA1" "XK_emspace"
.tL "P" "AA2" "XK_enspace"
.tL "P" "AA3" "XK_em3space"
.tL "P" "AA4" "XK_em4space"
.tL "P" "AA5" "XK_digitspace"
.tL "P" "AA6" "XK_punctspace"
.tL "P" "AA7" "XK_thinspace"
.tL "P" "AA8" "XK_hairspace"
.tL "P" "AA9" "XK_emdash"
.tL "P" "AAA" "XK_endash"
.tL "P" "AAC" "XK_signifblank"
.tL "P" "AAE" "XK_ellipsis"
.tL "P" "AAF" "XK_doubbaselinedot"
.tL "P" "AB0" "XK_onethird"
.tL "P" "AB1" "XK_twothirds"
.tL "P" "AB2" "XK_onefifth"
.tL "P" "AB3" "XK_twofifths"
.tL "P" "AB4" "XK_threefifths"
.tL "P" "AB5" "XK_fourfifths"
.tL "P" "AB6" "XK_onesixth"
.tL "P" "AB7" "XK_fivesixths"
.tL "P" "AB8" "XK_careof"
.tL "P" "ABB" "XK_figdash"
.tL "P" "ABC" "XK_leftanglebracket"
.tL "P" "ABD" "XK_decimalpoint"
.tL "P" "ABE" "XK_rightanglebracket"
.tL "P" "ABF" "XK_marker"
.tL "P" "AC3" "XK_oneeighth"
.tL "P" "AC4" "XK_threeeighths"
.tL "P" "AC5" "XK_fiveeighths"
.tL "P" "AC6" "XK_seveneighths"
.tL "P" "AC9" "XK_trademark"
.tL "P" "ACA" "XK_signaturemark"
.tL "P" "ACB" "XK_trademarkincircle"
.tL "P" "ACC" "XK_leftopentriangle"
.tL "P" "ACD" "XK_rightopentriangle"
.tL "P" "ACE" "XK_emopencircle"
.tL "P" "ACF" "XK_emopenrectangle"
.tL "P" "AD0" "XK_leftsinglequotemark"
.tL "P" "AD1" "XK_rightsinglequotemark"
.tL "P" "AD2" "XK_leftdoublequotemark"
.tL "P" "AD3" "XK_rightdoublequotemark"
.tL "P" "AD4" "XK_prescription"
.tL "P" "AD6" "XK_minutes"
.tL "P" "AD7" "XK_seconds"
.tL "P" "AD9" "XK_latincross"
.tL "P" "ADA" "XK_hexagram"
.tL "P" "ADB" "XK_filledrectbullet"
.tL "P" "ADC" "XK_filledlefttribullet"
.tL "P" "ADD" "XK_filledrighttribullet"
.tL "P" "ADE" "XK_emfilledcircle"
.tL "P" "ADF" "XK_emfilledrect"
.tL "P" "AE0" "XK_enopencircbullet"
.tL "P" "AE1" "XK_enopensquarebullet"
.tL "P" "AE2" "XK_openrectbullet"
.tL "P" "AE3" "XK_opentribulletup"
.tL "P" "AE4" "XK_opentribulletdown"
.tL "P" "AE5" "XK_openstar"
.tL "P" "AE6" "XK_enfilledcircbullet"
.tL "P" "AE7" "XK_enfilledsqbullet"
.tL "P" "AE8" "XK_filledtribulletup"
.tL "P" "AE9" "XK_filledtribulletdown"
.tL "P" "AEA" "XK_leftpointer"
.tL "P" "AEB" "XK_rightpointer"
.tL "P" "AEC" "XK_club"
.tL "P" "AED" "XK_diamond"
.tL "P" "AEE" "XK_heart"
.tL "P" "AF0" "XK_maltesecross"
.tL "P" "AF1" "XK_dagger"
.tL "P" "AF2" "XK_doubledagger"
.tL "P" "AF3" "XK_checkmark"
.tL "P" "AF4" "XK_ballotcross"
.tL "P" "AF5" "XK_musicalsharp"
.tL "P" "AF6" "XK_musicalflat"
.tL "P" "AF7" "XK_malesymbol"
.tL "P" "AF8" "XK_femalesymbol"
.tL "P" "AF9" "XK_telephone"
.tL "P" "AFA" "XK_telephonerecorder"
.tL "P" "AFB" "XK_phonographcopyright"
.tL "P" "AFC" "XK_caret"
.tL "P" "AFD" "XK_singlelowquotemark"
.tL "P" "AFE" "XK_doublelowquotemark"
.tL "P" "AFF" "XK_cursor"
>>STRATEGY
For each KeySym in table with code P:
	Call XKeysymToKeycode to obtain the KeyCode defined for that KeySym.
	Call XKeycodeToKeysym to obtain each KeySym for that KeyCode.
	Verify that one of the KeySyms returned is the original KeySym.
>>CODE 

	kysymtcdP();

>>ASSERTION Good A
When the
.A keysym
argument is a
.S KeySym
in the table which is defined and has code S,
then a call to xname returns the
.S KeyCode
defined for that
.S KeySym .
.tL "Code" "Value" "Name"
.tL "S" "9DF" "XK_blank"
.tL "S" "9E0" "XK_soliddiamond"
.tL "S" "9E1" "XK_checkerboard"
.tL "S" "9E2" "XK_ht"
.tL "S" "9E3" "XK_ff"
.tL "S" "9E4" "XK_cr"
.tL "S" "9E5" "XK_lf"
.tL "S" "9E8" "XK_nl"
.tL "S" "9E9" "XK_vt"
.tL "S" "9EA" "XK_lowrightcorner"
.tL "S" "9EB" "XK_uprightcorner"
.tL "S" "9EC" "XK_upleftcorner"
.tL "S" "9ED" "XK_lowleftcorner"
.tL "S" "9EE" "XK_crossinglines"
.tL "S" "9EF" "XK_horizlinescan1"
.tL "S" "9F0" "XK_horizlinescan3"
.tL "S" "9F1" "XK_horizlinescan5"
.tL "S" "9F2" "XK_horizlinescan7"
.tL "S" "9F3" "XK_horizlinescan9"
.tL "S" "9F4" "XK_leftt"
.tL "S" "9F5" "XK_rightt"
.tL "S" "9F6" "XK_bott"
.tL "S" "9F7" "XK_topt"
.tL "S" "9F8" "XK_vertbar"
>>STRATEGY
For each KeySym in table with code S:
	Call XKeysymToKeycode to obtain the KeyCode defined for that KeySym.
	Call XKeycodeToKeysym to obtain each KeySym for that KeyCode.
	Verify that one of the KeySyms returned is the original KeySym.
>>CODE 

	kysymtcdS();

>>ASSERTION Good A
When the
.A keysym
argument is a
.S KeySym
in the table which is defined and has code T,
then a call to xname returns the
.S KeyCode
defined for that
.S KeySym .
.tL "Code" "Value" "Name"
.tL "T" "8A1" "XK_leftradical"
.tL "T" "8A2" "XK_topleftradical"
.tL "T" "8A3" "XK_horizconnector"
.tL "T" "8A4" "XK_topintegral"
.tL "T" "8A5" "XK_botintegral"
.tL "T" "8A6" "XK_vertconnector"
.tL "T" "8A7" "XK_topleftsqbracket"
.tL "T" "8A8" "XK_botleftsqbracket"
.tL "T" "8A9" "XK_toprightsqbracket"
.tL "T" "8AA" "XK_botrightsqbracket"
.tL "T" "8AB" "XK_topleftparens"
.tL "T" "8AC" "XK_botleftparens"
.tL "T" "8AD" "XK_toprightparens"
.tL "T" "8AE" "XK_botrightparens"
.tL "T" "8AF" "XK_leftmiddlecurlybrace"
.tL "T" "8B0" "XK_rightmiddlecurlybrace"
.tL "T" "8B1" "XK_topleftsummation"
.tL "T" "8B2" "XK_botleftsummation"
.tL "T" "8B3" "XK_topvertsummationconnector"
.tL "T" "8B4" "XK_botvertsummationconnector"
.tL "T" "8B5" "XK_toprightsummation"
.tL "T" "8B6" "XK_botrightsummation"
.tL "T" "8B7" "XK_rightmiddlesummation"
.tL "T" "8BC" "XK_lessthanequal"
.tL "T" "8BD" "XK_notequal"
.tL "T" "8BE" "XK_greaterthanequal"
.tL "T" "8BF" "XK_integral"
.tL "T" "8C0" "XK_therefore"
.tL "T" "8C1" "XK_variation"
.tL "T" "8C2" "XK_infinity"
.tL "T" "8C5" "XK_nabla"
.tL "T" "8C8" "XK_approximate"
.tL "T" "8C9" "XK_similarequal"
.tL "T" "8CD" "XK_ifonlyif"
.tL "T" "8CE" "XK_implies"
.tL "T" "8CF" "XK_identical"
.tL "T" "8D6" "XK_radical"
.tL "T" "8DA" "XK_includedin"
.tL "T" "8DB" "XK_includes"
.tL "T" "8DC" "XK_intersection"
.tL "T" "8DD" "XK_union"
.tL "T" "8DE" "XK_logicaland"
.tL "T" "8DF" "XK_logicalor"
.tL "T" "8EF" "XK_partialderivative"
.tL "T" "8F6" "XK_function"
.tL "T" "8FB" "XK_leftarrow"
.tL "T" "8FC" "XK_uparrow"
.tL "T" "8FD" "XK_rightarrow"
.tL "T" "8FE" "XK_downarrow"
>>STRATEGY
For each KeySym in table with code T:
	Call XKeysymToKeycode to obtain the KeyCode defined for that KeySym.
	Call XKeycodeToKeysym to obtain each KeySym for that KeyCode.
	Verify that one of the KeySyms returned is the original KeySym.
>>CODE 

	kysymtcdT();

