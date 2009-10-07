include ../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = $(XTS_LCFLAGS) $(XTS_CFLAGS)
LDADD = $(TCM) $(XTS_LLIBS) $(XTS_LIBS)

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
