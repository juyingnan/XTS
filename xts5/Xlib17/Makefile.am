include ../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = $(XTS_LCFLAGS) $(XTS_CFLAGS)
LDADD = $(TCM) $(XTS_LLIBS) $(XTS_LIBS)

libexec_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:$(EXEEXT)=.c)
CLEANFILES = $(BUILT_SOURCES)

tprogs = \
	XAddPixel \
	XClipBox \
	XCreateBitmapFromData \
	XCreateImage \
	XCreatePixmapFromBitmapData \
	XCreateRegion \
	XDeleteContext \
	XDestroyImage \
	XDestroyRegion \
	XEmptyRegion \
	XEqualRegion \
	XFindContext \
	XFetchBuffer \
	XFetchBytes \
	XGetDefault/XGetDefault \
	XGetPixel \
	XGetVisualInfo \
	XIntersectRegion \
	IsCursorKey \
	IsFunctionKey \
	IsKeypadKey \
	IsModifierKey \
	IsMiscFunctionKey \
	IsPFKey \
	XKeycodeToKeysym \
	XKeysymToKeycode \
	XKeysymToString \
	XLookupKeysym \
	XLookupString \
	XMatchVisualInfo \
	XOffsetRegion \
	XPolygonRegion \
	XPointInRegion \
	Xpermalloc \
	XParseGeometry \
	XPutPixel \
	XRebindKeysym \
	XRectInRegion \
	XReadBitmapFile \
	XRefreshKeyboardMapping \
	XRotateBuffers \
	XSubImage \
	XSubtractRegion \
	XShrinkRegion \
	XStoreBuffer \
	XStoreBytes \
	XSetRegion \
	XStringToKeysym \
	XSaveContext \
	XUnionRectWithRegion \
	XUnionRegion \
	XUniqueContext \
	XWMGeometry \
	XWriteBitmapFile \
	XXorRegion

# Auxiliary programs run from tests
libexec_PROGRAMS += \
	XGetDefault/Test3 \
	XGetDefault/Test4 \
	XGetDefault/Test5
XGetDefault_Test3_LDADD = $(TCMCHILD) $(XTS_LLIBS) $(XTS_LIBS)
XGetDefault_Test4_LDADD = $(TCMCHILD) $(XTS_LLIBS) $(XTS_LIBS)
XGetDefault_Test5_LDADD = $(TCMCHILD) $(XTS_LLIBS) $(XTS_LIBS)
