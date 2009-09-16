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
$Header: /cvs/xtest/xtest/xts5/tset/Xlib16/XrmCombineDatabase/XrmCombineDatabase.m,v 1.1 2005-02-12 14:37:24 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xlib16/XrmCombineDatabase/XrmCombineDatabase.m
>># 
>># Description:
>>#	Tests for XrmCombineDatabase()
>># 
>># Modifications:
>># $Log: rmcomdt.m,v $
>># Revision 1.1  2005-02-12 14:37:24  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:34:24  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:56:44  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:25:44  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:22:16  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.1  1996/02/13 23:40:28  andy
>># Corrected logic and implementation problems reported by X Consortium.
>># Added assertions 2-6.
>>#
>># Revision 4.0  1995/12/15  09:10:28  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:12:53  andy
>># Prepare for GA Release
>>#
>>AVSCODE
>>TITLE XrmCombineDatabase Xlib16
void
XrmCombineDatabase()
>>EXTERN

char *src_specifier = "test.Quark:happy";
char *src_specifier1 = "test1.Quark:happier";
char *src_specifier2 = "test2.Quark:happiest";
char *dst_specifier = "test.Quark:sad";
char *str_name = "test.Quark";
char *str_name1 = "test1.Quark";
char *str_name2 = "test2.Quark";
char *dst_value = "sad";
char *src_value = "happy";
char *src_value1 = "happier";
char *src_value2 = "happiest";
char *str_class = "";
char *str_type_return;
XrmValue value_return;

XrmDatabase database_id = NULL;
XrmDatabase database_id2 = NULL;
XrmDatabase src_database_id;
XrmDatabase dst_database_id;
				
char *exec_file_name;
int x_init,
	y_init,
	h_init,
	w_init;

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

int	ss_status;		/* save stat return status */	
int	stat_status;		/* check stat return status */
int	setup_status;
int	cleanup_status;
int	i1;

>>ASSERTION Good C
If the implementation is X11R5 or later:
A call to 
.B XrmCombineDatabase
shall merge the contents of src_db into target_db.
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
	estatus[1] = Success;

	if ((regr_args.l_flags.good == 0) || (estatus[1] == Success)) {
		regr_args.l_flags.check = 1;
		regr_args.l_flags.chksta = 1;

		tet_infoline("PREP: Add data to two separate databases");
  		XrmPutLineResource(&database_id2, src_specifier);
  		XrmPutLineResource(&database_id, src_specifier1);
  		XrmPutLineResource(&database_id, src_specifier2);
  		src_database_id = database_id;
  		dst_database_id = database_id2;

		tet_infoline("PREP: Call to XrmCombineDatabase to merge databases");

		regr_args.l_flags.bufrout = 1;

		if (regr_args.l_flags.setup) 
			setup_status = REGR_NORMAL;
		XSync(display_arg, 0);

		if (regr_args.l_flags.chksta  == 1)
			ss_status = save_stat(0, gc_id, display_arg, drawable_id);

		errflg = 0;
		XSetErrorHandler(signal_status);
		XrmCombineDatabase(src_database_id, &dst_database_id, True);

		XSync(display_arg, 0);
		XSetErrorHandler(unexp_err);	  
		/* no colormap by default */
		r_wait(display_arg, window_arg, time_delay, None);	
					   
		if (regr_args.l_flags.chksta  == 1) 
			stat_status = chek_stat (0, gc_id, display_arg,
			 drawable_id, ss_status);
		else				  
			stat_status = REGR_NORMAL;

		if ((regr_args.l_flags.check) && (errflg == 0) && (stat_status == REGR_NORMAL)) {

			tet_infoline("TEST: Databases are merged");
			(void)XrmGetResource(dst_database_id, str_name1, 
				str_class, &str_type_return, &value_return);

			if (strcmp(value_return.addr, src_value1) != 0) {
	
				sprintf(ebuf, "ERROR: Expected value of %s to be \"%s\", is \"%s\"", str_name1, src_specifier1, value_return.addr);
				tet_infoline(ebuf);
				tet_result(TET_FAIL);
				errflg = 1;
			}
			(void)XrmGetResource(dst_database_id, str_name2, 
				str_class, &str_type_return, &value_return);

			if (strcmp(value_return.addr, src_value2) != 0) {
	
				sprintf(ebuf, "ERROR: Expected value of %s to be \"%s\", is \"%s\"", str_name2, src_specifier2, value_return.addr);
				tet_infoline(ebuf);
				tet_result(TET_FAIL);
				errflg = 1;
			}
			(void)XrmGetResource(dst_database_id, str_name, 
				str_class, &str_type_return, &value_return);

	
			if (strcmp(value_return.addr, src_value) != 0) {
	
				sprintf(ebuf, "ERROR: Expected value of %s to be \"%s\", is \"%s\"", str_name, src_specifier, value_return.addr);
				tet_infoline(ebuf);
				tet_result(TET_FAIL);
				errflg = 1;
			}

		}
	}

	XSync(display_arg, 0);

	if (regr_args.l_flags.cleanup)
		cleanup_status = REGR_NORMAL;

	XSync(display_arg, 0);
	dumpbuf();
	chkflg = 0;
	regr_args.l_flags.bufrout = 0;

	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
>>ASSERTION Good C
If the implementation is X11R5 or later:
A call to 
.B XrmCombineDatabase
when the same specifier is used for an entry in both databases and
override is True the entry in source_db shall replace the entry
in target_db.
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
	estatus[1] = Success;

	if ((regr_args.l_flags.good == 0) || (estatus[1] == Success)) {
		regr_args.l_flags.check = 1;
		regr_args.l_flags.chksta = 1;

		tet_infoline("PREP: Add data to two separate databases");
		database_id = database_id2 = NULL;
  		XrmPutLineResource(&database_id, src_specifier);
  		XrmPutLineResource(&database_id, src_specifier1);
  		XrmPutLineResource(&database_id, src_specifier2);
  		XrmPutLineResource(&database_id2, dst_specifier);
  		src_database_id = database_id;
  		dst_database_id = database_id2;

		tet_infoline("PREP: Call to XrmCombineDatabase to merge databases");

		regr_args.l_flags.bufrout = 1;

		if (regr_args.l_flags.setup) 
			setup_status = REGR_NORMAL;
		XSync(display_arg, 0);

		if (regr_args.l_flags.chksta  == 1)
			ss_status = save_stat(0, gc_id, display_arg, drawable_id);

		errflg = 0;
		XSetErrorHandler(signal_status);
		XrmCombineDatabase(src_database_id, &dst_database_id, True);

		XSync(display_arg, 0);
		XSetErrorHandler(unexp_err);	  
		/* no colormap by default */
		r_wait(display_arg, window_arg, time_delay, None);	
					   
		if (regr_args.l_flags.chksta  == 1) 
			stat_status = chek_stat (0, gc_id, display_arg,
			 drawable_id, ss_status);
		else				  
			stat_status = REGR_NORMAL;

		if ((regr_args.l_flags.check) && (errflg == 0) && (stat_status == REGR_NORMAL)) {

			tet_infoline("TEST: Source value overrides");
			(void)XrmGetResource(dst_database_id, str_name, 
				str_class, &str_type_return, &value_return);

	
			if (strcmp(value_return.addr, src_value) != 0) {
	
				sprintf(ebuf, "ERROR: Expected value of %s to be \"%s\", is \"%s\"", str_name, src_specifier, value_return.addr);
				tet_infoline(ebuf);
				tet_result(TET_FAIL);
				errflg = 1;
			}

		}
	}

	XSync(display_arg, 0);

	if (regr_args.l_flags.cleanup)
		cleanup_status = REGR_NORMAL;

	XSync(display_arg, 0);
	dumpbuf();
	chkflg = 0;
	regr_args.l_flags.bufrout = 0;

	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
>>ASSERTION Good C
If the implementation is X11R5 or later:
A call to 
.B XrmCombineDatabase
when the same specifier is used for an entry in both databases and
override is not True the entry in source_db shall not replace the entry
in target_db.
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
	estatus[1] = Success;

	if ((regr_args.l_flags.good == 0) || (estatus[1] == Success)) {
		regr_args.l_flags.check = 1;
		regr_args.l_flags.chksta = 1;

		tet_infoline("PREP: Add data to two separate databases");
		database_id = database_id2 = NULL;
  		XrmPutLineResource(&database_id, src_specifier);
  		XrmPutLineResource(&database_id, src_specifier1);
  		XrmPutLineResource(&database_id, src_specifier2);
  		XrmPutLineResource(&database_id2, dst_specifier);
  		src_database_id = database_id;
  		dst_database_id = database_id2;

		tet_infoline("PREP: Call to XrmCombineDatabase to merge databases");

		regr_args.l_flags.bufrout = 1;

		if (regr_args.l_flags.setup) 
			setup_status = REGR_NORMAL;
		XSync(display_arg, 0);

		if (regr_args.l_flags.chksta  == 1)
			ss_status = save_stat(0, gc_id, display_arg, drawable_id);

		errflg = 0;
		XSetErrorHandler(signal_status);
		XrmCombineDatabase(src_database_id, &dst_database_id, False);

		XSync(display_arg, 0);
		XSetErrorHandler(unexp_err);	  
		/* no colormap by default */
		r_wait(display_arg, window_arg, time_delay, None);	
					   
		if (regr_args.l_flags.chksta  == 1) 
			stat_status = chek_stat (0, gc_id, display_arg,
			 drawable_id, ss_status);
		else				  
			stat_status = REGR_NORMAL;

		if ((regr_args.l_flags.check) && (errflg == 0) && (stat_status == REGR_NORMAL)) {

			tet_infoline("TEST: Source value does not override");
			(void)XrmGetResource(dst_database_id, str_name, 
				str_class, &str_type_return, &value_return);

	
			if (strcmp(value_return.addr, dst_value) != 0) {
	
				sprintf(ebuf, "ERROR: Expected value of %s to be \"%s\", is \"%s\"", str_name, src_specifier, value_return.addr);
				tet_infoline(ebuf);
				tet_result(TET_FAIL);
				errflg = 1;
			}

		}
	}

	XSync(display_arg, 0);

	if (regr_args.l_flags.cleanup)
		cleanup_status = REGR_NORMAL;

	XSync(display_arg, 0);
	dumpbuf();
	chkflg = 0;
	regr_args.l_flags.bufrout = 0;

	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
>>ASSERTION Good C
If the implementation is X11R5 or later:
A call to 
.B XrmCombineDatabase
when target_db is NULL shall store source_db in it.
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
	estatus[1] = Success;

	if ((regr_args.l_flags.good == 0) || (estatus[1] == Success)) {
		regr_args.l_flags.check = 1;
		regr_args.l_flags.chksta = 1;

		tet_infoline("PREP: Add data to a database");
		database_id = database_id2 = NULL;
  		XrmPutLineResource(&database_id, src_specifier);
  		XrmPutLineResource(&database_id, src_specifier1);
  		XrmPutLineResource(&database_id, src_specifier2);
  		src_database_id = database_id;
  		dst_database_id = database_id2;

		tet_infoline("PREP: Call to XrmCombineDatabase to merge database with target_db NULL");

		regr_args.l_flags.bufrout = 1;

		if (regr_args.l_flags.setup) 
			setup_status = REGR_NORMAL;
		XSync(display_arg, 0);

		if (regr_args.l_flags.chksta  == 1)
			ss_status = save_stat(0, gc_id, display_arg, drawable_id);

		errflg = 0;
		XSetErrorHandler(signal_status);
		XrmCombineDatabase(src_database_id, &dst_database_id, False);

		XSync(display_arg, 0);
		XSetErrorHandler(unexp_err);	  
		/* no colormap by default */
		r_wait(display_arg, window_arg, time_delay, None);	
					   
		if (regr_args.l_flags.chksta  == 1) 
			stat_status = chek_stat (0, gc_id, display_arg,
			 drawable_id, ss_status);
		else				  
			stat_status = REGR_NORMAL;

		if ((regr_args.l_flags.check) && (errflg == 0) && (stat_status == REGR_NORMAL)) {

			tet_infoline("TEST: source_db copied to target_db");
	
			if (dst_database_id != src_database_id) {
	
				sprintf(ebuf, "ERROR: Expected value of target_db to be source_db (%p) is %p", src_database_id, dst_database_id);
				tet_infoline(ebuf);
				tet_result(TET_FAIL);
				errflg = 1;
			}

		}
	}

	XSync(display_arg, 0);

	if (regr_args.l_flags.cleanup)
		cleanup_status = REGR_NORMAL;

	XSync(display_arg, 0);
	dumpbuf();
	chkflg = 0;
	regr_args.l_flags.bufrout = 0;

	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
>>ASSERTION Good D 1
If the implementation is X11R5 or later:
A call to 
.B XrmCombineDatabase
shall merge database entries without changing values of types,
regardless of the locales of the databases.
>>ASSERTION Good D 1
If the implementation is X11R5 or later:
A call to 
.B XrmCombineDatabase
shall not modify the locale of the target database.
