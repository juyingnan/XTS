include ../../../common.mk

# Override the compiler to use the one for the build machine, for cross
# compiles.
CC = @CC_FOR_BUILD@
CFLAGS = @CFLAGS_FOR_BUILD@
LDFLAGS = @LDFLAGS_FOR_BUILD@

AM_CFLAGS = -I$(top_srcdir)/include \
	-I$(top_srcdir)/src/tet3/inc \
	-I$(top_srcdir)/xts5/include
noinst_PROGRAMS = mc
mc_SOURCES = main.c sections.c files.c shortname.c error.c gccomps.c set.c \
	expand.c code.c make.c ma.c cond.c mas.c

# Build mc for the 'dist' rule, because it's used to generate .c files that are
# distributed.
dist-hook: mc
