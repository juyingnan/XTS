include ../../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = $(XTS_LCFLAGS) $(XTS_CFLAGS)
LDADD = $(TCM) $(XTS_LLIBS) $(XTS_LIBS)

check_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:$(EXEEXT)=.c)
CLEANFILES = $(BUILT_SOURCES)

XrmCombineDatabase_XrmCombineDatabase_LDADD = $(LDADD) $(top_builddir)/xts5/src/libXR5/libXR5.a
XrmCombineFileDatabase_XrmCombineFileDatabase_LDADD = $(LDADD) $(top_builddir)/xts5/src/libXR5/libXR5.a
XrmEnumerateDatabase_XrmEnumerateDatabase_LDADD = $(LDADD) $(top_builddir)/xts5/src/libXR5/libXR5.a
XrmPermStringToQuark_XrmPermStringToQuark_LDADD = $(LDADD) $(top_builddir)/xts5/src/libXR5/libXR5.a

tprogs = \
	XrmCombineDatabase/XrmCombineDatabase \
	XrmCombineFileDatabase/XrmCombineFileDatabase \
	XrmDestroyDatabase/XrmDestroyDatabase \
	XrmEnumerateDatabase/XrmEnumerateDatabase \
	XrmGetDatabase/XrmGetDatabase \
	XrmGetFileDatabase/XrmGetFileDatabase \
	XrmGetResource/XrmGetResource \
	XrmGetStringDatabase/XrmGetStringDatabase \
	XrmInitialize/XrmInitialize \
	XrmLocaleOfDatabase/XrmLocaleOfDatabase \
	XrmMergeDatabases/XrmMergeDatabases \
	XrmParseCommand/XrmParseCommand \
	XrmPermStringToQuark/XrmPermStringToQuark \
	XrmPutFileDatabase/XrmPutFileDatabase \
	XrmPutLineResource/XrmPutLineResource \
	XrmPutResource/XrmPutResource \
	XrmPutStringResource/XrmPutStringResource \
	XrmQGetResource/XrmQGetResource \
	XrmQGetSearchList/XrmQGetSearchList \
	XrmQGetSearchResource/XrmQGetSearchResource \
	XrmQPutResource/XrmQPutResource \
	XrmQPutStringResource/XrmQPutStringResource \
	XrmQuarkToString/XrmQuarkToString \
	XrmSetDatabase/XrmSetDatabase \
	XrmStringToBindingQuarkList/XrmStringToBindingQuarkList \
	XrmStringToQuark/XrmStringToQuark \
	XrmStringToQuarkList/XrmStringToQuarkList \
	XrmUniqueQuark/XrmUniqueQuark \
	XResourceManagerString/XResourceManagerString \
	scrrs/scrrs
