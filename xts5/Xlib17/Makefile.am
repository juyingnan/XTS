include ../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = $(XTS_LCFLAGS) $(XTS_CFLAGS)
LDADD = $(TCM) $(XTS_LLIBS) $(XTS_LIBS)

libexec_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:$(EXEEXT)=.c)
CLEANFILES = $(BUILT_SOURCES)

tprogs = \
	XAddPixel/XAddPixel \
	XClipBox/XClipBox \
	XCreateBitmapFromData/XCreateBitmapFromData \
	XCreateImage/XCreateImage \
	XCreatePixmapFromBitmapData/XCreatePixmapFromBitmapData \
	XCreateRegion/XCreateRegion \
	XDeleteContext/XDeleteContext \
	XDestroyImage/XDestroyImage \
	XDestroyRegion/XDestroyRegion \
	XEmptyRegion/XEmptyRegion \
	XEqualRegion/XEqualRegion \
	XFindContext/XFindContext \
	XFetchBuffer/XFetchBuffer \
	XFetchBytes/XFetchBytes \
	XGetDefault/XGetDefault \
	XGetPixel/XGetPixel \
	XGetVisualInfo/XGetVisualInfo \
	XIntersectRegion/XIntersectRegion \
	IsCursorKey/IsCursorKey \
	IsFunctionKey/IsFunctionKey \
	IsKeypadKey/IsKeypadKey \
	IsModifierKey/IsModifierKey \
	IsMiscFunctionKey/IsMiscFunctionKey \
	IsPFKey/IsPFKey \
	XKeycodeToKeysym/XKeycodeToKeysym \
	XKeysymToKeycode/XKeysymToKeycode \
	XKeysymToString/XKeysymToString \
	XLookupKeysym/XLookupKeysym \
	XLookupString/XLookupString \
	XMatchVisualInfo/XMatchVisualInfo \
	XOffsetRegion/XOffsetRegion \
	XPolygonRegion/XPolygonRegion \
	XPointInRegion/XPointInRegion \
	Xpermalloc/Xpermalloc \
	XParseGeometry/XParseGeometry \
	XPutPixel/XPutPixel \
	XRebindKeysym/XRebindKeysym \
	XRectInRegion/XRectInRegion \
	XReadBitmapFile/XReadBitmapFile \
	XRefreshKeyboardMapping/XRefreshKeyboardMapping \
	XRotateBuffers/XRotateBuffers \
	XSubImage/XSubImage \
	XSubtractRegion/XSubtractRegion \
	XShrinkRegion/XShrinkRegion \
	XStoreBuffer/XStoreBuffer \
	XStoreBytes/XStoreBytes \
	XSetRegion/XSetRegion \
	XStringToKeysym/XStringToKeysym \
	XSaveContext/XSaveContext \
	XUnionRectWithRegion/XUnionRectWithRegion \
	XUnionRegion/XUnionRegion \
	XUniqueContext/XUniqueContext \
	XWMGeometry/XWMGeometry \
	XWriteBitmapFile/XWriteBitmapFile \
	XXorRegion/XXorRegion

# Auxiliary programs run from tests
libexec_PROGRAMS += \
	XGetDefault/Test3 \
	XGetDefault/Test4 \
	XGetDefault/Test5
XGetDefault_Test3_LDADD = $(TCMCHILD) $(XTS_LLIBS) $(XTS_LIBS)
XGetDefault_Test4_LDADD = $(TCMCHILD) $(XTS_LLIBS) $(XTS_LIBS)
XGetDefault_Test5_LDADD = $(TCMCHILD) $(XTS_LLIBS) $(XTS_LIBS)