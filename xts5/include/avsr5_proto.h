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
* $Header: /cvs/xtest/xtest/xts5/include/avsr5_proto.h,v 1.1 2005-02-12 14:37:13 anderson Exp $
*
* Copyright Applied Testing and Technology Inc. 1995
* All rights reserved
*
* Project: VSW5
*
* File:	vsw5/src/libXR5/r5avs_proto.h
*
* Description:
*	Drawable support routines
*
* Modifications:
* $Log: avsr5_proto.h,v $
* Revision 1.1  2005-02-12 14:37:13  anderson
* Initial revision
*
* Revision 8.0  1998/12/23 23:23:31  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:41:36  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:16:02  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:12:33  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:38:50  tbr
* Branch point for Release 5.0.0
*
* Revision 3.2  1995/12/15  02:08:48  andy
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
*/

void vmakebig();
void VBlowup();
void bufrdisp();
int diff_message();
int chek_stat();
void dumpbuf();
void check_dec();
void check_flo();
void check_dou();
void check_oct();
void check_hex();
void check_uns();
void check_cha();
void check_adr();
void check_str();
void check_strn ();
void message();
int badstat();
void r_wait();
void r5_startup();
void r5_cleanup();
void step();
int DummyEH();
int save_stat();
int signal_status();

/* 
void vmakebig(DISPLAY *vdisplay, Window window, Window blowup_win, int x, int y, 
	int zoom_factor,int pixels_across, int size, int format, GC gc, 
	unsigned long gcback, unsigned long gcfore, XImage *kgi, int ix, 
	int iy, unsigned long background, int view_color, int test_color);
void VBlowup(Display *vdisplay, Window window, int init_x, int init_y, int size, 
	int granularity, Colormap cmap, XImage *kgi, int ix, int iy, 
	unsigned long background, int warp_pointer_x, int warp_pointer_y, 
	int show_banner,int compare_color);
void bufrdisp(DISPLAY *display);
int diff_message(int environment, int *num_diff);
int chek_stat(int save_mask, GC gc_id, DISPLAY *display_struc, Drawable drawable_id, int watOK);
void dumpbuf(void);
void check_dec(long exp, long rec, char *item_name);
void check_flo(float exp, float rec, char *item_name);
void check_dou(double exp, double rec, char *item_name);
void check_oct(double exp, double rec, char *item_name);
void check_hex(long exp, long rec, char *item_name);
void check_uns(unsigned long exp, unsigned long rec, char *item_name);
void check_cha(char exp, char rec, char *item_name);
void check_adr(char *exp, char *rec, char *item_name);
void check_str(char *exp, char *rec, char *item_name);
void check_strn (char *exp, char *rec, int len, char *item_name);
void message(char *fmtstr, union msglst f_lst[], int f_cnt);
int badstat(DISPLAY *display, int expected, int received);
void r_wait(DISPLAY *disp, Window wind, int seconds, Colormap cmap);
void r5_startup(void);
void r5_cleanup(void);
void step(char *str);
int DummyEH(Display *display_struc, XErrorEvent error_event);
int save_stat(int save_mask, GC gc_id, Display *display_struc, Drawable drawable_id);
int signal_status(Display *disp, XErrorEvent *error_event);
*/
