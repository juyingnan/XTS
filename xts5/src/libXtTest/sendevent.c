/*
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
*/
/*
* $Header: /cvs/xtest/xtest/xts5/src/libXtTest/sendevent.c,v 1.1 2005-02-12 14:37:15 anderson Exp $
*
* Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
* Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
* All Rights Reserved.
*
* Project: VSW5
*
* File: vsw5/src/lib/libXtTest/sendevent.c
*
* Description:
*	Procedure send_event() to send a simulated event over a wire
*
* Modifications:
* $Log: sendevent.c,v $
* Revision 1.1  2005-02-12 14:37:15  anderson
* Initial revision
*
* Revision 8.0  1998/12/23 23:25:41  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:43:55  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:17:59  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:14:31  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:45:23  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:43:18  andy
* Prepare for GA Release
*
*/

#include <XtTest.h>

/*error messages formatted here*/
char ebuf[4096];

/*
** Simulate event
*/
void send_event_time(widget, event_type, event_mask, selection, event_time)
Widget widget;
int event_type;
long event_mask;
Boolean selection;
Time event_time;
{
     XtAppContext app_context;
     Display *display;
     Window  window;
     XEvent  event_good;
     Status  status_good;

	app_context = XtWidgetToApplicationContext(widget);
	display = XtDisplay(widget);
	window = XtWindow(widget);

	send_event_mask_time(display, window, event_mask, event_type, 0, &event_good, event_time);
     
	if ( selection == TRUE ) {
	     XSelectInput(display, window, event_mask);
	     XSync(display, False);
	}

	/*
	** Simulate event
	*/
	status_good = XSendEvent(display, window, False, event_mask, &event_good);
 
	if (!status_good) {
		sprintf(ebuf, "ERROR: send_event_time: The %d event not converted into a wire event.", event_good.type);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
		return;
	}
	XSync(display, False);

}

void send_event(widget, event_type, event_mask, selection)
Widget widget;
int event_type;
long event_mask;
Boolean selection;
{
	send_event_time(widget, event_type, event_mask, selection, (Time) CurrentTime);
}
