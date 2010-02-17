include ../../common.mk

AM_CFLAGS = -I$(top_srcdir)/include \
	-I$(top_srcdir)/src/tet3/inc \
	-I$(top_srcdir)/xts5/include \
	$(XTS_CFLAGS) \
	-DDEBUG
noinst_LTLIBRARIES = libXR5.la
libXR5_la_SOURCES = \
	r5startup.c \
	message.c \
	dumpbuf.c \
	save.c \
	misc.c \
	blowup.c \
	item.c \
	signal.c \
	bufdisp.c \
	chek.c \
	event.c
