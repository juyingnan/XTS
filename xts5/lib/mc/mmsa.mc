#
# Build a standalone version of the test case.
#
Test: $(OFILES) $(LIBS) $(top_builddir)/src/tet3/tcm/libtcmmain.la $(AUXFILES)
	$(CC) $(LDFLAGS) -o $@ $(OFILES) $(top_builddir)/src/tet3/tcm/libtcmmain.la $(LIBLOCAL) $(LIBS) $(SYSLIBS)

Test.c: $(SOURCES)
	$(CODEMAKER) -o Test.c $(SOURCES)

