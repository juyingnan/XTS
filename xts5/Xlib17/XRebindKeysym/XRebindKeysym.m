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
>># File: xts5/tset/Xlib17/XRebindKeysym/XRebindKeysym.m
>># 
>># Description:
>># 	Tests for XRebindKeysym()
>># 
>># Modifications:
>># $Log: rbndkysym.m,v $
>># Revision 1.2  2005-11-03 08:43:10  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:23  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:34:50  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:57:14  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:26:07  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:22:40  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.1  1996/05/09 21:06:26  andy
>># Fixed keysymdef include
>>#
>># Revision 4.0  1995/12/15  09:11:36  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:14:18  andy
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
>>TITLE XRebindKeysym Xlib17
void
XRebindKeysym(display, keysym, list, mod_count, string, bytes_string)
Display		*display = Dsp;
KeySym		keysym;
KeySym		*list;
int		mod_count;
unsigned char	*string;
int		bytes_string;
>>EXTERN

/* Arbitary keysyms for use as modifiers */
#define	MODKS1	0x12
#define	MODKS2	0x45

#define XK_LATIN1
#include    "X11/keysymdef.h"
#undef XK_LATIN1

#define	MAXRES	256	/* Maximum length of bound string */

>>#
>># The assertion category should be B. The assertion cannot be reliably 
>># tested because of the implementation defined treatment of modifiers.
>># XSetModifierMapping() is not guaranteed to be able to set 
>># the modifiers required for the test.
>># DPJ Cater 3/4/92
>>#
>>ASSERTION Good B 3
A call to xname rebinds the meaning of the
.A keysym
argument 
for use in XLookupString
to the
.A bytes_string
length
.A string
and to use the
.A mod_count
modifiers specified by the
.A list
argument.
>>STRATEGY
Set map between keysyms that will be used and keycodes.
Open new connection to get refreshed mappings.
Bind the keysym XK_A to a string using xname.
Bind the keysym XK_A with modifiers to a second string using xname.
Obtain the keycode bound to the XK_A keysym using XKeysymToKeycode.
Obtain the binding for the keycode without modifiers using XLookupString.
Verify that the keysym is correctly bound to the string astring.
Obtain the binding for the keycode with modifiers using XLookupString.
Verify that the keysym is correctly bound to the string modstring.
>>CODE
XKeyEvent	ev;
char	*astring = "Bound String";
char	*modstring = "String to bind to modified key";
static char	rstring[MAXRES] = "UninitializedBoundString."; 
int		bb;
KeySym	ksr;
KeySym	modlist[5];
KeySym	keylist[6];
XModifierKeymap	*origmap;
XModifierKeymap	*modmap;
KeySym	*origkeymap;
int 	minkc, maxkc;
int 	kpk;

	/*
	 * Save old keyboard map.  Map the keysyms that we want to use
	 * to the first available keycodes.
	 */
	XDisplayKeycodes(display, &minkc, &maxkc);
	origkeymap = XGetKeyboardMapping(display, minkc, maxkc-minkc+1, &kpk);
	keylist[0] = MODKS1;
	keylist[1] = MODKS1;
	keylist[2] = MODKS2;
	keylist[3] = MODKS2;
	keylist[4] = XK_A;
	keylist[5] = XK_A;
	XChangeKeyboardMapping(display, minkc, 2, keylist, 3);

	origmap = XGetModifierMapping(display);

	/*
	 * Set up a modifier mapping to use the modifier keysyms that we are
	 * going to use.
	 */
	modmap = XNewModifiermap(0);
	modmap = XInsertModifiermapEntry(modmap, minkc, ShiftMapIndex);
	modmap = XInsertModifiermapEntry(modmap, minkc+1, Mod1MapIndex);
	if( XSetModifierMapping(display, modmap) != MappingSuccess) {
		report("XSetModifierMapping did not return MappingSuccess");
		UNTESTED;
		/*
		 * Attempt to reset the state of the keyboard.
		 */
		XSetModifierMapping(display, origmap);
		XChangeKeyboardMapping(display, minkc, kpk, origkeymap,
			maxkc-minkc+1);
		return;
	} else
		CHECK;

	/*
	 * Need to refresh the display structure mappings, we just open a new
	 * connection and use that.
	 */
	display = opendisplay();

	/*
	 * Set up a rebinding for A (unshifted)
	 */
	keysym = XK_A;
	list = (KeySym *) NULL;
	mod_count = 0;
	string = (unsigned char *)astring;
	bytes_string = strlen((char *)string)+1;
	XCALL;

	/*
	 * Set up a rebinding for Shift Mod1 A.
	 */
	modlist[0] = MODKS1;
	modlist[1] = MODKS2;

	keysym = XK_A;
	list = modlist;
	mod_count = 2;
	string = (unsigned char *)modstring;
	bytes_string = strlen((char *)string)+1;
	XCALL;

	/*
	 * Check the unmodified case.
	 */
	ev.display = display;
	ev.keycode = XKeysymToKeycode(display, XK_A);
	debug(1, "code=%d", ev.keycode);
	ev.state = 0;
	XLookupString(&ev, rstring, MAXRES, &ksr, (XComposeStatus *) NULL);
	trace("String returned >%s<", rstring);

	if (strcmp(astring,  rstring) != 0) {
		report("%s() bound XK_A to \"%s\" instead of \"%s\".", TestName, rstring, astring);
		FAIL;
	} else
		CHECK;


	/*
	 * Now check the modified case.
	 */
	ev.display = display;
	ev.state = ShiftMask|Mod1Mask;
	XLookupString(&ev, rstring, MAXRES, &ksr, (XComposeStatus *) NULL);
	trace("String returned >%s<", rstring);

	if (strcmp(modstring,  rstring) != 0) {
		report("%s() bound XK_A to \"%s\" instead of \"%s\".", TestName, rstring, modstring);
		FAIL;
	} else
		CHECK;

	/*
	 * Attempt to reset the state of the keyboard.
	 */
	XSetModifierMapping(display, origmap);
	XChangeKeyboardMapping(display, minkc, kpk, origkeymap, maxkc-minkc+1);

	CHECKPASS(3);
>>ASSERTION Good B 1
When
.A keysym
does not exist, then
a call to xname rebinds the meaning of the
.A keysym
argument.
