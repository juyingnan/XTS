include ../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = -I$(top_srcdir)/include \
	-I$(top_srcdir)/src/tet3/inc \
	-I$(top_srcdir)/xts5/include \
	$(XTS_CFLAGS)
LDADD = $(top_builddir)/src/tet3/tcm/libtcmmain.la \
	$(top_builddir)/xts5/src/xim/libximtest.la \
	$(top_builddir)/xts5/src/lib/libxtest.la \
	$(top_builddir)/xts5/fonts/libfont.la \
	$(top_builddir)/src/tet3/apilib/libapi.la \
	$(top_builddir)/src/tet3/apilib/libapi_s.la \
	$(XTS_LIBS)

testprogdir = $(libexecdir)/$(subdir)
nobase_testprog_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:=.c)
CLEANFILES = $(BUILT_SOURCES)

XFlushGC_LDADD = $(top_builddir)/xts5/src/libXR5/libXR5.la $(LDADD)

tprogs = \
	XChangeGC \
	XCopyGC \
	XCreateGC \
	XFlushGC \
	XFreeGC \
	XGContextFromGC \
	XGetGCValues \
	XQueryBestStipple \
	XQueryBestSize \
	XQueryBestTile \
	XSetArcMode \
	XSetBackground \
	XSetClipMask \
	XSetClipOrigin \
	XSetClipRectangles \
	XSetDashes \
	XSetFillRule \
	XSetFillStyle \
	XSetFunction \
	XSetFont \
	XSetForeground \
	XSetGraphicsExposures \
	XSetLineAttributes \
	XSetPlaneMask \
	XSetSubwindowMode \
	XSetStipple \
	XSetState \
	XSetTile \
	XSetTSOrigin
