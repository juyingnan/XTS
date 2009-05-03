# Common variables and rules for building xts

#########################
# TET Parameters
#########################

# TET_BUILD_TOOL - The program to use as the build tool.
# This should normally be the wbuild program supplied as part
# of the test suite.
TET_BUILD_TOOL = wbuild

# TET_BUILD_FILE - This is intended to be used for the arguments to the TET
# build tool - this should be empty, since no arguments are accepted by pmake.
TET_BUILD_FILE =

# TET_CLEAN_TOOL - The program to use as the TET clean tool.
# This should normally be the wclean program supplied as part 
# of the test suite.
TET_CLEAN_TOOL = wbuild

# TET_CLEAN_FILE - This is intended to be used for the arguments to the TET
# clean tool - this *must* be 'clean'
TET_CLEAN_FILE = clean

# TET_OUTPUT_CAPTURE - This must be set to True.
TET_OUTPUT_CAPTURE = TRUE

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

# TSORT - Set to cat if archiver inserts its own symbol table
# or the system uses ranlib
TSORT=cat

# LORDER - Set to echo if archiver inserts its own symbol table
# or the system uses ranlib
LORDER=echo

# CODEMAKER - this is the utility supplied with the test suite
# to extract the code from the combined source files.
CODEMAKER=mc

##################
# TET locations
##################

# The location of TET_ROOT.  This must not contain variable expansions.
# This must be set in the environment
TET_ROOT = $(abs_top_srcdir)

# The location of the TET directories
TETBASE = $(top_srcdir)/src/tet3
TETBUILD = $(top_builddir)/src/tet3

# TETINCDIR - The directory containing the TET API headers.
#TETINCDIR = $(TETBASE)/inc/posix_c
#TETINCDIR = $(TETBASE)/inc/tet3
TETINCDIR = $(TETBASE)/inc

# TCM - The Test Control Manager
#TCM = $(TETLIB)/tcm/tcm.o
TCM = $(TETBASE)/tcm/tcm.c $(TETBASE)/tcm/dtcm.c

# TCMCHILD - The Test Control Manager for files executed by tet_exec. 
#TCMCHILD = $(TETLIB)/tcmchild.o
TCMCHILD = $(TETBASE)/tcm/tcmchild.c

# APILIB - The TET API library
APILIB = $(TETBASE)/apilib/libapi.la

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
XTESTHOST=`hostname`

# XTESTFONTDIR - location of installed VSW5 compiled fonts
#XTESTFONTDIR=/usr/lib/X11/fonts/xtest
XTESTFONTDIR = $(TET_ROOT)/xts5/fonts

# XTESTROOT
XTESTROOT = $(top_srcdir)/xts5
XTESTBUILD = $(top_builddir)/xts5

# XTESTLIBDIR - location of the VSW5 library files
XTESTLIBDIR = $(XTESTBUILD)/lib

# XTTESTLIB - the Xt Tests' libraries
#XTTESTLIB = $(XTESTLIBDIR)/libXtTest.a
XTTESTLIB = $(XTESTBUILD)/src/libXtTest/libXtTest.a

# XTESTLIB - the VSW5 library
#XTESTLIB = $(XTESTLIBDIR)/libxtest.a
XTESTLIB = $(XTESTBUILD)/src/lib/libxtest.a

# XSTLIB - library for linking the X Protocol tests
#XSTLIB = ${XTESTLIBDIR}/libXst.a
XSTLIB = $(XTESTBUILD)/src/libproto/libXst.a

# XTESTFONTLIB - supplementary library with font metrics.
#XTESTFONTLIB = $(XTESTLIBDIR)/libfont.a
XTESTFONTLIB = $(XTESTBUILD)/fonts/libfont.a

# XTESTXIMLIB - supplementary library for input methods.
#XTESTXIMLIB = $(XTESTLIBDIR)/libximtest.a
XTESTXIMLIB = $(XTESTBUILD)/src/xim/libximtest.a

# XTESTINCDIR - the VSW5 header file directory
XTESTINCDIR = $(XTESTROOT)/include

# XTESTBIN - location for VSW5 binaries.
XTESTBIN = $(XTESTROOT)/bin

####################
# System files
####################

# SYSLIBS - Any system libraries that are needed, will almost certainly
# include Xlib.
# If you wish to build the tests to make use of the XTEST extension, you
# will need to include the X extension library and the XTEST library.
# If you wish to build the tests to test the Input Device extension, you
# will need to include the necessary libraries for it.
# These are usually included by adding -lXi -lXext before -lX11.
# SVR4	: SYSLIBS=-lXi -lXtst -lXext -lX11 -lsocket -lnsl
# OSF1  : SYSLIBS=-lXi -lXtst -lXext -lX11
SYSLIBS=-lXi -lXtst -lXext -lX11

# XP_SYSLIBS - Any system libraries that are needed, to link the
# X Protocol tests. This will include Xlib, since libXst.a
# (which is part of the test suite) will include at least a call
# on XOpenDisplay.
# If you wish to build the tests to test the Input Device extension, you
# will need to include the necessary libraries for it.
# These are usually included by adding -lXi -lXext before -lX11.
# SVR4	: XP_SYSLIBS=-L/X11/lib -lXi -lXext -lX11 -lnsl
# OSF1	: XP_SYSLIBS=-lXi -lXtst -lXext -lX11
XP_SYSLIBS=-lXi -lXtst -lXext -lX11

# XT_SYSLIBS - Any system libraries that are needed, to link the
# Xt Toolkit tests. This will include Xlib and Xt.
# Do not include Athena widgets in this list (see XT_ATHENA below)
# If you wish to build the tests to make use of the XTEST extension, you
# will need to include the X extension library and the XTEST library.
# SVR4	: XT_SYSLIBS=-L/X11/lib -lXext -lXt -lX11 -lnsl
# OSF1  : XT_SYSLIBS= -lXt -lXtst -lXext -lX11
XT_SYSLIBS=-lXt -lXtst -lXext -lX11

# XT_ATHENA - System libraries that are needed provide the Athena
# widgets.
# If your implementation provides Athena widgets:
# XT_ATHENA=-lXaw -lXmu
# If your implementation does not provide Athena widgets, use the
# VSW5 provided versions:
#XT_ATHENA = $(XTESTLIBDIR)/libXtaw.a $(XTESTLIBDIR)/libXtmu.a
XT_ATHENA = $(XTESTBUILD)/src/libXtaw/libXtaw.a \
	$(XTESTBUILD)/src/libXtmu/libXtmu.a

# SYSINC - Any commands that should be given to the C compiler
# to cause include file directories to be searched.  Probably
# needs to include /usr/include/X11.  Note: when the implementation
# provides Athena widgets /usr/include must be included here to ensure
# the implementation's Athena headers are used rather than those
# provided by the test suite.
SYSINC=-I/usr/include -I/usr/include/X11

DEPHEADERS=/usr/include/X11/Xlib.h

################################
##### C compiler Directives Section
################################

# COPTS - Option to C compiler
# SunOS	: COPTS=-O
# ULTRIX: COPTS=-O
# HP-UX	: COPTS=-O -Aa
# DYNIX	: COPTS=-O
# OSF1	: COPTS=-O
# A/UX  : COPTS=-A4 -O
# SVR4	: COPTS=-O -Xc
COPTS=

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

# LINKOBJOPTS - options to give to the LD program to link object
# files together into one object file that can be further linked.
LINKOBJOPTS=-r

# LDFLAGS - Flags for the loader.
# SunOS	: LDFLAGS=
# ULTRIX: LDFLAGS=
# HP-UX	: LDFLAGS=
# DYNIX	: LDFLAGS=
# A/UX 	: LDFLAGS=-ZP
# AIXV3	: LDFLAGS=
# SVR4	: LDFLAGS=-Xc -L/usr/lib/X11
#LDFLAGS=-Xc -L/usr/lib/X11
#LDFLAGS=-L/usr/X11R6/lib

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

# INCLUDES - Options to cause C compiler to search correct directories
# for headers.
#INCLUDES=-I. -I${TETINCDIR} ${SYSINC} -I${XTESTINCDIR}

# CFLAGS - Flags for C compiler
# 
# for generating .dat files
# CFLAGS=-DXT_X_RELEASE=$(XT_X_RELEASE) -DGENERATE_PIXMAPS \
#    $(CFLOCAL) $(COPTS) $(INCLUDES) $(DEFINES)
#
#CFLAGS=-DXT_X_RELEASE=$(XT_X_RELEASE) $(CFLOCAL) $(COPTS) $(INCLUDES) $(DEFINES)

COMMON_CFLAGS = -I$(top_srcdir)/include -I$(TETINCDIR) -I$(XTESTINCDIR) \
	-DXT_X_RELEASE='$(XT_X_RELEASE)' -DTET_LITE
XTS_CFLAGS = $(COMMON_CFLAGS) $(DEFINES)

# XP_CFLAGS - Flags for C compiler specific to the X Protocol tests.
#XP_CFLAGS = -DXT_X_RELEASE=$(XT_X_RELEASE) $(CFLOCAL) $(COPTS) $(INCLUDES) $(XP_DEFINES)
XP_CFLAGS = $(COMMON_CFLAGS) $(XP_DEFINES)

# XT_CFLAGS - Flags for C compiler specific to the Xt Toolkit tests.
#XT_CFLAGS=-DXT_X_RELEASE=$(XT_X_RELEASE) $(CFLOCAL) $(COPTS) $(INCLUDES) $(XT_DEFINES)
XT_CFLAGS = $(COMMON_CFLAGS) $(XT_DEFINES)

# LIBS - List of libraries.
#
# for generating .dat files
# LIBS=${XTESTXIMLIB} ${XTESTLIB} ${XTESTFONTLIB} ${PIXLIB} 
#    {APILIB} ${SYSMATHLIB}
#
DLIBS=${XTESTXIMLIB} ${XTESTLIB} ${XTESTFONTLIB} ${APILIB}

# XP_LIBS - List of libraries specific to the X Protocol tests.
XP_LIBS=${XSTLIB} ${XTESTLIB} ${XTESTFONTLIB} ${APILIB}

# XT_LIBS - List of libraries specific to the Xt Toolkit tests.
XT_LIBS= ${XTESTLIB} ${XTTESTLIB} ${APILIB}

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

LINT=lint
LINTFLAGS=$(INCLUDES) $(DEFINES) -u -n
LINTXTEST=$(XTESTLIBDIR)/llib-lxtest.ln
LINTXST=$(XTESTLIBDIR)/llib-lXst.ln
LINTFONTS=$(XTESTLIBDIR)/llib-lfonts.ln
LINTTCM=$(XTESTLIBDIR)/llib-ltcm.ln
LINTTCMC=$(XTESTLIBDIR)/llib-ltcmc.ln
LINTLIBS=$(LINTXTEST) $(LINTFONTS)

XP_LINTFLAGS=$(INCLUDES) $(XP_DEFINES) -u -n
XP_LINTLIBS=$(LINTXST) $(LINTXTEST) $(LINTFONTS)
