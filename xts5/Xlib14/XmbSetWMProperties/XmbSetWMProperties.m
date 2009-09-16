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
>># File: xts/Xlib14/XmbSetWMProperties/XmbSetWMProperties.m
>># 
>># Description:
>>#	Tests for XmbSetWMProperties()
>># 
>># Modifications:
>># $Log: mbswmprp.m,v $
>># Revision 1.1  2005-02-12 14:37:21  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:38:57  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:02:03  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:29:58  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:26:31  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:23:57  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:01:41  andy
>># Prepare for GA Release
>>#
>>AVSCODE
>>TITLE XmbSetWMProperties Xlib14
void
XmbSetWMProperties()
>>EXTERN


Display	   *display_good;
Window	window_id_good;

long supplied ;

static XClassHint chints = {
        "Resource",
        "Class",
        } ;

        XClassHint *class_hints = &chints ;

static XWMHints wmhints = {
        AllHints,
        False,
        IconicState,
        12200,
        100,
        10,
        10,
        1200,
        800,
        } ;

XWMHints *wm_hints = &wmhints ;
              
char *window_name_good = "window" ;

char *icon_name_good = "icon" ;
 
static char *argv_good[]={
			"CommandName",
			"This",
			"is", 
			"an", 
			"argument", 
			"list",
                    	"used",
			"to",
			"verify",
			"argument",
			"vector",
			"passing",
			 };	



static int num_args_good = 12;

static XSizeHints sizehints ={

  (PPosition|PSize|PMinSize|PMaxSize|PResizeInc|PAspect|PBaseSize|PWinGravity),  /* flags */
	 90,               /* x */
       	 80,               /* y */
	200,               /* width */
	100,               /* height */
	 10,               /* min_width */
       	 10,               /* min_height */
       1200,               /* max_width */
	800,               /* max_height */
         20,               /* width_inc */
         10,               /* height_inc */
        {5 , 5},           /* min_aspect numerator & denominator */        
	{10, 10},           /* max_aspect numerator & denominator */
        10,                /* base width */
        10,                /* base height */
        NorthWestGravity   /* win gravity */
        };                                                         

	XSizeHints	*hints_good = &sizehints;


char *exec_file_name;
int x_init,
    y_init,
    h_init,
    w_init;


svcmbSetWMProperties(display, window_id, window_name, 
icon_name, argv, num_args, hints, wmh_good, classh_good) 
Display              *display;
Window               window_id;
char                 *window_name;
char                 *icon_name;
char                 **argv;
int                  num_args;
XSizeHints           *hints;
XWMHints		 *wmh_good;
XClassHint		 *classh_good ;
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
		ss_status,		/* save stat return status */	
		stat_status,		/* check stat return status */
  		setup_status,
  		cleanup_status,
		i1;


/*
 * The following definitions are used in the checking code to verify
 * that all the events occur as expected. They are used to
 * index into an array of integers used to tally the occurrances of
 * each event atom of our expected event type.
 */

#define NAME    	0
#define ICON_NAME 	1 
#define WM_HINTS     	2
#define COMMAND	    	3
#define NORMAL_HINTS 	4
#define ONCE		1

static char *window_name_return, *icon_name_return;
static XSizeHints hints_return;
static XWMHints  *wmhints_return;
static XClassHint class_hints_return;
static int NULL_SPOT = 1;
static unsigned char *data = NULL, *dptr;
static Atom actual_type;
static int actual_format, idx, i;
static unsigned long nitems, fitems;
static unsigned long leftover;
XEvent good_event, event_return_good;                 

	/******
 	* Turn on buffering and buffer parameter information
 	* in case an error occurs
 	******/
	regr_args.l_flags.bufrout = 1;

	/* buffer display struct info for error checking */
	bufrdisp(display);
                                                    
	drawable_id = window_id;

	if (regr_args.iter == 0)   
	    regr_args.iter = 1;	/* set number of iterations to 1.	*/ 

	if (regr_args.l_flags.setup) 
		setup_status = REGR_NORMAL;
	XSync(display_arg, 0);

	if (regr_args.l_flags.chksta  == 1)
		ss_status = save_stat(dpy_msk | win_msk ,
		       gc_id, display_arg, drawable_id);
				

	first_error = 0;	/* no errors encountered yet */

	errflg = 0;
	XSetErrorHandler(signal_status);
	XmbSetWMProperties( display, window_id, window_name, 
		icon_name, argv, num_args, 
		hints, wmh_good, classh_good);
	XSync(display_arg, 0);
	XSetErrorHandler(unexp_err);          
	/* no colormap by default */
	r_wait(display_arg, window_arg, time_delay, None);	
					   
	if (regr_args.l_flags.chksta  == 1) 
		stat_status = chek_stat (dpy_msk | win_msk ,
			 		gc_id, display_arg,
			 		drawable_id, ss_status);
	else                              
		stat_status = REGR_NORMAL;

	if ((!errflg) && (!chkflg)) 
		if ((badstat(display_arg, estatus, Success)) != REGR_NORMAL)
			errflg = 1;

	if ((regr_args.l_flags.check) && 
	    (errflg == 0) && 
	    (stat_status == REGR_NORMAL)) 
	{
		/* 
		 * check that window_name is what we set (if anything)
		 * in service invocation 
		 */
 		(void)XFetchName(display, window_id, &window_name_return);

		check_str("window", window_name_return, "window_name");
                                                                        
		/* check that icon_name is what we set(if anything)in service invocation */
		(void)XGetIconName(display, window_id, &icon_name_return);             
		check_str("icon", icon_name_return, "icon_name");
                                                                           
		wmhints_return =  XGetWMHints(display, window_id);

		/* 
		 * check the icon_pixmap id is what we set (if anything)
		 * in service invocation
   		 * and that the .flags field is set to IconPixmapHint 
		 */
		check_dec((long)AllHints, (long)wmhints_return->flags, 
			  "WMHints .flags field");
                   

		/* check XSetCommand's argv array */

		(void)XGetWindowProperty(display, 	 /* Display */
	 	         window_id, 	 /* Window  */
		         XA_WM_COMMAND,	 /* property atom */
		         0L, 		 /* long offset */
		         (long)BUFSIZ, 	 /* long length */
		         False, 	 /* delete Bool */
		         XA_STRING, 	 /* atom identifier */
	 	         &actual_type,	 /* atom identifier */
	                 &actual_format, /* format of property(8 bits) */
		         &nitems, 	 /* number of 8 bit chars */
		         &leftover, 	 /* bytes remaining on partial read */
                         &data);	 /* pointer to the data is spec format*/

		/* 
		 * check that the command property data returned 
		 * matches all expected criteria 
		 */	

                check_uns (XA_STRING, actual_type, 
			   "command property actual_type=XA_STRING");
                check_dec ((long)8, (long)actual_format, 
			   "command property actual_format");
                check_dec ((long)0, leftover, 
			   "command property leftover bytes");

		/* Get actual length of argv list */
                fitems=0;
                for (i=0; i < num_args; i++) 
			fitems += strlen( argv[i]) + NULL_SPOT;

		/* 
		 * Walk thru the data buffer and verify that the 
		 * argv arguments are intact 
		 */

		dptr = data;
		for(idx = 0, i = 0; *dptr;  i++, dptr = &data[idx])
                {  
			/* do some calc's */
			idx = strlen((char *)dptr) + NULL_SPOT + idx;
                	check_str (argv[i], (char *)dptr, 
				"command property data string");                  
                }
                check_uns (fitems, nitems, "command property data length");
                check_dec ((long)num_args, (long)i, "number of argv strings");
	
		/* 
		 * check the sizehints are what we set (if anything)
		 * in the service invocation 
		 */ 
                    
		(void) XGetWMNormalHints(display, window_id, &hints_return, &supplied);

		check_dec((long)hints->flags, (long)hints_return.flags , "XSizeHints->flags");
		check_dec((long)hints->x, (long)hints_return.x , "XSizeHints->x");
		check_dec((long)hints->y, (long)hints_return.y , "XSizeHints->y");
		check_dec((long)hints->width, (long)hints_return.width , "XSizeHints->width");
		check_dec((long)hints->height, (long)hints_return.height , "XSizeHints->height");
		check_dec((long)hints->min_width, (long)hints_return.min_width , "XSizeHints->min_width");
		check_dec((long)hints->min_height, (long)hints_return.min_height , "XSizeHints->min_height");
		check_dec((long)hints->max_width, (long)hints_return.max_width , "XSizeHints->max_width");
		check_dec((long)hints->max_height, (long)hints_return.max_height , "XSizeHints->max_height");
		check_dec((long)hints->width_inc, (long)hints_return.width_inc , "XSizeHints->width_inc");
		check_dec((long)hints->height_inc, (long)hints_return.height_inc , "XSizeHints->height_inc");
		check_dec((long)hints->min_aspect.x, (long)hints_return.min_aspect.x , "XSizeHints->min_aspect.x");
		check_dec((long)hints->min_aspect.y, (long)hints_return.min_aspect.y , "XSizeHints->min_aspect.y");
		check_dec((long)hints->max_aspect.x, (long)hints_return.max_aspect.x , "XSizeHints->max_aspect.x");
		check_dec((long)hints->max_aspect.y, (long)hints_return.max_aspect.y , "XSizeHints->max_aspect.y");
		check_dec((long)hints->base_width, (long)hints_return.base_width , "XSizeHints->base_width");
		check_dec((long)hints->base_height, (long)hints_return.base_height , "XSizeHints->base_height");
		check_dec((long)hints->win_gravity, (long)hints_return.win_gravity , "XSizeHints->win_gravity");

		check_dec((long)wm_hints->flags, (long)wmhints_return->flags , "XWMHints->flags")
		;
		check_dec((long)wm_hints->input, (long)wmhints_return->input , "XWMHints->input")
		;
		check_dec((long)wm_hints->initial_state, (long)wmhints_return->initial_state , "XWMHints->initial_state");
		check_dec((long)wm_hints->icon_window, (long)wmhints_return->icon_window , "XWMHints->icon_window");
		check_dec((long)wm_hints->icon_x, (long)wmhints_return->icon_x , "XWMHints->icon_x");
		check_dec((long)wm_hints->icon_y, (long)wmhints_return->icon_y , "XWMHints->icon_y");
		check_dec((long)wm_hints->icon_mask, (long)wmhints_return->icon_mask , "XWMHints->icon_mask");
		check_dec((long)wm_hints->window_group, (long)wmhints_return->window_group , "XWMHints->window_group");

		(void)XGetClassHint(display_arg, window_arg, &class_hints_return);

		/* check the class_hints structure */
		check_str(class_hints->res_name, class_hints_return.res_name , "XClassHints->res_name");
		check_str(class_hints->res_class, class_hints_return.res_class , "XClassHints->res_class");


	} /* end of checking code */
                              
	XSync(display_arg, 0);


	/*   Free storage allocated by XGetWindowProperty & XGetWMHints */

	if (regr_args.l_flags.cleanup)
	{
		if (data != NULL)
			XFree ((char *)data);

		if (wmhints_return != NULL)
          		XFree ((char *)wmhints_return);     

		if (class_hints_return.res_name != NULL)
			(void)XFree(class_hints_return.res_name);
		if (class_hints_return.res_class != NULL)
			(void)XFree(class_hints_return.res_class);

		XSync (display, 1);   /* Discard leftover events */
	}
	XSync(display_arg, 0);
	if (errflg) 
	{ 	
		errcnt++;   /* ...increment the error count  */
		tet_result(TET_FAIL);
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
If the value for a window argument does not name a defined window 
a call to xname shall return the BadWindow error code.
>>CODE

#if XT_X_RELEASE > 4
	display_arg = Dsp;
/*
 * Create a GC to save environmental data in
 */
	gc_save = XCreateGC(display_arg,
		XRootWindow(display_arg,XDefaultScreen(display_arg)),(unsigned long)0,(XGCValues *)0);


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
          
	if (w_init == -1) w_init = (MaxDisplayWidth - (2 * PixPerCM));
	if (h_init == -1) h_init = (MaxDisplayHeight - (2 * PixPerCM));
	if (x_init == -1) x_init = PixPerCM - 5;
	if (y_init == -1) y_init = PixPerCM - 5;
	if ((window_arg = XCreateSimpleWindow(display_arg, 
	    (Window)XRootWindow(display_arg, XDefaultScreen(display_arg)),
	    x_init, y_init, (unsigned int)w_init, (unsigned int)h_init,    
		BorderWidth, BorderPixel, BackgroundPixel)) == NULL)
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

        setlocale(LC_ALL, "C") ;
	display_good = display_arg;
	window_id_good = window_arg;

	XSelectInput(display_arg, window_arg, PropertyChangeMask);

	estatus[0] = 1;
	estatus[1] = BadWindow;

	if ((regr_args.l_flags.good == 0) || (estatus[1] == Success)) 
	{
		regr_args.l_flags.setup = 0;
		regr_args.l_flags.cleanup = 0;
		regr_args.l_flags.check = 0;
		regr_args.l_flags.chksta = 1;
		regr_args.l_flags.chkdpy = 0;

		{
		/*
 		* Create and destroy a window to make sure 
		* we have a bad window id or a bad drawable id
 		*/
		Window bad_window;

		tet_infoline("PREP: Create a window.");
		bad_window = XCreateSimpleWindow(display_arg, 
		XRootWindow(display_arg, XDefaultScreen(display_arg)),
		0, 0, (unsigned int)10, (unsigned int)10, (unsigned int)0, 
  		XWhitePixel(display_arg, XDefaultScreen(display_arg)),
		XWhitePixel(display_arg, XDefaultScreen(display_arg)));
		tet_infoline("PREP: Destroy the window.");
		XDestroyWindow(display_arg, bad_window);
		XSync(display_arg, 0);
		tet_infoline("TEST: Catt to XmbSetWMProperties with a non-existant window id returns BadWindow error");
		svcmbSetWMProperties( display_good,
                         bad_window, window_name_good,
                         icon_name_good, argv_good,
                         num_args_good, hints_good,
                         wm_hints, class_hints);
                }
	    } /* end if */
	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif

>>ASSERTION Good C
If the implementation is X11R5 or later:
A call to xname shall set a window's standard window manager properties.
.P
If the window_name argument is non-null, it shall set WM_NAME property.
.P
If the icon_name argument is non-null, it shall set WM_ICON_NAME property.
.P
If the argv argument is non-null, it shall set WM_COMMAND property.
.P
If the argc argument is zero, it shall set WM_CLIENT_MACHINE property.
.P
If the normal_hints argument in non-null, it shall set WM_NORMAL_HINTS property.
.P
If the wm_hints argument is non-null, it shall set WM_HINTS property.
.P
If the class_hints argument is non-null, it shall set WM_CLASS property.
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
	regr_args.iter = 1;	/* execute service once	*/
	estatus[0] = 1;

        setlocale(LC_ALL, "C") ;
	display_good = display_arg;
	window_id_good = window_arg;

	XSelectInput(display_arg, window_arg, PropertyChangeMask);

	estatus[0] = 1;
	estatus[1] = Success;

	if ((regr_args.l_flags.good == 0) || (estatus[1] == Success)) 
	{
		tet_infoline("TEST: XmbSetWMProperties sets all the specified window properties");
		regr_args.l_flags.setup = 0;
		regr_args.l_flags.cleanup = 1;
		regr_args.l_flags.chkdpy = 0;
		regr_args.l_flags.chksta = 1;
		regr_args.l_flags.check = 1;
		
		{
    		svcmbSetWMProperties(display_good, window_id_good,
	 			window_name_good, icon_name_good,
	 			argv_good, num_args_good, hints_good,
	 			wm_hints, class_hints);

		}
	} /* end if */
	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
