# Common variables and rules for building xts

##########################
# Commands
##########################

# The code generator for turning .m files to .c files.
SUFFIXES = .m _m.c .c
MC = $(top_builddir)/xts5/src/bin/mc/mc
AM_V_MC = $(am__v_MC_$(V))
am__v_MC_ = $(am__v_MC_$(AM_DEFAULT_VERBOSITY))
am__v_MC_0 = @echo "  MC    " $@;

# empty rules to turn off objc magic.  grr.
%.o : %.m

.m.c:
	$(AM_V_MC)TET_ROOT='$(abs_top_srcdir)' $(MC) -o $@ $<
.m_m.c:
	$(AM_V_MC)TET_ROOT='$(abs_top_srcdir)' $(MC) -m -o $@ $<

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

################################
##### Pixel Validation Section.
################################

PVXTESTLIB = ${XTESTLIBDIR}/libxtstpv.a
PIXLIB = ${XTESTLIBDIR}/libpvt.a
PVLIBS = ${PVXTESTLIB} $(top_builddir)/xts/fonts/libfont.la ${PIXLIB} \
	$(top_builddir)/src/tet3/apilib/libapi.la \
	$(top_builddir)/src/tet3/apilib/libapi_s.la

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
