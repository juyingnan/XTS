include ../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = $(XTS_LCFLAGS) $(XTS_CFLAGS)
LDADD = $(TCM) $(XTS_LLIBS) $(XTS_LIBS)

testprogdir = $(libexecdir)/$(subdir)
nobase_testprog_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:$(EXEEXT)=.c)
CLEANFILES = $(BUILT_SOURCES)

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
