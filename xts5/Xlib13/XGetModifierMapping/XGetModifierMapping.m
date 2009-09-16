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

Copyright (c) Applied Testing and Technology, Inc. 1995
All Rights Reserved.

>># Project: VSW5
>># 
>># File: xts5/Xlib13/XGetModifierMapping/XGetModifierMapping.m
>># 
>># Description:
>># 	Tests for XGetModifierMapping()
>># 
>># Modifications:
>># $Log: gtmdfrmppn.m,v $
>># Revision 1.2  2005-11-03 08:42:40  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:19  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:33:40  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:55:21  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:25:03  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:21:35  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:08:30  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:09:46  andy
>># Prepare for GA Release
>>#
/*
Portions of this software are based on Xlib and X Protocol Test Suite.
We have used this material under the terms of its copyright, which grants
free use, subject to the conditions below.  Note however that those
portions of this software that are based on the original Test Suite have
been significantly revised and that all such revisions are copyright (c)
1995 Applied Testing and Technology, Inc.  Insomuch as the proprietary
revisions cannot be separated from the freely copyable material, the net
result is that use of this software is governed by the ApTest copyright.

Copyright (c) 1990, 1991  X Consortium

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
X CONSORTIUM BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

Except as contained in this notice, the name of the X Consortium shall not be
used in advertising or otherwise to promote the sale, use or other dealings
in this Software without prior written authorization from the X Consortium.

Permission to use, copy, modify, distribute, and sell this software and
its documentation for any purpose is hereby granted without fee,
provided that the above copyright notice appear in all copies and that
both that copyright notice and this permission notice appear in
supporting documentation, and that the name of UniSoft not be
used in advertising or publicity pertaining to distribution of the
software without specific, written prior permission.  UniSoft
makes no representations about the suitability of this software for any
purpose.  It is provided "as is" without express or implied warranty.
*/
>>TITLE XGetModifierMapping Xlib13
XModifierKeymap *
xname
Display	*display = Dsp;
>>ASSERTION Good A
A call to xname returns a pointer to a newly created
.S XModifierKeymap
structure that contains the KeyCodes being used as modifiers
and the structure can be freed with
.F XFreeModifiermap .
>>STRATEGY
Call xname to get the current map.
Free map with XFreeModifiermap.
>>CODE
XModifierKeymap	*mkmp;
extern struct	valname	S_modifier[];
extern int 	NS_modifier;
int 	mod;
int 	set;

	mkmp = XCALL;

	for (mod = 0; mod < NS_modifier; mod++) {
		trace("modifier %s:", S_modifier[mod].name);
		for (set = 0; set < mkmp->max_keypermod; set++) {
			trace("  0x%x", mkmp->modifiermap[set+mod*mkmp->max_keypermod]);
		}
	}

	XFreeModifiermap(mkmp);

        CHECK;  /* Merely check and record that we reach this point. */
        CHECKPASS(1);

>>ASSERTION Good B 3
When only zero values appear in the set for any modifier,
then that modifier is disabled.
>>STRATEGY
If extension available and at least one button:
  Create a window.
  Get two copies of current modifier map using xname, save one.
  Zero keycodes for Shift.
  Call XSetModiferMapping to set map to that with zeroed Shift row.
  Set passive pointer grab on AnyButton with Shift modifier for window.
  Warp pointer into window.
  For all keycodes
    Simulate key press.
    Simulate Button1 press.
    Check that pointer grab not active (i.e. key has not acted as Shift modifier).
    Release key and button.
  Restore map to saved version.
  Free maps.
else
  report untested.
>>EXTERN
static int pgrabbed(display, win)
Display *display;
Window win;
{
	PointerPlace	*p;
	XEvent		ev;
	int		result;

	XSync(display, True);
	XSelectInput(display, win, PointerMotionMask);
	p = warppointer(display, win, 0,0);
	(void) warppointer(display, win, 10,10);
	(void) warppointer(display, p->oroot, p->ox, p->oy);
	result = (getevent(display, &ev) == 0);
	XSync(display, True);
	return result;
}
>>CODE
Window win;
Display *client2;
int minkc, maxkc;
XModifierKeymap *map;
XModifierKeymap *savemap;
int k;
int i;
int row;
int non_zero = 0;

	if (noext(1))
		return;
	else
		CHECK;
	win = defwin(display);
	client2 = opendisplay();
	XDisplayKeycodes(display, &minkc, &maxkc);
	savemap = XCALL;
	map = XCALL;
	if (isdeleted() || geterr() != Success || !map || !savemap) {
		delete("Could not get initial modifier key map.");
		return;
	} else
		CHECK;
	row = ShiftMapIndex * map->max_keypermod;
	for (i=0; i<map->max_keypermod; i++) {
	    if (map->modifiermap[ row+i ]) {
		trace("Shift had keycode %d.", map->modifiermap[ row+i ]);
		non_zero++;
		map->modifiermap[ row+i ] = 0;
	    }
	}
	trace("Shift had %d keycodes.", non_zero);
	if (XSetModifierMapping(display, map) != MappingSuccess || isdeleted()) {
		delete("Could not set new mapping with all zeroes for Shift.");
		XSetModifierMapping(display, savemap);
		XFreeModifiermap(map);
		XFreeModifiermap(savemap);
		return;
	} else
		CHECK;
	XGrabButton(display, AnyButton, ShiftMask, win, False, 0, GrabModeAsync, GrabModeAsync, None, None);
	if (isdeleted()) {
		delete("Could not set passive button grab.");
		XSetModifierMapping(display, savemap);
		XFreeModifiermap(map);
		XFreeModifiermap(savemap);
		return;
	} else
		CHECK;
	if (pgrabbed(client2, win)) {
		delete("Passive button grab erroneously triggered.");
		XSetModifierMapping(display, savemap);
		XFreeModifiermap(map);
		XFreeModifiermap(savemap);
		return;
	} else
		CHECK;
	(void) warppointer(display, win, 2,2); /* pgrabbed restores pointer */
	for(k=minkc; k <= maxkc; k++) {
		keypress(display, k);
		buttonpress(display, Button1);
		if (pgrabbed(client2, win)) {
			report("Despite Shift being disabled keycode %d acted like Shift modifier.", k);
			FAIL;
		} else
			CHECK;
		relalldev();
	}

	XUngrabButton(display, AnyButton, AnyModifier, win);
	XSetModifierMapping(display, savemap);
	XFreeModifiermap(map);
	XFreeModifiermap(savemap);

	CHECKPASS(5 + (maxkc - minkc + 1));
