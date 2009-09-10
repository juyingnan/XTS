include ../../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = $(XTS_LCFLAGS) $(XTS_CFLAGS)
LDADD = $(TCM) $(XTS_LLIBS) $(XTS_LIBS)

check_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:$(EXEEXT)=.c)
CLEANFILES = $(BUILT_SOURCES)

tprogs = \
	XAddPixel/XAddPixel \
	clpbx/clpbx \
	crtbtmpfrm/crtbtmpfrm \
	crtimg/crtimg \
	crtpxmpfrm/crtpxmpfrm \
	crtrgn/crtrgn \
	dltcntxt/dltcntxt \
	dstryimg/dstryimg \
	dstryrgn/dstryrgn \
	emptyrgn/emptyrgn \
	eqlrgn/eqlrgn \
	fndcntxt/fndcntxt \
	ftchbffr/ftchbffr \
	ftchbyts/ftchbyts \
	gtdflt/gtdflt \
	gtpxl/gtpxl \
	gtvslinf/gtvslinf \
	intrsctrgn/intrsctrgn \
	iscrsrky/iscrsrky \
	isfnctnky/isfnctnky \
	iskypdky/iskypdky \
	ismdfrky/ismdfrky \
	ismscfnctn/ismscfnctn \
	ispfky/ispfky \
	kycdtkysym/kycdtkysym \
	XKeysymToKeycode/XKeysymToKeycode \
	kysymtstr/kysymtstr \
	lkpkysym/lkpkysym \
	lkpstr/lkpstr \
	mtchvslinf/mtchvslinf \
	offstrgn/offstrgn \
	plygnrgn/plygnrgn \
	pntinrgn/pntinrgn \
	prmllc/prmllc \
	prsgmtry/prsgmtry \
	ptpxl/ptpxl \
	rbndkysym/rbndkysym \
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
	gtdflt/Test3 \
	gtdflt/Test4 \
	gtdflt/Test5
gtdflt_Test3_LDADD = $(TCMCHILD) $(XTS_LLIBS) $(XTS_LIBS)
gtdflt_Test4_LDADD = $(TCMCHILD) $(XTS_LLIBS) $(XTS_LIBS)
gtdflt_Test5_LDADD = $(TCMCHILD) $(XTS_LLIBS) $(XTS_LIBS)
