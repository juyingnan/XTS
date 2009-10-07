include ../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = $(XTS_LCFLAGS) $(XTS_CFLAGS)
LDADD = $(TCM) $(XTS_LLIBS) $(XTS_LIBS)

testprogdir = $(libexecdir)/$(subdir)
nobase_testprog_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:$(EXEEXT)=.c)
CLEANFILES = $(BUILT_SOURCES)

XrmCombineDatabase_LDADD = $(LDADD) $(top_builddir)/xts5/src/libXR5/libXR5.a
XrmCombineFileDatabase_LDADD = $(LDADD) $(top_builddir)/xts5/src/libXR5/libXR5.a
XrmEnumerateDatabase_LDADD = $(LDADD) $(top_builddir)/xts5/src/libXR5/libXR5.a
XrmPermStringToQuark_LDADD = $(LDADD) $(top_builddir)/xts5/src/libXR5/libXR5.a

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
