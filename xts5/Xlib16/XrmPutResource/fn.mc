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
>># File: xts5/tset/Xlib16/XrmPutResource/fn.mc
>># 
>># Description:
>># 	Tests for XrmPutResource()
>># 
>># Modifications:
>># $Log: fn.mc,v $
>># Revision 1.3  2005-11-03 08:42:58  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.2  2005/04/15 14:37:14  anderson
>># Merge baseline changes
>>#
>># Revision 1.1  2005/02/12 14:37:27  anderson
>># Initial revision
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
>># Revision 5.0  1998/01/26 03:22:10  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:10:10  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:12:27  andy
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

>># resource manager test common functions
>># Used by:
>>#	XrmPutLineResource
>>#	XrmPutResource
>>#	XrmQPutResource
>>#	XrmPutStringResource
>>#	XrmQPutStringResource
>>#	XrmGetResource
>>#	XrmQGetResource
>>#	XrmMergeDatabases
>>#	XrmDestroyDatabase
>>#	XrmGetFileDatabase
>>#	XrmGetStringDatabase
>>#	XrmPutFileDatabase

>>EXTERN

static XrmDatabase
xrm_create_database(data)
char *data;
{
	/* Create a new database for testing with */
	return(XrmGetStringDatabase(data));
}

static void
xrm_fill_value(value, data)
XrmValue *value;
char *data;
{
	value->addr = (caddr_t)data;
	value->size = (unsigned int)(strlen(data)+1);
}

static int
xrm_check_entry(dbase, fullspec, fullclass, type, val)
XrmDatabase dbase;
char *fullspec;
char *fullclass;
char *type;
char *val;
{
	int ret_val;
	char	*type_ret;
	XrmValue	value_ret;

	ret_val=0;
	type_ret=(char *)NULL;
	value_ret.size=0;
	value_ret.addr=(caddr_t)NULL;

	if(XrmGetResource(dbase, fullspec, fullclass, &type_ret, &value_ret)
		==False) {
		report("XrmGetResource failed to find database entry");
		report("Specifier was: %s", fullspec);
		ret_val++;
	} else {
		if (type_ret==NULL || strcmp(type_ret, type)) {
			report("XrmGetResource returned unexpected type information.");
			report("Specifier was: %s", fullspec);
			report("Expected type: '%s'", type);
			report("Returned type: '%s'",
				(type_ret==NULL)?"<NULL POINTER>":type_ret);
			ret_val++;
		}

		if (( value_ret.addr==(caddr_t)NULL)
			|| (strncmp((char *)value_ret.addr, val, strlen(val)))) {
			report("XrmGetResource returned unexpected value information.");
			report("Specifier was: %s", fullspec);
			report("Expected value: '%s'", val);
			if(value_ret.addr == (caddr_t)NULL) {
				report("Returned value: <NULL POINTER>");
			} else {
				report("Returned value: '%.*s' (%u bytes)",
					value_ret.size, (char *)value_ret.addr, value_ret.size);
			}
			ret_val++;
		}
	}

	return(ret_val);
}

static int
xrm_tabulate(from, into)
char *from, *into;
{
	int i,j;

	j = strlen(from);
	for(i=0; i<j; i++) {
		if(from[i]=='T') {
			into[i]='\t';
		} else {
			into[i]=from[i];
		}
	}
	return(j);
}
