MC = $(top_builddir)/xts5/src/bin/mc/mc

.m.c:
	TET_ROOT='$(TET_ROOT)' $(MC) -o $@ $<
