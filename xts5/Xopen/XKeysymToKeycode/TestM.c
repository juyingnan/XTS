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
* File: xts5/Xopen/XKeysymToKeycode/TestM.c
* 
* Description:
* 	Tests for XKeysymToKeycode()
* 
* Modifications:
* $Log: TestM.c,v $
* Revision 1.2  2005-11-03 08:44:00  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:40  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:35:48  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:58:29  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:27:02  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:23:35  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.1  1996/05/09 21:17:34  andy
* Fixed X includes
*
* Revision 4.0  1995/12/15  09:14:17  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  01:17:40  andy
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
#define XK_MISCELLANY
#include	<X11/keysymdef.h>
#undef XK_MISCELLANY

kysymtcdM()
{ 
int 	pass = 0, fail = 0;

	XDisplayKeycodes(Dsp, &minkc, &maxkc);
	XGetKeyboardMapping(Dsp, (KeyCode)minkc, 1, &keysyms_per_keycode);

#ifdef XK_BackSpace
	if(test(XK_BackSpace, "BackSpace") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("BackSpace");
	FAIL;
#endif

#ifdef XK_Tab
	if(test(XK_Tab, "Tab") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Tab");
	FAIL;
#endif

#ifdef XK_Linefeed
	if(test(XK_Linefeed, "Linefeed") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Linefeed");
	FAIL;
#endif

#ifdef XK_Clear
	if(test(XK_Clear, "Clear") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Clear");
	FAIL;
#endif

#ifdef XK_Return
	if(test(XK_Return, "Return") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Return");
	FAIL;
#endif

#ifdef XK_Pause
	if(test(XK_Pause, "Pause") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Pause");
	FAIL;
#endif

#ifdef XK_Scroll_Lock
	if(test(XK_Scroll_Lock, "Scroll_Lock") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Scroll_Lock");
	FAIL;
#endif

#ifdef XK_Escape
	if(test(XK_Escape, "Escape") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Escape");
	FAIL;
#endif

#ifdef XK_Multi_key
	if(test(XK_Multi_key, "Multi_key") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Multi_key");
	FAIL;
#endif

#ifdef XK_Kanji
	if(test(XK_Kanji, "Kanji") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Kanji");
	FAIL;
#endif

#ifdef XK_Muhenkan
	if(test(XK_Muhenkan, "Muhenkan") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Muhenkan");
	FAIL;
#endif

#ifdef XK_Henkan
	if(test(XK_Henkan, "Henkan") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Henkan");
	FAIL;
#endif

#ifdef XK_Henkan_Mode
	if(test(XK_Henkan_Mode, "Henkan_Mode") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Henkan_Mode");
	FAIL;
#endif

#ifdef XK_Romaji
	if(test(XK_Romaji, "Romaji") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Romaji");
	FAIL;
#endif

#ifdef XK_Hiragana
	if(test(XK_Hiragana, "Hiragana") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Hiragana");
	FAIL;
#endif

#ifdef XK_Katakana
	if(test(XK_Katakana, "Katakana") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Katakana");
	FAIL;
#endif

#ifdef XK_Hiragana_Katakana
	if(test(XK_Hiragana_Katakana, "Hiragana_Katakana") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Hiragana_Katakana");
	FAIL;
#endif

#ifdef XK_Zenkaku
	if(test(XK_Zenkaku, "Zenkaku") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Zenkaku");
	FAIL;
#endif

#ifdef XK_Hankaku
	if(test(XK_Hankaku, "Hankaku") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Hankaku");
	FAIL;
#endif

#ifdef XK_Zenkaku_Hankaku
	if(test(XK_Zenkaku_Hankaku, "Zenkaku_Hankaku") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Zenkaku_Hankaku");
	FAIL;
#endif

#ifdef XK_Touroku
	if(test(XK_Touroku, "Touroku") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Touroku");
	FAIL;
#endif

#ifdef XK_Massyo
	if(test(XK_Massyo, "Massyo") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Massyo");
	FAIL;
#endif

#ifdef XK_Kana_Lock
	if(test(XK_Kana_Lock, "Kana_Lock") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Kana_Lock");
	FAIL;
#endif

#ifdef XK_Kana_Shift
	if(test(XK_Kana_Shift, "Kana_Shift") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Kana_Shift");
	FAIL;
#endif

#ifdef XK_Eisu_Shift
	if(test(XK_Eisu_Shift, "Eisu_Shift") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Eisu_Shift");
	FAIL;
#endif

#ifdef XK_Eisu_toggle
	if(test(XK_Eisu_toggle, "Eisu_toggle") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Eisu_toggle");
	FAIL;
#endif

#ifdef XK_Home
	if(test(XK_Home, "Home") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Home");
	FAIL;
#endif

#ifdef XK_Left
	if(test(XK_Left, "Left") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Left");
	FAIL;
#endif

#ifdef XK_Up
	if(test(XK_Up, "Up") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Up");
	FAIL;
#endif

#ifdef XK_Right
	if(test(XK_Right, "Right") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Right");
	FAIL;
#endif

#ifdef XK_Down
	if(test(XK_Down, "Down") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Down");
	FAIL;
#endif

#ifdef XK_Prior
	if(test(XK_Prior, "Prior") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Prior");
	FAIL;
#endif

#ifdef XK_Next
	if(test(XK_Next, "Next") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Next");
	FAIL;
#endif

#ifdef XK_End
	if(test(XK_End, "End") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("End");
	FAIL;
#endif

#ifdef XK_Begin
	if(test(XK_Begin, "Begin") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Begin");
	FAIL;
#endif

#ifdef XK_Select
	if(test(XK_Select, "Select") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Select");
	FAIL;
#endif

#ifdef XK_Print
	if(test(XK_Print, "Print") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Print");
	FAIL;
#endif

#ifdef XK_Execute
	if(test(XK_Execute, "Execute") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Execute");
	FAIL;
#endif

#ifdef XK_Insert
	if(test(XK_Insert, "Insert") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Insert");
	FAIL;
#endif

#ifdef XK_Undo
	if(test(XK_Undo, "Undo") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Undo");
	FAIL;
#endif

#ifdef XK_Redo
	if(test(XK_Redo, "Redo") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Redo");
	FAIL;
#endif

#ifdef XK_Menu
	if(test(XK_Menu, "Menu") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Menu");
	FAIL;
#endif

#ifdef XK_Find
	if(test(XK_Find, "Find") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Find");
	FAIL;
#endif

#ifdef XK_Cancel
	if(test(XK_Cancel, "Cancel") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Cancel");
	FAIL;
#endif

#ifdef XK_Help
	if(test(XK_Help, "Help") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Help");
	FAIL;
#endif

#ifdef XK_Break
	if(test(XK_Break, "Break") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Break");
	FAIL;
#endif

#ifdef XK_Mode_switch
	if(test(XK_Mode_switch, "Mode_switch") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Mode_switch");
	FAIL;
#endif

#ifdef XK_script_switch
	if(test(XK_script_switch, "script_switch") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("script_switch");
	FAIL;
#endif

#ifdef XK_Num_Lock
	if(test(XK_Num_Lock, "Num_Lock") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Num_Lock");
	FAIL;
#endif

#ifdef XK_KP_Space
	if(test(XK_KP_Space, "KP_Space") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("KP_Space");
	FAIL;
#endif

#ifdef XK_KP_Tab
	if(test(XK_KP_Tab, "KP_Tab") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("KP_Tab");
	FAIL;
#endif

#ifdef XK_KP_Enter
	if(test(XK_KP_Enter, "KP_Enter") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("KP_Enter");
	FAIL;
#endif

#ifdef XK_KP_F1
	if(test(XK_KP_F1, "KP_F1") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("KP_F1");
	FAIL;
#endif

#ifdef XK_KP_F2
	if(test(XK_KP_F2, "KP_F2") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("KP_F2");
	FAIL;
#endif

#ifdef XK_KP_F3
	if(test(XK_KP_F3, "KP_F3") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("KP_F3");
	FAIL;
#endif

#ifdef XK_KP_F4
	if(test(XK_KP_F4, "KP_F4") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("KP_F4");
	FAIL;
#endif

#ifdef XK_KP_Multiply
	if(test(XK_KP_Multiply, "KP_Multiply") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("KP_Multiply");
	FAIL;
#endif

#ifdef XK_KP_Add
	if(test(XK_KP_Add, "KP_Add") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("KP_Add");
	FAIL;
#endif

#ifdef XK_KP_Separator
	if(test(XK_KP_Separator, "KP_Separator") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("KP_Separator");
	FAIL;
#endif

#ifdef XK_KP_Subtract
	if(test(XK_KP_Subtract, "KP_Subtract") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("KP_Subtract");
	FAIL;
#endif

#ifdef XK_KP_Decimal
	if(test(XK_KP_Decimal, "KP_Decimal") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("KP_Decimal");
	FAIL;
#endif

#ifdef XK_KP_Divide
	if(test(XK_KP_Divide, "KP_Divide") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("KP_Divide");
	FAIL;
#endif

#ifdef XK_KP_0
	if(test(XK_KP_0, "KP_0") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("KP_0");
	FAIL;
#endif

#ifdef XK_KP_1
	if(test(XK_KP_1, "KP_1") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("KP_1");
	FAIL;
#endif

#ifdef XK_KP_2
	if(test(XK_KP_2, "KP_2") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("KP_2");
	FAIL;
#endif

#ifdef XK_KP_3
	if(test(XK_KP_3, "KP_3") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("KP_3");
	FAIL;
#endif

#ifdef XK_KP_4
	if(test(XK_KP_4, "KP_4") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("KP_4");
	FAIL;
#endif

#ifdef XK_KP_5
	if(test(XK_KP_5, "KP_5") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("KP_5");
	FAIL;
#endif

#ifdef XK_KP_6
	if(test(XK_KP_6, "KP_6") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("KP_6");
	FAIL;
#endif

#ifdef XK_KP_7
	if(test(XK_KP_7, "KP_7") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("KP_7");
	FAIL;
#endif

#ifdef XK_KP_8
	if(test(XK_KP_8, "KP_8") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("KP_8");
	FAIL;
#endif

#ifdef XK_KP_9
	if(test(XK_KP_9, "KP_9") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("KP_9");
	FAIL;
#endif

#ifdef XK_KP_Equal
	if(test(XK_KP_Equal, "KP_Equal") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("KP_Equal");
	FAIL;
#endif

#ifdef XK_F1
	if(test(XK_F1, "F1") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("F1");
	FAIL;
#endif

#ifdef XK_F2
	if(test(XK_F2, "F2") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("F2");
	FAIL;
#endif

#ifdef XK_F3
	if(test(XK_F3, "F3") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("F3");
	FAIL;
#endif

#ifdef XK_F4
	if(test(XK_F4, "F4") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("F4");
	FAIL;
#endif

#ifdef XK_F5
	if(test(XK_F5, "F5") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("F5");
	FAIL;
#endif

#ifdef XK_F6
	if(test(XK_F6, "F6") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("F6");
	FAIL;
#endif

#ifdef XK_F7
	if(test(XK_F7, "F7") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("F7");
	FAIL;
#endif

#ifdef XK_F8
	if(test(XK_F8, "F8") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("F8");
	FAIL;
#endif

#ifdef XK_F9
	if(test(XK_F9, "F9") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("F9");
	FAIL;
#endif

#ifdef XK_F10
	if(test(XK_F10, "F10") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("F10");
	FAIL;
#endif

#ifdef XK_F11
	if(test(XK_F11, "F11") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("F11");
	FAIL;
#endif

#ifdef XK_L1
	if(test(XK_L1, "L1") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("L1");
	FAIL;
#endif

#ifdef XK_F12
	if(test(XK_F12, "F12") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("F12");
	FAIL;
#endif

#ifdef XK_L2
	if(test(XK_L2, "L2") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("L2");
	FAIL;
#endif

#ifdef XK_F13
	if(test(XK_F13, "F13") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("F13");
	FAIL;
#endif

#ifdef XK_L3
	if(test(XK_L3, "L3") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("L3");
	FAIL;
#endif

#ifdef XK_F14
	if(test(XK_F14, "F14") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("F14");
	FAIL;
#endif

#ifdef XK_L4
	if(test(XK_L4, "L4") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("L4");
	FAIL;
#endif

#ifdef XK_F15
	if(test(XK_F15, "F15") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("F15");
	FAIL;
#endif

#ifdef XK_L5
	if(test(XK_L5, "L5") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("L5");
	FAIL;
#endif

#ifdef XK_F16
	if(test(XK_F16, "F16") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("F16");
	FAIL;
#endif

#ifdef XK_L6
	if(test(XK_L6, "L6") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("L6");
	FAIL;
#endif

#ifdef XK_F17
	if(test(XK_F17, "F17") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("F17");
	FAIL;
#endif

#ifdef XK_L7
	if(test(XK_L7, "L7") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("L7");
	FAIL;
#endif

#ifdef XK_F18
	if(test(XK_F18, "F18") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("F18");
	FAIL;
#endif

#ifdef XK_L8
	if(test(XK_L8, "L8") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("L8");
	FAIL;
#endif

#ifdef XK_F19
	if(test(XK_F19, "F19") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("F19");
	FAIL;
#endif

#ifdef XK_L9
	if(test(XK_L9, "L9") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("L9");
	FAIL;
#endif

#ifdef XK_F20
	if(test(XK_F20, "F20") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("F20");
	FAIL;
#endif

#ifdef XK_L10
	if(test(XK_L10, "L10") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("L10");
	FAIL;
#endif

#ifdef XK_F21
	if(test(XK_F21, "F21") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("F21");
	FAIL;
#endif

#ifdef XK_R1
	if(test(XK_R1, "R1") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("R1");
	FAIL;
#endif

#ifdef XK_F22
	if(test(XK_F22, "F22") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("F22");
	FAIL;
#endif

#ifdef XK_R2
	if(test(XK_R2, "R2") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("R2");
	FAIL;
#endif

#ifdef XK_F23
	if(test(XK_F23, "F23") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("F23");
	FAIL;
#endif

#ifdef XK_R3
	if(test(XK_R3, "R3") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("R3");
	FAIL;
#endif

#ifdef XK_F24
	if(test(XK_F24, "F24") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("F24");
	FAIL;
#endif

#ifdef XK_R4
	if(test(XK_R4, "R4") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("R4");
	FAIL;
#endif

#ifdef XK_F25
	if(test(XK_F25, "F25") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("F25");
	FAIL;
#endif

#ifdef XK_R5
	if(test(XK_R5, "R5") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("R5");
	FAIL;
#endif

#ifdef XK_F26
	if(test(XK_F26, "F26") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("F26");
	FAIL;
#endif

#ifdef XK_R6
	if(test(XK_R6, "R6") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("R6");
	FAIL;
#endif

#ifdef XK_F27
	if(test(XK_F27, "F27") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("F27");
	FAIL;
#endif

#ifdef XK_R7
	if(test(XK_R7, "R7") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("R7");
	FAIL;
#endif

#ifdef XK_F28
	if(test(XK_F28, "F28") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("F28");
	FAIL;
#endif

#ifdef XK_R8
	if(test(XK_R8, "R8") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("R8");
	FAIL;
#endif

#ifdef XK_F29
	if(test(XK_F29, "F29") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("F29");
	FAIL;
#endif

#ifdef XK_R9
	if(test(XK_R9, "R9") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("R9");
	FAIL;
#endif

#ifdef XK_F30
	if(test(XK_F30, "F30") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("F30");
	FAIL;
#endif

#ifdef XK_R10
	if(test(XK_R10, "R10") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("R10");
	FAIL;
#endif

#ifdef XK_F31
	if(test(XK_F31, "F31") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("F31");
	FAIL;
#endif

#ifdef XK_R11
	if(test(XK_R11, "R11") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("R11");
	FAIL;
#endif

#ifdef XK_F32
	if(test(XK_F32, "F32") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("F32");
	FAIL;
#endif

#ifdef XK_R12
	if(test(XK_R12, "R12") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("R12");
	FAIL;
#endif

#ifdef XK_F33
	if(test(XK_F33, "F33") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("F33");
	FAIL;
#endif

#ifdef XK_R13
	if(test(XK_R13, "R13") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("R13");
	FAIL;
#endif

#ifdef XK_F34
	if(test(XK_F34, "F34") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("F34");
	FAIL;
#endif

#ifdef XK_R14
	if(test(XK_R14, "R14") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("R14");
	FAIL;
#endif

#ifdef XK_F35
	if(test(XK_F35, "F35") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("F35");
	FAIL;
#endif

#ifdef XK_R15
	if(test(XK_R15, "R15") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("R15");
	FAIL;
#endif

#ifdef XK_Shift_L
	if(test(XK_Shift_L, "Shift_L") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Shift_L");
	FAIL;
#endif

#ifdef XK_Shift_R
	if(test(XK_Shift_R, "Shift_R") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Shift_R");
	FAIL;
#endif

#ifdef XK_Control_L
	if(test(XK_Control_L, "Control_L") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Control_L");
	FAIL;
#endif

#ifdef XK_Control_R
	if(test(XK_Control_R, "Control_R") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Control_R");
	FAIL;
#endif

#ifdef XK_Caps_Lock
	if(test(XK_Caps_Lock, "Caps_Lock") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Caps_Lock");
	FAIL;
#endif

#ifdef XK_Shift_Lock
	if(test(XK_Shift_Lock, "Shift_Lock") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Shift_Lock");
	FAIL;
#endif

#ifdef XK_Meta_L
	if(test(XK_Meta_L, "Meta_L") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Meta_L");
	FAIL;
#endif

#ifdef XK_Meta_R
	if(test(XK_Meta_R, "Meta_R") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Meta_R");
	FAIL;
#endif

#ifdef XK_Alt_L
	if(test(XK_Alt_L, "Alt_L") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Alt_L");
	FAIL;
#endif

#ifdef XK_Alt_R
	if(test(XK_Alt_R, "Alt_R") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Alt_R");
	FAIL;
#endif

#ifdef XK_Super_L
	if(test(XK_Super_L, "Super_L") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Super_L");
	FAIL;
#endif

#ifdef XK_Super_R
	if(test(XK_Super_R, "Super_R") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Super_R");
	FAIL;
#endif

#ifdef XK_Hyper_L
	if(test(XK_Hyper_L, "Hyper_L") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Hyper_L");
	FAIL;
#endif

#ifdef XK_Hyper_R
	if(test(XK_Hyper_R, "Hyper_R") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Hyper_R");
	FAIL;
#endif

#ifdef XK_Delete
	if(test(XK_Delete, "Delete") == 1)
		CHECK;
	else
		FAIL;
#else
	reporterr("Delete");
	FAIL;
#endif

	CHECKPASS(148);
}
