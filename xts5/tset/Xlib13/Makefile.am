include ../../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = $(XTS_LCFLAGS) $(XTS_CFLAGS)
LDADD = $(TCM) $(XTS_LLIBS) $(XTS_LIBS)

check_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:$(EXEEXT)=.c)
CLEANFILES = $(BUILT_SOURCES)

tprogs = \
	allwevnts/allwevnts \
	atrptoff/atrptoff \
	atrpton/atrpton \
	bll/bll \
	chngactvpn/chngactvpn \
	chngkybrdc/chngkybrdc \
	chngkybrdm/chngkybrdm \
	chngpntrcn/chngpntrcn \
	dltmdfrmpe/dltmdfrmpe \
	dsplykycds/dsplykycds \
	frmdfrmp/frmdfrmp \
	grbbttn/grbbttn \
	grbky/grbky \
	grbkybrd/grbkybrd \
	grbpntr/grbpntr \
	gtinptfcs/gtinptfcs \
	gtkybrdcnt/gtkybrdcnt \
	gtkybrdmpp/gtkybrdmpp \
	gtmdfrmppn/gtmdfrmppn \
	gtpntrcntr/gtpntrcntr \
	gtpntrmppn/gtpntrmppn \
	insrtmdfrm/insrtmdfrm \
	nwmdfrmp/nwmdfrmp \
	qrykymp/qrykymp \
	stinptfcs/stinptfcs \
	stmdfrmppn/stmdfrmppn \
	stpntrmppn/stpntrmppn \
	ungrbbttn/ungrbbttn \
	ungrbky/ungrbky \
	ungrbkybrd/ungrbkybrd \
	ungrbpntr/ungrbpntr \
	wrppntr/wrppntr
