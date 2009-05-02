AM_CPPFLAGS = -I../inc -I$(top_srcdir)/include -DTET_LITE
noinst_LTLIBRARIES = libapi.la
# If we weren't building TeT lite, this could also add inetlib, servlib
# and xtilib
libapi_la_LIBADD = ../tcm/libtcm.la ../dtet2lib/libdtet2.la
libapi_la_SOURCES = \
		dcancel.c \
		dconfig.c \
		dresfile.c \
		errno.c \
		exit.c \
		getlist.c \
		getsys.c \
		getsysid.c \
		libvers.c \
		remexec.c \
		remkill.c \
		remtime.c \
		remwait.c \
		rtab.c \
		sync.c \
		tciface.c \
		tdiscon.c \
		tet_exec.c \
		tet_fork.c \
		tet_spawn.c
