Copyright (c) 2005 X.Org Foundation LLC

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
$Header: /cvs/xtest/xtest/xts5/tset/Xlib14/uicfoc/uicfoc.m,v 1.1 2005-02-12 14:37:22 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xlib14/uicfoc/uicfoc.m
>># 
>># Description:
>>#	Tests for XUnsetICFocus()
>># 
>># Modifications:
>># $Log: uicfoc.m,v $
>># Revision 1.1  2005-02-12 14:37:22  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:39:03  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:02:09  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:30:04  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:26:37  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:24:17  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:02:05  andy
>># Prepare for GA Release
>>#
>>AVSCODE
>>TITLE XUnsetICFocus Xlib14
void
XUnsetICFocus()
>>EXTERN

/******
 * User defined globals for test
 ******/


/******
 * User defined globals for test case sets
 ******/
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

/******
 * routines
 ******/


/*****
 * routine to modify saved information prior to chekstat call
 *****/
    mod_stat()
    {
	extern Display *dpy_save;
	extern Window wid_save;
	extern Pixmap pid_save;
	extern GC gc_save;
	extern XWindowAttributes wat_save;

        /*
         * insert modifications to saved data here
         */
    }

/*****
 * svcUnsetICFocus routine 
 *****/                             
    svcUnsetICFocus(ic_value)
    XIC   ic_value ;
    {
/*****
 * external defs
 *****/
        extern int  errcnt;
        extern int  errflg;
        extern int  chkflg;
	extern int  signal_status();
	extern int  unexp_err();
	extern char *svc_user_arg;
	extern char *strcpy();

/******
 * local storage 
 ******/
	char fmtstr[256], *call_string;
	union msglst fmt_lst[1];        
        int skip_pixcheck;
        XIM   im_value ;
        Window ret_window ;

	int
		ss_status,			  /* save stat return status */	
		stat_status,			  /* check stat return status */
  		setup_status,
  		cleanup_status,
		i1;

        char          *locale ;
        char  **list_return ;
        int   count_return ;
        char *def_string_return ;
        char *svc_ret_value ;


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

        call_string = "XUnsetICFocus(";

	(void)strcpy(fmtstr, "The routine call looked like this - \n    %s\n");
	fmt_lst[0].typ_str = call_string;
 	message(fmtstr, fmt_lst, 1);

	call_string = "                ic_value, ...)\n" ;
	message(call_string, fmt_lst, 0);
	(void)strcpy(fmtstr, "The parameter values were as follows... \n");
	message(fmtstr, fmt_lst, 0);
	bufrdisp(display_arg); /* buffer display struct info for error checking */

/******
 * Make sure we invoke the service at least once
 ******/
	                  
	if (regr_args.iter == 0)   
	    regr_args.iter = 1;	/* set number of iterations to 1.	*/ 

/******
 * iteration loop
 ******/

	for (i1 = 0; i1 < regr_args.iter; i1++) 
        {

/******
 * setup code for this service.
 ******/
            if (regr_args.l_flags.setup) {
	    	setup_status = REGR_NORMAL;

                if (setlocale(LC_CTYPE, "C" ) == NULL ) {
                    message("cannot set locale\n", NULL, 0) ;
                    exit(1) ;
                }
                if (!XSupportsLocale()) {
                    message("Does not support locale\n", NULL, 0);
                    errflg = errflg + 1 ;
                    exit(1) ;
                }
                if ((list = (char  *)XSetLocaleModifiers("")) == NULL ) {
                    message("cannot setlocale modifier\n", NULL, 0) ;
                    errflg = errflg + 1 ;
                }
                im_value = (XIM)malloc(sizeof(XIM));
                /* get the default im */
                im_value = XOpenIM(display_arg, NULL, NULL, NULL) ;
                if (im_value == NULL ) {
                    message("cannot create im_value\n", NULL, 0) ;
                    errflg = errflg + 1 ;
                }
                ic_value = XCreateIC(im_value, XNClientWindow, window_id_good,
                                 (char *)NULL) ;
                if (ic_value == NULL) {
                    message("cannot create ic_value\n", NULL, 0) ;
                    errflg = errflg + 1 ;
                }
            }
	    XSync(display_arg, 0);

/******
 * save environment 
 ******/                     
            if (regr_args.l_flags.chksta  == 1)
                ss_status = save_stat(dpy_msk | win_msk ,
		                       gc_id,
			               display_arg,
			               drawable_id);
                                                

	    first_error = 0;	/* no errors encountered yet */
/******
 * service call
 ******/
                                                                               

  	    errflg = 0;
	    XSetErrorHandler(signal_status);
            XUnsetICFocus(ic_value) ;
            XSync(display_arg, 0);
	    XSetErrorHandler(unexp_err);          
	    r_wait(display_arg, window_arg, time_delay, None);	/* no colormap by default */
                                                           
/******
 * mod_stat call
 ******/
                                                                               
            mod_stat();

                                                           
/******
 * check saved environment with current environment.
 ******/
	    if (regr_args.l_flags.chksta  == 1) 
                stat_status = chek_stat (dpy_msk | win_msk ,
		                	 gc_id,
					 display_arg,
					 drawable_id,
					 ss_status);
	    else                              
		stat_status = REGR_NORMAL;

/******
 * check Success returns with expected returns
 ******/
	    if ((!errflg) && (!chkflg)) 
		if ((badstat(display_arg, estatus, Success)) != REGR_NORMAL)
		    errflg = 1;

    

/******
 * verify the results of the service if successful completion.
 ******/

	    if ((regr_args.l_flags.check) && 
		(errflg == 0) && 
		(stat_status == REGR_NORMAL)) 
  	    {
               XGetICValues(ic_value, XNFocusWindow, &ret_window) ;
               check_dec(window_id_good, ret_window, "window id") ;
	    } /* end if */ 

	    XSync(display_arg, 0);
	    if (regr_args.l_flags.cleanup) {
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
}   /* end of svcUnsetICFocus service routine */


>>ASSERTION Good C
If the implementation is X11R5 or later:
A call to xname
shall allow a client to notify an input method that the
specified input context has lost a keyboard focus and that no more
input is expected on the foucs window attached to that input context.
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

	display_good = display_arg;
	window_id_good = window_arg;

            estatus[0] = 1;
            estatus[1] = Success;

            if ((regr_args.l_flags.good == 0) || (estatus[1] == Success)) {
                tet_infoline("TEST: Testcase for success");
                regr_args.l_flags.setup = 1;
                regr_args.l_flags.cleanup = 0;
                regr_args.l_flags.check = 0;
                regr_args.l_flags.chksta = 0;
                if ( (xmodifier = (char *)getenv("XMODIFIERS") ) != (char *)0)
                {
                    XIC ic ;
                    svcUnsetICFocus(ic);
                } else
                 message("Warning:No input method supported call untestable\n", NULL, 0);
	} /* end if */
	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
