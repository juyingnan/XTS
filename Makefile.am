SUBDIRS = src xts5

# Helper target to force generation of tetexec.cfg
.PHONY: tetexec.cfg
tetexec.cfg:
	@rm -f xts5/$@
	@cd xts5 && $(MAKE) $(AM_MAKEFLAGS) $@

# "make check" testing. Override the test set with scenario.
scenario =
check-local: check.sh
	@if test -z "$$DISPLAY"; then \
		echo "DISPLAY not set"; \
		exit 1; \
	fi
	$(SHELL) $(builddir)/check.sh $(scenario)

# Helper target for testing subsets (test-Xopen, etc.)
test-%:
	@$(MAKE) $(AM_MAKEFLAGS) check scenario='$*'
