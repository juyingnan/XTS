#SUBDIRS = lib libproto libXR5 libXtaw libXtmu libXtTest pixval xim
SUBDIRS = lib libproto libXR5 libXtTest xim bin

xtslibdir = $(libexecdir)/xts5
xtslib_LTLIBRARIES = libxts5.la libxts5proto.la

libxts5_la_SOURCES =
libxts5_la_LDFLAGS = -avoid-version
libxts5_la_LIBADD = \
	lib/libxtest.la \
	../fonts/libfont.la \
	xim/libximtest.la

libxts5proto_la_SOURCES =
libxts5proto_la_LDFLAGS = -avoid-version
libxts5proto_la_LIBADD = \
	libproto/libXst.la \
	libxts5.la
