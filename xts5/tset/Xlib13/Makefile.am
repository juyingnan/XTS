include ../../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = $(XTS_LCFLAGS) $(XTS_CFLAGS)
LDADD = $(TCM) $(XTS_LLIBS) $(XTS_LIBS)

check_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:$(EXEEXT)=.c)
CLEANFILES = $(BUILT_SOURCES)

tprogs = \
	XAllowEvents/XAllowEvents \
	XAutoRepeatOff/XAutoRepeatOff \
	XAutoRepeatOn/XAutoRepeatOn \
	XBell/XBell \
	XChangeActivePointerGrab/XChangeActivePointerGrab \
	XChangeKeyboardControl/XChangeKeyboardControl \
	XChangeKeyboardMapping/XChangeKeyboardMapping \
	XChangePointerControl/XChangePointerControl \
	XDeleteModifiermapEntry/XDeleteModifiermapEntry \
	XDisplayKeycodes/XDisplayKeycodes \
	XFreeModifiermap/XFreeModifiermap \
	GrabButton/GrabButton \
	GrabKey/GrabKey \
	GrabKeyboard/GrabKeyboard \
	GrabPointer/GrabPointer \
	XGetInputFocus/XGetInputFocus \
	XGetKeyboardControl/XGetKeyboardControl \
	XGetKeyboardMapping/XGetKeyboardMapping \
	XGetModifierMapping/XGetModifierMapping \
	XGetPointerControl/XGetPointerControl \
	GetPointerMapping/GetPointerMapping \
	insrtmdfrm/insrtmdfrm \
	nwmdfrmp/nwmdfrmp \
	QueryKeymap/QueryKeymap \
	SetInputFocus/SetInputFocus \
	SetModifierMapping/SetModifierMapping \
	SetPointerMapping/SetPointerMapping \
	UngrabButton/UngrabButton \
	UngrabKey/UngrabKey \
	UngrabKeyboard/UngrabKeyboard \
	UngrabPointer/UngrabPointer \
	WarpPointer/WarpPointer
