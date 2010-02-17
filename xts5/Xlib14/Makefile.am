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
	$(top_builddir)/xts5/src/libXR5/libXR5.la \
	$(XTS_LIBS)

testprogdir = $(libexecdir)/$(subdir)
nobase_testprog_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:$(EXEEXT)=.c)
CLEANFILES = $(BUILT_SOURCES)

tprogs = \
	XBaseFontNameListOfFontSet \
	XCloseIM \
	XContextDependentDrawing \
	XCreateFontSet \
	XCreateIC \
	XDestroyIC \
	XDisplayOfIM \
	XExtentsOfFontSet \
	XFilterEvent \
	XFontsOfFontSet \
	XFreeFontSet \
	XGetICValues \
	XGetIMValues \
	XIMOfIC \
	XLocaleOfFontSet \
	XLocaleOfIM \
	XmbDrawImageString/XmbDrawImageString \
	XmbDrawString/XmbDrawString \
	XmbDrawText/XmbDrawText \
	XmbLookupString \
	XmbResetIC \
	XmbSetWMProperties \
	XmbTextEscapement \
	XmbTextExtents \
	XmbTextListToTextProperty \
	XmbTextPerCharExtents \
	XmbTextPropertyToTextList \
	XOpenIM \
	XSetICFocus \
	XSetICValues \
	XSupportsLocale \
	XSetLocaleModifiers \
	XUnsetICFocus \
	XVaCreateNestedList \
	XwcDrawImageString/XwcDrawImageString \
	XwcDrawString/XwcDrawString \
	XwcDrawText/XwcDrawText \
	XwcFreeStringList \
	XwcLookupString \
	XwcResetIC \
	XwcTextEscapement \
	XwcTextListToTextProperty \
	XwcTextPerCharExtents \
	XwcTextPropertyToTextList \
	XwcTextExtents

# Data files for test programs
nobase_testprog_DATA = */*.dat
