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
$Header: /cvs/xtest/xtest/xts5/tset/XtC/twarngmsg/twarngmsg.m,v 1.1 2005-02-12 14:38:25 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/XtC/twarngmsg/twarngmsg.m
>># 
>># Description:
>>#	Tests for XtWarningMsg()
>># 
>># Modifications:
>># $Log: twarngmsg.m,v $
>># Revision 1.1  2005-02-12 14:38:25  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:38:39  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:44  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:29:41  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:26:15  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:23:05  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:19:51  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;

int flag = 0;
char msg[1024] ="/tmp/outfile";
char file_name[128] ="/tmp/dbfile";

/*
** Installed warning handler
*/
void XtWMH_Proc(name_good, type_good,
		class_good, defaultp, params, num_params)
String name_good;
String type_good;
String class_good;
String defaultp;
String *params;
Cardinal *num_params;
{
	avs_set_event(1, avs_get_event(1)+1);
	fprintf(stdout, "%s %s %s %s",
	name_good, type_good, class_good, defaultp);
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtWarningMsg XtC
void
XtWarningMsg(name, type, class, default, params, num_params)
>>ASSERTION Good A
A call to 
void XtWarningMsg(name, type, class, default, params, num_params)
shall invoke the warning handler for 
the calling process,
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
int invoked = 0;

	FORK(pid2);
	avs_xt_hier("Twarngmsg1", "XtWarningMsg");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Register XtWMH_Proc to be called on non fatal conditions");
	XtSetWarningMsgHandler(XtWMH_Proc);
	tet_infoline("TEST: Call XtWarningMsg");
	push_stdout("outfile", "w");
	XtWarningMsg("This", "is a", "test", "Hello World",
			(String *)NULL, (Cardinal)0);
	pop_stdout();
	tet_infoline("PREP: Open the temporary file and read the message");
	stream = (FILE *)fopen(msg, "r");
	if (stream == NULL) {
		tet_infoline("ERROR: Message not written");
		tet_result(TET_FAIL);
		unlink(msg);
		exit(0);
	}
	if (fgets(line, 80, stream) == NULL) {
		tet_infoline("ERROR: Message not written");
		tet_result(TET_FAIL);
		unlink(msg);
		exit(0);
	}
	tet_infoline("TEST: Message is correct");
	string = (char *)strstr(line, "Hello World");
	strncpy(buf, string, strlen("Hello World"));
	if (strncmp("Hello World", buf, strlen("Hello World")) != 0 ) {
		sprintf(ebuf, "ERROR: Expected \"Hello World\" Received \"%s\"", buf);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Error handler was invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtWMH_Proc invocations count");
	tet_infoline("CLEANUP: Unlink the file");
	fclose(stream);
	unlink(msg);
	LKROF(pid2, AVSXTTIMEOUT-2);
	unlink(msg);
	tet_result(TET_PASS);
>>ASSERTION Good A
When a user-defined warning handler has 
not been installed in the calling process
a call to 
void XtWarningMsg(name, type, class, default, params, num_params)
shall invoke the default warning handler provided 
by the Intrinsics.
>>CODE
char line[80], buf[80];
FILE *stream;
char *string;
pid_t pid2;
String  params = "aptest";
Cardinal	n_params;
XrmDatabase *database, file_database, db_return;
char *contents = "testString.error:Testing XtWarningMsg %s\n";
char *ErrorString = "Testing XtWarningMsg aptest";

	FORK(pid2);
	avs_xt_hier_no_warn("Twarngmsg2", "XtWarningMsg");
	tet_infoline("PREP: Create error database");
	XrmInitialize();
	db_return = XrmGetStringDatabase(contents);
	(void)XrmPutFileDatabase(db_return,file_name);
	file_database = XrmGetFileDatabase(file_name);
	database = XtGetErrorDatabase();
	if (database == (XrmDatabase *)NULL) {
		tet_infoline("ERROR: XtGetErrorDatabase returned NULL");
		tet_result(TET_FAIL);
		unlink(file_name);
		exit(0);
	}
	tet_infoline("PREP: Merge original database with new database");
	XrmMergeDatabases(file_database, database);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Call XtWarningMsg");
	n_params = 1;
	push_stderr("outfile", "w");
	XtWarningMsg("testString", "error", "AppWarning", "This is the default passed in", &params, &n_params);
	pop_stderr();
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("PREP: Open the temporary file and read the message");
	stream = (FILE *)fopen(msg, "r");
	if (stream == NULL) {
		tet_infoline("ERROR: Message not written");
		tet_result(TET_FAIL);
		unlink(msg);
		exit(0);
	}
	if (fgets(line, 80, stream) == NULL) {
		tet_infoline("ERROR: Message not written");
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
When a user-defined warning handler has not been 
installed in the calling process and no entry for 
the specified error exists in the error database
the Intrinsics-defined default warning handler invoked 
by a call to 
void XtWarningMsg(name, type, class, default, params, num_params)
shall display the message specified by
.A default.
>>CODE
char line[80], buf[80];
FILE *stream;
char *string;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier_no_warn("Tapwrnmsg2", "XtWarningMsg");
	tet_infoline("TEST: Call XtWarningMsg for non-existent message");
	push_stderr("outfile", "w");
	XtWarningMsg("This", "is a", "test", "Hello World", NULL, 0);
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
		sprintf(ebuf, "ERROR: Expected message to contain \"Hello World\", received \"%s\"", buf);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("CLEANUP: Unlink the file");
	fclose(stream);
	unlink(msg);
	tet_result(TET_PASS);
	unlink(msg);
