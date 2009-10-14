include ../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = -I$(top_srcdir)/include \
	-I$(top_srcdir)/src/tet3/inc \
	-I$(top_srcdir)/xts5/include \
	$(XTS_CFLAGS)
LDADD = $(top_builddir)/src/tet3/tcm/libtcmmain.la \
	$(top_builddir)/xts5/src/xim/libximtest.a \
	$(top_builddir)/xts5/src/lib/libxtest.a \
	$(top_builddir)/xts5/fonts/libfont.a \
	$(top_builddir)/src/tet3/apilib/libapi.la \
	$(XTS_LIBS)

testprogdir = $(libexecdir)/$(subdir)
nobase_testprog_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:$(EXEEXT)=.c)
CLEANFILES = $(BUILT_SOURCES)

# Tests ending in _m test the macro version of Xlib
tprogs = XAllPlanes \
	XBlackPixel XBlackPixel_m \
	XBlackPixelOfScreen XBlackPixelOfScreen_m \
	XBitmapBitOrder XBitmapBitOrder_m \
	XBitmapPad XBitmapPad_m \
	XBitmapUnit XBitmapUnit_m \
	XCellsOfScreen XCellsOfScreen_m \
	XCloseDisplay \
	XConnectionNumber XConnectionNumber_m \
	XDefaultColormap XDefaultColormap_m \
	XDefaultColormapOfScreen XDefaultColormapOfScreen_m \
	XDefaultDepth XDefaultDepth_m \
	XDefaultDepthOfScreen XDefaultDepthOfScreen_m \
	XDefaultGC XDefaultGC_m \
	XDefaultGCOfScreen XDefaultGCOfScreen_m \
	XDefaultRootWindow XDefaultRootWindow_m \
	XDefaultScreen XDefaultScreen_m \
	XDefaultScreenOfDisplay XDefaultScreenOfDisplay_m \
	XDefaultVisual XDefaultVisual_m \
	XDefaultVisualOfScreen XDefaultVisualOfScreen_m \
	XDoesBackingStore XDoesBackingStore_m \
	XDisplayCells XDisplayCells_m \
	XDisplayHeight XDisplayHeight_m \
	XDisplayHeightMM XDisplayHeightMM_m \
	XDisplayOfScreen XDisplayOfScreen_m \
	XDisplayPlanes XDisplayPlanes_m \
	XDisplayString/XDisplayString XDisplayString/XDisplayString_m \
	XDisplayWidth XDisplayWidth_m \
	XDisplayWidthMM XDisplayWidthMM_m \
	XDoesSaveUnders XDoesSaveUnders_m \
	XEventMaskOfScreen XEventMaskOfScreen_m \
	XFree \
	XHeightMMOfScreen XHeightMMOfScreen_m \
	XHeightOfScreen XHeightOfScreen_m \
	XImageByteOrder XImageByteOrder_m \
	XListDepths \
	XLastKnownRequestProcessed XLastKnownRequestProcessed_m \
	XListPixmapFormats \
	XMinCmapsOfScreen XMinCmapsOfScreen_m \
	XMaxCmapsOfScreen XMaxCmapsOfScreen_m \
	XNoOp \
	XNextRequest XNextRequest_m \
	XOpenDisplay/XOpenDisplay \
	XPlanesOfScreen XPlanesOfScreen_m \
	XProtocolRevision XProtocolRevision_m \
	XProtocolVersion XProtocolVersion_m \
	XQLength XQLength_m \
	XRootWindow XRootWindow_m \
	XRootWindowOfScreen XRootWindowOfScreen_m \
	XScreenCount XScreenCount_m \
	XScreenNumberOfScreen \
	XScreenOfDisplay XScreenOfDisplay_m \
	XServerVendor XServerVendor_m \
	XSetCloseDownMode \
	XVendorRelease XVendorRelease_m \
	XWidthMMOfScreen XWidthMMOfScreen_m \
	XWidthOfScreen XWidthOfScreen_m \
	XWhitePixel XWhitePixel_m \
	XWhitePixelOfScreen XWhitePixelOfScreen_m

# Auxiliary programs run from tests
CHILD_LDADD = $(top_builddir)/src/tet3/tcm/libtcmchild.la \
	$(top_builddir)/xts5/src/xim/libximtest.a \
	$(top_builddir)/xts5/src/lib/libxtest.a \
	$(top_builddir)/xts5/fonts/libfont.a \
	$(top_builddir)/src/tet3/apilib/libapi.la \
	$(XTS_LIBS)
nobase_testprog_PROGRAMS += \
	XDisplayString/Test1 \
	XOpenDisplay/Test1
XDisplayString_Test1_LDADD = $(CHILD_LDADD)
XOpenDisplay_Test1_LDADD = $(CHILD_LDADD)
