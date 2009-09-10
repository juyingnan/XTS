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
rmpstoq_rmpstoq_LDADD = $(LDADD) $(top_builddir)/xts5/src/libXR5/libXR5.a

tprogs = \
	XrmCombineDatabase/XrmCombineDatabase \
	XrmCombineFileDatabase/XrmCombineFileDatabase \
	XrmDestroyDatabase/XrmDestroyDatabase \
	XrmEnumerateDatabase/XrmEnumerateDatabase \
	XrmGetDatabase/XrmGetDatabase \
	XrmGetFileDatabase/XrmGetFileDatabase \
	XrmGetResource/XrmGetResource \
	rmgtstrdtb/rmgtstrdtb \
	rmintlz/rmintlz \
	rmloofdt/rmloofdt \
	rmmrgdtbss/rmmrgdtbss \
	rmprscmmnd/rmprscmmnd \
	rmpstoq/rmpstoq \
	rmptfldtbs/rmptfldtbs \
	rmptlnrsrc/rmptlnrsrc \
	rmptrsrc/rmptrsrc \
	rmptstrrsr/rmptstrrsr \
	rmqgtrsrc/rmqgtrsrc \
	rmqgtsrchl/rmqgtsrchl \
	rmqgtsrchr/rmqgtsrchr \
	rmqptrsrc/rmqptrsrc \
	rmqptstrrs/rmqptstrrs \
	rmqrktstr/rmqrktstr \
	rmstdb/rmstdb \
	rmstrtbndn/rmstrtbndn \
	rmstrtqrk/rmstrtqrk \
	rmstrtqrkl/rmstrtqrkl \
	rmunqqrk/rmunqqrk \
	rsrcmngrst/rsrcmngrst \
	scrrs/scrrs
