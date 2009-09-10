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
$Header: /cvs/xtest/xtest/xts5/tset/Xlib14/XwcResetIC/XwcResetIC.m,v 1.2 2005-04-21 09:40:42 ajosey Exp $

Copyright (c) 2001 The Open Group
Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xlib14/XwcResetIC/XwcResetIC.m
>># 
>># Description:
>>#	Tests for XwcResetIC()
>># 
>># Modifications:
>># $Log: wcreic.m,v $
>># Revision 1.2  2005-04-21 09:40:42  ajosey
>># resync to VSW5.1.5
>>#
>># Revision 8.3  2005/01/21 10:44:37  gwc
>># Updated copyright notice
>>#
>># Revision 8.2  2001/08/21 16:24:00  vsx
>># TSD4W.00170: give UNTESTED instead of UNRESOLVED if no usable input style supported
>>#
>># Revision 8.1  2001/04/05 12:04:25  vsx
>># TSD4W.00168: query supported input styles before XCreateIC()
>>#
>># Revision 8.0  1998/12/23 23:39:10  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:02:17  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:30:11  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:26:45  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.1  1998/01/21 01:38:44  tbr
>># Removed unnecessary dependency on XMODIFIERS
>>#
>># Revision 4.0  1995/12/15 09:24:46  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:02:25  andy
>># Prepare for GA Release
>>#
>>AVSCODE
>>TITLE XwcResetIC Xlib14
void
XwcResetIC()
>>EXTERN
#include <ximtest.h>

Display	   *display_good;
Window	window_id_good;

char *list, mod[256] ;
char *xmodifier ;
                                
/******
 * generated globals
 ******/
char *exec_file_name;
int x_init,
    y_init,
    h_init,
    w_init;

setup_locale()
{

    char *string ;

    if (setlocale(LC_ALL, "C") == (char *)0 )
       errflg++ ;

    if (!XSupportsLocale())
       errflg++ ;

    if ((string = XSetLocaleModifiers("") ) == (char *)0)
       errflg++ ;

    if (errflg)
       message("unable to setup locale setup_locale() function failed\n", NULL, 0) ;
}

svcwcResetIC(display, ic)
Display  *display ;
XIC  ic ;
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
		ss_status,			  /* save stat return status */	
		stat_status,			  /* check stat return status */
  		setup_status,
  		cleanup_status,
		i1;

        char   *svc_ret_value ;


	regr_args.l_flags.bufrout = 1;

	(void)strcpy(fmtstr, "*********************\n");
	message(fmtstr, fmt_lst, 0);
	(void)strcpy(fmtstr, "An error occurred during a call to %s\n\n");
	fmt_lst[0].typ_str = TestName;
	message(fmtstr, fmt_lst, 1);

        call_string = "svc_ret_value = XwcResetIC(";

	(void)strcpy(fmtstr, "The routine call looked like this - \n    %s\n");
	fmt_lst[0].typ_str = call_string;
 	message(fmtstr, fmt_lst, 1);

	call_string = "                ic)\n" ;
	message(call_string, fmt_lst, 0);
	(void)strcpy(fmtstr, "The parameter values were as follows... \n");
	message(fmtstr, fmt_lst, 0);
	bufrdisp(display); /* buffer display struct info for error checking */

	if (regr_args.iter == 0)   
	    regr_args.iter = 1;	/* set number of iterations to 1.	*/ 


	for (i1 = 0; i1 < regr_args.iter; i1++) 
        {


            if (regr_args.l_flags.setup) {
	    	setup_status = REGR_NORMAL;
                XSetInputFocus (display, None, RevertToNone, CurrentTime);
                XSelectInput (display, window_id_good, FocusChangeMask);
            }
           
	    XSync(display_arg, 0);

            if (regr_args.l_flags.chksta  == 1)
                ss_status = save_stat(dpy_msk | win_msk ,
		                       gc_id,
			               display_arg,
			               drawable_id);
                                                

	    first_error = 0;	/* no errors encountered yet */
  	    errflg = 0;
	    XSetErrorHandler(signal_status);
            XwcResetIC(ic) ;
            XSync(display_arg, 0);
	    XSetErrorHandler(unexp_err);          
	    r_wait(display_arg, window_arg, time_delay, None);	/* no colormap by default */
                                                           
	    if (regr_args.l_flags.chksta  == 1) 
                stat_status = chek_stat (dpy_msk | win_msk ,
		                	 gc_id,
					 display_arg,
					 drawable_id,
					 ss_status);
	    else                              
		stat_status = REGR_NORMAL;

	    if ((!errflg) && (!chkflg)) 
		if ((badstat(display_arg, estatus, Success)) != REGR_NORMAL)
		    errflg = 1;

	    if ((regr_args.l_flags.check) && 
		(errflg == 0) && 
		(stat_status == REGR_NORMAL)) {
                Window id ;
                XGetICValues(ic, XNFocusWindow, &id, (char *)0) ;
                check_dec(window_id_good, id, "expected window id") ;
	    } /* end if */ 

	    XSync(display_arg, 0);
	    if (regr_args.l_flags.cleanup) {
              XDestroyIC(ic) ;
	    }
	    XSync(display_arg, 0);
        } /* end of service test loop. */

	if (errflg) { 	/* if there was an error ...     */
	    errcnt++;   /* ...increment the error count  */
	    (void)strcpy(fmtstr, "\nEnd of error report\n");
	    message(fmtstr, fmt_lst, 0);
	    (void)strcpy(fmtstr, "*********************\n");
	    message(fmtstr, fmt_lst, 0);
        }

	/*****
 	* clear all flags
 	*****/
	chkflg = 0;
  	regr_args.l_flags.bufrout = 0;

        dumpbuf();
}   /* end of svcwcResetIC service routine */


>>ASSERTION Good C
If the implementation is X11R5 or later:
A call to xname shall reset the state of an input context to its initial state.
>>CODE

#if XT_X_RELEASE > 4
	display_arg = Dsp;
/*
 * Create a GC to save environmental data in
 */
	gc_save = XCreateGC(display_arg,XRootWindow(display_arg,XDefaultScreen(display_arg)),(unsigned long)0,(XGCValues *)0);


          BorderPixel = XBlackPixel(display_arg,XDefaultScreen(display_arg));
          BackgroundPixel = XWhitePixel(display_arg,XDefaultScreen(display_arg));
	  colormap_arg = XDefaultColormap(display_arg, XDefaultScreen(display_arg));
	  PixPerCM = XDisplayWidth(display_arg, XDefaultScreen(display_arg))*10/XDisplayWidthMM(display_arg,
					XDefaultScreen(display_arg));
	  MaxDisplayWidth  = XDisplayWidth(display_arg, XDefaultScreen(display_arg));
	  MaxDisplayHeight = XDisplayHeight(display_arg, XDefaultScreen(display_arg));
	  DisplayCenterX   = (MaxDisplayWidth / 2) - PixPerCM;
	  DisplayCenterY   = (MaxDisplayHeight / 2) - PixPerCM;
	  x_init = -1;
          y_init = -1;
          h_init = -1;
          w_init = -1;
          

	tet_infoline("PREP: Create a window for test.");
	  if (w_init == -1) w_init = (MaxDisplayWidth - (2 * PixPerCM));
	  if (h_init == -1) h_init = (MaxDisplayHeight - (2 * PixPerCM));
	  if (x_init == -1) x_init = PixPerCM - 5;
	  if (y_init == -1) y_init = PixPerCM - 5;
	  if ((window_arg = XCreateSimpleWindow(display_arg, 
				(Window)XRootWindow(display_arg, XDefaultScreen(display_arg)),
				x_init, y_init,
				(unsigned int)w_init, 
				(unsigned int)h_init,    
				BorderWidth,
				BorderPixel, 
				BackgroundPixel)) == NULL)
	{            
		tet_infoline("ERROR: Window creation failed.");
		tet_infoline("       Check x y w h values in change test");
		tet_result(TET_FAIL);
		return;
	}
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
	regr_args.iter = 1;		/* execute service once */
	estatus[0] = 1;

/******
 * User defined initialization code for test case sets
 ******/
	display_good = display_arg;
	window_id_good = window_arg;

            estatus[0] = 1;
            estatus[1] = Success;

	if ((regr_args.l_flags.good == 0) || (estatus[1] == Success)) {
                tet_infoline("TEST: XwcResetIC resets the state of an input");
		tet_infoline("       context to its initial state");
                regr_args.l_flags.setup = 1;
                regr_args.l_flags.cleanup = 1;
                regr_args.l_flags.check = 1;
                regr_args.l_flags.chksta = 0;
                {
                    XIM  input_method ;
                    XIC  input_context ;
		    XIMStyle which_style;

                    setup_locale() ;
                    input_method = XOpenIM(display_good, (XrmDatabase)0,
                                          (char *)0, (char *)0 ) ;

		    /* Find a supported style we can use */
		    /* NB PreeditNone and StatusNone are no good because
		       XNFocusWindow is ignored for that style */
		    reset_ic_style(input_method);
		    which_style = 0;
		    while (next_ic_style(&which_style)) {
			if ((which_style & XIMPreeditNone) == 0 &&
			    (which_style & XIMStatusNone) == 0)
			    break;
			which_style = 0;
		    }
		    if (which_style == 0) {
			tet_infoline("INFO: could not find a supported IM style the test can use");
			tet_result(TET_UNTESTED);
		    }
		    else if ((input_context = ic_open(input_method,
				window_id_good, which_style)) == NULL) {
			tet_infoline("ERROR: ic_open() returned NULL");
			tet_result(TET_UNRESOLVED);
		    }
		    else if (XSetICValues(input_context, XNFocusWindow,
				window_id_good, (char  *)0) != NULL) {
			tet_infoline("ERROR: XSetICValues() failed to set XNFocusWindow");
			tet_result(TET_UNRESOLVED);
		    }
		    else {
			svcwcResetIC(display_good, input_context) ;
			tet_result(TET_PASS);
		    }
                } 
	} /* end if */
#else
	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
