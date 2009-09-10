include ../../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = $(XTS_LCFLAGS) $(XTS_CFLAGS)
LDADD = $(TCM) $(XTS_LLIBS) $(XTS_LIBS)

check_PROGRAMS = $(tprogs)
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
	rctinrgn/rctinrgn \
	rdbtmpfl/rdbtmpfl \
	rfrshkybrd/rfrshkybrd \
	rttbffrs/rttbffrs \
	sbimg/sbimg \
	sbtrctrgn/sbtrctrgn \
	shrnkrgn/shrnkrgn \
	strbffr/strbffr \
	strbyts/strbyts \
	strgn/strgn \
	XStringToKeysym/XStringToKeysym \
	svcntxt/svcntxt \
	unnrctwthr/unnrctwthr \
	unnrgn/unnrgn \
	unqcntxt/unqcntxt \
	wmgmtry/wmgmtry \
	wrtbtmpfl/wrtbtmpfl \
	xrrgn/xrrgn

# Auxiliary programs run from tests
check_PROGRAMS += \
	XGetDefault/Test3 \
	XGetDefault/Test4 \
	XGetDefault/Test5
XGetDefault_Test3_LDADD = $(TCMCHILD) $(XTS_LLIBS) $(XTS_LIBS)
XGetDefault_Test4_LDADD = $(TCMCHILD) $(XTS_LLIBS) $(XTS_LIBS)
XGetDefault_Test5_LDADD = $(TCMCHILD) $(XTS_LLIBS) $(XTS_LIBS)
