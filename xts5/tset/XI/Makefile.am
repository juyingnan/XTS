include ../../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = $(XTS_LCFLAGS) $(XTS_CFLAGS)
LDADD = $(TCM) $(XTS_LLIBS) $(XTS_LIBS)

check_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:$(EXEEXT)=.c)
CLEANFILES = $(BUILT_SOURCES)

tprogs = \
	AllowDeviceEvents/AllowDeviceEvents \
	XChangeDeviceControl/XChangeDeviceControl \
	XChangeFeedbackControl/XChangeFeedbackControl \
	XChangeKeyboardDevice/XChangeKeyboardDevice \
	XChangeDeviceDontPropagateList/XChangeDeviceDontPropagateList \
	XChangePointerDevice/XChangePointerDevice \
	XChangeDeviceKeyMapping/XChangeDeviceKeyMapping \
	XCloseDevice/XCloseDevice \
	XDeviceBell/XDeviceBell \
	XGetDeviceControl/XGetDeviceControl \
	XGetFeedbackControl/XGetFeedbackControl \
	XGetDeviceFocus/XGetDeviceFocus \
	XGetDeviceDontPropagateList/XGetDeviceDontPropagateList \
	XGetExtensionVersion/XGetExtensionVersion \
	XGrabDevice/XGrabDevice \
	XGrabDeviceButton/XGrabDeviceButton \
	XGrabDeviceKey/XGrabDeviceKey \
	XGetDeviceButtonMapping/XGetDeviceButtonMapping \
	XGetDeviceKeyMapping/XGetDeviceKeyMapping \
	XGetDeviceModifierMapping/XGetDeviceModifierMapping \
	XGetDeviceMotionEvents/XGetDeviceMotionEvents \
	XGetSelectedExtensionEvents/XGetSelectedExtensionEvents \
	XListInputDevices/XListInputDevices \
	Miscellaneous/Miscellaneous \
	XOpenDevice/XOpenDevice \
	XQueryDeviceState/XQueryDeviceState \
	XSetDeviceValuators/XSetDeviceValuators \
	XSetDeviceButtonMapping/XSetDeviceButtonMapping \
	XSetDeviceFocus/XSetDeviceFocus \
	XSetDeviceModifierMapping/XSetDeviceModifierMapping \
	XSetDeviceMode/XSetDeviceMode \
	XSelectExtensionEvent/XSelectExtensionEvent \
	XSendExtensionEvent/XSendExtensionEvent \
	XUngrabDevice/XUngrabDevice \
	XUngrabDeviceButton/XUngrabDeviceButton \
	XUngrabDeviceKey/XUngrabDeviceKey
