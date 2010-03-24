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

XrmCombineDatabase_LDADD = $(LDADD) $(top_builddir)/xts5/src/libXR5/libXR5.la
XrmCombineFileDatabase_LDADD = $(LDADD) $(top_builddir)/xts5/src/libXR5/libXR5.la
XrmEnumerateDatabase_LDADD = $(LDADD) $(top_builddir)/xts5/src/libXR5/libXR5.la
XrmPermStringToQuark_LDADD = $(LDADD) $(top_builddir)/xts5/src/libXR5/libXR5.la

tprogs = \
	XrmCombineDatabase \
	XrmCombineFileDatabase \
	XrmDestroyDatabase \
	XrmEnumerateDatabase \
	XrmGetDatabase \
	XrmGetFileDatabase \
	XrmGetResource \
	XrmGetStringDatabase \
	XrmInitialize \
	XrmLocaleOfDatabase \
	XrmMergeDatabases \
	XrmParseCommand \
	XrmPermStringToQuark \
	XrmPutFileDatabase \
	XrmPutLineResource \
	XrmPutResource \
	XrmPutStringResource \
	XrmQGetResource \
	XrmQGetSearchList \
	XrmQGetSearchResource \
	XrmQPutResource \
	XrmQPutStringResource \
	XrmQuarkToString \
	XrmSetDatabase \
	XrmStringToBindingQuarkList \
	XrmStringToQuark \
	XrmStringToQuarkList \
	XrmUniqueQuark \
	XResourceManagerString \
	XScreenResourceString
