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
>># File: xts5/Xlib3/XMinCmapsOfScreen.m
>># 
>># Description:
>># 	Tests for XMinCmapsOfScreen()
>># 
>># Modifications:
>># $Log: mncmpsofsc.m,v $
>># Revision 1.2  2005-11-03 08:43:25  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:24  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:35:17  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:57:44  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:26:33  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:23:06  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:12:50  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:15:55  andy
>># Prepare for GA Release
>>#
>>#:
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
>>SET   macro
>>TITLE XMinCmapsOfScreen Xlib3
int
XMinCmapsOfScreen(screen)
Screen	*screen = DefaultScreenOfDisplay(Dsp);
>>ASSERTION Good B 3
A call to xname returns the minimum number of installed colourmaps supported by
the screen
.A screen .
>>STRATEGY
Obtain the minimum allowed number of installed colourmaps using xname.
Call that number minm.
Create minm colormaps for each visual, and collect them all into a set.
For each possible subset of size minm, install all of the colormaps in that
subset, and verify that they all stay installed.
>>CODE
int		minm;
XVisualInfo	*vp;
int		n, ni, nsubsets;
Colormap	*cmap, *icmap;
int		mode;
short		*subset;
int		i, j, k;

	minm = XCALL;

	if(minm < 1) {
		report("%s() returns %d < 1", TestName, minm);
		FAIL;
		minm = 1;
	} else
		CHECK;

	resetvinf(VI_WIN);
	n = minm * nvinf();
	cmap = (Colormap *) malloc(n * sizeof(Colormap));
	if (cmap == (Colormap *) 0) {
		delete("malloc() error");
		return;
	} else
		CHECK;

	i = 0;
	while (nextvinf(&vp)) {
		switch (vp->class) {
		case StaticGray:
		case StaticColor:
		case TrueColor:
			mode = AllocNone;
			break;
		default:
			mode = AllocAll;
			break;
		}
		for (j = 0; j < minm; j++)
			cmap[i++] = makecolmap(Dsp, vp->visual, mode);
		CHECK;
	}
	if (i != n) {
		delete("coding error, wrong number of colormaps created");
		return;
	}

	subset = (short *) malloc(n * sizeof(short));
	if (subset == (short *) 0) {
		delete("malloc() error");
		return;
	} else
		CHECK;

	for (i = minm; i < n; i++)
		subset[i] = 0;
	for (i = 0; i < minm; i++)
		subset[i] = i + 1;

	while (1) {
		k = 0;
		for (j = 0; j < n; j++) {
			if (subset[j]) {
				XInstallColormap(Dsp, cmap[j]);
				k++;
			}
		}
		if (k != minm) {
			delete("coding error, wrong number of colormaps installed, expected %d, got %d", minm, k);
			for (j = 0; j < n; j++) {
				if (subset[j])
					report("%d = %d", j, subset[j]);
			}
			return;
		}
		icmap = XListInstalledColormaps(Dsp, DRW(Dsp), &ni);
		if (ni < minm) {
			report("install of %d colormaps produced only %d",
				minm, ni);
			FAIL;
		} else {
			CHECK;
			for (j = 0; j < n; j++) {
				if (subset[j]) {
					for (k = 0; k < ni; k++) {
						if (icmap[k] == cmap[j])
							break;
					}
					if (k >= ni) {
						report("colormap did not stay installed");
						FAIL;
					} else {
						CHECK;
					}
				}
			}
		}
		XFree((char*)icmap);
		CHECK;
		if (i == n) {
			do
				subset[--i] = 0;
			while (i && subset[i - 1]);
			do
				i--;
			while (i >= 0 && !subset[i]);
			if (i < 0)
				break;
			subset[i + 1] = subset[i];
			subset[i] = 0;
			i++;
			while (subset[i] < minm) {
				subset[i + 1] = subset[i] + 1;
				i++;
			}
		} else {
			subset[i] = subset[i - 1];
			subset[i - 1] = 0;
		}
		i++;
	}

	/* compute "n choose k" for k = minm */
	nsubsets = 1;
	for (i = n - minm + 1; i <= n; i++)
		nsubsets *= i;
	for (i = 2; i <= minm; i++)
		nsubsets /= i;

	CHECKUNTESTED(3 + nvinf() + (2 + minm) * nsubsets);
