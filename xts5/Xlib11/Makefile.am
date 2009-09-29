include ../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = $(XTS_LCFLAGS) $(XTS_CFLAGS)
LDADD = $(TCM) $(XTS_LLIBS) $(XTS_LIBS)

libexec_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:$(EXEEXT)=.c)
CLEANFILES = $(BUILT_SOURCES)

tprogs = \
	ButtonPress \
	ButtonRelease \
	ClientMessage \
	ColormapNotify \
	ConfigureNotify \
	ConfigureRequest \
	CirculateNotify \
	CirculateRequest \
	CreateNotify \
	DestroyNotify \
	EnterNotify \
	Expose \
	FocusIn \
	FocusOut \
	GraphicsExpose \
	GravityNotify \
	KeymapNotify \
	KeyPress \
	KeyRelease \
	LeaveNotify \
	MapNotify \
	MappingNotify \
	MapRequest \
	MotionNotify \
	NoExpose \
	PropertyNotify \
	ReparentNotify \
	ResizeRequest \
	SelectionClear \
	SelectionNotify \
	SelectionRequest \
	UnmapNotify \
	VisibilityNotify
