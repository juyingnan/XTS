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
$Header: /cvs/xtest/xtest/xts5/tset/Xlib14/imofic/imofic.m,v 1.2 2005-11-03 08:42:44 jmichael Exp $

Copyright (c) Applied Testing and Technology, Inc. 1995
All Rights Reserved.

>># Project: VSW5
>># 
>># File: xts5/tset/Xlib14/imofic/imofic.m
>># 
>># Description:
>># 	Tests for XIMOfIC()
>># 
>># Modifications:
>># $Log: imofic.m,v $
>># Revision 1.2  2005-11-03 08:42:44  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:19  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:38:48  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:53  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:29:50  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:26:23  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:23:30  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:01:23  andy
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

>>TITLE XIMOfIC Xlib14
XIM

XIC ic;
>>SET startup localestartup
>>SET cleanup localecleanup
>>ASSERTION Good C
If the implementation is X11R5 or later:
A call to xname shall return the input method,
.A im
of the input context,
.A ic
which was used to create the ic.
>>STRATEGY
Loop through all the input method styles for all the locales, create an
input context, call XIMOfIC and check to see if this is the same input
method that was used for creating the input context.
>>CODE
#if XT_X_RELEASE > 4
char *plocale;
XrmDatabase db = NULL;
XIM im = NULL;
Window win;
XFontSet fs = NULL;
int nstyles = 0;
XIMStyle which_style;
XIC ic;
XIM tim;
#endif

#if XT_X_RELEASE > 4

	XrmInitialize();

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

			tim = XCALL;
			if(tim != im)
			{
				report("Input Method 0x%x returned by %s, differs from im 0x%x used during creation of the IC.",
					tim,TestName,im);
				FAIL;
			}
			else
				CHECK;

			/* destroy the IC */
			ic_close(ic);
		}
	}   /* nextlocale */
	cleanup_locale(NULL,fs,im,db);

	CHECKPASS(4*nlocales()+2*nstyles);
#else

	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
