include ../../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = $(XTS_LCFLAGS) $(XTS_CFLAGS)
LDADD = $(TCM) $(XTS_LLIBS) $(XTS_LIBS)

check_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:$(EXEEXT)=.c)
CLEANFILES = $(BUILT_SOURCES)

tprogs = \
	XCheckIfEvent/XCheckIfEvent \
	XCheckMaskEvent/XCheckMaskEvent \
	XCheckTypedEvent/XCheckTypedEvent \
	XCheckTypedWindowEvent/XCheckTypedWindowEvent \
	XCheckWindowEvent/XCheckWindowEvent \
	XDisplayMotionBufferSize/XDisplayMotionBufferSize \
	XDisplayName/XDisplayName \
	XEventsQueued/XEventsQueued \
	XFlush/XFlush \
	XGetErrorDatabaseText/XGetErrorDatabaseText \
	XGetErrorText/XGetErrorText \
	XGetMotionEvents/XGetMotionEvents \
	XIfEvent/XIfEvent \
	XMaskEvent/XMaskEvent \
	XNextEvent/XNextEvent \
	XPeekEvent/XPeekEvent \
	XPeekIfEvent/XPeekIfEvent \
	XPending/XPending \
	XPutBackEvent/XPutBackEvent \
	XSelectInput/XSelectInput \
	XSendEvent/XSendEvent \
	staftrfnct/staftrfnct \
	sterrrhndl/sterrrhndl \
	stioerrrhn/stioerrrhn \
	sync/sync \
	synchrnz/synchrnz \
	wdwevnt/wdwevnt

# Auxiliary programs run from tests
check_PROGRAMS += XDisplayName/Test1
XDisplayName_Test1_LDADD = $(TCMCHILD) $(XTS_LLIBS) $(XTS_LIBS)
