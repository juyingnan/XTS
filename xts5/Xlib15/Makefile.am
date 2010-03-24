include ../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = -I$(top_srcdir)/include \
	-I$(top_srcdir)/src/tet3/inc \
	-I$(top_srcdir)/xts5/include \
	$(XTS_CFLAGS)
LDADD = $(top_builddir)/src/tet3/tcm/libtcmmain.la \
	$(top_builddir)/xts5/src/xim/libximtest.la \
	$(top_builddir)/xts5/src/lib/libxtest.la \
	$(top_builddir)/xts5/fonts/libfont.la \
	$(top_builddir)/src/tet3/apilib/libapi.la \
	$(XTS_LIBS)

testprogdir = $(libexecdir)/$(subdir)
nobase_testprog_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:=.c)
CLEANFILES = $(BUILT_SOURCES)

XDefaultString_LDADD = $(top_builddir)/xts5/src/libXR5/libXR5.la $(LDADD)

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
CHILD_LDADD = $(top_builddir)/src/tet3/tcm/libtcmchild.la \
	$(top_builddir)/xts5/src/xim/libximtest.la \
	$(top_builddir)/xts5/src/lib/libxtest.la \
	$(top_builddir)/xts5/fonts/libfont.la \
	$(top_builddir)/src/tet3/apilib/libapi.la \
	$(XTS_LIBS)
nobase_testprog_PROGRAMS += \
	XSetWMProperties/Test1 \
	XSetWMProperties/Test2
XSetWMProperties_Test1_LDADD = $(CHILD_LDADD)
XSetWMProperties_Test2_LDADD = $(CHILD_LDADD)
