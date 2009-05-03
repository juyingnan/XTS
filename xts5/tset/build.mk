MC = $(top_builddir)/xts5/src/bin/mc/mc

.m.c:
	$(MC) -o $@ $<
