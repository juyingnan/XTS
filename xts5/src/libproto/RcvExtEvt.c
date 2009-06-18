/*
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
*/
/*
* $Header: /cvs/xtest/xtest/xts5/src/libproto/RcvExtEvt.c,v 1.2 2005-11-03 08:42:02 jmichael Exp $
*
* Copyright Applied Testing and Technology Inc. 1995
* All rights reserved
*
* Project: VSW5
*
* File:	xts5/src/libproto/RcvExtEvt.c
*
* Description:
*	Protocol test support routines
*
* Modifications:
* $Log: RcvExtEvt.c,v $
* Revision 1.2  2005-11-03 08:42:02  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:11  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:25:02  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:43:15  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:17:24  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:13:57  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.1  1996/01/25 01:58:33  andy
* Portability improvements from DEPLOY tools
*
* Revision 4.0  1995/12/15  08:43:35  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:41:11  andy
* Prepare for GA Release
*
*/

/*
Portions of this software are based on Xlib and X Protocol Test Suite.
We have used this material under the terms of its copyright, which grants
free use, subject to the conditions below.  Note however that those
portions of this software that are based on the original Test Suite have
been significantly revised and that all such revisions are copyright (c)
1995 Applied Testing and Technology, Inc.  Insomuch as the proprietary
revisions cannot be separated from the freely copyable material, the net
result is that use of this software is governed by the ApTest copyright.

Copyright (c) 1990, 1991  X Consortium

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
X CONSORTIUM BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

Except as contained in this notice, the name of the X Consortium shall not be
used in advertising or otherwise to promote the sale, use or other dealings
in this Software without prior written authorization from the X Consortium.

Copyright 1990, 1991 by UniSoft Group Limited.

Permission to use, copy, modify, distribute, and sell this software and
its documentation for any purpose is hereby granted without fee,
provided that the above copyright notice appear in all copies and that
both that copyright notice and this permission notice appear in
supporting documentation, and that the name of UniSoft not be
used in advertising or publicity pertaining to distribution of the
software without specific, written prior permission.  UniSoft
makes no representations about the suitability of this software for any
purpose.  It is provided "as is" without express or implied warranty.

Copyright 1988 by Sequent Computer Systems, Inc., Portland, Oregon

                        All Rights Reserved

Permission to use, copy, modify, and distribute this software and its
documentation for any purpose and without fee is hereby granted,
provided that the above copyright notice appears in all copies and that
both that copyright notice and this permission notice appear in
supporting documentation, and that the name of Sequent not be used
in advertising or publicity pertaining to distribution or use of the
software without specific, written prior permission.

SEQUENT DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING
ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT SHALL
SEQUENT BE LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR
ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS,
WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION,
ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS
SOFTWARE.
*/


/*
 *	$Header: /cvs/xtest/xtest/xts5/src/libproto/RcvExtEvt.c,v 1.2 2005-11-03 08:42:02 jmichael Exp $
 */

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#ifndef lint
static char rcsid[]="$Header: /cvs/xtest/xtest/xts5/src/libproto/RcvExtEvt.c,v 1.2 2005-11-03 08:42:02 jmichael Exp $";
#endif

#include "XstlibInt.h"
#ifdef INPUTEXTENSION
#include "X11/extensions/XIproto.h"
#endif
#ifdef Xpi
#include "xtestext1.h"
#endif
#include "DataMove.h"

#define EVENT_HEADER	4	/* constant header */
#define XInputNumEvents	15
extern int XInputFirstEvent;

int
Rcv_Ext_Evt(rp,rbuf,client,base)
xEvent *rp;
char rbuf[];
int client;
int base;
{
#ifdef INPUTEXTENSION
#ifdef Xpi
	int xtestType;
#endif
	int needswap = Xst_clients[client].cl_swap;
	char *rbp = rbuf;
	int valid = 1;		/* assume all is OK */
	int rtype;

	rbp += EVENT_HEADER;

	rtype = real_type(rp->u.u.type) - XInputFirstEvent; 
	if (rtype >= 0 && rtype < XInputNumEvents) {
		switch (rtype) {
		case XI_DeviceKeyPress:
		case XI_DeviceKeyRelease:
		case XI_DeviceButtonPress:
		case XI_DeviceButtonRelease:
		case XI_DeviceMotionNotify:
		case XI_ProximityIn:
		case XI_ProximityOut:
			{
			deviceKeyButtonPointer *rpi = (deviceKeyButtonPointer *) rp;
	
			rpi->time = unpack4(&rbp,needswap);
			rpi->root = unpack4(&rbp,needswap);
			rpi->event = unpack4(&rbp,needswap);
			rpi->child = unpack4(&rbp,needswap);
			rpi->root_x = unpack2(&rbp,needswap);
			rpi->root_y = unpack2(&rbp,needswap);
			rpi->event_x = unpack2(&rbp,needswap);
			rpi->event_y = unpack2(&rbp,needswap);
			rpi->state = unpack2(&rbp,needswap);
			rpi->same_screen = unpack1(&rbp);
			rpi->deviceid = unpack1(&rbp);
			break;
			}
		case XI_DeviceFocusIn:
		case XI_DeviceFocusOut:
			{
			deviceFocus *rpi = (deviceFocus *) rp;
	
			rpi->time = unpack4(&rbp,needswap);
			rpi->window = unpack4(&rbp,needswap);
			rpi->mode = unpack1(&rbp);
			rpi->deviceid = unpack1(&rbp);
			break;
			}
		case XI_ChangeDeviceNotify:
			{
			changeDeviceNotify *rpi = (changeDeviceNotify *) rp;
	
			rpi->time = unpack4(&rbp,needswap);
			rpi->request = unpack1(&rbp);
			break;
			}
		case XI_DeviceStateNotify:
			{
			deviceStateNotify *rpi = (deviceStateNotify *) rp;
	
			rpi->time = unpack4(&rbp,needswap);
			rpi->num_keys = unpack1(&rbp);
			rpi->num_buttons = unpack1(&rbp);
			rpi->num_valuators = unpack1(&rbp);
			rpi->classes_reported = unpack1(&rbp);
			rpi->buttons[0] = unpack1(&rbp);
			rpi->buttons[1] = unpack1(&rbp);
			rpi->buttons[2] = unpack1(&rbp);
			rpi->buttons[3] = unpack1(&rbp);
			rpi->keys[0] = unpack1(&rbp);
			rpi->keys[1] = unpack1(&rbp);
			rpi->keys[2] = unpack1(&rbp);
			rpi->keys[3] = unpack1(&rbp);
			rpi->valuator0 = unpack4(&rbp,needswap);
			rpi->valuator1 = unpack4(&rbp,needswap);
			rpi->valuator2 = unpack4(&rbp,needswap);
			break;
			}
		case XI_DeviceMappingNotify:
			{
			deviceMappingNotify *rpi = (deviceMappingNotify *) rp;
	
			rpi->request = unpack1(&rbp);
			rpi->firstKeyCode = unpack1(&rbp);
			rpi->count = unpack1(&rbp);
			rpi->pad1 = unpack1(&rbp);
			rpi->time = unpack4(&rbp,needswap);
			break;
			}
		case XI_DeviceValuator:
			{
			deviceValuator *rpi = (deviceValuator *) rp;
	
			rpi->device_state = unpack2(&rbp);
			rpi->num_valuators = unpack1(&rbp);
			rpi->first_valuator = unpack1(&rbp);
			rpi->valuator0 = unpack4(&rbp,needswap);
			rpi->valuator1 = unpack4(&rbp,needswap);
			rpi->valuator2 = unpack4(&rbp,needswap);
			rpi->valuator3 = unpack4(&rbp,needswap);
			rpi->valuator4 = unpack4(&rbp,needswap);
			rpi->valuator5 = unpack4(&rbp,needswap);
			break;
			}
		default:
			report("Unknown event of type %d received",
			    real_type(rp->u.u.type));
			DEFAULT_ERROR;
		}
	}
	else
		{
		report("Unknown event of type %d received",
		    real_type(rp->u.u.type));
		DEFAULT_ERROR;
		}
	return(valid);
#endif
}
