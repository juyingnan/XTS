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
>># File: xts/XtC/XtSetErrorMsgHandler.m
>># 
>># Description:
>>#	Tests for XtSetErrorMsgHandler()
>># 
>># Modifications:
>># $Log: tsterrmhd.m,v $
>># Revision 1.1  2005-02-12 14:38:25  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:38:37  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:41  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:29:39  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:26:12  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:22:59  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:19:42  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;

/*
** Installed error handler
*/
void XtEMH_Proc(name_good, type_good, class_good,
			defaultp, params, num_params)
String name_good;
String type_good;
String class_good;
String defaultp;
String *params;
Cardinal *num_params;
{
	avs_set_event(1, avs_get_event(1)+1);
	fprintf(stdout, "%s %s %s %s", name_good, type_good, class_good, defaultp);
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtSetErrorMsgHandler XtC
void
XtSetErrorMsgHandler(msg_handler)
>>ASSERTION Good A
A call to 
void XtSetErrorMsgHandler(msg_handler)
shall register 
.A msg_handler 
as the fatal error handler for the calling process.
>>CODE
char msg[1024];
char line[80], buf[80];
FILE *stream;
char *string;
pid_t pid2;
int invoked = 0;
pid_t pid3;
int pstatus;

	FORK(pid3);
	avs_xt_hier_def("Tsterrmhd1", "XtSetErrorMsgHandler");
	FORK(pid2);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get the file name to store warning message");
	strcpy(msg, "/tmp/");
	strcat(msg, "outfile");
	tet_infoline("TEST: Register procedure XtEMH_Proc to be invoked");
	XtSetErrorMsgHandler(XtEMH_Proc);
	sprintf(ebuf, "PREP: Store the error message to %s file", msg);
	tet_infoline(ebuf);
	 push_stdout("outfile", "w");
	 XtErrorMsg("This", "is a", "test", "Hello World", NULL, 0);
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
	strcpy(buf, string);
	check_str("Hello World", buf, "String");
	tet_infoline("TEST: Error handler was invoked");
	invoked = avs_get_event(1);
	if (invoked == 0) {
		sprintf(ebuf, "ERROR: Error Handler XtEMH_Proc was not invoke");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("CLEANUP: Unlink the file");
	fclose(stream);
	unlink(msg);
	LKROF(pid2, AVSXTTIMEOUT-4);
	KROF3(pid3, pstatus, AVSXTTIMEOUT-2);
        if (pstatus != 0) {
		tet_infoline("ERROR: Test process exited abnormally");
		tet_infoline("       May mean display cannot be opened");
		tet_result(TET_UNRESOLVED);
        }
	else {
		unlink(msg);
		tet_result(TET_PASS);
	}
