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

Copyright (c) 2001 The Open Group
Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/Xt13/XtAppGetErrorDatabaseText/XtAppGetErrorDatabaseText.m
>># 
>># Description:
>>#	Tests for XtAppGetErrorDatabaseText()
>># 
>># Modifications:
>># $Log: tapgterdt.m,v $
>># Revision 1.2  2005-04-21 09:40:42  ajosey
>># resync to VSW5.1.5
>>#
>># Revision 8.2  2005/01/21 12:13:11  gwc
>># Updated copyright notice
>>#
>># Revision 8.1  2001/03/28 12:14:09  vsx
>># tp3 - set file_name & change testString to notThereString
>>#
>># Revision 8.0  1998/12/23 23:38:18  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:01:20  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:29:20  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:25:54  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:22:03  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:18:13  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

#define ER_SIZE    512
char file_name[1024] ;

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;
>>TITLE XtAppGetErrorDatabaseText Xt13
void
XtAppGetErrorDatabaseText(app_context, name, type, class, default, buffer_return, nbytes, database)
>>ASSERTION Good A
A successful call to 
void XtAppGetErrorDatabaseText(app_context, name, type, class, default, 
buffer_return, nbytes, database)
when
.A database
is not NULL
shall return the error message in 
.A buffer_return
for the error specified by the resource name 
.A name.type,
resource class
.A class.class
in the error database specified by
.A database.
>>CODE
XrmDatabase *database, file_database, db_return;
char buffer[ER_SIZE];
char *contents = "testString.error:Testing XtErrorMsg\n";
char *ErrorString = "Testing XtErrorMsg";
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tapgterdt1", "XtAppGetErrorDatabaseText");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get the file name to dump error message");
	strcpy(file_name, "/tmp/");
	strcat(file_name, "outfile");
	tet_infoline("PREP: Create error database");
	XrmInitialize();
	db_return = XrmGetStringDatabase(contents);
	(void)XrmPutFileDatabase(db_return,file_name);
	file_database = XrmGetFileDatabase(file_name);
	tet_infoline("TEST: Get message for testString.error");
	XtAppGetErrorDatabaseText(app_ctext,
		"testString", "error", "AppError",
		"ERROR: Unable find database Text ", buffer,
		 ER_SIZE, file_database);
	sprintf(ebuf, "TEST: Message was %s", ErrorString);
	tet_infoline(ebuf);
	check_str(ErrorString, buffer, "String");
	unlink(file_name);
	LKROF(pid2, AVSXTTIMEOUT-2);
	unlink(file_name);
	tet_result(TET_PASS);
>>ASSERTION Good A
A call to 
void XtAppGetErrorDatabaseText(app_context, name, type, class, default, 
buffer_return, nbytes, database)
when 
.A database 
is NULL shall return the error message in the buffer
.A buffer_return
for the error specified by the resource name 
.A name.type,
resource class
.A class.class
in the error database of the application context
.A app_context.
>>CODE
XrmDatabase *database, file_database, db_return;
char buffer[ER_SIZE];
char *contents = "testString.error:Testing XtErrorMsg\n";
char *ErrorString = "Testing XtErrorMsg";
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tapgterdt1", "XtAppGetErrorDatabaseText");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get the file name to dump error message");
	strcpy(file_name, "/tmp/");
	strcat(file_name, "outfile");
	tet_infoline("PREP: Create error database");
	XrmInitialize();
	db_return = XrmGetStringDatabase(contents);
	(void)XrmPutFileDatabase(db_return,file_name);
	file_database = XrmGetFileDatabase(file_name);
	tet_infoline("PREP: Obtain the error database");
	database = XtAppGetErrorDatabase(app_ctext);
	if (database == (XrmDatabase *)NULL) {
		sprintf(ebuf, "ERROR: Expected database to be non-NULL");
		tet_infoline(ebuf);
		tet_result(TET_UNRESOLVED);
	}
	tet_infoline("PREP: Merge original database with new database");
	XrmMergeDatabases(file_database, database);
	tet_infoline("TEST: Get message for testString.error");
	XtAppGetErrorDatabaseText(app_ctext,
		"testString", "error", "AppError",
		"ERROR: Unable find database Text ", buffer,
		 ER_SIZE, (XrmDatabase) NULL);
	sprintf(ebuf, "TEST: Message was %s", ErrorString);
	tet_infoline(ebuf);
	check_str(ErrorString, buffer, "String");
	unlink(file_name);
	LKROF(pid2, AVSXTTIMEOUT-2);
	unlink(file_name);
	tet_result(TET_PASS);
>>ASSERTION Good A
When 
.A database 
is not NULL and no entry exists in the error database for 
for the error specified by the resource name 
.A name.type,
resource class
.A class.class
a call to 
void XtAppGetErrorDatabaseText(app_context, name, type, class, default, buffer_return, nbytes, database)
shall return the string specified by
.A default
in
.A buffer_return.
>>CODE
pid_t pid2;
XrmDatabase *database, file_database, db_return;
char buffer[ER_SIZE];
char *contents = "testString.error:Testing XtErrorMsg\n";
char *ErrorString = "Testing XtErrorMsg";

	FORK(pid2);
	avs_xt_hier("Tapgterdt2", "XtAppGetErrorDatabaseText");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Get the file name to dump error message");
	strcpy(file_name, "/tmp/");
	strcat(file_name, "outfile");
	tet_infoline("PREP: Create error database");
	XrmInitialize();
	db_return = XrmGetStringDatabase(contents);
	(void)XrmPutFileDatabase(db_return,file_name);
	file_database = XrmGetFileDatabase(file_name);
	tet_infoline("TEST: Call XtAppGetErrorDatabaseText");
	XtAppGetErrorDatabaseText(app_ctext,
		"notThereString", "error", "AppError",
		"Hello World", buffer,
		 ER_SIZE, file_database);
	tet_infoline("TEST: Message was default");
	check_str("Hello World", buffer, "Default String");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
When 
.A database 
is NULL and no entry exists in the error database of the
application context
.A app_context
for the error specified by the resource name 
.A name.type,
resource class
.A class.class
a call to 
void XtAppGetErrorDatabaseText(app_context, name, type, class, default, buffer_return, nbytes, database)
shall return the string specified by
.A default
in
.A buffer_return.
>>CODE
char buffer[ER_SIZE];
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tapgterdt2", "XtAppGetErrorDatabaseText");
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Call XtAppGetErrorDatabaseText");
	XtAppGetErrorDatabaseText(app_ctext,
		"testString", "error", "AppError",
		"Hello World", buffer,
		 ER_SIZE, (XrmDatabase)NULL);
	tet_infoline("TEST: Message was default");
	check_str("Hello World", buffer, "Default String");
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
