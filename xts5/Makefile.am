include common.mk

SUBDIRS = . fonts src scenarios Xproto Xopen Xlib3 Xlib4 Xlib5 Xlib6 \
	Xlib7 Xlib8 Xlib9 Xlib10 Xlib11 Xlib12 Xlib13 Xlib14 Xlib15 \
	Xlib16 Xlib17 XIproto XI

CLEANFILES = */*/tet_lock
LOGFILES = */*/*.log
DISTCLEANFILES = $(LOGFILES) */*/*.log.tmp

bin_SCRIPTS = bin/xts-config bin/xts-run
xts5_DATA = tetexec.cfg.in tet_scen tet_code
xts5dir = $(datadir)/xts5
check_DATA = tetexec.cfg

xts5docdir = $(xts5dir)/doc
dist_xts5doc_DATA = doc/release_notes doc/VSW_RELEASE doc/VSW_SPEC

# Script substitutions
EDIT = $(SED) -e 's,%bindir%,$(bindir),g' \
	-e 's,%libexecdir%,$(libexecdir),g' \
	-e 's,%DEFAULT_TET_ROOT%,$(DEFAULT_TET_ROOT),g' \
	-e 's,%PACKAGE_VERSION%,$(PACKAGE_VERSION),g'
bin/xts-config: bin/xts-config.in
	$(AM_V_GEN)$(EDIT) < $< > $@
bin/xts-run: bin/xts-run.in
	$(AM_V_GEN)$(EDIT) < $< > $@

# Config file generation for in-tree testing
XTS_CONFIG = TET_ROOT='$(top_srcdir)' XSET='$(XSET)' XDPYINFO='$(XDPYINFO)' \
	$(PERL) -p $(srcdir)/bin/xts-config
tetexec.cfg: tetexec.cfg.in $(srcdir)/bin/xts-config
	$(AM_V_GEN)$(XTS_CONFIG) < $< > $@.tmp && mv -f $@.tmp $@ || rm -f $@.tmp

# Store results in xts5/results/YYYY-mm-dd-HH:mm.xzy
logfile:
	date=`date +%F-%R`.XXXXX && \
	XTS_RESULTS_DIR=`mktemp -d --tmpdir=$(top_srcdir)/xts5/results $$date` && \
	cat $(LOGFILES) > $$XTS_RESULTS_DIR/xts.log
