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
* $Header: /cvs/xtest/xtest/xts5/src/libXtTest/sendmask.c,v 1.1 2005-02-12 14:37:15 anderson Exp $
*
* Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
* Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
* All Rights Reserved.
*
* Project: VSW5
*
* File: vsw5/src/lib/libXtTest/sendmask.c
*
* Description:
*	Procedure send_event_mask()
*
* Modifications:
* $Log: sendmask.c,v $
* Revision 1.1  2005-02-12 14:37:15  anderson
* Initial revision
*
* Revision 8.0  1998/12/23 23:25:41  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:43:55  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:18:00  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:14:32  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:45:25  tbr
* Branch point for Release 5.0.0
*
* Revision 3.2  1995/12/15  00:43:20  andy
* Prepare for GA Release
*
*/



/*
** FORMAL PARAMETERS:
**
**      dsply
**          pointer to the display to be used
**
**      wndw
**          target window for the event
**
**      msk
**          input event mask which is used in combination with 
**          input event type to fill the appropriate event structure
**
**      typ
**          input event type which is used in combination with 
**          input event mask to fill the appropriate event structure
**
**      key
**          input keycode to use in KeyPressMask event
**
**      sevent
**          pointer to the XEvent structure that is to be filled
**
** IMPLICIT INPUTS:
**
**      NONE
**
** IMPLICIT OUTPUTS:
**
**      NONE
**
** COMPLETION STATUS: (or RETURN VALUE)
**
**      NONE
**
** SIDE EFFECTS:
**
**      NONE
**
*/

#include <XtTest.h>
#include <X11/Xatom.h>              /* standard x atom values */
 
void send_event_mask_time (dsply, wndw, msk, typ, key, sevent, event_time)
Display *dsply;
Window wndw;
unsigned long   msk;
int     typ;
KeyCode key;
XEvent * sevent;
Time event_time;
{

    Status st;
    XWindowAttributes w_att;
    Atom atom;
    Window r;
    Window p;
    Window * childptr;
    unsigned int    nchildren,  i;
    int min_keycode ;
    int max_keycode ;
 
    st = XGetWindowAttributes (dsply, wndw, &w_att);
    XDisplayKeycodes(dsply, &min_keycode, &max_keycode);
 
    sevent -> xany.type = typ;
    sevent -> xany.display = dsply;
    sevent -> xany.window = wndw;
 
    switch (msk)
    {
	case ButtonMotionMask: 
	case Button1MotionMask: 
	case Button2MotionMask: 
	case Button3MotionMask: 
	case Button4MotionMask: 
	case Button5MotionMask: 
	case PointerMotionMask: 
	case PointerMotionHintMask: 
	    sevent -> xmotion.root = w_att.root;
	    sevent -> xmotion.subwindow = (Window) NULL;
	    sevent -> xmotion.time = (Time) event_time;
	    sevent -> xmotion.x = w_att.x;
	    sevent -> xmotion.y = w_att.y;
	    sevent -> xmotion.x_root = w_att.x;
	    sevent -> xmotion.y_root = w_att.y;
	    sevent -> xmotion.is_hint = NotifyHint;
	    sevent -> xmotion.same_screen = True;
 
	    switch (msk)
	    {
		case Button1MotionMask: 
		    sevent -> xmotion.state = Button1Mask;
		    break;
		case Button2MotionMask: 
		    sevent -> xmotion.state = Button2Mask;
		    break;
		case Button3MotionMask: 
		    sevent -> xmotion.state = Button3Mask;
		    break;
		case Button4MotionMask: 
		    sevent -> xmotion.state = Button4Mask;
		    break;
		case Button5MotionMask: 
		    sevent -> xmotion.state = Button5Mask;
		    break;
		default: 
		    sevent -> xmotion.state = (unsigned int) NULL;
		    break;
	    }
	    break;
 
	case ButtonPressMask: 
	case ButtonReleaseMask: 
	    sevent -> xbutton.root = w_att.root;
	    sevent -> xbutton.subwindow = (Window) NULL;
	    sevent -> xbutton.time = (Time) event_time;
	    sevent -> xbutton.x = w_att.x;
	    sevent -> xbutton.y = w_att.y;
	    sevent -> xbutton.x_root = w_att.x;
	    sevent -> xbutton.y_root = w_att.y;
	    sevent -> xbutton.state = (unsigned int) NULL;
	    sevent -> xbutton.button = Button1;
	    sevent -> xbutton.same_screen = True;
	    break;
 
	case EnterWindowMask: 
	case LeaveWindowMask: 
	    sevent -> xcrossing.root = w_att.root;
	    sevent -> xcrossing.subwindow = (Window) NULL;
	    sevent -> xcrossing.time = (Time) event_time;
	    sevent -> xcrossing.x = w_att.x;
	    sevent -> xcrossing.y = w_att.y;
	    sevent -> xcrossing.x_root = w_att.x;
	    sevent -> xcrossing.y_root = w_att.y;
	    sevent -> xcrossing.mode = NotifyNormal;
	    sevent -> xcrossing.detail = NotifyAncestor;
	    sevent -> xcrossing.same_screen = (Bool) True;
	    sevent -> xcrossing.focus = (Bool) True;
	    sevent -> xcrossing.state = (unsigned int) NULL;
	    break;
 
	case FocusChangeMask: 
	    sevent -> xfocus.mode = NotifyNormal;
	    sevent -> xfocus.detail = NotifyAncestor;
	    break;
 
	case ExposureMask: 
	    if (typ == Expose)
	    {
		sevent -> xexpose.x = w_att.x;
		sevent -> xexpose.y = w_att.y;
		sevent -> xexpose.width = w_att.width;
		sevent -> xexpose.height = w_att.height;
		sevent -> xexpose.count = (int) 0;
	    }
	    else
		if (typ == GraphicsExpose)
		{
		    sevent -> xgraphicsexpose.x = w_att.x;
		    sevent -> xgraphicsexpose.y = w_att.y;
		    sevent -> xgraphicsexpose.count = (int) 0;
		    sevent -> xgraphicsexpose.major_code = 63;/* X_CopyArea; */
		    sevent -> xgraphicsexpose.minor_code = (int) 0;
		}
		else
		    if (typ == NoExpose)
		    {
			sevent -> xnoexpose.major_code = 63;/* X_CopyArea; */
			sevent -> xnoexpose.minor_code = (int) 0;
		    }
	    break;
 
	case VisibilityChangeMask: 
	    sevent -> xvisibility.state = VisibilityUnobscured;
	    break;
 
	case StructureNotifyMask: 
	case SubstructureNotifyMask: 
	    switch (typ)
	    {
		case CirculateNotify: 
		    sevent -> xcirculate.event = wndw;
		    sevent -> xcirculate.window = wndw;
		    sevent -> xcirculate.place = PlaceOnTop;
		case CreateNotify: 
		    sevent -> xcreatewindow.parent = wndw;		    
		    sevent -> xcreatewindow.window = wndw;
		    sevent -> xcreatewindow.x = w_att.x;
		    sevent -> xcreatewindow.y = w_att.y;
		    sevent -> xcreatewindow.width = w_att.width;
		    sevent -> xcreatewindow.height = w_att.height;
		    sevent -> xcreatewindow.border_width = w_att.border_width;
		    sevent -> xcreatewindow.override_redirect = w_att.override_redirect;
		    break;
 
		case ConfigureNotify: 
		    sevent -> xconfigure.event = wndw;
		    sevent -> xconfigure.window = wndw;
		    sevent -> xconfigure.x = w_att.x;
		    sevent -> xconfigure.y = w_att.y;
		    sevent -> xconfigure.width = w_att.width;
		    sevent -> xconfigure.height = w_att.height;
		    sevent -> xconfigure.border_width = w_att.border_width;
		    sevent -> xconfigure.above = None;
		    sevent -> xconfigure.override_redirect = w_att.override_redirect;
		    break;
 
		case DestroyNotify: 
		    sevent -> xdestroywindow.event = wndw;
		    sevent -> xdestroywindow.window = wndw;
		    break;
 
		case GravityNotify: 
		    sevent -> xgravity.event = wndw;
		    sevent -> xgravity.window = wndw;
		    sevent -> xgravity.x = w_att.x;
		    sevent -> xgravity.y = w_att.y;
		    break;
 
		case MapNotify: 
		    sevent -> xmap.event = wndw;
		    sevent -> xmap.window = wndw;
		    sevent -> xmap.override_redirect = w_att.override_redirect;
		    break;
 
		case ReparentNotify: 
		    st = XQueryTree (dsply, wndw, &r, &p, &childptr, &nchildren);
		    if (st)
		    {
			XFree ((char *)childptr);
			sevent -> xreparent.parent = p;
		    }
		    else
			sevent -> xreparent.parent = XRootWindow (dsply,
				XDefaultScreen (dsply));
		    sevent -> xreparent.x = w_att.x;
		    sevent -> xreparent.y = w_att.y;
		    sevent -> xreparent.override_redirect = w_att.override_redirect;
		    break;
 
		case UnmapNotify: 
		    sevent -> xunmap.event = wndw;
		    sevent -> xunmap.window = wndw;
		    sevent -> xunmap.from_configure = True;
		    break;
	    }
	    break;
 
 
	case SubstructureRedirectMask: 
	    if (typ == CirculateRequest)
	    {
		sevent -> xcirculaterequest.place = PlaceOnTop;
		sevent -> xcirculaterequest.window = wndw;
	    }
	    else
		if (typ == ConfigureRequest)
		{
		    sevent -> xconfigurerequest.window = wndw;
		    sevent -> xconfigurerequest.x = w_att.x;
		    sevent -> xconfigurerequest.y = w_att.y;
		    sevent -> xconfigurerequest.width = w_att.width;
		    sevent -> xconfigurerequest.height = w_att.height;
		    sevent -> xconfigurerequest.border_width = w_att.border_width;
		    sevent -> xconfigurerequest.above = p;
		    sevent -> xconfigurerequest.detail = Above;
		    sevent -> xconfigurerequest.value_mask = None;
		}
		else
		    if (typ == MapRequest)
		    {
			sevent -> xmaprequest.parent = wndw;
			sevent -> xmaprequest.window = wndw;
		    }
	    break;
 
	case PropertyChangeMask: 
	    atom = XA_RESOURCE_MANAGER;
	    sevent -> xproperty.atom = atom;
	    sevent -> xproperty.time = (Time) event_time;
	    sevent -> xproperty.state = PropertyNewValue;
	    break;
 
	case ResizeRedirectMask: 
	    sevent -> xresizerequest.width = w_att.width;
	    sevent -> xresizerequest.height = w_att.height;
	    break;
 
	case ColormapChangeMask: 
	    sevent -> xcolormap.colormap = None;
	    sevent -> xcolormap.new = False;
	    sevent -> xcolormap.state = ColormapInstalled;
	    break;
 
	case KeymapStateMask: 
	    for (i = 0; i < 32; i++)
		sevent -> xkeymap.key_vector[i] = (char) 0;
	    break;
 
	case KeyPressMask: 
	case KeyReleaseMask:
	    sevent -> xkey.root = w_att.root;
	    sevent -> xkey.subwindow = (Window) NULL;
	    sevent -> xkey.time = (Time) event_time;
	    sevent -> xkey.x = w_att.x;
	    sevent -> xkey.y = w_att.y;
	    sevent -> xkey.x_root = w_att.x;
	    sevent -> xkey.y_root = w_att.y;
	    sevent -> xkey.state = (unsigned int) NULL;
	    sevent -> xkey.same_screen = True;
	    if (key < (KeyCode)min_keycode || key > (KeyCode)max_keycode)
		sevent -> xkey.keycode = min_keycode;
	    else
		sevent -> xkey.keycode = key;
	    break;
 
	default: 
	    switch (typ)
	    {
		case ClientMessage: 
		    sevent -> xclient.message_type = XA_PRIMARY;
		    sevent -> xclient.format = 32;
		    sevent -> xclient.data.l[0] = 0;
		    sevent -> xclient.data.l[1] = 0;
		    sevent -> xclient.data.l[2] = 0;
		    sevent -> xclient.data.l[3] = 0;
		    sevent -> xclient.data.l[4] = 0;
		    break;
		case MappingNotify: 
		    sevent -> xmapping.request = MappingModifier;
		    sevent -> xmapping.first_keycode = min_keycode;
		    sevent -> xmapping.count = 1;
		    break;
		case SelectionClear: 
		    sevent -> xselectionclear.selection = XA_PRIMARY;
		    sevent -> xselectionclear.time = 0;
		    break;
		case SelectionNotify: 
		    sevent -> xselection.requestor = wndw;
		    sevent -> xselection.selection = XA_PRIMARY;
		    sevent -> xselection.target = XA_PRIMARY;
		    sevent -> xselection.property = XA_PRIMARY;
		    sevent -> xselection.time = 0;
		    break;
		case SelectionRequest: 
		    sevent -> xselectionrequest.owner = wndw;
		    sevent -> xselectionrequest.requestor = wndw;
		    sevent -> xselectionrequest.selection = XA_PRIMARY;
		    sevent -> xselectionrequest.target = XA_PRIMARY;
		    sevent -> xselectionrequest.property = XA_PRIMARY;
		    sevent -> xselectionrequest.time = 0;
		    break;
		default: 
		    break;
	    }
	    break;
    }
    return;
}

void send_event_mask (dsply, wndw, msk, typ, key, sevent)
Display *dsply;
Window wndw;
unsigned long   msk;
int     typ;
KeyCode key;
XEvent *sevent;
{
	send_event_mask_time (dsply, wndw, msk, typ, key, sevent, (Time) CurrentTime);
}
