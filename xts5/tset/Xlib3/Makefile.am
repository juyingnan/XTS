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
	cnnctnnmbr/cnnctnnmbr cnnctnnmbr/cnnctnnmbr_m \
	dfltclrmp/dfltclrmp dfltclrmp/dfltclrmp_m \
	dfltclrmpo/dfltclrmpo dfltclrmpo/dfltclrmpo_m \
	dfltdpth/dfltdpth dfltdpth/dfltdpth_m \
	dfltdpthof/dfltdpthof dfltdpthof/dfltdpthof_m \
	dfltgc/dfltgc dfltgc/dfltgc_m \
	dfltgcofsc/dfltgcofsc dfltgcofsc/dfltgcofsc_m \
	dfltrtwdw/dfltrtwdw dfltrtwdw/dfltrtwdw_m \
	dfltscrn/dfltscrn dfltscrn/dfltscrn_m \
	dfltscrnof/dfltscrnof dfltscrnof/dfltscrnof_m \
	dfltvsl/dfltvsl dfltvsl/dfltvsl_m \
	dfltvslofs/dfltvslofs dfltvslofs/dfltvslofs_m \
	dsbckngstr/dsbckngstr dsbckngstr/dsbckngstr_m \
	dsplyclls/dsplyclls dsplyclls/dsplyclls_m \
	dsplyhght/dsplyhght dsplyhght/dsplyhght_m \
	dsplyhghtm/dsplyhghtm dsplyhghtm/dsplyhghtm_m \
	dsplyofscr/dsplyofscr dsplyofscr/dsplyofscr_m \
	dsplyplns/dsplyplns dsplyplns/dsplyplns_m \
	dsplystr/dsplystr dsplystr/dsplystr_m \
	dsplywdth/dsplywdth dsplywdth/dsplywdth_m \
	dsplywdthm/dsplywdthm dsplywdthm/dsplywdthm_m \
	dssvundrs/dssvundrs dssvundrs/dssvundrs_m \
	evntmskofs/evntmskofs evntmskofs/evntmskofs_m \
	fr/fr \
	hghtmmofsc/hghtmmofsc hghtmmofsc/hghtmmofsc_m \
	hghtofscrn/hghtofscrn hghtofscrn/hghtofscrn_m \
	imgbytordr/imgbytordr imgbytordr/imgbytordr_m \
	lstdpths/lstdpths \
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
	dsplystr/Test1 \
	OpenDisplay/Test1
dsplystr_Test1_LDADD = $(TCMCHILD) $(XTS_LLIBS) $(XTS_LIBS)
OpenDisplay_Test1_LDADD = $(TCMCHILD) $(XTS_LLIBS) $(XTS_LIBS)
