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
>># File: xts5/XI/dvcbll/dvcbll.m
>># 
>># Description:
>># 	Tests for XDeviceBell()
>># 
>># Modifications:
>># $Log: dvbell.m,v $
>># Revision 1.2  2005-11-03 08:42:05  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:13  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:31:56  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:52:03  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:23:30  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:20:03  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:03:32  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:01:26  andy
>># Prepare for GA Release
>>#
/*
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

Copyright 1993 by the Hewlett-Packard Company.

Copyright 1990, 1991 UniSoft Group Limited.

Permission to use, copy, modify, distribute, and sell this software and
its documentation for any purpose is hereby granted without fee,
provided that the above copyright notice appear in all copies and that
both that copyright notice and this permission notice appear in
supporting documentation, and that the names of HP, and UniSoft not be
used in advertising or publicity pertaining to distribution of the
software without specific, written prior permission.  HP, and UniSoft
make no representations about the suitability of this software for any
purpose.  It is provided "as is" without express or implied warranty.
*/
>>TITLE XDeviceBell XI
void

Display	*display = Dsp;
XDevice *device;
XID feedbackclass=KbdFeedbackClass;
XID feedbackid;
int percent = 100;
>>EXTERN
extern ExtDeviceInfo Devs;


>>ASSERTION Good D 1
If it is possible to ring a bell on the	display:  When	the
percent	argument  is negative, then the volume at which the
bell rings, where base is the base volume of  the  bell,  is
base + [(base*percent)/100].

>>ASSERTION Good D 1
If it is possible to ring a bell on the	display:  When	the
percent	argument  is  nonnegative, then the volume at which
the bell rings, where base is the base volume of  the  bell,
is base - [(base*percent)/100] + percent.
>>STRATEGY
Touch test.
>>CODE

	if (!Setup_Extension_DeviceInfo(KeyMask))
	    {
	    untested("%s: No input extension key device.\n", TestName);
	    return;
	    }
	device = Devs.Key;
	feedbackclass = KbdFeedbackClass;
	percent = 100;
	feedbackid = 0;
	XCALL;
	if (geterr() == Success)
		CHECK;
	else
		FAIL;

	percent = -100;
	XCALL;
	if (geterr() == Success)
		CHECK;
	else
		FAIL;
	CHECKPASS(2);
>>ASSERTION Bad B 3
A call to xname will fail with a BadValue error if a percent value greater
than 100 or less than -100 is specified.
>>STRATEGY
Make the call with an invalid percent value.
Verify that a BadValue error occurs.
>>CODE BadValue

	if (!Setup_Extension_DeviceInfo(KeyMask))
	    {
	    untested("%s: No input extension key device.\n", TestName);
	    return;
	    }
	device = Devs.Key;
	percent = -101;
	XCALL;
	if (geterr() == BadValue)
		CHECK;
	else
		FAIL;
	percent = 101;
	XCALL;
	if (geterr() == BadValue)
		CHECK;
	else
		FAIL;
	CHECKPASS(2);
>>ASSERTION Bad B 3
A call to xname will fail with a BadValue error if an invalid feedback
class is specified.
>>STRATEGY
Make the call with an invalid feedback class.
>>CODE BadValue

	if (!Setup_Extension_DeviceInfo(KeyMask))
	    {
	    untested("%s: No input extension key device.\n", TestName);
	    return;
	    }
	device = Devs.Key;
	feedbackclass = StringFeedbackClass;
	percent = 100;
	XCALL;
	if (geterr() == BadValue)
		PASS;
	else
		FAIL;
>>ASSERTION Bad B 3
A call to xname will fail with a BadValue error if an invalid feedback
id is specified.
>>STRATEGY
Make the call with an invalid feedback id.
>>CODE BadValue

	if (!Setup_Extension_DeviceInfo(KeyMask))
	    {
	    untested("%s: No input extension key device.\n", TestName);
	    return;
	    }
	device = Devs.Key;
	feedbackclass = KbdFeedbackClass;
	percent = 100;
	feedbackid = 254;
	XCALL;
	if (geterr() == BadValue)
		CHECK;
	else
		FAIL;

	feedbackclass = BellFeedbackClass;
	XCALL;
	if (geterr() == BadValue)
		CHECK;
	else
		FAIL;
	CHECKPASS(2);
>>ASSERTION Bad B 3
A call to xname will fail with a BadDevice error if an invalid device
is specified.
>>STRATEGY
Make the call with an invalid device.
>>CODE baddevice
XDevice nodevice;
int baddevice;
int ximajor, first, err;

	if (!XQueryExtension (display, INAME, &ximajor, &first, &err))
	    {
	    untested("%s: Input extension not supported.\n", TestName);
	    return;
	    }

	BadDevice (display, baddevice);
	nodevice.device_id = -1;
	device = &nodevice;

	XCALL;

	if (geterr() == baddevice)
		PASS;
	else
		FAIL;
