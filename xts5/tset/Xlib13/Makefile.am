include ../../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = $(XTS_LCFLAGS) $(XTS_CFLAGS)
LDADD = $(TCM) $(XTS_LLIBS) $(XTS_LIBS)

check_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:$(EXEEXT)=.c)
CLEANFILES = $(BUILT_SOURCES)

tprogs = \
	AllowEvents/AllowEvents \
	atrptoff/atrptoff \
	atrpton/atrpton \
	Bell/Bell \
	ChangeActivePointerGrab/ChangeActivePointerGrab \
	ChangeKeyboardControl/ChangeKeyboardControl \
	ChangeKeyboardMapping/ChangeKeyboardMapping \
	ChangePointerControl/ChangePointerControl \
	dltmdfrmpe/dltmdfrmpe \
	dsplykycds/dsplykycds \
	frmdfrmp/frmdfrmp \
	GrabButton/GrabButton \
	GrabKey/GrabKey \
	GrabKeyboard/GrabKeyboard \
	GrabPointer/GrabPointer \
	GetInputFocus/GetInputFocus \
	GetKeyboardControl/GetKeyboardControl \
	GetKeyboardMapping/GetKeyboardMapping \
	GetModifierMapping/GetModifierMapping \
	GetPointerControl/GetPointerControl \
	GetPointerMapping/GetPointerMapping \
	insrtmdfrm/insrtmdfrm \
	nwmdfrmp/nwmdfrmp \
	QueryKeymap/QueryKeymap \
	stinptfcs/stinptfcs \
	stmdfrmppn/stmdfrmppn \
	stpntrmppn/stpntrmppn \
	ungrbbttn/ungrbbttn \
	ungrbky/ungrbky \
	ungrbkybrd/ungrbkybrd \
	ungrbpntr/ungrbpntr \
	wrppntr/wrppntr
