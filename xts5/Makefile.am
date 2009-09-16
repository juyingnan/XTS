include common.mk

SUBDIRS = . src fonts tset scenarios

xts5_DATA = tetexec.cfg tet_scen
xts5dir = $(datadir)/xts5

XTS_CONFIG = TET_ROOT='$(TET_ROOT)' DISPLAY='$(XT_DISPLAY)' \
	XSET='$(XSET)' XDPYINFO='$(XDPYINFO)' \
	$(PERL) -p $(srcdir)/bin/xts-config
# We make this depend on Makefile so that it's regenerated after the
# Makefile is created or updated by config.status
tetexec.cfg: tetexec.cfg.in $(srcdir)/bin/xts-config Makefile
	$(XTS_CONFIG) < $< > $@ || rm -f $@

logfile:
	cd tset && $(MAKE) logfile

