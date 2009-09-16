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
$Header: /cvs/xtest/xtest/xts5/tset/Xlib16/XrmEnumerateDatabase/XrmEnumerateDatabase.m,v 1.2 2005-04-21 09:40:42 ajosey Exp $

Copyright (c) 2002 The Open Group
Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xlib16/XrmEnumerateDatabase/XrmEnumerateDatabase.m
>># 
>># Description:
>>#	Tests for XrmEnumerateDatabase()
>># 
>># Modifications:
>># $Log: rmedata.m,v $
>># Revision 1.2  2005-04-21 09:40:42  ajosey
>># resync to VSW5.1.5
>>#
>># Revision 8.2  2005/01/21 10:46:07  gwc
>># Updated copyright notice
>>#
>># Revision 8.1  2002/06/11 09:29:21  gwc
>># First arg of XrmPutStringResource was passed incorrectly
>>#
>># Revision 8.0  1998/12/23 23:34:26  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:56:46  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:25:45  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:22:17  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.1  1996/09/13 22:08:57  srini
>># Enhancements and clean-up
>>#
>># Revision 4.0  1995/12/15  09:10:32  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:12:57  andy
>># Prepare for GA Release
>>#
>>AVSCODE
>>TITLE XrmEnumerateDatabase Xlib16
void
XrmEnumerateDatabase()
>>EXTERN

char	*file_name_good = "xtestinfo.dat";
XrmDatabase	database_id_good = NULL;
XrmDatabase gfd_return, gfd_return2;

char		*contents_name_good = "test.Quark:happy\n";
XrmNameList 	quark_name;

char *exec_file_name;
int x_init, y_init, h_init, w_init;

typedef struct _SampleData {
    char *name;
    XrmRepresentation type;
    XrmValuePtr value;
} SampleData;

/*ARGSUSED*/
static Bool 
SearchFunc(db, bindings, quarks, type, value, data)
XrmDatabase         *db;
XrmBindingList      bindings;
XrmQuarkList        quarks;
XrmRepresentation   *type;
XrmValuePtr         value;
XPointer            data;
{
    SampleData *gd = (SampleData *)data;

    /* may as well return True */
    if ((*type == gd->type) && (value->size == gd->value->size) &&
        !strncmp((char *)value->addr, (char *)gd->value->addr, value->size))
    {
        gd->name = XrmQuarkToString(*quarks); /* XXX */
    }

    return True;
}

/*ARGSUSED*/
static Bool 
FalseFunc(db, bindings, quarks, type, value, data)
XrmDatabase         *db;
XrmBindingList      bindings;
XrmQuarkList        quarks;
XrmRepresentation   *type;
XrmValuePtr         value;
XPointer            data;
{
    return False;
}


>>ASSERTION Good C
If the implementation is X11R5 or later:
A call to 
.B XrmEnumerateDatabase
shall invoke the procedure
.I proc
for each resource in the database that would match given name/class resource
prefix and return True.
>>CODE
#if XT_X_RELEASE > 4
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
  		setup_status,
  		cleanup_status,
		i1;
        Bool      svc_ret_value;
	char buf[9];
	XrmValue resval;
	XrmQuark empty = NULLQUARK;
	SampleData data;
	XrmDatabase  database ;
#endif


#if XT_X_RELEASE > 4
	display_arg = Dsp;

	/*
 	* Create a GC to save environmental data in
 	*/
	gc_save = XCreateGC(display_arg,XRootWindow(display_arg,XDefaultScreen(display_arg)),(unsigned long)0,(XGCValues *)0);

        XrmInitialize();

	sprintf(buf, "%s", "test");
	resval.addr = (XPointer)buf;
	resval.size = strlen(buf) + 1;
	data.name = (char *)NULL;
	data.type = XrmPermStringToQuark("String");
	data.value = &resval;

	tet_infoline("PREP: Create a database");
	database = XrmGetStringDatabase(contents_name_good);
	XrmPutStringResource(&database, "test.Quark", "happy");

	tet_infoline("PREP: Associate the database with display");
	XrmSetDatabase(display_arg, database);

/*
	XrmStringToNameList("test*Quark", quark_name);
*/

	tet_infoline("TEST: XrmEnumerateDatabase calls the procedure");
	XSync(display_arg, 0);

	XSetErrorHandler(signal_status);
	svc_ret_value = XrmEnumerateDatabase(
		   database, (XrmNameList)&empty,
		   (XrmClassList)&empty, XrmEnumAllLevels,
		   SearchFunc, (XPointer)&data );
	XSync(display_arg, 0);
	XSetErrorHandler(unexp_err);          

	if (svc_ret_value != True)
	{
		tet_infoline("ERROR: xname did not return correct value");
		sprintf(ebuf, "      Expected: %d(True) Got: %d", True, svc_ret_value);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}

	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
>>ASSERTION Good C
If the implementation is X11R5 or later:
A call to 
.B XrmEnumerateDatabase
when the called procedure returns True shall return True.
>>CODE
#if XT_X_RELEASE > 4
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
  		setup_status,
  		cleanup_status,
		i1;
        Bool      svc_ret_value;
	char buf[9];
	XrmValue resval;
	XrmQuark empty = NULLQUARK;
	SampleData data;
	XrmDatabase  database ;
#endif


#if XT_X_RELEASE > 4
	display_arg = Dsp;

	/*
 	* Create a GC to save environmental data in
 	*/
	gc_save = XCreateGC(display_arg,XRootWindow(display_arg,XDefaultScreen(display_arg)),(unsigned long)0,(XGCValues *)0);

        XrmInitialize();

	sprintf(buf, "%s", "test");
	resval.addr = (XPointer)buf;
	resval.size = strlen(buf) + 1;
	data.name = (char *)NULL;
	data.type = XrmPermStringToQuark("String");
	data.value = &resval;

	tet_infoline("PREP: Create a database");
	database = XrmGetStringDatabase(contents_name_good);
	XrmPutStringResource(&database, "test.Quark", "happy");

	tet_infoline("PREP: Associate the database with display");
	XrmSetDatabase(display_arg, database);

	tet_infoline("TEST: XrmEnumerateDatabase returns True.");
	XSync(display_arg, 0);

	XSetErrorHandler(signal_status);
	svc_ret_value = XrmEnumerateDatabase(
		   database, (XrmNameList)&empty,
		   (XrmClassList)&empty, XrmEnumAllLevels,
		   SearchFunc, (XPointer)&data );
	XSync(display_arg, 0);
	XSetErrorHandler(unexp_err);          

	if (svc_ret_value != True)
	{
		tet_infoline("ERROR: xname did not return correct value");
		sprintf(ebuf, "      Expected: %d(True) Got: %d", True, svc_ret_value);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}

	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
>>ASSERTION Good C
If the implementation is X11R5 or later:
A call to 
.B XrmEnumerateDatabase
when the called procedure returns False shall terminate the enumeration
and return False.
>>CODE
#if XT_X_RELEASE > 4
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
  		setup_status,
  		cleanup_status,
		i1;
        Bool      svc_ret_value;
	char buf[9];
	XrmValue resval;
	XrmQuark empty = NULLQUARK;
	SampleData data;
	XrmDatabase  database ;
#endif


#if XT_X_RELEASE > 4
	display_arg = Dsp;

	/*
 	* Create a GC to save environmental data in
 	*/
	gc_save = XCreateGC(display_arg,XRootWindow(display_arg,XDefaultScreen(display_arg)),(unsigned long)0,(XGCValues *)0);

        XrmInitialize();

	sprintf(buf, "%s", "test");
	resval.addr = (XPointer)buf;
	resval.size = strlen(buf) + 1;
	data.name = (char *)NULL;
	data.type = XrmPermStringToQuark("String");
	data.value = &resval;

	tet_infoline("PREP: Create a database");
	database = XrmGetStringDatabase(contents_name_good);
	XrmPutStringResource(&database, "test.Quark", "happy");

	tet_infoline("PREP: Associate the database with display");
	XrmSetDatabase(display_arg, database);

	tet_infoline("TEST: XrmEnumerateDatabase returns False.");
	XSync(display_arg, 0);

	XSetErrorHandler(signal_status);
	svc_ret_value = XrmEnumerateDatabase(
		   database, (XrmNameList)&empty,
		   (XrmClassList)&empty, XrmEnumAllLevels,
		   FalseFunc, (XPointer)&data );
	XSync(display_arg, 0);
	XSetErrorHandler(unexp_err);          

	if (svc_ret_value != False)
	{
		tet_infoline("ERROR: xname did not return correct value");
		sprintf(ebuf, "      Expected: %d(False) Got: %d", False, svc_ret_value);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}

	tet_result(TET_PASS);
#else
	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
