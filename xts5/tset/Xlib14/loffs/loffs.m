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
$Header: /cvs/xtest/xtest/xts5/tset/Xlib14/loffs/loffs.m,v 1.2 2005-11-03 08:42:44 jmichael Exp $

Copyright (c) Applied Testing and Technology, Inc. 1995
All Rights Reserved.

>># Project: VSW5
>># 
>># File: xts5/tset/Xlib14/loffs/loffs.m
>># 
>># Description:
>># 	Tests for XLocaleOfFontSet()
>># 
>># Modifications:
>># $Log: loffs.m,v $
>># Revision 1.2  2005-11-03 08:42:44  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:19  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:38:49  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:54  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:29:50  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:26:24  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:23:31  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:01:25  andy
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

>>TITLE XLocaleOfFontSet Xlib14
char *
XLocaleOfFontSet(font_set)
XFontSet font_set;
>>SET startup localestartup
>>SET cleanup localecleanup
>>ASSERTION Good C
If the implementation is X11R5 or later:
Given a font set xname shall return the name of the locale to which it is 
bound.
>>STRATEGY
For every Locale specified by the user in the configuration file, create
each of the base font sets specified by the user, by calling
XCreateFontSet, then call XLocaleOfFontSet to get the locale, this name 
should be the same name as the current locale.
>>CODE
#if XT_X_RELEASE > 4
Display *dpy;
char *plocale;
char *font_list;
XFontSet pfs;
char *fontset;
char *defstr;
int missing_cnt;
char **missing_chars;
char *base_font_name;
char *locale_name;
#endif

#if XT_X_RELEASE > 4

	resetlocale();
	dpy = Dsp;
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

		/* cycle through the fontsets */
		resetfontset();
		while(nextfontset(&font_list))
		{
			pfs = XCreateFontSet(dpy,font_list,&missing_chars,
				&missing_cnt,&defstr);
			if(pfs == NULL)
			{
				report("XCreateFontSet unable to create fontset, %s",
					font_list);
				FAIL;
			}
			else
			{
				trace("Created Font Set %s", font_list);
				font_set = pfs;

				locale_name = XCALL;
				if(strcmp(locale_name,plocale) != 0)
				{
					report("Locale %s not same as current %s for fontset %s",
						locale_name,plocale,font_list);
					FAIL;
				}
				else
				{
					trace("Locale %s matches current locale, %s, for fontset %s",
						locale_name,plocale,font_list);
					CHECK;
				}
				XFreeFontSet(dpy,pfs);
				XFreeStringList(missing_chars);
			}
		}
	}
	
        CHECKPASS(nlocales()+nlocales()*nfontset());
#else

	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
