include ../../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = $(XTS_LCFLAGS) $(XTS_CFLAGS)
LDADD = $(TCM) $(XTS_LLIBS) $(XTS_LIBS)

check_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:$(EXEEXT)=.c)
CLEANFILES = $(BUILT_SOURCES)

tprogs = \
	XChangeWindowAttributes/XChangeWindowAttributes \
	XConfigureWindow/XConfigureWindow \
	XCirculateSubwindows/XCirculateSubwindows \
	crcltsbwsd/crcltsbwsd \
	crcltsbwsu/crcltsbwsu \
	crtsmplwdw/crtsmplwdw \
	CreateWindow/CreateWindow \
	dfncrsr/dfncrsr \
	DestroySubwindows/DestroySubwindows \
	DestroyWindow/DestroyWindow \
	lwrwdw/lwrwdw \
	mprsd/mprsd \
	MapSubwindows/MapSubwindows \
	MapWindow/MapWindow \
	mvrszwdw/mvrszwdw \
	mvwdw/mvwdw \
	rstckwdws/rstckwdws \
	rswdw/rswdw \
	rszwdw/rszwdw \
	stwdwbg/stwdwbg \
	stwdwbgpxm/stwdwbgpxm \
	stwdwbrdr/stwdwbrdr \
	stwdwbrdrp/stwdwbrdrp \
	stwdwbrdrw/stwdwbrdrw \
	stwdwclrmp/stwdwclrmp \
	undfncrsr/undfncrsr \
	UnmapSubwindows/UnmapSubwindows \
	UnmapWindow/UnmapWindow \
	vslidfrmvs/vslidfrmvs
