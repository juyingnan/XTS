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
>># File: xts/XtC/XtSetWarningHandler/XtSetWarningHandler.m
>># 
>># Description:
>>#	Tests for XtSetWarningHandler()
>># 
>># Modifications:
>># $Log: tstwhndlr.m,v $
>># Revision 1.1  2005-02-12 14:38:25  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:38:38  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:42  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:29:40  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:26:13  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:23:02  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:19:46  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;

long flag = 0;

/*
** Installed Warning handler
*/
void XtWMH_Proc(str)
String str;
{
	flag = 1;
	fprintf(stdout, "X Toolkit Warning: %s", str);
}

>>TITLE XtSetWarningHandler XtC
void
XtSetWarningHandler(handler)
>>ASSERTION Good A
A successful call to 
void XtSetWarningHandler(handler)
shall register 
.A handler 
as the warning handler for the calling process.
>>CODE
char msg[1024];
char line[80], buf[80];
FILE *stream;
char *string;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tstwhndlr1", "XtSetWarningHandler");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get the file name to store warning message");
	strcpy(msg, "/tmp/");
	strcat(msg, "outfile");
	tet_infoline("PREP: Register XtWMH_Proc to be called on non fatal conditions");
	XtSetWarningHandler(XtWMH_Proc);
	sprintf(ebuf, "PREP: Store the warning message to %s file", msg);
	tet_infoline(ebuf);
	push_stdout("outfile", "w");
	XtWarning("Hello World");
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
	tet_infoline("TEST: Warning handler XtWMH_Proc was invoked");
	if ( !flag ) {
		sprintf(ebuf, "ERROR: XtWMH_Proc was not invoked");
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("CLEANUP: Unlink the file");
	fclose(stream);
	unlink(msg);
	LKROF(pid2, AVSXTTIMEOUT-2);
	unlink(msg);
	tet_result(TET_PASS);
