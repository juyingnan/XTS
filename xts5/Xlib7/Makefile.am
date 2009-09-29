include ../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = $(XTS_LCFLAGS) $(XTS_CFLAGS)
LDADD = $(TCM) $(XTS_LLIBS) $(XTS_LIBS) \
	$(top_builddir)/xts5/src/libXR5/libXR5.a

libexec_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:$(EXEEXT)=.c)
CLEANFILES = $(BUILT_SOURCES)

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
