include ../../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = $(XP_LCFLAGS) $(XP_CFLAGS)
LDADD = $(TCM) $(XP_LLIBS) $(XP_LIBS)

check_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:$(EXEEXT)=.c)
CLEANFILES = $(BUILT_SOURCES)

tprogs = \
	AllowDeviceEvents/AllowDeviceEvents \
	ChangeDeviceControl/ChangeDeviceControl \
	ChangeDeviceDontPropagateList/ChangeDeviceDontPropagateList \
	ChangeFeedbackControl/ChangeFeedbackControl \
	ChangeKeyboardDevice/ChangeKeyboardDevice \
	ChangePointerDevice/ChangePointerDevice \
	ChangeDeviceKeyMapping/ChangeDeviceKeyMapping \
	CloseDevice/CloseDevice \
	DeviceBell/DeviceBell \
	GetDeviceModifierMapping/GetDeviceModifierMapping \
	GetFeedbackControl/GetFeedbackControl \
	GetExtensionVersion/GetExtensionVersion \
	GrabDevice/GrabDevice \
	GrabDeviceButton/GrabDeviceButton \
	GrabDeviceKey/GrabDeviceKey \
	GetDeviceButtonMapping/GetDeviceButtonMapping \
	GetDeviceControl/GetDeviceControl \
	GetDeviceFocus/GetDeviceFocus \
	GetDeviceMotionEvents/GetDeviceMotionEvents \
	GetDeviceDontPropagateList/GetDeviceDontPropagateList \
	GetDeviceKeyMapping/GetDeviceKeyMapping \
	GetSelectedExtensionEvents/GetSelectedExtensionEvents \
	ListInputDevices/ListInputDevices \
	Miscellaneous/Miscellaneous \
	OpenDevice/OpenDevice \
	QueryDeviceState/QueryDeviceState \
	SetDeviceValuators/SetDeviceValuators \
	SetDeviceButtonMapping/SetDeviceButtonMapping \
	SetDeviceFocus/SetDeviceFocus \
	SetDeviceModifierMapping/SetDeviceModifierMapping \
	SetDeviceMode/SetDeviceMode \
	SelectExtensionEvent/SelectExtensionEvent \
	SendExtensionEvent/SendExtensionEvent \
	UngrabDevice/UngrabDevice \
	XUngrabDeviceButton/XUngrabDeviceButton \
	XUngrabDeviceKey/XUngrabDeviceKey
