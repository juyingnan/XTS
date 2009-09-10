include ../../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = $(XTS_LCFLAGS) $(XTS_CFLAGS)
LDADD = $(TCM) $(XTS_LLIBS) $(XTS_LIBS)

check_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:$(EXEEXT)=.c)
CLEANFILES = $(BUILT_SOURCES)

tprogs = \
	ButtonPress/ButtonPress \
	ButtonRelease/ButtonRelease \
	ClientMessage/ClientMessage \
	ColormapNotify/ColormapNotify \
	ConfigureNotify/ConfigureNotify \
	ConfigureRequest/ConfigureRequest \
	CirculateNotify/CirculateNotify \
	CirculateRequest/CirculateRequest \
	CreateNotify/CreateNotify \
	DestroyNotify/DestroyNotify \
	EnterNotify/EnterNotify \
	Expose/Expose \
	FocusIn/FocusIn \
	FocusOut/FocusOut \
	GraphicsExpose/GraphicsExpose \
	GravityNotify/GravityNotify \
	kympntfy/kympntfy \
	kyprss/kyprss \
	kyrls/kyrls \
	lvntfy/lvntfy \
	mpntfy/mpntfy \
	mppngntfy/mppngntfy \
	mprqst/mprqst \
	mtnntfy/mtnntfy \
	nexps/nexps \
	prprtyntfy/prprtyntfy \
	rprntntfy/rprntntfy \
	rszrqst/rszrqst \
	slctnclr/slctnclr \
	slctnntfy/slctnntfy \
	slctnrqst/slctnrqst \
	unmpntfy/unmpntfy \
	vsbltyntfy/vsbltyntfy
