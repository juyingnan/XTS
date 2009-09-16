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
>># File: xts5/Xlib17/XCreateImage/XCreateImage.m
>># 
>># Description:
>># 	Tests for XCreateImage()
>># 
>># Modifications:
>># $Log: crtimg.m,v $
>># Revision 1.3  2007-05-14 15:29:46  gwc
>># In test 1 calculate a valid bytes_per_line value for each visual
>>#
>># Revision 1.2  2005/11/03 08:43:03  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:23  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:34:31  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:56:51  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:25:49  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:22:22  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:10:45  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:13:15  andy
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
>>TITLE XCreateImage Xlib17
XImage *
XCreateImage(display, visual, depth, format, offset, data, width, height, bitmap_pad, bytes_per_line)
Display		*display = Dsp;
Visual		*visual;
unsigned int	depth;
int		format;
int		offset;
char		*data;
unsigned int	width;
unsigned int 	height;
int		bitmap_pad;
int		bytes_per_line;
>>EXTERN
int
checkstruct(im, width, height, offset, format, data, bo, bmu, bmbo, bp, dep, bpl, bpp, rm, gm, bm)
XImage		*im;
int		width;
int		height;
int		offset;
int		format;
char		*data;
int		bo;
int		bmu;
int		bmbo;
int		bp;
int		dep;
int		bpl;
int		bpp;
unsigned long	rm;
unsigned long	gm;
unsigned long	bm;
{

	int pass = 0;
	int fail = 0;

	if(im-> width != width ) {
		report("The width component was %d instead of %d.", im->width, width);
		fail++;
	} else
		pass++;

	if(im-> height != height ) {
		report("The height component was %d instead of %d.", im->height, height);
		fail++;
	} else
		pass++;

	if(im-> xoffset != offset ) {
		report("The xoffset component was %d instead of %d.", im->xoffset, offset);
		fail++;
	} else
		pass++;

	if(im-> format != format ) {
		report("The format component was %d instead of %d.", im->format, format);
		fail++;
	} else
		pass++;

	if(im-> data == (char *) NULL) {
		report("The data component was NULL.");
		fail++;
	} else {
		pass++;
		if(strcmp(im->data, data) != 0) {
			report("The data component was incorrectly set.");
			fail++;
		} else
			pass++;
	}

	if(im-> byte_order != bo ) {
		report("The byte_order component was %d instead of %d.", im->byte_order, bo);
		fail++;
	} else
		pass++;

	if(im-> bitmap_unit != bmu ) {
		report("The bitmap_unit component was %d instead of %d.", im->bitmap_unit, bmu);
		fail++;
	} else
		pass++;

	if(im-> bitmap_bit_order != bmbo ) {
		report("The bitmap_bit_order component was %d instead of %d.", im->bitmap_bit_order, bmbo);
		fail++;
	} else
		pass++;

	if(im-> bitmap_pad != bp ) {
		report("The bitmap_pad component was %d instead of %d.", im->bitmap_pad, bp);
		fail++;
	} else
		pass++;

	if(im-> depth != dep) {
		report("The depth component was %d instead of %d.", im->depth, dep);
		fail++;
	} else
		pass++;

	if(im-> bytes_per_line != bpl) {
		report("The bytes_per_line component was %d instead of %d.", im->bytes_per_line, bpl);
		fail++;
	} else
		pass++;

	if(im-> bits_per_pixel != bpp) {
		report("The bits_per_pixel component was %d instead of %d.", im->bits_per_pixel, bpp);
		fail++;
	} else
		pass++;

	if(im-> red_mask != rm ) {
		report("The red_mask component was %lu instead of %lu.", im->red_mask, rm);
		fail++;
	} else
		pass++;

	if(im-> green_mask != gm ) {
		report("The green_mask component was %lu instead of %lu.", im->green_mask, gm);
		fail++;
	} else
		pass++;

	if(im-> blue_mask != bm ) {
		report("The blue_mask component was %lu instead of %lu.", im->blue_mask, bm);
		fail++;
	} else
		pass++;

	if( pass==16 && fail==0 )
		return 1;
	return 0;
}
#define ROUNDUP(nbytes, pad) ((((nbytes) + ((pad) - 1)) / (pad)) * (pad)) /* Courtesy of Xlib */
>>ASSERTION Good A
A call to xname allocates and returns an
.S XImage
structure.
>>STRATEGY
For format XYPixmap and ZPixmap:
   Create an XImage structure using xname.
   Verify that the call did not return NULL.
   Verify that the structure components set from the parameters are set correctly.
>>CODE
XVisualInfo	*vi;
XImage		*im;
int		byteord;
int		bmunit;
int		bmbitord;
int		bmpad;
unsigned long	rm;
unsigned long	gm;
unsigned long	bm;
int			bpp;
int			i;
XPixmapFormatValues	*pv;
XPixmapFormatValues	*f;
int			npv;

	if((pv = XListPixmapFormats(display, &npv)) == (XPixmapFormatValues *) NULL) {
		delete("XListPixmapFormats() returned NULL.");
		return;
	} else
		CHECK;

	byteord  = ImageByteOrder(display);
	bmunit   = BitmapUnit(display);
	bmbitord = BitmapBitOrder(display);
	bmpad    = BitmapPad(display);

	offset = 13;
	data = "SomeTextData";

	width = 10;
	height = 20;
	bitmap_pad = bmpad;

	for(resetvinf(VI_WIN_PIX); nextvinf(&vi);) {
		
		visual = vi->visual;
		depth = vi->depth;
		rm = vi->red_mask;
		gm = vi->green_mask;
		bm = vi->blue_mask;

		bpp = -1;
		for(i=npv, f=pv; i>0; i--,f++)
			if(f->depth == depth) {
				bpp = f->bits_per_pixel;
				break;
			}

		if(bpp == -1) {
			delete("Could not determine the bits_per_pixel component for depth %d.", depth);
			fail++; /* Avoid path checking in CHECKPASS */
			continue;
		} else
			CHECK;

		bytes_per_line = ROUNDUP((bpp * (width+1)), bmpad) >> 3;

		trace("ZPixmap.");
		format = ZPixmap;
		im = XCALL;

		if( im == (XImage *) NULL ) {
			delete("%s() returned NULL.", TestName);
			fail++; /* Avoid path checking in CHECKPASS */
		} else {
			CHECK;


			if(checkstruct(im, width, height, offset, format, data, byteord, bmunit, bmbitord, bitmap_pad, depth, bytes_per_line, bpp, rm, gm, bm) == 0)
				FAIL;
			else
				CHECK;

			im->data = (char *) NULL;
			XDestroyImage(im);
		}

		trace("XYPixmap.");
		format = XYPixmap;
		im = XCALL;

		if( im == (XImage *) NULL ) {
			delete("%s() returned NULL.", TestName);
			fail++; /* Avoid path checking in CHECKPASS */
		} else {
			CHECK;

			if(checkstruct(im, width, height, offset, format, data, byteord, bmunit, bmbitord, bitmap_pad, depth, bytes_per_line, 1, rm, gm, bm) == 0)
				FAIL;
			else
				CHECK;

			im->data = (char *) NULL;
			XDestroyImage(im);
		}
	}


	XFree( (char *) pv);
	CHECKPASS(1 + nvinf() * 5);

>>ASSERTION Good B 1
When sufficient storage cannot be allocated,
then a call to xname returns NULL.
>>ASSERTION Good A
When the
.A bytes_per_line
argument is zero, then scanlines are assumed to be contiguous.
>>STRATEGY
For format XYPixmap and ZPixmap:
   Create an XImage structure using xname with bytes_per_line argument set to zero.
   Verify that the call did not return NULL.
   Verify that the bytes_per_line component of the structure is correct.
>>CODE
XVisualInfo	*vi;
XImage		*im;
int		bmpad;
int		bpl;
int			bpp;
int			i;
XPixmapFormatValues	*pv;
XPixmapFormatValues	*f;
int			npv;

	if((pv = XListPixmapFormats(display, &npv)) == (XPixmapFormatValues *) NULL) {
		delete("XListPixmapFormats() returned NULL.");
		return;
	} else
		CHECK;

	bmpad = BitmapPad(display);
	offset = 0;
	data = (char *) NULL;
	width = 10;
	height = 20;
	bitmap_pad = bmpad;
	bytes_per_line = 0;


	for(resetvinf(VI_WIN_PIX); nextvinf(&vi);) {
		
		visual = vi->visual;
		depth = vi->depth;
		format = ZPixmap;
		im = XCALL;

		if( im == (XImage *) NULL ) {
			delete("%s() returned NULL.", TestName);
			fail++; /* Avoid path checking in CHECKPASS */
		} else {
			CHECK;

			bpp = -1;
			for(i=npv, f=pv; i>0; i--,f++)
				if(f->depth == depth) {
					bpp = f->bits_per_pixel;
					break;
				}

			if(bpp == -1) {
				delete("Could not determine the bits_per_pixel component for depth %d.", depth);
				fail++; /* Avoid path checking in CHECKPASS */
				bpp =depth;
			} else
				CHECK;

			bpl = ROUNDUP((bpp * width), bmpad) >> 3;
			if(im->bytes_per_line != bpl) {
				report("The bytes_per_line component was %d instead of %d.", im->bytes_per_line, bpl);
				FAIL;
			} else
				CHECK;

			XDestroyImage(im);
		}

		format = XYPixmap;
		im = XCALL;

		if( im == (XImage *) NULL ) {
			delete("%s() returned NULL.", TestName);
			fail++; /* Avoid path checking in CHECKPASS */
		} else {
			CHECK;

			bpl =  ROUNDUP((width + offset), bmpad) >> 3;

			if(im->bytes_per_line != bpl) {
				report("The bytes_per_line component was %d instead of %d.", im->bytes_per_line, bpl);
				FAIL;
			} else
				CHECK;

			im->data = (char *) NULL;
			XDestroyImage(im);
		}
	}

	XFree( (char *) pv);
	CHECKPASS(1 + nvinf() * 5);
