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
	cmsac/cmsac \
	cmsacs/cmsacs \
	cmsadfs/cmsadfs \
	cmsanc/cmsanc \
	cmsccoc/cmsccoc \
	cmsccol/cmsccol \
	cmscielq/cmscielq \
	cmscieqc/cmscieqc \
	cmscieql/cmscieql \
	cmscproc/cmscproc \
	cmscprocd/cmscprocd \
	cmscrcc/cmscrcc \
	cmsdcc/cmsdcc \
	cmsdocc/cmsdocc \
	cmsfccc/cmsfccc \
	cmsfopr/cmsfopr \
	cmslkcl/cmslkcl \
	cmslqml/cmslqml \
	cmspoft/cmspoft \
	cmsqbk/cmsqbk \
	cmsqbl/cmsqbl \
	cmsqc/cmsqc \
	cmsqcl/cmsqcl \
	cmsqgr/cmsqgr \
	cmsqmc/cmsqmc \
	cmsqmil/cmsqmil \
	cmsqml/cmsqml \
	cmsqmlc/cmsqmlc \
	cmsqred/cmsqred \
	cmsqwt/cmsqwt \
	cmssnoc/cmssnoc \
	cmsstclr/cmsstclr \
	cmsstcls/cmsstcls \
	cmstqmc/cmstqmc \
	cmstqmiv/cmstqmiv \
	cmstqmv/cmstqmv \
	cmstqmvc/cmstqmvc \
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
