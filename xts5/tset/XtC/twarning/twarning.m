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
$Header: /cvs/xtest/xtest/xts5/tset/XtC/twarning/twarning.m,v 1.1 2005-02-12 14:38:25 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/XtC/twarning/twarning.m
>># 
>># Description:
>>#	Tests for XtWarning()
>># 
>># Modifications:
>># $Log: twarning.m,v $
>># Revision 1.1  2005-02-12 14:38:25  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:38:39  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:43  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:29:41  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:26:14  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:23:04  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:19:49  andy
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

/*
** Installed Warning handler
*/
void XtWMH_Proc(str)
String str;
{
	avs_set_event(1, avs_get_event(1)+1);
	tet_infoline("TEST: String passed to handler");
	if (strstr(str, "Hello World") == NULL) {
		sprintf(ebuf, "ERROR: Expected string passed to handler to contain \"Hello World\", is \"%s\"", str);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtWarning XtC
void
XtWarning(msg)
>>ASSERTION Good A
A call to 
void XtWarning(message)
shall invoke the warning handler installed for the
calling process,
passing
.A message
as an argument to it.
>>CODE
char msg[1024];
char line[80], buf[80];
FILE *stream;
char *string;
pid_t pid2;
int invoked;

	FORK(pid2);
	avs_set_event(1, 0);
	avs_xt_hier("Twarning1", "XtWarning");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Register XtWMH_Proc as warning handler");
	XtSetWarningHandler(XtWMH_Proc);
	tet_infoline("TEST: Call XtWarning");
	XtWarning("Hello World");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Warning handler was invoked");
	invoked = avs_get_event(1);
        check_dec(1, invoked , "Warning handler invovocation count");
	tet_result(TET_PASS);
>>ASSERTION Good B 1
When a user warning handler has not been installed
for the calling process a call to 
void XtWarning(message)
shall invoke the default warning handler 
provided by the Intrinsics.
>>ASSERTION Good C
If the implementation is POSIX-based:
The default warning handler invoked by a call to
void XtWarning(message)
shall print the message 
.A message
to the standard error of the calling process and return.
>>CODE
char msg[1024];
char line[80], buf[80];
FILE *stream;
char *string;
pid_t pid2;

if (config.posix_system != 0) {
	FORK(pid2);
	avs_xt_hier("Twarning2", "XtWarning");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get the file name to store warning message");
	strcpy(msg, "/tmp/");
	strcat(msg, "outfile");
	sprintf(ebuf, "TEST: Call XtWarning");
	tet_infoline(ebuf);
	push_stderr("outfile", "w");
	XtWarning("Hello World");
	pop_stderr();
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
	tet_infoline("CLEANUP: Unlink the file");
	fclose(stream);
	unlink(msg);
	LKROF(pid2, AVSXTTIMEOUT-2);
	unlink(msg);
	tet_result(TET_PASS);
} else {
	tet_infoline("INFO: Not configured as a POSIX system");
	tet_result(TET_UNSUPPORTED);
}
