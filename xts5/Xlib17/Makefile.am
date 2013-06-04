include ../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = -I$(top_srcdir)/include \
	-I$(top_srcdir)/src/tet3/inc \
	-I$(top_srcdir)/xts5/include \
	$(XTS_CFLAGS)
LDADD = $(top_builddir)/src/tet3/tcm/libtcmmain.la \
	$(top_builddir)/xts5/src/libxts5.la \
	$(top_builddir)/src/tet3/apilib/libapi.la \
	$(top_builddir)/src/tet3/apilib/libapi_s.la \
	$(XTS_LIBS)

testprogdir = $(libexecdir)/$(subdir)
nobase_testprog_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:=.c)
EXTRA_DIST = $(addsuffix .m,$(filter-out %_m,$(tprogs)))
DISTCLEANFILES = $(BUILT_SOURCES)

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
CHILD_LDADD = $(top_builddir)/src/tet3/tcm/libtcmchild.la \
	$(top_builddir)/xts5/src/xim/libximtest.la \
	$(top_builddir)/xts5/src/lib/libxtest.la \
	$(top_builddir)/xts5/fonts/libfont.la \
	$(top_builddir)/src/tet3/apilib/libapi.la \
	$(top_builddir)/src/tet3/apilib/libapi_s.la \
	$(XTS_LIBS)
nobase_testprog_PROGRAMS += \
	XGetDefault/Test3 \
	XGetDefault/Test4 \
	XGetDefault/Test5
XGetDefault_Test3_LDADD = $(CHILD_LDADD)
XGetDefault_Test4_LDADD = $(CHILD_LDADD)
XGetDefault_Test5_LDADD = $(CHILD_LDADD)

# Data files for test programs
nobase_dist_testprog_DATA = $(srcdir)/XGetDefault/EnvXdefaults
