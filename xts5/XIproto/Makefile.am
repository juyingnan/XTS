include ../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = $(XP_LCFLAGS) $(XP_CFLAGS)
LDADD = $(TCM) $(XP_LLIBS) $(XP_LIBS)

testprogdir = $(libexecdir)/$(subdir)
nobase_testprog_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:$(EXEEXT)=.c)
CLEANFILES = $(BUILT_SOURCES)

tprogs = \
	AllowDeviceEvents \
	ChangeDeviceControl \
	ChangeDeviceDontPropagateList \
	ChangeFeedbackControl \
	ChangeKeyboardDevice \
	ChangePointerDevice \
	ChangeDeviceKeyMapping \
	CloseDevice \
	DeviceBell \
	GetDeviceModifierMapping \
	GetFeedbackControl \
	GetExtensionVersion \
	GrabDevice \
	GrabDeviceButton \
	GrabDeviceKey \
	GetDeviceButtonMapping \
	GetDeviceControl \
	GetDeviceFocus \
	GetDeviceMotionEvents \
	GetDeviceDontPropagateList \
	GetDeviceKeyMapping \
	GetSelectedExtensionEvents \
	ListInputDevices \
	Miscellaneous \
	OpenDevice \
	QueryDeviceState \
	SetDeviceValuators \
	SetDeviceButtonMapping \
	SetDeviceFocus \
	SetDeviceModifierMapping \
	SetDeviceMode \
	SelectExtensionEvent \
	SendExtensionEvent \
	UngrabDevice \
	UngrabDeviceButton \
	UngrabDeviceKey
