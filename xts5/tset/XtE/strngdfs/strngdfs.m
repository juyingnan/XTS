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
$Header: /cvs/xtest/xtest/xts5/tset/XtE/strngdfs/strngdfs.m,v 1.1 2005-02-12 14:38:25 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
All Rights Reserved.

>># 
>># Project: VSW5
>># 
>># File: tset/XtE/strngdfs/strngdfs.m
>># 
>># Description:
>>#	Tests for StringDefs.h contents
>># 
>># Modifications:
>># $Log: strngdfs.m,v $
>># Revision 1.1  2005-02-12 14:38:25  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:36:14  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:59:03  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:27:26  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:23:59  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:15:34  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:19:14  andy
>># Prepare for GA Release
>>#
>>EXTERN
>>TITLE StringDefs.h XtE
>>ASSERTION Good A
The header file StringDefs.h shall contain the definitions
specified in Appendix E of the Specification.
>>CODE

#ifndef XtNaccelerators
	tet_infoline("String \"XtNaccelerators\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNaccelerators, "accelerators") != 0) {
		sprintf(ebuf, "ERROR: XtNaccelerators should be \"accelerators\", is \"%s\"", XtNaccelerators);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNallowHoriz
	tet_infoline("String \"XtNallowHoriz\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNallowHoriz, "allowHoriz") != 0) {
		sprintf(ebuf, "ERROR: XtNallowHoriz should be \"allowHoriz\", is \"%s\"", XtNallowHoriz);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNallowVert
	tet_infoline("String \"XtNallowVert\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNallowVert, "allowVert") != 0) {
		sprintf(ebuf, "ERROR: XtNallowVert should be \"allowVert\", is \"%s\"", XtNallowVert);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNancestorSensitive
	tet_infoline("String \"XtNancestorSensitive\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNancestorSensitive, "ancestorSensitive") != 0) {
		sprintf(ebuf, "ERROR: XtNancestorSensitive should be \"ancestorSensitive\", is \"%s\"", XtNancestorSensitive);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNbackground
	tet_infoline("String \"XtNbackground\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNbackground, "background") != 0) {
		sprintf(ebuf, "ERROR: XtNbackground should be \"background\", is \"%s\"", XtNbackground);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNbackgroundPixmap
	tet_infoline("String \"XtNbackgroundPixmap\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNbackgroundPixmap, "backgroundPixmap") != 0) {
		sprintf(ebuf, "ERROR: XtNbackgroundPixmap should be \"backgroundPixmap\", is \"%s\"", XtNbackgroundPixmap);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNbitmap
	tet_infoline("String \"XtNbitmap\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNbitmap, "bitmap") != 0) {
		sprintf(ebuf, "ERROR: XtNbitmap should be \"bitmap\", is \"%s\"", XtNbitmap);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNborderColor
	tet_infoline("String \"XtNborderColor\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNborderColor, "borderColor") != 0) {
		sprintf(ebuf, "ERROR: XtNborderColor should be \"borderColor\", is \"%s\"", XtNborderColor);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNborder
	tet_infoline("String \"XtNborder\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNborder, "borderColor") != 0) {
		sprintf(ebuf, "ERROR: XtNborder should be \"borderColor\", is \"%s\"", XtNborder);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNborderPixmap
	tet_infoline("String \"XtNborderPixmap\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNborderPixmap, "borderPixmap") != 0) {
		sprintf(ebuf, "ERROR: XtNborderPixmap should be \"borderPixmap\", is \"%s\"", XtNborderPixmap);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNborderWidth
	tet_infoline("String \"XtNborderWidth\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNborderWidth, "borderWidth") != 0) {
		sprintf(ebuf, "ERROR: XtNborderWidth should be \"borderWidth\", is \"%s\"", XtNborderWidth);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNcallback
	tet_infoline("String \"XtNcallback\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNcallback, "callback") != 0) {
		sprintf(ebuf, "ERROR: XtNcallback should be \"callback\", is \"%s\"", XtNcallback);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNchildren
	tet_infoline("String \"XtNchildren\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNchildren, "children") != 0) {
		sprintf(ebuf, "ERROR: XtNchildren should be \"children\", is \"%s\"", XtNchildren);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNcolormap
	tet_infoline("String \"XtNcolormap\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNcolormap, "colormap") != 0) {
		sprintf(ebuf, "ERROR: XtNcolormap should be \"colormap\", is \"%s\"", XtNcolormap);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNdepth
	tet_infoline("String \"XtNdepth\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNdepth, "depth") != 0) {
		sprintf(ebuf, "ERROR: XtNdepth should be \"depth\", is \"%s\"", XtNdepth);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNdestroyCallback
	tet_infoline("String \"XtNdestroyCallback\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNdestroyCallback, "destroyCallback") != 0) {
		sprintf(ebuf, "ERROR: XtNdestroyCallback should be \"destroyCallback\", is \"%s\"", XtNdestroyCallback);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNeditType
	tet_infoline("String \"XtNeditType\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNeditType, "editType") != 0) {
		sprintf(ebuf, "ERROR: XtNeditType should be \"editType\", is \"%s\"", XtNeditType);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNfile
	tet_infoline("String \"XtNfile\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNfile, "file") != 0) {
		sprintf(ebuf, "ERROR: XtNfile should be \"file\", is \"%s\"", XtNfile);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNfont
	tet_infoline("String \"XtNfont\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNfont, "font") != 0) {
		sprintf(ebuf, "ERROR: XtNfont should be \"font\", is \"%s\"", XtNfont);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNfontSet
	tet_infoline("String \"XtNfontSet\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNfontSet, "fontSet") != 0) {
		sprintf(ebuf, "ERROR: XtNfontSet should be \"fontSet\", is \"%s\"", XtNfontSet);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNforceBars
	tet_infoline("String \"XtNforceBars\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNforceBars, "forceBars") != 0) {
		sprintf(ebuf, "ERROR: XtNforceBars should be \"forceBars\", is \"%s\"", XtNforceBars);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNforeground
	tet_infoline("String \"XtNforeground\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNforeground, "foreground") != 0) {
		sprintf(ebuf, "ERROR: XtNforeground should be \"foreground\", is \"%s\"", XtNforeground);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNfunction
	tet_infoline("String \"XtNfunction\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNfunction, "function") != 0) {
		sprintf(ebuf, "ERROR: XtNfunction should be \"function\", is \"%s\"", XtNfunction);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNheight
	tet_infoline("String \"XtNheight\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNheight, "height") != 0) {
		sprintf(ebuf, "ERROR: XtNheight should be \"height\", is \"%s\"", XtNheight);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNhighlight
	tet_infoline("String \"XtNhighlight\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNhighlight, "highlight") != 0) {
		sprintf(ebuf, "ERROR: XtNhighlight should be \"highlight\", is \"%s\"", XtNhighlight);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNhSpace
	tet_infoline("String \"XtNhSpace\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNhSpace, "hSpace") != 0) {
		sprintf(ebuf, "ERROR: XtNhSpace should be \"hSpace\", is \"%s\"", XtNhSpace);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNindex
	tet_infoline("String \"XtNindex\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNindex, "index") != 0) {
		sprintf(ebuf, "ERROR: XtNindex should be \"index\", is \"%s\"", XtNindex);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNinitialResourcesPersistent
	tet_infoline("String \"XtNinitialResourcesPersistent\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNinitialResourcesPersistent, "initialResourcesPersistent") != 0) {
		sprintf(ebuf, "ERROR: XtNinitialResourcesPersistent should be \"initialResourcesPersistent\", is \"%s\"", XtNinitialResourcesPersistent);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNinnerHeight
	tet_infoline("String \"XtNinnerHeight\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNinnerHeight, "innerHeight") != 0) {
		sprintf(ebuf, "ERROR: XtNinnerHeight should be \"innerHeight\", is \"%s\"", XtNinnerHeight);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNinnerWidth
	tet_infoline("String \"XtNinnerWidth\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNinnerWidth, "innerWidth") != 0) {
		sprintf(ebuf, "ERROR: XtNinnerWidth should be \"innerWidth\", is \"%s\"", XtNinnerWidth);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNinnerWindow
	tet_infoline("String \"XtNinnerWindow\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNinnerWindow, "innerWindow") != 0) {
		sprintf(ebuf, "ERROR: XtNinnerWindow should be \"innerWindow\", is \"%s\"", XtNinnerWindow);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNinsertPosition
	tet_infoline("String \"XtNinsertPosition\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNinsertPosition, "insertPosition") != 0) {
		sprintf(ebuf, "ERROR: XtNinsertPosition should be \"insertPosition\", is \"%s\"", XtNinsertPosition);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNinternalHeight
	tet_infoline("String \"XtNinternalHeight\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNinternalHeight, "internalHeight") != 0) {
		sprintf(ebuf, "ERROR: XtNinternalHeight should be \"internalHeight\", is \"%s\"", XtNinternalHeight);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNinternalWidth
	tet_infoline("String \"XtNinternalWidth\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNinternalWidth, "internalWidth") != 0) {
		sprintf(ebuf, "ERROR: XtNinternalWidth should be \"internalWidth\", is \"%s\"", XtNinternalWidth);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNjumpProc
	tet_infoline("String \"XtNjumpProc\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNjumpProc, "jumpProc") != 0) {
		sprintf(ebuf, "ERROR: XtNjumpProc should be \"jumpProc\", is \"%s\"", XtNjumpProc);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNjustify
	tet_infoline("String \"XtNjustify\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNjustify, "justify") != 0) {
		sprintf(ebuf, "ERROR: XtNjustify should be \"justify\", is \"%s\"", XtNjustify);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNknobHeight
	tet_infoline("String \"XtNknobHeight\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNknobHeight, "knobHeight") != 0) {
		sprintf(ebuf, "ERROR: XtNknobHeight should be \"knobHeight\", is \"%s\"", XtNknobHeight);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNknobIndent
	tet_infoline("String \"XtNknobIndent\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNknobIndent, "knobIndent") != 0) {
		sprintf(ebuf, "ERROR: XtNknobIndent should be \"knobIndent\", is \"%s\"", XtNknobIndent);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNknobPixel
	tet_infoline("String \"XtNknobPixel\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNknobPixel, "knobPixel") != 0) {
		sprintf(ebuf, "ERROR: XtNknobPixel should be \"knobPixel\", is \"%s\"", XtNknobPixel);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNknobWidth
	tet_infoline("String \"XtNknobWidth\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNknobWidth, "knobWidth") != 0) {
		sprintf(ebuf, "ERROR: XtNknobWidth should be \"knobWidth\", is \"%s\"", XtNknobWidth);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNlabel
	tet_infoline("String \"XtNlabel\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNlabel, "label") != 0) {
		sprintf(ebuf, "ERROR: XtNlabel should be \"label\", is \"%s\"", XtNlabel);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNlength
	tet_infoline("String \"XtNlength\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNlength, "length") != 0) {
		sprintf(ebuf, "ERROR: XtNlength should be \"length\", is \"%s\"", XtNlength);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNlowerRight
	tet_infoline("String \"XtNlowerRight\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNlowerRight, "lowerRight") != 0) {
		sprintf(ebuf, "ERROR: XtNlowerRight should be \"lowerRight\", is \"%s\"", XtNlowerRight);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNmappedWhenManaged
	tet_infoline("String \"XtNmappedWhenManaged\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNmappedWhenManaged, "mappedWhenManaged") != 0) {
		sprintf(ebuf, "ERROR: XtNmappedWhenManaged should be \"mappedWhenManaged\", is \"%s\"", XtNmappedWhenManaged);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNmenuEntry
	tet_infoline("String \"XtNmenuEntry\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNmenuEntry, "menuEntry") != 0) {
		sprintf(ebuf, "ERROR: XtNmenuEntry should be \"menuEntry\", is \"%s\"", XtNmenuEntry);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNname
	tet_infoline("String \"XtNname\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNname, "name") != 0) {
		sprintf(ebuf, "ERROR: XtNname should be \"name\", is \"%s\"", XtNname);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNnotify
	tet_infoline("String \"XtNnotify\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNnotify, "notify") != 0) {
		sprintf(ebuf, "ERROR: XtNnotify should be \"notify\", is \"%s\"", XtNnotify);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNnumChildren
	tet_infoline("String \"XtNnumChildren\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNnumChildren, "numChildren") != 0) {
		sprintf(ebuf, "ERROR: XtNnumChildren should be \"numChildren\", is \"%s\"", XtNnumChildren);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNorientation
	tet_infoline("String \"XtNorientation\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNorientation, "orientation") != 0) {
		sprintf(ebuf, "ERROR: XtNorientation should be \"orientation\", is \"%s\"", XtNorientation);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNparameter
	tet_infoline("String \"XtNparameter\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNparameter, "parameter") != 0) {
		sprintf(ebuf, "ERROR: XtNparameter should be \"parameter\", is \"%s\"", XtNparameter);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNpixmap
	tet_infoline("String \"XtNpixmap\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNpixmap, "pixmap") != 0) {
		sprintf(ebuf, "ERROR: XtNpixmap should be \"pixmap\", is \"%s\"", XtNpixmap);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNpopupCallback
	tet_infoline("String \"XtNpopupCallback\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNpopupCallback, "popupCallback") != 0) {
		sprintf(ebuf, "ERROR: XtNpopupCallback should be \"popupCallback\", is \"%s\"", XtNpopupCallback);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNpopdownCallback
	tet_infoline("String \"XtNpopdownCallback\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNpopdownCallback, "popdownCallback") != 0) {
		sprintf(ebuf, "ERROR: XtNpopdownCallback should be \"popdownCallback\", is \"%s\"", XtNpopdownCallback);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNresize
	tet_infoline("String \"XtNresize\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNresize, "resize") != 0) {
		sprintf(ebuf, "ERROR: XtNresize should be \"resize\", is \"%s\"", XtNresize);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNreverseVideo
	tet_infoline("String \"XtNreverseVideo\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNreverseVideo, "reverseVideo") != 0) {
		sprintf(ebuf, "ERROR: XtNreverseVideo should be \"reverseVideo\", is \"%s\"", XtNreverseVideo);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNscreen
	tet_infoline("String \"XtNscreen\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNscreen, "screen") != 0) {
		sprintf(ebuf, "ERROR: XtNscreen should be \"screen\", is \"%s\"", XtNscreen);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNscrollProc
	tet_infoline("String \"XtNscrollProc\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNscrollProc, "scrollProc") != 0) {
		sprintf(ebuf, "ERROR: XtNscrollProc should be \"scrollProc\", is \"%s\"", XtNscrollProc);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNscrollDCursor
	tet_infoline("String \"XtNscrollDCursor\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNscrollDCursor, "scrollDCursor") != 0) {
		sprintf(ebuf, "ERROR: XtNscrollDCursor should be \"scrollDCursor\", is \"%s\"", XtNscrollDCursor);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNscrollHCursor
	tet_infoline("String \"XtNscrollHCursor\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNscrollHCursor, "scrollHCursor") != 0) {
		sprintf(ebuf, "ERROR: XtNscrollHCursor should be \"scrollHCursor\", is \"%s\"", XtNscrollHCursor);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNscrollLCursor
	tet_infoline("String \"XtNscrollLCursor\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNscrollLCursor, "scrollLCursor") != 0) {
		sprintf(ebuf, "ERROR: XtNscrollLCursor should be \"scrollLCursor\", is \"%s\"", XtNscrollLCursor);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNscrollRCursor
	tet_infoline("String \"XtNscrollRCursor\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNscrollRCursor, "scrollRCursor") != 0) {
		sprintf(ebuf, "ERROR: XtNscrollRCursor should be \"scrollRCursor\", is \"%s\"", XtNscrollRCursor);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNscrollUCursor
	tet_infoline("String \"XtNscrollUCursor\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNscrollUCursor, "scrollUCursor") != 0) {
		sprintf(ebuf, "ERROR: XtNscrollUCursor should be \"scrollUCursor\", is \"%s\"", XtNscrollUCursor);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNscrollVCursor
	tet_infoline("String \"XtNscrollVCursor\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNscrollVCursor, "scrollVCursor") != 0) {
		sprintf(ebuf, "ERROR: XtNscrollVCursor should be \"scrollVCursor\", is \"%s\"", XtNscrollVCursor);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNselection
	tet_infoline("String \"XtNselection\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNselection, "selection") != 0) {
		sprintf(ebuf, "ERROR: XtNselection should be \"selection\", is \"%s\"", XtNselection);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNselectionArray
	tet_infoline("String \"XtNselectionArray\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNselectionArray, "selectionArray") != 0) {
		sprintf(ebuf, "ERROR: XtNselectionArray should be \"selectionArray\", is \"%s\"", XtNselectionArray);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNsensitive
	tet_infoline("String \"XtNsensitive\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNsensitive, "sensitive") != 0) {
		sprintf(ebuf, "ERROR: XtNsensitive should be \"sensitive\", is \"%s\"", XtNsensitive);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNshown
	tet_infoline("String \"XtNshown\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNshown, "shown") != 0) {
		sprintf(ebuf, "ERROR: XtNshown should be \"shown\", is \"%s\"", XtNshown);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNspace
	tet_infoline("String \"XtNspace\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNspace, "space") != 0) {
		sprintf(ebuf, "ERROR: XtNspace should be \"space\", is \"%s\"", XtNspace);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNstring
	tet_infoline("String \"XtNstring\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNstring, "string") != 0) {
		sprintf(ebuf, "ERROR: XtNstring should be \"string\", is \"%s\"", XtNstring);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNtextOptions
	tet_infoline("String \"XtNtextOptions\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNtextOptions, "textOptions") != 0) {
		sprintf(ebuf, "ERROR: XtNtextOptions should be \"textOptions\", is \"%s\"", XtNtextOptions);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNtextSink
	tet_infoline("String \"XtNtextSink\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNtextSink, "textSink") != 0) {
		sprintf(ebuf, "ERROR: XtNtextSink should be \"textSink\", is \"%s\"", XtNtextSink);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNtextSource
	tet_infoline("String \"XtNtextSource\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNtextSource, "textSource") != 0) {
		sprintf(ebuf, "ERROR: XtNtextSource should be \"textSource\", is \"%s\"", XtNtextSource);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNthickness
	tet_infoline("String \"XtNthickness\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNthickness, "thickness") != 0) {
		sprintf(ebuf, "ERROR: XtNthickness should be \"thickness\", is \"%s\"", XtNthickness);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNthumb
	tet_infoline("String \"XtNthumb\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNthumb, "thumb") != 0) {
		sprintf(ebuf, "ERROR: XtNthumb should be \"thumb\", is \"%s\"", XtNthumb);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNthumbProc
	tet_infoline("String \"XtNthumbProc\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNthumbProc, "thumbProc") != 0) {
		sprintf(ebuf, "ERROR: XtNthumbProc should be \"thumbProc\", is \"%s\"", XtNthumbProc);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNtop
	tet_infoline("String \"XtNtop\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNtop, "top") != 0) {
		sprintf(ebuf, "ERROR: XtNtop should be \"top\", is \"%s\"", XtNtop);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNtranslations
	tet_infoline("String \"XtNtranslations\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNtranslations, "translations") != 0) {
		sprintf(ebuf, "ERROR: XtNtranslations should be \"translations\", is \"%s\"", XtNtranslations);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNunrealizeCallback
	tet_infoline("String \"XtNunrealizeCallback\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNunrealizeCallback, "unrealizeCallback") != 0) {
		sprintf(ebuf, "ERROR: XtNunrealizeCallback should be \"unrealizeCallback\", is \"%s\"", XtNunrealizeCallback);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNupdate
	tet_infoline("String \"XtNupdate\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNupdate, "update") != 0) {
		sprintf(ebuf, "ERROR: XtNupdate should be \"update\", is \"%s\"", XtNupdate);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNuseBottom
	tet_infoline("String \"XtNuseBottom\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNuseBottom, "useBottom") != 0) {
		sprintf(ebuf, "ERROR: XtNuseBottom should be \"useBottom\", is \"%s\"", XtNuseBottom);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNuseRight
	tet_infoline("String \"XtNuseRight\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNuseRight, "useRight") != 0) {
		sprintf(ebuf, "ERROR: XtNuseRight should be \"useRight\", is \"%s\"", XtNuseRight);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNvalue
	tet_infoline("String \"XtNvalue\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNvalue, "value") != 0) {
		sprintf(ebuf, "ERROR: XtNvalue should be \"value\", is \"%s\"", XtNvalue);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNvSpace
	tet_infoline("String \"XtNvSpace\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNvSpace, "vSpace") != 0) {
		sprintf(ebuf, "ERROR: XtNvSpace should be \"vSpace\", is \"%s\"", XtNvSpace);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNwidth
	tet_infoline("String \"XtNwidth\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNwidth, "width") != 0) {
		sprintf(ebuf, "ERROR: XtNwidth should be \"width\", is \"%s\"", XtNwidth);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNwindow
	tet_infoline("String \"XtNwindow\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNwindow, "window") != 0) {
		sprintf(ebuf, "ERROR: XtNwindow should be \"window\", is \"%s\"", XtNwindow);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNx
	tet_infoline("String \"XtNx\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNx, "x") != 0) {
		sprintf(ebuf, "ERROR: XtNx should be \"x\", is \"%s\"", XtNx);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtNy
	tet_infoline("String \"XtNy\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtNy, "y") != 0) {
		sprintf(ebuf, "ERROR: XtNy should be \"y\", is \"%s\"", XtNy);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCAccelerators
	tet_infoline("String \"XtCAccelerators\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCAccelerators, "Accelerators") != 0) {
		sprintf(ebuf, "ERROR: XtCAccelerators should be \"Accelerators\", is \"%s\"", XtCAccelerators);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCBackground
	tet_infoline("String \"XtCBackground\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCBackground, "Background") != 0) {
		sprintf(ebuf, "ERROR: XtCBackground should be \"Background\", is \"%s\"", XtCBackground);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCBitmap
	tet_infoline("String \"XtCBitmap\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCBitmap, "Bitmap") != 0) {
		sprintf(ebuf, "ERROR: XtCBitmap should be \"Bitmap\", is \"%s\"", XtCBitmap);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCBoolean
	tet_infoline("String \"XtCBoolean\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCBoolean, "Boolean") != 0) {
		sprintf(ebuf, "ERROR: XtCBoolean should be \"Boolean\", is \"%s\"", XtCBoolean);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCBorderColor
	tet_infoline("String \"XtCBorderColor\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCBorderColor, "BorderColor") != 0) {
		sprintf(ebuf, "ERROR: XtCBorderColor should be \"BorderColor\", is \"%s\"", XtCBorderColor);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCBorderWidth
	tet_infoline("String \"XtCBorderWidth\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCBorderWidth, "BorderWidth") != 0) {
		sprintf(ebuf, "ERROR: XtCBorderWidth should be \"BorderWidth\", is \"%s\"", XtCBorderWidth);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCCallback
	tet_infoline("String \"XtCCallback\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCCallback, "Callback") != 0) {
		sprintf(ebuf, "ERROR: XtCCallback should be \"Callback\", is \"%s\"", XtCCallback);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCColormap
	tet_infoline("String \"XtCColormap\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCColormap, "Colormap") != 0) {
		sprintf(ebuf, "ERROR: XtCColormap should be \"Colormap\", is \"%s\"", XtCColormap);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCColor
	tet_infoline("String \"XtCColor\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCColor, "Color") != 0) {
		sprintf(ebuf, "ERROR: XtCColor should be \"Color\", is \"%s\"", XtCColor);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCCursor
	tet_infoline("String \"XtCCursor\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCCursor, "Cursor") != 0) {
		sprintf(ebuf, "ERROR: XtCCursor should be \"Cursor\", is \"%s\"", XtCCursor);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCDepth
	tet_infoline("String \"XtCDepth\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCDepth, "Depth") != 0) {
		sprintf(ebuf, "ERROR: XtCDepth should be \"Depth\", is \"%s\"", XtCDepth);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCEditType
	tet_infoline("String \"XtCEditType\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCEditType, "EditType") != 0) {
		sprintf(ebuf, "ERROR: XtCEditType should be \"EditType\", is \"%s\"", XtCEditType);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCEventBindings
	tet_infoline("String \"XtCEventBindings\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCEventBindings, "EventBindings") != 0) {
		sprintf(ebuf, "ERROR: XtCEventBindings should be \"EventBindings\", is \"%s\"", XtCEventBindings);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCFile
	tet_infoline("String \"XtCFile\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCFile, "File") != 0) {
		sprintf(ebuf, "ERROR: XtCFile should be \"File\", is \"%s\"", XtCFile);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCFont
	tet_infoline("String \"XtCFont\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCFont, "Font") != 0) {
		sprintf(ebuf, "ERROR: XtCFont should be \"Font\", is \"%s\"", XtCFont);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCFontSet
	tet_infoline("String \"XtCFontSet\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCFontSet, "FontSet") != 0) {
		sprintf(ebuf, "ERROR: XtCFontSet should be \"FontSet\", is \"%s\"", XtCFontSet);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCForeground
	tet_infoline("String \"XtCForeground\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCForeground, "Foreground") != 0) {
		sprintf(ebuf, "ERROR: XtCForeground should be \"Foreground\", is \"%s\"", XtCForeground);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCFraction
	tet_infoline("String \"XtCFraction\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCFraction, "Fraction") != 0) {
		sprintf(ebuf, "ERROR: XtCFraction should be \"Fraction\", is \"%s\"", XtCFraction);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCFunction
	tet_infoline("String \"XtCFunction\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCFunction, "Function") != 0) {
		sprintf(ebuf, "ERROR: XtCFunction should be \"Function\", is \"%s\"", XtCFunction);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCHeight
	tet_infoline("String \"XtCHeight\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCHeight, "Height") != 0) {
		sprintf(ebuf, "ERROR: XtCHeight should be \"Height\", is \"%s\"", XtCHeight);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCHSpace
	tet_infoline("String \"XtCHSpace\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCHSpace, "HSpace") != 0) {
		sprintf(ebuf, "ERROR: XtCHSpace should be \"HSpace\", is \"%s\"", XtCHSpace);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCIndex
	tet_infoline("String \"XtCIndex\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCIndex, "Index") != 0) {
		sprintf(ebuf, "ERROR: XtCIndex should be \"Index\", is \"%s\"", XtCIndex);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCInitialResourcesPersistent
	tet_infoline("String \"XtCInitialResourcesPersistent\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCInitialResourcesPersistent, "InitialResourcesPersistent") != 0) {
		sprintf(ebuf, "ERROR: XtCInitialResourcesPersistent should be \"InitialResourcesPersistent\", is \"%s\"", XtCInitialResourcesPersistent);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCInsertPosition
	tet_infoline("String \"XtCInsertPosition\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCInsertPosition, "InsertPosition") != 0) {
		sprintf(ebuf, "ERROR: XtCInsertPosition should be \"InsertPosition\", is \"%s\"", XtCInsertPosition);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCInterval
	tet_infoline("String \"XtCInterval\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCInterval, "Interval") != 0) {
		sprintf(ebuf, "ERROR: XtCInterval should be \"Interval\", is \"%s\"", XtCInterval);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCJustify
	tet_infoline("String \"XtCJustify\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCJustify, "Justify") != 0) {
		sprintf(ebuf, "ERROR: XtCJustify should be \"Justify\", is \"%s\"", XtCJustify);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCKnobIndent
	tet_infoline("String \"XtCKnobIndent\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCKnobIndent, "KnobIndent") != 0) {
		sprintf(ebuf, "ERROR: XtCKnobIndent should be \"KnobIndent\", is \"%s\"", XtCKnobIndent);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCKnobPixel
	tet_infoline("String \"XtCKnobPixel\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCKnobPixel, "KnobPixel") != 0) {
		sprintf(ebuf, "ERROR: XtCKnobPixel should be \"KnobPixel\", is \"%s\"", XtCKnobPixel);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCLabel
	tet_infoline("String \"XtCLabel\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCLabel, "Label") != 0) {
		sprintf(ebuf, "ERROR: XtCLabel should be \"Label\", is \"%s\"", XtCLabel);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCLength
	tet_infoline("String \"XtCLength\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCLength, "Length") != 0) {
		sprintf(ebuf, "ERROR: XtCLength should be \"Length\", is \"%s\"", XtCLength);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCMappedWhenManaged
	tet_infoline("String \"XtCMappedWhenManaged\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCMappedWhenManaged, "MappedWhenManaged") != 0) {
		sprintf(ebuf, "ERROR: XtCMappedWhenManaged should be \"MappedWhenManaged\", is \"%s\"", XtCMappedWhenManaged);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCMargin
	tet_infoline("String \"XtCMargin\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCMargin, "Margin") != 0) {
		sprintf(ebuf, "ERROR: XtCMargin should be \"Margin\", is \"%s\"", XtCMargin);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCMenuEntry
	tet_infoline("String \"XtCMenuEntry\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCMenuEntry, "MenuEntry") != 0) {
		sprintf(ebuf, "ERROR: XtCMenuEntry should be \"MenuEntry\", is \"%s\"", XtCMenuEntry);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCNotify
	tet_infoline("String \"XtCNotify\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCNotify, "Notify") != 0) {
		sprintf(ebuf, "ERROR: XtCNotify should be \"Notify\", is \"%s\"", XtCNotify);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCOrientation
	tet_infoline("String \"XtCOrientation\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCOrientation, "Orientation") != 0) {
		sprintf(ebuf, "ERROR: XtCOrientation should be \"Orientation\", is \"%s\"", XtCOrientation);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCParameter
	tet_infoline("String \"XtCParameter\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCParameter, "Parameter") != 0) {
		sprintf(ebuf, "ERROR: XtCParameter should be \"Parameter\", is \"%s\"", XtCParameter);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCPixmap
	tet_infoline("String \"XtCPixmap\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCPixmap, "Pixmap") != 0) {
		sprintf(ebuf, "ERROR: XtCPixmap should be \"Pixmap\", is \"%s\"", XtCPixmap);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCPosition
	tet_infoline("String \"XtCPosition\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCPosition, "Position") != 0) {
		sprintf(ebuf, "ERROR: XtCPosition should be \"Position\", is \"%s\"", XtCPosition);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCReadOnly
	tet_infoline("String \"XtCReadOnly\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCReadOnly, "ReadOnly") != 0) {
		sprintf(ebuf, "ERROR: XtCReadOnly should be \"ReadOnly\", is \"%s\"", XtCReadOnly);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCResize
	tet_infoline("String \"XtCResize\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCResize, "Resize") != 0) {
		sprintf(ebuf, "ERROR: XtCResize should be \"Resize\", is \"%s\"", XtCResize);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCReverseVideo
	tet_infoline("String \"XtCReverseVideo\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCReverseVideo, "ReverseVideo") != 0) {
		sprintf(ebuf, "ERROR: XtCReverseVideo should be \"ReverseVideo\", is \"%s\"", XtCReverseVideo);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCScreen
	tet_infoline("String \"XtCScreen\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCScreen, "Screen") != 0) {
		sprintf(ebuf, "ERROR: XtCScreen should be \"Screen\", is \"%s\"", XtCScreen);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCScrollProc
	tet_infoline("String \"XtCScrollProc\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCScrollProc, "ScrollProc") != 0) {
		sprintf(ebuf, "ERROR: XtCScrollProc should be \"ScrollProc\", is \"%s\"", XtCScrollProc);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCScrollDCursor
	tet_infoline("String \"XtCScrollDCursor\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCScrollDCursor, "ScrollDCursor") != 0) {
		sprintf(ebuf, "ERROR: XtCScrollDCursor should be \"ScrollDCursor\", is \"%s\"", XtCScrollDCursor);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCScrollHCursor
	tet_infoline("String \"XtCScrollHCursor\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCScrollHCursor, "ScrollHCursor") != 0) {
		sprintf(ebuf, "ERROR: XtCScrollHCursor should be \"ScrollHCursor\", is \"%s\"", XtCScrollHCursor);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCScrollLCursor
	tet_infoline("String \"XtCScrollLCursor\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCScrollLCursor, "ScrollLCursor") != 0) {
		sprintf(ebuf, "ERROR: XtCScrollLCursor should be \"ScrollLCursor\", is \"%s\"", XtCScrollLCursor);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCScrollRCursor
	tet_infoline("String \"XtCScrollRCursor\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCScrollRCursor, "ScrollRCursor") != 0) {
		sprintf(ebuf, "ERROR: XtCScrollRCursor should be \"ScrollRCursor\", is \"%s\"", XtCScrollRCursor);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCScrollUCursor
	tet_infoline("String \"XtCScrollUCursor\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCScrollUCursor, "ScrollUCursor") != 0) {
		sprintf(ebuf, "ERROR: XtCScrollUCursor should be \"ScrollUCursor\", is \"%s\"", XtCScrollUCursor);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCScrollVCursor
	tet_infoline("String \"XtCScrollVCursor\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCScrollVCursor, "ScrollVCursor") != 0) {
		sprintf(ebuf, "ERROR: XtCScrollVCursor should be \"ScrollVCursor\", is \"%s\"", XtCScrollVCursor);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCSelection
	tet_infoline("String \"XtCSelection\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCSelection, "Selection") != 0) {
		sprintf(ebuf, "ERROR: XtCSelection should be \"Selection\", is \"%s\"", XtCSelection);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCSensitive
	tet_infoline("String \"XtCSensitive\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCSensitive, "Sensitive") != 0) {
		sprintf(ebuf, "ERROR: XtCSensitive should be \"Sensitive\", is \"%s\"", XtCSensitive);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCSelectionArray
	tet_infoline("String \"XtCSelectionArray\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCSelectionArray, "SelectionArray") != 0) {
		sprintf(ebuf, "ERROR: XtCSelectionArray should be \"SelectionArray\", is \"%s\"", XtCSelectionArray);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCSpace
	tet_infoline("String \"XtCSpace\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCSpace, "Space") != 0) {
		sprintf(ebuf, "ERROR: XtCSpace should be \"Space\", is \"%s\"", XtCSpace);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCString
	tet_infoline("String \"XtCString\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCString, "String") != 0) {
		sprintf(ebuf, "ERROR: XtCString should be \"String\", is \"%s\"", XtCString);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCTextOptions
	tet_infoline("String \"XtCTextOptions\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCTextOptions, "TextOptions") != 0) {
		sprintf(ebuf, "ERROR: XtCTextOptions should be \"TextOptions\", is \"%s\"", XtCTextOptions);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCTextPosition
	tet_infoline("String \"XtCTextPosition\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCTextPosition, "TextPosition") != 0) {
		sprintf(ebuf, "ERROR: XtCTextPosition should be \"TextPosition\", is \"%s\"", XtCTextPosition);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCTextSink
	tet_infoline("String \"XtCTextSink\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCTextSink, "TextSink") != 0) {
		sprintf(ebuf, "ERROR: XtCTextSink should be \"TextSink\", is \"%s\"", XtCTextSink);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCTextSource
	tet_infoline("String \"XtCTextSource\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCTextSource, "TextSource") != 0) {
		sprintf(ebuf, "ERROR: XtCTextSource should be \"TextSource\", is \"%s\"", XtCTextSource);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCThickness
	tet_infoline("String \"XtCThickness\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCThickness, "Thickness") != 0) {
		sprintf(ebuf, "ERROR: XtCThickness should be \"Thickness\", is \"%s\"", XtCThickness);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCThumb
	tet_infoline("String \"XtCThumb\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCThumb, "Thumb") != 0) {
		sprintf(ebuf, "ERROR: XtCThumb should be \"Thumb\", is \"%s\"", XtCThumb);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCTranslations
	tet_infoline("String \"XtCTranslations\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCTranslations, "Translations") != 0) {
		sprintf(ebuf, "ERROR: XtCTranslations should be \"Translations\", is \"%s\"", XtCTranslations);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCValue
	tet_infoline("String \"XtCValue\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCValue, "Value") != 0) {
		sprintf(ebuf, "ERROR: XtCValue should be \"Value\", is \"%s\"", XtCValue);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCVSpace
	tet_infoline("String \"XtCVSpace\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCVSpace, "VSpace") != 0) {
		sprintf(ebuf, "ERROR: XtCVSpace should be \"VSpace\", is \"%s\"", XtCVSpace);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCWidth
	tet_infoline("String \"XtCWidth\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCWidth, "Width") != 0) {
		sprintf(ebuf, "ERROR: XtCWidth should be \"Width\", is \"%s\"", XtCWidth);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCWindow
	tet_infoline("String \"XtCWindow\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCWindow, "Window") != 0) {
		sprintf(ebuf, "ERROR: XtCWindow should be \"Window\", is \"%s\"", XtCWindow);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCX
	tet_infoline("String \"XtCX\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCX, "X") != 0) {
		sprintf(ebuf, "ERROR: XtCX should be \"X\", is \"%s\"", XtCX);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtCY
	tet_infoline("String \"XtCY\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtCY, "Y") != 0) {
		sprintf(ebuf, "ERROR: XtCY should be \"Y\", is \"%s\"", XtCY);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtRAcceleratorTable
	tet_infoline("String \"XtRAcceleratorTable\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtRAcceleratorTable, "AcceleratorTable") != 0) {
		sprintf(ebuf, "ERROR: XtRAcceleratorTable should be \"AcceleratorTable\", is \"%s\"", XtRAcceleratorTable);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtRAtom
	tet_infoline("String \"XtRAtom\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtRAtom, "Atom") != 0) {
		sprintf(ebuf, "ERROR: XtRAtom should be \"Atom\", is \"%s\"", XtRAtom);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtRBitmap
	tet_infoline("String \"XtRBitmap\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtRBitmap, "Bitmap") != 0) {
		sprintf(ebuf, "ERROR: XtRBitmap should be \"Bitmap\", is \"%s\"", XtRBitmap);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtRBool
	tet_infoline("String \"XtRBool\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtRBool, "Bool") != 0) {
		sprintf(ebuf, "ERROR: XtRBool should be \"Bool\", is \"%s\"", XtRBool);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtRBoolean
	tet_infoline("String \"XtRBoolean\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtRBoolean, "Boolean") != 0) {
		sprintf(ebuf, "ERROR: XtRBoolean should be \"Boolean\", is \"%s\"", XtRBoolean);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtRCallback
	tet_infoline("String \"XtRCallback\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtRCallback, "Callback") != 0) {
		sprintf(ebuf, "ERROR: XtRCallback should be \"Callback\", is \"%s\"", XtRCallback);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtRCallProc
	tet_infoline("String \"XtRCallProc\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtRCallProc, "CallProc") != 0) {
		sprintf(ebuf, "ERROR: XtRCallProc should be \"CallProc\", is \"%s\"", XtRCallProc);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtRCardinal
	tet_infoline("String \"XtRCardinal\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtRCardinal, "Cardinal") != 0) {
		sprintf(ebuf, "ERROR: XtRCardinal should be \"Cardinal\", is \"%s\"", XtRCardinal);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtRColor
	tet_infoline("String \"XtRColor\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtRColor, "Color") != 0) {
		sprintf(ebuf, "ERROR: XtRColor should be \"Color\", is \"%s\"", XtRColor);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtRColormap
	tet_infoline("String \"XtRColormap\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtRColormap, "Colormap") != 0) {
		sprintf(ebuf, "ERROR: XtRColormap should be \"Colormap\", is \"%s\"", XtRColormap);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtRCursor
	tet_infoline("String \"XtRCursor\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtRCursor, "Cursor") != 0) {
		sprintf(ebuf, "ERROR: XtRCursor should be \"Cursor\", is \"%s\"", XtRCursor);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtRDimension
	tet_infoline("String \"XtRDimension\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtRDimension, "Dimension") != 0) {
		sprintf(ebuf, "ERROR: XtRDimension should be \"Dimension\", is \"%s\"", XtRDimension);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtRDisplay
	tet_infoline("String \"XtRDisplay\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtRDisplay, "Display") != 0) {
		sprintf(ebuf, "ERROR: XtRDisplay should be \"Display\", is \"%s\"", XtRDisplay);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtREditMode
	tet_infoline("String \"XtREditMode\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtREditMode, "EditMode") != 0) {
		sprintf(ebuf, "ERROR: XtREditMode should be \"EditMode\", is \"%s\"", XtREditMode);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtREnum
	tet_infoline("String \"XtREnum\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtREnum, "Enum") != 0) {
		sprintf(ebuf, "ERROR: XtREnum should be \"Enum\", is \"%s\"", XtREnum);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtRFile
	tet_infoline("String \"XtRFile\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtRFile, "File") != 0) {
		sprintf(ebuf, "ERROR: XtRFile should be \"File\", is \"%s\"", XtRFile);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtRFloat
	tet_infoline("String \"XtRFloat\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtRFloat, "Float") != 0) {
		sprintf(ebuf, "ERROR: XtRFloat should be \"Float\", is \"%s\"", XtRFloat);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtRFont
	tet_infoline("String \"XtRFont\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtRFont, "Font") != 0) {
		sprintf(ebuf, "ERROR: XtRFont should be \"Font\", is \"%s\"", XtRFont);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtRFontSet
	tet_infoline("String \"XtRFontSet\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtRFontSet, "FontSet") != 0) {
		sprintf(ebuf, "ERROR: XtRFontSet should be \"FontSet\", is \"%s\"", XtRFontSet);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtRFontStruct
	tet_infoline("String \"XtRFontStruct\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtRFontStruct, "FontStruct") != 0) {
		sprintf(ebuf, "ERROR: XtRFontStruct should be \"FontStruct\", is \"%s\"", XtRFontStruct);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtRFunction
	tet_infoline("String \"XtRFunction\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtRFunction, "Function") != 0) {
		sprintf(ebuf, "ERROR: XtRFunction should be \"Function\", is \"%s\"", XtRFunction);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtRGeometry
	tet_infoline("String \"XtRGeometry\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtRGeometry, "Geometry") != 0) {
		sprintf(ebuf, "ERROR: XtRGeometry should be \"Geometry\", is \"%s\"", XtRGeometry);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtRImmediate
	tet_infoline("String \"XtRImmediate\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtRImmediate, "Immediate") != 0) {
		sprintf(ebuf, "ERROR: XtRImmediate should be \"Immediate\", is \"%s\"", XtRImmediate);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtRInitialState
	tet_infoline("String \"XtRInitialState\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtRInitialState, "InitialState") != 0) {
		sprintf(ebuf, "ERROR: XtRInitialState should be \"InitialState\", is \"%s\"", XtRInitialState);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtRInt
	tet_infoline("String \"XtRInt\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtRInt, "Int") != 0) {
		sprintf(ebuf, "ERROR: XtRInt should be \"Int\", is \"%s\"", XtRInt);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtRJustify
	tet_infoline("String \"XtRJustify\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtRJustify, "Justify") != 0) {
		sprintf(ebuf, "ERROR: XtRJustify should be \"Justify\", is \"%s\"", XtRJustify);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtRLongBoolean
	tet_infoline("String \"XtRLongBoolean\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
#ifndef XtRBool
	tet_infoline("String \"XtRBool\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtRLongBoolean, XtRBool) != 0) {
		sprintf(ebuf, "ERROR: XtRLongBoolean should be \"%s\", is \"%s\"", XtRBool, XtRLongBoolean);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif
#endif

#ifndef XtRObject
	tet_infoline("String \"XtRObject\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtRObject, "Object") != 0) {
		sprintf(ebuf, "ERROR: XtRObject should be \"Object\", is \"%s\"", XtRObject);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtROrientation
	tet_infoline("String \"XtROrientation\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtROrientation, "Orientation") != 0) {
		sprintf(ebuf, "ERROR: XtROrientation should be \"Orientation\", is \"%s\"", XtROrientation);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtRPixel
	tet_infoline("String \"XtRPixel\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtRPixel, "Pixel") != 0) {
		sprintf(ebuf, "ERROR: XtRPixel should be \"Pixel\", is \"%s\"", XtRPixel);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtRPixmap
	tet_infoline("String \"XtRPixmap\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtRPixmap, "Pixmap") != 0) {
		sprintf(ebuf, "ERROR: XtRPixmap should be \"Pixmap\", is \"%s\"", XtRPixmap);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtRPointer
	tet_infoline("String \"XtRPointer\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtRPointer, "Pointer") != 0) {
		sprintf(ebuf, "ERROR: XtRPointer should be \"Pointer\", is \"%s\"", XtRPointer);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtRPosition
	tet_infoline("String \"XtRPosition\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtRPosition, "Position") != 0) {
		sprintf(ebuf, "ERROR: XtRPosition should be \"Position\", is \"%s\"", XtRPosition);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtRScreen
	tet_infoline("String \"XtRScreen\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtRScreen, "Screen") != 0) {
		sprintf(ebuf, "ERROR: XtRScreen should be \"Screen\", is \"%s\"", XtRScreen);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtRShort
	tet_infoline("String \"XtRShort\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtRShort, "Short") != 0) {
		sprintf(ebuf, "ERROR: XtRShort should be \"Short\", is \"%s\"", XtRShort);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtRString
	tet_infoline("String \"XtRString\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtRString, "String") != 0) {
		sprintf(ebuf, "ERROR: XtRString should be \"String\", is \"%s\"", XtRString);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtRStringArray
	tet_infoline("String \"XtRStringArray\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtRStringArray, "StringArray") != 0) {
		sprintf(ebuf, "ERROR: XtRStringArray should be \"StringArray\", is \"%s\"", XtRStringArray);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtRStringTable
	tet_infoline("String \"XtRStringTable\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtRStringTable, "StringTable") != 0) {
		sprintf(ebuf, "ERROR: XtRStringTable should be \"StringTable\", is \"%s\"", XtRStringTable);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtRUnsignedChar
	tet_infoline("String \"XtRUnsignedChar\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtRUnsignedChar, "UnsignedChar") != 0) {
		sprintf(ebuf, "ERROR: XtRUnsignedChar should be \"UnsignedChar\", is \"%s\"", XtRUnsignedChar);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtRTranslationTable
	tet_infoline("String \"XtRTranslationTable\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtRTranslationTable, "TranslationTable") != 0) {
		sprintf(ebuf, "ERROR: XtRTranslationTable should be \"TranslationTable\", is \"%s\"", XtRTranslationTable);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtRVisual
	tet_infoline("String \"XtRVisual\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtRVisual, "Visual") != 0) {
		sprintf(ebuf, "ERROR: XtRVisual should be \"Visual\", is \"%s\"", XtRVisual);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtRWidget
	tet_infoline("String \"XtRWidget\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtRWidget, "Widget") != 0) {
		sprintf(ebuf, "ERROR: XtRWidget should be \"Widget\", is \"%s\"", XtRWidget);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtRWidgetClass
	tet_infoline("String \"XtRWidgetClass\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtRWidgetClass, "WidgetClass") != 0) {
		sprintf(ebuf, "ERROR: XtRWidgetClass should be \"WidgetClass\", is \"%s\"", XtRWidgetClass);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtRWidgetList
	tet_infoline("String \"XtRWidgetList\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtRWidgetList, "WidgetList") != 0) {
		sprintf(ebuf, "ERROR: XtRWidgetList should be \"WidgetList\", is \"%s\"", XtRWidgetList);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtRWindow
	tet_infoline("String \"XtRWindow\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtRWindow, "Window") != 0) {
		sprintf(ebuf, "ERROR: XtRWindow should be \"Window\", is \"%s\"", XtRWindow);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtEoff
	tet_infoline("String \"XtEoff\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtEoff, "off") != 0) {
		sprintf(ebuf, "ERROR: XtEoff should be \"off\", is \"%s\"", XtEoff);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtEfalse
	tet_infoline("String \"XtEfalse\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtEfalse, "false") != 0) {
		sprintf(ebuf, "ERROR: XtEfalse should be \"false\", is \"%s\"", XtEfalse);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtEno
	tet_infoline("String \"XtEno\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtEno, "no") != 0) {
		sprintf(ebuf, "ERROR: XtEno should be \"no\", is \"%s\"", XtEno);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtEon
	tet_infoline("String \"XtEon\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtEon, "on") != 0) {
		sprintf(ebuf, "ERROR: XtEon should be \"on\", is \"%s\"", XtEon);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtEtrue
	tet_infoline("String \"XtEtrue\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtEtrue, "true") != 0) {
		sprintf(ebuf, "ERROR: XtEtrue should be \"true\", is \"%s\"", XtEtrue);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtEyes
	tet_infoline("String \"XtEyes\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtEyes, "yes") != 0) {
		sprintf(ebuf, "ERROR: XtEyes should be \"yes\", is \"%s\"", XtEyes);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtEvertical
	tet_infoline("String \"XtEvertical\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtEvertical, "vertical") != 0) {
		sprintf(ebuf, "ERROR: XtEvertical should be \"vertical\", is \"%s\"", XtEvertical);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtEhorizontal
	tet_infoline("String \"XtEhorizontal\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtEhorizontal, "horizontal") != 0) {
		sprintf(ebuf, "ERROR: XtEhorizontal should be \"horizontal\", is \"%s\"", XtEhorizontal);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtEtextRead
	tet_infoline("String \"XtEtextRead\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtEtextRead, "read") != 0) {
		sprintf(ebuf, "ERROR: XtEtextRead should be \"read\", is \"%s\"", XtEtextRead);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtEtextAppend
	tet_infoline("String \"XtEtextAppend\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtEtextAppend, "append") != 0) {
		sprintf(ebuf, "ERROR: XtEtextAppend should be \"append\", is \"%s\"", XtEtextAppend);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtEtextEdit
	tet_infoline("String \"XtEtextEdit\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtEtextEdit, "edit") != 0) {
		sprintf(ebuf, "ERROR: XtEtextEdit should be \"edit\", is \"%s\"", XtEtextEdit);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtExtdefaultbackground
	tet_infoline("String \"XtExtdefaultbackground\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtExtdefaultbackground, "xtdefaultbackground") != 0) {
		sprintf(ebuf, "ERROR: XtExtdefaultbackground should be \"xtdefaultbackground\", is \"%s\"", XtExtdefaultbackground);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtExtdefaultforeground
	tet_infoline("String \"XtExtdefaultforeground\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtExtdefaultforeground, "xtdefaultforeground") != 0) {
		sprintf(ebuf, "ERROR: XtExtdefaultforeground should be \"xtdefaultforeground\", is \"%s\"", XtExtdefaultforeground);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

#ifndef XtExtdefaultfont
	tet_infoline("String \"XtExtdefaultfont\" not defined in StringDefs.h");
	tet_result(TET_FAIL);
#else
	if (strcmp(XtExtdefaultfont, "xtdefaultfont") != 0) {
		sprintf(ebuf, "ERROR: XtExtdefaultfont should be \"xtdefaultfont\", is \"%s\"", XtExtdefaultfont);
		tet_infoline(ebuf);
		tet_result(TET_FAIL);
	}
#endif

	tet_result(TET_PASS);
