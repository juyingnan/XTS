include ../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = $(XTS_LCFLAGS) $(XTS_CFLAGS)
LDADD = $(TCM) $(XTS_LLIBS) $(XTS_LIBS)

testprogdir = $(libexecdir)/$(subdir)
nobase_testprog_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:$(EXEEXT)=.c)
CLEANFILES = $(BUILT_SOURCES)

XFlushGC_LDADD = $(TCM) $(XTS_LLIBS) $(XTS_LIBS) \
	$(top_builddir)/xts5/src/libXR5/libXR5.a

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
