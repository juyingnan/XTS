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
$Header: /cvs/xtest/xtest/xts5/tset/XtC/terror/terror.m,v 1.1 2005-02-12 14:38:24 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/XtC/terror/terror.m
>># 
>># Description:
>>#	Tests for XtError()
>># 
>># Modifications:
>># $Log: terror.m,v $
>># Revision 1.1  2005-02-12 14:38:24  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:38:40  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:45  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:29:42  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:26:16  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:23:08  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:19:54  andy
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
char msg[1024];

/*
** XtEMH_Proc
*/
void XtEMH_Proc(str)
String str;
{
	fprintf(stdout, "X Toolkit Error: %s", str);
	avs_set_event(1, 1);
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtError XtC
void
XtError(message)
>>ASSERTION Good A
A call to 
void XtError(message)
shall invoke the fatal error handler for the 
calling process,
passing
.A message 
as an argument to it.
>>CODE
char line[80], buf[80];
FILE *stream;
char *string;
pid_t pid2;
int	status;

	FORK(pid2);
	avs_xt_hier("Terror1", "XtError");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get the file name to dump error message");
	strcat(msg, "/tmp/outfile");
	tet_infoline("PREP: Register procedure XtEMH_Proc to be invoked");
	XtSetErrorHandler(XtEMH_Proc);
	tet_infoline("TEST: Call XtError");
	push_stdout("outfile", "w");
	XtError("Hello World");
	pop_stdout();
	tet_infoline("TEST: Open the temporary file and read the message");
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
	tet_infoline("TEST: Check the error handler was invoked");
	fclose(stream);
	unlink(msg);
	LKROF(pid2, AVSXTTIMEOUT-2);
	status = avs_get_event(1);
        check_dec(1, status, "handler invocation count");
	tet_result(TET_PASS);
	unlink(msg);
>>ASSERTION Good B 1
When no user defined error handler 
has been registered for the calling process a call to 
void XtError(message)
shall invoke the default error 
handler provided by the Intrinsics.
>>ASSERTION Good C
If the implementation is POSIX-based:
The default error handler invoked by a call to
void XtError(message)
shall print the message 
.A message
to the standard error of the calling 
process and terminate it.
>>CODE
char line[80], buf[80];
FILE *stream;
char *string;
pid_t pid2;

if (config.posix_system != 0) {
	FORK(pid2);
	avs_xt_hier("Terror2", "XtError");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get the file name to dump error message");
	strcpy(msg, "/tmp/outfile");
	FORK(pid2);
	tet_infoline("TEST: Call XtError");
	push_stderr("outfile", "w");
	XtError("Hello World");
	pop_stderr();
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Open the temporary file and read the message");
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
	if (string == NULL) {
		sprintf(ebuf, "ERROR: Expected \"Hello World\" Received \"%s\"", buf);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	fclose(stream);
	unlink(msg);
	LKROF(pid2, AVSXTTIMEOUT-2);
	unlink(msg);
	tet_result(TET_PASS);
}else {
        tet_infoline("INFO: Not configured as a POSIX system");
        tet_result(TET_UNSUPPORTED);
}
