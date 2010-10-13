include ../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = -I$(top_srcdir)/include \
	-I$(top_srcdir)/src/tet3/inc \
	-I$(top_srcdir)/xts5/include \
	$(XTS_CFLAGS)
LDADD = $(top_builddir)/src/tet3/tcm/libtcmmain.la \
	$(top_builddir)/xts5/src/libxts5.la \
	$(top_builddir)/src/tet3/apilib/libapi.la \
	$(top_builddir)/src/tet3/apilib/libapi_s.la \
	$(top_builddir)/xts5/src/libXR5/libXR5.la \
	$(XTS_LIBS)

testprogdir = $(libexecdir)/$(subdir)
nobase_testprog_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:=.c)
EXTRA_DIST = $(addsuffix .m,$(filter-out %_m,$(tprogs)))
DISTCLEANFILES = $(BUILT_SOURCES)

tprogs = \
	XAllocColor \
	XAllocColorCells \
	XAllocColorPlanes \
	XAllocNamedColor \
	XcmsAllocColor \
	XcmsAddColorSpace \
	XcmsAddFunctionSet \
	XcmsAllocNamedColor \
	XcmsCCCOfColormap \
	XcmsConvertColors \
	XcmsCIELabQueryMaxLC \
	XcmsCIELabQueryMaxC \
	XcmsCIELabQueryMaxL \
	XcmsConversionProc \
	XcmsConversionProc2 \
	XcmsCreateCCC \
	XcmsDefaultCCC \
	XcmsDisplayOfCCC \
	XcmsFreeCCC \
	XcmsFormatOfPrefix \
	XcmsLookupColor \
	XcmsCIELabQueryMinL \
	XcmsPrefixOfFormat \
	XcmsQueryBlack \
	XcmsQueryBlue \
	XcmsQueryColor \
	XcmsQueryColors \
	XcmsQueryGreen \
	XcmsCIELuvQueryMaxC \
	XcmsCIELuvQueryMinL \
	XcmsCIELuvQueryMaxL \
	XcmsCIELuvQueryMaxLC \
	XcmsQueryRed \
	XcmsQueryWhite \
	XcmsScreenNumberOfCCC \
	XcmsStoreColor \
	XcmsStoreColors \
	XcmsTekHVCQueryMaxC \
	XcmsTekHVCQueryMinV \
	XcmsTekHVCQueryMaxV \
	XcmsTekHVCQueryMaxVC \
	XcmsTekHVCQueryMaxVSamples \
	XcmsVisualOfCCC \
	XcmsSetWhiteAdjustProc \
	XcmsScreenWhitePointOfCCC \
	XcmsClientWhitePointOfCCC \
	XcmsSetWhitePoint \
	XCopyColormapAndFree \
	XCreateColormap \
	XFreeColormap \
	XFreeColors \
	XLookupColor \
	XParseColor \
	XQueryColor \
	XQueryColors \
	XStoreColor \
	XStoreColors \
	XStoreNamedColor
