include ../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = -I$(top_srcdir)/include \
	-I$(top_srcdir)/src/tet3/inc \
	-I$(top_srcdir)/xts5/include \
	$(XTS_CFLAGS)
LDADD = $(top_builddir)/src/tet3/tcm/libtcmmain.la \
	$(top_builddir)/xts5/src/xim/libximtest.a \
	$(top_builddir)/xts5/src/lib/libxtest.a \
	$(top_builddir)/xts5/fonts/libfont.a \
	$(top_builddir)/src/tet3/apilib/libapi.la \
	$(XTS_LIBS)

testprogdir = $(libexecdir)/$(subdir)
nobase_testprog_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:$(EXEEXT)=.c)
CLEANFILES = $(BUILT_SOURCES)

tprogs = \
	AllowDeviceEvents \
	ChangeDeviceControl \
	ChangeFeedbackControl \
	ChangeKeyboardDevice \
	XChangeDeviceDontPropagateList \
	ChangePointerDevice \
	ChangeDeviceKeyMapping \
	CloseDevice \
	DeviceBell \
	XGetDeviceControl \
	GetFeedbackControl \
	XGetDeviceFocus \
	XGetDeviceDontPropagateList \
	GetExtensionVersion \
	GrabDevice \
	GrabDeviceButton \
	GrabDeviceKey \
	GetDeviceButtonMapping \
	XGetDeviceKeyMapping \
	XGetDeviceModifierMapping \
	GetDeviceMotionEvents \
	XGetSelectedExtensionEvents \
	ListInputDevices \
	Miscellaneous \
	OpenDevice \
	XQueryDeviceState \
	SetDeviceValuators \
	SetDeviceButtonMapping \
	XSetDeviceFocus \
	SetDeviceModifierMapping \
	SetDeviceMode \
	XSelectExtensionEvent \
	SendExtensionEvent \
	XUngrabDevice \
	UngrabDeviceButton \
	UngrabDeviceKey
