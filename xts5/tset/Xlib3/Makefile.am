include ../../common.mk

AM_CFLAGS = $(XTS_LCFLAGS) $(XTS_CFLAGS)
LDADD = $(TCM) $(XTS_LLIBS) $(XTS_LIBS)

check_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:$(EXEEXT)=.c)
CLEANFILES = $(BUILT_SOURCES)
.PHONY: $(TESTS)

# Tests ending in _m test the macro version of Xlib
tprogs = allplns/allplns
TESTS = XAllPlanes

tprogs += blckpxl/blckpxl blckpxl/blckpxl_m
TESTS += XBlackPixel BlackPixel

tprogs += blckpxlofs/blckpxlofs blckpxlofs/blckpxlofs_m
TESTS += XBlackPixelOfScreen BlackPixelOfScreen

tprogs += btmpbtordr/btmpbtordr btmpbtordr/btmpbtordr_m
TESTS += XBitmapBitOrder BitmapBitOrder

tprogs += btmppd/btmppd btmppd/btmppd_m
TESTS += XBitmapPad BitmapPad

tprogs += btmpunt/btmpunt btmpunt/btmpunt_m
TESTS += XBitmapUnit BitmapUnit

tprogs += cllsofscrn/cllsofscrn cllsofscrn/cllsofscrn_m
TESTS += XCellsOfScreen CellsOfScreen

tprogs += clsdsply/clsdsply
TESTS += XCloseDisplay

tprogs += cnnctnnmbr/cnnctnnmbr cnnctnnmbr/cnnctnnmbr_m
TESTS += XConnectionNumber ConnectionNumber

tprogs += dfltclrmp/dfltclrmp dfltclrmp/dfltclrmp_m
TESTS += XDefaultColormap DefaultColormap

tprogs += dfltclrmpo/dfltclrmpo dfltclrmpo/dfltclrmpo_m
TESTS += XDefaultColormapOfScreen DefaultColormapOfScreen

tprogs += dfltdpth/dfltdpth dfltdpth/dfltdpth_m
TESTS += XDefaultDepth DefaultDepth

tprogs += dfltdpthof/dfltdpthof dfltdpthof/dfltdpthof_m
TESTS += XDefaultDepthOfScreen DefaultDepthOfScreen

tprogs += dfltgc/dfltgc dfltgc/dfltgc_m
TESTS += XDefaultGC DefaultGC

tprogs += dfltgcofsc/dfltgcofsc dfltgcofsc/dfltgcofsc_m
TESTS += XDefaultGCOfScreen DefaultGCOfScreen

tprogs += dfltrtwdw/dfltrtwdw dfltrtwdw/dfltrtwdw_m
TESTS += XDefaultRootWindow DefaultRootWindow

tprogs += dfltscrn/dfltscrn dfltscrn/dfltscrn_m
TESTS += XDefaultScreen DefaultScreen

tprogs += dfltscrnof/dfltscrnof dfltscrnof/dfltscrnof_m
TESTS += XDefaultScreenOfDisplay DefaultScreenOfDisplay

tprogs += dfltvsl/dfltvsl dfltvsl/dfltvsl_m
TESTS += XDefaultVisual DefaultVisual

tprogs += dfltvslofs/dfltvslofs dfltvslofs/dfltvslofs_m
TESTS += XDefaultVisualOfScreen DefaultVisualOfScreen

tprogs += dsbckngstr/dsbckngstr dsbckngstr/dsbckngstr_m
TESTS += XDoesBackingStore DoesBackingStore

tprogs += dsplyclls/dsplyclls dsplyclls/dsplyclls_m
TESTS += XDisplayCells DisplayCells

tprogs += dsplyhght/dsplyhght dsplyhght/dsplyhght_m
TESTS += XDisplayHeight DisplayHeight

tprogs += dsplyhghtm/dsplyhghtm dsplyhghtm/dsplyhghtm_m
TESTS += XDisplayHeightMM DisplayHeightMM

tprogs += dsplyofscr/dsplyofscr dsplyofscr/dsplyofscr_m
TESTS += XDisplayOfScreen DisplayOfScreen

tprogs += dsplyplns/dsplyplns dsplyplns/dsplyplns_m
TESTS += XDisplayPlanes DisplayPlanes

tprogs += dsplystr/dsplystr dsplystr/dsplystr_m
TESTS += XDisplayString DisplayString

tprogs += dsplywdth/dsplywdth dsplywdth/dsplywdth_m
TESTS += XDisplayWidth DisplayWidth

tprogs += dsplywdthm/dsplywdthm dsplywdthm/dsplywdthm_m
TESTS += XDisplayWidthMM DisplayWidthMM

tprogs += dssvundrs/dssvundrs dssvundrs/dssvundrs_m
TESTS += XDoesSaveUnders DoesSaveUnders

tprogs += evntmskofs/evntmskofs evntmskofs/evntmskofs_m
TESTS += XEventMaskOfScreen EventMaskOfScreen

tprogs += fr/fr
TESTS += XFree

tprogs += hghtmmofsc/hghtmmofsc hghtmmofsc/hghtmmofsc_m
TESTS += XHeightMMOfScreen HeightMMOfScreen

tprogs += hghtofscrn/hghtofscrn hghtofscrn/hghtofscrn_m
TESTS += XHeightOfScreen HeightOfScreen

tprogs += imgbytordr/imgbytordr imgbytordr/imgbytordr_m
TESTS += XImageByteOrder ImageByteOrder

tprogs += lstdpths/lstdpths
TESTS += XListDepths

tprogs += lstknwnrqs/lstknwnrqs lstknwnrqs/lstknwnrqs_m
TESTS += XLastKnownRequestProcessed LastKnownRequestProcessed

tprogs += lstpxmpfrm/lstpxmpfrm
TESTS += XListPixmapFormats

tprogs += mncmpsofsc/mncmpsofsc mncmpsofsc/mncmpsofsc_m
TESTS += XMinCmapsOfScreen MinCmapsOfScreen

tprogs += mxcmpsofsc/mxcmpsofsc mxcmpsofsc/mxcmpsofsc_m
TESTS += XMaxCmapsOfScreen MaxCmapsOfScreen

tprogs += nop/nop
TESTS += XNoOp

tprogs += nxtrqst/nxtrqst nxtrqst/nxtrqst_m
TESTS += XNextRequest NextRequest

tprogs += opndsply/opndsply
TESTS += XOpenDisplay

tprogs += plnsofscrn/plnsofscrn plnsofscrn/plnsofscrn_m
TESTS += XPlanesOfScreen PlanesOfScreen

tprogs += prtclrvsn/prtclrvsn prtclrvsn/prtclrvsn_m
TESTS += XProtocolRevision ProtocolRevision

tprogs += prtclvrsn/prtclvrsn prtclvrsn/prtclvrsn_m
TESTS += XProtocolVersion ProtocolVersion

tprogs += qlngth/qlngth qlngth/qlngth_m
TESTS += XQLength QLength

tprogs += rtwdw/rtwdw rtwdw/rtwdw_m
TESTS += XRootWindow RootWindow

tprogs += rtwdwofscr/rtwdwofscr rtwdwofscr/rtwdwofscr_m
TESTS += XRootWindowOfScreen RootWindowOfScreen

tprogs += scrncnt/scrncnt scrncnt/scrncnt_m
TESTS += XScreenCount ScreenCount

tprogs += scrnnmbrof/scrnnmbrof
TESTS += XScreenNumberOfScreen

tprogs += scrnofdspl/scrnofdspl scrnofdspl/scrnofdspl_m
TESTS += XScreenOfDisplay ScreenOfDisplay

tprogs += srvrvndr/srvrvndr srvrvndr/srvrvndr_m
TESTS += XServerVendor ServerVendor

tprogs += stclsdwnmd/stclsdwnmd
TESTS += XSetCloseDownMode

tprogs += vndrrls/vndrrls vndrrls/vndrrls_m
TESTS += XVendorRelease VendorRelease

tprogs += wdthmmofsc/wdthmmofsc wdthmmofsc/wdthmmofsc_m
TESTS += XWidthMMOfScreen WidthMMOfScreen

tprogs += wdthofscrn/wdthofscrn wdthofscrn/wdthofscrn_m
TESTS += XWidthOfScreen WidthOfScreen

tprogs += whtpxl/whtpxl whtpxl/whtpxl_m
TESTS += XWhitePixel WhitePixel

tprogs += whtpxlofsc/whtpxlofsc whtpxlofsc/whtpxlofsc_m
TESTS += XWhitePixelOfScreen WhitePixelOfScreen

# Auxiliary programs run from tests
check_PROGRAMS += \
	dsplystr/Test1 \
	opndsply/Test1
dsplystr_Test1_LDADD = $(TCMCHILD) $(XTS_LLIBS) $(XTS_LIBS)
opndsply_Test1_LDADD = $(TCMCHILD) $(XTS_LLIBS) $(XTS_LIBS)
