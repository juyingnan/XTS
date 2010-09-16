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
DISTCLEANFILES = $(BUILT_SOURCES)

tprogs = \
	XAllowEvents \
	XAutoRepeatOff \
	XAutoRepeatOn \
	XBell \
	XChangeActivePointerGrab \
	XChangeKeyboardControl \
	XChangeKeyboardMapping \
	XChangePointerControl \
	XDeleteModifiermapEntry \
	XDisplayKeycodes \
	XFreeModifiermap \
	XGrabButton \
	XGrabKey \
	XGrabKeyboard \
	XGrabPointer \
	XGetInputFocus \
	XGetKeyboardControl \
	XGetKeyboardMapping \
	XGetModifierMapping \
	XGetPointerControl \
	XGetPointerMapping \
	XInsertModifiermapEntry \
	XNewModifiermap \
	XQueryKeymap \
	XSetInputFocus \
	XSetModifierMapping \
	XSetPointerMapping \
	XUngrabButton \
	XUngrabKey \
	XUngrabKeyboard \
	XUngrabPointer \
	XWarpPointer
