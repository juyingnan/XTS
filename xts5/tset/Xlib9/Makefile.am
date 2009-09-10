include ../../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = $(XTS_LCFLAGS) $(XTS_CFLAGS)
LDADD = $(TCM) $(XTS_LLIBS) $(XTS_LIBS)

check_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:$(EXEEXT)=.c)
CLEANFILES = $(BUILT_SOURCES)

tprogs = \
	XClearArea/XClearArea \
	XClearWindow/XClearWindow \
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
	XFreeFont/XFreeFont \
	XFreeFontInfo/XFreeFontInfo \
	XFreeFontNames/XFreeFontNames \
	XFreeFontPath/XFreeFontPath \
	XGetFontProperty/XGetFontProperty \
	XGetFontPath/XGetFontPath \
	XGetImage/XGetImage \
	XGetSubImage/XGetSubImage \
	XLoadFont/XLoadFont \
	XLoadQueryFont/XLoadQueryFont \
	XListFonts/XListFonts \
	XListFontsWithInfo/XListFontsWithInfo \
	PutImage/PutImage \
	QueryFont/QueryFont \
	qrytxtex16/qrytxtex16 \
	QueryTextExtents/QueryTextExtents \
	SetFontPath/SetFontPath \
	txtextnt16/txtextnt16 \
	txtextnts/txtextnts \
	txtwdth/txtwdth \
	txtwdth16/txtwdth16 \
	unldfnt/unldfnt
