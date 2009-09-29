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

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: xts/Xlib14/XmbTextPropertyToTextList.m
>># 
>># Description:
>>#	Tests for XmbTextPropertyToTextList()
>># 
>># Modifications:
>># $Log: mbtpttl.m,v $
>># Revision 1.1  2005-02-12 14:37:22  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:38:59  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:02:05  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:30:00  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:26:34  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:24:06  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:01:52  andy
>># Prepare for GA Release
>>#
>>AVSCODE
>>TITLE XmbTextPropertyToTextList Xlib14
void
XmbTextPropertyToTextList()
>>EXTERN

/******
 * User defined globals for test
 ******/

/******
 * User defined globals for test case sets
 ******/
	Display	   *display_good;
                                
/******
 * generated globals
 ******/
char *exec_file_name;
int x_init,
    y_init,
    w_init,
    h_init;

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
 * svcmbTextPropertyToTextList routine 
 *****/                             
    svcmbTextPropertyToTextList(display, text_prop_good, list_good, count_good) 
    Display             *display ;
    XTextProperty	*text_prop_good ;
    char	**list_good ;
    int		count_good ;
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
        Status ret_status ;

        char *s  ;

	int
		ss_status,			  /* save stat return status */	
		stat_status,			  /* check stat return status */
  		setup_status,
  		cleanup_status,
		i1;

        list_good = &s ;


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


        call_string = "XmbTextPropertyToTextList(";

	(void)strcpy(fmtstr, "The routine call looked like this - \n    %s\n");
	fmt_lst[0].typ_str = call_string;
 	message(fmtstr, fmt_lst, 1);

	call_string = "display,text_prop, list, count);\n\n";
	message(call_string, fmt_lst, 0);
	(void)strcpy(fmtstr, "The parameter values were as follows... \n");
	message(fmtstr, fmt_lst, 0);
                                                                  
	bufrdisp(display_good);	/* buffer display struct info for error checking */
/******
 * If there is a pixmap_id parameter or a window_id parameter then
 * set variable drawable_id equal to it.
 ******/


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
            if (regr_args.l_flags.setup) 
	    	setup_status = REGR_NORMAL;
	    XSync(display_arg, 0);

/******
 * save environment 
 ******/                     
            if (regr_args.l_flags.chksta  == 1)
                ss_status = save_stat(dpy_msk ,
		                       gc_id,
			               display_arg,
			               drawable_id);
                                                

	    first_error = 0;	/* no errors encountered yet */
/******
 * service call
 ******/
                                                                               

  	    errflg = 0;
	    XSetErrorHandler(signal_status);

            ret_status = XmbTextPropertyToTextList(
                                 display,
                                 text_prop_good,
                                 (char ***)&list_good,
                                 (int *) &count_good
                                 );

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
                stat_status = chek_stat (dpy_msk ,
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
		(stat_status == REGR_NORMAL)) {

                if  ( ret_status != Success ) {
                    message("XmbTextPropertyToTextList failed: Expected zero returned non zero\n", NULL, 0);
                    errflg = 1 ;
                    }

                check_str( (unsigned char *)"This is a string list",
                list_good[0], "list_good[0]");

                check_dec(1, count_good, "count_good");

              }
	    XSync(display_arg, 0);

/******
 * cleanup code for this service.
 ******/
	    if (regr_args.l_flags.cleanup) {
		cleanup_status = REGR_NORMAL;
                XFreeStringList((char **)list_good);
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
    }   /* end of svcmbTextPropertyToTextList service routine */

>>ASSERTION Good C
If the implementation is X11R5 or later:
A call to xname shall convert an internationalized text property to a list of
multi-byte strings and return Success.
>>CODE

#if XT_X_RELEASE > 4
	display_arg = Dsp;
/*
 * Create a GC to save environmental data in
 */
	gc_save = XCreateGC(display_arg,XRootWindow(display_arg,XDefaultScreen(display_arg)),(unsigned long)0,(XGCValues *)0);

	regr_args.l_flags.check = 0;
	regr_args.l_flags.nostat = 0;
	regr_args.l_flags.perf = 0;
	regr_args.l_flags.setup = 0;
	regr_args.l_flags.cleanup = 0;
	regr_args.l_flags.chksta = 0;
	regr_args.l_flags.chkdpy = 0;
	regr_args.l_flags.verbose = 0;
	regr_args.iter = 1;		/* execute service once	*/
	estatus[0] = 1;

/******
 * User defined initialization code for test case sets
 ******/
	display_good = display_arg;

            estatus[0] = 1;
            estatus[1] = Success;

            if ((regr_args.l_flags.good == 0) || (estatus[1] == Success)) {
              tet_infoline("TEST: Set XTextProperty structure to string list");
                regr_args.l_flags.setup = 1;
                regr_args.l_flags.cleanup = 1;
                regr_args.l_flags.check = 1;
                regr_args.l_flags.chksta = 1;

                {

                    XTextProperty 	text_prop ;
                    int count ;
                    char **list ;

                    text_prop.value = (unsigned char *)"This is a string list" ;
                    text_prop.encoding = XA_STRING ;
                    text_prop.format = 8 ;
                    text_prop.nitems = strlen("This is a string list");

                    svcmbTextPropertyToTextList(
                         display_good,
                         &text_prop,
                         list,
                         count
                        );

                }
	} /* end if */
	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
