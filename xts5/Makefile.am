include common.mk

SUBDIRS = . src fonts scenarios Xproto Xopen Xlib3 Xlib4 Xlib5 Xlib6 \
	Xlib7 Xlib8 Xlib9 Xlib10 Xlib11 Xlib12 Xlib13 Xlib14 Xlib15 \
	Xlib16 Xlib17 XIproto XI

CLEANFILES = */*/tet_lock
LOGFILES = */*/*.log
DISTCLEANFILES = $(LOGFILES) */*/*.log.tmp

xts5_DATA = tetexec.cfg.in tet_scen
xts5dir = $(datadir)/xts5
check_DATA = tetexec.cfg

# Setup for testing
TCC = $(top_builddir)/src/tet3/tcc/tcc$(EXEEXT)
run_tcc = TET_ROOT='$(TET_ROOT)' $(TCC) -e -a $(abs_builddir) \
	-x tetexec.cfg xts5
scenario =
XTS_CONFIG = TET_ROOT='$(TET_ROOT)' XSET='$(XSET)' XDPYINFO='$(XDPYINFO)' \
	$(PERL) -p $(srcdir)/bin/xts-config

tetexec.cfg: tetexec.cfg.in $(srcdir)/bin/xts-config
	$(AM_V_GEN)$(XTS_CONFIG) < $< > $@ || rm -f $@
check-local: tetexec.cfg
	$(run_tcc) $(scenario)

# Helpful pattern target for testing subsets (test-Xopen, etc.)
test-%:
	@$(MAKE) $(AM_MAKEFLAGS) check scenario='$*'

# Store results in xts5/results/YYYY-mm-dd-HH:mm.xzy
logfile:
	date=`date +%F-%R`.XXXXX && \
	XTS_RESULTS_DIR=`mktemp -d --tmpdir=$(top_srcdir)/xts5/results $$date` && \
	cat $(LOGFILES) > $$XTS_RESULTS_DIR/xts.log
