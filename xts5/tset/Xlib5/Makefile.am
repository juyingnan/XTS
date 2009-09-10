include ../../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = $(XTS_LCFLAGS) $(XTS_CFLAGS)
LDADD = $(TCM) $(XTS_LLIBS) $(XTS_LIBS)

check_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:$(EXEEXT)=.c)
CLEANFILES = $(BUILT_SOURCES)

tprogs = \
	XChangeProperty/XChangeProperty \
	XConvertSelection/XConvertSelection \
	XDeleteProperty/XDeleteProperty \
	XGetAtomName/XGetAtomName \
	XGetGeometry/XGetGeometry \
	XGetSelectionOwner/XGetSelectionOwner \
	XGetWindowAttributes/XGetWindowAttributes \
	XGetWindowProperty/XGetWindowProperty \
	XInternAtom/XInternAtom \
	XListProperties/XListProperties \
	XQueryPointer/XQueryPointer \
	XQueryTree/XQueryTree \
	XRotateWindowProperties/XRotateWindowProperties \
	XSetSelectionOwner/XSetSelectionOwner \
	XTranslateCoordinates/XTranslateCoordinates
