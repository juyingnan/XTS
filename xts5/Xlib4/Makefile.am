include ../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = -I$(top_srcdir)/include \
	-I$(top_srcdir)/src/tet3/inc \
	-I$(top_srcdir)/xts5/include \
	$(XTS_CFLAGS)
LDADD = $(top_builddir)/src/tet3/tcm/libtcmmain.la \
	$(top_builddir)/xts5/src/libxts5.la \
	$(top_builddir)/src/tet3/apilib/libapi.la \
	$(top_builddir)/src/tet3/apilib/libapi_s.la \
	$(XTS_LIBS)

testprogdir = $(libexecdir)/$(subdir)
nobase_testprog_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:=.c)
CLEANFILES = $(BUILT_SOURCES)

tprogs = \
	XChangeWindowAttributes/XChangeWindowAttributes \
	XConfigureWindow/XConfigureWindow \
	XCirculateSubwindows/XCirculateSubwindows \
	XCirculateSubwindowsDown/XCirculateSubwindowsDown \
	XCirculateSubwindowsUp/XCirculateSubwindowsUp \
	XCreateSimpleWindow/XCreateSimpleWindow \
	XCreateWindow/XCreateWindow \
	XDefineCursor \
	XDestroySubwindows \
	XDestroyWindow \
	XLowerWindow/XLowerWindow \
	XMapRaised/XMapRaised \
	XMapSubwindows/XMapSubwindows \
	XMapWindow/XMapWindow \
	XMoveResizeWindow/XMoveResizeWindow \
	XMoveWindow \
	XRestackWindows/XRestackWindows \
	XRaiseWindow/XRaiseWindow \
	XResizeWindow/XResizeWindow \
	XSetWindowBackground \
	XSetWindowBackgroundPixmap \
	XSetWindowBorder \
	XSetWindowBorderPixmap/XSetWindowBorderPixmap \
	XSetWindowBorderWidth/XSetWindowBorderWidth \
	XSetWindowColormap \
	XUndefineCursor \
	XUnmapSubwindows \
	XUnmapWindow \
	XVisualIDFromVisual

# Data files for test programs
nobase_testprog_DATA = $(srcdir)/*/*.dat
