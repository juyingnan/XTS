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
$Header: /cvs/xtest/xtest/xts5/tset/Xt13/taperror/taperror.m,v 1.1 2005-02-12 14:37:57 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt13/taperror/taperror.m
>># 
>># Description:
>>#	Tests for XtAppError()
>># 
>># Modifications:
>># $Log: taperror.m,v $
>># Revision 1.1  2005-02-12 14:37:57  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:38:22  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:25  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:29:24  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:25:58  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:22:14  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:18:27  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>
char msg[1024];

/*
** XtEMH_Proc
*/
static void XtEMH_Proc(str)
String str;
{
	avs_set_event(1, 1);
	fprintf(stdout, "X Toolkit Error: %s", str);
}

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtAppError Xt13
void
XtAppError(app_context, message)
>>ASSERTION Good A
A call to 
void XtAppError(app_context, message)
shall invoke the low-level error handler for the application
context
.A app_context
passing
.A message 
as an argument to it.
>>CODE
char line[80], buf[80];
FILE *stream;
char *string;
int status;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Taperror1", "XtAppError");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get the file name to store error message");
	strcpy(msg, "/tmp/");
	strcat(msg, "outfile");
	tet_infoline("PREP: Register a low-level error handler");
	XtAppSetErrorHandler(app_ctext, XtEMH_Proc);
	tet_infoline("TEST: Call XtAppError");
	push_stdout("outfile", "w");
	XtAppError(app_ctext, "Hello World");
	pop_stdout();
	tet_infoline("TEST: Error handler was invoked");
	status = avs_get_event(1);
	check_dec(1, status, "XtEMH_Proc invocations count");
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
	strncpy(buf, string, strlen("Hello World"));
	if (strncmp("Hello World", buf, strlen("Hello World")) != 0 ) {
		sprintf(ebuf, "ERROR: Expected message to contain \"Hello World\", Received %s", buf);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("CLEANUP: Unlink the file");
	fclose(stream);
	unlink(msg);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
	unlink(msg);
>>ASSERTION Good B 1
When no user defined low-level error handler has been registered for
the specified application context a call to 
void XtAppError(app_context, message)
shall invoke the default low-level error handler provided by the 
Intrinsics.
>>ASSERTION Good C
If the implementation is POSIX-based:
The default low-level error handler invoked by a call to
void XtAppError(app_context, message)
shall print the message 
.A message
to the standard error of the calling process and terminate it.
>>CODE
char line[80], buf[80];
FILE *stream;
char *string;
pid_t pid2;

if (config.posix_system != 0) {
	avs_xt_hier("Taperror2", "XtAppError");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get the file name to store error message");
	strcpy(msg, "/tmp/");
	strcat(msg, "outfile");
	FORK(pid2);
	tet_infoline("PREP: Redirect stderr to a file");
	push_stderr("outfile", "w");
	tet_infoline("TEST: Call XtAppError");
	XtAppError(app_ctext, "Hello World");
	pop_stderr();
	tet_infoline("ERROR: Application was not terminated");
	tet_result(TET_FAIL);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Open the file and read the message");
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
	strncpy(buf, string, strlen("Hello World"));
	if (strncmp("Hello World", buf, strlen("Hello World")) != 0 ) {
		sprintf(ebuf, "ERROR: Expected message to contain \"Hello World\", Received %s", buf);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("CLEANUP: Unlink the file");
	fclose(stream);
	unlink(msg);
	tet_result(TET_PASS);
}
else {
	tet_infoline("INFO: Not configured as a POSIX system");
	tet_result(TET_UNSUPPORTED);
}
