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

Copyright (c) 1999 The Open Group
Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: xts/Xt9/XtRemoveInput/XtRemoveInput.m
>># 
>># Description:
>>#	Tests for XtRemoveInput()
>># 
>># Modifications:
>># $Log: trminput.m,v $
>># Revision 1.2  2005-04-21 09:40:42  ajosey
>># resync to VSW5.1.5
>>#
>># Revision 8.2  2005/01/21 12:24:57  gwc
>># Updated copyright notice
>>#
>># Revision 8.1  1999/11/26 11:36:03  vsx
>># avoid fixed file locations (for exec-in-place false)
>>#
>># Revision 8.0  1998/12/23 23:36:57  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:59:50  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:28:04  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:38  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:18:01  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.2  1995/12/15  02:11:13  andy
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
** XtIOP_Proc
*/
void XtIOP_Proc(client_data, source, id)
XtPointer client_data;
int *source;
XtInputId *id;
{
	sprintf(ebuf, "ERROR: Deleted procedure XtIOP_Proc invoked");
	tet_infoline(ebuf);
	tet_result(TET_FAIL);
	exit(0);
}
/* procedure XtTMO_Proc to be invoked */
void XtTMO_Proc(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	exit(0);
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtRemoveInput Xt9
void XtRemoveInput(id)
>>ASSERTION Good A
A successful call to 
void XtRemoveInput(id) 
shall unregister the input source callback procedure
registered by a prior call to XtAppAddInput.
>>CODE
char data[1024];
FILE *fid;
XtInputId id;
char buf[10];
pid_t pid2;

	tet_infoline("PREP: Get the file name to read contents");
	if (getcwd(data, sizeof(data)-15) == NULL) {
		tet_infoline("ERROR: getcwd() returned NULL");
		tet_result(TET_UNRESOLVED);
		exit(0);
	}
	strcat(data, "/trminput.dat");
	FORK(pid2);
	avs_xt_hier("Trminput1", "XtRemoveInput");
	sprintf(ebuf, "PREP: Open file %s for read", data);
	tet_infoline(ebuf);
	if ((fid = (FILE *)fopen(data, "r")) == NULL) {
		sprintf(ebuf, "ERROR: Could not open file %s", data);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
		exit(0);
	}
	tet_infoline("PREP: Register a new file as an input source");
	id = XtAppAddInput(app_ctext, fileno(fid), (XtPointer)XtInputReadMask, XtIOP_Proc, NULL);
	tet_infoline("PREP: Remove the procedure XtIOP_Proc just registered");
	XtRemoveInput(id);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Register timeout procedure");
	XtAppAddTimeOut(app_ctext, AVSXTLOOPTIMEOUT, XtTMO_Proc, topLevel);
	tet_infoline("TEST: Input callback procedure is not called");
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
