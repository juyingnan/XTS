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
>># File: xts5/Xlib16/XrmPutResource/common.mc
>># 
>># Description:
>># 	Tests for XrmPutResource()
>># 
>># Modifications:
>># $Log: common.mc,v $
>># Revision 1.2  2005-11-03 08:42:58  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:21  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:34:17  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:56:33  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:25:37  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:22:09  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:10:09  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:12:25  andy
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

>># shared resource manager test declarations.
>># Used by:
>>#	XrmPutResource
>>#	XrmPutStringResource
>>#	XrmQPutResource
>>#	XrmQPutStringResource

>># include common functions
>>INCLUDE ../XrmPutResource/fn.mc
>>EXTERN

#define XRM_T1_TESTS	4

static char *t1_specifiers[XRM_T1_TESTS] = {
	"opus.hodgepodge.portnoy",
	"calvin*and.hobbes",
	"*The.Far*Side",
	"Cutter.John.was*here" };

static char *qt1_specifiers[XRM_T1_TESTS][5] = {
	{ "opus" , "hodgepodge", "portnoy" , (char *)NULL, (char *)NULL },
	{ "calvin", "and", "hobbes", (char *)NULL, (char *)NULL },
	{ "The", "Far", "Side" , (char *)NULL, (char *)NULL },
	{ "Cutter", "John", "was", "here", (char *)NULL } };

static XrmBinding qt1_bindings[XRM_T1_TESTS][4] = {
	{ XrmBindTightly, XrmBindTightly, XrmBindTightly },
	{ XrmBindTightly, XrmBindLoosely, XrmBindTightly },
	{ XrmBindLoosely, XrmBindTightly, XrmBindLoosely },
	{ XrmBindTightly, XrmBindTightly, XrmBindTightly, XrmBindLoosely } };

static char *t1_fspecs[XRM_T1_TESTS] = {
	"opus.hodgepodge.portnoy",
	"calvin.and.hobbes",
	"the.far.side",
	"cutter.john.was.here" };

static char *t1_fclasses[XRM_T1_TESTS] = {
	"opus.hodgepodge.portnoy",
	"Boy.Thingy0.Tiger",
	"The.Far.Side",
	"Cutter.John.was.here" };

static char *t1_types[XRM_T1_TESTS] = {
	"String",
	"Thing",
	"Ping",
	"Bing" };

static char *t1_values[XRM_T1_TESTS] = {
	"Value One",
	"Value Two",
	"What we say to cats.",
	"NCC-1701a" };

static char *t2_specifiers[2] = {
	"A.b*C",
	"A.b*C" };

static char *qt2_specifier[] = {
	"A", "b", "C", (char *)NULL }; 

static XrmBinding qt2_bindings[] = {
	XrmBindTightly, XrmBindTightly, XrmBindLoosely };

static char *t2_fullspec  = "a.b.c";

static char *t2_fullclass = "A.B.C";

static char *t2_types[2] = {
	"TypeOne",
	"TypeTwo" };

static char *t2_values[2] = {
	"One",
	"Two" };
