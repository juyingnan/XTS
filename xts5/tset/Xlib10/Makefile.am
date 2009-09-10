include ../../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = $(XTS_LCFLAGS) $(XTS_CFLAGS)
LDADD = $(TCM) $(XTS_LLIBS) $(XTS_LIBS)

check_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:$(EXEEXT)=.c)
CLEANFILES = $(BUILT_SOURCES)

tprogs = \
	actvtscrns/actvtscrns \
	addhst/addhst \
	addhsts/addhsts \
	addtsvst/addtsvst \
	ChangeSaveSet/ChangeSaveSet \
	dsblaccssc/dsblaccssc \
	enblaccssc/enblaccssc \
	ForceScreenSaver/ForceScreenSaver \
	GrabServer/GrabServer \
	GetScreenSaver/GetScreenSaver \
	instllclrm/instllclrm \
	kllclnt/kllclnt \
	lsthsts/lsthsts \
	lstinstlld/lstinstlld \
	rmvfrmsvst/rmvfrmsvst \
	rmvhst/rmvhst \
	rmvhsts/rmvhsts \
	rprntwdw/rprntwdw \
	rstscrnsvr/rstscrnsvr \
	staccsscnt/staccsscnt \
	stscrnsvr/stscrnsvr \
	ungrbsrvr/ungrbsrvr \
	unnstllclr/unnstllclr
