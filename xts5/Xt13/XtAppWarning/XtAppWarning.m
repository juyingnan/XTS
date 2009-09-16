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
>># File: tset/Xt13/XtAppWarning/XtAppWarning.m
>># 
>># Description:
>>#	Tests for XtAppWarning()
>># 
>># Modifications:
>># $Log: tapwrning.m,v $
>># Revision 1.1  2005-02-12 14:37:57  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:38:21  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:23  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:29:23  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:25:56  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:22:10  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:18:22  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;

char msg[1024];

/*
** XtWMH_Proc()
*/
static void XtWMH_Proc(str)
String str;
{
	fprintf(stdout, "X Toolkit Warning: %s", str);
	avs_set_event(1, avs_get_event(1)+1);
}

>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtAppWarning Xt13
void
XtAppWarning(app_context, message)
>>ASSERTION Good A
A call to 
void XtAppWarning(app_context, message)
shall invoke the low-level warning handler installed for the
application context
.A app_context
passing
.A message
as an argument to it.
>>CODE
char line[80], buf[80];
FILE *stream;
char *string;
pid_t pid2;
long invoked = 0;

	FORK(pid2);
	avs_xt_hier("Tapwrning1", "XtAppWarning");
	strcpy(msg, "/tmp/");
	strcat(msg, "outfile");
	tet_infoline("PREP: Register XtWMH_Proc to be called on non fatal conditions");
	XtAppSetWarningHandler(app_ctext, XtWMH_Proc);
	tet_infoline("TEST: Call XtAppWarning");
	push_stdout("outfile", "w");
	XtAppWarning(app_ctext, "Hello World");
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
	tet_infoline("TEST: Warning handler was invoked");
	invoked = avs_get_event(1);
	check_dec(1, invoked , "XtWMH_Proc invovocations count");
	tet_infoline("CLEANUP: Unlink the file");
	fclose(stream);
	unlink(msg);
	LKROF(pid2, AVSXTTIMEOUT-2);
	unlink(msg);
	tet_result(TET_PASS);
>>ASSERTION Good B 1
When a user low-level warning handler has not been installed
for the specified application context a call to 
void XtAppWarning(app_context, message)
shall invoke the default low-level warning handler provided by 
the Intrinsics.
>>ASSERTION Good C
If the implementation is POSIX-based:
The default low-level warning handler invoked by a call to
void XtAppWarning(app_context, message)
shall print the message 
.A message
to the standard error of the calling process and return.
>>CODE
char line[80], buf[80];
FILE *stream;
char *string;
pid_t pid2;

if (config.posix_system != 0) {
	FORK(pid2);
	avs_xt_hier("Tapwrning2", "XtAppWarning");
	tet_infoline("PREP: Get the file name to store warning message");
	strcpy(msg, "/tmp/");
	strcat(msg, "outfile");
	tet_infoline("TEST: Call XtAppWarning");
	push_stderr("outfile", "w");
	XtAppWarning(app_ctext, "Hello World");
	avs_set_event(2, avs_get_event(2)+1);
	pop_stderr();
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
	LKROF(pid2, AVSXTTIMEOUT-2);
	if (avs_get_event(2) == 0) {
		tet_infoline("ERROR: XtAppWarning exited rather than returned");
		tet_result(TET_FAIL);
	}
	tet_result(TET_PASS);
	unlink(msg);
} else {
	tet_infoline("INFO: Not configured as a POSIX system");
	tet_result(TET_UNSUPPORTED);
}
