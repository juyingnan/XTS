include ../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = $(XTS_LCFLAGS) $(XTS_CFLAGS)
LDADD = $(TCM) $(XTS_LLIBS) $(XTS_LIBS)

libexec_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:$(EXEEXT)=.c)
CLEANFILES = $(BUILT_SOURCES)

tprogs = \
	XCheckIfEvent \
	XCheckMaskEvent \
	XCheckTypedEvent \
	XCheckTypedWindowEvent \
	XCheckWindowEvent \
	XDisplayMotionBufferSize \
	XDisplayName/XDisplayName \
	XEventsQueued \
	XFlush \
	XGetErrorDatabaseText \
	XGetErrorText \
	XGetMotionEvents \
	XIfEvent \
	XMaskEvent \
	XNextEvent \
	XPeekEvent \
	XPeekIfEvent \
	XPending \
	XPutBackEvent \
	XSelectInput \
	XSendEvent \
	XSetAfterFunction \
	XSetErrorHandler \
	XSetIOErrorHandler \
	XSync \
	XSynchronize \
	XWindowEvent

# Auxiliary programs run from tests
libexec_PROGRAMS += XDisplayName/Test1
XDisplayName_Test1_LDADD = $(TCMCHILD) $(XTS_LLIBS) $(XTS_LIBS)
