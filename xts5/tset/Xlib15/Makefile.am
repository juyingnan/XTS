include ../../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = $(XTS_LCFLAGS) $(XTS_CFLAGS)
LDADD = $(TCM) $(XTS_LLIBS) $(XTS_LIBS)

check_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:$(EXEEXT)=.c)
CLEANFILES = $(BUILT_SOURCES)

XDefaultString_XDefaultString_LDADD = $(LDADD) $(top_builddir)/xts5/src/libXR5/libXR5.a

tprogs = \
	XAllocClassHint/XAllocClassHint \
	XAllocIconSize/XAllocIconSize \
	XAllocStandardColormap/XAllocStandardColormap \
	XAllocSizeHints/XAllocSizeHints \
	XAllocWMHints/XAllocWMHints \
	XDefaultString/XDefaultString \
	XFreeStringList/XFreeStringList \
	XFetchName/XFetchName \
	XGetClassHint/XGetClassHint \
	XGetCommand/XGetCommand \
	XGetIconName/XGetIconName \
	XGetIconSizes/XGetIconSizes \
	XGetRGBColormaps/XGetRGBColormaps \
	XGetTransientForHint/XGetTransientForHint \
	XGetTextProperty/XGetTextProperty \
	XGetWMClientMachine/XGetWMClientMachine \
	XGetWMColormapWindows/XGetWMColormapWindows \
	XGetWMHints/XGetWMHints \
	XGetWMIconName/XGetWMIconName \
	XGetWMName/XGetWMName \
	XGetWMNormalHints/XGetWMNormalHints \
	XGetWMProtocols/XGetWMProtocols \
	XGetWMSizeHints/XGetWMSizeHints \
	XIconifyWindow/XIconifyWindow \
	XReconfigureWMWindow/XReconfigureWMWindow \
	XSetClassHint/XSetClassHint \
	XSetCommand/XSetCommand \
	XSetIconName/XSetIconName \
	XSetIconSizes/XSetIconSizes \
	XSetRGBColormaps/XSetRGBColormaps \
	XStringListToTextProperty/XStringListToTextProperty \
	strnm/strnm \
	sttrnsntfr/sttrnsntfr \
	sttxtprprt/sttxtprprt \
	stwmclntmc/stwmclntmc \
	stwmclrmpw/stwmclrmpw \
	stwmhnts/stwmhnts \
	stwmicnnm/stwmicnnm \
	stwmnm/stwmnm \
	stwmnrmlhn/stwmnrmlhn \
	stwmprprts/stwmprprts \
	stwmprtcls/stwmprtcls \
	stwmszhnts/stwmszhnts \
	txtprprtyt/txtprprtyt \
	wthdrwwdw/wthdrwwdw

# Auxiliary programs run from tests
check_PROGRAMS += \
	stwmprprts/Test1 \
	stwmprprts/Test2
stwmprprts_Test1_LDADD = $(TCMCHILD) $(XTS_LLIBS) $(XTS_LIBS)
stwmprprts_Test2_LDADD = $(TCMCHILD) $(XTS_LLIBS) $(XTS_LIBS)
