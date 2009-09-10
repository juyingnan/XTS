include ../../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = $(XTS_LCFLAGS) $(XTS_CFLAGS)
LDADD = $(TCM) $(XTS_LLIBS) $(XTS_LIBS)

check_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:$(EXEEXT)=.c)
CLEANFILES = $(BUILT_SOURCES)

tprogs = \
	crtfntcrsr/crtfntcrsr \
	CreateGlyphCursor/CreateGlyphCursor \
	CreatePixmap/CreatePixmap \
	crtpxmpcrs/crtpxmpcrs \
	FreeCursor/FreeCursor \
	FreePixmap/FreePixmap \
	qrybstcrsr/qrybstcrsr \
	rclrcrsr/rclrcrsr
