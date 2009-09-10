include ../../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = $(XTS_LCFLAGS) $(XTS_CFLAGS)
LDADD = $(TCM) $(XTS_LLIBS) $(XTS_LIBS) \
	$(top_builddir)/xts5/src/libXR5/libXR5.a

check_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:$(EXEEXT)=.c)
CLEANFILES = $(BUILT_SOURCES)

tprogs = \
	XBaseFontNameListOfFontSet/XBaseFontNameListOfFontSet \
	XCloseIM/XCloseIM \
	XContextDependentDrawing/XContextDependentDrawing \
	XCreateFontSet/XCreateFontSet \
	XCreateIC/XCreateIC \
	XDestroyIC/XDestroyIC \
	XDisplayOfIM/XDisplayOfIM \
	XExtentsOfFontSet/XExtentsOfFontSet \
	XFilterEvent/XFilterEvent \
	XFontsOfFontSet/XFontsOfFontSet \
	XFreeFontSet/XFreeFontSet \
	XGetICValues/XGetICValues \
	XGetIMValues/XGetIMValues \
	XIMOfIC/XIMOfIC \
	XLocaleOfFontSet/XLocaleOfFontSet \
	XLocaleOfIM/XLocaleOfIM \
	XmbDrawImageString/XmbDrawImageString \
	mbdstr/mbdstr \
	mbdtext/mbdtext \
	mblstr/mblstr \
	mbresic/mbresic \
	mbswmprp/mbswmprp \
	mbtesc/mbtesc \
	mbtext/mbtext \
	mbtlttp/mbtlttp \
	mbtpcex/mbtpcex \
	mbtpttl/mbtpttl \
	openim/openim \
	sicfoc/sicfoc \
	sicvals/sicvals \
	slocale/slocale \
	stlmod/stlmod \
	uicfoc/uicfoc \
	vcnlist/vcnlist \
	wcdistr/wcdistr \
	wcdstr/wcdstr \
	wcdtext/wcdtext \
	wcfstli/wcfstli \
	wclustr/wclustr \
	wcreic/wcreic \
	wctesc/wctesc \
	wctlttp/wctlttp \
	wctpcex/wctpcex \
	wctpttl/wctpttl \
	wctxtex/wctxtex
