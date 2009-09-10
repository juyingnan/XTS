include ../../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = $(XTS_LCFLAGS) $(XTS_CFLAGS)
LDADD = $(TCM) $(XTS_LLIBS) $(XTS_LIBS)

check_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:$(EXEEXT)=.c)
CLEANFILES = $(BUILT_SOURCES)

# Tests ending in _m test the macro version of Xlib
tprogs = XAllPlanes/XAllPlanes \
	XBlackPixel/XBlackPixel XBlackPixel/XBlackPixel_m \
	XBlackPixelOfScreen/XBlackPixelOfScreen XBlackPixelOfScreen/XBlackPixelOfScreen_m \
	XBitmapBitOrder/XBitmapBitOrder XBitmapBitOrder/XBitmapBitOrder_m \
	XBitmapPad/XBitmapPad XBitmapPad/XBitmapPad_m \
	XBitmapUnit/XBitmapUnit XBitmapUnit/XBitmapUnit_m \
	XCellsOfScreen/XCellsOfScreen XCellsOfScreen/XCellsOfScreen_m \
	XCloseDisplay/XCloseDisplay \
	XConnectionNumber/XConnectionNumber XConnectionNumber/XConnectionNumber_m \
	XDefaultColormap/XDefaultColormap XDefaultColormap/XDefaultColormap_m \
	XDefaultColormapOfScreen/XDefaultColormapOfScreen XDefaultColormapOfScreen/XDefaultColormapOfScreen_m \
	XDefaultDepth/XDefaultDepth XDefaultDepth/XDefaultDepth_m \
	XDefaultDepthOfScreen/XDefaultDepthOfScreen XDefaultDepthOfScreen/XDefaultDepthOfScreen_m \
	XDefaultGC/XDefaultGC XDefaultGC/XDefaultGC_m \
	XDefaultGCOfScreen/XDefaultGCOfScreen XDefaultGCOfScreen/XDefaultGCOfScreen_m \
	XDefaultRootWindow/XDefaultRootWindow XDefaultRootWindow/XDefaultRootWindow_m \
	XDefaultScreen/XDefaultScreen XDefaultScreen/XDefaultScreen_m \
	XDefaultScreenOfDisplay/XDefaultScreenOfDisplay XDefaultScreenOfDisplay/XDefaultScreenOfDisplay_m \
	XDefaultVisual/XDefaultVisual XDefaultVisual/XDefaultVisual_m \
	XDefaultVisualOfScreen/XDefaultVisualOfScreen XDefaultVisualOfScreen/XDefaultVisualOfScreen_m \
	XDoesBackingStore/XDoesBackingStore XDoesBackingStore/XDoesBackingStore_m \
	XDisplayCells/XDisplayCells XDisplayCells/XDisplayCells_m \
	XDisplayHeight/XDisplayHeight XDisplayHeight/XDisplayHeight_m \
	XDisplayHeightMM/XDisplayHeightMM XDisplayHeightMM/XDisplayHeightMM_m \
	XDisplayOfScreen/XDisplayOfScreen XDisplayOfScreen/XDisplayOfScreen_m \
	XDisplayPlanes/XDisplayPlanes XDisplayPlanes/XDisplayPlanes_m \
	XDisplayString/XDisplayString XDisplayString/XDisplayString_m \
	XDisplayWidth/XDisplayWidth XDisplayWidth/XDisplayWidth_m \
	XDisplayWidthMM/XDisplayWidthMM XDisplayWidthMM/XDisplayWidthMM_m \
	XDoesSaveUnders/XDoesSaveUnders XDoesSaveUnders/XDoesSaveUnders_m \
	XEventMaskOfScreen/XEventMaskOfScreen XEventMaskOfScreen/XEventMaskOfScreen_m \
	XFree/XFree \
	XHeightMMOfScreen/XHeightMMOfScreen XHeightMMOfScreen/XHeightMMOfScreen_m \
	XHeightOfScreen/XHeightOfScreen XHeightOfScreen/XHeightOfScreen_m \
	XImageByteOrder/XImageByteOrder XImageByteOrder/XImageByteOrder_m \
	XListDepths/XListDepths \
	lstknwnrqs/lstknwnrqs lstknwnrqs/lstknwnrqs_m \
	lstpxmpfrm/lstpxmpfrm \
	mncmpsofsc/mncmpsofsc mncmpsofsc/mncmpsofsc_m \
	mxcmpsofsc/mxcmpsofsc mxcmpsofsc/mxcmpsofsc_m \
	nop/nop \
	nxtrqst/nxtrqst nxtrqst/nxtrqst_m \
	OpenDisplay/OpenDisplay \
	plnsofscrn/plnsofscrn plnsofscrn/plnsofscrn_m \
	prtclrvsn/prtclrvsn prtclrvsn/prtclrvsn_m \
	prtclvrsn/prtclvrsn prtclvrsn/prtclvrsn_m \
	qlngth/qlngth qlngth/qlngth_m \
	rtwdw/rtwdw rtwdw/rtwdw_m \
	rtwdwofscr/rtwdwofscr rtwdwofscr/rtwdwofscr_m \
	scrncnt/scrncnt scrncnt/scrncnt_m \
	scrnnmbrof/scrnnmbrof \
	scrnofdspl/scrnofdspl scrnofdspl/scrnofdspl_m \
	srvrvndr/srvrvndr srvrvndr/srvrvndr_m \
	SetCloseDownMode/SetCloseDownMode \
	vndrrls/vndrrls vndrrls/vndrrls_m \
	wdthmmofsc/wdthmmofsc wdthmmofsc/wdthmmofsc_m \
	wdthofscrn/wdthofscrn wdthofscrn/wdthofscrn_m \
	whtpxl/whtpxl whtpxl/whtpxl_m \
	whtpxlofsc/whtpxlofsc whtpxlofsc/whtpxlofsc_m

# Auxiliary programs run from tests
check_PROGRAMS += \
	XDisplayString/Test1 \
	OpenDisplay/Test1
XDisplayString_Test1_LDADD = $(TCMCHILD) $(XTS_LLIBS) $(XTS_LIBS)
OpenDisplay_Test1_LDADD = $(TCMCHILD) $(XTS_LLIBS) $(XTS_LIBS)
