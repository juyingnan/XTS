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
$Header: /cvs/xtest/xtest/xts5/tset/Xlib7/cmsstcls/cmsstcls.m,v 1.1 2005-02-12 14:37:36 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xlib7/cmsstcls/cmsstcls.m
>># 
>># Description:
>>#	Tests for XcmsStoreColors()
>># 
>># Modifications:
>># $Log: cmsstcls.m,v $
>># Revision 1.1  2005-02-12 14:37:36  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:27:18  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:45:36  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:19:30  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:16:00  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 08:50:26  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  00:50:38  andy
>># Prepare for GA Release
>>#
>>AVSCODE
>>TITLE XcmsStoreColors Xlib7
XcmsStoreColors()
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
Colormap   colormap_good ;
Colormap   colormap_dfl ;
XcmsColor  color_good, color_return ;
XcmsColorFormat format_good ;
int        screen_good ;
int        depth_good ;
XcmsColor  color_array[2] ;
XcmsColor  write_many_color[2] ;
XcmsColor  query_many_color[2] ;
XcmsColor  scrnColor, exactColor ;
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
 * svccmsStoreColors routine 
 *****/                             
svccmsStoreColors(display, colormap, colors, ncolors, flags_return)
Display              *display ;
Colormap             colormap ;
XcmsColor            colors[2] ;
unsigned int         ncolors ;
Bool                 flags_return[] ;
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


        call_string = "svc_ret_value = XcmsStoreColors(";

	(void)strcpy(fmtstr, "The routine call looked like this - \n    %s\n");
	fmt_lst[0].typ_str = call_string;
 	message(fmtstr, fmt_lst, 1);

	call_string = "		display, colormap, colors, ncolors, flags);\n\n";
	message(call_string, fmt_lst, 0);
	(void)strcpy(fmtstr, "The parameter values were as follows... \n");
	message(fmtstr, fmt_lst, 0);
                                                                  
	bufrdisp(display); /* buffer display struct info for error checking */
        {
            char *fmt_string;
            union msglst f_lst[1];

            f_lst[0].typ_dec = colormap ;
            fmt_string = "\n    colormap= %d\n" ;
            message(fmt_string, f_lst, 1);

        }
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
            svc_ret_value = XcmsStoreColors(
                                display, 
                                colormap,
                                &colors[0],
                                ncolors,
                                (Bool *)0
                                );
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
                check_dec(XcmsSuccess, svc_ret_value, "return value" ) ;
                format_good = XcmsRGBFormat ;
                query_many_color[0].pixel = 10 ;
                query_many_color[0].format = XcmsRGBFormat ;
                query_many_color[1].pixel = 11 ;
                query_many_color[1].format = XcmsRGBFormat ;
                XcmsQueryColors(display_good, colormap,
                          &query_many_color[0], (unsigned int)2, format_good) ;
                check_dec(0xff00, colors[0].spec.RGB.red, "red") ;
                check_dec(0x0000, colors[0].spec.RGB.green, "green") ;
                check_dec(0x0000, colors[0].spec.RGB.blue, "blue") ;
                check_dec(0x0000, colors[1].spec.RGB.red, "red") ;
                check_dec(0xff00, colors[1].spec.RGB.green, "green") ;
                check_dec(0x0000, colors[1].spec.RGB.blue, "blue") ;
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
shall convert the colors specified in the array of
.A XcmsColor
structure into RGB values for the pixels and return XcmsSuccess.
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


/******
 * User defined initialization code for test case sets
 ******/
	display_good = display_arg;

/*****
 * Test wide set up
 *****/

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
        }

        if ( writeable_colormaps ) {

            estatus[0] = 1;
            estatus[1] = Success;

            if ((regr_args.l_flags.good == 0) || (estatus[1] == Success)) {
/********************/
                step ("Testing XcmsStoreColors for Success\n");
/********************/
                regr_args.l_flags.check = 1;
                regr_args.l_flags.setup = 1;
                regr_args.l_flags.cleanup = 1;
                regr_args.l_flags.chksta = 0;
                regr_args.l_flags.chkdpy = 0;

                {
                    write_many_color[0].format = XcmsRGBFormat ;
                    write_many_color[0].pixel = 10 ;
                    write_many_color[0].spec.RGB.red  = 0xff00 ;
                    write_many_color[0].spec.RGB.green  = 0x0000 ;
                    write_many_color[0].spec.RGB.blue  = 0x00000 ;
                    write_many_color[1].format = XcmsRGBFormat ;
                    write_many_color[1].pixel = 11 ;
                    write_many_color[1].spec.RGB.red  = 0x0000 ;
                    write_many_color[1].spec.RGB.green  = 0xff00 ;
                    write_many_color[1].spec.RGB.blue  = 0x0000 ;
                    svccmsStoreColors(
                         display_good,
                         colormap_good,
                         &write_many_color[0],
                         (unsigned int)2,
                         (Bool *)0
                         ) ;
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
If the color cell is unallocated or is allocated read-only a call to
xname shall return the BadAccess error.
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


/******
 * User defined initialization code for test case sets
 ******/
	display_good = display_arg;

/*****
 * Test wide set up
 *****/

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
        }
        if ( writeable_colormaps ) {

            estatus[0] = 1;
            estatus[1] = BadAccess ;

            if ((regr_args.l_flags.good == 0) || (estatus[1] == Success)) {
/********************/
                step ("Testing XcmsStoreColors for BadAccess\n");
/********************/
                regr_args.l_flags.check = 0;
                regr_args.l_flags.setup = 0;
                regr_args.l_flags.cleanup = 0;
                regr_args.l_flags.chksta = 1;
                regr_args.l_flags.chkdpy = 0;

                {
                    colormap_dfl = XDefaultColormap(display_good, screen_good );
                    write_many_color[0].format = XcmsRGBFormat ;
                    write_many_color[0].pixel = 10 ;
                    write_many_color[0].spec.RGB.red  = 0xffff ;
                    write_many_color[0].spec.RGB.green  = 0x0 ;
                    write_many_color[0].spec.RGB.blue  = 0x0 ;
                    write_many_color[1].format = XcmsRGBFormat ;
                    write_many_color[1].pixel = 11 ;
                    write_many_color[1].spec.RGB.red  = 0x0 ;
                    write_many_color[1].spec.RGB.green  = 0xffff ;
                    write_many_color[1].spec.RGB.blue  = 0x0 ;
                    svccmsStoreColors(
                         display_good,
                         colormap_dfl,
                         write_many_color,
                         2,
                         (Bool )0
                         ) ;
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
If the value for the colormap argument does not name a defined colormap, a
call to xname
shall return the BadColor error code.
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


/******
 * User defined initialization code for test case sets
 ******/
	display_good = display_arg;

/*****
 * Test wide set up
 *****/

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
        }
        if ( writeable_colormaps ) {

            chkflg = 1 ;
            estatus[0] = 1;
            estatus[1] = BadColor ;

            if ((regr_args.l_flags.good == 0) || (estatus[1] == Success)) {
/********************/
                step ("Testing XcmsStoreColors for BadColor\n");
/********************/
                regr_args.l_flags.check = 0;
                regr_args.l_flags.setup = 0;
                regr_args.l_flags.cleanup = 0;
                regr_args.l_flags.chksta = 1;
                regr_args.l_flags.chkdpy = 0;

                {
                    Colormap colormap_bad = (Colormap)-1 ;
                    write_many_color[0].format = XcmsRGBFormat ;
                    write_many_color[0].pixel = 10 ;
                    write_many_color[0].spec.RGB.red  = 0xffff ;
                    write_many_color[0].spec.RGB.green  = 0x0 ;
                    write_many_color[0].spec.RGB.blue  = 0x0 ;
                    write_many_color[1].format = XcmsRGBFormat ;
                    write_many_color[1].pixel = 11 ;
                    write_many_color[1].spec.RGB.red  = 0x0 ;
                    write_many_color[1].spec.RGB.green  = 0xffff ;
                    write_many_color[1].spec.RGB.blue  = 0x0 ;
                    svccmsStoreColors(
                         display_good,
                         colormap_bad,
                         write_many_color,
                         2,
                         (Bool )0
                         ) ;
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
If a numeric value falls outside of the range of values accepted by
the request, a call to xname shall return the BadValue error code.
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


/******
 * User defined initialization code for test case sets
 ******/
	display_good = display_arg;

/*****
 * Test wide set up
 *****/

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
        }
        if ( writeable_colormaps ) {

            estatus[0] = 1;
            estatus[1] = BadValue ;

            if ((regr_args.l_flags.good == 0) || (estatus[1] == Success)) {
/********************/
                step ("Testing XcmsStoreColors for BadValue\n");
/********************/
                regr_args.l_flags.check = 0;
                regr_args.l_flags.setup = 0;
                regr_args.l_flags.cleanup = 0;
                regr_args.l_flags.chksta = 1;
                regr_args.l_flags.chkdpy = 0;

                {
                    write_many_color[0].format = XcmsRGBFormat ;
                    write_many_color[0].pixel = -998 ;
                    write_many_color[0].spec.RGB.red  = 0xffff ;
                    write_many_color[0].spec.RGB.green  = 0x0 ;
                    write_many_color[0].spec.RGB.blue  = 0x0 ;
                    write_many_color[1].format = XcmsRGBFormat ;
                    write_many_color[1].pixel = -999 ;
                    write_many_color[1].spec.RGB.red  = 0x0 ;
                    write_many_color[1].spec.RGB.green  = 0xffff ;
                    write_many_color[1].spec.RGB.blue  = 0x0 ;
                    svccmsStoreColors(
                         display_good,
                         colormap_good,
                         write_many_color,
                         2,
                         (Bool )0
                         ) ;

                }
	    } /* end if */
        } else
          message("Warning: not a writeable colormap\n", NULL, 0) ;
	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
