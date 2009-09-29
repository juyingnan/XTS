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
>># File: xts/Xt9/XtBuildEventMask.m
>># 
>># Description:
>>#	Tests for XtBuildEventMask()
>># 
>># Modifications:
>># $Log: tbuevtmsk.m,v $
>># Revision 1.1  2005-02-12 14:38:24  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:37:15  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:00:09  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:28:21  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:24:55  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:18:57  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:12:24  andy
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
** XtEVT1_Proc
*/
void XtEVT1_Proc(w, client_data, event, continue_to_process)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_process;
{
}
/*
** XtEVT2_Proc
*/
void XtEVT2_Proc(w, client_data, event, continue_to_process)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_process;
{
}
void XtACT2_Proc(w, event, params, num_params)
Widget w;
XEvent *event;
String *params;
Cardinal *num_params;
{
}
/*
** XtEVT3_Proc
*/
void XtEVT3_Proc(w, client_data, event, continue_to_process)
Widget w;
XtPointer client_data;
XEvent *event;
Boolean *continue_to_process;
{
}
void XtACT3_Proc(w, event, params, num_params)
Widget w;
XEvent *event;
String *params;
Cardinal *num_params;
{
}

>>TITLE XtBuildEventMask Xt9
EventMask
XtBuildEventMask(w)
>>ASSERTION Good A
A successful call to 
EventMask XtBuildEventMask(w) 
shall return the event mask for the widget 
.A w
that is the logical OR of all event masks for event handlers
registered on the widget with XtAddEventHandler and XtInsertEventHandler
and all event translations, including accelerators, installed on the 
specified widget.
>>CODE
Widget labelw_msg;
EventMask event_mask_good;
EventMask events_selected;
pid_t pid2;

	FORK(pid2);
	avs_xt_hier("Tbuevtmsk1", "XtBuildEventMask");
	tet_infoline("PREP: Create a test labelw_msg widget");
	labelw_msg = (Widget) CreateLabelWidget("ApTest", boxw1);
	tet_infoline("PREP: Register handler for KeyPress and Release events");
	events_selected = (KeyPressMask | KeyReleaseMask);
	XtAddEventHandler(labelw_msg,
		 events_selected,
		 False,
		 XtEVT1_Proc,
		 (Widget)topLevel
		 );
	tet_infoline("PREP: Realize widgets");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Event mask has KeyPress and Release set");
	event_mask_good = XtBuildEventMask(labelw_msg);
	if ((event_mask_good & events_selected) != events_selected) {
		sprintf(ebuf, "ERROR: expected mask to include %#x, mask was %#x", events_selected, event_mask_good);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
The event mask returned by a call to 
EventMask XtBuildEventMask(w) 
shall reflect all event translations and accelerators installed
for the widget
.A w. 
>>CODE
Widget labelw_msg;
EventMask event_mask_good, events_selected;
pid_t pid2;
XtTranslations translations;
static char trans_good[] = "#replace	\n\
	 <BtnDown>:	XtACT2_Proc()";
static XtActionsRec actions[] = {
	 {"XtACT2_Proc", (XtActionProc)XtACT2_Proc},
	};

	FORK(pid2);
	avs_xt_hier("Tbuevtmsk2", "XtBuildEventMask");
	tet_infoline("PREP: Create a test widget");
	labelw_msg = (Widget) CreateLabelWidget("ApTest", boxw1);
	tet_infoline("PREP: Register handler for KeyPress and Release events");
	events_selected = KeyPressMask|KeyReleaseMask;	
	XtAddEventHandler(labelw_msg,
		 events_selected,
		 False,
		 XtEVT2_Proc,
		 (Widget)topLevel
		 );
	tet_infoline("PREP: Add translations for ButtonPress");
	XtAppAddActions(app_ctext, actions, 1);
	translations = XtParseTranslationTable(trans_good);
	XtAugmentTranslations(labelw_msg, translations);
	tet_infoline("PREP: Realize widgets");
	XtRealizeWidget(topLevel);
	tet_infoline("TEST: Event mask has KeyPress and Release set");
	event_mask_good = XtBuildEventMask(labelw_msg);
	if ((event_mask_good & events_selected) != events_selected) {
		sprintf(ebuf, "ERROR: expected mask to include %#x, mask was %#x", events_selected, event_mask_good);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("TEST: Event mask has ButtonPress set");
	if ((event_mask_good & ButtonPressMask) != ButtonPressMask) {
		sprintf(ebuf, "ERROR: expected mask to include %#x, mask was %#x", ButtonPressMask, event_mask_good);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
>>ASSERTION Good A
The event mask returned by a call to EventMask XtBuildEventMask(w)
reflect the addition or removal or event handlers and translations.
>>CODE
Widget labelw_msg;
EventMask event_mask_good, events_selected;
pid_t pid2;
XtTranslations translations;
static char trans_good[] = "#replace	\n\
	 <BtnDown>:	XtACT3_Proc()";
static XtActionsRec actions[] = {
	 {"XtACT3_Proc", (XtActionProc)XtACT3_Proc},
	};

	FORK(pid2);
	avs_xt_hier("Tbuevtmsk3", "XtBuildEventMask");
	tet_infoline("PREP: Create a test widget");
	labelw_msg = (Widget) CreateLabelWidget("ApTest", boxw1);
	tet_infoline("PREP: Realize widgets");
	XtRealizeWidget(topLevel);
	events_selected = KeyPressMask|KeyReleaseMask;
	tet_infoline("PREP: Register handler for KeyPress and Release events");
	XtAddEventHandler(labelw_msg,
		 events_selected,
		 False,
		 XtEVT3_Proc,
		 NULL
		 );
	tet_infoline("TEST: Event mask has KeyPress and Release set");
	event_mask_good = XtBuildEventMask(labelw_msg);
	if ((event_mask_good & events_selected) != events_selected) {
		sprintf(ebuf, "ERROR: Expected mask to include %#x, mask was %#x", events_selected, event_mask_good);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("PREP: Add translations for ButtonPress");
	XtAppAddActions(app_ctext, actions, 1);
	translations = XtParseTranslationTable(trans_good);
	XtAugmentTranslations(labelw_msg, translations);
	event_mask_good = XtBuildEventMask(labelw_msg);
	tet_infoline("TEST: Event mask has ButtonPress set");
	if ((event_mask_good & ButtonPressMask) != ButtonPressMask) {
		sprintf(ebuf, "ERROR: Expected mask to include %#x, mask was %#x", ButtonPressMask, event_mask_good);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("PREP: Remove the event handler");
	XtRemoveEventHandler(labelw_msg,
		 events_selected,
		 False,
		 XtEVT3_Proc,
		 NULL
		 );
	tet_infoline("TEST: Event mask does not have KeyPress or Release set");
	event_mask_good = XtBuildEventMask(labelw_msg);
	if ((event_mask_good & events_selected) != 0) {
		sprintf(ebuf, "ERROR: Expected mask to not include %#x, mask was %#x", events_selected, event_mask_good);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	tet_infoline("PREP: Remove translations");
	XtUninstallTranslations(labelw_msg);
	tet_infoline("TEST: Event mask does not have ButtonPress set");
	event_mask_good = XtBuildEventMask(labelw_msg);
	if ((event_mask_good & ButtonPressMask) != 0) {
		sprintf(ebuf, "ERROR: Expected mask to not include %#x, mask was %#x", ButtonPressMask, event_mask_good);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
	LKROF(pid2, AVSXTTIMEOUT-2);
	tet_result(TET_PASS);
