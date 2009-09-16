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
$Header: /cvs/xtest/xtest/xts5/tset/Xlib14/XwcFreeStringList/XwcFreeStringList.m,v 1.2 2005-04-21 09:40:42 ajosey Exp $

Copyright (c) 2001 The Open Group
Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xlib14/XwcFreeStringList/XwcFreeStringList.m
>># 
>># Description:
>>#	Tests for XwcFreeStringList()
>># 
>># Modifications:
>># $Log: wcfstli.m,v $
>># Revision 1.2  2005-04-21 09:40:42  ajosey
>># resync to VSW5.1.5
>>#
>># Revision 8.2  2005/01/21 10:43:23  gwc
>># Updated copyright notice
>>#
>># Revision 8.1  2001/03/28 12:01:46  vsx
>># added XStoreName() call & fixed XGetTextProperty() return value check
>>#
>># Revision 8.0  1998/12/23 23:39:09  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:02:16  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:30:10  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:26:44  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.2  1998/01/21 00:26:56  tbr
>># Totally rewritten version of test.
>>#
>># Revision 4.0  1995/12/15 09:24:42  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:02:20  andy
>># Prepare for GA Release
>>#
>>AVSCODE
>>TITLE XwcFreeStringList Xlib14
void
XwcFreeStringList()
>>EXTERN

/******
 * User defined globals for test
 ******/
 char *xmodifier ;
 char tmpbuf[255];



int x_init, y_init, h_init, w_init;


svcwcFreeStringList(display, list)
Display *display;
wchar_t **list;
{
extern int  errcnt;
extern int  errflg;
extern int  chkflg;
extern int  signal_status();
extern int  unexp_err();
extern char *svc_user_arg;
extern char *strcpy();

char fmtstr[256], *call_string;
union msglst fmt_lst[1];        
int skip_pixcheck;


int
	ss_status,		/* save stat return status */	
	stat_status,		/* check stat return status */
	setup_status,
	cleanup_status,
	i1;


/******
* Turn on buffering and buffer parameter information
* in case an error occurs
******/
regr_args.l_flags.bufrout = 1;

(void)strcpy(fmtstr, "*********************\n");
message(fmtstr, fmt_lst, 0);
(void)strcpy(fmtstr, "An error occurred during a call to %s\n\n");
fmt_lst[0].typ_str = TestName;
message(fmtstr, fmt_lst, 1);
call_string = "XwcFreeStringList(";
(void)strcpy(fmtstr, "The routine call looked like this - \n    %s\n");
fmt_lst[0].typ_str = call_string;
message(fmtstr, fmt_lst, 1);
call_string = "		string);\n\n";
message(call_string, fmt_lst, 0);
(void)strcpy(fmtstr, "The parameter values were as follows... \n");
message(fmtstr, fmt_lst, 0);
bufrdisp(display);	/* buffer display struct info for error checking */

if (regr_args.iter == 0)   
	regr_args.iter = 1;


for (i1 = 0; i1 < regr_args.iter; i1++) {
	if (regr_args.l_flags.setup) 
		setup_status = REGR_NORMAL;

	XSync(display, 0);

	if (regr_args.l_flags.chksta  == 1)
		ss_status = save_stat(dpy_msk | win_msk | gc_msk | pix_msk ,
			gc_id, display, drawable_id);
                                                

	first_error = 0;	/* no errors encountered yet */
	errflg = 0;
	XSetErrorHandler(signal_status);
	XwcFreeStringList(list);
	XSync(display, 0);
	XSetErrorHandler(unexp_err);          
	r_wait(display, window_arg, time_delay, None);	

	if (regr_args.l_flags.chksta  == 1) 
		stat_status = chek_stat (dpy_msk | win_msk, gc_id, display,
			drawable_id, ss_status);
	else                              
		stat_status = REGR_NORMAL;

	if ((!errflg) && (!chkflg)) 
		if ((badstat(display, estatus, Success)) != REGR_NORMAL)
			errflg = 1;

	/*
	if ((regr_args.l_flags.check) && (errflg == 0) && 
		(stat_status == REGR_NORMAL)) 
	*/

	XSync(display, 0);


	/******
	 * cleanup code for this service.
	 * If the drawable is a pixmap, clear the pixmap using 
	 * the XFillRectangle command, otherwise it's a window; 
	 * clear the window normally 
	 ******/
	if (regr_args.l_flags.cleanup) {
		cleanup_status = REGR_NORMAL;
		}

	XSync(display, 0);
} /* end of service test loop. */

if (errflg) { 	
	errcnt++;   
	(void)strcpy(fmtstr, "\nEnd of error report\n");
	message(fmtstr, fmt_lst, 0);
	(void)strcpy(fmtstr, "*********************\n");
	message(fmtstr, fmt_lst, 0);
	tet_result(TET_FAIL);
	}

chkflg = 0;
regr_args.l_flags.bufrout = 0;

dumpbuf();
}


>>ASSERTION Good C
If the implementation is X11R5 or later:
A call to xname
shall free the string list and component strings allocated by
XwcTextPropertyToTextList.
>>CODE
#if XT_X_RELEASE > 4
int i,j;
XTextProperty prop_return;
wchar_t **list_return;
int count_return;
Status status;
#endif

#if XT_X_RELEASE > 4

display_arg = Dsp;

BorderPixel = XBlackPixel(display_arg,XDefaultScreen(display_arg));
BackgroundPixel = XWhitePixel(display_arg,XDefaultScreen(display_arg));
PixPerCM = XDisplayWidth(display_arg,
	XDefaultScreen(display_arg))*10/XDisplayWidthMM(display_arg,
	XDefaultScreen(display_arg));
MaxDisplayWidth  = XDisplayWidth(display_arg, XDefaultScreen(display_arg));
MaxDisplayHeight = XDisplayHeight(display_arg, XDefaultScreen(display_arg));
DisplayCenterX   = (MaxDisplayWidth / 2) - PixPerCM;
DisplayCenterY   = (MaxDisplayHeight / 2) - PixPerCM;
w_init = (MaxDisplayWidth - (2 * PixPerCM));
h_init = (MaxDisplayHeight - (2 * PixPerCM));
x_init = PixPerCM - 5;
y_init = PixPerCM - 5;
          

tet_infoline("PREP: Create a window for test.");
if ((window_arg = XCreateSimpleWindow(display_arg, 
	(Window)XRootWindow(display_arg, XDefaultScreen(display_arg)),
	x_init, y_init,
	(unsigned int)w_init, 
	(unsigned int)h_init,    
	BorderWidth,
	BorderPixel, 
	BackgroundPixel)) == (Window)NULL)
	{            
	tet_infoline("ERROR: Window creation failed.");
	tet_result(TET_UNRESOLVED);
	return;
	}

XStoreName (display_arg, window_arg, "Test");
XMapWindow (display_arg, window_arg);
XSync (display_arg, 0);	
	
regr_args.l_flags.check = 0;
regr_args.l_flags.nostat = 0;
regr_args.l_flags.perf = 0;
regr_args.l_flags.setup = 0;
regr_args.l_flags.cleanup = 0;
regr_args.l_flags.chksta = 0;
regr_args.l_flags.chkdpy = 0;
regr_args.l_flags.verbose = 0;
regr_args.iter = 1;
estatus[0] = 1;

tet_infoline("PREP: Get the XA_WM_NAME text property for the window.");
if (XGetTextProperty(display_arg, window_arg, &prop_return,
	XA_WM_NAME) == 0)
	{
	sprintf(tmpbuf, "ERROR: XGetTextProperty failed to get XA_WM_NAME");
	tet_infoline(tmpbuf);
	tet_result(TET_UNRESOLVED);
	return;
	}
tet_infoline("PREP: convert the text property to a text list.");
if ((status = XwcTextPropertyToTextList(display_arg, &prop_return, &list_return,
	&count_return)) != Success)
	{
	sprintf(tmpbuf, "ERROR: XwcTextPropertyToTextList failed with status(%d)",
		status);
	tet_infoline(tmpbuf);
	tet_result(TET_UNRESOLVED);
	return;
	}

tet_infoline("TEST: XwcFreeStringList frees the text list and component");
tet_infoline("TEST: strings allocated by XwcTextPropertyToTextList.");
svcwcFreeStringList(display_arg, list_return);

tet_result(TET_PASS);
#else

	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
