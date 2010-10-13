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
	$(XTS_LIBS)

testprogdir = $(libexecdir)/$(subdir)
nobase_testprog_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:=.c)
EXTRA_DIST = $(addsuffix .m,$(filter-out %_m,$(tprogs)))
DISTCLEANFILES = $(BUILT_SOURCES)

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
nobase_dist_testprog_DATA = $(srcdir)/*/*.dat
