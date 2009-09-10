include ../../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = $(XTS_LCFLAGS) $(XTS_CFLAGS)
LDADD = $(TCM) $(XTS_LLIBS) $(XTS_LIBS)

check_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:$(EXEEXT)=.c)
CLEANFILES = $(BUILT_SOURCES)

tprogs = \
	XChangeProperty/XChangeProperty \
	ConvertSelection/ConvertSelection \
	DeleteProperty/DeleteProperty \
	GetAtomName/GetAtomName \
	GetGeometry/GetGeometry \
	GetSelectionOwner/GetSelectionOwner \
	GetWindowAttributes/GetWindowAttributes \
	gtwdwprprt/gtwdwprprt \
	InternAtom/InternAtom \
	ListProperties/ListProperties \
	QueryPointer/QueryPointer \
	QueryTree/QueryTree \
	rttwdwprpr/rttwdwprpr \
	SetSelectionOwner/SetSelectionOwner \
	trnsltcrdn/trnsltcrdn
