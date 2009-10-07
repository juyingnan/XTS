include ../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = $(XTS_LCFLAGS) $(XTS_CFLAGS)
LDADD = $(TCM) $(XTS_LLIBS) $(XTS_LIBS)

testprogdir = $(libexecdir)/$(subdir)
nobase_testprog_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:$(EXEEXT)=.c)
CLEANFILES = $(BUILT_SOURCES)

tprogs = \
	XChangeProperty \
	XConvertSelection \
	XDeleteProperty \
	XGetAtomName \
	XGetGeometry \
	XGetSelectionOwner \
	XGetWindowAttributes \
	XGetWindowProperty \
	XInternAtom \
	XListProperties \
	XQueryPointer \
	XQueryTree \
	XRotateWindowProperties \
	XSetSelectionOwner \
	XTranslateCoordinates
