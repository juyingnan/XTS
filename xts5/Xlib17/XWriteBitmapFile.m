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

Copyright (c) Applied Testing and Technology, Inc. 1995
All Rights Reserved.

>># Project: VSW5
>># 
>># File: xts5/Xlib17/XWriteBitmapFile.m
>># 
>># Description:
>># 	Tests for XWriteBitmapFile()
>># 
>># Modifications:
>># $Log: wrtbtmpfl.m,v $
>># Revision 1.2  2005-11-03 08:43:15  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:24  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:34:58  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:57:23  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:26:14  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:22:47  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:11:58  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:14:48  andy
>># Prepare for GA Release
>>#
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
>>TITLE XWriteBitmapFile Xlib17
int

Display *display = Dsp;
const char *filename = outfile(xwbf_name);
Pixmap bitmap = xwbf_bm;
unsigned int width = xwbf_width;
unsigned int height = xwbf_height;
int x_hot = -1;
int y_hot = -1;
>>EXTERN

#include <sys/types.h>
#include <errno.h>
#include <sys/stat.h>

#ifndef S_IRUSR
#define XWBF_MODE 0x600
#else
#define XWBF_MODE (S_IRUSR|S_IXUSR)
#endif

#define XWBF_DIR "xwbf_dir"
#define XWBF_FILE "xwbf_dir/xwbf_file"

static char *xwbf_name = "xwbf_temp";

static Pixmap xwbf_bm = (Pixmap)0;

static unsigned char xwbf_data[]= {
	0x80, 0x00, 0x3f, 0xfe, 0x04, 0x07, 0x88, 0x41,
	0xfc, 0x09, 0x00, 0x80, 0x40, 0x20, 0x08, 0x04};
static unsigned int xwbf_width=16;
static unsigned int xwbf_height=8;

static void
xwbf_start()
{
	tpstartup();

	xwbf_bm = XCreateBitmapFromData(Dsp, DefaultRootWindow(Dsp),
		(char*)xwbf_data, xwbf_width, xwbf_height);
	regid(Dsp, (union regtypes *)&xwbf_bm, REG_PIXMAP);

	(void)unlink(outfile(xwbf_name));
}

static void
xwbf_clean()
{
	(void)unlink(filename);
	tpcleanup();
}

>>SET tpstartup xwbf_start
>>SET tpcleanup xwbf_clean
>>ASSERTION Good A
A call to xname writes a
.A bitmap 
to the file
.A filename
in the X version 11 format and returns
.S BitmapSuccess .
>>STRATEGY
Create a suitable bitmap.
Call xname to write the bitmap to file.
Verify that BitmapSucess was returned.
Read back bitmap with XReadBitmapFile.
Verify the bitmap was read back, and the details were correct.
>>CODE
	int ret;
	unsigned int w_ret, h_ret;
	Pixmap pm_ret;
	int x_h_ret, y_h_ret;
	XImage *good;

/* Create a suitable bitmap. */
/* Call xname to write the bitmap to file. */
	ret=XCALL;

/* Verify that BitmapSucess was returned. */
	if (ret != BitmapSuccess) {
		FAIL;
		report("%s did not return expected value.",
			TestName);
		report("Expected: %d (BitmapSuccess)", BitmapSuccess);
		report("Returned: %d", ret); 
	} else
		CHECK;

/* Read back bitmap with XReadBitmapFile. */
	ret=XReadBitmapFile(display, DefaultRootWindow(display),
		outfile(xwbf_name), &w_ret, &h_ret, &pm_ret, &x_h_ret, &y_h_ret);

/* Verify the bitmap was read back, and the details were correct. */
	if (ret != BitmapSuccess) {
		FAIL;
		report("XReadBitmapFile could not read back the bitmap file.");
	} else
		CHECK;

	if (w_ret != 16 || h_ret !=8) {
		FAIL;
		report("Read pixmap had incorrect width/height.");
		report("Expected width:16, height:8");
		report("Returned width:%d, height:%d", w_ret, h_ret);
	} else
		CHECK;

	if (x_h_ret != -1 || y_h_ret != -1) {
		FAIL;
		report("Read pixmap had incorrect hot spot.");
		report("Expected hotspot (x,y): -1,-1");
		report("Returned hotspot (x,y): %d,%d", x_h_ret, y_h_ret);
	} else
		CHECK;

	good=savimage(display, xwbf_bm);
	trace("savimage");
	if (!compsavimage(display, pm_ret, good)) {
		FAIL;
	} else
		CHECK;

	CHECKPASS(5);

>>ASSERTION Good A
When
.A x_hot
and
.A y_hot
are not -1, then a call to xname writes 
.A x_hot
and
.A y_hot
as the hotspot coordinates for the
.A bitmap .
>>STRATEGY
Create a suitable bitmap.
Call xname to write the bitmap to file, with non -1 x_hot and y_hot.
Verify that BitmapSucess was returned.
Read back bitmap with XReadBitmapFile.
Verify the bitmap was read back, and the details were correct.
>>CODE
	int ret;
	unsigned int w_ret, h_ret;
	Pixmap pm_ret;
	int x_h_ret, y_h_ret;
	XImage *good;

/* Create a suitable bitmap. */
/* Call xname to write the bitmap to file, with non -1 x_hoy and y_hot. */
	x_hot = 6;
	y_hot = 3;
	ret=XCALL;

/* Verify that BitmapSucess was returned. */
	if (ret != BitmapSuccess) {
		FAIL;
		report("%s did not return expected value.",
			TestName);
		report("Expected: %d (BitmapSuccess)", BitmapSuccess);
		report("Returned: %d", ret); 
	} else
		CHECK;

/* Read back bitmap with XReadBitmapFile. */
	ret=XReadBitmapFile(display, DefaultRootWindow(display),
		outfile(xwbf_name), &w_ret, &h_ret, &pm_ret, &x_h_ret, &y_h_ret);

/* Verify the bitmap was read back, and the details were correct. */
	if (ret != BitmapSuccess) {
		FAIL;
		report("XReadBitmapFile could not read back the bitmap file.");
	} else
		CHECK;

	if (w_ret != 16 || h_ret !=8) {
		FAIL;
		report("Read pixmap had incorrect width/height.");
		report("Expected width:16, height:8");
		report("Returned width:%d, height:%d", w_ret, h_ret);
	} else
		CHECK;

	if (x_h_ret != 6 || y_h_ret != 3) {
		FAIL;
		report("Read pixmap had incorrect hot spot.");
		report("Expected hotspot (x,y): 6,3");
		report("Returned hotspot (x,y): %d,%d", x_h_ret, y_h_ret);
	} else
		CHECK;

	good=savimage(display, xwbf_bm);
	trace("savimage");
	if (!compsavimage(display, pm_ret, good)) {
		FAIL;
	} else
		CHECK;

	CHECKPASS(5);

>>ASSERTION Bad A
When the file
.A filename
cannot be opened for writing,
then a call to xname returns
.S BitmapOpenFailed .
>>STRATEGY
Create a suitable bitmap.
Create an unwritable directory.
Call xname to write the bitmap file.
Verify that a BitmapOpenFailed error occurred.
>>CODE
int ret;

/* Writing won't fail even if the permissions say it should if we're root. */
	if(geteuid() == 0) {
	    report("File permissions cannot be tested as root.");
	    UNTESTED;
	    return;
	}

/* Create a suitable bitmap. */
/* Create an unwritable directory. */
	if(mkdir(outfile(XWBF_DIR), XWBF_MODE)) {
		int en = errno;
		delete("Could not create the test subdirectory.");
		report("errno %d", en);
		return;
	} else
		CHECK;

/* Call xname to write the bitmap file. */
	filename = outfile(XWBF_FILE);
	ret = XCALL;

/* Verify that a BitmapOpenFailed error occurred. */
	if (ret != BitmapOpenFailed) {
		FAIL;
		report("%s did not return expected value.",
		       TestName);
		report("Expected %d (BitmapOpenFailed)", BitmapOpenFailed);
		report("Returned %d", ret);
	} else
		CHECK;

	CHECKPASS(2);

	unlink(outfile(XWBF_FILE));
	rmdir(outfile(XWBF_DIR));

>>ASSERTION Bad B 1
When insufficient memory is allocated, then a call to xname returns
.S BitmapNoMemory .
>>ASSERTION Bad A
When
.A width
and 
.A height
are greater than the corresponding dimensions of the
.A bitmap ,
then on a call to xname a
.S BadMatch
error occurs.
>>STRATEGY
Create a suitable bitmap.
Call xname to write the bitmap to file, with the width and height
	bigger than the bitmap.
Verify that BadMatch occurred.
>>CODE BadMatch

/* Create a suitable bitmap. */
/* Call xname to write the bitmap to file, with the width and height */
/* 	bigger than the bitmap. */
	width=256;
	height=512;
	XCALL;

/* Verify that BadMatch occurred. */
	if (geterr() != BadMatch) {
		FAIL;
	} else
		CHECK;
	
	CHECKPASS(1);

>>ASSERTION Bad A
>># This may look odd (after all, xname takes a pixmap...) but there is 
>># nothing in the Xlib implementation to stop you passing any old
>># drawable here...	-stuart.
.ER BadDrawable
