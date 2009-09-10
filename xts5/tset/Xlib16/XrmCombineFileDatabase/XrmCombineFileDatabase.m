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
$Header: /cvs/xtest/xtest/xts5/tset/Xlib16/XrmCombineFileDatabase/XrmCombineFileDatabase.m,v 1.1 2005-02-12 14:37:24 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xlib16/XrmCombineFileDatabase/XrmCombineFileDatabase.m
>># 
>># Description:
>>#	Tests for XrmCombineFileDatabase()
>># 
>># Modifications:
>># $Log: rmcomfdt.m,v $
>># Revision 1.1  2005-02-12 14:37:24  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:34:25  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:56:45  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:25:44  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:22:17  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.2  1996/08/20 19:28:20  srini
>># Added tests #2-6
>>#
>># Revision 4.1  1996/02/14  00:01:33  andy
>># Corrcected specifier passed to XrmGetResource so value is not include.
>>#
>># Revision 4.0  1995/12/15  09:10:30  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:12:55  andy
>># Prepare for GA Release
>>#
>>AVSCODE
>>TITLE XrmCombineFileDatabase Xlib16
void
XrmCombineFileDatabase()
>>EXTERN

/******
 * User defined globals for test
 ******/
char *src_spec1 = "test.Quark:happy";
char *src_spec2 = "test1.Quark:happier";
char *src_spec3 = "test2.Quark:happiest";
char *dst_spec = "test.Quark:sad";

char *str_name = "test.Quark";
char *str2_name = "test1.Quark";
char *str3_name = "test2.Quark";
char *str_class = "";
char *str_type_return;
XrmValue value_return;

char *src_value = "happy";
char *src2_value = "happier";
char *src3_value = "happiest";
char *dst_value = "sad";

XrmDatabase gfd_return;
XrmDatabase dst_database_id;

char	*file_name_good = "xtestinfo.dat";

char *exec_file_name;
int x_init, y_init, h_init, w_init;

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

int 	ss_status,		/* save stat return status */	
	stat_status,		/* check stat return status */
	setup_status,
	cleanup_status,
	i1;

Status      svc_ret_value;


>>ASSERTION Good C
If the implementation is X11R5 or later:
A call to 
.B XrmCombineFileDatabase
shall merge the contents of a resource file into a database.
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
	estatus[0] = 1;

        XrmInitialize();

	estatus[0] = 1;
	estatus[1] = Success;

	regr_args.l_flags.setup = 1;
	regr_args.l_flags.check = 1;
	regr_args.l_flags.chksta = 1;

	gfd_return = XrmGetStringDatabase(src_spec1);

	tet_infoline("PREP: Add data to resource file");
	(void)XrmPutFileDatabase(gfd_return, file_name_good);
	tet_infoline("PREP: Add to database");

	(void)XrmPutLineResource(&dst_database_id, dst_spec);

	tet_infoline("TEST: Call to XrmCombineFileDatabase merges resource file into database");
	XrmCombineFileDatabase(file_name_good, &dst_database_id, True);

	XSync(display_arg, 0);
	XSetErrorHandler(unexp_err);          
	/* no colormap by default */
	r_wait(display_arg, window_arg, time_delay, None);	
	if (regr_args.l_flags.chksta  == 1) 
		stat_status = chek_stat (0, gc_id, display_arg,
			 drawable_id, ss_status);
	else                              
		stat_status = REGR_NORMAL;

	if ((!errflg) && (!chkflg)) 
		if ((badstat(display_arg, estatus, Success)) != REGR_NORMAL)
			errflg = 1;

	if ((regr_args.l_flags.check) && (errflg == 0) && 
	    (stat_status == REGR_NORMAL)) 
	{
		XrmGetResource(dst_database_id, str_name, str_class, 
			&str_type_return, &value_return);


		if (strcmp(value_return.addr, src_value) != 0) {

			sprintf(ebuf, "ERROR: Expected value of %s to be \"%s\", is \"%s\"", str_name, src_value, value_return.addr);
			tet_infoline(ebuf);
			tet_result(TET_FAIL);
		}
	}
	XSync(display_arg, 0);
	chkflg = 0;
	regr_args.l_flags.bufrout = 0;
	dumpbuf();
	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
>>ASSERTION Good C
If the implementation is X11R5 or later:
A call to 
.B XrmCombineFileDatabase
when the same specifier is used for an entry in both the file and the
database and override is True the entry in filename shall replace 
the entry in target_db.
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
	estatus[0] = 1;

        XrmInitialize();

	estatus[1] = Success;

	regr_args.l_flags.setup = 1;
	regr_args.l_flags.check = 1;
	regr_args.l_flags.chksta = 1;

	gfd_return = XrmGetStringDatabase(src_spec1);
	(void)XrmPutLineResource(&gfd_return, src_spec2);
	(void)XrmPutLineResource(&gfd_return, src_spec3);

	tet_infoline("PREP: Add data to resource file");
	(void)XrmPutFileDatabase(gfd_return, file_name_good);

	tet_infoline("PREP: Add to database");
	(void)XrmPutLineResource(&dst_database_id, dst_spec);

	tet_infoline("TEST: Entry in the file replaces the database entry");
	XrmCombineFileDatabase(file_name_good, &dst_database_id, True);

	XSync(display_arg, 0);
	XSetErrorHandler(unexp_err);          
	/* no colormap by default */
	r_wait(display_arg, window_arg, time_delay, None);	
	if (regr_args.l_flags.chksta  == 1) 
		stat_status = chek_stat (0, gc_id, display_arg,
			 drawable_id, ss_status);
	else                              
		stat_status = REGR_NORMAL;

	if ((!errflg) && (!chkflg)) 
		if ((badstat(display_arg, estatus, Success)) != REGR_NORMAL)
			errflg = 1;

	if ((regr_args.l_flags.check) && (errflg == 0) && 
	    (stat_status == REGR_NORMAL)) 
	{
		XrmGetResource(dst_database_id, str_name, str_class, 
			&str_type_return, &value_return);


		if (strcmp(value_return.addr, src_value) != 0) {

			sprintf(ebuf, "ERROR: Expected value of %s to be \"%s\", is \"%s\"", str_name, src_value, value_return.addr);
			tet_infoline(ebuf);
			tet_result(TET_FAIL);
		}
	}
	XSync(display_arg, 0);
	chkflg = 0;
	regr_args.l_flags.bufrout = 0;
	dumpbuf();
	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
>>ASSERTION Good C
If the implementation is X11R5 or later:
A call to 
.B XrmCombineFileDatabase
when the same specifier is used for an entry in both the file and the 
database and override is not True the entry in filename shall not 
replace the entry in target_db.
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
	estatus[0] = 1;

        XrmInitialize();

	estatus[1] = Success;

	regr_args.l_flags.setup = 1;
	regr_args.l_flags.check = 1;
	regr_args.l_flags.chksta = 1;

	gfd_return = XrmGetStringDatabase(src_spec1);
	(void)XrmPutLineResource(&gfd_return, src_spec2);
	(void)XrmPutLineResource(&gfd_return, src_spec3);

	tet_infoline("PREP: Add data to resource file");
	(void)XrmPutFileDatabase(gfd_return, file_name_good);

	tet_infoline("PREP: Add to database");
	(void)XrmPutLineResource(&dst_database_id, dst_spec);

	tet_infoline("TEST: Entry in the file does not replace the database entry");
	XrmCombineFileDatabase(file_name_good, &dst_database_id, False);

	XSync(display_arg, 0);
	XSetErrorHandler(unexp_err);          
	/* no colormap by default */
	r_wait(display_arg, window_arg, time_delay, None);	
	if (regr_args.l_flags.chksta  == 1) 
		stat_status = chek_stat (0, gc_id, display_arg,
			 drawable_id, ss_status);
	else                              
		stat_status = REGR_NORMAL;

	if ((!errflg) && (!chkflg)) 
		if ((badstat(display_arg, estatus, Success)) != REGR_NORMAL)
			errflg = 1;

	if ((regr_args.l_flags.check) && (errflg == 0) && 
	    (stat_status == REGR_NORMAL)) 
	{
		XrmGetResource(dst_database_id, str_name, str_class, 
			&str_type_return, &value_return);

		if (strcmp(value_return.addr, dst_value) != 0) {

			sprintf(ebuf, "ERROR: Expected value of %s to be \"%s\", is \"%s\"", str_name, dst_value, value_return.addr);
			tet_infoline(ebuf);
			tet_result(TET_FAIL);
		}
	}
	XSync(display_arg, 0);
	chkflg = 0;
	regr_args.l_flags.bufrout = 0;
	dumpbuf();
	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
>>ASSERTION Good C
If the implementation is X11R5 or later:
A call to 
.B XrmCombineDatabase
when target_db is NULL shall create a new database with entries from
filename in it.
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
	estatus[0] = 1;

        XrmInitialize();

	estatus[0] = 1;
	estatus[1] = Success;

	regr_args.l_flags.setup = 1;
	regr_args.l_flags.check = 1;
	regr_args.l_flags.chksta = 1;

	tet_infoline("PREP: Add data to resource file");
	gfd_return = XrmGetStringDatabase(src_spec1);
	(void)XrmPutLineResource(&gfd_return, src_spec2);
	(void)XrmPutLineResource(&gfd_return, src_spec3);
	(void)XrmPutFileDatabase(gfd_return, file_name_good);

	dst_database_id = NULL;

	tet_infoline("TEST: When target_db is NULL a new database is created");
	XrmCombineFileDatabase(file_name_good, &dst_database_id, True);

	XSync(display_arg, 0);
	XSetErrorHandler(unexp_err);          

	if (dst_database_id == NULL)
	{
		sprintf(ebuf, "ERROR: Expected value of target_db to be non-NULL is %p", dst_database_id);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	/* Search for entries */
	sprintf(ebuf, "	INFO: Check Resource: %s", str_name);
	tet_infoline(ebuf);
	XrmGetResource(dst_database_id, str_name, str_class, 
		&str_type_return, &value_return);
	if (strcmp(value_return.addr, src_value) != 0) {

		sprintf(ebuf, "ERROR: Expected value of %s to be \"%s\", is \"%s\"", str_name, src_value, value_return.addr);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}

	sprintf(ebuf, "	INFO: Check Resource: %s", str2_name);
	tet_infoline(ebuf);
	XrmGetResource(dst_database_id, str2_name, str_class, 
		&str_type_return, &value_return);
	if (strcmp(value_return.addr, src2_value) != 0) {

		sprintf(ebuf, "ERROR: Expected value of %s to be \"%s\", is \"%s\"", str2_name, src2_value, value_return.addr);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}

	sprintf(ebuf, "	INFO: Check Resource: %s", str3_name);
	tet_infoline(ebuf);
	XrmGetResource(dst_database_id, str3_name, str_class, 
		&str_type_return, &value_return);
	if (strcmp(value_return.addr, src3_value) != 0) {

		sprintf(ebuf, "ERROR: Expected value of %s to be \"%s\", is \"%s\"", str3_name, src3_value, value_return.addr);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	XSync(display_arg, 0);
	chkflg = 0;
	regr_args.l_flags.bufrout = 0;
	dumpbuf();
	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
>>ASSERTION Good D 1
If the implementation is X11R5 or later:
A call to 
.B XrmCombineFileDatabase
shall merge entries from filename and target_db without changing 
values of types, regardless of the locales of the database.
>>ASSERTION Good D 1
If the implementation is X11R5 or later:
A call to 
.B XrmCombineFileDatabase
shall not modify the locale of the target database.
