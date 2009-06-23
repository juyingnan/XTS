include ../../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = $(XTS_LCFLAGS) $(XTS_CFLAGS)
LDADD = $(TCM) $(XTS_LLIBS) $(XTS_LIBS)

check_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:$(EXEEXT)=.c)
CLEANFILES = $(BUILT_SOURCES)

tprogs = \
	crtfntcrsr/crtfntcrsr \
	crtglyphcr/crtglyphcr \
	crtpxmp/crtpxmp \
	crtpxmpcrs/crtpxmpcrs \
	frcrsr/frcrsr \
	frpxmp/frpxmp \
	qrybstcrsr/qrybstcrsr \
	rclrcrsr/rclrcrsr
