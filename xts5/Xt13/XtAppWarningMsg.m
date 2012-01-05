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
>># File: xts/Xt13/XtAppWarningMsg.m
>># 
>># Description:
>>#	Tests for XtAppWarningMsg()
>># 
>># Modifications:
>># $Log: tapwrnmsg.m,v $
>># Revision 1.1  2005-02-12 14:37:57  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:38:21  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:24  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:29:23  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:25:57  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:22:11  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:18:24  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;

char msg[1024] ="/tmp/outfile";
char file_name[128] ="/tmp/dbfile";
/*
** XtWMH_Proc()
*/
void XtWMH_Proc(name_good, type_good, class_good, defaultp, params, num_params)
String name_good;
String type_good;
String class_good;
String defaultp;
String *params;
Cardinal *num_params;
{
	fprintf(stdout, "%s %s %s %s", name_good, type_good, class_good, defaultp);
	avs_set_event(1, avs_get_event(1)+1);
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtAppWarningMsg Xt13
void
XtAppWarningMsg(app_context, name, type, class, default, params, num_params)
>>ASSERTION Good A
A call to 
void XtAppWarningMsg(app_context, name, type, class, default, 
params, num_params)
shall invoke the high-level warning handler for the application context 
.A app_context
passing
.A name,
.A type,
.A class,
.A default,
.A params,
and
.A num_params
as arguments to it.
>>CODE
char line[80], buf[80];
FILE *stream;
char *string;
pid_t pid2;
long invoked = 0;

	FORK(pid2);
	avs_xt_hier("Tapwrnmsg1", "XtAppWarningMsg");
	tet_infoline("PREP: Get the file name to store warning message");
	tet_infoline("PREP: Register XtWMH_Proc to be called on non fatal conditions");
	XtAppSetWarningMsgHandler(app_ctext, XtWMH_Proc);
	tet_infoline("TEST: Call XtAppWarningMsg");
 	push_stdout("outfile", "w");
	XtAppWarningMsg(app_ctext, "This", "is a", "test",
		"Hello World", NULL, (Cardinal *)0);
	pop_stdout();
	tet_infoline("TEST: Open the temporary file and read the message");
	stream = (FILE *)fopen(msg, "r");
	if (stream == NULL) {
		tet_infoline("ERROR: Message not generated");
		tet_result(TET_FAIL);
		exit(0);
	}
	if (fgets(line, 80, stream) == NULL) {
		tet_infoline("ERROR: Message not generated");
		tet_result(TET_FAIL);
		exit(0);
	}
	tet_infoline("TEST: Message is correct");
	string = (char *)strstr(line, "Hello World");
	if (string == NULL) {
		sprintf(ebuf, "ERROR: Expected message to contain \"Hello World\" Received \"%s\"", buf);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	fclose(stream);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Installed handler was invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked , "XtWMH_Proc invovocations count");
	tet_infoline("CLEANUP: Unlink the file");
	unlink(msg);
	tet_result(TET_PASS);
>>ASSERTION Good A
When a user-defined high-level warning handler has not been installed in
the application context
.A app_context
a call to 
void XtAppWarningMsg(app_context, name, type, class, default, 
params, num_params)
shall invoke the default warning handler provided by the Intrinsics.
>>CODE
char line[80], buf[80];
FILE *stream;
char *string;
pid_t pid2;
String	params = "aptest";
Cardinal	n_params;
XrmDatabase *database, file_database, db_return;
char *contents = "testString.error:Testing XtWarningMsg %s\n";
char *ErrorString = "Testing XtWarningMsg aptest";

	FORK(pid2);
	avs_xt_hier_no_warn("Tapwrnmsg2", "XtAppWarningMsg");
	tet_infoline("PREP: Create error database");
	XrmInitialize();
	db_return = XrmGetStringDatabase(contents);
	(void)XrmPutFileDatabase(db_return,file_name);
	file_database = XrmGetFileDatabase(file_name);
	database = XtAppGetErrorDatabase(app_ctext);
	if (database == (XrmDatabase *)NULL) {
		tet_infoline("ERROR: XtAppGetErrorDatabase returned NULL");
		tet_result(TET_FAIL);
		unlink(file_name);
		exit(0);
	}
	tet_infoline("PREP: Merge original database with new database");
	XrmMergeDatabases(file_database, database);
	tet_infoline("TEST: Call XtAppWarningMsg");
	n_params = 1;
	push_stderr("outfile", "w");
	XtAppWarningMsg(app_ctext, "testString", "error", "AppWarning", "This is the default passed in", &params, &n_params);
	pop_stderr();
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Open the temporary file and read the message");
	stream = (FILE *)fopen(msg, "r");
	if (stream == NULL) {
		tet_infoline("ERROR: Message not generated");
		tet_result(TET_FAIL);
		unlink(msg);
		exit(0);
	}
	if (fgets(line, 80, stream) == NULL) {
		tet_infoline("ERROR: Message not generated");
		tet_result(TET_FAIL);
		unlink(msg);
		exit(0);
	}
	tet_infoline("TEST: Message is correct");
	string = (char *)strstr(line, ErrorString);
	if (string == NULL) {
		sprintf(ebuf, "ERROR: Expected message to contain \"%s\", received \"%s\"", ErrorString, buf);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("CLEANUP: Unlink the file");
	fclose(stream);
	unlink(msg);
	tet_result(TET_PASS);
>>ASSERTION Good A
When a user-defined warning handler has not been installed in
the application context
.A app_context
and no entry for the specified error exists in the error database
the Intrinsics-defined default warning handler invoked by a call to 
void XtAppWarningMsg(app_context, name, type, class, default, 
params, num_params)
shall display the message specified by
.A default.
>>CODE
char line[80], buf[80];
FILE *stream;
char *string;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier_no_warn("Tapwrnmsg2", "XtAppWarningMsg");
	tet_infoline("TEST: Call XtAppWarningMsg for non-existent message");
	push_stderr("outfile", "w");
	XtAppWarningMsg(app_ctext, "This", "is a", "test", "Hello World", NULL, 0);
	pop_stderr();
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Open the temporary file and read the message");
	stream = (FILE *)fopen(msg, "r");
	if (stream == NULL) {
		tet_infoline("ERROR: Message not generated");
		tet_result(TET_FAIL);
		unlink(msg);
		exit(0);
	}
	if (fgets(line, 80, stream) == NULL) {
		tet_infoline("ERROR: Message not generated");
		tet_result(TET_FAIL);
		unlink(msg);
		exit(0);
	}
	tet_infoline("TEST: Message is correct");
	string = (char *)strstr(line, "Hello World");
	if (string == NULL) {
		sprintf(ebuf, "ERROR: Expected message to contain \"Hello World\" Received \"%s\"", buf);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("CLEANUP: Unlink the file");
	fclose(stream);
	unlink(msg);
	tet_result(TET_PASS);
	unlink(msg);
