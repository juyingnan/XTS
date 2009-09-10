include ../../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = $(XTS_LCFLAGS) $(XTS_CFLAGS)
LDADD = $(TCM) $(XTS_LLIBS) $(XTS_LIBS)

check_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:$(EXEEXT)=.c)
CLEANFILES = $(BUILT_SOURCES)

flushgc_flushgc_LDADD = $(TCM) $(XTS_LLIBS) $(XTS_LIBS) \
	$(top_builddir)/xts5/src/libXR5/libXR5.a

tprogs = \
	ChangeGC/ChangeGC \
	CopyGC/CopyGC \
	CreateGC/CreateGC \
	flushgc/flushgc \
	FreeGC/FreeGC \
	gcntxtfrmg/gcntxtfrmg \
	gtgcvls/gtgcvls \
	qrybststpp/qrybststpp \
	QueryBestSize/QueryBestSize \
	qrybsttl/qrybsttl \
	starcmd/starcmd \
	stbg/stbg \
	stclpmsk/stclpmsk \
	stclporgn/stclporgn \
	SetClipRectangles/SetClipRectangles \
	stdshs/stdshs \
	stfllrl/stfllrl \
	stfllstyl/stfllstyl \
	stfnctn/stfnctn \
	stfnt/stfnt \
	stfrgrnd/stfrgrnd \
	stgrphcsex/stgrphcsex \
	stlnattrbt/stlnattrbt \
	stplnmsk/stplnmsk \
	stsbwmd/stsbwmd \
	ststppl/ststppl \
	ststt/ststt \
	sttl/sttl \
	sttsorgn/sttsorgn
