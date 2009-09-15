# Common variables and rules for building xts

##########################
# Commands
##########################

# The code generator for turning .m files to .c files.
SUFFIXES = .m _m.c .c
MC = $(top_builddir)/xts5/src/bin/mc/mc
AM_V_mc = $(AM_V_mc_$(V))
AM_V_mc_ = $(AM_V_mc_$(AM_DEFAULT_VERBOSITY))
AM_V_mc_0 = @echo MC $@;
.m.c:
	$(AM_V_mc)TET_ROOT='$(TET_ROOT)' $(MC) -o $@ $<
.m_m.c:
	$(AM_V_mc)TET_ROOT='$(TET_ROOT)' $(MC) -m -o $@ $<

# Test scenario executor - The tests are run by tcc where the argument
# is the scenario name in the tet_scen file.
TCC = $(top_builddir)/src/tet3/tcc/tcc$(EXEEXT)
TESTS_ENVIRONMENT = TET_ROOT='$(TET_ROOT)' $(TCC) -e -j '' -i '' \
	-s $(top_srcdir)/xts5/tet_scen xts5

##################
# TET locations
##################

# The location of TET_ROOT.  This must not contain variable expansions.
# This must be set in the environment
TET_ROOT = $(abs_top_builddir)

# The location of the TET directories
TETSRC = $(top_srcdir)/src/tet3
TETBUILD = $(top_builddir)/src/tet3

# TETINCDIR - The directory containing the TET API headers.
TETINCDIR = $(TETSRC)/inc

# TCM - The Test Control Manager
TCM = $(TETBUILD)/tcm/libtcmmain.la

# TCMCHILD - The Test Control Manager for files executed by tet_exec. 
TCMCHILD = $(TETBUILD)/tcm/libtcmchild.la

# APILIB - The TET API library
APILIB = $(TETSRC)/apilib/libapi.la

####################
# Xtest variables
####################

# XTESTHOST - name of host on which test suite clients are to be executed.
# This may be set to the value returned by a command which can be executed
# using the PATH you have set on your host, or may be set to a specific name.
# This is used to produce a resource file named .Xdefaults-$(XTESTHOST) in the
# test execution directory.
# The resource file is created when building the test for XGetDefault.
# This parameter is only used in the Makefile of the test for XGetDefault.
# Examples are:
# XTESTHOST=`hostname`
# XTESTHOST=`uname -n`
# XTESTHOST=triton
#
# SVR4	: XTESTHOST=`uname -n`
XTESTHOST = `hostname`

# XTESTFONTDIR - location of installed VSW5 compiled fonts
XTESTFONTDIR = $(TET_ROOT)/xts5/fonts

# XTESTSRC
XTESTSRC = $(top_srcdir)/xts5
XTESTBUILD = $(top_builddir)/xts5

# XTTESTLIB - the Xt Tests' libraries
XTTESTLIB = $(XTESTBUILD)/src/libXtTest/libXtTest.a

# XTESTLIB - the VSW5 library
XTESTLIB = $(XTESTBUILD)/src/lib/libxtest.a

# XSTLIB - library for linking the X Protocol tests
XSTLIB = $(XTESTBUILD)/src/libproto/libXst.a

# XTESTFONTLIB - supplementary library with font metrics.
XTESTFONTLIB = $(XTESTBUILD)/fonts/libfont.a

# XTESTXIMLIB - supplementary library for input methods.
XTESTXIMLIB = $(XTESTBUILD)/src/xim/libximtest.a

# XTESTINCDIR - the VSW5 header file directory
XTESTINCDIR = $(XTESTSRC)/include

################################
##### C compiler Directives Section
################################

# XP_OPEN_DIS - A choice of which code to build in the X Protocol library 
# to make an X server connection.
# This must be set to one of three possible values:
#
#	XlibXtst.c	Your Xlib includes enhancements to _XConnectDisplay 
#			ensuring maximum portable protocol test coverage.
#	XlibOpaque.c	You have a normal R4 Xlib or early R5 Xlib which you 
#			cannot patch to include the enhancements to 
#			_XConnectDisplay, and you cannot emulate these by 
#			building XlibNoXtst.c, so only client-native testing 
#			can be done portably, and no failure testing of 
#			XOpenDisplay can be done.
#			This option uses XOpenDisplay to make the connection, 
#			from which the file descriptor is recovered for 
#			our own use. XCloseDisplay shuts down the connection.
#	XlibNoXtst.c	As for XlibOpaque.c but you can use the R4/R5 
#			connection emulation supplied. (Note: R4/R5 independent)
#			This will ensure maximum protocol test coverage
#			but may not be portable to all platforms.
#
# Reasons for not being able to build XlibNoXtst.c might include:
# i)  different interfaces to connection setup and connection read/write;
# ii) different access control mechanisms.
# Refer to your Xlib documentation for further details.
#
XP_OPEN_DIS=XlibXtst.c
#XP_OPEN_DIS=XlibNoXtst.c
#XP_OPEN_DIS=XlibOpaque.c

# CFLAGS - Flags for C compiler
#
COMMON_CFLAGS = -I$(top_srcdir)/include -I$(TETINCDIR) -I$(XTESTINCDIR)

# XTS_LCFLAGS - Flags for C compiler for generic xts5 programs
XTS_LCFLAGS = $(COMMON_CFLAGS)

# XP_LCFLAGS - Flags for C compiler specific to the X Protocol tests.
XP_LCFLAGS = $(COMMON_CFLAGS)

# XT_LCFLAGS - Flags for C compiler specific to the Xt Toolkit tests.
XT_LCFLAGS = $(COMMON_CFLAGS)

# LIBS - List of libraries.
#
# XTS_LLIBS - Libraries for generic xts5 programs
XTS_LLIBS = $(XTESTXIMLIB) $(XTESTLIB) $(XTESTFONTLIB) $(APILIB)

# XP_LIBS - List of libraries specific to the X Protocol tests.
XP_LLIBS = $(XSTLIB) $(XTESTLIB) $(XTESTFONTLIB) $(APILIB)

# XT_LIBS - List of libraries specific to the Xt Toolkit tests.
XT_LLIBS = $(XTESTLIB) $(XTTESTLIB) $(APILIB)

################################
##### Pixel Validation Section.
################################

PVXTESTLIB = ${XTESTLIBDIR}/libxtstpv.a
PIXLIB = ${XTESTLIBDIR}/libpvt.a
PVLIBS = ${PVXTESTLIB} ${XTESTFONTLIB} ${PIXLIB} ${APILIB}

# SYSMATHLIB - system math library.  Directive to be given to the C compiler
# to cause the maths routines to be available.
# XXX - handle this in configure.ac
SYSMATHLIB = -lm

################################
##### Lint Section.
################################

LINT = lint
LINTFLAGS = $(INCLUDES) $(DEFINES) -u -n
LINTXTEST = $(XTESTLIBDIR)/llib-lxtest.ln
LINTXST = $(XTESTLIBDIR)/llib-lXst.ln
LINTFONTS = $(XTESTLIBDIR)/llib-lfonts.ln
LINTTCM = $(XTESTLIBDIR)/llib-ltcm.ln
LINTTCMC = $(XTESTLIBDIR)/llib-ltcmc.ln
LINTLIBS = $(LINTXTEST) $(LINTFONTS)

XP_LINTFLAGS = $(INCLUDES) $(XP_DEFINES) -u -n
XP_LINTLIBS = $(LINTXST) $(LINTXTEST) $(LINTFONTS)
