include ../../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = $(XTS_LCFLAGS) $(XTS_CFLAGS)
LDADD = $(TCM) $(XTS_LLIBS) $(XTS_LIBS)

check_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:$(EXEEXT)=.c)
CLEANFILES = $(BUILT_SOURCES)

defstr_defstr_LDADD = $(LDADD) $(top_builddir)/xts5/src/libXR5/libXR5.a

tprogs = \
	XAllocClassHint/XAllocClassHint \
	allcicnsz/allcicnsz \
	allcstndrd/allcstndrd \
	allcszhnts/allcszhnts \
	allcwmhnts/allcwmhnts \
	defstr/defstr \
	frstrlst/frstrlst \
	ftchnm/ftchnm \
	gtclsshnt/gtclsshnt \
	gtcmmnd/gtcmmnd \
	gticnnm/gticnnm \
	gticnszs/gticnszs \
	gtrgbclrmp/gtrgbclrmp \
	gttrnsntfr/gttrnsntfr \
	gttxtprprt/gttxtprprt \
	gtwmclntmc/gtwmclntmc \
	gtwmclrmpw/gtwmclrmpw \
	gtwmhnts/gtwmhnts \
	gtwmicnnm/gtwmicnnm \
	gtwmnm/gtwmnm \
	gtwmnrmlhn/gtwmnrmlhn \
	gtwmprtcls/gtwmprtcls \
	gtwmszhnts/gtwmszhnts \
	icnfywdw/icnfywdw \
	rcnfgrwmwd/rcnfgrwmwd \
	stclsshnt/stclsshnt \
	stcmmnd/stcmmnd \
	sticnnm/sticnnm \
	sticnszs/sticnszs \
	strgbclrmp/strgbclrmp \
	strlstttxt/strlstttxt \
	strnm/strnm \
	sttrnsntfr/sttrnsntfr \
	sttxtprprt/sttxtprprt \
	stwmclntmc/stwmclntmc \
	stwmclrmpw/stwmclrmpw \
	stwmhnts/stwmhnts \
	stwmicnnm/stwmicnnm \
	stwmnm/stwmnm \
	stwmnrmlhn/stwmnrmlhn \
	stwmprprts/stwmprprts \
	stwmprtcls/stwmprtcls \
	stwmszhnts/stwmszhnts \
	txtprprtyt/txtprprtyt \
	wthdrwwdw/wthdrwwdw

# Auxiliary programs run from tests
check_PROGRAMS += \
	stwmprprts/Test1 \
	stwmprprts/Test2
stwmprprts_Test1_LDADD = $(TCMCHILD) $(XTS_LLIBS) $(XTS_LIBS)
stwmprprts_Test2_LDADD = $(TCMCHILD) $(XTS_LLIBS) $(XTS_LIBS)
