include ../../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = $(XTS_LCFLAGS) $(XTS_CFLAGS)
LDADD = $(TCM) $(XTS_LLIBS) $(XTS_LIBS)

check_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:$(EXEEXT)=.c)
CLEANFILES = $(BUILT_SOURCES)

tprogs = \
	XActivateScreenSaver/XActivateScreenSaver \
	XAddHost/XAddHost \
	XAddHosts/XAddHosts \
	XAddToSaveSet/XAddToSaveSet \
	XChangeSaveSet/XChangeSaveSet \
	XDisableAccessControl/XDisableAccessControl \
	XEnableAccessControl/XEnableAccessControl \
	XForceScreenSaver/XForceScreenSaver \
	XGrabServer/XGrabServer \
	XGetScreenSaver/XGetScreenSaver \
	XInstallColormap/XInstallColormap \
	XKillClient/XKillClient \
	XListHosts/XListHosts \
	XListInstalledColormaps/XListInstalledColormaps \
	rmvfrmsvst/rmvfrmsvst \
	rmvhst/rmvhst \
	rmvhsts/rmvhsts \
	ReparentWindow/ReparentWindow \
	rstscrnsvr/rstscrnsvr \
	SetAccessControl/SetAccessControl \
	SetScreenSaver/SetScreenSaver \
	UngrabServer/UngrabServer \
	UninstallColormap/UninstallColormap
