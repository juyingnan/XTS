include ../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = $(XTS_LCFLAGS) $(XTS_CFLAGS)
LDADD = $(TCM) $(XTS_LLIBS) $(XTS_LIBS)

libexec_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:$(EXEEXT)=.c)
CLEANFILES = $(BUILT_SOURCES)

tprogs = \
	XActivateScreenSaver \
	XAddHost \
	XAddHosts \
	XAddToSaveSet \
	XChangeSaveSet \
	XDisableAccessControl \
	XEnableAccessControl \
	XForceScreenSaver \
	XGrabServer \
	XGetScreenSaver \
	XInstallColormap \
	XKillClient \
	XListHosts \
	XListInstalledColormaps \
	XRemoveFromSaveSet \
	XRemoveHost \
	XRemoveHosts \
	XReparentWindow \
	XResetScreenSaver \
	XSetAccessControl \
	XSetScreenSaver \
	XUngrabServer \
	XUninstallColormap
