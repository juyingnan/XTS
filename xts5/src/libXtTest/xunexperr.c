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
* $Header: /cvs/xtest/xtest/xts5/src/libXtTest/xunexperr.c,v 1.2 2005-11-03 08:42:02 jmichael Exp $
*
* Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
* Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
* All Rights Reserved.
*
* Project: VSW5
*
* File: xts5/src/lib/libXtTest/xunexperr.c
*
* Description:
*	Function: x_unexperr()
*
* Modifications:
* $Log: xunexperr.c,v $
* Revision 1.2  2005-11-03 08:42:02  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:10  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:25:43  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:43:58  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:18:02  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:14:34  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:45:31  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:43:27  andy
* Prepare for GA Release
*
*/


#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <XtTest.h>
#include <X11/Xlib.h>

/*error messages formatted here*/
char ebuf[4096];

/*
 *
 *	Invoked by X when an XError occurs.  
 *	Setup by the test cases with: XSetErrorHandler(x_unexperr)
*/

int x_unexperr(disp, error_event)
Display *disp;
XErrorEvent *error_event;
{

    char	proto_string[30];
    char	error_buf[80], *error_ptr;

    error_ptr = error_buf;

/*****
 * get the proper protocol request info
 *****/
    switch(error_event->request_code) {
	case	1:	  
		(void)strcpy(proto_string, "X_CreateWindow");
		break;
	case	2:	  
		(void)strcpy(proto_string, "X_ChangeWindowAttributes");
		break;
	case	3:	  
		(void)strcpy(proto_string, "X_GetWindowAttributes");
		break;
	case	4:	  
		(void)strcpy(proto_string, "X_DestroyWindow");
		break;
	case	5:	  
		(void)strcpy(proto_string, "X_DestroySubwindows");
		break;
	case	6:	  
		(void)strcpy(proto_string, "X_ChangeSaveSet");
		break;
	case	7:	  
		(void)strcpy(proto_string, "X_ReparentWindow");
		break;
	case	8:	  
		(void)strcpy(proto_string, "X_MapWindow");
		break;
	case	9:  
		(void)strcpy(proto_string, "X_MapSubwindows");
		break;
	case	10:	  
		(void)strcpy(proto_string, "X_UnmapWindow");
		break;
	case	11:	  
		(void)strcpy(proto_string, "X_UnmapSubwindows");
		break;
	case	12:	  
		(void)strcpy(proto_string, "X_ConfigureWindow");
		break;
	case	13:	  
		(void)strcpy(proto_string, "X_CirculateWindow");
		break;
	case	14:	  
		(void)strcpy(proto_string, "X_GetGeometry");
		break;
	case	15:	  
		(void)strcpy(proto_string, "X_QueryTree");
		break;
	case	16:	  
		(void)strcpy(proto_string, "X_InternAtom");
		break;
	case	17:	  
		(void)strcpy(proto_string, "X_GetAtomName");
		break;
	case	18:	  
		(void)strcpy(proto_string, "X_ChangeProperty");
		break;
	case	19:	  
		(void)strcpy(proto_string, "X_DeleteProperty");
		break;
	case	20:	  
		(void)strcpy(proto_string, "X_GetProperty");
		break;
	case	21:	  
		(void)strcpy(proto_string, "X_ListProperties");
		break;
	case	22:	  
		(void)strcpy(proto_string, "X_SetSelectionOwner");
		break;
	case	23:	  
		(void)strcpy(proto_string, "X_GetSelectionOwner");
		break;
	case	24:	  
		(void)strcpy(proto_string, "X_ConvertSelection");
		break;
	case	25:	  
		(void)strcpy(proto_string, "X_SendEvent");
		break;
	case	26:	  
		(void)strcpy(proto_string, "X_GrabPointer");
		break;
	case	27:	  
		(void)strcpy(proto_string, "X_UngrabPointer");
		break;
	case	28:	  
		(void)strcpy(proto_string, "X_GrabButton");
		break;
	case	29:	  
		(void)strcpy(proto_string, "X_UngrabButton");
		break;
	case	30:	  
		(void)strcpy(proto_string, "X_ChangeActivePointerGrab");
		break;
	case	31:	  
		(void)strcpy(proto_string, "X_GrabKeyboard");
		break;
	case	32:	  
		(void)strcpy(proto_string, "X_UngrabKeyboard");
		break;
	case	33:	  
		(void)strcpy(proto_string, "X_GrabKey");
		break;
	case	34:	  
		(void)strcpy(proto_string, "X_UngrabKey");
		break;
	case	35:	  
		(void)strcpy(proto_string, "X_AllowEvents");
		break;
	case	36:	  
		(void)strcpy(proto_string, "X_GrabServer");
		break;
	case	37:	  
		(void)strcpy(proto_string, "X_UngrabServer");
		break;
	case	38:	  
		(void)strcpy(proto_string, "X_QueryPointer");
		break;
	case	39:	  
		(void)strcpy(proto_string, "X_GetMotionEvents");
		break;
	case	40:	  
		(void)strcpy(proto_string, "X_TranslateCoords");
		break;
	case	41:	  
		(void)strcpy(proto_string, "X_WarpPointer");
		break;
	case	42:	  
		(void)strcpy(proto_string, "X_SetInputFocus");
		break;
	case	43:	  
		(void)strcpy(proto_string, "X_GetInputFocus");
		break;
	case	44:	  
		(void)strcpy(proto_string, "X_QueryKeymap");
		break;
	case	45:	  
		(void)strcpy(proto_string, "X_OpenFont");
		break;
	case	46:	  
		(void)strcpy(proto_string, "X_CloseFont");
		break;
	case	47:	  
		(void)strcpy(proto_string, "X_QueryFont");
		break;
	case	48:	  
		(void)strcpy(proto_string, "X_QueryTextExtents");
		break;
	case	49:	  
		(void)strcpy(proto_string, "X_ListFonts");
		break;
	case	50:	  
		(void)strcpy(proto_string, "X_ListFontsWithInfo");
		break;
	case	51:	  
		(void)strcpy(proto_string, "X_SetFontPath");
		break;
	case	52:	  
		(void)strcpy(proto_string, "X_GetFontPath");
		break;
	case	53:	  
		(void)strcpy(proto_string, "X_CreatePixmap");
		break;
	case	54:	  
		(void)strcpy(proto_string, "X_FreePixmap");
		break;
	case	55:	  
		(void)strcpy(proto_string, "X_CreateGC");
		break;
	case	56:	  
		(void)strcpy(proto_string, "X_ChangeGC");
		break;
	case	57:	  
		(void)strcpy(proto_string, "X_CopyGC");
		break;
	case	58:	  
		(void)strcpy(proto_string, "X_SetDashes");
		break;
	case	59:	  
		(void)strcpy(proto_string, "X_SetClipRectangles");
		break;
	case	60:	  
		(void)strcpy(proto_string, "X_FreeGC");
		break;
	case	61:	  
		(void)strcpy(proto_string, "X_ClearArea");
		break;
	case	62:	  
		(void)strcpy(proto_string, "X_CopyArea");
		break;
	case	63:	  
		(void)strcpy(proto_string, "X_CopyPlane");
		break;
	case	64:	  
		(void)strcpy(proto_string, "X_PolyPoint");
		break;
	case	65:	  
		(void)strcpy(proto_string, "X_PolyLine");
		break;
	case	66:	  
		(void)strcpy(proto_string, "X_PolySegment");
		break;
	case	67:	  
		(void)strcpy(proto_string, "X_PolyRectangle");
		break;
	case	68:	  
		(void)strcpy(proto_string, "X_PolyArc");
		break;
	case	69:	  
		(void)strcpy(proto_string, "X_FillPoly");
		break;
	case	70:	  
		(void)strcpy(proto_string, "X_PolyFillRectangle");
		break;
	case	71:	  
		(void)strcpy(proto_string, "X_PolyFillArc");
		break;
	case	72:	  
		(void)strcpy(proto_string, "X_PutImage");
		break;
	case	73:	  
		(void)strcpy(proto_string, "X_GetImage");
		break;
	case	74:	  
		(void)strcpy(proto_string, "X_PolyText8");
		break;
	case	75:	  
		(void)strcpy(proto_string, "X_PolyText16");
		break;
	case	76:	  
		(void)strcpy(proto_string, "X_ImageText8");
		break;
	case	77:	  
		(void)strcpy(proto_string, "X_ImageText16");
		break;
	case	78:	  
		(void)strcpy(proto_string, "X_CreateColormap");
		break;
	case	79:	  
		(void)strcpy(proto_string, "X_FreeColormap");
		break;
	case	80:	  
		(void)strcpy(proto_string, "X_CopyColormapAndFree");
		break;
	case	81:	  
		(void)strcpy(proto_string, "X_InstallColormap");
		break;
	case	82:	  
		(void)strcpy(proto_string, "X_UninstallColormap");
		break;
	case	83:	  
		(void)strcpy(proto_string, "X_ListInstalledColormaps");
		break;
	case	84:	  
		(void)strcpy(proto_string, "X_AllocColor");
		break;
	case	85:	  
		(void)strcpy(proto_string, "X_AllocNamedColor");
		break;
	case	86:	  
		(void)strcpy(proto_string, "X_AllocColorCells");
		break;
	case	87:	  
		(void)strcpy(proto_string, "X_AllocColorPlanes");
		break;
	case	88:	  
		(void)strcpy(proto_string, "X_FreeColors");
		break;
	case	89:	  
		(void)strcpy(proto_string, "X_StoreColors");
		break;
	case	90:	  
		(void)strcpy(proto_string, "X_StoreNamedColor");
		break;
	case	91:	  
		(void)strcpy(proto_string, "X_QueryColors");
		break;
	case	92:	  
		(void)strcpy(proto_string, "X_LookupColor");
		break;
	case	93:	  
		(void)strcpy(proto_string, "X_CreateCursor");
		break;
	case	94:	  
		(void)strcpy(proto_string, "X_CreateGlyphCursor");
		break;
	case	95:	  
		(void)strcpy(proto_string, "X_FreeCursor");
		break;
	case	96:	  
		(void)strcpy(proto_string, "X_RecolorCursor");
		break;
	case	97:	  
		(void)strcpy(proto_string, "X_QueryBestSize");
		break;
	case	98:	  
		(void)strcpy(proto_string, "X_QueryExtension");
		break;
	case	99:	  
		(void)strcpy(proto_string, "X_ListExtensions");
		break;
	case	100:	  
		(void)strcpy(proto_string, "X_ChangeKeyboardMapping");
		break;
	case	101:	  
		(void)strcpy(proto_string, "X_GetKeyboardMapping");
		break;
	case	102:	  
		(void)strcpy(proto_string, "X_ChangeKeyboardControl");
		break;
	case	103:	  
		(void)strcpy(proto_string, "X_GetKeyboardControl");
		break;
	case	104:	  
		(void)strcpy(proto_string, "X_Bell");
		break;
	case	105:	  
		(void)strcpy(proto_string, "X_ChangePointerControl");
		break;
	case	106:	  
		(void)strcpy(proto_string, "X_GetPointerControl");
		break;
	case	107:	  
		(void)strcpy(proto_string, "X_SetScreenSaver");
		break;
	case	108:	  
		(void)strcpy(proto_string, "X_GetScreenSaver");
		break;
	case	109:	  
		(void)strcpy(proto_string, "X_ChangeHosts");
		break;
	case	110:	  
		(void)strcpy(proto_string, "X_ListHosts");
		break;
	case	111:	  
		(void)strcpy(proto_string, "X_SetAccessControl");
		break;
	case	112:	  
		(void)strcpy(proto_string, "X_SetCloseDownMode");
		break;
	case	113:	  
		(void)strcpy(proto_string, "X_KillClient");
		break;
	case	114:	  
		(void)strcpy(proto_string, "X_RotateProperties");
		break;
	case	115:	  
		(void)strcpy(proto_string, "X_ForceScreenSaver");
		break;
	case	116:	  
		(void)strcpy(proto_string, "X_SetPointerMapping");
		break;
	case	117:	  
		(void)strcpy(proto_string, "X_GetPointerMapping");
		break;
	case	118:	  
		(void)strcpy(proto_string, "X_SetModifierMapping");
		break;
	case	119:	  
		(void)strcpy(proto_string, "X_GetModifierMapping");
		break;
	case	127:	  
		(void)strcpy(proto_string, "X_NoOperation");
		break;
	case	128:	  
		(void)strcpy(proto_string, "X_ShapeRectangles");
		break;
	case	129:	  
		(void)strcpy(proto_string, "X_ShapeMask");
		break;
	case	130:	  
		(void)strcpy(proto_string, "X_ShapeCombine");
		break;
	case	131:	  
		(void)strcpy(proto_string, "X_ShapeOffset");
		break;
	case	132:	  
		(void)strcpy(proto_string, "X_ShapeQueryExtents");
		break;
	case	133:	  
		(void)strcpy(proto_string, "X_ShapeSelectInput");
		break;
	case	134:	  
		(void)strcpy(proto_string, "X_ShapeInputSelected");
		break;
	case	135:	  
		(void)strcpy(proto_string, "X_ShapeGetRectangles");
		break;
	default:
		(void)strcpy(proto_string, "Unknown");
		break;
    }

/*
 * get the text for the XError
 */
    XGetErrorText(disp, error_event->error_code, error_ptr, 80);

/*
 * print the error message
 */

	tet_infoline("ERROR: ************************************************");
	sprintf(ebuf, "ERROR: XError invoking protocol request %s", proto_string);
	tet_infoline(ebuf);
	sprintf(ebuf, "ERROR: The error was: %s", error_ptr);
	tet_infoline(ebuf);
	sprintf(ebuf, "ERROR: Number of requests sent over the network connection since opened = %ld", (long)error_event->serial);
	tet_infoline(ebuf);
	tet_infoline("ERROR: ************************************************");
	tet_result(TET_FAIL);
	exit(0);
}
