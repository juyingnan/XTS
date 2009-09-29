include ../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = $(XTS_LCFLAGS) $(XTS_CFLAGS)
LDADD = $(TCM) $(XTS_LLIBS) $(XTS_LIBS)

libexec_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:$(EXEEXT)=.c)
CLEANFILES = $(BUILT_SOURCES)

XDefaultString_LDADD = $(LDADD) $(top_builddir)/xts5/src/libXR5/libXR5.a

tprogs = \
	XAllocClassHint \
	XAllocIconSize \
	XAllocStandardColormap \
	XAllocSizeHints \
	XAllocWMHints \
	XDefaultString \
	XFreeStringList \
	XFetchName \
	XGetClassHint \
	XGetCommand \
	XGetIconName \
	XGetIconSizes \
	XGetRGBColormaps \
	XGetTransientForHint \
	XGetTextProperty \
	XGetWMClientMachine \
	XGetWMColormapWindows \
	XGetWMHints \
	XGetWMIconName \
	XGetWMName \
	XGetWMNormalHints \
	XGetWMProtocols \
	XGetWMSizeHints \
	XIconifyWindow \
	XReconfigureWMWindow \
	XSetClassHint \
	XSetCommand \
	XSetIconName \
	XSetIconSizes \
	XSetRGBColormaps \
	XStringListToTextProperty \
	XStoreName \
	XSetTransientForHint \
	XSetTextProperty \
	XSetWMClientMachine \
	XSetWMColormapWindows \
	XSetWMHints \
	XSetWMIconName \
	XSetWMName \
	XSetWMNormalHints \
	XSetWMProperties/XSetWMProperties \
	XSetWMProtocols \
	XSetWMSizeHints \
	XTextPropertyToStringList \
	XWithdrawWindow

# Auxiliary programs run from tests
libexec_PROGRAMS += \
	XSetWMProperties/Test1 \
	XSetWMProperties/Test2
XSetWMProperties_Test1_LDADD = $(TCMCHILD) $(XTS_LLIBS) $(XTS_LIBS)
XSetWMProperties_Test2_LDADD = $(TCMCHILD) $(XTS_LLIBS) $(XTS_LIBS)
