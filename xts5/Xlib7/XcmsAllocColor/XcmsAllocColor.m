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
$Header: /cvs/xtest/xtest/xts5/tset/Xlib7/XcmsAllocColor/XcmsAllocColor.m,v 1.2 2005-04-21 09:40:42 ajosey Exp $

Copyright (c) 2003 The Open Group
Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xlib7/XcmsAllocColor/XcmsAllocColor.m
>># 
>># Description:
>>#	Tests for XcmsAllocColor()
>># 
>># Modifications:
>># $Log: cmsac.m,v $
>># Revision 1.2  2005-04-21 09:40:42  ajosey
>># resync to VSW5.1.5
>>#
>># Revision 8.2  2005/01/21 10:49:31  gwc
>># Updated copyright notice
>>#
>># Revision 8.1  2003/12/08 12:15:12  gwc
>># PR1854: incorrect bits_per_rgb bit shift in svccmsAllocColor
>>#
>># Revision 8.0  1998/12/23 23:27:02  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:45:20  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:19:15  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.1  1998/03/02 03:43:47  tbr
>># vswsr165; changed to use only the most significant bits_per_rgb bits
>># of the color spec returned by XParseColor when comparing it to the color
>># spec returned by XcmsAllocColor. This is debatable when you closely
>># read the spec, but appears to be how the code was implemented.
>>#
>># Revision 5.0  1998/01/26 03:15:46  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.1  1998/01/23 03:37:31  tbr
>># Modified test to useXParseColor to find the RGB values for
>># XT_GOOD_COLORNAME and pass those to the function being tested.
>># Changed result if colormap is not writeable to unsupported.
>># Changed TP#2 to pass all good args, except colormap, to fn.
>>#
>># Revision 4.0  1995/12/15 08:49:33  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  00:49:02  andy
>># Prepare for GA Release
>>#
>>AVSCODE
>>TITLE XcmsAllocColor Xlib7
void
XcmsAllocColor()
>>EXTERN
#include "xtest.h"

Bool  writeable_colormaps = 1;
Display	   *display_good;
Visual     *visual_good ;
XcmsCCC    ccc_good ;
Colormap   colormap_good, colormap_return ;
XcmsColor  cmsColorSpec ;
XcmsColor  color_in_out ;
XcmsColorFormat format_good ;
int        screen_good ;
int        depth_good ;
int x_init, y_init, h_init, w_init;
XColor goodColorSpec;
char tmpbuf[255];

void
svccmsAllocColor(display, colormap, color, format)
Display              *display ;
Colormap             colormap ;
XcmsColor            color ;
XcmsColorFormat      format ;
{
extern int  errcnt;
extern int  errflg;
extern int  chkflg;
extern int  signal_status();
extern int  unexp_err();

char fmtstr[256], *call_string;
union msglst fmt_lst[1];        
int skip_pixcheck;
int red, green, blue;
int tmpRGB;

int     ss_status,			  /* save stat return status */	
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


	call_string = "svc_ret_value = XcmsAllocColor(";

	(void)strcpy(fmtstr, "The routine call looked like this - \n    %s\n");
	fmt_lst[0].typ_str = call_string;
	message(fmtstr, fmt_lst, 1);

	call_string = "		display, colormap, color, format);\n\n";
	message(call_string, fmt_lst, 0);
	(void)strcpy(fmtstr, "The parameter values were as follows... \n");
	message(fmtstr, fmt_lst, 0);
								  
	XSync(display_arg, 0);

	if (regr_args.l_flags.chksta  == 1)
			ss_status = save_stat(dpy_msk | win_msk , 
				    gc_id, display_arg, drawable_id);
					
	first_error = 0;	/* no errors encountered yet */
								       
   tet_infoline("TEST: Calling XcmsAllocColor");
	errflg = 0;
	svc_ret_value = XcmsAllocColor(display, colormap, &color, 
			format);
	XSync(display_arg, 0);

	/* no colormap by default */
	r_wait(display_arg, window_arg, time_delay, None);	
	if (regr_args.l_flags.chksta  == 1) 
		stat_status = chek_stat(dpy_msk | win_msk , gc_id,
				 display_arg, drawable_id, ss_status);
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
		tmpRGB = (goodColorSpec.red &
			((0xFFFF << (16 - ccc_good->visual->bits_per_rgb)) & 0xFFFF));
		check_dec(tmpRGB, color.spec.RGB.red, "red") ;
		tmpRGB = (goodColorSpec.green &
			((0xFFFF << (16 - ccc_good->visual->bits_per_rgb)) & 0xFFFF));
		check_dec(tmpRGB, color.spec.RGB.green, "green") ;
		tmpRGB = (goodColorSpec.blue &
			((0xFFFF << (16 - ccc_good->visual->bits_per_rgb)) & 0xFFFF));
		check_dec(tmpRGB, color.spec.RGB.blue, "blue") ;
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

	/* if there was an error ...     */
	if (errflg) 
	{ 	
    		errcnt++;   /* ...increment the error count  */
    		(void)strcpy(fmtstr, "\nEnd of error report\n");
    		message(fmtstr, fmt_lst, 0);
    		(void)strcpy(fmtstr, "*********************\n");
    		message(fmtstr, fmt_lst, 0);
		tet_result(TET_FAIL);
	}

	/*****
	* clear all flags
	*****/
	chkflg = 0;
	regr_args.l_flags.bufrout = 0;

	dumpbuf();
}   /* end of svccmsAllocColor service routine */
>>ASSERTION Good C
If the implementation is X11R5 or later:
A call to xname
shall allocate a device-independent color and return the pixel value
of the color cell and the color specification actually allocated.
>>CODE
#if XT_X_RELEASE > 4
	display_arg = Dsp;
	/*
 	* Create a GC to save environmental data in
 	*/
	gc_save = XCreateGC(display_arg, 
			XRootWindow(display_arg,XDefaultScreen(display_arg)),
			(unsigned long)0,(XGCValues *)0);

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

        if (writeable_colormaps) {
		estatus[0] = 1;
		estatus[1] = Success;

		sprintf(tmpbuf, "PREP: determining the color spec for %s",
			config.good_colorname);
		tet_infoline(tmpbuf);
      colormap_good = XDefaultColormap(display_good, screen_good );
		if (!XParseColor(display_good, colormap_good, config.good_colorname,
			&goodColorSpec))
			{ tet_result(TET_UNRESOLVED); return; }

      ccc_good = XcmsCCCOfColormap(display_good, colormap_good) ;
		sprintf(tmpbuf, "INFO: bits_per_rgb(%d)", ccc_good->visual->bits_per_rgb);
		tet_infoline(tmpbuf);

		if ((regr_args.l_flags.good == 0) || (estatus[1] == Success)) 
		{
			regr_args.l_flags.check = 1;
			regr_args.l_flags.setup = 1;
			regr_args.l_flags.cleanup = 1;
			regr_args.l_flags.chksta = 0;
			regr_args.l_flags.chkdpy = 0;

			{
			    format_good = XcmsRGBFormat ;
			    cmsColorSpec.format = XcmsRGBFormat ;
			    cmsColorSpec.pixel = goodColorSpec.pixel;
			    cmsColorSpec.spec.RGB.red = goodColorSpec.red;
			    cmsColorSpec.spec.RGB.green = goodColorSpec.green;
			    cmsColorSpec.spec.RGB.blue = goodColorSpec.blue;
			    svccmsAllocColor(display_good, colormap_good, cmsColorSpec,
					format_good);

			}
			tet_result(TET_PASS);
	    } /* end if */
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
If the value for the colormap argument does not name a defined colormap, a
call to xname shall return the BadColor error code.
>>CODE

#if XT_X_RELEASE > 4
	display_arg = Dsp;

	/*
 	* Create a GC to save environmental data in
 	*/
	gc_save = XCreateGC(display_arg, 
			XRootWindow(display_arg,XDefaultScreen(display_arg)),
			(unsigned long)0,(XGCValues *)0);

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

        if (writeable_colormaps) 
	{
		estatus[0] = 1;
		estatus[1] = BadColor ;

      colormap_good = XDefaultColormap(display_good, screen_good );

		sprintf(tmpbuf, "PREP: determining the color spec for %s",
			config.good_colorname);
		tet_infoline(tmpbuf);
      colormap_good = XDefaultColormap(display_good, screen_good );
		if (!XParseColor(display_good, colormap_good, config.good_colorname,
			&goodColorSpec))
			{ tet_result(TET_UNRESOLVED); return; }

      ccc_good = XcmsCCCOfColormap(display_good, colormap_good) ;

		if ((regr_args.l_flags.good == 0) || (estatus[1] == Success)) 
		{
			regr_args.l_flags.check = 0;
			regr_args.l_flags.setup = 1;
			regr_args.l_flags.cleanup = 1;
			regr_args.l_flags.chksta = 0;
			regr_args.l_flags.chkdpy = 0;

			chkflg = 1;

			format_good = XcmsRGBFormat ;
			cmsColorSpec.format = XcmsRGBFormat ;
			cmsColorSpec.pixel = goodColorSpec.pixel;
			cmsColorSpec.spec.RGB.red = goodColorSpec.red;
			cmsColorSpec.spec.RGB.green = goodColorSpec.green;
			cmsColorSpec.spec.RGB.blue = goodColorSpec.blue;
			svccmsAllocColor(display_good, -999, cmsColorSpec, format_good);
			tet_result(TET_PASS);
		} /* end if */
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
