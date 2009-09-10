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
$Header: /cvs/xtest/xtest/xts5/tset/Xlib13/SetPointerMapping/SetPointerMapping.m,v 1.3 2006-12-07 15:52:49 gwc Exp $

Copyright (c) Applied Testing and Technology, Inc. 1995
All Rights Reserved.

>># Project: VSW5
>># 
>># File: xts5/tset/Xlib13/SetPointerMapping/SetPointerMapping.m
>># 
>># Description:
>># 	Tests for XSetPointerMapping()
>># 
>># Modifications:
>># $Log: stpntrmppn.m,v $
>># Revision 1.3  2006-12-07 15:52:49  gwc
>># Patch from bug #7428 - remove MAXBUTTON=5 constraints
>>#
>># Revision 1.2  2005/11/03 08:42:41  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:19  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:33:44  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:55:29  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:25:07  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:21:39  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:08:41  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:10:07  andy
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
>>TITLE XSetPointerMapping Xlib13
>>SET return-value MappingSuccess
int

Display	*display = Dsp;
unsigned char	*map = Map;
int 	nmap;
>>EXTERN

/*
 * MAPSIZE must be at least one greater than the maximum number of buttons
 * allowed.  We use a much larger value.
 */
#define	MAPSIZE	32
static	unsigned char	Map[MAPSIZE];

static	int 	numbuttons;

/*
 * Set up the number of buttons.  Also set the nmap value to numbuttons (
 * the test may later override this).
 */
>>SET begin-function getnbutton
static	void
getnbutton()
{
	numbuttons = XGetPointerMapping(Dsp, Map, MAPSIZE);
	nmap = numbuttons;
	if (isdeleted())
		delete("XGetPointerMapping failed");
}

/*
 * Save and restore the old map.
 */
static unsigned char	oldmap[MAPSIZE];
>>SET startup savemap
static void
savemap()
{
	startup();
	if(Dsp)
		numbuttons = XGetPointerMapping(Dsp, oldmap, MAPSIZE);
}

>>SET cleanup restoremap
static void
restoremap()
{
	if(Dsp)
		(void) XSetPointerMapping(Dsp, oldmap, numbuttons);
	cleanup();
}

>>ASSERTION Good A
A successful call to xname sets the pointer mapping for the physical buttons
to the
.A nmap
logical button numbers specified in the array
.A map
and returns
.S MappingSuccess .
>>STRATEGY
Get number of buttons.
Set up a pointer mapping.
Set pointer mapping with xname.
Verify return value.
Get pointer mapping with XGetPointerMapping.
Verify that pointer mapping is as set.
>>CODE
unsigned char	newmap[MAPSIZE];
int 	i;

	/*
	 * Cycle the current mapping around.
	 */
	for (i = 0; i < numbuttons; i++) {
		map[i] = map[i] + 1;
		if (map[i] > numbuttons)
			map[i] = 1;
	}

	XCALL;

	(void) XGetPointerMapping(display, newmap, MAPSIZE);
	if (isdeleted()) {
		delete("Could not get pointer mapping");
		return;
	}

	for (i = 0; i < numbuttons; i++) {
		if (map[i] == newmap[i])
			CHECK;
		else {
			report("Mapping not set correctly in position %d", i);
			report("  was %u, expecting %u", (unsigned)newmap[i], (unsigned)map[i]);
			FAIL;
		}
	}

	CHECKPASS(numbuttons);
>>ASSERTION Good A
When a call to xname is successful, then a
.S MappingNotify
event is generated.
>>STRATEGY
Call xname.
Verify that a MappingNotify event is generated.
>>CODE
XEvent	ev;
XMappingEvent	good;
int 	n;

	XCALL;

	n = getevent(display, &ev);
	if (n == 0 || ev.type != MappingNotify) {
		report("Expecting a MappingNotify event, received %s", n? eventname(ev.type): "no event");
		FAIL;
	} else
		CHECK;

	defsetevent(good, display, MappingNotify);
	good.window = None;	/* Not used */
	good.request = MappingPointer;
	if (checkevent((XEvent*)&good, &ev))
		FAIL;
	else
		CHECK;

	CHECKPASS(2);
>>ASSERTION Good B 3
When an element of
.A map
is zero, then the corresponding physical button is
disabled.
>>STRATEGY
If extension available:
  Create and map a window.
  Select ButtonPress on it.
  For i in 1..numbuttons
    Set map[i-1] to 0.
    Call xname.
    Discard event queue.
    Simulate button i press with extension.
    Release all buttons etc.
    Check no button press event received.
    Restore map[i-1].
else
  Report untested.
>>CODE
int	i;
unsigned char zmap[MAPSIZE];
Window	win;

	if (noext(numbuttons))
		return;
	else
		CHECK;

	if (numbuttons<1 || numbuttons>MAPSIZE) {
		report("Limit of 1..%d buttons exceeded (%d).", MAPSIZE, numbuttons);
		return;
	} else
		CHECK;

	for(i=0; i<numbuttons; i++)
		zmap[i] = map[i];
	win = defwin(display);
	(void) warppointer(display, win, 2,2);
	XSelectInput(display, win, ButtonPressMask);

	for(i=0; i<numbuttons; i++) {
		unsigned char mapsave = zmap[i];
		int ret;
		XEvent ev;

		zmap[i] = 0; /* disable button i+1 */
		map = zmap;
		ret = XCALL;

		if (ret != MappingSuccess) {
			delete("Couldn't set zero entry for button %d.", i+1);
			return;
		} else
			CHECK;

		XSync(display, True); /* discard event queue */
		_startcall(display);	/* set error handler etc. */
		buttonpress(display, (unsigned int)i+1);
		relalldev();
		_endcall(display);
		if (geterr() != Success) {
			delete("Couldn't simulate pressing button %d.", i+1);
			return;
		} else
			CHECK;
		if (XCheckWindowEvent(display, win, ButtonPressMask, &ev)) {
			report("Got event after pressing disabled button %d.", i+1);
			FAIL;
		} else
			CHECK;
		zmap[i] = mapsave; /* restore button i+1 */
	}
	CHECKPASS(2+numbuttons*3);
>>ASSERTION Good A
Elements of the
.A map
array are not restricted in
value by the number of physical buttons.
>>STRATEGY
Set up map array with button number higher than number of physical buttons.
Call xname.
Verify no error.
>>CODE
int 	i;

	for (i = 0; i < numbuttons; i++)
		map[i] = i;

	map[0] = numbuttons+1;

	XCALL;

	if (geterr() == Success)
		PASS;

>>ASSERTION Good B 3
When any of the buttons to be altered are logically in the down state,
then a call to xname returns
.S MappingBusy ,
and the mapping is not changed.
>>STRATEGY
If extension available:
  Set mapping to be each button to itself and save this map.
  For i in 1..numbuttons
    Cycle map so that button i is not itself.
    Simulate button i press
    Call xname with cycled map so that button i is being altered.
    Release buttons etc.
    Check for MappingBusy.
    Call XGetPointerMapping to get current mapping and current numbuttons.
    Check same as original, saved, values.
else
  Report untested.
>>CODE
int	i;
int	nb;
unsigned char firstmap[MAPSIZE];
unsigned char newmap[MAPSIZE];
int	ret;

	if (noext(numbuttons))
		return;
	else
		CHECK;

	if (numbuttons<1 || numbuttons>MAPSIZE) {
		delete("Limit of 1..%d buttons exceeded (%d).", MAPSIZE, numbuttons);
		return;
	} else
		CHECK;
	for(i=0; i<numbuttons; i++)
		firstmap[i] = map[i] = (unsigned char)i+1;
	ret = XCALL;
	if (isdeleted() || ret != MappingSuccess) {
		delete("Couldn't set up monotonic map to start with.");
		return;
	} else
		CHECK;
	for(i=0; i<numbuttons; i++) {
		int j;
		unsigned char tmp;

		/* cycle map by one, until map[i] is not i=1 */
		do {
			for(tmp=map[0], j=0; j<(numbuttons-1); j++)
				map[j] = map[j+1];
			map[numbuttons - 1] = tmp;
		} while (map[i] == (unsigned char)i+1);

		_startcall(display);	/* set error handler etc. */
		buttonpress(display, (unsigned int)i+1);
		if (geterr() != Success) {
			delete("Couldn't simulate pressing button %d.", i+1);
			relalldev();
			_endcall(display);
			return;
		} else
			CHECK;
		_endcall(display);
		ret = XCALL;
		_startcall(display);	/* set error handler etc. */
		relalldev();
		_endcall(display);
		if (ret != MappingBusy) {
			report("Expecting MappingBusy with button %d, got %s (%d).",
				i+1, (ret==MappingSuccess)?"MappingSuccess":"<unknown>", ret);
			FAIL;
		} else
			CHECK;
		nb = XGetPointerMapping(display, newmap, numbuttons);
		if (isdeleted()) {
			delete("Couldn't get current pointer map for comparison.");
			return;
		} else
			CHECK;
		if (nb != numbuttons) {
			report("Button numbers changed from %d to %d.", numbuttons, nb);
			FAIL;
		} else {
			for(j=0; j<numbuttons; j++)
				if (firstmap[j] != newmap[j]) {
					report("Maps differ for button %d, was %d now %d.", j+1, firstmap[j], newmap[j]);
					FAIL;
				} else
					CHECK;
		}
	}
	CHECKPASS(3+numbuttons*(3+numbuttons*1));
>>ASSERTION Bad A
When
.A nmap
is not the same as the length that
.F XGetPointerMapping
would return,
then a
.S BadValue
error occurs.
>>STRATEGY
Set nmap to incorrect value.
Call xname.
Verify that a BadValue error occurs.
>>CODE BadValue
int 	i;

	nmap = numbuttons + 2;
	for (i = 0; i < nmap; i++)
		map[i] = i;	/* MAPSIZE is large enough to allow this */
	XCALL;

	if (geterr() == BadValue)
		PASS;
	else
		FAIL;	/* done already */
>>ASSERTION Bad C
If there is more than one button:
When two elements of
.A map
have the same non-zero value,
then a
.S BadValue
error occurs.
>>STRATEGY
If less than two buttons
  Report unsupported.
Set up a map with two elements the same.
Call xname.
Verify that a BadValue error occurs.
>>CODE BadValue
int 	i;

	if (numbuttons < 2) {
		unsupported("There are less than two buttons");
		return;
	}

	for (i = 0; i < nmap; i++)
		map[i] = i;

	map[0] = map[1];
	XCALL;

	if (geterr() == BadValue)
		PASS;
	else
		FAIL;

