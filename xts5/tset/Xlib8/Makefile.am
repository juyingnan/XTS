include ../../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = $(XTS_LCFLAGS) $(XTS_CFLAGS)
LDADD = $(TCM) $(XTS_LLIBS) $(XTS_LIBS)

check_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:$(EXEEXT)=.c)
CLEANFILES = $(BUILT_SOURCES)

XFlushGC_XFlushGC_LDADD = $(TCM) $(XTS_LLIBS) $(XTS_LIBS) \
	$(top_builddir)/xts5/src/libXR5/libXR5.a

tprogs = \
	XChangeGC/XChangeGC \
	XCopyGC/XCopyGC \
	XCreateGC/XCreateGC \
	XFlushGC/XFlushGC \
	XFreeGC/XFreeGC \
	XGContextFromGC/XGContextFromGC \
	XGetGCValues/XGetGCValues \
	XQueryBestStipple/XQueryBestStipple \
	XQueryBestSize/XQueryBestSize \
	XQueryBestTile/XQueryBestTile \
	XSetArcMode/XSetArcMode \
	XSetBackground/XSetBackground \
	XSetClipMask/XSetClipMask \
	XSetClipOrigin/XSetClipOrigin \
	XSetClipRectangles/XSetClipRectangles \
	XSetDashes/XSetDashes \
	XSetFillRule/XSetFillRule \
	XSetFillStyle/XSetFillStyle \
	XSetFunction/XSetFunction \
	XSetFont/XSetFont \
	XSetForeground/XSetForeground \
	stgrphcsex/stgrphcsex \
	stlnattrbt/stlnattrbt \
	stplnmsk/stplnmsk \
	stsbwmd/stsbwmd \
	ststppl/ststppl \
	ststt/ststt \
	sttl/sttl \
	sttsorgn/sttsorgn
