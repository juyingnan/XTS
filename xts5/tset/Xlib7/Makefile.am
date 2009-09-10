include ../../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = $(XTS_LCFLAGS) $(XTS_CFLAGS)
LDADD = $(TCM) $(XTS_LLIBS) $(XTS_LIBS) \
	$(top_builddir)/xts5/src/libXR5/libXR5.a

check_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:$(EXEEXT)=.c)
CLEANFILES = $(BUILT_SOURCES)

tprogs = \
	XAllocColor/XAllocColor \
	XAllocColorCells/XAllocColorCells \
	XAllocColorPlanes/XAllocColorPlanes \
	XAllocNamedColor/XAllocNamedColor \
	XcmsAllocColor/XcmsAllocColor \
	XcmsAddColorSpace/XcmsAddColorSpace \
	XcmsAddFunctionSet/XcmsAddFunctionSet \
	XcmsAllocNamedColor/XcmsAllocNamedColor \
	XcmsCCCOfColormap/XcmsCCCOfColormap \
	XcmsConvertColors/XcmsConvertColors \
	XcmsCIELabQueryMaxLC/XcmsCIELabQueryMaxLC \
	XcmsCIELabQueryMaxC/XcmsCIELabQueryMaxC \
	XcmsCIELabQueryMaxL/XcmsCIELabQueryMaxL \
	XcmsConversionProc/XcmsConversionProc \
	XcmsConversionProc/XcmsConversionProc \
	XcmsCreateCCC/XcmsCreateCCC \
	XcmsDefaultCCC/XcmsDefaultCCC \
	XcmsDisplayOfCCC/XcmsDisplayOfCCC \
	XcmsFreeCCC/XcmsFreeCCC \
	XcmsFormatOfPrefix/XcmsFormatOfPrefix \
	XcmsLookupColor/XcmsLookupColor \
	XcmsCIELabQueryMinL/XcmsCIELabQueryMinL \
	XcmsPrefixOfFormat/XcmsPrefixOfFormat \
	XcmsQueryBlack/XcmsQueryBlack \
	XcmsQueryBlue/XcmsQueryBlue \
	XcmsQueryColor/XcmsQueryColor \
	XcmsQueryColors/XcmsQueryColors \
	XcmsQueryGreen/XcmsQueryGreen \
	XcmsCIELuvQueryMaxC/XcmsCIELuvQueryMaxC \
	XcmsCIELuvQueryMinL/XcmsCIELuvQueryMinL \
	XcmsCIELuvQueryMaxL/XcmsCIELuvQueryMaxL \
	XcmsCIELuvQueryMaxLC/XcmsCIELuvQueryMaxLC \
	XcmsQueryRed/XcmsQueryRed \
	XcmsQueryWhite/XcmsQueryWhite \
	XcmsScreenNumberOfCCC/XcmsScreenNumberOfCCC \
	XcmsStoreColor/XcmsStoreColor \
	XcmsStoreColors/XcmsStoreColors \
	XcmsTekHVCQueryMaxC/XcmsTekHVCQueryMaxC \
	XcmsTekHVCQueryMinV/XcmsTekHVCQueryMinV \
	XcmsTekHVCQueryMaxV/XcmsTekHVCQueryMaxV \
	XcmsTekHVCQueryMaxVC/XcmsTekHVCQueryMaxVC \
	cmstqmvs/cmstqmvs \
	cmsvofcc/cmsvofcc \
	cmswapr/cmswapr \
	cmswpcc/cmswpcc \
	cmswpoc/cmswpoc \
	cmswpt/cmswpt \
	CopyColormapAndFree/CopyColormapAndFree \
	CreateColormap/CreateColormap \
	FreeColormap/FreeColormap \
	FreeColors/FreeColors \
	XLookupColor/XLookupColor \
	prsclr/prsclr \
	qryclr/qryclr \
	QueryColors/QueryColors \
	strclr/strclr \
	StoreColors/StoreColors \
	StoreNamedColor/StoreNamedColor
