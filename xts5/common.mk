# Common variables and rules for building xts

##########################
# X RELEASE
##########################

#XT_X_RELEASE - The X11 Release, e.g. 4 for X11R4, 5 for X11R5, 6 for X11R6
#XT_X_RELEASE=4
#XT_X_RELEASE=5
#XT_X_RELEASE=6
XT_X_RELEASE=6

##########################
# Commands
##########################

# The code generator for turning .m files to .c files.
MC = $(top_builddir)/xts5/src/bin/mc/mc
.m.c:
	TET_ROOT='$(TET_ROOT)' $(MC) < $< > $@

# Test scenario executor - The tests are run by tcc where the argument
# is the scenario file (using the all target).
TCC = $(top_builddir)/src/tet3/tcc/tcc$(EXEEXT)
TESTS_ENVIRONMENT = TET_ROOT='$(TET_ROOT)' $(TCC) -e -j '' -i '' -s

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

# DEFINES - C compiler defines.
# If you wish to build the tests to make use of the XTEST extension, you
# will need to define XTESTEXTENSION.
# If you wish to test the Input Device Extension, you will need to define
# INPUTEXTENSION.
# SunOS	: DEFINES=
# ULTRIX: DEFINES=
# HP-UX	: DEFINES=-D_XOPEN_SOURCE -D_HPUX_SOURCE
# DYNIX	: DEFINES=
# A/UX  : DEFINES=
# AIXV3	: DEFINES=-D_XOPEN_SOURCE -D_ALL_SOURCE
# SVR4	: DEFINES=-D_XOPEN_SOURCE
# OSF1	: DEFINES=-D_XOPEN_SOURCE_EXTENDED -DXTESTEXTENSION
#DEFINES = -D_XOPEN_SOURCE -DXTESTEXTENSION -D_GNU_SOURCE
DEFINES = -DXTESTEXTENSION

# XP_DEFINES - C compiler defines specific to the X Protocol tests.
# This can be set as DEFINES, but you can build support for additional 
# connection methods beyond TCP/IP, using the following defines, 
# if XP_OPEN_DIS is XlibNoXtst.c (R4/R5 XOpenDisplay emulation):
#	-DDNETCONN - Connections can also use DECnet.
#	-DUNIXCONN - Connections can also use UNIX domain sockets.
# Refer to your documentation for building and installing Xlib on
# your platform.
# If XP_OPEN_DIS is one of XlibXtst.c or XlibOpaque.c then none of
# the defines listed above will be required.
# If you wish to test the Input Device Extension, you will need to define
# INPUTEXTENSION.
#
# SunOS	: XP_DEFINES=-DUNIXCONN
# ULTRIX: XP_DEFINES=-DUNIXCONN
# HP-UX	: XP_DEFINES=-D_XOPEN_SOURCE -D_HPUX_SOURCE -DUNIXCONN
# DYNIX	: XP_DEFINES=-D_POSIX_SOURCE -DUNIXCONN
# A/UX 	: XP_DEFINES=-D_POSIX_SOURCE -DUNIXCONN
# AIXV3	: XP_DEFINES=-D_XOPEN_SOURCE -D_ALL_SOURCE
# SVR4	: XP_DEFINES=-D_XOPEN_SOURCE
# OSF1	: XP_DEFINES=-D_XOPEN_SOURCE_EXTENDED -DUNIXCONN
#XP_DEFINES = -D_XOPEN_SOURCE -D_GNU_SOURCE
XP_DEFINES =

# XT_DEFINES - C compiler defines specific to the Xt Toolkit tests.
# If you wish to build the tests to make use of the XTEST extension, you
# will need to define XTESTEXTENSION.
# -DNeedFunctionPrototypes=1 is needed on many implementations to avoid
# compiler warnings about the definition of XtPointer.
# SunOS	: XP_DEFINES=-DNeedFunctionPrototypes=1
# ULTRIX: XP_DEFINES=-DNeedFunctionPrototypes=1
# HP-UX	: XP_DEFINES=-D_XOPEN_SOURCE -D_HPUX_SOURCE -DNeedFunctionPrototypes=1
# DYNIX	: XP_DEFINES=-D_POSIX_SOURCE -DNeedFunctionPrototypes=1
# A/UX 	: XP_DEFINES=-D_POSIX_SOURCE -DNeedFunctionPrototypes=1
# AIXV3	: XP_DEFINES=-D_XOPEN_SOURCE -D_ALL_SOURCE -DNeedFunctionPrototypes=1
# SVR4	: XP_DEFINES=-DNeedFunctionPrototypes=1 -D_XOPEN_SOURCE
# OSF1	: XT_DEFINES=-D_XOPEN_SOURCE_EXTENDED -DNeedFunctionPrototypes=1 -DXTESTEXTENSION
#XT_DEFINES = -D_XOPEN_SOURCE -DXTESTEXTENSION -D_GNU_SOURCE
XT_DEFINES = -DXTESTEXTENSION

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
COMMON_CFLAGS = -I$(top_srcdir)/include -I$(TETINCDIR) -I$(XTESTINCDIR) \
	-DXT_X_RELEASE='$(XT_X_RELEASE)' -DTET_LITE

# XTS_LCFLAGS - Flags for C compiler for generic xts5 programs
XTS_LCFLAGS = $(COMMON_CFLAGS) $(DEFINES)

# XP_LCFLAGS - Flags for C compiler specific to the X Protocol tests.
XP_LCFLAGS = $(COMMON_CFLAGS) $(XP_DEFINES)

# XT_LCFLAGS - Flags for C compiler specific to the Xt Toolkit tests.
XT_LCFLAGS = $(COMMON_CFLAGS) $(XT_DEFINES)

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
