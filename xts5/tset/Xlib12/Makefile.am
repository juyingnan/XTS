include ../../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = $(XTS_LCFLAGS) $(XTS_CFLAGS)
LDADD = $(TCM) $(XTS_LLIBS) $(XTS_LIBS)

check_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:$(EXEEXT)=.c)
CLEANFILES = $(BUILT_SOURCES)

tprogs = \
	chckifevnt/chckifevnt \
	chckmskevn/chckmskevn \
	chcktypdev/chcktypdev \
	chcktypdwd/chcktypdwd \
	chckwdwevn/chckwdwevn \
	dsplymtnbf/dsplymtnbf \
	dsplynm/dsplynm \
	evntsqd/evntsqd \
	flsh/flsh \
	gterrrdtbs/gterrrdtbs \
	gterrrtxt/gterrrtxt \
	GetMotionEvents/GetMotionEvents \
	ifevnt/ifevnt \
	mskevnt/mskevnt \
	nxtevnt/nxtevnt \
	pkevnt/pkevnt \
	pkifevnt/pkifevnt \
	pndng/pndng \
	ptbckevnt/ptbckevnt \
	slctinpt/slctinpt \
	SendEvent/SendEvent \
	staftrfnct/staftrfnct \
	sterrrhndl/sterrrhndl \
	stioerrrhn/stioerrrhn \
	sync/sync \
	synchrnz/synchrnz \
	wdwevnt/wdwevnt

# Auxiliary programs run from tests
check_PROGRAMS += dsplynm/Test1
dsplynm_Test1_LDADD = $(TCMCHILD) $(XTS_LLIBS) $(XTS_LIBS)
