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
	chgdvprop/chgdvprop \
	XChangeFeedbackControl/XChangeFeedbackControl \
	chgkbd/chgkbd \
	chgptr/chgptr \
	chngdvkmap/chngdvkmap \
	closdev/closdev \
	dvbell/dvbell \
	getdvmmap/getdvmmap \
	getfctl/getfctl \
	getvers/getvers \
	grbdev/grbdev \
	grbdvbtn/grbdvbtn \
	grbdvky/grbdvky \
	gtbtnmppn/gtbtnmppn \
	gtdvctl/gtdvctl \
	gtdvfcs/gtdvfcs \
	gtdvmtnev/gtdvmtnev \
	gtdvprop/gtdvprop \
	gtkeymppn/gtkeymppn \
	gtslctexev/gtslctexev \
	listdev/listdev \
	misc/misc \
	opendev/opendev \
	qrydvstat/qrydvstat \
	setdval/setdval \
	setdvbmap/setdvbmap \
	setdvfcs/setdvfcs \
	setdvmmap/setdvmmap \
	setdvmode/setdvmode \
	slctexevnt/slctexevnt \
	sndextevnt/sndextevnt \
	ungrbdev/ungrbdev \
	ungrbdvbtn/ungrbdvbtn \
	ungrbdvky/ungrbdvky
