include ../build.mk
include ../../common.mk

AM_CFLAGS = $(XP_CFLAGS)
LIBS = $(XP_LIBS) $(XP_SYSLIBS) @LIBS@

check_PROGRAMS = allcclr/allcclr

allcclr_allcclr_SOURCES = allcclr/allcclr.c $(TCM)
