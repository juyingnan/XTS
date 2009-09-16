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
$Header: /cvs/xtest/xtest/xts5/tset/Xlib8/XFlushGC/XFlushGC.m,v 1.1 2005-02-12 14:37:37 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xlib8/XFlushGC/XFlushGC.m
>># 
>># Description:
>>#	Tests for XFlushGC()
>># 
>># Modifications:
>># $Log: flushgc.m,v $
>># Revision 1.1  2005-02-12 14:37:37  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:27:38  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:46:04  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:19:48  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:16:19  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.1  1998/01/13 19:54:03  andy
>># In svcFlushGC() changed GC passed to XGetGCValues to gc_id from
>># good_defaults, and check the return status of the call (SR 120).
>>#
>># Revision 4.0  1995/12/15 08:51:26  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  00:52:23  andy
>># Prepare for GA Release
>>#
>>AVSCODE
>>TITLE XFlushGC Xlib8
void
XFlushGC()
>>EXTERN

XGCValues 	good_defaults;
Pixmap pixmap1, tilemap, stipmap;


Display	   *display_good;
GC gc_id_good;
unsigned long 	gc_mask_good=0;
XGCValues	values_struc_good;
XGCValues	values_struc_bad;
                                
char *exec_file_name;
int x_init,
    y_init,
    h_init,
    w_init;


svcFlushGC(display, gc_id)
Display              *display;
GC                   gc_id;
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
		ss_status,	/* save stat return status */	
		stat_status,	/* check stat return status */
		setup_status, cleanup_status, i1;

	regr_args.l_flags.bufrout = 1;

	/* buffer display struct info for error checking */
	bufrdisp(display);	

	/* buffer gc structure for output in error log */
        bufrgc(gc_id,"gc_id");  

	if (regr_args.iter == 0)   
	    regr_args.iter = 1;	/* set number of iterations to 1.	*/ 

	if (regr_args.l_flags.setup) 
		setup_status = REGR_NORMAL;
	XSync(display_arg, 0);

	if (regr_args.l_flags.chksta  == 1)
		ss_status = save_stat(dpy_msk, gc_id,
			       display_arg, drawable_id);
					
	first_error = 0;	/* no errors encountered yet */
								       
	errflg = 0;
	XSetErrorHandler(signal_status);
	XFlushGC(display, gc_id);
	if (estatus[1] != Success)
		XDrawPoint(display, window_arg, gc_id, 1, 1);
	XSync(display_arg, 0);
	XSetErrorHandler(unexp_err);          
	/* no colormap by default */
	r_wait(display_arg, window_arg, time_delay, None);	
						   
	if (regr_args.l_flags.chksta  == 1) 
		stat_status = chek_stat(dpy_msk, gc_id,
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
		GC	 	good_defaults;
		unsigned long   value_mask;
		XGCValues       values;

		value_mask = ( GCLineWidth | GCLineStyle
			     | GCCapStyle | GCJoinStyle ) ;
		if (XGetGCValues(display, gc_id, value_mask, &values) == 0) {
			tet_infoline("XGetGCValues returned zero exit status");
			tet_result(TET_FAIL);
		} else {
			check_dec((long)0, 
				(long)values.line_width, "line_width");
			check_dec((long)LineSolid,
				(long)values.line_style, "line style");
		}
	}
	XSync(display_arg, 0);

	if (regr_args.l_flags.cleanup)
		cleanup_status = REGR_NORMAL;
	XSync(display_arg, 0);

	if (errflg) 
	{ 	
		/* if there was an error ...     */
		errcnt++;   /* ...increment the error count  */
		tet_result(TET_FAIL);
        }
	chkflg = 0;
  	regr_args.l_flags.bufrout = 0;
        dumpbuf();
}


>>ASSERTION Good A
If the implementation is X11R5 or later:
If the value for a GCcontext argument does not name a defined GCcontext
a call to xname shall generate a BadGC error.
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
	PixPerCM = XDisplayWidth(display_arg, 
		XDefaultScreen(display_arg))*10/XDisplayWidthMM(display_arg,
		XDefaultScreen(display_arg));
	MaxDisplayWidth  = XDisplayWidth(display_arg, XDefaultScreen(display_arg));
	MaxDisplayHeight = XDisplayHeight(display_arg, XDefaultScreen(display_arg));
	DisplayCenterX   = (MaxDisplayWidth / 2) - PixPerCM;
	DisplayCenterY   = (MaxDisplayHeight / 2) - PixPerCM;
	x_init = -1;
	y_init = -1;
	h_init = -1;
	w_init = -1;
          
	tet_infoline("PREP: Create a window.");
	if (w_init == -1) w_init = (MaxDisplayWidth - (2 * PixPerCM));
	if (h_init == -1) h_init = (MaxDisplayHeight - (2 * PixPerCM));
	if (x_init == -1) x_init = PixPerCM - 5;
	if (y_init == -1) y_init = PixPerCM - 5;
	if ((window_arg = XCreateSimpleWindow(display_arg, 
		(Window)XRootWindow(display_arg, 
		XDefaultScreen(display_arg)), x_init, y_init,
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
	regr_args.iter = 1;	/* execute service once	*/ 
	estatus[0] = 1;


	display_good = display_arg;
	gc_id_good = XCreateGC(display_arg,window_arg,(unsigned long)0, (XGCValues *)NULL);

/*
        XSetFunction(display_arg,gc_id_good,GXcopy);

        XSetBackground(display_arg,gc_id_good,XWhitePixel(display_arg, XDefaultScreen(display_arg)));
        XSetForeground(display_arg,gc_id_good,XBlackPixel(display_arg, XDefaultScreen(display_arg)));
*/
	/* values setup for BadGC testcase, change back for other testcases */
  	gc_mask_good = GCForeground;
  	values_struc_good.foreground = XWhitePixel(display_arg,
  			XDefaultScreen(display_arg));

            estatus[0] = 1;
            estatus[1] = BadGC;

	if ((regr_args.l_flags.good == 0) || (estatus[1] == Success)) 
	{
                regr_args.l_flags.setup = 0;
                regr_args.l_flags.cleanup = 0;
                regr_args.l_flags.check = 0;
                regr_args.l_flags.chksta = 1;
                regr_args.l_flags.chkdpy = 0;

                {
		/**
 		*   setup for bad GC
 		**/
			GC Bad_GC;

			tet_infoline("PREP: Create a GC");
  			Bad_GC = XCreateGC(display_arg, 
				XRootWindow(display_arg, 
				XDefaultScreen(display_arg)), 
				(unsigned long)0, (XGCValues *)0);
			tet_infoline("PREP: Free the GC");
  			XFreeGC(display_arg, Bad_GC);
  			XSync(display_arg, 0);
			tet_infoline("TEST: Call to XFlushGC generates BadGC error");
                	svcFlushGC(display_good, Bad_GC) ;
                }
	    } /* end if */
	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
>>ASSERTION Good A
If the implementation is X11R5 or later:
A call to xname shall force cached GC changes to the server.
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
          
	tet_infoline("PREP: Create a window.");
	if (w_init == -1) w_init = (MaxDisplayWidth - (2 * PixPerCM));
	if (h_init == -1) h_init = (MaxDisplayHeight - (2 * PixPerCM));
	if (x_init == -1) x_init = PixPerCM - 5;
	if (y_init == -1) y_init = PixPerCM - 5;
	if ((window_arg = XCreateSimpleWindow(display_arg, 
			(Window)XRootWindow(display_arg, 
			XDefaultScreen(display_arg)),
			x_init, y_init, (unsigned int)w_init, 
			(unsigned int)h_init, BorderWidth,
			BorderPixel, BackgroundPixel)) == NULL)
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
	regr_args.iter = 1;		/* execute service once	*/
	estatus[0] = 1;

	display_good = display_arg;
	gc_id_good = XCreateGC(display_arg,window_arg,
		(unsigned long)0, (XGCValues *)NULL);

/*
        XSetFunction(display_arg,gc_id_good,GXcopy);

        XSetBackground(display_arg,gc_id_good,XWhitePixel(display_arg, XDefaultScreen(display_arg)));
        XSetForeground(display_arg,gc_id_good,XBlackPixel(display_arg, XDefaultScreen(display_arg)));
*/
	/* values setup for BadGC testcase, change back for other testcases */
  	gc_mask_good = GCForeground;
  	values_struc_good.foreground = XWhitePixel(display_arg,
  			XDefaultScreen(display_arg));
	/* values setup for BadGC testcase, change back for other testcases */
  	gc_mask_good = GCForeground;
  	values_struc_good.foreground = XWhitePixel(display_arg,
  			XDefaultScreen(display_arg));


	/*
	 * this test case does not alter any parameters and therefore
	 * provides the same function as xcreategc, testing the default values.
	 * the default values are set in the call to xdefaultgc.
	 */

	estatus[0] = 1;
	estatus[1] = Success;

	if ((regr_args.l_flags.good == 0) || (estatus[1] == Success)) 
	{
		regr_args.l_flags.setup = 1;
		regr_args.l_flags.cleanup = 1;
		regr_args.l_flags.check = 1;
		regr_args.l_flags.chksta = 1;
		{

		pixmap1 = XCreatePixmap(display_arg, window_arg, 
			(unsigned int)w_init, (unsigned int)h_init, 
			(unsigned int)XDefaultDepth(display_arg, 
			XDefaultScreen(display_arg)));

		/*
 		* Partially fill the pixmap with 1's
 		*/
		{
			XGCValues xgcv1;
			GC tempgc;

			xgcv1.foreground = 1;

			tet_infoline("PREP: Create a GC");
			tempgc = XCreateGC(display_arg, pixmap1, 
				GCForeground, &xgcv1);
			XFillRectangle(display_arg, pixmap1, 
				tempgc, 0, 20, 50, 30);
			XSetForeground(display_arg, tempgc, 
				(unsigned long)0);
			XFillRectangle(display_arg, pixmap1, 
				tempgc, 0, 0, 50, 20);
			XFreeGC(display_arg, tempgc);
			XSync(display_arg, 0);
		}


		tilemap = pixmap1;

		{
		static unsigned short pixarr[] =  {
					 0xaa55, 0x0a55, 0xaa22, 0xaa55,
					 0xaacc, 0xaa55, 0xaa55, 0x1a55,
					 0xaa55, 0xaa05, 0xaa55, 0xa355,
					 0xaa51, 0xaa55, 0xa455, 0x0055
				       };

		stipmap = XCreateBitmapFromData (display_good, XDefaultRootWindow(display_good), (char *)pixarr, 16, 16);
		}

		tet_infoline("PREP: Modify the GC");

		XSetLineAttributes(display_good, gc_id_good, 0, 
		                   (int)LineSolid, (int)CapButt, 
				   (int)JoinRound) ;

		values_struc_good.tile = tilemap;
		values_struc_good.stipple = stipmap;
		gc_mask_good = GCTile | GCStipple;

		XChangeGC(display_good, gc_id_good, gc_mask_good, 
			  &values_struc_good);
		tet_infoline("TEST: XFlushGC forces cached GC changes to server");
		svcFlushGC(display_good, gc_id_good) ;

		XFreePixmap (display_arg, tilemap);
		XFreePixmap (display_arg, stipmap);

                }
	    } /* end if */
	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
