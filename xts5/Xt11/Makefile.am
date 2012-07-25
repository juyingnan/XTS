include ../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = -I$(top_srcdir)/include \
	-I$(top_srcdir)/src/tet3/inc \
	-I$(top_srcdir)/xts5/include \
	$(XTS_CFLAGS) $(XAW_CFLAGS)
LDADD = $(top_builddir)/src/tet3/tcm/libtcmmain.la \
	$(top_builddir)/xts5/src/libxts5.la \
	$(top_builddir)/xts5/src/libXtTest/libXtTest.la \
	$(top_builddir)/xts5/src/libXtaw/libXtaw.la \
	$(top_builddir)/src/tet3/apilib/libapi.la \
	$(top_builddir)/src/tet3/apilib/libapi_s.la \
	$(XTS_LIBS) $(XAW_LIBS)

testprogdir = $(libexecdir)/$(subdir)
nobase_testprog_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:=.c)
EXTRA_DIST = $(addsuffix .m,$(filter-out %_m,$(tprogs)))
DISTCLEANFILES = $(BUILT_SOURCES)

tprogs = \
	XtAppReleaseCacheRefs \
	XtAppSetTypeConverter \
	XtCallbackReleaseCacheRefList \
	XtCallbackReleaseCacheRef \
	XtCallConverter \
	XtConvertAndStore \
	XtCvtColorToPixel \
	XtCvtIntToBoolean \
	XtCvtIntToBool \
	XtCvtIntToColor \
	XtCvtIntToDimension \
	XtCvtIntToFloat \
	XtCvtIntToFont \
	XtCvtIntToPixel \
	XtCvtIntToPixmap \
	XtCvtIntToPosition \
	XtCvtIntToShort \
	XtCvtIntToUnsignedChar \
	XtCvtPixelToColor \
	XtCvtStringToAcceleratorTable \
	XtCvtStringToAtom \
	XtCvtStringToBoolean \
	XtCvtStringToBool \
	XtCvtStringToCursor \
	XtCvtStringToDimension \
	XtCvtStringToDisplay \
	XtCvtStringToFile \
	XtCvtStringToFloat \
	XtCvtStringToFont \
	XtCvtStringToFontSet \
	XtCvtStringToFontStruct \
	XtCvtStringToInitialState \
	XtCvtStringToInt \
	XtCvtStringToPixel \
	XtCvtStringToPosition \
	XtCvtStringToShort \
	XtCvtStringToTranslationTable \
	XtCvtStringToUnsignedChar \
	XtCvtStringToVisual \
	XtDisplayStringConversionWarning \
	XtDisplayToApplicationContext \
	XtGetApplicationResources \
	XtGetConstraintResourceList \
	XtGetResourceList \
	XtGetSubresources \
	XtGetSubvalues \
	XtGetValues \
	XtOffset \
	XtOffsetOf \
	XtSetSubvalues \
	XtSetTypeConverter \
	XtSetValues \
	XtVaGetApplicationResources \
	XtVaGetSubresources \
	XtVaGetSubvalues \
	XtVaGetValues \
	XtVaSetSubvalues \
	XtVaSetValues
