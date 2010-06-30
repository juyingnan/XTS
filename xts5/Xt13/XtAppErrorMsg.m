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
>># File: xts/Xt13/XtAppErrorMsg.m
>># 
>># Description:
>>#	Tests for XtAppErrorMsg()
>># 
>># Modifications:
>># $Log: taperrmsg.m,v $
>># Revision 1.1  2005-02-12 14:37:57  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:38:20  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:22  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:29:22  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:25:56  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:22:07  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:18:18  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

char msg[128];
char file_name[128];

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;
/*
** XtEMH_Proc
*/
static void XtEMH_Proc(name_good, type_good, class_good,
		defaultp, params, num_params)
String name_good;
String type_good;
String class_good;
String defaultp;
String *params;
Cardinal *num_params;
{
	tet_infoline("TEST: Arguments passed to message handler correctly");
	avs_set_event(1, 1);
	if (name_good == NULL) {
		tet_infoline("ERROR: name parameter is NULL");
		tet_result(TET_FAIL);
	} else {
		if (strcmp(name_good, "This") != 0) {
			sprintf(ebuf, "ERROR: Expected name passed to handler = \"This\", received \"%s\"", name_good);
			tet_infoline(ebuf);
			tet_result(TET_FAIL);
		}
	}
	if (type_good == NULL) {
		tet_infoline("ERROR: type parameter is NULL");
		tet_result(TET_FAIL);
	} else {
		if (strcmp(type_good, "is a") != 0) {
			sprintf(ebuf, "ERROR: Expected type passed to handler = \"is a\", received \"%s\"", type_good);
			tet_infoline(ebuf);
			tet_result(TET_FAIL);
		}
	}
	if (class_good == NULL) {
		tet_infoline("ERROR: class parameter is NULL");
		tet_result(TET_FAIL);
	} else {
		if (strcmp(class_good, "test") != 0) {
			sprintf(ebuf, "ERROR: Expected class passed to handler = \"test\", received \"%s\"", class_good);
			tet_infoline(ebuf);
			tet_result(TET_FAIL);
		}
	}
	if (defaultp == NULL) {
		tet_infoline("ERROR: default parameter is NULL");
		tet_result(TET_FAIL);
	} else {
		if (strcmp(defaultp, "Hello World") != 0) {
			sprintf(ebuf, "ERROR: Expected default passed to handler = \"Hello World\", received \"%s\"", defaultp);
			tet_infoline(ebuf);
			tet_result(TET_FAIL);
		}
	}
	if (params == NULL) {
		tet_infoline("ERROR: params parameter is NULL");
		tet_result(TET_FAIL);
	} else {
		if (*params == NULL) {
			tet_infoline("ERROR: params parameter points to NULL");
			tet_result(TET_FAIL);
		} else {
			if (strcmp(*params, "Params") != 0) {
				sprintf(ebuf, "ERROR: Expected params passed to handler = \"Params\", received \"%s\"", *params);
				tet_infoline(ebuf);
				tet_result(TET_FAIL);
			}
		}
	}
	if (*num_params != 1) {
		sprintf(ebuf, "ERROR: Expected num_params passed to handler = 1, received %d", *num_params);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtAppErrorMsg Xt13
void
void XtAppErrorMsg(app_context, name, type, class, default, params, num_params)
>>ASSERTION Good A
A successful call to 
void XtAppErrorMsg(app_context, name, type, class, default, 
params, num_params)
shall invoke the high-level error handler for 
the application context 
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
int status;
pid_t pid2;
String	params = "Params";
Cardinal	n_params;

	FORK(pid2);
	avs_xt_hier("Taperrmsg1", "XtAppErrorMsg");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Register message handler");
	XtAppSetErrorMsgHandler(app_ctext, XtEMH_Proc);
	sprintf(ebuf, "TEST: Call XtAppErrorMsg");
	tet_infoline(ebuf);
	n_params = 1;
	XtAppErrorMsg(app_ctext, "This", "is a", "test", "Hello World", &params, &n_params);
	tet_infoline("TEST: Message handler was invoked");
	status = avs_get_event(1);
	check_dec(1, status, "invocations count");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When a user-defined error handler has not been installed in
the application context
.A app_context
a call to 
void XtAppErrorMsg(app_context, name, type, class, default, 
params, num_params)
shall invoke the default error handler provided by the Intrinsics.
>>CODE
char label[] = "Xt Function: XtAppErrorMsg";
char line[80], buf[80];
FILE *stream;
char *string;
pid_t pid2;
String	params = "aptest";
Cardinal	n_params;
XrmDatabase *database, file_database, db_return;
char *contents = "testString.error:Testing XtErrorMsg %s\n";
char *ErrorString = "Testing XtErrorMsg aptest";

	tet_infoline("PREP: Initialize toolkit, Open display and Create topLevel root widget");
	topLevel = (Widget) avs_xt_init("Taperrmsg1", NULL, 0);
	app_ctext = XtWidgetToApplicationContext(topLevel);
	tet_infoline("PREP: Set up widget tree of depth eight (8) return panedw widget");
	panedw = (Widget) avs_xt_tree(topLevel);
	tet_infoline("PREP: Create boxw1 widget in panedw widget");
	boxw1 = (Widget) CreateBoxWidget(panedw);
	 
	tet_infoline("PREP: Create rowcolw widget in boxw1 widget");
	rowcolw = (Widget) CreateRowColWidget(boxw1);
	tet_infoline("PREP: Create push button gadget `Quit' in rowcolw widget");
	click_quit = (Widget) CreatePushButtonGadget("Quit", rowcolw);
	tet_infoline("PREP: Add callback procedure DestroyTree to push button gadget `Quit' ");
	XtAddCallback(click_quit,
			 XtNcallback,
			 DestroyTree,
			 (XtPointer)topLevel
			 );
	tet_infoline("PREP: Get the label widget name");
	sprintf(ebuf, "PREP: Create label widget `%s' in boxw1 widget", label);
	tet_infoline(ebuf);
	labelw = (Widget) CreateLabelWidget(label, boxw1);
	tet_infoline("PREP: Register procedure DestroyTree to handle events to rowcolw widget");
	XtAddEventHandler(rowcolw,
		 ButtonReleaseMask,
		 False,
		 (XtEventHandler)DestroyTree,
		 (XtPointer)topLevel
		 );
	tet_infoline("PREP: Create boxw2 widget in panedw widget");
	boxw2 = (Widget) CreateBoxWidget(panedw);
	tet_infoline("PREP: Set the height and width of boxw2 widget");
	ConfigureDimension(topLevel, boxw2);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	strcpy(file_name, "/tmp/");
	strcat(file_name, "dbfile");
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

	tet_infoline("PREP: Get the file name to store the error message");
	strcpy(msg, "/tmp/");
	strcat(msg, "outfile");
	FORK(pid2);
	tet_infoline("TEST: Call XtAppErrorMsg");
	push_stderr("outfile", "w");
	n_params = 1;
	XtAppErrorMsg(app_ctext, "testString", "error", "AppError", "This is the default passed in", &params, &n_params);
	pop_stderr();
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Open the temporary file and read the message");
	stream = (FILE *)fopen(msg, "r");
	if (stream == NULL) {
		tet_infoline("ERROR: Message not generated");
		tet_result(TET_FAIL);
		unlink(msg);
		unlink(file_name);
		exit(0);
	}
	if (fgets(line, 80, stream) == NULL) {
		tet_infoline("ERROR: Message not generated");
		tet_result(TET_FAIL);
		unlink(msg);
		unlink(file_name);
		exit(0);
	}
	tet_infoline("TEST: Message is correct");
	string = (char *)strstr(line, ErrorString);
	if (string == NULL) {
		sprintf(ebuf, "ERROR: Expected message to contain \"%s\", received \"%s\"", ErrorString, buf);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	fclose(stream);
	unlink(msg);
	unlink(file_name);
	tet_result(TET_PASS);
>>ASSERTION Good A
When a user-defined error handler has not been installed in
the application context
.A app_context
and no entry for the specified error exists in the error database
the Intrinsics-defined default error handler invoked by a call to 
void XtAppErrorMsg(app_context, name, type, class, default, 
params, num_params)
shall display the message specified by
.A default.
>>CODE
char label[] = "Xt Function: XtAppErrorMsg";
char line[80], buf[80];
FILE *stream;
char *string;
pid_t pid2;

	tet_infoline("PREP: Initialize toolkit, Open display and Create topLevel root widget");
	topLevel = (Widget) avs_xt_init("Taperrmsg1", NULL, 0);
	app_ctext = XtWidgetToApplicationContext(topLevel);
	tet_infoline("PREP: Set up widget tree of depth eight (8) return panedw widget");
	panedw = (Widget) avs_xt_tree(topLevel);
	tet_infoline("PREP: Create boxw1 widget in panedw widget");
	boxw1 = (Widget) CreateBoxWidget(panedw);
	 
	tet_infoline("PREP: Create rowcolw widget in boxw1 widget");
	rowcolw = (Widget) CreateRowColWidget(boxw1);
	tet_infoline("PREP: Create push button gadget `Quit' in rowcolw widget");
	click_quit = (Widget) CreatePushButtonGadget("Quit", rowcolw);
	tet_infoline("PREP: Add callback procedure DestroyTree to push button gadget `Quit' ");
	XtAddCallback(click_quit,
			 XtNcallback,
			 DestroyTree,
			 (XtPointer)topLevel
			 );
	tet_infoline("PREP: Get the label widget name");
	sprintf(ebuf, "PREP: Create label widget `%s' in boxw1 widget", label);
	tet_infoline(ebuf);
	labelw = (Widget) CreateLabelWidget(label, boxw1);
	tet_infoline("PREP: Register procedure DestroyTree to handle events to rowcolw widget");
	XtAddEventHandler(rowcolw,
		 ButtonReleaseMask,
		 False,
		 (XtEventHandler)DestroyTree,
		 (XtPointer)topLevel
		 );
	tet_infoline("PREP: Create boxw2 widget in panedw widget");
	boxw2 = (Widget) CreateBoxWidget(panedw);
	tet_infoline("PREP: Set the height and width of boxw2 widget");
	ConfigureDimension(topLevel, boxw2);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get the file name to store the error message");
	strcpy(msg, "/tmp/");
	strcat(msg, "outfile");
	FORK(pid2);
	tet_infoline("TEST: Call XtAppErrorMsg with non-existant error");
	push_stderr("outfile", "w");
	XtAppErrorMsg(app_ctext, "This", "is a", "test", "Hello World", (String *)NULL, (Cardinal *)0);
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
	tet_infoline("TEST: Message is default");
	string = (char *)strstr(line, "Hello World");
	if (string == NULL) {
		sprintf(ebuf, "ERROR: Expected message to contain \"Hello World\", Received %s", line);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	fclose(stream);
	unlink(msg);
	tet_result(TET_PASS);
