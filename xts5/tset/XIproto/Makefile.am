include ../../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = $(XP_LCFLAGS) $(XP_CFLAGS)
LDADD = $(TCM) $(XP_LLIBS) $(XP_LIBS)

check_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:$(EXEEXT)=.c)
CLEANFILES = $(BUILT_SOURCES)

tprogs = \
	XAllowDeviceEvents/XAllowDeviceEvents \
	XChangeDeviceControl/XChangeDeviceControl \
	ChangeDeviceDontPropagateList/ChangeDeviceDontPropagateList \
	XChangeFeedbackControl/XChangeFeedbackControl \
	XChangeKeyboardDevice/XChangeKeyboardDevice \
	XChangePointerDevice/XChangePointerDevice \
	XChangeDeviceKeyMapping/XChangeDeviceKeyMapping \
	XCloseDevice/XCloseDevice \
	XDeviceBell/XDeviceBell \
	GetDeviceModifierMapping/GetDeviceModifierMapping \
	XGetFeedbackControl/XGetFeedbackControl \
	XGetExtensionVersion/XGetExtensionVersion \
	XGrabDevice/XGrabDevice \
	XGrabDeviceButton/XGrabDeviceButton \
	XGrabDeviceKey/XGrabDeviceKey \
	XGetDeviceButtonMapping/XGetDeviceButtonMapping \
	gtdvctl/gtdvctl \
	gtdvfcs/gtdvfcs \
	XGetDeviceMotionEvents/XGetDeviceMotionEvents \
	gtdvprop/gtdvprop \
	gtkeymppn/gtkeymppn \
	gtslctexev/gtslctexev \
	XListInputDevices/XListInputDevices \
	Miscellaneous/Miscellaneous \
	XOpenDevice/XOpenDevice \
	qrydvstat/qrydvstat \
	XSetDeviceValuators/XSetDeviceValuators \
	XSetDeviceButtonMapping/XSetDeviceButtonMapping \
	setdvfcs/setdvfcs \
	XSetDeviceModifierMapping/XSetDeviceModifierMapping \
	XSetDeviceMode/XSetDeviceMode \
	slctexevnt/slctexevnt \
	XSendExtensionEvent/XSendExtensionEvent \
	ungrbdev/ungrbdev \
	XUngrabDeviceButton/XUngrabDeviceButton \
	XUngrabDeviceKey/XUngrabDeviceKey
