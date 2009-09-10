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
$Header: /cvs/xtest/xtest/xts5/tset/XI/XGetSelectedExtensionEvents/XGetSelectedExtensionEvents.m,v 1.2 2005-11-03 08:42:07 jmichael Exp $

Copyright (c) Applied Testing and Technology, Inc. 1995
All Rights Reserved.

>># Project: VSW5
>># 
>># File: xts5/tset/XI/gtslctdext/gtslctdext.m
>># 
>># Description:
>># 	Tests for XGetSelectedExtensionEvents()
>># 
>># Modifications:
>># $Log: gtslctevnt.m,v $
>># Revision 1.2  2005-11-03 08:42:07  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:14  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:32:03  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:52:17  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:23:37  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:20:09  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:03:54  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:01:58  andy
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
>>TITLE XGetSelectedExtensionEvents XI
XEventClass *

Display	*display = Dsp;
Window	win;
int	*this_client_count = &tcount;
XEventClass **this_client_list= &tlist;
int	*all_clients_count = &acount;
XEventClass **all_clients_list= &alist;
>>EXTERN
int acount, tcount;
XEventClass *tlist, *alist;
>>ASSERTION Good B 3
A successful call to xname returns the selected input extension events for the 
specified window.
>>STRATEGY
Call xname.
>>CODE
Window	w;
Display	*client1, *client2;
int 	ret;

/* Create client1. */
	if (!Setup_Extension_DeviceInfo(KeyMask))
	    {
	    untested("%s: No input extension key device.\n", TestName);
	    return;
	    }
	client1 = opendisplay();
	if (client1 == (Display *) NULL) {
		delete("Can not open display");
		return;
	}
	else
		CHECK;
	client2 = opendisplay();
	if (client2 == (Display *) NULL) {
		delete("Can not open display");
		return;
	}
	else
		CHECK;
/* Create window with client1. */
	w = mkwin(client1, (XVisualInfo *) NULL, (struct area *) NULL, False);
	win = w;
	XSync (client1, True);
	
	ret = XCALL;
	if (geterr() == Success)
		CHECK;
	else
		FAIL;
	CHECKPASS(3);

	SuppressExtensionEvents(display,w);
	XSync (display, True);
	ret = XCALL;
	if (geterr() == Success)
		CHECK;
	else
		FAIL;
	CHECKPASS(4);

	SelectExtensionEvents(display,w);
	XSync (display, True);
	ret = XCALL;
	if (geterr() == Success)
		CHECK;
	else
		FAIL;
	CHECKPASS(5);

	SelectExtensionEvents(client1,w);
	XSync (client1, True);
	ret = XCALL;
	if (geterr() == Success)
		CHECK;
	else
		FAIL;
	CHECKPASS(6);

	SelectExtensionEvents(client2,w);
	XSync (client2, True);
	ret = XCALL;
	if (geterr() == Success)
		CHECK;
	else
		FAIL;
	CHECKPASS(7);

>>ASSERTION Bad B 3
A call to xname with an invalid window returns a BadWindow error.
>>STRATEGY
Call xname with an invalid window.
>>CODE BadWindow
Window	w;
Display	*client1;
int 	ret;

/* Create client1. */
	if (!Setup_Extension_DeviceInfo(KeyMask))
	    {
	    untested("%s: No input extension key device.\n", TestName);
	    return;
	    }
	client1 = opendisplay();
	if (client1 == (Display *) NULL) {
		delete("Can not open display");
		return;
	}
	else
		CHECK;
/* Create window with client1. */
	win = 0;
	ret = XCALL;
	if (geterr() == BadWindow)
		CHECK;
	else {
		report("No BadWindow for invalid window test");
		FAIL;
		}
	CHECKPASS(2);

