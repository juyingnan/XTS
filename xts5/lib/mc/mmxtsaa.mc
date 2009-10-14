#
# Build a standalone version of the test case.
#
Test: $(OFILES) $(XT_LIBS) $(top_builddir)/src/tet3/tcm/libtcmmain.la $(AUXFILES)
	$(CC) $(LDFLAGS) -o $@ $(OFILES) $(top_builddir)/src/tet3/tcm/libtcmmain.la $(LIBLOCAL) $(XT_LIBS) $(XT_ATHENA) $(XT_SYSLIBS)

Test.c: $(SOURCES)
	$(CODEMAKER) -o Test.c $(SOURCES)

