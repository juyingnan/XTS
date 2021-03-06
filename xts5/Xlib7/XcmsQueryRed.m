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
>># File: xts/Xlib7/XcmsQueryRed.m
>># 
>># Description:
>>#	Tests for XcmsQueryRed()
>># 
>># Modifications:
>># $Log: cmsqred.m,v $
>># Revision 1.1  2005-02-12 14:37:36  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:27:16  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:45:34  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:19:28  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:15:59  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 08:50:19  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  00:50:25  andy
>># Prepare for GA Release
>>#
>>AVSCODE
>>TITLE XcmsQueryRed Xlib7
XcmsQueryRed()
>>EXTERN

/******
 * User defined globals for test
 ******/

Bool  writeable_colormaps = 1;
          
/******
 * User defined globals for test case sets
 ******/
Display	   *display_good;
Visual     *visual_good ;
XcmsCCC    ccc_good ;
Colormap   colormap_good, colormap_return ;
XcmsColor  color_good ;
XcmsColorFormat format_good ;
XcmsColorFormat format_all[] = { XcmsRGBiFormat, } ;
int        screen_good ;
int        depth_good, i ;
                                
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
 * svccmsQueryRed routine 
 *****/                             
svccmsQueryRed(display, ccc, format, color)
Display              *display ;
XcmsCCC              ccc ;
XcmsColorFormat      format ;
XcmsColor            color ;
{
        extern int  errcnt;
        extern int  errflg;
        extern int  chkflg;
	extern int  signal_status();
	extern int  unexp_err();

	char fmtstr[256], *call_string;
	union msglst fmt_lst[1];        

	int
		ss_status,			  /* save stat return status */	
		stat_status,			  /* check stat return status */
		cleanup_status;

        Status           svc_ret_value;

	regr_args.l_flags.bufrout = 1;

	(void)strcpy(fmtstr, "*********************\n");
	message(fmtstr, fmt_lst, 0);
	(void)strcpy(fmtstr, "An error occurred during a call to %s\n\n");
	fmt_lst[0].typ_str = TestName;
	message(fmtstr, fmt_lst, 1);


        call_string = "svc_ret_value = XcmsQueryRed(";

	(void)strcpy(fmtstr, "The routine call looked like this - \n    %s\n");
	fmt_lst[0].typ_str = call_string;
 	message(fmtstr, fmt_lst, 1);

	call_string = "		 ccc, format, colormap);\n\n";
	message(call_string, fmt_lst, 0);
	(void)strcpy(fmtstr, "The parameter values were as follows... \n");
	message(fmtstr, fmt_lst, 0);
                                                                  
	bufrdisp(display); /* buffer display struct info for error checking */
        {
            char *fmt_string;
            union msglst f_lst[1];

            f_lst[0].typ_uns = format ;
            fmt_string = "\n    format= %u\n" ;
            message(fmt_string, f_lst, 1);

        }

        if (regr_args.l_flags.chksta  == 1)
                ss_status = save_stat(dpy_msk | win_msk, gc_id,
			               display_arg, drawable_id);
                                                
	first_error = 0;	/* no errors encountered yet */
							       
	svc_ret_value = 0 ;
	errflg = 0;
	XSetErrorHandler(signal_status);
	svc_ret_value = XcmsQueryRed(ccc, format, &color);
	XSync(display_arg, 0);
	XSetErrorHandler(unexp_err);          
	r_wait(display_arg, window_arg, time_delay, None);	/* no colormap by default */
	if (regr_args.l_flags.chksta  == 1) 
		stat_status = chek_stat (dpy_msk | win_msk , gc_id,
				 display_arg, drawable_id, ss_status);
	else                              
		stat_status = REGR_NORMAL;

	if ((!errflg) && (!chkflg)) 
		if ((badstat(display_arg, estatus, Success)) != REGR_NORMAL)
    			errflg = 1;

	if ((regr_args.l_flags.check) &&
		(errflg == 0) &&
		(stat_status == REGR_NORMAL))
	{
		double one = 1.000000 ;
		double zero = 0.000000 ;

		check_dec(XcmsSuccess, svc_ret_value, "return value" ) ;
		if ((svc_ret_value = XcmsSuccess ) && 
     		    (format == XcmsRGBiFormat))
		{
     			check_dou(one, color.spec.RGBi.red, "red" ) ;
     			check_dou(zero, color.spec.RGBi.green, "green" ) ;
     			check_dou(zero, color.spec.RGBi.blue, "blue" ) ;
		}
	}
	XSync(display_arg, 0);

	if (regr_args.l_flags.cleanup)
		cleanup_status = REGR_NORMAL;
	XSync(display_arg, 0);

	/* if there was an error ...     */
	if (errflg)
	{
	    errcnt++;   /* ...increment the error count  */
	    (void)strcpy(fmtstr, "\nEnd of error report\n");
	    message(fmtstr, fmt_lst, 0);
	    (void)strcpy(fmtstr, "*********************\n");
	    message(fmtstr, fmt_lst, 0);
        }
	chkflg = 0;
  	regr_args.l_flags.bufrout = 0;

        dumpbuf();
}


>>ASSERTION Good C
If the implementation is X11R5 or later:
A call to xname shall return the device-independent color specification
for the specified target format for full intensity red and zero intensity
green and blue.
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
	regr_args.iter = 1;	/* execute service once	*/
	estatus[0] = 1;


	display_good = display_arg;
        screen_good = XDefaultScreen(display_good);
        depth_good = DisplayPlanes( display_good, screen_good );
        visual_good = XDefaultVisual(display_good, screen_good );

        if ((visual_good->class == StaticGray) ||
              (visual_good->class == StaticColor) ||
              (visual_good->class == TrueColor))
            writeable_colormaps = 0 ;

        if (writeable_colormaps)
	{
           colormap_good = XDefaultColormap(display_good, screen_good );
           ccc_good = XcmsCCCOfColormap(display_good, colormap_good) ;
        }

        if (writeable_colormaps) 
	{
            estatus[0] = 1;
            estatus[1] = Success;

            if ((regr_args.l_flags.good == 0) || (estatus[1] == Success)) {
                tet_infoline("TEST: Testing XcmsQueryRed for Success\n");
                regr_args.l_flags.check = 1;
                regr_args.l_flags.setup = 1;
                regr_args.l_flags.cleanup = 1;
                regr_args.l_flags.chksta = 0;
                regr_args.l_flags.chkdpy = 0;

                {
                    format_good = XcmsRGBiFormat ;
                    svccmsQueryRed(display_good, ccc_good,
                         format_good, color_good);

                }
	    } /* end if */
        }
	else
		message("Warning: not a writeable colormap\n", NULL, 0) ;
	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
