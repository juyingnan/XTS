include ../../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = $(XTS_LCFLAGS) $(XTS_CFLAGS)
LDADD = $(TCM) $(XTS_LLIBS) $(XTS_LIBS)

check_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:$(EXEEXT)=.c)
CLEANFILES = $(BUILT_SOURCES)

tprogs = \
	XAllowDeviceEvents/XAllowDeviceEvents \
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
	grbdev/grbdev \
	grbdvbtn/grbdvbtn \
	grbdvky/grbdvky \
	gtbtnmppn/gtbtnmppn \
	gtdvkmap/gtdvkmap \
	gtdvmmap/gtdvmmap \
	gtdvmtnev/gtdvmtnev \
	gtslctevnt/gtslctevnt \
	listdev/listdev \
	misc/misc \
	opendev/opendev \
	querydvst/querydvst \
	setdval/setdval \
	setdvbmap/setdvbmap \
	setdvfocus/setdvfocus \
	setdvmmap/setdvmmap \
	setdvmode/setdvmode \
	slextevnt/slextevnt \
	sndextevnt/sndextevnt \
	ungrbdv/ungrbdv \
	ungrbdvbtn/ungrbdvbtn \
	ungrbdvky/ungrbdvky
