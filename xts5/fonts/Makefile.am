include ../common.mk

AM_CFLAGS = -I$(top_srcdir)/include \
	-I$(top_srcdir)/src/tet3/inc \
	-I$(top_srcdir)/xts5/include \
	$(XTS_CFLAGS)
noinst_LTLIBRARIES = libfont.la
libfont_la_SOURCES = xtfont0.c xtfont1.c xtfont2.c xtfont3.c xtfont4.c \
	xtfont5.c xtfont6.c

FONTBDFS = xtfont0.bdf xtfont1.bdf xtfont2.bdf xtfont3.bdf xtfont4.bdf \
	xtfont5.bdf xtfont6.bdf xtfont7.bdf xtfont8.bdf
FONTPCFS = $(FONTBDFS:.bdf=.pcf)

xts5fontsdir = $(datadir)/xts5/fonts
xts5fonts_DATA = $(FONTPCFS) fonts.dir

.bdf.pcf:
	$(BDFTOPCF) -t -o $@ $<
fonts.dir: $(FONTPCFS)
	$(MKFONTDIR) -x .bdf
