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
* $Header: /cvs/xtest/xtest/xts5/tset/Xopen/kysymdf/TestM.c,v 1.1 2005-02-12 14:37:43 anderson Exp $
* 
* Project: VSW5
* 
* File: vsw5/tset/Xopen/kysymdf/TestM.c
* 
* Description:
* 	Tests for keysymdef()
* 
* Modifications:
* $Log: TestM.c,v $
* Revision 1.1  2005-02-12 14:37:43  anderson
* Initial revision
*
* Revision 8.0  1998/12/23 23:35:40  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:58:16  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:26:54  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:23:28  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.1  1996/05/09 21:16:18  andy
* Fixed X includes
*
* Revision 4.0  1995/12/15  09:13:53  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  01:17:12  andy
* Prepare for GA Release
*
*/
/*
 *      SCCS:  @(#)  TestM.c Rel 1.1	    (11/28/91)
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

#define XK_MISCELLANY
#include	<X11/keysymdef.h>
#undef XK_MISCELLANY

kysymdf11()
{ 
int 	pass = 0, fail = 0;
#ifdef XK_BackSpace
	if(test("XK_BackSpace", XK_BackSpace, 0xFF08) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_BackSpace");
	FAIL;
#endif

#ifdef XK_Tab
	if(test("XK_Tab", XK_Tab, 0xFF09) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Tab");
	FAIL;
#endif

#ifdef XK_Linefeed
	if(test("XK_Linefeed", XK_Linefeed, 0xFF0A) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Linefeed");
	FAIL;
#endif

#ifdef XK_Clear
	if(test("XK_Clear", XK_Clear, 0xFF0B) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Clear");
	FAIL;
#endif

#ifdef XK_Return
	if(test("XK_Return", XK_Return, 0xFF0D) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Return");
	FAIL;
#endif

#ifdef XK_Pause
	if(test("XK_Pause", XK_Pause, 0xFF13) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Pause");
	FAIL;
#endif

#ifdef XK_Scroll_Lock
	if(test("XK_Scroll_Lock", XK_Scroll_Lock, 0xFF14) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Scroll_Lock");
	FAIL;
#endif

#ifdef XK_Escape
	if(test("XK_Escape", XK_Escape, 0xFF1B) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Escape");
	FAIL;
#endif

#ifdef XK_Multi_key
	if(test("XK_Multi_key", XK_Multi_key, 0xFF20) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Multi_key");
	FAIL;
#endif

#ifdef XK_Kanji
	if(test("XK_Kanji", XK_Kanji, 0xFF21) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Kanji");
	FAIL;
#endif

#ifdef XK_Muhenkan
	if(test("XK_Muhenkan", XK_Muhenkan, 0xFF22) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Muhenkan");
	FAIL;
#endif

#ifdef XK_Henkan
	if(test("XK_Henkan", XK_Henkan, 0xFF23) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Henkan");
	FAIL;
#endif

#ifdef XK_Henkan_Mode
	if(test("XK_Henkan_Mode", XK_Henkan_Mode, 0xFF23) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Henkan_Mode");
	FAIL;
#endif

#ifdef XK_Romaji
	if(test("XK_Romaji", XK_Romaji, 0xFF24) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Romaji");
	FAIL;
#endif

#ifdef XK_Hiragana
	if(test("XK_Hiragana", XK_Hiragana, 0xFF25) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Hiragana");
	FAIL;
#endif

#ifdef XK_Katakana
	if(test("XK_Katakana", XK_Katakana, 0xFF26) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Katakana");
	FAIL;
#endif

#ifdef XK_Hiragana_Katakana
	if(test("XK_Hiragana_Katakana", XK_Hiragana_Katakana, 0xFF27) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Hiragana_Katakana");
	FAIL;
#endif

#ifdef XK_Zenkaku
	if(test("XK_Zenkaku", XK_Zenkaku, 0xFF28) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Zenkaku");
	FAIL;
#endif

#ifdef XK_Hankaku
	if(test("XK_Hankaku", XK_Hankaku, 0xFF29) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Hankaku");
	FAIL;
#endif

#ifdef XK_Zenkaku_Hankaku
	if(test("XK_Zenkaku_Hankaku", XK_Zenkaku_Hankaku, 0xFF2A) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Zenkaku_Hankaku");
	FAIL;
#endif

#ifdef XK_Touroku
	if(test("XK_Touroku", XK_Touroku, 0xFF2B) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Touroku");
	FAIL;
#endif

#ifdef XK_Massyo
	if(test("XK_Massyo", XK_Massyo, 0xFF2C) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Massyo");
	FAIL;
#endif

#ifdef XK_Kana_Lock
	if(test("XK_Kana_Lock", XK_Kana_Lock, 0xFF2D) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Kana_Lock");
	FAIL;
#endif

#ifdef XK_Kana_Shift
	if(test("XK_Kana_Shift", XK_Kana_Shift, 0xFF2E) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Kana_Shift");
	FAIL;
#endif

#ifdef XK_Eisu_Shift
	if(test("XK_Eisu_Shift", XK_Eisu_Shift, 0xFF2F) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Eisu_Shift");
	FAIL;
#endif

#ifdef XK_Eisu_toggle
	if(test("XK_Eisu_toggle", XK_Eisu_toggle, 0xFF30) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Eisu_toggle");
	FAIL;
#endif

#ifdef XK_Home
	if(test("XK_Home", XK_Home, 0xFF50) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Home");
	FAIL;
#endif

#ifdef XK_Left
	if(test("XK_Left", XK_Left, 0xFF51) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Left");
	FAIL;
#endif

#ifdef XK_Up
	if(test("XK_Up", XK_Up, 0xFF52) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Up");
	FAIL;
#endif

#ifdef XK_Right
	if(test("XK_Right", XK_Right, 0xFF53) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Right");
	FAIL;
#endif

#ifdef XK_Down
	if(test("XK_Down", XK_Down, 0xFF54) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Down");
	FAIL;
#endif

#ifdef XK_Prior
	if(test("XK_Prior", XK_Prior, 0xFF55) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Prior");
	FAIL;
#endif

#ifdef XK_Next
	if(test("XK_Next", XK_Next, 0xFF56) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Next");
	FAIL;
#endif

#ifdef XK_End
	if(test("XK_End", XK_End, 0xFF57) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_End");
	FAIL;
#endif

#ifdef XK_Begin
	if(test("XK_Begin", XK_Begin, 0xFF58) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Begin");
	FAIL;
#endif

#ifdef XK_Select
	if(test("XK_Select", XK_Select, 0xFF60) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Select");
	FAIL;
#endif

#ifdef XK_Print
	if(test("XK_Print", XK_Print, 0xFF61) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Print");
	FAIL;
#endif

#ifdef XK_Execute
	if(test("XK_Execute", XK_Execute, 0xFF62) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Execute");
	FAIL;
#endif

#ifdef XK_Insert
	if(test("XK_Insert", XK_Insert, 0xFF63) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Insert");
	FAIL;
#endif

#ifdef XK_Undo
	if(test("XK_Undo", XK_Undo, 0xFF65) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Undo");
	FAIL;
#endif

#ifdef XK_Redo
	if(test("XK_Redo", XK_Redo, 0xFF66) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Redo");
	FAIL;
#endif

#ifdef XK_Menu
	if(test("XK_Menu", XK_Menu, 0xFF67) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Menu");
	FAIL;
#endif

#ifdef XK_Find
	if(test("XK_Find", XK_Find, 0xFF68) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Find");
	FAIL;
#endif

#ifdef XK_Cancel
	if(test("XK_Cancel", XK_Cancel, 0xFF69) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Cancel");
	FAIL;
#endif

#ifdef XK_Help
	if(test("XK_Help", XK_Help, 0xFF6A) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Help");
	FAIL;
#endif

#ifdef XK_Break
	if(test("XK_Break", XK_Break, 0xFF6B) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Break");
	FAIL;
#endif

#ifdef XK_Mode_switch
	if(test("XK_Mode_switch", XK_Mode_switch, 0xFF7E) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Mode_switch");
	FAIL;
#endif

#ifdef XK_script_switch
	if(test("XK_script_switch", XK_script_switch, 0xFF7E) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_script_switch");
	FAIL;
#endif

#ifdef XK_Num_Lock
	if(test("XK_Num_Lock", XK_Num_Lock, 0xFF7F) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Num_Lock");
	FAIL;
#endif

#ifdef XK_KP_Space
	if(test("XK_KP_Space", XK_KP_Space, 0xFF80) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_KP_Space");
	FAIL;
#endif

#ifdef XK_KP_Tab
	if(test("XK_KP_Tab", XK_KP_Tab, 0xFF89) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_KP_Tab");
	FAIL;
#endif

#ifdef XK_KP_Enter
	if(test("XK_KP_Enter", XK_KP_Enter, 0xFF8D) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_KP_Enter");
	FAIL;
#endif

#ifdef XK_KP_F1
	if(test("XK_KP_F1", XK_KP_F1, 0xFF91) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_KP_F1");
	FAIL;
#endif

#ifdef XK_KP_F2
	if(test("XK_KP_F2", XK_KP_F2, 0xFF92) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_KP_F2");
	FAIL;
#endif

#ifdef XK_KP_F3
	if(test("XK_KP_F3", XK_KP_F3, 0xFF93) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_KP_F3");
	FAIL;
#endif

#ifdef XK_KP_F4
	if(test("XK_KP_F4", XK_KP_F4, 0xFF94) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_KP_F4");
	FAIL;
#endif

#ifdef XK_KP_Multiply
	if(test("XK_KP_Multiply", XK_KP_Multiply, 0xFFAA) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_KP_Multiply");
	FAIL;
#endif

#ifdef XK_KP_Add
	if(test("XK_KP_Add", XK_KP_Add, 0xFFAB) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_KP_Add");
	FAIL;
#endif

#ifdef XK_KP_Separator
	if(test("XK_KP_Separator", XK_KP_Separator, 0xFFAC) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_KP_Separator");
	FAIL;
#endif

#ifdef XK_KP_Subtract
	if(test("XK_KP_Subtract", XK_KP_Subtract, 0xFFAD) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_KP_Subtract");
	FAIL;
#endif

#ifdef XK_KP_Decimal
	if(test("XK_KP_Decimal", XK_KP_Decimal, 0xFFAE) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_KP_Decimal");
	FAIL;
#endif

#ifdef XK_KP_Divide
	if(test("XK_KP_Divide", XK_KP_Divide, 0xFFAF) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_KP_Divide");
	FAIL;
#endif

#ifdef XK_KP_0
	if(test("XK_KP_0", XK_KP_0, 0xFFB0) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_KP_0");
	FAIL;
#endif

#ifdef XK_KP_1
	if(test("XK_KP_1", XK_KP_1, 0xFFB1) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_KP_1");
	FAIL;
#endif

#ifdef XK_KP_2
	if(test("XK_KP_2", XK_KP_2, 0xFFB2) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_KP_2");
	FAIL;
#endif

#ifdef XK_KP_3
	if(test("XK_KP_3", XK_KP_3, 0xFFB3) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_KP_3");
	FAIL;
#endif

#ifdef XK_KP_4
	if(test("XK_KP_4", XK_KP_4, 0xFFB4) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_KP_4");
	FAIL;
#endif

#ifdef XK_KP_5
	if(test("XK_KP_5", XK_KP_5, 0xFFB5) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_KP_5");
	FAIL;
#endif

#ifdef XK_KP_6
	if(test("XK_KP_6", XK_KP_6, 0xFFB6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_KP_6");
	FAIL;
#endif

#ifdef XK_KP_7
	if(test("XK_KP_7", XK_KP_7, 0xFFB7) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_KP_7");
	FAIL;
#endif

#ifdef XK_KP_8
	if(test("XK_KP_8", XK_KP_8, 0xFFB8) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_KP_8");
	FAIL;
#endif

#ifdef XK_KP_9
	if(test("XK_KP_9", XK_KP_9, 0xFFB9) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_KP_9");
	FAIL;
#endif

#ifdef XK_KP_Equal
	if(test("XK_KP_Equal", XK_KP_Equal, 0xFFBD) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_KP_Equal");
	FAIL;
#endif

#ifdef XK_F1
	if(test("XK_F1", XK_F1, 0xFFBE) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_F1");
	FAIL;
#endif

#ifdef XK_F2
	if(test("XK_F2", XK_F2, 0xFFBF) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_F2");
	FAIL;
#endif

#ifdef XK_F3
	if(test("XK_F3", XK_F3, 0xFFC0) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_F3");
	FAIL;
#endif

#ifdef XK_F4
	if(test("XK_F4", XK_F4, 0xFFC1) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_F4");
	FAIL;
#endif

#ifdef XK_F5
	if(test("XK_F5", XK_F5, 0xFFC2) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_F5");
	FAIL;
#endif

#ifdef XK_F6
	if(test("XK_F6", XK_F6, 0xFFC3) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_F6");
	FAIL;
#endif

#ifdef XK_F7
	if(test("XK_F7", XK_F7, 0xFFC4) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_F7");
	FAIL;
#endif

#ifdef XK_F8
	if(test("XK_F8", XK_F8, 0xFFC5) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_F8");
	FAIL;
#endif

#ifdef XK_F9
	if(test("XK_F9", XK_F9, 0xFFC6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_F9");
	FAIL;
#endif

#ifdef XK_F10
	if(test("XK_F10", XK_F10, 0xFFC7) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_F10");
	FAIL;
#endif

#ifdef XK_F11
	if(test("XK_F11", XK_F11, 0xFFC8) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_F11");
	FAIL;
#endif

#ifdef XK_L1
	if(test("XK_L1", XK_L1, 0xFFC8) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_L1");
	FAIL;
#endif

#ifdef XK_F12
	if(test("XK_F12", XK_F12, 0xFFC9) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_F12");
	FAIL;
#endif

#ifdef XK_L2
	if(test("XK_L2", XK_L2, 0xFFC9) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_L2");
	FAIL;
#endif

#ifdef XK_F13
	if(test("XK_F13", XK_F13, 0xFFCA) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_F13");
	FAIL;
#endif

#ifdef XK_L3
	if(test("XK_L3", XK_L3, 0xFFCA) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_L3");
	FAIL;
#endif

#ifdef XK_F14
	if(test("XK_F14", XK_F14, 0xFFCB) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_F14");
	FAIL;
#endif

#ifdef XK_L4
	if(test("XK_L4", XK_L4, 0xFFCB) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_L4");
	FAIL;
#endif

#ifdef XK_F15
	if(test("XK_F15", XK_F15, 0xFFCC) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_F15");
	FAIL;
#endif

#ifdef XK_L5
	if(test("XK_L5", XK_L5, 0xFFCC) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_L5");
	FAIL;
#endif

#ifdef XK_F16
	if(test("XK_F16", XK_F16, 0xFFCD) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_F16");
	FAIL;
#endif

#ifdef XK_L6
	if(test("XK_L6", XK_L6, 0xFFCD) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_L6");
	FAIL;
#endif

#ifdef XK_F17
	if(test("XK_F17", XK_F17, 0xFFCE) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_F17");
	FAIL;
#endif

#ifdef XK_L7
	if(test("XK_L7", XK_L7, 0xFFCE) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_L7");
	FAIL;
#endif

#ifdef XK_F18
	if(test("XK_F18", XK_F18, 0xFFCF) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_F18");
	FAIL;
#endif

#ifdef XK_L8
	if(test("XK_L8", XK_L8, 0xFFCF) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_L8");
	FAIL;
#endif

#ifdef XK_F19
	if(test("XK_F19", XK_F19, 0xFFD0) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_F19");
	FAIL;
#endif

#ifdef XK_L9
	if(test("XK_L9", XK_L9, 0xFFD0) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_L9");
	FAIL;
#endif

#ifdef XK_F20
	if(test("XK_F20", XK_F20, 0xFFD1) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_F20");
	FAIL;
#endif

#ifdef XK_L10
	if(test("XK_L10", XK_L10, 0xFFD1) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_L10");
	FAIL;
#endif

#ifdef XK_F21
	if(test("XK_F21", XK_F21, 0xFFD2) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_F21");
	FAIL;
#endif

#ifdef XK_R1
	if(test("XK_R1", XK_R1, 0xFFD2) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_R1");
	FAIL;
#endif

#ifdef XK_F22
	if(test("XK_F22", XK_F22, 0xFFD3) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_F22");
	FAIL;
#endif

#ifdef XK_R2
	if(test("XK_R2", XK_R2, 0xFFD3) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_R2");
	FAIL;
#endif

#ifdef XK_F23
	if(test("XK_F23", XK_F23, 0xFFD4) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_F23");
	FAIL;
#endif

#ifdef XK_R3
	if(test("XK_R3", XK_R3, 0xFFD4) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_R3");
	FAIL;
#endif

#ifdef XK_F24
	if(test("XK_F24", XK_F24, 0xFFD5) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_F24");
	FAIL;
#endif

#ifdef XK_R4
	if(test("XK_R4", XK_R4, 0xFFD5) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_R4");
	FAIL;
#endif

#ifdef XK_F25
	if(test("XK_F25", XK_F25, 0xFFD6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_F25");
	FAIL;
#endif

#ifdef XK_R5
	if(test("XK_R5", XK_R5, 0xFFD6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_R5");
	FAIL;
#endif

#ifdef XK_F26
	if(test("XK_F26", XK_F26, 0xFFD7) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_F26");
	FAIL;
#endif

#ifdef XK_R6
	if(test("XK_R6", XK_R6, 0xFFD7) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_R6");
	FAIL;
#endif

#ifdef XK_F27
	if(test("XK_F27", XK_F27, 0xFFD8) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_F27");
	FAIL;
#endif

#ifdef XK_R7
	if(test("XK_R7", XK_R7, 0xFFD8) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_R7");
	FAIL;
#endif

#ifdef XK_F28
	if(test("XK_F28", XK_F28, 0xFFD9) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_F28");
	FAIL;
#endif

#ifdef XK_R8
	if(test("XK_R8", XK_R8, 0xFFD9) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_R8");
	FAIL;
#endif

#ifdef XK_F29
	if(test("XK_F29", XK_F29, 0xFFDA) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_F29");
	FAIL;
#endif

#ifdef XK_R9
	if(test("XK_R9", XK_R9, 0xFFDA) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_R9");
	FAIL;
#endif

#ifdef XK_F30
	if(test("XK_F30", XK_F30, 0xFFDB) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_F30");
	FAIL;
#endif

#ifdef XK_R10
	if(test("XK_R10", XK_R10, 0xFFDB) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_R10");
	FAIL;
#endif

#ifdef XK_F31
	if(test("XK_F31", XK_F31, 0xFFDC) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_F31");
	FAIL;
#endif

#ifdef XK_R11
	if(test("XK_R11", XK_R11, 0xFFDC) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_R11");
	FAIL;
#endif

#ifdef XK_F32
	if(test("XK_F32", XK_F32, 0xFFDD) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_F32");
	FAIL;
#endif

#ifdef XK_R12
	if(test("XK_R12", XK_R12, 0xFFDD) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_R12");
	FAIL;
#endif

#ifdef XK_F33
	if(test("XK_F33", XK_F33, 0xFFDE) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_F33");
	FAIL;
#endif

#ifdef XK_R13
	if(test("XK_R13", XK_R13, 0xFFDE) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_R13");
	FAIL;
#endif

#ifdef XK_F34
	if(test("XK_F34", XK_F34, 0xFFDF) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_F34");
	FAIL;
#endif

#ifdef XK_R14
	if(test("XK_R14", XK_R14, 0xFFDF) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_R14");
	FAIL;
#endif

#ifdef XK_F35
	if(test("XK_F35", XK_F35, 0xFFE0) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_F35");
	FAIL;
#endif

#ifdef XK_R15
	if(test("XK_R15", XK_R15, 0xFFE0) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_R15");
	FAIL;
#endif

#ifdef XK_Shift_L
	if(test("XK_Shift_L", XK_Shift_L, 0xFFE1) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Shift_L");
	FAIL;
#endif

#ifdef XK_Shift_R
	if(test("XK_Shift_R", XK_Shift_R, 0xFFE2) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Shift_R");
	FAIL;
#endif

#ifdef XK_Control_L
	if(test("XK_Control_L", XK_Control_L, 0xFFE3) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Control_L");
	FAIL;
#endif

#ifdef XK_Control_R
	if(test("XK_Control_R", XK_Control_R, 0xFFE4) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Control_R");
	FAIL;
#endif

#ifdef XK_Caps_Lock
	if(test("XK_Caps_Lock", XK_Caps_Lock, 0xFFE5) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Caps_Lock");
	FAIL;
#endif

#ifdef XK_Shift_Lock
	if(test("XK_Shift_Lock", XK_Shift_Lock, 0xFFE6) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Shift_Lock");
	FAIL;
#endif

#ifdef XK_Meta_L
	if(test("XK_Meta_L", XK_Meta_L, 0xFFE7) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Meta_L");
	FAIL;
#endif

#ifdef XK_Meta_R
	if(test("XK_Meta_R", XK_Meta_R, 0xFFE8) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Meta_R");
	FAIL;
#endif

#ifdef XK_Alt_L
	if(test("XK_Alt_L", XK_Alt_L, 0xFFE9) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Alt_L");
	FAIL;
#endif

#ifdef XK_Alt_R
	if(test("XK_Alt_R", XK_Alt_R, 0xFFEA) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Alt_R");
	FAIL;
#endif

#ifdef XK_Super_L
	if(test("XK_Super_L", XK_Super_L, 0xFFEB) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Super_L");
	FAIL;
#endif

#ifdef XK_Super_R
	if(test("XK_Super_R", XK_Super_R, 0xFFEC) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Super_R");
	FAIL;
#endif

#ifdef XK_Hyper_L
	if(test("XK_Hyper_L", XK_Hyper_L, 0xFFED) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Hyper_L");
	FAIL;
#endif

#ifdef XK_Hyper_R
	if(test("XK_Hyper_R", XK_Hyper_R, 0xFFEE) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Hyper_R");
	FAIL;
#endif

#ifdef XK_Delete
	if(test("XK_Delete", XK_Delete, 0xFFFF) == 0)
		FAIL;
	else
		CHECK;
#else
	reporterr("XK_Delete");
	FAIL;
#endif


	CHECKPASS(148);
}
