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
$Header: /cvs/xtest/xtest/xts5/tset/Xlib14/vcnlist/vcnlist.m,v 1.2 2005-11-03 08:42:46 jmichael Exp $

Copyright (c) Applied Testing and Technology, Inc. 1995
All Rights Reserved.

>># Project: VSW5
>># 
>># File: xts5/tset/Xlib14/vcnlist/vcnlist.m
>># 
>># Description:
>># 	Tests for XVaCreateNestedList()
>># 
>># Modifications:
>># $Log: vcnlist.m,v $
>># Revision 1.2  2005-11-03 08:42:46  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:20  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:39:03  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:02:09  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:30:04  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:26:38  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.1  1998/01/13 20:04:29  andy
>># Test 4 was missing XNVaNestedList argument in call to XVaCreateNestedList.
>>#
>># Revision 4.0  1995/12/15 09:24:19  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:02:08  andy
>># Prepare for GA Release
>>#
/*

Copyright (c) 1993  X Consortium

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
Copyright 1993 by Sun Microsystems, Inc. Mountain View, CA.

                  All Rights Reserved

Permission  to  use,  copy,  modify,  and  distribute   this
software  and  its documentation for any purpose and without
fee is hereby granted, provided that the above copyright no-
tice  appear  in all copies and that both that copyright no-
tice and this permission notice appear in  supporting  docu-
mentation,  and  that the names of Sun or MIT not be used in
advertising or publicity pertaining to distribution  of  the
software  without specific prior written permission. Sun and
M.I.T. make no representations about the suitability of this
software for any purpose. It is provided "as is" without any
express or implied warranty.

SUN DISCLAIMS ALL WARRANTIES WITH REGARD TO  THIS  SOFTWARE,
INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FIT-
NESS FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL SUN BE  LI-
ABLE  FOR  ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR
ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE,  DATA  OR
PROFITS,  WHETHER  IN  AN  ACTION OF CONTRACT, NEGLIGENCE OR
OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION  WITH
THE USE OR PERFORMANCE OF THIS SOFTWARE.
*/
>>EXTERN
#include <locale.h>
#include <ximtest.h>

/* Stuff from SetICValues */
typedef struct {
	int cnt;
	char *name;
	union ICV *val;
	XVaNestedList va;
	struct ICL *list;
} att_def;

typedef union ICV {
	Window win;
	XIMStyle style;
	char str[256];	
	XRectangle rect;
	XPoint pt;
	Colormap cmap;
	Pixmap pmap;
	XFontSet fs;
	unsigned long val_long;
	int val_int;
	Cursor cur;
	XIMCallback cb; 
	att_def att;
	Atom atom;
} ic_val_def;

typedef struct ICL {
	char *name;
	int type;
#define ICV_WINDOW		0
#define ICV_STYLE		1
#define ICV_STR			2
#define ICV_RECT		3
#define ICV_PT			4
#define ICV_CMAP		5
#define ICV_PMAP		6
#define	ICV_LONG		7
#define ICV_FS			8
#define ICV_INT			9
#define ICV_CURSOR		10	
#define ICV_CB			11	
#define ICV_ATT			12
#define ICV_ATOM		13
	ic_val_def *val;
	unsigned int style_mask;
} ic_list_def;

>>TITLE XVaCreateNestedList Xlib14
XVaNestedList

int dummy;
int endlist=0;
>>SET startup localestartup
>>SET cleanup localecleanup
>>EXTERN
static Bool
check_val(type,name,base_val,return_val)
int type;
char *name;
ic_val_def *base_val;
ic_val_def *return_val;
{
	/* check the base_value returned in ic_base_val */
	switch(type)
	{
		case ICV_WINDOW:
			if(return_val->win != base_val->win)
			{
				report("Returned value does not match expected value for %s",name);
				report("     returned 0x%x",return_val->win);
				report("     expected 0x%x",base_val->win);
				return(False);
			}
			break;
		case ICV_STYLE:
			if(return_val->style != base_val->style)
			{
				report("Returned value does not match expected value for %s",name);
				report("     returned 0x%x",return_val->style);
				report("     expected 0x%x",base_val->style);
				return(False);
			}
			break;
		case ICV_STR:
			if(strcmp(return_val->str,base_val->str) != 0)
			{
				report("Returned value does not match expected value for %s",name);
				report("     returned %s",return_val->str);
				report("     expected %s",base_val->str);
				return(False);
			}
			break;
		case ICV_RECT:
			if((return_val->rect.x != base_val->rect.x) ||
			   (return_val->rect.y != base_val->rect.y) ||
			   (return_val->rect.width != base_val->rect.width) ||
			   (return_val->rect.height != base_val->rect.height))
			{
				report("Returned value does not match expected value for %s",name);
				report("     returned (%d,%d) (%d,%d)",
					return_val->rect.x,
					return_val->rect.y,
					return_val->rect.width, 
					return_val->rect.height);
				report("     expected (%d,%d) (%d,%d)",
					base_val->rect.x, 
					base_val->rect.y,
					base_val->rect.width, 
					base_val->rect.height);
				return(False);
			}
			break;
		case ICV_PT:
			if((return_val->pt.x != base_val->pt.x) ||
			   (return_val->pt.y != base_val->pt.y))
			{
				report("Returned value does not match expected value for %s",name);
				report("     returned (%d,%d)",
					return_val->pt.x,return_val->pt.y);
				report("     expected (%d,%d)",
					base_val->pt.x,base_val->pt.y);
				return(False);
			}
			break;
		case ICV_CMAP:
			if(return_val->cmap != base_val->cmap)
			{
				report("Returned value does not match expected value for %s",name);
				report("     returned 0x%x",return_val->cmap);
				report("     expected 0x%x",base_val->cmap);
				return(False);
			}
			break;
		case ICV_LONG:
			if(return_val->val_long != base_val->val_long)
			{
				report("Returned value does not match expected value for %s",name);
				report("     returned %d",return_val->val_long);
				report("     expected %d",base_val->val_long);
				return(False);
			}
			break;
		case ICV_ATOM:
			if(return_val->atom != base_val->atom)
			{
				report("Returned value does not match expected value for %s",name);
				report("     returned %d",return_val->atom);
				report("     expected %d",base_val->atom);
				return(False);
			}
			break;
		case ICV_PMAP:
			if(return_val->pmap != base_val->pmap)
			{
				report("Returned value does not match expected value for %s",name);
				report("     returned 0x%x",return_val->pmap);
				report("     expected 0x%x",base_val->pmap);
				return(False);
			}
			break;
		case ICV_FS:
			if(return_val->fs != base_val->fs)
			{
				report("Returned value does not match expected value for %s",name);
				report("     returned 0x%x",return_val->fs);
				report("     expected 0x%x",base_val->fs);
				return(False);
			}
			break;
		case ICV_INT:
			if(return_val->val_int != base_val->val_int)
			{
				report("Returned value does not match expected value for %s",name);
				report("     returned %d",return_val->val_int);
				report("     expected %d",base_val->val_int);
				return(False);
			}
			break;
		case ICV_CURSOR:
			if(return_val->cur != base_val->cur)
			{
				report("Returned base_value for %s, 0x%x does not match expected base_value 0x%x",
					name,return_val->cur,base_val->cur);
				return(False);
			}
			break;
		case ICV_CB:
			if((return_val->cb.callback != base_val->cb.callback) ||
			   (return_val->cb.client_data != base_val->cb.client_data))
			{
				report("Returned value does not match expected value for %s",name);
				report("     returned (0x%x,%c)",
					return_val->cb.callback,
					return_val->cb.client_data);
				report("     expected (0x%x,%c)",
					base_val->cb.callback,
					base_val->cb.client_data);
				return(False);
			}
			break;
		case ICV_ATT:
			report("Programming error in test: should get type attribute");
			return(False);
		default:
			report("Unknown IC value type");
			return(False);
	}
	return(True);
}

 
static Window win;
static XIMStyle which_style;
Colormap cmap = None;
static Pixmap pmap = None;
static char rname[] = "im_rname";
static char rclass[] = "IM_rclass";
static unsigned long fg = 1L;
static unsigned long bg = 0L;
static XRectangle area = {0, 0, 20, 20};
static XRectangle area_needed = {0, 10, 50, 20};
static XPoint spot = {20, 11};
static unsigned long filter = 5;
static int linesp = 7;
static Cursor cur = None;

static att_def pe_att;
static att_def st_att;

#define ICCB_START	0
#define ICCB_DONE	1
#define ICCB_DRAW	2
#define ICCB_CARET	3
#define ICCB_MAX	4

static XIMCallback cbp[ICCB_MAX];
static XIMCallback cbs[ICCB_MAX];
static XIMCallback geom;

#define PE_NONE 0
#define PE_A	XIMPreeditArea 
#define PE_CB	XIMPreeditCallbacks
#define PE_POS	XIMPreeditPosition
#define PE_NOT	XIMPreeditPosition
#define PE_N	XIMPreeditNone
#define PE_STD  PE_POS | PE_A | PE_NOT
#define PE_MOST	PE_A | PE_CB | PE_POS | PE_NOT
#define PE_ALL	PE_A | PE_CB | PE_POS | PE_NOT | PE_N

#define S_NONE	0
#define S_A		XIMStatusArea
#define	S_CB	XIMStatusCallbacks
#define S_NOT	XIMStatusNothing
#define S_N		XIMStatusNone
#define S_STD   S_A | S_NOT
#define S_MOST	S_A | S_CB | S_NOT 
#define S_ALL	S_A | S_CB | S_NOT | S_N

#define IM_MOST	PE_MOST | S_MOST
#define IM_STD 	PE_STD | S_STD 
#define IM_ALL	PE_ALL | S_ALL
#define IM_NONE	PE_NONE | S_NONE

static ic_list_def status_list[] = {
	{ XNArea,ICV_RECT,(ic_val_def *)&area,S_A},
	{ XNAreaNeeded,ICV_RECT,(ic_val_def *)&area,S_A },
	{ XNColormap,ICV_CMAP,(ic_val_def *)&cmap,S_A},
	{ XNForeground,ICV_LONG,(ic_val_def *)&fg,S_STD},
	{ XNBackground,ICV_LONG,(ic_val_def *)&bg,S_STD},
	{ XNBackgroundPixmap,ICV_PMAP,(ic_val_def *)&pmap,S_A},
	{ XNLineSpace,ICV_INT,(ic_val_def *)&linesp,S_A},
	{ XNCursor,ICV_CURSOR,(ic_val_def *)&cur,S_A},
	{ XNStatusStartCallback,ICV_CB,(ic_val_def *)&cbs[ICCB_START],S_CB},
	{ XNStatusDoneCallback,ICV_CB,(ic_val_def *)&cbs[ICCB_DONE],S_CB},
	{ XNStatusDrawCallback,ICV_CB,(ic_val_def *)&cbs[ICCB_DRAW],S_CB},
};

>>ASSERTION Good C 
If the implementation is X11R5 or later:
A call to xname shall build and return a pairwise list of parameters from an
variable length list.
>>STRATEGY
For all locales, build an empty variable list, verify that it is null.
>>CODE
#if XT_X_RELEASE > 4
char *plocale;
XVaNestedList va;
#endif

#if XT_X_RELEASE > 4

	resetlocale();
	while(nextlocale(&plocale))
	{

		if (locale_set(plocale))
			CHECK;
		else
		{
			report("Couldn't set locale.");
			FAIL;
			continue;
		}

		va = XCALL;
		if(va == NULL)
			CHECK;
		else
		{
			report("%s() created a non-null nested list from no arguments",
				TestName);
			FAIL;
		}
		if(va != NULL)
			XFree(va);
	}   /* nextlocale */

	CHECKPASS(2*nlocales());
#else

	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif

>>ASSERTION Good C 
If the implementation is X11R5 or later:
A call to xname shall build and return a pair wise list of parameters from 
an variable length list.
>>STRATEGY
For all locales, build a variable list of one element, 
verify that a nested list is returned. 
>>CODE
#if XT_X_RELEASE > 4
char cmd[32];
int a1,cnt,tmp;
char *plocale;
XVaNestedList va;
char *p;
int *pi;
/* SetICValues stuff */
char 		*ic_name1, *ic_name2, *ic_name3;
XIC ic;
char *ic_name;
ic_val_def *ic_val;
int endlist = 0;
Display *dpy;
XIM im = NULL;
XFontSet fs = NULL;
XrmDatabase db = NULL;
char *pstr;
ic_val_def icv,*picv,*ret_icv;
int nstyles = 0;
int ncheck = 0;
ic_list_def *ils;
int type,dummy;
att_def *att,ret_att;
char name_sub[128];
char name[128];
int *val;
#endif

#if XT_X_RELEASE > 4

	dpy = Dsp;
	ic_get_cb(cbp,cbs,&geom);

	st_att.cnt = sizeof(status_list) / sizeof(ic_list_def);
	st_att.list = (ic_list_def *)status_list;

	tet_infoline("TEST: XVaCreateNestedList succeeds with one member");
	resetlocale();
	while (nextlocale(&plocale))
	{
		if (locale_set(plocale))
			CHECK;
		else
		{
			report("Couldn't set locale.");
			FAIL;
			continue;
		}

		cleanup_locale(NULL,fs,im,db);

		db = rm_db_open();
		if(db != NULL)
			CHECK;
		else
		{
			report("Couldn't open database.");
			FAIL;
			continue;
		}

		im = im_open(db);
		if(im != NULL)
			CHECK;
		else
		{
			report("Couldn't open input method.");
			FAIL;
			continue;
		}

		if(ic_setup(&win,&fs))
			CHECK;
		else
		{
			report("Couldn't setup input styles.");
			FAIL;
			continue;
		}

		/* get the input styles */
		reset_ic_style(im);
		nstyles += n_ic_styles();

		while (next_ic_style(&which_style))
		{
			int j;

			ic = ic_open(im,win,which_style);
			if(ic != NULL)
					CHECK;
				else
			{
				report("Unable to create input context for locale, %s",
					plocale);
					FAIL;
				continue;
			}
	 
			strcpy(name,XNStatusAttributes);
	 
			/* loop through all the IC values, fetching them */
			att = (att_def *)&st_att;
			for(j=0; j<att->cnt; j++)
			{
				ils = (ic_list_def *)&att->list[j];
				if (!(ils->style_mask & which_style))
					continue;
					ncheck++;

				if(ils->type == ICV_LONG	|| 
				   ils->type == ICV_ATOM	||
				   ils->type == ICV_WINDOW	||
				   ils->type == ICV_INT)
				{
					val = (int*)ils->val;
					att->va = 
					  XVaCreateNestedList(dummy,ils->name,*val,NULL);
				}
				else
					att->va = 
					  XVaCreateNestedList(dummy,ils->name,ils->val,NULL);
				ic_name = name;
				ic_val = (ic_val_def *)att->va;

				pstr = XSetICValues(ic, ic_name, 
						    ic_val, endlist);
				if(pstr != NULL && *pstr != '\0')
				{
					report("%s() returns non-null result, %s",
						"XSetICValues",pstr);	
					FAIL;
				}
				else
				{
					/* fetch the values */
					ret_icv = &icv;
					ret_att.va = XVaCreateNestedList(dummy,ils->name,&ret_icv,NULL);
					pstr = XGetICValues(ic,ic_name,ret_att.va,NULL);
					if(pstr != NULL && *pstr != '\0')
					{
						report("XGetICValues returns non-null result, %s",
							pstr);	
						FAIL;
					}
					trace("%s",ils->name);

					if(ils->type == ICV_STR		||
					   ils->type == ICV_PT		||
					   ils->type == ICV_RECT	||
					   ils->type == ICV_CMAP	|| 
					   ils->type == ICV_PMAP	||
					   ils->type == ICV_CURSOR	||
					   ils->type == ICV_CB)
						picv = ret_icv;
					else
						picv = (ic_val_def *)&ret_icv;

					if(picv == NULL)
					{
						report("XGetICValues returns null value for %s",
							ic_name);
						FAIL;
					}
					else
					{
						if(check_val(ils->type,ils->name,ils->val,picv))
							CHECK;
						else
							FAIL;
					}
				}
			}
			ic_close(ic);
		}
	}   /* nextlocale */
 	cleanup_locale(NULL,fs,im,db);

	CHECKPASS(4*nlocales()+nstyles+ncheck);
#else

	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif

>>ASSERTION Good C 
If the implementation is X11R5 or later:
A call to xname shall build and return a list of parameters from an variable
length list.
>>STRATEGY
For all locales, build a variable list of two elements, 
verify that a nested list is returned. 
>>CODE
#if XT_X_RELEASE > 4
char cmd[2][32];
int a[2],cnt;
char *plocale;
XVaNestedList va;
char *p;
int *pi;
int j,tmp;
/* SetICValues stuff */
XIC ic;
char *ic_name;
ic_val_def 	*ic_val;
char 		*ic_name1, *ic_name2;
ic_val_def 	icv1, icv2, *picv, *ret_icv1, *ret_icv2;
int endlist = 0;
Display *dpy;
XIM im = NULL;
XFontSet fs = NULL;
XrmDatabase db = NULL;
char *pstr;
ic_val_def icv,*ret_icv;
int nstyles = 0;
int ncheck = 0;
ic_list_def *ils;
int type, dummy;
att_def *att, ret_att;
char name_sub[128];
char name[128];
int 		*val, *val1, *val2;
int		index1, index2;
ic_val_def 	ic_val1, ic_val2, ic_val3;
#endif

#if XT_X_RELEASE > 4

	dpy = Dsp;
	ic_get_cb(cbp,cbs,&geom);

	st_att.cnt = sizeof(status_list) / sizeof(ic_list_def);
	st_att.list = (ic_list_def *)status_list;

	tet_infoline("TEST: XVaCreateNestedList succeeds with two members");
	resetlocale();
	while (nextlocale(&plocale))
	{
		if (locale_set(plocale))
			CHECK;
		else
		{
			report("Couldn't set locale.");
			FAIL;
			continue;
		}

		cleanup_locale(NULL,fs,im,db);

		db = rm_db_open();
		if(db != NULL)
			CHECK;
		else
		{
			report("Couldn't open database.");
			FAIL;
			continue;
		}

		im = im_open(db);
		if(im != NULL)
			CHECK;
		else
		{
			report("Couldn't open input method.");
			FAIL;
			continue;
		}

		if(ic_setup(&win,&fs))
			CHECK;
		else
		{
			report("Couldn't setup input styles.");
			FAIL;
			continue;
		}

		/* get the input styles */
		reset_ic_style(im);
		nstyles += n_ic_styles();

		while (next_ic_style(&which_style))
		{
			int k, j;

			ic = ic_open(im, win, which_style);
			if(ic != NULL)
				CHECK;
			else
			{
				report("Unable to create input context for locale, %s",
					plocale);
				FAIL;
				continue;
			}
	 
			strcpy(name, XNStatusAttributes);
	 
			/* loop through all the IC values, fetching them */
			att = (att_def *)&st_att;
			for(j=0; j<att->cnt; j++)
			{
				ils = (ic_list_def *)&att->list[j];
				if (!(ils->style_mask & which_style))
					continue;
				ncheck++;

				if (ncheck == 1)
				{
					if(ils->type == ICV_LONG	|| 
				   	ils->type == ICV_ATOM	||
				   	ils->type == ICV_WINDOW	||
				   	ils->type == ICV_INT)
					{
						val = (int*)ils->val;
						val1 = (int *)*val;
					}
					else
						val1 = (int*)ils->val;
					ic_name1 = ils->name;
					index1 = j;
				}
				else if (ncheck == 2)
				{
					if(ils->type == ICV_LONG	|| 
				   	ils->type == ICV_ATOM	||
				   	ils->type == ICV_WINDOW	||
				   	ils->type == ICV_INT)
					{
						val = (int*)ils->val;
						val2 = (int *)*val;
					}
					else
						val2 = (int*)ils->val;
					ic_name2 = ils->name;
					index2 = j;
				}
				ic_name = name;
			}
			
			if (ncheck >= 2)
			{
			 	att->va = XVaCreateNestedList(dummy, ic_name1, val1, ic_name2, val2, NULL);
				ic_val = (ic_val_def *)att->va;
				ic_name = name;

				pstr = XSetICValues(ic, ic_name, ic_val, endlist);
				if(pstr != NULL && *pstr != '\0')
				{
					report("%s() returns non-null result, %s",
					"XSetICValues",pstr);	
					FAIL;
				}
				else
				{
					for(k=0; k<2; k++)
					{
						if (k == 0)
						{
							ils = (ic_list_def *)&att->list[index1];
							if (!(ils->style_mask & which_style))
								continue;
						}
						else if (k == 1)
						{
							ils = (ic_list_def *)&att->list[index2];
							if (!(ils->style_mask & which_style))
								continue;
						}
						/* fetch the values */
						ret_icv = &icv;
						ret_att.va = XVaCreateNestedList(dummy,ils->name,&ret_icv,NULL);
						pstr = XGetICValues(ic,ic_name,ret_att.va,NULL);
						if(pstr != NULL && *pstr != '\0')
						{
							report("XGetICValues returns non-null result, %s",
								pstr);	
							FAIL;
						}
						trace("%s",ils->name);

						if(ils->type == ICV_STR		||
						   ils->type == ICV_PT		||
						   ils->type == ICV_RECT	||
						   ils->type == ICV_CMAP	|| 
						   ils->type == ICV_PMAP	||
						   ils->type == ICV_CURSOR	||
						   ils->type == ICV_CB)
							picv = ret_icv;
						else
							picv = (ic_val_def *)&ret_icv;

						if(picv == NULL)
						{
							report("XGetICValues returns null value for %s",
								ic_name);
							FAIL;
						}
						else
						{
							if(check_val(ils->type,ils->name,ils->val,picv))
								;
							else
								FAIL;
						}
					}
				}
			}
			ic_close(ic);
		}
	}   /* nextlocale */
 	cleanup_locale(NULL,fs,im,db);

	CHECKPASS(4*nlocales()+nstyles);
#else

	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif


>>ASSERTION Good C 
If the implementation is X11R5 or later:
A call to xname shall build and return a list of parameters from an variable
length list.
>>STRATEGY
For all locales, build a variable list of one element, and use this
argument as a parameter to a second nested list, verify that a nested 
list is returned. 
>>CODE
#if XT_X_RELEASE > 4
int a1,cnt;
char *plocale;
XVaNestedList va,va2;
char cmd[32];
char va_cmd[32];
char *p;
int *pi;
int tmp;
/* SetICValues stuff */
XIC ic;
char *ic_name;
ic_val_def 	*ic_val;
char 		*ic_name1, *ic_name2;
ic_val_def 	icv1, icv2, *picv, *ret_icv1, *ret_icv2;
int endlist = 0;
Display *dpy;
XIM im = NULL;
XFontSet fs = NULL;
XrmDatabase db = NULL;
char *pstr;
ic_val_def icv,*ret_icv;
int nstyles = 0;
int ncheck = 0;
ic_list_def *ils;
int type, dummy;
att_def 	*att, *att1, ret_att;
char name_sub[128];
char 	name[128];
int 		*val, *val1, *val2;
int		index1, index2;
ic_val_def 	ic_val1, ic_val2, ic_val3;
XVaNestedList	va_temp;
#endif

#if XT_X_RELEASE > 4

	dpy = Dsp;
	ic_get_cb(cbp,cbs,&geom);

	st_att.cnt = sizeof(status_list) / sizeof(ic_list_def);
	st_att.list = (ic_list_def *)status_list;

	tet_infoline("TEST: XVaCreateNestedList succeeds with a VaNestedList as parameter");
	resetlocale();
	while (nextlocale(&plocale))
	{
		if (locale_set(plocale))
			CHECK;
		else
		{
			report("Couldn't set locale.");
			FAIL;
			continue;
		}

		cleanup_locale(NULL,fs,im,db);

		db = rm_db_open();
		if(db != NULL)
			CHECK;
		else
		{
			report("Couldn't open database.");
			FAIL;
			continue;
		}

		im = im_open(db);
		if(im != NULL)
			CHECK;
		else
		{
			report("Couldn't open input method.");
			FAIL;
			continue;
		}

		if(ic_setup(&win,&fs))
			CHECK;
		else
		{
			report("Couldn't setup input styles.");
			FAIL;
			continue;
		}

		/* get the input styles */
		reset_ic_style(im);
		nstyles += n_ic_styles();

		while (next_ic_style(&which_style))
		{
			int k, j;

			ic = ic_open(im, win, which_style);
			if(ic != NULL)
				CHECK;
			else
			{
				report("Unable to create input context for locale, %s",
					plocale);
				FAIL;
				continue;
			}
	 
			strcpy(name, XNStatusAttributes);
	 
			/* loop through all the IC values, fetching them */
			att = (att_def *)&st_att;
			for(j=0; j<att->cnt; j++)
			{
				ils = (ic_list_def *)&att->list[j];
				if (!(ils->style_mask & which_style))
					continue;
				ncheck++;

				if (ncheck == 1)
				{
					if(ils->type == ICV_LONG	|| 
				   	ils->type == ICV_ATOM	||
				   	ils->type == ICV_WINDOW	||
				   	ils->type == ICV_INT)
					{
						val = (int*)ils->val;
						val1 = (int *)*val;
					}
					else
						val1 = (int*)ils->val;
					ic_name1 = ils->name;
					index1 = j;
				}
				else if (ncheck == 2)
				{
					if(ils->type == ICV_LONG	|| 
				   	ils->type == ICV_ATOM	||
				   	ils->type == ICV_WINDOW	||
				   	ils->type == ICV_INT)
					{
						val = (int*)ils->val;
						val2 = (int *)*val;
					}
					else
						val2 = (int*)ils->val;
					ic_name2 = ils->name;
					index2 = j;
				}
				ic_name = name;
			}
			
			if (ncheck >= 2)
			{
			 	va_temp = XVaCreateNestedList(dummy, ic_name1, val1, NULL);
			 	att->va = XVaCreateNestedList(dummy, XNVaNestedList, (char *)va_temp, ic_name2, val2, NULL);
				ic_val = (ic_val_def *)att->va;
				ic_name = name;

				pstr = XSetICValues(ic, ic_name, ic_val, endlist);
				if(pstr != NULL && *pstr != '\0')
				{
					report("%s() returns non-null result, %s",
					"XSetICValues",pstr);	
					FAIL;
				}
				else
				{
tet_infoline("4");
					for(k=0; k<2; k++)
					{
						if (k == 0)
						{
							ils = (ic_list_def *)&att->list[index1];
							if (!(ils->style_mask & which_style))
								continue;
						}
						else if (k == 1)
						{
							ils = (ic_list_def *)&att->list[index2];
							if (!(ils->style_mask & which_style))
								continue;
						}
tet_infoline("5");
						/* fetch the values */
						ret_icv = &icv;
						ret_att.va = XVaCreateNestedList(dummy,ils->name,&ret_icv,NULL);
						pstr = XGetICValues(ic,ic_name,ret_att.va,NULL);
						if(pstr != NULL && *pstr != '\0')
						{
							report("XGetICValues returns non-null result, %s",
								pstr);	
							FAIL;
						}
						trace("%s",ils->name);

						if(ils->type == ICV_STR		||
						   ils->type == ICV_PT		||
						   ils->type == ICV_RECT	||
						   ils->type == ICV_CMAP	|| 
						   ils->type == ICV_PMAP	||
						   ils->type == ICV_CURSOR	||
						   ils->type == ICV_CB)
							picv = ret_icv;
						else
							picv = (ic_val_def *)&ret_icv;

						if(picv == NULL)
						{
							report("XGetICValues returns null value for %s",
								ic_name);
							FAIL;
						}
						else
						{
							if(check_val(ils->type,ils->name,ils->val,picv))
								;
							else
								FAIL;
						}
					}
				}
			}
			ic_close(ic);
		}
	}   /* nextlocale */
 	cleanup_locale(NULL,fs,im,db);

	CHECKPASS(4*nlocales()+nstyles);
#else

	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif
