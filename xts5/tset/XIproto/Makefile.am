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
	XGetFeedbackControl/XGetFeedbackControl \
	GetExtensionVersion/GetExtensionVersion \
	XGrabDevice/XGrabDevice \
	XGrabDeviceButton/XGrabDeviceButton \
	XGrabDeviceKey/XGrabDeviceKey \
	GetDeviceButtonMapping/GetDeviceButtonMapping \
	GetDeviceControl/GetDeviceControl \
	GetDeviceFocus/GetDeviceFocus \
	GetDeviceMotionEvents/GetDeviceMotionEvents \
	GetDeviceDontPropagateList/GetDeviceDontPropagateList \
	GetDeviceKeyMapping/GetDeviceKeyMapping \
	GetSelectedExtensionEvents/GetSelectedExtensionEvents \
	XListInputDevices/XListInputDevices \
	Miscellaneous/Miscellaneous \
	XOpenDevice/XOpenDevice \
	QueryDeviceState/QueryDeviceState \
	XSetDeviceValuators/XSetDeviceValuators \
	XSetDeviceButtonMapping/XSetDeviceButtonMapping \
	SetDeviceFocus/SetDeviceFocus \
	XSetDeviceModifierMapping/XSetDeviceModifierMapping \
	XSetDeviceMode/XSetDeviceMode \
	SelectExtensionEvent/SelectExtensionEvent \
	XSendExtensionEvent/XSendExtensionEvent \
	UngrabDevice/UngrabDevice \
	XUngrabDeviceButton/XUngrabDeviceButton \
	XUngrabDeviceKey/XUngrabDeviceKey
