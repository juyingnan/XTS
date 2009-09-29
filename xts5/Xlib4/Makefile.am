include ../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = $(XTS_LCFLAGS) $(XTS_CFLAGS)
LDADD = $(TCM) $(XTS_LLIBS) $(XTS_LIBS)

libexec_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:$(EXEEXT)=.c)
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
