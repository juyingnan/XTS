include ../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = $(XTS_LCFLAGS) $(XTS_CFLAGS)
LDADD = $(TCM) $(XTS_LLIBS) $(XTS_LIBS)

testprogdir = $(libexecdir)/$(subdir)
nobase_testprog_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:$(EXEEXT)=.c)
CLEANFILES = $(BUILT_SOURCES)

tprogs = \
	XClearArea \
	XClearWindow \
	XCopyArea/XCopyArea \
	XCopyPlane/XCopyPlane \
	XDrawArc/XDrawArc \
	XDrawArcs/XDrawArcs \
	XDrawImageString16/XDrawImageString16 \
	XDrawImageString/XDrawImageString \
	XDrawLine/XDrawLine \
	XDrawLines/XDrawLines \
	XDrawPoint/XDrawPoint \
	XDrawPoints/XDrawPoints \
	XDrawRectangle/XDrawRectangle \
	XDrawRectangles/XDrawRectangles \
	XDrawSegments/XDrawSegments \
	XDrawString/XDrawString \
	XDrawString16/XDrawString16 \
	XDrawText/XDrawText \
	XDrawText16/XDrawText16 \
	XFillArc/XFillArc \
	XFillArcs/XFillArcs \
	XFillPolygon/XFillPolygon \
	XFillRectangle/XFillRectangle \
	XFillRectangles/XFillRectangles \
	XFreeFont \
	XFreeFontInfo \
	XFreeFontNames \
	XFreeFontPath \
	XGetFontProperty \
	XGetFontPath \
	XGetImage \
	XGetSubImage \
	XLoadFont/XLoadFont \
	XLoadQueryFont/XLoadQueryFont \
	XListFonts \
	XListFontsWithInfo \
	XPutImage/XPutImage \
	XQueryFont \
	XQueryTextExtents16 \
	XQueryTextExtents \
	XSetFontPath \
	XTextExtents16 \
	XTextExtents \
	XTextWidth \
	XTextWidth16 \
	XUnloadFont

# Data files for test programs
nobase_testprog_DATA = */*.dat
