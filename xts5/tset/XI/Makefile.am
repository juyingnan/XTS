include ../../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = $(XTS_LCFLAGS) $(XTS_CFLAGS)
LDADD = $(TCM) $(XTS_LLIBS) $(XTS_LIBS)

check_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:$(EXEEXT)=.c)
CLEANFILES = $(BUILT_SOURCES)

tprogs = \
	alldvevnts/alldvevnts \
	chgdvctl/chgdvctl \
	chgfctl/chgfctl \
	chgkbd/chgkbd \
	chgprop/chgprop \
	chgptr/chgptr \
	chngdvkmap/chngdvkmap \
	closdev/closdev \
	dvbell/dvbell \
	getdctl/getdctl \
	getfctl/getfctl \
	getfocus/getfocus \
	getprop/getprop \
	getvers/getvers \
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
