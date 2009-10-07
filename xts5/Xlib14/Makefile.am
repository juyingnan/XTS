include ../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = $(XTS_LCFLAGS) $(XTS_CFLAGS)
LDADD = $(TCM) $(XTS_LLIBS) $(XTS_LIBS) \
	$(top_builddir)/xts5/src/libXR5/libXR5.a

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
