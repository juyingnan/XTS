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
>># File: xts5/tset/Xlib14/XwcLookupString/XwcLookupString.m
>># 
>># Description:
>># 	Tests for XwcLookupString()
>># 
>># Modifications:
>># $Log: wclustr.m,v $
>># Revision 1.2  2005-11-03 08:42:46  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:20  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:39:10  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:02:16  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:30:11  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:26:44  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:24:44  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.2  1995/12/15  02:02:23  andy
>># Prepare for GA Release
>>#
/*

Copyright (c) 1993  X Consortium

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
Copyright 1993 by Sun Microsystems, Inc. Mountain View, CA.

                  All Rights Reserved

Permission  to  use,  copy,  modify,  and  distribute   this
software  and  its documentation for any purpose and without
fee is hereby granted, provided that the above copyright no-
tice  appear  in all copies and that both that copyright no-
tice and this permission notice appear in  supporting  docu-
mentation,  and  that the names of Sun or MIT not be used in
advertising or publicity pertaining to distribution  of  the
software  without specific prior written permission. Sun and
M.I.T. make no representations about the suitability of this
software for any purpose. It is provided "as is" without any
express or implied warranty.

SUN DISCLAIMS ALL WARRANTIES WITH REGARD TO  THIS  SOFTWARE,
INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FIT-
NESS FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL SUN BE  LI-
ABLE  FOR  ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR
ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE,  DATA  OR
PROFITS,  WHETHER  IN  AN  ACTION OF CONTRACT, NEGLIGENCE OR
OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION  WITH
THE USE OR PERFORMANCE OF THIS SOFTWARE.
*/
>>EXTERN
#include <locale.h>
#include <ximtest.h>

>>TITLE XwcLookupString Xlib14
int

XIC ic;
XKeyPressedEvent *event;
wchar_t *buffer_return;
int bytes_buffer;
KeySym *keysym_return;
Status *status_return;
>>EXTERN
static KeySym which_key = 0x062; /* XK_b */
static KeySym which_keycap = 0x042; /* XK_B */
>>SET startup localestartup
>>SET cleanup localecleanup
>>ASSERTION Good C
If the implementation is X11R5 or later:
A call to xname shall return the string from the input method specified in the
.A buffer_return
argument. If no string is returned the 
.A buffer_return 
argument shall remain unchanged.  The 
.S KeySym 
into which the 
.S KeyCode 
from the event was mapped shall be returned in the
.A keysym_return
argument if it is non-NULL and the 
.A status_return 
argument indicates that a 
.S KeySym 
was returned.  If both a string and a 
.S KeySym 
are returned, the 
.S KeySym 
value does not necessarily correspond to the string returned.
xname returns the length of the string in bytes.  The text is returned
in the encoding of the locale bound to the input method of the 
specified input context,
.A ic .
>>STRATEGY
For all locales, create an input method and 
for all supported styles create an input context,
Obtain the keycode corresponding to the keysym XK_b using XKeysymToKeycode.
Obtain the string and keysym bound to that keycode using xname.
Verify that the returned string is correct.
Obtain the string and keysym bound to that keycode using xname with state = ShiftMask.
Verify that the returned string is correct.
>>CODE
#if XT_X_RELEASE > 4
wchar_t wcomp_str[256];
wchar_t wcomp_strcap[256];
static char buf[] = "Xtest uninitialiased string.";
char *plocale;
XrmDatabase db = NULL;
XIM im = NULL;
Window win;
XFontSet fs = NULL;
XIMStyle which_style;
int nstyles = 0;
KeyCode kc;
XKeyEvent ke;
KeySym ks=0;
int wlen;
Status status;
int res,cmplen;
static wchar_t wbuf[256]; 
char mbcomp_str[256];
char mbcomp_strcap[256];
char mbbuffer_return[256];
#endif

#if XT_X_RELEASE > 4

	XrmInitialize();

	mbstowcs(wcomp_str,"b",256);	
	mbstowcs(wcomp_strcap,"B",256);	

	wlen = mbstowcs(wbuf,buf,256);

	resetlocale();
	while(nextlocale(&plocale))
	{
		if (locale_set(plocale))
			CHECK;
		else
		{
			report("Couldn't set locale.");
			FAIL;
			continue;
		}

		cleanup_locale(NULL,fs,im,db);

		db = rm_db_open();
		if(db != NULL)
			CHECK;
		else
		{
			report("Couldn't open database.");
			FAIL;
			continue;
		}

		im = im_open(db);
		if(im != NULL)
			CHECK;
		else
		{
			report("Couldn't open input method.");
			FAIL;
			continue;
		}

		if(ic_setup(&win,&fs))
			CHECK;
		else
		{
			report("Couldn't setup input styles.");
			FAIL;
			continue;
		}

		reset_ic_style(im);
		nstyles += n_ic_styles();
     	while(next_ic_style(&which_style))
     	{
	  		ic = ic_open(im,win,which_style);
     		if(ic != NULL)
				CHECK;
			else
     		{
        		report("Unable to create input context for locale, %s",
              			plocale);
        		FAIL;
        		continue;
     		}

			kc = XKeysymToKeycode(Dsp, which_key);

			ke.type = KeyPress;
			ke.display = Dsp;
			ke.keycode = kc;
			ke.state = 0;
			ke.window = win;

			event = &ke;
			buffer_return = (wchar_t *)wbuf;
			bytes_buffer = wlen;
			keysym_return = &ks;
			status_return = &status;

			res = XCALL;
			trace("Status = %d\n",status);
			if(ks != which_key)
			{
				report("%s() returned keysym %d instead of %d.", 
					TestName, (int) ks, which_key);
				FAIL;
			}
			else
				CHECK;

			if(res != 1)
			{
				report("%s() returned %d instead of 1.", TestName, res);
				FAIL;
			}
			else
				CHECK;

			cmplen = wlen;
			if(res>0 && res<wlen) cmplen = res;

			if(!xim_wsneq(buffer_return, wcomp_str, cmplen))
			{
				wcstombs(mbcomp_str,wcomp_str,256);
				wcstombs(mbbuffer_return,buffer_return,256);
				report("%s() returned string \"%s\" instead of \"%s\".",
					TestName, mbbuffer_return,mbcomp_str);
				FAIL;
			}
			else
				CHECK;

			ke.state = ShiftMask;
			event = &ke;
			res = XCALL;
			trace("Status = %d\n",status);

			if(ks != which_keycap)
			{
				report("%s() returned keysym %d instead of %d.",
					TestName, (int) ks, which_keycap);
				FAIL;
			}
			else
				CHECK;

			cmplen = wlen;
			if(res>0 && res<wlen) cmplen = res;

			if(!xim_wsneq(buffer_return, wcomp_strcap, cmplen))
			{
				wcstombs(mbcomp_str,wcomp_str,256);
				wcstombs(mbbuffer_return,buffer_return,256);
				report("%s() returned string \"%s\" instead of \"%s\".",
					TestName, mbbuffer_return,mbcomp_strcap);
				FAIL;
			}
			else
				CHECK;

			ic_close(ic);
		}
	}   /* nextlocale */
	cleanup_locale(NULL,fs,im,db);

	CHECKPASS(4*nlocales()+6*nstyles);
#else

	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif

>>ASSERTION Bad D 1
If the implementation is X11R5 or later:
If the input string to be returned is too large for the supplied
.A buffer_return
xname shall return XBufferOverflow in the
.A status_return
argument.
>>ASSERTION Good D 1
If the implementation is X11R5 or later:
If no consistent input has been composed so far the value
a call to xname shall return XLookupNone
in 
.A status_return,
not modify the contents of 
.A buffer_return
or
.A keysym_return,
and return zero.
