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
>># File: xts/Xt12/XtParseTranslationTable/XtParseTranslationTable.m
>># 
>># Description:
>>#	Tests for XtParseTranslationTable()
>># 
>># Modifications:
>># $Log: tprsttbl.m,v $
>># Revision 1.1  2005-02-12 14:37:56  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:37:56  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:00:55  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:28:59  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:25:33  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:20:58  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:16:36  andy
>># Prepare for GA Release
>>#
>>EXTERN
#include <X11/IntrinsicP.h>
#include <X11/ConstrainP.h>
#include <X11/CoreP.h>

XtAppContext app_ctext;
Widget topLevel, panedw, boxw1, boxw2;
Widget labelw, rowcolw, click_quit;

extern char *event_names[];

XtActionProc XtACT_Proc(w, event, params, num_params)
Widget w;
XEvent *event;
String *params;
Cardinal *num_params;
{
	if (event->type == ButtonPress)
		avs_set_event(1,1);
	else {
		sprintf(ebuf, "ERROR: Expected ButtonPress event Received %s", event_names[event->type]);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	exit(0);
}
>>SET tpstartup avs_alloc_sem
>>SET tpcleanup avs_free_sem
>>TITLE XtParseTranslationTable Xt12
XtTranslations
XtParseTranslationTable(table)
>>ASSERTION Good A
A successful call to 
XtTranslations XtParseTranslationTable(table)
shall compile the translation table specified by the string
.A table
into a representation of type XtTranslations and return a pointer
to it.
>>CODE
pid_t pid2;
int invoked = 0;
XtTranslations translations;
static char trans_good[] = "<BtnDown>:	XtACT_Proc()";
static XtActionsRec actions[] = {
	 {"XtACT_Proc", (XtActionProc)XtACT_Proc},
};

	FORK(pid2);
	avs_xt_hier("Tprsttbl1", "XtParseTranslationTable");
	tet_infoline("PREP: Add action table");
	XtAppAddActions(app_ctext, actions, 1);
	tet_infoline("PREP: Parse translation table.");
	translations = XtParseTranslationTable(trans_good);
	tet_infoline("PREP: Create windows for widgets and map them");
	XtRealizeWidget(topLevel);
	tet_infoline("PREP: Add new translations into boxw1 widget.");
	XtAugmentTranslations(boxw1, translations);
	tet_infoline("PREP: Send ButtonPress event over wire");
	send_event(boxw1, ButtonPress, ButtonPressMask, TRUE);
	XtAppMainLoop(app_ctext);
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_infoline("TEST: Procedure XtACT_Proc was invoked.");
	invoked = avs_get_event(1);
	check_dec(1, invoked, "XtACT_Proc invoked status");
	tet_result(TET_PASS);
