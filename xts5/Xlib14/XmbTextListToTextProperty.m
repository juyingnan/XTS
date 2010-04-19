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
>># File: xts/Xlib14/XmbTextListToTextProperty.m
>># 
>># Description:
>>#	Tests for XmbTextListToTextProperty()
>># 
>># Modifications:
>># $Log: mbtlttp.m,v $
>># Revision 1.1  2005-02-12 14:37:21  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:38:58  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:02:04  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:29:59  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:26:33  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:24:03  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:01:48  andy
>># Prepare for GA Release
>>#
>>AVSCODE
>>TITLE XmbTextListToTextProperty Xlib14
void
XmbTextListToTextProperty()
>>EXTERN

char *list[] = { "Xlib test string abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789" } ;
int length_good = 79;

Display	   *display_good;
                                
char *exec_file_name;
int x_init, y_init, w_init, h_init;

svcmbTextListToTextProperty(display, list_good, 
	count_good, style_good, text_prop_good )
Display     *display ;
char	**list_good ;
int		count_good ;
XICCEncodingStyle style_good ;
XTextProperty	text_prop_good ;
{
        extern int  errflg;
        extern int  chkflg;
	extern int  signal_status();
	extern int  unexp_err();
	extern char *strcpy();

        Status ret_status ;

	int ss_status,	/* save stat return status */	
	    stat_status,	/* check stat return status */
	    setup_status,
	    cleanup_status;

	regr_args.l_flags.bufrout = 1;

	/* buffer display struct info for error checking */
	bufrdisp(display_good);	

	if (regr_args.l_flags.setup) 
		setup_status = REGR_NORMAL;
	XSync(display_arg, 0);

	if (regr_args.l_flags.chksta  == 1)
		ss_status = save_stat(dpy_msk, gc_id,
		       display_arg, drawable_id);
				

	first_error = 0;	/* no errors encountered yet */

	errflg = 0;
	XSetErrorHandler(signal_status);

	tet_infoline("PREP: Call XmbTextListToTextProperty with a multi-byte list");
	ret_status = XmbTextListToTextProperty(
		 display, list_good, count_good,
		 style_good, &text_prop_good);

	XSync(display_arg, 0);
	XSetErrorHandler(unexp_err);          
	/* no colormap by default */
	r_wait(display_arg, window_arg, time_delay, None);

	if (regr_args.l_flags.chksta  == 1) 
		stat_status = chek_stat (dpy_msk ,
				 gc_id, display_arg,
				 drawable_id, ss_status);
	else                              
		stat_status = REGR_NORMAL;


	if ((!errflg) && (!chkflg)) 
		if ((badstat(display_arg, estatus, Success)) != 
		    REGR_NORMAL)
	    errflg = 1;

	tet_infoline("TEST: Call returns Success");
	if ((regr_args.l_flags.check) && 
	    (errflg == 0) && 
	    (stat_status == REGR_NORMAL)) 
	{

		if (ret_status != Success) 
		{
	    		message("XmbTextListToTextProperty failed: Expected zero returned non zero\n", NULL, 0);
	    		errflg = 1 ;
	    	} 
		else
		{
			tet_infoline("TEST: Value of Property returned");
	    		check_str(list[0], text_prop_good.value, 
				"string");
	    		check_dec(length_good, text_prop_good.nitems, 
				"nitems");
	    	}
	}
	XSync(display_arg, 0);

	if (regr_args.l_flags.cleanup)
		cleanup_status = REGR_NORMAL;

	XSync(display_arg, 0);

	chkflg = 0;
  	regr_args.l_flags.bufrout = 0;

        dumpbuf();
}

>>ASSERTION Good C
If the implementation is X11R5 or later:
A call to xname
shall convert an internationalized multi-byte text list to a
list property structure and return Success.
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

        estatus[0] = 1;
        estatus[1] = Success;

	if ((regr_args.l_flags.good == 0) || (estatus[1] == Success)) 
	{
		tet_infoline("TEST: set text list to XTextProperty structure\n");
                regr_args.l_flags.setup = 1;
                regr_args.l_flags.cleanup = 1;
                regr_args.l_flags.check = 1;
                regr_args.l_flags.chksta = 1;

                {
                    XTextProperty 	text_prop ;
                    int count = 1;

                    svcmbTextListToTextProperty(
                         display_good,
                         list,
                         count,
                         (XICCEncodingStyle)XStdICCTextStyle,
                         &text_prop
                        );
                }
	}
	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
