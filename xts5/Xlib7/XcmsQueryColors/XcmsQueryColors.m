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
>># File: tset/Xlib7/XcmsQueryColors/XcmsQueryColors.m
>># 
>># Description:
>>#	Tests for XcmsQueryColors()
>># 
>># Modifications:
>># $Log: cmsqcl.m,v $
>># Revision 1.1  2005-02-12 14:37:36  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:27:13  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:45:31  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.1  1998/10/27 02:00:24  mar
>># req.4.W.00119, vswsr176, vswsr187: tp1 - Use XcmsLookupColor() to find the
>># correct screen color, and then XcmsStoreColor() the pixel with selected
>># screen color.
>>#
>># Revision 6.0  1998/03/02 05:19:25  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:15:56  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.1  1998/01/23 05:56:15  tbr
>># vswsr119 vswsr118
>># Modified test #1 to get the pixel associated with the XT_GOOD_COLORNAME
>># and compare the results to the values for that pixel.
>>#
>># Modified test #2 to properly checl for BadValue which is what
>># was originally intended since #3 checks for BadColor. Removed
>># returned colors check from test.
>>#
>># Recoded #3 somewhat.
>>#
>># Revision 4.0  1995/12/15 08:50:09  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  00:50:07  andy
>># Prepare for GA Release
>>#
>>AVSCODE
>>TITLE XcmsQueryColors Xlib7
XcmsQueryColors()
>>EXTERN
#include "xtest.h"
#include "limits.h"

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
Colormap   rw_colormap ;
XcmsColor  color_good ;
XcmsColor  color_array[2] ;
XcmsColor  write_many_color[2] ;
XcmsColor  query_many_color[2] ;
XcmsColor  scrnColor, exactColor ;
XcmsColor  color_in_out ;
XcmsColor  goodExactColorSpec;
XcmsColor  goodScreenColorSpec;
XcmsColorFormat format_good ;
int        screen_good ;
int        depth_good ;
char tmpbuf[255];
                                
/******
 * generated globals
 ******/
char *exec_file_name;
int x_init, y_init, h_init, w_init;

/******
 * routines
 ******/

/*****
 * svccmsQueryColors routine 
 *****/                             
svccmsQueryColors(display, colormap, colors, ncolors, format)
Display              *display ;
Colormap             colormap ;
XcmsColor            colors[2] ;
unsigned int         ncolors ;
XcmsColorFormat      format ;
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


        call_string = "svc_ret_value = XcmsQueryColors(";

	(void)strcpy(fmtstr, "The routine call looked like this - \n    %s\n");
	fmt_lst[0].typ_str = call_string;
 	message(fmtstr, fmt_lst, 1);

	call_string = "		display, colormap, colors, ncolors, format);\n\n";
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
 * If there is a pixmap_id parameter or a window_id parameter then
 * set variable drawable_id equal to it.
 ******/

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
                                                                               
		 tet_infoline("TEST: Calling XcmsQueryColors");
       svc_ret_value = 0 ;
  	    errflg = 0;
	    XSetErrorHandler(signal_status);

       svc_ret_value = XcmsQueryColors( display, colormap, &colors[0],
		    ncolors, format);

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
		check_dec(goodScreenColorSpec.pixel, colors[0].pixel, "pixel0") ;
		check_dec(goodScreenColorSpec.spec.RGB.red, colors[0].spec.RGB.red, "red0") ;
		check_dec(goodScreenColorSpec.spec.RGB.green, colors[0].spec.RGB.green, "green0") ;
		check_dec(goodScreenColorSpec.spec.RGB.blue, colors[0].spec.RGB.blue, "blue0") ;

		check_dec(goodScreenColorSpec.pixel, colors[1].pixel, "pixel1") ;
		check_dec(goodScreenColorSpec.spec.RGB.red, colors[1].spec.RGB.red, "red1") ;
		check_dec(goodScreenColorSpec.spec.RGB.green, colors[1].spec.RGB.green, "green1") ;
		check_dec(goodScreenColorSpec.spec.RGB.blue, colors[1].spec.RGB.blue, "blue1") ;
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
shall return the RGB values for the colormap cells specified by the
.A pixel
fields of the specified
.A XcmsColor
structures, and then convert the value to the target format specified by the
.A result_format
argument.
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
        colormap_good = XDefaultColormap(display_good, screen_good );

        if ((visual_good->class == StaticGray) ||
              (visual_good->class == StaticColor) ||
              (visual_good->class == TrueColor))
            writeable_colormaps = 0 ;

        if (writeable_colormaps) 
	{

      estatus[0] = 1;
      estatus[1] = Success;

      rw_colormap = XCreateColormap( display_good,
          XRootWindow(display_good, screen_good), visual_good, AllocAll);

		sprintf(tmpbuf, "PREP: determining the color spec for %s",
			config.good_colorname);
		tet_infoline(tmpbuf);
      colormap_good = XDefaultColormap(display_good, screen_good );
		if (!XcmsLookupColor(display_good, rw_colormap, config.good_colorname,
			&goodExactColorSpec, &goodScreenColorSpec, XcmsRGBFormat))
			{ tet_infoline("ERROR: XcmsLookupColor failed"); tet_result(TET_UNRESOLVED); return; }
		goodScreenColorSpec.pixel = 2;
		if (!XcmsStoreColor(display_good, rw_colormap, &goodScreenColorSpec))
			{ tet_infoline("ERROR: XcmsStoreColor failed"); tet_result(TET_UNRESOLVED); return; }

      ccc_good = XcmsCCCOfColormap(display_good, colormap_good) ;

            if ((regr_args.l_flags.good == 0) || 
		(estatus[1] == Success))
	    {
                regr_args.l_flags.check = 1;
                regr_args.l_flags.setup = 1;
                regr_args.l_flags.cleanup = 1;
                regr_args.l_flags.chksta = 0;
                regr_args.l_flags.chkdpy = 0;

                {
                    format_good = XcmsRGBFormat ;

                    query_many_color[0].format = XcmsRGBFormat ;
                    query_many_color[0].pixel = goodScreenColorSpec.pixel;
                    query_many_color[1].format = XcmsRGBFormat ;
                    query_many_color[1].pixel = goodScreenColorSpec.pixel;

                    svccmsQueryColors(
                         display_good,
                         rw_colormap,
                         &query_many_color[0],
                         (unsigned int)2,
                         format_good
                        );

                }
	    } /* end if */
			tet_result(TET_PASS);
        }
	else
		{
      tet_infoline("colormap is not writeable");
		tet_result(TET_UNSUPPORTED);
		}
#else
	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
>>ASSERTION Good C
When the value for a XcmsColor pixel argument argument does not name a
valid pixel, a call to
.B XcmsQueryColors
shall return a BadValue error code.
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
        colormap_good = XDefaultColormap(display_good, screen_good );

        if ((visual_good->class == StaticGray) ||
              (visual_good->class == StaticColor) ||
              (visual_good->class == TrueColor))
            writeable_colormaps = 0 ;

        if (writeable_colormaps)
	{
      chkflg = 1 ;
      estatus[0] = 1;
      estatus[1] = BadValue ;

      rw_colormap = XCreateColormap( display_good,
          XRootWindow(display_good, screen_good), visual_good, AllocAll);

		sprintf(tmpbuf, "PREP: determining the color spec for %s",
			config.good_colorname);
		tet_infoline(tmpbuf);
      colormap_good = XDefaultColormap(display_good, screen_good );
		if (!XcmsLookupColor(display_good, rw_colormap, config.good_colorname,
			&goodExactColorSpec, &goodScreenColorSpec, XcmsRGBFormat))
			{ tet_infoline("ERROR: XcmsLookupColor failed"); tet_result(TET_UNRESOLVED); return; }
		goodScreenColorSpec.pixel = 2;
		if (!XcmsStoreColor(display_good, rw_colormap, &goodScreenColorSpec))
			{ tet_infoline("ERROR: XcmsStoreColor failed"); tet_result(TET_UNRESOLVED); return; }

      ccc_good = XcmsCCCOfColormap(display_good, colormap_good) ;

            if ((regr_args.l_flags.good == 0) || 
		(estatus[1] == Success))
	    {
                regr_args.l_flags.check = 0;
                regr_args.l_flags.setup = 1;
                regr_args.l_flags.cleanup = 1;
                regr_args.l_flags.chksta = 0;
                regr_args.l_flags.chkdpy = 0;

                {
                    format_good = XcmsRGBFormat ;

                    query_many_color[0].format = XcmsRGBFormat ;
                    query_many_color[0].pixel = goodScreenColorSpec.pixel;
                    query_many_color[1].format = XcmsRGBFormat ;
                    query_many_color[1].pixel = ULONG_MAX;

                    svccmsQueryColors( display_good, rw_colormap,
                         &query_many_color[0], (unsigned int)2,
                         format_good);

                }
	    } /* end if */
			tet_result(TET_PASS);
        }
	else
		{
      tet_infoline("colormap is not writeable");
		tet_result(TET_UNSUPPORTED);
		}
#else
	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
       
>>ASSERTION Good C
If the implementation is X11R5 or later:
If the value for the colormap argument does not name a defined colormap a
call to xname shall return the BadColor error code.
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
        colormap_good = XDefaultColormap(display_good, screen_good );

        if ((visual_good->class == StaticGray) ||
              (visual_good->class == StaticColor) ||
              (visual_good->class == TrueColor))
            writeable_colormaps = 0 ;

        if (writeable_colormaps)
	{
      chkflg = 1 ;
      estatus[0] = 1 ;
      estatus[1] = BadColor ;

      rw_colormap = XCreateColormap( display_good,
         XRootWindow(display_good, screen_good), visual_good, AllocAll);

		sprintf(tmpbuf, "PREP: determining the color spec for %s",
			config.good_colorname);
		tet_infoline(tmpbuf);
      colormap_good = XDefaultColormap(display_good, screen_good );
		if (!XcmsLookupColor(display_good, rw_colormap, config.good_colorname,
			&goodExactColorSpec, &goodScreenColorSpec, XcmsRGBFormat))
			{ tet_infoline("ERROR: XcmsLookupColor failed"); tet_result(TET_UNRESOLVED); return; }
		goodScreenColorSpec.pixel = 2;
		if (!XcmsStoreColor(display_good, rw_colormap, &goodScreenColorSpec))
			{ tet_infoline("ERROR: XcmsStoreColor failed"); tet_result(TET_UNRESOLVED); return; }


       ccc_good = XcmsCCCOfColormap(display_good, colormap_good) ;

            if ((regr_args.l_flags.good == 0) || 
		(estatus[1] == Success))
	    {
                regr_args.l_flags.check = 0;
                regr_args.l_flags.setup = 1;
                regr_args.l_flags.cleanup = 1;
                regr_args.l_flags.chksta = 0;
                regr_args.l_flags.chkdpy = 0;

                {
                    format_good = XcmsRGBFormat ;

                    query_many_color[0].format = XcmsRGBFormat ;
                    query_many_color[0].pixel = goodScreenColorSpec.pixel;
                    query_many_color[1].format = XcmsRGBFormat ;
                    query_many_color[1].pixel = goodScreenColorSpec.pixel;

                    svccmsQueryColors( display_good, -999,
                         &query_many_color[0], (unsigned int)2,
                         format_good);

                }
	    } /* end if */
			tet_result(TET_PASS);
        }
	else
		{
      tet_infoline("colormap is not writeable");
		tet_result(TET_UNSUPPORTED);
		}
#else
	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
