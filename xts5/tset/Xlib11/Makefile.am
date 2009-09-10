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
	cnfgrrqst/cnfgrrqst \
	crcltntfy/crcltntfy \
	crcltrqst/crcltrqst \
	crtntfy/crtntfy \
	dstryntfy/dstryntfy \
	entrntfy/entrntfy \
	exps/exps \
	fcsin/fcsin \
	fcsot/fcsot \
	grphcsexps/grphcsexps \
	grvtyntfy/grvtyntfy \
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
