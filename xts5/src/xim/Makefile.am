include ../../common.mk

AM_CFLAGS = -I$(top_srcdir)/include \
	-I$(top_srcdir)/src/tet3/inc \
	-I$(top_srcdir)/xts5/include \
	$(XTS_CFLAGS)
noinst_LIBRARIES = libximtest.a
libximtest_a_SOURCES = \
	linklocale.c \
	clnlocale.c \
	ic.c \
	nextlocale.c \
	nextlclmod.c \
	nxtfontset.c \
	parse.c \
	xim_cb.c \
	xim_comp.c \
	response.c \
	xim_save.c \
	stimulus.c
