include ../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = -I$(top_srcdir)/include \
	-I$(top_srcdir)/src/tet3/inc \
	-I$(top_srcdir)/xts5/include \
	$(XTS_CFLAGS)
LDADD = $(top_builddir)/src/tet3/tcm/libtcmmain.la \
	$(top_builddir)/xts5/src/xim/libximtest.la \
	$(top_builddir)/xts5/src/lib/libxtest.la \
	$(top_builddir)/xts5/fonts/libfont.la \
	$(top_builddir)/src/tet3/apilib/libapi.la \
	$(top_builddir)/src/tet3/apilib/libapi_s.la \
	$(XTS_LIBS)

testprogdir = $(libexecdir)/$(subdir)
nobase_testprog_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:=.c)
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
