include ../../common.mk

AM_CFLAGS = $(XTS_LCFLAGS) $(XTS_CFLAGS)
LDADD = $(TCM) $(XTS_LLIBS) $(XTS_LIBS)

check_PROGRAMS = $(fprogs) $(mprogs)
TESTS = $(fprogs:$(EXEEXT)=.scen) $(mprogs:$(EXEEXT)=.scen)
BUILT_SOURCES = $(fprogs:$(EXEEXT)=.c) $(mprogs:$(EXEEXT)=.c)
#DISTCLEANFILES = $(BUILT_SOURCES)
CLEANFILES = $(BUILT_SOURCES)

# Function tests
fprogs = \
	allplns/allplns \
	blckpxl/blckpxl \
	blckpxlofs/blckpxlofs \
	btmpbtordr/btmpbtordr \
	btmppd/btmppd \
	btmpunt/btmpunt \
	cllsofscrn/cllsofscrn \
	clsdsply/clsdsply \
	cnnctnnmbr/cnnctnnmbr \
	dfltclrmp/dfltclrmp \
	dfltclrmpo/dfltclrmpo \
	dfltdpth/dfltdpth \
	dfltdpthof/dfltdpthof \
	dfltgc/dfltgc \
	dfltgcofsc/dfltgcofsc \
	dfltrtwdw/dfltrtwdw \
	dfltscrn/dfltscrn \
	dfltscrnof/dfltscrnof \
	dfltvsl/dfltvsl \
	dfltvslofs/dfltvslofs \
	dsbckngstr/dsbckngstr \
	dsplyclls/dsplyclls \
	dsplyhght/dsplyhght \
	dsplyhghtm/dsplyhghtm \
	dsplyofscr/dsplyofscr \
	dsplyplns/dsplyplns \
	dsplystr/dsplystr \
	dsplywdth/dsplywdth \
	dsplywdthm/dsplywdthm \
	dssvundrs/dssvundrs \
	evntmskofs/evntmskofs \
	fr/fr \
	hghtmmofsc/hghtmmofsc \
	hghtofscrn/hghtofscrn \
	imgbytordr/imgbytordr \
	lstdpths/lstdpths \
	lstknwnrqs/lstknwnrqs \
	lstpxmpfrm/lstpxmpfrm \
	mncmpsofsc/mncmpsofsc \
	mxcmpsofsc/mxcmpsofsc \
	nop/nop \
	nxtrqst/nxtrqst \
	opndsply/opndsply \
	plnsofscrn/plnsofscrn \
	prtclrvsn/prtclrvsn \
	prtclvrsn/prtclvrsn \
	qlngth/qlngth \
	rtwdw/rtwdw \
	rtwdwofscr/rtwdwofscr \
	scrncnt/scrncnt \
	scrnnmbrof/scrnnmbrof \
	scrnofdspl/scrnofdspl \
	srvrvndr/srvrvndr \
	stclsdwnmd/stclsdwnmd \
	vndrrls/vndrrls \
	wdthmmofsc/wdthmmofsc \
	wdthofscrn/wdthofscrn \
	whtpxl/whtpxl \
	whtpxlofsc/whtpxlofsc

# Macro tests; the same as function tests, but using macros
mprogs = \
	blckpxl/blckpxl_m \
	blckpxlofs/blckpxlofs_m \
	btmpbtordr/btmpbtordr_m \
	btmppd/btmppd_m \
	btmpunt/btmpunt_m \
	cllsofscrn/cllsofscrn_m \
	cnnctnnmbr/cnnctnnmbr_m \
	dfltclrmp/dfltclrmp_m \
	dfltclrmpo/dfltclrmpo_m \
	dfltdpth/dfltdpth_m \
	dfltdpthof/dfltdpthof_m \
	dfltgc/dfltgc_m \
	dfltgcofsc/dfltgcofsc_m \
	dfltrtwdw/dfltrtwdw_m \
	dfltscrn/dfltscrn_m \
	dfltscrnof/dfltscrnof_m \
	dfltvsl/dfltvsl_m \
	dfltvslofs/dfltvslofs_m \
	dsbckngstr/dsbckngstr_m \
	dsplyclls/dsplyclls_m \
	dsplyhght/dsplyhght_m \
	dsplyhghtm/dsplyhghtm_m \
	dsplyofscr/dsplyofscr_m \
	dsplyplns/dsplyplns_m \
	dsplystr/dsplystr_m \
	dsplywdth/dsplywdth_m \
	dsplywdthm/dsplywdthm_m \
	dssvundrs/dssvundrs_m \
	evntmskofs/evntmskofs_m \
	hghtmmofsc/hghtmmofsc_m \
	hghtofscrn/hghtofscrn_m \
	imgbytordr/imgbytordr_m \
	lstknwnrqs/lstknwnrqs_m \
	mncmpsofsc/mncmpsofsc_m \
	mxcmpsofsc/mxcmpsofsc_m \
	nxtrqst/nxtrqst_m \
	plnsofscrn/plnsofscrn_m \
	prtclrvsn/prtclrvsn_m \
	prtclvrsn/prtclvrsn_m \
	qlngth/qlngth_m \
	rtwdw/rtwdw_m \
	rtwdwofscr/rtwdwofscr_m \
	scrncnt/scrncnt_m \
	scrnofdspl/scrnofdspl_m \
	srvrvndr/srvrvndr_m \
	vndrrls/vndrrls_m \
	wdthmmofsc/wdthmmofsc_m \
	wdthofscrn/wdthofscrn_m \
	whtpxl/whtpxl_m \
	whtpxlofsc/whtpxlofsc

# Auxiliary programs run from tests
check_PROGRAMS += \
	dsplystr/Test1 \
	opndsply/Test1
dsplystr_Test1_LDADD = $(TCMCHILD) $(XTS_LLIBS) $(XTS_LIBS)
opndsply_Test1_LDADD = $(TCMCHILD) $(XTS_LLIBS) $(XTS_LIBS)
