SUBDIRS = src xts5

# Helper target to force generation of tetexec.cfg
.PHONY: tetexec.cfg
tetexec.cfg:
	@rm -f xts5/$@
	@cd xts5 && $(MAKE) $(AM_MAKEFLAGS) $@

# Helper target for testing subsets
test-%:
	@cd xts5/tset && $(MAKE) $(AM_MAKEFLAGS) $@

logfile:
	cd xts5 && $(MAKE) logfile
