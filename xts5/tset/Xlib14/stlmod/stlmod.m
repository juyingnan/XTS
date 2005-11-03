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
$Header: /cvs/xtest/xtest/xts5/tset/Xlib14/stlmod/stlmod.m,v 1.2 2005-11-03 08:42:46 jmichael Exp $

Copyright (c) Applied Testing and Technology, Inc. 1995
All Rights Reserved.

>># Project: VSW5
>># 
>># File: xts5/tset/Xlib14/stlmod/stlmod.m
>># 
>># Description:
>># 	Tests for XSetLocaleModifiers()
>># 
>># Modifications:
>># $Log: stlmod.m,v $
>># Revision 1.2  2005-11-03 08:42:46  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:20  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:39:02  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:02:08  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:30:03  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:26:37  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:24:15  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:02:03  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <locale.h>
#include <ximtest.h>

>>TITLE XSetLocaleModifiers Xlib14
char *
XSetLocaleModifiers(modifier_list)
char *modifier_list;
>>SET startup localestartup
>>SET cleanup localecleanup
>>ASSERTION Good C
If the implementation is X11R5 or later:
A call to xname 
.A modifier_list 
>>STRATEGY
For every Locale specified by the user in the configuration file, call 
XSetLocaleModifiers for every locale modifier set specified by the user 
in the configuration file.
>>CODE
#if XT_X_RELEASE > 4
Display *dpy;
char *plocale,*plclmod;
char *modstr;
Bool supported;
#endif

#if XT_X_RELEASE > 4

	resetlocale();
	while(nextlocale(&plocale))
	{
		setlocale(LC_CTYPE,plocale);
		resetlclmod();
		supported = XSupportsLocale();
		while(nextlclmod(&plclmod))
		{
			if(supported)
			{
				modifier_list = plclmod;
				modstr = XCALL;
				if((modstr != NULL) && (strcmp(modstr,modifier_list) == 0))
				{
					trace("Modifier %s found for locale %s",
						modifier_list,plocale);;
					CHECK;
				}
				else
				{
					report("Modifiers, %s, not supported for %s locale",
						plclmod,plocale);
					FAIL;
				}
			}
			else
			{
				report("Locale %s not supported for modifier, %s",
					plocale,plclmod);
				FAIL;
			}
		}
	}
	
	CHECKPASS(nlocales() * nlclmod());
#else

	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
