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
>># File: xts5/XI/gtdvcmdfrm/gtdvcmdfrm.m
>># 
>># Description:
>># 	Tests for XGetDeviceModifierMapping()
>># 
>># Modifications:
>># $Log: gtdvmmap.m,v $
>># Revision 1.2  2005-11-03 08:42:07  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:14  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:32:02  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:52:15  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:23:36  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:20:08  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:03:51  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:01:54  andy
>># Prepare for GA Release
>>#
/*
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

Copyright 1993 by the Hewlett-Packard Company.

Copyright 1990, 1991 UniSoft Group Limited.

Permission to use, copy, modify, distribute, and sell this software and
its documentation for any purpose is hereby granted without fee,
provided that the above copyright notice appear in all copies and that
both that copyright notice and this permission notice appear in
supporting documentation, and that the names of HP, and UniSoft not be
used in advertising or publicity pertaining to distribution of the
software without specific, written prior permission.  HP, and UniSoft
make no representations about the suitability of this software for any
purpose.  It is provided "as is" without express or implied warranty.
*/
>>TITLE XGetDeviceModifierMapping XI
XModifierKeymap	*
xname
Display	*display = Dsp;
XDevice *device;
>>EXTERN
extern ExtDeviceInfo Devs;

>>ASSERTION Good B 3
A call to GetDeviceModifierMapping returns a pointer to a newly
created XModifierKeymap structure that contains the KeyCodes
being used as modifiers and the structure can be freed  with
XFreeModifiermap.
>>STRATEGY
Call xname to get the current map.
Free map with XFreeModifiermap.
>>CODE
XModifierKeymap	*mkmp;
extern struct	valname	S_modifier[];
extern int 	NS_modifier;
int 	mod;
int 	set;

	if (!Setup_Extension_DeviceInfo(KeyMask | ModMask))
	    {
	    untested("%s: No input extension device without keys.\n", TestName);
	    return;
	    }
	device = Devs.Mod;
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
When only zero values appear in the set	for  any  modifier,
then that modifier is disabled.
>>STRATEGY
If extension available and at least one button:
  Create a window.
  Get two copies of current modifier map using xname, save one.
  Zero keycodes for Shift.
  Call XSetDeviceModiferMapping to set map to that with zeroed Shift row.
  Set passive device grab on AnyButton with Shift modifier for window.
  Warp pointer into window.
  For all keycodes
    Simulate key press.
    Simulate Button1 press.
    Check that device grab not active (i.e. key has not acted as Shift modifier).
    Release key and button.
  Restore map to saved version.
  Free maps.
else
  report untested.
>>EXTERN
static int dgrabbed(display, dev, win)
Display *display;
XDevice *dev;
Window win;
{
int ret;
Display *client1;

/* Create client1, without causing resource registration. */
	if (config.display == NULL) {
		delete("config.display not set");
		return;
	}
	client1 = XOpenDisplay(config.display);
	if (client1 == NULL) {
		delete("Couldn't create client1.");
		return;
	}
	ret = XGrabDevice(client1, dev, win, True, 0, NULL,
	    GrabModeAsync, GrabModeAsync, CurrentTime);
	if (ret == AlreadyGrabbed)
	    {
	    XCloseDisplay(client1);
	    return(True);
	    }
	else
	    {
	    XUngrabDevice(client1, dev, CurrentTime);
	    XCloseDisplay(client1);
	    return(False);
	    }
}
>>CODE
Window win;
Display *client2;
int minkc, maxkc, numkeys;
XModifierKeymap *map;
XModifierKeymap *savemap;
int k;
int i;
int row;
int non_zero = 0;

	if (!Setup_Extension_DeviceInfo(KeyMask | ModMask | BtnMask))
	    {
	    untested("%s: Required input extension devices not present.\n", TestName);
	    return;
	    }
	if (noext(1))
	    return;
	else
	    CHECK;
	devicerelkeys(Devs.Mod);
	devicerelbuttons(Devs.Button);
	win = defwin(display);
	client2 = opendisplay();

	MinMaxKeys(display, Devs.Mod, &minkc, &maxkc, &numkeys);
	device = Devs.Mod;
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
	if (XSetDeviceModifierMapping(display, Devs.Mod, map) != MappingSuccess || isdeleted()) {
		delete("Could not set new mapping with all zeroes for Shift.");
		XSetDeviceModifierMapping(display, Devs.Mod, savemap);
		XFreeModifiermap(map);
		XFreeModifiermap(savemap);
		return;
	} else
		CHECK;
	XGrabDeviceButton(display, Devs.Button, AnyButton, ShiftMask, Devs.Mod, win, False, 0, NULL, GrabModeAsync, GrabModeAsync);
	if (isdeleted()) {
		delete("Could not set passive button grab.");
		XSetDeviceModifierMapping(display, Devs.Mod, savemap);
		XFreeModifiermap(map);
		XFreeModifiermap(savemap);
		return;
	} else
		CHECK;
	if (dgrabbed(client2, Devs.Button, win)) {
		delete("Passive button grab erroneously triggered.");
		XSetDeviceModifierMapping(display, Devs.Mod, savemap);
		XFreeModifiermap(map);
		XFreeModifiermap(savemap);
		return;
	} else
		CHECK;
	warppointer(display, win, 2,2); /* dgrabbed restores pointer */
	for(k=minkc; k <= maxkc; k++) {
		devicekeypress(display, Devs.Mod, k);
		devicebuttonpress(display, Devs.Button, Button1);
		if (dgrabbed(client2, Devs.Button, win)) {
			report("Despite Shift being disabled keycode %d acted like Shift modifier.", k);
			FAIL;
		} else
			CHECK;
		devicekeyrel(display, Devs.Mod, k);
		devicebuttonrel(display, Devs.Button, Button1);
		devicerelkeys(Devs.Mod);
		devicerelbuttons(Devs.Button);
	}

	XUngrabDeviceButton(display, Devs.Button, AnyButton, ShiftMask, Devs.Mod, win);
	XSetDeviceModifierMapping(display, Devs.Mod, savemap);
	XFreeModifiermap(map);
	XFreeModifiermap(savemap);
	CHECKPASS(5 + maxkc - minkc + 1);

>>ASSERTION Bad B 3
If a device with no keys is specified, a BadMatch error occurs.
>>STRATEGY
Specifiy a device with no keys.
>>CODE BadMatch
XModifierKeymap *ret;

	if (!Setup_Extension_DeviceInfo(NKeysMask))
	    {
	    untested("%s: No input extension device without keys.\n", TestName);
	    return;
	    }
	device = Devs.NoKeys;
	ret = XCALL;

	if (geterr() == BadMatch)
		PASS;
	else
		FAIL;
>>ASSERTION Bad B 3
If an invalid device is specified, a BadDevice error occurs.
>>STRATEGY
Specifiy an invalid device.
>>CODE baddevice
XModifierKeymap *ret;
int baddevice;
XDevice bogus;
int ximajor, first, err;

	if (!XQueryExtension (display, INAME, &ximajor, &first, &err))
	    {
	    untested("%s: Input extension not supported.\n", TestName);
	    return;
	    }

	BadDevice(display, baddevice);
	bogus.device_id = -1;
	device = &bogus;
	ret = XCALL;

	if (geterr() == baddevice)
		PASS;
	else
		FAIL;
