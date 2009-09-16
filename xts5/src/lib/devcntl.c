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
* Copyright Applied Testing and Technology Inc. 1995
* All rights reserved
*
* Project: VSW5
*
* File:	xts5/src/lib/devcntl.c
*
* Description:
*	Inout device extension test support routines
*
* Modifications:
* $Log: devcntl.c,v $
* Revision 1.2  2005-11-03 08:42:01  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:09  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:24:31  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:42:42  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:16:56  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:13:29  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.1  1996/01/25 01:57:14  andy
* Portability improvements from DEPLOY tools
*
* Revision 4.0  1995/12/15  08:42:09  tbr
* Branch point for Release 5.0.0
*
* Revision 3.2  1995/12/15  00:39:20  andy
* Prepare for GA Release
*
*/

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

Copyright 1990, 1991 by UniSoft Group Limited.

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

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include	"xtest.h"
#include	<X11/Xlib.h>
#include	<X11/Xutil.h>
#ifdef INPUTEXTENSION
#include	<X11/extensions/XInput.h>
#endif
#include	"xtestlib.h"

#define	MAX_DEVICES	9
#define	MAXBUT	256
#define	MAXKEY	256

static	struct	butsave {
	unsigned int 	button;
	Display	*disp;
} buttons[MAXBUT];
static	int 	butind;

static	struct	keysave {
	int 	key;
	Display	*disp;
} keys[MAXKEY];
static	int 	keyind;

static struct dkeysave {
	int	key;
	Display	*disp;
} dkeys[MAX_DEVICES][MAXKEY];
static 	int	dkeyind[MAX_DEVICES];

/*
 * Simulate a button press, saving the press so it can be automatically
 * released later.
 */
void
buttonpress(disp, button)
Display *disp;
unsigned int     button;
{
	if (!SimulateButtonPressEvent(disp, button)) {
		delete("XTEST extension not configured or in use");
		return;
	}
	XSync(disp, False);
	debug(1, "Button press %d", button);

	buttons[butind].disp = disp;
	buttons[butind++].button = button;
}

#ifdef INPUTEXTENSION
void
devicebuttonpress(disp, dev, button)
Display *disp;
XDevice *dev;
unsigned int     button;
{
	if (!SimulateDeviceButtonPressEvent(disp, dev, button)) {
		delete("XTEST extension not configured or in use");
		return;
	}
	XSync(disp, False);
	debug(1, "Button press %d", button);

	buttons[butind].disp = disp;
	buttons[butind++].button = button;
}
#endif

/*
 * Simulate a button release, the corresponding saved event is removed.
 */
void
buttonrel(disp, button)
Display *disp;
unsigned int     button;
{
int 	i;

	if (!SimulateButtonReleaseEvent(disp, button)) {
		delete("XTEST extension not configured or in use");
		return;
	}
	XSync(disp, False);
	debug(1, "Button release %d", button);

	/*
	 * Remove the corresponding button down.
	 */
	for (i = butind-1; i >= 0; i--) {
		if (buttons[i].button == button) {
			buttons[i].disp = 0;
			break;
		}
	}
}

#ifdef INPUTEXTENSION
void
devicebuttonrel(disp, dev, button)
Display *disp;
XDevice *dev;
unsigned int     button;
{
int 	i;

	if (!SimulateDeviceButtonReleaseEvent(disp, dev, button)) {
		delete("XTEST extension not configured or in use");
		return;
	}
	XSync(disp, False);
	debug(1, "Button release %d", button);

	/*
	 * Remove the corresponding button down.
	 */
	for (i = butind-1; i >= 0; i--) {
		if (buttons[i].button == button) {
			buttons[i].disp = 0;
			break;
		}
	}
}
#endif

/*
 * Simulate a key press, saving the event so it can be automatically
 * released later.
 */
void
keypress(disp, key)
Display *disp;
int     key;
{
	if (key == NoSymbol)
		return;

	if (!SimulateKeyPressEvent(disp, key)) {
		delete("XTEST extension not configured or in use");
		return;
	}
	XSync(disp, False);
	debug(1, "Key press %d", key);

	keys[keyind].disp = disp;
	keys[keyind++].key = key;
}

#ifdef INPUTEXTENSION
void
devicekeypress(disp, dev, key)
Display *disp;
XDevice *dev;
int     key;
{
int id = dev->device_id;

	if (key == NoSymbol)
		return;

	if (!SimulateDeviceKeyPressEvent(disp, dev, key)) {
		delete("XTEST extension not configured or in use");
		return;
	}
	XSync(disp, False);
	debug(1, "Key press %d", key);

/*
	keys[keyind].disp = disp;
	keys[keyind++].key = key;
*/
	dkeys[id][dkeyind[id]].disp = disp;
	dkeys[id][dkeyind[id]++].key = key;
}
#endif

/*
 * Simulate a key release, the corresponding saved event is removed.
 */
void
keyrel(disp, key)
Display *disp;
int     key;
{
int 	i;

	if (key == NoSymbol)
		return;
	if (!SimulateKeyReleaseEvent(disp, key)) {
		delete("XTEST extension not configured or in use");
		return;
	}
	XSync(disp, False);
	debug(1, "Key release %d", key);

	/*
	 * Remove the corresponding key down.
	 */
	for (i = keyind-1; i >= 0; i--) {
		if (keys[i].key == key) {
			keys[i].disp = 0;
			break;
		}
	}
}

#ifdef INPUTEXTENSION
void
devicekeyrel(disp, dev, key)
Display *disp;
XDevice *dev;
int     key;
{
int 	i, id=dev->device_id;

	if (key == NoSymbol)
		return;
	if (!SimulateDeviceKeyReleaseEvent(disp, dev, key)) {
		delete("XTEST extension not configured or in use");
		return;
	}
	XSync(disp, False);
	debug(1, "Key release %d", key);

	/*
	 * Remove the corresponding key down.
	 */
/*
	for (i = keyind-1; i >= 0; i--) {
		if (keys[i].key == key) {
			keys[i].disp = 0;
*/
	for (i = dkeyind[id]-1; i >= 0; i--) {
		if (dkeys[id][i].key == key) {
			dkeys[id][i].disp = 0;
			break;
		}
	}
}
#endif

/*
 * Release buttons pressed with buttonpress, in reverse order of pressing.
 */
void
relbuttons()
{
int 	i;

	for (i = butind-1; i >= 0; i--) {
		if (buttons[i].disp)
			buttonrel(buttons[i].disp, buttons[i].button);
	}
	butind = 0;
}

#ifdef INPUTEXTENSION
void
devicerelbuttons(dev)
XDevice *dev;
{
int 	i;

	for (i = butind-1; i >= 0; i--) {
		if (buttons[i].disp)
			devicebuttonrel(buttons[i].disp, dev, buttons[i].button);
	}
	butind = 0;
}
#endif

/*
 * Release keys pressed with keypress, in reverse order of pressing.
 */
void
relkeys()
{
int 	i;

	for (i = keyind-1; i >= 0; i--) {
		if (keys[i].disp)
			keyrel(keys[i].disp, keys[i].key);
	}
	keyind = 0;
}
#ifdef INPUTEXTENSION
devicerelkeys(dev)
XDevice *dev;
{
int 	i, id=dev->device_id;

/*
	for (i = keyind-1; i >= 0; i--) {
		if (keys[i].disp)
			devicekeyrel(keys[i].disp, dev, keys[i].key);
*/
	for (i = dkeyind[id]-1; i >= 0; i--) {
		if (dkeys[id][i].disp)
			devicekeyrel(dkeys[id][i].disp, dev, dkeys[id][i].key);
	}
	dkeyind[id] = 0;
}
#endif

/*
 * Release all buttons and keys, buttons first.  It doesn't matter
 * if none are currently pressed (applies to all the release functions.)
 */
void
relalldev()
{
	relbuttons();
	relkeys();
}

#define	NMODS	8	/* Number of modifiers */

static	XModifierKeymap	*origmap;
static	XModifierKeymap	*curmap;
static	XModifierKeymap	*devcurmap;

/*
 * Given the number of modifiers that you want it returns a modifier
 * key mask with that number of bits set if possible.  Each bit is
 * a valid modifier for the server.  If necessary the modifer map is
 * set up with extra keycodes.
 * If the server is really limited in how many keycodes it allows
 * to be used as modifiers then you may not get as many modifiers as
 * you want.  You should insure that the test will still work in this
 * case.
 */
unsigned int
_wantmods(disp, dev, want)
Display	*disp;
#ifdef INPUTEXTENSION
XDevice *dev;
#else
void *dev;
#endif
int 	want;
{
unsigned int 	mask;
int 	nmods;
int 	i;

	if (curmap == NULL)
	    if (dev == NULL)
		curmap = XGetModifierMapping(disp);
#ifdef INPUTEXTENSION
	    else
		curmap = XGetDeviceModifierMapping(disp, dev);
#endif
	if (curmap == NULL)
		return(0);

	mask = 0;
	nmods = 0;

	/*
	 * Find out what is currently available.
	 */
	for (i = 0; i < NMODS*curmap->max_keypermod; i++) {
		if (curmap->modifiermap[i])
			mask |= 1 << (i/curmap->max_keypermod);
	}

	/*
	 * If we want more modifiers than are currently in the map then
	 * try to add some.  There is no guarantee that this can be done though.
	 */
	nmods = bitcount(mask);
	if (nmods < want) {
		/*
		 * Exercise for the reader...
		 */
		untested("Unimplemented modmap expansion in wantmods");
	}

	/* I want, but I can't get */
	if (nmods < want)
		want = nmods;

	/*
	 * Put the wanted number of modifiers into the return mask
	 */
	for (i = 0; i < NMODS; i++) {
		if (mask & (1 << i))
			want--;
		if (want < 0)
			mask &= ~(1 << i);
	}

	return(mask);
}

#ifdef INPUTEXTENSION
unsigned int
wantdevmods(disp, dev, want)
Display	*disp;
XDevice *dev;
int 	want;
{
	return (_wantmods(disp, dev, want));
}
#endif

unsigned int
wantmods(disp, want)
Display	*disp;
int 	want;
{
	return (_wantmods(disp, NULL, want));
}

static void modthing(/* disp, mask */);
static void devmodthing(/* disp, dev, mask */);

/*
 * Simulate pressing a bunch of modifier keys.  The mask passed to this
 * function should be made of bits obtained by a previous call to wantmods,
 * to ensure that they have assigned keycodes.
 */
modpress(disp, mask)
Display	*disp;
unsigned int 	mask;
{
	modthing(disp, mask, True);
}

#ifdef INPUTEXTENSION
devmodpress(disp, dev, mask)
Display	*disp;
XDevice *dev;
unsigned int 	mask;
{
	devmodthing(disp, dev, mask, True);
}
#endif

/*
 * Simulate releasing a bunch of modifier keys.  The mask passed to this
 * function should be made of bits obtained by a previous call to wantmods,
 * to ensure that they have assigned keycodes.
 */
modrel(disp, mask)
Display	*disp;
unsigned int 	mask;
{
	modthing(disp, mask, False);
}

#ifdef INPUTEXTENSION
devmodrel(disp, dev, mask)
Display	*disp;
XDevice *dev;
unsigned int 	mask;
{
	devmodthing(disp, dev, mask, False);
}
#endif

static void
modthing(disp, mask, pressing)
Display	*disp;
unsigned int 	mask;
int pressing;
{
int 	mod;
int 	ent;
void	(*func)();

	if (curmap == NULL) {
		delete("Programming error: wantmods() not called");
		return;
	}

	if (pressing)
		func = keypress;
	else
		func = keyrel;

	for (mod = 0; mod < NMODS; mod++) {
		if (mask & (1 << mod))
			{
			for (ent=mod*curmap->max_keypermod; 
			     ent<(mod+1) *curmap->max_keypermod; ent++)
			    if (curmap->modifiermap[ent]) {
				(*func)(disp, curmap->modifiermap[ent]);
				break;
			    }
			/*
			(*func)(disp, curmap->modifiermap[mod*curmap->max_keypermod]);
			*/
			}
	}
}

#ifdef INPUTEXTENSION
static void
devmodthing(disp, dev, mask, pressing)
Display	*disp;
unsigned int 	mask;
int pressing;
{
int 	mod;
void	(*func)();

	if (curmap == NULL) {
		delete("Programming error: wantmods() not called");
		return;
	}

	if (dev)
	    if (pressing)
		func = devicekeypress;
	    else
		func = devicekeyrel;

	for (mod = 0; mod < NMODS; mod++) {
		if (mask & (1 << mod))
			(*func)(disp, dev, devcurmap->modifiermap[mod*devcurmap->max_keypermod]);
	}
}
#endif

/*
 * Check if a keycode corresponds to any of mods in a mask, returned by
 * wantmods.
 */
ismodkey(mask, kc)
unsigned int 	mask;
int kc;
{
int 	mod;

	if (curmap == NULL) {
		delete("Programming error: wantmods() not called");
		return False;
	}
	if (!mask || kc < 8 || kc > 255)
		return False;

	for (mod = 0; mod < NMODS; mod++) {
		if (mask & (1 << mod))
			if (curmap->modifiermap[mod*curmap->max_keypermod] == kc)
				return True;
	}
	return False;
}

/*
 * This routine should be called at the end of a test after any of the
 * device press routines have been called.
 */
restoredevstate()
{
extern	Display	*Dsp;

	relalldev();
	if (origmap)
		XSetModifierMapping(Dsp, origmap);
}

/*
 * Returns True if we don't want to do extended testing for any reason.
 */
noext(needbutton)
int 	needbutton;
{

	if (config.extensions == False) {
		untested("Extended testing not required");
		return True;
	} else if (IsExtTestAvailable() == False) {
		untested("Server does not support XTEST extension");
		untested("or test suite not configured to use XTEST extension");
		return True;
	} else if (needbutton && nbuttons() == 0) {
		untested("No buttons exist on the server");
		return True;
	}
	return False;
}


/*
 * Returns the number of physical buttons.
 */
nbuttons()
{
static int 	Nbuttons = -1;
unsigned	char	pmap[5];
extern	Display	*Dsp;

	if (Nbuttons == -1)
		Nbuttons = XGetPointerMapping(Dsp, pmap, sizeof(pmap));
	return Nbuttons;
}

/*
 * Returns a valid keycode for the server.  A different one is returned
 * every time (until it wraps round).
 */
getkeycode(display)
Display	*display;
{
static	int 	minkc, maxkc;
static	int 	curkey;

	XDisplayKeycodes(display, &minkc, &maxkc);
	if (minkc < 8)
		minkc = 8;
	if (!curkey)
		curkey = minkc;

	if (curkey > maxkc)
		curkey = minkc;

	return curkey++;
}

/*
 * Returns a valid keycode for the device.  A different one is returned
 * every time (until it wraps round).
 */
#ifdef INPUTEXTENSION
getdevkeycode(display,dev)
Display	*display;
XDevice *dev;
{
static	int 	minkc, maxkc;
static	int 	devcurkey[MAX_DEVICES];
XDeviceInfoPtr list;
XAnyClassPtr any;
int i, j, id=dev->device_id, ndevices;

        list = XListInputDevices (display, &ndevices);
	for(i=0; i<ndevices; i++)
	    if ((list+i)->id == id)
		break;

	any = (XAnyClassPtr) ((list+i)->inputclassinfo);
	for (j=0; j<list->num_classes; j++)
	    {
	    XKeyInfo *K = (XKeyInfo *) any;
	    if (any->class == KeyClass)
		{
		minkc = K->min_keycode;
		maxkc = K->max_keycode;
		break;
		}
	    any = (XAnyClassPtr) ((char *) any + any->length);
	    }
 	XFreeDeviceList(list);

	if (minkc < 8)
		minkc = 8;
	if (!devcurkey[id])
		devcurkey[id] = minkc;

	if (devcurkey[id] > maxkc)
		devcurkey[id] = minkc;

	return devcurkey[id]++;
}
#endif
