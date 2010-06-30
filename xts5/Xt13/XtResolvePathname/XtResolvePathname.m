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

Copyright (c) 1999 The Open Group
Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: xts/Xt13/XtResolvePathname/XtResolvePathname.m
>># 
>># Description:
>>#	Tests for XtResolvePathname()
>># 
>># Modifications:
>># $Log: trspathnm.m,v $
>># Revision 1.2  2005-04-21 09:40:42  ajosey
>># resync to VSW5.1.5
>>#
>># Revision 8.2  2005/01/21 12:16:55  gwc
>># Updated copyright notice
>>#
>># Revision 8.1  1999/11/26 10:40:47  vsx
>># avoid fixed file locations (for exec-in-place false)
>>#
>># Revision 8.0  1998/12/23 23:38:26  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:28  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.1  1998/06/23 23:10:04  andy
>># Added sleep(XT_RESET_DELAY) to vsw_init_lang().  SR# 186.
>>#
>># Revision 6.0  1998/03/02 05:29:28  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:26:01  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.1  1997/01/21 18:07:36  mar
>># req.4.W.00036: tp19 - ensure that thelangproc() is set to return both a
>># language and a territory part.
>>#
>># Revision 4.0  1995/12/15  09:22:22  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:18:35  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;

char pathname1[]	= "/test/path/";
char string_good1_1[] = "/test/path/128data1";
char string_good1_2[] = "/test/path/data1128";
Boolean FindFile1(string)
String string;
{
int count1;

	count1 = avs_get_event(1);

	if (count1 == 0) {
		tet_infoline("TEST: First string passed to predicate has substitutions");
		check_str(string_good1_1, string, "First string passed to predicate");
		avs_set_event(1, 1);
		tet_infoline("PREP: Return false for first string");
		return(FALSE);
	}
	if (count1 == 1) {
		tet_infoline("TEST: Second string passed to predicate has substitutions");
		check_str(string_good1_2, string, "Second string passed to predicate");
		avs_set_event(1, 2);
		tet_infoline("PREP: Return true for second string");
		return(TRUE);
	}
	sprintf(ebuf, "ERROR: path contained two strings but predicate called %d times", count1++);
	avs_set_event(1, count1);
	tet_infoline(ebuf);
	tet_result(TET_FAIL);
}

Boolean FindFileFail(string)
String string;
{
	avs_set_event(1, 1);
	return(FALSE);
}

char *pathname2	= "/test/path/%N";
char *string_good2 = "/test/path/TEST_N";
Boolean FindFile2(string)
String string;
{
	avs_set_event(1, 1);
	check_str(string_good2, string, "String passed to predicate");
	return(TRUE);
}
char *pathname3	= "/test/path/%N";
char *string_good3 = "/test/path/Trspathnm3";
Boolean FindFile3(string)
String string;
{
	avs_set_event(1, 1);
	check_str(string_good3, string, "String passed to predicate");
	return(TRUE);
}
char *pathname3a	= "/test/%:path/%:";
char *string_good3a = "/test/:path/:";
Boolean FindFile3a(string)
String string;
{
	avs_set_event(1, 1);
	check_str(string_good3a, string, "String passed to predicate");
	return(TRUE);
}
char *pathname4	= "/test/path/%T";
char *string_good4 = "/test/path/TEST_T";
Boolean FindFile4(string)
String string;
{
	avs_set_event(1, 1);
	check_str(string_good4, string, "String passed to predicate");
	return(TRUE);
}
char *pathname4a	= "/test/%%path/%%";
char *string_good4a = "/test/%path/%";
Boolean FindFile4a(string)
String string;
{
	avs_set_event(1, 1);
	check_str(string_good4a, string, "String passed to predicate");
	return(TRUE);
}
char *pathname5	= "/test/path/%S";
char *string_good5 = "/test/path/TEST_S";
Boolean FindFile5(string)
String string;
{
	avs_set_event(1, 1);
	check_str(string_good5, string, "String passed to predicate");
	return(TRUE);
}
char *pathname5a = ":/test/path/%S";
char *string_good5a_1 = "TEST_FTEST_S";
char *string_good5a_2 = "/test/path/TEST_S";
Boolean FindFile5a(string)
String string;
{
int count1;

	count1 = avs_get_event(1);

	if (count1 == 0) {
		tet_infoline("TEST: First string passed to predicate is %N%S after substitution");
		check_str(string_good5a_1, string, "First string passed to predicate");
		avs_set_event(1, 1);
		tet_infoline("PREP: Return false for first string");
		return(FALSE);
	}
	if (count1 == 1) {
		tet_infoline("TEST: Second string passed to predicate has substitutions");
		check_str(string_good5a_2, string, "Second string passed to predicate");
		avs_set_event(1, 2);
		tet_infoline("PREP: Return true for second string");
		return(TRUE);
	}
	sprintf(ebuf, "ERROR: path contained two strings but predicate called %d times", count1++);
	avs_set_event(1, count1);
	tet_infoline(ebuf);
	tet_result(TET_FAIL);
}
char *string_good6 = "/test/path/TEST_ENV";
Boolean FindFile6(string)
String string;
{
	avs_set_event(1, 1);
	check_str(string_good6, string, "String passed to predicate");
	return(TRUE);
}
char *pathname6a = "/test/path/::%S";
char *string_good6a_1 = "/test/path/";
char *string_good6a_2 = "TEST_FTEST_S";
char *string_good6a_3 = "TEST_S";
Boolean FindFile6a(string)
String string;
{
int count1;

	count1 = avs_get_event(1);

	if (count1 == 0) {
		tet_infoline("TEST: First string passed to predicate is %N%S after substitution");
		check_str(string_good6a_1, string, "First string passed to predicate");
		avs_set_event(1, 1);
		tet_infoline("PREP: Return false for first string");
		return(FALSE);
	}
	if (count1 == 1) {
		tet_infoline("TEST: Second string passed to predicate has substitutions");
		check_str(string_good6a_2, string, "Second string passed to predicate");
		avs_set_event(1, 2);
		tet_infoline("PREP: Return false for second string");
		return(FALSE);
	}
	if (count1 == 2) {
		tet_infoline("TEST: Third string passed to predicate has substitutions");
		check_str(string_good6a_3, string, "Third string passed to predicate");
		avs_set_event(1, 3);
		tet_infoline("PREP: Return true for third string");
		return(TRUE);
	}
	sprintf(ebuf, "ERROR: path contained three strings but predicate called %d times", count1++);
	avs_set_event(1, count1);
	tet_infoline(ebuf);
	tet_result(TET_FAIL);
}
char *pathname7	= "/test/path/%L";
char *string_good7 = "/test/path/LANGUAGE_TERRITORY";
Boolean FindFile7(string)
String string;
{
	avs_set_event(1, 1);
	check_str(string_good7, string, "String passed to predicate");
	return(TRUE);
}
void failfor(str)
char *str;
{
	sprintf(ebuf, "ERROR: Expected string to contain %s", str);
	tet_infoline(ebuf);
	tet_result(TET_FAIL);
}

Boolean FindFile10(string)
String string;
{
int	count;
char	*str;

	count = avs_get_event(1);
	sprintf(ebuf, "INFO: String %d is \"%s\"", count+1, string);
	tet_infoline(ebuf);

	switch (count) {

		/*can't check for subsets of lang string as format not defined*/
		/*thus, can't differentiate between alternate valid forms
		or, therefor, require %L*/
		case 0:
		case 1:
		case 2:
			if (strstr(string, "CUSTOM") == NULL)
				failfor("%C (CUSTOM)");
			if (strstr(string, "FILE") == NULL)
				failfor("%N (FILE)");
			if (strstr(string, "SUFFIX") == NULL)
				failfor("%S (SUFFIX)");
			if (strstr(string, "SUFFIX") == NULL)
				failfor("%T (TYPE)");
			break;
		case 3:
		case 4:
		case 5:
			if (strstr(string, "FILE") == NULL)
				failfor("%N (FILE)");
			if (strstr(string, "SUFFIX") == NULL)
				failfor("%S (SUFFIX)");
			if (strstr(string, "SUFFIX") == NULL)
				failfor("%T (TYPE)");
			break;
		/*allow additional ones at the end*/
		default:
			break;
	}
	avs_set_event(1, count+1);
	return(FALSE);
}

char *pathname11	= "/test/path/%C";
char *string_good11 = "/test/path/CUSTOM";
Boolean FindFile11(string)
String string;
{
	avs_set_event(1, 1);
	check_str(string_good11, string, "String passed to predicate");
	return(TRUE);
}

String thelangproc(display, language, client_data)
Display *display;
String language;
XtPointer client_data;
{
	return("LANGUAGE_TERRITORY");
}

void vsw_init_lang()
{
char app_class[128]; 
Display *display;
Widget root_widget;
int x_origin, y_origin;		/* x, y origin of widget */
int width, height;		/* height and width of widget */
int DisplayWidthInPix;		/* Number of display width pixels */
int DisplayHeightInPix;		/* Number of display height pixels */
int DisplayWidthInMM;		/* display width in mm */
int PixelPerCM;			/* number of pixels in cms */
int argcount = 1;
char *	cfgdisplay;
char label[128];
String argvector[] = {"ApTest", NULL};
XrmDatabase database, database_custom;
char *contents = "ApTest.customization:CUSTOM";

	(void)XSetIOErrorHandler(x_handler);	/*X Handler for severe errors */
	(void)XSetErrorHandler(x_unexperr);	/* Unexpected XError handler */

	XtToolkitInitialize();

	app_ctext = XtCreateApplicationContext();

	(void)XtSetLanguageProc(app_ctext, thelangproc, NULL);

	/*
	** form application class name
	*/
	strcpy(app_class, "Trspathnm");
	/*
	** open display
	*/
	cfgdisplay = getenv("DISPLAY");
	if (cfgdisplay == 0) {
		tet_infoline("ERROR: DISPLAY not set");
		tet_result(TET_UNRESOLVED);
		exit(0);
	}
	if (strlen(cfgdisplay) == 0) {
		tet_infoline("ERROR: DISPLAY has empty value");
		tet_result(TET_UNRESOLVED);
		exit(0);
	}
	sleep(config.reset_delay);
	display = XtOpenDisplay(
		 app_ctext,			/* application context */
		 (String)cfgdisplay,		/* display name */
		 (String)NULL,			/*application name use argv[0]*/
		 app_class,			/* application class */
		 (XrmOptionDescRec *)NULL,	/* command line options */
		 (Cardinal)0,			/* num command line options */
		 &argcount,
		 argvector			/* command line args */
		 );


	if (!display) {
		sprintf(ebuf,"ERROR: Unable to open display %s", config.display);
		tet_infoline(ebuf);
		tet_result(TET_UNRESOLVED);
		exit(0);
	}

	tet_infoline("PREP: Merge customization string into display database");
	XrmInitialize();
	database_custom = XrmGetStringDatabase(contents);
	if (database_custom == NULL) {
		tet_infoline("ERROR: XrmGetStringDatabase returned NULL");
		tet_result(TET_FAIL);
		exit(0);
	}
	database = XrmGetDatabase(display);
	XrmCombineDatabase(database_custom, &database, True);
	XrmSetDatabase(display, database);

	XResetScreenSaver(display);

	/*
	** Get height and width of display in pixels and create a toplevel
	** shell with consistent height and width for any display.
	*/
	DisplayWidthInPix  = XDisplayWidth(display, XDefaultScreen(display));
	DisplayHeightInPix = XDisplayHeight(display, XDefaultScreen(display));
	DisplayWidthInMM = XDisplayWidthMM(display, XDefaultScreen(display));

	PixelPerCM = (DisplayWidthInPix * 10)/DisplayWidthInMM;

	x_origin =  2 * PixelPerCM;
	y_origin = 2 * PixelPerCM;
	width = DisplayWidthInPix - ( 4 * PixelPerCM );
	height = DisplayHeightInPix - ( 4 * PixelPerCM );

	topLevel = XtVaAppCreateShell(
		(String)NULL,		   	/*application name use argv[0]*/
		app_class,		  	/* application class */
		applicationShellWidgetClass, 	/* widget class */
		display,			/* display struct */
		XtNx, x_origin,		 	/* resource specifications */
		XtNy, y_origin,
		XtNwidth, width,
		XtNheight, height,
		(char *)NULL
		);

	trace("Set up the XtToolkitError handler");
	XtAppSetErrorMsgHandler(app_ctext, xt_handler);
	trace("Set up widget tree of depth eight (8) return panedw widget");
	panedw = (Widget) avs_xt_tree(topLevel);
	trace("Create boxw1 widget in panedw widget");
	boxw1 = (Widget) CreateBoxWidget(panedw);
         
	trace("Create rowcolw widget in boxw1 widget");
	rowcolw = (Widget) CreateRowColWidget(boxw1);
        trace("Create push button gadget `Quit' in rowcolw widget");
        click_quit = (Widget) CreatePushButtonGadget("Quit", rowcolw);
        trace("Add callback procedure DestroyTree to push button gadget `Quit' ");
        XtAddCallback(click_quit,
                          XtNcallback,
                          DestroyTree,
                          (XtPointer)topLevel
                          );
	trace("Get the label widget name");
	sprintf(label, "Xt Function: %s", "XtResolvePathname");
	trace("Create label widget `%s' in boxw1 widget", label);
	labelw = (Widget) CreateLabelWidget(label, boxw1);
	trace("Register procedure DestroyTree to handle events to rowcolw widget");
	XtAddEventHandler(rowcolw,
		  ButtonReleaseMask,
		  False,
		  (XtEventHandler)DestroyTree,
		  (Widget)topLevel
		  );
	trace("Create boxw2 widget in panedw widget");
	boxw2 = (Widget) CreateBoxWidget(panedw);
	trace("Set the height and width of boxw2 widget");
	ConfigureDimension(topLevel, boxw2);
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtResolvePathname Xt13
String
XtResolvePathname(display, type, filename, suffix, path, substitutions, num_substitutions, predicate)
>>ASSERTION Good A
A successful call to 
String XtResolvePathname(display, type, filename, suffix, 
path, substitutions, num_substitutions, predicate)
shall obtain each colon-separated string from
.A path,
replace in this string each occurrence of a percent character 
followed by a character other than a ':' or '%' with standard 
substitutions and with the substitution field of the structure 
in the list of substitutions specified by
.A substitutions
that has the match field equal to the character following the
percent character, pass each resulting string to the procedure
.A predicate,
until a a string is found for which this procedure returns True, and 
return this string.
>>CODE
char path[1024];
SubstitutionRec sub[2];
Cardinal num_substitutions;
String str;
Display *display;
pid_t pid2;

	avs_set_event(1, 0);
	FORK(pid2);
	avs_xt_hier("Trspathnm1", "XtResolvePathname");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	memset(path, 0 , sizeof(path));
	strcpy(path, pathname1);
	strcat(path, "%d%s:");
	strcat(path, pathname1);
	strcat(path, "%s%d");
	tet_infoline("TEST: Call XtResolvePathname");
	display = XtDisplay(topLevel);
	sub[0].match = 's';
	sub[0].substitution = "data1";
	sub[1].match = 'd';
	sub[1].substitution = "128";
	str = XtResolvePathname(display, NULL, NULL, NULL, path, &sub[0], 2, FindFile1); 
	if (str == NULL) {
		tet_infoline("ERROR: XtResolvePathname returned NULL");
		tet_result(TET_FAIL);
		exit(0);
	}
	tet_infoline("TEST: Returned string is second path name after substitutions");
	check_str(string_good1_2, str, "String returned");
	LKROF(pid2, AVSXTTIMEOUT-2);
	if (avs_get_event(1) == 0) {
		tet_infoline("ERROR: predicate was never called");
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
>>ASSERTION Good A
When no string in the colon-separated list of strings specified by
.A path
yields a True return from the procedure
.A predicate
a call to
String XtResolvePathname(display, type, filename, suffix, 
path, substitutions, num_substitutions, predicate)
shall return NULL.
>>CODE
char path[1024];
SubstitutionRec sub[2];
Cardinal num_substitutions;
String str;
Display *display;
pid_t pid2;

	avs_set_event(1, 0);
	FORK(pid2);
	avs_xt_hier("Trspathnm2", "XtResolvePathname");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	memset(path, 0 , sizeof(path));
	strcpy(path, pathname1);
	strcat(path, "%d%s:");
	strcat(path, pathname1);
	strcat(path, "%s%d");
	tet_infoline("TEST: Call XtResolvePathname with predicate that will always fail");
	display = XtDisplay(topLevel);
	sub[0].match = 's';
	sub[0].substitution = "data1";
	sub[1].match = 'd';
	sub[1].substitution = "128";
	str = XtResolvePathname(display, NULL, NULL, NULL, path, &sub[0], 2, FindFileFail); 
	tet_infoline("TEST: Returns NULL");
	if (str != NULL) {
		sprintf(ebuf, "ERROR: XtResolvePathname returned \"%s\", expected NULL", str);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
		exit(0);
	}
	LKROF(pid2, AVSXTTIMEOUT-2);
	if (avs_get_event(1) == 0) {
		tet_infoline("ERROR: predicate was never called");
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
>>ASSERTION Good A
A call to 
String XtResolvePathname(display, type, filename, suffix, 
path, substitutions, num_substitutions, predicate)
shall replace each "%:" sequences in 
.A path 
by a single colon before passing it to the procedure
.A predicate.
>>CODE
char path[1024];
SubstitutionRec sub[1];
Cardinal num_substitutions;
String str;
Display *display;
pid_t pid2;

	avs_set_event(1, 0);
	FORK(pid2);
	avs_xt_hier("Trspathnm3", "XtResolvePathname");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	strcpy(path, pathname3a);
	tet_infoline("TEST: Call XtResolvePathname with path containing %:");
	display = XtDisplay(topLevel);
	str = XtResolvePathname(display, NULL, NULL, NULL,
			path, NULL, 0, FindFile3a); 
	if (str == NULL) {
		tet_infoline("ERROR: XtResolvePathname returned NULL");
		tet_result(TET_FAIL);
		exit(0);
	}
	tet_infoline("TEST: Returned string");
	check_str(string_good3a, str, "String returned");
	LKROF(pid2, AVSXTTIMEOUT-2);
	if (avs_get_event(1) == 0) {
		tet_infoline("ERROR: predicate was never called");
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
>>ASSERTION Good A
A call to 
String XtResolvePathname(display, type, filename, suffix, 
path, substitutions, num_substitutions, predicate)
shall replace each "%%" sequences in 
.A path 
by a single percent character before passing it to the procedure
.A predicate.
>>CODE
char path[1024];
SubstitutionRec sub[1];
Cardinal num_substitutions;
String str;
Display *display;
pid_t pid2;

	avs_set_event(1, 0);
	FORK(pid2);
	avs_xt_hier("Trspathnm4", "XtResolvePathname");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	strcpy(path, pathname4a);
	tet_infoline("TEST: Call XtResolvePathname with path containing %%");
	display = XtDisplay(topLevel);
	str = XtResolvePathname(display, NULL, NULL, NULL,
			path, NULL, 0, FindFile4a); 
	if (str == NULL) {
		tet_infoline("ERROR: XtResolvePathname returned NULL");
		tet_result(TET_FAIL);
		exit(0);
	}
	tet_infoline("TEST: Returned string");
	check_str(string_good4a, str, "String returned");
	LKROF(pid2, AVSXTTIMEOUT-2);
	if (avs_get_event(1) == 0) {
		tet_infoline("ERROR: predicate was never called");
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
>>ASSERTION Good D 3
If the operating system does not interpret multiple 
embedded name separators in a path in the same way as a single seperator:
A call to
String XtResolvePathname(display, type, filename, suffix, 
path, substitutions, num_substitutions, predicate)
shall replace multiple embedded name seperators in each string specified by
.A path
with a single seperator character after all other substitutions are made and
before passing it to the procedure
.A predicate.
>>ASSERTION Good A
When 
.A predicate 
is NULL and no file that is readable, not a directory and matches 
any of the specified file names in
.A path
is found a call to
String XtResolvePathname(display, type, filename, suffix, 
path, substitutions, num_substitutions, predicate)
shall return NULL.
>>CODE
char path[1024];
char filename[1024];
SubstitutionRec sub[1];
Cardinal num_substitutions;
String str;
Display *display;
pid_t pid2;

	avs_set_event(1, 0);
	FORK(pid2);
	avs_xt_hier("Trspathnm2", "XtResolvePathname");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	if (getcwd(path, sizeof(path)-3) == NULL) {
		tet_infoline("ERROR: getcwd() returned NULL");
		tet_result(TET_UNRESOLVED);
		exit(0);
	}
	strcat(path, "/%s");
	tet_infoline("TEST: Call XtResolvePathname for non-existent file");
	sub[0].match = 's';
	sub[0].substitution = "data5";
	display = XtDisplay(topLevel);
	strcpy(filename, "TEST_N");
	str = XtResolvePathname(display, NULL, NULL, NULL, path, &sub[0], 1,  NULL); 
	avs_set_event(1, 1);
	tet_infoline("TEST: Return value");
	if (str != NULL) {
		sprintf(ebuf, "ERROR: XtResolvePathname returned \"%s\", expected NULL", str);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
		exit(0);
	}
	LKROF(pid2, AVSXTTIMEOUT-2);
	if (avs_get_event(1) == 0) {
		tet_infoline("ERROR: XtResolvePathname terminated process");
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
>>ASSERTION Good A
When 
.A filename 
is non-NULL and path contains the character 
sequence %N a call to
String XtResolvePathname(display, type, filename, suffix, path, substitutions, num_substitutions, predicate)
shall replace it with 
.A filename.
>>CODE
char path[1024];
char filename[1024];
SubstitutionRec sub[1];
Cardinal num_substitutions;
String str;
Display *display;
pid_t pid2;

	avs_set_event(1, 0);
	FORK(pid2);
	avs_xt_hier("Trspathnm2", "XtResolvePathname");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	strcpy(path, pathname2);
	tet_infoline("TEST: Call XtResolvePathname with path containing %N");
	display = XtDisplay(topLevel);
	strcpy(filename, "TEST_N");
	str = XtResolvePathname(display, NULL, filename, NULL,
			path, NULL, 0, FindFile2); 
	if (str == NULL) {
		tet_infoline("ERROR: XtResolvePathname returned NULL");
		tet_result(TET_FAIL);
		exit(0);
	}
	tet_infoline("TEST: Returned string");
	check_str(string_good2, str, "String returned");
	LKROF(pid2, AVSXTTIMEOUT-2);
	if (avs_get_event(1) == 0) {
		tet_infoline("ERROR: predicate was never called");
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
>>ASSERTION Good A
When 
.A filename
is NULL and path contains the character 
sequence %N a call to
String XtResolvePathname(display, type, filename, suffix, path, substitutions, num_substitutions, predicate)
shall replace it with the class name of the calling process.
>>CODE
char path[1024];
SubstitutionRec sub[1];
Cardinal num_substitutions;
String type = NULL, filename = NULL, suffix = NULL;
String str;
Display *display;
pid_t pid2;

	avs_set_event(1, 0);
	FORK(pid2);
	avs_xt_hier("Trspathnm3", "XtResolvePathname");
	strcpy(path, pathname3);
	tet_infoline("TEST: Call XtResolvePathname with path containing %N and no filename");
	display = XtDisplay(topLevel);
	str = XtResolvePathname(display, NULL, NULL, NULL,
			path, NULL, 0, FindFile3); 
	if (str == NULL) {
		tet_infoline("ERROR: XtResolvePathname returned NULL");
		tet_result(TET_FAIL);
		exit(0);
	}
	tet_infoline("TEST: Returned string");
	check_str(string_good3, str, "String returned");
	LKROF(pid2, AVSXTTIMEOUT-2);
	if (avs_get_event(1) == 0) {
		tet_infoline("ERROR: predicate was never called");
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
>>ASSERTION Good A
When 
.A type
is non-NULL and path contains the character sequence %T 
a call to
String XtResolvePathname(display, type, filename, suffix, path, substitutions, num_substitutions, predicate)
shall replace it with 
.A type.
>>CODE
char path[1024];
char type[1024];
SubstitutionRec sub[1];
Cardinal num_substitutions;
String str;
Display *display;
pid_t pid2;

	avs_set_event(1, 0);
	FORK(pid2);
	avs_xt_hier("Trspathnm4", "XtResolvePathname");
	strcpy(path, pathname4);
	tet_infoline("TEST: Call XtResolvePathname with path containing %T");
	display = XtDisplay(topLevel);
	strcpy(type, "TEST_T");
	str = XtResolvePathname(display, type, NULL, NULL,
			path, NULL, 0, FindFile4); 
	if (str == NULL) {
		tet_infoline("ERROR: XtResolvePathname returned NULL");
		tet_result(TET_FAIL);
		exit(0);
	}
	tet_infoline("TEST: Returned string");
	check_str(string_good4, str, "String returned");
	LKROF(pid2, AVSXTTIMEOUT-2);
	if (avs_get_event(1) == 0) {
		tet_infoline("ERROR: predicate was never called");
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
>>ASSERTION Good A
When 
.A suffix
is non-NULL and path contains the character sequence %S 
a call to
String XtResolvePathname(display, type, filename, suffix, path, substitutions, num_substitutions, predicate)
shall replace it with 
.A suffix.
>>CODE
char path[1024];
char suffix[1024];
SubstitutionRec sub[1];
Cardinal num_substitutions;
String str;
Display *display;
pid_t pid2;

	avs_set_event(1, 0);
	FORK(pid2);
	avs_xt_hier("Trspathnm5", "XtResolvePathname");
	strcpy(path, pathname5);
	tet_infoline("TEST: Call XtResolvePathname with path containing %S");
	display = XtDisplay(topLevel);
	strcpy(suffix, "TEST_S");
	str = XtResolvePathname(display, NULL, NULL, suffix,
			path, NULL, 0, FindFile5); 
	if (str == NULL) {
		tet_infoline("ERROR: XtResolvePathname returned NULL");
		tet_result(TET_FAIL);
		exit(0);
	}
	tet_infoline("TEST: Returned string");
	check_str(string_good5, str, "String returned");
	LKROF(pid2, AVSXTTIMEOUT-2);
	if (avs_get_event(1) == 0) {
		tet_infoline("ERROR: predicate was never called");
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
>>ASSERTION Good A
When 
.A path
contains the character sequence %L a call to
String XtResolvePathname(display, type, filename, suffix, path, substitutions, num_substitutions, predicate)
shall replace it with the language string associated with the
display
.A display.
>>CODE
char path[1024];
char suffix[1024];
SubstitutionRec sub[1];
Cardinal num_substitutions;
String str;
Display *display;
pid_t pid2;

	avs_set_event(1, 0);
	FORK(pid2);
	tet_infoline("PREP: Initialize toolkit, Open display and Create topLevel root widget");
	vsw_init_lang();
	strcpy(path, pathname7);
	tet_infoline("TEST: Call XtResolvePathname with path containing %L");
	display = XtDisplay(topLevel);
	str = XtResolvePathname(display, NULL, NULL, NULL,
			path, NULL, 0, FindFile7); 
	if (str == NULL) {
		tet_infoline("ERROR: XtResolvePathname returned NULL");
		tet_result(TET_FAIL);
		exit(0);
	}
	tet_infoline("TEST: Returned string");
	check_str(string_good7, str, "String returned");
	LKROF(pid2, AVSXTTIMEOUT-2);
	if (avs_get_event(1) == 0) {
		tet_infoline("ERROR: predicate was never called");
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
>>ASSERTION Good B 1
When 
.A path
contains the character sequence %l a call to
String XtResolvePathname(display, type, filename, suffix, path, substitutions, num_substitutions, predicate)
shall replace it with the language part of the language string 
associated with the display
.A display.
>>ASSERTION Good B 1
When 
.A path
contains the character sequence %t a call to
String XtResolvePathname(display, type, filename, suffix, path, 
substitutions, num_substitutions, predicate)
shall replace it with the territory part of the language string 
associated with the display
.A display.
>>ASSERTION Good B 1
When 
.A path
contains the character sequence %c a call to
String XtResolvePathname(display, type, filename, suffix, path, 
substitutions, num_substitutions, predicate)
shall replace it with the codeset part of the language string 
associated with the display
.A display.
>>ASSERTION Good C
If the implementation is X11R5 or later:
When 
.A path 
contains the character sequence %C a call to
String XtResolvePathname(display, type, filename, suffix, path, 
substitutions, num_substitutions, predicate)
shall replace it with the customization string retrieved from the
resource database associated with the display
.A display.
>>CODE
#if XT_X_RELEASE > 4
char filename[128];
char suffix[128];
char type[128];
String str;
Display *display;
pid_t pid2;

	avs_set_event(1, 0);
	FORK(pid2);
	tet_infoline("PREP: Initialize toolkit, Open display and Create topLevel root widget");
	vsw_init_lang();
	tet_infoline("TEST: Call XtResolvePathname with path containing %C");
	display = XtDisplay(topLevel);
	str = XtResolvePathname(display, NULL, NULL, NULL,
			pathname11, NULL, 0, FindFile11); 
	if (str == NULL) {
		tet_infoline("ERROR: XtResolvePathname returned NULL");
		tet_result(TET_FAIL);
		exit(0);
	}
	tet_infoline("TEST: Returned string");
	check_str(string_good11, str, "String returned");
	LKROF(pid2, AVSXTTIMEOUT-2);
	if (avs_get_event(1) == 0) {
		tet_infoline("ERROR: predicate was never called");
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
#else

	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
>>ASSERTION Good A
On a call to
String XtResolvePathname(display, type, filename, suffix, path, 
substitutions, num_substitutions, predicate)
when the path begins with a colon it shall be preceded by %N%S.
>>CODE
char path[1024];
char suffix[1024];
char filename[1024];
SubstitutionRec sub[1];
Cardinal num_substitutions;
String str;
Display *display;
pid_t pid2;

	avs_set_event(1, 0);
	FORK(pid2);
	avs_xt_hier("Trspathnm5", "XtResolvePathname");
	strcpy(path, pathname5a);
	tet_infoline("TEST: Call XtResolvePathname with path beginning with :");
	display = XtDisplay(topLevel);
	strcpy(suffix, "TEST_S");
	strcpy(filename, "TEST_F");
	str = XtResolvePathname(display, NULL, filename, suffix,
			path, NULL, 0, FindFile5a); 
	if (str == NULL) {
		tet_infoline("ERROR: XtResolvePathname returned NULL");
		tet_result(TET_FAIL);
		exit(0);
	}
	tet_infoline("TEST: Returned string");
	check_str(string_good5a_2, str, "String returned");
	LKROF(pid2, AVSXTTIMEOUT-2);
	if (avs_get_event(1) == 0) {
		tet_infoline("ERROR: predicate was never called");
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
>>ASSERTION Good A
On a call to
String XtResolvePathname(display, type, filename, suffix, path, 
substitutions, num_substitutions, predicate)
when the path includes two adjacent colons  a %N%S shall be 
inserted between them.
>>CODE
char path[1024];
char suffix[1024];
char filename[1024];
SubstitutionRec sub[1];
Cardinal num_substitutions;
String str;
Display *display;
pid_t pid2;

	avs_set_event(1, 0);
	FORK(pid2);
	avs_xt_hier("Trspathnm6", "XtResolvePathname");
	strcpy(path, pathname6a);
	tet_infoline("TEST: Call XtResolvePathname with path with two adjacent :'s");
	display = XtDisplay(topLevel);
	strcpy(suffix, "TEST_S");
	strcpy(filename, "TEST_F");
	str = XtResolvePathname(display, NULL, filename, suffix,
			path, NULL, 0, FindFile6a); 
	if (str == NULL) {
		tet_infoline("ERROR: XtResolvePathname returned NULL");
		tet_result(TET_FAIL);
		exit(0);
	}
	tet_infoline("TEST: Returned string");
	check_str(string_good6a_3, str, "String returned");
	LKROF(pid2, AVSXTTIMEOUT-2);
	if (avs_get_event(1) == 0) {
		tet_infoline("ERROR: predicate was never called");
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
>>ASSERTION Good A
When 
.A path
is NULL and the environment variable XFILESEARCHPATH 
is defined a call to 
String XtResolvePathname(display, type, filename, suffix, path, 
substitutions, num_substitutions, predicate)
shall use the value defined by this variable as the search path.
>>CODE
char path[1024];
char filename[1024];
SubstitutionRec sub[1];
Cardinal num_substitutions;
String str;
Display *display;
pid_t pid2;

	avs_set_event(1, 0);
	FORK(pid2);
	putenv("XFILESEARCHPATH=/test/path/%N");
	avs_xt_hier("Trspathnm6", "XtResolvePathname");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Set up env variable XFILESEARCHPATH=/test/path/%N");
	putenv("XFILESEARCHPATH=/test/path/%N");
	tet_infoline("TEST: Call XtResolvePathname with NULL path");
	display = XtDisplay(topLevel);
	strcpy(filename, "TEST_ENV");
	str = XtResolvePathname(display, NULL, filename, NULL,
			NULL, NULL, 0, FindFile6); 
	if (str == NULL) {
		tet_infoline("ERROR: XtResolvePathname returned NULL");
		tet_result(TET_FAIL);
		exit(0);
	}
	tet_infoline("TEST: Returned string");
	check_str(string_good6, str, "String returned");
	LKROF(pid2, AVSXTTIMEOUT-2);
	if (avs_get_event(1) == 0) {
		tet_infoline("ERROR: predicate was never called");
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
>>ASSERTION Good A
When 
.A path
is NULL and the environment variable XFILESEARCHPATH 
is not defined a call to 
String XtResolvePathname(display, type, filename, suffix, path, 
substitutions, num_substitutions, predicate)
shall use a default path that contains at least the entries
containing the following substitutions, in the order specified:

- %C, %N, %S, %T, %L or %C, %N, %S, %T, %l, %t, %c

- %C, %N, %S, %T, %l

- %C, %N, %S, %T

- %N, %S, %T, %L

- %N, %S, %T, %l

- %N, %S, %T
>>CODE
char filename[128];
char suffix[128];
char type[128];
String str;
Display *display;
pid_t pid2;

	avs_set_event(1, 0);
	FORK(pid2);
	tet_infoline("PREP: Initialize toolkit, Open display and Create topLevel root widget");
	vsw_init_lang();
	strcpy(filename, "FILE");
	strcpy(suffix, "SUFFIX");
	strcpy(type, "TYPE");
	tet_infoline("TEST: Call XtResolvePathname with NULL path");
	display = XtDisplay(topLevel);
	str = XtResolvePathname(display, type, filename, suffix,
			NULL, NULL, 0, FindFile10); 
	LKROF(pid2, AVSXTTIMEOUT-2);
	if (avs_get_event(1) < 6) {
		sprintf(ebuf, "ERROR: Expected predicate to be called at least 6 times, was called %d times", avs_get_event(1));
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
>>ASSERTION Good A
When 
.A predicate 
is NULL a call to
String XtResolvePathname(display, type, filename, suffix, 
path, substitutions, num_substitutions, predicate)
shall return a filename specified in 
.A path
that matches a file which is readable and not a directory.
>>CODE
char path[1024];
SubstitutionRec sub[1];
Cardinal num_substitutions;
String str;
Display *display;
char string_good[1024];
pid_t pid2;

	avs_set_event(1, 0);
	FORK(pid2);
	avs_xt_hier("Trspathnm7", "XtResolvePathname");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	if (getcwd(path, sizeof(path)-3) == NULL) {
		tet_infoline("ERROR: getcwd() returned NULL");
		tet_result(TET_UNRESOLVED);
		exit(0);
	}
	strcat(path, "/%s");
	tet_infoline("TEST: Call XtResolvePathname with NULL predicate");
	display = XtDisplay(topLevel);
	sub[0].match = 's';
	sub[0].substitution = "data1";
	str = XtResolvePathname(display, NULL, NULL, NULL,
			path, &sub[0], 1, NULL); 
	if (str == NULL) {
		tet_infoline("ERROR: XtResolvePathname returned NULL");
		tet_result(TET_FAIL);
		exit(0);
	}
	if (getcwd(string_good, sizeof(string_good)-6) == NULL) {
		tet_infoline("ERROR: getcwd() returned NULL");
		tet_result(TET_UNRESOLVED);
		exit(0);
	}
	strcat(string_good, "/data1");
	tet_infoline("TEST: Returned string");
	check_str(string_good, str, "String");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
