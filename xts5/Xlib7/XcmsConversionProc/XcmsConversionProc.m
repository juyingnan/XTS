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
>># File: tset/Xlib7/XcmsConversionProc/XcmsConversionProc.m
>># 
>># Description:
>>#	Tests for XcmsConversionProc()
>># 
>># Modifications:
>># $Log: cmscproc.m,v $
>># Revision 1.1  2005-02-12 14:37:35  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:27:06  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:45:24  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:19:19  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:15:50  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 08:49:46  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  00:49:26  andy
>># Prepare for GA Release
>>#
>>AVSCODE
>>TITLE XcmsConversionProc Xlib7
XcmsConversionProc()
>>EXTERN

Bool  writeable_colormaps = 1;
Display	   *display_good;
Visual     *visual_good ;
XcmsCCC    ccc_good ;
Colormap   colormap_good, colormap_return ;
Colormap   rw_colormap ;
XcmsColor  color_good[2] ;
XcmsColor  white_point[2] ;
XcmsColor    *white_ptr ;
XcmsColorFormat format_good ;
int        screen_good ;
int        depth_good ;
unsigned int   ncolors ;
/*
Bool     compression_flags_return[] ;
*/

int (*XcmsConversionFunc)() ;

char *exec_file_name;
int x_init, y_init, h_init, w_init;

svccmsConversionProc(display, ccc, white_point, colors, num)
Display              *display ;
XcmsCCC              ccc ;
XcmsColor            white_point[] ;
XcmsColor            colors[] ;
unsigned int         num ;
{
        extern int  errcnt;
        extern int  errflg;
        extern int  chkflg;
	extern int  signal_status();
	extern int  unexp_err();
	extern char *svc_user_arg;

/******
 * local storage 
 ******/
	char fmtstr[256], *call_string;
	union msglst fmt_lst[1];        
        int skip_pixcheck;

	int
		ss_status,			  /* save stat return status */	
		stat_status,			  /* check stat return status */
  		setup_status,
  		cleanup_status,
		i1;

        Status           svc_ret_value;


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


        call_string = "svc_ret_value = XcmsConversionProc(";

	(void)strcpy(fmtstr, "The routine call looked like this - \n    %s\n");
	fmt_lst[0].typ_str = call_string;
 	message(fmtstr, fmt_lst, 1);

	call_string = "		ccc, white_point, colors, ncolors);\n\n";
	message(call_string, fmt_lst, 0);
	(void)strcpy(fmtstr, "The parameter values were as follows... \n");
	message(fmtstr, fmt_lst, 0);
                                                                  
	bufrdisp(display); /* buffer display struct info for error checking */

/******
 * Setup code for this service - this should always be executed.
 ******/

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
                                                                               
            svc_ret_value = 0 ;
  	    errflg = 0;
	    XSetErrorHandler(signal_status);
            svc_ret_value = XcmsConversionFunc(ccc, &white_point[0], colors, num) ;
            XSync(display_arg, 0);
	    XSetErrorHandler(unexp_err);          
	    r_wait(display_arg, window_arg, time_delay, None);	/* no colormap by default */
                                                           
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
                check_dec(XcmsSuccess, svc_ret_value, "return value") ;
              }
	    XSync(display_arg, 0);

/******
 * cleanup code for this service.
 ******/
	    if (regr_args.l_flags.cleanup)
              {
		cleanup_status = REGR_NORMAL;
              }
	    XSync(display_arg, 0);

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
}

>>ASSERTION Good C
If the implementation is X11R5 or later:
A call to xname
shall convert color specifications from XcmsCIELab to XcmsCIELXYZ.
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

        if ( writeable_colormaps ) {
           colormap_good = XCreateColormap(
                                display_good,
                                XRootWindow(display_good, screen_good),
                                visual_good,
                                AllocAll);
           ccc_good = XcmsCCCOfColormap(display_good, colormap_good) ;
        }

        if (writeable_colormaps)
	{

            estatus[0] = 1;
            estatus[1] = Success;

		if ((regr_args.l_flags.good == 0) || (estatus[1] == Success))
		{
                	tet_infoline("TEST: Testing XcmsCIELabToCIEXYZ for Success\n");
			regr_args.l_flags.check = 1;
			regr_args.l_flags.setup = 1;
			regr_args.l_flags.cleanup = 1;
			regr_args.l_flags.chksta = 0;
			regr_args.l_flags.chkdpy = 0;

			{
			    color_good[0].format = XcmsCIELabFormat ;
			    color_good[0].spec.CIELab.L_star = 1.8 ;
			    color_good[0].spec.CIELab.a_star = 0.6 ;
			    color_good[0].spec.CIELab.b_star = 1.4 ;
			    white_point[0].format = XcmsCIEXYZFormat ;
			    white_point[0].spec.CIEXYZ.X = 1.0 ;
			    white_point[0].spec.CIEXYZ.Y = 1.0 ;
			    white_point[0].spec.CIEXYZ.Z = 1.0 ;
			    ncolors = 1 ;
			    XcmsConversionFunc = XcmsCIELabToCIEXYZ ;
			    svccmsConversionProc(
				 display_good,
				 ccc_good,
				 &white_point[0],
				 &color_good[0],
				 ncolors
				);
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
>>ASSERTION Good C
If the implementation is X11R5 or later:
A call to xname
shall convert color specifications from XcmsCIELuv to XcmsCIEuvY.
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

        if ( writeable_colormaps ) {
           colormap_good = XCreateColormap(
                                display_good,
                                XRootWindow(display_good, screen_good),
                                visual_good,
                                AllocAll);
           ccc_good = XcmsCCCOfColormap(display_good, colormap_good) ;
        }

        if (writeable_colormaps)
	{
            estatus[0] = 1;
            estatus[1] = Success;

            if ((regr_args.l_flags.good == 0) || (estatus[1] == Success))
	    {
                tet_infoline("TEST: Testing XcmsCIELuvToCIEuvY for Success\n");
                regr_args.l_flags.check = 1;
                regr_args.l_flags.setup = 1;
                regr_args.l_flags.cleanup = 1;
                regr_args.l_flags.chksta = 0;
                regr_args.l_flags.chkdpy = 0;

                {
                    color_good[0].format = XcmsCIELuvFormat ;
                    color_good[0].spec.CIELuv.L_star = 100.0 ;
                    color_good[0].spec.CIELuv.u_star = 100.0 ;
                    color_good[0].spec.CIELuv.v_star = 100.0 ;
                    white_point[0].format = XcmsCIEXYZFormat ;
                    white_point[0].spec.CIEXYZ.X = 1.0 ;
                    white_point[0].spec.CIEXYZ.Y = 1.0 ;
                    white_point[0].spec.CIEXYZ.Z = 1.0 ;
                    ncolors = 1 ;
                    XcmsConversionFunc = XcmsCIELuvToCIEuvY ;
                    svccmsConversionProc(
                         display_good,
                         ccc_good,
                         &white_point[0],
                         &color_good[0],
                         ncolors
                        );

                }
	    } /* end if */
        } else
          message("Warning: not a writeable colormap\n", NULL, 0) ;
	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
>>ASSERTION Good C
If the implementation is X11R5 or later:
A call to xname
shall convert color specifications from XcmsCIEXYZ to XcmsCIELab.
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

        if ( writeable_colormaps ) {
           colormap_good = XCreateColormap(
                                display_good,
                                XRootWindow(display_good, screen_good),
                                visual_good,
                                AllocAll);
           ccc_good = XcmsCCCOfColormap(display_good, colormap_good) ;
        }

        message("Assertion #3\n", NULL, 0);
        if ( writeable_colormaps ) {
            estatus[0] = 1;
            estatus[1] = Success;

            if ((regr_args.l_flags.good == 0) || (estatus[1] == Success))
	    {
                tet_infoline("TEST: Testing XcmsCIEXYZToCIELab for Success\n");
                regr_args.l_flags.check = 1;
                regr_args.l_flags.setup = 1;
                regr_args.l_flags.cleanup = 1;
                regr_args.l_flags.chksta = 0;
                regr_args.l_flags.chkdpy = 0;

                {
                    color_good[0].format = XcmsCIEXYZFormat ;
                    color_good[0].spec.CIEXYZ.X = 1.0 ;
                    color_good[0].spec.CIEXYZ.Y = 1.0 ;
                    color_good[0].spec.CIEXYZ.Z = 1.0 ;
                    white_point[0].format = XcmsCIEXYZFormat ;
                    white_point[0].spec.CIEXYZ.X = 1.0 ;
                    white_point[0].spec.CIEXYZ.Y = 1.0 ;
                    white_point[0].spec.CIEXYZ.Z = 1.0 ;
                    ncolors = 1 ;
                    XcmsConversionFunc = XcmsCIEXYZToCIELab ;
                    svccmsConversionProc(
                         display_good,
                         ccc_good,
                         &white_point[0],
                         &color_good[0],
                         ncolors
                        );

                }
	    } /* end if */
        } else
          message("Warning: not a writeable colormap\n", NULL, 0) ;

	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
>>ASSERTION Good C
If the implementation is X11R5 or later:
A call to xname
shall convert color specifications from XcmsCIEXYZ to XcmsCIELuvY.
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

        if ( writeable_colormaps ) {
           colormap_good = XCreateColormap(
                                display_good,
                                XRootWindow(display_good, screen_good),
                                visual_good,
                                AllocAll);
           ccc_good = XcmsCCCOfColormap(display_good, colormap_good) ;
        }

        if (writeable_colormaps) 
	{
            estatus[0] = 1;
            estatus[1] = Success;

            if ((regr_args.l_flags.good == 0) || (estatus[1] == Success))
	    {
                tet_infoline("TEST: Testing XcmsCIEXYZToCIEuvY for Success\n");

                regr_args.l_flags.check = 1;
                regr_args.l_flags.setup = 1;
                regr_args.l_flags.cleanup = 1;
                regr_args.l_flags.chksta = 0;
                regr_args.l_flags.chkdpy = 0;

                {
                    color_good[0].format = XcmsCIEXYZFormat ;
                    color_good[0].spec.CIEXYZ.X = 1.0 ;
                    color_good[0].spec.CIEXYZ.Y = 1.0 ;
                    color_good[0].spec.CIEXYZ.Z = 1.0 ;
                    white_point[0].format = XcmsCIEXYZFormat ;
                    white_point[0].spec.CIEXYZ.X = 1.0 ;
                    white_point[0].spec.CIEXYZ.Y = 1.0 ;
                    white_point[0].spec.CIEXYZ.Z = 1.0 ;
                    ncolors = 1 ;
                    XcmsConversionFunc = XcmsCIEXYZToCIEuvY ;
                    svccmsConversionProc(
                         display_good,
                         ccc_good,
                         &white_point[0],
                         &color_good[0],
                         ncolors
                        );

                }
	    } /* end if */
        } else
          message("Warning: not a writeable colormap\n", NULL, 0) ;

	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
>>ASSERTION Good C
If the implementation is X11R5 or later:
A call to xname
shall convert color specifications from XcmsCIEXYZ to XcmsCIExyY.
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

        if ( writeable_colormaps ) {
           colormap_good = XCreateColormap(
                                display_good,
                                XRootWindow(display_good, screen_good),
                                visual_good,
                                AllocAll);
           ccc_good = XcmsCCCOfColormap(display_good, colormap_good) ;
        }

        if (writeable_colormaps) 
	{
            estatus[0] = 1;
            estatus[1] = Success;

            if ((regr_args.l_flags.good == 0) || (estatus[1] == Success))
	    {
                tet_infoline("TEST: Testing XcmsCIEXYZToCIExyY for Success\n");
                regr_args.l_flags.check = 1;
                regr_args.l_flags.setup = 1;
                regr_args.l_flags.cleanup = 1;
                regr_args.l_flags.chksta = 0;
                regr_args.l_flags.chkdpy = 0;

                {
                    color_good[0].format = XcmsCIEXYZFormat ;
                    color_good[0].spec.CIEXYZ.X = 1.0 ;
                    color_good[0].spec.CIEXYZ.Y = 1.0 ;
                    color_good[0].spec.CIEXYZ.Z = 1.0 ;
                    white_point[0].format = XcmsCIEXYZFormat ;
                    white_point[0].spec.CIEXYZ.X = 1.0 ;
                    white_point[0].spec.CIEXYZ.Y = 1.0 ;
                    white_point[0].spec.CIEXYZ.Z = 1.0 ;
                    ncolors = 1 ;
                    XcmsConversionFunc = XcmsCIEXYZToCIExyY ;
                    svccmsConversionProc(
                         display_good,
                         ccc_good,
                         &white_point[0],
                         &color_good[0],
                         ncolors
                        );

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
>>ASSERTION Good C
If the implementation is X11R5 or later:
A call to xname shall convert color specifications from XcmsCIEXYZ
to XcmsCIExyY.
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

        if ( writeable_colormaps ) {
           colormap_good = XCreateColormap(
                                display_good,
                                XRootWindow(display_good, screen_good),
                                visual_good,
                                AllocAll);
           ccc_good = XcmsCCCOfColormap(display_good, colormap_good) ;
        }
        message("Assertion #6\n", NULL, 0);
        if (writeable_colormaps)
	{

            estatus[0] = 1;
            estatus[1] = Success;

            if ((regr_args.l_flags.good == 0) || (estatus[1] == Success)) 
	    {
                tet_infoline("TEST: Testing XcmsCIEuvYToCIELuv for Success\n");
                regr_args.l_flags.check = 1;
                regr_args.l_flags.setup = 1;
                regr_args.l_flags.cleanup = 1;
                regr_args.l_flags.chksta = 0;
                regr_args.l_flags.chkdpy = 0;

                {
                    color_good[0].format = XcmsCIEuvYFormat ;
                    color_good[0].spec.CIEuvY.u_prime = 0.6 ;
                    color_good[0].spec.CIEuvY.v_prime = 0.6 ;
                    color_good[0].spec.CIEuvY.Y = 1.0 ;
                    white_point[0].format = XcmsCIEXYZFormat ;
                    white_point[0].spec.CIEXYZ.X = 1.0 ;
                    white_point[0].spec.CIEXYZ.Y = 1.0 ;
                    white_point[0].spec.CIEXYZ.Z = 1.0 ;
                    ncolors = 1 ;
                    XcmsConversionFunc = XcmsCIEuvYToCIELuv ;
                    svccmsConversionProc(display_good, ccc_good, &white_point[0],
                         &color_good[0], ncolors);

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
>>ASSERTION Good C
If the implementation is X11R5 or later:
A call to xname
shall convert color specifications from XcmsCIEuvY to XcmsCIEXYZ.
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

        if ( writeable_colormaps ) {
           colormap_good = XCreateColormap(
                                display_good,
                                XRootWindow(display_good, screen_good),
                                visual_good,
                                AllocAll);
           ccc_good = XcmsCCCOfColormap(display_good, colormap_good) ;
        }
        message("Assertion #7\n", NULL, 0);
        if (writeable_colormaps) 
	{

            estatus[0] = 1;
            estatus[1] = Success;

            if ((regr_args.l_flags.good == 0) || (estatus[1] == Success)) {
                tet_infoline("TEST: Testing XcmsCIEuvYToCIEXYZ for Success\n");
                regr_args.l_flags.check = 1;
                regr_args.l_flags.setup = 1;
                regr_args.l_flags.cleanup = 1;
                regr_args.l_flags.chksta = 0;
                regr_args.l_flags.chkdpy = 0;

                {
                    color_good[0].format = XcmsCIEuvYFormat ;
                    color_good[0].spec.CIEuvY.u_prime = 1.0 ;
                    color_good[0].spec.CIEuvY.v_prime = 1.0 ;
                    color_good[0].spec.CIEuvY.Y = 1.0 ;
                    white_point[0].format = XcmsCIEXYZFormat ;
                    white_point[0].spec.CIEXYZ.X = 1.0 ;
                    white_point[0].spec.CIEXYZ.Y = 1.0 ;
                    white_point[0].spec.CIEXYZ.Z = 1.0 ;
                    ncolors = 1 ;
                    XcmsConversionFunc = XcmsCIEuvYToCIEXYZ ;
                    svccmsConversionProc(
                         display_good,
                         ccc_good,
                         &white_point[0],
                         &color_good[0],
                         ncolors
                        );

                }
	    } /* end if */
        } else
          message("Warning: not a writeable colormap\n", NULL, 0) ;
	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
>>ASSERTION Good C
If the implementation is X11R5 or later:
A call to xname
shall convert color specifications from XcmsCIExyY to XcmsCIEXYZ.
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

        if ( writeable_colormaps ) {
           colormap_good = XCreateColormap(
                                display_good,
                                XRootWindow(display_good, screen_good),
                                visual_good,
                                AllocAll);
           ccc_good = XcmsCCCOfColormap(display_good, colormap_good) ;
        }

        if (writeable_colormaps) 
	{
            estatus[0] = 1;
            estatus[1] = Success;

            if ((regr_args.l_flags.good == 0) || (estatus[1] == Success)) 
	    {
                tet_infoline("TEST: Testing XcmsCIExyYToCIEXYZ for Success\n");
                regr_args.l_flags.check = 1;
                regr_args.l_flags.setup = 1;
                regr_args.l_flags.cleanup = 1;
                regr_args.l_flags.chksta = 0;
                regr_args.l_flags.chkdpy = 0;

                {
                    color_good[0].format = XcmsCIExyYFormat ;
                    color_good[0].spec.CIExyY.x = 0.75 ;
                    color_good[0].spec.CIExyY.y = 0.85 ;
                    color_good[0].spec.CIExyY.Y = 1.0 ;
                    white_point[0].format = XcmsCIEXYZFormat ;
                    white_point[0].spec.CIEXYZ.X = 1.0 ;
                    white_point[0].spec.CIEXYZ.Y = 1.0 ;
                    white_point[0].spec.CIEXYZ.Z = 1.0 ;
                    ncolors = 1 ;
                    XcmsConversionFunc = XcmsCIExyYToCIEXYZ ;
                    svccmsConversionProc(
                         display_good,
                         ccc_good,
                         &white_point[0],
                         &color_good[0],
                         ncolors
                        );

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
>>ASSERTION Good C
If the implementation is X11R5 or later:
A call to xname
shall convert color specifications from XcmsTekHVC to XcmsCIEuvY.
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

        if ( writeable_colormaps ) {
           colormap_good = XCreateColormap(
                                display_good,
                                XRootWindow(display_good, screen_good),
                                visual_good,
                                AllocAll);
           ccc_good = XcmsCCCOfColormap(display_good, colormap_good) ;
        }

        if (writeable_colormaps) 
	{

            estatus[0] = 1;
            estatus[1] = Success;

            if ((regr_args.l_flags.good == 0) || (estatus[1] == Success)) 
	    {
                tet_infoline("TEST: Testing XcmsTekHVCToCIEuvY for Success\n");
                regr_args.l_flags.check = 1;
                regr_args.l_flags.setup = 1;
                regr_args.l_flags.cleanup = 1;
                regr_args.l_flags.chksta = 0;
                regr_args.l_flags.chkdpy = 0;

                {
                    color_good[0].format = XcmsTekHVCFormat ;
                    color_good[0].spec.TekHVC.H = 360.0 ;
                    color_good[0].spec.TekHVC.V = 100.0 ;
                    color_good[0].spec.TekHVC.C = 100.0 ;
                    white_point[0].format = XcmsCIEXYZFormat ;
                    white_point[0].spec.CIEXYZ.X = 1.0 ;
                    white_point[0].spec.CIEXYZ.Y = 1.0 ;
                    white_point[0].spec.CIEXYZ.Z = 1.0 ;
                    ncolors = 1 ;
                    XcmsConversionFunc = XcmsTekHVCToCIEuvY ;
                    svccmsConversionProc(
                         display_good,
                         ccc_good,
                         &white_point[0],
                         &color_good[0],
                         ncolors
                        );

                }
	    } /* end if */
        } else
          message("Warning: not a writeable colormap\n", NULL, 0) ;

	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
